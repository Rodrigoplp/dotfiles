export ZSH="/Users/rp-office/.oh-my-zsh"

ZSH_THEME="rpinto"
zle_highlight+=(paste:none)
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export EDITOR=/usr/local/bin/vim
export VISUAL=/usr/local/bin/vim
export PAGER='less'
export PATH=/bin:/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/mongodb@3.6/bin:$PATH

# Aliases
alias lsdir='ls -ld -- */'																																			# List folders
alias lsall='ls -ldfh -- */ && ls -lafh | grep -v "^d"'																					# List folders and files separately
alias lsf='ls -lahp | grep -v /'																																# list only files
alias changelog='github-changes -o reol -r edge_ios -a --title "Leadkit iOS CHANGELOG"'					# REOL build
alias scripts='cd /Users/rodrigopinto/Documents/Development/Scripts'														# Script directory
alias folder='find . -type f -exec ls -l {} \; | awk '\''{sum += $5} END {print sum}'\'''				# folder size
alias dev="cd /Users/rodrigopinto/Documents/Development"
alias home='cd ~/Documents/mfind-backend'
alias wiki="cd /Users/rodrigopinto/Documents/Development/iPhone\ projects/Tnk_Wiki"							# TnK wiki
alias site="cd /Users/rodrigopinto/Documents/Development/iPhone\ projects/KidsOnTube_site"			# TnK site
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
alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim

function up {
    cd `expr "$PWD" : "^\(.*$1[^/]*\)"`
}

# Fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore --hidden --follow --glob "!{.git,node_modules}/*"'
