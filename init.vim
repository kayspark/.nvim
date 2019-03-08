"cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local/Cellar/nmengine/1.0.2) Environment Variables:

"let $XDG_RUNTIME_DIR = expand('/run/user/501')
let $XDG_CACHE_HOME = expand($HOME.'/.cache')
let $XDG_CONFIG_DIRS = expand('/etc/xdg')
let $XDG_CONFIG_HOME = expand($HOME.'/.config')
let $XDG_DATA_DIRS = expand('/usr/local/share:/usr/share')
let $XDG_DATA_HOME = expand($HOME.'/.local/share')

let $ANSIBLE_VAULT_PASSWORD_FILE = expand($XDG_CONFIG_HOME . '/ansible-vault/vault_password')

let s:gopath = expand('$HOME/go') . '/src'
let s:srcpath = expand('$HOME/Documents/')
" -------------------------------------------------------------------------------------------------
" Neovim Configs:
if has('macunix')
  let g:ruby_host_prog = '/usr/local/bin/ruby'
  let g:python_host_prog = '/usr/local/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
  let s:python2_include_dir = '/usr/local/opt/python2/Frameworks/Python.framework/Headers'
  let s:python3_include_dir = '/usr/local/opt/python3/Frameworks/Python.framework/Headers'
  set wildignore+=*.DS_Store  " macOS only
  let g:clipboard = {
        \   'name': 'macOS-clipboard',
        \   'copy': {
        \      '+': 'pbcopy',
        \     '*': 'pbcopy',
        \    },
        \   'paste': {
        \      '+': 'pbpaste',
        \      '*': 'pbpaste',
        \   },
        \   'cache_enabled': 1,
        \ }

elseif has ('unix')
  let g:ruby_host_prog = '/usr/bin/ruby'

  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
  let s:python2_include_dir = '/usr/include/python2.7'
  let s:python3_include_dir = '/usr/include/python3.7m'
endif

let g:loaded_python_provider = 1
" -------------------------------------------------------------------------------------------------
" GlobalAutoCmd:

augroup GlobalAutoCmd
  autocmd!
augroup END
command! -nargs=* Gautocmd   autocmd GlobalAutoCmd <args>
command! -nargs=* Gautocmdft autocmd GlobalAutoCmd FileType <args>
" -------------------------------------------------------------------------------------------------
" Global Settings:

set autoindent
set backup
set backupdir=$XDG_DATA_HOME/nvim/backup
set belloff=all
set cinoptions+=:0,g0,N-1,m1
set clipboard^=unnamedplus
set cmdheight=2
set complete=.  " default: .,w,b,u,t
set completeopt=menuone,noinsert,noselect  " longest
set concealcursor=niv
set conceallevel=1
set cursorline
set cursorcolumn
"
set directory=$XDG_DATA_HOME/nvim/swap
set expandtab
set fillchars="diff:⣿,fold: ,vert:│"
set fileformats=unix,mac,dos
set foldcolumn=0
set foldmethod=indent
set foldnestmax=1  " maximum fold depth
set formatoptions+=c  " Autowrap comments using textwidth
set formatoptions+=j  " Delete comment character when joining commented lines
set formatoptions+=l  " do not wrap lines that have been longer when starting insert mode already
set formatoptions+=n  " Recognize numbered lists
set formatoptions+=q  " Allow formatting of comments with "gq".
set formatoptions+=r  " Insert comment leader after hitting <Enter>
set formatoptions+=t  " Auto-wrap text using textwidth
set helplang & helplang=en,ko  " Hey, if true Vim master, use English help language.
set hidden
set history=10000
set ignorecase
"set inccommand=nosplit
set laststatus=2
set linebreak
set list & listchars=nbsp:%,tab:»-,trail:_
set makeprg="make -j4"
set matchtime=0  " disable nvim matchparen
set maxmempattern=1000  " max: 2000000
set modeline
set modelines=5
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
  set balloondelay=250
  set ballooneval
  set balloonevalterm
endif
set noswapfile
set number
set packpath=
set path=$PWD/**
set previewheight=10
set pumheight=40
set regexpengine=2
set ruler
"set scrollback=-1
set scrolljump=1
set scrolloff=10
set secure
set shiftround
set shiftwidth=2
set shortmess=filnxtToOFc  " default: shortmess=filnxtToOF
set showfulltag
set showmatch
set showmode
set showtabline=2
set sidescrolloff=3
set signcolumn=yes
set smartcase
set smartindent
set softtabstop=2
set splitbelow
set splitright
set switchbuf=useopen
set synmaxcol=3000  " 0: unlimited
set tabstop=2
set tags=./tags;  " http://d.hatena.ne.jp/thinca/20090723/1248286959
set termguicolors
set textwidth=0
set timeout  " mappnig timeout
set timeoutlen=500
set ttimeout  " keycode timeout
set ttimeoutlen=5
set undodir=$XDG_DATA_HOME/nvim/undo
set undofile
set undolevels=10000
set updatetime=500
set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png            " image
set wildignore+=*.manifest                                " gb
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.out,*.class  " compiler
set wildignore+=*.swp,*.swo,*.swn                         " vim
set wildignore+=*.ycm_extra_conf.py,*.ycm_extra_conf.pyc  " YCM
set wildignore+=*/.git,*/.hg,*/.svn                       " vcs
set wildignore+=tags,*.tags                               " tags
set wildmode=longest,list:full  " http://stackoverflow.com/a/526940/5228839
set wrap

set noautochdir
set noerrorbells
set nofoldenable
set nolazyredraw
set noshiftround
set nostartofline
set noswapfile
set notitle
set nowrapscan
set nowritebackup


set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h14
set background=dark
if has ("gui_running")
  set transparency=20
endif


" mkdir backupdir
if !isdirectory(&backupdir)
  call mkdir(&backupdir, "p")
endif
" mkdir swapdir
if !isdirectory(&directory)
  call mkdir(&directory, "p")
endif
" mkdir undodir
if !isdirectory(&undodir)
  call mkdir(&undodir, "p")
endif

if isdirectory(s:python2_include_dir)
  set path+=s:python2_include_dir
endif
if isdirectory(s:python3_include_dir)
  set path+=s:python3_include_dir
endif

" add $CPATH directories to &path
for s:cpath in split($CPATH, ":")
  exec 'set path+=' . s:cpath
endfor

" -------------------------------------------------------------------------------------------------
" Ignore Plugins:

"let g:did_install_default_menus = $VIMRUNTIME/menu.vim
"let g:did_menu_trans            = 1 " $VIMRUNTIME/menu.vim
let g:load_doxygen_syntax       = 1 " $VIMRUNTIME/syntax/doxygen.vim
let g:loaded_2html_plugin       = 1 " $VIMRUNTIME/plugin/tohtml.vim
let g:loaded_gzip               = 1 " $VIMRUNTIME/plugin/gzip.vim
let g:loaded_less               = 1 " $VIMRUNTIME/macros/less.vim
"let g:loaded_matchit            = 1 " $VIMRUNTIME/plugin/matchit.vim
let g:loaded_matchparen         = 1 " $VIMRUNTIME/plugin/matchparen.vim
let g:loaded_netrw              = 1 " $VIMRUNTIME/autoload/netrw.vim
let g:loaded_netrwFileHandlers  = 1 " $VIMRUNTIME/autoload/netrwFileHandlers.vim
let g:loaded_netrwPlugin        = 1 " $VIMRUNTIME/plugin/netrwPlugin.vim
let g:loaded_netrwSettings      = 1 " $VIMRUNTIME/autoload/netrwSettings.vim
let g:loaded_rrhelper           = 1 " $VIMRUNTIME/plugin/rrhelper.vim
let g:loaded_spellfile_plugin   = 1 " $VIMRUNTIME/plugin/spellfile.vim
let g:loaded_sql_completion     = 1 " $VIMRUNTIME/autoload/sqlcomplete.vim
let g:loaded_syntax_completion  = 1 " $VIMRUNTIME/autoload/syntaxcomplete.vim
let g:loaded_tar                = 1 " $VIMRUNTIME/autoload/tar.vim
let g:loaded_tarPlugin          = 1 " $VIMRUNTIME/plugin/tarPlugin.vim
let g:loaded_tutor_mode_plugin  = 1 " $VIMRUNTIME/plugin/tutor.vim
let g:loaded_vimball            = 1 " $VIMRUNTIME/autoload/vimball.vim
let g:loaded_vimballPlugin      = 1 " $VIMRUNTIME/plugin/vimballPlugin
let g:loaded_zip                = 1 " $VIMRUNTIME/autoload/zip.vim
let g:loaded_zipPlugin          = 1 " $VIMRUNTIME/plugin/zipPlugin.vim
let g:myscriptsfile             = 1 " $VIMRUNTIME/scripts.vim
let g:netrw_nogx                = 1
let g:suppress_doxygen          = 1 " $VIMRUNTIME/syntax/doxygen.vim

" -------------------------------------------------------------------------------------------------

" Dein:

filetype plugin indent on
syntax enable
let s:dein_cache_dir = $XDG_CACHE_HOME . '/nvim/dein'
if !isdirectory(s:dein_cache_dir)
  call mkdir(s:dein_cache_dir, 'p')
