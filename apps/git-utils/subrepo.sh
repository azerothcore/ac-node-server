
#!/usr/bin/env bash



CUR_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"

source "$CUR_PATH/../git-subrepo/.rc"

echo "> Init and updating submodules..."
[ ! -d "$CUR_PATH/../git-subrepo" ] && git submodule add https://github.com/ingydotnet/git-subrepo apps/git-subrepo
git submodule update --init apps/git-subrepo

function subrepoUpdate() {
    repo=$1
    branch=$2
    folder=$3

    # try-catch
    set +e
    git subrepo clone "$repo" "$folder" -b "$branch"
    set -e

    git subrepo clean "$folder"
    git subrepo pull "$folder"
    git subrepo push "$folder" -s
    git subrepo clean "$folder"
}