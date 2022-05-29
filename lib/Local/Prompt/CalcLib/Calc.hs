module Local.Prompt.CalcLib.Calc where

import Local.Prompt.CalcLib.Expr
import Local.Prompt.CalcLib.ParserExpr
import Data.Maybe

-- pretty show the result like `2.0 + 2.0 = 4.0`
prettyEval :: String -> String
prettyEval s =
  let e = (parse . filter (\x -> x /= ' ')) s
   in case parse s of
        Nothing -> "Invalide input"
        Just a -> (show a) ++ " = " ++ (show $ evalExpr a)

-- return the value of the result
eval :: String -> Maybe Double
eval = fmap evalExpr . parse . filter (\x -> x /= ' ')

result :: String -> String
result s =
  let e = (parse . filter (\x -> x /= ' ')) s
   in case parse s of
        Nothing -> "Invalide input"
        Just a -> (show $ evalExpr a)
