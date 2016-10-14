" NeoBundle がインストールされていない時、
" もしくは、プラグインの初期化に失敗した時の処理
" Enable snipMate compatibility feature.
"
  " neocomplcache
function! s:WithoutBundles()
 " colorscheme hybrid
  " その他の処理
endfunction

" NeoBundle よるプラグインのロードと各プラグインの初期化
function! s:LoadBundles()
" ...
  " 読み込んだプラグインの設定
" ... 
 


"-------キー設定-------
"  set encoding=utf-8 
  set fileencodings=utf-8,ucs2le,ucs-2,cp932,euc-jp
  set showmatch
  set expandtab 
  set expandtab "タブ入力を複数の空白入力に置き換える
  set tabstop=2 "画面上でタブ文字が占める幅
  set shiftwidth=2 "自動インデントでずれる幅
  set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
  set autoindent "改行時に前の行のインデントを継続する
  set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
  set ruler
  set backspace=indent,eol,start
  set virtualedit+=block
  set nowrapscan
  "現在の行を表示
  set cursorline
  hi clear CursorLine
 
  " ビジュアルモードでのヤンク後にカーソルを選択前の位置に戻さない
  vnoremap y y`>
  nnoremap <silent><C-e> :NERDTree<CR>

  set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P 
  
  ""uniteの設定
  " insert modeで開始
  let g:unite_enable_start_insert = 1

  " 大文字小文字を区別しない
  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
  " grep検索
  nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
  " カーソル位置の単語をgrep検索
  nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
  " grep検索結果の再呼出
  nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
  nnoremap <silent> ,o : <C-u>Unite -vertical -winwidth=30 outline<CR>
  "unite-oulineの設定
  " バッファ一覧
  nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
  " ファイル一覧
  nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
  " レジスタ一覧
  nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
  " 最近使用したファイル一覧
  nnoremap <silent> ,um :<C-u>Unite file_mru<CR>

  " unite grep に ag(The Silver Searcher) を使う
  if executable('ag')
      let g:unite_source_grep_command = 'ag'
      let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
      let g:unite_source_grep_recursive_opt = ''
  endif

  "矢印キーでは表示行単位で行移動する
  set ruler
  set number
" Disable AutoComplPop.
  set backspace=indent,eol,start
  set et ts=4 sts=4 sw=4 fenc=utf-8 ff=unix
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  " ファイル全般に設定
  augroup General
    autocmd!
    " 設定の保存と復元
    autocmd BufWinLeave * silent mkview
    autocmd BufWinEnter * silent loadview
  augroup END

  " 挿入モードでのカーソル移動
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-h> <Left>
  inoremap <C-l> <Right>

  let g:syntastic_enable_signs=1
  let g:syntastic_auto_loc_list=1
  let g:syntastic_mode_map = { 'mode': 'active',
              \ 'active_filetypes': ['php'],
              \ 'passive_filetypes': []
              \ }
  let g:syntastic_php_checkers=['php']
  let g:syntastic_quite_warnings=0
  " Enable heavy features.
  " Use camel case completion.
  "let g:neocomplcache_enable_camel_case_completion = 1
  " Use underbar completion.
  "let g:neocomplcache_enable_underbar_completion = 1

  " Define dictionary.
  " complcache_dictionary_filetype_lists
  let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
          \ }

  " Define keyword.
  if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     neocomplcache#undo_completion()
  inoremap <expr><C-l>     neocomplcache#complete_common_string()
  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y>  neocomplcache#close_popup()
  inoremap <expr><C-e>  neocomplcache#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

 " let g:neocomplcache_enable_camel_case_completion = 1
 " let g:neocomplcache_enable_underbar_completion = 1
"f let g:neocomplcache_smart_case = 1
 " let g:neocomplcache_min_syntax_length = 3
 " let g:neocomplcache_manual_completion_start_length = 0
 " let g:neocomplcache_caching_percent_in_statusline = 1
 " let g:neocomplcache_enable_skip_completion = 1
 " let g:neocomplcache_skip_input_time = '0.5'
  "
  " 
  "" inoremap { {}<LEFT>
 "" inoremap < <><LEFT>
 """" inoremap % % %<LEFT>
""  inoremap [ []<LEFT>
 "" inoremap ( ()<LEFT>
  inoremap {<Enter> {}<Left><CR><ESC><S-o>
  inoremap [<Enter> []<Left><CR><ESC><S-o>
  inoremap (<Enter> ()<Left><CR><ESC><S-o>
  inoremap " ""<LEFT>
  inoremap ' ''<LEFT>
  vnoremap { "zdi^V{<C-R>z}<ESC>
  vnoremap [ "zdi^V[<C-R>z]<ESC>
  vnoremap ( "zdi^V(<C-R>z)<ESC6
  vnoremap " "zdi^V"<C-R>z^V"<ESC>
  vnoremap ' "zdi'<C-R>z'<ESC>

  "空行のインデントを勝手に消さない
  nnoremap o oX<C-h>
  nnoremap O OX<C-h>
  inoremap <CR> <CR>X<C-h>

if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif
endfunction


" NeoBundle がインストールされているなら LoadBundles() を呼び出す
" そうでないなら WithoutBundles() を呼び出す
function! s:InitNeoBundle()
  if isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    filetype plugin indent off
    if has('vim_starting')
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif
    try
      call neobundle#begin(expand('~/.vim/bundle/'))
        " 読み込むプラグインの指定
	      NeoBundle 'Shougo/neobundle.vim'
	      NeoBundle 'tpope/vim-surround'
      	NeoBundle 'scrooloose/nerdtree' 
  	    " NeoBundle 'davidhalter/jedi-vim'
      	NeoBundle "neocomplete.vim"
  	    NeoBundle 'Shougo/neosnippet'
      	NeoBundle 'itchyny/lightline.vim'
      	NeoBundle 'Shougo/neosnippet-snippets'
  	    NeoBundle 'Shougo/neocomplcache'
      	NeoBundle 'mattn/emmet-vim'
  	    NeoBundle 'nanotech/jellybeans.vim'
      	NeoBundle 'tomasr/molokai'
  	    NeoBundle 'scrooloose/syntastic'
      	NeoBundle "Shougo/unite.vim"
  	    NeoBundle "https://github.com/Shougo/vimproc" 
      	NeoBundle "Shougo/neomru"
  	    NeoBundle "Shougo/unite-outline"
      	NeoBundle "ctrlpvim/ctrlp.vim"
        NeoBundle "tyrannicaltoucan/vim-deep-space"
        call s:LoadBundles()
      call neobundle#end()
      " colorscheme はbundle#end()の外に記述
      "colorscheme molokai
      colorscheme deep-space
    catch
      call s:WithoutBundles()
    endtry 
  else
    call s:WithoutBundles()
  endif

  filetype indent plugin on
  syntax on
endfunction

call s:InitNeoBundle()
