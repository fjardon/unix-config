

all : setup-latest.sh

setup.sh: setup-template setup-files.shar
	sed -e '/[@]SHAR_ARCHIVE[@]/ r setup-files.shar' setup-template > $@
	chmod 0755 $@

setup-files.shar: dot_profile dot_bashrc dot_emacs runcron dot_vimrc dot_Xresources dot_XWinrc
	shar $^ > $@

