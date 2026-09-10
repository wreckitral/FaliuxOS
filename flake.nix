{
  description = "faliux's multi-host Nix configuration (WSL, Intel laptop, MacBook)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    opencode-nix.url = "github:dan-online/opencode-nix";
    herdr.url = "github:herdrdev/herdr";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-darwin = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      nixpkgs-darwin,
      home-manager,
      home-manager-darwin,
      nix-darwin,
      nixos-wsl,
      sops-nix,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];
      imports = [ treefmt-nix.flakeModule ];
      flake =
        let
          username = "faliux";
          # Linux (NixOS) host builder
          mkNixosHost =
            {
              name,
              extraModules ? [ ],
            }:
            nixpkgs.lib.nixosSystem {
              specialArgs = { inherit inputs username; };
              modules = [
                { nixpkgs.hostPlatform = "x86_64-linux"; }
                ./hosts/${name}
                home-manager.nixosModules.home-manager
                sops-nix.nixosModules.sops
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    backupFileExtension = "backup";
                    extraSpecialArgs = { inherit inputs username; };
                    users.${username} = import ./hosts/${name}/home.nix;
                  };
                }
              ]
              ++ extraModules;
            };

          # macOS (nix-darwin) host builder
          mkDarwinHost =
            {
              name,
              system ? "aarch64-darwin",
            }:
            nix-darwin.lib.darwinSystem {
              specialArgs = { inherit inputs username; };
              modules = [
                { nixpkgs.hostPlatform = system; }
                ./hosts/${name}
                home-manager-darwin.darwinModules.home-manager
                sops-nix.darwinModules.sops
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    backupFileExtension = "backup";
                    extraSpecialArgs = { inherit inputs username; };
                    users.${username} = import ./hosts/${name}/home.nix;
                  };
                }
              ];
            };
        in
        {
          nixosConfigurations = {
            # `nixos-rebuild switch --flake .#nixos-wsl`
            nixos-wsl = mkNixosHost {
              name = "nixos-wsl";
              extraModules = [ nixos-wsl.nixosModules.default ];
            };
            # `nixos-rebuild switch --flake .#laptop-intel`
            laptop-intel = mkNixosHost { name = "laptop-intel"; };
          };
          # `darwin-rebuild switch --flake .#macbook`
          darwinConfigurations = {
            macbook = mkDarwinHost { name = "macbook"; };
          };
        };
      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        {
          treefmt = {
            projectRootFile = "flake.nix";
            programs.nixfmt.enable = true;
          };
          formatter = config.treefmt.build.wrapper;
        };
    };
}
