""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Owner: Wenfa Xu <lvyexuwenfa100@126.com>
" Created: 2013-07-21
" Last Modified: 2013-07-21
"
" Sections:
" -> General
" -> Platform Specific Configuration
" -> Plugin
" -> Vim User Interface
" -> Colors and Fonts
" -> Indent and Tab Related
" -> Search Related
" -> Fold Related
" -> Filetype Specific
" -> Key Mapping
" -> Local Setting
"
" -> Tagbar
" -> NERD_tree
" -> NERD_commenter
" -> Neocomplcache
" -> delimitMate
" -> Ag(Ack)
" -> Syntastic
" -> Indent Guides
" -> fugitive
" -> Gundo(Undotree)
" -> EasyTags
" -> SingleCompile
" -> Zencoding
" -> GoldenView
" -> Splitjoin
" -> Unite
" -> vimux
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"------------------------------------------------
" => General
"------------------------------------------------
set nocompatible				" Get out of VI's compatible mode
filetype plugin indent on 	      	     	" Enable filetype
let mapleader=','				" Change the mapleader
let maplocalleader='\'				" Change the maplocalleader
set timeoutlen=500				" Time to wait for a command
"autocmd BufWritePost .vimrc source $MYVIMRC    " Source the vimrc file after saving it
nnoremap <Leader>x :tabedit $MYVIMRC<CR>	" Fast edit the .vimrc file using ',x'
set autoread 	   	    			" Set autoread when a file is changed outside
set autowrite 					" Write on make/shell commands
set hidden 					" Turn on hidden"
set history=1000 				" Increase the lines of history
set fileencodings=utf-8,gb2312,gbk,gb18030
set encoding=utf-8 				" Set utf-8 encoding
set completeopt+=longest 			" Optimize auto complete
set completeopt-=preview 			" Optimize auto complete
set mousehide 					" Hide mouse after chars typed
set mouse=a 					" Mouse in all modes
set nobackup 					" Set backup to void ~ file
set undofile 					" Set undo
set cmdheight=2                                 

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Record last pos
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \   exe "normal g'\"" |
            \ endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Platform Specific Configuration
"-------------------------------------------------

" On Windows, also use '.vim' instead of 'vimfiles'
if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

set viewoptions+=slash,unix " Better Unix/Windows compatibility
set viewoptions-=options " in case of mapping change
set fileformats=unix,mac,dos " Auto detect the file formats

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Plugin
"--------------------------------------------------
filetype off " Required!
let g:vundle_default_git_proto='git'
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" UI Additions
"Bundle 'w0ng/vim-hybrid'
Bundle 'tomasr/molokai'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'
if executable('ctags')
    Bundle 'majutsushi/tagbar'
endif

Bundle 'terryma/vim-multiple-cursors'
Bundle 'corntrace/bufexplorer'
Bundle 'uguu-org/vim-matrix-screensaver'
Bundle 'vim-scripts/grep.vim'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/cscope.vim'
Bundle 'endel/vim-github-colorscheme'
Bundle 'fugalh/desert.vim'
Bundle 'vim-scripts/blackdust.vim'
Bundle 'zeis/vim-kolor'
Bundle 'mileszs/ack.vim'
Bundle 'tyok/nerdtree-ack'
Bundle 'kien/ctrlp.vim'

" Local bundles if avaiable
if filereadable(expand("~/.vimrc.bundles.local"))
    source ~/.vimrc.bundles.local
endif

filetype plugin indent on " Required!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Vim User Interface
"-------------------------------------------------

" Set title
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}

" Set tabline
set showtabline=2 " Always show tab line
" Set up tab labels
set guitablabel=%m%N:%t\[%{tabpagewinnr(v:lnum)}\]
set tabline=%!MyTabLine()
function! MyTabLine()
    let s=''
    let t=tabpagenr() " The index of current page
    let i=1
    while i<=tabpagenr('$') " From the first page
        let buflist=tabpagebuflist(i)
        let winnr=tabpagewinnr(i)
        let s.=(i==t?'%#TabLineSel#':'%#TabLine#')
        let s.='%'.i.'T'
        let s.=' '
        let bufnr=buflist[winnr - 1]
        let file=bufname(bufnr)
        let m=''
        if getbufvar(bufnr, "&modified")
            let m='[+]'
        endif
        if file=~'\/.'
            let file=substitute(file,'.*\/\ze.','','')
        endif
        if file==''
            let file='[No Name]'
        endif
        let s.=m
        let s.=i.':'
        let s.=file
        let s.='['.winnr.']'
        let s.=' '
        let i=i+1
    endwhile
    let s.='%T%#TabLineFill#%='
    let s.=(tabpagenr('$')>1?'%999XX':'X')
    return s
