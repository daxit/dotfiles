{ pkgs, ... }:
{
  # CLI tools managed by nix. Transitive dependencies are resolved automatically.
  home.packages = with pkgs; [
    bat       # cat replacement with syntax highlighting and line numbers
    eza       # ls replacement with color, icons, and git status
    fd        # find replacement; faster, friendlier syntax
    ffmpeg    # audio/video conversion and streaming toolkit
    fnm       # Node.js version manager; reads .nvmrc / .node-version per project
    jq        # JSON query and pretty-print tool
    podman    # daemonless container engine (needs `podman machine init` once)
    ripgrep   # grep replacement; respects .gitignore, very fast
    tesseract # OCR engine for extracting text from images
    tree      # print directory trees
    uv        # Python package and runtime manager; use per-project venvs
    yt-dlp    # download video/audio from YouTube and 1000+ other sites
  ];
}
