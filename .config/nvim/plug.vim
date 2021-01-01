call plug#begin(stdpath('data') . '/plug')

Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'editorconfig/editorconfig-vim'
Plug 'https://git.zx2c4.com/password-store', { 'rtp': 'contrib/vim' }
Plug 'godlygeek/tabular'
Plug 'tpope/vim-eunuch'

call plug#end()
