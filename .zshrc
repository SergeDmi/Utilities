# .zshrc
# https://github.com/NicolasCARPi/.dotfiles
source $HOME/.zsh_alias


# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

# autocompletion
autoload -Uz compinit && compinit
# load colors
[[ -r ${HOME}/.zsh/colors.zsh ]] && source ${HOME}/.zsh/colors.zsh
# For autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select
# import new commands from the history file also in other zsh-session
setopt SHARE_HISTORY
# save each command's beginning timestamp and the duration to the history file
setopt EXTENDED_HISTORY
# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list
setopt HIST_IGNORE_ALL_DUPS
# remove command lines from the history list when the first character on the
# line is a space
setopt HIST_IGNORE_SPACE
# remove blanks
setopt HIST_REDUCE_BLANKS
# suggest correction
setopt CORRECT
# * shouldn't match dotfiles. ever.
setopt noglobdots

# edit command line in $EDITOR with ^f
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^f' edit-command-line

# vim <3... but later
export EDITOR="nano"

## PROMPT appearance
#┌─[user@machine:~]-[16:26:07]
#└─>
if [ $UID -eq 0 ];then
    export PROMPT="%{$fg[red]%}┌─[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[red]%}:%{$fg[yellow]%}%~%{$fg[red]%}]%{$fg[yellow]%}-%{$fg[red]%}[%{$fg[cyan]%}%*%{$fg[red]%}]%{$reset_color%}%{$reset_color%}"$'\n'"%{$fg[red]%}└─>%{$reset_color%} "
else
    export PROMPT="%{$fg[white]%}┌─[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[white]%}:%{$fg[cyan]%}%~%{$fg[white]%}]%{$fg[yellow]%}-%{$fg[white]%}[%{$fg[cyan]%}%*%{$fg[white]%}]%{$reset_color%}%{$reset_color%}"$'\n'"%{$fg[white]%}└─>%{$reset_color%} "
fi

PATH=~/.bin:/srv/http/go/bin:~/.gem/ruby/2.4.0/bin:~/.gem/ruby/2.3.0/bin:$PATH
export PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH=/usr/local/share/python:$PATH

if [ -d "$HOME/bin" ] ; then
  PATH="$PATH:$HOME/bin"
fi


# to have nice colors in ls
export LS_OPTIONS='-G'
LS_COLORS='rs=00:fi=00;32:di=02;36:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;35:*.tar=00;31:*.tgz=01;33:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=00;32:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
export LS_COLORS


# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# pretty man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# autocomplete
# https://github.com/tarruda/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions.zsh
# change color of autocomplete
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=7'

## ls after cd
function chpwd() {
    emulate -LR zsh
    ls -G
}

# extract command
function e () {
    if [ -f $1 ] ; then
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *.tar.xz) tar xvJf $1 ;;
        *.xz) unlzma $1 ;;
        *) echo "wtf is that shit ?? '$1'...";;

        esac
    else
        echo "'$1' is not a fucking file !"
    fi
}

# local configuration
# if file is here and is readable, load it
[[ -r ${HOME}/.zshrc.local ]] && source ${HOME}/.zshrc.local
[[ -r ${HOME}/.zsh/aliases.zsh ]] && source ${HOME}/.zsh/aliases.zsh
[[ -r ${HOME}/.zsh/tmuxinator.zsh ]] && source ${HOME}/.zsh/tmuxinator.zsh

if [ "$TERM" != "linux" ] ; then
    if ! tmux list-sessions > /dev/null 2>&1; then
        tmuxinator ktr
    fi
fi
# /K\