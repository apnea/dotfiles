" ~/.vimrc or ~/.config/nvim/init.vim

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" === [1] Plugins (using Vim-Plug) ===
call plug#begin('~/.vim/plugged')  " For Neovim: ~/.local/share/nvim/plugged

" Themes
Plug 'morhetz/gruvbox'             " Gruvbox colorscheme
Plug 'vim-airline/vim-airline'      " Status bar
Plug 'vim-airline/vim-airline-themes'

" Functionality
Plug 'preservim/nerdtree'          " File explorer
Plug 'tpope/vim-commentary'         " Easy commenting (gc)
Plug 'sheerun/vim-polyglot'         " Better syntax highlighting

call plug#end()

" === [2] General Settings ===
syntax enable
set number              " Line numbers
set relativenumber      " Relative line numbers
set cursorline          " Highlight current line
set termguicolors       " Enable true colors (24-bit)
set mouse=a             " Enable mouse support
set scrolloff=8         " Keep 8 lines above/below cursor
set nowrap              " Disable line wrapping
set noshowmode          " Hide default mode (replaced by airline)

" Use spaces instead of tabs
set expandtab       " Convert tabs to spaces
set tabstop=4       " Number of spaces a tab counts for
set softtabstop=4   " Number of spaces inserted when pressing <Tab>
set shiftwidth=4    " Number of spaces for autoindent

" Optional: Auto-indent settings
set autoindent      " Copy indent from current line on new line
set smartindent     " Better auto-indent for code blocks

" Optional: Show existing tab characters as visible symbols
set list            " Show invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:␣" Use spaces instead of tabs
set expandtab       " Convert tabs to spaces
set tabstop=4       " Number of spaces a tab counts for
set softtabstop=4   " Number of spaces inserted when pressing <Tab>
set shiftwidth=4    " Number of spaces for autoindent

" Optional: Auto-indent settings
set autoindent      " Copy indent from current line on new line
set smartindent     " Better auto-indent for code blocks

" Optional: Show existing tab characters as visible symbols
set list            " Show invisible characters
set listchars=tab:▸\ ,trail:·,nbsp:␣

" === [3] Colorscheme ===
colorscheme gruvbox
set background=dark     " dark/light

" === [4] Airline (Status Bar) ===
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" === [5] Keybindings ===
nnoremap <C-n> :NERDTreeToggle<CR>  " Toggle file explorer
nnoremap <C-s> :w<CR>               " Save file
nnoremap <C-q> :q<CR>               " Quit
inoremap jk <Esc>                   " Escape with 'jk'

