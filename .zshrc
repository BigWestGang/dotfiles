export LANG='ja_JP.UTF-8'
export LC_CTYPE=$LANG
export PATH=$PATH

autoload -Uz add-zsh-hook

# Created by newuser for 5.3.1
source ~/.zplug/init.zsh

if ! zplug check; then
    zplug install
fi

zplug "b4b4r07/enhancd", use:init.sh
zplug "olivierverdier/zsh-git-prompt", use:zshrc.sh

if zplug check olivierverdier/zsh-git-prompt; then
  source ~/.zplug/repos/olivierverdier/zsh-git-prompt/zshrc.sh
  ZSH_THEME_GIT_PROMPT_PREFIX="["
  ZSH_THEME_GIT_PROMPT_SUFFIX=$'%{\e[36;40;1m%}]'
  ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[white]%}"
  ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}%{ %G%}"
  ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[magenta]%}%{x%G%}"
  ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}%{+%G%}"
  ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[red]%}%{-%G%}"
  ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}%{+%G%}"
  ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{✔%G%}"
fi

if zplug check b4b4r07/enhancd; then
    # setting if enhancd is available
    export ENHANCD_FILTER=fzy:peco
    source ~/.zplug/repos/b4b4r07/enhancd/init.sh
fi

local time=("${(f)$(date +"%l")}")
case $time in
  " 1" ) mark="🕐";;
  " 2" ) mark="🕑";;
  " 3" ) mark="🕒";;
  " 4" ) mark="🕓";;
  " 5" ) mark="🕔";;
  " 6" ) mark="🕕";;
  " 7" ) mark="🕖";;
  " 8" ) mark="🕗";;
  " 9" ) mark="🕘";;
  "10" ) mark="🕙";;
  "11" ) mark="🕚";;
  "12" ) mark="🕛";;
esac

# prompt setting
function() {
  current=$'%{\e[36;40;1m%}[%{\e[32;1m%}%~%{\e[36;40;1m%}]'
  clock=$'[%D{%Y/%m/%d(%a)} '
  clock2=$mark
  clock3=$'%D{%T}]'
  line=$'%{\e[31;1m%}$ %{\e[0m%}'
  PROMPT=${current}${clock}${clock2}${clock3}'$(git_super_status)
'${line}
}