endfunction
" Set up tab tooltips with every buffer name
set guitabtooltip=%F

" Set status line
set laststatus=2 " Show the statusline
set noshowmode " Hide the default mode text
" Only have cursorline in current window and in normal window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline
auto InsertEnter * set nocursorline
auto InsertLeave * set cursorline
set wildmenu " Show list instead of just completing
set wildmode=list:longest,full " Use powerful wildmenu
set shortmess=at " Avoids 'hit enter'
set showcmd " Show cmd

set backspace=indent,eol,start " Make backspaces delete sensibly
set whichwrap+=h,l,<,>,[,] " Backspace and cursor keys wrap to
set virtualedit=block,onemore " Allow for cursor beyond last character
set scrolljump=5 " Lines to scroll when cursor leaves screen
set scrolloff=3 " Minimum lines to keep above and below cursor
set sidescroll=1 " Minimal number of columns to scroll horizontally
set sidescrolloff=10 " Minimal number of screen columns to keep away from cursor

set showmatch " Show matching brackets/parenthesis
set matchtime=2 " Decrease the time to blink
" Use Tab instead of % to switch using matchit
nmap <Tab> %
vmap <Tab> %

set number " Show line numbers
" Toggle relativenumber
function! ToggleRelativenumber()
    if &number==1
        set relativenumber
    else
        set number
    endif
endfunction
nnoremap <Leader>n :call ToggleRelativenumber()<CR>

set formatoptions+=rnlmM " Optimize format options
set wrap " Set wrap
"set textwidth=80 " Change text width
set colorcolumn=+1 " Indicate text border
"set list " Show these tabs and spaces and so on
"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮ " Change listchars
set linebreak " Wrap long lines at a blank
set showbreak=↪ " Change wrap line break
set fillchars=diff:⣿,vert:│ " Change fillchars
" Only show trailing whitespace when not in insert mode
augroup trailing
    autocmd!
    autocmd InsertEnter * :set listchars-=trail:⌴
    autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

" Set gVim UI setting
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Colors and Fonts
"-------------------------------------------------

syntax on " Enable syntax
set background=dark " Set background
if !has('gui_running')
    set t_Co=256 " Use 256 colors
endif
"colorscheme molokai " Load a colorscheme
"colorscheme github
"colorscheme desert
"colorscheme molokai
colorscheme kolor

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

nnoremap <silent>\t :colorscheme Tomorrow-Night-Eighties<CR>
nnoremap <silent>\j :colorscheme jellybeans<CR>
nnoremap <silent>\h :colorscheme hybrid<CR>
if has('gui_running')
    nnoremap <silent>\t :colorscheme Tomorrow-Night<CR>
    nnoremap <silent>\s :colorscheme solarized<CR>
endif

if has('gui_running')
    if has('gui_gtk')
        set guifont=DejaVu\ Sans\ Mono\ 11
    elseif has('gui_macvim')
        set guifont=Monaco:h11
    elseif has('gui_win32')
        set guifont=Consolas:h11:cANSI
    endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Indent and Tab Related
"-------------------------------------------------

set autoindent " Preserve current indent on new lines
set cindent " set C style indent
set expandtab " Convert all tabs typed to spaces
set tabstop=4
set softtabstop=4 " Indentation levels every four columns
set shiftwidth=4 " Indent/outdent by four columns
set shiftround " Indent/outdent to nearest tabstop

" Indent setting for html
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Search Related
"-------------------------------------------------

set ignorecase " Case insensitive search
set smartcase " Case sensitive when uc present
set hlsearch " Highlight search terms
set incsearch " Find as you type search
set gdefault " turn on 'g' flag

