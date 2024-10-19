starship init fish | source

export RUSTUP_HOME=/Users/irinanita/.rustup

source "$HOME/.cargo/env.fish"

function fish_greeting
	echo "(づ￣ ³￣)づ 💞 $hostname" "|" (set_color yellow; date +%T; set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# source /opt/homebrew/opt/chruby-fish/share/fish/vendor_functions.d/chruby_use.fish
# source /opt/homebrew/opt/chruby-fish/share/fish/vendor_functions.d/chruby_reset.fish
# source /opt/homebrew/opt/chruby-fish/share/fish/vendor_functions.d/chruby.fish
# source /opt/homebrew/opt/chruby-fish/share/fish/vendor_conf.d/chruby_auto.fish
#
# chruby ruby-3.1.3

