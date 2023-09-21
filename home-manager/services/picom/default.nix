{ pkgs, ... }:
{
  services.picom = {
     enable = true;
     inactiveOpacity = 0.8;
     settings = {
        "unredir-if-possible" = true;
        backend = "xrender"; # try "glx" if xrender doesn't help
        vsync = true;	
      };  
  };	
}
