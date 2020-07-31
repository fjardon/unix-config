POD2MAN = pod2man -r "github.com/fjardon/unix-config" -c "FJ Unix Config Commands"
TAR = tar

all : setup-latest.sh

setup-latest.sh: setup-template setup-files.shar
	sed -e '/[@]SHAR_ARCHIVE[@]/ r setup-files.shar' setup-template > $@
	chmod 0755 $@

GIT_FILES  = apt-cyg
MAN1_FILES = byzanz-helper.1 \
			 codefmt.1 \
			 codemv.1 \
			 plgen.1 \
             ffmpeg-helper.1 \
             hyper-v.1 \
             msvc-shell.1 \
			 sixel2tmux.1 \
             yank.1
SHAR_FILES = config.site \
             dot_bash_profile \
             dot_bashrc \
             dot_gdbinit \
             dot_gemrc \
             dot_profile \
             dot_tmux_conf \
             dot_vimrc \
			 dot_xprofile \
             dot_Xresources \
             dot_Xresources_user \
             dot_XWinrc \
             ibase.sh \
			 scripts/byzanz-helper \
             scripts/codefmt \
             scripts/codemv \
             scripts/plgen \
             scripts/ffmpeg-helper \
             scripts/hyper-v \
             scripts/msvc-shell \
             scripts/sixel2tmux \
             scripts/yank \
             share-gdb.tar \
             tmux-256color.tinfo \
			 uudecode.pl \
             runcron \
			 vscode-term.env \
			 vscode.sh \
             $(GIT_FILES) \
             $(MAN1_FILES)

apt-cyg:
	curl -O 'https://raw.githubusercontent.com/fjardon/apt-cyg/master/apt-cyg'
	chmod a+x apt-cyg

byzanz-helper.1 : scripts/byzanz-helper
	$(POD2MAN) $< $@

codefmt.1 : scripts/codefmt
	$(POD2MAN) $< $@

codemv.1 : scripts/codemv
	$(POD2MAN) $< $@

plgen.1 : scripts/plgen
	$(POD2MAN) $< $@

ffmpeg-helper.1 : scripts/ffmpeg-helper
	$(POD2MAN) $< $@

share-gdb :
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python share-gdb/python

share-gdb.tar : share-gdb
	$(TAR) cvf share-gdb.tar --exclude '.svn' -C share-gdb .

hyper-v.1 : scripts/hyper-v
	$(POD2MAN) $< $@

msvc-shell.1 : scripts/msvc-shell
	$(POD2MAN) $< $@

sixel2tmux.1 : scripts/sixel2tmux
	$(POD2MAN) $< $@

yank.1 : scripts/yank
	$(POD2MAN) $< $@

setup-files.shar: $(SHAR_FILES)
	shar $^ > $@

clean:
	$(RM) -f setup-latest.sh
	$(RM) -f setup-files.shar
	$(RM) -rf share-gdb
	$(RM) -f share-gdb.tar
	$(RM) -f $(MAN1_FILES)
	$(RM) -f $(GIT_FILES)


