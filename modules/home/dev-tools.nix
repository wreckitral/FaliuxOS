{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zip
    docker
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
    (writeShellScriptBin "chrome-wsl" ''
      arg="$1"
      case "$arg" in
        http://*|https://*)
          target="$arg"
          ;;
        file://*)
          target=$(wslpath -w "''${arg#file://}")
          ;;
        *)
          target=$(wslpath -w "$arg" 2>/dev/null || echo "$arg")
          ;;
      esac
      "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" "$target"
    '')
  ];

  home.shellAliases = {
    her = "herdr";
    herstop = "herdr server stop";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.home-manager.enable = true;
}
