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
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'kballard/vim-swift'
Plugin 'posva/vim-vue'
Plugin 'atelierbram/Base2Tone-vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/fzf.vim'
Plugin 'w0rp/ale'
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
Plugin 'mhinz/vim-startify'

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

command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --ignore --hidden --follow --glob "!{.git,node_modules}/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Better command-line completion
set wildmenu

" Ale fixers
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_pattern_options = {
\   '.*\.json$': {'ale_enabled': 0},
\   '.*\.md$': {'ale_enabled': 0},
\}

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
	call append(line('.'), "- 14:00 - 18:00 [4:00]")
	call append(line('.'), "- 10:00 - 13:00 [3:00]")
	call append(line('.'), "")
	call append(line('.'), strftime("%Y-%m-%d %a"))
endfunction
nmap <F12> :call Timesheet()<CR>

" Vim-instant-markdown (https://github.com/suan/vim-instant-markdown)
let g:instant_markdown_autostart = 0

syntax on
set t_Co=256
set background=light
colorscheme Base2Tone_EarthDark
hi Normal ctermbg=none
hi String ctermfg=white
hi Function ctermfg=214
hi StorageClass ctermfg=214
hi Boolean ctermfg=214
hi Conditional ctermfg=214
hi LineNr ctermfg=grey ctermbg=none
hi CursorLine ctermbg=none
hi CursorLineNr ctermbg=none ctermfg=darkblue
hi Comment ctermfg=blue
hi Folded ctermfg=blue
hi EndOfBuffer ctermfg=gray
hi Search cterm=none ctermbg=none ctermfg=Red
hi ALEErrorSign ctermbg=none ctermfg=Red
hi ALEWarningSign ctermbg=none ctermfg=190
hi ALEError ctermbg=none cterm=underline
hi ALEWarning ctermbg=none cterm=underline
hi SignColumn ctermbg=none

" YouCompleteMe options
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist = { 'notes': 1, 'markdown': 1, 'md': 1, 'text': 1, 'vimwiki': 1, 'pandoc': 1, 'infolog': 1, 'mail': 1 }

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
		hi User5 ctermbg=Red ctermfg=240
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
	let statusline.="\ %{fugitive#head()!=''?'\ '.fugitive#head().'\ ':'\ -\ '}"
	let statusline.="%4*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%5*"
	let statusline.="\ [%n/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}]"
	let statusline.="\ %{pathshorten(expand('%:f'))}\ %m\ "
	let statusline.="%{&readonly?'\ \ ':''}"
	let statusline.="%="
	let statusline.="\ %{''!=#&filetype?&filetype:'none'}\ "
	let statusline.="%4*"
	let statusline.="%{mode()=='i'||mode()=='v'?'':''}"
	let statusline.="%3*"
	let statusline.="\ %{&ff=='mac'?'CR':&ff=='unix'?'LF':'CRLF'} %vC|%l/%LL\ "            " Column number | Row number / total lines
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
 
" Spell check
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
hi Folded ctermbg=none
hi FoldColumn ctermbg=none
let g:markdown_folding = 1
let g:markdown_enable_folding = 1

" Folding js and jsx
function JsFold() 
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
au BufEnter *.js setlocal foldexpr=JsFold()
au BufEnter *.js setlocal foldmethod=expr
au BufEnter *.jsx setlocal foldexpr=JsFold()
au BufEnter *.jsx setlocal foldmethod=expr

" Folding test.js
function TestsFold()
  let h1 = matchstr(getline(v:lnum), 'describe(')
  let h2 = matchstr(getline(v:lnum), 'describe.only(')
  let h3 = matchstr(getline(v:lnum), 'it(')
  let h4 = matchstr(getline(v:lnum), 'it.only(')
  let h5 = matchstr(getline(v:lnum), 'it.skip(')
  if !empty(h1) || !empty(h2)
    return ">1"
  endif
  if !empty(h3) || !empty(h4) || !empty(h5)
    return ">2"
  endif
  if empty(h1) && empty(h2) && empty(h3) && empty(h4) && empty(h5)
    return "="
  endif
endfunction
au BufEnter *.test.js setlocal foldexpr=TestsFold()
au BufEnter *.test.js setlocal foldmethod=expr

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

autocmd BufNewFile,BufRead *.* set expandtab

" Language dependent configurations

" Python
autocmd BufNewFile,BufRead *.py set tabstop=4
autocmd BufNewFile,BufRead *.py set softtabstop=4
autocmd BufNewFile,BufRead *.py set shiftwidth=4
autocmd BufNewFile,BufRead *.py set textwidth=139
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
let g:vim_json_syntax_conceal = 0
autocmd BufNewFile,BufRead *.json set tabstop=2
autocmd BufNewFile,BufRead *.json set softtabstop=2
autocmd BufNewFile,BufRead *.json set shiftwidth=2
autocmd BufNewFile,BufRead *.json set nospell
autocmd BufNewFile,BufRead *.json hi constant ctermfg=gray
autocmd BufNewFile,BufRead *.json hi error ctermbg=none
autocmd BufNewFile,BufRead *.json hi Label ctermfg=black
autocmd BufNewFile,BufRead *.json hi jsonString ctermfg=blue
autocmd BufNewFile,BufRead *.json hi jsonNumber ctermfg=magenta
autocmd BufNewFile,BufRead *.json hi jsonBoolean ctermfg=blue
autocmd BufNewFile *.json set fdm=syntax
autocmd BufRead *.json :call FoldChoice()

function FoldChoice()
  let choice=confirm("Disable syntax folding rules? (May impact performance on large files. To disable rules after the file is opened use 'zi').", "&Disable rules\n&No (default)", 2)
  if choice == 2
    set fdm=syntax
  endif
endfunction

" XML
autocmd BufNewFile,BufRead *.xml set tabstop=2
autocmd BufNewFile,BufRead *.xml set softtabstop=2
autocmd BufNewFile,BufRead *.xml set shiftwidth=2

" Markdown
hi htmlItalic ctermfg=grey ctermbg=none cterm=none
hi markdownError ctermbg=none
autocmd BufNewFile,BufRead *.md set noexpandtab

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
nmap =j :%!python -c "import json, sys; print(json.dumps(json.load(sys.stdin), indent=2))"<CR>
nmap \f :!ranger<CR>
map <leader>md :InstantMarkdownPreview<CR>
cmap W w
cmap Q q
map 0 :call LineHome()<CR>
inoremap ><Tab> ><Esc>F<lyt>o</<C-r>"><Esc>O<Space>
nmap J <nop>						" Avoid joining lines when hitting caps lock by mistake
nmap K <nop>						" Avoid opening help when hitting caps lock by mistake

" Identify rule causing highlight
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

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
inoremap ` <c-r>=QuoteDelim("`")<CR>
nnoremap <C-]> :ALEFix<CR>

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

" Copy path to clipboard
function Path()
  let @+=expand("%:p")
  echo('Path copied to clipboard')
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
" ca q :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1))<Bar>exe 'q'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>
" ca wq :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1))<Bar>exe 'wq'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>

" Position search matches in middle of screen
nnoremap n nzz
nnoremap N Nzz
