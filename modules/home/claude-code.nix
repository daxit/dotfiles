{ pkgs, lib, config, ... }:
let
  # Memories and global instructions live in iCloud so they survive a wipe.
  cloudDir = "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs/claude";
in
{
  # Claude Code rewrites settings.json itself (/model, /effort), so these keys
  # are merged on activation rather than symlinked read-only.
  home.activation.claudeCodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settingsFile="$HOME/.claude/settings.json"
    mkdir -p "$HOME/.claude" "${cloudDir}/memory"
    [ -f "$settingsFile" ] || echo '{}' > "$settingsFile"
    [ -f "${cloudDir}/CLAUDE.md" ] || touch "${cloudDir}/CLAUDE.md"

    # Invalid JSON must not abort activation.
    if ${pkgs.jq}/bin/jq --arg memdir "${cloudDir}/memory" \
         '.model = "opusplan"
          | .permissions.defaultMode = "plan"
          | .effortLevel = "high"
          | .autoMemoryDirectory = $memdir' \
         "$settingsFile" > "$settingsFile.tmp" 2>/dev/null; then
      mv "$settingsFile.tmp" "$settingsFile"
    else
      rm -f "$settingsFile.tmp"
      echo "claude-code: $settingsFile is not valid JSON; left unchanged." >&2
    fi
  '';

  # The # shortcut appends to CLAUDE.md, so it must stay writable — symlink to
  # iCloud rather than the read-only store.
  home.file.".claude/CLAUDE.md".source =
    config.lib.file.mkOutOfStoreSymlink "${cloudDir}/CLAUDE.md";
}
