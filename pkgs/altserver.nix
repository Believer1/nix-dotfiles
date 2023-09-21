{ pkgs, ... }:

  let
     dockerName = "alt_anisette";
     altStoreIpa = pkgs.fetchurl {
       url = "https://cdn.altstore.io/file/altstore/apps/altstore/1_6_1.ipa";
       hash = "sha256-1+/B2wf4H5cCyaU0M8QZEfHCORhU4OODfB+4I5PxwgY=";
     };
  in
    pkgs.writeShellApplication {
      name = "altserver";

      runtimeInputs = with pkgs; [ docker unstable.altserver-linux ];

      text = ''
       UUID=
       getUuid(){
       UUID=$(lsusb -s "$(lsusb | grep "Apple" | cut -d ' ' -f 2)":"$(lsusb | grep "Apple" | cut -d ' ' -f 4 | sed 's/://')" -v | grep iSerial | awk '{print $3}')
       }

       echo "AltServer Time"
       docker pull nyamisty/alt_anisette_server
       docker run -d --name ${dockerName} --rm -p 6969:6969 -it nyamisty/alt_anisette_server
       export ALTSERVER_ANISETTE_SERVER="http://localhost:6969"
       getUuid
       
       echo "$UUID"
       ls ${altStoreIpa} 

       docker stop ${dockerName}
       '';
  }
