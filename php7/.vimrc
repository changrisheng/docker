set number
set encoding=utf-8
set fencs=utf-8,GB18030,ucs-bom,default,latin1
set nobomb
set tabstop=4
set cursorline
set confirm
set smartindent
set autoindent
set cindent
set softtabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set showcmd
set showmatch
set matchtime=5
set novisualbell
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][LINE=%l/%L][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)
set cmdheight=2
set backspace=2

"syntax enable
set background=dark
filetype indent on
set spell spelllang=en_us
set undofile
set history=1000
set autoread

set listchars=tab:»■,trail:■
"set listchars=tab:>-,trail:-
set list

set wildmenu
set wildmode=longest:list,full