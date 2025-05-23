# <main />
# disable history
set -g fish_history ""
# use cli tty for gpg (in theory)
set -gx GPG_TTY (tty)
# journalctl
set -gx SYSTEMD_LESS FRMK
set -gx GOPATH ~/.go

# <alias />
alias ls "ls --group-directories-first --color=auto --classify=auto --time-style=\"+%Y-%m-%d %H:%M:%S\" -h"
alias ll "ls -l"
alias lt "ls -hs1S"
alias la "ls -A"
alias lla "ll -A"
alias lta "lt -A"
alias y "yarn run"
alias hypr Hyprland
alias vi nvim
alias hx helix

alias ffmpeg "ffmpeg -hide_banner"
alias ffprobe "ffprobe -hide_banner"

alias clear "printf '\033[2J\033[3J\033[1;1H'"

eval (dircolors -c)

function rm
    echo "use trash instead"
end

function tmp
    set -l _tmp (mktemp -d)
    echo "tmp $_tmp"
    cd $_tmp
end

function take
    mkdir -p $argv[1]
    cd $argv[1]
end

function cal
    if test -d $argv[1]
        ls --group-directories-first --color=auto --classify --time-style="+%Y-%m-%d %H:%M:%S" -l $argv[1] $argv[2..-1]
    else
        cat $argv[1] $argv[2..-1]
    end
end

function wl-cf
    echo file://(realpath $argv[1]) | wl-copy -t text/uri-list
end

# <abbr />
# https://fishshell.com/docs/current/interactive.html#abbreviations
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd
abbr dc cd
abbr --position anywhere dif diff
abbr gut git
abbr got git

function excl
    echo (history | head -1)
end
abbr --add exclexcl --position anywhere --regex "!!" --function excl

# <bindings />
bind \cw backward-kill-bigword
bind \cl "printf '\033[2J\033[3J\033[1;1H'; commandline -f repaint"

# <ssh />
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"

# <path />
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin

# <zoxide />
set -x _ZO_ECHO '1'
zoxide init --cmd cd fish | source
