# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
export PS1="\[\033[32m\]┌╴[\w]\[\033[0m\]\n\[\033[32m\]└╴\[\033[1;36m\]\u\[\033[1;33m\] > \[\033[0m\]"
alias scrot='scrot ~/Pictures/Screenshots/%b%d::%H%M%S.png'
alias sysupdate='sudo emerge --sync && sudo emerge --ask -uDU --with-bdeps=y @world'
alias suspend='sudo pm-suspend'
alias make.conf='sudo $EDITOR /etc/portage/make.conf'
