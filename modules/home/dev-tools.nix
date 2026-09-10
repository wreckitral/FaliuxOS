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
    go_1_27
    luarocks
    lua5_1
    readline
    opencode
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
