syntax on
set hlsearch
set nocompatible
"set number
set paste
"" set viminfo to enable 'y' more lines
set viminfo='1000,f1,<1000
"" vim修改tab为四个空格：Method 1
"set tabstop=4
"set autoindent
"set expandtab
""
set smartindent
set showmatch
set ruler
set incsearch
"" vim修改tab为四个空格：Method 2
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab "set noexpandtab
""
set cindent
set nobackup
set clipboard+=unnamed
set ignorecase
"colorscheme elflord
"colorscheme desert
"To record last edif position
autocmd BufReadPost * if line("'\"")>0&&line("'\"")<=line("$") | exe "normal g'\"" | endif
set laststatus=2

"shortcut
map <silent><F2> :q<cr>

" Taglist
map <silent><F8> :TlistToggle<cr>    "在映射F8键打开tags窗口
"map <F8> :Tlist<CR>
set tags=tags;
set autochdir
"nnoremap <silent> <F8> : TlistToggle<CR>
"let Tlist_Use_Right_Window = 1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Show_One_File = 1
"let Tlist_Ctags_Cmd = ""
let Tlist_Inc_Winwidth = 0
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Display_Prototype = 1
"let Tlist_Auto_Open = 1
"let Tlist_Ctags_Cmd="c:\\usr\\bin\\ctags"
set tags+=tags
set tags+=~/vimfiles/tags/libc.tags
set tags+=~/vimfiles/tags/susv2.tags
set tags+=~/vimfiles/tags/glib.tags
set tags+=~/vimfiles/tags/cpp.tags

"set tags=tags

function! UpdateCtags()
    let curdir=getcwd()
    while !filereadable("./tags")
        cd ..
        if getcwd() == "/"
            break
        endif
    endwhile
    if filewritable("./tags")
        !ctags -R --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q
        TlistUpdate
    endif
    execute ":cd " . curdir
endfunction

nnoremap <silent> <F11> : call UpdateCtags()<CR>

set completeopt=longest,menu

" cscope
if has("cscope")
    set cscopequickfix=s-,c-,d-,i-,t-,e-
endif

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" SuperTab
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<C-X><C-O>"

" Favourate
set tabstop=4
set shiftwidth=4
"set number
set nobackup
colorscheme desert

" Chinese help
if  version >= 603
    set helplang=cn
endif

"cscope_quickfix.vim

"If you don't want to open quickfix window after :Cscope command, put a line in .vimrc like: 
let Cscope_OpenQuickfixWindow = 0 
"If you don't want to jump first item after :Cscope command, put a line in .vimrc like: 
let Cscope_JumpError = 0 
"If you want to use Popup menu for :Cscope command, put a line in .vimrc like: 
let Cscope_PopupMenu = 1 
"If you don't want to use Tools menu for :Cscope command, put a line in .vimrc like: 
let Cscope_ToolsMenu = 0


"c.vim
"let  g:C_UseTool_cmake    = 'yes' 
"let  g:C_UseTool_doxygen = 'yes'



"-------[ Status bar ]------------------------------------❱----{{{1

set statusline =%7*[%n]%*
set statusline +=%1*%F\ %*%8*%m%r%*%1*%h%w%* "filename
set statusline +=%7*\|%*
set statusline+=%2*\ %Y: "filetype
set statusline+=%{&ff}:  "dos/unix
set statusline+=%{&fenc!=''?&fenc:&enc}\ %* "encoding

"fugitve branch
"set statusline +=%8*%{fugitive#head()!=''?'['.fugitive#head().']':''}%2*\ 

set statusline +=%7*\|%*
set statusline+=%2*\ ASCII:%b\ %*  " ascii 
set statusline +=%7*\|%*
set statusline+=%2*\ row:%l/%*%1*%L%*%2*\ %*%1*%p%%%*%2*\ \ col:%v\ %*
set statusline +=%7*\|%*


""color in terminal
"hi User1 cterm=bold ctermfg=black ctermbg=67
"hi User2 ctermfg=black ctermbg=246
"hi User7 cterm=bold ctermfg=245 ctermbg=237
"hi User8 ctermfg=black ctermbg=167
"
""color in gvim
"hi User1  gui=bold guifg=#000000 guibg=#5B89C7
"hi User2  guifg=#000000 guibg=#949494
"hi User7  gui=bold guifg=#8a8a8a guibg=#3a3a3a
"hi User8  guifg=#000000 guibg=#d75f5f
""set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}G\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
"set laststatus=2
"
""set cursor line color
"set cul "highlighting cusor line


"set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P
"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P



"-------[ Functions ]-------------------------------------{{{1

"do chmod +x if the first line of the buffer beginning with #!
"this would be called on autocmd event BufWritePost
function! AutoCmd_chmodx()
	if getline(1) =~ '#!'
		let f = shellescape(@%,1)
		if stridx(getfperm(f), 'x') != 2
			call system("chmod +x ".f)
			e!
			filetype detect
		endif
	endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

hi User1 guifg=#eea040 guibg=#222222
hi User2 guifg=#dd3333 guibg=#222222
hi User3 guifg=#ff66ff guibg=#222222
hi User4 guifg=#a0ee40 guibg=#222222
hi User5 guifg=#eeee40 guibg=#222222

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set statusline=
"set statusline+=%7*\[%n]                                  "buffernr
"set statusline+=%1*\ %<%F\                                "File+path
"set statusline+=%2*\ %y\                                  "FileType
"set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
"set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
"set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
"set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
"set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
"set statusline+=%9*\ col:%03c\                            "Colnr
"set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
"
"function! HighlightSearch()
"  if &hls
"    return 'H'
"  else
"    return ''
"  endif
"endfunction
"
"hi User1 guifg=#ffdad8  guibg=#880c0e
"hi User2 guifg=#000000  guibg=#F4905C
"hi User3 guifg=#292b00  guibg=#f4f597
"hi User4 guifg=#112605  guibg=#aefe7B
"hi User5 guifg=#051d00  guibg=#7dcc7d
"hi User7 guifg=#ffffff  guibg=#880c0e gui=bold
"hi User8 guifg=#ffffff  guibg=#5b7fbb
"hi User9 guifg=#ffffff  guibg=#810085
"hi User0 guifg=#ffffff  guibg=#094afe

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

