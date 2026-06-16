# dotfiles

Reproducible macOS setup for **DaxBook** (Apple Silicon) using a Nix flake
driving [nix-darwin](https://github.com/nix-darwin/nix-darwin) (system level) +
[home-manager](https://github.com/nix-community/home-manager) (user level).

After a wipe, this repo rebuilds the machine — CLI tools, GUI apps, shell, git,
fonts, and macOS preferences — with a handful of commands.

## Layout

```
flake.nix              Inputs (nixpkgs, nix-darwin, home-manager) + outputs
hosts/daxbook.nix      Per-machine nix-darwin system config
modules/darwin/        System-level: homebrew (GUI apps), macOS defaults, fonts
modules/home/          User-level: CLI packages, zsh + starship, git/gh
```

- **CLI tools** come from nix (`modules/home/packages.nix`).
- **GUI apps** come from Homebrew casks declared in nix-darwin
  (`modules/darwin/homebrew.nix`). nix-darwin manages brew *state*; it does not
  install Homebrew itself.
- **Node/Python** stay per-project: fnm for Node, `uv`/venv for Python. Both
  are installed by nix; runtime versions are managed per-project.

## Bootstrap (after wiping the Mac)

1. **Xcode command-line tools**
   ```sh
   xcode-select --install
   ```
2. **Install Nix** (Determinate Systems installer — flakes enabled by default)
   ```sh
   curl -fsSL https://install.determinate.systems/nix | sh -s -- install
   ```
   Open a new terminal afterwards so `nix` is on PATH.
3. **Install Homebrew** (nix-darwin manages packages but not brew itself)
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
4. **Clone this repo**
   ```sh
   git clone https://github.com/daxit/dotfiles.git ~/Documents/git-repos/dotfiles
   ```
5. **First build**
   ```sh
   sudo nix run nix-darwin -- switch --flake ~/Documents/git-repos/dotfiles#daxbook
   ```

## Post-build steps

- **GitHub auth** — `gh auth login` then `gh auth setup-git` (configures git to use gh for HTTPS auth).
- **App Store** — sign in so the `mas` apps install.
- **Node** — fnm is installed by nix, but you still need a Node version:
  ```sh
  fnm install --lts
  ```

## Editing the config

- Add/remove GUI apps → `modules/darwin/homebrew.nix` (`casks`).
- Add/remove CLI tools → `modules/home/packages.nix`.
- Shell/aliases/prompt → `modules/home/shell.nix`.
- macOS system preferences → `modules/darwin/system.nix`.

After any change, validate before applying:

```sh
darwin-rebuild build --flake ~/Documents/git-repos/dotfiles#daxbook   # build only
darwin-rebuild switch --flake ~/Documents/git-repos/dotfiles#daxbook  # apply
```
