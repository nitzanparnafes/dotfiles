#!/bin/bash
#
# Dotfiles Installation script
# Move and backup the configuration files.
#

BSPWMC="/home/$USER/.config/bspwm/bspwmrc"
SXHKDC="/home/$USER/.config/sxhkd/sxhkdrc"
PANELDIR="/home/$USER/.config/bspwmpanel/"

if [ -e $BSPWMC -o -e $SXHKDC ]
then
	echo $"BSWPM and SXHKD file already found on your computer. \nWould You like to create a backup folder? (Y/N)"
	read answer
	if [ $answer == "Y" -o $answer == "y" -o $answer == "Yes" -o $answer == "YES" ]
	then
		mkdir /home/$USER/.configBackup 					# Creating backup folder
		if [ -e $BSPWMC ]
		then
			mv $BSPWMC /home/$USER/.configBackup
		fi
		if [ -e $SXHKDC ]
		then
			mv $SXHKD /home/$USER/.configBackup
		fi
	echo 'Moved old files to backup folder'
	fi
fi

# Installing Panel

mkdir bar && cd bar
git clone https://github.com/krypt-n/bar
cd bar
make && sudo make install

# Panel installed successfully

if [ -e $PANELDIR/panel -o -e $PANELDIR/panel_bar -o -e $PANELDIR/panel_colors ]
then
	echo $"Panel Configuration files already found on your computer. \nWould you like to move it to the backup folder? (Y/N)"
	read answer
	if [ $answer == "Y" -o $answer == "y" -o $answer == "Yes" -o $answer == "YES" ]
	then
		mkdir /home/$USER/.configBackup/bspwmpanel/				# Creating backup folder
		if [ -e $PANELDIR/panel ]
		then
			mv $PANELDIR/panel /home/$USER/.configBackup/bspwmpanel/
		fi
		if [ -e $PANELDIR/panel_bar ]
		then
			mv $PANELDIR/panel_bar /home/$USER/.configBackup/bspwmpanel/
		fi
		if [ -e $PANELDIR/panel_colors ]
		then
			mv $PANELDIR/panel_colors /home/$USER/.configBackup/bspwmpanel/
		fi
	echo 'Moved old files to backup folder'
	fi
fi

if [ -e $USER/.Xresources -o -e $USER/.compton.conf ]
then
	echo $"Old Xresources file and compton configuration file already found on your computer. \nWould you like to move it to the backup folder? (Y/N)"
	read answer
	if [ $answer == "Y" -o $answer == "y" -o $answer == "Yes" -o $answer == "YES" ]
	then
		if [ -e $USER/.Xresources ]
		then
			mv $USER/.Xresources /home/$USER/.configBackup
		fi
		if [ -e $USER/.compton.conf ]
		then
			mv $USER/.compton.conf /home/$USER/.configBackup
		fi
	echo 'Moved old files to backup folder'
	fi
fi

# Moving new files to directories.

DIR="/home/$USER/.config/"

mv ".config/bspwm/bspwmrc" "$DIR/bspwm/bspwmrc"
mv ".config/sxhkd/sxhkdrc" "$DIR/sxhkd/sxhkdrc"
mkdir "$DIR/bspwmpanel"
mv ".config/bspwmpanel/panel*" "$DIR/bspwmpanel/"
mv ".compton.conf" "$USER/"
mv ".Xresources.conf" "$USER/"
mv "Pictures/Space.png" "$USER/Pictures"

##########################

echo '################################'
echo -e "Programs to install\n"
echo "  compton"
echo "  dmenu2"
echo "  slop"
echo -e "\n"; exit 0




