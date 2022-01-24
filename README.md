# System Configuration "dotfiles"

## Overview
 * Target platform is Linux
 * Managment of these files is intended to work with GNU stow

## Features
The main development environment is based on the following tools:
 * i3
 * tmux
 * neovim
 * fish
 * alacritty

As much as possible the style of these different tools are all based on
the [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) colorscheme.

## Dependencies
 * Neovim v0.5.0
 * JetBrains font
 * Powerline font
 * Font Awesome

## Installation
### Clone
The folder structure of the repository is designed to work with `stow` so this
repository must be checked out to your home directory.
```bash
cd                     # Make sure we are home
git clone https://github.com/sunshin-es/dot-files.git
mv dot-files .dotfiles # Give the repository a better name
```
### Install
Some of the tools are grouped together, but `stow` must be run from the root of
the repository.

```bash
stow editor # Neovim configuration
stow term   # tmux, fish, and alacritty configurations
stow wm     # i3 configuration
```

## License
Unless otherwise noted, the contents of this repo are in the public domain. See
the [LICENSE](LICENSE.md) for details.
