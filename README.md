# bash scripts

I use this github project to store an version my bash scripts

## add scripts to your bash
add the following line into your .bash_profile or .bashrc

```
test -f ~/.profile && . ~/.profile
```

## .profile
This is the main file
It includes 4 files if they exists

- .profile_utils
- .profile_aem
- .profile_projects
- .profile_keys 

It also defines a lot of alias for better navigation, for maven and git 
commands

## .profile_utils
This file includes color definition and some function like extract tgz files, 
make a backup from a file and so on.


## .profile_aem
This file includes aem specific funtions like 
- aemi - infomration which aem instances are running
- cqlog - colorize aem log bash output
- (a|p)log - tail author|publish log
- (a|p)start - start aem author|publish
- mountLog - mount a virtual box shared folder into virtualbox and output defined logs into this shared folder
- killcq - kill all aem instances

## .profile_projects
This file includes project specific functions, alias, ...

## .profile_keys
This files includes keys for some api functions like https://pushover.net/
