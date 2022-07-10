module Local.Themes.Theme where

import XMonad
import XMonad.Layout.Tabbed

import XMonad.Hooks.DynamicLog (xmobarColor)

data MyTheme =
  MyTheme
    { colorCurrent :: String -> String
    , colorHiddenNoWindows :: String -> String
    , colorHidden :: String -> String
    , colorTitle :: String -> String
    , colorVisible :: String -> String
    , xmobarConf :: String
    , colorSep :: String
    , promptFG :: String
    , promptBG :: String
    , promptSelection :: String
    , promptBorder :: String
    , mainBorderColor :: String
    , fBorderColor :: String
    , tabForeground :: String
    , tabBackGround :: String
    }

oneTheme :: MyTheme
oneTheme =
  MyTheme
    { colorCurrent = xmobarColor "#61AFEF,#393d45" ""
    , colorHiddenNoWindows = xmobarColor "#c678dd" ""
    , colorHidden = xmobarColor "#c678dd" ""
    , colorTitle = xmobarColor "#a9a1e1" ""
    , colorVisible = xmobarColor "#61AFEF" ""
    , xmobarConf = "xmobarrc"
    , colorSep = "  " -- "<fc=#666666> \xe0b1 </fc>"
    , promptFG = "#ABB2BF"
    , promptBG = "#1e2127"
    , promptSelection = "#C678DD"
    , promptBorder = "#000000"
    , mainBorderColor = "#1e2127"
    , fBorderColor = "#61AFEF"
    , tabForeground = "#61AFEF"
    , tabBackGround = "#282c34"
    }

gruvboxTheme :: MyTheme
gruvboxTheme =
  MyTheme
    { colorCurrent = xmobarColor "#282828,#458588:0" ""
    , colorHiddenNoWindows = xmobarColor "#d3869b" ""
    , colorHidden = xmobarColor "#fabd2f" ""
    , colorTitle = xmobarColor "#689d6a" ""
               -- , colorVisible         = xmobarColor "#928374" ""
    , colorVisible = xmobarColor "#458588" ""
    , xmobarConf = "xmobargruvbox"
    , colorSep = "  "
    , promptFG = "#bfbaba"
    , promptBG = "#1d2021"
    , promptSelection = "#d65d0e"
     -- , promptBorder = "#928374"
    , promptBorder = "#282828"
    , mainBorderColor = "#282828"
    , fBorderColor = "#458588"
     -- , fBorderColor = "#928374"
    , tabForeground = "#458588"
    , tabBackGround = "#1d2021"
    }

--------------------------------------------------------------------------------
-- BORDER SETTINGS:
--------------------------------------------------------------------------------
myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = mainBorderColor currentTheme

-- myNormalBorderColor  = "#000000"
myFocusedBorderColor :: String
myFocusedBorderColor = fBorderColor currentTheme

-- myFocusedBorderColor = "#5f87af"
--------------------------------------------------------------------------------
-- CURRENT THEME:
--------------------------------------------------------------------------------
currentTheme :: MyTheme
currentTheme = oneTheme

--------------------------------------------------------------------------------
-- TABS THEME:
--------------------------------------------------------------------------------
myTabTheme :: Theme
myTabTheme =
  def
    { fontName = "xft:xos4 Terminus:size=9"
    , activeColor = tabForeground currentTheme
    , inactiveColor = tabBackGround currentTheme
    , urgentColor = tabBackGround currentTheme
    , activeBorderColor = tabForeground currentTheme
    , inactiveBorderColor = "#282828" -- TODO
    , urgentBorderColor = tabBackGround currentTheme
    , activeTextColor = tabBackGround currentTheme
    , inactiveTextColor = "#bfbaba" -- TODO
    }
