set nocompatible
set encoding=utf-8

filetype on
filetype plugin indent on

syntax on

" Leader
let mapleader = ','

" Load vim-plug
call functions#PlugLoad()
call plug#begin('~/.config/nvim/plugged')

" UI
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
Plug 'ryanoasis/vim-devicons'

" Edition
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/HTML-AutoCloseTag'
Plug 'vim-scripts/a.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-surround'
Plug 'chrisbra/Colorizer', { 'for': ['scss', 'css'] }

" Tags
Plug 'ludovicchabant/vim-gutentags'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'phpvim/phpcd.vim'

" Vim extension
Plug 'tpope/vim-repeat'
Plug 'moll/vim-bbye'
nmap <leader>b :Bdelete<cr>

" Light as air
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'zchee/deoplete-jedi'

" Linting
Plug 'w0rp/ale' " Asynchonous linting engine

call plug#end()

set background=dark

" Formatting
set autoread			" Read file when changed outside
set ruler				" Display percentage
set number				" Display number
set mouse=a				" Activate mouse
set backspace=indent,eol,start
set scrolloff=7			"Offset of the cursor
set clipboard=unnamedplus
set virtualedit=onemore
set spelllang=en,fr

" Completion
set wildmode=longest,list,full
set wildmenu
set wildignorecase
"
" ignore files vim doesnt use
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

set complete=.,w,b,t			 " Same as default except that I remove the 'u' option
set completeopt-=preview
set completeopt+=menuone

" Indentation settings
set smarttab
set noexpandtab        " Do not convert tab to spaces
set tabstop=4          " Number of spaces for a tab
set softtabstop=4      " Delete this number of spaces when removing a tab
set shiftwidth=4       " Space of the tab when using <
set shiftround         " Always a round number of spaces
set autoindent
set copyindent
set cindent

if has("autocmd")
	autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
	autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
	autocmd FileType html setlocal ts=2 sts=2 sw=2 noexpandtab
	autocmd FileType css setlocal ts=2 sts=2 sw=2 noexpandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
	autocmd FileType latex setlocal textwidth=80
endif

vmap <Tab> >gv		" Indent with tab in visual mode
vmap <S-Tab> <gv	" Indent with tab in visual mode
vnoremap < <gv
vnoremap > >gv

nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

"Search settings
set ignorecase				" Ignore case in search
set smartcase				" but not if there is uppercase
set incsearch				" Show the first match when typing
set hlsearch				" Enable highlighting
map <C-h> :nohlsearch<CR>	" Disable highlighting

" Buffer settings
set hidden		" Allow hidden buffer (unsaved)

map  <C-Left>  <esc>:bp<CR>
map  <C-Right> <esc>:bn<CR>
imap <C-Left>  <esc>:bp<CR>
imap <C-Right> <esc>:bn<CR>

"Window settings
noremap <S-Down>  <C-w>j
noremap <S-Up>    <C-w>k
noremap <S-Left>  <C-w>h
noremap <S-Right> <C-w>l

" Deplacement
nmap <Up> gk
nmap <Down> gj

" Move a line
nnoremap <silent><C-S-Down> :m .+1<CR>==
nnoremap <silent><C-S-Up> :m .-2<CR>==
inoremap <silent><C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><C-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv
vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv

" Folding
nnoremap <space> za		" Toggle folding

" Spell checking
nmap <silent> <leader>s :set spell!<CR>
nmap <silent> zn ]s
nmap <silent> zp [s

" Backups
set backup
set backupext=.bak
set backupdir=~/.cache/vim/backup//
set directory=~/.cache/vim/backup//
set viminfo='100,n~/.cache/vim/viminfo

" Function
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Airline
let g:airline_powerline_fonts = 1
let g:airline_detect_paste=1     " Gérer le mode PASTE
let g:airline_skip_empty_sections = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

set laststatus=2	" Always on screen


let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'


" Comment
vnoremap <C-_> :call NERDComment(1, 'toggle')<CR>
noremap <C-_> :call NERDComment(1, 'toggle')<CR>

" NerdTree
map <C-n>  :NERDTreeToggle <CR> 
let g:nerdtree_tabs_open_on_console_startup = 0 " Ouvrir au démarrage

nnoremap <leader>m :!clear<CR>:make<CR>
nnoremap <leader>l :!clear<CR>:make launch<CR>
nnoremap <leader>d :make debug<CR>
nnoremap <leader>c :make clean<CR>
nnoremap <leader>C :make mrproper<CR>

" Tagbar
let g:tagbar_left = 0
let g:tagbar_width = 30
let g:tagbar_compact = 1
nmap <C-t> :TagbarToggle<CR>
set tags=./tags;~/.vim/vimtags

" Ctrlp
let g:ctrlp_by_filename = 1
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 0
 
" Edit root file
cmap w!! w !sudo tee % > /dev/null

" Undo
set undodir=~/.cache/vim/undo
set undofile

" Latex
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:vimtex_view_method = 'zathura'

" Startify
let g:startify_list_order = [
      \ ['   My most recently used files in the current directory:'],
      \ 'dir',
      \ ['   My most recently used files:'],
      \ 'files',
      \ ['   These are my sessions:'],
      \ 'sessions',
      \ ['   These are my bookmarks:'],
      \ 'bookmarks',
      \ ]
"
" Tabular
nmap <Leader>t& :Tabularize /&<CR>
vmap <Leader>t& :Tabularize /&<CR>
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t=> :Tabularize /=><CR>
vmap <Leader>t=> :Tabularize /=><CR>
nmap <Leader>t: :Tabularize /:<CR>
vmap <Leader>t: :Tabularize /:<CR>
nmap <Leader>t, :Tabularize /,<CR>
vmap <Leader>t, :Tabularize /,<CR>
nmap <Leader>t\ :Tabularize /\\<CR>
vmap <Leader>t\ :Tabularize /\\<CR>
nmap <Leader>t" :Tabularize /"<CR>
vmap <Leader>t" :Tabularize /"<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 4
let g:deoplete#enable_smart_case = 1

let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"

" Gui Font
set guifont=DroidSansMono\ Nerd\ Font\ 11

""use TAB as the mapping
inoremap <silent><expr> <TAB>
    \ pumvisible() ?  "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "" {{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction "" }}}
