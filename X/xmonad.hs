import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog  
import XMonad.Hooks.ManageDocks  
import XMonad.Util.Run  
import System.IO 
import XMonad.Hooks.ManageDocks
import XMonad.Util.Paste
import XMonad.Layout.PerWorkspace   
import XMonad.Layout.IM   
import XMonad.Layout.Grid 
import XMonad.Layout.Spacing   
import Data.Ratio ((%))   


myWorkspaces = ["1","2","3","4","5","6","7","8","9","0"]  
myManageHook = composeAll  
      [ className =? "Conkeror" --> doShift "9"  
      ] 

myLayoutHook = avoidStruts $ onWorkspace "7:Pidgin" pidginLayout $ tiled1 ||| Mirror tiled1 ||| Full   
	       where   
	       tiled1 = spacing 5 $ Tall nmaster1 delta ratio   
	       nmaster1 = 1   
	       nmaster2 = 2   
	       ratio = 2/3   
	       delta = 3/100   
	       gridLayout = spacing 8 $ Grid      
	       pidginLayout = withIM (18/100) (Role "buddy_list") gridLayout 


main = do
--       xmproc <- spawnPipe "xmobar"
       xmonad $ defaultConfig { terminal = "gnome-terminal"  
                              , modMask = mod4Mask
                              , workspaces = myWorkspaces  
                              , layoutHook = myLayoutHook 
                              , manageHook = myManageHook <+> manageHook defaultConfig <+> manageDocks
                 --             , logHook = dynamicLogWithPP xmobarPP  
                   --             { ppOutput = hPutStrLn xmproc  
                     --           , ppTitle = xmobarColor "blue" "" . shorten 50   
                       --         , ppLayout = const "" -- to disable the layout info on xmobar  
                          --      }
						  }
                 `additionalKeys`
                 [ --((mod1Mask, xK_m        ), spawn "echo 'Hi, mom!' | dzen2 -p 4")
                   -- xF86XK_AudioRaiseVolume
                 ((0, 0x1008ff11), spawn "amixer -q sset Master 2-")
                   -- XF86AudioMute
                 , ((0, 0x1008ff12), spawn "amixer set Master toggle;amixer set Headphone toggle")
                   -- XF86AudioRaiseVolume
                 , ((0, 0x1008ff13), spawn "amixer -q sset Master 2+")
                   -- XF86TouchpadToggle
                 , ((0, 0x1008ffa9), spawn "/etc/acpi/asus-touchpad.sh")
                   -- CPU control
                 , ((0, 0x1008ff46), spawn "sudo /etc/acpi/eeepc/eeepc-cpu-control.sh")

		 --- from here for mcabook air
                 , ((0, 0x1008ff02), spawn "xbacklight -inc 10 ")
                 , ((0, 0x1008ff03), spawn "xbacklight -dec 10 ")
                 , ((0, 0x1008ff05), spawn "mba_kbbacklight up ")
                 , ((0, 0x1008ff06), spawn "mba_kbbacklight down ")
                 , ((0, 0x1008ff4a), spawn "logger windown key pressed")
                 , ((0, 0x1008ff4b), spawn "logger app key pressed")
                 --("M-q"     , spawn "killall xmobar ;killall dzen2;killall trayer ;xmonad --recompile; xmonad --restart")
		 ,((mod3Mask .|. shiftMask, xK_l), spawn "gnome-screensaver-command -l")
                 ] 

-- old stuffs
{- main = xmonad defaultConfig
         { modMask = mod4Mask
         , terminal = "urxvt"
         }-}

