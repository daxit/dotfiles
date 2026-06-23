{ ... }:
{
  # Homebrew is used only for GUI casks and MAS apps — CLI tools live in nix.
  # nix-darwin manages state declaratively but does not install Homebrew itself;
  # run the official installer once during bootstrap (see README).
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap"; # removes unlisted casks and their associated data
    };

    brews = [ "mas" ]; # required for masApps

    casks = [
      "appcleaner"
      "betterdisplay"
      "brave-browser"
      "claude"
      "cursor"
      "devin-desktop"
      # "gog-galaxy"  # Intel-only; requires Rosetta 2 (`softwareupdate --install-rosetta`)
      "google-chrome"
      "handbrake-app"
      "heroic"
      "iina"
      "keka"
      "mythic"
      "notion"
      "notion-calendar"
      "spotify"
      "steam"
      "visual-studio-code"
      "windscribe"
      "zoom"
    ];

    # Requires being signed into the App Store. IDs from `mas list`.
    masApps = {
      Bitwarden = 1352778147;
      Flow = 1423210932;         # Pomodoro timer
      "Pilot Training" = 1272775528;
      "Prime Video" = 545519333;
      Spark = 1176895641;
      "uBlock Origin Lite" = 6745342698;
      WhatsApp = 310633997;
      Xcode = 497799835;
    };
  };
}
