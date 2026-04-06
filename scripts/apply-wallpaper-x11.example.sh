#!/usr/bin/env bash
set -euo pipefail

# $1 = absolute path of wallpaper
# $2 = relative X coordinate of mouse click (unused in X11 example)
# $3 = relative Y coordinate of mouse click (unused in X11 example)

WALLPAPER_PATH="${1:-}"

if [[ -z "$WALLPAPER_PATH" ]]; then
  echo "usage: $0 <wallpaper_path>" >&2
  exit 1
fi

if ! command -v feh >/dev/null 2>&1; then
  echo "feh not found; cannot apply X11 wallpaper" >&2
  exit 1
fi

# Basic X11 wallpaper apply
feh --bg-fill "$WALLPAPER_PATH"

# Maintain a project-owned symlink
mkdir -p "$HOME/.config/hypr-wallpicker"
ln -sfn "$WALLPAPER_PATH" "$HOME/.config/hypr-wallpicker/current_wallpaper"

# Optional color generation
if command -v wal >/dev/null 2>&1; then
  wal -i "$WALLPAPER_PATH"
fi

# Optional i3 reload
command -v i3-msg >/dev/null 2>&1 && i3-msg reload >/dev/null 2>&1 || true
