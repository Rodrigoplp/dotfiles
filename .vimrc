set nocompatible              " be iMproved, required
filetype off									" required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tmhedberg/SimpylFold'
Plugin 'pangloss/vim-javascript'
Plugin 'chemzqm/vim-jsx-improve'
Plugin 'kballard/vim-swift'

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
 
" Do not show intro message when opening Vim. Add 'I' to default.
set shortmess+=I

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <HTTP://www.vim.org/scripts/script.php?script_id=1876>.
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
" While this behavior deviates from that of Vi, it does what most users
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

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//
if exists("&undodir")
  set undodir=~/.vim/undo//
endif

" Insert skeleton of timesheet text
function! Timesheet()
	call append(line('.'), "")
	call append(line('.'), "- 16:30 - 18:30 [2:00]")
	call append(line('.'), "- 13:30 - 16:30 [3:00]")
	call append(line('.'), "- 09:30 - 12:30 [3:00]")
	call append(line('.'), "")
	call append(line('.'), "### " . strftime("%Y-%m-%d %a"))
endfunction
nmap <F2> :call Timesheet()<CR>

" Vim-instant-markdown (https://github.com/suan/vim-instant-markdown)
let g:instant_markdown_autostart = 0

syntax on
set t_Co=256
set background=light

" Status bar
hi User1 ctermbg=none ctermfg=gray
hi User2 ctermbg=none ctermfg=gray
hi User3 ctermbg=none ctermfg=gray
hi User4 ctermbg=none ctermfg=gray
hi User5 ctermbg=none ctermfg=white

function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		hi User1 ctermbg=37 ctermfg=black
		hi User2 ctermbg=44 ctermfg=37
		hi User3 ctermbg=44 ctermfg=white
		hi User4 ctermbg=none ctermfg=44			" Use ctermbg=51 for a brighter version
		hi User5 ctermbg=none ctermfg=51			" Use ctermbg=51 for a brighter version
	elseif a:mode == 'r'
		hi User5 ctermbg=none ctermfg=240
	elseif a:mode == 'v'
		hi User5 ctermbg=none ctermfg=240
	else
		hi User5 ctermbg=red ctermfg=240
	endif
endfunction

function! ModeName(mode)
	if a:mode == 'i'
		return 'Insert'
	elseif a:mode == 'v'
		hi User1 ctermbg=202 ctermfg=blue
		hi User2 ctermbg=215 ctermfg=202
		hi User3 ctermbg=215 ctermfg=white
		hi User4 ctermbg=none ctermfg=215
		hi User5 ctermbg=none ctermfg=202
		redrawstatus
		return 'Visual'
	else
		hi User1 ctermbg=none ctermfg=gray
		hi User2 ctermbg=none ctermfg=gray
		hi User3 ctermbg=none ctermfg=gray
		hi User4 ctermbg=none ctermfg=gray
		hi User5 ctermbg=none ctermfg=white
		redrawstatus
		return 'Normal'
	endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi User1 ctermbg=none ctermfg=gray
au InsertLeave * hi User2 ctermbg=none ctermfg=gray
au InsertLeave * hi User3 ctermbg=none ctermfg=gray
au InsertLeave * hi User4 ctermbg=none ctermfg=gray
au InsertLeave * hi User5 ctermbg=none ctermfg=240

function! ActiveStatus()
	let statusline=""
	let statusline.="%1*"
	let statusline.="\ %{ModeName(mode())}\ "
	let statusline.="%2*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%3*"
	let statusline.="\ %{fugitive#head()!=''?'\ '.fugitive#head().'\ ':'[not versd]\ '}"
	let statusline.="%4*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%5*"
	let statusline.="\ %.90F\ "
	let statusline.="%{&readonly?'\ \ ':''}"
	let statusline.="%="
	let statusline.="\ %{''!=#&filetype?&filetype:'none'}\ "
	let statusline.="%4*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%3*"
	let statusline.="\ %v|%l/%L\ "			" Column number | Row number / total lines
	let statusline.="%2*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%1*"
	let statusline.="\ %{strftime('%a %b-%d %H:%M')}\ "			" Date time clock updated on key presses

	return statusline
endfunction

set statusline=%!ActiveStatus()

" Auto-update status bar every 4 seconds
let timer = timer_start(4000, 'UpdateStatusBar',{'repeat':-1})
function! UpdateStatusBar(timer)
  execute 'let &ro = &ro'
endfunction

