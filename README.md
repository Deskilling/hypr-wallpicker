# Hypr-wallpicker ⬡

Hypr-wallpicker a standalone hexagonal wallpaper selector written in `C` and `Raylib` for Hyprland.

![showcase](./demonstration/showcase.gif)

## Features

* **Hexagonal grid UI:** It calculates and renders a proper hexagonal grid for wallpaper thumbnails.
* **Animations:** It provides scale and brightness transitions on mouse hover.
* **Auto-caching**: It automatically resizes, crops, and applies a hex-mask to high-res wallpapers for fast subsequent loads.
* **Wayland transition:** Integrates with `awww` to trigger ripple transitions directly from the absolute screen coordinates of the clicked hex tile.
* **Color extraction support:** It supprots `matugen` upon selection to dynamically adjust your system theme color based on the chosen wallpaper.

By utilizing raw `C` and `Raylib`, it bypasses the overhead and bloated dependencies typical of modern JS/Electron UI frameworks.

This tool adheres to the Unix philosophy—it handles the visual selection of wallpapers and delegates the actual desktop drawing to Wayland daemons (`awww`) and theming engines (`matugen`) via standard shell commands. 

## Dependencies

To build and run the tool, you may need:

* `raylib` (for UI rendering)
* `awww` (for Wayland wallpaper drawing and transitions)
* `matugen` (optional, for dynamic system color generation)

## Build & Run

Currently, the build process is as raw as it gets (a proper build system is on the roadmap).

Use `gcc` to compile:
```bash
gcc main.c -o wallpicker -O2 -Wall -lraylib -lm -ldl -lpthread -lrt -lX11
```
Run the executable:
```bash
./wallpicker
```
The program defaults to `~/Pictures/wallpapers/` if no argument is provided. To specify a custom directory, pass the path as an argument:

```bash
./wallpicker [path/to/directory]
```
For example:
```bash
./wallpicker ~/Pictures/custom/my_wallpapers
```
The first time you use this program, it will generate cached files of wallpapers, which may take a short time. Please be patient.
