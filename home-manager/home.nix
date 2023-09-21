# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # inputs.hyprland.homeManagerModules.default
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    inputs.nix-doom-emacs.hmModule
    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ] ++ (import ./programs) ++ (import ./services);

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "believer";
    homeDirectory = "/home/believer";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # WAYLAND
    sway
    swww
    waybar

    # UTIL
    arandr
    git-lfs
    btop
    xclip
    playerctl
    coreutils
    dunst
    altserver

    # DEV
    insomnia
    nixfmt
    ripgrep 
    # BASIC
    # i3-gaps
    alacritty
    git
    rofi
    google-chrome
    tor
    tor-browser-bundle-bin
    haskellPackages.greenclip
    webcord-vencord

    # TERMINAL
    any-nix-shell
    neofetch
    zip
    unrar
    unzip
    escrotum
    tree
    gnupg
    aria2
    imagemagick
    feh

    # DEFAULT
    pavucontrol

    # GAMES
    lutris
    slippi
  ];

  programs.zsh = {
    enable = true;
    initExtra = ''
      bindkey "''${key[Up]}" up-line-or-search
    '';
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -l";
      update = "cd /etc/nixos && sudo nixos-rebuild switch --flake .#nix-os";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "zsh-autosuggestions" "fzf" ];
    };
  };
  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
