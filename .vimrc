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
Bundle "serverhorror/javascript.vim"
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
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

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

inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" just for xml document, but need not for now.
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                \ '{' : '}',
                \ '[' : ']',
                \ '(' : ')',
                \ '<' : '>'
                \}
    if line('$')>2000
        let line = getline('.')

        let txt = strpart(line, col('.')-1)
    else
        let lines = getline(1,line('$'))
        let line=""
        for str in lines
            let line = line . str . "\n"
        endfor

        let blines = getline(line('.')-1, line("$"))
        let txt = strpart(getline("."), col('.')-1)
        for str in blines
            let txt = txt . str . "\n"
        endfor
    endif
    let oL = len(split(line, a:char, 1))-1
    let cL = len(split(line, PAIRs[a:char], 1))-1

    let ol = len(split(txt, a:char, 1))-1
    let cl = len(split(txt, PAIRs[a:char], 1))-1

    if oL>=cL || (oL<cL && ol>=cl)
        return a:char . PAIRs[a:char] . "\<Left>"
    else
        return a:char
    endif
endfunction
function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
    let ql = len(split(getline('.'), a:quote, 1))-1
    let slen = len(split(strpart(getline("."), 0, col(".")-1), a:quote, 1))-1
    let elen = len(split(strpart(getline("."), col(".")-1), a:quote, 1))-1
    let isBefreQuote = getline('.')[col('.') - 1] == a:quote

    if '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
        " for vim comment.
        return a:quote
    elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
        " for Name's Blog.
        return a:quote
    elseif (ql%2)==1
        " a:quote length is odd.
        return a:quote
    elseif ((slen%2)==1 && (elen%2)==1 && !isBefreQuote) || ((slen%2)==0 && (elen%2)==0)
        return a:quote . a:quote . "\<Left>"
    elseif isBefreQuote
        return "\<Right>"
    else
        return a:quote . a:quote . "\<Left>"
    endif
endfunction

" compile to javascript on write
" au BufWritePost *.coffee silent CoffeeMake!
