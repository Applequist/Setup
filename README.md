# configs

Store your config files and setup script into *packages* and use `stow` to manage their *installation*.

A *package* is a group of files stored under a root directory in this repository.

Current packages are:
- 'shell' : all configuration files related to the shell itself and terminal utilities
- 'bins'  : a collection of utilities to install/update programs.

## New machine setup

The new machine must have `git` and GNU `stow` already available.

0. Cd into your $HOME direcotry:
```
$ cd 
```
1. Clone the project:
```
~ $ git clone git@github.com:Applequist/Setup 
```
2. Call the bootstrap script:
```
~ $ ./Setup/bootstrap
```
