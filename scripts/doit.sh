#!/bin/bash

#laziness++ grab the parent dir of scripts
backupdir=$(dirname $(dirname $(realpath $0)))
oldfiledir="$backupdir/old_dotfiles"

if [ ! -d $oldfiledir ]
then
	mkdir $oldfiledir
fi

if [ -f ~/"notarealfileihope" ]
then
	echo $backupdir/$backup
	echo "Creating symlink: ~/$backup -> $backupdir/$backup"

	for backup in $(ls -A $backupdir)
	do
		#skip these things
		if [ $backup == ".git" -o $backup == ".gitignore" -o $backup == "misc" -o $backup == "scripts" \
			-o $backup == $oldfiledir ]
		then
			continue
		fi


		if [ -f $backupdir/$backup ] # if the backup is a file
		then
			if [ ! -f ~/$backup ] # if there is no file or symlink to this backup
			then
				ln -s $backupdir/$backup ~/$backup
			else
				if [ ! -L ~/$backup ] # file exists but is not a symlink
				then
					read -p "Replace file ~/$backup with symlink to $backupdir/$backup ? " answer
					if [ answer == "y" -o answer == "Y" ]
					then
						mv ~/$backup $oldfiledir/$backup
						ln -s $backupdir/$backup ~/$backup
					fi
				else
					if [ $(readlink ~/$backup) != $backupdir/$backup ] #if the symlink is not the same target
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
		fi

		if [ -d $backup ]
		then
			continue
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
else
	for backup in $(ls -A $backupdir)
	do
		echo $backupdir/$backup
	done
fi

		echo $oldfiledir

# load and merge .Xresources file
#$(dirname $0)/xres.sh #TODO: resolve path correctly

