module Local.Hooks.StartupHooks where


import XMonad

import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.SpawnOnce


--------------------------------------------------------------------------------
-- STARTUP:
--------------------------------------------------------------------------------
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  setWMName "LG3D"
  -- spawnOnce "conky"
  -- spawnOnce "compton --config ~/.config/compton.conf"
  -- spawnOnce "xrandr --output HDMI-0 --primary --left-of DVI-D-0 --output DVI-D-0 --auto"
  -- spawnOnce "setxkbmap -layout fr -option ctrl:nocaps"
  -- spawnOnce "xset r rate 300 50"
