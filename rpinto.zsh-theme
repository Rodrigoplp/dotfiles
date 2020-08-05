local ret_status="%(?:%{$fg_bold[blue]%}➜ :%{$fg_bold[red]%}➜ )"

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[cyan]%}\uE0A0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

PROMPT=' %{$fg[blue]%}%1~$(git_prompt_info) ${ret_status}%{$reset_color%}'

RPROMPT='%{$fg[cyan]%}%~%{$reset_color%}'

export LSCOLORS=exfxcxcxxxegedabagacex