endif
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
  if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
    let s:dein_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

let g:dein#install_max_processes = 3
let g:dein#types#git#default_protocol = 'https'
let g:dein#types#git#clone_depth = 1

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir, expand('<sfile>'))

  " Develop Plugins:


  " Dein:
  call dein#add('Shougo/dein.vim')
  call dein#add('dracula/vim')
  "call dein#add('nanotech/jellybeans.vim')

  " Completion Deoplete:
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif
call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })  
  call dein#add('Shougo/neco-vim', { 'on_ft': ['vim'] })
  "  call dein#add('LuXuryPro/deoplete-rtags', { 'on_ft': ['c', 'cpp', 'objc', 'objcpp'] })
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim', { 'depends': ['neosnippet-snippets'] })
  "" support
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('Shougo/neoinclude.vim', { 'on_ft': ['c', 'cpp', 'objc', 'objcpp'] })
  call dein#add('Shougo/echodoc.vim')
  call dein#add('Shougo/neopairs.vim', { 'on_event': 'CompleteDone' })
  "call dein#add('Shougo/deoppet.nvim')


  " Denite:
  call dein#add('Shougo/denite.nvim')
  "" dependency
  " call dein#local(s:srcpath, { 'frozen': 1, 'merged': 0 }, ['nixprime/cpsm'])  " can't build with pypy3
  "" suorces
  " LLDB and GDB
  call dein#add('sakhnik/nvim-gdb', { 'rev': 'next', 'build': 'bash install.sh' })
  "
  " LanguageClient:
  call dein#add('autozimu/LanguageClient-neovim', { 'rev': 'next', 'build': 'bash install.sh' })

  " Filer:
  call dein#add('cocopon/vaffle.vim')
  " call dein#add('Shougo/defx.nvim')
  call dein#add('philip-karlsson/bolt.nvim')

  " Git:
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive.git')
  "

  " Linter:
  call dein#add('w0rp/ale')
  call dein#add('machakann/vim-vimhelplint')

  " Formatter:
  "  call dein#add('rhysd/vim-clang-format', { 'on_ft': ['c', 'cpp', 'objc', 'objcpp', 'proto', 'javascript', 'java', 'typescript'] })

  let g:clang_format#code_style='llvm'
  let g:clang_format#detect_style_file=1
  let g:clang_format#enable_fallback_style=1
  let g:clang_format#auto_format_on_insert_leave=1
  "
  " References:

  " Interface:
  call dein#add('itchyny/lightline.vim')
  call dein#add('maximbaz/lightline-ale')
  call dein#add('mgee/lightline-bufferline')  
  "  call dein#add('vim-airline/vim-airline')
  "  call dein#add('vim-airline/vim-airline-themes', { 'depends': ['vim-airline/vim-airline'] })
  call dein#add('ryanoasis/vim-devicons')

  "  " Operator:
  "  call dein#add('kana/vim-operator-user')
  "  call dein#add('kana/vim-operator-replace', { 'on_map': '<Plug>', 'depends': 'vim-operator-user' })
  "  call dein#add('rhysd/vim-operator-surround', { 'on_map': '<Plug>', 'depends': 'vim-operator-user' })

  " Utility:
  call dein#add('Shougo/vimproc.vim', {'build': 'make'})
  "call dein#local(s:gopath.'/github.com',  { 'frozen': 1, 'merged': 0 }, ['utahta/trans.nvim'])
  call dein#add('cocopon/colorswatch.vim', { 'on_cmd': ['ColorSwatchGenerate'] })
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('haya14busa/dein-command.vim', { 'on_cmd': ['Dein'] })
  call dein#add('haya14busa/vim-asterisk', { 'on_map': ['<Plug>'] })
  "  call dein#add('itchyny/vim-parenmatch')
  call dein#add('junegunn/vim-easy-align', {'on_map': '<Plug>'})

  call dein#add('craigemery/vim-autotag')

  call dein#add('mattn/benchvimrc-vim', { 'on_cmd': ['BenchVimrc'] })
  call dein#add('mattn/sonictemplate-vim', { 'on_cmd': ['Template'] })
  call dein#add('rhysd/accelerated-jk', { 'on_map': ['<Plug>'] })
  call dein#add('thinca/vim-quickrun', { 'on_cmd': ['Capture'] })
  call dein#add('tyru/caw.vim', { 'on_map': ['<Plug>'] })
  call dein#add('tyru/open-browser-github.vim', { 'on_cmd': ['OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq'], 'depends': 'open-browser.vim' })
  call dein#add('tyru/open-browser.vim')

  " Lifelog:
  "  call dein#add('wakatime/vim-wakatime')

  " -------
  " Language Plugin:

  "" C Family:
  "  call dein#add('vim-jp/vim-cpp')
  call dein#add('octol/vim-cpp-enhanced-highlight')
  call dein#add('bfrg/vim-cpp-modern')
  "  call dein#add('lyuts/vim-rtags', { 'on_ft': ['c', 'cpp', 'objc', 'objcpp'] })
  "" Swift:
  call dein#add('keith/swift.vim')
  "" CMake:
  call dein#add('pboettch/vim-cmake-syntax')
  "  call dein#add('vhdirk/vim-cmake')

  "" LLVM TableGen:
  call dein#local($HOME.'/src/', { 'frozen': 1, 'merged': 0, 'rtp': 'utils/vim' }, ['llvm.org/llvm'])
  "" Python:
  call dein#add('davidhalter/jedi-vim', {'lazy': 1, 'on_ft': ['python', 'cython', 'pyrex'] })
  call dein#add('hynek/vim-python-pep8-indent')
  call dein#local($HOME.'/src/', { 'frozen': 1, 'merged': 0 }, ['tweekmonster/impsort.vim'])

  "" Rust:
  call dein#add('rust-lang/rust.vim', { 'on_ft': ['rust'] })

  "" Docker:
  call dein#add('ekalinin/Dockerfile.vim')

  "" Kubernetes:
  "  call dein#add('andrewstuart/vim-kubernetes')
  "" Lua:

  "" Serializer:
  call dein#add('uarun/vim-protobuf')

  "" Bazel:
  call dein#add('google/vim-maktaba')
  call dein#add('bazelbuild/vim-bazel', { 'on_ft': ['bazel'] })

  "" Assembly:
  call dein#add('Shirk/vim-gas')

  "" TypeScript:
  call dein#add('HerringtonDarkholme/yats.vim')

  "" Binary:
  call dein#add('Shougo/vinarise.vim', { 'on_cmd': ['Vinarise', 'VinarisePluginDump'] })

  "" Markdown:
  call dein#add('moorereason/vim-markdownfmt')

  "" Vim:
  call dein#add('vim-ko/vim-ko')
  call dein#add('vim-jp/syntax-vim-ex')

  "" Shell:
  call dein#add('chrisbra/vim-sh-indent')

  "" Yaml:
  call dein#add('stephpy/vim-yaml')

  "" Toml:
  call dein#add('cespare/vim-toml')

  "" Json:
  call dein#add('elzr/vim-json')

  "" JsonSchema:
  call dein#add('Quramy/vison')

  "" GraphQL:
  call dein#add('jparise/vim-graphql')

  "" Tmux:
  "call dein#add('tmux-plugins/vim-tmux')

  "" TerraFrom:
  call dein#add('hashivim/vim-terraform')

  "" Protobuf:
  call dein#add('uarun/vim-protobuf')
  call dein#add('uber/prototool', {'rtp': 'vim/prototool'} )

  "" TinyScheme:  for macOS sandbox-exec profile *.sb tinyscheme filetype
  call dein#add('vim-scripts/vim-niji', { 'on_ft': ['scheme'] })

  "" PlantUML:
  "call dein#add('aklt/plantuml-syntax')
  "call dein#add('scrooloose/vim-slumlord')

  " Testing Plugin:
  call dein#add('scrooloose/nerdtree')
  "  call dein#add('zebult/auto-gtags.vim')
  "  call dein#add('gilligan/vim-lldb')
  call dein#add('mileszs/ack.vim')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-markdown')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-unimpaired')
  call dein#add('tpope/vim-abolish')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

if !exists('g:syntax_on')
  syntax enable
endif
let g:enable_bold_font = 1
"colorscheme hybrid_reverse
" Ack:
nmap <M-k>    :Ack! "\b<cword>\b" <CR>
nmap <Esc>k   :Ack! "\b<cword>\b" <CR>
nmap <M-S-k>  :Ggrep! "\b<cword>\b" <CR>
nmap <Esc>K   :Ggrep! "\b<cword>\b" <CR>
" -------------------------------------------------------------------------------------------------
" Color:

"" Global:
"highlight! TermCursor    gui=none      guifg=#222222    guibg=#ffffff
"highlight! TermCursorNC  gui=reverse   guifg=#222222    guibg=#ffffff

