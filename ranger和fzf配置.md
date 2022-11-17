https://zhuanlan.zhihu.com/p/441083543
地址


ranger介绍
GitHub - ranger/ranger: A VIM-inspired filemanager for the console
​github.com/ranger/ranger

ranger是一个面向终端的文件资源管理器, 使用python语言编写, 支持全平台. 其操作遵循vim用户的键位习惯, 它与传统的图形化文件资源管理器相比的最大优势在于两个字 快捷 . 举几个例子:

我现在身处目录 /A/B/C/ 下, 但是我想去往 /home/ch4ser/Documents 目录下. 在图形化界面中, 你需要看看家目录的按钮, 点一点, 然后在几个相似的图标中寻找Documents字样的文件, 然后再用鼠标点一点, 光是想一想就已经开始累了....但是在ranger下面, 你可以通过按下 "gd" (也就是go document的意思) 键来从任意一个目录跳转到 /home/ch4ser/Documents中, 当然, 具体按哪个键是在 ranger 配置文件中的rc.conf中定义的, 比如下面这几行, 非常好理解
map gh cd /home/ch4ser
map gn cd /home/ch4ser/Downloads
map ge cd /home/ch4ser/Desktop
map gu cd /usr
map gd cd /home/ch4ser/Documents
身处目录X下, 我想看看该目录下的每个目录中的内容或者每个文件中的内容. 在mac中, 你需要按下空格来进行预览, 但是在ranger中, 只要你把定位到该文件或者目录, 右侧就会自动展示预览, 如下图


这里是在kde下使用ranger, wayland中不支持w3m
当然，ranger的目标用户应该是使用终端比较多的用户。

Ranger的基础键位如下

hjkl 负责上下左右移动，左表示进入父目录，右表示进入子目录或者打开文件
空格选中一个文件，对选中的文件再按空格取消选中
v选中全部文件
dd剪切文件到剪切板
dD彻底删除文件
yy复制文件
p张贴文件
基础的ranger使用就到这里，下面介绍一下ranger的简单配置

执行ranger --copy-config=all 生成默认配置文件, 在arch linux 中, 生成的配置文件位于 ~/.config/ranger中, 打开~/.config/ranger/rc.config , 将set preview_images false 修改为set preview_images true , 并确保set use_preview_script true 设置. 到此为止, 文件预览设置成功.

在rc.config 中可以看到很多的键位映射, 可以根据自己的使用习惯进行调整.

接下来, 使用ranger_devicons插件来为ranger添加文件图标.

GitHub - alexanderjeurissen/ranger_devicons: Ranger plugin that adds file glyphs / icon support to Ranger
​github.com/alexanderjeurissen/ranger_devicons

git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
当然, 可以根据自己的喜好定义不同的图标.

fzf 介绍
https://github.com/junegunn/fzf
​github.com/junegunn/fzf
fzf是一个模糊文件查找的命令行工具, 使用golang编写. fzf没有配置文件, 而是通过环境变量配置的, 比如我的:

export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border --preview '~/Tools/Other/fzf-scope.sh {} '"
export FZF_DEFAULT_COMMAND="fd --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla} --type f --hidden --follow"
FZF_DEFAULT_OPTS变量中设置了fzf启动时候的高度, 排列方式, 是否有边框, 预览的方式 , 这里我的预览方式是根据不同的文件类型使用不同的预览工具, 集成在了fzf-scope.sh脚本中. 如下:

#!/bin/bash

case "$1" in
	*.pdf) pdftotext "$1" ;;
	*.md) glow -s dark "$1" ;;
	*.zip) zipinfo "$1" ;;
	*.7z) 7z l "$1" ;;
	*) bat --color=always --italic-text=always --style=numbers,changes,header --line-range :500 "$1" ;;
esac
FZF_DEFAULT_COMMAND 里面设置使用fd 来查找文件, 并排除了一些项目, 让模糊查找的时候不包括这些项目.

以上设置完毕后, 运行fzf 如下所示, 输入关键词就可以进行模糊文件查找了


ranger和fzf联动
在~/.config/ranger/commands.py 加入以下代码

class fzf_select(Command):
   """
   :fzf_select
   Find a file using fzf.
   With a prefix argument to select only directories.

   See: https://github.com/junegunn/fzf
   """

   def execute(self):
       import subprocess
       import os
       from ranger.ext.get_executables import get_executables

       if 'fzf' not in get_executables():
           self.fm.notify('Could not find fzf in the PATH.', bad=True)
           return

       fd = None
       if 'fdfind' in get_executables():
           fd = 'fdfind'
       elif 'fd' in get_executables():
           fd = 'fd'

       if fd is not None:
           hidden = ('--hidden' if self.fm.settings.show_hidden else '')
           exclude = "--no-ignore-vcs --exclude={.wine,.git,.idea,.vscode,.sass-cache,node_modules,build,.local,.steam,.m2,.rangerdir,.ssh,.ghidra,.mozilla} --exclude '*.py[co]' --exclude '__pycache__'"
           only_directories = ('--type directory' if self.quantifier else '')
           fzf_default_command = '{} --follow {} {} {} --color=always'.format(
               fd, hidden, exclude, only_directories
           )
       else:
           hidden = ('-false' if self.fm.settings.show_hidden else r"-path '*/\.*' -prune")
           exclude = r"\( -name '\.git' -o -iname '\.*py[co]' -o -fstype 'dev' -o -fstype 'proc' \) -prune"
           only_directories = ('-type d' if self.quantifier else '')
           fzf_default_command = 'find -L . -mindepth 1 {} -o {} -o {} -print | cut -b3-'.format(
               hidden, exclude, only_directories
           )

       env = os.environ.copy()
       env['FZF_DEFAULT_COMMAND'] = fzf_default_command
       env['FZF_DEFAULT_OPTS'] = '--height=100% --layout=reverse --ansi --preview="{}"'.format('''
           (
               ~/Tools/Other/fzf-scope.sh {} ||
               #batcat --color=always {} ||
               #bat --color=always {} ||
               #cat {} ||
               tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' {}
           ) 2>/dev/null | head -n 100
       ''')

       fzf = self.fm.execute_command('fzf --no-multi', env=env,
                                     universal_newlines=True, stdout=subprocess.PIPE)
       stdout, _ = fzf.communicate()
       if fzf.returncode == 0:
           selected = os.path.abspath(stdout.strip())
           if os.path.isdir(selected):
               self.fm.cd(selected)
           else:
               self.fm.select_file(selected)       


在.config/ranger/rc.conf 添加快捷键

map f fzf_select
启动ranger, 按下f从当前目录开始进行模糊文件查找, 在ranger中按下Ctrl-h现实隐藏文件后再按f将会连同隐藏文件一并进行模糊文件查找.

另外，让两个ranger实例可以相互复制粘贴文件，建议对rc.conf进行修改，通过save_copy_buffer来将操作的文件名存储到文件中以供其他ranger实例通过load_copy_buffer进行读取：

将

map yy copy
map pp paste
修改为

map yy chain copy; save_copy_buffer
map pp chain load_copy_buffer;paste