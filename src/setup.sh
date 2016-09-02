#!/usr/bin/env bash

# Exit on any errors
set -e

# Prepare backups directory
DATE=$(date '+%Y%m%d')
BACKUPDIR=~/.backups/${DATE}
install -m 0700 -d ${BACKUPDIR}

# Backup files
echo "shell ..."
install -m 0644 dot_profile ~/.profile

# .local setup
echo "local ..."
install -m 0755 -d ~/.local/bin
install -m 0755 -d ~/.local/lib
install -m 0755 -d ~/.local/share
install -m 0755 -d ~/.local/etc/cron
install -m 0755 runcron ~/.local/bin

# Cron setup
echo "cron ..."
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
grep -v ~/.cron/ "${BACKUPDIR}/crontab" > "${tmpcrontab}"
echo "0 * * * *" ~/.local/bin/runcron ~/.local/etc/cron/hourly  >> "${tmpcrontab}"
echo "0 0 * * *" ~/.local/bin/runcron ~/.local/etc/cron/daily   >> "${tmpcrontab}"
echo "0 4 * * *" ~/.local/bin/runcron ~/.local/etc/cron/daily-4 >> "${tmpcrontab}"
echo "0 8 * * *" ~/.local/bin/runcron ~/.local/etc/cron/daily-8 >> "${tmpcrontab}"
echo "0 12 * * *" ~/.local/bin/runcron ~/.local/etc/cron/daily-12 >> "${tmpcrontab}"
echo "0 16 * * *" ~/.local/bin/runcron ~/.local/etc/cron/daily-16 >> "${tmpcrontab}"
echo "0 20 * * *" ~/.local/bin/runcron ~/.local/etc/cron/daily-20 >> "${tmpcrontab}"
echo "0 0 * * 0" ~/.local/bin/runcron ~/.local/etc/cron/weekly  >> "${tmpcrontab}"
echo "0 0 1 * *" ~/.local/bin/runcron ~/.local/etc/cron/monthly >> "${tmpcrontab}"
echo "0 0 1 1 *" ~/.local/bin/runcron ~/.local/etc/cron/yearly  >> "${tmpcrontab}"
crontab "${tmpcrontab}"
rm -f "${tmpcrontab}"
