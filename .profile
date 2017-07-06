#!/bin/bash

### Add Scripts
test -f ~/.profile_utils && . ~/.profile_utils
test -f ~/.profile_aem && . ~/.profile_aem
test -f ~/.profile_projects && . ~/.profile_projects
test -f ~/.profile_keys && . ~/.profile_keys

### Enviroment
#   Change Prompt
#   ------------------------------------------------------------
#    export PS1="________________________________________________________________________________\n| \w @ \h (\u) \n| => "
#    export PS2="| => "

# Colors
Red="\e[0;31m" # Define color red
Colour_Off="\e[0;0m" # Define default color
CLICOLOR=1 # Enable colored CLI output
LSCOLORS=GxFxCxDxBxegedabagaced # Colors for ls command

function info() {
    printf $Red"JAVA VERSION"$Colour_Off"\n"
    printf "$($JAVA_HOME/bin/java -version)"
    printf $Red"MAVEN VERSION"$Colour_Off"\n"
    printf "$(mvn -version)\n"
}

### Alias
# Some shortcuts for different directory listings
alias ls='ls -hFG'                 # classify files in colour
alias ll='ls -l'                   # long list
alias la='ls -la'                  # all but . and ..

alias ~="cd ~"                     # Go Home
alias c='clear'                    # Clear terminal display

alias df='df -H'                   # Discspace                
alias fs='du -hs'                  # Folder size
alias du='du -hd 1'                # Sub folder list size
alias dusort='du -ach | sort -h'   # File size sorted

alias pstree='ps auxf'             # display process tree
alias mkdir="mkdir -pv"            # make any necessary parent and tell every new folder

alias profile="tm ~/.profile" # Open this file

alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .3='cd ../../..'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

## Date
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'

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
## alias
alias gs='git status'
alias gpl='git pull'
alias gph='git push'
alias gc='git checkout'
alias garc='git archive HEAD --format=zip >'


# git fetch prune
alias gfp='git fetch -p'

# reset local git folder
alias grhh='git reset --hard HEAD'

## GIT Function
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

# remove all local branches which are not on remote anymore
function gcb {
     git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv) | awk '{print $1}' | xargs git branch -D
}

# update all local branches
function gub {
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

# Find all branches which are merged into develop
function gm {
     for branch in `git branch -r --merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r
}

# Find all branches which are not merged into develop
function gnm {
     for branch in `git branch -r --no-merged | grep -v HEAD`; do echo -e `git show --format="%ci %cr %an" $branch | head -n 1` \\t$branch; done | sort -r  
}


### FUNCTIONS
## Search
alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

