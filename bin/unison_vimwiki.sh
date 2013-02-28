#!/bin/bash
unison -batch /home/huangjide/.vim/vimwiki ssh://huangjide@zuogehaoren.com//home/huangjide/unison_data/vimwiki -ignore "Name *.swo"  -ignore "Name *.swp"  -ignore 'Name .svn'
