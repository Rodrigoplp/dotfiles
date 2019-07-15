set nocompatible              " be iMproved, required
filetype off									" required

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tmhedberg/SimpylFold'
Plugin 'elzr/vim-json'
Plugin 'pangloss/vim-javascript'
Plugin 'chemzqm/vim-jsx-improve'
Plugin 'kballard/vim-swift'
Plugin 'posva/vim-vue'
Plugin 'atelierbram/Base2Tone-vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/fzf.vim'

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
set omnifunc=syntaxcomplete#Complete
set hidden

" Fuzzy finder
set rtp+=/usr/local/opt/fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --ignore --hidden --follow --glob "!{.git,node_modules}/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd

" Make Shift + arrow behave as selector instead of page jumper
"if exists('$TMUX')
	nmap <S-Up> v<Up>
	nmap <S-Down> v<Down>
	nmap <S-Left> v<Left>
	nmap <S-Right> v<Right>
	vmap <S-Up> <Up>
	vmap <S-Down> <Down>
	vmap <S-Left> <Left>
	vmap <S-Right> <Right>
	imap <S-Up> <Esc>v<Up>
	imap <S-Down> <Esc>v<Down>
	imap <S-Left> <Esc>v<Left>
	imap <S-Right> <Esc>v<Right>
"else
"	set keymodel=startsel,stopsel
"endif

