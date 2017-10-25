set nocompatible              " be iMproved, required
filetype off                  " required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'enricobacis/vim-airline-clock'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vimwiki/vimwiki'
" Plugin 'pangloss/vim-javascript'
" Plugin 'mxw/vim-jsx'

call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype indent plugin on
set hidden
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
"set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set noruler
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" 'press <Enter> to continue'
set cmdheight=1
set laststatus=2

" Vimwiki (https://github.com/vimwiki/vimwiki)
set nocompatible
filetype plugin on
syntax on
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
 
" Vim-instant-markdown (https://github.com/suan/vim-instant-markdown)
let g:instant_markdown_autostart = 0

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='monochrome'
set t_Co=256

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.space = "\ua0"

" Airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Airline sections
function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode'])
	let g:airline_section_x = airline#section#create(['%P'])
	let g:airline_section_y = 'Col %c'
	let g:airline_section_z = '%L lines'
	let g:airline_section_error = airline#section#create([])
	let g:airline_section_warning = airline#section#create([])
endfunction
autocmd VimEnter * call AirlineInit()

" Airline clock settings
let g:airline#extensions#clock#format = '%b %d, %H:%M'

" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Relative number lines
set relativenumber
 
" Trying to hide tildes
highlight EndOfBuffer ctermfg=green

" Spell check
set spell
highlight clear SpellBad
highlight SpellBad cterm=underline ctermfg=yellow
highlight SpellCap cterm=underline ctermfg=81 ctermbg=NONE
highlight Comment ctermfg=yellow
highlight Statement ctermfg=white

" Yank to clipboard
set clipboard=unnamed

" NerdTree like setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 15

set tabstop=2
set shiftwidth=2

" Set space as character in split separator
set fillchars+=vert:\ 
highlight VertSplit ctermfg=black
highlight Folded ctermfg=12
set splitbelow
set splitright

" Enable folding
set foldmethod=manual
set foldcolumn=1
highlight Folded ctermbg=NONE
highlight FoldColumn ctermbg=NONE
let g:markdown_folding = 1
let g:markdown_enable_folding = 1

function MarkdownLevel() 
	let h = matchstr(getline(v:lnum), '^#\+') 
	if empty(h) 
		return "=" 
	else 
		return ">" . len(h) 
	endif 
endfunction
au BufEnter *.md setlocal foldexpr=MarkdownLevel()
au BufEnter *.md setlocal foldmethod=expr


" Language dependent configurations

" Python
autocmd BufNewFile,BufRead *.py set tabstop=4
autocmd BufNewFile,BufRead *.py set softtabstop=4
autocmd BufNewFile,BufRead *.py set shiftwidth=4
autocmd BufNewFile,BufRead *.py set textwidth=139
autocmd BufNewFile,BufRead *.py set expandtab
autocmd BufNewFile,BufRead *.py set autoindent
autocmd BufNewFile,BufRead *.py set fileformat=unix

" Javascript, HTML and CSS
autocmd BufNewFile,BufRead *.js set tabstop=2
autocmd BufNewFile,BufRead *.js set softtabstop=2
autocmd BufNewFile,BufRead *.js set shiftwidth=2

autocmd BufNewFile,BufRead *.html set tabstop=2
autocmd BufNewFile,BufRead *.html set softtabstop=2
autocmd BufNewFile,BufRead *.html set shiftwidth=2

autocmd BufNewFile,BufRead *.css set tabstop=2
autocmd BufNewFile,BufRead *.css set softtabstop=2
autocmd BufNewFile,BufRead *.css set shiftwidth=2

" JSON
com! Json %!python -m json.tool

" XML
autocmd BufNewFile,BufRead *.xml set tabstop=2
autocmd BufNewFile,BufRead *.xml set softtabstop=2
autocmd BufNewFile,BufRead *.xml set shiftwidth=2

"------------------------------------------------------------
" Mappings
"
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
nmap Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

nmap - :Explore<Enter>
nmap < <C-B>
nmap > <C-F>
nnoremap <space> za
nmap =j :%!python -m json.tool<CR>
nmap \f :!ranger<CR>
map <leader>md :InstantMarkdownPreview<CR>

" Deleting does not replace clipboard
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
