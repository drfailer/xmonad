module Local.Hooks.LogHooks where


import XMonad

import XMonad.Hooks.FadeInactive
import XMonad.Hooks.DynamicLog


--------------------------------------------------------------------------------
-- LOG:
--------------------------------------------------------------------------------
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0
