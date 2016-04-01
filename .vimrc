colorscheme desert
highlight Normal ctermfg=grey ctermbg=black
set background=dark
let asmsyntax='armasm' 
let filetype_inc='armasm'
set tabstop=4
set shiftwidth=4
set number 
set ai
syntax on
set smartindent
set backspace=indent,eol,start
:filetype indent on
set hlsearch 
:map <F3> :set hlsearch!<CR>
set guioptions-=T "remove toolbar
set mouse=a
set encoding=utf8


"
" Vundle stuff
"
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" GITS
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tomtom/tlib_vim'
Plugin 'vimoutliner/vimoutliner'
Plugin 'sudar/vim-arduino-syntax'
"Plugin 'quark-zju/vim-cpp-auto-include'
Plugin 'godlygeek/tabular'
Plugin 'rdnetto/YCM-Generator', {'branch' : 'stable'}




"VIM website

Plugin 'AutoCpp'
Plugin 'Atom'


call vundle#end()

" 
" word processor mode
"
let Tlist_Use_Right_Window = 1

"func! WordProcessorMode() 
"	setlocal formatoptions=1 
"	setlocal noexpandtab 
"	map j gj 
"	map k gk
"	setlocal spell spelllang=en_us 
"	"set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
"	set complete+=s
"	set formatprg=par
"	setlocal wrap 
"	setlocal linebreak 
"endfu 
"com! WP call WordProcessorMode()

"
" tpope gist to automatically maintain tabs while typing
"
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
	let p = '^\s*|\s.*\s|\s*$'
	if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
		let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
		let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
		Tabularize/|/l1
		normal! 0
		call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
	endif
endfunction

" disable clang_complete and SuperTab in favor of youcompleteme

"let g:clang_use_library=1
func! StartClangComplete()
	let g:clang_debug=1
	"On Ubuntu, libllvm.so is not located in /usr/lib/
	"On ubuntu, you must install libclang1-dev in order to get
	"/usr/lib/libclang.so
	let g:clang_library_path='/usr/lib/llvm-3.4/lib/'
	let g:clang_auto_select=1 
	set conceallevel=2
	set concealcursor=vin
	let g:clang_snippets=1
	let g:clang_conceal_snippets=1

	" The single one that works with clang_complete
	let g:clang_snippets_engine='clang_complete'
	" show errors in code
	"let g:clang_complete_copen = 1
	let g:clang_hl_errors=1
	"let g:clang_periodic_quickfix=1
	"nmap <F5> call g:ClangUpdateQuickFix()
	"
	" Complete options (disable preview scratch window, longest removed to aways
	" show menu)
	set completeopt=menu,menuone
	" Limit popup menu height
	set pumheight=20
endfu
com! StartClang call StartClangComplete()


" SuperTab completion fall-back 
let g:SuperTabDefaultCompletionType='<c-x><c-u><c-p>'
"let g:tex_flavor='latex'
"let g:Tex_DefaultTargetFormat='pdf'
set nocp

let g:acp_behaviorSnipmateLength = 1

nmap <F8> :TagbarToggle<CR>
nmap <F9> :NERDTreeToggle<CR>
" use F3 to toggle highlighting of search strings

:map <C-h> :MBEbp<CR>
:map <C-l> :MBEbn<CR>


filetype plugin on
filetype plugin indent on
highlight Normal ctermfg=grey ctermbg=black




