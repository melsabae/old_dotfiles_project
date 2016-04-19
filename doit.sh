#!/bin/bash

if [ -d ~/.BAK ]
then
	echo ".BAK dir exists"
fi

for rcfile in $(ls -a $(pwd))
do
		# skip '.', '..', and the script itself
		if [ $rcfile == "." -o $rcfile == ".." -o $rcfile == $0 ]
		then
			continue
		fi

		# not sure what to do with  these files for now
		if [ $rcfile == "./misc" ]
		then
			continue
		fi

		# check if this thing is a directory
		if [ -d $rcfile ]
		then
			# cp -R current directory into .BAK?
			# cp -R directory most likely
			continue
		fi

		#check to see if the file currently exists in ~
		if [ -e ~/$rcfile ]
		then
			# need to backup the current file in ~ then symlink this file in ~
			echo "$rcfile exists in home dir"
		fi
done

# reconstitute my coloration
xrdb -load ~/.Xresources
xrdb -merge ~/.Xresources

