fancy: all install-conky install-torrent

all: light install-bar install-i3 install-mail install-music install-dunst

light: install-bash install-gtk install-htop install-ranger install-termite install-vim install-scripts install-X

clean:
	stow -D bar bash conky gtk htop i3 mail music ranger scripts termite torrent vim X

install-i3:
	stow i3

install-bar:
	stow bar

install-bash:
	stow bash

install-conky:
	stow conky

install-dunst:
	stow dunst

install-gtk:
	stow gtk

install-htop:
	stow htop

install-mail:
	stow mail

install-music:
	stow music

install-ranger:
	stow ranger

install-scripts:
	stow scripts

install-termite:
	stow termite

install-torrent:
	stow torrent

install-vim:
	stow vim

install-X:
	stow X
