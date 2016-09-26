#!/usr/bin/env bash

# Exit on any errors
set -e
function echoerr() { echo "$@" 1>&2; }

# Configure some shell variables
PATH=${PATH}:${HOME}/.local/bin
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/.local/lib
DATAROOTDIR="${HOME}/.local/share"

# Autodetect current install capabilities
hash crontab > /dev/null 2>&1
has_crontab=$?
hash curl > /dev/null 2>&1
has_curl=$?
hash dialog > /dev/null 2>&1
has_dialog=$?
hash gcc > /dev/null 2>&1
has_gcc=$?
hash git > /dev/null 2>&1
has_git=$?
hash global > /dev/null 2>&1
has_global=$?
hash grep > /dev/null 2>&1
has_grep=$?
hash install > /dev/null 2>&1
has_install=$?
hash make > /dev/null 2>&1
has_make=$?
hash mkid > /dev/null 2>&1
has_mkid=$?
hash mktemp > /dev/null 2>&1
has_mktemp=$?
hash sed > /dev/null 2>&1
has_sed=$?
hash tar > /dev/null 2>&1
has_tar=$?
hash uname > /dev/null 2>&1
has_uname=$?
hash unshar > /dev/null 2>&1
has_unshar=$?

# Install error reporting
[[ 0 == $has_git     ]] || echoerr "This script requires 'git' !"
[[ 0 == $has_grep    ]] || echoerr "This script requires 'grep' !"
[[ 0 == $has_install ]] || echoerr "This script requires 'install' !"
[[ 0 == $has_mktemp  ]] || echoerr "This script requires 'mktemp' !"
[[ 0 == $has_sed     ]] || echoerr "This script requires 'sed' !"
[[ 0 == $has_unshar  ]] || echoerr "This script requires 'unshar' !"
[[ 0 == $has_git && 0 == $has_install && 0 == $has_mktemp && 0 == $has_sed && 0 == $has_unshar ]] || exit 1

build_idutils=
if [[ 0 != $has_mkid && 0 == $has_curl && 0 == $has_gcc && 0 == $has_make && 0 == $has_tar ]]; then
    build_idutils=Yes
fi

build_global=
if [[ 0 != $has_global && 0 == $has_curl && 0 == $has_gcc && 0 == $has_make && 0 == $has_tar ]]; then
    build_global=Yes
fi

os_name=
if [[ 0 == $has_uname ]]; then
    os_name=$(uname -o)
fi

# Save current directory
RUNCWD=$(pwd)

# Prepare backups directory
DATE=$(date '+%Y%m%d')
HOUR=$(date '+%H%M%S')
BACKUPDIR=~/.backups/${DATE}/${HOUR}
install -m 0700 -d ${BACKUPDIR}

# Backup files
echo "shell ..."
touch ~/.bash_profile
touch ~/.bashrc
cp -f ~/.bash_profile ${BACKUPDIR}
cp -f ~/.bashrc       ${BACKUPDIR}
install -m 0644 dot_profile ~/.bash_profile
install -m 0644 dot_bashrc  ~/.bashrc

# XWinrc for Cygwin
echo "XWindow ..."
if [ -e ~/.Xresources ]; then
    cp -f ~/.Xresources ${BACKUPDIR}
fi
if [ -e ~/.XWinrc ]; then
    cp -f ~/.XWinrc ${BACKUPDIR}
fi
install -m 0644 Xresources ~/.Xresources
install -m 0644 XWinrc ~/.XWinrc

# .local setup
echo "local ..."
install -m 0755 -d ~/.local/bin
install -m 0755 -d ~/.local/lib
install -m 0755 -d ~/.local/share
install -m 0755 -d ~/.local/var/lock
install -m 0755 -d ~/.local/var/log
install -m 0755 -d ~/.local/var/run
install -m 0755 -d ~/.local/etc/cron
install -m 0755 runcron ~/.local/bin

