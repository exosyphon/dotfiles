syntax on
set nu
set relativenumber
set encoding=UTF-8

 call plug#begin()
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdcommenter'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'airblade/vim-gitgutter'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'HerringtonDarkholme/yats.vim'
call plug#end()

set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let g:NERDTreeIgnore = ['^node_modules']

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set expandtab

nnoremap <C-p> :Files<Cr>
nnoremap <Leader>f :Rg<Cr>

function! NerdTreeToggleFind()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTree
    endif
endfunction

nnoremap <C-n> :call NerdTreeToggleFind()<CR>
