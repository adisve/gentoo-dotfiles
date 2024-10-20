" adisve .vimrc, gentoo
" Updated: 2024-03-25

" ----- Leader --------------------------------------------------------------
let mapleader=","
let maplocalleader=","
syntax on
filetype plugin indent on

" ----- Vim Plug ------------------------------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
call plug#end()


set background=dark


" ----- Color ---------------------------------------------------------------
function! MyHighlights() abort
   highlight Visual ctermbg=white ctermfg=red 
endfunction

" ----- au Vim --------------------------------------------------------------
augroup myVim
  au!
  au FileType vim setlocal expandtab
  au FileType vim setlocal tabstop=8
  au FileType vim setlocal shiftwidth=2
  au FileType vimrc setlocal shiftwidth=2
  au FileType vim setlocal softtabstop=2
  au FileType vimrc setlocal softtabstop=2
augroup END

" ----- au Make -------------------------------------------------------------
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ----- au MD ---------------------------------------------------------------
augroup LaTeX
  au!
  au FileType tex setlocal shiftwidth=2
  au FileType tex setlocal tabstop=4
  au FileType tex setlocal noexpandtab
  au FileType tex setlocal listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
augroup END

" ----- C - Kernel ----------------------------------------------------------
"augroup myC
  "au!
  "au BufRead,BufNewFile *.c setfiletype c
  "au FileType c setlocal shiftwidth=8
  "au FileType c setlocal tabstop=8
  "au FileType c setlocal noexpandtab " using TAB, not converting to spaces
  "au FileType c setlocal listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
  "au FileType c setlocal list
"augroup END

" ----- C -------------------------------------------------------------------
"  :retab <- changes .c-files to spaces
augroup myC
  au!
  au BufRead,BufNewFile *.c setfiletype c
  au FileType c setlocal shiftwidth=4
  au FileType c setlocal tabstop=4
  au FileType c setlocal expandtab
  au FileType c setlocal listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
  "au FileType c setlocal list
augroup END

" ----- C++ -----------------------------------------------------------------
augroup myCPP
  au!
  au BufRead,BufNewFile *.cpp setfiletype cpp
  au FileType cpp setlocal shiftwidth=4
  au FileType cpp setlocal tabstop=4
  au FileType cpp setlocal expandtab
  au FileType cpp setlocal listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
  "au FileType c setlocal list
augroup END

" ----- au python -----------------------------------------------------------
augroup myPython
  au!
  au FileType python setlocal expandtab
  au FileType python setlocal tabstop=8
  au FileType python setlocal shiftwidth=4
  au FileType python setlocal softtabstop=4
  au FileType python setlocal listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
  "au FileType python setlocal list
augroup END

" ----- .vimrc --------------------------------------------------------------
autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
nnoremap <Leader>vv :vsplit $MYVIMRC<CR>

inoremap jk <ESC>
tnoremap <Esc> <C-\><C-n>
nnoremap <Leader><ESC> :noh<CR><ESC>

" ----- Save And Close ------------------------------------------------
nnoremap <Leader><Leader> :w<CR>

" ----- Save And Compile pdf  -----------------------------------------
nnoremap <C-r>l :w<CR>:!pdflatex %<Enter><CR>
"nnoremap <C-r>l :w<CR>:!pdflatex main && bibtex main && pdflatex main && pdflatex main<Enter><CR>

" ----- xor list ------------------------------------------------------
nnoremap <C-r>c :set list!<CR>

" ----- Navigation ----------------------------------------------------
nnoremap <S-j> 10j<CR>
vnoremap <S-j> 10j<CR>
nnoremap <S-k> 10k<CR>
vnoremap <S-k> 10k<CR>

" ----- Editor Config -------------------------------------------------
set encoding=UTF-8
set clipboard=unnamedplus

" Vim fuzzy
set path+=**

" Searching
set hlsearch
set smartcase
set incsearch
set ignorecase

" General
set so=7
set nowrap
set number
set hidden
set wildmenu
set showmatch
set autoindent
set cursorline
set showbreak=↪
set relativenumber

set shiftround
set ruler
set showcmd
set nobackup
set splitright
set splitbelow
set noswapfile
set nobackup
set cmdheight=1
set laststatus=2
set nowritebackup
set updatetime=100

