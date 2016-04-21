#!/bin/bash

#laziness++ grab the parent dir of scripts
backupdir=$(dirname $(dirname $(realpath $0)))
scriptdir="$backupdir/scripts"
oldfiledir="$backupdir/old_dotfiles"

if [ ! -d $oldfiledir ]
then
	mkdir $oldfiledir
fi


for backup in $(ls -A $backupdir)
do
	#skip these things
	if [ $backup == ".git" -o $backup == ".gitignore" -o $backup == "misc" -o $backup == "scripts" -o $backup == $oldfiledir ]
	then
		continue
	fi

	# if there is no file/dir with $backup's name in ~, and the current $backup is a file, then symlink it
	if [ ! -e ~/$backup ] && [ -f $backupdir/$backup ]
	then
		echo "Creating symlink: ~/$backup -> $backupdir/$backup"
		ln -s $backupdir/$backup ~/$backup
		continue
	fi


	if [ -f $backupdir/$backup ] # if the backup is a file
	then
		if [ ! -L ~/$backup ] # file exists but is not a symlink
		then
			read -p "Replace file ~/$backup with symlink to $backupdir/$backup ? " answer
			if [ answer == "y" -o answer == "Y" ]
			then
				mv ~/$backup $oldfiledir/$backup
				ln -s $backupdir/$backup ~/$backup
			fi
		else
			if [ $(readlink ~/$backup) != $(realpath $backupdir/$backup) ] #TODO replace string comparisons with file path comparisons
			then
				read -p "Replace symlink ~/$backup with symlink to $backupdir/$backup ? " answer
				if [ answer == "y" -o answer == "Y" ]
				then
					rm ~/$backup
					ln -s $backupdir/$backup ~/$backup
				fi
			fi
		fi
	fi

	if [ -d $backup ] # if the backup is its own dir of backups
	then
		for $rcdir in $(ls -A $backupdir/$backup)
		do
			if [ ! -e ~/$backup/$rcdir ] #if no dir or link exists, make it
			then
				echo "Creating symlink: ~/$backup/$rcdir -> $backupdir/$backup/$rcdir"
				ln -s $backupdir/$backup/$rcdir ~/$backup/$rcdir
				continue
			else
				if [ ! -L ~/$backup/$rcdir ] # if the dir exists but is not a link, prompt and make
				then
					read -p "Replace dir ~/$backup/$rcdir with symlink to $backupdir/$backup/$rcdir ? " answer
					if [ answer == "y" -o answer == "Y" ]
					then
						mv ~/$backup/$rcdir $oldfiledir/$backup
						ln -s $backupdir/$backup/$rcdir ~/$backup/$rcdir
					fi
				elif [ $(readlink ~/$backup/$rcdir) != $(realpath $backupdir/$backup/$rcdir) ] #if the symlink is not pointing to the repo
				then
					read -p "Replace symlink ~/$backup with symlink to $backupdir/$backup ? " answer
					if [ answer == "y" -o answer == "Y" ]
					then
						rm ~/$backup/$rcdir
						ln -s $backupdir/$backup/$rcdir ~/$backup/$rcdir
					fi
				fi
			fi
		done
	fi
done

# load and merge .Xresources file
$scriptdir/xres.sh

