# Aliases
alias lsdir='ls -ld -- */'																																			# List folders
alias lsall='ls -ldfh -- */ && ls -lafh | grep -v "^d"'																					# List folders and files separetly
alias folder='find . -type f -exec ls -l {} \; | awk '\''{sum += $5} END {print sum}'\'''				# folder size
alias up1='cd ..;lsdir'																																					# up one dir
alias wwatch='webpack --progress --colors --watch'																							# Start Webpack Watch
alias gitwho='git ls-tree -r master --name-only'																								# List files tracked by Git 
alias mem='top -l 1 | grep -E "^CPU|^Phys"'																											# system memory usage
alias ranger='ranger --choosedir=$HOME/rangerdir; LASTDIR=`cat $HOME/rangerdir`; cd "$LASTDIR"'	# Quit Ranger to selected folder
alias usdo='sudo "$@"'																																					# Fat fingers' sudo fix

function up {
    cd `expr "$PWD" : "^\(.*$1[^/]*\)"`
}
