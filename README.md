# nix-config

One flake, three hosts: `nixos-wsl`, `laptop-intel`, `macbook`.
All host-agnostic behavior (zsh, neovim, git, dev tooling) lives once in
`modules/home/` and is sharedacross every host, including macOS.
Only the `hosts/<name>/` layer differs per machine.

## Layout

```
flake.nix              # wires everything together, defines mkNixosHost/mkDarwinHost
hosts/
  nixos-wsl/            # WSL machine
  laptop-intel/         # bare-metal Intel laptop
  macbook/              # nix-darwin
modules/
  nixos/                # NixOS-only system modules (core, users, locale, wsl, bare-metal)
  darwin/                # nix-darwin-only system modules
  home/                  # cross-platform home-manager modules (shared by ALL hosts)
overlays/               # custom/patched packages, wired into every host
dotfiles/                # where the app level config lives
```

## Bootstrap for WSL

```powershell
wsl --install NixOS
```
```bash
git clone <this-repo> ~/nix-config
cd ~/nix-config
sudo nixos-rebuild switch --flake .#nixos-wsl
```

## Bootstrap for Intel laptop

1. Boot the NixOS installer ISO.
2. `sudo nixos-generate-config --show-hardware-config > hosts/laptop-intel/hardware-configuration.nix`
   (replace the placeholder file with this real output, do not hand-edit UUIDs)
3. `git clone <this-repo> ~/nix-config && cd ~/nix-config`
4. `sudo nixos-rebuild switch --flake .#laptop-intel`

## Bootstrap for MacBook

1. Install Nix (official installer or Determinate Systems installer).
2. Install nix-darwin: `nix run nix-darwin -- switch --flake ~/nix-config#macbook`
3. Subsequent rebuilds: `darwin-rebuild switch --flake ~/nix-config#macbook`

## Adding a fourth host later

1. `mkdir hosts/<name>`, add `default.nix` + `home.nix` importing the
   modules that apply.
2. Register it in `flake.nix` under `nixosConfigurations` or
   `darwinConfigurations` using the existing `mkNixosHost`/`mkDarwinHost`,
   no other file needs to change.

## Notes / TODO for this repo

- `dotfiles/nvim` and `dotfiles/.p10k.zsh` are placeholders
- `hosts/laptop-intel/hardware-configuration.nix` is a placeholder and
  MUST be regenerated on the real hardware before building that host.
- Secrets (SSH keys, API tokens, etc.): `sops-nix` is already wired as a
  flake input and imported on every host just add a `secrets.yaml`
  `.sops.yaml` and per-host `sops.secrets.<name>` declarations when needed.
- Formatting: `nix fmt` (uses `nixfmt-rfc-style`, set as the flake formatter).
- `system.primaryUser` in `modules/darwin/core.nix` and the cask list are
  placeholders.
