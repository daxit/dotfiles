{ username, ... }:
{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
  ];

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.sessionPath = [ "$HOME/.local/bin" ];

  # Pinned to the version at first install — do not bump without reading the migration guide.
  home.stateVersion = "24.11";

  # Let home-manager manage itself.
  programs.home-manager.enable = true;
}
