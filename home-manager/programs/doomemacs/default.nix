{ pkgs, ... }:
{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d; # Directory containing your config.el, init.el
  };
}