" Also mapping ctrl-c, ctrl-v, ctrl-x and ctrl-z
vmap <C-c> y<Esc>
vmap <C-x> d<Esc>
inoremap <C-z> <C-G>u<Esc>[s1z=`]a<C-G>u
nnoremap <C-z> <nop>			" Disable the standard behaviour of minimizing vim

" Ranger as file explorer
function RangerExplorer()
	exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . system('echo "' . expand("%:p:h") . '" | sed -E "s/\ /\\\ /g"')
	if filereadable('/tmp/vim_ranger_current_file')
		exec 'edit ' . system('cat /tmp/vim_ranger_current_file | sed -E "s/\ /\\\ /g"')
		call system('rm /tmp/vim_ranger_current_file')
	endif
	redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>

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
 
" Silence both sound and visual bell
set vb t_vb=
 
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
	call append(line('.'), "- 22:00 - 00:00 [2:00]")
	call append(line('.'), "- 13:00 - 17:30 [4:30]")
	call append(line('.'), "- 09:00 - 12:30 [3:30]")
	call append(line('.'), "")
	call append(line('.'), "#### " . strftime("%Y-%m-%d %a"))
endfunction
nmap <F12> :call Timesheet()<CR>

" Vim-instant-markdown (https://github.com/suan/vim-instant-markdown)
let g:instant_markdown_autostart = 0

syntax on
set t_Co=256
set background=light
colorscheme Base2Tone_ForestDark
hi LineNr ctermfg=grey
hi CursorLine ctermbg=none
hi CursorLineNr ctermbg=none ctermfg=darkblue
hi Comment ctermfg=blue
hi Folded ctermfg=blue
hi EndOfBuffer ctermfg=gray
hi Search cterm=NONE ctermbg=NONE ctermfg=Red

" YouCompleteMe options
let g:ycm_autoclose_preview_window_after_completion = 1

" Status bar
function! InsertStatuslineColor(mode)
	if a:mode == 'i'
		hi User1 ctermbg=37 ctermfg=black
		hi User2 ctermbg=44 ctermfg=37
		hi User3 ctermbg=44 ctermfg=white
		hi User4 ctermbg=none ctermfg=44
		hi User5 ctermbg=none ctermfg=51
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
		return 'I'
	elseif a:mode == 'v'
		hi User1 ctermbg=202 ctermfg=blue
		hi User2 ctermbg=215 ctermfg=202
		hi User3 ctermbg=215 ctermfg=white
		hi User4 ctermbg=none ctermfg=215
		hi User5 ctermbg=none ctermfg=202
		redrawstatus
	return 'V'
	else
		hi User1 ctermbg=none ctermfg=33
		hi User2 ctermbg=none ctermfg=33
		hi User3 ctermbg=none ctermfg=33
		hi User4 ctermbg=none ctermfg=33
		hi User5 ctermbg=none ctermfg=232
		redrawstatus
		return 'N'
	endif
endfunction

au InsertEnter * call InsertStatuslineColor(v:insertmode)

function! ActiveStatus()
	let statusline=""
	let statusline.="%1*"
	let statusline.="\ %{ModeName(mode())}\ "
	let statusline.="%2*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%3*"
	let statusline.="\ %{fugitive#head()!=''?'\ '.fugitive#head().'\ ':'\ [not versd]\ '}"
	let statusline.="%4*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%5*"
	let statusline.="\ [%n/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]"
	let statusline.="\ %.90F\ %m\ "
	let statusline.="%{&readonly?'\ \ ':''}"
	let statusline.="%="
	let statusline.="\ %{''!=#&filetype?&filetype:'none'}\ "
	let statusline.="%4*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%3*"
	let statusline.="\ %{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'} %vC|%l/%LL\ %p%%\ "            " Column number | Row number / total lines
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

" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>

" Relative number lines
set relativenumber
 
" Limit characters of line in Markdown files
" highlight ColorColumn ctermbg=black
" au BufRead,BufNewFile *.md setlocal colorcolumn=80

" Spell check
" set spell
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
hi VertSplit ctermfg=black
set splitbelow
set splitright

" Enable folding
set foldmethod=manual
set foldcolumn=1
hi Folded ctermbg=NONE
hi FoldColumn ctermbg=NONE
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

" Folding js and jsx
function JsLevel() 
	let h = matchstr(getline(v:lnum), '// MARK:') 
	let h2 = matchstr(getline(v:lnum), '// MARK: -') 
	if empty(h) 
		return "=" 
	elseif empty(h2) 
		return ">1"
	else
		return ">2"
	endif

endfunction
au BufEnter *.js setlocal foldexpr=JsLevel()
au BufEnter *.js setlocal foldmethod=expr
au BufEnter *.jsx setlocal foldexpr=JsLevel()
au BufEnter *.jsx setlocal foldmethod=expr

" Folding txt
function! NeatFoldText()
	setlocal foldmethod=expr
	setlocal foldexpr=(getline(v:lnum)=~'^$')?-1:((indent(v:lnum)<indent(v:lnum+1))?('>'.indent(v:lnum+1)):indent(v:lnum))
	set foldtext=getline(v:foldstart)
endfunction

autocmd BufNewFile,BufRead *.txt set foldmethod=indent
autocmd BufNewFile,BufRead *.txt set foldtext=NeatFoldText()

" Folding CSS
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

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
autocmd BufNewFile,BufRead *.html set filetype=htmlm4

autocmd BufNewFile,BufRead *.css set tabstop=2
autocmd BufNewFile,BufRead *.css set softtabstop=2
autocmd BufNewFile,BufRead *.css set shiftwidth=2

" JSON
com! Json %!python -m json.tool
autocmd BufNewFile,BufRead *.json set tabstop=2
autocmd BufNewFile,BufRead *.json set softtabstop=2
autocmd BufNewFile,BufRead *.json set shiftwidth=2
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

" Map <C-L> (redraw screen) to also turn off search highlighting until the next search
nnoremap <C-L> :nohl<CR><C-L>
nmap < <C-B>																"Page up
nmap > <C-F>																"Page down
nnoremap - :call smooth_scroll#up(&scroll*2, 10, 4)<CR>						"Page up
nnoremap <space> :call smooth_scroll#down(&scroll*2, 10, 4)<CR>		"Page down
nmap =j :%!python -c "import json, sys; print json.dumps(json.load(sys.stdin), indent=2)"<CR>
nmap \f :!ranger<CR>
map <leader>md :InstantMarkdownPreview<CR>
cmap W w
cmap Q q
map 0 :call LineHome()<CR>
inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
nmap J <nop>						" Avoid joining lines when hitting caps lock by mistake
nmap K <nop>						" Avoid opening help when hitting caps lock by mistake

" First character of line or beginning of line
function! LineHome()
	let x = col('.')
	execute "normal ^"
	if x == col('.')
		unmap 0
		execute "normal 0"
		map 0 :call LineHome()<CR>:echo<CR>
	endif
	return ""
endfunction

" Automatic closures
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
inoremap { {}<Esc>i
inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap " ""<Esc>i
"autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	let list = ['=', '{', '[', '(', '<', '+', '-']

	if col == 1
		return a:char.a:char."\<Esc>i"
	endif

	for item in list
		if line[col - 2] == item
			return a:char.a:char."\<Esc>i"
		endif
	endfor

	if line[col - 2] == "\<Space>"
		return a:char.a:char."\<Esc>i"
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		return a:char
	endif
endf

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Moving multiple lines
xnoremap [e :m-2<CR>gv=gv         " Move lines up, visual mode
xnoremap ]e :m'>+<CR>gv=gv        " Move lines down, visual mode
nnoremap [e :<C-u>m-2<CR>==       " Move lines up, normal mode
nnoremap ]e :<C-u>m+<CR>==        " Move lines down, normal mode

" Navigate buffers
nnoremap <Leader>bb :ls<CR>:b
nnoremap <Leader>bp :bp<CR>								" Previous buffer
nnoremap <Leader>bn :bn<CR>								" Next buffer

" Don't quit vim if there is more than one buffer opened
ca q :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1))<Bar>exe 'q'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>
ca wq :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1))<Bar>exe 'wq'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>

" Position search matches in middle of screen
nnoremap n nzz
nnoremap N Nzz
