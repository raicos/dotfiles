### Zsh rc

# -*- sh -*-

### key bind
# Emacs style
bindkey -e
# vi style
#bindkey -v

### Directory Movings
## change directory only directory_name
setopt auto_cd
## cd -> pushd
setopt auto_pushd
## if specified directory is not found in current dir, 
## next is used.
cdpath=(~)
## if directory changed, display directory stacks.
chpwd_functions=($chpwd_functions dirs)


### History
## file it saves history
HISTFILE=~/.zsh_history
## History Counts
HISTSIZE=10000
SAVEHIST=$HISTSIZE
## save with times
setopt extended_history
## don't save same command done prev.
setopt hist_ignore_space
## save immedoately
setopt inc_append_history
## use same history in many processes
setopt share_history
## Don't use C-s/C-q
setopt no_flow_control

### Prompt
## Use Variable-expansion, command-substitution, math-expression in PROMPT
setopt prompt_subst
## Enable subst. of "%"-Head Strings in PROMPT
setopt prompt_percent
## Vanish Right PROMPT in Command Moving
setopt transient_rprompt

### generate 16bit color
color256()
{
	local red=$1;shift
	local green=$2; shift
	local blue=$3; shift

	echo -n $[$red * 36 + $green * 6 + $blue + 16]
}

fg256()
{
	echo -n $'\e[38;5;'$(color256 "$@")"m"
}

bg256()
{
	echo -n $'\e[48;5;'$(color256 "$@")"m"
}


export ZSH_LEVEL=`expr ${ZSH_LEVEL:=0} + 1`
alias nest="echo $ZSH_LEVEL"
###############################################################
### PROMPT Strings
################################################################
## %{%B%}...%{%b%} : BOLD
## %{%F{cyan}%} ... %{%f%} : cyan(color - fg)
## %{%K{cyan}%} ... %{%k%} : cyan(color - bg)
## %n : HOST NAME
## %m : SHORT HOST NAME
## %(x.(true_text).(false_text)) : if-statement of x.
## ? : last command's returns (Success: 0, Failed: another)
## %? : last command's returns (FULL)
## %D{...} : Date.
## 	%Y : Year.
##	%m : month.
##	%d : day.
##	%H : Hour.
##	%M : Minutes.
################################################################
if [ $ZSH_LEVEL -eq 1 ]; then
    zshlevel=""
else
    zshlevel="%{%U%}`nest`%{%u%}"
fi
lprompt_self="%{%F{green}%}%n@%m%{%f%} %{%F{cyan}%}%~ `echo $zshlevel`$ %{%f%}"
rprompt_self="%(?.%{%F{green}%}[%?]%{%f%}.%{%F{red}%}[%?]%{%f%}"

PROMPT=$lprompt_self
RPROMPT=$rprompt_self


### Complement
## Initialize Complements
autoload -U compinit
compinit

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

alias tw="~/.gem/ruby/2.1.0/bin/tw"

alias telcot="cocot -p sjis -t utf-8 -- "

alias e="TERM=xterm-256color /Applications/Emacs.app/Contents/MacOS/Emacs -nw"
### vim
if [ -n `which vim` ]; then
    alias vi="vim"
fi

if [ -e /usr/bin/gvim ]; then
    alias gvi="gvim"
else
    alias gvi="vi"
fi

### ls and ps
## ls <- color, if you can GNU ls
## la <- only ls
## ps : only self processes
case $(uname) in
	*BSD|Darwin)
		if [ -x "$(which gnuls)" ]; then
			alias ls="gnuls -lhAF --color=auto"
			alias la="gnuls"
            alias ll="gnuls -alhAF --color=auto"
		else
			alias la="ls -lhAFG"
            alias ll="ls -alhAFG"
        fi
		#alias ps="ps -fU$(whoami)"
		alias ps="ps -f"
		;;
	SunOS)
		if [ -x "`which gls`" ]; then
			alias la='gnuls'
			alias ls="gnuls -lhAF --color=auto"
            alias ll="gnuls -alhAF --color=auto"
		else
			alias la="ls -lhAF"
            alias ll="ls -alhAF"
        fi
		alias ps="ps -fl -u$(/usr/xpg4/bin/id -un)"
		;;
	*)
        alias ls="ls --color=auto"
		alias la="ls -hAF --color=auto"
        alias ll="ls -alAF --color=auto"
		alias ps="ps -fU$(whoami) --forest"
esac

### Window Title
## display "command, user, host, cwd"
update_title() {
	local command_line=
	typeset -a command_line
	command_line=${(z)2}
	local command=
	if [ ${(t)command_line} = "array-local" ]; then
		command=$command_line[1]
	else
		command="%2"
	fi
	print -n -P "\e]2"
	echo -n "(${command})"
	print -n -P " %n@%m:%~\a"
}

### Language and Locale
## in linux term, cannot display cjk
case ${TERM} in
    linux)
        export LANG=en_US.UTF-8
        ;;
    *)
        export LANG=ja_JP.UTF-8
esac

## on X, change Title
if [ -n "$DISPLAY" ]; then
	preexex_functions=($preexec_functions update_title)
	
fi


