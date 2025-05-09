if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    \ >/dev/null 2>&1
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

Plug 'Rigellute/rigel'
Plug 'GlennLeo/cobalt2'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'vimlab/split-term.vim'
Plug 'tpope/vim-vinegar'
call plug#end()

set fileformat=unix "LF
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set clipboard+=unnamed

set showcmd


"mitame

set termguicolors
syntax enable
"colorscheme rigel
colorscheme cobalt2
let g:rigel_airline = 1
let g:airline_theme ='rigel'
let g:rigel_lightline = 1
let g:lightline = { 'colorscheme': 'rigel'}
set title
set showcmd
set number
set cursorline
set virtualedit=onemore
set autoindent
set smartindent
set expandtab

set tabstop=4
set shiftwidth=4
set softtabstop=4

set showmatch
set laststatus=2
set wildmode=list:longest
syntax enable

set list listchars=tab:>-,trail:-

"file editor
set splitbelow
set termwinsize=5*0
let g:netrw_banner=0
let g:netrw_liststyle=3

let g:netrw_browse_split=4
let g:netrw_preview=1
let g:netrw_winsize=75
" NERDTree を左に表示
"
nnoremap <C-n> :NERDTreeToggle<CR>
" ウィンドウ移動を楽に（Ctrl + hjkl）
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" ファイルを開いても NERDTree を閉じないようにする
let g:nerdtree_quit_on_open = 0

" Running Cat (loading animation) {{{
let s:runcat = #{frame: 0, winid: 0, tid: 0, delay: 100, fg: 239, fgmax: 255, fgmin: 17}
fu! s:runcat.animation(_) abort
    cal setbufline(winbufnr(self.winid), 1, self.cat[self.frame])
    exe 'hi RunningCat ctermfg='.self.fg
    cal matchadd('RunningCat', '[^ ]', 16, -1, #{window: self.winid})
    let self.fg = self.fg == self.fgmax ? self.fgmin : self.fg+1
    let self.frame = self.frame == len(self.cat)-1 ? 0 : self.frame+1
    let self.tid = timer_start(self.delay, self.animation)
endf
fu! s:runcat.stop() abort
    cal popup_close(self.winid)
    cal timer_stop(self.tid)
endf
fu! s:runcat.start(...) abort
    cal self.stop()
    let self.delay = a:0 ? 700-(a:1-1)*140 : self.delay
    let self.winid = popup_create(self.cat[0], #{line: 1, zindex: 1})
    cal self.animation(0)
endf
fu! s:runcat_gear_list(A, L, P) abort
    retu ['1', '2', '3', '4', '5']
endf

" running cat AA {{{
let s:runcat.cat = [
    \[
    \ '                                                            ',
    \ '                               =?7I=~             ~~        ',
    \ '                            =NMMMMMMMMMD+      :+OMO:       ',
    \ '                          ~NMMMMMMMMMMMMMMMNNMMMMMMMM=      ',
    \ '                        :DMMMMMMMMMMMMMMMMMMMMMMMMMMMN=     ',
    \ '                      IMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8:     ',
    \ '                  :$MMMMMMMMMMMMMMMMMMMMMMMMMMMM?           ',
    \ '             :~ZMMMMMNI :DMMMMMMMMMMMMMMMMMNN$:             ',
    \ '       :+8NMMMMMMMO~     =NMMMMMMM?  +MMD~                  ',
    \ '     8MMMMMMM8+:           :?OMMMM+ =NMM~                   ',
    \ '                             :DMMZ  7MM+                    ',
    \ '                              ?NMMMMMMD:                    ',
    \ '                                 :?777~                     ',
    \],
    \[
    \ '                                                            ',
    \ '                                                     :O~    ',
    \ '                                          +I777ZDNMMMMMI    ',
    \ '                        :+Z8DDDNNNNDD88NMMMMMMMMMMMMMMMM$   ',
    \ '                     +DMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM=  ',
    \ '                  :$MMMMMMMMMMMMMMMMMMMMMMMMMMMMMN888DMM8:  ',
    \ '                :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMD            ',
    \ '              ?NMMMMMMMMMMMMMMMMMMMMMMMMD?~=DMMMI           ',
    \ '    7MMMMMMMMMMMMZ+NMMMMMMMMMNNNNN87?~: +NDDMMN~            ',
    \ '     ~?$OZZI=:   7MMMMMMMMMN=            =DM8:              ',
    \ '                  8MMN888$:                                 ',
    \ '                  :DMMD$                                    ',
    \ '                    =7$=                                    ',
    \],
    \[
    \ '                                                            ',
    \ '                                                            ',
    \ '                         ~~++?????IIIIIIII7$77I?+I$$77OD:   ',
    \ '              ~7ODNNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7   ',
    \ '         ~ZNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM?  ',
    \ '      :$MMMMZ=?MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM$  ',
    \ '    =NMM8~  :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8: :~77   ',
    \ '  =NMM+  :DMMMMMMMMMMMMMN+     :=OMMMMMMMMMMD$8MMMMMD?      ',
    \ ' OMN=  ?NMMMMMMMMMMNZ+::             ::~::      IMMMMMMM$   ',
    \ ' ::  ZMMMMMMN?:                                =MMO:  =$~   ',
    \ '    ~8Z~DMN=                                                ',
    \ '                                                            ',
    \ '                                                            ',
    \],
    \[
    \ '                                                            ',
    \ '                      :IZOZI:                               ',
    \ '                   INMMMMMMMMMD+                     ?:     ',
    \ '                =DMMMMMMMMMMMMMMMM8$II7$OO87:  :=ODDMM+     ',
    \ '             :OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM8    ',
    \ '           =NMMD+ 8MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMI   ',
    \ '        :8MMMZ7DDDMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7   ',
    \ '      +NMMM7 ~MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM7           ',
    \ '   :7MMMM7   +MMNMMMMM$: :?8NNMMMMMMMMMMNNMMMMMN:           ',
    \ '  =DMMN?    :8MM~  :                      :8MMMMMMMMN8?:    ',
    \ '   =~      8MMM7                             ?8MMMD+?ZNM?   ',
    \ '            +~                                  :$NMMN7     ',
    \ '                                                   :IDD=    ',
    \],
    \[
    \ '                                                            ',
    \ '                            ~~:                             ',
    \ '                        =ONMMMMMMD$~                        ',
    \ '                     +8MMMMMMMMMMMMMNZ:           :         ',
    \ '                  ~8MMMMMMMMMMMMMMMMMMMMDD8DDDNDDM8         ',
    \ '               =OMMMM$DMMMMMMMMMMMMMMMMMMMMMMMMMMMM+        ',
    \ '           :OMMMMNI:  NMMMMMMM$ZNMMMMMMMMMMMMMMMMMM8:       ',
    \ '        ~DMMMNI:    :NMMMMMMMZ   =NMMMMMMMMMMMMMMMMM=       ',
    \ '      =NMMN+         OMMMMMD~      :ZNMMMMMMMMO  :+:        ',
    \ '      :?=:            +MM?            7MM8 +NMMMI:          ',
    \ '                       :NM8=           ZM$    :ZNMMMD       ',
    \ '                         ?$=           :DMO:       II       ',
    \ '                                        :I+                 ',
    \]
\]
" }}}

com! -bar -nargs=? -complete=customlist,s:runcat_gear_list RunCat cal s:runcat.start(<f-args>)
com! -bar RunCatStop cal s:runcat.stop()
