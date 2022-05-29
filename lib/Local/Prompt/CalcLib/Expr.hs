module Local.Prompt.CalcLib.Expr where

-------------------------------------------------------------------------------
-- Expressions:
-------------------------------------------------------------------------------
data Expr
  = Add Expr Expr
  | Sub Expr Expr
  | Mul Expr Expr
  | Div Expr Expr
  | Pow Expr Expr
  | Par Expr
  | Lit Double
  | Fun Function
  | Cst Constant

instance Show Expr where
  show (Add el er) = (show el) ++ " + " ++ (show er)
  show (Sub el er) = (show el) ++ " - " ++ (show er)
  show (Mul el er) = (show el) ++ " x " ++ (show er)
  show (Div el er) = (show el) ++ " / " ++ (show er)
  show (Pow e p) = (show e) ++ "^(" ++ (show p) ++ ")"
  show (Par e) = "(" ++ show e ++ ")"
  show (Lit a) = show a
  show (Fun f) = show f
  show (Cst c) = show c

evalExpr :: Expr -> Double
evalExpr (Add el er) = (evalExpr el) + (evalExpr er)
evalExpr (Sub el er) = (evalExpr el) - (evalExpr' er)
evalExpr (Mul el er) = (evalExpr el) * (evalExpr er)
evalExpr (Div el er) = (evalExpr el) / (evalExpr er)
evalExpr (Pow e p) = (evalExpr e) ** (evalExpr p)
evalExpr (Par e) = evalExpr e
evalExpr (Lit l) = l
evalExpr (Fun f) = evalFun f
evalExpr (Cst c) = evalConstant c

evalExpr' :: Expr -> Double
evalExpr' (Sub el er) = (evalExpr el) + (evalExpr' er)
evalExpr' expr = evalExpr expr

-------------------------------------------------------------------------------
-- Functions:
-------------------------------------------------------------------------------
data Function
  = Sqrt Expr
  | Cos Expr
  | Sin Expr
  | Tan Expr
  | ACos Expr
  | ASin Expr
  | ATan Expr
  | Log Expr
  | Exp Expr

instance Show Function where
  show (Sqrt e) = "sqrt(" ++ (show e) ++ ")"
  show (Cos e)  = "cos(" ++ (show e) ++ ")"
  show (Sin e)  = "sin(" ++ (show e) ++ ")"
  show (Tan e)  = "tan(" ++ (show e) ++ ")"
  show (ACos e) = "acos(" ++ (show e) ++ ")"
  show (ASin e) = "asin(" ++ (show e) ++ ")"
  show (ATan e) = "atan(" ++ (show e) ++ ")"
  show (Log e)  = "log(" ++ (show e) ++ ")"
  show (Exp e)  = "exp(" ++ (show e) ++ ")"


evalFun :: Function -> Double
evalFun (Sqrt e) = sqrt (evalExpr e)
evalFun (Cos e)  = cos (evalExpr e)
evalFun (Sin e)  = sin (evalExpr e)
evalFun (Tan e)  = tan (evalExpr e)
evalFun (ACos e) = acos (evalExpr e)
evalFun (ASin e) = asin (evalExpr e)
evalFun (ATan e) = atan (evalExpr e)
evalFun (Log e)  = log (evalExpr e)
evalFun (Exp e)  = exp (evalExpr e)

-------------------------------------------------------------------------------
-- Constantant:
-------------------------------------------------------------------------------
data Constant
  = Pi

instance Show Constant where
  show Pi = "pi"

evalConstant :: Constant -> Double
evalConstant Pi = pi
