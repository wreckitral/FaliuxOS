# PLACEHOLDER — replace this entire file with the output of:
#   sudo nixos-generate-config --show-hardware-config
# run ON the laptop itself, after booting the NixOS installer.
# Do not hand-write this; it encodes your actual disk UUIDs, filesystems,
# and kernel modules.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ ]; # filled in by nixos-generate-config
  boot.kernelModules = [ ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/REPLACE-ME";
    fsType = "ext4";
  };
  swapDevices = [ ];
  nixpkgs.hostPlatform = "x86_64-linux";
}
