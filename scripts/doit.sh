#!/bin/bash

#laziness++ grab the parent dir of scripts
backupdir=$(basename $(dirname $0))
echo $backupdir

if [ -f ~/"notarealfileihope" ]
then
	for backup in $(ls -A $backupdir)
	do
		#skip these things
		if [ $backup == ".git" -o $backup == ".gitignore" -o $backup == "misc" -o $backup == "scripts" ]
		then
			continue
		fi

		echo $backupdir/$backup

		if [ -f $backupdir/$backup ] # if the backup is a file
		then
			if [ ! -f $backupdir/$backup ] # if there is no file or symlink to this backup
			then
				echo "Creating symlink: ~/$backup -> $backupdir/$backup"
				ln -s $(pwd)/$backup ~/$backup #TODO: handle PWD things
			else
				if [ ! -L ~/$backup ] # file exists but is not a symlink
				then
					continue #TODO:backup old file, drop in symlink
				elif [ $(readlink ~/$backup) == $backupdir/$backup ] #string comparison BAD
				then
					continue #ignore because it's already been done
				else 
					continue #TODO: prompt for permission to change symlink
				fi
			fi
		elif [ -d $backup ]
		then
			continue #TODO: handle directory of backups
		fi

		#if [ -f $backup ] #backup is a file
		#then
		#if [ ! -f ~/$backup ] #if backup is not reached from home dir
		#then
		#echo "Creating symlink: ~/$backup -> $(pwd)/$backup"
		#ln -s $(pwd)/$backup ~/$backup
		#else
		#if [ ! -L ~/$backup ]
		#then
		#read -p "Replace file ~/$backup with symlink to $(pwd)/$backup ? " answer
		#if [ answer == "y" -o answer == "Y" ]
		#then
		#mv ~/$backup $(dirname
		#ln -s $(pwd)/$rcfile/$rcdir ~/$rcfile/$rcdir
		#fi
		#fi
		#fi
		#fi

		#if [ -d $backup ] #backup is a directory
		#then
		#continue
		#fi

		echo
	done
fi


# load and merge .Xresources file
$(dirname $0)/xres.sh #TODO: resolve path correctly

