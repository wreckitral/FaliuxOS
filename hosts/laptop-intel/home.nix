{ username, ... }:
{
  imports = [
    ../../modules/home/zsh.nix
    ../../modules/home/neovim.nix
    ../../modules/home/git.nix
    ../../modules/home/dev-tools.nix
    ../../modules/home/dev-shells.nix
    ../../modules/home/herdr.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
}
