# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="dogenpunk"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

export LM_LICENSE_FILE=2100@ece46sql01.ece.unm.edu
export XILINXD_LICENSE_FILE=2100@ece46sql01.ece.unm.edu



#------------------------------------------////
# Colors:
#------------------------------------------////
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
brown='\e[0;33m'
lightgray='\e[0;37m'
darkgray='\e[1;30m'
lightblue='\e[1;34m'
lightgreen='\e[1;32m'
lightcyan='\e[1;36m'
lightred='\e[1;31m'
lightpurple='\e[1;35m'
yellow='\e[1;33m'
white='\e[1;37m'
nc='\e[0m'

#Color table
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}

#Environments  
export EDITOR=vim
export PAGER=less


# prompt
PROMPT="#${fg_lgray}%n@${at_bold}%m${at_boldoff}${fg_dgray}[${fg_white}%~${fg_dgray}] #[${fg_white}%T${fg_dgray}]:${at_normal}"


# prompt
function prompt_git_dirty() 
{
gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')
	LD_LIBRARY_PATH=""awk

if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:$") > 0 ]]; then
	echo -n $fg_yellow
	elif [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\)$") > 0 ]]; then
	echo -n $fg_lred
	else
	echo -n $fg_pink
fi
}

function prompt_current_branch() 
{
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return 1
	echo ${ref#refs/heads/}
}

function prompt_hostname()
{
	case "`hostname`" in
		"Arch")
			echo -n "${fg_yellow}Arch${at_normal}";;    
		esac
}

function precmd() 
# Uses: setting user/root PROMPT1 variable and rehashing commands list
{
	# Last command status
	cmdstatus=$?
	sadface=`[ "$cmdstatus" != "0" ] && echo "${fg_red}:(${at_normal} "`

	# Colours
	usercolour=`[ $UID != 0 ]   && echo $fg_blue      	|| echo $fg_red`
	usercolour2=`[ $UID != 0 ]  && echo $fg_white 		|| echo $fg_red`
	dircolour=`[ -w "\`pwd\`" ] && echo $fg_lgray       || echo $fg_red`

	# Git branch
	git="[branch: `prompt_git_dirty``prompt_current_branch`${fg_blue}]"

	export PROMPT="	${usercolour}┌─[${dircolour}♨ %n${PR_NO_COLOR} ♨ `prompt_hostname`${usercolour}]${dircolour}[%~]${at_normal} `prompt_current_branch &>/dev/null && echo -n $git`
	${usercolour}└─${sadface}${usercolour}${dircolour}(%T)(%l)${usercolour} $HOST ─╼ ${at_normal}"                      
}              


#zmodload zsh/pcre

#{{{ Completion Stuff
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
bindkey -M viins '\C-i' complete-word
# Faster! (?)
zstyle ':completion::complete:*' use-cache 1
# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' \
	'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'
# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'
# Have the newer files last so I see them first
zstyle ':completion:*' file-sort modification reverse
# color code completion!!!!  Wohoo!
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
unsetopt LIST_AMBIGUOUS
setopt  COMPLETE_IN_WORD
# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true
# Egomaniac!
zstyle ':completion:*' list-separator 'fREW'
# complete with a menu for xwindow ids
zstyle ':completion:*:windows' menu on=0
zstyle ':completion:*:expand:*' tag-order all-expansions
# more errors allowed for large words and fewer for small words
zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
# Errors format
zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
# Don't complete stuff already on the line
zstyle ':completion::*:(rm|vi):*' ignore-line true
# Don't complete directory we are already in (../here)
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion::approximate*:*' prefix-needed false

#}}}




## FUNCTIONS
cdl() 
{
	builtin cd $@; ls 
}

# Easy extract
extract () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xvjf $1    ;;
			*.tar.gz)    tar xvzf $1    ;;
			*.bz2)       bunzip2 $1     ;;
			*.rar)       rar x $1       ;;
			*.gz)        gunzip $1      ;;
			*.tar)       tar xvf $1     ;;
			*.tbz2)      tar xvjf $1    ;;
			*.tgz)       tar xvzf $1    ;;
			*.zip)       unzip $1       ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1        ;;
			*)           echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

#Search All PDFs for text
search () {
	find . -name '*.pdf' -exec sh -c 'pdftotext "{}" - | grep --with-filename --label="{}" --color "'$1'"' \;
}



# Makes directory then moves into it
function mkcdr {
	mkdir -p -v $1
	cd $1
}

# Creates an archive from given directory
mktar() 
{ 
	tar cvf  "${1%%/}.tar"     "${1%%/}/"; 
}

mktgz() 
{ 
	tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; 
}

mktbz() 
{ 
	tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; 
}


