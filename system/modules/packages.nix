{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    exa
    bind
    cached-nix-shell
    cachix
    capitaine-cursors
    curl
    fzf
    git
    git-crypt
    gnumake
    htop
    inputs.npgh.defaultPackage.x86_64-linux
    pavucontrol
    xfce.thunar-archive-plugin
    xfce.xfce4-pulseaudio-plugin
    nixos-generators
    stable.nixops
    keepassxc
    kora-icon-theme
    nixpkgs-fmt
    ripgrep
    sshfs
    sweet
    sxiv
    tmux
    tree
    ueberzug
    procs
    wget
    xclip
    vim
  ];
}
