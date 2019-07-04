export PATH=/bin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/local/opt/mongodb@3.6/bin:$PATH

# Colors
export CLICOLOR=1
export LSCOLORS='exfxcxdxbxexexaxaxaxex'
export TERM="xterm-color"
export PS1='\[\e[0;34m\]\u\[\e[0m\]@\[\e[0;34m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '

# Aliases
alias lsdir='ls -ld -- */'																																			# List folders
alias lsall='ls -ldfh -- */ && ls -lafh | grep -v "^d"'																					# List folders and files separately
alias lsf='ls -lahp | grep -v /'																																# list only files
alias changelog='github-changes -o reol -r edge_ios -a --title "Leadkit iOS CHANGELOG"'					# REOL build
alias scripts='cd /Users/rodrigopinto/Documents/Development/Scripts'														# Script directory
alias folder='find . -type f -exec ls -l {} \; | awk '\''{sum += $5} END {print sum}'\'''				# folder size
alias dev="cd /Users/rodrigopinto/Documents/Development"
alias home='cd /Users/rodrigopinto/Documents/Office'
alias wiki="cd /Users/rodrigopinto/Documents/Development/iPhone\ projects/Tnk_Wiki"							# TnK wiki
alias site="cd /Users/rodrigopinto/Documents/Development/iPhone\ projects/KidsOnTube_site"			# TnK site
alias indie='cd /Users/rodrigopinto/Documents/Office/Entreprise/IndieHackers'
alias joinpdf="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py --output all.pdf *.pdf"	# join PDFs into one file
alias hour='say it is now `date "+%H:%M"`'
alias up1='cd ..;lsdir'																																					# up one dir
alias gitwho='git ls-tree -r master --name-only'																								# List files tracked by Git 
alias mem='top -l 1 | grep -E "^CPU|^Phys"'																											# system memory usage
alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'	# Quit Ranger to selected folder
alias usdo='sudo "$@"'																																					# Fat fingers sudo fix
alias mutt='neomutt'
alias clock='tty-clock -scC 3'
alias tree='tree -I node_modules --dirsfirst'
alias ts='vim -c "set spell" "+normal zajjzajjzOj" /Users/rodrigopinto/Documents/Office/timesheet.md'

function up {
    cd `expr "$PWD" : "^\(.*$1[^/]*\)"`
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
