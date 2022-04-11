" Plugins
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'preservim/nerdtree'

Plug 'tpope/vim-fugitive'
Plug 't9md/vim-choosewin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'wincent/terminus'
Plug 'bagrat/vim-buffet'
Plug 'mhinz/vim-signify'
Plug 'voldikss/vim-floaterm'
Plug 'Xuyuanp/nerdtree-git-plugin'
if has("gui")
    Plug 'ryanoasis/vim-devicons'
endif
call plug#end()

" buffet shortcuts
nmap b1 <Plug>BuffetSwitch(1)
nmap b2 <Plug>BuffetSwitch(2)
nmap b3 <Plug>BuffetSwitch(3)
nmap b4 <Plug>BuffetSwitch(4)
nmap b5 <Plug>BuffetSwitch(5)
nmap b6 <Plug>BuffetSwitch(6)
nmap b7 <Plug>BuffetSwitch(7)
nmap b8 <Plug>BuffetSwitch(8)
nmap b9 <Plug>BuffetSwitch(9)
nmap b0 <Plug>BuffetSwitch(10)
nmap bc :Bw<CR>
nmap bcf :Bw!<CR>

" choosewin shortcuts
nmap - <Plug>(choosewin)
if has('gui')
    nmap == :set fu<CR>
    nmap =- :set nofu<CR>
endif

" ctrlp shortcuts
noremap ss :CtrlP<CR>
noremap ssb :CtrlPBuffer<CR>
noremap ssm :CtrlPMRU<CR>
noremap ssa :CtrlPMixed<CR>

" floatterm shortcuts
nnoremap   <silent>   <F1>    :FloatermToggle<CR>
tnoremap   <silent>   <F1>    <C-\><C-n>:FloatermToggle<CR>
nnoremap   <silent>   <F2>    :FloatermKill!<CR>
tnoremap   <silent>   <F2>    <C-\><C-n>:FloatermKill!<CR>

" Nerdtree shortcuts
nnoremap <silent><expr> fc (winnr()==g:NERDTree.GetWinNum() ? ":NERDTreeClose\<CR>" : ":NERDTreeFocus\<CR>")
nnoremap <silent> ff :NERDTreeFind<CR>

"Basic vars
let $LANG='en'
let NERDTreeHijackNetrw = 1
let NERDTreeMinimalUI=1
let NERDTreeChDirMode=2
let NERDTreeAutoCenter=1
let NERDTreeAutoCenterThreshold=1
let NERDTreeHighlightCursorline=1
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding =''
let g:airline_theme='owo'
let g:startify_change_to_dir = 1
let g:choosewin_label='qwerty'
let g:ctrlp_map = ''
let g:ctrlp_working_path_mode = 'ra'
let g:floaterm_height=0.5
let g:floaterm_width=0.7
let g:floaterm_title=" Terminal -> $1/$2"
let g:floaterm_autoclose=2
let g:floaterm_borderchars="─│─│┌┐┘└"
" buffet configs
if has('gui')
    let g:buffet_powerline_separators = 1
    let g:buffet_tab_icon = "\uf00a"
    let g:buffet_left_trunc_icon = "\uf0a8"
    let g:buffet_right_trunc_icon = "\uf0a9"
endif
let g:buffet_show_index=1


" Basic settings
set enc=utf-8
set guifont=Inconsolata\ Regular\ Nerd\ Font\ Complete\ Mono:h15
set ruler
set number
set langmenu=en
set guioptions-=r
set guioptions-=L
set guioptions-=b
set guioptions+=!
set completeopt=menuone,noinsert,noselect,preview
set hidden
set expandtab
set tabstop=4
set shiftwidth=4
set termguicolors
set nowritebackup
set hidden
set encoding=utf-8
set cmdheight=2
set updatetime=100
set dir=~/.vim.swcache
set udir=~/.vim.swcache
set bdir=~/.vim.swcache
syntax enable
colorscheme monokai

" buffet ui config
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=74 ctermfg=white guibg=#76CEFF guifg=#000000
  hi! BuffetBuffer cterm=NONE ctermbg=238 ctermfg=white guibg=#424242 guifg=#000000
  hi! BuffetActiveBuffer cterm=NONE ctermbg=74 ctermfg=white guibg=#999999 guifg=white
  hi! BuffetTab cterm=NONE ctermbg=109 ctermfg=234 guibg=#c0c0c0 guifg=#000000
endfunction

" PHP LSP config
if executable('intelephense')
  augroup LspPHPIntelephense
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'intelephense',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
        \ 'whitelist': ['php'],
        \ 'initialization_options': {'storagePath': '.intelephense'},
        \ 'workspace_config': {
        \   'intelephense': {
        \     'files': {
        \       'maxSize': 1000000,
        \       'associations': ['*.php', '*.phtml'],
        \       'exclude': [],
        \     },
        \     'completion': {
        \       'insertUseDeclaration': v:true,
        \       'fullyQualifyGlobalConstantsAndFunctions': v:false,
        \       'triggerParameterHints': v:true,
        \       'maxItems': 100,
        \     },
        \     'format': {
        \       'enable': v:true
        \     },
        \   },
        \ }
        \})
  augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> le <plug>(lsp-document-diagnostics)
    nmap <buffer> ld <plug>(lsp-definition)
    nmap <buffer> ls <plug>(lsp-document-symbol-search)
    nmap <buffer> lS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> lr <plug>(lsp-references)
    nmap <buffer> li <plug>(lsp-implementation)
    nmap <buffer> lt <plug>(lsp-type-definition)
    nmap <buffer> lf <plug>(lsp-document-format)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> lp <plug>(lsp-previous-diagnostic)
    nmap <buffer> ln <plug>(lsp-next-diagnostic)
    nmap <buffer> lh <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function! s:kill_all_floaterm() abort
    for bufnr in floaterm#buflist#gather()
      call floaterm#terminal#kill(bufnr)
    endfor
    return 
endfunction

" NerdTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() <= 0 && exists("s:std_in") | Startify | set nu | endif
autocmd VimEnter * NERDTree ~/ | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()  | call s:kill_all_floaterm() | quit | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call s:kill_all_floaterm() | quit | endif
