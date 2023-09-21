{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = ./config.ini;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };
    script = ''
    # Launch bar on each monitor, tray on primary
    polybar --list-monitors | while IFS=$'\n' read line; do
      primary=$(echo $line | ${pkgs.coreutils}/bin/cut -d':' -f1)
      monitor=$(echo $line | ${pkgs.coreutils}/bin/cut -d' ' -f3)
      tray_position=$([ -n "$primary" ] && echo "right" || echo "none")
      MONITOR=$monitor TRAY_POSITION=$tray_position polybar --reload main &
    done
  '';
    extraConfig = (builtins.readFile ./modules.ini) + ''
      [module/spotify]
      type = custom/script
      interval = 1.0
      tail = true
      format-prefix = " "
      format = <label>
      exec = ${pkgs.polybar-spotify}
    '';
  };
}
