colorscheme ChocolateLiquor 
highlight Normal ctermfg=grey ctermbg=black
set background=dark
let asmsyntax='armasm'
let filetype_inc='armasm'
set tabstop=2
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
set guifont=Fixedsys:h11:cANSI

"
"	VUNDLE STUFF
"
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
call vundle#begin('$USERPROFILE/vimfiles/bundle/')


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


Plugin 'tpope/vim-fugitive'
Plugin 'L9'
"Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'vim-latex/vim-latex'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'tomtom/tlib_vim'
Plugin 'vimoutliner/vimoutliner'
Plugin 'sudar/vim-arduino-syntax'
"Plugin 'quark-zju/vim-cpp-auto-include'
Plugin 'godlygeek/tabular'
Plugin 'rdnetto/YCM-Generator', {'branch' : 'stable'}
Plugin 'scrooloose/nerdtree'
Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'


"VIM website

Plugin 'AutoCpp'
Plugin 'Atom'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


"
"	END VUNDLE
"


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    	if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"
"       Vim tags
"
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', 'Docs']
set autochdir
set tags=./tags,tags;$HOME
" Ctrl + \  :: open in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Alt + ]       :: open in Vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

"
" tpope gist to automatically maintain tabs while typing
"
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a


" Use by selecting all text which you desire to align.
" Then use `:` `Tabularize /{symbol to align on}`
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


" use :call SwapWords({'foo':'bar'}) to swap
" foo with bar and bar with foo.
" NOTE:
" If one of your words contains a /, you have to pass in a delimiter
" which you know none of your words contains, .e.g
" :call SwapWords({'foo/bar':'foo/baz'}, '@')
"
function! SwapWords(dict, ...)
                let words = keys(a:dict) + values(a:dict)
                let words = map(words, 'escape(v:val, "|")')
                if(a:0 == 1)
                                let delimiter = a:1
                else
                                let delimiter = '/'
                endif
                let pattern = '\v(' . join(words, '|') . ')'
                exe '%s' . delimiter . pattern . delimiter
                                                                \ . '\=' . string(Mirror(a:dict)) . '[S(0)]'
                                                                \ . delimiter . 'g'
endfunction

"
" DOXYGEN PARAMS
"
let g:DoxygenToolkit_briefTag_pre="@breif  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@return   "
let g:DoxygenToolkit_blockHeader="***********"
let g:DoxygenToolkit_blockFooter="***********"
let g:DoxygenToolkit_authorName="Steven Seppala"
let g:DoxygenToolkit_licenseTag=" ENSCO, inc Internal Software. Do not distribute"
  let g:DoxygenToolkit_briefTag_className =        " yes "
  let g:DoxygenToolkit_briefTag_structName =       " yes "
  let g:DoxygenToolkit_briefTag_enumName =         " yes "
  let g:DoxygenToolkit_briefTag_namespaceName =    " yes "
  let g:DoxygenToolkit_briefTag_funcName =         " yes "
  let g:DoxygenToolkit_keepEmptyLineAfterComment = " yes "
"
"
"
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


let g:Tex_ViewRule_pdf = 'c:/Program\ Files (x86)/Adob/Acrobat\ Reader\ DC/Reader/AcroRd32'


filetype plugin on
filetype plugin indent on
highlight Normal ctermfg=grey ctermbg=black