upinfo ()
{
	echo -ne "\t ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}

# list files only
lf () 
{ 
	ls -1p $@ | grep -v '\/$' 
}


# define words with wordnet
ddefine () 
{ 
	curl dict://dict.org/d:${1}:wn; 
}


## Aliases

alias ls='ls --color=auto' # color is useful.
alias l='ls'  
alias ll='ls -alFh'  
alias la='ls -lAFh'   
alias lr='ls -tRFh'   
alias lt='ls -ltFh'   
alias rm='mv -t ~/Trash/'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -h -c'
alias reload='source ~/.zshrc'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'
alias remdir='"rm" -rf'
alias trashman='"rm" -rf ~/Trash/*'
alias zshrc="$EDITOR ~/.zshrc"
alias mountiso="sudo mount -t iso9660 -o loop"
alias blank="sleep 1 && xset dpms force off"
alias lesslast="less !:*"
alias mine="sudo chown root"
alias -g L="| less"
alias reboot='sudo reboot'

## changing dirs with just dots. 
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'
alias ....='cd ../../../../'

## MORE aliases that i use a lot.
alias top="sudo htop d 1"
alias ps="ps aux"
alias today='date "+%d %h %y"'
alias now='date "+%A, %d %B, %G%t%H:%M %Z(%z)"'
alias msgs='tail -f /var/log/messages'
alias nautilus='nautilus --no-desktop'
alias k=kill                     	# QUICKKEY - kill process
alias e=$EDITOR                  	# QUICKKEY - edit quickly
alias m=more                     	# QUICKKEY - yeah
alias q=exit                     	# QUICKKEY - like vim

## Debian/Debian-based.  

alias ainstall='sudo apt-get install'
alias aremove='sudo apt-get remove'
alias system_update='sudo apt-get update && sudo apt-get distupgrade'
alias afind='apt-cache search'
alias afupdate='sudo apt-file update'
alias aupdate='sudo apt-get update'
alias orphand='sudo deborphan | xargs sudo apt-get -y remove --purge'
alias cleanup='sudo apt-get autoclean && sudo apt-get autoremove && sudo apt-get clean && sudo apt-get remove && orphand'
alias updatedb='sudo updatedb'
alias lessswap="sudo sysctl vm.swappiness=10"
alias moreswap="sudo sysctl vm.swappiness=100"

## Archlinux

#alias aurinst='sudo yaourt -S'
#alias aurpkg='sudo pacman -U'
#alias pinstall='sudo pacman -S'
#alias premove='sudo pacman -R'
#alias system_update='sudo pacman -Syu'
#alias aurfind='sudo yaourt -Ss'
#alias pfind='sudo pacman -Ss'
#alias pinfo='sudo pacman -Si'
#alias installedby='sudo pacman -Ql'
#alias whatfrom='sudo pacman -Qo'
#alias showorphan='sudo pacman -Qdt'
#alias removeuseless='sudo pacman -Rsnc $(pacman -Qdqt)'
#alias pacupgrade='sh ~/.mirrorfix'
#alias giveswhat='sudo pkgfile --list'


## Keybinding Fixes
# Stops the damn tilde

bindkey "\e[1~" beginning-of-line 		# Home
bindkey "\e[4~" end-of-line 			# End
bindkey "\e[5~" beginning-of-history	# PageUp
bindkey "\e[6~" end-of-history 			# PageDown
bindkey "\e[2~" quoted-insert 			# Ins
bindkey "\e[3~" delete-char 			# Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete 	# Shift+Tab

# for rxvt
bindkey "\e[7~" beginning-of-line 	# Home
bindkey "\e[8~" end-of-line 		# End

# Incremental search is elite!
bindkey "^R" history-incremental-search-backward
bindkey "^F" history-incremental-search-forward

# it's like, space AND completion.  Gnarlbot.
bindkey -M viins ' ' magic-space

### 
#	Z-Shell Options Here
###

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt append_history 			# Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history 		# save timestamp of command and duration
setopt inc_append_history 		# Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first 	# when trimming history, lose oldest duplicates first
setopt hist_ignore_dups 		# Do not write events to history that are duplicates of previous events
setopt hist_ignore_space 		# remove command line from history list when first character on the line is a space
setopt hist_find_no_dups 		# When searching history don't display results already cycled through twice
setopt hist_reduce_blanks 		# Remove extra blanks from each command line being added to history
setopt hist_verify 				# don't execute, just expand history
setopt share_history 			# imports new commands and appends typed commands to history
setopt autocd extendedglob notify
setopt no_beep


#------------------------------------------////
# System Information:
#------------------------------------------////
clear
echo -ne "${blue}Today is:\t\t${lightgreen}" `date`; echo ""
echo -e "${blue}Kernel Information: \t${cyan}" `uname -smr`
echo -ne "${purple}";upinfo;echo ""
echo -e "${blue}"; cal -3
