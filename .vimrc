" dein{{{
" dein初期設定{{{
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.vim/plugins')
" dein.vim 本体
let s:dein_repo_dir = expand('~/.vim/dein.vim')

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
"}}}
" dein-add{{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
"  let s:go = g:rc_dir . '/go.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
"  call dein#load_toml(s:go, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif
"}}}
" dein後処理{{{
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
"}}}
"}}}

" 折りたたみ機能を追加{{{
  au FileType vim setlocal foldmethod=marker
  au FileType toml setlocal foldmethod=marker
"}}}
"keymap(vim){{{
" 上下移動は位置を保持するように
noremap j gj
noremap k gk

" Shift+移動キーで終端まで移動できるように
noremap <S-h>   b
noremap <S-l>   w
noremap <S-j>   }
noremap <S-k>   {

" Option+移動キーで移動できるように(不安定/Mac専用)
noremap <D-h>   ^
noremap <D-l>   $

" Ctrl+移動キーで移動できるように
noremap <C-h>   ^
noremap <C-l>   $
noremap <C-j>   }
noremap <C-k>   {

" (shift)Tab でインデント
nnoremap <Tab>  >> 
nnoremap <S-Tab> << 
vnoremap <Tab>  >> 
vnoremap <S-Tab> << 

" BS無効化(C-hで可能)
inoremap <BS>  <Nop>
" typo抑制
inoremap <C-J>  <Nop>
inoremap <C-k>  <Nop>
inoremap <C-l>  <Nop>

" 保存コマンド無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" フォーマット + exMode無効化
nnoremap Q gq

" Sキーを無効化
nnoremap s <Nop>
nnoremap S <Nop>

" ペインの分割
nnoremap s" :<C-u>sp<CR>
nnoremap s% :<C-u>vs<CR>

" ペインの切り替えとサイズ変更
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>+
nnoremap sK <C-w>-
nnoremap sL <C-w>>
nnoremap sH <C-w><

" タブ切り替えキー変更
nnoremap Sl gT
nnoremap Sh gt

" レコーディングモードの一部無効化
nnoremap qH <Nop>
nnoremap qJ <Nop>
nnoremap qK <Nop>
nnoremap qL <Nop>
nnoremap qQ <Nop>

nnoremap qh <Nop>
nnoremap qj <Nop>
nnoremap qk <Nop>
nnoremap ql <Nop>
nnoremap qq <Nop>

" S-J(改行削除)の再配置
noremap <S-d>   J 

" ノーマルモードでコロンとセミコロンを同一視する
nmap ; :

" ROモード上書き防止
augroup NoWrite
  au!
    au BufWrite * if &ro | throw 'それをかきかえるだなんてとんでもない！' | endif
    augroup END
"}}}
" vim-switch-setting{{{
" 行番号を表示
set relativenumber
set number

" ルーラーを表示
set ruler

" 入力中のコマンドをステータスに表示する
set showcmd

" 括弧入力時の対応する括弧を表示
set showmatch

" シンタックスハイライトを有効にする
syntax on

" 検索結果文字列のハイライトを有効にする
set hlsearch

" コメント文の色を変更
highlight Comment ctermfg=DarkCyan

" コマンドライン補完を拡張モードにする
set wildmenu

" 入力されているテキストの最大幅(勝手に改行される)を無効にする
set textwidth=0

" ウィンドウの幅より長い行は折り返して、次の行に続けて表示する
set wrap

" タイプライタースクロールモード
set scrolloff=9999

" カーソル行の背景色を変更
set cursorline

" タブの代わりに空白文字を挿入する
set expandtab

" タブ文字の表示幅
set tabstop=4
set shiftwidth=4

" 一部のファイルでのタブ設定上書き
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.md setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.css setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.htm setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead .vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead makefile setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
  autocmd BufNewFile,BufRead *.re setlocal tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
augroup END

" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

" 改行時に前の行のインデントを継続する
set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

" カレントディレクトリのvimrcを読み込む
if (!exists('s:dir'))
  let s:dir = getcwd()
  let s:ans = findfile(".vimrc", fnameescape(s:dir) . ";")

  if len(s:ans) > 1
    let s:rc = fnamemodify(s:ans, ":p:h") . "/.vimrc"
    call feedkeys(":source".s:rc."\<cr>")
  endif
endif
"}}}
" 色とステータスラインの設定 {{{
" ステータスラインを表示
set laststatus=2

" 検索結果の色を修正
hi Search gui=bold ctermbg=lightyellow ctermfg=black " Modefi

" ステータスラインの基礎色
hi StatusLine   term=NONE cterm=NONE ctermfg=black ctermbg=white
" カーソルラインの基礎色
hi CursorLineNr gui=bold ctermbg=blue ctermfg=white"{{{}}}

" 各項目の色
hi User1 gui=bold ctermbg=blue ctermfg=white        " Mode (後で上書きされる)
hi User2 gui=bold ctermbg=lightyellow ctermfg=black " Modefi
hi User3 gui=bold ctermbg=darkred ctermfg=white     " ReadOnly
hi User4 gui=bold ctermbg=magenta ctermfg=white     " GitBranch

" Gitのブランチ取得用{{{
function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    lcd %:p:h
    let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
    lcd -
    if l:gitrevparse!~"fatal: not a git repository"
      let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').")"
    endif
  endif
endfunction
augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END
"}}}
" ステータスラインの変化用{{{
function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    hi User1 gui=bold ctermbg=blue ctermfg=white
    hi CursorLineNr gui=bold ctermbg=blue ctermfg=white
    return "NORMAL"
  elseif l:mode==?"v"
    hi User1 gui=bold ctermbg=green ctermfg=white
    hi CursorLineNr gui=bold ctermbg=green ctermfg=white
    return "VISUAL"
  elseif l:mode==#"i"
    hi User1 gui=bold ctermbg=red ctermfg=white
    hi CursorLineNr gui=bold ctermbg=red ctermfg=white
    return "INSERT"
  elseif l:mode==#"R"
    hi User1 gui=bold ctermbg=darkred ctermfg=black
    hi CursorLineNr gui=bold ctermbg=darkred ctermfg=black
    return "REPLACE"
  elseif l:mode==?"s"
    hi User1 gui=bold ctermbg=blue ctermfg=white
    hi CursorLineNr gui=bold ctermbg=blue ctermfg=white
    return "SELECT"
  elseif l:mode==#"t"
    hi User1 gui=bold ctermbg=lightgreen ctermfg=black
    hi CursorLineNr gui=bold ctermbg=lightgreen ctermfg=black
    return "TERMINAL"
  elseif l:mode==#"c"
    hi User1 gui=bold ctermbg=lightgreen ctermfg=black
    hi CursorLineNr gui=bold ctermbg=lightgreen ctermfg=black
    return "COMMAND"
  elseif l:mode==#"!"
    hi User1 gui=bold ctermbg=lightgreen ctermfg=black
    hi CursorLineNr gui=bold ctermbg=lightgreen ctermfg=black
    return "SHELL"
  endif
  redraw
endfunction
"}}}

" ステータスライン
set statusline=
set statusline+=%1*\[%{StatuslineMode()}] 
set statusline+=%0*\ %f\ 
set statusline+=%2*\%m
set statusline+=%3*\%r
set statusline+=%3*\%h
set statusline+=%0*\ 
let b:gitbranch=get(b:, 'gitbranch', '')
set statusline+=%4*\%{b:gitbranch}
set statusline+=%0*\%=
set statusline+=%{strlen(&fenc)?&fenc:'none'}\ \|\ 
set statusline+=%l\/%L(%P)
"}}}
" quickfix ウィンドウのみの場合に自動で閉じる{{{
augroup QfAutoCommands
  autocmd!
  autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | quit | endif
augroup END
"}}}

