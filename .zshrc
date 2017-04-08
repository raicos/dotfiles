### Zsh rc

# -*- zplug -*-
source ~/.zplug/init.zsh

zplug "sorin-ionescu/prezto"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "yous/vanilli.sh"
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
#zplug "yous/lime"

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

### key bind
bindkey -e
# bindkey -v

cdpath=(~)
chpwd_functions=($chpwd_functions dirs)

### cd 
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

### History
HISTFILE=~/.zsh_history
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

alias ls='ls -G'
alias la='ls -aG'
alias ll='ls -lG'

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

## shortcut for pushd/popd
alias pd="pushd"
alias po="popd"

