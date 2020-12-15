" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'tomasr/molokai'
Plug 'Lokaltog/vim-powerline'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'lepture/vim-jinja'
Plug 'majutsushi/tagbar'
Plug 'digitaltoad/vim-pug'
Plug 'groenewege/vim-less'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'lambdatoast/elm.vim'
Plug 'posva/vim-vue'
Plug 'kchmck/vim-coffee-script'
Plug 'chemzqm/wxapp.vim'
Plug 'moll/vim-node'
Plug 'vim-scripts/indentpython.vim'
Plug 'w0rp/ale'
Plug 'leafgarland/typescript-vim'
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

filetype plugin indent on    " required


" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" jj => ESC
inoremap jj <ESC>

" remap : to ;
nnoremap ; :

" undo even after close the file
" set undofile

" ColorScheme
syntax enable

" nerd tree plugin
nnoremap <C-d> :NERDTreeToggle<CR>
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Show line number
set number

" show relative line number from current line
" set relativenumber

" handle cases in search
set ignorecase
set smartcase

" Incremental search
set incsearch
" highlight search
set hlsearch

" toggle between paste and normal: for 'safer' pasting from keyboard
set pastetoggle=<F4>

set nobackup
set nowritebackup
set noswapfile

set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

" map tab page navigations
map <C-S-Tab> :tabprevious<CR>
nmap <C-S-Tab> :tabprevious<CR>
imap <C-S-Tab> <ESC>:tabprevious<CR>i

map <C-Tab> :tabnext<CR>
nmap <C-Tab> :tabnext<CR>
imap <C-Tab> <ESC>:tabnext<CR>i

" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

" change leader key
" let mapleader = ","

" reselect the text that was just pasted
nnoremap <leader>v V`]

" zencoding map
let g:user_emmet_leader_key = ","

" powerline
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
set t_Co=256 " Explicitly tell Vim that the terminal supports 256 colors

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

au BufNewFile *.py 0r ~/.vim/python.skel | let IndentStyle = "python"
au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm set ft=jinja

nmap <F8> :TagbarToggle<CR>

let g:pymode_folding = 0
let g:jsx_ext_required = 0

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype coffee setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype pug setlocal ts=2 sts=2 sw=2
autocmd Filetype elm setlocal ts=2 sts=2 sw=2
autocmd Filetype json setlocal ts=2 sts=2 sw=2
autocmd Filetype wxml setlocal ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal ts=2 sts=2 sw=2
autocmd Filetype typescript setlocal ts=2 sts=2 sw=2


let g:NERDSpaceDelims=1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

autocmd FileType javascript set formatprg=prettier\ --stdin
