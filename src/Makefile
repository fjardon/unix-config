POD2MAN = pod2man -r "github.com/fjardon/unix-config" -c "FJ Unix Config Commands"
TAR = tar

all : setup-latest.sh

setup-latest.sh: setup-template setup-files.shar
	sed -e '/[@]SHAR_ARCHIVE[@]/ r setup-files.shar' setup-template > $@
	chmod 0755 $@

GIT_FILES  = apt-cyg
MAN1_FILES = byzanz-helper.1 \
             ffmpeg-helper.1 \
             hyper-v.1 \
             msvc-shell.1 \
			 sixel2tmux.1 \
             yank.1
SHAR_FILES = config.site \
             dot_bash_profile \
             dot_bashrc \
             dot_gdbinit \
             dot_profile \
             dot_tmux_conf \
             dot_vimrc \
             dot_Xresources \
             dot_XWinrc \
             byzanz-helper \
             ffmpeg-helper \
             hyper-v \
             msvc-shell \
             sixel2tmux \
             yank \
             tmux-256color.tinfo \
             runcron \
             share-gdb.tar \
             $(GIT_FILES) \
             $(MAN1_FILES)

apt-cyg:
	curl -O 'https://raw.githubusercontent.com/fjardon/apt-cyg/master/apt-cyg'
	chmod a+x apt-cyg

byzanz-helper.1 : byzanz-helper
	$(POD2MAN) $< $@

ffmpeg-helper.1 : ffmpeg-helper
	$(POD2MAN) $< $@

share-gdb :
	svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python share-gdb/python

share-gdb.tar : share-gdb
	$(TAR) cvf share-gdb.tar --exclude '.svn' -C share-gdb .

hyper-v.1 : hyper-v
	$(POD2MAN) $< $@

msvc-shell.1 : msvc-shell
	$(POD2MAN) $< $@

sixel2tmux.1 : sixel2tmux
	$(POD2MAN) $< $@

yank.1 : yank
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


