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

    initContent = ''
      # Homebrew — puts `brew`/`mas` on the interactive PATH.
      # nix-darwin places nix profiles earlier, so nix CLIs win over brew duplicates.
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';
  };

  # fnm handles installation and zsh integration (reads .nvmrc / .node-version).
  programs.fnm = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship.enable = true;
}
