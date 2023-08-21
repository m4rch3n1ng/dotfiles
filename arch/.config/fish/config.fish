# <main />
# disable history
set -g fish_history ""
# use cli tty for gpg (in theory)
set -gx GPG_TTY (tty)
# journalctl
set -gx SYSTEMD_LESS FRMK

# <alias />
alias cls="printf '\033[2J\033[3J\033[1;1H'"
alias ls="ls --group-directories-first --color=auto --classify --time-style=\"+%Y-%m-%d %H:%M:%S\""
alias ll="ls -l"
alias lt="ls -hs1S"
alias la="ls -A"
alias lla="ll -A"
alias lta="lt -A"
alias y="yarn run"
alias hypr="Hyprland"
alias blu="bluetoothctl"

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

# <abbr />
# https://fishshell.com/docs/current/interactive.html#abbreviations
function multicd
	echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# <bindings />
bind \cw backward-kill-bigword
bind \cl "printf '\033[2J\033[3J\033[1;1H'; commandline -f repaint"

# <ssh />
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# <path />
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
