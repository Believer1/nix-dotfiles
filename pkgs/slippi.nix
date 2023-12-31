{ pkgs, ... }:

  let
        app_name = "Slippi_Online-x86_64.AppImage";
        gh_proj = "Ishiiruka";
        gh_user = "project-slippi";
        version = "3.2.2";
        hash = "12k344ky4kp4i9sr847sh9hzq1h8w42msd25gkf5zpmx0s7v8y4r";
    in pkgs.appimageTools.wrapType2 {
        name = "slippi-online";
        extraPkgs = pkgs: [ 
			pkgs.gmp
			pkgs.mpg123
			pkgs.libmpg123
			];
        src = builtins.fetchurl {
            url =
                "https://github.com/${gh_user}/${gh_proj}/releases/download/"
                    + "v${version}/${app_name}";
            sha256 = "${hash}";
        };
    }
