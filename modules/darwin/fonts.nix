{ pkgs, ... }:
{
  # Fonts installed system-wide via nix.
  fonts.packages = with pkgs; [
    lexend # clean variable UI/display font
    inter # versatile UI font, great at small sizes
    ibm-plex # editor/terminal font (IBM Plex Mono)
    nerd-fonts.jetbrains-mono # programming font with full glyph/icon set
    nerd-fonts.symbols-only # icon glyphs for starship/powerline prompts
  ];
}
