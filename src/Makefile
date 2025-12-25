POD2MAN = pod2man -r "github.com/fjardon/unix-config" -c "FJ Unix Config Commands"
TAR = tar

all : man-dir setup

setup: templates/setup tmp/setup-files.shar
	sed -e '/[@]SHAR_ARCHIVE[@]/ r tmp/setup-files.shar' templates/setup > $@
	chmod 0755 $@

# GIT_FILES  = apt-cyg
MAN1_FILES = \
             man/byzanz-helper.1 \
             man/codefmt.1 \
             man/codemv.1 \
             man/ffmpeg-helper.1 \
             man/hyper-v.1 \
             man/msvc-shell.1 \
             man/plgen.1 \
             man/sixel2tmux.1 \
             man/yank.1
SHAR_FILES = \
             data/config.site \
             data/tmux-256color.tinfo \
             dot/bash_profile \
             dot/bashrc \
             dot/gemrc \
             dot/profile \
             dot/tmux.conf \
             dot/vimrc \
             dot/xprofile \
             dot/Xresources \
             dot/Xresources_user \
             dot/XWinrc \
             scripts/bshell.bat \
             scripts/byzanz-helper \
             scripts/codefmt \
             scripts/codemv \
             scripts/ffmpeg-helper \
             scripts/hyper-v \
             scripts/msvc-shell \
             scripts/plgen \
             scripts/runcron \
             scripts/sixel2tmux \
             scripts/uudecode.pl \
             scripts/yank \
             $(MAN1_FILES)

man-dir:
	mkdir -p man

# scripts/apt-cyg:
# 	curl -O 'https://raw.githubusercontent.com/fjardon/apt-cyg/master/apt-cyg'
# 	chmod a+x apt-cyg

man/byzanz-helper.1 : scripts/byzanz-helper
	$(POD2MAN) $< $@

man/codefmt.1 : scripts/codefmt
	$(POD2MAN) $< $@

man/codemv.1 : scripts/codemv
	$(POD2MAN) $< $@

man/plgen.1 : scripts/plgen
	$(POD2MAN) $< $@

man/ffmpeg-helper.1 : scripts/ffmpeg-helper
	$(POD2MAN) $< $@

man/hyper-v.1 : scripts/hyper-v
	$(POD2MAN) $< $@

man/msvc-shell.1 : scripts/msvc-shell
	$(POD2MAN) $< $@

man/sixel2tmux.1 : scripts/sixel2tmux
	$(POD2MAN) $< $@

man/yank.1 : scripts/yank
	$(POD2MAN) $< $@

tmp/setup-files.shar: $(SHAR_FILES)
	mkdir tmp
	shar $^ > $@

clean:
	$(RM) -f setup
	$(RM) -f tmp/setup-files.shar
	$(RM) -rf tmp
	$(RM) -f $(MAN1_FILES)
	$(RM) -rf man


