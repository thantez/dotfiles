" Plug Section
" Installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'rstacruz/sparkup'
Plug 'terryma/vim-smooth-scroll'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-endwise'
Plug 'elixir-lang/vim-elixir'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

" System defined section
set number
set tabstop=2 shiftwidth=2 expandtab
set hlsearch
set belloff=all
set backspace=indent,eol,start
set copyindent
set smartindent
set splitright
set splitbelow
set hidden
set updatetime=300
set signcolumn=yes
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set laststatus=2

" User defined section
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
let mapleader = ","
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js,*.svelte'
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
let g:powerline_pycmd = 'py3'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Functions
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Keymaps
" -- nerdtree
map <C-n> :NERDTreeToggle<CR>

" -- smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" -- coc
inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" ** Use `[g` and `]g` to navigate diagnostics ** "
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" ** GoTo code navigation. ** "
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" ** Use K to show documentation in preview window. ** "
nnoremap <silent> K :call <SID>show_documentation()<CR>

" ** Highlight the symbol and its references when holding the cursor. ** "
autocmd CursorHold * silent call CocActionAsync('highlight')

" ** Symbol renaming. ** "
nmap <leader>rn <Plug>(coc-rename)

" ** Formatting selected code. ** "
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" **Find symbol of current document.** "
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" **Search workspace symbols.** "
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" **Do default action for next item.** "
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" **Do default action for previous item.** "
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

vmap <C-j> <Plug>(coc-snippets-select)
imap <C-j> <Plug>(coc-snippets-expand-jump)
xmap <leader>x  <Plug>(coc-convert-snippet)
