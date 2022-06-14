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

### Main Mod/Prefix/Leader Keybindings
 * in Vim the leader key is: <kbd>Space</kbd>
 * in tmux the prefix is: <kbd>CTRL</kbd> + <kbd>a</kbd>
 * in i3 the mod key is: <kbd>GUI</kbd>

As much as possible the style of these different tools are all based on
the [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) colorscheme.

## Dependencies
 * Neovim v0.6.0
 * JetBrains font
 * Powerline font
 * Font Awesome
 * ripgrep
 * python3 with pynvim

## Installation
### Clone
The folder structure of the repository is designed to work with `stow` so this
repository must be checked out to your home directory.
```shell
git clone https://github.com/sunshin-es/dotfiles.git ~/.dotfiles
```

### Plugin Manager
Packer.nvim is used to manage Vim plugins, this needs to be installed to somewhere on your `packpath`, e.g.:

> Unix, Linux Installation

```shell
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Install
Some of the tools are grouped together, but `stow` must be run from the root of
the repository.

```shell
stow editor # Neovim configuration
stow term   # tmux, fish, and alacritty configurations
stow wm     # i3 configuration
```

## License
Unless otherwise noted, the contents of this repo are in the public domain. See
the [LICENSE](LICENSE.md) for details.
