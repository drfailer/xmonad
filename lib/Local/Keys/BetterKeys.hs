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
    , ("M-S-p b", brightnessPrompt myXPConfig) -- (laptop config)

    , ("M-S-q", io (exitWith ExitSuccess))
    , ("M-q", spawn "xmonad --recompile; xmonad --restart")
    , ("M-s", refresh)
    , ("M-S-c", kill)
    , ("M-b", sendMessage ToggleStruts)
    , ("M-C-<Return>", spawn "st -t FloatTerm")

    -- Window navigation
    , ("M-n", windows W.focusDown)
    , ("M-S-n", windows W.focusUp)
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
    , ("M-w h", sendMessage $ Swap L)
    , ("M-w j", sendMessage $ Swap D)
    , ("M-w k", sendMessage $ Swap U)
    , ("M-w l", sendMessage $ Swap R)

    -- resizing
    , ("M-M1-S-h", sendMessage Shrink)
    , ("M-M1-S-l", sendMessage Expand)
    , ("M-M1-S-j", sendMessage MirrorShrink)
    , ("M-M1-S-k", sendMessage MirrorExpand)

    -- tabs manipulation
    , ("M-<Tab> h", sendMessage $ pullGroup L)
    , ("M-<Tab> l", sendMessage $ pullGroup R)
    , ("M-<Tab> k", sendMessage $ pullGroup U)
    , ("M-<Tab> j", sendMessage $ pullGroup D)
    , ("M-<Tab> m", withFocused (sendMessage . MergeAll))
    , ("M-<Tab> u", withFocused (sendMessage . UnMergeAll))
    , ("M-,", onGroup W.focusUp')
    , ("M-;", onGroup W.focusDown')

    -- Resize floating windows
    , ("M-S-<F1>", withFocused (keysResizeWindow (50, 0) (0, 1)))
    , ("M-S-<F2>", withFocused (keysResizeWindow (0, 50) (0, 0)))
    , ("M-S-<F3>", withFocused (keysResizeWindow (-50, -0) (0, 1)))
    , ("M-S-<F4>", withFocused (keysResizeWindow (0, -50) (0, 0)))

      -- Move floating windows:
    , ("M-C-S-h", withFocused (keysMoveWindow (-50, 0)))
    , ("M-C-S-j", withFocused (keysMoveWindow (0, 50)))
    , ("M-C-S-k", withFocused (keysMoveWindow (0, -50)))
    , ("M-C-S-l", withFocused (keysMoveWindow (50, 0)))

    -- app launch
    , ("M-S-a m", spawn $ termLaunch ++ "neomutt")
    , ("M-S-a f", spawn "brave")
    , ("M-S-a e", spawn "emacs")
    , ("M-S-a o", spawn "emacsclient -c")

    -- dmenu scripts
    -- , ("M-p", spawn "dmenu_run -p 'Run:'")
    -- , ("M-f", spawn "exec ~/.scripts/dmenu/search/search")
    -- , ("M-S-p s", spawn "exec ~/.scripts/dmenu/sound/sound")
    -- , ("M-S-p c", spawn "exec ~/.scripts/dmenu/editconf/editconf")
    -- , ("M-n r", spawn "exec ~/.scripts/dmenu/notes/read-note")
    -- , ("M-n e", spawn "exec ~/.scripts/dmenu/notes/edit-notes")

    -- Spacing: windows and borders
    , ("M-<F11>", (incWindowSpacing 10))
    , ("M-S-<F11>", (decWindowSpacing 10))
    , ("M-<F12>", (incScreenSpacing 10))
    , ("M-S-<F12>", (decScreenSpacing 10))
    , ("M-S-b", (toggleScreenSpacingEnabled >> toggleWindowSpacingEnabled))

    -- Remap keys
    , ("M-S-h", spawn "sleep 0.1 && xdotool key --clearmodifiers Left")
    , ("M-S-j", spawn "sleep 0.1 && xdotool key --clearmodifiers Down")
    , ("M-S-k", spawn "sleep 0.1 && xdotool key --clearmodifiers Up")
    , ("M-S-l", spawn "sleep 0.1 && xdotool key --clearmodifiers Right")
    , ("M-C-h", spawn "xdotool mousemove_relative -- -100 0")
    , ("M-C-j", spawn "xdotool mousemove_relative 0 100")
    , ("M-C-k", spawn "xdotool mousemove_relative 0 -100")
    , ("M-C-l", spawn "xdotool mousemove_relative 100 0")
    , ("M-C-M1-h", spawn "xdotool mousemove_relative -- -10 0")
    , ("M-C-M1-j", spawn "xdotool mousemove_relative 0 10")
    , ("M-C-M1-k", spawn "xdotool mousemove_relative 0 -10")
    , ("M-C-M1-l", spawn "xdotool mousemove_relative 10 0")
    , ("M-C-u", spawn "xdotool click --clearmodifiers 1")
    , ("M-C-i", spawn "xdotool click --clearmodifiers 2")
    , ("M-C-o", spawn "xdotool click --clearmodifiers 3")

    -- Multimedia keys
    , ("<XF86MonBrightnessDown>", spawn "exec xbacklight -dec 2")
    , ("<XF86MonBrightnessUp>", spawn "exec xbacklight -inc 2")
    , ("<XF86AudioMute>", spawn "exec pamixer -t")
    , ("<XF86AudioLowerVolume>", spawn "exec pamixer -d 2")
    , ("<XF86AudioRaiseVolume>", spawn "exec pamixer -i 2")
    , ("<XF86Search>", searchPrompt myXPConfig)
    , ("<Print>", spawn "gnome-screenshot -a")
    ]
