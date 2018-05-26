GPG_TTY=$(tty)
export GPG_TTY
export SVN_EDITOR=/usr/bin/vim

export CLICOLOR=1
export LSCOLORS=fxgxexbxCxegfdabagacEg
export PROMPT_DIRTRIM=5
export PS1="\[$(tput setaf 2)\]\u\[$(tput bold)\]\[$(tput setaf 1)\]@\[$(tput setaf 6)\]\h\[$(tput sgr0)\]\[$(tput setaf 5)\] \w\[$(tput setaf 6)\] \\$ \[$(tput sgr0)\]"

alias grep="grep --color=auto"
alias proxy=". proxy"
alias ports="lsof -i -P"

alias lolidk="echo '¯\_(ツ)_/¯' | pbcopy"
alias lenny="echo '( ͡° ͜ʖ ͡°)' | pbcopy"
alias srsly="echo 'ಠ_ಠ' | pbcopy"
alias flippintables="echo '(╯°□°）╯︵ ┻━┻' | pbcopy"

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi
export PATH=$PATH:/usr/local/bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
