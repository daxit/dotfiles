{ pkgs, lib, ... }:
{
  # Claude Code rewrites settings.json itself (/model, /effort), so these keys
  # are merged on activation rather than symlinked read-only.
  home.activation.claudeCodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settingsFile="$HOME/.claude/settings.json"
    mkdir -p "$HOME/.claude"
    [ -f "$settingsFile" ] || echo '{}' > "$settingsFile"

    # Invalid JSON must not abort activation.
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
