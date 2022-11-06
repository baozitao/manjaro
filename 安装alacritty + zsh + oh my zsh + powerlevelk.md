## 安装zsh```

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

## 查看值得shells有哪些

```
cat /etc/shells
```


## 切换到zsh

```
chsh -s /bin/zsh
```


## 查看当前的shell

```
echo $SHELL
```

# 使用 powerlevel10k主题
1.  [Install the recommended font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k). _Optional but highly recommended.
3.  [Install Powerlevel10k](https://github.com/romkatv/powerlevel10k#installation) itself.
4.  Restart Zsh with `exec zsh`.
5.  Type `p10k configure` if the configuration wizard doesn't start automatically.

