if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

" Color Themes
Plug 'altercation/vim-colors-solarized'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'mhartington/oceanic-next'

" Autocomplete
function! DoRemote(arg)
	  UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}


" Languages
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'tpope/vim-rails'

" Add plugins to &runtimepath
call plug#end()

" Custom Key Bindings
:map :put_ n
" '\y' Copy to system clipboard
vnoremap <leader>y "+y
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" '\x' Cut to system clipboard
vnoremap <leader>x "+x
nnoremap <leader>x "+x
nnoremap <leader>yy "+yy

" '\d' Deleting without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>dd "_dd
vnoremap <leader>dd "_dd

"General Configuration

autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_ca

syn on
set nu
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=80
set smarttab
set expandtab
set backupcopy=yes
set autoindent

filetype plugin indent on
filetype plugin on


 " For Neovim 0.1.3 and 0.1.4
 let $NVIM_TUI_ENABLE_TRUE_COLOR=1

 " Or if you have Neovim >= 0.1.5
 if (has("termguicolors"))
   set termguicolors
 endif

 " Theme
 syntax enable
 colorscheme OceanicNext
 set background=dark

