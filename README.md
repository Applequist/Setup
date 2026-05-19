# Setup

Setup helps you setup and reuse your Debian system configuration.


## Getting Started

Clone this repository **in your $HOME repository**.
Bootstrap the setup.
Setup additional packages.

**Do NOT delete** the repository from your computer.

When editing your configuration locally, you actually modify the *installation image* of 
the cooresponding package in the Setup repository. 

You can commit and push the modifications so you don't loose them:

Or you can just revert them.

## Layout

Setup/                : Setup root dir, the one containing .git when cloned. 
  README.md           : This file.
  bootstrap           : bootstrap script. See below.
  data/               : Root directory for package files that are not part of their *installation image*. May contains data and other files that serves as input.
  pkgs/               : Root directory containing packages. Act as the *stow directory* in stow parlance.
    <pkg>/            : Package root directory. It contains the package's *installation image* (in stow parlance)
      bin/
        install_<pkg> : Pacakge installation/update script. Optional (if the package is pure system configuration).
      .profile.d/     : Contains scripts sourced in .profile of the 'base' package.
         <pkg>.env    : Package environment setup (PATH item, ...). Optional.
      .config/        : Package configuration root
        ...


## Bootstrap

Bootstraping a system does the following:
- update the system: sudo apt update && sudo apt upgrade
- install fundamental tools required for this setup to work
- Write setup.env in $HOME/.profile.env: it contains Setup env variables
- setup the 'base' package
- Load Gnome presets [TODO]
- setup additional packages passed as arguments

To bootstrap a new system, invoke 'bootstrap':
```
~/Setup $ ./bootstrap [pkgs]
```


## Package setup

Setting up a package '<pkg>' does the following:
- Install or update the package by running 'Setup/<pkg>/bin/install_<pkg>' **if present**
- Stow the package: '$ stow -S <pkg> -d $HOME/Setup'. 

To setup a package, invoke 'setup':
```
~/Setup $ ./setup <pkg>
```

## Available Packages

### shell

- Configure the shell for use with other packages.
- Configure other base tools: git, ... (tinted-theming ?)

Pkgs/
  shell/
    .bashrc
    .profile
    .config/
      git/
        config
    bin/
      setup     : script use to setup packages.

### Rust

- Install rust stable toolchain
- Install rust utilities: bacon, ripgrep, tree-sitter-cli...
- Install rust.env to include $HOME/.cargo/bin in PATH

Pkgs/
  rust/
    bin/
      install_rust
    .profile.d/
      rust.env

### Lua_ls

- Install lua-language-server

Pkgs/
  lua/
    bin/
      install_lua_ls

### Editor

- Install and configure Neovim for Lua, Rust programming

Pkgs/
  editor/
    bin/
      install_editor  : Install Neovim release from Github
    .config/
      nvim/
        ...           : Neovim configuration

### Themes [TODO]

- Install tinted-theming tinty

Pkgs/
  themes/
    bin/
      install_themes

## TODO

### Editor

- Configure treesitter
- Configure LSP features:
  - completions
  - diagnostics
  -...

### Python

TODO


