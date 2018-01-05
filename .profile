#!/bin/bash

### Add Scripts
test -f ~/.profile_utils && . ~/.profile_utils
test -f ~/.profile_aem && . ~/.profile_aem
test -f ~/.profile_projects && . ~/.profile_projects
test -f ~/.profile_keys && . ~/.profile_keys

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
