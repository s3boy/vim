function! MakeAndroidProject()
    :cd $ANDROIDPROJECTPATH 
    !ant debug && ant installd
endfunction

function! FindManifestFile()
python << endpython
import vim
import os
import os.path

def find_manifest(path):
    found = False
    dirs = os.listdir(path)
    for d in dirs:
        if d=="AndroidManifest.xml" :
            return True
    return False

found = False
pwd = os.getcwd()

found = find_manifest(pwd)

while not found:
    if pwd=='/':
        break
    os.chdir(pwd+'/..')
    pwd = os.getcwd()
    found = find_manifest(pwd)

if found:
    ANDROID_SDK = os.environ['ANDROID_SDK']
    if ANDROID_SDK=='':
        exit(0)
    cmd = "set tags+=/Users/huangjide/.vim/android/sdk_tags," + pwd + "/tags"
    vim.command(cmd)
    if os.path.isfile(pwd+ "/project.properties") :
        cmd = "let $ANDROIDPROJECTPATH = '" + pwd + "'"
        vim.command("nmap <F10> :call MakeAndroidProject()<CR>")
        vim.command(cmd)
        cmd = "let s:androidSdkPath = '" + ANDROID_SDK + "'"
        vim.command(cmd)
        cmd = "vimgrep /target=/j " + pwd + "/project.properties"
        vim.command(cmd)
        vim.command("let s:androidTargetPlatform = split(getqflist()[0].text, '=')[1]")
        vim.command("let s:targetAndroidJar = s:androidSdkPath . '/platforms/' . s:androidTargetPlatform . '/android.jar'")
        target = vim.eval("s:targetAndroidJar")
        cmd = "let $CLASSPATH = '" + target + "'"
        vim.command(cmd)
endpython
endfunction
