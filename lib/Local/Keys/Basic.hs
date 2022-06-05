module Local.Keys.Basic where


import XMonad

import Local.Workspaces.WS
import Local.Hooks.LayoutHooks
import Graphics.X11.ExtraTypes.XF86

import qualified Data.Map as M
import qualified XMonad.StackSet as W


--------------------------------------------------------------------------------
-- BASIC KEYBINDINGS:
--------------------------------------------------------------------------------
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm, xK_space ), sendMessage NextLayout)
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [  xK_ampersand
                                                  , xK_eacute
                                                  , xK_quotedbl
                                                  , xK_quoteright
                                                  , xK_parenleft
                                                  , xK_minus
                                                  , xK_egrave
                                                  , xK_underscore
                                                  , xK_ccedilla
                                                 ]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_i, xK_u, xK_o] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_i, xK_u, xK_o] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
