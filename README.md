# mouse-scroll-restore

A lightweight global minor mode for GNU Emacs that restores your cursor position (point) after mouse scrolling sessions.

## Overview

When you scroll through a buffer using your mouse wheel or trackpad, `mouse-scroll-restore-mode` automatically remembers your initial cursor position. You can scroll as far as you want—the moment you press an arrow key, start typing, or execute any non-mouse command, the window instantly snaps back and recenters around your original position.

Standard keyboard scrolling commands (like `C-v`, `M-v`, `PageUp`, and `PageDown`) remain completely unaffected and retain their default behavior.

## Installation

### Manual Installation

1. Create a directory for the package and clone/save the source file there:
   ```bash
   mkdir -p ~/elisp/mode/mouse-scroll-restore
   # Save mouse-scroll-restore.el into this directory
   ```

2. Add the directory to your Emacs `load-path` and enable the mode in your `init.el` or `~/.emacs`:

   ```elisp
   ;; Add the specific plugin directory to the load-path
   (add-to-list 'load-path "~/elisp/mode/mouse-scroll-restore")

   ;; Load and activate the mode
   (require 'mouse-scroll-restore)
   (mouse-scroll-restore-mode 1)
   ```

   *Alternatively, if you automatically scan your `~/elisp/mode` directory for subfolders, you can just require it directly.*

## Features

- **Isolated Mouse Behavior:** Tracks only wheel and trackpad scroll events (`mwheel-scroll`, `mwheel-scroll-up`, `mwheel-scroll-down`).
- **Zero Keyboard Interference:** Keeps your custom or default keyboard paging configs completely intact.
- **Smart Recentering:** Automatically executes a `recenter` command once you snap back to provide immediate visual context.
- **Clean Disabling:** Toggling the minor mode off perfectly cleans up all internal hooks and advices.

## License

This program is free software: you can redistribute it and/or modify it under the terms of the **GNU General Public License** as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

See the [GNU General Public License](https://gnu.org) for more details.
