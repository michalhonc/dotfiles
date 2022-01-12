set directory=/tmp

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
    " Github Copilot
    " Plug 'github/copilot.vim', {'branch': 'release'}
    " Linters & Type Checkers
    " Languages
    Plug 'w0rp/ale'
    Plug 'jason0x43/vim-js-indent'
    Plug 'Quramy/vim-js-pretty-template'
    "Plug 'mxw/vim-jsx'
    Plug 'jparise/vim-graphql'
    " Plug 'pantharshit00/vim-prisma'
    "Plug 'sheerun/vim-polyglot'
    " Svelte
    Plug 'evanleck/vim-svelte', {'branch': 'main'}
    " Find
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'jremmen/vim-ripgrep'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    "" Config
    Plug 'editorconfig/editorconfig-vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'itchyny/lightline.vim'
    Plug 'tpope/vim-surround'
    "" Files
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    " Visuals
    "Plug 'crusoexia/vim-monokai' Modified config is in /nvim/colors
    Plug 'cormacrelf/vim-colors-github'
    " Git
    Plug 'tpope/vim-fugitive'
call plug#end()

highlight nonascii guibg=Red ctermbg=1 term=standout
au BufReadPost * syntax match nonascii "[^\u0000-\u007F]"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NERDTree

" Automaticaly open NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Start NERDTree
" autocmd VimEnter * NERDTree
" Jump to the main window.
" autocmd VimEnter * wincmd p

" Close NERDTree when open file
let NERDTreeQuitOnOpen = 1

" Delete buffer when deleting file
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Close NERDTree if is only tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 

let g:NERDCreateDefaultMappings = 0
let g:NERDTreeChDirMode=2
let g:NERDTreeShowHidden=1
nmap <C-e> :NERDTreeFind<CR>

"Paste in visual mode without copying
xnoremap p pgvy

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" NERDCommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" Mapping
nmap <C-_> <Plug>NERDCommenterToggle
vmap <C-_> <Plug>NERDCommenterToggle<CR>gv


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Git
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']
 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behaviors
set nocursorline
set noerrorbells
set visualbell
" Show line numbers
set number relativenumber

" Don't wrap lines
" set nowrap
" set ma

set re=0
" Enable yanking to the clipboard
set clipboard=unnamed
" set clipboard=unnamedplus " use the clipboards of vim and win
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard

" Do no show -- INSERT--
set noshowmode

" Split windows to right and below natively
set splitright
set splitbelow

" Mapleader (SPACE)
let mapleader = " "

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching
" Highlight search matches
set hlsearch

" Ignore node_modules with command-t
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"

let g:ctrlp_custom_ignore = 'node_modules\|build'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax

" Intellisense
" https://medium.com/vim-drops/javascript-autocompletion-on-vim-4fea7f6934e2
"filetype plugin on
"set omnifunc=syntaxcomplete#Complete
let g:qf_modifiable = 1
" Allow JSX in .js files
let g:jsx_ext_required=0
" Allow Flow
let g:javascript_plugin_flow = 1

set t_Co=256  " vim-monokai now only support 256 colours in terminal.

let g:lightline = {}

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.component_function = {
\   'gitbranch': 'fugitive#head',
\ }

let g:lightline.active = {
\   'left': [[ 'mode', 'paste', 'gitbranch', 'readonly', 'filename', 'modified' ]],
\   'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]],
\ }

"""""""
" Flow
autocmd FileType qf setlocal wrap
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'typescript': ['eslint'],
  \}
let g:ale_fixers = ['prettier']
" let g:ale_fix_on_save = 1

" let g:ale_open_list = 'on_save'
let g:ale_open_list = 0
" let g:ale_echo_cursor = 0
" let g:ale_cursor_detail = 1
let g:ale_set_highlights = 0
" let g:ale_list_window_size = 5
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 1

" Set this if you want to.
" This can be useful if you are combining ALE with
" some other plugin which sets quickfix errors, etc.
let g:ale_keep_list_window_open = 0
let g:ale_sign_warning = '>'
let g:netrw_winsize=30
" Set this in your vimrc file to disabling highlighting
let g:ale_linters_ignore = {
      \ 'javascript': ['tsserver'],
      \ 'javascriptreact': ['tsserver'],
      \}
set shortmess=at
set cmdheight=1

"colorscheme sublimemonokai
colorscheme monokai
" colorscheme github

" if you use airline / lightline
let g:airline_theme = "github"
let g:lightline = { 'colorscheme': 'github' }

"autocmd FileType typescriptreact colorscheme desert
"autocmd FileType typescript colorscheme desert
"autocmd FileType typescript.tsx colorscheme desert
"autocmd FileType javascript colorscheme sublimemonokai
"autocmd FileType javascript colorscheme monokai

nnoremap <expr> <C-m> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

set laststatus=2

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab
set nolist
" Mapping
" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
nnoremap <expr> <C-[> ':Files %:p:h'."\<cr>"

" Move lines up and down Alt-j Alt-k
nnoremap <Esc>j :m .+1<CR>==
nnoremap <Esc>k :m .-2<CR>==
inoremap <Esc>j <Esc>:m .+1<CR>==gi
inoremap <Esc>k <Esc>:m .-2<CR>==gi
vnoremap <Esc>j :m '>+1<CR>gv=gv
vnoremap <Esc>k :m '<-2<CR>gv=gv

nnoremap <C-F> :Ag<Space>
" nnoremap <C-F> :Rg<Space>
let g:rg_highlight='true'

" Type `gd` to go to definition
nnoremap <silent> gd :ALEGoToDefinition<CR>
" AutoFix
noremap <silent> <F2> :ALEFix<CR>
" Meta-click (command-click) to go to definition
nnoremap <M-LeftMouse> <LeftMouse>:ALEGoToDefinition<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Disable arrow key
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Disable new space with Enter
noremap <Enter> <NOP>

set autoindent
" Add new line after
" TODO: zprovoznit Ctrl+Enter
nmap <NL><Enter> O<Esc>
nmap <Enter> o<Esc>

" Easy motion
nmap s <Plug>(easymotion-s2)

" Copy relative path
noremap <silent> <F4> :let @+=expand("%")<CR>

" Save with space
nnoremap <leader> :update<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>f :ALEFix<CR>

noremap <silent> <F1> :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')<cr>
