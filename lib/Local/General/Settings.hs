module Local.General.Settings where

import XMonad

import XMonad.Config.Desktop

myTerminal = "st"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
myClickJustFocuses :: Bool
myClickJustFocuses = False
myModMask     = mod4Mask

_JAVA_AWT_WM_NONREPARENTING=1
--AWT_TOOLKIT=MToolkit


termLaunch :: String
termLaunch = myTerminal ++ " -e "

coursesPath :: String
coursesPath = " ~/Desktop/cours/cours_s4/"