" Use sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap s/ s/\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s? s?\v

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g* g*zzzv
nnoremap g# g#zzzv

" Visual search mappings
function! s:VSetSearch()
    let temp=@@
    normal! gvy
    let @/='\V'.substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@=temp
endfunction
vnoremap * :<C-U>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-U>call <SID>VSetSearch()<CR>??<CR>

" Use ,Space to toggle the highlight search
nnoremap <Leader><Space> :set hlsearch!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"-------------------------------------------------
" => Fold Related
"-------------------------------------------------

set foldlevelstart=0 " Start with all folds closed
set foldcolumn=1 " Set fold column

" Space to toggle and create folds.
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Set foldtext
function! MyFoldText()
    let line=getline(v:foldstart)
    let nucolwidth=&foldcolumn+&number*&numberwidth
    let windowwidth=winwidth(0)-nucolwidth-3
    let foldedlinecount=v:foldend-v:foldstart+1
    let onetab=strpart(' ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')
    let line=strpart(line, 0, windowwidth-2-len(foldedlinecount))
    let fillcharcount=windowwidth-len(line)-len(foldedlinecount)
    return line.'…'.repeat(" ",fillcharcount).foldedlinecount.'…'.' '
endfunction
set foldtext=MyFoldText()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Filetype Specific
"-------------------------------------------------

" QuickFix
augroup ft_quickfix
    autocmd!
    autocmd Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap textwidth=0
augroup END

" Markdown
augroup ft_markdown
    autocmd!
" Use <localLeader>1/2/3/4/5/6 to add headings
    autocmd Filetype markdown nnoremap <buffer> <localLeader>1 I# <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>2 I## <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>3 I### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>4 I#### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>5 I##### <ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>6 I###### <ESC>
" Use <LocalLeader>b to add blockquotes in normal and visual mode
    autocmd Filetype markdown nnoremap <buffer> <localLeader>b I> <ESC>
    autocmd Filetype markdown vnoremap <buffer> <localLeader>b :s/^/> /<CR>
