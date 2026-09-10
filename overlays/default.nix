{ inputs, ... }:
[
  (final: prev: {
    herdr = inputs.herdr.packages.${prev.system}.default;
  })

  (final: prev: {
    opencode = inputs.opencode-nix.packages.${prev.system}.default;
  })

  # Example: pull a package from nixpkgs-unstable when stable is behind.
  # (uncomment and adjust once you actually need it)
  #
  # (final: prev: {
  #   somePackage = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.somePackage;
  # })
]
