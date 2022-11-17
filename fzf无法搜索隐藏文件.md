这样可以解决以下问题：找不到点文件，而是找到任何隐藏目录中的文件（例如，内部的文件 .git 要么 .svn 目录）仍然被忽略。
如果您也需要在隐藏目录中列出文件（您可能不需要），请尝试以下操作：

export FZF_DEFAULT_COMMAND='find . -type f -print -o -type l -print 2> /dev/null | sed s/^..//' 
然后 fzf 应该按照您想要的方式工作。

你能告诉我如何忽略文件吗 .DS_Store？我尝试添加 -not -name '.DS_Store' 但它似乎不起作用。
添加新条件很重要。如果你需要 prune .DS_Store以及其他点文件，一种方法是添加 -o -name .DS_Store 之前 -prune 因此最终的导出命令（基于答案中的第一个命令）将是 export FZF_DEFAULT_COMMAND='find . -path '*/\.*' -type d -o -name .DS_Store -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//'
我尝试添加 -o -name .DS_Store 如您所说，但是它现在在 .git 夹。
尝试这个 export FZF_DEFAULT_COMMAND=‌​'find . \( -path '*/\.*' -type d -o -name .DS_Store \) -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//'
现在返回一个空结果集。