"" Go:
" vim-go-stdlib:
"let g:go_highlight_error = 1
"let g:go_highlight_return = 0
"" #cc6666
"highlight! goStdlibErr        gui=Bold    guifg=#ff005f    guibg=None
"highlight! goString           gui=None    guifg=#92999f    guibg=None
"highlight! goComment          gui=None    guifg=#838c93    guibg=None
"highlight! goField            gui=Bold    guifg=#a1cbc5    guibg=None
"highlight! link               goStdlib          Statement
"highlight! link               goStdlibReturn    PreProc
"highlight! link               goImportedPkg     Statement
"highlight! link               goFormatSpecifier PreProc

"" Python:
highlight! pythonSpaceError   gui=None    guifg=#787f86    guibg=#787f86
highlight! link pythonDelimiter    Special
highlight! link pythonNone    pythonFunction
highlight! link pythonSelf    pythonOperator
syn keyword pythonDecorator True False

"" C:
let g:c_ansi_constants = 1
let g:c_ansi_typedefs = 1
let g:c_comment_strings = 1
let g:c_gnu = 0
let g:c_no_curly_error = 1
let g:c_no_tab_space_error = 1
let g:c_no_trail_space_error = 1
let g:c_syntax_for_h = 0
"highlight! cCustomFunc  gui=Bold    guifg=#f0c674    guibg=None
"highlight! cErr         gui=Bold    guifg=#ff005f    guibg=None
"
" CPP:
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" EASYTAGS
"let g:easytags_opts = ['--c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++']
"let g:easytags_include_members = 1
"let g:easytags_resolve_links = 0
""let g:easytags_events = ['BufWritePost']
"let g:easytags_autorecurse = 0
"let g:easytags_async = 0

"" Vim:
"Gautocmdft qf hi Search     gui=None    guifg=None  guibg=#373b41
""" Denite:
" guibg=#343941

highlight! DeniteMatchedChar guifg=#85678f
highlight! DeniteMatchedRange guifg=#f0c674
highlight! DenitePreviewLine guifg=#85678f
highlight! DeniteUnderlined guifg=#85678f

"" ParenMatch:
"highlight! ParenMatch    gui=underline guifg=none       guibg=#343941
"
" -------------------------------------------------------------------------------------------------
" Initialize Syntax:

silent! filetype plugin indent on

" -------------------------------------------------------------------------------------------------
" Gautocmd:
if has('mac')
  Gautocmdft c,cpp,objc,objcpp source $XDG_CONFIG_HOME/nvim/path/macOS_header.vim  " only Go and C family filetype
endif
" Global:
" always jump to the last known cursor position
"  https://github.com/neovim/neovim/blob/master/runtime/vimrc_example.vim
function! s:autoJump()
  if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' && &filetype != 'gitrebase'
    execute "silent! keepjumps normal! g`\"zz"
  endif
endfunction
Gautocmd BufWinEnter * call s:autoJump()

"" automatically close window
"  http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
function! s:autoClose()
  let s:ft = getbufvar(winbufnr(winnr()), "&filetype")
  if winnr('$') == 1 &&
        \ s:ft == "qf" || s:ft == 'vaffle'  " || s:ft == 'diff'
    quit!
  endif
endfunction
Gautocmd WinEnter * call s:autoClose()

" macOS Frameworks and system header protection
Gautocmd BufNewFile,BufReadPost
      \ /System/Library/*,/Applications/Xcode*,/usr/include*,/usr/lib*
      \ setlocal readonly nomodified

Gautocmdft help,man,qf,quickrun,ref call LessMap()  " less like keymappnig
Gautocmd BufEnter option-window call LessMap()  " :option have not filetype
Gautocmd BufEnter __LanguageClient__ call LessMap()

"" Terminel Settings:
function! s:nvim_terminal_config()
  if exists('g:loaded_nvim_terminal_config')
    silent! finish
  endif
  let g:loaded_nvim_terminal_config = 1

  let g:terminal_scrollback_buffer_size = 100000
  let s:num = 0
  "        black      red        green      yellow     blue       magenta    cyan       white
  for s:color in [
        \ '#101112', '#b24e4e', '#9da45a', '#f0c674', '#5f819d', '#85678f', '#5e8d87', '#707880',
        \ '#373b41', '#cc6666', '#a0a85c', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6',
        \ ]
    let g:terminal_color_{s:num} = s:color
    let s:num += 1
  endfor
endfunction
"Gautocmd TermOpen * call s:nvim_terminal_config()
"Gautocmd TermOpen * setlocal nonumber sidescrolloff=0 scrolloff=0 statusline=%{b:term_title}
Gautocmd BufNewFile,BufRead,BufEnter term://* startinsert
Gautocmd BufLeave term://* stopinsert

"" Deoplete:
" Gautocmd InsertEnter * call deoplete#enable()  " slow

"" LanguageClient Neovim:
function! s:languageclient_setup()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    " Gautocmdft c,cpp,dockerfile,go,graphql,objc,python,rust,sh,yaml,zsh silent! LanguageClientStart
    Gautocmdft c,cpp,python,qml,docckerfile,go,graphql,objc,rust,sh,yaml,zsh setlocal formatexpr=LanguageClient#textDocument_rangeFormatting()
    " Gautocmd User LanguageClientStart call s:lsp_yaml_set_schema('')
    Gautocmd User LanguageClientBufReadPost call s:lsp_yaml_set_schema('')

    " languageclient : key mapping:
    " nnoremap  <silent>gm          :<C-u>call LanguageClient_contextMenuItems()<CR>
    " nnoremap  <silent>gx          :<C-u>call LanguageClient_textDocument_codeAction()<CR>
    nnoremap  <silent><C-/>      :<C-u>call LanguageClient_textDocument_references()<CR>
    nnoremap  <silent><C-{>       :<C-u>call LanguageClient_textDocument_definition()<CR>
    nnoremap  <silent><C-}>       :<C-u>call LanguageClient_textDocument_implementation()<CR>
    nnoremap  <silent><C-h>       :<C-u>call LanguageClient_textDocument_hover()<CR>
    " Rename - rn => rename
    noremap <leader>f           :<C-u>call LanguageClient#textDocument_formatting()<CR>
    noremap <leader>e           :<C-u>call LanguageClient#textDocument_rename()<CR>
    "  noremap <leader>h :call LanguageClient#textDocument_documentHighlight()<CR>
    "  noremap <leader>nh :call LanguageClient#clearDocumentHighlight()<CR>
    noremap <leader>m              :<C-u>call LanguageClient_contextMenu()<CR>
  endif
endfunction

" Language:
"" Go:
Gautocmd BufRead,BufNewFile *.tmpl set filetype=gohtmltmpl

" Vim:
"" nested autoload
Gautocmd BufWritePost $MYVIMRC nested silent! source $MYVIMRC

"" Neosnippet:
Gautocmdft neosnippet call dein#source('neosnippet.vim')
if dein#source('neosnippet')
  Gautocmd InsertLeave * NeoSnippetClearMarkers
endif

"" Gitcommit:
Gautocmd BufEnter COMMIT_EDITMSG  startinsert

Gautocmdft jsp,asp,php,xml,perl syntax sync minlines=500 maxlines=1000

"" Gitfugitive: 
Gautocmd QuickFixCmdPost *grep* cwindow

" -------------------------------------------------------------------------------------------------
" Language Settings:

" C CXX:
"" VimCPPModern:
let g:cpp_simple_highlight = 0  " Put all standard C and C++ keywords under Vim's highlight group `Statement` (affects both C and C++ files)
let g:cpp_named_requirements_highlight = 1  " Enable highlighting of named requirements (C++20 library concepts)
"
"" Rtags:
"let g:rtagsJumpStackMaxSize = 1000
"let g:rtagsMaxSearchResultWindowHeight = 15
"let g:rtagsMinCharsForCommandCompletion = 100
"let g:rtagsUseDefaultMappings = 1
"let g:rtagsUseLocationList = 0  "By default, search results are showed in a location list. Location lists are local to the current window. To use the vim QuickFix window, which is shared between all windows, set: 0


" Asm:
let g:nasm_loose_syntax = 1
let g:nasm_ctx_outside_macro = 1


" TerraForm:
let g:terraform_align = 1
let g:terraform_fmt_on_save = 1
let g:terraform_fold_sections = 1
let g:terraform_remap_spacebar = 1


" Binary:
let g:vinarise_enable_auto_detect = 1
if isdirectory('/usr/local/opt/binutils')
  let g:vinarise_objdump_command = '/usr/local/opt/binutils/bin/gobjdump'
endif


" Markdown:
" http://mattn.kaoriya.net/software/vim/20140523124903.html
let g:markdown_fenced_languages = [
      \ 'asm',
      \ 'c',
      \ 'cpp',
      \ 'go',
      \ 'javascript',
      \ 'json',
      \ 'python',
      \ 'sh',
      \ 'vim',
      \ 'yaml',
      \ ]
let g:slide_fenced_languages = [
      \ 'asm',
      \ 'c',
      \ 'cpp',
      \ 'go',
      \ 'javascript',
      \ 'json',
      \ 'python',
      \ 'sh',
      \ 'vim',
      \ 'yaml',
      \ ]
"
"" VimMarkdownfmt:
let g:markdownfmt_command = 'markdownfmt'
let g:markdownfmt_options = ''
let g:markdownfmt_autosave = 0
let g:markdownfmt_fail_silently = 0

" -------------------------------------------------------------------------------------------------
" Plugin Setting:

"" Deoplete:d
" core
let g:deoplete#enable_at_startup = 1
let s:default_ignore_sources = ['around', 'dictionary', 'member', 'omni', 'tag']
let s:deoplete_custom_option = {
      \ 'auto_complete': v:true,
      \ 'auto_complete_delay': 0,
      \ 'auto_refresh_delay': 20,
      \ 'camel_case': v:true,
      \ 'delimiters': ['/'],
      \ 'ignore_case': v:true,
      \ 'ignore_sources': {
      \   '_': s:default_ignore_sources+['LanguageClient'],
      \   'c': s:default_ignore_sources,
      \   'cpp': s:default_ignore_sources,
      \   'dockerfile': s:default_ignore_sources,
      \   'go': s:default_ignore_sources+['buffer', 'file', 'LanguageClient', 'neosnippet'],
      \   'javascript': s:default_ignore_sources,
      \   'objc': s:default_ignore_sources+['buffer', 'neosnippet'],
      \   'python': s:default_ignore_sources,
      \   'rust': s:default_ignore_sources,
      \   'sh': s:default_ignore_sources,
      \   'swift': s:default_ignore_sources,
      \   'typescript': s:default_ignore_sources,
      \   'yaml': s:default_ignore_sources+['buffer'],
      \   'yaml.docker-compose': s:default_ignore_sources+['buffer'],
      \   'zsh': s:default_ignore_sources,
      \ },
      \ 'max_list': 1000,
      \ 'min_pattern_length': 1,
      \ 'num_processes': 0,
      \ 'on_insert_enter': v:true,
      \ 'on_text_changed_i': v:true,
      \ 'prev_completion_mode': 'filter',
      \ 'refresh_always': v:true,
      \ 'skip_multibyte': v:true,
      \ 'skip_chars': ['(', ')'],
      \ 'smart_case': v:true,
      \ }
call deoplete#custom#option(s:deoplete_custom_option)
call deoplete#custom#source('_', 'converters', ['converter_remove_paren', 'converter_auto_paren', 'converter_remove_overlap'])
" call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])  " can't build with pypy3
call deoplete#custom#source('_', 'sorters', ['sorter_rank'])
call deoplete#custom#source('buffer', 'rank', 10)
call deoplete#custom#source('go', 'rank', 1000)
call deoplete#custom#source('go', 'sorters', ['sorter_rank'])
call deoplete#custom#source('go', 'disabled_syntaxes', ['Comment'])
call deoplete#custom#source('jedi', 'disabled_syntaxes', ['Comment'])
call deoplete#custom#source('LanguageClient', 'disabled_syntaxes', ['Comment'])
call deoplete#custom#source('LanguageClient', 'mark', '[LSP]')
call deoplete#custom#source('LanguageClient', 'min_pattern_length', 1)
call deoplete#custom#source('LanguageClient', 'rank', 1000)
call deoplete#custom#source('neosnippet', 'rank', 0)
call deoplete#custom#source('neosnippet', 'disabled_syntaxes', ['Comment'])
call deoplete#custom#source('vim', 'disabled_syntaxes', ['Comment'])
Gautocmdft yaml call deoplete#custom#source('LanguageClient', 'min_pattern_length', 0)

" source
" LLVM library path
if isdirectory("/usr/local/opt/llvm/lib")
  let s:llvm_library_path = '/usr/local/opt/llvm/lib'
  let s:llvm_clang_version = '7.0.1'
elseif ("/usr/lib/clang")
  let s:llvm_library_path = '/usr/lib/clang'
  let s:llvm_clang_version = '8.0.0'
else
  let s:llvm_library_path = '/Library/Developer/CommandLineTools/usr/lib'
  let s:llvm_clang_version = '10.0.0'
endif

""" go
"let s:use_gocode_mdempsky = 0
"let g:deoplete#sources#go#gocode_binary = expand('$HOME/go/bin/gocode')
"let g:deoplete#sources#go#gocode_flags = []
"if s:use_gocode_mdempsky != 0
"  let g:deoplete#sources#go#gocode_binary = expand('$HOME/go/bin/gocode-mdempsky')
"  let g:deoplete#sources#go#gocode_flags = ['-builtin', '-sock=none', '-source']
"endif
"let g:deoplete#sources#go#auto_goos = 1
"let g:deoplete#sources#go#pointer = 1
"let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const', 'package']
"let g:deoplete#sources#go#cgo = 1
"let g:deoplete#sources#go#cgo#libclang_path = s:llvm_library_path . '/libclang.dylib'
"let g:deoplete#sources#go#cgo#sort_algo = 'priority'  " 'alphabetical'
"" clang
let g:deoplete#sources#clang#clang_header = s:llvm_library_path . '/clang'
let g:deoplete#sources#clang#flags = [
      \ '-I/usr/local/include',
      \ '-I' . s:llvm_library_path . '/clang/' . s:llvm_clang_version . '/include',
      \ '-I/usr/include',
      \ ] " echo | clang -v -E -x c -
