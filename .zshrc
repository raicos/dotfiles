### Zsh rc

# -*- zplug -*-
source ~/.zplug/init.zsh

zplug "sorin-ionescu/prezto"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "yous/vanilli.sh"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
#zplug "zsh-users/zsh-autosuggestions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# -*- sh -*-
export XDG_CONFIG_HOME=~/.config
#export TERM=xterm-color256
export PATH="/Users/shoma/anaconda3/bin:$PATH"

### key bind
bindkey -e
# bindkey -v

cdpath=(~)
chpwd_functions=($chpwd_functions dirs)

### vsc
autoload -Uz vsc_info
zstyle ':vsc_info:*' enable git svn hg
zstyle ':vsc_info:*' formats '(%s)[%b] '
zstyle ':vsc_info:*' actionformats '(%s)[%b|%a] '
zstyle ':vsc_info:svn:*' branchformat '%b:r%r'

### History
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt extended_history
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt no_flow_control

### Prompt
## Use Variable-expansion, command-substitution, math-expression in PROMPT
setopt prompt_subst
## Enable subst. of "%"-Head Strings in PROMPT
setopt prompt_percent
## Vanish Right PROMPT in Command Moving
setopt transient_rprompt

alias vi='nvim'
alias vim='nvim'
alias ls='ls -G'
alias la='ls -aG'
alias ll='ls -lG'
alias python='python3'
alias pip='pip3'

### Complement
## Initialize Complements
#autoload -U compinit
#compinit

## to Grouped
## How to display.
## %d: labels
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

## Selection on Menues
## select=2 By List.
##	but proposed is only one, completion will end immediately
zstyle ':completion:*:default' menu select=2

## Use Color
## '': use defalt
zstyle ':completion:*:defalt' list-colors ""

## Search more.
## Use Wildcards, ignore Upper, Lower
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z} r:|[._-]=*'

## completate level
## _oldlist : use previous log
## _complete : use complete
## _match : don't use grob
## _history : use history log
## _ignored : don't use ignore's list
## _approximate : use near anwer
## _prefix : igonore next for cursor
zstyle ':completion:*' completer _oldlist _complete _match _history \ 
	_ignored _ approximate _prefix

## Cashe
zstyle ':completion:*' use-cashe yes
## use information detail
zstyle ':completion:*' verbose yes
## use sudo_path in sudo
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH"

## completion in cursor
setopt complete_in_word
## don't use glob
setopt glob_complete
## use history
setopt hist_expand
## don't use beep
setopt no_beep
## in sort,  not dictionary, use number
setopt numeric_glob_sort

### expantions
## use prefix
setopt magic_equal_subst
## use extended glob
setopt extended_glob
## in genereted path with glob, add / to last when path is directory
setopt mark_dirs

## jobs: Output Process ID 
setopt long_list_jobs
## display comsumed times
REPORTTIME=3

## watch all users (login/logout)
watch="all"
## Display "Logout", Immediately
#log

## don't logout with ^D
setopt ignore_eof


### Words
## to terminator '/'
WORDCHARS=${WORDCHARS:s,/,,}

### aliases
### grep -r def *.rg L -> grep -r def *.rb |& lv
alias -g L="|& $PAGER"
## more useful grep
alias -g G='| grep'
##
alias -g H='| head'
alias -g T='| tail'
alias -g S='| sed'

## delete completely
alias rr="command rm -rf"
## check file operation
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

## git
alias gl='git log --graph'
alias gc='git checkout'

## shortcut for pushd/popd
alias pd="pushd"
alias po="popd"

## tmux
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
  if is_screen_or_tmux_running; then
    ! is_exists 'tmux' && return 1

    if is_tmux_runnning; then
      echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
      echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
      echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
      echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
      echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
    elif is_screen_running; then
      echo "This is on screen."
    fi
  else
    if shell_has_started_interactively && ! is_ssh_running; then
      if ! is_exists 'tmux'; then
        echo 'Error: tmux command not found' 2>&1
        return 1
      fi

      if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
        # detached session exists
        tmux list-sessions
        echo -n "Tmux: attach? (y/N/num) "
        read
        if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
          tmux attach-session
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
          tmux attach -t "$REPLY"
          if [ $? -eq 0 ]; then
            echo "$(tmux -V) attached session"
            return 0
          fi
        fi
      fi

      if is_osx && is_exists 'reattach-to-user-namespace'; then
        # on OS X force tmux's default command
        # to spawn a shell in the user's namespace
        tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
        tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
      else
        tmux new-session && echo "tmux created new session"
      fi
    fi
  fi
}
tmux_automatically_attach_session
