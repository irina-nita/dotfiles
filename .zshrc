# The following lines were added by compinstall
zstyle :compinstall filename '/home/irina/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

source "$HOME/.zsh/spaceship/spaceship.zsh"
export PATH="$PATH:/opt/nvim-linux64/bin:/home/irina/.local/share/nvim/mason/packages/clangd/clangd_17.0.3/bin:/home/irina/rv32imfc/bin"

alias btw='neofetch --ascii /home/irina/.config/neofetch/logo --ascii_colors 7'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source "$HOME/.cargo/env"