# Cron setup
echo "cron ..."
if [[ 0 == $has_crontab ]]; then
    install -m 0755 -d ~/.local/etc/cron
    install -m 0755 -d ~/.local/etc/cron/hourly
    install -m 0755 -d ~/.local/etc/cron/daily
    install -m 0755 -d ~/.local/etc/cron/daily-4
    install -m 0755 -d ~/.local/etc/cron/daily-8
    install -m 0755 -d ~/.local/etc/cron/daily-12
    install -m 0755 -d ~/.local/etc/cron/daily-16
    install -m 0755 -d ~/.local/etc/cron/daily-20
    install -m 0755 -d ~/.local/etc/cron/weekly
    install -m 0755 -d ~/.local/etc/cron/monthly
    install -m 0755 -d ~/.local/etc/cron/yearly
    install -m 0755 -d ~/.local/etc/cron/commands
    touch ~/.local/etc/cron/environ.bash

    crontab -l > "${BACKUPDIR}/crontab"
    tmpcrontab=$(mktemp)
    grep -v ~/.local/bin/runcron "${BACKUPDIR}/crontab" \
	 > "${tmpcrontab}"
    echo "0  * * * *" ~/.local/bin/runcron hourly   >> "${tmpcrontab}"
    echo "0  0 * * *" ~/.local/bin/runcron daily    >> "${tmpcrontab}"
    echo "0  4 * * *" ~/.local/bin/runcron daily-4  >> "${tmpcrontab}"
    echo "0  8 * * *" ~/.local/bin/runcron daily-8  >> "${tmpcrontab}"
    echo "0 12 * * *" ~/.local/bin/runcron daily-12 >> "${tmpcrontab}"
    echo "0 16 * * *" ~/.local/bin/runcron daily-16 >> "${tmpcrontab}"
    echo "0 20 * * *" ~/.local/bin/runcron daily-20 >> "${tmpcrontab}"
    echo "0  0 * * 0" ~/.local/bin/runcron weekly   >> "${tmpcrontab}"
    echo "0  0 1 * *" ~/.local/bin/runcron monthly  >> "${tmpcrontab}"
    echo "0  0 1 1 *" ~/.local/bin/runcron yearly   >> "${tmpcrontab}"
    crontab "${tmpcrontab}"
    rm -f "${tmpcrontab}"
fi

# vim
echo "vim ..."
touch ~/.vimrc
cp -f ~/.vimrc ${BACKUPDIR}
install -m 0644 vimrc ~/.vimrc

# emacs
echo "emacs ..."
touch ~/.emacs
cp -f ~/.emacs ${BACKUPDIR}
install -m 0644 emacs ~/.emacs

echo "emacs cedet ..."
CEDETDIR=cedet-git
if [ ! -e "${DATAROOTDIR}/${CEDETDIR}" ]; then
    git -C "${DATAROOTDIR}" clone \
	'http://git.code.sf.net/p/cedet/git' ${CEDETDIR}
    make -C "${DATAROOTDIR}/${CEDETDIR}" EMACS=emacs
fi

echo "emacs ecb ..."
ECBDIR=ecb-git
if [ ! -e "${DATAROOTDIR}/${ECBDIR}" ]; then
    git -C "${DATAROOTDIR}" clone \
	'https://github.com/alexott/ecb.git' ${ECBDIR}
fi

# gnu global / idutils
echo "dev tools ..."
if [[ -n "$build_idutils" ]]; then
    echo "Building idutils ..."
    TMPDIR=$(mktemp -d)
    RELEASE="idutils-4.5"
    TGZ="${TMPDIR}/${RELEASE}.tar.gz"
    SRCDIR="${TMPDIR}/${RELEASE}"
    BUILDDIR="${TMPDIR}/build"
    curl -s -o "${TGZ}" \
	 "http://ftp.gnu.org/gnu/idutils/${RELEASE}.tar.gz"
    tar -C "${TMPDIR}" -zxf "${TGZ}"
    mkdir "${BUILDDIR}"
    cd "${BUILDDIR}"
    "${SRCDIR}/configure" "--prefix=${HOME}/.local"
    make
    make install
    cd "${RUNCWD}"
fi

if [[ -n "$build_global" ]]; then
    echo "Building GNU global ..."
    TMPDIR=$(mktemp -d)
    RELEASE="global-6.5.4"
    TGZ="${TMPDIR}/${RELEASE}.tar.gz"
    SRCDIR="${TMPDIR}/${RELEASE}"
    BUILDDIR="${TMPDIR}/build"
    curl -s -o "${TGZ}" \
	 "http://ftp.gnu.org/gnu/global/${RELEASE}.tar.gz"
    tar -C "${TMPDIR}" -zxf "${TGZ}"
    mkdir "${BUILDDIR}"
    cd "${BUILDDIR}"
    "${SRCDIR}/configure" "--prefix=${HOME}/.local"
    make
    make install
    cd "${RUNCWD}"
fi
