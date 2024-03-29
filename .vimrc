set nocompatible              " be iMproved, required
filetype off                  " required


 " set the runtime path to include Vundle and initialize
 set rtp+=~/.vim/bundle/Vundle.vim
 call vundle#begin()
 " alternatively, pass a path where Vundle should install plugins
 "call vundle#begin('~/some/path/here')

 " let Vundle manage Vundle, required
 Plugin 'VundleVim/Vundle.vim'
 Plugin 'frazrepo/vim-rainbow'
 Plugin 'vim-airline/vim-airline'
 Plugin 'vim-airline/vim-airline-themes'
 "Plugin 'altercation/vim-colors-solarized'
 Plugin 'preservim/nerdtree'
 Plugin 'airblade/vim-gitgutter'
 " The following are examples of different formats supported.
 " Keep Plugin commands between vundle#begin/end.
 " plugin on GitHub repo
 " Plugin 'tpope/vim-fugitive'
 " plugin from http://vim-scripts.org/vim/scripts.html
 " Plugin 'L9'
 " Git plugin not hosted on GitHub
 Plugin 'tarikgraba/vim-liberty'
 " Plugin 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (i.e. when working on your own plugin)
 " Plugin 'file:///home/gmarik/path/to/plugin'
 " The sparkup vim script is in a subdirectory of this repo called vim.
 " Pass the path to set the runtimepath properly.
 " Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
 " Install L9 and avoid a Naming conflict if you've already installed a
 " different version somewhere else.
 " Plugin 'ascenator/L9', {'name': 'newL9'}

 " All of your Plugins must be added before the following line
 call vundle#end()            " required
 filetype plugin indent on    " required
 " To ignore plugin indent changes, instead use:
 "filetype plugin on
 "
 " Brief help
 " :PluginList       - lists configured plugins
 " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
 " :PluginSearch foo - searches for foo; append `!` to refresh local cache
 " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
 "
 " see :h vundle for more details or wiki for FAQ
 " Put your non-Plugin stuff after this line
 
set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim
set nu
colorscheme darkblue
set cursorcolumn
set cursorline
try
source ~/.vim_runtime/my_configs.vim
catch
endtry

au! Syntax upf source ~/.vim_runtime/syntax/upf.vim
au BufRead,BufNewFile *.upf set filetype=upf

au BufRead,BufNewFile *.lib set filetype=liberty
au BufRead,BufNewFile *.lib.gz set filetype=liberty
au BufRead * normal zR

set guifont=Monospace

map <F8> :tabp<CR>
map <F9> :tabn<CR>


"" Plugin configurations:
let g:rainbow_active = 1
let g:airline#extensions#tabline#enabled = 1

syntax enable
set nowrap
