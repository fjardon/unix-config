#!/usr/bin/env bash

# Exit on any errors
set -e
function echoerr() { echo "$@" 1>&2; }

# Sanity checks
has_errors=""
if ! hash git; then
    has_errors='x'
    echoerr "This script requires 'git' !"
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
DATAROOTDIR="${HOME}/.local/share"

# Cron setup
echo "cron ..."
if command -v crontab > /dev/null 2>&1; then
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
if ! command -v mkid > /dev/null 2>&1; then
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

if ! command -v global > /dev/null 2>&1; then
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
