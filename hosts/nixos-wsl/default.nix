{ ... }:
{
  imports = [
    ../../modules/nixos/core.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/wsl.nix
  ];

  system.stateVersion = "24.05";
}
