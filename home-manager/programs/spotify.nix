# when i use lib.mkIf nixosConfig.setup.gui.enable { ... } the build fails
#error: The option `home-manager.users.snd.imports' does not exist. Definition values:
#       - In `/nix/store/bf9kjz37ssx959dxh8hq6iqy5ww6afsl-source/home-manager/single/spotify.nix':
#           {
#             _type = "if";
#             condition = true;
#             content = [
#               <function, args: {config, lib, pkgs}>
#           ...
{ pkgs, lib, ... }:
let
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
    sha256 = "1prd9b1xx8c0sfwnyzkspplh30m613j42l1k789s521f4kv4c2z2";
  };
  spicetify-nix = (import flake-compat {
    src = builtins.fetchTarball {
      url = "https://github.com/the-argus/spicetify-nix/archive/master.tar.gz";
      sha256 = "0szlf5264kvyqz3rm27jjh7kbxldz078939267c9rpin45dadyiv";
    };
  }).defaultNix;

  officialThemes = {
    pname = "officialThemes";
    version = "7e9e898124c96f115dc61fb91d0499ae81f56892";
    src = pkgs.fetchgit {
      url = "https://github.com/spicetify/spicetify-themes";
      rev = "7e9e898124c96f115dc61fb91d0499ae81f56892";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-fnUINAgBCaklVDR2JsyvnN0ekBJ/sOnUNnKStug2txs=";
    };
    date = "2023-08-17";
  };

  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" ];

  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify = {
    enable = true;

    theme = {
      name = "text";
      src = officialThemes.src;
      patches = {
        "xpui.js_find_8008" = ",(\\w+=)56";
        "xpui.js_repl_8008" = ",\${1}32";
      };
      injectCss = true;
      replaceColors = true;
      appendName = true;
      overwriteAssets = false;
      sidebarConfig = false;
    };
    # colorScheme = "mauvei";
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      hidePodcasts
      playlistIcons
      genre
      lastfm
      historyShortcut
      adblock
    ];
  };
}
