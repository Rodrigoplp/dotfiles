export PATH=/bin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:$PATH

# Colors
export CLICOLOR=1
export LSCOLORS='exfxcxdxbxexexaxaxaxex'
export TERM="xterm-color"
export PS1='\[\e[0;34m\]\u\[\e[0m\]@\[\e[0;34m\]\h\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]\$ '

# Aliases
alias lsdir='ls -ld -- */'																																	# List folders
alias changelog='github-changes -o reol -r edge_ios -a --title "Leadkit iOS CHANGELOG"'			# REOL build
alias jira='cd /Users/rodrigopinto/Documents/Office/REOL\ Services/tmp'											# runs jira.sh
alias folder='find . -type f -exec ls -l {} \; | awk '\''{sum += $5} END {print sum}'\'''		# folder size
alias home="cd /Users/rodrigopinto/Documents/Development/iPhone\ projects/KidsOnTube_site"	# go to iPhone folder
alias joinpdf="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py --output all.pdf *.pdf"	# join PDFs into one file
alias hour='say `date "+%H:%M"`'																														# say local time
alias up1='cd ..;lsdir'																																			# up one dir
alias wwatch='webpack --progress --colors --watch'																					# Start Webpack Watch
alias gitwho='git ls-tree -r master --name-only'																						# List files tracked by Git 
alias mem='top -l 1 | grep -E "^CPU|^Phys"'																									# system memory usage

function up {
    cd `expr "$PWD" : "^\(.*$1[^/]*\)"`
}

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
