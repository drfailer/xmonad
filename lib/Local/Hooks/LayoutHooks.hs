module Local.Hooks.LayoutHooks where

import XMonad

import XMonad.Config.Desktop

import XMonad.Layout.Grid
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation

import XMonad.Hooks.ManageDocks

import Data.Ratio

import Local.Themes.Theme


--------------------------------------------------------------------------------
-- LAYOUTS:
--------------------------------------------------------------------------------
mySpacing ::
     Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myLayout =
  avoidStruts
    (tiled ||| Mirror tiled ||| full ||| twoPane ||| treeCols ||| grid)
  where
    -- Put space between windows
    tiled =
      mySpacing 4 $
      addTabs shrinkText myTabTheme $
      configurableNavigation noNavigateBorders $
      subLayout [] (Simplest) $
      ResizableTall nmaster delta ratio []
    treeCols =
      mySpacing 4 $
      addTabs shrinkText myTabTheme $
      configurableNavigation noNavigateBorders $
      subLayout [] (Simplest) $
       ThreeColMid nmaster delta ratio
    grid = mySpacing 4 $ windowNavigation $ Grid
    twoPane = mySpacing 4 $ windowNavigation $ TwoPane delta ratio
    full = noBorders Full
    -- The default number of windows in the master pane
    nmaster = 1
    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100
