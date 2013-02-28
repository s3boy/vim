"个人配置信息(hjd@moxiu.net)
"常用快捷键:
"----- F2   nertree
"----- F3   taglist
"----- F3   buffers管理
"----- F5   刷新项目信息 php: (刷新tags cocspe等) 
"----- F6   最近两个buffer切换
"----- F10  编译/运行
"----- F11  tabnext
"----- F12  tabpreview
"
nmap <F9> <ESC>:Calendar<RETURN>

"mac的默认配置
filetype plugin on
syntax on  
set clipboard=unnamed
"基本配置
set nocompatible
set nu "显示行号
set ruler "在右下角显示光标的坐标
set hlsearch "高亮显示搜索结果
set incsearch "边输边搜，即时更新搜索结果
set showcmd "在ruler左边显示当前正在输入的命令
set expandtab "将tab键改为空格，默认是8个
set tabstop=4 "将tab键改为4个空格
set cindent "使用C语言的规则自动缩进
set shiftwidth=4 "自动缩进时，使用4个空格，默认是8个
"set modeline "自动识别文件格式
set fdm=indent "代码折叠
set nofoldenable
"上一个/下一个标签页切换的快捷键
nmap <F11> <ESC>:tabprevious<RETURN>
nmap <F12> <ESC>:tabnext<RETURN>

"buffers管理
let g:buffergator_viewport_split_policy = "T"
let g:buffergator_split_size = 6
nmap <F4> <ESC>:BuffergatorToggle<RETURN>
nmap <F6> <ESC>:w<RETURN>:b#<RETURN>


" vim copy
" vmap y :w !pbcopy<CR><CR>
" nmap yy :.w !pbcopy<CR><CR>
" nmap p :r !pbpaste<CR><CR>


"PATHOGEN 插件管理插件加载选项
call pathogen#runtime_append_all_bundles()

"NERDTREE插件配置
let NERDTreeWinSize=24
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
nmap <F2> <ESC>:NERDTreeToggle<RETURN>

" taglist配置信息
nmap <F3> <ESC>:TagbarToggle<RETURN>
set tags=tags
set autochdir
let g:tagbar_left = 0
let g:tagbar_width = 24
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_sort = 1


"VimWiki插件配置
let g:vimwiki_list = [{'path': '~/.vim/vimwiki/', 'path_html': '~/.vim/vimwiki_html/'}]
autocmd BufNewFile */diary/*.wiki 0r ~/.vim/template/diary.wiki

"snipMate配置
let g:snips_author = '黄继德<hjd@moxiu.net>'

"php定制内容
autocmd FileType php noremap <C-L> :!php -l %<CR>

"php doc注释插件
nnoremap <C-K> :call PhpDocSingle()<CR>
vnoremap <C-K> :call PhpDocRange()<CR>
let g:pdv_cfg_Uses = '1'
let g:pdv_cfg_Package = 'package'
let g:pdv_cfg_Version = '$Id$'
let g:pdv_cfg_Author = 'hjd <hjd@moxiu.net>'
let g:pdv_cfg_Copyright = ' 2007-2013 moxiu.com'
let g:pdv_cfg_License = '魔秀科技(北京)有限公司 (https://moxiu.net/pm/projects/mx-dev/wiki/源代码管理规范)'

"vim session插件配置
:let g:session_autoload = 'no'
:let g:session_autosave = 'yes'
:let g:session_command_aliases = 1

"同步wiki到svn
command! Wwiki :!svn up ~/.vim/vimwiki/ && svn ci ~/.vim/vimwiki/ -m 'hjd vim ci'


" android 开发相关配置
if has("autocmd")
    augroup uncompress 
        autocmd Filetype java setlocal omnifunc=javacomplete#Complete
        autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo
        autocmd Filetype java call FindManifestFile()
        autocmd Filetype php call FindMxProject()
    augroup END
endif

filetype plugin indent on 

inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType = '<C-X><C-O>'
" 打印
"打印机使用"iP1880-series", 不配置表示使用系统默认打印机.
"set printdevice=iP1880-series
"打印编码使用"utf-8", 不配置的话使用encoding的值.
set printencoding=utf-8
"打印所用的宽字符集为ISO10646, 这个和printencoding值要匹配
set printmbcharset=ISO10646
"打印所用字体, 在linux下, 要用ghostscript里已有的字体, 不然会打印乱码.
set printmbfont=r:STSong-Light,c:yes "MSungGBK-Light
"打印可选项, formfeed: 是否处理换页符, header: 页眉大小, paper: 用何种纸,
"duplex: 是否双面打印, syntax: 是否支持语法高
set printoptions=formfeed:y,header:5,paper:A4,duplex:on,syntax:y
"打印时页眉的格式
set printheader=%<%f%h%m%=Page\ %N


set laststatus=2 
set statusline=[%n]%<%.99f\ %h%w%m%r%=[%Y,%{&ff},%{strlen(&fenc)?&fenc:&enc}]\ %([%l,%c-%v,%p\%%]%)\ M\  


nmap <F8> <ESC>:!echo %:p<RETURN>

colorscheme jellybeans

" php语法风格
let Vimphpcs_Standard='Moxiu'
" php 缩进
let PHP_vintage_case_default_indent=1

"简易的跨服务器复制粘贴
vmap <silent> <leader>y <ESC>:'<,'>w! !curl --data-binary @- -X POST http://moxiu.net/clipboard.php<RETURN><RETURN>
nmap <silent> <leader>p <ESC>:r !curl -s http://moxiu.net/clipboard.php<RETURN>

nmap <M-K> <ESC>:!php %:p<CR>
