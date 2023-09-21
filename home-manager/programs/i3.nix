{ pkgs, lib, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [ ];

      window.border = 0;

      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+w" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+w" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+Shift+c" = "exec ${pkgs.rofi}/bin/rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'";
        "${modifier}+f" = "fullscreen toggle";
        
        # MODES
        "${modifier}+Shift+s" = "mode power"; 
      };


      modes.power = {
        "s" = "exec systemctl suspend, mode default";      


        "Escape" = "mode default";
      };

      startup = [
        {
            command = "${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1-1 --left-of HDMI-0";
            always = true;
            notification = false;
        }
        {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
        }
        {
           command = "${pkgs.feh}/bin/feh --bg-scale --zoom fill /etc/nixos/home-manager/programs/wallpapers/lain_asm.png";
           always = true;
           notification = false;     
        }
      ];
    };
  };
}
