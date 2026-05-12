# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [[ -d "$HOME/bin" ]] ; then
  case ":${PATH}:" in
    *:"$HOME/bin":*)
      ;;
    *)
      PATH="$HOME/bin:$PATH"
      ;;
  esac
fi

if [[ -d "$HOME/.local/bin" ]] ; then
  case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
      ;;
    *)
      PATH="$HOME/.local/bin:$PATH"
      ;;
  esac
fi

# TODO When installing a tool, add a tool env setting script (or a link to it) in '.env'
# and source them here using run-parts so we don't have to modify this script after 
# every tool installation
# for e in $(run-parts --list $HOME/.env) ; do
#   if [ -r $e ] ; then
#     . $e
#   fi
# done

# Add '$HOME/.cargo/bin' to PATH
if [[ -d "$HOME/.cargo/bin" ]] ; then
  case ":${PATH}:" in
    *:"$HOME/.cargo/bin":*)
      ;;
    *)
      PATH="$HOME/.cargo/bin:$PATH"
      ;;
  esac
fi