" Use <localLeader>ul and <localLeader>ol to add list symbols in visual mode
    autocmd Filetype markdown vnoremap <buffer> <localLeader>ul :s/^/* /<CR>
    autocmd Filetype markdown vnoremap <buffer> <LocalLeader>ol :s/^/\=(line(".")-line("'<")+1).'. '/<CR>
" Use <localLeader>e1/2/3 to add emphasis symbols
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e1 I*<ESC>A*<ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e2 I**<ESC>A**<ESC>
    autocmd Filetype markdown nnoremap <buffer> <localLeader>e3 I***<ESC>A***<ESC>
" Use <Leader>P to preview markdown file in browser
    autocmd Filetype markdown nnoremap <buffer> <Leader>P :MarkdownPreview<CR>
augroup END

" LESS
augroup ft_less
    autocmd!
    autocmd filetype less nnoremap <buffer> <Leader>r :w <BAR> !lessc % > %:t:r.css<CR><Space>
augroup END

" JSON
augroup ft_json
    autocmd!
" Disable concealing of double quotes
    autocmd filetype json setlocal conceallevel=0
" Added folding of {...} and [...] blocks
    autocmd filetype json setlocal foldmethod=syntax
augroup END

" Python
augroup ft_python

" Indent Python in the Google way.
    let s:maxoff = 50 " maximum number of lines to look backwards.
    function! GetGooglePythonIndent(lnum)
" Indent inside parens.
" Align with the open paren unless it is at the end of the line.
" E.g.
" open_paren_not_at_EOL(100,
" (200,
" 300),
" 400)
" open_paren_at_EOL(
" 100, 200, 300, 400)
        call cursor(a:lnum, 1)
        let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
                    \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
                    \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
                    \ . " =~ '\\(Comment\\|String\\)$'")
        if par_line > 0
            call cursor(par_line, 1)
            if par_col != col("$") - 1
                return par_col
            endif
        endif
" Delegate the rest to the original function.
        return GetPythonIndent(a:lnum)
    endfunction

    function! ChoosePythonCompiler()
        echo "Please choose python compiler:\n"
        echo "1. Python2+\n"
        echo "2. Python3+\n"
        let flag=getchar()
        if flag==49
            call SingleCompile#ChooseCompiler('python', 'python')
            execute 'SingleCompileRun'
        elseif flag==50
            call SingleCompile#ChooseCompiler('python', 'python3')
            execute 'SingleCompileRun'
        endif
    endfunction

    let pyindent_nested_paren="&sw*2"
    let pyindent_open_paren="&sw*2"

    autocmd!
    autocmd filetype python setlocal indentexpr=GetGooglePythonIndent(v:lnum)
    autocmd filetype python nnoremap <buffer> <Leader>r :call ChoosePythonCompiler()<CR>

augroup END

" Perl
augroup ft_perl
    let perl_include_pod=1
    let perl_extended_vars=1
    let perl_sync_dist=250
    autocmd!
    autocmd filetype perl setlocal keywordprg=perldoc\ -f
augroup END

" PHP
augroup ft_php
    autocmd!
    if filereadable("$HOME/.vim/dict/php_funclist.txt")
        function! AddPHPFuncList() " Inspired by hawk (https://github.com/hawklim)
            set dictionary-="$HOME/.vim/dict/php_funclist.txt" dictionary+="$HOME/.vim/dict/php_funclist.txt"
            set complete-=k complete+=k
        endfunction
        autocmd filetype php call AddPHPFuncList()
    endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------
" => Key Mapping
"-------------------------------------------------
" quickfix
map <leader>l :lopen<cr>

" copy & paste
vmap ys :w !pbcopy<cr><cr>
nmap z :r !pbpaste<cr><cr>

"before paste input '@', so paste will no indent, must input '@' end paste 
set pastetoggle=<F7>
:map <F1> :set paste<CR>
:map <F2> :set nopaste<CR>

" delete space or tab
nmap << 0dw



" Select All
map <leader>a ggVG

" Remove the Windows ^M
map <leader>M :%s/\r//g<cr>

" Fast Save & Quit
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>


" Useful mappings for managing tabs
map tt :tabnew 
map tc :tabclose<cr>
map tk :tabNext<cr>
map tj :tabprevious<cr>
map th :tabfirst<cr>
map tl :tablast<cr>

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" 窗口快速切换
nn <c-h> <c-w>h
nn <c-j> <c-w>j
nn <c-k> <c-w>k
nn <c-l> <c-w>l

" Make j and k work the way you expect
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Navigation between windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Repeat last substitution, including flags, with &.
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG

" Map \<Space> to commenting
function! IsWhiteLine()
    if (getline(".")=~"^$")
        let oldlinenumber=line(".")
        :call NERDComment('n', 'Sexy')
        if (line(".")==oldlinenumber)
            :call NERDComment('n', 'Append')
        else
            normal! k
            startinsert!
        endif
    else
        normal! A
        :call NERDComment('n', 'Append')
    endif
endfunction
nnoremap <silent>\<Space> :call IsWhiteLine()<CR>

" Strip all trailing whitespace in the current file
"nnoremap <Leader>q :%s/\s\+$//<CR>:let @/=''<CR>

" Modify all the indents
nnoremap \= gg=G

" See the differences between the current buffer and the file it was loaded from
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_
            \ | diffthis | wincmd p | diffthis

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Map auto complete of (, ", ', [,{
"inoremap ( ()<esc>:let leavechar=")"<cr>i
"inoremap [ []<esc>:let leavechar="]"<cr>i
"inoremap { {}<esc>:let leavechar="}"<cr>i
"inoremap < <><esc>:let leavechar=">"<cr>i
""inoremap ' ''<esc>:let leavechar="'"<cr>i
"inoremap " ""<esc>:let leavechar='"'<cr>i
"inoremap )) (<esc>o)<esc>:let leavechar=")"<cr>O
"inoremap ]] [<esc>o]<esc>:let leavechar="]"<cr>O
"inoremap }} {<esc>o}<esc>:let leavechar="}"<cr>O
"
"vnoremap #( <esc>`>a)<esc>`<i(<esc>
"vnoremap #[ <esc>`>a]<esc>`<i[<esc>
"vnoremap #{ <esc>`>a}<esc>`<i{<esc>
"vnoremap #< <esc>`>a><esc>`<i<<esc>
"vnoremap #' <esc>`>a'<esc>`<i'<esc>
"vnoremap #" <esc>`>a"<esc>`<i"<esc>


"--------------------------------------------------
" => NERD_tree
"--------------------------------------------------

nnoremap <Leader>d :NERDTreeTabsToggle<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeDirArrows=1
let NERDTreeIgnore=['^\.','\.pyc$','\.svn$','\.tmp$','\.bak$','\~$', 'cscope.*', 'tags$', '\.o$']
let g:nerdtree_tabs_open_on_gui_startup=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
" => Tlist
" ctrl+]  goto the function
" ctrl+T  goback
"--------------------------------------------------
let Tlist_Ctags_Cmd="/usr/local/bin/ctags"
let Tlist_Use_Right_Window=1
let Tlist_Show_One_File=1
let Tlist_Auto_Open=0
let Tlist_Inc_Winwidth=0
let Tlist_Exit_OnlyWindow=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
"" => Tagbar
"--------------------------------------------------

nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
"" => NERD_commenter
"--------------------------------------------------

let NERDCommentWholeLinesInVMode=2
let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
"" => Neocomplcache
"--------------------------------------------------

let g:neocomplcache_enable_at_startup=1
let g:neocomplcache_enable_auto_delimiter=1
let g:neocomplcache_enable_camel_case_completion=1
let g:neocomplcache_enable_underbar_completion=1

let g:snips_author='Xiao-Ou Zhang <kepbod@gmail.com>'

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory="$HOME/.vim/bundle/vim-snippets/snippets"
let g:neosnippet#enable_snipmate_compatibility=1

" Plugin key-mappings
imap <C-K> <Plug>(neosnippet_expand_or_jump)
smap <C-K> <Plug>(neosnippet_expand_or_jump)
xmap <C-K> <Plug>(neosnippet_expand_target)

" Map <C-E> to cancel completion
"inoremap <expr><C-E> neocomplcache#cancel_popup()
"
"" SuperTab like snippets behavior
"inoremap <expr><Tab> neosnippet#expandable() ?
""\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-N>" : "\<Tab>"
"snoremap <expr><Tab> neosnippet#expandable() ?
""\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
"inoremap <expr><S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
"
"" CR/S-CR: close popup and save indent
"inoremap <expr><CR> delimitMate#WithinEmptyPair() ?
""\<C-R>=delimitMate#ExpandReturn()\<CR>" : pumvisible() ?
"neocomplcache#close_popup() : "\<CR>"
"inoremap <expr><S-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" :
""\<CR>"

" For snippet_complete marker
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
"" => BufExplorer
"--------------------------------------------------
let g:bufExplorerDefaultHelp=0
let g:bufExplorerMaxHeight=25
let g:bufExplorerResize=1
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='mru'
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitRight=0
let g:bufExplorerSplitVertSize = 20
let g:bufExplorerSplitVertical=1
let g:bufExplorerUseCurrentWindow=1

nmap <leader>b :BufExplorer<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
"" => Vimwiki (set to dropbox directory)
"--------------------------------------------------
if has('win32') || has('win64')
let g:vimwiki_list = [{'path': '~/my_site/',
            \ 'template_path': '~/public_html/templates/',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'}]
else
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/',
            \ 'template_path': '~/Dropbox/wiki/templates/',
            \ 'template_default': 'template',
            \ 'template_ext': '.html',
            \ 'path_html': '~/Dropbox/wiki/html/',
            \ 'diary_rel_path': 'diary/'
            \}]
endif

nmap <leader>v :VimwikiAll2HTML<cr>
nmap vj :VimwikiDiaryPrevDay<cr>
nmap vk :VimwikiDiaryNextDay<cr>
nmap v- glm
nmap cr  A<br><ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
"" => Grep
"--------------------------------------------------
nmap <leader>g :Grep -r<cr><cr>.c<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"--------------------------------------------------
"" => Cscope
"--------------------------------------------------
if filereadable("cscope.out")
    cs add cscope.out
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------
"" => A
"--------------------------------------------------
nmap <leader>s :A<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
