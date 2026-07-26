{ pkgs, lib, ... }:
{
  # ~/.claude/settings.json is a live file Claude Code writes to itself
  # (e.g. /model, /effort, /config), so it's merged via jq on activation
  # rather than symlinked read-only like starship.toml/ghostty.conf.
  home.activation.claudeCodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settingsFile="$HOME/.claude/settings.json"
    mkdir -p "$HOME/.claude"
    [ -f "$settingsFile" ] || echo '{}' > "$settingsFile"

    # Claude Code owns this file, so it can be mid-write or hand-edited into
    # invalid JSON. Warn and move on rather than aborting the whole activation.
    if ${pkgs.jq}/bin/jq \
         '.model = "opusplan" | .permissions.defaultMode = "plan" | .effortLevel = "high"' \
         "$settingsFile" > "$settingsFile.tmp" 2>/dev/null; then
      mv "$settingsFile.tmp" "$settingsFile"
    else
      rm -f "$settingsFile.tmp"
      echo "claude-code: $settingsFile is not valid JSON; left unchanged." >&2
    fi
  '';
}
