# Restore defaults
emulate -LR zsh

setopt NO_CASE_GLOB # Be case insensitive when completing


### History
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000 # History size across all sessions
HISTSIZE=2000 # History size in the current session 
setopt EXTENDED_HISTORY # Add epoch time next to the values of history
setopt SHARE_HISTORY # share history across multiple zsh sessions
setopt APPEND_HISTORY # Append to history
setopt INC_APPEND_HISTORY # Adds commands as they are typed, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first
setopt HIST_IGNORE_DUPS # do not store duplications
setopt HIST_FIND_NO_DUPS #ignore duplicates when searching
setopt HIST_REDUCE_BLANKS # removes blank lines from history

### Auto correction
# setopt CORRECT
# setopt CORRECT_ALL

### COMPLETION
autoload -Uz compinit && compinit

setopt COMPLETE_ALIASES

# Load specific files
. ~/.dotFiles/profile/alias
. ~/.dotFiles/profile/alias.zshrc
. ~/.keys


if [[ $os = "Darwin" || $os = "Linux" ]]; then
	# Set access to root
	alias su="sudo su"
fi

PATH=~/.dotFiles/profile/bin:$PATH
PATH=/usr/local/bin:$PATH
PATH=/opt/homebrew/bin:$PATH
PATH=/usr/local/sbin:$PATH

if (($+commands[go])); then
	export GOPATH=${HOME}/Dev/Go
	PATH=$PATH:${GOPATH}/bin
fi

_ARCH=$(arch)
PROMPT="$_ARCH $PROMPT"
# Requires iterm2
if [[ "$_ARCH" == "i386" ]]; then
 echo -ne "\033]1337;SetColors=bg=1d2b2e\007"
 export PATH="/usr/local/homebrew/bin:$PATH"
 export PATH="/usr/local/homebrew/opt:$PATH"
else
 export PATH="/opt/homebrew/bin:$PATH"
 export PATH="/opt/homebrew/opt:$PATH"
fi

export PATH

if (($+commands[rbenv])); then
  eval "$(rbenv init -)"
fi

if (($+commands[nodenv])); then
  eval "$(nodenv init -)"
fi

autoload -Uz vcs_info

setopt PROMPT_SUBST
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn
zstyle ':vcs_info:git:*' formats '(%b)'

# Start Prompt
PROMPT="["

# User@host: directory
PROMPT="${PROMPT}%F{red}%n%f@%F{green}%M%f %F{blue}%~%f"

vcs_info_wrapper() {
	vcs_info
	if [ -n "$vcs_info_msg_0_" ]; then
		echo " %{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	fi
}

PROMPT=$PROMPT'%F{yellow}$(vcs_info_wrapper)%f'

# End Prompt
PROMPT="${PROMPT}]$ "

# Output of grep contains colors
export GREP_OPTIONS='--color=auto' GREP_COLOR='33'

# Use vim as default pager
export MANPAGER="/bin/sh -c \"col -b | vim -c 'nnoremap <space> <C-F>| nnoremap q :q<cr>| set ft=man ts=8 nomod nolist nonu noma' -\""

# Set vim as default editor
export EDITOR=vim

# VI style editing in BASH
set -o vi

export CLICOLOR=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.kubectl.zsh ] && source ~/.kubectl.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# ssh-add --apple-use-keychain ~/.ssh/id_ed25519.sign 2>/dev/null


# export AWS_PROFILE=dev
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