if has('unix')
  let g:deoplete#sources#clang#libclang_path = s:llvm_library_path . '/libclang.so'
elseif has('macunix')
  let g:deoplete#sources#clang#libclang_path = s:llvm_library_path . '/libclang.dylib'
elseif has('win32')
  let g:deoplete#sources#clang#libclang_path = s:llvm_library_path . '/libclang.dll'
endif

"" jedi
let g:deoplete#sources#jedi#statement_length = 0
let g:deoplete#sources#jedi#short_types = 0
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#enable_typeinfo = 1
let g:deoplete#sources#jedi#ignore_errors = 1
let g:deoplete#sources#jedi#extra_path = []
let g:deoplete#sources#jedi#python_path = g:python3_host_prog
" let g:deoplete#sources#jedi#worker_threads = 2
let g:deoplete#sources#jedi#python_path = g:python3_host_prog
let g:deoplete#sources#asm#go_mode = 1
" racer
let g:racer_cmd = "/usr/local/bin/racer"
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 1
" neopairs
let g:neopairs#enable = 1

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'sygnature'
" neosnippet
let g:neosnippet#data_directory = $XDG_CACHE_HOME . '/nvim/neosnippet'
let g:neosnippet#disable_runtime_snippets = {}
let g:neosnippet#disable_select_mode_mappings = 0
let g:neosnippet#enable_auto_clear_markers = 1
let g:neosnippet#enable_complete_done = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1
let g:neosnippet_username = 'kspark'
let g:neosnippet_author = 'kay park'
" debug
" call deoplete#custom#option('profile', v:true)
" call deoplete#enable_logging('DEBUG', $DEOPLETE_LOG_FILE)
" call deoplete#custom#source('asm', 'is_debug_enabled', 1)
" call deoplete#enable()


"" LanguageClient:
let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1
let g:LanguageClient_changeThrottle = 0.5
let g:LanguageClient_completionPreferTextEdit = 0  " should be 0
let g:LanguageClient_diagnosticsList = 'Quickfix'  " default: Quickfix, Location, Disabled
let g:LanguageClient_hasSnippetSupport = 0
let g:LanguageClient_hoverPreview = 'Auto'  " Always, Auto, Never
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_selectionUI = 'fzf'  " fzf, quickfix, location-list
let g:LanguageClient_settingsPath = '.lsp.json'
let g:LanguageClient_windowLogMessageLevel = "Warning"  " Error, default: Warning, Info, Log
if has('mac')
  let s:LanguageClient_serverCommands_c = [
        \ 'clangd',
        \'-j=12',
        \]
elseif has('unix')
  let s:LanguageClient_serverCommands_c = [
        \ 'clangd-8',
        \ '-all-scopes-completion',
        \ '-background-index',
        \ '-compile-commands-dir=build',
        \ '-compile_args_from=filesystem',
        \ '-completion-style=detailed',
        \ '-function-arg-placeholders',
        \ '-header-insertion-decorators',
        \ '-include-ineligible-results',
        \ '-input-style=standard',
        \ '-j=12',
        \ '-pch-storage=disk',
        \ '-resource-dir=/usr/lib/clang/8.0.0/include',
        \ '-static-func-full-module-prefix',
        \ '-use-dbg-addr',
        \ '-view-background',
        \ ] 
endif
let g:LanguageClient_serverCommands = {
      \ 'c': s:LanguageClient_serverCommands_c,
      \ 'cpp': s:LanguageClient_serverCommands_c,
      \ 'sh': ['bash-language-server', 'start'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'zsh': ['bash-language-server', 'start'],
      \ }
let s:LanguageClient_rootMarkers_c = ['autogen.sh', 'configure', '.clang-format']
let g:LanguageClient_rootMarkers = {
      \ 'c': s:LanguageClient_rootMarkers_c,
      \ 'cpp': s:LanguageClient_rootMarkers_c,
      \ 'python': ['setup.py', 'LICENSE'],
      \ }
let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loggingLevel = 'DEBUG'  " default: WARN
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'

" Denite:
call denite#custom#option('_', {
      \ 'auto_accel': v:false,
      \ 'highlight-matched-char': 'DeniteMatchedChar',
      \ 'highlight-matched-range': 'DeniteMatchedRange',
      \ 'highlight-preview-line': 'DenitePreviewLine',
      \ 'auto-highlight': v:false,
      \ 'empty': v:false,
      \ 'prompt': '>',
      \ 'sorter': 'sorter/word',
      \ 'source_names': 'short',
      \ 'unique': v:true,
      \ 'winheight': 20,
      \ })
