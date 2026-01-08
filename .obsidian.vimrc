" Use system clipboard by default
set clipboard=unnamed

" Remap go and gO to start new lines without moving cursor 
nnoremap go o<Esc>k
nnoremap gO O<Esc>j

" Remap BS to "_d
nnoremap <BS> "_d
vnoremap <BS> "_d

" Surround visual selection with backticks when pressing g`
vnoremap g` <Esc>`>a`<Esc>`<i`<Esc>
