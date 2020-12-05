" +-----------------------------------------------------------------------------+
" | Plugins                                                                     |
" +-----------------------------------------------------------------------------+
call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator' " move between vim & tmux
"Plug 'benmills/vimux' " send input to tmux pane
Plug 'git://github.com/Townk/vim-autoclose.git'
Plug 'tpope/vim-surround' " add/change/remove ' ( [ { ...
Plug 'tpope/vim-unimpaired' " [] mappings
"Plug 'sjl/gundo.vim' " visual undo
Plug 'scrooloose/nerdtree' " directory tree

" +---- colorschemes
Plug 'dracula/vim' " dark
Plug 'NLKNguyen/papercolor-theme' " light

" +---- code related
Plug 'tmhedberg/matchit' " % for tags
Plug 'chaoren/vim-wordmotion' " camelCase & snake_case => Word motions
Plug 'scrooloose/nerdcommenter' " toggle comments
"Plug 'Yggdroot/indentLine' " show lines on space-indented code
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb' " git and Gbrowse
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " snippets engine and the snippets
"Plug 'mhinz/vim-signify' " diff in the sign column

"let g:ale_completion_enabled = 1
"Plug 'dense-analysis/ale'

" +---- language specific plugins
"Plug 'aklt/plantuml-syntax'
"Plug 'lmeijvogel/vim-yaml-helper' " yaml traversing
" +---- ruby
"Plug 'vim-ruby/vim-ruby'
"Plug 'danchoi/ri.vim'
"Plug 'hallison/vim-rdoc'
"Plug 'ecomba/vim-ruby-refactoring'
"Plug 'tpope/vim-rails'
"Plug 'jgdavey/vim-turbux'
" +---- python
"Plug 'KangOl/vim-pudb'
" +---- markdown
"Plug 'greyblake/vim-preview'
"Plug 'godlygeek/tabular'
"Plug 'ajorgensen/vim-markdown-toc', {'for': 'markdown'}
"Plug 'rhysd/vim-gfm-syntax', {'for': 'markdown'}
"Plug 'Scuilion/markdown-drawer', {'for': 'markdown'}
"let g:gfm_syntax_emoji_conceal=1
"autocmd BufRead,BufNewFile *.md setlocal spell
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
"Plug 'JamshedVesuna/vim-markdown-preview'
"Plug 'shime/vim-livedown'
call plug#end() " sets filetype plugin indent on and syntax enable

" +-----------------------------------------------------------------------------+
" | :set options                                                                |
" +-----------------------------------------------------------------------------+
set encoding=utf-8
set shell=/usr/local/bin/fish\ -li

set background=dark
colorscheme dracula
"set background=light
"colorscheme PaperColor

" characters displayed as whitespaces: set list
set showbreak=\\
set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~

set cursorline
set relativenumber
set noshowmode " do not display mode on the last line
set laststatus=2 " last window always has a status line
set scrolloff=5 " number of screen lines above/below cursor
set display=lastline " display as much as possible of the last line, print @@@ indicator
set showmatch " jump to matching bracket after inserting it
set autoindent
set wrap " wrap long lines
set linebreak " and do it sensibly, e.g. not in the middle of a word
set formatoptions+=j " remove comment leader when joining lines

set shiftwidth=2 " spaces number for indent
set tabstop=2 " width of tab (spaces number per tab)
set expandtab " tabs = spaces

set hlsearch " higlight all search matches
set incsearch " search while typing
set ignorecase " ignore case while searching
set smartcase " unless there are some capitals
set magic " no need to escape special characters

set wildmenu " vertical command line completion
set wildmode=list:full " list all matches and complete each
set wildignore+=.git,*.sw?,DS_STORE " ignore these when expanding wildcards
set completeopt=menuone,preview,longest " insert mode completion: show menu even for one match, display additional info, insert longest common text

set noerrorbells
set novisualbell

set hidden " allow opening a new file, while having unsaved changes
set autoread " read the file if it was changed outside of vim

set fillchars=diff:⣿ " what to fill deleted lines with => git diff

