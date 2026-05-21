if has('termguicolors')
  set termguicolors
endif

call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tmsvg/pear-tree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'rust-lang/rust.vim'
  Plug 'nordtheme/vim'
call plug#end()

if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!**/.git/*"'
endif

syntax on
filetype plugin indent on
set number
set relativenumber
set backspace=indent,eol,start
set showmatch
set wildmenu
set wildmode=longest:full,full
set path+=**
set incsearch
set hlsearch
set ignorecase
set smartcase
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent
set nobackup
set nowritebackup
set updatetime=750
set signcolumn=yes
set hidden
set termguicolors
set foldmethod=indent
set foldlevel=99
set foldcolumn=1
colorscheme nord

highlight Pmenu guibg=#323232 guifg=#eeeeee
highlight PmenuSel guibg=#4e4e4e guifg=#ffffff

let mapleader = " "
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <CR> <C-^>
nnoremap <leader>h :noh<return>
nnoremap <Tab> za

command! PyRun execute "w" | execute "!python3 %"
command! JavaComp execute "w" | execute "!javac %"
command! JavaRun execute "w" | execute "!javac % && java %:r"
command! RustComp execute "w" | execute "!rustc %"
command! RustRun execute "w" | execute "!rustc % && ./%:r"
command! CargoRun execute "w" | execute "!cargo run"
command! CargoBuild execute "w" | execute "!cargo build"
command! CargoCheck execute "w" | execute "!cargo check"


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <Down> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
inoremap <silent><expr> <Up>   coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if exists('*complete_info')
  inoremap <silent><expr> <cr> complete_info(["selected"])["selected"] != -1 ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
