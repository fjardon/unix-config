

all : setup-latest.sh

setup-latest.sh: setup-template setup-files.shar
	sed -e '/[@]SHAR_ARCHIVE[@]/ r setup-files.shar' setup-template > $@
	chmod 0755 $@

SHAR_FILES = dot_bash_profile \
						 dot_bashrc \
						 dot_profile \
						 dot_tmux_conf \
						 dot_vimrc \
						 dot_Xresources \
						 dot_XWinrc \
						 msvc-shell \
						 tmux-256color.tinfo \
						 runcron

setup-files.shar: $(SHAR_FILES)
	shar $^ > $@

clean:
		$(RM) setup-latest.sh
		$(RM) setup-files.shar