call denite#custom#option('file_rec', {
      \ 'sorter': 'sorter/sublime',
      \ })
let s:denite_fd_command = ['fd', '--follow', '--hidden', '--type=f', '--full-path', '--color=never', '--exclude=.git', '--exclude=vendor', '']
let s:denite_ag_command = ['pt', '--follow', '--nocolor', '--nogroup', '-g', '']
let s:denite_pt_command = ['pt', '--follow', '--nocolor', '--nogroup', '-g', '']
let s:denite_rg_command = ['rg', '--files', '--mmap', '--threads=12', '--hidden', '--smart-case', '--no-ignore-vcs', '--no-heading', '--glob', '!.git', '--glob', '!vendor', '']
" if &filetype == 'go'
"   let s:denite_fd_command = ['fd', '--follow', '--hidden', '--type=f', '--full-path', '--color=never', '--exclude=".git"', '--exclude="vendor"', '']
"   let s:denite_rg_command = ['rg', '--files', '--mmap', '--threads=12', '--hidden', '--smart-case', '--no-ignore-vcs', '--no-heading', '--glob', '!.git', '--glob', '!vendor']
" endif
call denite#custom#var('file_rec/fd', 'command', s:denite_fd_command)
call denite#custom#var('file_rec/ag', 'command', s:denite_ag_command)
call denite#custom#var('file_rec/pt', 'command', s:denite_pt_command)
call denite#custom#var('file_rec/rg', 'command', s:denite_rg_command)
" call denite#custom#source('file_rec', 'matchers', ['matcher_cpsm'])
"" grep
call denite#custom#var('grep/rg', 'command', ['rg'])
call denite#custom#var('grep/rg', 'default_opts', ['--mmap', '--threads=12', '--hidden', '--smart-case', '--vimgrep', '--no-ignore-vcs', '--no-heading', '--glob', '!.git', '--glob', '!vendor'])
call denite#custom#var('grep/rg', 'recursive_opts', [])
call denite#custom#var('grep/rg', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep/rg', 'separator', ['--'])
call denite#custom#var('grep/rg', 'final_opts', [])
call denite#custom#var('grep/pt', 'command', ['pt'])
call denite#custom#var('grep/pt', 'default_opts', ['--follow', '--hidden', '--nogroup', '--nocolor', '--smart-case', '--ignore="_*"'])
call denite#custom#var('grep/pt', 'recursive_opts', [])
call denite#custom#var('grep/pt', 'pattern_opt', [])
call denite#custom#var('grep/pt', 'separator', ['--'])
call denite#custom#var('grep/pt', 'final_opts', [])
"" line
call denite#custom#var('line/rg', 'command', ['rg', '--files', '--glob', '!.git', ''])
call denite#custom#var('line/pt', 'command', ['pt', '--nocolor', '--nogroup', '--follow', '-g', ''])
"" map
call denite#custom#map('insert', '<Down>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<Up>', '<denite:move_to_previous_line>', 'noremap')
"" alias
call denite#custom#alias('source', 'file_rec/ag', 'file_rec')
call denite#custom#alias('source', 'file_rec/fd', 'file_rec')
call denite#custom#alias('source', 'file_rec/pt', 'file_rec')
call denite#custom#alias('source', 'file_rec/ag', 'file_rec')
call denite#custom#alias('source', 'grep/rg', 'grep')
call denite#custom#alias('source', 'grep/pt', 'grep')
call denite#custom#alias('source', 'line/rg', 'line')
call denite#custom#alias('source', 'line/pt', 'line')
"" filter
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

" Vikube:
let g:vikube_autoupdate = 1
let g:vikube_default_logs_tail = 100
let g:vikube_use_current_namespace = 1


" Ale:
let g:ale_cache_executable_check_failures = 1
let g:ale_change_sign_column_color = 0
let g:ale_completion_enabled = 0
let g:ale_cursor_detail = 1
let g:ale_echo_cursor = 1
let g:ale_echo_delay = 20
let g:ale_fix_on_save = 1
let g:ale_keep_list_window_open = 0
let g:ale_lint_delay = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_list_window_size = 10
let g:ale_open_list = 0
let g:ale_set_highlights = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0
let g:ale_sign_column_always = 1
let g:ale_use_global_executables = 1
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_delay = 20
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
"" linters
let g:ale_linters = {}
let g:ale_linters.dockerfile = ['hadolint']
let g:ale_linters.cpp = ['cppcheck','clazy']
let g:ale_c_cppcheck_options = '--enable=warning,performance,portability,style --language=c++'
"let g:ale_cpp_clangtidy_options = '-Wall -std=c++17 -x c++'
"let g:ale_cpp_clangtidy_checks = ['*,-bugprone-bool-pointer-implicit-conversion,-bugprone-exception-escape,-cert-env33-c,-cert-dcl50-cpp,-cert-dcl59-cpp,-cppcoreguidelines-no-malloc,-cppcoreguidelines-owning-memory,-cppcoreguidelines-pro-bounds-array-to-pointer-decay,-cppcoreguidelines-pro-bounds-constant-array-index,-cppcoreguidelines-pro-type-const-cast,-cppcoreguidelines-pro-type-cstyle-cast,-cppcoreguidelines-pro-type-reinterpret-cast,-cppcoreguidelines-pro-type-union-access,-cppcoreguidelines-special-member-functions,-fuchsia-*,-google-*,google-default-arguments,google-explicit-constructor,google-runtime-member-string-references,google-runtime-operator,-hicpp-braces-around-statements,-hicpp-named-parameter,-hicpp-no-array-decay,-hicpp-no-assembler,-hicpp-no-malloc,-hicpp-function-size,-hicpp-special-member-functions,-hicpp-vararg,-llvm-*,-objc-*,-readability-else-after-return,-readability-implicit-bool-conversion,-readability-named-parameter,-readability-simplify-boolean-expr,-readability-braces-around-statements,-readability-identifier-naming,-readability-function-size,-readability-redundant-member-init,-misc-bool-pointer-implicit-conversion,-misc-definitions-in-headers,-misc-unused-alias-decls,-misc-unused-parameters,-misc-unused-using-decls,-modernize-*']
let g:ale_linters.qml = ['qmlfmt','qmllint']
let g:ale_linters.go = []  " let g:ale_linters.go = ['gofmt', 'goimports', 'go vet', 'golint', 'gometalinter']
let g:ale_linters.proto = ['prototool']
let g:ale_linters.python = ['pylint']
let g:ale_linters.rust = ['cargo']
let g:ale_linters.sh = ['shellcheck', 'sh-language-server', 'shfmt']
let g:ale_linters.yaml = ['yamllint', 'swaglint']
let g:ale_linters.zsh = ['sh-language-server']
"" fixers
let g:ale_fixers = {}
let g:ale_fixers.sh = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers.zsh = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
"" Go:
let g:ale_go_gofmt_options = '-s'
let g:ale_go_gometalinter_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'
let g:ale_go_staticcheck_options = ''
let g:ale_go_staticcheck_package = 1
"" Shell ShellCheck Shfmt:
let g:ale_sh_shell_default_shell = 'zsh'
let g:ale_sh_shellcheck_executable = '/usr/bin/shellcheck'
let g:ale_sh_shellcheck_options = '-x -s bash'
let g:ale_sh_shfmt_options = ''

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Caw:
let g:caw_hatpos_skip_blank_line = 0
let g:caw_no_default_keymappings = 1
let g:caw_operator_keymappings = 0


" LightLine:
" https://donniewest.com/a-guide-to-basic-neovim-plugins
let g:lightline = {}
let g:lightline.colorscheme = 'dracula'
function! DeviconsGetFileTypeSymbol()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction
function! DeviconsGetFileFormatSymbol()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction
" function! LightlineModified()
"   let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
"   let mode = get(map, mode()[0], mode()[0])
"   let bgcolor = {'n': [240, '#B5BD68'], 'i': [31, '#82AAFF']}
"   let color = get(bgcolor, mode, bgcolor.n)
"   exe printf('hi ModifiedColor ctermfg=196 ctermbg=%d guifg=#282a2e guibg=%s gui=bold term=bold cterm=bold', color[0], color[1])
"   return &modified ? '+' : &modifiable ? '' : '-'
" endfunction
function! LightlineModified()
  hi ModifiedColor ctermfg=167 guifg=#cf6a4c ctermbg=242 guibg=#666656 term=bold cterm=bold
  return &modified ? '+' : &modifiable ? '' : '-'
