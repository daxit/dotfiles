{ pkgs, ... }:
{
  # GUI apps that ship as macOS binaries — not buildable from source by Nix on macOS.
  environment.systemPackages = [ pkgs.ghostty-bin ];
  # macOS system preferences captured declaratively. Start conservative and
  # expand over time. After changing these, log out/in (or restart) for some
  # to take full effect. Full option list:
  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.defaults
  system.defaults = {
    dock = {
      autohide = false;
      show-recents = false;
      mru-spaces = false; # don't auto-rearrange Spaces by recent use
      tilesize = 56;
      magnification = true;
      largesize = 70;

      # Pinned apps, left-to-right, captured from the current Dock.
      persistent-apps = [
        "/Applications/Spark.app"
        "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
        "/Applications/Brave Browser.app"
        "/Applications/Notion Calendar.app"
        "/Applications/Notion.app"
        "/Applications/Spotify.app"
        "/System/Applications/Messages.app"
        "/System/Applications/iPhone Mirroring.app"
        "/Applications/Google Chrome.app"
        "/System/Applications/Notes.app"
        "/Applications/Nix Apps/Ghostty.app"
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv"; # list view by default
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      ApplePressAndHoldEnabled = false; # key repeat instead of accent menu
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      "com.apple.swipescrolldirection" = true; # natural scrolling
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
    };

    # Save screenshots somewhere tidy instead of the Desktop.
    screencapture.location = "~/Pictures/Screenshots";

    # Avoid creating .DS_Store on network and USB volumes.
    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
    };
  };
}
