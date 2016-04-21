#!/bin/bash

#laziness++ grab the parent dir of scripts
backupdir=$(dirname $(dirname $(realpath $0)))
scriptdir="$backupdir/scripts"
oldfiledir="$backupdir/old_dotfiles"

linkIt ()
{
	if [ -z "$1" ]
	then
		return
	fi

	ln -s $backupdir/$1  ~/$1
	echo "ln -s $backupdir/$1 ~/$1"
}

if [ ! -d $oldfiledir ]
then
	mkdir $oldfiledir
fi


for backup in $(ls -A $backupdir)
do
	#skip these things
	if [ $backup == ".git" -o $backup == ".gitignore" -o $backup == "misc" -o $backup == "scripts" -o $backup == $(basename $oldfiledir) ]
	then
		continue
	fi

	# if there is no file/dir with $backup's name in ~, and the current $backup is a file, then symlink it
	if [ ! -e ~/$backup ] && [ -f $backupdir/$backup ]
	then
		echo "Creating symlink: ~/$backup -> $backupdir/$backup"
		linkIt $backup
		continue
	fi


	if [ -f $backupdir/$backup ] # if the backup is a file
	then
		if [ ! -L ~/$backup ] # file exists but is not a symlink
		then
			read -p "Replace file ~/$backup with symlink to $backupdir/$backup ? " answer
			if [[ $answer =~ ^[Yy]$ ]]
			then
				mv ~/$backup $oldfiledir/$backup
				linkIt $backup
			fi
		else
			if [ $(readlink ~/$backup) != $(realpath $backupdir/$backup) ] #TODO replace string comparisons with file path comparisons
			then
				read -p "Replace symlink ~/$backup ($(readlink ~/$backup)) with symlink to $backupdir/$backup ? " answer
				if [[ $answer =~ ^[Yy]$ ]]
				then
					rm ~/$backup
					linkIt $backup
				fi
			fi
		fi
	fi

	if [ -d $backupdir/$backup ] # if the backup is its own dir of backups
	then
		for rcdir in $(ls -A $backupdir/$backup)
		do
			if [ ! -e ~/$backup/$rcdir ] #if no dir or link exists, make it
			then
				echo "Creating symlink: ~/$backup/$rcdir -> $backupdir/$backup/$rcdir"
				linkIt $backup/$rcdir
				continue
			else
				if [ ! -L ~/$backup/$rcdir ] # if the dir exists but is not a link, prompt and make
				then
					read -p "Replace dir ~/$backup/$rcdir with symlink to $backupdir/$backup/$rcdir ? " answer
					if [[ $answer =~ ^[Yy]$ ]]
					then
						mv ~/$backup/$rcdir $oldfiledir/$backup
						linkIt $backup/$rcdir
					fi
				elif [ $(readlink ~/$backup/$rcdir) != $(realpath $backupdir/$backup/$rcdir) ] #if the symlink is not pointing to the repo
				then
					read -p "Replace symlink ~/$backupdir/$backup ($(readlink $backupdir/$backup)) with symlink to $backupdir/$backup ? " answer
					if [[ $answer =~ ^[Yy]$ ]]
					then
						rm ~/$backup/$rcdir
						linkIt $backup/$rcdir
					fi
				fi
			fi
		done
	fi
done

# load and merge .Xresources file
$scriptdir/xres.sh

