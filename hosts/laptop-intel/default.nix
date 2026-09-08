{ ... }:
{
  imports = [
    ./hardware-configuration.nix # generate with `nixos-generate-config` on the laptop
    ../../modules/nixos/core.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/bare-metal.nix
  ];

  system.stateVersion = "24.05";
}
