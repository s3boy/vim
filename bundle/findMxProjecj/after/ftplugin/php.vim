"mx project插件

function! InitMxProject()
    if $MXAPP_PATH  !~ "^/"
        return 
    endif
    echohl WarningMsg | echo "刷新项目索引:" . $MXAPP_PATH | echohl None
    cd $MXAPP_PATH
    "基础设置 tags cscope设置
    silent exe "!find " . $MXAPP_PATH . " -type f -name \"*.php\"|grep -v \"./src/third-party/mxlibs/Mx/Tpl/\" >cscope.files"
    silent !exuberant-ctags -f tags -L cscope.files --totals=yes --tag-relative=yes --PHP-kinds=+cf --regex-PHP='/abstract class ([^ ]*)/\1/c/' --regex-PHP='/interface ([^ ]*)/\1/c/' --regex-PHP='/(public |static |abstract |protected |private )+function ([^ (]*)/\2/f/' 2>/dev/null 
    silent !cscope -kb -icscope.files 2>/dev/null 
    cs kill #
    exe "cs add " . $MXAPP_PATH . "/cscope.out"
    !clear 
    echohl WarningMsg | echo "刷新完成:" . $MXAPP_PATH | echohl None
endfunction

"递归向上查找mxapp.json文件
function! FindMxappJson(path)
    if (a:path == '' || a:path == '/') 
        return 
    endif
    let desc = a:path . "/mxapp.json"
    if filereadable(desc)
        return a:path
    else
        return FindMxappJson(strpart(a:path, 0, strridx(a:path, '/')))
    endif
endfunction

function! FindMxProject()
    "通过查找父级目录下是否包含 mxapp.json文件来确定是不是个mx项目
    let a:mxapp_path = FindMxappJson($PWD)
    nmap <F10> <ESC>:CodeSniff<CR>
    if type(a:mxapp_path) != 1
        return
    endif

    "设置项目地址的变量
    let g:mxapp_path = a:mxapp_path
    let $MXAPP_PATH = a:mxapp_path

    exe "set tags+=" . a:mxapp_path . "/tags"
    nmap <F5> :call InitMxProject()<CR>

    "如果当前文件为空 模版填充处理
    if line("$") == 1
        exe "0read !mx autofill " . expand("%:p")
        exe line("$") . "d"
    endif
endfunction
