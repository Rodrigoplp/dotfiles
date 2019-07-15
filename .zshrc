# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="rpinto"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "miloshadzic" "wezm" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Editors
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
alias home='cd ~/Documents/Office'
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
alias ts='vim -c "set spell" "+normal zajjzajjzOj" ~/iCloud/Documents/timesheet.md'
alias vim=/usr/local/bin/vim
alias vi=/usr/local/bin/vim

# Fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore --hidden --follow --glob "!{.git,node_modules}/*"'
