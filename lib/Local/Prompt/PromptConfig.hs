module Local.Prompt.PromptConfig where

import XMonad

import XMonad.Prompt
import XMonad.Prompt.FuzzyMatch

import Local.Themes.Theme


--------------------------------------------------------------------------------
-- XMONAD PROMPT:
--------------------------------------------------------------------------------
myXPConfig :: XPConfig
myXPConfig = def
    {font                 = "xft:Pro Font For Powerline:size10"
    , bgColor             = promptBG currentTheme
    , fgColor             = promptFG currentTheme
    , bgHLight            = promptBG currentTheme
    , fgHLight            = promptSelection currentTheme
    , borderColor         = promptBorder currentTheme
    , promptBorderWidth   = 1
    , promptKeymap        = emacsLikeXPKeymap
    , position            = Top
    , alwaysHighlight     = True
    , height              = 21
    , historySize         = 256
    , historyFilter       = id
    , defaultText         = []
    , autoComplete        = Nothing -- Just 100000
    , showCompletionOnTab = False
    , maxComplRows        = Just 3
    , searchPredicate     = fuzzyMatch
    }
