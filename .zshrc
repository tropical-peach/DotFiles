plugins=(git)

# prompt
PROMPT="#${fg_lgray}%n@${at_bold}%m${at_boldoff}${fg_dgray}[${fg_white}%~${fg_dgray}] #[${fg_white}%T${fg_dgray}]:${at_normal}"

if [ -d ~/bin/shell ]; then
		cd ~/bin/shell
		for i in $(ls -1); do
						source $i
		done
		cd ~
		unset i
fi

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
setopt EXTENDED_HISTORY
setopt append_history 			# Allow multiple terminal sessions to all append to one zsh command history
setopt extended_history 		# save timestamp of command and duration
setopt inc_append_history 	# Add comamnds as they are typed, don't wait until shell exit
setopt hist_expire_dups_first 	# when trimming history, lose oldest duplicates first
setopt hist_ignore_dups 		# Do not write events to history that are duplicates of previous events
setopt hist_ignore_space 		# remove command line from history list when first character on the line is a space
setopt hist_find_no_dups 		# When searching history don't display results already cycled through twice
setopt hist_reduce_blanks 	# Remove extra blanks from each command line being added to history
setopt hist_verify 					# don't execute, just expand history
setopt share_history 				# imports new commands and appends typed commands to history
setopt autocd extendedglob notify
setopt no_beep



