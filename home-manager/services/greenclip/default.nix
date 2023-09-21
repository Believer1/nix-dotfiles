{ pkgs, ...}:
{
  xdg.configFile."greenclip.cfg".source = ./greenclip.cfg;

  systemd.user.services.greenclip = {
    Unit = {
      Description = "greenclip daemon";
      After    = [ "graphical-session.target" ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.haskellPackages.greenclip}/bin/greenclip daemon";
    };
  };

}

