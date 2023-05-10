# disable history
set -g fish_history ""
# use cli tty for gpg (in theory)
set -gx GPG_TTY (tty)

# alias
alias cls="printf '\033[2J\033[3J\033[1;1H'"
alias ls="ls --group-directories-first --color=auto --file-type --time-style=\"+%Y-%m-%d %H:%M:%S\""
alias ll="ls --file-type -l"
alias lt="ls -hs1SF"
alias y="yarn run"
alias hypr="Hyprland"

function rm; echo "use trash instead"; end

function tmp
	set -l _tmp (mktemp -d)
	echo "tmp $_tmp"
	cd $_tmp
end

function take
	mkdir -p $argv[1]
	cd $argv[1]
end

# bindings
bind \cw backward-kill-bigword

# launch fish_ssh_agent
fish_ssh_agent

# add to path
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
