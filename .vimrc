execute pathogen#infect()
syntax on
filetype plugin indent on

set t_Co=256
set encoding=utf-8

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" highlight cursor line
function s:SetCursorLine()
    set cursorline
            hi cursorline cterm=none ctermbg=235
      endfunction
autocmd VimEnter * call s:SetCursorLine()

set background=dark
set nu
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set ic
set nowrap
set list listchars=tab:\ \ ,eol:¬
set foldmethod=syntax
set foldlevel=99
set hlsearch

" exit insert mode with jj
inoremap jj <ESC>
" comment line (c style) with ctrl-c
nnoremap <C-e> 0i//<ESC>j0
" uncomment line with ctrl-q
nnoremap <C-q> 0xx
" jump 10 lines up and down with ctrl-k and ctrl-j
nnoremap <C-k> 10k
nnoremap <C-j> 10j
" jump between buffers with ) and (
nnoremap ) :bn<CR>
nnoremap ( :bp<CR>
" delete buffer with D
nnoremap D :bd<CR>
" add empty line below with _
nnoremap # o<ESC>k
" toggle fold with E
nnoremap E za
" toggle nerd tree with ctrl-n
map <C-n> :NERDTreeToggle<CR>

if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

" beautify your color-scheme
autocmd FileType * call <SID>def_base_syntax()
function! s:def_base_syntax()
	syntax match commonOperator "\(=\|+=\|&&\|-=\|<=\|>=\|<<=\|>>=\|&=\|\\=\|*=\||=\|!=\|||\)"
	syntax match Integers "\(uint32\|uint16\|uint8\|uint64\|\w\+_t\(\s\|;\)\@=\|\w\+_type\s\)"
"	syntax match braces1 "\((\|)\)"
"	syntax match braces2 "\({\|}\)"
"    hi braces1 ctermfg=cyan
"    hi braces2 ctermfg=122
	hi commonOperator ctermfg=cyan
	hi link Integers Type
    hi Folded ctermbg=233 ctermfg=white cterm=bold
    hi Search ctermbg=darkgray ctermfg=NONE
	hi Comment ctermfg=lightblue
	hi LineNr ctermfg=darkgray
	hi CursorLineNr ctermfg=gray
	hi Type ctermfg=red
    hi NonText ctermfg=238
    hi Comment ctermfg=244
    hi PreCondit ctermfg=13
    " mark extra white spaces
    hi ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    if (&filetype == 'c' || &filetype == 'cpp')
        syntax match cCustomParen "?=(" contains=cParen,cCppParen
        syntax match cCustomFunc "\w\+\s*(\@=" contains=cCustomParen
        syntax match cCustomFuncDec "\(void\|u\?int\(8\|16\|32\|64\)\?\|struct \w\+\|\w\+_t\|\w\+_type\)\@<=\s\+\w\+\s*\((\)\@=" contains=cCustomParen,cType,Integers
        syntax match cCustomScope "::"
        syntax match cCustomClass "\w\+\s*::" contains=cCustomScope
        hi link cCustomFunc Function
        hi Function ctermfg=lightblue
        hi cCustomFuncDec ctermfg=green
        hi cCustomClass ctermfg=lightblue
    endif
endfunction

" beautify your function folds
function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

set foldtext=NeatFoldText()

" toggle cursor-colum
fu! ToggleCurline ()
    if &cursorcolumn
        set nocursorcolumn
    else
        set cursorcolumn
    endif
endfunction

let mapleader = ","
" toggle cursor-colum with cl
map cl :call ToggleCurline()<CR>
" map :gig to :!git grep -in, allowing free text to come after
map <Leader>gig :!git grep -in
" map :gis to git grep -in word under cursor
map <Leader>gis yiw:!git grep -in <C-r>"<CR>
" plugins:
"
" pathogen vim:
" mkdir -p ~/.vim/autoload ~/.vim/bundle && \
" curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
"
" nerdtree vim:
" git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
"
" ctrlp:
" cd ~/.vim/bundle && git clone https://github.com/kien/ctrlp.vim
"
" fugitive:
" cd ~/.vim/bundle && git clone https://github.com/tpope/vim-fugitive
"
" airline:
" git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
"
" google-searchindex
" cd ~/.vim/bundle && git clone https://github.com/google/vim-searchindex.git
"
" persistent undo:
" mkdir ~/.vim/undo
"
"
" fonts:
" cp -rf ~amichaim/.fonts ~/
" cp -rf /labhome/amichaim/.config/fontconfig ~/
"
"
"
"
"  git clone https://github.com/powerline/fonts.git --depth=1
"  cd fonts
"  ./install.sh
"  cd ..
"  rm -rf fonts
