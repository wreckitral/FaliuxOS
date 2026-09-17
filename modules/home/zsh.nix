{ pkgs, config, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    GOPATH = "$HOME/go";
    LANG = "en_US.UTF-8";
    OPENCODE_DISABLE_AUTOUPDATE = "1";
    BROWSER = "chrome-wsl";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    shellAliases = {
      v = "$EDITOR";
    };

    initContent = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  home.packages = [ pkgs.zsh-powerlevel10k ];

  home.file.".p10k.zsh".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix-config/dotfiles/.p10k.zsh";
}
