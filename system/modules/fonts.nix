{ config, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      fira-code
      iosevka-term-ss08-font
      iosevka-fixed-ss08-font
      iosevka-ss08-font
      material-design-icons
      fantasque-sans-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" "IBMPlexMono" ]; })
      noto-fonts-emoji
      jetbrains-mono
      terminus_font_ttf
      terminus_font
      unifont
    ];

    enableDefaultFonts = false;

    fontconfig.defaultFonts = {
      serif = [ "Unifont" ];
      sansSerif = [ "Unifont" ];
      monospace = [ "Unifont" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
