{ config, pkgs, ... }:

{
  services.keybase.enable = true;

  services.kbfs.enable = true;

  services.syncthing.enable = true;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    defaultCacheTtlSsh = 60;
    maxCacheTtl = 60;
    maxCacheTtlSsh = 60;
    pinentryFlavor = "gtk2";
    # sshKeys = [ "..." ];
  };
}
