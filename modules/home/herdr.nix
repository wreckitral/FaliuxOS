{ pkgs, config, ... }:
{
  home.packages = [ pkgs.herdr pkgs.jq ];

  xdg.configFile."herdr/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/herdr/config.toml";

  home.file.".local/bin/herdr-sessionizer".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/scripts/herdr-sessionizer";
}
