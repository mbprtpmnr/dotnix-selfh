{ config, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = "experimental-features = nix-command flakes";
  };
}