{ lib, fetchzip }:

let
  version = "8.0.2";
  at = "v8.0.2";
in fetchzip {
  name = "iosevka-term-ss08-${version}";

  url = "https://github.com/be5invis/Iosevka/releases/download/${at}/ttf-iosevka-term-ss08-${version}.zip";

  postFetch = ''
    mkdir -p $out/share/fonts
    unzip -j $downloadedFile '*.ttf' -d $out/share/fonts/IosevkaTermSS08
  '';

  sha256 = "sha256-6Rvg4DPe/ZAyZCMMkynyE7qBQjJ+grW6MvVxQ5PC3k4=";

  meta = with lib; {
    homepage = "https://github.com/be5invis/Iosevka";
    description = "Monospace font with programming ligatures";
    license = licenses.ofl;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
