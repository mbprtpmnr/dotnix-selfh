{ config, lib, pkgs, inputs, ... }:

let
  home = config.home.homeDirectory;
in

{
  programs.gh = {
    enable = true;
    gitProtocol = "ssh";
    editor = "vim";
  };

  programs.firefox = {
    enable = true;
    profiles = {
      mbprtpmnr = {
        isDefault = true;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      bitwarden
      # (buildFirefoxXpiAddon {
      #   pname = "adblock-plus";
      #   version = "3.11.2";
      #   addonId = "{1f9ca01b-0cab-42e2-a13c-2accd2d77a7f}";
      #   url = "https://addons.mozilla.org/firefox/downloads/file/3833352/adblock_plus-3.11.2-an+fx.xpi";
      #   sha256 = "sha256-HVLgUOsOcEB9+D0tqGM6WUSvo3XBNqqP6gMilHBjDQU=";
      #   meta = with lib; { platforms = platforms.all; };
      # })
      ublock-origin
      sponsorblock
    ];
  };

  programs.gpg = {
    enable = true;
    settings = {
      homedir = "${home}/.gnupg";
    };
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    settings = {
      PASSWORD_STORE_DIR = "${home}/.password-store";
    };
  };

  programs.ssh = {
    enable = true;
    compression = true;
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "${home}/.ssh/id_ed25519";
        identitiesOnly = true;
      };

      "mbprtpmnr.xyz" = {
        user = "mbprtpmnr";
        identityFile = "${home}/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
