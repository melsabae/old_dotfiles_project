#!/bin/bash

for rcfile in $(ls -a $(pwd))
do
	# skip '.', '..', and the script itself
	if [ $rcfile == "." -o $rcfile == ".." -o $rcfile == $0 -o $rcfile == ".git" ]
	then
		continue
	fi

	# not sure what to do with  these files for now
	if [ $rcfile == "misc" ]
	then
		continue
	fi

	if [ $rcfile == ".gitignore" -o $rcfile == "*.swp" -o $rcfile == "xres.sh" -o $rcfile == "doit.sh" ]
	then
		continue
	fi

	# check if this thing is a directory
	if [ -d $rcfile ]
	then 
		for rcdir in $(ls -a $(pwd)/$rcfile)
		do
			if [ $rcdir != "." -a $rcdir != ".." ]
			then
				read -p "Replace ~/$rcfile/$rcdir? [yn/YN] " answer
				if [ answer == "y" -o answer == "Y" ]
				then
					rm -rf ~/$rcfile/$rcdir
					ln -s $(pwd)/$rcfile/$rcdir ~/$rcfile/$rcdir
				fi
			fi
		done

		continue
	fi

	#check to see if the file currently exists in ~
	if [ -f ~/$rcfile ]
	then
		read -p "Replace ~/$rcfile? [yn/YN] " answer
		if [ answer == "y" -o answer == "Y" ]
		then
			# need to backup the current file in ~ then symlink this file in ~
			rm ~/$rcfile
			ln -s $(pwd)/$rcfile ~/$rcfile
		fi
	else
		cp $(pwd)/$rcfile ~/
	fi
done

exec $(pwd)/xres.sh

