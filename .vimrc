set nocompatible
set number

set ai
set expandtab
set shiftwidth=4
set softtabstop=4

syntax enable
set background=dark

let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized

" Override solarized defaults "
hi LineNr ctermbg=none ctermfg=Brown guibg=none guifg=Brown
hi SignColumn ctermbg=none guibg=none
hi NonText ctermfg=Blue ctermbg=none guibg=none

" Return to line position on reopen "
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
