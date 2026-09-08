{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoxide
    cmatrix
    gcc
    gnumake
    unzip
    ripgrep
    fd
    ast-grep
    tree
    fzf
    nodejs_22
    python3
    uv
    go
    luarocks
    lua5_1
    readline
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
