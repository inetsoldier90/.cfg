if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'
Plug 'peterhellberg/snippets'
Plug 'itchyny/lightline.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'

call plug#end()

let mapleader=","

set timeout
set timeoutlen=2000

set clipboard=unnamed,unnamedplus
set completeopt-=preview
set expandtab
set hidden
set ignorecase
set lazyredraw
set list listchars=tab:▸\ ,trail:·,extends:>,precedes:<
set modelines=3
set mouse=c
set nobackup
set nocursorcolumn
set nocursorline
set noshowmode
set noswapfile
set nowrap
set nowritebackup
set number
set omnifunc=syntaxcomplete#Complete
set re=1
set shiftwidth=2
set shortmess+=I
set showmatch
set sidescroll=1
set sidescrolloff=1
set smartcase
set splitright
set synmaxcol=1024
set tabstop=2
set virtualedit=block
set emoji
set updatetime=100

syntax sync minlines=256

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Vim annoyances
" http://blog.sanctum.geek.nz/vim-annoyances/
vnoremap u y
nnoremap U <C-r>
nnoremap Q <nop>
nnoremap K <nop>
nnoremap J mzJ`z
nnoremap Y y$
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap jj <Esc>

au InsertEnter * set nocursorline
au InsertLeave * set cursorline nopaste

" Change the cursor in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Disable automatic comments
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatic formatting
function! <SID>StripTrailingSpace()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l,c)
endfun

" Strip trailing space for a list of extensions
autocmd BufWritePre *.builder,*.c,*.coffee,*.elm,*.ex,*.exs,*.haml,*.html,*.js,*.lua,*.markdown,*.md,*.rb,*.rs,*.scss,*.txt :call <SID>StripTrailingSpace()

" Set noeol on all new files
autocmd BufNewFile * set noeol

" Set noeol on all new files
autocmd VimEnter * set nosc

" Use space for :
noremap <space> :

" Quick save
nmap <leader>w :w!<cr>

" Open last opened file
nmap <leader>l :e#<cr>

" Change record macro to Q
nnoremap <leader>q q
nnoremap q <Nop>

" Open new buffers
nmap <leader>sl :leftabove  vnew<cr>
nmap <leader>sh :rightbelow vnew<cr>
nmap <leader>sk :leftabove  new<cr>
nmap <leader>sj :rightbelow new<cr>

" Tab between buffers
noremap <tab> <c-w>w
noremap <S-tab> <c-w>W

" Close current buffer
nmap <leader>b :bd<cr>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>

let NERDTreeShowHidden=1
let NERDTreeDirArrowExpandable = '→'
let NERDTreeDirArrowCollapsible = '↓'
let NERDTreeHighlightCursorline=1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"

" CtrlP
nnoremap <silent> t :CtrlP<cr>

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_working_path_mode = 2
let g:ctrlp_by_filename = 0
let g:ctrlp_max_files = 256
let g:ctrlp_max_depth = 4
let g:ctrlp_root_markers = ['.git']
let g:ctrlp_user_command = {
  \ 'types': { 1: ['.git/', 'cd %s && git ls-files --cached --exclude-standard --others | grep -v vendor | grep -v _workspace | grep -v private_gems'] },
  \ 'fallback': 'ack -f %s --ignore-dir=.git | head -' . g:ctrlp_max_files
  \ }
