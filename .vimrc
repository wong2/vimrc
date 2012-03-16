" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off 

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle "gmarik/vundle"
Bundle "mattn/zencoding-vim"
Bundle "ervandew/supertab"
Bundle "scrooloose/nerdtree"
Bundle "pangloss/vim-javascript"
Bundle "jsbeautify"
Bundle "tpope/vim-fugitive"
Bundle "vim-coffee-script"
Bundle "Markdown"

filetype plugin indent on 

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" ColorScheme
syntax enable

" nerd tree plugin
nnoremap <C-d> :NERDTreeToggle<CR>

" Show line number
set number

" Incremental search
set incsearch
" highlight search
set hlsearch    
" toggle between paste and normal: for 'safer' pasting from keyboard
set pastetoggle=<F12> 

set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

" Sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

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