" hi User1 ctermbg=none ctermfg=gray
" hi User2 ctermbg=none ctermfg=gray
" hi User3 ctermbg=none ctermfg=gray
" hi User4 ctermbg=none ctermfg=white
" 
" function! InsertStatuslineColor(mode)
" 	if a:mode == 'i'
" 		hi User1 ctermbg=51 ctermfg=blue
" 		hi User2 ctermbg=51 ctermfg=blue
" 		hi User3 ctermbg=none ctermfg=51
" 		hi User4 ctermbg=none ctermfg=51
" 	elseif a:mode == 'r'
" 		hi User1 ctermbg=none ctermfg=gray
" 		hi User2 ctermbg=none ctermfg=gray
" 		hi User3 ctermbg=none ctermfg=black
" 		hi User4 ctermbg=none ctermfg=black
" 	elseif a:mode == 'v'
" 		hi User1 ctermbg=none ctermfg=gray
" 		hi User2 ctermbg=none ctermfg=gray
" 		hi User3 ctermbg=none ctermfg=black
" 		hi User4 ctermbg=none ctermfg=black
" 	else
" 		hi User1 ctermbg=none ctermfg=gray
" 		hi User2 ctermbg=none ctermfg=gray
" 		hi User3 ctermbg=none ctermfg=black
" 		hi User4 ctermbg=none ctermfg=black
" 	endif
" endfunction
" 
" function! ModeName(mode)
" 	if a:mode == 'i'
" 		return 'Insert'
" 	elseif a:mode == 'v'
" 		hi User1 ctermbg=202 ctermfg=blue
" 		hi User2 ctermbg=202 ctermfg=blue
" 		hi User3 ctermbg=none ctermfg=202
" 		hi User4 ctermbg=none ctermfg=202
" 		redrawstatus
" 		return 'Visual'
" 	else
" 		hi User1 ctermbg=none ctermfg=gray
" 		hi User2 ctermbg=none ctermfg=gray
" 		hi User3 ctermbg=none ctermfg=gray
" 		hi User4 ctermbg=none ctermfg=white
" 		redrawstatus
" 		return 'Normal'
" 	endif
" endfunction
" 
" au InsertEnter * call InsertStatuslineColor(v:insertmode)
" au InsertLeave * hi User1 ctermbg=none ctermfg=gray
" au InsertLeave * hi User2 ctermbg=none ctermfg=gray
" au InsertLeave * hi User3 ctermbg=none ctermfg=white
" au InsertLeave * hi User4 ctermbg=none ctermfg=white
" 
" function! ActiveStatus()
"   let statusline=""
"   let statusline.="%1*"
" 	let statusline.="\ %{ModeName(mode())}\ "
"   let statusline.="%2*"
" 	let statusline.=""
" 	let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':'\ [not versd]\ '}"
"   let statusline.="%3*"
"   let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
" 	let statusline.="%4*"
"   let statusline.="\ %.100F"
"   let statusline.="%{&readonly?'\ \ ':''}"
"   let statusline.="%="
"   let statusline.="\ %{''!=#&filetype?&filetype:'none'}\ "
"   let statusline.="%3*"
"   let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
" 	let statusline.="%2*"
"   let statusline.="\ %v|%l/%L"					" Column number | Row number / total lines
" 	let statusline.="%1*"
" 	let statusline.="\ \ %{strftime('%a %b-%d %H:%M')}\ "			" Date time clock
" 
"   return statusline
" endfunction
" 
" set statusline=%!ActiveStatus()

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

" Limit characters of line in Markdown files
" highlight ColorColumn ctermbg=black
" au BufRead,BufNewFile *.md setlocal colorcolumn=80

" Spell check
set spell
highlight clear SpellBad
hi SpellBad cterm=underline ctermbg=none ctermfg=LightRed
hi SpellLocal cterm=underline ctermbg=none ctermfg=LightRed
set spelllang=en_us		" spelllang=en_us,fr

" Change cursor per mode
let &t_EI = "\<Esc>]50;CursorShape=2\x7"	" Normal mode: underline
let &t_SI = "\<Esc>]50;CursorShape=1\x7"	" Insert mode: vertical line
let &t_SR = "\<Esc>]50;CursorShape=0\x7"	" Replace mode: block

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

" Folding in txt files
function! NeatFoldText()
	setlocal foldmethod=expr
	setlocal foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
	set foldtext=getline(v:foldstart)
endfunction

autocmd BufNewFile,BufRead *.txt set foldmethod=indent
autocmd BufNewFile,BufRead *.txt set foldtext=NeatFoldText()

" Hide duplicate -- INSERT -- warning
set noshowmode

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
autocmd BufNewFile,BufRead *.html hi error ctermbg=none ctermfg=gray

autocmd BufNewFile,BufRead *.css set tabstop=2
autocmd BufNewFile,BufRead *.css set softtabstop=2
autocmd BufNewFile,BufRead *.css set shiftwidth=2

" JSON
com! Json %!python -m json.tool
autocmd BufNewFile,BufRead *.json set fdm=syntax        " Change folding rule
autocmd BufNewFile,BufRead *.json set nospell
autocmd BufNewFile,BufRead *.json hi constant ctermfg=gray
autocmd BufNewFile,BufRead *.json hi error ctermbg=none

" XML
autocmd BufNewFile,BufRead *.xml set tabstop=2
autocmd BufNewFile,BufRead *.xml set softtabstop=2
autocmd BufNewFile,BufRead *.xml set shiftwidth=2

" Markdown
hi htmlItalic ctermfg=grey ctermbg=none cterm=none

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
cmap W w
cmap Q q

" Automatically closing braces
inoremap {<CR> {<CR>}<Esc>ko<tab>
inoremap [<CR> [<CR>]<Esc>ko<tab>
inoremap (<CR> (<CR>)<Esc>ko<tab>

" Comment line
map ( I// <Esc>
map ) ^3x

" Deleting does not replace clipboard
" nnoremap d "_d
" vnoremap d "_d
" nnoremap D "_D
" vnoremap D "_D

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
