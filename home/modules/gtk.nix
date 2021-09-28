{ config, pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme.name = "Kora";
    iconTheme.package = pkgs.kora-icon-theme;
    theme.name = "Sweet-Dark";
    theme.package = pkgs.sweet;
    gtk3.extraCss = ''
      VteTerminal, vte-terminal {
        padding: 15px;
      };
    '';
  };
}
