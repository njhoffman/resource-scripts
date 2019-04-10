#!/bin/bash

# replace all occurences of "foo" with "bar"
cd /path/to/folder
sed -i 's/foo/bar/g'
find ./ -type f -exec \
	sed -i 's/foo/bar/g' {} +
ag SearchString -l0 | xargs -0 sed -i 's/SearchString/Replacement/g'
# dry run
find ./ -type f | xargs sed 's/foo/bar/g'
find ./ -type f | xargs sed --quiet 's/foo/bar/gp'
find ./ -type f | xargs -I FILE sed 's|^|FILE: |g' FILE | sed 's/foo/bar/g' #| grep -n 'bar'
# todo: use 'nl -n ln' to add line numbers (with tee probably)


# searching files
grep -v pattern file.txt # only match lines not containing expression
grep -P "(?<=\[')[^,]*" file.txt # grep with perl regex pattern
grep -Po "(?<=\[')[^,]*" file.txt # only output matching pattern
grep -l <patten> # only output file names
grep -Ri --color "the_content" . | cut -c1-"$COLUMNS"
grep --exclude='*.min.*'
grep --exclude-dir="node_modules"

# finding files
find . -type f -exec chmod 774 {} + // change all files to 774
find . -type d -exec chmod 775 {} + // change  all directories
find . -maxdepth 2 -name package.json
find / -mindepth 0 -maxdepth 0 -type d | egrep -v '^media$|^c$|^proc$' | xargs sudo du -shc
find / -type f -size +1024k
find / -size +50000 -exec ls -lahg {} \;
#find . \( -name node_modules -prune \) -o -exec grep "search text"
find . -name "*.js" -o -name "*.vue" -o path "./node_modules" -prune
find . -name "*.txt" -exec echo {} \; -exec grep banana {} \;
find . -type f -iregex ".*\.js$" - not -path "./node_modules/*" -not -path "./report/*"

# other sed commands
sed '/pattern/d' file.txt           # delete lines matching pattern
sed '/regexp/!d' file.txt           # grep equivalent
sed 's/^/ /' file.txt >file_new.txt # add 8 spaces to left
sed -n 12,18p file.txt              # show only lines 12-18
sed '/baz/s/foo/bar/g' file.txt     # only if line contains baz, substitue foo with bar
sed '/boom/!s/aaa/bb/' file.txt     # unless boom is found replace aaa with bb
sed '17,/disk/d' file.txt           # delete all lines from 17 to 'disk'
sed 's/.$//' file.txt               # dos2unix
sed '/regex/,+5/expr/'              # match regex plus the next 5 lines
