" setting
"se fenc=utf-8
se nobackup
se noswapfile
se showcmd

" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" looks
se nu
se cursorline
" se cursorcolumn
se smartindent
se showmatch
se laststatus=2
se wildmode=list:longest

se t_vb=
se novisualbell

" tab
se list listchars=tab:\▶\-

" search
se ignorecase
se smartcase
se incsearch
se hlsearch

" editting
se shiftround
se infercase
se hidden
se switchbuf=useopen
se showmatch
se matchtime=2
se matchpairs& matchpairs+=<:>  " add <>

" key setting
nmap <silent> <Esc><Esc> :nohlsearch<CR>    " ESCを二回押すことでハイライトを消す
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" plugin

if &compatible
  se nocompatible
endif
se runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('davidhalter/jedi-vim')

call dein#end()

" Jedi for python
if ! empty(dein#get("jedi-vim"))
  let g:jedi#auto_initialization = 1
  let g:jedi#auto_vim_configuration = 1

  nnoremap [jedi] <Nop>
  xnoremap [jedi] <Nop>
  nmap <Leader>j [jedi]
  xmap <Leader>j [jedi]

  let g:jedi#completions_command = "<C-Space>"    " 補完キーの設定この場合はCtrl+Space
  let g:jedi#goto_assignments_command = "<C-g>"   " 変数の宣言場所へジャンプ（Ctrl + g)
  let g:jedi#goto_definitions_command = "<C-d>"   " クラス、関数定義にジャンプ（Gtrl + d）
  let g:jedi#documentation_command = "<C-k>"      " Pydocを表示（Ctrl + k）
  let g:jedi#rename_command = "[jedi]r"
  let g:jedi#usages_command = "[jedi]n"
  let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0

  autocmd FileType python setlocal completeopt-=preview

  " for w/ neocomplete
  if ! empty(dein#get("neocomplete.vim"))
    autocmd FileType python setlocal omnifunc=jedi#completions
    let g:jedi#completions_enabled = 0
    let g:jedi#auto_vim_configuration = 0
    let g:neocomplete#force_omni_input_patterns = {}
    let g:neocomplete#force_omni_input_patterns.python = 
      \'\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
  endif
endif
