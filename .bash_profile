# Some shortcuts for different directory listings
alias ls='ls -hFG'                 # classify files in colour
alias ll='ls -l'                   # long list
alias la='ls -la'                  # all but . and ..

alias df='df -H'
alias du='du -ch'

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

### MAVEN
alias mup='mvn compile -U'
alias mci='mvn clean install'
alias mcis='mvn clean javadoc:jar source:jar install'
alias mcid='mci dependency:sources dependency:resolve -Dclassifier=javadoc'
alias mep='mvn help:effective-pom > effective-pom.xml'
alias mdt='mvn dependency:tree > dependency-tree.txt'
alias mda='mvn dependency:analyze > dependency-analyze.txt'
alias mrelease='mvn clean release:prepare release:perform release:clean clean'
alias mreleaserollback='mvn release:rollback release:clean clean'

### GIT
alias gs='git status'
alias gpl='git pull'
alias gph='git push'
alias gc='git checkout'
alias garc='git archive HEAD --format=zip >'

# aktualisiert alle lokalen branches der Reihe nach.
alias gup='git_update_all'

# löscht alle lokalen branches, die remote nicht mehr existieren
alias gfp='git fetch -p'
alias gc='git_clean'

alias grhh='git reset --hard HEAD'

# FUNCTIONS

# delete tag function (based on http://nathanhoad.net/how-to-delete-a-remote-git-tag)
function gdt {
	if [ $1 ]; then
		echo "Deleting tag: \"$1\""
		git tag -d $1
		git push origin :refs/tags/$1
	else
		echo "Please specify a valid tag (as first parameter)"
	fi
}

function p {
	if [ $1 ]; then
		__HOST=$1
	else
		__HOST=google.ch
	fi
	ping -t 3 $__HOST
}

function git_update_all {
	local run br
	br=$(git name-rev --name-only HEAD 2>/dev/null)
	[ "$1" = "-n" ] && shift && run=echo

	for x in $( git branch | cut -c3- ) ; do
		$run git checkout $x && $run git pull --ff-only || return 2
		echo "-------------------------------------------------";
		echo "";
	done
	[ ${#br} -gt 0 ] && $run git checkout "$br"
}

## git remove all local branches not on remote anymore
function git_clean {
	git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv) | awk '{print $1}' | xargs git branch -D
}

### merged branch list
function gm {
	for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r
}

### no merged branch list
function gnm {
	for branch in `git branch -r --no-merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r  
}
