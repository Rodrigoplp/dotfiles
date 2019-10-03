export ZSH="/Users/rodrigopinto/.oh-my-zsh"

ZSH_THEME="rpinto"
zle_highlight+=(paste:none)
COMPLETION_WAITING_DOTS="true"
plugins=(
  git
  zsh-nvm
)
source $ZSH/oh-my-zsh.sh
export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim
export PAGER='less -MR'
export LESS='MR'
export PATH=/bin:/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/mongodb@3.6/bin:$PATH
export RIPGREP_CONFIG_PATH=$HOME/.rgrc

# Aliases
alias lsdir='ls -ld -- */'																																			# List folders
alias lsall='ls -ldfh -- */ && ls -lafh | grep -v "^d"'																					# List folders and files separately
alias lsf='ls -lahp | grep -v /'																																# list only files
alias changelog='github-changes -o reol -r edge_ios -a --title "Leadkit iOS CHANGELOG"'					# REOL build
alias scripts='cd ~/Documents/Development/Scripts'
alias folder='find . -type f -exec ls -l {} \; | awk '\''{sum += $5} END {print sum}'\'''				# folder size
alias dev="cd ~/Documents/Development"
alias office='cd ~/Documents/Office'
alias home='cd ~/Documents/Development/Rodrigoplp'
alias tempo='cd ~/Documents/Office/Interview/Tempo/tempo-app'
alias wiki='cd ~/Documents/Development/iPhone\ projects/Tnk_Wiki'
alias site="cd ~/Documents/Development/iPhone\ projects/KidsOnTube_site"
alias joinpdf="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py --output all.pdf *.pdf"	# join PDFs into one file
alias hour='say it is now `date "+%H:%M"`'
alias up1='cd ..;lsdir'																																					# up one dir
alias gitwho='git ls-tree -r master --name-only'																								# List files tracked by Git
alias mem='top -l 1 | grep -E "^CPU|^Phys"'																											# system memory usage
alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'	# Quit Ranger to selected folder
alias usdo='sudo "$@"'																																					# Fat fingers sudo fix
alias mutt='neomutt'
alias clock='tty-clock -scC 3'
alias tree='tree -C -I node_modules --dirsfirst'
alias ts='vim -c "set spell" "+normal zajjzajjzOj" ~/iCloud/Documents/timesheet.md'
alias hustle='vim -c "set spell" ~/iCloud/Documents/hustle.md'

# Override bin
alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim
alias vimdiff=/usr/local/bin/vimdiff
alias git=/usr/local/bin/git

function up {
    cd `expr "$PWD" : "^\(.*$1[^/]*\)"`
}

# Fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore-case --hidden --follow --glob "!{.git,node_modules}/*"'

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# iTerm shell integration
source ~/.iterm2_shell_integration.zsh

# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
profile() { echo -e "\033]50;SetProfile=$1\a" }
