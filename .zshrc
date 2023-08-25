# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

source $HOME/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle Aloxaf/fzf-tab

# Load the theme.
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

# fnm
export PATH="$HOME/.fnm:$PATH"
eval "$(fnm env --use-on-cd)" > /dev/null 2>&1


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pdm
export PATH="$HOME/.local/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


function ln-image-tags {
    if [ -z "$1" ]; then
        echo "usage: ln-image-tags <image-name>"
        exit 1
    fi
    
    curlie -L https://registry.lawsnote.com/v2/$1/tags/list
}

function ln-save-image {
    if [ -z "$1" ]; then
        echo "usage: ln-save-image <image-name:tag>"
        exit 1
    fi
    
    docker-save --rm -p -o . -i registry.lawsnote.com/$1
}

function vpnup {
    sudo wg-quick up Lawsnote
}

function vpndown {
    sudo wg-quick down Lawsnote
}

function updatesoftware {
    if [ -f "/etc/arch-release" ]; then
        sudo pacman -Syu
        yay -Syu
    fi
    
    flatpak update -y
}

function updatefirmware {
    fwupdmgr refresh --force
    fwupdmgr update
}

function updateall {
    updatesoftware
    updatefirmware
}
