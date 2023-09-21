{ pkgs, ... }:

{
 
  programs.emacs.enable = true;
  home.file.".emacs.d" = {
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "develop";
      sha256 = "sha256-74kLS+D8hLziJp6ZkV2Do+H++pZizLV7YzgZs+I1Qlc=";
    };
    recursive = true;
  };
  home.file.".spacemacs".source = ./spacemacs/spacemacs.el;

}
