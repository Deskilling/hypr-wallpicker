#!/usr/bin/env bash
set -euo pipefail

# $1 = absolute path of wallpaper
# $2 = relative X coordinate of mouse click (0.0 - 1.0)
# $3 = relative Y coordinate of mouse click (0.0 - 1.0)

WALLPAPER_PATH="${1:-}"
REL_X="${2:-0.5}"
REL_Y="${3:-0.5}"

if [[ -z "$WALLPAPER_PATH" ]]; then
  echo "usage: $0 <wallpaper_path> [rel_x] [rel_y]" >&2
  exit 1
fi

if ! command -v awww >/dev/null 2>&1; then
  echo "awww not found; cannot apply Wayland wallpaper transition" >&2
  exit 1
fi

# Apply wallpaper with animated transition
awww img "$WALLPAPER_PATH" \
  --transition-type grow \
  --transition-pos "$REL_X,$REL_Y" \
  --transition-step 30 \
  --transition-duration 1.2 \
  --transition-fps 60

# Maintain a symlink to the current wallpaper for other components
mkdir -p "$HOME/.config/hypr"
ln -sfn "$WALLPAPER_PATH" "$HOME/.config/hypr/current_wallpaper.png"

# Optional integrations
if command -v matugen >/dev/null 2>&1; then
  matugen image "$WALLPAPER_PATH" --source-color-index 0
fi

command -v makoctl >/dev/null 2>&1 && makoctl reload
command -v hyprctl >/dev/null 2>&1 && hyprctl reload

sleep 1

if [[ -x "$HOME/.config/waybar/scripts/reload-waybar.sh" ]]; then
  "$HOME/.config/waybar/scripts/reload-waybar.sh"
fi
