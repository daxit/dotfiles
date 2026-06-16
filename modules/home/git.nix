{ ... }:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Dax";
        email = "8814691+daxit@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.ff = "only";
      fetch.prune = true;
      core.autocrlf = false;
      diff.colorMoved = "default";
      rerere.enabled = true;
    };

    ignores = [
      ".DS_Store"
      "._*"
    ];
  };

  # Auth tokens are not managed here — run `gh auth login` after first build.
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "https";
      prompt = "enabled";
      aliases = {
        co = "pr checkout";
      };
    };
  };
}
