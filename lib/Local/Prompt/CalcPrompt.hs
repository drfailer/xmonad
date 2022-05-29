module Local.Prompt.CalcPrompt where

import Local.Prompt.CalcLib.Calc
import XMonad
import XMonad.Prompt
import XMonad.Prompt.Input


calcPrompt :: XPConfig -> X ()
calcPrompt =
  makeCalcPrompt "Calc"

makeCalcPrompt :: String -> XPConfig -> X ()
makeCalcPrompt s c =
  inputPrompt c s ?+ (\x -> makeCalcPrompt (prettyEval x) c)