endfunction
let g:lightline.component = {
      \ 'absolutepath': '%F',
      \ 'bufnum': '%n',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'close': '%999X X ',
      \ 'column': '%c',
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'filename': '%{expand(''%:p'')}',
      \ 'line': '%l',
      \ 'lineinfo': '%3l  %-2v',
      \ 'mode': '%{lightline#mode()}',
      \ 'modified': '%( %#ModifiedColor#%{LightlineModified()} %)',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'percent': '%3p%%',
      \ 'percentwin': '%P',
      \ 'readonly': '%R',
      \ 'relativepath': '%f',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'winnr': '%{winnr()}',
      \ }
let g:lightline.component_expand = {
      \ 'linter_checking': 'lightline#ale#checking',
      \ 'linter_errors': 'lightline#ale#errors',
      \ 'linter_ok': 'lightline#ale#ok',
      \ 'linter_warnings': 'lightline#ale#warnings',
      \ }
let g:lightline.component_type = {
      \ 'modified': 'raw',
      \ 'linter_checking': 'left',
      \ 'linter_errors': 'error',
      \ 'linter_ok': 'left',
      \ 'linter_warnings': 'warning',
      \ }
let g:lightline.component_function = {
      \ 'fileformat': 'DeviconsGetFileFormatSymbol',
      \ 'filetype': 'DeviconsGetFileTypeSymbol',
      \ 'gitbranch': 'gina#component#repo#branch',
      \ }
let g:lightline.active = {
      \ 'left': [ ['mode', 'paste'], ['filename', 'gitbranch'] ],
      \ 'right': [ [ 'lineinfo', 'percent' ], [ 'filetype', 'fileformat', 'fileencoding' ], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
      \ }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'close' ] ]
      \ }
let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'filename', 'modified' ],
      \ 'inactive': [ 'tabnum', 'filename', 'modified' ]
      \ }
let g:lightline.enable = { 'statusline': 1, 'tabline': 1 }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': ' ', 'right': ' ' }
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1

function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction
Gautocmd User ALELint call s:MaybeUpdateLightline()

" GitGutter:
let g:gitgutter_async = 1
let g:gitgutter_eager = 1
let g:gitgutter_enabled = 1
let g:gItgutter_highlight_lines = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 100000


" Accelerated JK:
let g:accelerated_jk_acceleration_limit = 150  " 300
let g:accelerated_jk_acceleration_table = [7, 12, 17, 21, 24, 26, 28, 30]
" let g:accelerated_jk_acceleration_table = [1, 3, 7, 12, 17, 21, 24, 26, 28, 30]


" VimAutoPep8:
let g:autopep8_aggressive = 2
let g:autopep8_disable_show_diff = 1
let g:autopep8_max_line_length = 99


" ParenMatch:
let g:cursorword = 0


" Wakatime:
let g:wakatime_PythonBinary = '/usr/bin/python3'


" SonicTemplate:
let g:sonictemplate_vim_template_dir = [expand($XDG_CONFIG_HOME.'/nvim/template')]


" Vaffle:
let g:vaffle_auto_cd = 1
let g:vaffle_force_delete = 1
let g:vaffle_show_hidden_files = 1
let g:vaffle_use_default_mappings = 1


" Editorconfig:
let g:EditorConfig_core_mode = 'python_external'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Trans:
"let g:trans_lang_credentials_file = $XDG_CONFIG_HOME.'/gcloud/credentials/kouzoh-p-zchee/trans-nvim.json'
"let g:trans_lang_cutset = ['//', '#']
let g:trans_lang_locale = 'ko'


" OpenBrowser:
let g:openbrowser_search_engines = {
      \ 'google': 'http://google.com/',
      \}
let g:openbrowser_message_verbosity = 1

" -------------------------------------------------------------------------------------------------
" Previous use plugins

" Jedivim:
let g:jedi#auto_initialization = 0
let g:jedi#use_splits_not_buffers = ''
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
let g:jedi#documentation_command = "K"
let g:jedi#force_py_version = 3
let g:jedi#max_doc_height = 150
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = 0
let g:jedi#smart_auto_mappings = 0

" NERDTree:
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeSortHiddenFirst = 1

" Neomake:
" let g:neomake_highlight_lines = 0
" let g:neomake_list_height = 25
" let g:neomake_open_list = 2
" let g:neomake_python_enabled_makers = ['pyflakes', 'flake8']

" Neoformat:
" let g:neoformat_enabled_python = ['autopep8', 'yapf']
" NVMIM-GDB
let g:nvimgdb_config = {
      \ 'key_until':      'u',
      \ 'key_continue':   'c',
      \ 'key_next':       'n',
      \ 'key_step':       's',
      \ 'key_finish':     'f',
      \ 'key_breakpoint': 'b',
      \ 'key_frameup':    '<c-p>',
      \ 'key_framedown':  '<c-n>',
      \ 'key_eval':       '<f9>',
      \ 'set_tkeymaps':   'function("GdbCallAsync", "keymaps.setT")',
      \ 'sign_current_line': '▶',
      \ 'sign_breakpoint': [ '●', '●²', '●³', '●⁴', '●⁵', '●⁶', '●⁷', '●⁸', '●⁹', '●ⁿ' ],
      \ 'split_command': 'split'
      \ }

