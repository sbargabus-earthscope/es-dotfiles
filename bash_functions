listpath() {
	echo "${PATH//:/$'\n'}"
}

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

parse_git_host() {
    git config --get remote.origin.url | awk -F'[/:]' '{print $1}' | awk -F'[/@]' '{print $2}'
}

parse_git_remote() {
    url=`git config --get remote.origin.url`
    if [[ ${#url} -eq 0 ]]; then
        return
    fi

    re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$"

    if [[ $url =~ $re ]]; then
        user=${BASH_REMATCH[4]}
    fi

    echo $user
}

parse_git_fields() {
    remte=`parse_git_remote`
    hst=`parse_git_host`
    brnch=`parse_git_branch 2> /dev/null | tr -d "()"`
    if [[ ${#remte} -gt 0 ]] && [[ ${#brnch} -gt 0 ]]; then
        printf "($hst:$remte:$brnch:"
        STATUS="$(git status 2> /dev/null)"
        if [[ $? -ne 0 ]]; then printf "-"; return; else printf "["; fi
        if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf ">"; else printf ""; fi
        if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf "!"; else printf ""; fi
        if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf "+"; else printf ""; fi
        if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf "?"; else printf ""; fi
        if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf "*"; else printf ""; fi
        if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf "-"; else printf ""; fi
        printf "])"
    fi
}

prompt_help() {
    echo "";
    echo "prompt: (GITHUBUSER:BRANCH:[status])";
    echo "";
    echo "status characters are as follows:";
    echo "";
    echo "renamed:         >";
    echo "branch is ahead: !";
    echo "new file::       +";
    echo "untracked files: ?";
    echo "modified:        *";
    echo "deleted:         -";
}
