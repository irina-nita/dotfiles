starship init fish | source

export RUSTUP_HOME="$HOME/.rustup"

source "$HOME/.cargo/env.fish"

function fish_greeting
	echo "(づ￣ ³￣)づ 💞 $hostname" "|" (set_color yellow; date +%T; set_color normal)
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

