#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 
# ~/.bashrc
#

[[ $- != *i* ]] && return

cd ~

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

### EXPORTS
export TERMINAL="alacritty"
export BROWSER=/usr/bin/firefox-developer-edition
export EDITOR="nvim"

export R_LIBS="/mnt/LocalDisk1/Shobhan/Applications/R"
export R_LIBS_USER="/mnt/LocalDisk1/Shobhan/Applications/R"
export R_LIBS_SITE="/mnt/LocalDisk1/Shobhan/Applications/R"

export _JAVA_AWT_WM_NONREPARENTING=1

export PATH="/usr/local/gromacs/bin:$PATH"
export PATH="/home/lsw/.scripts/:$PATH"
export PATH="/home/lsw/.scripts/statusbar/:$PATH"
export PATH="/home/lsw/.local/bin:$PATH"

export PATH=$ANDROID_HOME:$PATH
export PATH="~/.Cytoscape_v3.9.1/":$PATH
export PATH="/mnt/LocalDisk/IITM/Sem_7/Academics/Computational_Biology_Laboratory/BT4110/Assignment_3/MGLTools-1.5.7/share/bin":$PATH
# export PYTHONPATH="/mnt/LocalDisk/IITM/Sem_5/Research_Project/Bacterial_Interactions/New/MSI"
# export PYTHONPATH="$PYTHONPATH:/mnt/LocalDisk/IITM/Sem_5/Research_Project/Bacterial_Interactions/New/Metquest"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export QT_QPA_PLATFORMTHEME=qt5ct

### ALIASES
alias cls="clear"
alias cp="cp -i"                          # confirm before overwriting something
alias mv="mv -i"                          # confirm before overwriting something
alias rm="rm -i"                          # confirm before overwriting something

alias df='df -h'                          # human-readable sizes
alias np='nano -w PKGBUILD'
alias more=less

alias vi=nvim
alias r=ranger
alias wallpaper="nitrogen --set-zoom-fill --random /mnt/LocalDisk2/Wallpapers"
alias pacman="sudo pacman"
alias battery="upower --enumerate | grep BAT | xargs upower --show-info | \grep percent"
alias ytdl="youtube-dl -f 'best'"

alias cdl="cd /mnt/LocalDisk/"
alias cdl1="cd /mnt/LocalDisk1/"
alias cdl2="cd /mnt/LocalDisk2/"
alias cdli="cd /mnt/LocalDisk/IITM"
alias cdld="cd /mnt/LocalDisk1/Shobhan/Workspace/Linux/Linux_Dot_Files"

alias cfb="nvim ~/.bashrc"
alias cfv="nvim ~/.config/nvim/init.vim"
alias cfq="nvim ~/.config/qtile/config.py"
alias cfa="nvim ~/.config/awesome/rc.lua"
alias cfx="nvim ~/.xmonad/xmonad.hs"
alias cfxb="nvim ~/.xmobarrc"
alias cfd="nvim ~/.config/dwm/config.def.h"
alias cfs="nvim ~/.config/st/config.def.h"
alias cfk="nvim ~/.config/kitty/kitty.conf"
alias cfdw="cd ~/.config/dwmblocks/"

alias gitpat="cat ~/.config/PAT | tr -d "\n" | xclip -sel clip"
alias pinga="ping archlinux.org"
alias drone="dragon-drag-and-drop"
alias btctl="bluetoothctl"
alias nb="jupyter-notebook"
alias joplin-desktop="/home/lsw/.joplin/Joplin.AppImage"
alias wifi-reset="sudo modprobe -r ath10k_pci; sudo modprobe ath10k_pci"

### CUSTOM CONFIGS
wmname=$(wmctrl -m | grep Name | cut -d : -f 2 | tr -d " ")
if [[ $wmname == "LG3D" ]] 
then
	unset COLUMNS
	unset LINES
fi

set -o vi

### CUSTOM FUNCTIONS
source ~/.scripts/mkcd
source ~/.scripts/cdsi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/lsw/.miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lsw/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lsw/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/lsw/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/lsw/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/lsw/micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/lsw/micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/lsw/micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/lsw/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<


# Load Angular CLI autocompletion.
source <(ng completion script)
