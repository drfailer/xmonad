module Local.Prompt.CalcLib.ParserExpr where

import Local.Prompt.CalcLib.Expr
import Control.Applicative
import Data.Char

newtype Parser a =
  Parser
    { runParser :: String -> Maybe (a, String)
    }

-------------------------------------------------------------------------------
-- Class instancies:
-------------------------------------------------------------------------------
instance Functor Parser where
  fmap f (Parser p) =
    Parser $ \input -> do
      (x, r) <- p input
      Just (f x, r)

-- (<*>) :: f (a -> b) -> f a -> f b
-- NOTE: we can use the `do` because of the Maybe monad, so we can hide the
-- error handeling
instance Applicative Parser where
  pure x = Parser $ \input -> Just (x, input)
  (Parser p1) <*> (Parser p2) =
    Parser $ \input -> do
      (f, r) <- p1 input
      (x, r') <- p2 r
      Just (f x, r')

instance Alternative Parser where
  empty = Parser $ const Nothing
  (Parser p1) <|> (Parser p2) = Parser $ \input -> (p1 input) <|> (p2 input)

-------------------------------------------------------------------------------
-- Parsing functions:
-------------------------------------------------------------------------------
-- Helper function to convert strings to doubles
toDouble :: String -> Double
toDouble s = read s :: Double

charP :: Char -> Parser Char
charP c = Parser f
  where
    f [] = Nothing
    f (x:xs)
      | x == c = Just (x, xs)
      | otherwise = Nothing

-- sequenceA :: (Traversable t, Applicative f) => t (f a) -> f (t a)
stringP :: String -> Parser String
stringP = sequenceA . map charP

-- Parse a suit of digits
digitP :: Parser String
digitP = Parser f
  where
    f s =
      let (d, r) = span (isDigit) s
       in if d == ""
            then Nothing
            else Just (d, r)

-- inP parse an integer but return a Parser Double as we want to have the same
-- type everywhere for the evaluation
intP :: Parser Double
intP = toDouble <$> digitP

floatP :: Parser Double
floatP = toDouble <$> Parser f
  where
    f s = do
      (i, r) <- runParser (digitP) s
      (_, r') <- runParser (charP '.') r
      (f, r'') <- runParser (digitP) r'
      Just (i ++ "." ++ f, r'')

-- Parse an expression containing a binary operator
-- the expression constructor and the operator symbol are given in parameters
-- as well as the parsers for the left and right part of the expression
binOpP :: (l -> r -> b) -> Parser l -> Char -> Parser r -> Parser b
binOpP c pl o pr = c <$> pl <*> (charP o *> pr)

powP :: Parser Expr
powP = binOpP Pow facP '^' facP

-- Parse a function such as `cos(0.2)` using the parameter name
-- it construct the expression using the constructor c
funcP :: (Expr -> Function) -> String -> Parser Expr
funcP c name = (\n -> Fun n) <$> fp
  where
    fp = c <$> (stringP name *> charP '(' *> exprP <* charP ')')

-- Parser for all the functions
functionsP :: Parser Expr
functionsP =
  sqrtP <|> cosP <|> sinP <|> tanP <|> acosP <|> asinP <|> atanP <|> logP <|>
  expP
  where
    sqrtP = funcP Sqrt "sqrt"
    cosP = funcP Cos "cos"
    sinP = funcP Sin "sin"
    tanP = funcP Tan "tan"
    acosP = funcP ACos "acos"
    asinP = funcP ASin "asin"
    atanP = funcP ATan "atan"
    logP = funcP Log "log"
    expP = funcP Exp "exp"

-- Parse a constant using the constructor and the constant name
cstP :: Constant -> String -> Parser Expr
cstP c name = (\n -> Cst n) <$> cp
  where
    cp = (\_ -> c) <$> stringP name

-- Constant parser
constP :: Parser Expr
constP = piP
  where
    piP = cstP Pi "pi"

-- Parse a factor which can be an expression between parents, a literal, a
-- negative number or a function
-- a factor correspond to the leaf of the expression tree, they need to be
-- evaluate first (so we are parsing them last)
facP :: Parser Expr
facP = parentP <|> litP <|> negateP <|> functionsP <|> constP
  where
    litP = (\n -> Lit n) <$> numberP
    numberP = floatP <|> intP
    parentP = (\n -> Par n) <$> (charP '(' *> (negateP <|> exprP) <* charP ')')
    negateP = (\n -> Lit (-n)) <$> (charP '-' *> numberP)

-- Hight priority expression are multiplications, divisions, ... they need to
-- be evaluate be evaluated before the additions and subtractions
termoP :: Parser Expr
termoP = mulP <|> divP <|> powP <|> facP
  where
    mulP = binOpP Mul (divP <|> facP) '*' termoP
    divP = binOpP Div facP '/' facP

-- Low priority expressions are the last ones to be evaluated so we parse them
-- first
addoP :: Parser Expr
addoP = addP <|> subP
  where
    addP = binOpP Add (subP <|> termoP) '+' exprP
    subP = binOpP Sub termoP '-' (subP <|> termoP)

-- Main expression parser
exprP :: Parser Expr
exprP = addoP <|> termoP

-- Parser a string to withdraw the expression
parse :: String -> Maybe Expr
parse = f . runParser (exprP)
  where
    f (Just (e, "")) = Just e
    f _ = Nothing
