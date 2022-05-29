module Local.General.Utils where

import qualified Data.Map as M
import XMonad
import XMonad.Operations
import qualified XMonad.StackSet as W

--------------------------------------------------------------------------------
-- WINDOWS COUNT FUNCTION:
--------------------------------------------------------------------------------
windowCount :: X (Maybe String)
windowCount =
  gets $
  Just .
  show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

--------------------------------------------------------------------------------
-- CENTER FLOAT FUNCTION:
--------------------------------------------------------------------------------
toggleFloat :: Window -> X ()
toggleFloat w =
  windows
    (\s ->
       if M.member w (W.floating s)
         then W.sink w s
         else (W.float w (W.RationalRect 0.20 0.20 0.6 0.6) s))
