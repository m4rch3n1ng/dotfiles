## cmd prompt
# color
reset=$'\e[0;00m'
red=$'\e[0;31m'
green=$'\e[0;32m'
yellow=$'\e[0;33m'
magenta=$'\e[0;35m'
cyan=$'\e[0;36m'
# const
MAYZSH_GIT_HASH_PREFIX=":"
MAYZSH_GIT_MODE_BISECT="bsc"
MAYZSH_GIT_MODE_REBASE="rbs"
MAYZSH_GIT_MODE_MERGE="mrg"

mayzsh_git_mode () {
	local git_path=".git"

	if [[ -e "${git_path}/BISECT_LOG" ]]; then
		echo ${MAYZSH_GIT_MODE_BISECT}
	elif [[ -e "${git_path}/MERGE_HEAD" ]]; then
		echo ${MAYZSH_GIT_MODE_MERGE}
	elif [[ -e "${git_path}/rebase" || -e "${git_path}/rebase-apply" || -e "${git_path}/rebase-merge" || -e "${git_path}/../.dotest" ]]; then
		local branch proc

		if [[ -f "${git_path}/rebase-merge/msgnum" ]] then
			local step="$(< ${git_path}/rebase-merge/msgnum)"
			local total="$(< ${git_path}/rebase-merge/end)"
			proc=" ${step}/${total}"
		fi

		if [[ -f "${git_path}/rebase-merge/head-name" ]] then
			local branch_str="$(< ${git_path}/rebase-merge/head-name)"
			[[ ${branch_str} ]] && branch=" ${green}${branch_str#refs/heads/}"
		fi

		echo "${MAYZSH_GIT_MODE_REBASE}${proc}${branch}"
	fi
}

mayzsh_git_branch () {
	local ref
	ref=$(git symbolic-ref --quiet HEAD 2> /dev/null)
	local ret=$?
	if [[ ${ret} == 0 ]]; then
		echo ${ref#refs/heads/} # remove "refs/heads/" to get branch
	else # not on a branch
		[[ ${ret} == 128 ]] && return  # not a git repo
		ref=$(git rev-parse --short HEAD 2> /dev/null) || return
		echo "${MAYZSH_GIT_HASH_PREFIX}${ref}" # hash prefixed to distingush from branch
	fi
}

mayzsh_git () {
	local git_branch=$(mayzsh_git_branch)
	local git_mode=$(mayzsh_git_mode)

	local gitm
	[[ ${git_mode} ]] && gitm="${red}${git_mode} ${green}"
	local git
	[[ ${git_branch} ]] && git="${green}(${gitm}${git_branch}) " || git=""
	echo "${git}"
}

mk_mayzsh () {
	local usr=$(whoami)
	local dir=$(echo ${PWD##*/})
	local git=$(mayzsh_git)

	echo "$ ${yellow}${usr} ${magenta}${dir} ${git}${reset}>> "
}

export PS1='$(mk_mayzsh)'

## alias
alias ls="ls --group-directories-first --color=auto --file-type --time-style=\"+%Y-%m-%d %H:%M:%S\""
alias ll="ls -l"
alias cls="clear"
alias lt="ls -hs1SF"
alias y="yarn run"
alias dokcer="docker"

## ssh agent via https://gist.github.com/justinribeiro/b4fd5039e3b8eb6463f9157a0fa066dd
env=~/.ssh/agent.env

agent_load_env () {
	test -f "${env}" && . "${env}" >| /dev/null ;
}

agent_start () {
	(umask 077; ssh-agent >| "${env}")
	. "${env}" >| /dev/null ;
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "${SSH_AUTH_SOCK}" ] || [ ${agent_run_state} = 2 ]; then
	agent_start
	ssh-add
elif [ "${SSH_AUTH_SOCK}" ] && [ ${agent_run_state} = 1 ]; then
	ssh-add
fi

unset env
