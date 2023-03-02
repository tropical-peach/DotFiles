colorscheme ChocolateLiquor
set background=dark
set tabstop=2 shiftwidth=2 expandtab
    
set softtabstop=0
set autoindent
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
set guifont=DejaVu\ Sans\ Mono\ 10
set t_Co=256

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"
" VUNDLE STUFF
"
" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin()


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'

Plugin 'neomake/neomake'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'tomtom/tlib_vim'
Plugin 'vimoutliner/vimoutliner'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'vhda/verilog_systemverilog.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'w0rp/ale'
Plugin 'majutsushi/tagbar'
" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plugin 'xuhdev/vim-latex-live-preview'
" Plugin for markdown viewing
Plugin 'instant-markdown/vim-instant-markdown'


"VIM website

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on


"
" END VUNDLE
"
let g:livepreview_previewer = 'zathura'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts=1
set laststatus=2

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
set diffexpr=MyDiff()

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
set nocp

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

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on
filetype plugin on
filetype plugin indent on
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/

" Always show statusline
set laststatus=2

let g:lightline = {
  \   'colorscheme': 'molokai',
  \   'active': {
  \   'left': [ [ 'filename' ],
  \             [ 'readonly', 'fugitive' ],
  \             [ 'lint' ] ],
  \   'right': [ [ 'percent', 'lineinfo' ],
  \              [ 'fileencoding', 'filetype' ],
  \              [ 'fileformat' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'WizMod',
  \   'readonly': 'WizRO',
  \   'fugitive': 'WizGit',
  \   'filename': 'WizName',
  \   'filetype': 'WizType',
  \   'fileformat' : 'WizFormat',
  \   'fileencoding': 'WizEncoding',
  \   'mode': 'WizMode',
  \   'lint': 'Dryer',
  \ },
  \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
  \ 'subseparator': { 'left': '▒', 'right': '░' }  
  \ }


function! WizMod()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '»' : &modifiable ? '' : ''
endfunction

function! WizRO()
  return &ft !~? 'help\|vimfiler' && &readonly ? 'x' : ''
endfunction

function! WizGit()
  if &ft !~? 'help\|vimfiler' && exists("*fugitive#head")
    return fugitive#head()
  endif
  return ''
endfunction

function! WizName()
  return ('' != WizMod() ? WizMod() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[none]') 
endfunction

function! WizType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : '') : ''
endfunction

function! WizFormat()
  return ''
endfunction

function! WizEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &enc : &enc) : ''
endfunction

function! Dryer()
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:Merrors = l:counts.error
    let l:Mwarnings = l:counts.warning
    let l:Minfos = l:counts.info
    let l:MstylesCheck = l:counts.style_error + l:counts.style_warning

    return l:counts.total == 0 ? ' ✓☆  ok' : printf(
    \   '☠ %d ⚠ %d I%d Style%d',
    \   Merrors,
    \   Mwarnings,
    \   Minfos,
    \   MstylesCheck
    \)
endfunction



if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif



""//
""//     ██     ██       ████████
""//    ████   ░██      ░██░░░░░ 
""//   ██░░██  ░██      ░██      
""//  ██  ░░██ ░██      ░███████ 
""// ██████████░██      ░██░░░░  
""//░██░░░░░░██░██      ░██      
""//░██     ░██░████████░████████
""//░░      ░░ ░░░░░░░░ ░░░░░░░░ 
""//
""let g:airline#extensions#ale#enabled =  1
let g:ale_lint_on_text_changed = 'never'
" You can disable this option too
" if you don't want linters to run on opening a file
let g:ale_lint_on_enter = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = "☢"
let g:ale_sign_warning = "⚠"


""let g:syntastic_always_populate_loc_list = 1
""let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
""let g:syntastic_vhdl_checkers = ['vhdltool']


""let g:neomake_open_list = 2
""autocmd! BufWritePost,BufRead * Neomake
""let g:neomake_vhdl_vhdltool_maker = {
""  \ 'exe': 'vhdl-tool',
""  \ 'args': ['client', 'lint', '--compact'],
""  \ 'errorformat': '%f:%l:%c:%t:%m',
""  \ }
""let g:neomake_vhdl_enabled_makers = ['vhdltool']



""// ██      ██ ██      ██ ███████       ██    
""//░██     ░██░██     ░██░██░░░░██     ████   
""//░██     ░██░██     ░██░██    ░██   ██░░██  
""//░░██    ██ ░██████████░██    ░██  ██  ░░██ 
""// ░░██  ██  ░██░░░░░░██░██    ░██ ██████████
""//  ░░████   ░██     ░██░██    ██ ░██░░░░░░██
""//   ░░██    ░██     ░██░███████  ░██     ░██
""//    ░░     ░░      ░░ ░░░░░░░   ░░      ░░ 
nnoremap <leader>i :VerilogFollowInstance<CR>
nnoremap <leader>I :VerilogFollowPort<CR>
nnoremap <leader>u :VerilogGotoInstanceStart<CR>

let g:SuperTabDefaultCompletionType = 'context'
let g:tagbar_type_verilog_systemverilog = {
        \ 'ctagstype'   : 'SystemVerilog',
        \ 'kinds'       : [
            \ 'b:blocks:1:1',
            \ 'c:constants:1:0',
            \ 'e:events:1:0',
            \ 'f:functions:1:1',
            \ 'm:modules:0:1',
            \ 'n:nets:1:0',
            \ 'p:ports:1:0',
            \ 'r:registers:1:0',
            \ 't:tasks:1:1',
            \ 'A:assertions:1:1',
            \ 'C:classes:0:1',
            \ 'V:covergroups:0:1',
            \ 'I:interfaces:0:1',
            \ 'M:modport:0:1',
            \ 'K:packages:0:1',
            \ 'P:programs:0:1',
            \ 'R:properties:0:1',
            \ 'T:typedefs:0:1'
        \ ],
        \ 'sro'         : '.',
        \ 'kind2scope'  : {
            \ 'm' : 'module',
            \ 'b' : 'block',
            \ 't' : 'task',
            \ 'f' : 'function',
            \ 'C' : 'class',
            \ 'V' : 'covergroup',
            \ 'I' : 'interface',
            \ 'K' : 'package',
            \ 'P' : 'program',
            \ 'R' : 'property'
        \ },
    \ }


filetype plugin on
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
"let g:instant_markdown_open_to_the_world = 1
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_mermaid = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
"let g:instant_markdown_port = 8888
"let g:instant_markdown_python = 1
