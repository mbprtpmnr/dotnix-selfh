{ config, pkgs, inputs, ... }:

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
      mbprtpmnr = { };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      bitwarden
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
