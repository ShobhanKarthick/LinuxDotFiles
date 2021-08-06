import XMonad
import Data.Monoid
import System.IO 
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import XMonad.Layout.ThreeColumns
import XMonad.Layout.LayoutModifier
import XMonad.Layout.WindowNavigation
import XMonad.Layout.SimplestFloat
import XMonad.Layout.ResizableTile

import XMonad.Layout.Renamed
import XMonad.Layout.SubLayouts
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.LimitWindows 
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))

import XMonad.Actions.DwmPromote
import XMonad.Actions.RotSlaves
import XMonad.Actions.WithAll (sinkAll, killAll)
import XMonad.Actions.Promote

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Dmenu

import XMonad.Hooks.DynamicLog

myMod = mod4Mask                         -- Super key is the defaut mod key

myTerminal = "alacritty"                 -- Sets Alacritty as the default terminal emulator
myEditor = "vim"                         -- Sets VIM as the default editor
myBrowser = "firefox-developer-edition"  -- Sets Firfox Dev as default browser

myBorderWidth = 2
myNormColor   = "#dddddd"   -- Border color of normal windows
myFocusColor  = "#ff0000"   -- Border color of focused windows 

myFocusFollowsMouse = True
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border 12 i i i) True (Border 12 i i i) True

main :: IO ()
main = do
  xmproc <- spawnPipe "xmobar -x 0 /home/lsw/.xmobarrc"
  xmonad $ ewmh  $ docks def
    {
      manageHook = myManageHook <+> manageDocks
    , handleEventHook = docksEventHook

    , modMask = myMod
    , terminal = myTerminal
    , borderWidth = myBorderWidth
    , focusFollowsMouse = myFocusFollowsMouse

    , workspaces = myWorkspaces
    , normalBorderColor = myNormColor
    , focusedBorderColor = myFocusColor

    , logHook = dynamicLogWithPP $ xmobarPP
       -- the following variables beginning with 'pp' are settings for xmobar.
       { ppOutput = \x -> hPutStrLn xmproc x                          -- xmobar on monitor 1
       , ppCurrent = xmobarColor "#c792ea" "" . wrap "[" "]"         -- Current workspace
       , ppVisible = xmobarColor "#c792ea" "" 
       , ppHidden = xmobarColor "#82AAFF" "" . wrap "[" "]" 
       , ppHiddenNoWindows = xmobarColor "#82AAFF" ""                  -- Hidden workspaces (no windows)
       , ppTitle = xmobarColor "#b3afc2" "" . shorten 60               -- Title of active window
       , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"                    -- Separator character
       , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"            -- Urgent workspace
       , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
       }

    , layoutHook = gappedLayout
    , startupHook = myStartupHook
    }
    `additionalKeysP` [
    -- Basic Config
      ("M-<Return>", spawn myTerminal)
    , ("M-p", spawn "dmenu_run")
    , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")
    , ("M-q", kill)
    , ("M-C-q", io exitSuccess)

    -- Applications
    , ("M-f"  , spawn "firefox-developer-edition")
    , ("M-S-s", spawn "flameshot gui")

    -- Floating windows
--  , ("M-S-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
--    , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
--   , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile
 
    -- Windows navigation
    , ("M-m", windows W.focusMaster)  -- Move focus to the master window
    , ("M-j", windows W.focusDown)    -- Move focus to the next window
    , ("M-k", windows W.focusUp)      -- Move focus to the prev window
    , ("M-S-h", dwmpromote) -- Swap the focused window and the master window
    , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
    , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
    , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
    , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
    , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    ]

myLayout = avoidStruts(tiled 
         ||| Mirror tiled 
         ||| Full 
         ||| threeCol)
  where
    threeCol = ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

gappedLayout = mySpacing 6 $ myLayout

myStartupHook = do
    spawnOnce "picom &"
    spawnOnce "nm-applet &"
    spawnOnce "volumeicon &"
    spawnOnce "nitrogen --set-zoom-fill --random /mnt/LocalDisk2/Wallpapers &"
    setWMName "LG3D"

myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]


