module Local.Keys.BetterKeys where

import XMonad
import System.Exit

import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad
import XMonad.Util.EZConfig (additionalKeysP, removeKeysP)
import qualified XMonad.StackSet as W

import XMonad.Layout.Spacing
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation

import XMonad.Actions.FloatKeys

import XMonad.Hooks.ManageDocks

import Local.Prompt.PromptConfig
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.XMonad
import XMonad.Prompt.Shell
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass

import Local.General.Settings
import Local.General.Utils
import Local.Prompt.PromptConfig
import Local.Prompt.CustomPrompts
import Local.Prompt.CalcPrompt


--------------------------------------------------------------------------------
-- BETTER KEYBINDINGS:
--------------------------------------------------------------------------------
myAdditionalKeys :: [(String, X ())]
myAdditionalKeys =
    [ ("M-p", shellPrompt myXPConfig) -- run prompt

    -- Custom prompts
    , ("M-S-p x", xmonadPrompt myXPConfig)
    , ("M-S-p m", manPrompt myXPConfig)
    , ("M-S-p p", passPrompt myXPConfig)
    , ("M-f", searchPrompt myXPConfig)
    , ("M-S-p s", soundPrompt myXPConfig)
    , ("M-S-p f", configPrompt myXPConfig)
    , ("M-S-p c", calcPrompt myXPConfig)
    -- , ("M-S-p b", brightnessPrompt myXPConfig) -- (laptop config)

    , ("M-S-q", io (exitWith ExitSuccess))
    , ("M-q", spawn "xmonad --recompile; xmonad --restart")
    , ("M-s", refresh)
    , ("M-S-c", kill)
    , ("M-b", sendMessage ToggleStruts)
    , ("M-C-<Return>", spawn "st -t FloatTerm")

    -- Window navigation
    , ("M-<Tab>", windows W.focusDown)
    , ("M-h", sendMessage $ Go L)
    , ("M-j", sendMessage $ Go D)
    , ("M-k", sendMessage $ Go U)
    , ("M-l", sendMessage $ Go R)
    , ("M-m", windows W.focusMaster)
    , ("M-<Return>", windows W.swapMaster)
    , ("M-t", withFocused toggleFloat)

    -- Moving windows
    , ("M-S-w h", sendMessage (IncMasterN 1))
    , ("M-S-w l", sendMessage (IncMasterN (-1)))
    , ("M-S-h", sendMessage $ Swap L)
    , ("M-S-j", sendMessage $ Swap D)
    , ("M-S-k", sendMessage $ Swap U)
    , ("M-S-l", sendMessage $ Swap R)

    -- resizing
    , ("M-M1-h", sendMessage Shrink)
    , ("M-M1-l", sendMessage Expand)
    , ("M-M1-j", sendMessage MirrorShrink)
    , ("M-M1-k", sendMessage MirrorExpand)

    -- tabs manipulation
    , ("M-S-o h", sendMessage $ pullGroup L)
    , ("M-S-o l", sendMessage $ pullGroup R)
    , ("M-S-o k", sendMessage $ pullGroup U)
    , ("M-S-o j", sendMessage $ pullGroup D)
    , ("M-S-o m", withFocused (sendMessage . MergeAll))
    , ("M-S-o u", withFocused (sendMessage . UnMergeAll))
    , ("M-M1-;", onGroup W.focusUp')
    , ("M-M1-,", onGroup W.focusDown')

    -- Resize floating windows
    , ("M-S-C-l", withFocused (keysResizeWindow (50, 0) (0, 1)))
    , ("M-S-C-h", withFocused (keysResizeWindow (-50, -0) (0, 1)))
    , ("M-S-C-k", withFocused (keysResizeWindow (0, -50) (0, 0)))
    , ("M-S-C-j", withFocused (keysResizeWindow (0, 50) (0, 0)))

      -- Move floating windows:
    , ("M-C-h", withFocused (keysMoveWindow (-50, 0)))
    , ("M-C-j", withFocused (keysMoveWindow (0, 50)))
    , ("M-C-k", withFocused (keysMoveWindow (0, -50)))
    , ("M-C-l", withFocused (keysMoveWindow (50, 0)))

    -- app launch
    , ("M-S-a m", spawn $ termLaunch ++ "neomutt")
    , ("M-S-a f", spawn "brave")

    -- dmenu scripts
    -- , ("M-p", spawn "dmenu_run -p 'Run:'")
    -- , ("M-f", spawn "exec ~/.scripts/dmenu/search/search")
    -- , ("M-S-p s", spawn "exec ~/.scripts/dmenu/sound/sound")
    -- , ("M-S-p c", spawn "exec ~/.scripts/dmenu/editconf/editconf")
    , ("M-n r", spawn "exec ~/.scripts/dmenu/notes/read-note")
    , ("M-n e", spawn "exec ~/.scripts/dmenu/notes/edit-notes")

    -- Spacing: windows and borders
    , ("M-a", (incWindowSpacing 10))
    , ("M-S-a", (decWindowSpacing 10))
    , ("M-z", (incScreenSpacing 10))
    , ("M-S-z", (decScreenSpacing 10))
    , ("M-S-b", (toggleScreenSpacingEnabled >> toggleWindowSpacingEnabled))
    ]
