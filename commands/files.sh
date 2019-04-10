#!/bin/bash

# free up disk space
sudo apt-get autoremove
sudo du -sh /var/cache/apt
sudo apt-get clean / autoclean

# find large files
find / -size +50000 -exec ls -lahg {} \;
find / -printf '%s %p\n'| sort -nr | head -10 # finds 10 largest files
find / -mindepth 0 -maxdepth 0 -type d | egrep -v '^media$|^c$|^proc$' | xargs sudo du -shc

# list directories by size
du -shc *
du -sk * | sort -nr
du -xh / | grep '^\S*[0-9\.]\+G' | sort -rn # -x only check this fs, list dirs starting with non-whitespace (+G filters > 1GB)
find . -maxdepth 3 -type d | egrep 'node_modules$' | xargs sudo du -shc

for file in /dir/*; do cat $file | prettyjson; done
lsof -i

# cp to multiple files
for i in file1 file2 ; do cp srcFile $i ; done
for file in *; do mv $file "${file/ToReplace/ReplaceWith}"; done;

# do something for each line in a file
while read p; do echo $p; done <file.txt

# file information
file hello.c
readelf -l file

# list open files
lsof +D /var/log # list open files in /var/log
lsof /var/log/syslog # list processes for specific file
lsof -u <username> # list all files belonging to user
lsof -c ssh -c init # list files opened by ssh and init processes
lsof -u <username> -c init -a -r5 # list only files opened by init process by username, refresh every 5 seconds
lsof -i :25 # list processes listening on port 25

# permissions
chmod g+s . # set gid
setfacl -d -m g::rwx . # set group to rwx default
setfacl -d -m o::rx . # set other
setfacl -R -d -m g::rwx . # set group and all sub-directory groups to rwx default
getfacl .

# list underscores first with shell expansion
#   _* shell pattern matching any file name beginning with an _, expanded in alphabetic order
#   [!_]* matches any file name not beginning with an underscore, expanded in alphabetic order
#   -f tells ls to not sort, because the shell already did.
ls -lf _* [!_]*
ls -lfd _* [!_]*
# (LC_COLLATE=C ls / LC_ALL=C ls) - _ before UC needs a custom locale definition /usr/share/i18n/locales

# run command on file change
while inotifywait -e close_write myfile.js; do ./myfile.js; done
nodemon -x "./myfile.js" ./myfile.js -w ./lib ./src

inotifywait -q -m -e close_write myfile.js |
while read -r filename event; do "./$filename" done

ag  -l | entr make
ls *.css *.html | entr reload-browser Chrome
find . -name '*.py' | entr ./myfile.py # -c clear screen between runs
ls *.rb | entr -r ruby main.rb # start script, block until files change, terminate and wait, restart
# when new file appears, execute command and rescan the file system
while true; do
  ls -d src/*.py | entr -d ./setup.py
done

# compare two files in vimdiff pane, autorefresh on change
vimdiff -R ./file1.txt ./file2.txt
ls file*.txt | entr tmux send-keys -t .0 ":windo e" C-m
