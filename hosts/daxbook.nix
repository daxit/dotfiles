{
  inputs,
  username,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/darwin/homebrew.nix
    ../modules/darwin/system.nix
    ../modules/darwin/fonts.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  # Primary user — required by nix-darwin for user-scoped options (homebrew,
  # some system.defaults) and for the home-manager mapping in flake.nix.
  system.primaryUser = username;
  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # Using the Determinate Nix installer, which manages its own daemon and
  # nix.conf (flakes/nix-command are already enabled by default there).
  # nix-darwin must not also try to manage the Nix installation.
  nix.enable = false;

  # Use Touch ID for sudo (handy for `darwin-rebuild` / `sudo`).
  security.pam.services.sudo_local.touchIdAuth = true;

  # zsh is the login shell; nix-darwin manages /etc/zshrc integration.
  programs.zsh.enable = true;

  # Allow unfree packages (e.g. some fonts / tools).
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "daxbook";

  # Pinned to the version at first install — do not bump without reading the migration guide.
  system.stateVersion = 6;
}
