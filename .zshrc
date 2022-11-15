# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme
ZSH_THEME="powerlevel10k/powerlevel10k"

######启动Z################3
eval "$(lua /home/baojt/z.lua/z.lua --init zsh)"    # ZSH 初始化
#
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

plugins=(zsh-autosuggestions zsh-syntax-highlighting copydir sudo autojump-zsh z extract)


##################zplug plugins#####################
source /usr/share/zsh/scripts/zplug/init.zsh
 
# 通过zplug管理插件
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
 
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
 
#加载插件，没有这句没效果，后面的--verbose记得去掉，不然每次启动都会提示一大段信息
zplug load #--verbose

export EDITOR=/usr/bin/nvim 
export VISUAL=/usr/bin/nvim
##################zplug plugins#####################

#################
source  /home/baojt/Downloads/fzf-tab-completion/zsh/fzf-zsh-completion.sh
bindkey '^I' fzf_completion

alias vi='nvim'
alias vim='nvim'
alias ll='ls -lh'

cdls() {
    cd "${1}";
    ll;
}
alias cd='cdls'



eval "$(ssh-agent)" &
ssh-add ~/.ssh/github &
ssh-add ~/.ssh/baojt.pem &


