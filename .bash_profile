#
# ~/.bash_profile
#

if shopt -q login_shell; then
	[[ -f ~/.bashrc ]] && source ~/.bashrc
	if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then exec startx; fi
else
	echo "not login shell"
	exit 1
fi
