{
  pkgs,
  inputs,
  username,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.overlays = import ../../overlays { inherit inputs; };
  nixpkgs.config.allowUnfree = true;

  # nix-darwin manages /etc/nix; keep the "determinate"/official installer's
  # store untouched by disabling nix-darwin's own daemon management if you
  # installed Nix via the official installer rather than nix-darwin itself.
  nix.enable = true;

  users.users.${username}.home = "/Users/${username}";

  system.stateVersion = 5;
  system.primaryUser = username;

  # macOS system defaults, tweak to taste.
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
  };

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    casks = [
      "raycast"
      "rectangle"
    ];
  };
}
