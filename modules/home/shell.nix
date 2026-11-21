{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 50000;
      save = 50000;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    shellAliases = {
      ll = "eza -la";
      ls = "eza";
      cat = "bat --paging=never";
      gst = "git status";
      gsw = "git switch";
    };

    # Runs in ~/.zprofile (login shells). home-manager owns this file, which
    # prevents Homebrew's installer from creating its own duplicate ~/.zprofile.
    profileExtra = ''
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';

    # fnm shell hook — auto-switches Node version on cd (reads .nvmrc / .node-version).
    initContent = ''
      eval "$(fnm env --use-on-cd --shell zsh)"
    '';
  };

  # Fuzzy finder. Its zsh integration binds Ctrl+R (history search), Ctrl+T
  # (insert a file path) and Alt+C (cd into a folder).
  programs.fzf.enable = true;

  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = ./starship.toml;

  # Ghostty is installed in modules/darwin/system.nix; target must be named "config".
  xdg.configFile."ghostty/config".source = ./ghostty.conf;
}