set backupdir=~/.vim/tmp/backup/
set directory=~/.vim/tmp/swap/
set backup
set viminfo='50,<50,s10,h,:0,n~/.vim/.viminfo

au FocusLost * :silent! wall
"au VimResized * :wincmd =

" +-----------------------------------------------------------------------------+
" | mappings                                                                    |
" +-----------------------------------------------------------------------------+
inoremap jk <Esc>
nnoremap § ;
nnoremap ; :
nnoremap Q :q!
nnoremap <Leader>s :w
set pastetoggle=<F2>
nmap <F4> :set clipboard=unnamed
cnorea w!! w !sudo tee % > /dev/null
map <leader>e :tabe! ~/.vimrc
autocmd! bufwritepost .vimrc source ~/.vimrc " reload vimrc on save
nmap <Leader>D :%d
nmap <Leader>Y :%y
map <Leader>yf :s/false/true/
map <Leader>yt :s/true/false/
" clear the highlighting of :set hlsearch
nnoremap <silent> <C-I> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" +-----------------------------------------------------------------------------+
" | vim as a manpager                                                           |
" +-----------------------------------------------------------------------------+
autocmd FileType man match NONE
if exists("$MANPAGER")
  let $MANPAGER = ""
endif
if exists("$PAGER")
  let $PAGER = ""
endif
if $VIM_CRONTAB == "true"
  set nobackup
  set nowritebackup
endif

" +-----------------------------------------------------------------------------+
" | plugin's configuration                                                      |
" +-----------------------------------------------------------------------------+
" Plug 'vim-airline/vim-airline'
let g:airline_theme='papercolor'
let g:airline_powerline_fonts=1
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'n',
    \ 'i'  : 'i',
    \ 'R'  : 'R',
    \ 'c'  : 'c',
    \ 'v'  : 'v',
    \ 'V'  : 'V',
    \ '^V' : '^V',
    \ 's'  : 's',
    \ 'S'  : 'S',
    \ '^S' : '^S',
    \ }

" Plug 'junegunn/fzf.vim'
nnoremap <Leader>A :Ag 
nnoremap  :GFiles
nnoremap  :Buffers

" Plug 'tpope/vim-fugitive'
nnoremap <Leader>g :Gstatus5j
nnoremap <Leader>w :Gwrite
nnoremap <Leader>r :Gread
autocmd Filetype gitcommit setlocal spell textwidth=72

autocmd BufReadPost fugitive://* set bufhidden=delete
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
"highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

" Plug 'vim-ruby/vim-ruby'
"let ruby_space_errors=1

" Plug 'SirVer/ultisnips'
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1

"map <Leader>rl :call VimuxRunCommand("clear; env RAILS_ENV=test bundle exec rspec " . bufname("%") . ":" . line('.'))
"map <Leader>rb :call VimuxRunCommand("clear; env RAILS_ENV=test bundle exec rspec " . bufname("%"))
"map <Leader>rs :call VimuxRunCommand("clear; env RAILS_ENV=test bundle exec rspec")
"map <Leader>rr :call VimuxRunCommand("clear; python3 contemplate_koans.py")
"map <Leader>rc :call VimuxRunCommand("clear; check_current")
"map <Leader>rc :call VimuxRunCommand("clear; rubocop -R " . bufname("%"))
"map <Leader>u :call VimuxRunCommand("clear; plantuml -progress -failfast " . bufname("%") . " && open " . expand("%:p:r") . ".png")

" Plug 'mhinz/vim-signify'
"let g:signify_vcs_list = ['git']
" highlight lines in Sy and vimdiff etc.)
"highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
"highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
"highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
" highlight signs in Sy
"highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
"highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
"highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Plug 'dense-analysis/ale'
"nmap <silent> <C-m> <Plug>(ale_previous)
"nmap <silent> <C-n> <Plug>(ale_next)

" +-----------------------------------------------------------------------------+
" | TODO                                                                        |
" +-----------------------------------------------------------------------------+
"folding?
"mksession
"smartindent?
"spell?
