# color
reset=$'\e[0m'
red=$'\e[31m'
green=$'\e[32m'
yellow=$'\e[33m'
magenta=$'\e[35m'
cyan=$'\e[36m'

## customize
# default
MAYZSH_START='%(#.#.%(!.!.$)) '
MAYZSH_PROMPT='>>'
MAYZSH_RPROMPT=""
MAYZSH_NEWLINE=false
# git
MAYZSH_GIT_HASH_PREFIX=":"
MAYZSH_GIT_MODES=true
MAYZSH_GIT_MODE_BISECT="bsc"
MAYZSH_GIT_MODE_REBASE="rbs"
MAYZSH_GIT_MODE_MERGE="mrg"

# eval info
MAYZSH_USER='echo $USER'
MAYZSH_DIR='echo ${PWD##*/}'

mayzsh_git_path () {
	command git rev-parse --git-dir 2> /dev/null
}

mayzsh_git_wrap () {
	GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# thx https://github.com/Moarram/headline
mayzsh_git_branch () {
	local ref
	ref=$(mayzsh_git_wrap symbolic-ref --quiet HEAD 2> /dev/null)
	local ret=$?
	if [[ ${ret} == 0 ]]; then
		echo ${ref#refs/heads/} # remove "refs/heads/" to get branch
	else # not on a branch
		[[ ${ret} == 128 ]] && return  # not a git repo
		ref=$(mayzsh_git_wrap rev-parse --short HEAD 2> /dev/null) || return
		local hash=$(mayzsh_git_hash $ref)
		echo "${MAYZSH_GIT_HASH_PREFIX}${hash}" # hash prefixed to distingush from branch
	fi
}

mayzsh_git_hash () {
	local hash_long=$1
	local hash_short=$(git rev-parse --short $hash_long)
	local hash_rel=$(git name-rev --no-undefined --always --exclude="tags/*" --exclude="remotes/*" "$hash_short" 2> /dev/null)

	local spl1=$(echo $hash_rel | cut -d " " -f1)
	local spl2=$(echo $hash_rel | cut -d " " -f2)

	if [ "$spl1" = "$spl2" ]; then
		hash_rel=$(git name-rev --no-undefined --always --exclude="tags/*" "$hash_short" 2> /dev/null)
		spl1=$(echo $hash_rel | cut -d " " -f1)
		spl2=$(echo $hash_rel | cut -d " " -f2)

		if [ "$spl1" = "$spl2" ]; then
			unset hash_rel
		fi
	fi

	if [ ${hash_rel} ]; then
		echo ${hash_rel}
	else
		echo ${hash_short}
	fi
}

# thx https://github.com/ohmyzsh/ohmyzsh/blob/d47e1d65f66f9bb2e7a96ba58797b33f0e91a623/themes/peepcode.zsh-theme#L14
# thx https://github.com/zthxxx/jovial/blob/bd705f1b74ecb1dfc5a3637193498191a016bb09/jovial.zsh-theme#L749
mayzsh_git_mode () {
	if [[ -e "${git_path}/rebase" || -e "${git_path}/rebase-apply" || -e "${git_path}/rebase-merge" ]]; then
		local branch proc

		if [[ -f "${git_path}/rebase-merge/msgnum" ]]; then
			local step="$(< ${git_path}/rebase-merge/msgnum)"
			local total="$(< ${git_path}/rebase-merge/end)"
			proc=" ${step}/${total}"
		fi

		if [[ -f "${git_path}/rebase-merge/head-name" ]]; then
			local branch_str="$(< ${git_path}/rebase-merge/head-name)"
			[[ ${branch_str} ]] && branch=" ${green}${branch_str#refs/heads/}"
		fi

		echo "${MAYZSH_GIT_MODE_REBASE}${proc}${branch}"
	elif [[ -e "${git_path}/BISECT_LOG" ]]; then
		local branch
		if [[ -f "$git_path/BISECT_START" ]]; then
			local branch_str="$(< ${git_path}/BISECT_START)"
			branch=" ${branch_str}"
		fi

		echo "${MAYZSH_GIT_MODE_BISECT}${branch}"
	elif [[ -e "${git_path}/MERGE_HEAD" ]]; then
		local hash_long=$(< "${git_path}/MERGE_HEAD")
		local hash=$(mayzsh_git_hash ${hash_long})

		echo "${MAYZSH_GIT_MODE_MERGE} :${hash}"
	elif [[ -f "$git_path/CHERRY_PICK_HEAD" ]]; then
		local hash_long="$(< ${git_path}/CHERRY_PICK_HEAD)"
		local hash=$(mayzsh_git_hash ${hash_long})

		echo "chp :${hash}"
	elif [[ -f "$git_path/REVERT_HEAD" ]]; then
		local hash_long=$(< "${git_path}/REVERT_HEAD")
		local hash=$(mayzsh_git_hash ${hash_long})

		echo "rvt :${hash}"
	fi
}

mayzsh_git () {
	local git_branch=$(mayzsh_git_branch)
	local git_mode
	[[ ${MAYZSH_GIT_MODES} = "true" ]] && git_mode=$(mayzsh_git_mode)

	local gitm
	[[ ${git_mode} ]] && gitm="${red}${git_mode} ${green}"
	local git
	[[ ${git_branch} ]] && git="${green}(${gitm}${git_branch})${reset} " || git=""

	echo ${git}
}

mk_mayzsh () {
	git_path=$(mayzsh_git_path)

	local user="${yellow}$(eval ${MAYZSH_USER})${reset}"
	local dir="${magenta}%c${reset}"
	local git=$(mayzsh_git)

	[[ ${MAYZSH_NEWLINE} = "true" ]] && print -rP ""
	print -rP "${MAYZSH_START}${user} ${dir} ${git}${MAYZSH_PROMPT} "
}

PROMPT='$(mk_mayzsh)'
RPROMPT="${MAYZSH_RPROMPT}"
