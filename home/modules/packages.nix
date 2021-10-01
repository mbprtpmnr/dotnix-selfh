{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    afetch
    pfetch
    bat
    bleachbit
    bc
    discord
    element-desktop
    thunderbird
    exa
    fup-repl
    hub
    kotatogram-desktop
    ranger
    meld
    gimp
    i3lock-fancy
    i3lock-color
    pinentry-gtk2
    inkscape
    lsd
    neofetch
    xarchiver
    gopass
    p7zip
    unrar
    unzip
    xsel
  ];
}
