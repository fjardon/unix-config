POD2MAN = pod2man -r "github.com/fjardon/unix-config" -c "FJ Unix Config Commands"
TAR = tar

all : setup

setup: templates/setup tmp/setup-files.shar
	sed -e '/[@]SHAR_ARCHIVE[@]/ r tmp/setup-files.shar' templates/setup > $@
	chmod 0755 $@

GCC_COMMIT = 99677969d463d75a562f94460ea75e9f6a016b4f
GDB_PRETTY_PRINTER_FILES = \
	libstdc++-v3/python/libstdcxx/__init__.py \
	libstdc++-v3/python/libstdcxx/v6/__init__.py \
	libstdc++-v3/python/libstdcxx/v6/printers.py \
	libstdc++-v3/python/libstdcxx/v6/xmethods.py
GIT_FILES  = scripts/apt-cyg
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
	dot/gdbinit \
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
	$(GDB_PRETTY_PRINTER_FILES) \
	$(GIT_FILES) \
	$(MAN1_FILES)

scripts/apt-cyg:
	curl -s -o $@ 'https://raw.githubusercontent.com/fjardon/apt-cyg/master/apt-cyg'
	chmod a+x scripts/apt-cyg

libstdc++-v3/python/libstdcxx/__init__.py :
	mkdir -p libstdc++-v3/python/libstdcxx/v6
	curl -s -o $@ -L -G --data-urlencode 'f=$@' --data-urlencode 'hb=$(GCC_COMMIT)' --expand-url 'https://gcc.gnu.org/git/?p=gcc.git;a=blob_plain;'

libstdc++-v3/python/libstdcxx/v6/__init__.py :
	mkdir -p libstdc++-v3/python/libstdcxx/v6
	curl -s -o $@ -L -G --data-urlencode 'f=$@' --data-urlencode 'hb=$(GCC_COMMIT)' --expand-url 'https://gcc.gnu.org/git/?p=gcc.git;a=blob_plain;'

libstdc++-v3/python/libstdcxx/v6/printers.py :
	mkdir -p libstdc++-v3/python/libstdcxx/v6
	curl -s -o $@ -L -G --data-urlencode 'f=$@' --data-urlencode 'hb=$(GCC_COMMIT)' --expand-url 'https://gcc.gnu.org/git/?p=gcc.git;a=blob_plain;'

libstdc++-v3/python/libstdcxx/v6/xmethods.py :
	mkdir -p libstdc++-v3/python/libstdcxx/v6
	curl -s -o $@ -L -G --data-urlencode 'f=$@' --data-urlencode 'hb=$(GCC_COMMIT)' --expand-url 'https://gcc.gnu.org/git/?p=gcc.git;a=blob_plain;'

man/byzanz-helper.1 : scripts/byzanz-helper
	mkdir -p man
	$(POD2MAN) $< $@

man/codefmt.1 : scripts/codefmt
	mkdir -p man
	$(POD2MAN) $< $@

man/codemv.1 : scripts/codemv
	mkdir -p man
	$(POD2MAN) $< $@

man/plgen.1 : scripts/plgen
	mkdir -p man
	$(POD2MAN) $< $@

man/ffmpeg-helper.1 : scripts/ffmpeg-helper
	mkdir -p man
	$(POD2MAN) $< $@

man/hyper-v.1 : scripts/hyper-v
	mkdir -p man
	$(POD2MAN) $< $@

man/msvc-shell.1 : scripts/msvc-shell
	mkdir -p man
	$(POD2MAN) $< $@

man/sixel2tmux.1 : scripts/sixel2tmux
	mkdir -p man
	$(POD2MAN) $< $@

man/yank.1 : scripts/yank
	mkdir -p man
	$(POD2MAN) $< $@

tmp/setup-files.shar: $(SHAR_FILES)
	mkdir -p tmp
	shar $^ > $@

clean:
	$(RM) -f setup
	$(RM) -f tmp/setup-files.shar
	$(RM) -f $(GDB_PRETTY_PRINTER_FILES)
	$(RM) -f $(GIT_FILES)
	$(RM) -f $(MAN1_FILES)
	$(RM) -rf man
	$(RM) -rf tmp


