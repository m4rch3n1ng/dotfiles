if status is-interactive
	# Commands to run in interactive sessions can go here
end

# disable history
set -g fish_history ""
set -gx GPG_TTY (tty)

# alias
alias cls="clear"
alias ls="ls --group-directories-first --color=auto --file-type --time-style=\"+%Y-%m-%d %H:%M:%S\""
alias ll="ls --file-type -l"
alias lt="ls -hs1SF"
alias y="yarn run"
alias hypr="Hyprland"

# launch fish_ssh_agent
fish_ssh_agent
