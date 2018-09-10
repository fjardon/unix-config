POD2MAN = pod2man -r "github.com/fjardon/unix-config" -c "FJ Unix Config Commands"

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
						 byzanz-helper \
						 byzanz-helper.1 \
						 ffmpeg-helper \
						 ffmpeg-helper.1 \
						 hyper-v \
						 hyper-v.1 \
						 msvc-shell \
						 msvc-shell.1 \
						 yank \
						 yank.1 \
						 tmux-256color.tinfo \
						 runcron

byzanz-helper.1 : byzanz-helper
	$(POD2MAN) $< $@

ffmpeg-helper.1 : ffmpeg-helper
	$(POD2MAN) $< $@

hyper-v.1 : hyper-v
	$(POD2MAN) $< $@

msvc-shell.1 : msvc-shell
	$(POD2MAN) $< $@

yank.1 : yank
	$(POD2MAN) $< $@

setup-files.shar: $(SHAR_FILES)
	shar $^ > $@

clean:
		$(RM) setup-latest.sh
		$(RM) setup-files.shar