nmap <C-b> :GdbBreakpointToggle<CR>
"
" CtrlP:
" let g:ctrlp_follow_symlinks = 1
" let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25'
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_custom_ignore = {
"       \ 'dir':  '\v[\/](\.(git|hg|svn|idea|)|vendor)$',
"       \ 'file': '\v\.(exe|so|dll)$',
"       \ }

" VimMarkdownPreview:
" let vim_markdown_preview_github = 1
" let vim_markdown_preview_hotkey = '<C-m>'

" VimFiler:
" let g:vimfiler_as_default_explorer = 0
" let g:vimfiler_safe_mode_by_default = 0
" let g:vimfiler_enable_auto_cd = 0
" let g:vimfiler_tree_leaf_icon = ''
" let g:vimfiler_tree_opened_icon = '▾'
" let g:vimfiler_tree_closed_icon = '▸'
" let g:vimfiler_marked_file_icon = '✓'

" Crowi:
" let g:crowi#api_url = "https://wiki.mercari.in"
" let g:crowi#access_token = expand($CROWI_TOKEN)
" let g:crowi#filetypes = ['markdown']
" let g:crowi#open_page = 'true'
" let g:crowi#default_create_path = expand($XDG_DATA_HOME).'crowi'
" let g:crowi#browser_command = 'open'

" TagBar:
" let g:tagbar_type_go = {
"      \ 'ctagstype' : 'go',
"      \ 'kinds'     : [
"      \ 'p:package',
"      \ 'i:imports:1',
"      \ 'c:constants',
"      \ 'v:variables',
"      \ 't:types',
"      \ 'n:interfaces',
"      \ 'w:fields',
"      \ 'e:embedded',
"      \ 'm:methods',
"      \ 'r:constructor',
"      \ 'f:functions'
"      \ ],
"      \ 'sro' : '.',
"      \ 'kind2scope' : {
"      \ 't' : 'ctype',
"      \ 'n' : 'ntype'
"      \ },
"      \ 'scope2kind' : {
"      \ 'ctype' : 't',
"      \ 'ntype' : 'n'
"      \ },
"      \ 'ctagsbin'  : 'gotags',
"      \ 'ctagsargs' : '-sort -silent'
"      \ }


" fzf:
" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
"key bindings for fzf
"nmap <Leader>b :Buffers<CR>
"nmap <Leader>f :Files<CR>
"nmap <Leader>r :Tags<CR>>

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" -------------------------------------------------------------------------------------------------
" Functions:

" LanguageClient:
function! s:lsp_set_schema(args)
  if &filetype !=? "yaml"
    return
  endif

  let l:filepath = expand('%:p')
  let l:filename = fnamemodify(l:filepath, ':t')
  let l:schema = 'default'
  let l:config_file = ''
  let l:config = ''

  if len(a:args)
    let l:schema = a:args
    let l:config_file = expand($XDG_CONFIG_HOME . '/nvim/lsp/yaml/' . l:schema . '.json')
    let l:config = json_decode(readfile(l:config_file))
    call LanguageClient#Notify('workspace/didChangeConfiguration', { 'settings': l:config })
    return
  endif

  if l:filepath =~# '**/kubernetes/.*/*.yaml' || l:filename =~# 'kubectl-edit-.*.yaml'
    let l:schema = 'kubernetes'
  elseif l:filepath =~# '**/openapi.*/.*/*.yaml'
    let l:schema = 'openapi'
  elseif l:filename =~# '\v\.?cloudbuild\.yaml$'
    let l:schema = 'cloudbuild'
  elseif l:filepath =~# '**/.circleci/config.yml'
    let l:schema = 'circleci'
  elseif l:filename =~# '\v\.?codecov\.yml$'
    let l:schema = 'codecov'
  elseif l:filename =~# '\vhelmfile\.yaml$'
    let l:schema = 'helmfile'
  elseif l:filename =~# '\v\.?appveyor\.yml$'
    let l:schema = 'appveyor'
  elseif l:filename =~# '\vswagger.*\.ya?ml$'
    let l:schema = 'swagger-2.0'
  elseif l:filename =~# '\vdocker-compose.*\.ya?ml'
    let l:schema = 'docker-compose'
  elseif l:filename ==# '.travis.yml'
    let l:schema = 'travis'
  endif

  let l:config_file = expand($XDG_CONFIG_HOME . '/nvim/lsp/yaml/' . l:schema . '.json')
  let l:config = json_decode(readfile(l:config_file))

  echom 'yaml-language-server: schema: ' . l:schema
  echom 'yaml-language-server: config_file: ' . l:config_file

  call LanguageClient#Notify('workspace/didChangeConfiguration', { 'settings': l:config })
endfunction

command! -nargs=* LSPYamlSetSchema call <SID>lsp_yaml_set_schema(<q-args>)

if dein#tap('LanguageClient-neovim')
  Gautocmdft c,cpp,javascript,json,objc,python,sh,swift,typescript,yaml,yaml.docker-compose,zsh call <SID>languageclient_setup()
  Gautocmd User LanguageClientTextDocumentDidOpenPost call <SID>lsp_set_schema('')  " LanguageClientStart, dLanguageClientStopped, LanguageClientDiagnosticsChanged, LanguageClientTextDocumentDidOpenPost
  " Gautocmd User LanguageClientTextDocumentDidOpenPost let g:LanguageClient_settingsPath = findfile('.lsp.json', '.;')
endif


" Filetye Execute:
function! s:filetype_exec(...)
  let s:ft = getbufvar(winbufnr(winnr()), "&filetype")
  if s:ft == a:1
    execute a:2
  endif
endfunction


" Help:
" https://github.com/rhysd/dotfiles/blob/master/nvimrc#L380-L405
function! s:smart_help(args)
  try
    if winwidth(0) > winheight(0) * 2
      execute 'vertical rightbelow help ' . a:args
    else
      execute 'rightbelow help ' . a:args
    endif
  catch /^Vim\%((\a\+)\)\=:E149/
    echohl ErrorMsg
    echomsg "E149: Sorry, no help for " . a:args
    echohl None
  endtry
endfunction
command! -nargs=* -complete=help Help call <SID>smart_help(<q-args>)

" HelpGrep:
function! s:smart_helpgrep(args)
  try
    if winwidth(0) > winheight(0) * 2
      execute 'vertical rightbelow helpgrep ' . a:args . '@ko'
    else
      execute 'rightbelow helpgrep ' . a:args . '@ko'
    endif
  catch /^Vim\%((\a\+)\)\=:E149/
    echohl ErrorMsg
    echomsg "E149: Sorry, no help for " . a:args
    echohl None
  endtry
  copen
endfunction
command! -nargs=* -complete=help HelpGrep call <SID>smart_helpgrep(<q-args>)


" SyntaxInfo:
" Display syntax infomation on under the current cursor
" for syntax ID
function! s:get_syn_id(transparent)
  let s:synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(s:synid)
  else
    return s:synid
  endif
endfunction
" for syntax attributes
function! s:get_syn_attr(synid)
  let s:name = synIDattr(a:synid, "name")
  let s:bold  = synIDattr(a:synid, "bold", "gui")
  let s:guifg = synIDattr(a:synid, "fg", "gui")
  let s:guibg = synIDattr(a:synid, "bg", "gui")
  let s:attr = {
        \ "name": s:name,
        \ "bold": s:bold,
        \ "guifg": s:guifg,
        \ "guibg": s:guibg,
        \ }
  return s:attr
endfunction
" return syntax information
function! s:get_syn_info(cword)
  let s:baseSyn = s:get_syn_attr(s:get_syn_id(0))
  let s:baseSynInfo = "name: " . s:baseSyn.name .
        \ " bold: " . (s:baseSyn.bold == 1 ? 'true' : 'false' ) . "," .
        \ " guifg: " . s:baseSyn.guifg . "," .
        \ " guibg: " . s:baseSyn.guibg
  let s:linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  let s:linkedSynInfo =  "name: " . s:linkedSyn.name .
        \ " bold: " .  (s:linkedSyn.bold == 1 ? 'true' : 'false' ) . "," .
        \ " guifg: " . s:linkedSyn.guifg . "," .
        \ " guibg: " . s:linkedSyn.guibg
  echomsg a:cword . ':'
  echomsg s:baseSynInfo
  echomsg '  ' . "link to"
  echomsg s:linkedSynInfo
endfunction
command! SyntaxInfo call s:get_syn_info(expand('<cword>'))


" ClearMessage:
command! ClearMessage for n in range(200) | echom "" | endfor


" Binary Edit Mode:
" need open nvim with `-b` flag
function! BinaryMode() abort
  if !has('binary')
    echoerr "BinaryMode must be 'binary' option"
    return
  endif

  execute '%!xxd'
endfunction


" Less Like Mapping:
function! LessMap()
  set colorcolumn=""
  let b:gitgutter_enabled = 0
  nnoremap <silent><buffer>u <C-u>
  nnoremap <silent><buffer>d <C-d>
  nnoremap <silent><buffer>q :q<CR>
endfunction


" Profiling Syntax:
function! ProfileSyntax() abort
  " Initial and cleanup syntime
  redraw!
  syntime clear
  " Profiling syntax regexp
  syntime on
  redraw!
  QuickRun -type vim -src 'syntime report'
endfunction


" Open the C/C++ online document
" https://github.com/rhysd/dogfiles/blob/926f2b9c1856bbf3a8090f430831f2c94d7cc410/vimrc#L1399-L1423
function! s:open_online_cfamily_doc()
  call dein#source('open-browser.vim')
  let l:l = getline('.')

  if l:l =~# '^\s*#\s*include\s\+<.\+>'
    let l:header = matchstr(l, '^\s*#\s*include\s\+<\zs.\+\ze>')
    if header =~# '^boost'
      "https://www.google.co.kr/search?hl=en&as_q=int64_max&as_sitesearch=cppref.github.io
      execute 'OpenBrowser' 'http://www.google.com/cse?cx=011577717147771266991:jigzgqluebe&q='.matchstr(header, 'boost/\zs[^/>]\+\ze')
      return
    else
      execute 'OpenBrowser' 'http://cppreference.com/mwiki/index.php?title=Special:Search&search='.matchstr(header, '\zs[^/>]\+\ze')
      return
    endif
  else
    let l:cword = expand('<cword>')
    if cword ==# ''
      return
    endif
    let l:line_head = getline('.')[:col('.')-1]
    if line_head =~# 'boost::[[:alnum:]:]*$'
      execute 'OpenBrowser' 'http://www.google.com/cse?cx=011577717147771266991:jigzgqluebe&q='.l:cword
    elseif line_head =~# 'std::[[:alnum:]:]*$'
      execute 'OpenBrowser' 'https://www.google.co.kr/search?hl=en&as_sitesearch=cpprefen.github.io&as_q='.l:cword
      execute 'OpenBrowser' 'http://en.cppreference.com/mwiki/index.php?title=Special:Search&search='.l:cword
    else
      let l:name = synIDattr(synIDtrans(synID(line("."), col("."), 1)), 'name')
      if l:name == 'Statement'
        execute 'OpenBrowser' 'http://en.cppreference.com/w/c/language/'.l:cword
      else
        execute 'OpenBrowser' 'http://en.cppreference.com/mwiki/index.php?title=Special:Search&search='.l:cword
      endif
    endif
  endif
endfunction


" Trim Whitespace:
function! s:trimSpace()
  if !&binary && &filetype != 'diff' && &filetype != 'markdown'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction
command! TrimSpace call s:trimSpace()


" InitEdit:
function! s:initEdit()
  vsplit $XDG_CONFIG_HOME/nvim/init.vim
endfunction
command! InitEdit call s:initEdit()


" Lr:
" <lr-args> to browse lr(1) results in a new window, press return to open file in new window.
command! -nargs=* -complete=file Lr
      \ new | setl bt=nofile noswf | silent exe '0r!lr -Q ' <q-args> |
      \ 0 | res | map <buffer><C-M> $<C-W>F<C-W>_

" -------------------------------------------------------------------------------------------------
" Command:

" Terminal:
command! -nargs=* Terminal split | terminal <args>
command! -nargs=* TerminalV vsplit | terminal <args>

" Capture:
" http://qiita.com/sgur/items/9e243f13caa4ff294fa8
command! -nargs=+ -complete=command Capture QuickRun -type vim -src <q-args>

" Shfmt:
command! -nargs=0 -bang -complete=command Shfmt %!shfmt -i 2
"
" FormatJson:
" if has("python3")
"  python3 << EOF
"import vim
"import json
"def Format_Json(start, end):
"    start = start - 1
"    jsonStr = "\n".join(vim.current.buffer[start:end])
"    prettyJson = json.dumps(json.loads(jsonStr), sort_keys=True, indent=2, separators=(',', ': '), ensure_ascii=False)
"    prettyJson = prettyJson.encode('utf8')
"    vim.current.buffer[start:end] = prettyJson.split(b'\n')
"EOF
" command! -bang -bar -complete=command -nargs=* -range=% FormatJson :python3 Format_Json(<line1>, <line2>)
"else
"  command! -nargs=0 -bang -complete=command FormatJson %!python3 -m json.tool
"endif

" ProfileSyntax:
command! -nargs=0 -bang -complete=command ProfileSyntax call ProfileSyntax()

" -------------------------------------------------------------------------------------------------
" Keymap:
"
" For Kinesis Advantage With Programmer Dvorak.
" Global & Local MapLeader are arranged in the center of the keyboard.
"
"   - Global MapLeader: <Space> " Righthand
"   - Local MapLeader : <BS>    " Lefthand
"   - Local prefix    : ,       " Lefthand
"
" TODO(zchee):
"   Swaps semicolon and colon to ideal at Kinesis hardware level. Now use direct edited macOS key dictionary
"   Use Kinesis Advantage2 instead of.
"
" Vim remappable keys
"   - <Space>
"   - ,       : Reverse repeat for f, t, F, T
"   - s       : replace to cl
"   - t       : Never use it in normal mode, f -> ... -> h instead of
"   - m       : For sets marker, never use it also
"
"   - http://deris.hatenablog.jp/entry/2013/05/02/192415
"
" -------------------------------------------------------------------------------------------------
" Map Leader: <Space>

" nmap <Nop> for g:mapleader and g:maplocalleader keys
nnoremap <nowait><Space> <Nop>
nnoremap <nowait><BS>    <Nop>
let g:mapleader= ","
let g:maplocalleader=","
if !exists('g:mapleader')
  let g:mapleader = "<Space>"
endif
if !exists('g:maplocalleader')
  let g:maplocalleader = ","
endif

"" <Leader>
"nnoremap              <Leader>ga        :<C-u>Gina add %<CR>
"nnoremap              <Leader>gc        :<C-u>Gina commit<CR>
"nnoremap              <Leader>gp        :<C-u>Gina push<CR>
"nnoremap              <Leader>gs        :<C-u>Gina status<CR>

"" <LocalLeader>
nnoremap <silent><LocalLeader>*         :<C-u>DeniteCursorWord grep/rg -buffer-name='grep/rg' -mode=insert<CR>
nnoremap <silent><LocalLeader>-         :<C-u>split<CR>
nnoremap <silent><LocalLeader>\         :<C-u>vsplit<CR>
nnoremap <silent><LocalLeader>b         :<C-u>Denite buffer -buffer-name='buffer' -mode=insert<CR>
nnoremap <silent><LocalLeader>g         :<C-u>Denite line/rg -buffer-name='line/rg' -mode=insert<CR>
nnoremap <silent><LocalLeader>q         :<C-u>q<CR>
nnoremap <silent><LocalLeader>w         :<C-u>w<CR>

"" ,
"nnoremap              <silent>,m        <C-w>W
"nnoremap              <silent>,n        <C-w>w
"nnoremap              <silent>,p        <C-w>W
"nnoremap              <silent>,r        <C-w>x
"nnoremap              <silent>,s        :<C-u>bNext<CR>
"nnoremap              <silent>,t        :<C-u>tabnew<CR>
"nnoremap              <silent>,w        <C-w>w

" -------------------------------------------------------------------------------------------------
" Map: (m)

" -------------------------------------------------------------------------------------------------
" Normal: (n)

"        *) asterisk-gz*
"        -) 'Vaffle %:p:h' or 'VimFilerExplorer -find<CR>'
"      @,^) ^,@: switch '@' and '^' for Dvorak pinky
"       ga) EasyAlign
"       gx) openbrowser-smart-search
"        j) accelerated_jk_gj_position
"        k) accelerated_jk_gk_position
"        p) Paste
"        Q) gq: do not use Ex mode. Use 'gq' is the format the lines that {motion} moves over
"        s) A: Append text at the end of the line [count] times
"        x) "_x: do not add yank register
"       zj)       zjzt
"       zk)       2zkzjzt
"       ZQ) <Nop>: disable suspend
"    <C-g>) 'DeniteProjectDir grep'
"    <C-p>) 'DeniteProjectDir file_rec'
"    <C-q>) nohlsearch: Stop the highlighting for the 'hlsearch' option
" <S-Tab>>) %: Jump to match pair brackets. *<Tab>* and *<C-i>* are similar treatment.
"              Note that needs <C-i>(<Tab>) for jump to next taglist
" <S-Down>) <Nop>
"   <S-Up>) <Nop>

nmap     <silent>*           <Plug>(asterisk-gz*)
nnoremap <silent>-           :<C-u>Vaffle %:p:h<CR>
"nnoremap <nowait>@           ^
"nnoremap <nowait>^           @
nmap     <silent>ga          <Plug>(EasyAlign)
nmap     <silent>gx          <Plug>(openbrowser-smart-search)
nmap     <nowait>j           <Plug>(accelerated_jk_gj_position)
nmap     <nowait>k           <Plug>(accelerated_jk_gk_position)
nnoremap         Q           gq
nnoremap         s           A
nnoremap <nowait>x           "_x
nnoremap         zj          zjzt
nnoremap         zk          2zkzjzt
nnoremap         ZQ          <Nop>
" nnoremap <silent><C-o>       <C-o>zz
nnoremap <silent><C-g>       :<C-u>DeniteProjectDir grep/rg -buffer-name='grep/rg' -mode=insert<CR>
nnoremap <silent><C-p>       :<C-u>DeniteProjectDir file_rec/fd -buffer-name='file_rec/fd' -mode=insert<CR>
nnoremap <silent><C-q>       :<C-u>nohlsearch<CR>
" nnoremap <silent><C-w><C-r>  <C-w>r<C-w>x
nnoremap         <S-Tab>     %
nnoremap         <S-Down>    <Nop>
nnoremap         <S-Up>      <Nop>
nnoremap <silent><LocalLeader>nt           :<C-u>NERDTreeToggle<CR>

" Language:

"" Vim:
" http://ku.ido.nu/post/90355094974/how-to-grep-a-word-under-the-cursor-on-vim
Gautocmdft vim nnoremap <silent><buffer>K  :<C-u>Help<Space><C-r><C-w><CR>

"" Ouickfix:
Gautocmdft qf  nnoremap <buffer><CR>      <CR>

"" Help:
Gautocmdft help nnoremap <silent><buffer><C-n> :<C-u>cnext<CR>
Gautocmdft help nnoremap <silent><buffer><C-p> :<C-u>cprevious<CR>

" -------------------------------------------------------------------------------------------------
" Insert: (i)

" <C-c> doesn't trigger the InsertLeave autocmd
inoremap <C-c> <ESC>

" Move cursor to first or end of line
inoremap <silent><C-a>  <C-o><S-i>
inoremap <silent><C-e>  <C-o><S-a>
" Put +register word
inoremap <silent><C-p>  <C-r>*
inoremap <silent><C-j>  <C-r>*

" Language:

" Deoplete:
inoremap <silent><expr><CR>     pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
inoremap <silent><expr><Tab>    pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr><Up>     pumvisible() ? "\<C-p>"  : "\<Up>"
inoremap <silent><expr><Down>   pumvisible() ? "\<C-n>"  : "\<Down>"
inoremap <silent><expr><C-Up>   pumvisible() ? deoplete#mappings#cancel_popup()."\<Up>" : "\<C-Up>"
inoremap <silent><expr><C-Down> pumvisible() ? deoplete#mappings#cancel_popup()."\<Down>" : "\<C-Down>"
inoremap <silent><expr><Left>   pumvisible() ? deoplete#mappings#cancel_popup()."\<Left>"  : "\<Left>"
inoremap <silent><expr><Right>  pumvisible() ? deoplete#mappings#cancel_popup()."\<Right>" : "\<Right>"
inoremap <silent><expr><C-l>    pumvisible() ? deoplete#mappings#refresh() : "\<C-l>"
inoremap <silent><expr><C-z>    deoplete#mappings#undo_completion()
"
" Neosnippet:
imap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""
smap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""
xmap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""

" -------------------------------------------------------------------------------------------------
" Visual Select: (v)

" Do not add register to current cursor word
vnoremap c       "_c
vnoremap x       "_x
vnoremap P       "_dP
vnoremap p       "_dp
vnoremap @       ^
vnoremap ^       @

" -------------------------------------------------------------------------------------------------
" Visual: (x)
"xmap  <LocalLeader>        <Plug>(operator-replace)
xmap     <silent>ga        <Plug>(EasyAlign)
" xnoremap <expr>r              <Plug>(niceblock#force_blockwise('r'))

xnoremap <silent><C-t>     :<C-u>Trans<CR>

" Language:
"" Go:
" Gautocmdft go xnoremap <buffer> "  '
" Gautocmdft go xnoremap <buffer> '  "

" -------------------------------------------------------------------------------------------------

" Language:
"" Go:
" Gautocmdft go snoremap <buffer> "  '
" Gautocmdft go snoremap <buffer> '  "

" -------------------------------------------------------------------------------------------------
" CommandLine: (c)

" Move beginning of the command line
" http://superuser.com/a/988874/483994
cnoremap <C-a>    <Home>
cnoremap <C-d>    <Del>

" -------------------------------------------------------------------------------------------------
" Terminal: (t)

tnoremap <C-w>       <<C-\><C-n><C-w>
tnoremap <nowait><buffer><BS>    <BS>

" -------------------------------------------------------------------------------------------------

colorscheme dracula 
if has ('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


