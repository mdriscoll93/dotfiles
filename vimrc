"---------------------------------------------------------------------
" Basic Settings
"---------------------------------------------------------------------
syntax on                     " Turn on syntax highlighting
filetype plugin indent on     " Enable filetype detection & indentation
set number                    " Show line numbers

" Optional but nice:
set relativenumber            " Relative line numbers (easier for linewise motions)
set cursorline                " Highlight the line with the cursor

"---------------------------------------------------------------------
" Indentation & Tabs
"---------------------------------------------------------------------
set tabstop=2                " A tab counts as 2 spaces
set shiftwidth=2             " Indentation width is 2
set softtabstop=2            " Allows the use of backspace across 2 spaces
set expandtab                 " Use spaces instead of tab characters
set autoindent               " Copy indent from the current line when starting a new line

"---------------------------------------------------------------------
" Colors & Theme
"---------------------------------------------------------------------
colorscheme desert            " Built-in scheme; choose one you like (e.g. desert, elflord, peachpuff)

" If you find your terminal supports truecolor (24-bit), you can also do:
set termguicolors

"---------------------------------------------------------------------
" Netrw + Vinegar Settings
"---------------------------------------------------------------------
" Vinegar drastically simplifies Netrw navigation, mostly by using '-'
" to open the file explorer in the current directory, and '-' again to go up.

let g:netrw_banner = 0        " Hide the top banner
let g:netrw_liststyle = 3     " Tree-style view (experiment with 1,2,3)
let g:netrw_browse_split = 4  " Open files in prior window
let g:netrw_altv = 1          " Open splits vertically by default
let g:netrw_preview = 1       " Open preview window

" Some people also like:
let g:netrw_keepdir = 0     " Keep your working directory as-is

let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

"---------------------------------------------------------------------
" Additional Options
"---------------------------------------------------------------------
set ignorecase               " Case-insensitive search...
set smartcase                " ...unless you type a capital letter
set incsearch                " Show match as you type
set hlsearch                 " Highlight search matches
set hidden                   " Allows you to switch buffers without saving
set mouse=a                  " Enable mouse in all modes (if you like it)

" End of .vimrc

