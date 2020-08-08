#!/usr/bin/env bash

PREFIX="${PREFIX:-${HOME}}"

# =============================================================================
# Exit on any errors
set -e
function echoerr() { echo "$@" 1>&2; }
# =============================================================================

# =============================================================================
# Configure some shell variables
PATH="${PATH}:${PREFIX}/.local/bin"
LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${PREFIX}/.local/lib"
DATAROOTDIR="${PREFIX}/.local/share"
# =============================================================================

# =============================================================================
# Autodetect current install capabilities
function has_prog() {
    hash "$1" > /dev/null 2>&1
    return $?
}

REQUIRED_PROGS=(curl git grep install mktemp sed tar)
has_errors=
for p in ${REQUIRED_PROGS[@]};
do
    if ! has_prog "${p}"; then
       echoerr " - ${p} required"
       has_errors=Yes
    fi
done
if ! has_prog uudecode && ! has_prog perl; then
    echoerr " - uudecode or perl required"
    has_errors=Yes
fi
[[ -z "${has_errors}" ]] || exit 1

os_name=
if has_prog uname; then
    os_name=$(uname -s)
fi
# =============================================================================

# =============================================================================
# Prepare temporary directory to unarchive files
# ----------------------------------------------
RUN_CWD=$(pwd)
SHAR_TMPDIR=$(mktemp -d)
cd "${SHAR_TMPDIR}"
echo "Unsharing files in ${SHAR_TMPDIR} ..."
cat <<'SETUP_SHAR_EOF'> setup.shar
# @SHAR_ARCHIVE@
#!/bin/sh
# This is a shell archive (produced by GNU sharutils 4.15.2).
# To extract the files from this archive, save it to some FILE, remove
# everything before the '#!/bin/sh' line above, then type 'sh FILE'.
#
lock_dir=_sh04856
# Made on 2020-08-08 09:35 CEST by <fjardon@old-beaver>.
# Source directory was '/home/fjardon/workspace/github/unix-config/src'.
#
# Existing files will *not* be overwritten, unless '-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#    601 -rw-rw-r-- config.site
#    455 -rw-rw-r-- dot_bash_profile
#   3065 -rw-rw-r-- dot_bashrc
#    214 -rw-rw-r-- dot_gdbinit
#     89 -rw-rw-r-- dot_gemrc
#   2479 -rw-rw-r-- dot_profile
#   3135 -rw-rw-r-- dot_tmux_conf
#   3051 -rw-r--r-- dot_tmux_3_conf
#   4114 -rw-rw-r-- dot_vimrc
#    340 -rwxrwxr-x dot_xprofile
#    828 -rw-rw-r-- dot_Xresources
#    832 -rw-rw-r-- dot_Xresources_user
#   4076 -rw-rw-r-- dot_XWinrc
#    195 -rw-rw-r-- ibase.sh
#   2541 -rwxrwxr-x scripts/byzanz-helper
#   8094 -rwxrwxr-x scripts/codefmt
#   4685 -rwxrwxr-x scripts/codemv
#  16939 -rwxrwxr-x scripts/plgen
#   3766 -rwxrwxr-x scripts/ffmpeg-helper
#   1820 -rwxrwxr-x scripts/hyper-v
#   6290 -rwxrwxr-x scripts/msvc-shell
#   3591 -rwxrwxr-x scripts/sixel2tmux
#   4128 -rwxrwxr-x scripts/yank
# 143360 -rw-rw-r-- share-gdb.tar
#   2836 -rw-rw-r-- tmux-256color.tinfo
#    332 -rwxrwxr-x uudecode.pl
#    901 -rwxrwxr-x runcron
#    149 -rw-rw-r-- vscode-term.env
#    106 -rw-rw-r-- vscode.sh
#  13765 -rwxrwxr-x apt-cyg
#   5751 -rw-rw-r-- byzanz-helper.1
#   5278 -rw-rw-r-- codefmt.1
#   5359 -rw-rw-r-- codemv.1
#   6704 -rw-rw-r-- plgen.1
#   5707 -rw-rw-r-- ffmpeg-helper.1
#   5125 -rw-rw-r-- hyper-v.1
#   5911 -rw-rw-r-- msvc-shell.1
#   6506 -rw-rw-r-- sixel2tmux.1
#   7189 -rw-rw-r-- yank.1
#
MD5SUM=${MD5SUM-md5sum}
f=`${MD5SUM} --version | egrep '^md5sum .*(core|text)utils'`
test -n "${f}" && md5check=true || md5check=false
${md5check} || \
  echo 'Note: not verifying md5sums.  Consider installing GNU coreutils.'
if test "X$1" = "X-c"
then keep_file=''
else keep_file=true
fi
echo=echo
save_IFS="${IFS}"
IFS="${IFS}:"
gettext_dir=
locale_dir=
set_echo=false

for dir in $PATH
do
  if test -f $dir/gettext \
     && ($dir/gettext --version >/dev/null 2>&1)
  then
    case `$dir/gettext --version 2>&1 | sed 1q` in
      *GNU*) gettext_dir=$dir
      set_echo=true
      break ;;
    esac
  fi
done

if ${set_echo}
then
  set_echo=false
  for dir in $PATH
  do
    if test -f $dir/shar \
       && ($dir/shar --print-text-domain-dir >/dev/null 2>&1)
    then
      locale_dir=`$dir/shar --print-text-domain-dir`
      set_echo=true
      break
    fi
  done

  if ${set_echo}
  then
    TEXTDOMAINDIR=$locale_dir
    export TEXTDOMAINDIR
    TEXTDOMAIN=sharutils
    export TEXTDOMAIN
    echo="$gettext_dir/gettext -s"
  fi
fi
IFS="$save_IFS"
if (echo "testing\c"; echo 1,2,3) | grep c >/dev/null
then if (echo -n test; echo 1,2,3) | grep n >/dev/null
     then shar_n= shar_c='
'
     else shar_n=-n shar_c= ; fi
else shar_n= shar_c='\c' ; fi
f=shar-touch.$$
st1=200112312359.59
st2=123123592001.59
st2tr=123123592001.5 # old SysV 14-char limit
st3=1231235901

if   touch -am -t ${st1} ${f} >/dev/null 2>&1 && \
     test ! -f ${st1} && test -f ${f}; then
  shar_touch='touch -am -t $1$2$3$4$5$6.$7 "$8"'

elif touch -am ${st2} ${f} >/dev/null 2>&1 && \
     test ! -f ${st2} && test ! -f ${st2tr} && test -f ${f}; then
  shar_touch='touch -am $3$4$5$6$1$2.$7 "$8"'

elif touch -am ${st3} ${f} >/dev/null 2>&1 && \
     test ! -f ${st3} && test -f ${f}; then
  shar_touch='touch -am $3$4$5$6$2 "$8"'

else
  shar_touch=:
  echo
  ${echo} 'WARNING: not restoring timestamps.  Consider getting and
installing GNU '\''touch'\'', distributed in GNU coreutils...'
  echo
fi
rm -f ${st1} ${st2} ${st2tr} ${st3} ${f}
#
if test ! -d ${lock_dir} ; then :
else ${echo} "lock directory ${lock_dir} exists"
     exit 1
fi
if mkdir ${lock_dir}
then ${echo} "x - created lock directory ${lock_dir}."
else ${echo} "x - failed to create lock directory ${lock_dir}."
     exit 1
fi
# ============= config.site ==============
if test -n "${keep_file}" && test -f 'config.site'
then
${echo} "x - SKIPPING config.site (file already exists)"

else
${echo} "x - extracting config.site (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'config.site' &&
# ${HOME}/.local/etc/config.site for configure
#
# Change some defaults.
test "$prefix" = NONE && prefix="${HOME}/.local"
X
# Give Autoconf 2.x generated configure scripts a shared default
# cache file for feature test results, architecture-specific.
if test "$cache_file" = /dev/null; then
X  # A cache file is only valid for one C compiler.
X  if test -z "${CC}"; then
X    CC=gcc
X  fi
X
X  if hash "md5sum" > /dev/null 2>&1; then
X    md5=`echo "CFLAGS='${CFLAGS}' CXXFLAGS='${CXXFLAGS}' LDFLAGS='${LDFLAGS}'" | md5sum | awk '{print $1}'`
X    cache_file="${prefix}/var/config.cache.${CC}.${md5}"
X  fi
fi
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'config.site'
   eval "${shar_touch}") && \
  chmod 0664 'config.site'
if test $? -ne 0
then ${echo} "restore of config.site failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'config.site': 'MD5 check failed'
       ) << \SHAR_EOF
2ed65e831ddaf57e14ca86252615ceb3  config.site
SHAR_EOF

else
test `LC_ALL=C wc -c < 'config.site'` -ne 601 && \
  ${echo} "restoration warning:  size of 'config.site' is not 601"
  fi
fi
# ============= dot_bash_profile ==============
if test -n "${keep_file}" && test -f 'dot_bash_profile'
then
${echo} "x - SKIPPING dot_bash_profile (file already exists)"

else
${echo} "x - extracting dot_bash_profile (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_bash_profile' &&
# .bash_profile executed by bash(1) for login shells.
X
X. ~/.profile
X
if [ -d ~/.local/etc/profile.d ]; then
X    for profile_script in ~/.local/etc/profile.d/*.bash
X    do
X        [ -e "${profile_script}" ] || continue
X        . "${profile_script}"
X    done
fi
X
# Bash reads:
# - .bash_profile for interactive login shells
# - .bashrc for non-login intecactive shells.
#
# source the user's bashrc if it exists
if [ -f ~/.bashrc ]; then
X    . ~/.bashrc
fi
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_bash_profile'
   eval "${shar_touch}") && \
  chmod 0664 'dot_bash_profile'
if test $? -ne 0
then ${echo} "restore of dot_bash_profile failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_bash_profile': 'MD5 check failed'
       ) << \SHAR_EOF
07adf6ac1b41071190ff98bb97223ac1  dot_bash_profile
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_bash_profile'` -ne 455 && \
  ${echo} "restoration warning:  size of 'dot_bash_profile' is not 455"
  fi
fi
# ============= dot_bashrc ==============
if test -n "${keep_file}" && test -f 'dot_bashrc'
then
${echo} "x - SKIPPING dot_bashrc (file already exists)"

else
${echo} "x - extracting dot_bashrc (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_bashrc' &&
# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return
X
# Prompt customization
TPUT=$(which tput)
if [ -t 1 -a -n "${TPUT}" ]; then
X    NCOLORS=$(tput colors)
X    if [ -n "${NCOLORS}" -a "${NCOLORS}" -ge 8 ]; then
X        #BLACK_FG=$(tput setaf 0)
X        RED_FG=$(tput setaf 1)
X        GREEN_FG=$(tput setaf 2)
X        YELLOW_FG=$(tput setaf 3)
X        #BLUE_FG=$(tput setaf 4)
X        MAGENTA_FG=$(tput setaf 5)
X        CYAN_FG=$(tput setaf 6)
X        WHITE_FG=$(tput setaf 7)
X        DEFAULT_FG=$(tput sgr0)
X    fi
fi
X
case "${TERM}" in
X  *xterm* | tmux*)
X    SETXTERMTITLE='\[\e]0;\h - \w\a\]\n';
X    PS1="${SETXTERMTITLE}${PS1}"
X    ;;
esac
if [[ -n "${VIMRUNTIME}" ]]; then
X    VIM_LED="${RED_FG}[vim] "
fi
if [[ -n "${VS_KIT}" ]]; then
X    VS_LED="${CYAN_FG}[msvc ${VS_KIT} ${VS_VERSION:0:2}.${VS_VERSION:2:1}] "
fi
PS1="${SETXTERMTITLE}${VIM_LED}${VS_LED}${GREEN_FG}\\u@\\h ${MAGENTA_FG}\\t ${YELLOW_FG}\\w${DEFAULT_FG}\n\$ "
export PS1
X
# Make bash append rather than overwrite the history on disk
shopt -s histappend
X
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
X
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"
X
# Load bash-completion if available
if [ -f /usr/share/bash-completion/bash_completion ]; then
X    source /usr/share/bash-completion/bash_completion
fi
X
# Following line is usually added by travis gem for bash autocompletion
# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh
X
# Aliases
#
# Some people use a different file for aliases
if [ -f "${HOME}/.bash_aliases" ]; then
X    source "${HOME}/.bash_aliases"
fi
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
X
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
X
# Functions
#
# Some people use a different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
X    source "${HOME}/.bash_functions"
fi
X
# Some example functions:
#
# a) function settitle
settitle ()
{
X    echo -ne "\e]2;$@\a\e]1;$@\a";
}
X
# b) function is_ssh_agent_running
is_ssh_agent_running()
{
X    ps -p "$1" | grep 'ssh-agent$' > /dev/null 2>&1
X    return $?
}
X
# Remote PulseAudio
# -----------------
# export PULSE_SERVER=tcp:localhost:4713
# export SDL_AUDIODRIVER=pulse
X
# SSH-AGENT sourcing
if [ -e ~/.ssh/ssh-agent.pid ]; then
X    source ~/.ssh/ssh-agent.pid > /dev/null 2>&1
fi
if ! is_ssh_agent_running "${SSH_AGENT_PID:-1}"; then
X    ssh-agent > ~/.ssh/ssh-agent.pid 2> /dev/null
X    source ~/.ssh/ssh-agent.pid > /dev/null 2>&1
fi
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_bashrc'
   eval "${shar_touch}") && \
  chmod 0664 'dot_bashrc'
if test $? -ne 0
then ${echo} "restore of dot_bashrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_bashrc': 'MD5 check failed'
       ) << \SHAR_EOF
54ab6629396b8f997b4a616df60a2e5e  dot_bashrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_bashrc'` -ne 3065 && \
  ${echo} "restoration warning:  size of 'dot_bashrc' is not 3065"
  fi
fi
# ============= dot_gdbinit ==============
if test -n "${keep_file}" && test -f 'dot_gdbinit'
then
${echo} "x - SKIPPING dot_gdbinit (file already exists)"

else
${echo} "x - extracting dot_gdbinit (text)"
  sed 's/^X//' << 'SHAR_EOF' | uudecode &&
begin 600 dot_gdbinit
M<'ET:&]N"FEM<&]R="!S>7,*9G)O;2!O<RYP871H(&EM<&]R="!E>'!A;F1U
M<V5R"G-Y<RYP871H+FEN<V5R="@P+"!E>'!A;F1U<V5R*"=^)RDK)R\N;&]C
M86PO<VAA<F4O9V1B+W!Y=&AO;B<I"F9R;VT@;&EB<W1D8WAX+G8V+G!R:6YT
M97)S(&EM<&]R="!R96=I<W1E<E]L:6)S=&1C>'A?<')I;G1E<G,*<F5G:7-T
B97)?;&EB<W1D8WAX7W!R:6YT97)S("A.;VYE*0IE;F0*"G1E
`
end
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_gdbinit'
   eval "${shar_touch}") && \
  chmod 0664 'dot_gdbinit'
if test $? -ne 0
then ${echo} "restore of dot_gdbinit failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_gdbinit': 'MD5 check failed'
       ) << \SHAR_EOF
bcf57111a0ff83ffe9a6ca0be1574280  dot_gdbinit
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_gdbinit'` -ne 214 && \
  ${echo} "restoration warning:  size of 'dot_gdbinit' is not 214"
  fi
fi
# ============= dot_gemrc ==============
if test -n "${keep_file}" && test -f 'dot_gemrc'
then
${echo} "x - SKIPPING dot_gemrc (file already exists)"

else
${echo} "x - extracting dot_gemrc (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_gemrc' &&
gem: --user-install --bindir ~/.local/bin
install: --user-install --bindir ~/.local/bin
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_gemrc'
   eval "${shar_touch}") && \
  chmod 0664 'dot_gemrc'
if test $? -ne 0
then ${echo} "restore of dot_gemrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_gemrc': 'MD5 check failed'
       ) << \SHAR_EOF
41198829c505876f4deb88494421c002  dot_gemrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_gemrc'` -ne 89 && \
  ${echo} "restoration warning:  size of 'dot_gemrc' is not 89"
  fi
fi
# ============= dot_profile ==============
if test -n "${keep_file}" && test -f 'dot_profile'
then
${echo} "x - SKIPPING dot_profile (file already exists)"

else
${echo} "x - extracting dot_profile (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_profile' &&
# .profile executed by sh(1) for login shells.
X
# Save system paths the first time
if [ -z "${SYSTEM_PATH}" ] ; then
X    export SYSTEM_PATH="${PATH}"
X    export SYSTEM_LD_LIBRARY_PATH="${LD_LIBRARY_PATH}"
X    export SYSTEM_MANPATH="${MANPATH}"
X    export SYSTEM_PERL5LIB="${PERL5LIB}"
X    export SYSTEM_PKG_CONFIG_PATH="${PKG_CONFIG_PATH}"
else
X    export PATH="${SYSTEM_PATH}"
X    export LD_LIBRARY_PATH="${SYSTEM_LD_LIBRARY_PATH}"
X    export MANPATH="${SYSTEM_MANPATH}"
X    export PERL5LIB="${SYSTEM_PERL5LIB}"
X    export PKG_CONFIG_PATH="${SYSTEM_PKG_CONFIG_PATH}"
fi
X
if [ -f ~/.path_dirs ]; then
X    while read -r xtrad || [ -n "${xtrad}" ];
X    do
X        if echo "${xtrad}" | grep '^[[:space:]]*\(#.*\)\?$' > /dev/null 2>&1 ; then
X            continue
X        fi
X        # Set PATH so it includes user's private bin if it exists
X        if [ -d "${xtrad}/bin" ]; then
X            PATH="${xtrad}/bin${PATH:+:${PATH}}"
X        fi
X
X        # Set PATH so it includes user's private lib if it exists
X        if [ -d "${xtrad}/lib" ]; then
X            PATH="${xtrad}/lib${PATH:+:${PATH}}"
X            LD_LIBRARY_PATH="${xtrad}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}"
X        fi
X
X        # Set PKG_CONFIG_PATH so it includes user's private if it exists
X        if [ -d "${xtrad}/lib/pkgconfig" ]; then
X            PKG_CONFIG_PATH="${xtrad}/lib/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}"
X        fi
X
X        # Set MANPATH so it includes users' private man if it exists
X        if [ -d "${xtrad}/man" ]; then
X            MANPATH="${xtrad}/man:${MANPATH}"
X        fi
X        if [ -d "${xtrad}/share/man" ]; then
X            MANPATH="${xtrad}/share/man:${MANPATH}"
X        fi
X
X        # Set INFOPATH so it includes users' private info if it exists
X        if [ -d "${xtrad}/info" ]; then
X            INFOPATH="${xtrad}/info${INFOPATH:+:${INFOPATH}}"
X        fi
X
X    done < ~/.path_dirs
fi
X
if [ -O ~/.paths ]; then
X    while read -r xtrad || [ -n "${xtrad}" ];
X    do
X        if echo "${xtrad}" | grep '^[[:space:]]*\(#.*\)\?$' > /dev/null 2>&1 ; then
X            continue
X        fi
X        PATH="${PATH}:${xtrad}"
X    done < ~/.paths
fi
X
export PATH
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH
export MANPATH
export INFOPATH
X
# For nedit bug...
export XLIB_SKIP_ARGB_VISUALS=1
X
if [ -d ~/.local/etc/profile.d ]; then
X    for profile_script in ~/.local/etc/profile.d/*.sh
X    do
X        [ -e "${profile_script}" ] || continue
X        . "${profile_script}"
X    done
fi
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_profile'
   eval "${shar_touch}") && \
  chmod 0664 'dot_profile'
if test $? -ne 0
then ${echo} "restore of dot_profile failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_profile': 'MD5 check failed'
       ) << \SHAR_EOF
a06ac8c065a95711e0c59921981c5353  dot_profile
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_profile'` -ne 2479 && \
  ${echo} "restoration warning:  size of 'dot_profile' is not 2479"
  fi
fi
# ============= dot_tmux_conf ==============
if test -n "${keep_file}" && test -f 'dot_tmux_conf'
then
${echo} "x - SKIPPING dot_tmux_conf (file already exists)"

else
${echo} "x - extracting dot_tmux_conf (text)"
  sed 's/^X//' << 'SHAR_EOF' | uudecode &&
begin 600 dot_tmux_conf
M(R`M+2T@9V5N97)A;"`M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"G-E="`M9R!D969A=6QT+71E<FUI
M;F%L(")T;75X+3(U-F-O;&]R(@IS971W("UG('AT97)M+6ME>7,@;VX*<V5T
M("UG('-E="UC;&EP8F]A<F0@;VX*<V5T=R`M9R!M;V1E+6ME>7,@=FD*<V5T
M("US(&9O8W5S+65V96YT<R!O;@H*<V5T=R`M<2`M9R!U=&8X(&]N"@HC(&,P
M+6-H86YG92UI;G1E<G9A;"!I;G1E<G9A;"`C('!R979E;G1S(&9L;V]D:6YG
M('1O(&)R96%K($-T<FPK0PHC(&,P+6-H86YG92UT<FEG9V5R('1R:6=G97(@
M("`C"@HC("TM+2!D:7-P;&%Y("TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*<V5T("UG(&)A<V4M:6YD
M97@@,2`@("`@("`@(",@<W1A<G0@=VEN9&]W(&YU;6)E<FEN9R!A="`Q"G-E
M='<@+6<@<&%N92UB87-E+6EN9&5X(#$@("`C('-T87)T('!A;F4@;G5M8F5R
M:6YG(&%T(#$*"G-E='<@+6<@875T;VUA=&EC+7)E;F%M92!O;B`C(')E;F%M
M92!W:6YD;W<@=&\@8W5R<F5N="!P<F]G<F%M"G-E="`M9R!R96YU;6)E<BUW
M:6YD;W=S(&]N("`C(')E;F%M92!W:6YD;W<@=VAE;B!W:6YD;W<@:7,@8VQO
M<V5D"@IS970@+6<@<V5T+71I=&QE<R!O;B`@("`@("`@(R!S970@=&5R;6EN
M86P@=&ET;&4*<V5T("UG('-E="UT:71L97,M<W1R:6YG("<C:"`@("-3("`@
M(TD@(U<G"@IS970@+6<@9&ES<&QA>2UP86YE<RUT:6UE(#@P,"`C(&QO;F=E
M<B!P86YE(&EN9&EC871O<B!D:7-P;&%Y('1I;64*<V5T("UG(&1I<W!L87DM
M=&EM92`Q,#`P("`@("`@(R!L;VYG97(@<W1A='5S(&EN9&EC871O<B!D:7-P
M;&%Y('1I;64*<V5T("UG('-T871U<RUI;G1E<G9A;"`Q,"`@("`@(R!R969R
M97-H('-T871U<R!E=F5R>2`Q,"!S96-O;F1S"@HC(&%C=&EV:71Y"G-E="`M
M9R!M;VYI=&]R+6%C=&EV:71Y(&]N"G-E="`M9R!V:7-U86PM86-T:79I='D@
M;V9F"@HC("TM+2!S=&%T=7,@=&AE;64@+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*<V5T("UG(&UE<W-A9V4M
M8V]M;6%N9"UF9R`G8V]L;W5R,C(R)PIS970@+6<@;65S<V%G92UB9R`G8V]L
M;W5R,C,X)PIS970@+6<@;65S<V%G92UF9R`G8V]L;W5R,C(R)PIS970@+6<@
M;65S<V%G92UC;VUM86YD+6)G("=C;VQO=7(R,S@G"@IS970@+6<@<&%N92UA
M8W1I=F4M8F]R9&5R+69G("=C;VQO=7(Q-30G"G-E="`M9R!P86YE+6)O<F1E
M<BUF9R`G8V]L;W5R,C,X)PH*<V5T("UG('-T871U<RUB9R`G8V]L;W5R,C,U
M)PIS970@+6<@<W1A='5S+6IU<W1I9GD@)V-E;G1R92<*<V5T("UG('-T871U
M<RUL969T+6QE;F=T:"`G,3`P)PIS970@+6<@<W1A='5S("=O;B<*<V5T("UG
M('-T871U<RUR:6=H="UL96YG=&@@)S$P,"<*<V5T("UG('-T871U<RUR:6=H
M="UA='1R("=N;VYE)PIS970@+6<@<W1A='5S+6%T='(@)VYO;F4G"G-E="`M
M9R!S=&%T=7,M;&5F="UA='1R("=N;VYE)PH*<V5T=R`M9R!W:6YD;W<M<W1A
M='5S+69G("=C;VQO=7(Q,C$G"G-E='<@+6<@=VEN9&]W+7-T871U<RUA='1R
M("=N;VYE)PIS971W("UG('=I;F1O=RUS=&%T=7,M86-T:79I='DM8F<@)V-O
M;&]U<C(S-2<*<V5T=R`M9R!W:6YD;W<M<W1A='5S+6%C=&EV:71Y+6%T='(@
M)VYO;F4G"G-E='<@+6<@=VEN9&]W+7-T871U<RUA8W1I=FET>2UF9R`G8V]L
M;W5R,34T)PIS971W("UG('=I;F1O=RUS=&%T=7,M<V5P87)A=&]R("<G"G-E
M='<@+6<@=VEN9&]W+7-T871U<RUB9R`G8V]L;W5R,C,U)PH*<V5T("UG("!S
M=&%T=7,M;&5F="`G(UMF9SUC;VQO=7(R,S(L8F<]8V]L;W5R,34T7>^#J"`C
M4R<@(R!S97-S:6]N(&YA;64*<V5T("UG82!S=&%T=7,M;&5F="`G(UMF9SUC
M;VQO=7(Q-30L8F<]8V]L;W5R,C,X+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I
M=&%L:6-S7>Z"N"<*<V5T("UG82!S=&%T=7,M;&5F="`G(UMF9SUC;VQO<C(R
M,BQB9SUC;VQO=7(R,SA=[XFL("-7)R`C('=I;F1O=R!N86UE"G-E="`M9V$@
M<W1A='5S+6QE9G0@)R-;9F<]8V]L;W5R,C,X+&)G/6-O;&]U<C(S-2QN;V)O
M;&0L;F]U;F1E<G-C;W)E+&YO:71A;&EC<UWN@K@G"G-E="`M9V$@<W1A='5S
M+6QE9G0@)R-;9F<]8V]L;W5R,C(R+&)G/6-O;&]U<C(S-5WO@(<@(RAW:&]A
M;6DI)R`C('=I;F1O=R!N86UE"G-E="`M9V$@<W1A='5S+6QE9G0@)R-;9F<]
M8V]L;W5R,C,U+&)G/6-O;&]U<C(S-2QN;V)O;&0L;F]U;F1E<G-C;W)E+&YO
M:71A;&EC<UWN@K@G"@IS970@+6<@('-T871U<RUR:6=H="`G(UMF9SUC;VQO
M=7(R,S4L8F<]8V]L;W5R,C,U+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L
M:6-S7>Z"NB<*<V5T("UG82!S=&%T=7,M<FEG:'0@)R-;9F<]8V]L;W5R,3(Q
M+&)G/6-O;&]U<C(S-5WOF8\@)5(G(",@:&]U<BP@9&%Y+"!Y96%R"G-E="`M
M9V$@<W1A='5S+7)I9VAT("<C6V9G/6-O;&]U<C(S."QB9SUC;VQO=7(R,S4L
M;F]B;VQD+&YO=6YD97)S8V]R92QN;VET86QI8W-=[H*Z)PIS970@+6=A('-T
M871U<RUR:6=H="`G(UMF9SUC;VQO=7(R,C(L8F<]8V]L;W5R,C,X7>^1LR`C
M2"<@(R!H;W-T;F%M90H*<V5T=R`M9R`@=VEN9&]W+7-T871U<RUF;W)M870@
M)R-;9F<]8V]L;W5R,C,X7>Z"NB<*<V5T=R`M9V$@=VEN9&]W+7-T871U<RUF
M;W)M870@)R-;9F<]8V]L;W5R,C(R+&)G/6-O;&]U<C(S.%TC22`C5R<*<V5T
M=R`M9V$@=VEN9&]W+7-T871U<RUF;W)M870@)R-;9F<]8V]L;W5R,C,X+&)G
M/6-O;&]U<C(S-5WN@K@G"G-E='<@+6=A('=I;F1O=RUS=&%T=7,M9F]R;6%T
M("<C6VYO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S72<*"G-E='<@+6<@
M('=I;F1O=RUS=&%T=7,M8W5R<F5N="UF;W)M870@)R-;9F<]8V]L;W5R,34T
M7>Z"NB<*<V5T=R`M9V$@=VEN9&]W+7-T871U<RUC=7)R96YT+69O<FUA="`G
M(UMF9SUC;VQO=7(R,S(L8F<]8V]L;W5R,34T72-)("-7(T8G"G-E='<@+6=A
M('=I;F1O=RUS=&%T=7,M8W5R<F5N="UF;W)M870@)R-;9F<]8V]L;W5R,34T
M+&)G/6-O;&]U<C(S-5WN@K@G"G-E='<@+6=A('=I;F1O=RUS=&%T=7,M8W5R
M<F5N="UF;W)M870@)R-;9F<]8V]L;W5R,C,X+&)G/6-O;&]U<C(S-2QN;V)O
>;&0L;F]U;F1E<G-C;W)E+&YO:71A;&EC<UTG"@H*
`
end
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_tmux_conf'
   eval "${shar_touch}") && \
  chmod 0664 'dot_tmux_conf'
if test $? -ne 0
then ${echo} "restore of dot_tmux_conf failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_tmux_conf': 'MD5 check failed'
       ) << \SHAR_EOF
fc362a37911ce04a0f3335f143f5d7a0  dot_tmux_conf
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_tmux_conf'` -ne 3135 && \
  ${echo} "restoration warning:  size of 'dot_tmux_conf' is not 3135"
  fi
fi
# ============= dot_tmux_3_conf ==============
if test -n "${keep_file}" && test -f 'dot_tmux_3_conf'
then
${echo} "x - SKIPPING dot_tmux_3_conf (file already exists)"

else
${echo} "x - extracting dot_tmux_3_conf (text)"
  sed 's/^X//' << 'SHAR_EOF' | uudecode &&
begin 600 dot_tmux_3_conf
M(R`M+2T@9V5N97)A;"`M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM"G-E="`M9R!D969A=6QT+71E<FUI
M;F%L(")T;75X+3(U-F-O;&]R(@IS971W("UG('AT97)M+6ME>7,@;VX*<V5T
M("UG('-E="UC;&EP8F]A<F0@;VX*<V5T=R`M9R!M;V1E+6ME>7,@=FD*<V5T
M("US(&9O8W5S+65V96YT<R!O;@H*<V5T=R`M<2`M9R!U=&8X(&]N"@HC(&,P
M+6-H86YG92UI;G1E<G9A;"!I;G1E<G9A;"`C('!R979E;G1S(&9L;V]D:6YG
M('1O(&)R96%K($-T<FPK0PHC(&,P+6-H86YG92UT<FEG9V5R('1R:6=G97(@
M("`C"@HC("TM+2!D:7-P;&%Y("TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*<V5T("UG(&)A<V4M:6YD
M97@@,2`@("`@("`@(",@<W1A<G0@=VEN9&]W(&YU;6)E<FEN9R!A="`Q"G-E
M='<@+6<@<&%N92UB87-E+6EN9&5X(#$@("`C('-T87)T('!A;F4@;G5M8F5R
M:6YG(&%T(#$*"G-E='<@+6<@875T;VUA=&EC+7)E;F%M92!O;B`C(')E;F%M
M92!W:6YD;W<@=&\@8W5R<F5N="!P<F]G<F%M"G-E="`M9R!R96YU;6)E<BUW
M:6YD;W=S(&]N("`C(')E;F%M92!W:6YD;W<@=VAE;B!W:6YD;W<@:7,@8VQO
M<V5D"@IS970@+6<@<V5T+71I=&QE<R!O;B`@("`@("`@(R!S970@=&5R;6EN
M86P@=&ET;&4*<V5T("UG('-E="UT:71L97,M<W1R:6YG("<C:"`@("-3("`@
M(TD@(U<G"@IS970@+6<@9&ES<&QA>2UP86YE<RUT:6UE(#@P,"`C(&QO;F=E
M<B!P86YE(&EN9&EC871O<B!D:7-P;&%Y('1I;64*<V5T("UG(&1I<W!L87DM
M=&EM92`Q,#`P("`@("`@(R!L;VYG97(@<W1A='5S(&EN9&EC871O<B!D:7-P
M;&%Y('1I;64*<V5T("UG('-T871U<RUI;G1E<G9A;"`Q,"`@("`@(R!R969R
M97-H('-T871U<R!E=F5R>2`Q,"!S96-O;F1S"@HC(&%C=&EV:71Y"G-E="`M
M9R!M;VYI=&]R+6%C=&EV:71Y(&]N"G-E="`M9R!V:7-U86PM86-T:79I='D@
M;V9F"@HC("TM+2!S=&%T=7,@=&AE;64@+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2T*<V5T("UG(&UE<W-A9V4M
M8V]M;6%N9"US='EL92!F9STG8V]L;W5R,C(R)RQB9STG8V]L;W5R,C,X)PIS
M970@+6<@;65S<V%G92US='EL92`@("`@("`@(&9G/2=C;VQO=7(R,C(G+&)G
M/2=C;VQO=7(R,S@G"@IS970@+6<@<&%N92UA8W1I=F4M8F]R9&5R+7-T>6QE
M(&9G/2=C;VQO=7(Q-30G"G-E="`M9R!P86YE+6)O<F1E<BUS='EL92`@("`@
M("`@9F<])V-O;&]U<C(S."<*"G-E="`M9R!S=&%T=7,M<W1Y;&4@("`@("`@
M(&)G/2=C;VQO=7(R,S4G+"=N;VYE)PIS970@+6<@<W1A='5S+6IU<W1I9GD@
M("`@("`G8V5N=')E)PIS970@+6<@<W1A='5S+6QE9G0M;&5N9W1H("`G,3`P
M)PIS970@+6<@<W1A='5S+6QE9G0M<W1Y;&4@("`G;F]N92<*<V5T("UG('-T
M871U<RUR:6=H="UL96YG=&@@)S$P,"<*<V5T("UG('-T871U<RUR:6=H="US
M='EL92`@)VYO;F4G"G-E="`M9R!S=&%T=7,@("`@("`@("`@("`@("=O;B<*
M"G-E='<@+6<@=VEN9&]W+7-T871U<RUS='EL92!F9STG8V]L;W5R,3(Q)RQB
M9STG8V]L;W5R,C,U)RPG;F]N92<*"G-E='<@+6<@=VEN9&]W+7-T871U<RUA
M8W1I=FET>2US='EL92!F9STG8V]L;W5R,34T)RQB9STG8V]L;W5R,C,U)RPG
M;F]N92<*<V5T=R`M9R!W:6YD;W<M<W1A='5S+7-E<&%R871O<B`G)PH*<V5T
M("UG("!S=&%T=7,M;&5F="`G(UMF9SUC;VQO=7(R,S(L8F<]8V]L;W5R,34T
M7>^#J"`C4R<@(R!S97-S:6]N(&YA;64*<V5T("UG82!S=&%T=7,M;&5F="`G
M(UMF9SUC;VQO=7(Q-30L8F<]8V]L;W5R,C,X+&YO8F]L9"QN;W5N9&5R<V-O
M<F4L;F]I=&%L:6-S7>Z"N"<*<V5T("UG82!S=&%T=7,M;&5F="`G(UMF9SUC
M;VQO<C(R,BQB9SUC;VQO=7(R,SA=[XFL("-7)R`C('=I;F1O=R!N86UE"G-E
M="`M9V$@<W1A='5S+6QE9G0@)R-;9F<]8V]L;W5R,C,X+&)G/6-O;&]U<C(S
M-2QN;V)O;&0L;F]U;F1E<G-C;W)E+&YO:71A;&EC<UWN@K@G"G-E="`M9V$@
M<W1A='5S+6QE9G0@)R-;9F<]8V]L;W5R,C(R+&)G/6-O;&]U<C(S-5WO@(<@
M(RAW:&]A;6DI)R`C('=I;F1O=R!N86UE"G-E="`M9V$@<W1A='5S+6QE9G0@
M)R-;9F<]8V]L;W5R,C,U+&)G/6-O;&]U<C(S-2QN;V)O;&0L;F]U;F1E<G-C
M;W)E+&YO:71A;&EC<UWN@K@G"@IS970@+6<@('-T871U<RUR:6=H="`G(UMF
M9SUC;VQO=7(R,S4L8F<]8V]L;W5R,C,U+&YO8F]L9"QN;W5N9&5R<V-O<F4L
M;F]I=&%L:6-S7>Z"NB<*<V5T("UG82!S=&%T=7,M<FEG:'0@)R-;9F<]8V]L
M;W5R,3(Q+&)G/6-O;&]U<C(S-5WOF8\@)5(G(",@:&]U<BP@9&%Y+"!Y96%R
M"G-E="`M9V$@<W1A='5S+7)I9VAT("<C6V9G/6-O;&]U<C(S."QB9SUC;VQO
M=7(R,S4L;F]B;VQD+&YO=6YD97)S8V]R92QN;VET86QI8W-=[H*Z)PIS970@
M+6=A('-T871U<RUR:6=H="`G(UMF9SUC;VQO=7(R,C(L8F<]8V]L;W5R,C,X
M7>^1LR`C2"<@(R!H;W-T;F%M90H*<V5T=R`M9R`@=VEN9&]W+7-T871U<RUF
M;W)M870@)R-;9F<]8V]L;W5R,C,X7>Z"NB<*<V5T=R`M9V$@=VEN9&]W+7-T
M871U<RUF;W)M870@)R-;9F<]8V]L;W5R,C(R+&)G/6-O;&]U<C(S.%TC22`C
M5R<*<V5T=R`M9V$@=VEN9&]W+7-T871U<RUF;W)M870@)R-;9F<]8V]L;W5R
M,C,X+&)G/6-O;&]U<C(S-5WN@K@G"G-E='<@+6=A('=I;F1O=RUS=&%T=7,M
M9F]R;6%T("<C6VYO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S72<*"G-E
M='<@+6<@('=I;F1O=RUS=&%T=7,M8W5R<F5N="UF;W)M870@)R-;9F<]8V]L
M;W5R,34T7>Z"NB<*<V5T=R`M9V$@=VEN9&]W+7-T871U<RUC=7)R96YT+69O
M<FUA="`G(UMF9SUC;VQO=7(R,S(L8F<]8V]L;W5R,34T72-)("-7(T8G"G-E
M='<@+6=A('=I;F1O=RUS=&%T=7,M8W5R<F5N="UF;W)M870@)R-;9F<]8V]L
M;W5R,34T+&)G/6-O;&]U<C(S-5WN@K@G"G-E='<@+6=A('=I;F1O=RUS=&%T
M=7,M8W5R<F5N="UF;W)M870@)R-;9F<]8V]L;W5R,C,X+&)G/6-O;&]U<C(S
D-2QN;V)O;&0L;F]U;F1E<G-C;W)E+&YO:71A;&EC<UTG"@H*
`
end
SHAR_EOF
  (set 20 20 08 08 09 30 38 'dot_tmux_3_conf'
   eval "${shar_touch}") && \
  chmod 0644 'dot_tmux_3_conf'
if test $? -ne 0
then ${echo} "restore of dot_tmux_3_conf failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_tmux_3_conf': 'MD5 check failed'
       ) << \SHAR_EOF
7bfcd249b498819800d5e6dcbdcaa65e  dot_tmux_3_conf
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_tmux_3_conf'` -ne 3051 && \
  ${echo} "restoration warning:  size of 'dot_tmux_3_conf' is not 3051"
  fi
fi
# ============= dot_vimrc ==============
if test -n "${keep_file}" && test -f 'dot_vimrc'
then
${echo} "x - SKIPPING dot_vimrc (file already exists)"

else
${echo} "x - extracting dot_vimrc (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_vimrc' &&
" In case usual windows move command doesn't work
" :nmap <silent> <A-Up> :wincmd k<CR>
" :nmap <silent> <A-Down> :wincmd j<CR>
" :nmap <silent> <A-Left> :wincmd h<CR>
" :nmap <silent> <A-Right> :wincmd l<CR>
X
" Highligth characters after 80th columns
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
X
" Use explorer in tree mode
let g:netrw_liststyle=3
X
" Use soft tabs, size 4
set tabstop=4 shiftwidth=4 expandtab
X
" Auto indent file
autocmd FileType *      set formatoptions=tcql nocindent comments&
autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,ex:*/,://
set autoindent
X
" Highlight searched targets
set hlsearch
X
" Show line numbers
set number
X
" Encoding utf8
set encoding=utf8
X
" Block cursor
let &t_SI.="\e[1 q"
let &t_EI.="\e[1 q"
let &t_ti.="\e[1 q"
let &t_te.="\e[1 q"
X
" Show cursor line
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white
set cursorline
nnoremap <Leader>c :set cursorcolumn!
X
set nocompatible              " be iMproved, required
filetype off                  " required
X
call plug#begin()
" Code/project navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'majutsushi/tagbar'          	" Class/module browser
"Plug 'ervandew/supertab'
"Plug 'BufOnly.vim'
"Plug 'wesQ3/vim-windowswap'
"Plug 'SirVer/ultisnips'
"Plug 'junegunn/fzf.vim'
"Plug 'junegunn/fzf'
Plug 'godlygeek/tabular'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'benmills/vimux'
"Plug 'jeetsukumaran/vim-buffergator'
"Plug 'gilsondev/searchtasks.vim'
"Plug 'tpope/vim-dispatch'
X
" Programming
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'honza/vim-snippets'
"Plug 'Townk/vim-autoclose'
"Plug 'vim-syntastic/syntastic'
"Plug 'neomake/neomake'
if has('nvim')
X  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugs' }
else
X  Plug 'Shougo/deoplete.nvim'
X  Plug 'roxma/nvim-yarp'
X  Plug 'roxma/vim-hug-neovim-rpc'
endif
"let g:deoplete#enable_at_startup = 1
X
" Markdown / Writting
"Plug 'reedes/vim-pencil'
Plug 'vim-pandoc/vim-pandoc'
"Plug 'LanguageTool'
X
" Theming
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'   	" Lean & mean status/tabline for vim
Plug 'vim-airline/vim-airline-themes'
"Plug 'fisadev/FixedTaskList.vim'  	" Pending tasks list
Plug 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
"Plug 'ctags.vim'
X
" language support
"Plug 'elixir-lang/vim-elixir'
"Plug 'leafgarland/typescript-vim'
X
" solarized color theme
Plug 'altercation/vim-colors-solarized'
X
" Git support
Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
X
" Abolish (completion, typo fixes, casing)
Plug 'tpope/vim-abolish'
X
" Repeat (repeat plugin commands)
"Plug 'tpope/vim-repeat'
X
" Project support
Plug 'vim-scripts/project.tar.gz'
X
" Scratch buffer
"Plug 'vim-scripts/scratch.vim'
X
" All of your Plugins must be added before the following line
call plug#end()
X
filetype plugin indent on
X
syntax on
set ruler
X
" autocmd vimenter * TagbarToggle
" autocmd vimenter * NERDTree
" autocmd vimenter * if !argc() | NERDTree | endif
X
" Set solarized color theme
let g:solarized_termcolors=256
set background=light
colorscheme solarized
X
set nu
set nobackup
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
X
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
set ttimeoutlen=10
X
map <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 0
X
map <F3> :NERDTreeToggle<CR>
X
" Disable syntastic by default
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
" nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>
X
" copy the current text selection to the system clipboard
if has('gui_running') || has('nvim') && exists('$DISPLAY')
X  noremap <Leader>y "+y
else
X  " copy to attached terminal using the yank(1) script:
X  noremap <silent> <Leader>y y:call system('yank', @0)<Return>
endif
X
hi Terminal ctermbg=black ctermfg=white
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_vimrc'
   eval "${shar_touch}") && \
  chmod 0664 'dot_vimrc'
if test $? -ne 0
then ${echo} "restore of dot_vimrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_vimrc': 'MD5 check failed'
       ) << \SHAR_EOF
b114051c239d372194af4c2e122a0611  dot_vimrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_vimrc'` -ne 4114 && \
  ${echo} "restoration warning:  size of 'dot_vimrc' is not 4114"
  fi
fi
# ============= dot_xprofile ==============
if test -n "${keep_file}" && test -f 'dot_xprofile'
then
${echo} "x - SKIPPING dot_xprofile (file already exists)"

else
${echo} "x - extracting dot_xprofile (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_xprofile' &&
#!/usr/bin/env bash
X
# Some (most) session managers like 'gdm' pass the '-no-cppp' option to 'xrdb'
# which causes our .Xresources.user file to not be loaded.
#
# Our solution is to explicitly merge our .Xresources file in .xprofile which
# is (still) respected by these session managers.
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_xprofile'
   eval "${shar_touch}") && \
  chmod 0775 'dot_xprofile'
if test $? -ne 0
then ${echo} "restore of dot_xprofile failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_xprofile': 'MD5 check failed'
       ) << \SHAR_EOF
b1e407df92b42487a43fde948050e652  dot_xprofile
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_xprofile'` -ne 340 && \
  ${echo} "restoration warning:  size of 'dot_xprofile' is not 340"
  fi
fi
# ============= dot_Xresources ==============
if test -n "${keep_file}" && test -f 'dot_Xresources'
then
${echo} "x - SKIPPING dot_Xresources (file already exists)"

else
${echo} "x - extracting dot_Xresources (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_Xresources' &&
#include ".Xresources.user"
X
XXTerm*eightBitInput: true
XXTerm*metaSendsEscape: true
XXTerm*renderFont: true
XXTerm*termName: xterm-256color
XXTerm*utf8Fonts: true
XXTerm*utf8Title: true
! Contrary to what the statement looks like, it is enabling the SetSelection
! window operation. The default value is: 20,21,SetXprop,SetSelection
XXTerm*disallowedWindowOps: 20,21,SetXprop
XXTerm*vt100.initialFont: 3
! Fix for the infamous Ctrl+H issue
! see: http://www.hypexr.org/linux_ruboff.php
XXTerm*ttyModes:         erase ^?
XXTerm*VT100.Translations: \
X  #override <Key>BackSpace: string(0x7f) \n\
X            <Key>Delete:    string(0x1b) string("[3~")
X
!XTerm*dynamicColors: true
!XTerm*backarrowKey: false
!XTerm*backarrowKeyIsErase: true
X
! Sixel enabling with more than 16 colors
XXTerm*decTerminalID: vt340
XXTerm*numColorRegisters: 256
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_Xresources'
   eval "${shar_touch}") && \
  chmod 0664 'dot_Xresources'
if test $? -ne 0
then ${echo} "restore of dot_Xresources failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_Xresources': 'MD5 check failed'
       ) << \SHAR_EOF
c0260819dea21ffbc0ce69f179808a75  dot_Xresources
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_Xresources'` -ne 828 && \
  ${echo} "restoration warning:  size of 'dot_Xresources' is not 828"
  fi
fi
# ============= dot_Xresources_user ==============
if test -n "${keep_file}" && test -f 'dot_Xresources_user'
then
${echo} "x - SKIPPING dot_Xresources_user (file already exists)"

else
${echo} "x - extracting dot_Xresources_user (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_Xresources_user' &&
! This file is preprocessed by 'cpp' which defines the following macros:
! X_RESOLUTION: the X resolution of the screen in pixel per meter
! Y_RESOLUTION: the Y resolution of the screen in pixel per meter
!
! By running `xrdb -symbols` we can inspect these macros for the current X
! session.
!
! We can use these macros to define the font face size of our XTerm.
#define XTERM_FACE_SIZE_MULTIPLE ((Y_RESOLUTION+3775)/3776)
X
XXTerm*faceName: DejaVuSansMono Nerd Font Mono
#if XTERM_FACE_SIZE_MULTIPLE == 1
XXTerm*faceSize: 14
#endif
#if XTERM_FACE_SIZE_MULTIPLE == 2
XXTerm*faceSize: 24
#endif
#if XTERM_FACE_SIZE_MULTIPLE >= 3
XXTerm*faceSize: 36
#endif
XXTerm*reverseVideo: false
XXTerm*foreground: white
XXTerm*background: black
XXTerm*rightScrollBar: true
XXTerm*scrollBar: true
XXTerm*toolBar: false
XXTerm*utf8: 2
XXTerm*visualBell: true
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_Xresources_user'
   eval "${shar_touch}") && \
  chmod 0664 'dot_Xresources_user'
if test $? -ne 0
then ${echo} "restore of dot_Xresources_user failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_Xresources_user': 'MD5 check failed'
       ) << \SHAR_EOF
e8970ffffd426e18f1287b1b6a1ea0e2  dot_Xresources_user
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_Xresources_user'` -ne 832 && \
  ${echo} "restoration warning:  size of 'dot_Xresources_user' is not 832"
  fi
fi
# ============= dot_XWinrc ==============
if test -n "${keep_file}" && test -f 'dot_XWinrc'
then
${echo} "x - SKIPPING dot_XWinrc (file already exists)"

else
${echo} "x - extracting dot_XWinrc (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_XWinrc' &&
# XWin Server Resource File - EXAMPLE
# Earle F. Philhower, III
X
# Place in ~/.XWinrc or in /etc/X11/system.XWinrc
X
# Keywords are case insensitive, comments legal pretty much anywhere
# you can have an end-of-line
X
# Comments begin with "#" or "//" and go to the end-of-line
X
# Paths to commands are **cygwin** based (i.e. /usr/local/bin/xcalc)
X
# Paths to icons are **WINDOWS** based (i.e. c:\windows\icons)
X
# Menus are defined as...
# MENU <name> {
#	<Menu Text>	EXEC	<command>
#                               ^^ This command will have any "%display%"
#                                  string replaced with the proper display
#                                  variable (i.e. 127.0.0.1:<display>.0)
#                                  (This should only rarely be needed as
#                                  the DISPLAY environment variable is also
#                                  set correctly)
#  or	<Menu Text>	MENU	<name-of-some-prior-defined-menu>
#  or	<Menu Text>	ALWAYSONTOP
#                         ^^ Sets the window to display above all others
#  or   <Menu Text>	RELOAD
#                         ^^ Causes ~/.XWinrc or the system.XWinrc file
#                            to be reloaded and icons and menus regenerated
#  or	SEPARATOR
#       ...
# }
X
# Set the taskmar menu with
# ROOTMENU <name-of-some-prior-defined-menu>
X
# If you want a menu to be applied to all popup window's system menu
# DEFAULTSYSMENU <name-of-some-prior-defined-menu> <atstart|atend>
X
# To choose a specific menu for a specific WM_CLASS or WM_NAME use ...
# SYSMENU {
#	<class-or-name-of-window> <name-of-prior-defined-menu> <atstart|atend>
#	...
# }
X
# When specifying an ICONFILE in the following commands several different
# formats are allowed:
# 1. Name of a regular Windows .ico format file
#    (ex:  "cygwin.ico", "apple.ico")
# 2. Name and index into a Windows .DLL
#    (ex: "c:\windows\system32\shell32.dll,4" gives the default folder icon
#         "c:\windows\system32\shell32.dll,5" gives the floppy drive icon)
# 3. Index into XWin.EXE internal ICON resource
#    (ex: ",101" is the 1st icon inside XWin.exe)
X
# To define where ICO files live (** Windows path**)
# ICONDIRECTORY	<windows-path i.e. c:\cygwin\usr\icons>
# NOTE: If you specify a fully qualified path to an ICON below
#             (i.e. "c:\xxx" or "d:\xxxx")
#       this ICONDIRECTORY will not be prepended
X
# To change the taskbar icon use...
# TRAYICON       <name-of-windows-ico-file-in-icondirectory>
X
# To define a replacement for the standard X icon for apps w/o specified icons
# DEFAULTICON	<name-of-windows-ico-file-in-icondirectory>
X
# To define substitute icons on a per-window basis use...
# ICONS {
#	<class-or-name-of-window> <icon-file-name.ico>
#	...
# }
# In the case where multiple matches occur, the first listed in the ICONS
# section will be chosen.
X
# To disable exit confirmation dialog add the line containing SilentExit
X
# DEBUG <string> prints out the string to the XWin.log file
X
// Below are just some silly menus to demonstrate writing your
// own configuration file.
X
// Make some menus...
menu apps {
X	xterm	exec	"xterm"
X	"Emacs"	exec	"xterm -e emacs -nw"
X	notepad	exec	notepad
X	xload	exec	"xload -display %display%"  # Comment
}
X
menu root {
X        "xterm"         exec    "xterm"
X	SEPARATOR
X	"Applications"	menu	apps
// Comments fit here, too...
X
//	SEPARATOR
//	FAQ            EXEC "cygstart http://x.cygwin.com/docs/faq/cygwin-x-faq.html"
//	"User's Guide" EXEC "cygstart http://x.cygwin.com/docs/ug/cygwin-x-ug.html"
X	SEPARATOR
X	"View logfile" EXEC "xterm -e less +F $XWINLOGFILE"
X	SEPARATOR
X
X	"Reload .XWinrc"	RELOAD
X	SEPARATOR
}
X
menu aot {
X	Separator
X	"Always on Top"	alwaysontop
}
X
menu xtermspecial {
X        "XTerm" exec "xterm"
X	"Emacs"		exec	"xterm -e emacs -nw"
X	"Always on Top"	alwaysontop
X	SepArAtor
}
X
RootMenu root
X
DefaultSysMenu aot atend
X
SysMenu {
X	"xterm"	xtermspecial atstart
}
X
# IconDirectory	"c:\winnt\"
X
# DefaultIcon	"reinstall.ico"
X
# Icons {
# 	"xterm"	"uninstall.ico"
# }
X
SilentExit
X
DEBUG "Done parsing the configuration file..."
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'dot_XWinrc'
   eval "${shar_touch}") && \
  chmod 0664 'dot_XWinrc'
if test $? -ne 0
then ${echo} "restore of dot_XWinrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_XWinrc': 'MD5 check failed'
       ) << \SHAR_EOF
061681de2263a9bb820392d2cbe1faaa  dot_XWinrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_XWinrc'` -ne 4076 && \
  ${echo} "restoration warning:  size of 'dot_XWinrc' is not 4076"
  fi
fi
# ============= ibase.sh ==============
if test -n "${keep_file}" && test -f 'ibase.sh'
then
${echo} "x - SKIPPING ibase.sh (file already exists)"

else
${echo} "x - extracting ibase.sh (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'ibase.sh' &&
IBASE="${HOME}/.local/share/ibase"
export IBASE
X
PATH="${PATH}:${IBASE}/bin"
export PATH
X
BOOM_MODEL=debug,st
export BOOM_MODEL
X
PERL5LIB="${PERL5LIB}${PERL5LIB:+:}${IBASE}/bin"
export PERL5LIB
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'ibase.sh'
   eval "${shar_touch}") && \
  chmod 0664 'ibase.sh'
if test $? -ne 0
then ${echo} "restore of ibase.sh failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'ibase.sh': 'MD5 check failed'
       ) << \SHAR_EOF
d7655864afb771c844870b3c7baf897c  ibase.sh
SHAR_EOF

else
test `LC_ALL=C wc -c < 'ibase.sh'` -ne 195 && \
  ${echo} "restoration warning:  size of 'ibase.sh' is not 195"
  fi
fi
# ============= scripts/byzanz-helper ==============
if test ! -d 'scripts'; then
  mkdir 'scripts'
if test $? -eq 0
then ${echo} "x - created directory scripts."
else ${echo} "x - failed to create directory scripts."
     exit 1
fi
fi
if test -n "${keep_file}" && test -f 'scripts/byzanz-helper'
then
${echo} "x - SKIPPING scripts/byzanz-helper (file already exists)"

else
${echo} "x - extracting scripts/byzanz-helper (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/byzanz-helper' &&
#!/usr/bin/env perl
X
use 5.008000;
use strict;
use warnings 'all';
X
use Carp;
use Cwd;
use File::Basename;
use File::Temp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use Pod::Usage;
X
X
# Parse options
my ($opt_help, $opt_t, $opt_o);
GetOptionsFromArray(
X    \@ARGV,
X    'help|h'       => \$opt_help,
X    't|duration=s' => \$opt_t,
X    'o|output=s'   => \$opt_o,
) or croak('Error parsing command line arguments');
X
# Handle help option
pod2usage(-exitval => 0) if ($opt_help);
X
if(!defined($opt_o) || $opt_o eq '') {
X    print STDERR "Option '-o' or '--output' is mandatory\n";
X    pod2usage(-exitval => 1);
}
X
# Default option values
$opt_t //= 30;
X
# Get the recorded window parameters
my $xwin_info = `xwininfo`;
croak('Error getting X-Window information') if($?);
X
my ($x, $y, $width, $height);
$xwin_info =~ m/Absolute upper-left X:\s*(\d+)/g;
$x = $1;
$xwin_info =~ m/Absolute upper-left Y:\s*(\d+)/g;
$y = $1;
$xwin_info =~ m/Width:\s*(\d+)/g;
$width = $1;
$xwin_info =~ m/Height:\s*(\d+)/g;
$height = $1;
X
print "Recording area: [$x,$y -> $width,$height]\n";
exec "byzanz-record", "-d", $opt_t, "-x", $x, "-y", $y, "-w", $width, "-h", $height, $opt_o;
X
__END__
=head1 NAME
X
byzanz-helper - Helper script to record an X-Window with byzanz-record
X
=head1 SYNOPSIS
X
B<byzanz-helper> B<-h>|B<--help>
X
B<byzanz-helper> [B<OPTIONS>] B<-o> I<FILE>
X
=head1 DESCRIPTION
X
This tool helps record a specific B<X11> window using B<byzanz-record>. When
run, the script will ask the user to pick the desired X-Window using the mouse.
The recording will then start for the specified duration.
X
Internally the script uses B<xwininfo> to obtain the position and size of the
recorded video. These parameters are not updated while the video is recorded.
It the recorded window is moved it will leave the area of recording and be
only partially visible in the resulting video.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-o> I<FILE>|B<--output>=I<FILE>
X
Sets the output file for the recorded video.
X
=item B<-t> I<DURATION>|B<--duration>=I<DURATION>
X
Sets the recording duration in seconds. Default is 30 seconds.
X
=back
X
=head1 SEE ALSO
X
byzanz-record(1), byzanz-playback(1), xwininfo(1)
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2018 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the MIT license.
X
=cut
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/byzanz-helper'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/byzanz-helper'
if test $? -ne 0
then ${echo} "restore of scripts/byzanz-helper failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/byzanz-helper': 'MD5 check failed'
       ) << \SHAR_EOF
ba44a6190023b1b48776340b2bb6a277  scripts/byzanz-helper
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/byzanz-helper'` -ne 2541 && \
  ${echo} "restoration warning:  size of 'scripts/byzanz-helper' is not 2541"
  fi
fi
# ============= scripts/codefmt ==============
if test ! -d 'scripts'; then
  mkdir 'scripts'
if test $? -eq 0
then ${echo} "x - created directory scripts."
else ${echo} "x - failed to create directory scripts."
     exit 1
fi
fi
if test -n "${keep_file}" && test -f 'scripts/codefmt'
then
${echo} "x - SKIPPING scripts/codefmt (file already exists)"

else
${echo} "x - extracting scripts/codefmt (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/codefmt' &&
#!/usr/bin/env perl
#*===========================================================================*
#*                                                                           *
#*  codefmt - Code formatting tool                                           *
#*                                                                           *
#*  Copyright (c) 2019 Frederic Jardon  <frederic.jardon@gmail.com>          *
#*                                                                           *
#*  ------------------ GPL Licensed Source Code ------------------           *
#*  Frederic Jardon makes this software available under the GNU              *
#*  General Public License (GPL) license for open source projects.           *
#*  For details of the GPL license please see www.gnu.org or read            *
#*  the file license.gpl provided in this package.                           *
#*                                                                           *
#*  This program is free software; you can redistribute it and/or            *
#*  modify it under the terms of the GNU General Public License as           *
#*  published by the Free Software Foundation; either version 3 of           *
#*  the License, or (at your option) any later version.                      *
#*                                                                           *
#*  This program is distributed in the hope that it will be useful,          *
#*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
#*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
#*  GNU General Public License for more details.                             *
#*                                                                           *
#*  You should have received a copy of the GNU General Public                *
#*  License along with this program in the file 'license.gpl'; if            *
#*  not, see <http://www.gnu.org/licenses/>.                                 *
#*  --------------------------------------------------------------           *
#*===========================================================================*
X
use strict;
use warnings 'all';
use Data::Dumper;
use Carp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case pass_through);
use List::Util qw(max sum);
use Pod::Usage;
X
sub shuffle_words_in_columns {
X    my %args = @_;
X    croak "words is not defined" if (!defined ($args{words}));
X    croak "fmt is not defined"   if (!defined ($args{fmt}));
X
X    my @words = @{$args{words}};
X    my $fmt   = $args{fmt};
X
X    my $n_cols = length ($fmt);
X    my $n_rows = int ((@words+$n_cols-1)/$n_cols);
X    my @cols   = ();
X    for (my $i=0; $i<$n_cols; ++$i) {
X        my @indexes = map { $i+$n_cols*$_ } (0..($n_rows-1));
X        my @column  = map { $_ //= '' } @words[@indexes];
X        push (@cols, \@column);
X    }
X    return @cols;
}
X
sub line_width {
X    my %args = @_;
X
X    croak "cols is not defined" if (!defined ($args{cols}));
X
X    my @cols      = @{$args{cols}};
X    my $textwidth = $args{textwidth};
X    my $c_sep     = $args{separator};
X    my $eol_sep   = $args{eol_separator};
X    $textwidth  //= 70;
X    $c_sep      //= ' ';
X    $eol_sep    //= ' \\';
X
X    my $n_cols = @cols;
X    my @widths = map { max (map scalar @{$_} ) } @cols;
X    my $width  = ($n_cols - 1)*length ($c_sep) + sum (@widths) + length ($eol_sep);
X    return $width;
}
X
X
sub format_args {
X    my ($fmt, @args) = @_;
X    $^A = '';
X    formline ($fmt, @args);
X    return ''.$^A;
}
X
sub format_columns_to_lines {
X    my %args = @_;
X
X    croak "cols is not defined"     if (!defined ($args{cols}));
X    croak "fmt is not defined"      if (!defined ($args{fmt}));
X    croak "n_words is not defined"  if (!defined ($args{n_words}));
X
X    my @cols      = @{$args{cols}};
X    my $fmt       = $args{fmt};
X    my $textwidth = $args{textwidth};
X    my $c_sep     = $args{separator};
X    my $eol_sep   = $args{eol_separator};
X    my $n_words   = $args{n_words};
X    $textwidth  //= 70;
X    $c_sep      //= ' ';
X    $eol_sep    //= ' \\';
X
X    my $eol_len   = length ($eol_sep);
X    my $n_cols    = scalar @cols;
X    my @c_indexes = (0..$#cols);
X    my @widths    = map {
X                        my $col = $_;
X                        max (map {length ($_)} @{$col})
X                    } @cols;
X
X    my @perl_fmta = map {
X                        my ($c, $width) = (substr ($fmt, $_, 1), $widths[$_]);
X                        $width -= 1;
X                        my $r = '@'.'<'x$width;
X                        $r = '@'.'|'x$width if ($c eq 'c');
X                        $r = '@'.'>'x$width if ($c eq 'r');
X                        $r;
X                    } @c_indexes;
X    my $perl_fmt  = join ($c_sep, @perl_fmta);
X    $perl_fmt    .= ' ^'.('<'x($eol_len-1))."\n";
X
X    my $last_n_cols = $n_cols-((-$n_words) % $n_cols);
X    my @last_c_indexes = (0..($last_n_cols-1));
X    my @last_perl_fmta = @perl_fmta[@last_c_indexes];
X    my $last_perl_fmt  = join ($c_sep, @last_perl_fmta);
X
X    my $n_lines   = @{$cols[0]};
X    my @l_indexes = (0..($n_lines-2));
X    my @lines     = map {
X                        my $l_no = $_;
X                        my @words = map { $_->[$l_no] } @cols;
X                        push (@words, $eol_sep);
X                        format_args ($perl_fmt, @words)
X                    } @l_indexes;
X    my $last_line = format_args ($last_perl_fmt, map { $_->[$n_lines-1] } @cols);
X    $last_line =~ s/[ \t]*$//g;
X    push (@lines, $last_line);
X    return @lines;
}
X
# CLI arguments processing
my ($opt_help,
X    $opt_fmt,
X    $opt_eol,
X    $opt_prefix,
X    $opt_separator,
X    $opt_textwidth,
);
X
GetOptionsFromArray(\@ARGV,
X    'h|help'         => \$opt_help,
X    'f|format=s'     => \$opt_fmt,
X    'e|eol=s'        => \$opt_eol,
X    'p|prefix=s'     => \$opt_prefix,
X    's|separator=s'  => \$opt_separator,
X    'w|width=i'      => \$opt_textwidth,
) or croak "Error while parsing command-line arguments";
X
# Handle help option
pod2usage(-exitval => 0) if ($opt_help);
X
$opt_fmt       //= 'lll';
$opt_eol       //= " \\";
$opt_prefix    //= '    ';
$opt_separator //= ' ';
$opt_textwidth //= 70;
X
my @words = ();
while (<>) {
X    chomp;
X    my @line = ();
X    while ($_ ne '') {
X        my $word = undef;
X        if ($_ =~ s/^[ \t]*\Q$opt_eol\E$//g) {
X            last;
X        }
X        elsif ($_ =~ s/^[ \t]*\Q$opt_separator\E//g) {
X            next;
X        }
X        elsif ($_ =~ s/^[ \t]+//g) {
X            next;
X        }
X        elsif ($_ =~ s/^("([^"\\]|\\.)*")//g) {
X            push (@line, $1);
X        }
X        elsif ($_ =~ s/^('([^'\\]|\\.)*')//g) {
X            push (@line, $1);
X        }
X        elsif ($_ =~ s/^([^ \t]+)//g) {
X            push (@line, $1);
X        }
X        else {
X            croak "Unexpected tokens: '".quotemeta($_)."'";
X        }
X    }
X    next if (! @line);
X    push (@words, @line);
}
X
if (0 == @words) {
X    exit 0;
}
X
X
my @cols  = shuffle_words_in_columns (words => \@words, fmt => $opt_fmt);
my @lines = format_columns_to_lines (cols => \@cols, fmt => $opt_fmt, separator => $opt_separator, eol_separator => $opt_eol, n_words => scalar @words);
foreach my $line (@lines) {
X    print $opt_prefix.$line;
}
X
Xexit 0;
X
__END__
=head1 NAME
X
codefmt - Code Formatter tool
X
=head1 SYNOPSIS
X
B<codefmt> B<-h>|B<--help>
X
B<codefmt> [B<OPTIONS>] [B<FILE> ...]
X
=head1 DESCRIPTION
X
This tool format tabular data into fixed size columns.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-e> I<EOL-SEPARATOR>|B<--eol>=I<EOL-SEPARATOR>
X
Sets the end-of-line separator. Default value is: C< \\>.
X
=item B<-s> I<COLUMN-SEPARATOR>|B<--separator>=I<COLUMN-SEPARATOR>
X
Sets the end-of-line separator. Default value is: C< >.
X
=back
X
=head1 SEE ALSO
X
fmt(1), column(1), codemv(1)
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2019 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the GPL license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/codefmt'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/codefmt'
if test $? -ne 0
then ${echo} "restore of scripts/codefmt failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/codefmt': 'MD5 check failed'
       ) << \SHAR_EOF
1d3f96584042667191108c7b9ddc345b  scripts/codefmt
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/codefmt'` -ne 8094 && \
  ${echo} "restoration warning:  size of 'scripts/codefmt' is not 8094"
  fi
fi
# ============= scripts/codemv ==============
if test -n "${keep_file}" && test -f 'scripts/codemv'
then
${echo} "x - SKIPPING scripts/codemv (file already exists)"

else
${echo} "x - extracting scripts/codemv (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/codemv' &&
#!/usr/bin/env perl
#*===========================================================================*
#*                                                                           *
#*  codemv - Code formatting tool                                           *
#*                                                                           *
#*  Copyright (c) 2019 Frederic Jardon  <frederic.jardon@gmail.com>          *
#*                                                                           *
#*  ------------------ GPL Licensed Source Code ------------------           *
#*  Frederic Jardon makes this software available under the GNU              *
#*  General Public License (GPL) license for open source projects.           *
#*  For details of the GPL license please see www.gnu.org or read            *
#*  the file license.gpl provided in this package.                           *
#*                                                                           *
#*  This program is free software; you can redistribute it and/or            *
#*  modify it under the terms of the GNU General Public License as           *
#*  published by the Free Software Foundation; either version 3 of           *
#*  the License, or (at your option) any later version.                      *
#*                                                                           *
#*  This program is distributed in the hope that it will be useful,          *
#*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
#*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
#*  GNU General Public License for more details.                             *
#*                                                                           *
#*  You should have received a copy of the GNU General Public                *
#*  License along with this program in the file 'license.gpl'; if            *
#*  not, see <http://www.gnu.org/licenses/>.                                 *
#*  --------------------------------------------------------------           *
#*===========================================================================*
X
use strict;
use warnings 'all';
use Data::Dumper;
use Carp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case pass_through);
use List::Util qw(max sum);
use Pod::Usage;
X
sub usage {
X    my $exitval = scalar @_;
X    map { print STDERR "ERROR: ".$_."\n" } @_;
X    pod2usage(-exitval => $exitval);
}
X
# CLI arguments processing
my ($opt_help,
X    $opt_append,
X    $opt_copy,
X    $opt_end_string,
X    $opt_extract,
X    $opt_overwrite,
X    $opt_start_string,
);
X
GetOptionsFromArray(\@ARGV,
X    'h|help'         => \$opt_help,
X    'a|append=s'     => \$opt_append,
X    'c|copy'         => \$opt_copy,
X    'e|end=s'        => \$opt_end_string,
X    'o|overwrite=s'  => \$opt_overwrite,
X    's|start=s'      => \$opt_start_string,
X    'x|extract'      => \$opt_extract,
) or croak "Error while parsing command-line arguments";
X
# Handle help option
usage if ($opt_help);
usage("Options: '-a' and '-o' are mutually exclusive") if (defined($opt_append) and defined($opt_overwrite));
usage("Options: '-c' and '-x' are mutually exclusive") if (defined($opt_copy) and defined($opt_extract));
X
my ($open_mode, $filename);
$open_mode = '>>' if(defined($opt_append));
$open_mode = '>'  if(defined($opt_overwrite));
$filename //= $opt_append;
$filename //= $opt_overwrite;
usage("One option out of '-a' or '-o' is required") if(!defined($open_mode));
X
X
open(FILE, $open_mode, $filename) or die("Unable to open: '".$filename."'");
while(my $line = <STDIN>) {
X    print STDOUT $line if(defined($opt_copy));
X    print FILE $line;
}
close(FILE);
X
X
Xexit 0;
X
__END__
=head1 NAME
X
codemv - Code Mover Tool
X
=head1 SYNOPSIS
X
B<codemv> B<-h>|B<--help>
X
B<codemv> [B<OPTIONS>]...
X
=head1 DESCRIPTION
X
This tool divert part of its input to a specified file.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-a> I<FILE>|B<--append>=I<FILE>
X
Sets the file where diverted input is appended. This option is mutually
exclusive with the B<-o> option.
X
=item B<-c>|B<--copy>
X
Copy to stdout the whole input.
X
=item B<-o> I<FILE>|B<--overwrite>=I<FILE>
X
Sets the file overwritten by the diverted input. This option is mutually
exclusive with the B<-o> option.
X
=back
X
=head1 SEE ALSO
X
fmt(1), column(1), codefmt(1)
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2019 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the GPL license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/codemv'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/codemv'
if test $? -ne 0
then ${echo} "restore of scripts/codemv failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/codemv': 'MD5 check failed'
       ) << \SHAR_EOF
d10a4c05ffb485a81e7ce95721c40e8a  scripts/codemv
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/codemv'` -ne 4685 && \
  ${echo} "restoration warning:  size of 'scripts/codemv' is not 4685"
  fi
fi
# ============= scripts/plgen ==============
if test -n "${keep_file}" && test -f 'scripts/plgen'
then
${echo} "x - SKIPPING scripts/plgen (file already exists)"

else
${echo} "x - extracting scripts/plgen (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/plgen' &&
#!/usr/bin/env perl
#*===========================================================================*
#*                                                                           *
#*  plgen - Generate perl plain-old-data record modules
#*                                                                           *
#*  Copyright (c) 2019 Frederic Jardon  <frederic.jardon@gmail.com>          *
#*                                                                           *
#*  ------------------ GPL Licensed Source Code ------------------           *
#*  Frederic Jardon makes this software available under the GNU              *
#*  General Public License (GPL) license for open source projects.           *
#*  For details of the GPL license please see www.gnu.org or read            *
#*  the file license.gpl provided in this package.                           *
#*                                                                           *
#*  This program is free software; you can redistribute it and/or            *
#*  modify it under the terms of the GNU General Public License as           *
#*  published by the Free Software Foundation; either version 3 of           *
#*  the License, or (at your option) any later version.                      *
#*                                                                           *
#*  This program is distributed in the hope that it will be useful,          *
#*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
#*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
#*  GNU General Public License for more details.                             *
#*                                                                           *
#*  You should have received a copy of the GNU General Public                *
#*  License along with this program in the file 'license.gpl'; if            *
#*  not, see <http://www.gnu.org/licenses/>.                                 *
#*  --------------------------------------------------------------           *
#*===========================================================================*
X
use strict;
use warnings 'all';
X
use Carp;
use Data::Dumper;
use File::Basename;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case pass_through);
use Pod::Usage;
use SelectSaver;
X
main() unless caller;
X
sub generate_field_ctor_for_array {
X    my ($field) = @_;
X    my $pl_name = $field->{'pl_name'};
X    my $value   = $field->{'value'} // 'undef';
X
X    my $codegen =<<"CODEGEN";
X        '${pl_name}' => $value,
CODEGEN
X    return $codegen;
}
X
sub generate_field_methods_for_array {
X    my ($field) = @_;
X    my $name      = $field->{'name'};
X    my $pl_name   = $field->{'pl_name'};
X    my $item_type = $field->{'item_type'} // "'undefined'";
X
X    my $codegen =<<"CODEGEN";
X
# Field: ${name} methods
# ------
sub count_${pl_name} {
X    my (\$self) = \@_;
X    return scalar \@{ \$self->{'_${pl_name}'} };
}
X
sub get_${pl_name} {
X    my (\$self) = \@_;
X    return \@{ \$self->{'_${pl_name}'} };
}
X
sub set_${pl_name} {
X    my (\$self, \@new_values) = \@_;
X    \@{ \$self->{'_${pl_name}'} } = (\@new_values);
}
X
sub push_${pl_name} {
X    my (\$self, \@new_values) = \@_;
X    push(\@{ \$self->{'_${pl_name}'} }, \@new_values);
}
X
sub clear_${pl_name} {
X    my (\$self) = \@_;
X    \@{ \$self->{'_${pl_name}'} } = ();
}
X
sub apply_${pl_name} {
X    my (\$self, \$sub) = \@_;
X    map { \$sub->(\$_) } \@{ \$self->{'_${pl_name}'} };
}
CODEGEN
X    return $codegen;
}
X
sub generate_field_methods_for_scalar {
X    my ($field) = @_;
X    my $name      = $field->{'name'};
X    my $item_type = $field->{'item_type'} // "'undefined'";
X    my $pl_name   = $field->{'pl_name'};
X
X    my $codegen =<<"CODEGEN";
X
# Field: ${name} methods
# ------
sub get_${pl_name} {
X    my (\$self) = \@_;
X    return \$self->{'_${pl_name}'};
}
X
sub set_${pl_name} {
X    my (\$self, \$new_value) = \@_;
X    \$self->{'_${pl_name}'} = \$new_value;
}
CODEGEN
X    return $codegen;
}
X
sub generate_field_pod_for_array {
X    my ($field) = @_;
X    my $name      = $field->{'name'};
X    my $pl_name   = $field->{'pl_name'};
X    my $item_type = $field->{'item_type'} // "'undefined'";
X
X    my $codegen =<<"CODEGEN";
X
#=item count_field_name()
X
Returns the count of elements in the array
X
#=item get_field_name()
X
Which returns a list
X
#=item set_field_name(I<\@new_values>)
X
Which copies the items in the internal array
X
#=item push_field_name(I<\@new_values>)
X
Which append items to the internal array
X
#=item clear_field_name()
X
Which clears the internal array
X
#=item apply_field_name(I<sub {...}>)
X
Which applies the sub on the array's items
CODEGEN
X    return $codegen;
}
X
sub generate_field_pod_for_scalar {
X    my ($field) = @_;
X    my $name      = $field->{'name'};
X    my $item_type = $field->{'item_type'} // "'undefined'";
X    my $pl_name   = $field->{'pl_name'};
X
X    my $codegen =<<"CODEGEN";
X
#=item get_${pl_name}()
X
Gets the scalar value of the field.
X
#=item set_${pl_name}(I<\$new_value>)
X
Sets the scalar value of the new field.
CODEGEN
X    return $codegen;
}
X
sub generate_header {
X    my ($parameters_ref) = @_;
X    my $filename   = basename $parameters_ref->{'filename'};
X    my $version    = $parameters_ref->{'version'};
X    my $class_name = $parameters_ref->{'class_name'};
X    my @fields     = @{ $parameters_ref->{'fields'} };
X    my $codegen =<<"CODEGEN";
#!/usr/bin/env perl
#*===========================================================================*
#*                                                                           *
#*  ${filename} - A perl plain-old-data record modules
#*                                                                           *
#*  Copyright (c) 2019 Frederic Jardon  <frederic.jardon\@gmail.com>          *
#*                                                                           *
#*  ------------------ GPL Licensed Source Code ------------------           *
#*  Frederic Jardon makes this software available under the GNU              *
#*  General Public License (GPL) license for open source projects.           *
#*  For details of the GPL license please see www.gnu.org or read            *
#*  the file license.gpl provided in this package.                           *
#*                                                                           *
#*  This program is free software; you can redistribute it and/or            *
#*  modify it under the terms of the GNU General Public License as           *
#*  published by the Free Software Foundation; either version 3 of           *
#*  the License, or (at your option) any later version.                      *
#*                                                                           *
#*  This program is distributed in the hope that it will be useful,          *
#*  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
#*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
#*  GNU General Public License for more details.                             *
#*                                                                           *
#*  You should have received a copy of the GNU General Public                *
#*  License along with this program in the file 'license.gpl'; if            *
#*  not, see <http://www.gnu.org/licenses/>.                                 *
#*  --------------------------------------------------------------           *
#*===========================================================================*
package ${class_name};
X
use strict;
use warnings 'all';
X
require Exporter;
X
our \@ISA = qw(Exporter);
X
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
X
# This allows declaration	use ${class_name} ':all';
# If you do not need this, moving things directly into \@EXPORT or \@EXPORT_OK
# will save memory.
our \%EXPORT_TAGS = ( 'all' => [ qw(
X
) ] );
X
our \@EXPORT_OK = ( \@{ \$EXPORT_TAGS{'all'} } );
X
our \@EXPORT = qw(
X
);
X
our \$VERSION = '${version}';
X
# Preloaded methods go here.
#
sub new {
X    my (\$class, \$parameters_ref) = \@_;
X    my \$self = {
X @{[ map { generate_field_ctor_for_array($_) } @fields ]}
X    };
X    return bless \$self, \$class;
}
CODEGEN
X    return $codegen;
}
X
sub generate_footer {
X    my ($parameters_ref) = @_;
X    my $filename   = basename $parameters_ref->{'filename'};
X    my $version    = $parameters_ref->{'version'};
X    my $class_name = $parameters_ref->{'class_name'};
X    my @fields     = @{ $parameters_ref->{'fields'} };
X
X    my $pod_generator_for_field_type_ref = {
X        'array'  => \&generate_field_pod_for_array,
X        'scalar' => \&generate_field_pod_for_scalar,
X    };
X
X    my $codegen =<<"CODEGEN";
X
if(!caller) {
X    use Test::More;
X    ok(1);
X    done_testing;
}
X
1;
X
#__END__
X
#=head1 NAME
X
${class_name} - Plain Old Perl Data Record
X
#=head1 VERSION
X
This documentation refers to ${class_name} version ${version}.
X
#=head1 SYNOPSIS
X
X    use ${class_name};
X
X    my \$record = ${class_name}->new();
X
#=head1 DESCRIPTION
X
This module implements a plain old data record.
X
#=head1 SUBROUTINES/METHODS
X
#=over 5
X
@{[ map { $pod_generator_for_field_type_ref->{$_->{'type'}}->($_) } @fields ]}
X
#=back
X
#=head1 DIAGNOSTICS
X
none
X
#=head1 CONFIGURATION AND ENVIRONMENT
X
none
X
#=head1 DEPENDENCES
X
none
X
#=head1 INCOMPATIBILITIES
X
none
X
#=head1 BUGS AND LIMITATIONS
X
none
X
#=head1 SEE ALSO
X
X
#=head1 AUTHOR
X
Frederic JARDON <frederic.jardon\@gmail.com>
X
#=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2020 by Frederic JARDON <frederic.jardon\@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the GPL license.
X
#=cut
X
CODEGEN
X    return $codegen;
}
X
X
#=item get_options({ argv => \@ARGV, env => \%env })
#
#Returns a HASH reference whose keys are the parsed options.
#
#- input, the input filename
#- output, the output filename
#
#=cut
sub get_options {
X    my ($parameters_ref) = @_;
X    my $argv = $parameters_ref->{'argv'};
X    my ($opt_help, $opt_c, $opt_o,);
X
X    GetOptionsFromArray($argv,
X        'h|help' => \$opt_help,
X        'c=s'    => \$opt_c,
X        'o=s'    => \$opt_o,
X    ) or croak "Error while parsing command-line arguments";
X
X    # Handle help option
X    pod2usage(-exitval => 0) if ($opt_help);
X
X    $opt_c //= '-';
X    $opt_o //= '-';
X
X    if(@{$argv}) {
X        print STDERR "Extra arguments on command line\n";
X        pod2usage(-exitval => 1);
X    }
X
X    my $opts = {
X        'input'  => $opt_c,
X        'output' => $opt_o,
X    };
X    return $opts;
}
X
#=item read_input_file({filename => $filename})
#
#Returns a HASH reference whose keys are:
#
#- class_name: the class name defined in the input file
#- version:    the version defined in the input file
#- fields:     an ARRAY reference containing field descriptions
#
#Each field description is a HASH reference whose keys are:
#
#- name:      the name of the field as defined in the input file
#- pl_name:   the name of the field converted to a suitable perl identifier
#- type:      one of: array, hash, scalar
#- item_type: the type of items stored in the array if the field is an array
#- value:     the initial value of the field
#
#=cut
sub read_input_file {
X    my ($parameters_ref) = @_;
X
X    my $filename = $parameters_ref->{'filename'};
X    croak "Missing parameter 'filename'" if(!defined($filename));
X
X    my ($class_name, $version);
X    my @fields = ();
X
X    my $in_fh = \*STDIN;
X    if($filename ne '-') {
X        open(my $in, '<', $filename)
X            or croak("Unable to open: '$filename' for reading");
X        $in_fh = $in;
X    }
X    while(my $line = <$in_fh>) {
X        # Remove leading and trailing spaces
X        chomp $line;
X        $line =~ s/^\s+//g;
X
X        # Remove comments and blank lines
X        next if('' eq $line or $line =~ m/^#/);
X
X        # Handle the ':class-name:' attribute
X        if($line =~ m/^:class-name:\s*([a-zA-Z0-9_:]+)$/) {
X            $class_name = $1;
X            next;
X        }
X
X        # Handle the ':version:' attribute
X        if($line =~ m/^:version:\s*([a-zA-Z0-9_.-]+)$/) {
X            $version = $1;
X            next;
X        }
X
X        # Handle field
X        my $field_line = $line;
X        if($field_line =~ s/^(\S+)\s+//g) {
X            my $field = { 'name' => $1 };
X            if($field_line =~ s/\s+([a-zA-Z0-9_:]+)$//g) {
X                $field->{ 'item_type' } = $1;
X            }
X
X            $field->{ 'value' } = $field_line;
X            if($field->{ 'value' } ne '') {
X                $field->{ 'type' }   = 'array' if($field->{'value'} =~ m/^\[/);
X                $field->{ 'type' } //= 'scalar';
X                push(@fields, $field);
X                next;
X            }
X
X            print STDERR "Unknown field definition: '$line'\n";
X        }
X
X        # Erroneous line
X        print STDERR "Unknown line format: '$line'\n";
X    }
X    close($in_fh)
X        if($filename ne '-');
X
X    foreach my $field (@fields) {
X        my $pl_name = $field->{'name'};
X        $pl_name =~ s/[^\w\d]/_/g;
X        $field->{'pl_name'} = $pl_name;
X    }
X
X    my $spec_ref = {
X        'class_name' => $class_name // 'Plain::Old::Data',
X        'version'    => $version    // '0.01',
X        'fields'     => \@fields,
X    };
X    return $spec_ref;
}
X
#=item generate_output({filename => $filename, class_name => '...', fields => [...]})
#
#Generate the output file whose fields are described by I<fields>.
#
#=cut
sub generate_output {
X    my ($parameters_ref) = @_;
X    my $class_name = $parameters_ref->{'class_name'};
X    my $fields_ref = $parameters_ref->{'fields'};
X    my $filename   = $parameters_ref->{'filename'};
X    croak "Missing parameter 'class_name'" if(!defined($class_name));
X    croak "Missing parameter 'fields'"     if(!defined($fields_ref));
X    croak "Missing parameter 'filename'"   if(!defined($filename));
X    my @fields = @{ $fields_ref };
X
X    my $method_generators = {
X        'array'  => \&generate_field_methods_for_array,
X        'scalar' => \&generate_field_methods_for_scalar,
X    };
X
X    my $codegen =<<"CODEGEN";
${\( generate_header($parameters_ref) )}
@{[ map { $method_generators->{$_->{'type'}}->($_) } @fields ]}
${\( generate_footer($parameters_ref) )}
CODEGEN
X
X    # Transform the escaped pod and __END__ macros
X    $codegen =~ s/^#=/=/mg;
X    $codegen =~ s/^#__END__/__END__/mg;
X    # Trim whitespaces at end of line
X    $codegen =~ s/\s+$/\n/mg;
X
X    my $out_fh = \*STDOUT;
X    if($filename ne '-') {
X        open(my $out, '>', $filename)
X            or croak("Unable to open: '$filename' for writing");
X        $out_fh = $out;
X    }
X    {
X        my $saver = SelectSaver->new($out_fh);
X        print $codegen;
X    }
X    close($out_fh)
X        if($filename ne '-');
X
X    return;
}
X
sub main {
X    my $opts = get_options({argv => \@ARGV, env => \%ENV});
X    my $spec = read_input_file({filename => $opts->{'input'}});
X    generate_output({'filename' => $opts->{'output'}, %{$spec}});
}
X
__END__
=head1 NAME
X
plgen - Code Formatter tool
X
=head1 SYNOPSIS
X
B<plgen> B<-h>|B<--help>
X
B<plgen> [B<OPTIONS>] -c B<FILE>
X
=head1 DESCRIPTION
X
This tool format tabular data into fixed size columns.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-c> I<FILE>
X
Sets the input file to compile.
X
=item B<-o> I<OUTPUT>
X
Sets the output file to generate.
X
=back
X
=head1 INPUT FILE FORMAT
X
The input file describe a simple data record. The file format is line oriented
and should start with a header:
X
X    :class-name: The::Class::Name
X    :version: 0.0.2a
X    # Some comment
X    #
X    # Field       Default-Value   Item-Type_opt
X    field-name-1  ''
X    field-name-2  []              Item::Type
X    field-name-3  0
X
The following methods are created for scalar fields:
X
=over 5
X
=item get_field_name()
X
Gets the scalar value of the field.
X
=item set_field_name(I<$new_value>)
X
Sets the scalar value of the new field.
X
=back
X
For array fields, the following methods are created:
X
=over 5
X
=item count_field_name()
X
Returns the count of elements in the array.
X
=item get_field_name()
X
Which returns a list.
X
=item set_field_name(I<@new_values>)
X
Which copies the items in the internal array.
X
=item push_field_name(I<@new_values>)
X
Which append items to the internal array.
X
=item clear_field_name()
X
Which clears the internal array.
X
=item apply_field_name(I<sub {...}>)
X
Which applies the sub on the array's items.
X
=back
X
X
=head1 DIAGNOSTICS
X
=head1 CONFIGURATION AND ENVIRONMENT
X
=head1 DEPENDENCIES
X
=head1 INCOMPATIBILITIES
X
=head1 BUGS AND LIMITATIONS
X
=head1 SEE ALSO
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2019 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the GPL license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/plgen'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/plgen'
if test $? -ne 0
then ${echo} "restore of scripts/plgen failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/plgen': 'MD5 check failed'
       ) << \SHAR_EOF
4c0548f326d9f5060c786e6fc0f7195a  scripts/plgen
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/plgen'` -ne 16939 && \
  ${echo} "restoration warning:  size of 'scripts/plgen' is not 16939"
  fi
fi
# ============= scripts/ffmpeg-helper ==============
if test -n "${keep_file}" && test -f 'scripts/ffmpeg-helper'
then
${echo} "x - SKIPPING scripts/ffmpeg-helper (file already exists)"

else
${echo} "x - extracting scripts/ffmpeg-helper (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/ffmpeg-helper' &&
#!/usr/bin/env perl
X
use 5.008000;
use strict;
use warnings 'all';
X
use Carp;
use Cwd;
use File::Basename;
use File::Temp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use Pod::Usage;
use POSIX qw(uname);
X
X
# Parse options
my ($opt_help, $opt_t, $opt_o);
GetOptionsFromArray(
X    \@ARGV,
X    'help|h'       => \$opt_help,
X    't|duration=s' => \$opt_t,
X    'o|output=s'   => \$opt_o,
) or croak('Error parsing command line arguments');
X
# Handle help option
pod2usage(-exitval => 0) if ($opt_help);
X
if(!defined($opt_o) || $opt_o eq '') {
X    print STDERR "Option '-o' or '--output' is mandatory\n";
X    pod2usage(-exitval => 1);
}
X
# Default option values
$opt_t //= 30;
X
# Get the recorded window parameters
my $xwin_info = `xwininfo`;
croak('Error getting X-Window information') if($?);
X
my ($title, $x, $y, $width, $height);
$xwin_info =~ m/Window id:\s+\w+\s+"([^"]+)"/g;
$title = $1;
$xwin_info =~ m/Absolute upper-left X:\s*(\d+)/g;
$x = $1;
$xwin_info =~ m/Absolute upper-left Y:\s*(\d+)/g;
$y = $1;
$xwin_info =~ m/Width:\s*(\d+)/g;
$width = $1;
$xwin_info =~ m/Height:\s*(\d+)/g;
$height = $1;
X
my $tmp = File::Temp->new(SUFFIX => '.mkv');
close($tmp);
my $mkv = "$tmp";
X
my ($sysname) = uname;
if($sysname =~ m/CYGWIN/) {
X    my @args = ("ffmpeg");
X    push(@args, '-video_size', $width.'x'.$height);
X    push(@args, '-framerate', '25');
X    push(@args, '-f', 'gdigrab');
X    push(@args, '-i', 'title='.$title);
X    push(@args, '-c:v', 'libx264', '-crf', '0', '-preset', 'ultrafast');
X    push(@args, $mkv);
X    my $cmd_cli = "'".join("' '", @args)."'";
X    print "system $cmd_cli\n";
X    system @args == 0
X        or die("Unable to execute command: $cmd_cli");
} else {
X    my @args = ("ffmpeg");
X    push(@args, '-video_size', $width.'x'.$height);
X    push(@args, '-framerate', '25');
X    push(@args, '-f', 'x11grab');
X    push(@args, '-i', ':0.0+'.$x.','.$y);
X    push(@args, '-c:v', 'libx264', '-crf', '0', '-preset', 'ultrafast');
X    push(@args, $mkv);
X    my $cmd_cli = "'".join("' '", @args)."'";
X    print "system $cmd_cli\n";
X    system @args == 0
X        or die("Unable to execute command: $cmd_cli");
}
X
my @args = ();
push(@args, 'ffmpeg');
push(@args, '-i', $mkv);
push(@args, '-c:v', 'libvpx-vp9', '-crf', '0', '-preset', 'veryslow');
push(@args, $opt_o);
my $cmd_cli = "'".join("' '", @args)."'";
print "system $cmd_cli\n";
system @args == 0
X    or die("Unable to execute command: $cmd_cli");
X
__END__
=head1 NAME
X
ffmpeg-helper - Helper script to record an X-Window with ffmpeg-record
X
=head1 SYNOPSIS
X
B<ffmpeg-helper> B<-h>|B<--help>
X
B<ffmpeg-helper> [B<OPTIONS>] B<-o> I<FILE>
X
=head1 DESCRIPTION
X
This tool helps record a specific B<X11> window using B<ffmpeg>. When
run, the script will ask the user to pick the desired X-Window using the mouse.
The recording will then start for the specified duration.
X
Internally the script uses B<xwininfo> to obtain the position and size of the
recorded video. These parameters are not updated while the video is recorded.
It the recorded window is moved it will leave the area of recording and be
only partially visible in the resulting video.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-o> I<FILE>|B<--output>=I<FILE>
X
Sets the output file for the recorded video.
X
=item B<-t> I<DURATION>|B<--duration>=I<DURATION>
X
Sets the recording duration in seconds. Default is 30 seconds.
X
=back
X
=head1 SEE ALSO
X
ffmpeg(1), xwininfo(1)
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2018 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the MIT license.
X
=cut
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/ffmpeg-helper'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/ffmpeg-helper'
if test $? -ne 0
then ${echo} "restore of scripts/ffmpeg-helper failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/ffmpeg-helper': 'MD5 check failed'
       ) << \SHAR_EOF
730d1c68192b332ed5091a88717971de  scripts/ffmpeg-helper
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/ffmpeg-helper'` -ne 3766 && \
  ${echo} "restoration warning:  size of 'scripts/ffmpeg-helper' is not 3766"
  fi
fi
# ============= scripts/hyper-v ==============
if test -n "${keep_file}" && test -f 'scripts/hyper-v'
then
${echo} "x - SKIPPING scripts/hyper-v (file already exists)"

else
${echo} "x - extracting scripts/hyper-v (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/hyper-v' &&
#!/usr/bin/env perl
X
use 5.008000;
use strict;
use warnings 'all';
X
use Carp;
use Cwd;
use File::Basename;
use File::Temp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use Pod::Usage;
X
# Parse options
my ($opt_help, $opt_start, $opt_stop);
my $ret = GetOptionsFromArray(
X    \@ARGV,
X    'help|h' => \$opt_help,
X    'start'  => \$opt_start,
X    'stop'   => \$opt_stop,
);
pod2usage(-exitval => 1, -message => 'Unknown options: '.join(', ', @ARGV)) if(@ARGV);
pod2usage(-exitval => 1) if(!$ret);
X
# Handle help option
pod2usage(-exitval => 0) if $opt_help;
X
# Handle bad arguments
pod2usage(-exitval => 1)
X    if(!$opt_start && !$opt_stop);
pod2usage(-exitval => 1, -message => '--start and --stop are exclusive')
X    if($opt_start && $opt_stop);
X
my @command = ('bcdedit', '/set', 'hypervisorlaunchtype');
push(@command, 'auto') if ($opt_start);
push(@command, 'off')  if ($opt_stop);
X
system (@command);
X
__END__
=head1 NAME
X
hyper-v - Starts and stop the hyper-v windows hypervisor
X
=head1 SYNOPSIS
X
B<hyper-v> B<-h>|B<--help>
X
B<hyper-v> --start
X
B<hyper-v> --stop
X
=head1 DESCRIPTION
X
This tools enables or disables the hyper-v service on Windows 10. Note that for
the change to take effect one has to reboot the computer.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<start>
X
Mark the hyper-v service as running the next time windows starts.
X
=item B<stop>
X
Mark the hyper-v service as not running the next time windows starts.
X
=back
X
=head1 SEE ALSO
X
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2018 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the MIT license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/hyper-v'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/hyper-v'
if test $? -ne 0
then ${echo} "restore of scripts/hyper-v failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/hyper-v': 'MD5 check failed'
       ) << \SHAR_EOF
931cccf0a443d53c5f44be782f9a4583  scripts/hyper-v
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/hyper-v'` -ne 1820 && \
  ${echo} "restoration warning:  size of 'scripts/hyper-v' is not 1820"
  fi
fi
# ============= scripts/msvc-shell ==============
if test -n "${keep_file}" && test -f 'scripts/msvc-shell'
then
${echo} "x - SKIPPING scripts/msvc-shell (file already exists)"

else
${echo} "x - extracting scripts/msvc-shell (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/msvc-shell' &&
#!/usr/bin/env perl
X
use strict;
use warnings 'all';
X
require Carp;
require Cwd;
require File::Basename;
require Getopt::Long;
require Storable;
X
use File::Temp;
X
sub call_vcvarsall {
X    my ($opts) = @_;
X
X    # Save current context to restore it later
X    my %saved_ENV = (%ENV);
X    my $cwd = Cwd::getcwd;
X
X    # Get environment
X    my $env = $opts->{ENV};
X    $env //= \%ENV;
X
X    # Get path to comspec
X    my $comspec_win=$env->{'COMSPEC'};
X    Carp::croak("Unable to find 'COMSPEC' in the environment!")
X        if(!defined($comspec_win));
X    my $comspec_path = Cygwin::win_to_posix_path($comspec_win);
X
X    # Get path to vcvarsall.bat
X    my $vcvarsall_bat_path = $opts->{vcvarsall_bat_path};
X    Carp::croak("'vcvarsall_bat_path' parameter is mandatory")
X        if(!defined($vcvarsall_bat_path));
X
X    # Get vcvarsall.bat arguments
X    my $vcvarsall_args = $opts->{args};
X    $vcvarsall_args  //= [];
X
X    # Get paths to scripts and bash
X    my $bat_dir      = File::Basename::dirname($vcvarsall_bat_path);
X    my $bat_dir_win  = Cygwin::posix_to_win_path($bat_dir);
X    my $bash_dir     ='/usr/bin';
X    my $bash_dir_win = Cygwin::posix_to_win_path($bash_dir);
X
X    # Prepare a temporary file to store environment
X    my $tmp_env_handle   = File::Temp->new();
X    my $tmp_env_filename = "$tmp_env_handle";
X    # Close the temporary file handle to avoid 'text file is busy' errors
X    close($tmp_env_handle);
X
X    # Write .bat to a temporary file
X    my $tmp_bat_handle = File::Temp->new(SUFFIX => '.bat');
X    my $tmp_bat        = "$tmp_bat_handle";
X    my $tmp_bat_win    = Cygwin::posix_to_win_path($tmp_bat);
X    my $tmp_bat_dir    = File::Basename::dirname($tmp_bat);
X    # Close the temporary file handle to avoid 'text file is busy' errors
X    close($tmp_bat_handle);
X
X    # Compute parameters
X    my $vcvarsall_params = join(' ', @{$vcvarsall_args});
X
X    open(my $fh, '>', $tmp_bat) or
X        Carp::croak("Unable to create batch file");
X    print $fh <<BATCH;
\@ECHO OFF
CD "$bat_dir_win"
CALL vcvarsall.bat $vcvarsall_params
CD "$bash_dir_win"
bash -l -c "perl -MStorable -e 'Cygwin::sync_winenv();' -e 'Storable::store \\%%ENV, \\\"$tmp_env_filename\\\";'"
BATCH
X    chmod 0755, $tmp_bat;
X    chdir $tmp_bat_dir;
X    system $comspec_path, '/C', $tmp_bat_win;
X
X    # Read modified environment
X    my %vc_env = %{Storable::retrieve($tmp_env_filename)};
X
X    # Check for errors
X    Carp::croak("Error while setuping VC++ environment")
X        if(! exists($vc_env{VSCMD_VER}) || $vc_env{VSCMD_VER} eq '');
X
X    # Start subshell with modified environment
X    %ENV = %vc_env;
X    $ENV{VS_KIT}=join('-', 'msvc', $vc_env{VSCMD_VER}, @{$vcvarsall_args});
X    system 'bash', '-l', '-i';
X
X    # Restore saved environment
X    chdir $cwd;
X    %ENV = %saved_ENV;
}
X
sub get_default_vs_paths {
X    my @default_vs_paths = ();
X    push(@default_vs_paths, $ENV{'ProgramW6432'})
X        if(exists($ENV{'ProgramW6432'}));
X    push(@default_vs_paths, $ENV{'ProgramFiles(x86)'})
X        if(exists($ENV{'ProgramFiles(x86)'}));
X    @default_vs_paths = map { Cygwin::win_to_posix_path($_) } @default_vs_paths;
X    @default_vs_paths = map { $_.'/Microsoft Visual Studio' } @default_vs_paths;
X    @default_vs_paths = map { my $year=$_; map { $_.'/'.$year } @default_vs_paths; } (2019, 2017);
X    @default_vs_paths = map { $_.'/Community', $_.'/Professional', $_.'/Enterprise' } @default_vs_paths;
X    @default_vs_paths = map { $_.'/VC/Auxiliary/Build/vcvarsall.bat' } @default_vs_paths;
X    return @default_vs_paths;
}
X
# Load the full windows environment
Cygwin::sync_winenv();
X
# Parse options
my ($opt_help, $opt_p);
Getopt::Long::Configure("no_ignore_case");
Getopt::Long::GetOptionsFromArray(
X    \@ARGV,
X    'help|h'             => \$opt_help,
X    'p|vcvarsall-path=s' => \$opt_p,
) or Carp::croak('Error parsing command line arguments');
X
# Handle help option
if($opt_help) {
X    require Pod::Usage;
X    Pod::Usage::pod2usage(-exitval => 0);
}
X
# Clean '-p' option
$opt_p = Cygwin::win_to_posix_path($opt_p)
X    if(defined($opt_p));
if(! defined($opt_p)) {
X    my @default_vs_paths = get_default_vs_paths();
X    my @found_vcvars = grep { -f $_ } @default_vs_paths;
X    if(@found_vcvars) {
X        $opt_p = $found_vcvars[0];
X        print "Using 'vcvarsall.bat' found in path: ".File::Basename::dirname($opt_p)."\n";
X    }
}
if(! defined($opt_p)) {
X    print STDERR "Unable to find a suitable path to 'vcvarsall.bat'. Please use option '-p'\n";
X    require Pod::Usage;
X    Pod::Usage::pod2usage(-exitval => 1);
}
if(! -f $opt_p) {
X    print STDERR "The path specified by option '-p' is not valid.\n";
X    require Pod::Usage;
X    Pod::Usage::pod2usage(-exitval => 1);
}
X
call_vcvarsall({
X    vcvarsall_bat_path => $opt_p,
X    args => \@ARGV,
});
X
X
__END__
=head1 NAME
X
msvc-shell - MS-VC++ build environment shell spawner
X
=head1 SYNOPSIS
X
B<msvc-shell> B<-h>|B<--help>
X
B<msvc-shell> [B<OPTIONS>] B<VC_OPTIONS>
X
=head1 DESCRIPTION
X
This tool wraps the B<vcvarsall.bat> batch script provided with visual studio
to setup the build environment. Calling this script allows to spawn a shell
with the same configuration that B<vcvarsall.bat> setup when called in a
windows console.
X
The tool also setup a B<VS_KIT> environment variable in the spawned shell to
indicate the parameters that were passed to B<vcvarsall.bat>.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-p> I<path/to/vcvarsall.bat>|B<--vcvarsall-path>=I<path/to/vcvarsall.bat>
X
Sets the path to the B<vcvarsall.bat> batch script. Before Visual Studio 2017
it was possible to deduce the path to this script from the environment variable
set at install time, but this is no longer the case.
X
=back
X
=head1 VC_OPTIONS
X
The B<vcvarsall.bat> script accepts parameters to indicate which architecture,
platform, SDK, etc. is targeted by the environment it sets up.
X
Run the script without B<VC_OPTIONS> to get more information in the error
message printed by B<vcvarsall.bat>.
X
=head1 SEE ALSO
X
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2017 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the MIT license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/msvc-shell'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/msvc-shell'
if test $? -ne 0
then ${echo} "restore of scripts/msvc-shell failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/msvc-shell': 'MD5 check failed'
       ) << \SHAR_EOF
e7c451e8bcbc2b345740b82da1fd7011  scripts/msvc-shell
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/msvc-shell'` -ne 6290 && \
  ${echo} "restoration warning:  size of 'scripts/msvc-shell' is not 6290"
  fi
fi
# ============= scripts/sixel2tmux ==============
if test -n "${keep_file}" && test -f 'scripts/sixel2tmux'
then
${echo} "x - SKIPPING scripts/sixel2tmux (file already exists)"

else
${echo} "x - extracting scripts/sixel2tmux (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/sixel2tmux' &&
#!/usr/bin/env perl
X
use strict;
use warnings 'all';
X
use Carp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use Pod::Usage;
X
sub tmux_dcs_escape {
X    my ($inception_level, $msg) = @_;
X
X    for(my $l=0; $l<$inception_level; ++$l) {
X        my $dcs_payload = $msg;
X        $dcs_payload =~ s/\033/\033\033/g;
X        $msg = "\033Ptmux;$dcs_payload\033\\";
X    }
X    return $msg;
}
X
# Parse options
my ($opt_help, $opt_t, $opt_tmux_tty, $opt_l);
GetOptionsFromArray(
X    \@ARGV,
X    'help|h'              => \$opt_help,
X    'l|inception-level=s' => \$opt_l,
X    't|terminal=s'        => \$opt_t,
) or croak('Error parsing command line arguments');
X
# Handle help option
pod2usage(-exitval => 0) if $opt_help;
X
# get terminal
my ($terminal);
$terminal //= $opt_t if(defined($opt_t));
$terminal //= '/dev/tty';
X
# inception level
$opt_l //= 1 if(exists($ENV{'TMUX'}));
$opt_l //= 0;
X
# output to tty
my $tty;
$tty = \*STDOUT;
open($tty, '>', $terminal) or croak("Unable to open tty: $terminal\n") if('-' ne $terminal);
X
# loop reading sixel chunks, escape them using tmux DCS and loop again
my ($msg, $payload, $chunk) = ('', '', '');
my $max_byte_size = 74994;
binmode STDIN;
binmode $tty;
while(sysread STDIN, $msg, 256) {
X    $payload .= $msg;
X    while($payload =~ s/^((.*)?\e\\)//g) {
X        $chunk = $1;
X        $chunk = tmux_dcs_escape($opt_l, $chunk);
X        if(length($chunk) > $max_byte_size) {
X            print STDERR "An escape sequence is too large to pass-through: ".length($chunk)." > $max_byte_size. Aborting!\n";
X            exit 1;
X        }
X        syswrite $tty, $chunk;
X    }
}
$chunk = tmux_dcs_escape($opt_l, $payload);
syswrite $tty, $chunk;
close($tty) if('-' ne $terminal);
X
__END__
=head1 NAME
X
sixel2tmux - Script converting sixel input into tmux's DCS escape sequence
X
=head1 SYNOPSIS
X
B<sixel2tmux> B<-h>|B<--help>
X
B<sixel2tmux> [B<OPTIONS>]
X
GNUTERM=sixelgd gnuplot -e 'plot sin(x)' | B<sixel2tmux>
X
=head1 DESCRIPTION
X
This tool converts standard input into a I<tmux> specific B<DCS> escape sequence
and outputs it to a terminal.
X
The output of the program should be directed to a terminal. In case no terminal
is specified, the script will use F</dev/tty>.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-t> I<TERMINAL>|B<--terminal>=I<TERMINAL>
X
Sets the terminal used to output the tmux DCS escape sequence. In case the
terminal is not specified, the default value is: F</dev/tty>.
X
The special name: '-' means I<stdout>
X
=item B<-l>=I<INCEPTION>|B<--inception-level>=I<INCEPTION>
X
Sets the B<tmux> inception level. This is needed in case you connect to another
B<tmux> session from within a B<tmux> session. Default value is 0 unless the
B<TMUX> environment variable is set, in which case the default value is 1.
X
=back
X
X
=head1 ENVIRONMENT VARIABLES
X
=over
X
=item TMUX
X
The B<TMUX> environment variable is used to find out if we are running inside
a B<tmux> pane.
X
=back
X
X
=head1 SEE ALSO
X
xterm(1), tmux(1)
X
=over
X
=item I<XTerm Control Sequences>
X
X    https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Operating-System-Commands
X
=item I<Device Control String Sequences>
X
X    https://vt100.net/docs/vt510-rm/chapter4.html
X
=item I<TMux DCS Sequences>
X
X    see tmux changelog
X
=back
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2017 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the MIT license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/sixel2tmux'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/sixel2tmux'
if test $? -ne 0
then ${echo} "restore of scripts/sixel2tmux failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/sixel2tmux': 'MD5 check failed'
       ) << \SHAR_EOF
1502bceaaa5049181d318128b8e4d58d  scripts/sixel2tmux
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/sixel2tmux'` -ne 3591 && \
  ${echo} "restoration warning:  size of 'scripts/sixel2tmux' is not 3591"
  fi
fi
# ============= scripts/yank ==============
if test -n "${keep_file}" && test -f 'scripts/yank'
then
${echo} "x - SKIPPING scripts/yank (file already exists)"

else
${echo} "x - extracting scripts/yank (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/yank' &&
#!/usr/bin/env perl
X
use strict;
use warnings 'all';
X
use Carp;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case);
use MIME::Base64 qw(encode_base64);
use Pod::Usage;
X
sub get_tmux_tty {
X    my $pty = `tmux list-panes -F "#{pane_tty}"`;
X    return undef if($?);
X    return $pty;
}
X
# Parse options
my ($opt_help, $opt_t, $opt_tmux_tty, $opt_l);
GetOptionsFromArray(
X    \@ARGV,
X    'help|h'       => \$opt_help,
X    'l|inception-level=s' => \$opt_l,
X    't|terminal=s' => \$opt_t,
X    'tmux-tty'     => \$opt_tmux_tty,
) or croak('Error parsing command line arguments');
X
# Handle help option
pod2usage(-exitval => 0) if $opt_help;
X
# get terminal
my ($terminal);
$terminal //= get_tmux_tty if(defined($opt_tmux_tty));
$terminal //= $opt_t if(defined($opt_t));
$terminal //= '/dev/tty';
X
# inception level
$opt_l //= 1 if(exists($ENV{'TMUX'}));
$opt_l //= 0;
X
# read input
my $max_byte_size = 74994;
my $msg = '';
while(length($msg) < $max_byte_size) {
X    my $line = <STDIN>;
X    last if(!defined($line));
X    $msg = $msg.$line;
}
croak('Error: message is too big')
X    if(length($msg) > $max_byte_size);
my ($b64, $osc52);
$b64   = encode_base64($msg);
$b64   =~ s/[\r\n]//g;
X
# OSC 5-2 is to modify the operating system selection (copy/paste buffer)
$osc52 = "\033]52;c;$b64\a";
X
# In case we are incepted in TMUX, use a tmux specific DCS to pass the OSC to
# the outer tty
for(my $l=0; $l<$opt_l; ++$l) {
X    my $dcs_payload = $osc52;
X    $dcs_payload =~ s/\033/\033\033/g;
X    $osc52 = "\033Ptmux;$dcs_payload\033\\";
}
X
# output to tty
open(my $tty, '>', $terminal) or croak("Unable to open tty: $terminal\n");
print $tty $osc52;
close($tty);
X
__END__
=head1 NAME
X
yank - Script converting input into OSC 5-2 escape sequence
X
=head1 SYNOPSIS
X
B<yank> B<-h>|B<--help>
X
B<yank> [B<OPTIONS>]
X
echo "Text To Copy" | B<yank>
X
=head1 DESCRIPTION
X
This tool converts standard input into B<OSC 5-2> escape sequence and outputs
it to a terminal. These escape sequences are interpreted by terminals to set
their B<selection> buffer. For B<XTerm> it means the B<X11> copy/paste buffer.
X
The script can used to provide seamless copy/paste capabilities between a host
and a remote session. For instance a user running B<vim> through B<tmux> on a
remote host connected by B<ssh> running on its B<Windows> laptop.
X
The output of the program should be directed to a terminal. In case no terminal
is specified, the script will use F</dev/tty>.
X
=head1 OPTIONS
X
=over
X
=item B<-h>|B<--help>
X
Print the usage, help and version information for this program and exit.
X
=item B<-t> I<TERMINAL>|B<--terminal>=I<TERMINAL>
X
Sets the terminal used to output the OSC 5-2 escape sequence. In case the
terminal is not specified, the default value is: F</dev/tty>.
X
=item B<--tmux-tty>
X
Sets the terminal used to output the OSC 5-2 escape sequence to the B<tmux> pane
tty. In case the program is unable to find out B<tmux> pane's tty, the value of
the B<--terminal> option is taken into account.
X
=item B<-l>=I<INCEPTION>|B<--inception-level>=I<INCEPTION>
X
Sets the B<tmux> inception level. This is needed in case you connect to another
B<tmux> session from within a B<tmux> session. Default value is 0 unless the
B<TMUX> environment variable is set, in which case the default value is 1.
X
=back
X
=head1 LIMITATIONS
X
No more than 74994 bytes of data can be transmitted through the OSC 5-2 escape
sequence.
X
=head1 ENVIRONMENT VARIABLES
X
=over
X
=item TMUX
X
The B<TMUX> environment variable is used to find out if we are running inside
a B<tmux> pane.
X
=back
X
X
=head1 SEE ALSO
X
xterm(1), tmux(1)
X
=over
X
=item I<XTerm Control Sequences>
X
X    https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Operating-System-Commands
X
=item I<Device Control String Sequences>
X
X    https://vt100.net/docs/vt510-rm/chapter4.html
X
=item I<TMux DCS Sequences>
X
X    see tmux changelog
X
=back
X
=head1 AUTHOR
X
Frederic JARDON <frederic.jardon@gmail.com>
X
=head1 COPYRIGHT AND LICENSE
X
Copyright (C) 2017 by Frederic JARDON <frederic.jardon@gmail.com>
X
This program is free software; you can redistribute it and/or modify
it under the MIT license.
X
=cut
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'scripts/yank'
   eval "${shar_touch}") && \
  chmod 0775 'scripts/yank'
if test $? -ne 0
then ${echo} "restore of scripts/yank failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/yank': 'MD5 check failed'
       ) << \SHAR_EOF
b5528cfbfa7966be5377b78960cd2e28  scripts/yank
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/yank'` -ne 4128 && \
  ${echo} "restoration warning:  size of 'scripts/yank' is not 4128"
  fi
fi
# ============= share-gdb.tar ==============
if test -n "${keep_file}" && test -f 'share-gdb.tar'
then
${echo} "x - SKIPPING share-gdb.tar (file already exists)"

else
${echo} "x - extracting share-gdb.tar (text)"
  sed 's/^X//' << 'SHAR_EOF' | uudecode &&
begin 600 share-gdb.tar
M+B\`````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````#`P,#`W-S4`,#`P,3<U,``P,#`Q-S4P`#`P,#`P,#`P,#`P
M`#$S-S$S-#4R-C8R`#`Q,3`U-@`@-0``````````````````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````!U<W1A<B`@`&9J87)D
M;VX`````````````````````````````````9FIA<F1O;@``````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````N+W!Y=&AO;B\`````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````,#`P,#<W-0`P,#`Q-S4P`#`P
M,#$W-3``,#`P,#`P,#`P,#``,3,W,3,T-3(V-C,`,#$R-#`P`"`U````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````'5S=&%R("``9FIA<F1O;@````````````````````````````````!F
M:F%R9&]N````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````"XO<'ET:&]N+VAO
M;VLN:6X`````````````````````````````````````````````````````
M```````````````````````````````````````````````````````````P
M,#`P-C8T`#`P,#$W-3``,#`P,3<U,``P,#`P,#`P-#4P,``Q,S<Q,S0U,C8V
M,P`P,3,V-C<`(#``````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````=7-T87(@(`!F:F%R9&]N````````````
M`````````````````````&9J87)D;VX`````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````(R`M*BT@<'ET:&]N("TJ+0HC($-O<'ER:6=H="`H0RD@,C`P.2TR
M,#(P($9R964@4V]F='=A<F4@1F]U;F1A=&EO;BP@26YC+@H*(R!4:&ES('!R
M;V=R86T@:7,@9G)E92!S;V9T=V%R93L@>6]U(&-A;B!R961I<W1R:6)U=&4@
M:70@86YD+V]R(&UO9&EF>0HC(&ET('5N9&5R('1H92!T97)M<R!O9B!T:&4@
M1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@87,@<'5B;&ES:&5D(&)Y"B,@
M=&AE($9R964@4V]F='=A<F4@1F]U;F1A=&EO;CL@96ET:&5R('9E<G-I;VX@
M,R!O9B!T:&4@3&EC96YS92P@;W(*(R`H870@>6]U<B!O<'1I;VXI(&%N>2!L
M871E<B!V97)S:6]N+@HC"B,@5&AI<R!P<F]G<F%M(&ES(&1I<W1R:6)U=&5D
M(&EN('1H92!H;W!E('1H870@:70@=VEL;"!B92!U<V5F=6PL"B,@8G5T(%=)
M5$A/550@04Y9(%=!4E)!3E19.R!W:71H;W5T(&5V96X@=&AE(&EM<&QI960@
M=V%R<F%N='D@;V8*(R!-15)#2$%.5$%"24Q)5%D@;W(@1DE43D534R!&3U(@
M02!005)424-53$%2(%!54E!/4T4N("!3964@=&AE"B,@1TY5($=E;F5R86P@
M4'5B;&EC($QI8V5N<V4@9F]R(&UO<F4@9&5T86EL<RX*(PHC(%EO=2!S:&]U
M;&0@:&%V92!R96-E:79E9"!A(&-O<'D@;V8@=&AE($=.52!'96YE<F%L(%!U
M8FQI8R!,:6-E;G-E"B,@86QO;F<@=VET:"!T:&ES('!R;V=R86TN("!)9B!N
M;W0L('-E92`\:'1T<#HO+W=W=RYG;G4N;W)G+VQI8V5N<V5S+SXN"@II;7!O
M<G0@<WES"FEM<&]R="!G9&(*:6UP;W)T(&]S"FEM<&]R="!O<RYP871H"@IP
M>71H;VYD:7(@/2`G0'!Y=&AO;F1I<D`G"FQI8F1I<B`]("=`=&]O;&5X96-L
M:6)D:7)`)PH*(R!4:&ES(&9I;&4@;6EG:'0@8F4@;&]A9&5D('=H96X@=&AE
M<F4@:7,@;F\@8W5R<F5N="!O8FIF:6QE+B`@5&AI<PHC(&-A;B!H87!P96X@
M:68@=&AE('5S97(@;&]A9',@:70@;6%N=6%L;'DN("!);B!T:&ES(&-A<V4@
M=V4@9&]N)W0*(R!U<&1A=&4@<WES+G!A=&@[(&EN<W1E860@=V4@:G5S="!H
M;W!E('1H92!U<V5R(&UA;F%G960@=&\@9&\@=&AA=`HC(&)E9F]R96AA;F0N
M"FEF(&=D8BYC=7)R96YT7V]B:F9I;&4@*"D@:7,@;F]T($YO;F4Z"B`@("`C
M(%5P9&%T92!M;V1U;&4@<&%T:"X@(%=E('=A;G0@=&\@9FEN9"!T:&4@<F5L
M871I=F4@<&%T:"!F<F]M(&QI8F1I<@H@("`@(R!T;R!P>71H;VYD:7(L(&%N
M9"!T:&5N('=E('=A;G0@=&\@87!P;'D@=&AA="!R96QA=&EV92!P871H('1O
M('1H90H@("`@(R!D:7)E8W1O<GD@:&]L9&EN9R!T:&4@;V)J9FEL92!W:71H
M('=H:6-H('1H:7,@9FEL92!I<R!A<W-O8VEA=&5D+@H@("`@(R!4:&ES('!R
M97-E<G9E<R!R96QO8V%T86)I;&ET>2!O9B!T:&4@9V-C('1R964N"@H@("`@
M(R!$;R!A('-I;7!L92!N;W)M86QI>F%T:6]N('1H870@<F5M;W9E<R!D=7!L
M:6-A=&4@<V5P87)A=&]R<RX*("`@('!Y=&AO;F1I<B`](&]S+G!A=&@N;F]R
M;7!A=&@@*'!Y=&AO;F1I<BD*("`@(&QI8F1I<B`](&]S+G!A=&@N;F]R;7!A
M=&@@*&QI8F1I<BD*"B`@("!P<F5F:7@@/2!O<RYP871H+F-O;6UO;G!R969I
M>"`H6VQI8F1I<BP@<'ET:&]N9&ER72D*("`@(",@26X@<V]M92!B:7IA<G)E
M(&-O;F9I9W5R871I;VX@=V4@;6EG:'0@:&%V92!F;W5N9"!A(&UA=&-H(&EN
M('1H90H@("`@(R!M:61D;&4@;V8@82!D:7)E8W1O<GD@;F%M92X*("`@(&EF
M('!R969I>%LM,5T@(3T@)R\G.@H@("`@("`@('!R969I>"`](&]S+G!A=&@N
M9&ER;F%M92`H<')E9FEX*2`K("<O)PH*("`@(",@4W1R:7`@;V9F('1H92!P
M<F5F:7@N"B`@("!P>71H;VYD:7(@/2!P>71H;VYD:7);;&5N("AP<F5F:7@I
M.ET*("`@(&QI8F1I<B`](&QI8F1I<EML96X@*'!R969I>"DZ70H*("`@(",@
M0V]M<'5T92!T:&4@(BXN(G,@;F5E9&5D('1O(&=E="!F<F]M(&QI8F1I<B!T
M;R!T:&4@<')E9FEX+@H@("`@9&]T9&]T<R`]("@G+BXG("L@;W,N<V5P*2`J
M(&QE;B`H;&EB9&ER+G-P;&ET("AO<RYS97`I*0H*("`@(&]B:F9I;&4@/2!G
M9&(N8W5R<F5N=%]O8FIF:6QE("@I+F9I;&5N86UE"B`@("!D:7)?(#T@;W,N
M<&%T:"YJ;VEN("AO<RYP871H+F1I<FYA;64@*&]B:F9I;&4I+"!D;W1D;W1S
M+"!P>71H;VYD:7(I"@H@("`@:68@;F]T(&1I<E\@:6X@<WES+G!A=&@Z"B`@
M("`@("`@<WES+G!A=&@N:6YS97)T*#`L(&1I<E\I"@HC($-A;&P@82!F=6YC
M=&EO;B!A<R!A('!L86EN(&EM<&]R="!W;W5L9"!N;W0@97AE8W5T92!B;V1Y
M(&]F('1H92!I;F-L=61E9"!F:6QE"B,@;VX@<F5P96%T960@<F5L;V%D<R!O
M9B!T:&ES(&]B:F5C="!F:6QE+@IF<F]M(&QI8G-T9&-X>"YV-B!I;7!O<G0@
M<F5G:7-T97)?;&EB<W1D8WAX7W!R:6YT97)S"G)E9VES=&5R7VQI8G-T9&-X
M>%]P<FEN=&5R<RAG9&(N8W5R<F5N=%]O8FIF:6QE*"DI"@``````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`"XO<'ET:&]N+VQI8G-T9&-X>"\`````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````P,#`P-S<U`#`P,#$W-3``,#`P,3<U,``P,#`P,#`P,#`P
M,``Q,S<Q,S0U,C8V,P`P,30T,#0`(#4`````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````=7-T87(@(`!F:F%R
M9&]N`````````````````````````````````&9J87)D;VX`````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````+B]P>71H;VXO;&EB<W1D8WAX+W8V+P``````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````#`P,#`W-S4`,#`P,3<U,``P
M,#`Q-S4P`#`P,#`P,#`P,#`P`#$S-S$S-#4R-C8S`#`Q-#<S-P`@-0``````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````!U<W1A<B`@`&9J87)D;VX`````````````````````````````````
M9FIA<F1O;@``````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````````N+W!Y=&AO;B]L
M:6)S=&1C>'@O=C8O7U]I;FET7U\N<'D`````````````````````````````
M````````````````````````````````````````````````````````````
M,#`P,#8V-``P,#`Q-S4P`#`P,#$W-3``,#`P,#`P,#(R,3$`,3,W,3,T-3(V
M-C,`,#$W,#0T`"`P````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````'5S=&%R("``9FIA<F1O;@``````````
M``````````````````````!F:F%R9&]N````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````",@0V]P>7)I9VAT("A#*2`R,#$T+3(P,C`@1G)E92!3;V9T=V%R
M92!&;W5N9&%T:6]N+"!);F,N"@HC(%1H:7,@<')O9W)A;2!I<R!F<F5E('-O
M9G1W87)E.R!Y;W4@8V%N(')E9&ES=')I8G5T92!I="!A;F0O;W(@;6]D:69Y
M"B,@:70@=6YD97(@=&AE('1E<FUS(&]F('1H92!'3E4@1V5N97)A;"!0=6)L
M:6,@3&EC96YS92!A<R!P=6)L:7-H960@8GD*(R!T:&4@1G)E92!3;V9T=V%R
M92!&;W5N9&%T:6]N.R!E:71H97(@=F5R<VEO;B`S(&]F('1H92!,:6-E;G-E
M+"!O<@HC("AA="!Y;W5R(&]P=&EO;BD@86YY(&QA=&5R('9E<G-I;VXN"B,*
M(R!4:&ES('!R;V=R86T@:7,@9&ES=')I8G5T960@:6X@=&AE(&AO<&4@=&AA
M="!I="!W:6QL(&)E('5S969U;"P*(R!B=70@5TE42$]55"!!3ED@5T%24D%.
M5%D[('=I=&AO=70@979E;B!T:&4@:6UP;&EE9"!W87)R86YT>2!O9@HC($U%
M4D-(04Y404))3$E462!O<B!&251.15-3($9/4B!!(%!!4E1)0U5,05(@4%52
M4$]312X@(%-E92!T:&4*(R!'3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS92!F
M;W(@;6]R92!D971A:6QS+@HC"B,@66]U('-H;W5L9"!H879E(')E8V5I=F5D
M(&$@8V]P>2!O9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4*(R!A
M;&]N9R!W:71H('1H:7,@<')O9W)A;2X@($EF(&YO="P@<V5E(#QH='1P.B\O
M=W=W+F=N=2YO<F<O;&EC96YS97,O/BX*"FEM<&]R="!G9&(*"B,@3&]A9"!T
M:&4@>&UE=&AO9',@:68@1T1"('-U<'!O<G1S('1H96TN"F1E9B!G9&)?:&%S
M7WAM971H;V1S*"DZ"B`@("!T<GDZ"B`@("`@("`@:6UP;W)T(&=D8BYX;65T
M:&]D"B`@("`@("`@<F5T=7)N(%1R=64*("`@(&5X8V5P="!);7!O<G1%<G)O
M<CH*("`@("`@("!R971U<FX@1F%L<V4*"F1E9B!R96=I<W1E<E]L:6)S=&1C
M>'A?<')I;G1E<G,H;V)J*3H*("`@(",@3&]A9"!T:&4@<')E='1Y+7!R:6YT
M97)S+@H@("`@9G)O;2`N<')I;G1E<G,@:6UP;W)T(')E9VES=&5R7VQI8G-T
M9&-X>%]P<FEN=&5R<PH@("`@<F5G:7-T97)?;&EB<W1D8WAX7W!R:6YT97)S
M*&]B:BD*"B`@("!I9B!G9&)?:&%S7WAM971H;V1S*"DZ"B`@("`@("`@9G)O
M;2`N>&UE=&AO9',@:6UP;W)T(')E9VES=&5R7VQI8G-T9&-X>%]X;65T:&]D
M<PH@("`@("`@(')E9VES=&5R7VQI8G-T9&-X>%]X;65T:&]D<RAO8FHI"@``
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````"XO<'ET:&]N+VQI8G-T9&-X>"]V-B]P<FEN=&5R<RYP
M>0``````````````````````````````````````````````````````````
M```````````````````````````````P,#`P-C8T`#`P,#$W-3``,#`P,3<U
M,``P,#`P,#(R,C8T-0`Q,S<Q,S0U,C8V,P`P,3<Q-S(`(#``````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M=7-T87(@(`!F:F%R9&]N`````````````````````````````````&9J87)D
M;VX`````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````(R!0<F5T='DM<')I;G1E
M<G,@9F]R(&QI8G-T9&,K*RX*"B,@0V]P>7)I9VAT("A#*2`R,#`X+3(P,C`@
M1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N+"!);F,N"@HC(%1H:7,@<')O9W)A
M;2!I<R!F<F5E('-O9G1W87)E.R!Y;W4@8V%N(')E9&ES=')I8G5T92!I="!A
M;F0O;W(@;6]D:69Y"B,@:70@=6YD97(@=&AE('1E<FUS(&]F('1H92!'3E4@
M1V5N97)A;"!0=6)L:6,@3&EC96YS92!A<R!P=6)L:7-H960@8GD*(R!T:&4@
M1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N.R!E:71H97(@=F5R<VEO;B`S(&]F
M('1H92!,:6-E;G-E+"!O<@HC("AA="!Y;W5R(&]P=&EO;BD@86YY(&QA=&5R
M('9E<G-I;VXN"B,*(R!4:&ES('!R;V=R86T@:7,@9&ES=')I8G5T960@:6X@
M=&AE(&AO<&4@=&AA="!I="!W:6QL(&)E('5S969U;"P*(R!B=70@5TE42$]5
M5"!!3ED@5T%24D%.5%D[('=I=&AO=70@979E;B!T:&4@:6UP;&EE9"!W87)R
M86YT>2!O9@HC($U%4D-(04Y404))3$E462!O<B!&251.15-3($9/4B!!(%!!
M4E1)0U5,05(@4%524$]312X@(%-E92!T:&4*(R!'3E4@1V5N97)A;"!0=6)L
M:6,@3&EC96YS92!F;W(@;6]R92!D971A:6QS+@HC"B,@66]U('-H;W5L9"!H
M879E(')E8V5I=F5D(&$@8V]P>2!O9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC
M($QI8V5N<V4*(R!A;&]N9R!W:71H('1H:7,@<')O9W)A;2X@($EF(&YO="P@
M<V5E(#QH='1P.B\O=W=W+F=N=2YO<F<O;&EC96YS97,O/BX*"FEM<&]R="!G
M9&(*:6UP;W)T(&ET97)T;V]L<PII;7!O<G0@<F4*:6UP;W)T('-Y<PH*(R,C
M(%!Y=&AO;B`R("L@4'ET:&]N(#,@8V]M<&%T:6)I;&ET>2!C;V1E"@HC(%)E
M<V]U<F-E<R!A8F]U="!C;VUP871I8FEL:71Y.@HC"B,@("H@/&AT='`Z+R]P
M>71H;VYH;W-T960N;W)G+W-I>"\^.B!$;V-U;65N=&%T:6]N(&]F('1H92`B
M<VEX(B!M;V1U;&4*"B,@1DE8344Z(%1H92!H86YD;&EN9R!O9B!E+F<N('-T
M9#HZ8F%S:6-?<W1R:6YG("AA="!L96%S="!O;B!C:&%R*0HC('!R;V)A8FQY
M(&YE961S('5P9&%T:6YG('1O('=O<FL@=VET:"!0>71H;VX@,R=S(&YE=R!S
M=')I;F<@<G5L97,N"B,*(R!);B!P87)T:6-U;&%R+"!0>71H;VX@,R!H87,@
M82!S97!A<F%T92!T>7!E("AC86QL960@8GET92D@9F]R"B,@8GET97-T<FEN
M9W,L(&%N9"!A('-P96-I86P@8B(B('-Y;G1A>"!F;W(@=&AE(&)Y=&4@;&ET
M97)A;',[('1H92!O;&0*(R!S='(H*2!T>7!E(&AA<R!B965N(')E9&5F:6YE
M9"!T;R!A;'=A>7,@<W1O<F4@56YI8V]D92!T97AT+@HC"B,@5V4@<')O8F%B
M;'D@8V%N)W0@9&\@;75C:"!A8F]U="!T:&ES('5N=&EL('1H:7,@1T1"(%!2
M(&ES(&%D9')E<W-E9#H*(R`\:'1T<',Z+R]S;W5R8V5W87)E+F]R9R]B=6=Z
M:6QL82]S:&]W7V)U9RYC9VD_:60],3<Q,S@^"@II9B!S>7,N=F5R<VEO;E]I
M;F9O6S!=(#X@,CH*("`@(",C(R!0>71H;VX@,R!S='5F9@H@("`@271E<F%T
M;W(@/2!O8FIE8W0*("`@(",@4'ET:&]N(#,@9F]L9',@=&AE<V4@:6YT;R!T
M:&4@;F]R;6%L(&9U;F-T:6]N<RX*("`@(&EM87`@/2!M87`*("`@(&EZ:7`@
M/2!Z:7`*("`@(",@06QS;RP@:6YT('-U8G-U;65S(&QO;F<*("`@(&QO;F<@
M/2!I;G0*96QS93H*("`@(",C(R!0>71H;VX@,B!S='5F9@H@("`@8VQA<W,@
M271E<F%T;W(Z"B`@("`@("`@(B(B0V]M<&%T:6)I;&ET>2!M:7AI;B!F;W(@
M:71E<F%T;W)S"@H@("`@("`@($EN<W1E860@;V8@=W)I=&EN9R!N97AT*"D@
M;65T:&]D<R!F;W(@:71E<F%T;W)S+"!W<FET90H@("`@("`@(%]?;F5X=%]?
M*"D@;65T:&]D<R!A;F0@=7-E('1H:7,@;6EX:6X@=&\@;6%K92!T:&5M('=O
M<FL@:6X*("`@("`@("!0>71H;VX@,B!A<R!W96QL(&%S(%!Y=&AO;B`S+@H*
M("`@("`@("!)9&5A('-T;VQE;B!F<F]M('1H92`B<VEX(B!D;V-U;65N=&%T
M:6]N.@H@("`@("`@(#QH='1P.B\O<'ET:&]N:&]S=&5D+F]R9R]S:7@O(W-I
M>"Y)=&5R871O<CX*("`@("`@("`B(B(*"B`@("`@("`@9&5F(&YE>'0H<V5L
M9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF+E]?;F5X=%]?*"D*"B`@("`C
M($EN(%!Y=&AO;B`R+"!W92!S=&EL;"!N965D('1H97-E(&9R;VT@:71E<G1O
M;VQS"B`@("!F<F]M(&ET97)T;V]L<R!I;7!O<G0@:6UA<"P@:7II<`H*(R!4
M<GD@=&\@=7-E('1H92!N97<M<W1Y;&4@<')E='1Y+7!R:6YT:6YG(&EF(&%V
M86EL86)L92X*7W5S95]G9&)?<'`@/2!4<G5E"G1R>3H*("`@(&EM<&]R="!G
M9&(N<')I;G1I;F<*97AC97!T($EM<&]R=$5R<F]R.@H@("`@7W5S95]G9&)?
M<'`@/2!&86QS90H*(R!4<GD@=&\@:6YS=&%L;"!T>7!E+7!R:6YT97)S+@I?
M=7-E7W1Y<&5?<')I;G1I;F<@/2!&86QS90IT<GDZ"B`@("!I;7!O<G0@9V1B
M+G1Y<&5S"B`@("!I9B!H87-A='1R*&=D8BYT>7!E<RP@)U1Y<&50<FEN=&5R
M)RDZ"B`@("`@("`@7W5S95]T>7!E7W!R:6YT:6YG(#T@5')U90IE>&-E<'0@
M26UP;W)T17)R;W(Z"B`@("!P87-S"@HC(%-T87)T:6YG('=I=&@@=&AE('1Y
M<&4@3U))1RP@<V5A<F-H(&9O<B!T:&4@;65M8F5R('1Y<&4@3D%-12X@(%1H
M:7,*(R!H86YD;&5S('-E87)C:&EN9R!U<'=A<F0@=&AR;W5G:"!S=7!E<F-L
M87-S97,N("!4:&ES(&ES(&YE961E9"!T;PHC('=O<FL@87)O=6YD(&AT='`Z
M+R]S;W5R8V5W87)E+F]R9R]B=6=Z:6QL82]S:&]W7V)U9RYC9VD_:60],3,V
M,34N"F1E9B!F:6YD7W1Y<&4H;W)I9RP@;F%M92DZ"B`@("!T>7`@/2!O<FEG
M+G-T<FEP7W1Y<&5D969S*"D*("`@('=H:6QE(%1R=64Z"B`@("`@("`@(R!3
M=')I<"!C=BUQ=6%L:69I97)S+B`@4%(@-C<T-#`N"B`@("`@("`@<V5A<F-H
M(#T@)R5S.CHE<R<@)2`H='EP+G5N<75A;&EF:65D*"DL(&YA;64I"B`@("`@
M("`@=')Y.@H@("`@("`@("`@("!R971U<FX@9V1B+FQO;VMU<%]T>7!E*'-E
M87)C:"D*("`@("`@("!E>&-E<'0@4G5N=&EM945R<F]R.@H@("`@("`@("`@
M("!P87-S"B`@("`@("`@(R!4:&4@='EP92!W87,@;F]T(&9O=6YD+"!S;R!T
M<GD@=&AE('-U<&5R8VQA<W,N("!792!O;FQY(&YE960*("`@("`@("`C('1O
M(&-H96-K('1H92!F:7)S="!S=7!E<F-L87-S+"!S;R!W92!D;VXG="!B;W1H
M97(@=VET:`H@("`@("`@(",@86YY=&AI;F<@9F%N8VEE<B!H97)E+@H@("`@
M("`@(&9I96QD<R`]('1Y<"YF:65L9',H*0H@("`@("`@(&EF(&QE;BAF:65L
M9',I(&%N9"!F:65L9'-;,%TN:7-?8F%S95]C;&%S<SH*("`@("`@("`@("`@
M='EP(#T@9FEE;&1S6S!=+G1Y<&4*("`@("`@("!E;'-E.@H@("`@("`@("`@
M("!R86ES92!686QU945R<F]R*")#86YN;W0@9FEN9"!T>7!E("5S.CHE<R(@
M)2`H<W1R*&]R:6<I+"!N86UE*2D*"E]V97)S:6]N961?;F%M97-P86-E(#T@
M)U]?.#HZ)PH*9&5F(&QO;VMU<%]T96UP;%]S<&5C*'1E;7!L+"`J87)G<RDZ
M"B`@("`B(B(*("`@($QO;VMU<"!T96UP;&%T92!S<&5C:6%L:7IA=&EO;B!T
M96UP;#QA<F=S+BXN/@H@("`@(B(B"B`@("!T(#T@)WM]/'M]/B<N9F]R;6%T
M*'1E;7!L+"`G+"`G+FIO:6XH6W-T<BAA*2!F;W(@82!I;B!A<F=S72DI"B`@
M("!T<GDZ"B`@("`@("`@<F5T=7)N(&=D8BYL;V]K=7!?='EP92AT*0H@("`@
M97AC97!T(&=D8BYE<G)O<B!A<R!E.@H@("`@("`@(",@5'EP92!N;W0@9F]U
M;F0L('1R>2!A9V%I;B!I;B!V97)S:6]N960@;F%M97-P86-E+@H@("`@("`@
M(&=L;V)A;"!?=F5R<VEO;F5D7VYA;65S<&%C90H@("`@("`@(&EF(%]V97)S
M:6]N961?;F%M97-P86-E(&%N9"!?=F5R<VEO;F5D7VYA;65S<&%C92!N;W0@
M:6X@=&5M<&PZ"B`@("`@("`@("`@('0@/2!T+G)E<&QA8V4H)SHZ)RP@)SHZ
M)R`K(%]V97)S:6]N961?;F%M97-P86-E+"`Q*0H@("`@("`@("`@("!T<GDZ
M"B`@("`@("`@("`@("`@("!R971U<FX@9V1B+FQO;VMU<%]T>7!E*'0I"B`@
M("`@("`@("`@(&5X8V5P="!G9&(N97)R;W(Z"B`@("`@("`@("`@("`@("`C
M($EF('1H870@86QS;R!F86EL<RP@<F5T:')O=R!T:&4@;W)I9VEN86P@97AC
M97!T:6]N"B`@("`@("`@("`@("`@("!P87-S"B`@("`@("`@<F%I<V4@90H*
M(R!5<V4@=&AI<R!T;R!F:6YD(&-O;G1A:6YE<B!N;V1E('1Y<&5S(&EN<W1E
M860@;V8@9FEN9%]T>7!E+`HC('-E92!H='1P<SHO+V=C8RYG;G4N;W)G+V)U
M9WII;&QA+W-H;W=?8G5G+F-G:3]I9#TY,3DY-R!F;W(@9&5T86EL<RX*9&5F
M(&QO;VMU<%]N;V1E7W1Y<&4H;F]D96YA;64L(&-O;G1A:6YE<G1Y<&4I.@H@
M("`@(B(B"B`@("!,;V]K=7`@<W!E8VEA;&EZ871I;VX@;V8@=&5M<&QA=&4@
M3D]$14Y!344@8V]R<F5S<&]N9&EN9R!T;R!#3TY404E.15)465!%+@H@("`@
M92YG+B!I9B!.3T1%3D%-12!I<R`G7TQI<W1?;F]D92<@86YD($-/3E1!24Y%
M4E194$4@:7,@<W1D.CIL:7-T/&EN=#X*("`@('1H96X@<F5T=7)N('1H92!T
M>7!E('-T9#HZ7TQI<W1?;F]D93QI;G0^+@H@("`@4F5T=7)N<R!.;VYE(&EF
M(&YO="!F;W5N9"X*("`@("(B(@H@("`@(R!)9B!N;V1E;F%M92!I<R!U;G%U
M86QI9FEE9"P@87-S=6UE(&ET)W,@:6X@;F%M97-P86-E('-T9"X*("`@(&EF
M("<Z.B<@;F]T(&EN(&YO9&5N86UE.@H@("`@("`@(&YO9&5N86UE(#T@)W-T
M9#HZ)R`K(&YO9&5N86UE"B`@("!T<GDZ"B`@("`@("`@=F%L='EP92`](&9I
M;F1?='EP92AC;VYT86EN97)T>7!E+"`G=F%L=65?='EP92<I"B`@("!E>&-E
M<'0Z"B`@("`@("`@=F%L='EP92`](&-O;G1A:6YE<G1Y<&4N=&5M<&QA=&5?
M87)G=6UE;G0H,"D*("`@('9A;'1Y<&4@/2!V86QT>7!E+G-T<FEP7W1Y<&5D
M969S*"D*("`@('1R>3H*("`@("`@("!R971U<FX@;&]O:W5P7W1E;7!L7W-P
M96,H;F]D96YA;64L('9A;'1Y<&4I"B`@("!E>&-E<'0@9V1B+F5R<F]R(&%S
M(&4Z"B`@("`@("`@(R!&;W(@9&5B=6<@;6]D92!C;VYT86EN97)S('1H92!N
M;V1E(&ES(&EN('-T9#HZ7U]C>'@Q.3DX+@H@("`@("`@(&EF(&ES7VUE;6)E
M<E]O9E]N86UE<W!A8V4H;F]D96YA;64L("=S=&0G*3H*("`@("`@("`@("`@
M:68@:7-?;65M8F5R7V]F7VYA;65S<&%C92AC;VYT86EN97)T>7!E+"`G<W1D
M.CI?7V-X>#$Y.3@G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("=S=&0Z.E]?9&5B=6<G+"`G7U]G;G5?9&5B=6<G*3H*("`@("`@
M("`@("`@("`@(&YO9&5N86UE(#T@;F]D96YA;64N<F5P;&%C92@G.CHG+"`G
M.CI?7V-X>#$Y.3@Z.B<L(#$I"B`@("`@("`@("`@("`@("!T<GDZ"B`@("`@
M("`@("`@("`@("`@("`@<F5T=7)N(&QO;VMU<%]T96UP;%]S<&5C*&YO9&5N
M86UE+"!V86QT>7!E*0H@("`@("`@("`@("`@("`@97AC97!T(&=D8BYE<G)O
M<CH*("`@("`@("`@("`@("`@("`@("!P87-S"B`@("`@("`@<F5T=7)N($YO
M;F4*"F1E9B!I<U]M96UB97)?;V9?;F%M97-P86-E*'1Y<"P@*FYA;65S<&%C
M97,I.@H@("`@(B(B"B`@("!497-T('=H971H97(@82!T>7!E(&ES(&$@;65M
M8F5R(&]F(&]N92!O9B!T:&4@<W!E8VEF:65D(&YA;65S<&%C97,N"B`@("!4
M:&4@='EP92!C86X@8F4@<W!E8VEF:65D(&%S(&$@<W1R:6YG(&]R(&$@9V1B
M+E1Y<&4@;V)J96-T+@H@("`@(B(B"B`@("!I9B!T>7!E*'1Y<"D@:7,@9V1B
M+E1Y<&4Z"B`@("`@("`@='EP(#T@<W1R*'1Y<"D*("`@('1Y<"`]('-T<FEP
M7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP*0H@("`@9F]R(&YA;65S<&%C92!I
M;B!N86UE<W!A8V5S.@H@("`@("`@(&EF('1Y<"YS=&%R='-W:71H*&YA;65S
M<&%C92`K("<Z.B<I.@H@("`@("`@("`@("!R971U<FX@5')U90H@("`@<F5T
M=7)N($9A;'-E"@ID968@:7-?<W!E8VEA;&EZ871I;VY?;V8H>"P@=&5M<&QA
M=&5?;F%M92DZ"B`@("`B5&5S="!I9B!A('1Y<&4@:7,@82!G:79E;B!T96UP
M;&%T92!I;G-T86YT:6%T:6]N+B(*("`@(&=L;V)A;"!?=F5R<VEO;F5D7VYA
M;65S<&%C90H@("`@:68@='EP92AX*2!I<R!G9&(N5'EP93H*("`@("`@("!X
M(#T@>"YT86<*("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@
M(')E='5R;B!R92YM871C:"@G7G-T9#HZ*"5S*3\E<SPN*CXD)R`E("A?=F5R
M<VEO;F5D7VYA;65S<&%C92P@=&5M<&QA=&5?;F%M92DL('@I(&ES(&YO="!.
M;VYE"B`@("!R971U<FX@<F4N;6%T8V@H)UYS=&0Z.B5S/"XJ/B0G("4@=&5M
M<&QA=&5?;F%M92P@>"D@:7,@;F]T($YO;F4*"F1E9B!S=')I<%]V97)S:6]N
M961?;F%M97-P86-E*'1Y<&5N86UE*3H*("`@(&=L;V)A;"!?=F5R<VEO;F5D
M7VYA;65S<&%C90H@("`@:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@
M("`@<F5T=7)N('1Y<&5N86UE+G)E<&QA8V4H7W9E<G-I;VYE9%]N86UE<W!A
M8V4L("<G*0H@("`@<F5T=7)N('1Y<&5N86UE"@ID968@<W1R:7!?:6YL:6YE
M7VYA;65S<&%C97,H='EP95]S='(I.@H@("`@(E)E;6]V92!K;F]W;B!I;FQI
M;F4@;F%M97-P86-E<R!F<F]M('1H92!C86YO;FEC86P@;F%M92!O9B!A('1Y
M<&4N(@H@("`@='EP95]S='(@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E
M*'1Y<&5?<W1R*0H@("`@='EP95]S='(@/2!T>7!E7W-T<BYR97!L86-E*"=S
M=&0Z.E]?8WAX,3$Z.B<L("=S=&0Z.B<I"B`@("!E>'!T7VYS(#T@)W-T9#HZ
M97AP97)I;65N=&%L.CHG"B`@("!F;W(@;&9T<U]N<R!I;B`H)V9U;F1A;65N
M=&%L<U]V,2<L("=F=6YD86UE;G1A;'-?=C(G*3H*("`@("`@("!T>7!E7W-T
M<B`]('1Y<&5?<W1R+G)E<&QA8V4H97AP=%]N<RML9G1S7VYS*R<Z.B<L(&5X
M<'1?;G,I"B`@("!F<U]N<R`](&5X<'1?;G,@*R`G9FEL97-Y<W1E;3HZ)PH@
M("`@='EP95]S='(@/2!T>7!E7W-T<BYR97!L86-E*&9S7VYS*R=V,3HZ)RP@
M9G-?;G,I"B`@("!R971U<FX@='EP95]S='(*"F1E9B!G971?=&5M<&QA=&5?
M87)G7VQI<W0H='EP95]O8FHI.@H@("`@(E)E='5R;B!A('1Y<&4G<R!T96UP
M;&%T92!A<F=U;65N=',@87,@82!L:7-T(@H@("`@;B`](#`*("`@('1E;7!L
M871E7V%R9W,@/2!;70H@("`@=VAI;&4@5')U93H*("`@("`@("!T<GDZ"B`@
M("`@("`@("`@('1E;7!L871E7V%R9W,N87!P96YD*'1Y<&5?;V)J+G1E;7!L
M871E7V%R9W5M96YT*&XI*0H@("`@("`@(&5X8V5P=#H*("`@("`@("`@("`@
M<F5T=7)N('1E;7!L871E7V%R9W,*("`@("`@("!N("L](#$*"F-L87-S(%-M
M87)T4'1R271E<F%T;W(H271E<F%T;W(I.@H@("`@(D%N(&ET97)A=&]R(&9O
M<B!S;6%R="!P;VEN=&5R('1Y<&5S('=I=&@@82!S:6YG;&4@)V-H:6QD)R!V
M86QU92(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L*3H*("`@("`@("!S
M96QF+G9A;"`]('9A;`H*("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@
M("!R971U<FX@<V5L9@H*("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@
M("!I9B!S96QF+G9A;"!I<R!.;VYE.@H@("`@("`@("`@("!R86ES92!3=&]P
M271E<F%T:6]N"B`@("`@("`@<V5L9BYV86PL('9A;"`]($YO;F4L('-E;&8N
M=F%L"B`@("`@("`@<F5T=7)N("@G9V5T*"DG+"!V86PI"@IC;&%S<R!3:&%R
M9610;VEN=&5R4')I;G1E<CH*("`@(")0<FEN="!A('-H87)E9%]P='(@;W(@
M=V5A:U]P='(B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@
M=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D
M7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H@
M("`@("`@('-E;&8N<&]I;G1E<B`]('9A;%LG7TU?<'1R)UT*"B`@("!D968@
M8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(')E='5R;B!3;6%R=%!T<DET97)A
M=&]R*'-E;&8N<&]I;G1E<BD*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*
M("`@("`@("!S=&%T92`]("=E;7!T>2<*("`@("`@("!R969C;W5N=',@/2!S
M96QF+G9A;%LG7TU?<F5F8V]U;G0G75LG7TU?<&DG70H@("`@("`@(&EF(')E
M9F-O=6YT<R`A/2`P.@H@("`@("`@("`@("!U<V5C;W5N="`](')E9F-O=6YT
M<ULG7TU?=7-E7V-O=6YT)UT*("`@("`@("`@("`@=V5A:V-O=6YT(#T@<F5F
M8V]U;G1S6R=?35]W96%K7V-O=6YT)UT*("`@("`@("`@("`@:68@=7-E8V]U
M;G0@/3T@,#H*("`@("`@("`@("`@("`@('-T871E(#T@)V5X<&ER960L('=E
M86L@8V]U;G0@)60G("4@=V5A:V-O=6YT"B`@("`@("`@("`@(&5L<V4Z"B`@
M("`@("`@("`@("`@("!S=&%T92`]("=U<V4@8V]U;G0@)60L('=E86L@8V]U
M;G0@)60G("4@*'5S96-O=6YT+"!W96%K8V]U;G0@+2`Q*0H@("`@("`@(')E
M='5R;B`G)7,\)7,^("@E<RDG("4@*'-E;&8N='EP96YA;64L('-T<BAS96QF
M+G9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I*2P@<W1A=&4I"@IC;&%S
M<R!5;FEQ=650;VEN=&5R4')I;G1E<CH*("`@(")0<FEN="!A('5N:7%U95]P
M='(B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*
M("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@(&EM<&Q?='EP92`]('9A
M;"YT>7!E+F9I96QD<R@I6S!=+G1Y<&4N=&%G"B`@("`@("`@(R!#:&5C:R!F
M;W(@;F5W(&EM<&QE;65N=&%T:6]N<R!F:7)S=#H*("`@("`@("!I9B!I<U]S
M<&5C:6%L:7IA=&EO;E]O9BAI;7!L7W1Y<&4L("=?7W5N:7%?<'1R7V1A=&$G
M*2!<"B`@("`@("`@("`@(&]R(&ES7W-P96-I86QI>F%T:6]N7V]F*&EM<&Q?
M='EP92P@)U]?=6YI<5]P=')?:6UP;"<I.@H@("`@("`@("`@("!T=7!L95]M
M96UB97(@/2!V86Q;)U]-7W0G75LG7TU?="=="B`@("`@("`@96QI9B!I<U]S
M<&5C:6%L:7IA=&EO;E]O9BAI;7!L7W1Y<&4L("=T=7!L92<I.@H@("`@("`@
M("`@("!T=7!L95]M96UB97(@/2!V86Q;)U]-7W0G70H@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@(')A:7-E(%9A;'5E17)R;W(H(E5N<W5P<&]R=&5D(&EM
M<&QE;65N=&%T:6]N(&9O<B!U;FEQ=65?<'1R.B`E<R(@)2!I;7!L7W1Y<&4I
M"B`@("`@("`@='5P;&5?:6UP;%]T>7!E(#T@='5P;&5?;65M8F5R+G1Y<&4N
M9FEE;&1S*"E;,%TN='EP92`C(%]4=7!L95]I;7!L"B`@("`@("`@='5P;&5?
M:&5A9%]T>7!E(#T@='5P;&5?:6UP;%]T>7!E+F9I96QD<R@I6S%=+G1Y<&4@
M("`C(%](96%D7V)A<V4*("`@("`@("!H96%D7V9I96QD(#T@='5P;&5?:&5A
M9%]T>7!E+F9I96QD<R@I6S!="B`@("`@("`@:68@:&5A9%]F:65L9"YN86UE
M(#T]("=?35]H96%D7VEM<&PG.@H@("`@("`@("`@("!S96QF+G!O:6YT97(@
M/2!T=7!L95]M96UB97);)U]-7VAE861?:6UP;"=="B`@("`@("`@96QI9B!H
M96%D7V9I96QD+FES7V)A<V5?8VQA<W,Z"B`@("`@("`@("`@('-E;&8N<&]I
M;G1E<B`]('1U<&QE7VUE;6)E<BYC87-T*&AE861?9FEE;&0N='EP92D*("`@
M("`@("!E;'-E.@H@("`@("`@("`@("!R86ES92!686QU945R<F]R*")5;G-U
M<'!O<G1E9"!I;7!L96UE;G1A=&EO;B!F;W(@='5P;&4@:6X@=6YI<75E7W!T
M<CH@)7,B("4@:6UP;%]T>7!E*0H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ
M"B`@("`@("`@<F5T=7)N(%-M87)T4'1R271E<F%T;W(H<V5L9BYP;VEN=&5R
M*0H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@(')E='5R;B`H
M)W-T9#HZ=6YI<75E7W!T<CPE<SXG("4@*'-T<BAS96QF+G9A;"YT>7!E+G1E
M;7!L871E7V%R9W5M96YT*#`I*2DI"@ID968@9V5T7W9A;'5E7V9R;VU?86QI
M9VYE9%]M96UB=68H8G5F+"!V86QT>7!E*3H*("`@("(B(E)E='5R;G,@=&AE
M('9A;'5E(&AE;&0@:6X@82!?7V=N=5]C>'@Z.E]?86QI9VYE9%]M96UB=68N
M(B(B"B`@("!R971U<FX@8G5F6R=?35]S=&]R86=E)UTN861D<F5S<RYC87-T
M*'9A;'1Y<&4N<&]I;G1E<B@I*2YD97)E9F5R96YC92@I"@ID968@9V5T7W9A
M;'5E7V9R;VU?;&ES=%]N;V1E*&YO9&4I.@H@("`@(B(B4F5T=7)N<R!T:&4@
M=F%L=64@:&5L9"!I;B!A;B!?3&ES=%]N;V1E/%]686P^(B(B"B`@("!T<GDZ
M"B`@("`@("`@;65M8F5R(#T@;F]D92YT>7!E+F9I96QD<R@I6S%=+FYA;64*
M("`@("`@("!I9B!M96UB97(@/3T@)U]-7V1A=&$G.@H@("`@("`@("`@("`C
M($,K*S`S(&EM<&QE;65N=&%T:6]N+"!N;V1E(&-O;G1A:6YS('1H92!V86QU
M92!A<R!A(&UE;6)E<@H@("`@("`@("`@("!R971U<FX@;F]D95LG7TU?9&%T
M82=="B`@("`@("`@96QI9B!M96UB97(@/3T@)U]-7W-T;W)A9V4G.@H@("`@
M("`@("`@("`C($,K*S$Q(&EM<&QE;65N=&%T:6]N+"!N;V1E('-T;W)E<R!V
M86QU92!I;B!?7V%L:6=N961?;65M8G5F"B`@("`@("`@("`@('9A;'1Y<&4@
M/2!N;V1E+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("`@("`@
M<F5T=7)N(&=E=%]V86QU95]F<F]M7V%L:6=N961?;65M8G5F*&YO9&5;)U]-
M7W-T;W)A9V4G72P@=F%L='EP92D*("`@(&5X8V5P=#H*("`@("`@("!P87-S
M"B`@("!R86ES92!686QU945R<F]R*")5;G-U<'!O<G1E9"!I;7!L96UE;G1A
M=&EO;B!F;W(@)7,B("4@<W1R*&YO9&4N='EP92DI"@IC;&%S<R!3=&1,:7-T
M4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ;&ES="(*"B`@("!C;&%S<R!?
M:71E<F%T;W(H271E<F%T;W(I.@H@("`@("`@(&1E9B!?7VEN:71?7RAS96QF
M+"!N;V1E='EP92P@:&5A9"DZ"B`@("`@("`@("`@('-E;&8N;F]D971Y<&4@
M/2!N;V1E='EP90H@("`@("`@("`@("!S96QF+F)A<V4@/2!H96%D6R=?35]N
M97AT)UT*("`@("`@("`@("`@<V5L9BYH96%D(#T@:&5A9"YA9&1R97-S"B`@
M("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?
M7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F
M(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF+F)A<V4@/3T@
M<V5L9BYH96%D.@H@("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO
M;@H@("`@("`@("`@("!E;'0@/2!S96QF+F)A<V4N8V%S="AS96QF+FYO9&5T
M>7!E*2YD97)E9F5R96YC92@I"B`@("`@("`@("`@('-E;&8N8F%S92`](&5L
M=%LG7TU?;F5X="=="B`@("`@("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@
M("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@
M("`@("`@=F%L(#T@9V5T7W9A;'5E7V9R;VU?;&ES=%]N;V1E*&5L="D*("`@
M("`@("`@("`@<F5T=7)N("@G6R5D72<@)2!C;W5N="P@=F%L*0H*("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF
M+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M
M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!C:&EL9')E;BAS
M96QF*3H*("`@("`@("!N;V1E='EP92`](&QO;VMU<%]N;V1E7W1Y<&4H)U],
M:7-T7VYO9&4G+"!S96QF+G9A;"YT>7!E*2YP;VEN=&5R*"D*("`@("`@("!R
M971U<FX@<V5L9BY?:71E<F%T;W(H;F]D971Y<&4L('-E;&8N=F%L6R=?35]I
M;7!L)UU;)U]-7VYO9&4G72D*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I.@H@
M("`@("`@(&AE861N;V1E(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?;F]D
M92=="B`@("`@("`@:68@:&5A9&YO9&5;)U]-7VYE>'0G72`]/2!H96%D;F]D
M92YA9&1R97-S.@H@("`@("`@("`@("!R971U<FX@)V5M<'1Y("5S)R`E("AS
M96QF+G1Y<&5N86UE*0H@("`@("`@(')E='5R;B`G)7,G("4@*'-E;&8N='EP
M96YA;64I"@IC;&%S<R!.;V1E271E<F%T;W)0<FEN=&5R.@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PL(&-O;G1N86UE+"!N;V1E;F%M
M92DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N
M86UE(#T@='EP96YA;64*("`@("`@("!S96QF+F-O;G1N86UE(#T@8V]N=&YA
M;64*("`@("`@("!S96QF+FYO9&5T>7!E(#T@;&]O:W5P7VYO9&5?='EP92AN
M;V1E;F%M92P@=F%L+G1Y<&4I"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*
M("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-7VYO9&4G73H*("`@("`@("`@
M("`@<F5T=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S
M=&0Z.B5S)R`E("AS96QF+F-O;G1N86UE*0H@("`@("`@(&YO9&4@/2!S96QF
M+G9A;%LG7TU?;F]D92==+F-A<W0H<V5L9BYN;V1E='EP92YP;VEN=&5R*"DI
M+F1E<F5F97)E;F-E*"D*("`@("`@("!R971U<FX@<W1R*&=E=%]V86QU95]F
M<F]M7VQI<W1?;F]D92AN;V1E*2D*"F-L87-S(%-T9$QI<W1)=&5R871O<E!R
M:6YT97(H3F]D94ET97)A=&]R4')I;G1E<BDZ"B`@("`B4')I;G0@<W1D.CIL
M:7-T.CII=&5R871O<B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA
M;64L('9A;"DZ"B`@("`@("`@3F]D94ET97)A=&]R4')I;G1E<BY?7VEN:71?
M7RAS96QF+"!T>7!E;F%M92P@=F%L+"`G;&ES="<L("=?3&ES=%]N;V1E)RD*
M"F-L87-S(%-T9$9W9$QI<W1)=&5R871O<E!R:6YT97(H3F]D94ET97)A=&]R
M4')I;G1E<BDZ"B`@("`B4')I;G0@<W1D.CIF;W)W87)D7VQI<W0Z.FET97)A
M=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*
M("`@("`@("!.;V1E271E<F%T;W)0<FEN=&5R+E]?:6YI=%]?*'-E;&8L('1Y
M<&5N86UE+"!V86PL("=F;W)W87)D7VQI<W0G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@)U]&=V1?;&ES=%]N;V1E)RD*"F-L87-S
M(%-T9%-L:7-T4')I;G1E<CH*("`@(")0<FEN="!A(%]?9VYU7V-X>#HZ<VQI
M<W0B"@H@("`@8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!D
M968@7U]I;FET7U\H<V5L9BP@;F]D971Y<&4L(&AE860I.@H@("`@("`@("`@
M("!S96QF+FYO9&5T>7!E(#T@;F]D971Y<&4*("`@("`@("`@("`@<V5L9BYB
M87-E(#T@:&5A9%LG7TU?:&5A9"==6R=?35]N97AT)UT*("`@("`@("`@("`@
M<V5L9BYC;W5N="`](#`*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@
M("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H
M<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N8F%S92`]/2`P.@H@("`@("`@
M("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!E;'0@
M/2!S96QF+F)A<V4N8V%S="AS96QF+FYO9&5T>7!E*2YD97)E9F5R96YC92@I
M"B`@("`@("`@("`@('-E;&8N8F%S92`](&5L=%LG7TU?;F5X="=="B`@("`@
M("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@("`@("`@("`@("!S96QF+F-O
M=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@("`@<F5T=7)N("@G6R5D
M72<@)2!C;W5N="P@96QT6R=?35]D871A)UTI"@H@("`@9&5F(%]?:6YI=%]?
M*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L
M"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(&YO9&5T>7!E(#T@
M;&]O:W5P7VYO9&5?='EP92@G7U]G;G5?8WAX.CI?4VQI<W1?;F]D92<L('-E
M;&8N=F%L+G1Y<&4I"B`@("`@("`@<F5T=7)N('-E;&8N7VET97)A=&]R*&YO
M9&5T>7!E+G!O:6YT97(H*2P@<V5L9BYV86PI"@H@("`@9&5F('1O7W-T<FEN
M9RAS96QF*3H*("`@("`@("!I9B!S96QF+G9A;%LG7TU?:&5A9"==6R=?35]N
M97AT)UT@/3T@,#H*("`@("`@("`@("`@<F5T=7)N("=E;7!T>2!?7V=N=5]C
M>'@Z.G-L:7-T)PH@("`@("`@(')E='5R;B`G7U]G;G5?8WAX.CIS;&ES="<*
M"F-L87-S(%-T9%-L:7-T271E<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT(%]?
M9VYU7V-X>#HZ<VQI<W0Z.FET97)A=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*
M("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@;F]T('-E;&8N
M=F%L6R=?35]N;V1E)UTZ"B`@("`@("`@("`@(')E='5R;B`G;F]N+61E<F5F
M97)E;F-E86)L92!I=&5R871O<B!F;W(@7U]G;G5?8WAX.CIS;&ES="<*("`@
M("`@("!N;V1E='EP92`](&QO;VMU<%]N;V1E7W1Y<&4H)U]?9VYU7V-X>#HZ
M7U-L:7-T7VYO9&4G+"!S96QF+G9A;"YT>7!E*2YP;VEN=&5R*"D*("`@("`@
M("!R971U<FX@<W1R*'-E;&8N=F%L6R=?35]N;V1E)UTN8V%S="AN;V1E='EP
M92DN9&5R969E<F5N8V4H*5LG7TU?9&%T82==*0H*8VQA<W,@4W1D5F5C=&]R
M4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ=F5C=&]R(@H*("`@(&-L87-S
M(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?("AS
M96QF+"!S=&%R="P@9FEN:7-H+"!B:71V96,I.@H@("`@("`@("`@("!S96QF
M+F)I='9E8R`](&)I='9E8PH@("`@("`@("`@("!I9B!B:71V96,Z"B`@("`@
M("`@("`@("`@("!S96QF+FET96T@("`]('-T87)T6R=?35]P)UT*("`@("`@
M("`@("`@("`@('-E;&8N<V\@("`@(#T@<W1A<G1;)U]-7V]F9G-E="=="B`@
M("`@("`@("`@("`@("!S96QF+F9I;FES:"`](&9I;FES:%LG7TU?<"=="B`@
M("`@("`@("`@("`@("!S96QF+F9O("`@("`](&9I;FES:%LG7TU?;V9F<V5T
M)UT*("`@("`@("`@("`@("`@(&ET>7!E(#T@<V5L9BYI=&5M+F1E<F5F97)E
M;F-E*"DN='EP90H@("`@("`@("`@("`@("`@<V5L9BYI<VEZ92`](#@@*B!I
M='EP92YS:7IE;V8*("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@
M('-E;&8N:71E;2`]('-T87)T"B`@("`@("`@("`@("`@("!S96QF+F9I;FES
M:"`](&9I;FES:`H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*("`@("`@
M("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF
M"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("`@("`@8V]U
M;G0@/2!S96QF+F-O=6YT"B`@("`@("`@("`@('-E;&8N8V]U;G0@/2!S96QF
M+F-O=6YT("L@,0H@("`@("`@("`@("!I9B!S96QF+F)I='9E8SH*("`@("`@
M("`@("`@("`@(&EF('-E;&8N:71E;2`]/2!S96QF+F9I;FES:"!A;F0@<V5L
M9BYS;R`^/2!S96QF+F9O.@H@("`@("`@("`@("`@("`@("`@(')A:7-E(%-T
M;W!)=&5R871I;VX*("`@("`@("`@("`@("`@(&5L="`](&)O;VPH<V5L9BYI
M=&5M+F1E<F5F97)E;F-E*"D@)B`H,2`\/"!S96QF+G-O*2D*("`@("`@("`@
M("`@("`@('-E;&8N<V\@/2!S96QF+G-O("L@,0H@("`@("`@("`@("`@("`@
M:68@<V5L9BYS;R`^/2!S96QF+FES:7IE.@H@("`@("`@("`@("`@("`@("`@
M('-E;&8N:71E;2`]('-E;&8N:71E;2`K(#$*("`@("`@("`@("`@("`@("`@
M("!S96QF+G-O(#T@,`H@("`@("`@("`@("`@("`@<F5T=7)N("@G6R5D72<@
M)2!C;W5N="P@96QT*0H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@
M("`@:68@<V5L9BYI=&5M(#T]('-E;&8N9FEN:7-H.@H@("`@("`@("`@("`@
M("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@("`@(&5L
M="`]('-E;&8N:71E;2YD97)E9F5R96YC92@I"B`@("`@("`@("`@("`@("!S
M96QF+FET96T@/2!S96QF+FET96T@*R`Q"B`@("`@("`@("`@("`@("!R971U
M<FX@*"=;)61=)R`E(&-O=6YT+"!E;'0I"@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S
M=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E
M;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYI<U]B;V]L(#T@=F%L+G1Y<&4N
M=&5M<&QA=&5?87)G=6UE;G0H,"DN8V]D92`]/2!G9&(N5%E015]#3T1%7T)/
M3TP*"B`@("!D968@8VAI;&1R96XH<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E
M;&8N7VET97)A=&]R*'-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UTL
M"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@('-E;&8N=F%L6R=?35]I
M;7!L)UU;)U]-7V9I;FES:"==+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("!S96QF+FES7V)O;VPI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*
M("`@("`@("!S=&%R="`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T
M)UT*("`@("`@("!F:6YI<V@@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F
M:6YI<V@G70H@("`@("`@(&5N9"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-
M7V5N9%]O9E]S=&]R86=E)UT*("`@("`@("!I9B!S96QF+FES7V)O;VPZ"B`@
M("`@("`@("`@('-T87)T(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A
M<G0G75LG7TU?<"=="B`@("`@("`@("`@('-O("`@(#T@<V5L9BYV86Q;)U]-
M7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?;V9F<V5T)UT*("`@("`@("`@("`@
M9FEN:7-H(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-
M7W`G70H@("`@("`@("`@("!F;R`@("`@/2!S96QF+G9A;%LG7TU?:6UP;"==
M6R=?35]F:6YI<V@G75LG7TU?;V9F<V5T)UT*("`@("`@("`@("`@:71Y<&4@
M/2!S=&%R="YD97)E9F5R96YC92@I+G1Y<&4*("`@("`@("`@("`@8FP@/2`X
M("H@:71Y<&4N<VEZ96]F"B`@("`@("`@("`@(&QE;F=T:"`@(#T@*&)L("T@
M<V\I("L@8FP@*B`H*&9I;FES:"`M('-T87)T*2`M(#$I("L@9F\*("`@("`@
M("`@("`@8V%P86-I='D@/2!B;"`J("AE;F0@+2!S=&%R="D*("`@("`@("`@
M("`@<F5T=7)N("@G)7,\8F]O;#X@;V8@;&5N9W1H("5D+"!C87!A8VET>2`E
M9"<*("`@("`@("`@("`@("`@("`@("`E("AS96QF+G1Y<&5N86UE+"!I;G0@
M*&QE;F=T:"DL(&EN="`H8V%P86-I='DI*2D*("`@("`@("!E;'-E.@H@("`@
M("`@("`@("!R971U<FX@*"<E<R!O9B!L96YG=&@@)60L(&-A<&%C:71Y("5D
M)PH@("`@("`@("`@("`@("`@("`@("4@*'-E;&8N='EP96YA;64L(&EN="`H
M9FEN:7-H("T@<W1A<G0I+"!I;G0@*&5N9"`M('-T87)T*2DI"@H@("`@9&5F
M(&1I<W!L87E?:&EN="AS96QF*3H*("`@("`@("!R971U<FX@)V%R<F%Y)PH*
M8VQA<W,@4W1D5F5C=&]R271E<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT('-T
M9#HZ=F5C=&]R.CII=&5R871O<B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@
M='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D
M968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(&EF(&YO="!S96QF+G9A;%LG
M7TU?8W5R<F5N="==.@H@("`@("`@("`@("!R971U<FX@)VYO;BUD97)E9F5R
M96YC96%B;&4@:71E<F%T;W(@9F]R('-T9#HZ=F5C=&]R)PH@("`@("`@(')E
M='5R;B!S='(H<V5L9BYV86Q;)U]-7V-U<G)E;G0G72YD97)E9F5R96YC92@I
M*0H*(R!43T1/(&%D9"!P<FEN=&5R(&9O<B!V96-T;W(\8F]O;#XG<R!?0FET
M7VET97)A=&]R(&%N9"!?0FET7V-O;G-T7VET97)A=&]R"@IC;&%S<R!3=&14
M=7!L95!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.G1U<&QE(@H*("`@(&-L
M87-S(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@0'-T871I8VUE=&AO
M9`H@("`@("`@(&1E9B!?:7-?;F]N96UP='E?='5P;&4@*&YO9&5S*3H*("`@
M("`@("`@("`@:68@;&5N("AN;V1E<RD@/3T@,CH*("`@("`@("`@("`@("`@
M(&EF(&ES7W-P96-I86QI>F%T:6]N7V]F("AN;V1E<ULQ72YT>7!E+"`G7U]T
M=7!L95]B87-E)RDZ"B`@("`@("`@("`@("`@("`@("`@<F5T=7)N(%1R=64*
M("`@("`@("`@("`@96QI9B!L96X@*&YO9&5S*2`]/2`Q.@H@("`@("`@("`@
M("`@("`@<F5T=7)N(%1R=64*("`@("`@("`@("`@96QI9B!L96X@*&YO9&5S
M*2`]/2`P.@H@("`@("`@("`@("`@("`@<F5T=7)N($9A;'-E"B`@("`@("`@
M("`@(')A:7-E(%9A;'5E17)R;W(H(E1O<"!O9B!T=7!L92!T<F5E(&1O97,@
M;F]T(&-O;G-I<W0@;V8@82!S:6YG;&4@;F]D92XB*0H*("`@("`@("!D968@
M7U]I;FET7U\@*'-E;&8L(&AE860I.@H@("`@("`@("`@("!S96QF+FAE860@
M/2!H96%D"@H@("`@("`@("`@("`C(%-E="!T:&4@8F%S92!C;&%S<R!A<R!T
M:&4@:6YI=&EA;"!H96%D(&]F('1H90H@("`@("`@("`@("`C('1U<&QE+@H@
M("`@("`@("`@("!N;V1E<R`]('-E;&8N:&5A9"YT>7!E+F9I96QD<R`H*0H@
M("`@("`@("`@("!I9B!S96QF+E]I<U]N;VYE;7!T>5]T=7!L92`H;F]D97,I
M.@H@("`@("`@("`@("`@("`@(R!3970@=&AE(&%C='5A;"!H96%D('1O('1H
M92!F:7)S="!P86ER+@H@("`@("`@("`@("`@("`@<V5L9BYH96%D("`]('-E
M;&8N:&5A9"YC87-T("AN;V1E<ULP72YT>7!E*0H@("`@("`@("`@("!S96QF
M+F-O=6YT(#T@,`H*("`@("`@("!D968@7U]I=&5R7U\@*'-E;&8I.@H@("`@
M("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\@*'-E
M;&8I.@H@("`@("`@("`@("`C($-H96-K(&9O<B!F=7)T:&5R(')E8W5R<VEO
M;G,@:6X@=&AE(&EN:&5R:71A;F-E('1R964N"B`@("`@("`@("`@(",@1F]R
M(&$@1T-#(#4K('1U<&QE('-E;&8N:&5A9"!I<R!.;VYE(&%F=&5R('9I<VET
M:6YG(&%L;"!N;V1E<SH*("`@("`@("`@("`@:68@;F]T('-E;&8N:&5A9#H*
M("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@
M("`@;F]D97,@/2!S96QF+FAE860N='EP92YF:65L9',@*"D*("`@("`@("`@
M("`@(R!&;W(@82!'0T,@-"YX('1U<&QE('1H97)E(&ES(&$@9FEN86P@;F]D
M92!W:71H(&YO(&9I96QD<SH*("`@("`@("`@("`@:68@;&5N("AN;V1E<RD@
M/3T@,#H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@
M("`@("`@("`@(R!#:&5C:R!T:&%T('1H:7,@:71E<F%T:6]N(&AA<R!A;B!E
M>'!E8W1E9"!S=')U8W1U<F4N"B`@("`@("`@("`@(&EF(&QE;B`H;F]D97,I
M(#X@,CH*("`@("`@("`@("`@("`@(')A:7-E(%9A;'5E17)R;W(H(D-A;FYO
M="!P87)S92!M;W)E('1H86X@,B!N;V1E<R!I;B!A('1U<&QE('1R964N(BD*
M"B`@("`@("`@("`@(&EF(&QE;B`H;F]D97,I(#T](#$Z"B`@("`@("`@("`@
M("`@("`C(%1H:7,@:7,@=&AE(&QA<W0@;F]D92!O9B!A($=#0R`U*R!S=&0Z
M.G1U<&QE+@H@("`@("`@("`@("`@("`@:6UP;"`]('-E;&8N:&5A9"YC87-T
M("AN;V1E<ULP72YT>7!E*0H@("`@("`@("`@("`@("`@<V5L9BYH96%D(#T@
M3F]N90H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@(R!%:71H
M97(@82!N;V1E(&)E9F]R92!T:&4@;&%S="!N;V1E+"!O<B!T:&4@;&%S="!N
M;V1E(&]F"B`@("`@("`@("`@("`@("`C(&$@1T-#(#0N>"!T=7!L92`H=VAI
M8V@@:&%S(&%N(&5M<'1Y('!A<F5N="DN"@H@("`@("`@("`@("`@("`@(R`M
M($QE9G0@;F]D92!I<R!T:&4@;F5X="!R96-U<G-I;VX@<&%R96YT+@H@("`@
M("`@("`@("`@("`@(R`M(%)I9VAT(&YO9&4@:7,@=&AE(&%C='5A;"!C;&%S
M<R!C;VYT86EN960@:6X@=&AE('1U<&QE+@H*("`@("`@("`@("`@("`@(",@
M4')O8V5S<R!R:6=H="!N;V1E+@H@("`@("`@("`@("`@("`@:6UP;"`]('-E
M;&8N:&5A9"YC87-T("AN;V1E<ULQ72YT>7!E*0H*("`@("`@("`@("`@("`@
M(",@4')O8V5S<R!L969T(&YO9&4@86YD('-E="!I="!A<R!H96%D+@H@("`@
M("`@("`@("`@("`@<V5L9BYH96%D("`]('-E;&8N:&5A9"YC87-T("AN;V1E
M<ULP72YT>7!E*0H*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U
M;G0@*R`Q"@H@("`@("`@("`@("`C($9I;F%L;'DL(&-H96-K('1H92!I;7!L
M96UE;G1A=&EO;BX@($EF(&ET(&ES"B`@("`@("`@("`@(",@=W)A<'!E9"!I
M;B!?35]H96%D7VEM<&P@<F5T=7)N('1H870L(&]T:&5R=VES92!R971U<FX*
M("`@("`@("`@("`@(R!T:&4@=F%L=64@(F%S(&ES(BX*("`@("`@("`@("`@
M9FEE;&1S(#T@:6UP;"YT>7!E+F9I96QD<R`H*0H@("`@("`@("`@("!I9B!L
M96X@*&9I96QD<RD@/"`Q(&]R(&9I96QD<ULP72YN86UE("$](")?35]H96%D
M7VEM<&PB.@H@("`@("`@("`@("`@("`@<F5T=7)N("@G6R5D72<@)2!S96QF
M+F-O=6YT+"!I;7!L*0H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@
M("`@<F5T=7)N("@G6R5D72<@)2!S96QF+F-O=6YT+"!I;7!L6R=?35]H96%D
M7VEM<&PG72D*"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V
M86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?
M;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L.PH*
M("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8N
M7VET97)A=&]R("AS96QF+G9A;"D*"B`@("!D968@=&]?<W1R:6YG("AS96QF
M*3H*("`@("`@("!I9B!L96X@*'-E;&8N=F%L+G1Y<&4N9FEE;&1S("@I*2`]
M/2`P.@H@("`@("`@("`@("!R971U<FX@)V5M<'1Y("5S)R`E("AS96QF+G1Y
M<&5N86UE*0H@("`@("`@(')E='5R;B`G)7,@8V]N=&%I;FEN9R<@)2`H<V5L
M9BYT>7!E;F%M92D*"F-L87-S(%-T9%-T86-K3W)1=65U95!R:6YT97(Z"B`@
M("`B4')I;G0@82!S=&0Z.G-T86-K(&]R('-T9#HZ<75E=64B"@H@("`@9&5F
M(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF
M+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M
M92D*("`@("`@("!S96QF+G9I<W5A;&EZ97(@/2!G9&(N9&5F875L=%]V:7-U
M86QI>F5R*'9A;%LG8R==*0H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N('-E;&8N=FES=6%L:7IE<BYC:&EL9')E;B@I"@H@("`@
M9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@<F5T=7)N("<E<R!W<F%P
M<&EN9SH@)7,G("4@*'-E;&8N='EP96YA;64L"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@('-E;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H
M*2D*"B`@("!D968@9&ES<&QA>5]H:6YT("AS96QF*3H*("`@("`@("!I9B!H
M87-A='1R("AS96QF+G9I<W5A;&EZ97(L("=D:7-P;&%Y7VAI;G0G*3H*("`@
M("`@("`@("`@<F5T=7)N('-E;&8N=FES=6%L:7IE<BYD:7-P;&%Y7VAI;G0@
M*"D*("`@("`@("!R971U<FX@3F]N90H*8VQA<W,@4F)T<F5E271E<F%T;W(H
M271E<F%T;W(I.@H@("`@(B(B"B`@("!4=7)N(&%N(%)"+71R964M8F%S960@
M8V]N=&%I;F5R("AS=&0Z.FUA<"P@<W1D.CIS970@971C+BD@:6YT;PH@("`@
M82!0>71H;VX@:71E<F%B;&4@;V)J96-T+@H@("`@(B(B"@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L(')B=')E92DZ"B`@("`@("`@<V5L9BYS:7IE(#T@<F)T
M<F5E6R=?35]T)UU;)U]-7VEM<&PG75LG7TU?;F]D95]C;W5N="=="B`@("`@
M("`@<V5L9BYN;V1E(#T@<F)T<F5E6R=?35]T)UU;)U]-7VEM<&PG75LG7TU?
M:&5A9&5R)UU;)U]-7VQE9G0G70H@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@
M("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF"@H@
M("`@9&5F(%]?;&5N7U\H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&EN="`H<V5L
M9BYS:7IE*0H*("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("!I9B!S
M96QF+F-O=6YT(#T]('-E;&8N<VEZ93H*("`@("`@("`@("`@<F%I<V4@4W1O
M<$ET97)A=&EO;@H@("`@("`@(')E<W5L="`]('-E;&8N;F]D90H@("`@("`@
M('-E;&8N8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@(&EF('-E;&8N
M8V]U;G0@/"!S96QF+G-I>F4Z"B`@("`@("`@("`@(",@0V]M<'5T92!T:&4@
M;F5X="!N;V1E+@H@("`@("`@("`@("!N;V1E(#T@<V5L9BYN;V1E"B`@("`@
M("`@("`@(&EF(&YO9&4N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G73H*("`@
M("`@("`@("`@("`@(&YO9&4@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7W)I
M9VAT)UT*("`@("`@("`@("`@("`@('=H:6QE(&YO9&4N9&5R969E<F5N8V4H
M*5LG7TU?;&5F="==.@H@("`@("`@("`@("`@("`@("`@(&YO9&4@/2!N;V1E
M+F1E<F5F97)E;F-E*"E;)U]-7VQE9G0G70H@("`@("`@("`@("!E;'-E.@H@
M("`@("`@("`@("`@("`@<&%R96YT(#T@;F]D92YD97)E9F5R96YC92@I6R=?
M35]P87)E;G0G70H@("`@("`@("`@("`@("`@=VAI;&4@;F]D92`]/2!P87)E
M;G0N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G73H*("`@("`@("`@("`@("`@
M("`@("!N;V1E(#T@<&%R96YT"B`@("`@("`@("`@("`@("`@("`@<&%R96YT
M(#T@<&%R96YT+F1E<F5F97)E;F-E*"E;)U]-7W!A<F5N="=="B`@("`@("`@
M("`@("`@("!I9B!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7W)I9VAT)UT@(3T@
M<&%R96YT.@H@("`@("`@("`@("`@("`@("`@(&YO9&4@/2!P87)E;G0*("`@
M("`@("`@("`@<V5L9BYN;V1E(#T@;F]D90H@("`@("`@(')E='5R;B!R97-U
M;'0*"F1E9B!G971?=F%L=65?9G)O;5]28E]T<F5E7VYO9&4H;F]D92DZ"B`@
M("`B(B)2971U<FYS('1H92!V86QU92!H96QD(&EN(&%N(%]28E]T<F5E7VYO
M9&4\7U9A;#XB(B(*("`@('1R>3H*("`@("`@("!M96UB97(@/2!N;V1E+G1Y
M<&4N9FEE;&1S*"E;,5TN;F%M90H@("`@("`@(&EF(&UE;6)E<B`]/2`G7TU?
M=F%L=65?9FEE;&0G.@H@("`@("`@("`@("`C($,K*S`S(&EM<&QE;65N=&%T
M:6]N+"!N;V1E(&-O;G1A:6YS('1H92!V86QU92!A<R!A(&UE;6)E<@H@("`@
M("`@("`@("!R971U<FX@;F]D95LG7TU?=F%L=65?9FEE;&0G70H@("`@("`@
M(&5L:68@;65M8F5R(#T]("=?35]S=&]R86=E)SH*("`@("`@("`@("`@(R!#
M*RLQ,2!I;7!L96UE;G1A=&EO;BP@;F]D92!S=&]R97,@=F%L=64@:6X@7U]A
M;&EG;F5D7VUE;6)U9@H@("`@("`@("`@("!V86QT>7!E(#T@;F]D92YT>7!E
M+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@("`@(')E='5R;B!G971?
M=F%L=65?9G)O;5]A;&EG;F5D7VUE;6)U9BAN;V1E6R=?35]S=&]R86=E)UTL
M('9A;'1Y<&4I"B`@("!E>&-E<'0Z"B`@("`@("`@<&%S<PH@("`@<F%I<V4@
M5F%L=65%<G)O<B@B56YS=7!P;W)T960@:6UP;&5M96YT871I;VX@9F]R("5S
M(B`E('-T<BAN;V1E+G1Y<&4I*0H*(R!4:&ES(&ES(&$@<')E='1Y('!R:6YT
M97(@9F]R('-T9#HZ7U)B7W1R965?:71E<F%T;W(@*'=H:6-H(&ES"B,@<W1D
M.CIM87`Z.FET97)A=&]R*2P@86YD(&AA<R!N;W1H:6YG('1O(&1O('=I=&@@
M=&AE(%)B=')E94ET97)A=&]R"B,@8VQA<W,@86)O=F4N"F-L87-S(%-T9%)B
M=')E94ET97)A=&]R4')I;G1E<CH*("`@(")0<FEN="!S=&0Z.FUA<#HZ:71E
M<F%T;W(L('-T9#HZ<V5T.CII=&5R871O<BP@971C+B(*"B`@("!D968@7U]I
M;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L
M(#T@=F%L"B`@("`@("`@;F]D971Y<&4@/2!L;V]K=7!?;F]D95]T>7!E*"=?
M4F)?=')E95]N;V1E)RP@<V5L9BYV86PN='EP92D*("`@("`@("!S96QF+FQI
M;FM?='EP92`](&YO9&5T>7!E+G!O:6YT97(H*0H*("`@(&1E9B!T;U]S=')I
M;F<@*'-E;&8I.@H@("`@("`@(&EF(&YO="!S96QF+G9A;%LG7TU?;F]D92==
M.@H@("`@("`@("`@("!R971U<FX@)VYO;BUD97)E9F5R96YC96%B;&4@:71E
M<F%T;W(@9F]R(&%S<V]C:6%T:79E(&-O;G1A:6YE<B<*("`@("`@("!N;V1E
M(#T@<V5L9BYV86Q;)U]-7VYO9&4G72YC87-T*'-E;&8N;&EN:U]T>7!E*2YD
M97)E9F5R96YC92@I"B`@("`@("`@<F5T=7)N('-T<BAG971?=F%L=65?9G)O
M;5]28E]T<F5E7VYO9&4H;F]D92DI"@IC;&%S<R!3=&1$96)U9TET97)A=&]R
M4')I;G1E<CH*("`@(")0<FEN="!A(&1E8G5G(&5N86)L960@=F5R<VEO;B!O
M9B!A;B!I=&5R871O<B(*"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N
M86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"@H@("`@(R!*=7-T
M('-T<FEP(&%W87D@=&AE(&5N8V%P<W5L871I;F<@7U]G;G5?9&5B=6<Z.E]3
M869E7VET97)A=&]R"B`@("`C(&%N9"!R971U<FX@=&AE('=R87!P960@:71E
M<F%T;W(@=F%L=64N"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@
M("!B87-E7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H)U]?9VYU7V1E8G5G.CI?
M4V%F95]I=&5R871O<E]B87-E)RD*("`@("`@("!I='EP92`]('-E;&8N=F%L
M+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("!S869E7W-E<2`]
M('-E;&8N=F%L+F-A<W0H8F%S95]T>7!E*5LG7TU?<V5Q=65N8V4G70H@("`@
M("`@(&EF(&YO="!S869E7W-E<3H*("`@("`@("`@("`@<F5T=7)N('-T<BAS
M96QF+G9A;"YC87-T*&ET>7!E*2D*("`@("`@("!I9B!S96QF+G9A;%LG7TU?
M=F5R<VEO;B==("$]('-A9F5?<V5Q6R=?35]V97)S:6]N)UTZ"B`@("`@("`@
M("`@(')E='5R;B`B:6YV86QI9"!I=&5R871O<B(*("`@("`@("!R971U<FX@
M<W1R*'-E;&8N=F%L+F-A<W0H:71Y<&4I*0H*9&5F(&YU;5]E;&5M96YT<RAN
M=6TI.@H@("`@(B(B4F5T=7)N(&5I=&AE<B`B,2!E;&5M96YT(B!O<B`B3B!E
M;&5M96YT<R(@9&5P96YD:6YG(&]N('1H92!A<F=U;65N="XB(B(*("`@(')E
M='5R;B`G,2!E;&5M96YT)R!I9B!N=6T@/3T@,2!E;'-E("<E9"!E;&5M96YT
M<R<@)2!N=6T*"F-L87-S(%-T9$UA<%!R:6YT97(Z"B`@("`B4')I;G0@82!S
M=&0Z.FUA<"!O<B!S=&0Z.FUU;'1I;6%P(@H*("`@(",@5'5R;B!A;B!28G1R
M965)=&5R871O<B!I;G1O(&$@<')E='1Y+7!R:6YT(&ET97)A=&]R+@H@("`@
M8VQA<W,@7VET97(H271E<F%T;W(I.@H@("`@("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!R8FET97(L('1Y<&4I.@H@("`@("`@("`@("!S96QF+G)B:71E<B`]
M(')B:71E<@H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H@("`@("`@("`@
M("!S96QF+G1Y<&4@/2!T>7!E"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF
M*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X
M=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF+F-O=6YT("4@,B`]/2`P
M.@H@("`@("`@("`@("`@("`@;B`](&YE>'0H<V5L9BYR8FET97(I"B`@("`@
M("`@("`@("`@("!N(#T@;BYC87-T*'-E;&8N='EP92DN9&5R969E<F5N8V4H
M*0H@("`@("`@("`@("`@("`@;B`](&=E=%]V86QU95]F<F]M7U)B7W1R965?
M;F]D92AN*0H@("`@("`@("`@("`@("`@<V5L9BYP86ER(#T@;@H@("`@("`@
M("`@("`@("`@:71E;2`](&Y;)V9I<G-T)UT*("`@("`@("`@("`@96QS93H*
M("`@("`@("`@("`@("`@(&ET96T@/2!S96QF+G!A:7);)W-E8V]N9"=="B`@
M("`@("`@("`@(')E<W5L="`]("@G6R5D72<@)2!S96QF+F-O=6YT+"!I=&5M
M*0H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@
M("`@("`@("`@<F5T=7)N(')E<W5L=`H*("`@(&1E9B!?7VEN:71?7R`H<V5L
M9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T
M<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L
M9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@
M("!R971U<FX@)R5S('=I=&@@)7,G("4@*'-E;&8N='EP96YA;64L"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("!N=6U?96QE;65N=',H;&5N*%)B
M=')E94ET97)A=&]R("AS96QF+G9A;"DI*2D*"B`@("!D968@8VAI;&1R96X@
M*'-E;&8I.@H@("`@("`@(&YO9&4@/2!L;V]K=7!?;F]D95]T>7!E*"=?4F)?
M=')E95]N;V1E)RP@<V5L9BYV86PN='EP92DN<&]I;G1E<B@I"B`@("`@("`@
M<F5T=7)N('-E;&8N7VET97(@*%)B=')E94ET97)A=&]R("AS96QF+G9A;"DL
M(&YO9&4I"@H@("`@9&5F(&1I<W!L87E?:&EN="`H<V5L9BDZ"B`@("`@("`@
M<F5T=7)N("=M87`G"@IC;&%S<R!3=&139710<FEN=&5R.@H@("`@(E!R:6YT
M(&$@<W1D.CIS970@;W(@<W1D.CIM=6QT:7-E="(*"B`@("`C(%1U<FX@86X@
M4F)T<F5E271E<F%T;W(@:6YT;R!A('!R971T>2UP<FEN="!I=&5R871O<BX*
M("`@(&-L87-S(%]I=&5R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET
M7U\H<V5L9BP@<F)I=&5R+"!T>7!E*3H*("`@("`@("`@("`@<V5L9BYR8FET
M97(@/2!R8FET97(*("`@("`@("`@("`@<V5L9BYC;W5N="`](#`*("`@("`@
M("`@("`@<V5L9BYT>7!E(#T@='EP90H*("`@("`@("!D968@7U]I=&5R7U\H
M<V5L9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?
M7VYE>'1?7RAS96QF*3H*("`@("`@("`@("`@:71E;2`](&YE>'0H<V5L9BYR
M8FET97(I"B`@("`@("`@("`@(&ET96T@/2!I=&5M+F-A<W0H<V5L9BYT>7!E
M*2YD97)E9F5R96YC92@I"B`@("`@("`@("`@(&ET96T@/2!G971?=F%L=65?
M9G)O;5]28E]T<F5E7VYO9&4H:71E;2D*("`@("`@("`@("`@(R!&25A-13H@
M=&AI<R!I<R!W96ER9"`N+BX@=VAA="!T;R!D;S\*("`@("`@("`@("`@(R!-
M87EB92!A("=S970G(&1I<W!L87D@:&EN=#\*("`@("`@("`@("`@<F5S=6QT
M(#T@*"=;)61=)R`E('-E;&8N8V]U;G0L(&ET96TI"B`@("`@("`@("`@('-E
M;&8N8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@("`@("!R971U<FX@
M<F5S=6QT"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L
M*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA
M;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@
M(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@(')E='5R;B`G)7,@=VET
M:"`E<R<@)2`H<V5L9BYT>7!E;F%M92P*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@(&YU;5]E;&5M96YT<RAL96XH4F)T<F5E271E<F%T;W(@*'-E
M;&8N=F%L*2DI*0H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@
M;F]D92`](&QO;VMU<%]N;V1E7W1Y<&4H)U]28E]T<F5E7VYO9&4G+"!S96QF
M+G9A;"YT>7!E*2YP;VEN=&5R*"D*("`@("`@("!R971U<FX@<V5L9BY?:71E
M<B`H4F)T<F5E271E<F%T;W(@*'-E;&8N=F%L*2P@;F]D92D*"F-L87-S(%-T
M9$)I='-E=%!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.F)I='-E="(*"B`@
M("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@
M<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP
M96YA;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R
M:6YG("AS96QF*3H*("`@("`@("`C($EF('1E;7!L871E7V%R9W5M96YT(&AA
M;F1L960@=F%L=65S+"!W92!C;W5L9"!P<FEN="!T:&4*("`@("`@("`C('-I
M>F4N("!/<B!W92!C;W5L9"!U<V4@82!R96=E>'`@;VX@=&AE('1Y<&4N"B`@
M("`@("`@<F5T=7)N("<E<R<@)2`H<V5L9BYT>7!E;F%M92D*"B`@("!D968@
M8VAI;&1R96X@*'-E;&8I.@H@("`@("`@('1R>3H*("`@("`@("`@("`@(R!!
M;B!E;7!T>2!B:71S970@;6%Y(&YO="!H879E(&%N>2!M96UB97)S('=H:6-H
M('=I;&P*("`@("`@("`@("`@(R!R97-U;'0@:6X@86X@97AC97!T:6]N(&)E
M:6YG('1H<F]W;BX*("`@("`@("`@("`@=V]R9',@/2!S96QF+G9A;%LG7TU?
M=R=="B`@("`@("`@97AC97!T.@H@("`@("`@("`@("!R971U<FX@6UT*"B`@
M("`@("`@=W1Y<&4@/2!W;W)D<RYT>7!E"@H@("`@("`@(",@5&AE(%]-7W<@
M;65M8F5R(&-A;B!B92!E:71H97(@86X@=6YS:6=N960@;&]N9RP@;W(@86X*
M("`@("`@("`C(&%R<F%Y+B`@5&AI<R!D97!E;F1S(&]N('1H92!T96UP;&%T
M92!S<&5C:6%L:7IA=&EO;B!U<V5D+@H@("`@("`@(",@268@:70@:7,@82!S
M:6YG;&4@;&]N9RP@8V]N=F5R="!T;R!A('-I;F=L92!E;&5M96YT(&QI<W0N
M"B`@("`@("`@:68@=W1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7T%24D%9
M.@H@("`@("`@("`@("!T<VEZ92`]('=T>7!E+G1A<F=E="`H*2YS:7IE;V8*
M("`@("`@("!E;'-E.@H@("`@("`@("`@("!W;W)D<R`](%MW;W)D<UT*("`@
M("`@("`@("`@='-I>F4@/2!W='EP92YS:7IE;V8*"B`@("`@("`@;G=O<F1S
M(#T@=W1Y<&4N<VEZ96]F("\@='-I>F4*("`@("`@("!R97-U;'0@/2!;70H@
M("`@("`@(&)Y=&4@/2`P"B`@("`@("`@=VAI;&4@8GET92`\(&YW;W)D<SH*
M("`@("`@("`@("`@=R`]('=O<F1S6V)Y=&5="B`@("`@("`@("`@(&)I="`]
M(#`*("`@("`@("`@("`@=VAI;&4@=R`A/2`P.@H@("`@("`@("`@("`@("`@
M:68@*'<@)B`Q*2`A/2`P.@H@("`@("`@("`@("`@("`@("`@(",@06YO=&AE
M<B!S<&]T('=H97)E('=E(&-O=6QD('5S92`G<V5T)S\*("`@("`@("`@("`@
M("`@("`@("!R97-U;'0N87!P96YD*"@G6R5D72<@)2`H8GET92`J('1S:7IE
M("H@."`K(&)I="DL(#$I*0H@("`@("`@("`@("`@("`@8FET(#T@8FET("L@
M,0H@("`@("`@("`@("`@("`@=R`]('<@/CX@,0H@("`@("`@("`@("!B>71E
M(#T@8GET92`K(#$*("`@("`@("!R971U<FX@<F5S=6QT"@IC;&%S<R!3=&1$
M97%U95!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.F1E<75E(@H*("`@(&-L
M87-S(%]I=&5R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L
M9BP@;F]D92P@<W1A<G0L(&5N9"P@;&%S="P@8G5F9F5R7W-I>F4I.@H@("`@
M("`@("`@("!S96QF+FYO9&4@/2!N;V1E"B`@("`@("`@("`@('-E;&8N<"`]
M('-T87)T"B`@("`@("`@("`@('-E;&8N96YD(#T@96YD"B`@("`@("`@("`@
M('-E;&8N;&%S="`](&QA<W0*("`@("`@("`@("`@<V5L9BYB=69F97)?<VEZ
M92`](&)U9F9E<E]S:7IE"B`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@
M("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N
M('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@
M("!I9B!S96QF+G`@/3T@<V5L9BYL87-T.@H@("`@("`@("`@("`@("`@<F%I
M<V4@4W1O<$ET97)A=&EO;@H*("`@("`@("`@("`@<F5S=6QT(#T@*"=;)61=
M)R`E('-E;&8N8V]U;G0L('-E;&8N<"YD97)E9F5R96YC92@I*0H@("`@("`@
M("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*"B`@("`@("`@("`@
M(",@061V86YC92!T:&4@)V-U<B<@<&]I;G1E<BX*("`@("`@("`@("`@<V5L
M9BYP(#T@<V5L9BYP("L@,0H@("`@("`@("`@("!I9B!S96QF+G`@/3T@<V5L
M9BYE;F0Z"B`@("`@("`@("`@("`@("`C($EF('=E(&=O="!T;R!T:&4@96YD
M(&]F('1H:7,@8G5C:V5T+"!M;W9E('1O('1H90H@("`@("`@("`@("`@("`@
M(R!N97AT(&)U8VME="X*("`@("`@("`@("`@("`@('-E;&8N;F]D92`]('-E
M;&8N;F]D92`K(#$*("`@("`@("`@("`@("`@('-E;&8N<"`]('-E;&8N;F]D
M95LP70H@("`@("`@("`@("`@("`@<V5L9BYE;F0@/2!S96QF+G`@*R!S96QF
M+F)U9F9E<E]S:7IE"@H@("`@("`@("`@("!R971U<FX@<F5S=6QT"@H@("`@
M9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E
M;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N
M86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYE;'1T
M>7!E(#T@=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("!S
M:7IE(#T@<V5L9BYE;'1T>7!E+G-I>F5O9@H@("`@("`@(&EF('-I>F4@/"`U
M,3(Z"B`@("`@("`@("`@('-E;&8N8G5F9F5R7W-I>F4@/2!I;G0@*#4Q,B`O
M('-I>F4I"B`@("`@("`@96QS93H*("`@("`@("`@("`@<V5L9BYB=69F97)?
M<VEZ92`](#$*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@('-T
M87)T(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A<G0G70H@("`@("`@
M(&5N9"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="@H@("`@
M("`@(&1E;'1A7VX@/2!E;F1;)U]-7VYO9&4G72`M('-T87)T6R=?35]N;V1E
M)UT@+2`Q"B`@("`@("`@9&5L=&%?<R`]('-T87)T6R=?35]L87-T)UT@+2!S
M=&%R=%LG7TU?8W5R)UT*("`@("`@("!D96QT85]E(#T@96YD6R=?35]C=7(G
M72`M(&5N9%LG7TU?9FER<W0G70H*("`@("`@("!S:7IE(#T@<V5L9BYB=69F
M97)?<VEZ92`J(&1E;'1A7VX@*R!D96QT85]S("L@9&5L=&%?90H*("`@("`@
M("!R971U<FX@)R5S('=I=&@@)7,G("4@*'-E;&8N='EP96YA;64L(&YU;5]E
M;&5M96YT<RAL;VYG*'-I>F4I*2D*"B`@("!D968@8VAI;&1R96XH<V5L9BDZ
M"B`@("`@("`@<W1A<G0@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]S=&%R
M="=="B`@("`@("`@96YD(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?9FEN
M:7-H)UT*("`@("`@("!R971U<FX@<V5L9BY?:71E<BAS=&%R=%LG7TU?;F]D
M92==+"!S=&%R=%LG7TU?8W5R)UTL('-T87)T6R=?35]L87-T)UTL"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@96YD6R=?35]C=7(G72P@<V5L9BYB=69F
M97)?<VEZ92D*"B`@("!D968@9&ES<&QA>5]H:6YT("AS96QF*3H*("`@("`@
M("!R971U<FX@)V%R<F%Y)PH*8VQA<W,@4W1D1&5Q=65)=&5R871O<E!R:6YT
M97(Z"B`@("`B4')I;G0@<W1D.CID97%U93HZ:71E<F%T;W(B"@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I
M9B!N;W0@<V5L9BYV86Q;)U]-7V-U<B==.@H@("`@("`@("`@("!R971U<FX@
M)VYO;BUD97)E9F5R96YC96%B;&4@:71E<F%T;W(@9F]R('-T9#HZ9&5Q=64G
M"B`@("`@("`@<F5T=7)N('-T<BAS96QF+G9A;%LG7TU?8W5R)UTN9&5R969E
M<F5N8V4H*2D*"F-L87-S(%-T9%-T<FEN9U!R:6YT97(Z"B`@("`B4')I;G0@
M82!S=&0Z.F)A<VEC7W-T<FEN9R!O9B!S;VUE(&MI;F0B"@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L
M(#T@=F%L"B`@("`@("`@<V5L9BYN97=?<W1R:6YG(#T@='EP96YA;64N9FEN
M9"@B.CI?7V-X>#$Q.CIB87-I8U]S=')I;F<B*2`A/2`M,0H*("`@(&1E9B!T
M;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@(R!-86ME('-U<F4@)G-T<FEN9R!W
M;W)K<RP@=&]O+@H@("`@("`@('1Y<&4@/2!S96QF+G9A;"YT>7!E"B`@("`@
M("`@:68@='EP92YC;V1E(#T](&=D8BY465!%7T-/1$5?4D5&.@H@("`@("`@
M("`@("!T>7!E(#T@='EP92YT87)G970@*"D*"B`@("`@("`@(R!#86QC=6QA
M=&4@=&AE(&QE;F=T:"!O9B!T:&4@<W1R:6YG('-O('1H870@=&]?<W1R:6YG
M(')E='5R;G,*("`@("`@("`C('1H92!S=')I;F<@86-C;W)D:6YG('1O(&QE
M;F=T:"P@;F]T(&%C8V]R9&EN9R!T;R!F:7)S="!N=6QL"B`@("`@("`@(R!E
M;F-O=6YT97)E9"X*("`@("`@("!P='(@/2!S96QF+G9A;"!;)U]-7V1A=&%P
M;'5S)UU;)U]-7W`G70H@("`@("`@(&EF('-E;&8N;F5W7W-T<FEN9SH*("`@
M("`@("`@("`@;&5N9W1H(#T@<V5L9BYV86Q;)U]-7W-T<FEN9U]L96YG=&@G
M70H@("`@("`@("`@("`C(&AT='!S.B\O<V]U<F-E=V%R92YO<F<O8G5G>FEL
M;&$O<VAO=U]B=6<N8V=I/VED/3$W-S(X"B`@("`@("`@("`@('!T<B`]('!T
M<BYC87-T*'!T<BYT>7!E+G-T<FEP7W1Y<&5D969S*"DI"B`@("`@("`@96QS
M93H*("`@("`@("`@("`@<F5A;'1Y<&4@/2!T>7!E+G5N<75A;&EF:65D("@I
M+G-T<FEP7W1Y<&5D969S("@I"B`@("`@("`@("`@(')E<'1Y<&4@/2!G9&(N
M;&]O:W5P7W1Y<&4@*'-T<B`H<F5A;'1Y<&4I("L@)SHZ7U)E<"<I+G!O:6YT
M97(@*"D*("`@("`@("`@("`@:&5A9&5R(#T@<'1R+F-A<W0H<F5P='EP92D@
M+2`Q"B`@("`@("`@("`@(&QE;F=T:"`](&AE861E<BYD97)E9F5R96YC92`H
M*5LG7TU?;&5N9W1H)UT*("`@("`@("!I9B!H87-A='1R*'!T<BP@(FQA>GE?
M<W1R:6YG(BDZ"B`@("`@("`@("`@(')E='5R;B!P='(N;&%Z>5]S=')I;F<@
M*&QE;F=T:"`](&QE;F=T:"D*("`@("`@("!R971U<FX@<'1R+G-T<FEN9R`H
M;&5N9W1H(#T@;&5N9W1H*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I
M.@H@("`@("`@(')E='5R;B`G<W1R:6YG)PH*8VQA<W,@5'(Q2&%S:'1A8FQE
M271E<F%T;W(H271E<F%T;W(I.@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!H
M87-H=&%B;&4I.@H@("`@("`@('-E;&8N8G5C:V5T<R`](&AA<VAT86)L95LG
M7TU?8G5C:V5T<R=="B`@("`@("`@<V5L9BYB=6-K970@/2`P"B`@("`@("`@
M<V5L9BYB=6-K971?8V]U;G0@/2!H87-H=&%B;&5;)U]-7V)U8VME=%]C;W5N
M="=="B`@("`@("`@<V5L9BYN;V1E7W1Y<&4@/2!F:6YD7W1Y<&4H:&%S:'1A
M8FQE+G1Y<&4L("=?3F]D92<I+G!O:6YT97(H*0H@("`@("`@('-E;&8N;F]D
M92`](#`*("`@("`@("!W:&EL92!S96QF+F)U8VME="`A/2!S96QF+F)U8VME
M=%]C;W5N=#H*("`@("`@("`@("`@<V5L9BYN;V1E(#T@<V5L9BYB=6-K971S
M6W-E;&8N8G5C:V5T70H@("`@("`@("`@("!I9B!S96QF+FYO9&4Z"B`@("`@
M("`@("`@("`@("!B<F5A:PH@("`@("`@("`@("!S96QF+F)U8VME="`]('-E
M;&8N8G5C:V5T("L@,0H*("`@(&1E9B!?7VET97)?7R`H<V5L9BDZ"B`@("`@
M("`@<F5T=7)N('-E;&8*"B`@("!D968@7U]N97AT7U\@*'-E;&8I.@H@("`@
M("`@(&EF('-E;&8N;F]D92`]/2`P.@H@("`@("`@("`@("!R86ES92!3=&]P
M271E<F%T:6]N"B`@("`@("`@;F]D92`]('-E;&8N;F]D92YC87-T*'-E;&8N
M;F]D95]T>7!E*0H@("`@("`@(')E<W5L="`](&YO9&4N9&5R969E<F5N8V4H
M*5LG7TU?=B=="B`@("`@("`@<V5L9BYN;V1E(#T@;F]D92YD97)E9F5R96YC
M92@I6R=?35]N97AT)UT["B`@("`@("`@:68@<V5L9BYN;V1E(#T](#`Z"B`@
M("`@("`@("`@('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K970@*R`Q"B`@("`@
M("`@("`@('=H:6QE('-E;&8N8G5C:V5T("$]('-E;&8N8G5C:V5T7V-O=6YT
M.@H@("`@("`@("`@("`@("`@<V5L9BYN;V1E(#T@<V5L9BYB=6-K971S6W-E
M;&8N8G5C:V5T70H@("`@("`@("`@("`@("`@:68@<V5L9BYN;V1E.@H@("`@
M("`@("`@("`@("`@("`@(&)R96%K"B`@("`@("`@("`@("`@("!S96QF+F)U
M8VME="`]('-E;&8N8G5C:V5T("L@,0H@("`@("`@(')E='5R;B!R97-U;'0*
M"F-L87-S(%-T9$AA<VAT86)L94ET97)A=&]R*$ET97)A=&]R*3H*("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!H87-H=&%B;&4I.@H@("`@("`@('-E;&8N;F]D
M92`](&AA<VAT86)L95LG7TU?8F5F;W)E7V)E9VEN)UU;)U]-7VYX="=="B`@
M("`@("`@=F%L='EP92`](&AA<VAT86)L92YT>7!E+G1E;7!L871E7V%R9W5M
M96YT*#$I"B`@("`@("`@8V%C:&5D(#T@:&%S:'1A8FQE+G1Y<&4N=&5M<&QA
M=&5?87)G=6UE;G0H.2DN=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("!N
M;V1E7W1Y<&4@/2!L;V]K=7!?=&5M<&Q?<W!E8R@G<W1D.CI?7V1E=&%I;#HZ
M7TAA<VA?;F]D92<L('-T<BAV86QT>7!E*2P*("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`G=')U92<@:68@8V%C:&5D(&5L<V4@)V9A
M;'-E)RD*("`@("`@("!S96QF+FYO9&5?='EP92`](&YO9&5?='EP92YP;VEN
M=&5R*"D*"B`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@<F5T=7)N
M('-E;&8*"B`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@:68@<V5L
M9BYN;V1E(#T](#`Z"B`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*
M("`@("`@("!E;'0@/2!S96QF+FYO9&4N8V%S="AS96QF+FYO9&5?='EP92DN
M9&5R969E<F5N8V4H*0H@("`@("`@('-E;&8N;F]D92`](&5L=%LG7TU?;GAT
M)UT*("`@("`@("!V86QP='(@/2!E;'1;)U]-7W-T;W)A9V4G72YA9&1R97-S
M"B`@("`@("`@=F%L<'1R(#T@=F%L<'1R+F-A<W0H96QT+G1Y<&4N=&5M<&QA
M=&5?87)G=6UE;G0H,"DN<&]I;G1E<B@I*0H@("`@("`@(')E='5R;B!V86QP
M='(N9&5R969E<F5N8V4H*0H*8VQA<W,@5'(Q56YO<F1E<F5D4V5T4')I;G1E
M<CH*("`@(")0<FEN="!A('-T9#HZ=6YO<F1E<F5D7W-E="!O<B!T<C$Z.G5N
M;W)D97)E9%]S970B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M
M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO
M;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A
M;`H*("`@(&1E9B!H87-H=&%B;&4@*'-E;&8I.@H@("`@("`@(&EF('-E;&8N
M='EP96YA;64N<W1A<G1S=VET:"@G<W1D.CIT<C$G*3H*("`@("`@("`@("`@
M<F5T=7)N('-E;&8N=F%L"B`@("`@("`@<F5T=7)N('-E;&8N=F%L6R=?35]H
M)UT*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!C;W5N="`]
M('-E;&8N:&%S:'1A8FQE*"E;)U]-7V5L96UE;G1?8V]U;G0G70H@("`@("`@
M(')E='5R;B`G)7,@=VET:"`E<R<@)2`H<V5L9BYT>7!E;F%M92P@;G5M7V5L
M96UE;G1S*&-O=6YT*2D*"B`@("!`<W1A=&EC;65T:&]D"B`@("!D968@9F]R
M;6%T7V-O=6YT("AI*3H*("`@("`@("!R971U<FX@)ULE9%TG("4@:0H*("`@
M(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@8V]U;G1E<B`](&EM87`@
M*'-E;&8N9F]R;6%T7V-O=6YT+"!I=&5R=&]O;',N8V]U;G0H*2D*("`@("`@
M("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H)W-T9#HZ='(Q)RDZ"B`@
M("`@("`@("`@(')E='5R;B!I>FEP("AC;W5N=&5R+"!4<C%(87-H=&%B;&5)
M=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI"B`@("`@("`@<F5T=7)N(&EZ
M:7`@*&-O=6YT97(L(%-T9$AA<VAT86)L94ET97)A=&]R("AS96QF+FAA<VAT
M86)L92@I*2D*"F-L87-S(%1R,55N;W)D97)E9$UA<%!R:6YT97(Z"B`@("`B
M4')I;G0@82!S=&0Z.G5N;W)D97)E9%]M87`@;W(@='(Q.CIU;F]R9&5R961?
M;6%P(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ
M"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE
M<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D
M968@:&%S:'1A8FQE("AS96QF*3H*("`@("`@("!I9B!S96QF+G1Y<&5N86UE
M+G-T87)T<W=I=&@H)W-T9#HZ='(Q)RDZ"B`@("`@("`@("`@(')E='5R;B!S
M96QF+G9A;`H@("`@("`@(')E='5R;B!S96QF+G9A;%LG7TU?:"=="@H@("`@
M9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@8V]U;G0@/2!S96QF+FAA
M<VAT86)L92@I6R=?35]E;&5M96YT7V-O=6YT)UT*("`@("`@("!R971U<FX@
M)R5S('=I=&@@)7,G("4@*'-E;&8N='EP96YA;64L(&YU;5]E;&5M96YT<RAC
M;W5N="DI"@H@("`@0'-T871I8VUE=&AO9`H@("`@9&5F(&9L871T96X@*&QI
M<W0I.@H@("`@("`@(&9O<B!E;'0@:6X@;&ES=#H*("`@("`@("`@("`@9F]R
M(&D@:6X@96QT.@H@("`@("`@("`@("`@("`@>6EE;&0@:0H*("`@($!S=&%T
M:6-M971H;V0*("`@(&1E9B!F;W)M871?;VYE("AE;'0I.@H@("`@("`@(')E
M='5R;B`H96QT6R=F:7)S="==+"!E;'1;)W-E8V]N9"==*0H*("`@($!S=&%T
M:6-M971H;V0*("`@(&1E9B!F;W)M871?8V]U;G0@*&DI.@H@("`@("`@(')E
M='5R;B`G6R5D72<@)2!I"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@
M("`@("!C;W5N=&5R(#T@:6UA<"`H<V5L9BYF;W)M871?8V]U;G0L(&ET97)T
M;V]L<RYC;W5N="@I*0H@("`@("`@(",@36%P(&]V97(@=&AE(&AA<V@@=&%B
M;&4@86YD(&9L871T96X@=&AE(')E<W5L="X*("`@("`@("!I9B!S96QF+G1Y
M<&5N86UE+G-T87)T<W=I=&@H)W-T9#HZ='(Q)RDZ"B`@("`@("`@("`@(&1A
M=&$@/2!S96QF+F9L871T96X@*&EM87`@*'-E;&8N9F]R;6%T7V]N92P@5'(Q
M2&%S:'1A8FQE271E<F%T;W(@*'-E;&8N:&%S:'1A8FQE*"DI*2D*("`@("`@
M("`@("`@(R!::7`@=&AE('1W;R!I=&5R871O<G,@=&]G971H97(N"B`@("`@
M("`@("`@(')E='5R;B!I>FEP("AC;W5N=&5R+"!D871A*0H@("`@("`@(&1A
M=&$@/2!S96QF+F9L871T96X@*&EM87`@*'-E;&8N9F]R;6%T7V]N92P@4W1D
M2&%S:'1A8FQE271E<F%T;W(@*'-E;&8N:&%S:'1A8FQE*"DI*2D*("`@("`@
M("`C(%II<"!T:&4@='=O(&ET97)A=&]R<R!T;V=E=&AE<BX*("`@("`@("!R
M971U<FX@:7II<"`H8V]U;G1E<BP@9&%T82D*"B`@("!D968@9&ES<&QA>5]H
M:6YT("AS96QF*3H*("`@("`@("!R971U<FX@)VUA<"<*"F-L87-S(%-T9$9O
M<G=A<F1,:7-T4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ9F]R=V%R9%]L
M:7-T(@H*("`@(&-L87-S(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@
M9&5F(%]?:6YI=%]?*'-E;&8L(&YO9&5T>7!E+"!H96%D*3H*("`@("`@("`@
M("`@<V5L9BYN;V1E='EP92`](&YO9&5T>7!E"B`@("`@("`@("`@('-E;&8N
M8F%S92`](&AE861;)U]-7VYE>'0G70H@("`@("`@("`@("!S96QF+F-O=6YT
M(#T@,`H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@
M(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@
M("`@("`@("`@:68@<V5L9BYB87-E(#T](#`Z"B`@("`@("`@("`@("`@("!R
M86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@(&5L="`]('-E;&8N8F%S
M92YC87-T*'-E;&8N;F]D971Y<&4I+F1E<F5F97)E;F-E*"D*("`@("`@("`@
M("`@<V5L9BYB87-E(#T@96QT6R=?35]N97AT)UT*("`@("`@("`@("`@8V]U
M;G0@/2!S96QF+F-O=6YT"B`@("`@("`@("`@('-E;&8N8V]U;G0@/2!S96QF
M+F-O=6YT("L@,0H@("`@("`@("`@("!V86QP='(@/2!E;'1;)U]-7W-T;W)A
M9V4G72YA9&1R97-S"B`@("`@("`@("`@('9A;'!T<B`]('9A;'!T<BYC87-T
M*&5L="YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I+G!O:6YT97(H*2D*("`@
M("`@("`@("`@<F5T=7)N("@G6R5D72<@)2!C;W5N="P@=F%L<'1R+F1E<F5F
M97)E;F-E*"DI"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V
M86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYT>7!E
M;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"@H@
M("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(&YO9&5T>7!E(#T@;&]O
M:W5P7VYO9&5?='EP92@G7T9W9%]L:7-T7VYO9&4G+"!S96QF+G9A;"YT>7!E
M*2YP;VEN=&5R*"D*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T;W(H;F]D
M971Y<&4L('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7VAE860G72D*"B`@("!D
M968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(&EF('-E;&8N=F%L6R=?35]I
M;7!L)UU;)U]-7VAE860G75LG7TU?;F5X="==(#T](#`Z"B`@("`@("`@("`@
M(')E='5R;B`G96UP='D@)7,G("4@<V5L9BYT>7!E;F%M90H@("`@("`@(')E
M='5R;B`G)7,G("4@<V5L9BYT>7!E;F%M90H*8VQA<W,@4VEN9VQE3V)J0V]N
M=&%I;F5R4')I;G1E<BAO8FIE8W0I.@H@("`@(D)A<V4@8VQA<W,@9F]R('!R
M:6YT97)S(&]F(&-O;G1A:6YE<G,@;V8@<VEN9VQE(&]B:F5C=',B"@H@("`@
M9&5F(%]?:6YI=%]?("AS96QF+"!V86PL('9I>BP@:&EN="`]($YO;F4I.@H@
M("`@("`@('-E;&8N8V]N=&%I;F5D7W9A;'5E(#T@=F%L"B`@("`@("`@<V5L
M9BYV:7-U86QI>F5R(#T@=FEZ"B`@("`@("`@<V5L9BYH:6YT(#T@:&EN=`H*
M("`@(&1E9B!?<F5C;V=N:7IE*'-E;&8L('1Y<&4I.@H@("`@("`@("(B(E)E
M='5R;B!465!%(&%S(&$@<W1R:6YG(&%F=&5R(&%P<&QY:6YG('1Y<&4@<')I
M;G1E<G,B(B(*("`@("`@("!G;&]B86P@7W5S95]T>7!E7W!R:6YT:6YG"B`@
M("`@("`@:68@;F]T(%]U<V5?='EP95]P<FEN=&EN9SH*("`@("`@("`@("`@
M<F5T=7)N('-T<BAT>7!E*0H@("`@("`@(')E='5R;B!G9&(N='EP97,N87!P
M;'E?='EP95]R96-O9VYI>F5R<RAG9&(N='EP97,N9V5T7W1Y<&5?<F5C;V=N
M:7IE<G,H*2P*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@='EP92D@;W(@<W1R*'1Y<&4I"@H@("`@8VQA<W,@7V-O
M;G1A:6YE9"A)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?("AS96QF
M+"!V86PI.@H@("`@("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@("`@("!D
M968@7U]I=&5R7U\@*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*
M("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E
M;&8N=F%L(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E
M<F%T:6]N"B`@("`@("`@("`@(')E='9A;"`]('-E;&8N=F%L"B`@("`@("`@
M("`@('-E;&8N=F%L(#T@3F]N90H@("`@("`@("`@("!R971U<FX@*"=;8V]N
M=&%I;F5D('9A;'5E72<L(')E='9A;"D*"B`@("!D968@8VAI;&1R96X@*'-E
M;&8I.@H@("`@("`@(&EF('-E;&8N8V]N=&%I;F5D7W9A;'5E(&ES($YO;F4Z
M"B`@("`@("`@("`@(')E='5R;B!S96QF+E]C;VYT86EN960@*$YO;F4I"B`@
M("`@("`@:68@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG
M*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=FES=6%L:7IE<BYC:&EL9')E
M;B`H*0H@("`@("`@(')E='5R;B!S96QF+E]C;VYT86EN960@*'-E;&8N8V]N
M=&%I;F5D7W9A;'5E*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@
M("`@("`@(",@:68@8V]N=&%I;F5D('9A;'5E(&ES(&$@;6%P('=E('=A;G0@
M=&\@9&ES<&QA>2!I;B!T:&4@<V%M92!W87D*("`@("`@("!I9B!H87-A='1R
M("AS96QF+G9I<W5A;&EZ97(L("=C:&EL9')E;B<I(&%N9"!H87-A='1R("AS
M96QF+G9I<W5A;&EZ97(L("=D:7-P;&%Y7VAI;G0G*3H*("`@("`@("`@("`@
M<F5T=7)N('-E;&8N=FES=6%L:7IE<BYD:7-P;&%Y7VAI;G0@*"D*("`@("`@
M("!R971U<FX@<V5L9BYH:6YT"@IC;&%S<R!3=&1%>'!!;GE0<FEN=&5R*%-I
M;F=L94]B:D-O;G1A:6YE<E!R:6YT97(I.@H@("`@(E!R:6YT(&$@<W1D.CIA
M;GD@;W(@<W1D.CIE>'!E<FEM96YT86PZ.F%N>2(*"B`@("!D968@7U]I;FET
M7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA
M;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@
M("`@('-E;&8N='EP96YA;64@/2!R92YS=6(H)UYS=&0Z.F5X<&5R:6UE;G1A
M;#HZ9G5N9&%M96YT86QS7W9<9#HZ)RP@)W-T9#HZ97AP97)I;65N=&%L.CHG
M+"!S96QF+G1Y<&5N86UE+"`Q*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@
M("`@("`@<V5L9BYC;VYT86EN961?='EP92`]($YO;F4*("`@("`@("!C;VYT
M86EN961?=F%L=64@/2!.;VYE"B`@("`@("`@=FES=6%L:7IE<B`]($YO;F4*
M("`@("`@("!M9W(@/2!S96QF+G9A;%LG7TU?;6%N86=E<B=="B`@("`@("`@
M:68@;6=R("$](#`Z"B`@("`@("`@("`@(&9U;F,@/2!G9&(N8FQO8VM?9F]R
M7W!C*&EN="AM9W(N8V%S="AG9&(N;&]O:W5P7W1Y<&4H)VEN='!T<E]T)RDI
M*2D*("`@("`@("`@("`@:68@;F]T(&9U;F,Z"B`@("`@("`@("`@("`@("!R
M86ES92!686QU945R<F]R*"));G9A;&ED(&9U;F-T:6]N('!O:6YT97(@:6X@
M)7,B("4@<V5L9BYT>7!E;F%M92D*("`@("`@("`@("`@<G@@/2!R(B(B*'LP
M?3HZ7TUA;F%G97)?7'<K/"XJ/BDZ.E]37VUA;F%G95PH*&5N=6T@*3][,'TZ
M.E]/<"P@*&-O;G-T('LP?7Q[,'T@8V]N<W0I(#]<*BP@*'5N:6]N("D_>S!]
M.CI?07)G(#]<*EPI(B(B+F9O<FUA="AT>7!E;F%M92D*("`@("`@("`@("`@
M;2`](')E+FUA=&-H*')X+"!F=6YC+F9U;F-T:6]N+FYA;64I"B`@("`@("`@
M("`@(&EF(&YO="!M.@H@("`@("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O
M<B@B56YK;F]W;B!M86YA9V5R(&9U;F-T:6]N(&EN("5S(B`E('-E;&8N='EP
M96YA;64I"@H@("`@("`@("`@("!M9W)N86UE(#T@;2YG<F]U<"@Q*0H@("`@
M("`@("`@("`C($9)6$U%(&YE960@=&\@97AP86YD("=S=&0Z.G-T<FEN9R<@
M<V\@=&AA="!G9&(N;&]O:W5P7W1Y<&4@=V]R:W,*("`@("`@("`@("`@:68@
M)W-T9#HZ<W1R:6YG)R!I;B!M9W)N86UE.@H@("`@("`@("`@("`@("`@;6=R
M;F%M92`](')E+G-U8B@B<W1D.CIS=')I;F<H/R%<=RDB+"!S='(H9V1B+FQO
M;VMU<%]T>7!E*"=S=&0Z.G-T<FEN9R<I+G-T<FEP7W1Y<&5D969S*"DI+"!M
M+F=R;W5P*#$I*0H*("`@("`@("`@("`@;6=R='EP92`](&=D8BYL;V]K=7!?
M='EP92AM9W)N86UE*0H@("`@("`@("`@("!S96QF+F-O;G1A:6YE9%]T>7!E
M(#T@;6=R='EP92YT96UP;&%T95]A<F=U;65N="@P*0H@("`@("`@("`@("!V
M86QP='(@/2!.;VYE"B`@("`@("`@("`@(&EF("<Z.E]-86YA9V5R7VEN=&5R
M;F%L)R!I;B!M9W)N86UE.@H@("`@("`@("`@("`@("`@=F%L<'1R(#T@<V5L
M9BYV86Q;)U]-7W-T;W)A9V4G75LG7TU?8G5F9F5R)UTN861D<F5S<PH@("`@
M("`@("`@("!E;&EF("<Z.E]-86YA9V5R7V5X=&5R;F%L)R!I;B!M9W)N86UE
M.@H@("`@("`@("`@("`@("`@=F%L<'1R(#T@<V5L9BYV86Q;)U]-7W-T;W)A
M9V4G75LG7TU?<'1R)UT*("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@
M("`@(')A:7-E(%9A;'5E17)R;W(H(E5N:VYO=VX@;6%N86=E<B!F=6YC=&EO
M;B!I;B`E<R(@)2!S96QF+G1Y<&5N86UE*0H@("`@("`@("`@("!C;VYT86EN
M961?=F%L=64@/2!V86QP='(N8V%S="AS96QF+F-O;G1A:6YE9%]T>7!E+G!O
M:6YT97(H*2DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!V:7-U86QI>F5R
M(#T@9V1B+F1E9F%U;'1?=FES=6%L:7IE<BAC;VYT86EN961?=F%L=64I"B`@
M("`@("`@<W5P97(H4W1D17AP06YY4')I;G1E<BP@<V5L9BDN7U]I;FET7U\@
M*&-O;G1A:6YE9%]V86QU92P@=FES=6%L:7IE<BD*"B`@("!D968@=&]?<W1R
M:6YG("AS96QF*3H*("`@("`@("!I9B!S96QF+F-O;G1A:6YE9%]T>7!E(&ES
M($YO;F4Z"B`@("`@("`@("`@(')E='5R;B`G)7,@6VYO(&-O;G1A:6YE9"!V
M86QU95TG("4@<V5L9BYT>7!E;F%M90H@("`@("`@(&1E<V,@/2`B)7,@8V]N
M=&%I;FEN9R`B("4@<V5L9BYT>7!E;F%M90H@("`@("`@(&EF(&AA<V%T='(@
M*'-E;&8N=FES=6%L:7IE<BP@)V-H:6QD<F5N)RDZ"B`@("`@("`@("`@(')E
M='5R;B!D97-C("L@<V5L9BYV:7-U86QI>F5R+G1O7W-T<FEN9R`H*0H@("`@
M("`@('9A;'1Y<&4@/2!S96QF+E]R96-O9VYI>F4@*'-E;&8N8V]N=&%I;F5D
M7W1Y<&4I"B`@("`@("`@<F5T=7)N(&1E<V,@*R!S=')I<%]V97)S:6]N961?
M;F%M97-P86-E*'-T<BAV86QT>7!E*2D*"F-L87-S(%-T9$5X<$]P=&EO;F%L
M4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0<FEN=&5R*3H*("`@(")0<FEN
M="!A('-T9#HZ;W!T:6]N86P@;W(@<W1D.CIE>'!E<FEM96YT86PZ.F]P=&EO
M;F%L(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ
M"B`@("`@("`@=F%L='EP92`]('-E;&8N7W)E8V]G;FEZ92`H=F%L+G1Y<&4N
M=&5M<&QA=&5?87)G=6UE;G0H,"DI"B`@("`@("`@='EP96YA;64@/2!S=')I
M<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N
M='EP96YA;64@/2!R92YS=6(H)UYS=&0Z.BAE>'!E<FEM96YT86PZ.GPI*&9U
M;F1A;65N=&%L<U]V7&0Z.GPI*"XJ*2<L('(G<W1D.CI<,5PS/"5S/B<@)2!V
M86QT>7!E+"!T>7!E;F%M92P@,2D*("`@("`@("!P87EL;V%D(#T@=F%L6R=?
M35]P87EL;V%D)UT*("`@("`@("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I
M=&@H)W-T9#HZ97AP97)I;65N=&%L)RDZ"B`@("`@("`@("`@(&5N9V%G960@
M/2!V86Q;)U]-7V5N9V%G960G70H@("`@("`@("`@("!C;VYT86EN961?=F%L
M=64@/2!P87EL;V%D"B`@("`@("`@96QS93H*("`@("`@("`@("`@96YG86=E
M9"`]('!A>6QO861;)U]-7V5N9V%G960G70H@("`@("`@("`@("!C;VYT86EN
M961?=F%L=64@/2!P87EL;V%D6R=?35]P87EL;V%D)UT*("`@("`@("`@("`@
M=')Y.@H@("`@("`@("`@("`@("`@(R!3:6YC92!'0T,@.0H@("`@("`@("`@
M("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@8V]N=&%I;F5D7W9A;'5E6R=?35]V
M86QU92=="B`@("`@("`@("`@(&5X8V5P=#H*("`@("`@("`@("`@("`@('!A
M<W,*("`@("`@("!V:7-U86QI>F5R(#T@9V1B+F1E9F%U;'1?=FES=6%L:7IE
M<B`H8V]N=&%I;F5D7W9A;'5E*0H@("`@("`@(&EF(&YO="!E;F=A9V5D.@H@
M("`@("`@("`@("!C;VYT86EN961?=F%L=64@/2!.;VYE"B`@("`@("`@<W5P
M97(@*%-T9$5X<$]P=&EO;F%L4')I;G1E<BP@<V5L9BDN7U]I;FET7U\@*&-O
M;G1A:6YE9%]V86QU92P@=FES=6%L:7IE<BD*"B`@("!D968@=&]?<W1R:6YG
M("AS96QF*3H*("`@("`@("!I9B!S96QF+F-O;G1A:6YE9%]V86QU92!I<R!.
M;VYE.@H@("`@("`@("`@("!R971U<FX@(B5S(%MN;R!C;VYT86EN960@=F%L
M=65=(B`E('-E;&8N='EP96YA;64*("`@("`@("!I9B!H87-A='1R("AS96QF
M+G9I<W5A;&EZ97(L("=C:&EL9')E;B<I.@H@("`@("`@("`@("!R971U<FX@
M(B5S(&-O;G1A:6YI;F<@)7,B("4@*'-E;&8N='EP96YA;64L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@<V5L9BYV:7-U86QI
M>F5R+G1O7W-T<FEN9R@I*0H@("`@("`@(')E='5R;B!S96QF+G1Y<&5N86UE
M"@IC;&%S<R!3=&1687)I86YT4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0
M<FEN=&5R*3H*("`@(")0<FEN="!A('-T9#HZ=F%R:6%N="(*"B`@("!D968@
M7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@86QT97)N
M871I=F5S(#T@9V5T7W1E;7!L871E7V%R9U]L:7-T*'9A;"YT>7!E*0H@("`@
M("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E
M*'1Y<&5N86UE*0H@("`@("`@('-E;&8N='EP96YA;64@/2`B)7,\)7,^(B`E
M("AS96QF+G1Y<&5N86UE+"`G+"`G+FIO:6XH6W-E;&8N7W)E8V]G;FEZ92AA
M;'0I(&9O<B!A;'0@:6X@86QT97)N871I=F5S72DI"B`@("`@("`@<V5L9BYI
M;F1E>"`]('9A;%LG7TU?:6YD97@G70H@("`@("`@(&EF('-E;&8N:6YD97@@
M/CT@;&5N*&%L=&5R;F%T:79E<RDZ"B`@("`@("`@("`@('-E;&8N8V]N=&%I
M;F5D7W1Y<&4@/2!.;VYE"B`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`]
M($YO;F4*("`@("`@("`@("`@=FES=6%L:7IE<B`]($YO;F4*("`@("`@("!E
M;'-E.@H@("`@("`@("`@("!S96QF+F-O;G1A:6YE9%]T>7!E(#T@86QT97)N
M871I=F5S6VEN="AS96QF+FEN9&5X*5T*("`@("`@("`@("`@861D<B`]('9A
M;%LG7TU?=2==6R=?35]F:7)S="==6R=?35]S=&]R86=E)UTN861D<F5S<PH@
M("`@("`@("`@("!C;VYT86EN961?=F%L=64@/2!A9&1R+F-A<W0H<V5L9BYC
M;VYT86EN961?='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*("`@("`@
M("`@("`@=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H8V]N
M=&%I;F5D7W9A;'5E*0H@("`@("`@('-U<&5R("A3=&1687)I86YT4')I;G1E
M<BP@<V5L9BDN7U]I;FET7U\H8V]N=&%I;F5D7W9A;'5E+"!V:7-U86QI>F5R
M+"`G87)R87DG*0H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@
M:68@<V5L9BYC;VYT86EN961?=F%L=64@:7,@3F]N93H*("`@("`@("`@("`@
M<F5T=7)N("(E<R!;;F\@8V]N=&%I;F5D('9A;'5E72(@)2!S96QF+G1Y<&5N
M86UE"B`@("`@("`@:68@:&%S871T<BAS96QF+G9I<W5A;&EZ97(L("=C:&EL
M9')E;B<I.@H@("`@("`@("`@("!R971U<FX@(B5S(%MI;F1E>"`E9%T@8V]N
M=&%I;FEN9R`E<R(@)2`H<V5L9BYT>7!E;F%M92P@<V5L9BYI;F1E>"P*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@('-E;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H*2D*("`@("`@("!R971U
M<FX@(B5S(%MI;F1E>"`E9%TB("4@*'-E;&8N='EP96YA;64L('-E;&8N:6YD
M97@I"@IC;&%S<R!3=&1.;V1E2&%N9&QE4')I;G1E<BA3:6YG;&5/8FI#;VYT
M86EN97)0<FEN=&5R*3H*("`@(")0<FEN="!A(&-O;G1A:6YE<B!N;V1E(&AA
M;F1L92(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ
M"B`@("`@("`@<V5L9BYV86QU95]T>7!E(#T@=F%L+G1Y<&4N=&5M<&QA=&5?
M87)G=6UE;G0H,2D*("`@("`@("!N;V1E='EP92`]('9A;"YT>7!E+G1E;7!L
M871E7V%R9W5M96YT*#(I+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@
M<V5L9BYI<U]R8E]T<F5E7VYO9&4@/2!I<U]S<&5C:6%L:7IA=&EO;E]O9BAN
M;V1E='EP92YN86UE+"`G7U)B7W1R965?;F]D92<I"B`@("`@("`@<V5L9BYI
M<U]M87!?;F]D92`]('9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I("$]
M('-E;&8N=F%L=65?='EP90H@("`@("`@(&YO9&5P='(@/2!V86Q;)U]-7W!T
M<B=="B`@("`@("`@:68@;F]D97!T<CH*("`@("`@("`@("`@:68@<V5L9BYI
M<U]R8E]T<F5E7VYO9&4Z"B`@("`@("`@("`@("`@("!C;VYT86EN961?=F%L
M=64@/2!G971?=F%L=65?9G)O;5]28E]T<F5E7VYO9&4H;F]D97!T<BYD97)E
M9F5R96YC92@I*0H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@
M8V]N=&%I;F5D7W9A;'5E(#T@9V5T7W9A;'5E7V9R;VU?86QI9VYE9%]M96UB
M=68H;F]D97!T<ELG7TU?<W1O<F%G92==+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M<V5L9BYV86QU95]T>7!E*0H@("`@("`@("`@("!V:7-U86QI>F5R(#T@9V1B
M+F1E9F%U;'1?=FES=6%L:7IE<BAC;VYT86EN961?=F%L=64I"B`@("`@("`@
M96QS93H*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@3F]N90H@("`@
M("`@("`@("!V:7-U86QI>F5R(#T@3F]N90H@("`@("`@(&]P=&%L;&]C(#T@
M=F%L6R=?35]A;&QO8R=="B`@("`@("`@<V5L9BYA;&QO8R`](&]P=&%L;&]C
M6R=?35]P87EL;V%D)UT@:68@;W!T86QL;V-;)U]-7V5N9V%G960G72!E;'-E
M($YO;F4*("`@("`@("!S=7!E<BA3=&1.;V1E2&%N9&QE4')I;G1E<BP@<V5L
M9BDN7U]I;FET7U\H8V]N=&%I;F5D7W9A;'5E+"!V:7-U86QI>F5R+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`G87)R87DG*0H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@
M9&5S8R`]("=N;V1E(&AA;F1L92!F;W(@)PH@("`@("`@(&EF(&YO="!S96QF
M+FES7W)B7W1R965?;F]D93H*("`@("`@("`@("`@9&5S8R`K/2`G=6YO<F1E
M<F5D("<*("`@("`@("!I9B!S96QF+FES7VUA<%]N;V1E.@H@("`@("`@("`@
M("!D97-C("L]("=M87`G.PH@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(&1E
M<V,@*ST@)W-E="<["@H@("`@("`@(&EF('-E;&8N8V]N=&%I;F5D7W9A;'5E
M.@H@("`@("`@("`@("!D97-C("L]("<@=VET:"!E;&5M96YT)PH@("`@("`@
M("`@("!I9B!H87-A='1R*'-E;&8N=FES=6%L:7IE<BP@)V-H:6QD<F5N)RDZ
M"B`@("`@("`@("`@("`@("!R971U<FX@(B5S(#T@)7,B("4@*&1E<V,L('-E
M;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H*2D*("`@("`@("`@("`@<F5T=7)N
M(&1E<V,*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@)V5M<'1Y
M("5S)R`E(&1E<V,*"F-L87-S(%-T9$5X<%-T<FEN9U9I97=0<FEN=&5R.@H@
M("`@(E!R:6YT(&$@<W1D.CIB87-I8U]S=')I;F=?=FEE=R!O<B!S=&0Z.F5X
M<&5R:6UE;G1A;#HZ8F%S:6-?<W1R:6YG7W9I97<B"@H@("`@9&5F(%]?:6YI
M=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]
M('9A;`H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@('!T<B`]
M('-E;&8N=F%L6R=?35]S='(G70H@("`@("`@(&QE;B`]('-E;&8N=F%L6R=?
M35]L96XG70H@("`@("`@(&EF(&AA<V%T='(@*'!T<BP@(FQA>GE?<W1R:6YG
M(BDZ"B`@("`@("`@("`@(')E='5R;B!P='(N;&%Z>5]S=')I;F<@*&QE;F=T
M:"`](&QE;BD*("`@("`@("!R971U<FX@<'1R+G-T<FEN9R`H;&5N9W1H(#T@
M;&5N*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(')E
M='5R;B`G<W1R:6YG)PH*8VQA<W,@4W1D17AP4&%T:%!R:6YT97(Z"B`@("`B
M4')I;G0@82!S=&0Z.F5X<&5R:6UE;G1A;#HZ9FEL97-Y<W1E;3HZ<&%T:"(*
M"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@
M("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<W1A<G0@/2!S96QF+G9A;%LG
M7TU?8VUP=',G75LG7TU?:6UP;"==6R=?35]S=&%R="=="B`@("`@("`@9FEN
M:7-H(#T@<V5L9BYV86Q;)U]-7V-M<'1S)UU;)U]-7VEM<&PG75LG7TU?9FEN
M:7-H)UT*("`@("`@("!S96QF+FYU;5]C;7!T<R`](&EN="`H9FEN:7-H("T@
M<W1A<G0I"@H@("`@9&5F(%]P871H7W1Y<&4H<V5L9BDZ"B`@("`@("`@="`]
M('-T<BAS96QF+G9A;%LG7TU?='EP92==*0H@("`@("`@(&EF('1;+3DZ72`]
M/2`G7U)O;W1?9&ER)SH*("`@("`@("`@("`@<F5T=7)N(")R;V]T+61I<F5C
M=&]R>2(*("`@("`@("!I9B!T6RTQ,#I=(#T]("=?4F]O=%]N86UE)SH*("`@
M("`@("`@("`@<F5T=7)N(")R;V]T+6YA;64B"B`@("`@("`@<F5T=7)N($YO
M;F4*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!P871H(#T@
M(B5S(B`E('-E;&8N=F%L(%LG7TU?<&%T:&YA;64G70H@("`@("`@(&EF('-E
M;&8N;G5M7V-M<'1S(#T](#`Z"B`@("`@("`@("`@('0@/2!S96QF+E]P871H
M7W1Y<&4H*0H@("`@("`@("`@("!I9B!T.@H@("`@("`@("`@("`@("`@<&%T
M:"`]("<E<R!;)7-=)R`E("AP871H+"!T*0H@("`@("`@(')E='5R;B`B9FEL
M97-Y<W1E;3HZ<&%T:"`E<R(@)2!P871H"@H@("`@8VQA<W,@7VET97)A=&]R
M*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@8VUP=',I
M.@H@("`@("`@("`@("!S96QF+FET96T@/2!C;7!T<ULG7TU?:6UP;"==6R=?
M35]S=&%R="=="B`@("`@("`@("`@('-E;&8N9FEN:7-H(#T@8VUP='-;)U]-
M7VEM<&PG75LG7TU?9FEN:7-H)UT*("`@("`@("`@("`@<V5L9BYC;W5N="`]
M(#`*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R
M971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@
M("`@("`@(&EF('-E;&8N:71E;2`]/2!S96QF+F9I;FES:#H*("`@("`@("`@
M("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@:71E;2`]
M('-E;&8N:71E;2YD97)E9F5R96YC92@I"B`@("`@("`@("`@(&-O=6YT(#T@
M<V5L9BYC;W5N=`H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N
M="`K(#$*("`@("`@("`@("`@<V5L9BYI=&5M(#T@<V5L9BYI=&5M("L@,0H@
M("`@("`@("`@("!P871H(#T@:71E;5LG7TU?<&%T:&YA;64G70H@("`@("`@
M("`@("!T(#T@4W1D17AP4&%T:%!R:6YT97(H:71E;2YT>7!E+FYA;64L(&ET
M96TI+E]P871H7W1Y<&4H*0H@("`@("`@("`@("!I9B!N;W0@=#H*("`@("`@
M("`@("`@("`@('0@/2!C;W5N=`H@("`@("`@("`@("!R971U<FX@*"=;)7-=
M)R`E('0L('!A=&@I"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@
M(')E='5R;B!S96QF+E]I=&5R871O<BAS96QF+G9A;%LG7TU?8VUP=',G72D*
M"F-L87-S(%-T9%!A=&A0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIF:6QE
M<WES=&5M.CIP871H(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA
M;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF
M+G1Y<&5N86UE(#T@='EP96YA;64*("`@("`@("!I;7!L(#T@<V5L9BYV86Q;
M)U]-7V-M<'1S)UU;)U]-7VEM<&PG75LG7TU?="==6R=?35]T)UU;)U]-7VAE
M861?:6UP;"=="B`@("`@("`@<V5L9BYT>7!E(#T@:6UP;"YC87-T*&=D8BYL
M;V]K=7!?='EP92@G=6EN='!T<E]T)RDI("8@,PH@("`@("`@(&EF('-E;&8N
M='EP92`]/2`P.@H@("`@("`@("`@("!S96QF+FEM<&P@/2!I;7!L"B`@("`@
M("`@96QS93H*("`@("`@("`@("`@<V5L9BYI;7!L(#T@3F]N90H*("`@(&1E
M9B!?<&%T:%]T>7!E*'-E;&8I.@H@("`@("`@('0@/2!S='(H<V5L9BYT>7!E
M+F-A<W0H9V1B+FQO;VMU<%]T>7!E*'-E;&8N='EP96YA;64@*R`G.CI?5'EP
M92<I*2D*("`@("`@("!I9B!T6RTY.ET@/3T@)U]2;V]T7V1I<B<Z"B`@("`@
M("`@("`@(')E='5R;B`B<F]O="UD:7)E8W1O<GDB"B`@("`@("`@:68@=%LM
M,3`Z72`]/2`G7U)O;W1?;F%M92<Z"B`@("`@("`@("`@(')E='5R;B`B<F]O
M="UN86UE(@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F('1O7W-T<FEN
M9R`H<V5L9BDZ"B`@("`@("`@<&%T:"`]("(E<R(@)2!S96QF+G9A;"!;)U]-
M7W!A=&AN86UE)UT*("`@("`@("!I9B!S96QF+G1Y<&4@(3T@,#H*("`@("`@
M("`@("`@="`]('-E;&8N7W!A=&A?='EP92@I"B`@("`@("`@("`@(&EF('0Z
M"B`@("`@("`@("`@("`@("!P871H(#T@)R5S(%LE<UTG("4@*'!A=&@L('0I
M"B`@("`@("`@<F5T=7)N(")F:6QE<WES=&5M.CIP871H("5S(B`E('!A=&@*
M"B`@("!C;&%S<R!?:71E<F%T;W(H271E<F%T;W(I.@H@("`@("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!I;7!L+"!P871H='EP92DZ"B`@("`@("`@("`@(&EF
M(&EM<&PZ"B`@("`@("`@("`@("`@("`C(%=E(&-A;B=T(&%C8V5S<R!?26UP
M;#HZ7TU?<VEZ92!B96-A=7-E(%]);7!L(&ES(&EN8V]M<&QE=&4*("`@("`@
M("`@("`@("`@(",@<V\@8V%S="!T;R!I;G0J('1O(&%C8V5S<R!T:&4@7TU?
M<VEZ92!M96UB97(@870@;V9F<V5T('IE<F\L"B`@("`@("`@("`@("`@("!I
M;G1?='EP92`](&=D8BYL;V]K=7!?='EP92@G:6YT)RD*("`@("`@("`@("`@
M("`@(&-M<'1?='EP92`](&=D8BYL;V]K=7!?='EP92AP871H='EP92LG.CI?
M0VUP="<I"B`@("`@("`@("`@("`@("!C:&%R7W1Y<&4@/2!G9&(N;&]O:W5P
M7W1Y<&4H)V-H87(G*0H@("`@("`@("`@("`@("`@:6UP;"`](&EM<&PN8V%S
M="AI;G1?='EP92YP;VEN=&5R*"DI"B`@("`@("`@("`@("`@("!S:7IE(#T@
M:6UP;"YD97)E9F5R96YC92@I"B`@("`@("`@("`@("`@("`C<V5L9BYC87!A
M8VET>2`]("AI;7!L("L@,2DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("`@
M("`@:68@:&%S871T<BAG9&(N5'EP92P@)V%L:6=N;V8G*3H*("`@("`@("`@
M("`@("`@("`@("!S:7IE;V9?26UP;"`](&UA>"@R("H@:6YT7W1Y<&4N<VEZ
M96]F+"!C;7!T7W1Y<&4N86QI9VYO9BD*("`@("`@("`@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@("`@("`@("`@<VEZ96]F7TEM<&P@/2`R("H@:6YT7W1Y
M<&4N<VEZ96]F"B`@("`@("`@("`@("`@("!B96=I;B`](&EM<&PN8V%S="AC
M:&%R7W1Y<&4N<&]I;G1E<B@I*2`K('-I>F5O9E]);7!L"B`@("`@("`@("`@
M("`@("!S96QF+FET96T@/2!B96=I;BYC87-T*&-M<'1?='EP92YP;VEN=&5R
M*"DI"B`@("`@("`@("`@("`@("!S96QF+F9I;FES:"`]('-E;&8N:71E;2`K
M('-I>F4*("`@("`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"B`@("`@("`@
M("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!S96QF+FET96T@/2!.;VYE"B`@
M("`@("`@("`@("`@("!S96QF+F9I;FES:"`]($YO;F4*"B`@("`@("`@9&5F
M(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@
M("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N
M:71E;2`]/2!S96QF+F9I;FES:#H*("`@("`@("`@("`@("`@(')A:7-E(%-T
M;W!)=&5R871I;VX*("`@("`@("`@("`@:71E;2`]('-E;&8N:71E;2YD97)E
M9F5R96YC92@I"B`@("`@("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@("`@
M("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@
M("`@<V5L9BYI=&5M(#T@<V5L9BYI=&5M("L@,0H@("`@("`@("`@("!P871H
M(#T@:71E;5LG7TU?<&%T:&YA;64G70H@("`@("`@("`@("!T(#T@4W1D4&%T
M:%!R:6YT97(H:71E;2YT>7!E+FYA;64L(&ET96TI+E]P871H7W1Y<&4H*0H@
M("`@("`@("`@("!I9B!N;W0@=#H*("`@("`@("`@("`@("`@('0@/2!C;W5N
M=`H@("`@("`@("`@("!R971U<FX@*"=;)7-=)R`E('0L('!A=&@I"@H@("`@
M9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R
M871O<BAS96QF+FEM<&PL('-E;&8N='EP96YA;64I"@H*8VQA<W,@4W1D4&%I
M<E!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.G!A:7(@;V)J96-T+"!W:71H
M("=F:7)S="<@86YD("=S96-O;F0G(&%S(&-H:6QD<F5N(@H*("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A
M;"`]('9A;`H*("`@(&-L87-S(%]I=&5R*$ET97)A=&]R*3H*("`@("`@("`B
M06X@:71E<F%T;W(@9F]R('-T9#HZ<&%I<B!T>7!E<RX@4F5T=7)N<R`G9FER
M<W0G('1H96X@)W-E8V]N9"<N(@H*("`@("`@("!D968@7U]I;FET7U\H<V5L
M9BP@=F%L*3H*("`@("`@("`@("`@<V5L9BYV86P@/2!V86P*("`@("`@("`@
M("`@<V5L9BYW:&EC:"`]("=F:7)S="<*"B`@("`@("`@9&5F(%]?:71E<E]?
M*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@
M7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N=VAI8V@@:7,@
M3F]N93H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@
M("`@("`@("`@=VAI8V@@/2!S96QF+G=H:6-H"B`@("`@("`@("`@(&EF('=H
M:6-H(#T]("=F:7)S="<Z"B`@("`@("`@("`@("`@("!S96QF+G=H:6-H(#T@
M)W-E8V]N9"<*("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@('-E
M;&8N=VAI8V@@/2!.;VYE"B`@("`@("`@("`@(')E='5R;B`H=VAI8V@L('-E
M;&8N=F%L6W=H:6-H72D*"B`@("!D968@8VAI;&1R96XH<V5L9BDZ"B`@("`@
M("`@<F5T=7)N('-E;&8N7VET97(H<V5L9BYV86PI"@H@("`@9&5F('1O7W-T
M<FEN9RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*8VQA<W,@4W1D0VUP
M0V%T4')I;G1E<CH*("`@(")0<FEN="!A(&-O;7!A<FES;VX@8V%T96=O<GD@
M;V)J96-T(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A
M;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('1Y<&5N86UE6W1Y<&5N86UE
M+G)F:6YD*"<Z)RDK,3I="B`@("`@("`@<V5L9BYV86P@/2!V86Q;)U]-7W9A
M;'5E)UT*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!I9B!S
M96QF+G1Y<&5N86UE(#T]("=S=')O;F=?;W)D97)I;F<G(&%N9"!S96QF+G9A
M;"`]/2`P.@H@("`@("`@("`@("!N86UE(#T@)V5Q=6%L)PH@("`@("`@(&5L
M<V4Z"B`@("`@("`@("`@(&YA;65S(#T@>RTQ,C<Z)W5N;W)D97)E9"<L("TQ
M.B=L97-S)RP@,#HG97%U:79A;&5N="<L(#$Z)V=R96%T97(G?0H@("`@("`@
M("`@("!N86UE(#T@;F%M97-;:6YT*'-E;&8N=F%L*5T*("`@("`@("!R971U
M<FX@)W-T9#HZ>WTZ.GM])RYF;W)M870H<V5L9BYT>7!E;F%M92P@;F%M92D*
M"B,@02`B<F5G=6QA<B!E>'!R97-S:6]N(B!P<FEN=&5R('=H:6-H(&-O;F9O
M<FUS('1O('1H90HC(")3=6)0<F5T='E0<FEN=&5R(B!P<F]T;V-O;"!F<F]M
M(&=D8BYP<FEN=&EN9RX*8VQA<W,@4GA0<FEN=&5R*&]B:F5C="DZ"B`@("!D
M968@7U]I;FET7U\H<V5L9BP@;F%M92P@9G5N8W1I;VXI.@H@("`@("`@('-U
M<&5R*%)X4')I;G1E<BP@<V5L9BDN7U]I;FET7U\H*0H@("`@("`@('-E;&8N
M;F%M92`](&YA;64*("`@("`@("!S96QF+F9U;F-T:6]N(#T@9G5N8W1I;VX*
M("`@("`@("!S96QF+F5N86)L960@/2!4<G5E"@H@("`@9&5F(&EN=F]K92AS
M96QF+"!V86QU92DZ"B`@("`@("`@:68@;F]T('-E;&8N96YA8FQE9#H*("`@
M("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@:68@=F%L=64N='EP92YC
M;V1E(#T](&=D8BY465!%7T-/1$5?4D5&.@H@("`@("`@("`@("!I9B!H87-A
M='1R*&=D8BY686QU92PB<F5F97)E;F-E9%]V86QU92(I.@H@("`@("`@("`@
M("`@("`@=F%L=64@/2!V86QU92YR969E<F5N8V5D7W9A;'5E*"D*"B`@("`@
M("`@<F5T=7)N('-E;&8N9G5N8W1I;VXH<V5L9BYN86UE+"!V86QU92D*"B,@
M02!P<F5T='DM<')I;G1E<B!T:&%T(&-O;F9O<FUS('1O('1H92`B4')E='1Y
M4')I;G1E<B(@<')O=&]C;VP@9G)O;0HC(&=D8BYP<FEN=&EN9RX@($ET(&-A
M;B!A;'-O(&)E('5S960@9&ER96-T;'D@87,@86X@;VQD+7-T>6QE('!R:6YT
M97(N"F-L87-S(%!R:6YT97(H;V)J96-T*3H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!N86UE*3H*("`@("`@("!S=7!E<BA0<FEN=&5R+"!S96QF*2Y?7VEN
M:71?7R@I"B`@("`@("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@('-E;&8N
M<W5B<')I;G1E<G,@/2!;70H@("`@("`@('-E;&8N;&]O:W5P(#T@>WT*("`@
M("`@("!S96QF+F5N86)L960@/2!4<G5E"B`@("`@("`@<V5L9BYC;VUP:6QE
M9%]R>"`](')E+F-O;7!I;&4H)UXH6V$M>D$M6C`M.5\Z72LI*#PN*CXI/R0G
M*0H*("`@(&1E9B!A9&0H<V5L9BP@;F%M92P@9G5N8W1I;VXI.@H@("`@("`@
M(",@02!S;6%L;"!S86YI='D@8VAE8VLN"B`@("`@("`@(R!&25A-10H@("`@
M("`@(&EF(&YO="!S96QF+F-O;7!I;&5D7W)X+FUA=&-H*&YA;64I.@H@("`@
M("`@("`@("!R86ES92!686QU945R<F]R*"=L:6)S=&1C*RL@<')O9W)A;6UI
M;F<@97)R;W(Z("(E<R(@9&]E<R!N;W0@;6%T8V@G("4@;F%M92D*("`@("`@
M("!P<FEN=&5R(#T@4GA0<FEN=&5R*&YA;64L(&9U;F-T:6]N*0H@("`@("`@
M('-E;&8N<W5B<')I;G1E<G,N87!P96YD*'!R:6YT97(I"B`@("`@("`@<V5L
M9BYL;V]K=7!;;F%M95T@/2!P<FEN=&5R"@H@("`@(R!!9&0@82!N86UE('5S
M:6YG(%]'3$E"0UA87T)%1TE.7TY!34534$%#15]615)324].+@H@("`@9&5F
M(&%D9%]V97)S:6]N*'-E;&8L(&)A<V4L(&YA;64L(&9U;F-T:6]N*3H*("`@
M("`@("!S96QF+F%D9"AB87-E("L@;F%M92P@9G5N8W1I;VXI"B`@("`@("`@
M:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@("`@("`@('9B87-E(#T@
M<F4N<W5B*"=>*'-T9'Q?7V=N=5]C>'@I.CHG+"!R)UQG/#`^)7,G("4@7W9E
M<G-I;VYE9%]N86UE<W!A8V4L(&)A<V4I"B`@("`@("`@("`@('-E;&8N861D
M*'9B87-E("L@;F%M92P@9G5N8W1I;VXI"@H@("`@(R!!9&0@82!N86UE('5S
M:6YG(%]'3$E"0UA87T)%1TE.7TY!34534$%#15]#3TY404E.15(N"B`@("!D
M968@861D7V-O;G1A:6YE<BAS96QF+"!B87-E+"!N86UE+"!F=6YC=&EO;BDZ
M"B`@("`@("`@<V5L9BYA9&1?=F5R<VEO;BAB87-E+"!N86UE+"!F=6YC=&EO
M;BD*("`@("`@("!S96QF+F%D9%]V97)S:6]N*&)A<V4@*R`G7U]C>'@Q.3DX
M.CHG+"!N86UE+"!F=6YC=&EO;BD*"B`@("!`<W1A=&EC;65T:&]D"B`@("!D
M968@9V5T7V)A<VEC7W1Y<&4H='EP92DZ"B`@("`@("`@(R!)9B!I="!P;VEN
M=',@=&\@82!R969E<F5N8V4L(&=E="!T:&4@<F5F97)E;F-E+@H@("`@("`@
M(&EF('1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@
M("`@='EP92`]('1Y<&4N=&%R9V5T("@I"@H@("`@("`@(",@1V5T('1H92!U
M;G%U86QI9FEE9"!T>7!E+"!S=')I<'!E9"!O9B!T>7!E9&5F<RX*("`@("`@
M("!T>7!E(#T@='EP92YU;G%U86QI9FEE9"`H*2YS=')I<%]T>7!E9&5F<R`H
M*0H*("`@("`@("!R971U<FX@='EP92YT86<*"B`@("!D968@7U]C86QL7U\H
M<V5L9BP@=F%L*3H*("`@("`@("!T>7!E;F%M92`]('-E;&8N9V5T7V)A<VEC
M7W1Y<&4H=F%L+G1Y<&4I"B`@("`@("`@:68@;F]T('1Y<&5N86UE.@H@("`@
M("`@("`@("!R971U<FX@3F]N90H*("`@("`@("`C($%L;"!T:&4@='EP97,@
M=V4@;6%T8V@@87)E('1E;7!L871E('1Y<&5S+"!S;R!W92!C86X@=7-E(&$*
M("`@("`@("`C(&1I8W1I;VYA<GDN"B`@("`@("`@;6%T8V@@/2!S96QF+F-O
M;7!I;&5D7W)X+FUA=&-H*'1Y<&5N86UE*0H@("`@("`@(&EF(&YO="!M871C
M:#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@8F%S96YA;64@
M/2!M871C:"YG<F]U<"@Q*0H*("`@("`@("!I9B!V86PN='EP92YC;V1E(#T]
M(&=D8BY465!%7T-/1$5?4D5&.@H@("`@("`@("`@("!I9B!H87-A='1R*&=D
M8BY686QU92PB<F5F97)E;F-E9%]V86QU92(I.@H@("`@("`@("`@("`@("`@
M=F%L(#T@=F%L+G)E9F5R96YC961?=F%L=64H*0H*("`@("`@("!I9B!B87-E
M;F%M92!I;B!S96QF+FQO;VMU<#H*("`@("`@("`@("`@<F5T=7)N('-E;&8N
M;&]O:W5P6V)A<V5N86UE72YI;G9O:V4H=F%L*0H*("`@("`@("`C($-A;FYO
M="!F:6YD(&$@<')E='1Y('!R:6YT97(N("!2971U<FX@3F]N92X*("`@("`@
M("!R971U<FX@3F]N90H*;&EB<W1D8WAX7W!R:6YT97(@/2!.;VYE"@IC;&%S
M<R!496UP;&%T951Y<&50<FEN=&5R*&]B:F5C="DZ"B`@("!R(B(B"B`@("!!
M('1Y<&4@<')I;G1E<B!F;W(@8VQA<W,@=&5M<&QA=&5S('=I=&@@9&5F875L
M="!T96UP;&%T92!A<F=U;65N=',N"@H@("`@4F5C;V=N:7IE<R!S<&5C:6%L
M:7IA=&EO;G,@;V8@8VQA<W,@=&5M<&QA=&5S(&%N9"!P<FEN=',@=&AE;2!W
M:71H;W5T"B`@("!A;GD@=&5M<&QA=&4@87)G=6UE;G1S('1H870@=7-E(&$@
M9&5F875L="!T96UP;&%T92!A<F=U;65N="X*("`@(%1Y<&4@<')I;G1E<G,@
M87)E(')E8W5R<VEV96QY(&%P<&QI960@=&\@=&AE('1E;7!L871E(&%R9W5M
M96YT<RX*"B`@("!E+F<N(')E<&QA8V4@(G-T9#HZ=F5C=&]R/%0L('-T9#HZ
M86QL;V-A=&]R/%0^(#XB('=I=&@@(G-T9#HZ=F5C=&]R/%0^(BX*("`@("(B
M(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!N86UE+"!D969A<F=S*3H*("`@
M("`@("!S96QF+FYA;64@/2!N86UE"B`@("`@("`@<V5L9BYD969A<F=S(#T@
M9&5F87)G<PH@("`@("`@('-E;&8N96YA8FQE9"`](%1R=64*"B`@("!C;&%S
M<R!?<F5C;V=N:7IE<BAO8FIE8W0I.@H@("`@("`@(")4:&4@<F5C;V=N:7IE
M<B!C;&%S<R!F;W(@5&5M<&QA=&54>7!E4')I;G1E<BXB"@H@("`@("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!N86UE+"!D969A<F=S*3H*("`@("`@("`@("`@
M<V5L9BYN86UE(#T@;F%M90H@("`@("`@("`@("!S96QF+F1E9F%R9W,@/2!D
M969A<F=S"B`@("`@("`@("`@(",@<V5L9BYT>7!E7V]B:B`]($YO;F4*"B`@
M("`@("`@9&5F(')E8V]G;FEZ92AS96QF+"!T>7!E7V]B:BDZ"B`@("`@("`@
M("`@("(B(@H@("`@("`@("`@("!)9B!T>7!E7V]B:B!I<R!A('-P96-I86QI
M>F%T:6]N(&]F('-E;&8N;F%M92!T:&%T('5S97,@86QL('1H90H@("`@("`@
M("`@("!D969A=6QT('1E;7!L871E(&%R9W5M96YT<R!F;W(@=&AE(&-L87-S
M('1E;7!L871E+"!T:&5N(')E='5R;@H@("`@("`@("`@("!A('-T<FEN9R!R
M97!R97-E;G1A=&EO;B!O9B!T:&4@='EP92!W:71H;W5T(&1E9F%U;'0@87)G
M=6UE;G1S+@H@("`@("`@("`@("!/=&AE<G=I<V4L(')E='5R;B!.;VYE+@H@
M("`@("`@("`@("`B(B(*"B`@("`@("`@("`@(&EF('1Y<&5?;V)J+G1A9R!I
M<R!.;VYE.@H@("`@("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@
M("`@(&EF(&YO="!T>7!E7V]B:BYT86<N<W1A<G1S=VET:"AS96QF+FYA;64I
M.@H@("`@("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@("`@('1E
M;7!L871E7V%R9W,@/2!G971?=&5M<&QA=&5?87)G7VQI<W0H='EP95]O8FHI
M"B`@("`@("`@("`@(&1I<W!L87EE9%]A<F=S(#T@6UT*("`@("`@("`@("`@
M<F5Q=6ER95]D969A=6QT960@/2!&86QS90H@("`@("`@("`@("!F;W(@;B!I
M;B!R86YG92AL96XH=&5M<&QA=&5?87)G<RDI.@H@("`@("`@("`@("`@("`@
M(R!4:&4@86-T=6%L('1E;7!L871E(&%R9W5M96YT(&EN('1H92!T>7!E.@H@
M("`@("`@("`@("`@("`@=&%R9R`]('1E;7!L871E7V%R9W-;;ET*("`@("`@
M("`@("`@("`@(",@5&AE(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G0@9F]R
M('1H92!C;&%S<R!T96UP;&%T93H*("`@("`@("`@("`@("`@(&1E9F%R9R`]
M('-E;&8N9&5F87)G<RYG970H;BD*("`@("`@("`@("`@("`@(&EF(&1E9F%R
M9R!I<R!N;W0@3F]N93H*("`@("`@("`@("`@("`@("`@("`C(%-U8G-T:71U
M=&4@;W1H97(@=&5M<&QA=&4@87)G=6UE;G1S(&EN=&\@=&AE(&1E9F%U;'0Z
M"B`@("`@("`@("`@("`@("`@("`@9&5F87)G(#T@9&5F87)G+F9O<FUA="@J
M=&5M<&QA=&5?87)G<RD*("`@("`@("`@("`@("`@("`@("`C($9A:6P@=&\@
M<F5C;V=N:7IE('1H92!T>7!E("AB>2!R971U<FYI;F<@3F]N92D*("`@("`@
M("`@("`@("`@("`@("`C('5N;&5S<R!T:&4@86-T=6%L(&%R9W5M96YT(&ES
M('1H92!S86UE(&%S('1H92!D969A=6QT+@H@("`@("`@("`@("`@("`@("`@
M('1R>3H*("`@("`@("`@("`@("`@("`@("`@("`@:68@=&%R9R`A/2!G9&(N
M;&]O:W5P7W1Y<&4H9&5F87)G*3H*("`@("`@("`@("`@("`@("`@("`@("`@
M("`@(')E='5R;B!.;VYE"B`@("`@("`@("`@("`@("`@("`@97AC97!T(&=D
M8BYE<G)O<CH*("`@("`@("`@("`@("`@("`@("`@("`@(R!4>7!E(&QO;VMU
M<"!F86EL960L(&IU<W0@=7-E('-T<FEN9R!C;VUP87)I<V]N.@H@("`@("`@
M("`@("`@("`@("`@("`@("!I9B!T87)G+G1A9R`A/2!D969A<F<Z"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@("`@
M("`@("`@("`@(",@06QL('-U8G-E<75E;G0@87)G<R!M=7-T(&AA=F4@9&5F
M875L=',Z"B`@("`@("`@("`@("`@("`@("`@<F5Q=6ER95]D969A=6QT960@
M/2!4<G5E"B`@("`@("`@("`@("`@("!E;&EF(')E<75I<F5?9&5F875L=&5D
M.@H@("`@("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@("`@
M("`@("!E;'-E.@H@("`@("`@("`@("`@("`@("`@(",@4F5C=7)S:79E;'D@
M87!P;'D@<F5C;V=N:7IE<G,@=&\@=&AE('1E;7!L871E(&%R9W5M96YT"B`@
M("`@("`@("`@("`@("`@("`@(R!A;F0@861D(&ET('1O('1H92!A<F=U;65N
M=',@=&AA="!W:6QL(&)E(&1I<W!L87EE9#H*("`@("`@("`@("`@("`@("`@
M("!D:7-P;&%Y961?87)G<RYA<'!E;F0H<V5L9BY?<F5C;V=N:7IE7W-U8G1Y
M<&4H=&%R9RDI"@H@("`@("`@("`@("`C(%1H:7,@87-S=6UE<R!N;R!C;&%S
M<R!T96UP;&%T97,@:6X@=&AE(&YE<W1E9"UN86UE+7-P96-I9FEE<CH*("`@
M("`@("`@("`@=&5M<&QA=&5?;F%M92`]('1Y<&5?;V)J+G1A9ULP.G1Y<&5?
M;V)J+G1A9RYF:6YD*"<\)RE="B`@("`@("`@("`@('1E;7!L871E7VYA;64@
M/2!S=')I<%]I;FQI;F5?;F%M97-P86-E<RAT96UP;&%T95]N86UE*0H*("`@
M("`@("`@("`@<F5T=7)N('1E;7!L871E7VYA;64@*R`G/"<@*R`G+"`G+FIO
M:6XH9&ES<&QA>65D7V%R9W,I("L@)SXG"@H@("`@("`@(&1E9B!?<F5C;V=N
M:7IE7W-U8G1Y<&4H<V5L9BP@='EP95]O8FHI.@H@("`@("`@("`@("`B(B)#
M;VYV97)T(&$@9V1B+E1Y<&4@=&\@82!S=')I;F<@8GD@87!P;'EI;F<@<F5C
M;V=N:7IE<G,L"B`@("`@("`@("`@(&]R(&EF('1H870@9F%I;',@=&AE;B!S
M:6UP;'D@8V]N=F5R=&EN9R!T;R!A('-T<FEN9RXB(B(*"B`@("`@("`@("`@
M(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?0T]$15]05%(Z"B`@("`@
M("`@("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N:7IE7W-U8G1Y<&4H='EP
M95]O8FHN=&%R9V5T*"DI("L@)RHG"B`@("`@("`@("`@(&EF('1Y<&5?;V)J
M+F-O9&4@/3T@9V1B+E194$5?0T]$15]!4E)!63H*("`@("`@("`@("`@("`@
M('1Y<&5?<W1R(#T@<V5L9BY?<F5C;V=N:7IE7W-U8G1Y<&4H='EP95]O8FHN
M=&%R9V5T*"DI"B`@("`@("`@("`@("`@("!I9B!S='(H='EP95]O8FHN<W1R
M:7!?='EP961E9G,H*2DN96YD<W=I=&@H)UM=)RDZ"B`@("`@("`@("`@("`@
M("`@("`@<F5T=7)N('1Y<&5?<W1R("L@)UM=)R`C(&%R<F%Y(&]F('5N:VYO
M=VX@8F]U;F0*("`@("`@("`@("`@("`@(')E='5R;B`B)7-;)61=(B`E("AT
M>7!E7W-T<BP@='EP95]O8FHN<F%N9V4H*5LQ72`K(#$I"B`@("`@("`@("`@
M(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?0T]$15]2148Z"B`@("`@
M("`@("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N:7IE7W-U8G1Y<&4H='EP
M95]O8FHN=&%R9V5T*"DI("L@)R8G"B`@("`@("`@("`@(&EF(&AA<V%T='(H
M9V1B+"`G5%E015]#3T1%7U)604Q515]2148G*3H*("`@("`@("`@("`@("`@
M(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?0T]$15]25D%,545?4D5&
M.@H@("`@("`@("`@("`@("`@("`@(')E='5R;B!S96QF+E]R96-O9VYI>F5?
M<W5B='EP92AT>7!E7V]B:BYT87)G970H*2D@*R`G)B8G"@H@("`@("`@("`@
M("!T>7!E7W-T<B`](&=D8BYT>7!E<RYA<'!L>5]T>7!E7W)E8V]G;FEZ97)S
M*`H@("`@("`@("`@("`@("`@("`@(&=D8BYT>7!E<RYG971?='EP95]R96-O
M9VYI>F5R<R@I+"!T>7!E7V]B:BD*("`@("`@("`@("`@:68@='EP95]S='(Z
M"B`@("`@("`@("`@("`@("!R971U<FX@='EP95]S='(*("`@("`@("`@("`@
M<F5T=7)N('-T<BAT>7!E7V]B:BD*"B`@("!D968@:6YS=&%N=&EA=&4H<V5L
M9BDZ"B`@("`@("`@(E)E='5R;B!A(')E8V]G;FEZ97(@;V)J96-T(&9O<B!T
M:&ES('1Y<&4@<')I;G1E<BXB"B`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G
M;FEZ97(H<V5L9BYN86UE+"!S96QF+F1E9F%R9W,I"@ID968@861D7V]N95]T
M96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"!N86UE+"!D969A<F=S*3H*("`@
M('(B(B(*("`@($%D9"!A('1Y<&4@<')I;G1E<B!F;W(@82!C;&%S<R!T96UP
M;&%T92!W:71H(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G1S+@H*("`@($%R
M9W,Z"B`@("`@("`@;F%M92`H<W1R*3H@5&AE('1E;7!L871E+6YA;64@;V8@
M=&AE(&-L87-S('1E;7!L871E+@H@("`@("`@(&1E9F%R9W,@*&1I8W0@:6YT
M.G-T<FEN9RD@5&AE(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G1S+@H*("`@
M(%1Y<&5S(&EN(&1E9F%R9W,@8V%N(')E9F5R('1O('1H92!.=&@@=&5M<&QA
M=&4M87)G=6UE;G0@=7-I;F<@>TY]"B`@("`H=VET:"!Z97)O+6)A<V5D(&EN
M9&EC97,I+@H*("`@(&4N9RX@)W5N;W)D97)E9%]M87`G(&AA<R!T:&5S92!D
M969A<F=S.@H@("`@>R`R.B`G<W1D.CIH87-H/'LP?3XG+`H@("`@("`S.B`G
M<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@("`@-#H@)W-T9#HZ86QL;V-A=&]R
M/'-T9#HZ<&%I<CQC;VYS="![,'TL('LQ?3X@/B<@?0H*("`@("(B(@H@("`@
M<')I;G1E<B`](%1E;7!L871E5'EP95!R:6YT97(H)W-T9#HZ)RMN86UE+"!D
M969A<F=S*0H@("`@9V1B+G1Y<&5S+G)E9VES=&5R7W1Y<&5?<')I;G1E<BAO
M8FHL('!R:6YT97(I"@H@("`@(R!!9&0@='EP92!P<FEN=&5R(&9O<B!S86UE
M('1Y<&4@:6X@9&5B=6<@;F%M97-P86-E.@H@("`@<')I;G1E<B`](%1E;7!L
M871E5'EP95!R:6YT97(H)W-T9#HZ7U]D96)U9SHZ)RMN86UE+"!D969A<F=S
M*0H@("`@9V1B+G1Y<&5S+G)E9VES=&5R7W1Y<&5?<')I;G1E<BAO8FHL('!R
M:6YT97(I"@H@("`@:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@("`@
M(R!!9&0@<V5C;VYD('1Y<&4@<')I;G1E<B!F;W(@<V%M92!T>7!E(&EN('9E
M<G-I;VYE9"!N86UE<W!A8V4Z"B`@("`@("`@;G,@/2`G<W1D.CHG("L@7W9E
M<G-I;VYE9%]N86UE<W!A8V4*("`@("`@("`C(%!2(#@V,3$R($-A;FYO="!U
M<V4@9&EC="!C;VUP<F5H96YS:6]N(&AE<F4Z"B`@("`@("`@9&5F87)G<R`]
M(&1I8W0H*&XL(&0N<F5P;&%C92@G<W1D.CHG+"!N<RDI(&9O<B`H;BQD*2!I
M;B!D969A<F=S+FET96US*"DI"B`@("`@("`@<')I;G1E<B`](%1E;7!L871E
M5'EP95!R:6YT97(H;G,K;F%M92P@9&5F87)G<RD*("`@("`@("!G9&(N='EP
M97,N<F5G:7-T97)?='EP95]P<FEN=&5R*&]B:BP@<')I;G1E<BD*"F-L87-S
M($9I;'1E<FEN9U1Y<&50<FEN=&5R*&]B:F5C="DZ"B`@("!R(B(B"B`@("!!
M('1Y<&4@<')I;G1E<B!T:&%T('5S97,@='EP961E9B!N86UE<R!F;W(@8V]M
M;6]N('1E;7!L871E('-P96-I86QI>F%T:6]N<RX*"B`@("!!<F=S.@H@("`@
M("`@(&UA=&-H("AS='(I.B!4:&4@8VQA<W,@=&5M<&QA=&4@=&\@<F5C;V=N
M:7IE+@H@("`@("`@(&YA;64@*'-T<BDZ(%1H92!T>7!E9&5F+6YA;64@=&AA
M="!W:6QL(&)E('5S960@:6YS=&5A9"X*"B`@("!#:&5C:W,@:68@82!S<&5C
M:6%L:7IA=&EO;B!O9B!T:&4@8VQA<W,@=&5M<&QA=&4@)VUA=&-H)R!I<R!T
M:&4@<V%M92!T>7!E"B`@("!A<R!T:&4@='EP961E9B`G;F%M92<L(&%N9"!P
M<FEN=',@:70@87,@)VYA;64G(&EN<W1E860N"@H@("`@92YG+B!I9B!A;B!I
M;G-T86YT:6%T:6]N(&]F('-T9#HZ8F%S:6-?:7-T<F5A;3Q#+"!4/B!I<R!T
M:&4@<V%M92!T>7!E(&%S"B`@("!S=&0Z.FES=')E86T@=&AE;B!P<FEN="!I
M="!A<R!S=&0Z.FES=')E86TN"B`@("`B(B(*"B`@("!D968@7U]I;FET7U\H
M<V5L9BP@;6%T8V@L(&YA;64I.@H@("`@("`@('-E;&8N;6%T8V@@/2!M871C
M:`H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@("!S96QF+F5N86)L
M960@/2!4<G5E"@H@("`@8VQA<W,@7W)E8V]G;FEZ97(H;V)J96-T*3H*("`@
M("`@("`B5&AE(')E8V]G;FEZ97(@8VQA<W,@9F]R(%1E;7!L871E5'EP95!R
M:6YT97(N(@H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@;6%T8V@L(&YA
M;64I.@H@("`@("`@("`@("!S96QF+FUA=&-H(#T@;6%T8V@*("`@("`@("`@
M("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@("`@("!S96QF+G1Y<&5?;V)J
M(#T@3F]N90H*("`@("`@("!D968@<F5C;V=N:7IE*'-E;&8L('1Y<&5?;V)J
M*3H*("`@("`@("`@("`@(B(B"B`@("`@("`@("`@($EF('1Y<&5?;V)J('-T
M87)T<R!W:71H('-E;&8N;6%T8V@@86YD(&ES('1H92!S86UE('1Y<&4@87,*
M("`@("`@("`@("`@<V5L9BYN86UE('1H96X@<F5T=7)N('-E;&8N;F%M92P@
M;W1H97)W:7-E($YO;F4N"B`@("`@("`@("`@("(B(@H@("`@("`@("`@("!I
M9B!T>7!E7V]B:BYT86<@:7,@3F]N93H*("`@("`@("`@("`@("`@(')E='5R
M;B!.;VYE"@H@("`@("`@("`@("!I9B!S96QF+G1Y<&5?;V)J(&ES($YO;F4Z
M"B`@("`@("`@("`@("`@("!I9B!N;W0@='EP95]O8FHN=&%G+G-T87)T<W=I
M=&@H<V5L9BYM871C:"DZ"B`@("`@("`@("`@("`@("`@("`@(R!&:6QT97(@
M9&ED;B=T(&UA=&-H+@H@("`@("`@("`@("`@("`@("`@(')E='5R;B!.;VYE
M"B`@("`@("`@("`@("`@("!T<GDZ"B`@("`@("`@("`@("`@("`@("`@<V5L
M9BYT>7!E7V]B:B`](&=D8BYL;V]K=7!?='EP92AS96QF+FYA;64I+G-T<FEP
M7W1Y<&5D969S*"D*("`@("`@("`@("`@("`@(&5X8V5P=#H*("`@("`@("`@
M("`@("`@("`@("!P87-S"B`@("`@("`@("`@(&EF('-E;&8N='EP95]O8FH@
M/3T@='EP95]O8FHZ"B`@("`@("`@("`@("`@("!R971U<FX@<W1R:7!?:6YL
M:6YE7VYA;65S<&%C97,H<V5L9BYN86UE*0H@("`@("`@("`@("!R971U<FX@
M3F]N90H*("`@(&1E9B!I;G-T86YT:6%T92AS96QF*3H*("`@("`@("`B4F5T
M=7)N(&$@<F5C;V=N:7IE<B!O8FIE8W0@9F]R('1H:7,@='EP92!P<FEN=&5R
M+B(*("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N:7IE<BAS96QF+FUA=&-H
M+"!S96QF+FYA;64I"@ID968@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"!M
M871C:"P@;F%M92DZ"B`@("!P<FEN=&5R(#T@1FEL=&5R:6YG5'EP95!R:6YT
M97(H)W-T9#HZ)R`K(&UA=&-H+"`G<W1D.CHG("L@;F%M92D*("`@(&=D8BYT
M>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT97(H;V)J+"!P<FEN=&5R*0H@("`@
M:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@("`@;G,@/2`G<W1D.CHG
M("L@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@("`@("!P<FEN=&5R(#T@1FEL
M=&5R:6YG5'EP95!R:6YT97(H;G,@*R!M871C:"P@;G,@*R!N86UE*0H@("`@
M("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT97(H;V)J+"!P<FEN
M=&5R*0H*9&5F(')E9VES=&5R7W1Y<&5?<')I;G1E<G,H;V)J*3H*("`@(&=L
M;V)A;"!?=7-E7W1Y<&5?<')I;G1I;F<*"B`@("!I9B!N;W0@7W5S95]T>7!E
M7W!R:6YT:6YG.@H@("`@("`@(')E='5R;@H*("`@(",@061D('1Y<&4@<')I
M;G1E<G,@9F]R('1Y<&5D969S('-T9#HZ<W1R:6YG+"!S=&0Z.G=S=')I;F<@
M971C+@H@("`@9F]R(&-H(&EN("@G)RP@)W<G+"`G=3@G+"`G=3$V)RP@)W4S
M,B<I.@H@("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)V)A<VEC
M7W-T<FEN9R<L(&-H("L@)W-T<FEN9R<I"B`@("`@("`@861D7V]N95]T>7!E
M7W!R:6YT97(H;V)J+"`G7U]C>'@Q,3HZ8F%S:6-?<W1R:6YG)RP@8V@@*R`G
M<W1R:6YG)RD*("`@("`@("`C(%1Y<&5D969S(&9O<B!?7V-X>#$Q.CIB87-I
M8U]S=')I;F<@=7-E9"!T;R!B92!I;B!N86UE<W!A8V4@7U]C>'@Q,3H*("`@
M("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=?7V-X>#$Q.CIB87-I
M8U]S=')I;F<G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=?7V-X
M>#$Q.CHG("L@8V@@*R`G<W1R:6YG)RD*("`@("`@("!A9&1?;VYE7W1Y<&5?
M<')I;G1E<BAO8FHL("=B87-I8U]S=')I;F=?=FEE=R<L(&-H("L@)W-T<FEN
M9U]V:65W)RD*"B`@("`C($%D9"!T>7!E('!R:6YT97)S(&9O<B!T>7!E9&5F
M<R!S=&0Z.FES=')E86TL('-T9#HZ=VES=')E86T@971C+@H@("`@9F]R(&-H
M(&EN("@G)RP@)W<G*3H*("`@("`@("!F;W(@>"!I;B`H)VEO<R<L("=S=')E
M86UB=68G+"`G:7-T<F5A;2<L("=O<W1R96%M)RP@)VEO<W1R96%M)RP*("`@
M("`@("`@("`@("`@("`@)V9I;&5B=68G+"`G:69S=')E86TG+"`G;V9S=')E
M86TG+"`G9G-T<F5A;2<I.@H@("`@("`@("`@("!A9&1?;VYE7W1Y<&5?<')I
M;G1E<BAO8FHL("=B87-I8U\G("L@>"P@8V@@*R!X*0H@("`@("`@(&9O<B!X
M(&EN("@G<W1R:6YG8G5F)RP@)VES=')I;F=S=')E86TG+"`G;W-T<FEN9W-T
M<F5A;2<L"B`@("`@("`@("`@("`@("`@("=S=')I;F=S=')E86TG*3H*("`@
M("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G8F%S:6-?)R`K
M('@L(&-H("L@>"D*("`@("`@("`@("`@(R`\<W-T<F5A;3X@='EP97,@87)E
M(&EN(%]?8WAX,3$@;F%M97-P86-E+"!B=70@='EP961E9G,@87)E;B=T.@H@
M("`@("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=?7V-X>#$Q
M.CIB87-I8U\G("L@>"P@8V@@*R!X*0H*("`@(",@061D('1Y<&4@<')I;G1E
M<G,@9F]R('1Y<&5D969S(')E9V5X+"!W<F5G97@L(&-M871C:"P@=V-M871C
M:"!E=&,N"B`@("!F;W(@86)I(&EN("@G)RP@)U]?8WAX,3$Z.B<I.@H@("`@
M("`@(&9O<B!C:"!I;B`H)R<L("=W)RDZ"B`@("`@("`@("`@(&%D9%]O;F5?
M='EP95]P<FEN=&5R*&]B:BP@86)I("L@)V)A<VEC7W)E9V5X)RP@86)I("L@
M8V@@*R`G<F5G97@G*0H@("`@("`@(&9O<B!C:"!I;B`H)V,G+"`G<R<L("=W
M8R<L("=W<R<I.@H@("`@("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO
M8FHL(&%B:2`K("=M871C:%]R97-U;'1S)RP@86)I("L@8V@@*R`G;6%T8V@G
M*0H@("`@("`@("`@("!F;W(@>"!I;B`H)W-U8E]M871C:"<L("=R96=E>%]I
M=&5R871O<B<L("=R96=E>%]T;VME;E]I=&5R871O<B<I.@H@("`@("`@("`@
M("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"!A8FD@*R!X+"!A8FD@
M*R!C:"`K('@I"@H@("`@(R!.;W1E('1H870@=V4@8V%N)W0@:&%V92!A('!R
M:6YT97(@9F]R('-T9#HZ=W-T<F5A;7!O<RP@8F5C875S90H@("`@(R!I="!I
M<R!T:&4@<V%M92!T>7!E(&%S('-T9#HZ<W1R96%M<&]S+@H@("`@861D7V]N
M95]T>7!E7W!R:6YT97(H;V)J+"`G9G!O<R<L("=S=')E86UP;W,G*0H*("`@
M(",@061D('1Y<&4@<')I;G1E<G,@9F]R(#QC:')O;F\^('1Y<&5D969S+@H@
M("`@9F]R(&1U<B!I;B`H)VYA;F]S96-O;F1S)RP@)VUI8W)O<V5C;VYD<R<L
M("=M:6QL:7-E8V]N9',G+`H@("`@("`@("`@("`@("`@)W-E8V]N9',G+"`G
M;6EN=71E<R<L("=H;W5R<R<I.@H@("`@("`@(&%D9%]O;F5?='EP95]P<FEN
M=&5R*&]B:BP@)V1U<F%T:6]N)RP@9'5R*0H*("`@(",@061D('1Y<&4@<')I
M;G1E<G,@9F]R(#QR86YD;VT^('1Y<&5D969S+@H@("`@861D7V]N95]T>7!E
M7W!R:6YT97(H;V)J+"`G;&EN96%R7V-O;F=R=65N=&EA;%]E;F=I;F4G+"`G
M;6EN<W1D7W)A;F0P)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@
M)VQI;F5A<E]C;VYG<G5E;G1I86Q?96YG:6YE)RP@)VUI;G-T9%]R86YD)RD*
M("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)VUE<G-E;FYE7W1W:7-T
M97)?96YG:6YE)RP@)VUT,3DY,S<G*0H@("`@861D7V]N95]T>7!E7W!R:6YT
M97(H;V)J+"`G;65R<V5N;F5?='=I<W1E<E]E;F=I;F4G+"`G;70Q.3DS-U\V
M-"<I"B`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=S=6)T<F%C=%]W
M:71H7V-A<G)Y7V5N9VEN92<L("=R86YL=7@R-%]B87-E)RD*("`@(&%D9%]O
M;F5?='EP95]P<FEN=&5R*&]B:BP@)W-U8G1R86-T7W=I=&A?8V%R<GE?96YG
M:6YE)RP@)W)A;FQU>#0X7V)A<V4G*0H@("`@861D7V]N95]T>7!E7W!R:6YT
M97(H;V)J+"`G9&ES8V%R9%]B;&]C:U]E;F=I;F4G+"`G<F%N;'5X,C0G*0H@
M("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G9&ES8V%R9%]B;&]C:U]E
M;F=I;F4G+"`G<F%N;'5X-#@G*0H@("`@861D7V]N95]T>7!E7W!R:6YT97(H
M;V)J+"`G<VAU9F9L95]O<F1E<E]E;F=I;F4G+"`G:VYU=&A?8B<I"@H@("`@
M(R!!9&0@='EP92!P<FEN=&5R<R!F;W(@97AP97)I;65N=&%L.CIB87-I8U]S
M=')I;F=?=FEE=R!T>7!E9&5F<RX*("`@(&YS(#T@)V5X<&5R:6UE;G1A;#HZ
M9G5N9&%M96YT86QS7W8Q.CHG"B`@("!F;W(@8V@@:6X@*"<G+"`G=R<L("=U
M."<L("=U,38G+"`G=3,R)RDZ"B`@("`@("`@861D7V]N95]T>7!E7W!R:6YT
M97(H;V)J+"!N<R`K("=B87-I8U]S=')I;F=?=FEE=R<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@;G,@*R!C:"`K("=S=')I;F=?=FEE=R<I"@H@
M("`@(R!$;R!N;W0@<VAO=R!D969A=6QT960@=&5M<&QA=&4@87)G=6UE;G1S
M(&EN(&-L87-S('1E;7!L871E<RX*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP
M95]P<FEN=&5R*&]B:BP@)W5N:7%U95]P='(G+`H@("`@("`@("`@("![(#$Z
M("=S=&0Z.F1E9F%U;'1?9&5L971E/'LP?3XG('TI"B`@("!A9&1?;VYE7W1E
M;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=D97%U92<L('L@,3H@)W-T9#HZ
M86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P
M<FEN=&5R*&]B:BP@)V9O<G=A<F1?;&ES="<L('L@,3H@)W-T9#HZ86QL;V-A
M=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R
M*&]B:BP@)VQI<W0G+"![(#$Z("=S=&0Z.F%L;&]C871O<CQ[,'T^)WTI"B`@
M("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=?7V-X>#$Q
M.CIL:7-T)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@861D
M7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=F5C=&]R)RP@>R`Q
M.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@861D7V]N95]T96UP;&%T
M95]T>7!E7W!R:6YT97(H;V)J+"`G;6%P)RP*("`@("`@("`@("`@>R`R.B`G
M<W1D.CIL97-S/'LP?3XG+`H@("`@("`@("`@("`@(#,Z("=S=&0Z.F%L;&]C
M871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^/B<@?2D*("`@(&%D9%]O
M;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)VUU;'1I;6%P)RP*("`@
M("`@("`@("`@>R`R.B`G<W1D.CIL97-S/'LP?3XG+`H@("`@("`@("`@("`@
M(#,Z("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^
M/B<@?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@
M)W-E="<L"B`@("`@("`@("`@('L@,3H@)W-T9#HZ;&5S<SQ[,'T^)RP@,CH@
M)W-T9#HZ86QL;V-A=&]R/'LP?3XG('TI"B`@("!A9&1?;VYE7W1E;7!L871E
M7W1Y<&5?<')I;G1E<BAO8FHL("=M=6QT:7-E="<L"B`@("`@("`@("`@('L@
M,3H@)W-T9#HZ;&5S<SQ[,'T^)RP@,CH@)W-T9#HZ86QL;V-A=&]R/'LP?3XG
M('TI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=U
M;F]R9&5R961?;6%P)RP*("`@("`@("`@("`@>R`R.B`G<W1D.CIH87-H/'LP
M?3XG+`H@("`@("`@("`@("`@(#,Z("=S=&0Z.F5Q=6%L7W1O/'LP?3XG+`H@
M("`@("`@("`@("`@(#0Z("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!]
M(&-O;G-T+"![,7T^/B=]*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R
M:6YT97(H;V)J+"`G=6YO<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@("`@
M>R`R.B`G<W1D.CIH87-H/'LP?3XG+`H@("`@("`@("`@("`@(#,Z("=S=&0Z
M.F5Q=6%L7W1O/'LP?3XG+`H@("`@("`@("`@("`@(#0Z("=S=&0Z.F%L;&]C
M871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^/B=]*0H@("`@861D7V]N
M95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO<F1E<F5D7W-E="<L
M"B`@("`@("`@("`@('L@,3H@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@("`@("`@
M("`@("`R.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@("`@("`@("`@("`S
M.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@861D7V]N95]T96UP;&%T
M95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO<F1E<F5D7VUU;'1I<V5T)RP*("`@
M("`@("`@("`@>R`Q.B`G<W1D.CIH87-H/'LP?3XG+`H@("`@("`@("`@("`@
M(#(Z("=S=&0Z.F5Q=6%L7W1O/'LP?3XG+`H@("`@("`@("`@("`@(#,Z("=S
M=&0Z.F%L;&]C871O<CQ[,'T^)WTI"@ID968@<F5G:7-T97)?;&EB<W1D8WAX
M7W!R:6YT97)S("AO8FHI.@H@("`@(E)E9VES=&5R(&QI8G-T9&,K*R!P<F5T
M='DM<')I;G1E<G,@=VET:"!O8FIF:6QE($]B:BXB"@H@("`@9VQO8F%L(%]U
M<V5?9V1B7W!P"B`@("!G;&]B86P@;&EB<W1D8WAX7W!R:6YT97(*"B`@("!I
M9B!?=7-E7V=D8E]P<#H*("`@("`@("!G9&(N<')I;G1I;F<N<F5G:7-T97)?
M<')E='1Y7W!R:6YT97(H;V)J+"!L:6)S=&1C>'A?<')I;G1E<BD*("`@(&5L
M<V4Z"B`@("`@("`@:68@;V)J(&ES($YO;F4Z"B`@("`@("`@("`@(&]B:B`]
M(&=D8@H@("`@("`@(&]B:BYP<F5T='E?<')I;G1E<G,N87!P96YD*&QI8G-T
M9&-X>%]P<FEN=&5R*0H*("`@(')E9VES=&5R7W1Y<&5?<')I;G1E<G,H;V)J
M*0H*9&5F(&)U:6QD7VQI8G-T9&-X>%]D:6-T:6]N87)Y("@I.@H@("`@9VQO
M8F%L(&QI8G-T9&-X>%]P<FEN=&5R"@H@("`@;&EB<W1D8WAX7W!R:6YT97(@
M/2!0<FEN=&5R*")L:6)S=&1C*RLM=C8B*0H*("`@(",@;&EB<W1D8RLK(&]B
M:F5C=',@<F5Q=6ER:6YG('!R971T>2UP<FEN=&EN9RX*("`@(",@26X@;W)D
M97(@9G)O;3H*("`@(",@:'1T<#HO+V=C8RYG;G4N;W)G+V]N;&EN961O8W,O
M;&EB<W1D8RLK+VQA=&5S="UD;WAY9V5N+V$P,3@T-RYH=&UL"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G8F%S:6-?<W1R
M:6YG)RP@4W1D4W1R:6YG4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R
M+F%D9%]V97)S:6]N*"=S=&0Z.E]?8WAX,3$Z.B<L("=B87-I8U]S=')I;F<G
M+"!3=&13=')I;F=0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7V-O;G1A:6YE<B@G<W1D.CHG+"`G8FET<V5T)RP@4W1D0FET<V5T4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ
M)RP@)V1E<75E)RP@4W1D1&5Q=650<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R
M:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G;&ES="<L(%-T9$QI<W10
M<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G
M<W1D.CI?7V-X>#$Q.CHG+"`G;&ES="<L(%-T9$QI<W10<FEN=&5R*0H@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G;6%P
M)RP@4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C
M;VYT86EN97(H)W-T9#HZ)RP@)VUU;'1I;6%P)RP@4W1D36%P4')I;G1E<BD*
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@
M)VUU;'1I<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=P86ER)RP@4W1D4&%I<E!R:6YT
M97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG
M+"`G<')I;W)I='E?<75E=64G+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=Q=65U92<L(%-T9%-T
M86-K3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?
M=F5R<VEO;B@G<W1D.CHG+"`G='5P;&4G+"!3=&14=7!L95!R:6YT97(I"B`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=S
M970G+"!3=&139710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7W9E<G-I;VXH)W-T9#HZ)RP@)W-T86-K)RP@4W1D4W1A8VM/<E%U975E4')I
M;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z
M.B<L("=U;FEQ=65?<'1R)RP@56YI<75E4&]I;G1E<E!R:6YT97(I"B`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=V96-T
M;W(G+"!3=&1696-T;W)0<FEN=&5R*0H@("`@(R!V96-T;W(\8F]O;#X*"B`@
M("`C(%!R:6YT97(@<F5G:7-T<F%T:6]N<R!F;W(@8VQA<W-E<R!C;VUP:6QE
M9"!W:71H("U$7T=,24)#6%A?1$5"54<N"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&0H)W-T9#HZ7U]D96)U9SHZ8FET<V5T)RP@4W1D0FET<V5T4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CID
M97%U92<L(%-T9$1E<75E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R
M+F%D9"@G<W1D.CI?7V1E8G5G.CIL:7-T)RP@4W1D3&ES=%!R:6YT97(I"B`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ;6%P)RP@
M4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D
M.CI?7V1E8G5G.CIM=6QT:6UA<"<L(%-T9$UA<%!R:6YT97(I"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ;75L=&ES970G+"!3
M=&139710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z
M.E]?9&5B=6<Z.G!R:6]R:71Y7W%U975E)RP*("`@("`@("`@("`@("`@("`@
M("`@("`@("!3=&13=&%C:T]R475E=650<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G%U975E)RP@4W1D4W1A8VM/
M<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D
M.CI?7V1E8G5G.CIS970G+"!3=&139710<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G-T86-K)RP@4W1D4W1A8VM/
M<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D
M.CI?7V1E8G5G.CIU;FEQ=65?<'1R)RP@56YI<75E4&]I;G1E<E!R:6YT97(I
M"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ=F5C
M=&]R)RP@4W1D5F5C=&]R4')I;G1E<BD*"B`@("`C(%1H97-E(&%R92!T:&4@
M5%(Q(&%N9"!#*RLQ,2!P<FEN=&5R<RX*("`@(",@1F]R(&%R<F%Y("T@=&AE
M(&1E9F%U;'0@1T1"('!R971T>2UP<FEN=&5R('-E96US(')E87-O;F%B;&4N
M"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G
M<VAA<F5D7W!T<B<L(%-H87)E9%!O:6YT97)0<FEN=&5R*0H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)W=E86M?<'1R)RP@
M4VAA<F5D4&]I;G1E<E!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA
M9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=U;F]R9&5R961?;6%P)RP*("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P
M4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H
M)W-T9#HZ)RP@)W5N;W)D97)E9%]S970G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R96139710<FEN=&5R*0H@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G=6YO
M<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)W5N;W)D97)E9%]M
M=6QT:7-E="<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M(%1R,55N;W)D97)E9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=F;W)W87)D7VQI<W0G+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1&;W)W87)D3&ES
M=%!R:6YT97(I"@H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ='(Q.CHG+"`G<VAA<F5D7W!T<B<L(%-H87)E9%!O:6YT97)0<FEN
M=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ
M='(Q.CHG+"`G=V5A:U]P='(G+"!3:&%R9610;VEN=&5R4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@
M)W5N;W)D97)E9%]M87`G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]S
M970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO
M<F1E<F5D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V
M97)S:6]N*"=S=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]M=6QT:6UA<"<L"B`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R961-
M87!0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ='(Q.CHG+"`G=6YO<F1E<F5D7VUU;'1I<V5T)RP*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9%-E=%!R:6YT
M97(I"@H@("`@(R!4:&5S92!A<F4@=&AE($,K*S$Q('!R:6YT97(@<F5G:7-T
M<F%T:6]N<R!F;W(@+41?1TQ)0D-86%]$14)51R!C87-E<RX*("`@(",@5&AE
M('1R,2!N86UE<W!A8V4@8V]N=&%I;F5R<R!D;R!N;W0@:&%V92!A;GD@9&5B
M=6<@97%U:79A;&5N=',L"B`@("`C('-O(&1O(&YO="!R96=I<W1E<B!P<FEN
M=&5R<R!F;W(@=&AE;2X*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D
M.CI?7V1E8G5G.CIU;F]R9&5R961?;6%P)RP*("`@("`@("`@("`@("`@("`@
M("`@("`@("!4<C%5;F]R9&5R961-87!0<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N;W)D97)E9%]S970G+`H@
M("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9%-E=%!R:6YT
M97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ
M=6YO<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@("`@("`@("`@("`@("`@
M("!4<C%5;F]R9&5R961-87!0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N;W)D97)E9%]M=6QT:7-E="<L"B`@
M("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D4V5T4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIF
M;W)W87)D7VQI<W0G+`H@("`@("`@("`@("`@("`@("`@("`@("`@(%-T9$9O
M<G=A<F1,:7-T4')I;G1E<BD*"B`@("`C($QI8G)A<GD@1G5N9&%M96YT86QS
M(%13(&-O;7!O;F5N=',*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S
M:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ9G5N9&%M96YT86QS7W8Q.CHG+`H@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@)V%N>2<L(%-T9$5X
M<$%N>5!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO
M;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V,3HZ)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=O<'1I;VYA;"<L(%-T
M9$5X<$]P=&EO;F%L4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ9G5N9&%M96YT86QS7W8Q
M.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@)V)A<VEC
M7W-T<FEN9U]V:65W)RP@4W1D17AP4W1R:6YG5FEE=U!R:6YT97(I"B`@("`C
M($9I;&5S>7-T96T@5%,@8V]M<&]N96YT<PH@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D7W9E<G-I;VXH)W-T9#HZ97AP97)I;65N=&%L.CIF:6QE<WES=&5M
M.CIV,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=P
M871H)RP@4W1D17AP4&%T:%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9I;&5S>7-T96TZ
M.G8Q.CI?7V-X>#$Q.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@)W!A=&@G+"!3=&1%>'!0871H4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F9I;&5S>7-T96TZ.B<L"B`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G<&%T:"<L(%-T9%!A
M=&A0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ9FEL97-Y<W1E;3HZ7U]C>'@Q,3HZ)RP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("=P871H)RP@4W1D4&%T:%!R:6YT97(I"@H@
M("`@(R!#*RLQ-R!C;VUP;VYE;G1S"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA
M9&1?=F5R<VEO;B@G<W1D.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@)V%N>2<L(%-T9$5X<$%N>5!R:6YT97(I"B`@("!L:6)S=&1C
M>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@)V]P=&EO;F%L)RP@4W1D17AP3W!T:6]N
M86Q0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=B
M87-I8U]S=')I;F=?=FEE=R<L(%-T9$5X<%-T<FEN9U9I97=0<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=V87)I86YT)RP@4W1D
M5F%R:6%N=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R
M<VEO;B@G<W1D.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@)U].;V1E7VAA;F1L92<L(%-T9$YO9&5(86YD;&50<FEN=&5R*0H*("`@
M(",@0RLK,C`@8V]M<&]N96YT<PH@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7W9E<G-I;VXH)W-T9#HZ)RP@)W!A<G1I86Q?;W)D97)I;F<G+"!3=&1#;7!#
M8710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ)RP@)W=E86M?;W)D97)I;F<G+"!3=&1#;7!#8710<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)W-T
M<F]N9U]O<F1E<FEN9R<L(%-T9$-M<$-A=%!R:6YT97(I"@H@("`@(R!%>'1E
M;G-I;VYS+@H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)U]?
M9VYU7V-X>#HZ)RP@)W-L:7-T)RP@4W1D4VQI<W10<FEN=&5R*0H*("`@(&EF
M(%1R=64Z"B`@("`@("`@(R!4:&5S92!S:&]U;&1N)W0@8F4@;F5C97-S87)Y
M+"!I9B!'1$(@(G!R:6YT("II(B!W;W)K960N"B`@("`@("`@(R!"=70@:70@
M;V9T96X@9&]E<VXG="P@<V\@:&5R92!T:&5Y(&%R92X*("`@("`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=?3&ES=%]I
M=&5R871O<B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("!3=&1,:7-T271E<F%T;W)0<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)U],:7-T7V-O;G-T
M7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@(%-T9$QI<W1)=&5R871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)U]28E]T<F5E7VET
M97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!3=&128G1R965)=&5R871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)U]28E]T<F5E7V-O;G-T
M7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("!3=&128G1R965)=&5R871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G7T1E<75E7VET
M97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@(%-T9$1E<75E271E<F%T;W)0<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)U]$97%U95]C;VYS
M=%]I=&5R871O<B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("!3=&1$97%U94ET97)A=&]R4')I;G1E<BD*("`@("`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G7U]G;G5?8WAX.CHG+"`G7U]N
M;W)M86Q?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@(%-T9%9E8W1O<DET97)A=&]R4')I;G1E<BD*("`@("`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G7U]G;G5?8WAX.CHG+"`G
M7U-L:7-T7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("!3=&13;&ES=$ET97)A=&]R4')I;G1E<BD*("`@("`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=?1G=D
M7VQI<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@4W1D1G=D3&ES=$ET97)A=&]R4')I;G1E<BD*("`@("`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=?
M1G=D7VQI<W1?8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@4W1D1G=D3&ES=$ET97)A=&]R4')I;G1E
M<BD*"B`@("`@("`@(R!$96)U9R`H8V]M<&EL960@=VET:"`M1%]'3$E"0UA8
M7T1%0E5'*2!P<FEN=&5R"B`@("`@("`@(R!R96=I<W1R871I;VYS+@H@("`@
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G7U]G;G5?9&5B=6<Z.E]3869E
M7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D
M1&5B=6=)=&5R871O<E!R:6YT97(I"@IB=6EL9%]L:6)S=&1C>'A?9&EC=&EO
M;F%R>2`H*0H`````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````+B]P>71H;VXO;&EB<W1D8WAX+W8V+WAM971H;V1S+G!Y````
M````````````````````````````````````````````````````````````
M`````````````````````````#`P,#`V-C0`,#`P,3<U,``P,#`Q-S4P`#`P
M,#`P,#8W,#`V`#$S-S$S-#4R-C8S`#`Q-S$U-0`@,```````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````````````````!U<W1A
M<B`@`&9J87)D;VX`````````````````````````````````9FIA<F1O;@``
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````C(%AM971H;V1S(&9O<B!L:6)S
M=&1C*RLN"@HC($-O<'ER:6=H="`H0RD@,C`Q-"TR,#(P($9R964@4V]F='=A
M<F4@1F]U;F1A=&EO;BP@26YC+@H*(R!4:&ES('!R;V=R86T@:7,@9G)E92!S
M;V9T=V%R93L@>6]U(&-A;B!R961I<W1R:6)U=&4@:70@86YD+V]R(&UO9&EF
M>0HC(&ET('5N9&5R('1H92!T97)M<R!O9B!T:&4@1TY5($=E;F5R86P@4'5B
M;&EC($QI8V5N<V4@87,@<'5B;&ES:&5D(&)Y"B,@=&AE($9R964@4V]F='=A
M<F4@1F]U;F1A=&EO;CL@96ET:&5R('9E<G-I;VX@,R!O9B!T:&4@3&EC96YS
M92P@;W(*(R`H870@>6]U<B!O<'1I;VXI(&%N>2!L871E<B!V97)S:6]N+@HC
M"B,@5&AI<R!P<F]G<F%M(&ES(&1I<W1R:6)U=&5D(&EN('1H92!H;W!E('1H
M870@:70@=VEL;"!B92!U<V5F=6PL"B,@8G5T(%=)5$A/550@04Y9(%=!4E)!
M3E19.R!W:71H;W5T(&5V96X@=&AE(&EM<&QI960@=V%R<F%N='D@;V8*(R!-
M15)#2$%.5$%"24Q)5%D@;W(@1DE43D534R!&3U(@02!005)424-53$%2(%!5
M4E!/4T4N("!3964@=&AE"B,@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@
M9F]R(&UO<F4@9&5T86EL<RX*(PHC(%EO=2!S:&]U;&0@:&%V92!R96-E:79E
M9"!A(&-O<'D@;V8@=&AE($=.52!'96YE<F%L(%!U8FQI8R!,:6-E;G-E"B,@
M86QO;F<@=VET:"!T:&ES('!R;V=R86TN("!)9B!N;W0L('-E92`\:'1T<#HO
M+W=W=RYG;G4N;W)G+VQI8V5N<V5S+SXN"@II;7!O<G0@9V1B"FEM<&]R="!G
M9&(N>&UE=&AO9`II;7!O<G0@<F4*"FUA=&-H97)?;F%M95]P<F5F:7@@/2`G
M;&EB<W1D8RLK.CHG"@ID968@9V5T7V)O;VQ?='EP92@I.@H@("`@<F5T=7)N
M(&=D8BYL;V]K=7!?='EP92@G8F]O;"<I"@ID968@9V5T7W-T9%]S:7IE7W1Y
M<&4H*3H*("`@(')E='5R;B!G9&(N;&]O:W5P7W1Y<&4H)W-T9#HZ<VEZ95]T
M)RD*"F-L87-S($QI8E-T9$-X>%A-971H;V0H9V1B+GAM971H;V0N6$UE=&AO
M9"DZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@=V]R:V5R7V-L87-S
M*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D+E]?:6YI=%]?*'-E;&8L
M(&YA;64I"B`@("`@("`@<V5L9BYW;W)K97)?8VQA<W,@/2!W;W)K97)?8VQA
M<W,*"B,@6&UE=&AO9',@9F]R('-T9#HZ87)R87D*"F-L87-S($%R<F%Y5V]R
M:V5R0F%S92AG9&(N>&UE=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92DZ"B`@("`@("`@<V5L9BY?
M=F%L7W1Y<&4@/2!V86Q?='EP90H@("`@("`@('-E;&8N7W-I>F4@/2!S:7IE
M"@H@("`@9&5F(&YU;&Q?=F%L=64H<V5L9BDZ"B`@("`@("`@;G5L;'!T<B`]
M(&=D8BYP87)S95]A;F1?979A;"@G*'9O:60@*BD@,"<I"B`@("`@("`@<F5T
M=7)N(&YU;&QP='(N8V%S="AS96QF+E]V86Q?='EP92YP;VEN=&5R*"DI+F1E
M<F5F97)E;F-E*"D*"F-L87-S($%R<F%Y4VEZ95=O<FME<BA!<G)A>5=O<FME
M<D)A<V4I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE
M*3H*("`@("`@("!!<G)A>5=O<FME<D)A<V4N7U]I;FET7U\H<V5L9BP@=F%L
M7W1Y<&4L('-I>F4I"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E
M;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*
M"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M<V5L9BY?<VEZ90H*8VQA<W,@07)R87E%;7!T>5=O<FME<BA!<G)A>5=O<FME
M<D)A<V4I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE
M*3H*("`@("`@("!!<G)A>5=O<FME<D)A<V4N7U]I;FET7U\H<V5L9BP@=F%L
M7W1Y<&4L('-I>F4I"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E
M;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]B;V]L7W1Y<&4H*0H*("`@
M(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B`H:6YT
M*'-E;&8N7W-I>F4I(#T](#`I"@IC;&%S<R!!<G)A>49R;VYT5V]R:V5R*$%R
M<F%Y5V]R:V5R0F%S92DZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y
M<&4L('-I>F4I.@H@("`@("`@($%R<F%Y5V]R:V5R0F%S92Y?7VEN:71?7RAS
M96QF+"!V86Q?='EP92P@<VEZ92D*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS
M96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT
M7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y
M<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!I9B!I
M;G0H<V5L9BY?<VEZ92D@/B`P.@H@("`@("`@("`@("!R971U<FX@;V)J6R=?
M35]E;&5M<R==6S!="B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N
M('-E;&8N;G5L;%]V86QU92@I"@IC;&%S<R!!<G)A>4)A8VM7;W)K97(H07)R
M87E7;W)K97)"87-E*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?='EP
M92P@<VEZ92DZ"B`@("`@("`@07)R87E7;W)K97)"87-E+E]?:6YI=%]?*'-E
M;&8L('9A;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E
M;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?
M='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP
M90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(&EF(&EN
M="AS96QF+E]S:7IE*2`^(#`Z"B`@("`@("`@("`@(')E='5R;B!O8FI;)U]-
M7V5L96US)UU;<V5L9BY?<VEZ92`M(#%="B`@("`@("`@96QS93H*("`@("`@
M("`@("`@<F5T=7)N('-E;&8N;G5L;%]V86QU92@I"@IC;&%S<R!!<G)A>4%T
M5V]R:V5R*$%R<F%Y5V]R:V5R0F%S92DZ"B`@("!D968@7U]I;FET7U\H<V5L
M9BP@=F%L7W1Y<&4L('-I>F4I.@H@("`@("`@($%R<F%Y5V]R:V5R0F%S92Y?
M7VEN:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92D*"B`@("!D968@9V5T7V%R
M9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y
M<&4H*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!I;F1E
M>"DZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?
M8V%L;%]?*'-E;&8L(&]B:BP@:6YD97@I.@H@("`@("`@(&EF(&EN="AI;F1E
M>"D@/CT@:6YT*'-E;&8N7W-I>F4I.@H@("`@("`@("`@("!R86ES92!);F1E
M>$5R<F]R*"=!<G)A>2!I;F1E>"`B)60B('-H;W5L9"!N;W0@8F4@/CT@)60N
M)R`E"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@*"AI;G0H:6YD97@I
M+"!S96QF+E]S:7IE*2DI"B`@("`@("`@<F5T=7)N(&]B:ELG7TU?96QE;7,G
M75MI;F1E>%T*"F-L87-S($%R<F%Y4W5B<V-R:7!T5V]R:V5R*$%R<F%Y5V]R
M:V5R0F%S92DZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I
M>F4I.@H@("`@("`@($%R<F%Y5V]R:V5R0F%S92Y?7VEN:71?7RAS96QF+"!V
M86Q?='EP92P@<VEZ92D*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*
M("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!G
M971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@<F5T
M=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B
M:BP@:6YD97@I.@H@("`@("`@(&EF(&EN="AS96QF+E]S:7IE*2`^(#`Z"B`@
M("`@("`@("`@(')E='5R;B!O8FI;)U]-7V5L96US)UU;:6YD97A="B`@("`@
M("`@96QS93H*("`@("`@("`@("`@<F5T=7)N('-E;&8N;G5L;%]V86QU92@I
M"@IC;&%S<R!!<G)A>4UE=&AO9'--871C:&5R*&=D8BYX;65T:&]D+EA-971H
M;V1-871C:&5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF*3H*("`@("`@("!G
M9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BY?7VEN:71?7RAS96QF+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(&UA=&-H
M97)?;F%M95]P<F5F:7@@*R`G87)R87DG*0H@("`@("`@('-E;&8N7VUE=&AO
M9%]D:6-T(#T@>PH@("`@("`@("`@("`G<VEZ92<Z($QI8E-T9$-X>%A-971H
M;V0H)W-I>F4G+"!!<G)A>5-I>F57;W)K97(I+`H@("`@("`@("`@("`G96UP
M='DG.B!,:6)3=&1#>'A8365T:&]D*"=E;7!T>2<L($%R<F%Y16UP='E7;W)K
M97(I+`H@("`@("`@("`@("`G9G)O;G0G.B!,:6)3=&1#>'A8365T:&]D*"=F
M<F]N="<L($%R<F%Y1G)O;G17;W)K97(I+`H@("`@("`@("`@("`G8F%C:R<Z
M($QI8E-T9$-X>%A-971H;V0H)V)A8VLG+"!!<G)A>4)A8VM7;W)K97(I+`H@
M("`@("`@("`@("`G870G.B!,:6)3=&1#>'A8365T:&]D*"=A="<L($%R<F%Y
M0717;W)K97(I+`H@("`@("`@("`@("`G;W!E<F%T;W);72<Z($QI8E-T9$-X
M>%A-971H;V0H)V]P97)A=&]R6UTG+"!!<G)A>5-U8G-C<FEP=%=O<FME<BDL
M"B`@("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H
M;V1?9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D
M968@;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@
M("`@(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K.CHI/V%R<F%Y/"XJ
M/B0G+"!C;&%S<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E='5R;B!.;VYE
M"B`@("`@("`@;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N9V5T*&UE=&AO
M9%]N86UE*0H@("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R(&YO="!M971H
M;V0N96YA8FQE9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!T
M<GDZ"B`@("`@("`@("`@('9A;'5E7W1Y<&4@/2!C;&%S<U]T>7!E+G1E;7!L
M871E7V%R9W5M96YT*#`I"B`@("`@("`@("`@('-I>F4@/2!C;&%S<U]T>7!E
M+G1E;7!L871E7V%R9W5M96YT*#$I"B`@("`@("`@97AC97!T.@H@("`@("`@
M("`@("!R971U<FX@3F]N90H@("`@("`@(')E='5R;B!M971H;V0N=V]R:V5R
M7V-L87-S*'9A;'5E7W1Y<&4L('-I>F4I"@HC(%AM971H;V1S(&9O<B!S=&0Z
M.F1E<75E"@IC;&%S<R!$97%U95=O<FME<D)A<V4H9V1B+GAM971H;V0N6$UE
M=&AO9%=O<FME<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4I
M.@H@("`@("`@('-E;&8N7W9A;%]T>7!E(#T@=F%L7W1Y<&4*("`@("`@("!S
M96QF+E]B=69S:7IE(#T@-3$R("\O('9A;%]T>7!E+G-I>F5O9B!O<B`Q"@H@
M("`@9&5F('-I>F4H<V5L9BP@;V)J*3H*("`@("`@("!F:7)S=%]N;V1E(#T@
M;V)J6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;)U]-7VYO9&4G70H@("`@("`@
M(&QA<W1?;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G75LG7TU?
M;F]D92=="B`@("`@("`@8W5R(#T@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES
M:"==6R=?35]C=7(G70H@("`@("`@(&9I<G-T(#T@;V)J6R=?35]I;7!L)UU;
M)U]-7V9I;FES:"==6R=?35]F:7)S="=="B`@("`@("`@<F5T=7)N("AL87-T
M7VYO9&4@+2!F:7)S=%]N;V1E*2`J('-E;&8N7V)U9G-I>F4@*R`H8W5R("T@
M9FER<W0I"@H@("`@9&5F(&EN9&5X*'-E;&8L(&]B:BP@:61X*3H*("`@("`@
M("!F:7)S=%]N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;)U]-
M7VYO9&4G70H@("`@("`@(&EN9&5X7VYO9&4@/2!F:7)S=%]N;V1E("L@:6YT
M*&ED>"D@+R\@<V5L9BY?8G5F<VEZ90H@("`@("`@(')E='5R;B!I;F1E>%]N
M;V1E6S!=6VED>"`E('-E;&8N7V)U9G-I>F5="@IC;&%S<R!$97%U945M<'1Y
M5V]R:V5R*$1E<75E5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E
M<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S
M=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7V)O;VQ?
M='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@
M<F5T=7)N("AO8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?8W5R)UT@
M/3T*("`@("`@("`@("`@("`@(&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G
M75LG7TU?8W5R)UTI"@IC;&%S<R!$97%U95-I>F57;W)K97(H1&5Q=657;W)K
M97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@
M(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O
M8FHI.@H@("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@
M9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N
M<VEZ92AO8FHI"@IC;&%S<R!$97%U949R;VYT5V]R:V5R*$1E<75E5V]R:V5R
M0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R
M971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J
M*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C
M86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@;V)J6R=?35]I;7!L
M)UU;)U]-7W-T87)T)UU;)U]-7V-U<B==6S!="@IC;&%S<R!$97%U94)A8VM7
M;W)K97(H1&5Q=657;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U
M;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?
M='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(&EF
M("AO8FI;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7V-U<B==(#T]"B`@
M("`@("`@("`@(&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G75LG7TU?9FER
M<W0G72DZ"B`@("`@("`@("`@('!R979?;F]D92`](&]B:ELG7TU?:6UP;"==
M6R=?35]F:6YI<V@G75LG7TU?;F]D92==("T@,0H@("`@("`@("`@("!R971U
M<FX@<')E=E]N;V1E6S!=6W-E;&8N7V)U9G-I>F4@+2`Q70H@("`@("`@(&5L
M<V4Z"B`@("`@("`@("`@(')E='5R;B!O8FI;)U]-7VEM<&PG75LG7TU?9FEN
M:7-H)UU;)U]-7V-U<B==6RTQ70H*8VQA<W,@1&5Q=653=6)S8W)I<'17;W)K
M97(H1&5Q=657;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E
M;&8I.@H@("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@
M9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHL('-U8G-C<FEP="DZ"B`@
M("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?
M*'-E;&8L(&]B:BP@<W5B<V-R:7!T*3H*("`@("`@("!R971U<FX@<V5L9BYI
M;F1E>"AO8FHL('-U8G-C<FEP="D*"F-L87-S($1E<75E0717;W)K97(H1&5Q
M=657;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@
M("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U
M<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J
M+"!I;F1E>"DZ"B`@("`@("`@9&5Q=65?<VEZ92`](&EN="AS96QF+G-I>F4H
M;V)J*2D*("`@("`@("!I9B!I;G0H:6YD97@I(#X](&1E<75E7W-I>F4Z"B`@
M("`@("`@("`@(')A:7-E($EN9&5X17)R;W(H)T1E<75E(&EN9&5X("(E9"(@
M<VAO=6QD(&YO="!B92`^/2`E9"XG("4*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`H:6YT*&EN9&5X*2P@9&5Q=65?<VEZ92DI"B`@("`@("`@96QS
M93H*("`@("`@("`@("!R971U<FX@<V5L9BYI;F1E>"AO8FHL(&EN9&5X*0H*
M8VQA<W,@1&5Q=65-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D
M36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@("`@("`@9V1B
M+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L9BP*("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!M871C:&5R
M7VYA;65?<')E9FEX("L@)V1E<75E)RD*("`@("`@("!S96QF+E]M971H;V1?
M9&EC="`]('L*("`@("`@("`@("`@)V5M<'1Y)SH@3&EB4W1D0WAX6$UE=&AO
M9"@G96UP='DG+"!$97%U945M<'1Y5V]R:V5R*2P*("`@("`@("`@("`@)W-I
M>F4G.B!,:6)3=&1#>'A8365T:&]D*"=S:7IE)RP@1&5Q=653:7IE5V]R:V5R
M*2P*("`@("`@("`@("`@)V9R;VYT)SH@3&EB4W1D0WAX6$UE=&AO9"@G9G)O
M;G0G+"!$97%U949R;VYT5V]R:V5R*2P*("`@("`@("`@("`@)V)A8VLG.B!,
M:6)3=&1#>'A8365T:&]D*"=B86-K)RP@1&5Q=65"86-K5V]R:V5R*2P*("`@
M("`@("`@("`@)V]P97)A=&]R6UTG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R
M871O<EM=)RP@1&5Q=653=6)S8W)I<'17;W)K97(I+`H@("`@("`@("`@("`G
M870G.B!,:6)3=&1#>'A8365T:&]D*"=A="<L($1E<75E0717;W)K97(I"B`@
M("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H;V1?
M9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D968@
M;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@("`@
M(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K.CHI/V1E<75E/"XJ/B0G
M+"!C;&%S<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@
M("`@("`@;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N9V5T*&UE=&AO9%]N
M86UE*0H@("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R(&YO="!M971H;V0N
M96YA8FQE9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!R971U
M<FX@;65T:&]D+G=O<FME<E]C;&%S<RAC;&%S<U]T>7!E+G1E;7!L871E7V%R
M9W5M96YT*#`I*0H*(R!8;65T:&]D<R!F;W(@<W1D.CIF;W)W87)D7VQI<W0*
M"F-L87-S($9O<G=A<F1,:7-T5V]R:V5R0F%S92AG9&(N>&UE=&AO9"Y8365T
M:&]D36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L
M(&YO9&5?='EP92DZ"B`@("`@("`@<V5L9BY?=F%L7W1Y<&4@/2!V86Q?='EP
M90H@("`@("`@('-E;&8N7VYO9&5?='EP92`](&YO9&5?='EP90H*("`@(&1E
M9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@IC
M;&%S<R!&;W)W87)D3&ES=$5M<'1Y5V]R:V5R*$9O<G=A<F1,:7-T5V]R:V5R
M0F%S92DZ"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@
M("`@("`@<F5T=7)N(&=E=%]B;V]L7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?
M7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!O8FI;)U]-7VEM<&PG75LG
M7TU?:&5A9"==6R=?35]N97AT)UT@/3T@,`H*8VQA<W,@1F]R=V%R9$QI<W1&
M<F]N=%=O<FME<BA&;W)W87)D3&ES=%=O<FME<D)A<V4I.@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF
M+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@(&YO9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?:&5A9"==6R=?35]N97AT
M)UTN8V%S="AS96QF+E]N;V1E7W1Y<&4I"B`@("`@("`@=F%L7V%D9')E<W,@
M/2!N;V1E6R=?35]S=&]R86=E)UU;)U]-7W-T;W)A9V4G72YA9&1R97-S"B`@
M("`@("`@<F5T=7)N('9A;%]A9&1R97-S+F-A<W0H<V5L9BY?=F%L7W1Y<&4N
M<&]I;G1E<B@I*2YD97)E9F5R96YC92@I"@IC;&%S<R!&;W)W87)D3&ES=$UE
M=&AO9'--871C:&5R*&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@
M(&1E9B!?7VEN:71?7RAS96QF*3H*("`@("`@("!M871C:&5R7VYA;64@/2!M
M871C:&5R7VYA;65?<')E9FEX("L@)V9O<G=A<F1?;&ES="<*("`@("`@("!G
M9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BY?7VEN:71?7RAS96QF+"!M871C
M:&5R7VYA;64I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@("`@
M("`@("`@("=E;7!T>2<Z($QI8E-T9$-X>%A-971H;V0H)V5M<'1Y)RP@1F]R
M=V%R9$QI<W1%;7!T>5=O<FME<BDL"B`@("`@("`@("`@("=F<F]N="<Z($QI
M8E-T9$-X>%A-971H;V0H)V9R;VYT)RP@1F]R=V%R9$QI<W1&<F]N=%=O<FME
M<BD*("`@("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE
M=&AO9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T70H*("`@
M(&1E9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@
M("`@("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_9F]R=V%R
M9%]L:7-T/"XJ/B0G+"!C;&%S<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E
M='5R;B!.;VYE"B`@("`@("`@;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N
M9V5T*&UE=&AO9%]N86UE*0H@("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R
M(&YO="!M971H;V0N96YA8FQE9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*
M("`@("`@("!V86Q?='EP92`](&-L87-S7W1Y<&4N=&5M<&QA=&5?87)G=6UE
M;G0H,"D*("`@("`@("!N;V1E7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H<W1R
M*&-L87-S7W1Y<&4I("L@)SHZ7TYO9&4G*2YP;VEN=&5R*"D*("`@("`@("!R
M971U<FX@;65T:&]D+G=O<FME<E]C;&%S<RAV86Q?='EP92P@;F]D95]T>7!E
M*0H*(R!8;65T:&]D<R!F;W(@<W1D.CIL:7-T"@IC;&%S<R!,:7-T5V]R:V5R
M0F%S92AG9&(N>&UE=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@(&1E9B!?7VEN
M:71?7RAS96QF+"!V86Q?='EP92P@;F]D95]T>7!E*3H*("`@("`@("!S96QF
M+E]V86Q?='EP92`]('9A;%]T>7!E"B`@("`@("`@<V5L9BY?;F]D95]T>7!E
M(#T@;F]D95]T>7!E"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W9A;'5E7V9R;VU?;F]D
M92AS96QF+"!N;V1E*3H*("`@("`@("!N;V1E(#T@;F]D92YD97)E9F5R96YC
M92@I"B`@("`@("`@:68@;F]D92YT>7!E+F9I96QD<R@I6S%=+FYA;64@/3T@
M)U]-7V1A=&$G.@H@("`@("`@("`@("`C($,K*S`S(&EM<&QE;65N=&%T:6]N
M+"!N;V1E(&-O;G1A:6YS('1H92!V86QU92!A<R!A(&UE;6)E<@H@("`@("`@
M("`@("!R971U<FX@;F]D95LG7TU?9&%T82=="B`@("`@("`@(R!#*RLQ,2!I
M;7!L96UE;G1A=&EO;BP@;F]D92!S=&]R97,@=F%L=64@:6X@7U]A;&EG;F5D
M7VUE;6)U9@H@("`@("`@(&%D9'(@/2!N;V1E6R=?35]S=&]R86=E)UTN861D
M<F5S<PH@("`@("`@(')E='5R;B!A9&1R+F-A<W0H<V5L9BY?=F%L7W1Y<&4N
M<&]I;G1E<B@I*2YD97)E9F5R96YC92@I"@IC;&%S<R!,:7-T16UP='E7;W)K
M97(H3&ES=%=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?8F]O;%]T>7!E*"D*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!B87-E7VYO9&4@
M/2!O8FI;)U]-7VEM<&PG75LG7TU?;F]D92=="B`@("`@("`@:68@8F%S95]N
M;V1E6R=?35]N97AT)UT@/3T@8F%S95]N;V1E+F%D9')E<W,Z"B`@("`@("`@
M("`@(')E='5R;B!4<G5E"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T
M=7)N($9A;'-E"@IC;&%S<R!,:7-T4VEZ95=O<FME<BA,:7-T5V]R:V5R0F%S
M92DZ"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@
M("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*"B`@("!D968@7U]C86QL
M7U\H<V5L9BP@;V)J*3H*("`@("`@("!B96=I;E]N;V1E(#T@;V)J6R=?35]I
M;7!L)UU;)U]-7VYO9&4G75LG7TU?;F5X="=="B`@("`@("`@96YD7VYO9&4@
M/2!O8FI;)U]-7VEM<&PG75LG7TU?;F]D92==+F%D9')E<W,*("`@("`@("!S
M:7IE(#T@,`H@("`@("`@('=H:6QE(&)E9VEN7VYO9&4@(3T@96YD7VYO9&4Z
M"B`@("`@("`@("`@(&)E9VEN7VYO9&4@/2!B96=I;E]N;V1E6R=?35]N97AT
M)UT*("`@("`@("`@("`@<VEZ92`K/2`Q"B`@("`@("`@<F5T=7)N('-I>F4*
M"F-L87-S($QI<W1&<F]N=%=O<FME<BA,:7-T5V]R:V5R0F%S92DZ"B`@("!D
M968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N
M('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ
M"B`@("`@("`@;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]N;V1E)UU;)U]-
M7VYE>'0G72YC87-T*'-E;&8N7VYO9&5?='EP92D*("`@("`@("!R971U<FX@
M<V5L9BYG971?=F%L=65?9G)O;5]N;V1E*&YO9&4I"@IC;&%S<R!,:7-T0F%C
M:U=O<FME<BA,:7-T5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7W)E<W5L=%]T
M>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E
M"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<')E=E]N
M;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7VYO9&4G75LG7TU?<')E=B==+F-A
M<W0H<V5L9BY?;F]D95]T>7!E*0H@("`@("`@(')E='5R;B!S96QF+F=E=%]V
M86QU95]F<F]M7VYO9&4H<')E=E]N;V1E*0H*8VQA<W,@3&ES=$UE=&AO9'--
M871C:&5R*&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E9B!?
M7VEN:71?7RAS96QF*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D36%T
M8VAE<BY?7VEN:71?7RAS96QF+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@(&UA=&-H97)?;F%M95]P<F5F:7@@*R`G;&ES
M="<I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@("`@("`@("`@
M("=E;7!T>2<Z($QI8E-T9$-X>%A-971H;V0H)V5M<'1Y)RP@3&ES=$5M<'1Y
M5V]R:V5R*2P*("`@("`@("`@("`@)W-I>F4G.B!,:6)3=&1#>'A8365T:&]D
M*"=S:7IE)RP@3&ES=%-I>F57;W)K97(I+`H@("`@("`@("`@("`G9G)O;G0G
M.B!,:6)3=&1#>'A8365T:&]D*"=F<F]N="<L($QI<W1&<F]N=%=O<FME<BDL
M"B`@("`@("`@("`@("=B86-K)SH@3&EB4W1D0WAX6$UE=&AO9"@G8F%C:R<L
M($QI<W1"86-K5V]R:V5R*0H@("`@("`@('T*("`@("`@("!S96QF+FUE=&AO
M9',@/2!;<V5L9BY?;65T:&]D7V1I8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T
M:&]D7V1I8W1="@H@("`@9&5F(&UA=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE
M=&AO9%]N86UE*3H*("`@("`@("!I9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?
M7UQD*SHZ*3\H7U]C>'@Q,3HZ*3]L:7-T/"XJ/B0G+"!C;&%S<U]T>7!E+G1A
M9RDZ"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@;65T:&]D(#T@
M<V5L9BY?;65T:&]D7V1I8W0N9V5T*&UE=&AO9%]N86UE*0H@("`@("`@(&EF
M(&UE=&AO9"!I<R!.;VYE(&]R(&YO="!M971H;V0N96YA8FQE9#H*("`@("`@
M("`@("`@<F5T=7)N($YO;F4*("`@("`@("!V86Q?='EP92`](&-L87-S7W1Y
M<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("!N;V1E7W1Y<&4@/2!G
M9&(N;&]O:W5P7W1Y<&4H<W1R*&-L87-S7W1Y<&4I("L@)SHZ7TYO9&4G*2YP
M;VEN=&5R*"D*("`@("`@("!R971U<FX@;65T:&]D+G=O<FME<E]C;&%S<RAV
M86Q?='EP92P@;F]D95]T>7!E*0H*(R!8;65T:&]D<R!F;W(@<W1D.CIV96-T
M;W(*"F-L87-S(%9E8W1O<E=O<FME<D)A<V4H9V1B+GAM971H;V0N6$UE=&AO
M9%=O<FME<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4I.@H@
M("`@("`@('-E;&8N7W9A;%]T>7!E(#T@=F%L7W1Y<&4*"B`@("!D968@<VEZ
M92AS96QF+"!O8FHI.@H@("`@("`@(&EF('-E;&8N7W9A;%]T>7!E+F-O9&4@
M/3T@9V1B+E194$5?0T]$15]"3T],.@H@("`@("`@("`@("!S=&%R="`](&]B
M:ELG7TU?:6UP;"==6R=?35]S=&%R="==6R=?35]P)UT*("`@("`@("`@("`@
M9FEN:7-H(#T@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]P)UT*
M("`@("`@("`@("`@9FEN:7-H7V]F9G-E="`](&]B:ELG7TU?:6UP;"==6R=?
M35]F:6YI<V@G75LG7TU?;V9F<V5T)UT*("`@("`@("`@("`@8FET7W-I>F4@
M/2!S=&%R="YD97)E9F5R96YC92@I+G1Y<&4N<VEZ96]F("H@.`H@("`@("`@
M("`@("!R971U<FX@*&9I;FES:"`M('-T87)T*2`J(&)I=%]S:7IE("L@9FEN
M:7-H7V]F9G-E=`H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')E='5R;B!O
M8FI;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UT@+2!O8FI;)U]-7VEM<&PG75LG
M7TU?<W1A<G0G70H*("`@(&1E9B!G970H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@
M("`@("`@:68@<V5L9BY?=F%L7W1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%
M7T)/3TPZ"B`@("`@("`@("`@('-T87)T(#T@;V)J6R=?35]I;7!L)UU;)U]-
M7W-T87)T)UU;)U]-7W`G70H@("`@("`@("`@("!B:71?<VEZ92`]('-T87)T
M+F1E<F5F97)E;F-E*"DN='EP92YS:7IE;V8@*B`X"B`@("`@("`@("`@('9A
M;'`@/2!S=&%R="`K(&EN9&5X("\O(&)I=%]S:7IE"B`@("`@("`@("`@(&]F
M9G-E="`](&EN9&5X("4@8FET7W-I>F4*("`@("`@("`@("`@<F5T=7)N("AV
M86QP+F1E<F5F97)E;F-E*"D@)B`H,2`\/"!O9F9S970I*2`^(#`*("`@("`@
M("!E;'-E.@H@("`@("`@("`@("!R971U<FX@;V)J6R=?35]I;7!L)UU;)U]-
M7W-T87)T)UU;:6YD97A="@IC;&%S<R!696-T;W)%;7!T>5=O<FME<BA696-T
M;W)7;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@
M("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?8F]O;%]T>7!E*"D*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@:6YT
M*'-E;&8N<VEZ92AO8FHI*2`]/2`P"@IC;&%S<R!696-T;W)3:7IE5V]R:V5R
M*%9E8W1O<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L
M9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T
M>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T
M>7!E*"D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R
M971U<FX@<V5L9BYS:7IE*&]B:BD*"F-L87-S(%9E8W1O<D9R;VYT5V]R:V5R
M*%9E8W1O<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L
M9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T
M>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E
M"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N
M('-E;&8N9V5T*&]B:BP@,"D*"F-L87-S(%9E8W1O<D)A8VM7;W)K97(H5F5C
M=&]R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*
M("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H
M<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L
M9BYG970H;V)J+"!I;G0H<V5L9BYS:7IE*&]B:BDI("T@,2D*"F-L87-S(%9E
M8W1O<D%T5V]R:V5R*%9E8W1O<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A
M<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T
M>7!E*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@:6YD
M97@I.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?
M7V-A;&Q?7RAS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!S:7IE(#T@:6YT
M*'-E;&8N<VEZ92AO8FHI*0H@("`@("`@(&EF(&EN="AI;F1E>"D@/CT@<VEZ
M93H*("`@("`@("`@("`@<F%I<V4@26YD97A%<G)O<B@G5F5C=&]R(&EN9&5X
M("(E9"(@<VAO=6QD(&YO="!B92`^/2`E9"XG("4*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`H*&EN="AI;F1E>"DL('-I>F4I*2D*("`@("`@("!R
M971U<FX@<V5L9BYG970H;V)J+"!I;G0H:6YD97@I*0H*8VQA<W,@5F5C=&]R
M4W5B<V-R:7!T5V]R:V5R*%9E8W1O<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E
M=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ
M95]T>7!E*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@
M<W5B<V-R:7!T*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!S=6)S8W)I<'0I.@H@("`@("`@
M(')E='5R;B!S96QF+F=E="AO8FHL(&EN="AS=6)S8W)I<'0I*0H*8VQA<W,@
M5F5C=&]R365T:&]D<TUA=&-H97(H9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H
M97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8I.@H@("`@("`@(&=D8BYX;65T
M:&]D+EA-971H;V1-871C:&5R+E]?:6YI=%]?*'-E;&8L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@;6%T8VAE<E]N86UE
M7W!R969I>"`K("=V96-T;W(G*0H@("`@("`@('-E;&8N7VUE=&AO9%]D:6-T
M(#T@>PH@("`@("`@("`@("`G<VEZ92<Z($QI8E-T9$-X>%A-971H;V0H)W-I
M>F4G+"!696-T;W)3:7IE5V]R:V5R*2P*("`@("`@("`@("`@)V5M<'1Y)SH@
M3&EB4W1D0WAX6$UE=&AO9"@G96UP='DG+"!696-T;W)%;7!T>5=O<FME<BDL
M"B`@("`@("`@("`@("=F<F]N="<Z($QI8E-T9$-X>%A-971H;V0H)V9R;VYT
M)RP@5F5C=&]R1G)O;G17;W)K97(I+`H@("`@("`@("`@("`G8F%C:R<Z($QI
M8E-T9$-X>%A-971H;V0H)V)A8VLG+"!696-T;W)"86-K5V]R:V5R*2P*("`@
M("`@("`@("`@)V%T)SH@3&EB4W1D0WAX6$UE=&AO9"@G870G+"!696-T;W)!
M=%=O<FME<BDL"B`@("`@("`@("`@("=O<&5R871O<EM=)SH@3&EB4W1D0WAX
M6$UE=&AO9"@G;W!E<F%T;W);72<L"B`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("!696-T;W)3=6)S8W)I<'17;W)K97(I+`H@
M("`@("`@('T*("`@("`@("!S96QF+FUE=&AO9',@/2!;<V5L9BY?;65T:&]D
M7V1I8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T:&]D7V1I8W1="@H@("`@9&5F
M(&UA=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE=&AO9%]N86UE*3H*("`@("`@
M("!I9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]V96-T;W(\+BH^
M)"<L(&-L87-S7W1Y<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*
M("`@("`@("!M971H;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T:&]D
M7VYA;64I"B`@("`@("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO
M9"YE;F%B;&5D.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@(')E
M='5R;B!M971H;V0N=V]R:V5R7V-L87-S*&-L87-S7W1Y<&4N=&5M<&QA=&5?
M87)G=6UE;G0H,"DI"@HC(%AM971H;V1S(&9O<B!A<W-O8VEA=&EV92!C;VYT
M86EN97)S"@IC;&%S<R!!<W-O8VEA=&EV94-O;G1A:6YE<E=O<FME<D)A<V4H
M9V1B+GAM971H;V0N6$UE=&AO9%=O<FME<BDZ"B`@("!D968@7U]I;FET7U\H
M<V5L9BP@=6YO<F1E<F5D*3H*("`@("`@("!S96QF+E]U;F]R9&5R960@/2!U
M;F]R9&5R960*"B`@("!D968@;F]D95]C;W5N="AS96QF+"!O8FHI.@H@("`@
M("`@(&EF('-E;&8N7W5N;W)D97)E9#H*("`@("`@("`@("`@<F5T=7)N(&]B
M:ELG7TU?:"==6R=?35]E;&5M96YT7V-O=6YT)UT*("`@("`@("!E;'-E.@H@
M("`@("`@("`@("!R971U<FX@;V)J6R=?35]T)UU;)U]-7VEM<&PG75LG7TU?
M;F]D95]C;W5N="=="@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N($YO;F4*"F-L87-S($%S<V]C:6%T:79E0V]N=&%I;F5R
M16UP='E7;W)K97(H07-S;V-I871I=F5#;VYT86EN97)7;W)K97)"87-E*3H*
M("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R
M971U<FX@9V5T7V)O;VQ?='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L
M(&]B:BDZ"B`@("`@("`@<F5T=7)N(&EN="AS96QF+FYO9&5?8V]U;G0H;V)J
M*2D@/3T@,`H*8VQA<W,@07-S;V-I871I=F5#;VYT86EN97)3:7IE5V]R:V5R
M*$%S<V]C:6%T:79E0V]N=&%I;F5R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T
M7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S
M=&1?<VEZ95]T>7!E*"D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*
M("`@("`@("!R971U<FX@<V5L9BYN;V1E7V-O=6YT*&]B:BD*"F-L87-S($%S
M<V]C:6%T:79E0V]N=&%I;F5R365T:&]D<TUA=&-H97(H9V1B+GAM971H;V0N
M6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YA;64I
M.@H@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R+E]?:6YI=%]?
M*'-E;&8L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@;6%T8VAE<E]N86UE7W!R969I>"`K(&YA;64I"B`@("`@("`@<V5L
M9BY?;F%M92`](&YA;64*("`@("`@("!S96QF+E]M971H;V1?9&EC="`]('L*
M("`@("`@("`@("`@)W-I>F4G.B!,:6)3=&1#>'A8365T:&]D*"=S:7IE)RP@
M07-S;V-I871I=F5#;VYT86EN97)3:7IE5V]R:V5R*2P*("`@("`@("`@("`@
M)V5M<'1Y)SH@3&EB4W1D0WAX6$UE=&AO9"@G96UP='DG+`H@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@($%S<V]C:6%T:79E0V]N=&%I
M;F5R16UP='E7;W)K97(I+`H@("`@("`@('T*("`@("`@("!S96QF+FUE=&AO
M9',@/2!;<V5L9BY?;65T:&]D7V1I8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T
M:&]D7V1I8W1="@H@("`@9&5F(&UA=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE
M=&AO9%]N86UE*3H*("`@("`@("!I9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?
M7UQD*SHZ*3\E<SPN*CXD)R`E('-E;&8N7VYA;64L(&-L87-S7W1Y<&4N=&%G
M*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M971H;V0@/2!S
M96QF+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@("`@("`@:68@
M;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@("`@("`@
M("`@("!R971U<FX@3F]N90H@("`@("`@('5N;W)D97)E9"`]("=U;F]R9&5R
M960G(&EN('-E;&8N7VYA;64*("`@("`@("!R971U<FX@;65T:&]D+G=O<FME
M<E]C;&%S<RAU;F]R9&5R960I"@HC(%AM971H;V1S(&9O<B!S=&0Z.G5N:7%U
M95]P='(*"F-L87-S(%5N:7%U95!T<D=E=%=O<FME<BAG9&(N>&UE=&AO9"Y8
M365T:&]D5V]R:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ=6YI<75E7W!T
M<CQ4/CHZ9V5T*"D@86YD('-T9#HZ=6YI<75E7W!T<CQ4/CHZ;W!E<F%T;W(M
M/B@I(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I.@H@("`@
M("`@('-E;&8N7VES7V%R<F%Y(#T@96QE;5]T>7!E+F-O9&4@/3T@9V1B+E19
M4$5?0T]$15]!4E)!60H@("`@("`@(&EF('-E;&8N7VES7V%R<F%Y.@H@("`@
M("`@("`@("!S96QF+E]E;&5M7W1Y<&4@/2!E;&5M7W1Y<&4N=&%R9V5T*"D*
M("`@("`@("!E;'-E.@H@("`@("`@("`@("!S96QF+E]E;&5M7W1Y<&4@/2!E
M;&5M7W1Y<&4*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@
M("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@
M;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?96QE;5]T>7!E+G!O:6YT97(H
M*0H*("`@(&1E9B!?<W5P<&]R=',H<V5L9BP@;65T:&]D7VYA;64I.@H@("`@
M("`@(")O<&5R871O<BT^(&ES(&YO="!S=7!P;W)T960@9F]R('5N:7%U95]P
M='(\5%M=/B(*("`@("`@("!R971U<FX@;65T:&]D7VYA;64@/3T@)V=E="<@
M;W(@;F]T('-E;&8N7VES7V%R<F%Y"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L
M(&]B:BDZ"B`@("`@("`@:6UP;%]T>7!E(#T@;V)J+F1E<F5F97)E;F-E*"DN
M='EP92YF:65L9',H*5LP72YT>7!E+G1A9PH@("`@("`@(",@0VAE8VL@9F]R
M(&YE=R!I;7!L96UE;G1A=&EO;G,@9FER<W0Z"B`@("`@("`@:68@<F4N;6%T
M8V@H)UYS=&0Z.BA?7UQD*SHZ*3]?7W5N:7%?<'1R7RAD871A?&EM<&PI/"XJ
M/B0G+"!I;7!L7W1Y<&4I.@H@("`@("`@("`@("!T=7!L95]M96UB97(@/2!O
M8FI;)U]-7W0G75LG7TU?="=="B`@("`@("`@96QI9B!R92YM871C:"@G7G-T
M9#HZ*%]?7&0K.CHI/W1U<&QE/"XJ/B0G+"!I;7!L7W1Y<&4I.@H@("`@("`@
M("`@("!T=7!L95]M96UB97(@/2!O8FI;)U]-7W0G70H@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@='5P;&5?:6UP;%]T
M>7!E(#T@='5P;&5?;65M8F5R+G1Y<&4N9FEE;&1S*"E;,%TN='EP92`C(%]4
M=7!L95]I;7!L"B`@("`@("`@='5P;&5?:&5A9%]T>7!E(#T@='5P;&5?:6UP
M;%]T>7!E+F9I96QD<R@I6S%=+G1Y<&4@("`C(%](96%D7V)A<V4*("`@("`@
M("!H96%D7V9I96QD(#T@='5P;&5?:&5A9%]T>7!E+F9I96QD<R@I6S!="B`@
M("`@("`@:68@:&5A9%]F:65L9"YN86UE(#T]("=?35]H96%D7VEM<&PG.@H@
M("`@("`@("`@("!R971U<FX@='5P;&5?;65M8F5R6R=?35]H96%D7VEM<&PG
M70H@("`@("`@(&5L:68@:&5A9%]F:65L9"YI<U]B87-E7V-L87-S.@H@("`@
M("`@("`@("!R971U<FX@='5P;&5?;65M8F5R+F-A<W0H:&5A9%]F:65L9"YT
M>7!E*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"@IC
M;&%S<R!5;FEQ=650=')$97)E9E=O<FME<BA5;FEQ=650=')'9717;W)K97(I
M.@H@("`@(DEM<&QE;65N=',@<W1D.CIU;FEQ=65?<'1R/%0^.CIO<&5R871O
M<BHH*2(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@
M("`@("!5;FEQ=650=')'9717;W)K97(N7U]I;FET7U\H<V5L9BP@96QE;5]T
M>7!E*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@
M("`@("!R971U<FX@<V5L9BY?96QE;5]T>7!E"@H@("`@9&5F(%]S=7!P;W)T
M<RAS96QF+"!M971H;V1?;F%M92DZ"B`@("`@("`@(F]P97)A=&]R*B!I<R!N
M;W0@<W5P<&]R=&5D(&9O<B!U;FEQ=65?<'1R/%1;73XB"B`@("`@("`@<F5T
M=7)N(&YO="!S96QF+E]I<U]A<G)A>0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF
M+"!O8FHI.@H@("`@("`@(')E='5R;B!5;FEQ=650=')'9717;W)K97(N7U]C
M86QL7U\H<V5L9BP@;V)J*2YD97)E9F5R96YC92@I"@IC;&%S<R!5;FEQ=650
M=')3=6)S8W)I<'17;W)K97(H56YI<75E4'1R1V5T5V]R:V5R*3H*("`@("))
M;7!L96UE;G1S('-T9#HZ=6YI<75E7W!T<CQ4/CHZ;W!E<F%T;W);72AS:7IE
M7W0I(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I.@H@("`@
M("`@(%5N:7%U95!T<D=E=%=O<FME<BY?7VEN:71?7RAS96QF+"!E;&5M7W1Y
M<&4I"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T
M=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*"B`@("!D968@9V5T7W)E<W5L=%]T
M>7!E*'-E;&8L(&]B:BP@:6YD97@I.@H@("`@("`@(')E='5R;B!S96QF+E]E
M;&5M7W1Y<&4*"B`@("!D968@7W-U<'!O<G1S*'-E;&8L(&UE=&AO9%]N86UE
M*3H*("`@("`@("`B;W!E<F%T;W);72!I<R!O;FQY('-U<'!O<G1E9"!F;W(@
M=6YI<75E7W!T<CQ46UT^(@H@("`@("`@(')E='5R;B!S96QF+E]I<U]A<G)A
M>0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@
M("!R971U<FX@56YI<75E4'1R1V5T5V]R:V5R+E]?8V%L;%]?*'-E;&8L(&]B
M:BE;:6YD97A="@IC;&%S<R!5;FEQ=650=')-971H;V1S36%T8VAE<BAG9&(N
M>&UE=&AO9"Y8365T:&]D36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L
M9BDZ"B`@("`@("`@9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET
M7U\H<V5L9BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("!M871C:&5R7VYA;65?<')E9FEX("L@)W5N:7%U95]P='(G*0H@
M("`@("`@('-E;&8N7VUE=&AO9%]D:6-T(#T@>PH@("`@("`@("`@("`G9V5T
M)SH@3&EB4W1D0WAX6$UE=&AO9"@G9V5T)RP@56YI<75E4'1R1V5T5V]R:V5R
M*2P*("`@("`@("`@("`@)V]P97)A=&]R+3XG.B!,:6)3=&1#>'A8365T:&]D
M*"=O<&5R871O<BT^)RP@56YI<75E4'1R1V5T5V]R:V5R*2P*("`@("`@("`@
M("`@)V]P97)A=&]R*B<Z($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R*B<L
M(%5N:7%U95!T<D1E<F5F5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R
M6UTG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R871O<EM=)RP@56YI<75E4'1R
M4W5B<V-R:7!T5V]R:V5R*2P*("`@("`@("!]"B`@("`@("`@<V5L9BYM971H
M;V1S(#T@6W-E;&8N7VUE=&AO9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE
M=&AO9%]D:6-T70H*("`@(&1E9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M
M971H;V1?;F%M92DZ"B`@("`@("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH
M7U]<9"LZ.BD_=6YI<75E7W!T<CPN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@
M("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N
M7VUE=&AO9%]D:6-T+F=E="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H
M;V0@:7,@3F]N92!O<B!N;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@
M(')E='5R;B!.;VYE"B`@("`@("`@=V]R:V5R(#T@;65T:&]D+G=O<FME<E]C
M;&%S<RAC;&%S<U]T>7!E+G1E;7!L871E7V%R9W5M96YT*#`I*0H@("`@("`@
M(&EF('=O<FME<BY?<W5P<&]R=',H;65T:&]D7VYA;64I.@H@("`@("`@("`@
M("!R971U<FX@=V]R:V5R"B`@("`@("`@<F5T=7)N($YO;F4*"B,@6&UE=&AO
M9',@9F]R('-T9#HZ<VAA<F5D7W!T<@H*8VQA<W,@4VAA<F5D4'1R1V5T5V]R
M:V5R*&=D8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@(DEM<&QE;65N
M=',@<W1D.CIS:&%R961?<'1R/%0^.CIG970H*2!A;F0@<W1D.CIS:&%R961?
M<'1R/%0^.CIO<&5R871O<BT^*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M(&5L96U?='EP92DZ"B`@("`@("`@<V5L9BY?:7-?87)R87D@/2!E;&5M7W1Y
M<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7T%24D%9"B`@("`@("`@:68@<V5L
M9BY?:7-?87)R87DZ"B`@("`@("`@("`@('-E;&8N7V5L96U?='EP92`](&5L
M96U?='EP92YT87)G970H*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E
M;&8N7V5L96U?='EP92`](&5L96U?='EP90H*("`@(&1E9B!G971?87)G7W1Y
M<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R
M97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]E
M;&5M7W1Y<&4N<&]I;G1E<B@I"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M
M971H;V1?;F%M92DZ"B`@("`@("`@(F]P97)A=&]R+3X@:7,@;F]T('-U<'!O
M<G1E9"!F;W(@<VAA<F5D7W!T<CQ46UT^(@H@("`@("`@(')E='5R;B!M971H
M;V1?;F%M92`]/2`G9V5T)R!O<B!N;W0@<V5L9BY?:7-?87)R87D*"B`@("!D
M968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@;V)J6R=?
M35]P='(G70H*8VQA<W,@4VAA<F5D4'1R1&5R9697;W)K97(H4VAA<F5D4'1R
M1V5T5V]R:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ<VAA<F5D7W!T<CQ4
M/CHZ;W!E<F%T;W(J*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?
M='EP92DZ"B`@("`@("`@4VAA<F5D4'1R1V5T5V]R:V5R+E]?:6YI=%]?*'-E
M;&8L(&5L96U?='EP92D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L
M(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7V5L96U?='EP90H*("`@(&1E
M9B!?<W5P<&]R=',H<V5L9BP@;65T:&]D7VYA;64I.@H@("`@("`@(")O<&5R
M871O<BH@:7,@;F]T('-U<'!O<G1E9"!F;W(@<VAA<F5D7W!T<CQ46UT^(@H@
M("`@("`@(')E='5R;B!N;W0@<V5L9BY?:7-?87)R87D*"B`@("!D968@7U]C
M86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@4VAA<F5D4'1R1V5T
M5V]R:V5R+E]?8V%L;%]?*'-E;&8L(&]B:BDN9&5R969E<F5N8V4H*0H*8VQA
M<W,@4VAA<F5D4'1R4W5B<V-R:7!T5V]R:V5R*%-H87)E9%!T<D=E=%=O<FME
M<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z.G-H87)E9%]P='(\5#XZ.F]P97)A
M=&]R6UTH<VEZ95]T*2(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@96QE;5]T
M>7!E*3H*("`@("`@("!3:&%R9610=')'9717;W)K97(N7U]I;FET7U\H<V5L
M9BP@96QE;5]T>7!E*0H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@
M("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U
M<FX@<V5L9BY?96QE;5]T>7!E"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M
M971H;V1?;F%M92DZ"B`@("`@("`@(F]P97)A=&]R6UT@:7,@;VYL>2!S=7!P
M;W)T960@9F]R('-H87)E9%]P='(\5%M=/B(*("`@("`@("!R971U<FX@<V5L
M9BY?:7-?87)R87D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!I;F1E
M>"DZ"B`@("`@("`@(R!#:&5C:R!B;W5N9',@:68@7V5L96U?='EP92!I<R!A
M;B!A<G)A>2!O9B!K;F]W;B!B;W5N9`H@("`@("`@(&T@/2!R92YM871C:"@G
M+BI<6RA<9"LI720G+"!S='(H<V5L9BY?96QE;5]T>7!E*2D*("`@("`@("!I
M9B!M(&%N9"!I;F1E>"`^/2!I;G0H;2YG<F]U<"@Q*2DZ"B`@("`@("`@("`@
M(')A:7-E($EN9&5X17)R;W(H)W-H87)E9%]P='(\)7,^(&EN9&5X("(E9"(@
M<VAO=6QD(&YO="!B92`^/2`E9"XG("4*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`H<V5L9BY?96QE;5]T>7!E+"!I;G0H:6YD97@I+"!I;G0H;2YG
M<F]U<"@Q*2DI*0H@("`@("`@(')E='5R;B!3:&%R9610=')'9717;W)K97(N
M7U]C86QL7U\H<V5L9BP@;V)J*5MI;F1E>%T*"F-L87-S(%-H87)E9%!T<E5S
M94-O=6YT5V]R:V5R*&=D8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@
M(DEM<&QE;65N=',@<W1D.CIS:&%R961?<'1R/%0^.CIU<V5?8V]U;G0H*2(*
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@("`@("!3
M:&%R9610=')5<V5#;W5N=%=O<FME<BY?7VEN:71?7RAS96QF+"!E;&5M7W1Y
M<&4I"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T
M=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ
M"B`@("`@("`@<F5T=7)N(&=D8BYL;V]K=7!?='EP92@G;&]N9R<I"@H@("`@
M9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5F8V]U;G1S(#T@
M;V)J6R=?35]R969C;W5N="==6R=?35]P:2=="B`@("`@("`@<F5T=7)N(')E
M9F-O=6YT<ULG7TU?=7-E7V-O=6YT)UT@:68@<F5F8V]U;G1S(&5L<V4@,`H*
M8VQA<W,@4VAA<F5D4'1R56YI<75E5V]R:V5R*%-H87)E9%!T<E5S94-O=6YT
M5V]R:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ<VAA<F5D7W!T<CQ4/CHZ
M=6YI<75E*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?='EP92DZ
M"B`@("`@("`@4VAA<F5D4'1R57-E0V]U;G17;W)K97(N7U]I;FET7U\H<V5L
M9BP@96QE;5]T>7!E*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@
M;V)J*3H*("`@("`@("!R971U<FX@9V1B+FQO;VMU<%]T>7!E*"=B;V]L)RD*
M"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M4VAA<F5D4'1R57-E0V]U;G17;W)K97(N7U]C86QL7U\H<V5L9BP@;V)J*2`]
M/2`Q"@IC;&%S<R!3:&%R9610=')-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO
M9"Y8365T:&]D36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@
M("`@("`@9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L
M9BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!M871C:&5R7VYA;65?<')E9FEX("L@)W-H87)E9%]P='(G*0H@("`@("`@
M('-E;&8N7VUE=&AO9%]D:6-T(#T@>PH@("`@("`@("`@("`G9V5T)SH@3&EB
M4W1D0WAX6$UE=&AO9"@G9V5T)RP@4VAA<F5D4'1R1V5T5V]R:V5R*2P*("`@
M("`@("`@("`@)V]P97)A=&]R+3XG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R
M871O<BT^)RP@4VAA<F5D4'1R1V5T5V]R:V5R*2P*("`@("`@("`@("`@)V]P
M97)A=&]R*B<Z($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R*B<L(%-H87)E
M9%!T<D1E<F5F5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R6UTG.B!,
M:6)3=&1#>'A8365T:&]D*"=O<&5R871O<EM=)RP@4VAA<F5D4'1R4W5B<V-R
M:7!T5V]R:V5R*2P*("`@("`@("`@("`@)W5S95]C;W5N="<Z($QI8E-T9$-X
M>%A-971H;V0H)W5S95]C;W5N="<L(%-H87)E9%!T<E5S94-O=6YT5V]R:V5R
M*2P*("`@("`@("`@("`@)W5N:7%U92<Z($QI8E-T9$-X>%A-971H;V0H)W5N
M:7%U92<L(%-H87)E9%!T<E5N:7%U95=O<FME<BDL"B`@("`@("`@?0H@("`@
M("`@('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@
M;2!I;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@
M8VQA<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM
M871C:"@G7G-T9#HZ*%]?7&0K.CHI/W-H87)E9%]P='(\+BH^)"<L(&-L87-S
M7W1Y<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M
M971H;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@
M("`@("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D
M.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@('=O<FME<B`](&UE
M=&AO9"YW;W)K97)?8VQA<W,H8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N
M="@P*2D*("`@("`@("!I9B!W;W)K97(N7W-U<'!O<G1S*&UE=&AO9%]N86UE
M*3H*("`@("`@("`@("`@<F5T=7)N('=O<FME<@H@("`@("`@(')E='5R;B!.
M;VYE"@P*9&5F(')E9VES=&5R7VQI8G-T9&-X>%]X;65T:&]D<RAL;V-U<RDZ
M"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C
M=7,L($%R<F%Y365T:&]D<TUA=&-H97(H*2D*("`@(&=D8BYX;65T:&]D+G)E
M9VES=&5R7WAM971H;V1?;6%T8VAE<BAL;V-U<RP@1F]R=V%R9$QI<W1-971H
M;V1S36%T8VAE<B@I*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO
M9%]M871C:&5R*&QO8W5S+"!$97%U94UE=&AO9'--871C:&5R*"DI"B`@("!G
M9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L($QI
M<W1-971H;V1S36%T8VAE<B@I*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?
M>&UE=&AO9%]M871C:&5R*&QO8W5S+"!696-T;W)-971H;V1S36%T8VAE<B@I
M*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@
M("`@("`@(&QO8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C
M:&5R*"=S970G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?
M;6%T8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-
M971H;V1S36%T8VAE<B@G;6%P)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E
M<E]X;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E
M0V]N=&%I;F5R365T:&]D<TUA=&-H97(H)VUU;'1I<V5T)RDI"B`@("!G9&(N
M>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C
M=7,L($%S<V]C:6%T:79E0V]N=&%I;F5R365T:&]D<TUA=&-H97(H)VUU;'1I
M;6%P)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H
M97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N=&%I;F5R365T:&]D
M<TUA=&-H97(H)W5N;W)D97)E9%]S970G*2D*("`@(&=D8BYX;65T:&]D+G)E
M9VES=&5R7WAM971H;V1?;6%T8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I
M871I=F5#;VYT86EN97)-971H;V1S36%T8VAE<B@G=6YO<F1E<F5D7VUA<"<I
M*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@
M("`@("`@(&QO8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C
M:&5R*"=U;F]R9&5R961?;75L=&ES970G*2D*("`@(&=D8BYX;65T:&]D+G)E
M9VES=&5R7WAM971H;V1?;6%T8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I
M871I=F5#;VYT86EN97)-971H;V1S36%T8VAE<B@G=6YO<F1E<F5D7VUU;'1I
M;6%P)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H
M97(H;&]C=7,L(%5N:7%U95!T<DUE=&AO9'--871C:&5R*"DI"B`@("!G9&(N
M>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L(%-H87)E
M9%!T<DUE=&AO9'--871C:&5R*"DI"@``````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````+B]P>71H;VXO;&EB
M<W1D8WAX+U]?:6YI=%]?+G!Y````````````````````````````````````
M`````````````````````````````````````````````````````````#`P
M,#`V-C0`,#`P,3<U,``P,#`Q-S4P`#`P,#`P,#`P,#`Q`#$S-S$S-#4R-C8S
M`#`Q-C4P-``@,```````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````!U<W1A<B`@`&9J87)D;VX`````````````
M````````````````````9FIA<F1O;@``````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````*````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````"XO<'ET:&]N+TUA:V5F:6QE+F%M````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````P,#`P-C8T`#`P,#$W
M-3``,#`P,3<U,``P,#`P,#`P-#,S-P`Q,S<Q,S0U,C8V,P`P,30T-#,`(#``
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````=7-T87(@(`!F:F%R9&]N````````````````````````````
M`````&9J87)D;VX`````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````(R,@36%K
M969I;&4@9F]R('1H92!P>71H;VX@<W5B9&ER96-T;W)Y(&]F('1H92!'3E4@
M0RLK(%-T86YD87)D(&QI8G)A<GDN"B,C"B,C($-O<'ER:6=H="`H0RD@,C`P
M.2TR,#(P($9R964@4V]F='=A<F4@1F]U;F1A=&EO;BP@26YC+@HC(PHC(R!4
M:&ES(&9I;&4@:7,@<&%R="!O9B!T:&4@;&EB<W1D8RLK('9E<G-I;VX@,R!D
M:7-T<FEB=71I;VXN"B,C(%!R;V-E<W,@=&AI<R!F:6QE('=I=&@@875T;VUA
M:V4@=&\@<')O9'5C92!-86ME9FEL92YI;BX*"B,C(%1H:7,@9FEL92!I<R!P
M87)T(&]F('1H92!'3E4@25-/($,K*R!,:6)R87)Y+B`@5&AI<R!L:6)R87)Y
M(&ES(&9R964*(R,@<V]F='=A<F4[('EO=2!C86X@<F5D:7-T<FEB=71E(&ET
M(&%N9"]O<B!M;V1I9GD@:70@=6YD97(@=&AE"B,C('1E<FUS(&]F('1H92!'
M3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS92!A<R!P=6)L:7-H960@8GD@=&AE
M"B,C($9R964@4V]F='=A<F4@1F]U;F1A=&EO;CL@96ET:&5R('9E<G-I;VX@
M,RP@;W(@*&%T('EO=7(@;W!T:6]N*0HC(R!A;GD@;&%T97(@=F5R<VEO;BX*
M(R,*(R,@5&AI<R!L:6)R87)Y(&ES(&1I<W1R:6)U=&5D(&EN('1H92!H;W!E
M('1H870@:70@=VEL;"!B92!U<V5F=6PL"B,C(&)U="!7251(3U54($%.62!7
M05)204Y463L@=VET:&]U="!E=F5N('1H92!I;7!L:65D('=A<G)A;G1Y(&]F
M"B,C($U%4D-(04Y404))3$E462!O<B!&251.15-3($9/4B!!(%!!4E1)0U5,
M05(@4%524$]312X@(%-E92!T:&4*(R,@1TY5($=E;F5R86P@4'5B;&EC($QI
M8V5N<V4@9F]R(&UO<F4@9&5T86EL<RX*(R,*(R,@66]U('-H;W5L9"!H879E
M(')E8V5I=F5D(&$@8V]P>2!O9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC($QI
M8V5N<V4@86QO;F<*(R,@=VET:"!T:&ES(&QI8G)A<GD[('-E92!T:&4@9FEL
M92!#3U!924Y',RX@($EF(&YO="!S964*(R,@/&AT='`Z+R]W=W<N9VYU+F]R
M9R]L:6-E;G-E<R\^+@H*:6YC;'5D92`D*'1O<%]S<F-D:7(I+V9R86=M96YT
M+F%M"@HC(R!7:&5R92!T;R!I;G-T86QL('1H92!M;V1U;&4@8V]D92X*:68@
M14Y!0DQ%7U!95$A/3D1)4@IP>71H;VYD:7(@/2`D*'!R969I>"DO)"AP>71H
M;VY?;6]D7V1I<BD*96QS90IP>71H;VYD:7(@/2`D*&1A=&%D:7(I+V=C8RTD
M*&=C8U]V97)S:6]N*2]P>71H;VX*96YD:68*"F%L;"UL;V-A;#H@9V1B+G!Y
M"@IN;V)A<V5?<'ET:&]N7T1!5$$@/2!<"B`@("!L:6)S=&1C>'@O=C8O<')I
M;G1E<G,N<'D@7`H@("`@;&EB<W1D8WAX+W8V+WAM971H;V1S+G!Y(%P*("`@
M(&QI8G-T9&-X>"]V-B]?7VEN:71?7RYP>2!<"B`@("!L:6)S=&1C>'@O7U]I
M;FET7U\N<'D*"F=D8BYP>3H@:&]O:RYI;B!-86ME9FEL90H)<V5D("UE("=S
M+$!P>71H;VYD:7)`+"0H<'ET:&]N9&ER*2PG(%P*"2`@("`M92`G<RQ`=&]O
M;&5X96-L:6)D:7)`+"0H=&]O;&5X96-L:6)D:7(I+"<@/"`D*'-R8V1I<BDO
M:&]O:RYI;B`^("1`"@II;G-T86QL+61A=&$M;&]C86PZ(&=D8BYP>0H)0"0H
M;6MD:7)?<"D@)"A$15-41$E2*20H=&]O;&5X96-L:6)D:7(I"B,C(%=E('=A
M;G0@=&\@:6YS=&%L;"!G9&(N<'D@87,@4T]-151(24Y'+6=D8BYP>2X@(%-/
M34542$E.1R!I<R!T:&4*(R,@9G5L;"!N86UE(&]F('1H92!F:6YA;"!L:6)R
M87)Y+B`@5V4@=V%N="!T;R!I9VYO<F4@<WEM;&EN:W,L('1H90HC(R`N;&$@
M9FEL92P@86YD(&%N>2!P<F5V:6]U<R`M9V1B+G!Y(&9I;&4N("!4:&ES(&ES
M(&EN:&5R96YT;'D*(R,@9G)A9VEL92P@8G5T('1H97)E(&1O97,@;F]T('-E
M96T@=&\@8F4@82!B971T97(@;W!T:6]N+"!B96-A=7-E"B,C(&QI8G1O;VP@
M:&ED97,@=&AE(')E86P@;F%M97,@9G)O;2!U<RX*"4!H97)E/6!P=V1@.R!C
M9"`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BD[(%P*"2`@9F]R(&9I;&4@
M:6X@;&EB<W1D8RLK+BH[(&1O(%P*"2`@("!C87-E("0D9FEL92!I;B!<"@D@
M("`@("`J+6=D8BYP>2D@.SL@7`H)("`@("`@*BYL82D@.SL@7`H)("`@("`@
M*BD@:68@=&5S="`M:"`D)&9I;&4[('1H96X@7`H)("`@("`@("`@("!C;VYT
M:6YU93L@7`H)("`@("`@("`@9FD[(%P*"2`@("`@("`@(&QI8FYA;64])"1F
M:6QE.SL@7`H)("`@(&5S86,[(%P*"2`@9&]N93L@7`H)8V0@)"1H97)E.R!<
M"@EE8VAO("(@)"A)3E-404Q,7T1!5$$I(&=D8BYP>2`D*$1%4U1$25(I)"AT
M;V]L97AE8VQI8F1I<BDO)"1L:6)N86UE+6=D8BYP>2([(%P*"20H24Y35$%,
M3%]$051!*2!G9&(N<'D@)"A$15-41$E2*20H=&]O;&5X96-L:6)D:7(I+R0D
M;&EB;F%M92UG9&(N<'D*````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````"XO<'ET:&]N+TUA
M:V5F:6QE+FEN````````````````````````````````````````````````
M```````````````````````````````````````````````````````````P
M,#`P-C8T`#`P,#$W-3``,#`P,3<U,``P,#`P,#`T-#4Q,``Q,S<Q,S0U,C8V
M,P`P,30T-3$`(#``````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````=7-T87(@(`!F:F%R9&]N````````````
M`````````````````````&9J87)D;VX`````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````(R!-86ME9FEL92YI;B!G96YE<F%T960@8GD@875T;VUA:V4@,2XQ
M-2XQ(&9R;VT@36%K969I;&4N86TN"B,@0&-O;F9I9W5R95]I;G!U=$`*"B,@
M0V]P>7)I9VAT("A#*2`Q.3DT+3(P,3<@1G)E92!3;V9T=V%R92!&;W5N9&%T
M:6]N+"!);F,N"@HC(%1H:7,@36%K969I;&4N:6X@:7,@9G)E92!S;V9T=V%R
M93L@=&AE($9R964@4V]F='=A<F4@1F]U;F1A=&EO;@HC(&=I=F5S('5N;&EM
M:71E9"!P97)M:7-S:6]N('1O(&-O<'D@86YD+V]R(&1I<W1R:6)U=&4@:70L
M"B,@=VET:"!O<B!W:71H;W5T(&UO9&EF:6-A=&EO;G,L(&%S(&QO;F<@87,@
M=&AI<R!N;W1I8V4@:7,@<')E<V5R=F5D+@H*(R!4:&ES('!R;V=R86T@:7,@
M9&ES=')I8G5T960@:6X@=&AE(&AO<&4@=&AA="!I="!W:6QL(&)E('5S969U
M;"P*(R!B=70@5TE42$]55"!!3ED@5T%24D%.5%DL('1O('1H92!E>'1E;G0@
M<&5R;6ET=&5D(&)Y(&QA=SL@=VET:&]U=`HC(&5V96X@=&AE(&EM<&QI960@
M=V%R<F%N='D@;V8@34520TA!3E1!0DE,2519(&]R($9)5$Y%4U,@1D]2($$*
M(R!005)424-53$%2(%!54E!/4T4N"@I`4T547TU!2T5`"@I64$%42"`]($!S
M<F-D:7)`"F%M7U]I<U]G;G5?;6%K92`]('L@7`H@(&EF('1E<W0@+7H@)R0H
M34%+14Q%5D5,*2<[('1H96X@7`H@("`@9F%L<V4[(%P*("!E;&EF('1E<W0@
M+6X@)R0H34%+15](3U-4*2<[('1H96X@7`H@("`@=')U93L@7`H@(&5L:68@
M=&5S="`M;B`G)"A-04M%7U9%4E-)3TXI)R`F)B!T97-T("UN("<D*$-54D1)
M4BDG.R!T:&5N(%P*("`@('1R=64[(%P*("!E;'-E(%P*("`@(&9A;'-E.R!<
M"B`@9FD[(%P*?0IA;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N(#T@7`H@
M(&-A<V4@)"1[=&%R9V5T7V]P=&EO;BU](&EN(%P*("`@("`@/RD@.SL@7`H@
M("`@("`J*2!E8VAO(")A;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N.B!I
M;G1E<FYA;"!E<G)O<CH@:6YV86QI9"(@7`H@("`@("`@("`@("`@(")T87)G
M970@;W!T:6]N("<D)'MT87)G971?;W!T:6]N+7TG('-P96-I9FEE9"(@/B8R
M.R!<"B`@("`@("`@(&5X:70@,3L[(%P*("!E<V%C.R!<"B`@:&%S7V]P=#UN
M;SL@7`H@('-A;F5?;6%K969L86=S/20D34%+149,04=3.R!<"B`@:68@)"AA
M;5]?:7-?9VYU7VUA:V4I.R!T:&5N(%P*("`@('-A;F5?;6%K969L86=S/20D
M349,04=3.R!<"B`@96QS92!<"B`@("!C87-E("0D34%+149,04=3(&EN(%P*
M("`@("`@*EQ<6UP@7`E=*BD@7`H@("`@("`@(&)S/5Q<.R!<"B`@("`@("`@
M<V%N95]M86ME9FQA9W,]8'!R:6YT9B`G)7-<;B<@(B0D34%+149,04=3(B!<
M"B`@("`@("`@("!\('-E9"`B<R\D)&)S)"1B<ULD)&)S("0D8G,)72HO+V<B
M8#L[(%P*("`@(&5S86,[(%P*("!F:3L@7`H@('-K:7!?;F5X=#UN;SL@7`H@
M('-T<FEP7W1R86EL;W!T("@I(%P*("![(%P*("`@(&9L9SU@<')I;G1F("<E
M<UQN)R`B)"1F;&<B('P@<V5D(")S+R0D,2XJ)"0O+R)@.R!<"B`@?3L@7`H@
M(&9O<B!F;&<@:6X@)"1S86YE7VUA:V5F;&%G<SL@9&\@7`H@("`@=&5S="`D
M)'-K:7!?;F5X="`]('EE<R`F)B![('-K:7!?;F5X=#UN;SL@8V]N=&EN=64[
M('T[(%P*("`@(&-A<V4@)"1F;&<@:6X@7`H@("`@("`J/2I\+2TJ*2!C;VYT
M:6YU93L[(%P*("`@("`@("`M*DDI('-T<FEP7W1R86EL;W!T("=))SL@<VMI
M<%]N97AT/7EE<SL[(%P*("`@("`@+2I)/RHI('-T<FEP7W1R86EL;W!T("=)
M)SL[(%P*("`@("`@("`M*D\I('-T<FEP7W1R86EL;W!T("=/)SL@<VMI<%]N
M97AT/7EE<SL[(%P*("`@("`@+2I//RHI('-T<FEP7W1R86EL;W!T("=/)SL[
M(%P*("`@("`@("`M*FPI('-T<FEP7W1R86EL;W!T("=L)SL@<VMI<%]N97AT
M/7EE<SL[(%P*("`@("`@+2IL/RHI('-T<FEP7W1R86EL;W!T("=L)SL[(%P*
M("`@("`@+5MD141M72D@<VMI<%]N97AT/7EE<SL[(%P*("`@("`@+5M*5%TI
M('-K:7!?;F5X=#UY97,[.R!<"B`@("!E<V%C.R!<"B`@("!C87-E("0D9FQG
M(&EN(%P*("`@("`@*B0D=&%R9V5T7V]P=&EO;BHI(&AA<U]O<'0]>65S.R!B
M<F5A:SL[(%P*("`@(&5S86,[(%P*("!D;VYE.R!<"B`@=&5S="`D)&AA<U]O
M<'0@/2!Y97,*86U?7VUA:V5?9')Y<G5N(#T@*'1A<F=E=%]O<'1I;VX];CL@
M)"AA;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N*2D*86U?7VUA:V5?:V5E
M<&=O:6YG(#T@*'1A<F=E=%]O<'1I;VX]:SL@)"AA;5]?;6%K95]R=6YN:6YG
M7W=I=&A?;W!T:6]N*2D*<&MG9&%T861I<B`]("0H9&%T861I<BDO0%!!0TM!
M1T5`"G!K9VEN8VQU9&5D:7(@/2`D*&EN8VQU9&5D:7(I+T!004-+04=%0`IP
M:V=L:6)D:7(@/2`D*&QI8F1I<BDO0%!!0TM!1T5`"G!K9VQI8F5X96-D:7(@
M/2`D*&QI8F5X96-D:7(I+T!004-+04=%0`IA;5]?8V0@/2!#1%!!5$@](B0D
M>UI32%]615)324].*RY])"A0051(7U-%4$%2051/4BDB("8F(&-D"FEN<W1A
M;&Q?<VA?1$%402`]("0H:6YS=&%L;%]S:"D@+6,@+6T@-C0T"FEN<W1A;&Q?
M<VA?4%)/1U)!32`]("0H:6YS=&%L;%]S:"D@+6,*:6YS=&%L;%]S:%]30U))
M4%0@/2`D*&EN<W1A;&Q?<V@I("UC"DE.4U1!3$Q?2$5!1$52(#T@)"A)3E-4
M04Q,7T1!5$$I"G1R86YS9F]R;2`]("0H<')O9W)A;5]T<F%N<V9O<FU?;F%M
M92D*3D]234%,7TE.4U1!3$P@/2`Z"E!215])3E-404Q,(#T@.@I03U-47TE.
M4U1!3$P@/2`Z"DY/4DU!3%]53DE.4U1!3$P@/2`Z"E!215]53DE.4U1!3$P@
M/2`Z"E!/4U1?54Y)3E-404Q,(#T@.@IB=6EL9%]T<FEP;&5T(#T@0&)U:6QD
M0`IH;W-T7W1R:7!L970@/2!`:&]S=$`*=&%R9V5T7W1R:7!L970@/2!`=&%R
M9V5T0`IS=6)D:7(@/2!P>71H;VX*04-,3T-!3%]--"`]("0H=&]P7W-R8V1I
M<BDO86-L;V-A;"YM-`IA;5]?86-L;V-A;%]M-%]D97!S(#T@)"AT;W!?<W)C
M9&ER*2\N+B]C;VYF:6<O86-X+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N
M9FEG+V5N86)L92YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]F=71E
M>"YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]H=V-A<',N;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O:6-O;G8N;30@7`H))"AT;W!?<W)C
M9&ER*2\N+B]C;VYF:6<O;&5A9"UD;W0N;30@7`H))"AT;W!?<W)C9&ER*2\N
M+B]C;VYF:6<O;&EB+6QD+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG
M+VQI8BUL:6YK+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VQI8BUP
M<F5F:7@N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;'1H;W-T9FQA
M9W,N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;75L=&DN;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;F\M97AE8W5T86)L97,N;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;W9E<G)I9&4N;30@7`H))"AT;W!?
M<W)C9&ER*2\N+B]C;VYF:6<O<W1D:6YT+FTT(%P*"20H=&]P7W-R8V1I<BDO
M+BXO8V]N9FEG+W5N=VEN9%]I<&EN9F\N;30@7`H))"AT;W!?<W)C9&ER*2\N
M+B]L:6)T;V]L+FTT("0H=&]P7W-R8V1I<BDO+BXO;'1O<'1I;VYS+FTT(%P*
M"20H=&]P7W-R8V1I<BDO+BXO;'1S=6=A<BYM-"`D*'1O<%]S<F-D:7(I+RXN
M+VQT=F5R<VEO;BYM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+VQT?F]B<V]L971E
M+FTT("0H=&]P7W-R8V1I<BDO8W)O<W-C;VYF:6<N;30@7`H))"AT;W!?<W)C
M9&ER*2]L:6YK86=E+FTT("0H=&]P7W-R8V1I<BDO86-I;F-L=61E+FTT(%P*
M"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V=C*RMF:6QT+FTT(%P*"20H=&]P
M7W-R8V1I<BDO+BXO8V]N9FEG+W1L<RYM-"`D*'1O<%]S<F-D:7(I+RXN+V-O
M;F9I9R]G=&AR+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V-E="YM
M-"`D*'1O<%]S<F-D:7(I+V-O;F9I9W5R92YA8PIA;5]?8V]N9FEG=7)E7V1E
M<',@/2`D*&%M7U]A8VQO8V%L7VTT7V1E<',I("0H0T].1DE'55)%7T1%4$5.
M1$5.0TE%4RD@7`H))"A!0TQ/0T%,7TTT*0I$25-47T-/34U/3B`]("0H<W)C
M9&ER*2]-86ME9FEL92YA;0I#3TY&24=?2$5!1$52(#T@)"AT;W!?8G5I;&1D
M:7(I+V-O;F9I9RYH"D-/3D9)1U]#3$5!3E]&24Q%4R`]"D-/3D9)1U]#3$5!
M3E]64$%42%]&24Q%4R`]"D%-7U9?4"`]("0H86U?7W9?4%]`04U?5D`I"F%M
M7U]V7U!?(#T@)"AA;5]?=E]07T!!35]$149!54Q47U9`*0IA;5]?=E]07S`@
M/2!F86QS90IA;5]?=E]07S$@/2`Z"D%-7U9?1T5.(#T@)"AA;5]?=E]'14Y?
M0$%-7U9`*0IA;5]?=E]'14Y?(#T@)"AA;5]?=E]'14Y?0$%-7T1%1D%53%1?
M5D`I"F%M7U]V7T=%3E\P(#T@0&5C:&\@(B`@1T5.("`@("`B("1`.PIA;5]?
M=E]'14Y?,2`](`I!35]67V%T(#T@)"AA;5]?=E]A=%]`04U?5D`I"F%M7U]V
M7V%T7R`]("0H86U?7W9?871?0$%-7T1%1D%53%1?5D`I"F%M7U]V7V%T7S`@
M/2!`"F%M7U]V7V%T7S$@/2`*9&5P8V]M<"`]"F%M7U]D97!F:6QE<U]M87EB
M92`]"E-/55)#15,@/0IA;5]?8V%N7W)U;E]I;G-T86QL:6YF;R`](%P*("!C
M87-E("0D04U?55!$051%7TE.1D]?1$E2(&EN(%P*("`@(&Y\;F]\3D\I(&9A
M;'-E.SL@7`H@("`@*BD@*&EN<W1A;&PM:6YF;R`M+79E<G-I;VXI(#XO9&5V
M+VYU;&P@,CXF,3L[(%P*("!E<V%C"F%M7U]V<&%T:%]A9&I?<V5T=7`@/2!S
M<F-D:7)S=')I<#U@96-H;R`B)"AS<F-D:7(I(B!\('-E9"`G<WPN?"Y\9R=@
M.PIA;5]?=G!A=&A?861J(#T@8V%S92`D)'`@:6X@7`H@("`@)"AS<F-D:7(I
M+RHI(&8]8&5C:&\@(B0D<"(@?"!S960@(G-\7B0D<W)C9&ER<W1R:7`O?'PB
M8#L[(%P*("`@("HI(&8])"1P.SL@7`H@(&5S86,["F%M7U]S=')I<%]D:7(@
M/2!F/6!E8VAO("0D<"!\('-E9"`M92`G<WQ>+BHO?'PG8#L*86U?7VEN<W1A
M;&Q?;6%X(#T@-#`*86U?7VYO8F%S95]S=')I<%]S971U<"`](%P*("!S<F-D
M:7)S=')I<#U@96-H;R`B)"AS<F-D:7(I(B!\('-E9"`G<R];72Y;7B0D7%PJ
M?%TO7%Q<7"8O9R=@"F%M7U]N;V)A<V5?<W1R:7`@/2!<"B`@9F]R('`@:6X@
M)"1L:7-T.R!D;R!E8VAO("(D)'`B.R!D;VYE('P@<V5D("UE(")S?"0D<W)C
M9&ER<W1R:7`O?'PB"F%M7U]N;V)A<V5?;&ES="`]("0H86U?7VYO8F%S95]S
M=')I<%]S971U<"D[(%P*("!F;W(@<"!I;B`D)&QI<W0[(&1O(&5C:&\@(B0D
M<"`D)'`B.R!D;VYE('P@7`H@('-E9"`B<WP@)"1S<F-D:7)S=')I<"]\('P[
M(B<@+R`N*EPO+R%S+R`N*B\@+B\[(',L7"@@+BI<*2];7B]=*B0D+%PQ+"<@
M?"!<"B`@)"A!5TLI("="14=)3B![(&9I;&5S6R(N(ET@/2`B(B!]('L@9FEL
M97-;)"0R72`](&9I;&5S6R0D,ET@(B`B("0D,3L@7`H@("`@:68@*"LK;ELD
M)#)=(#T]("0H86U?7VEN<W1A;&Q?;6%X*2D@7`H@("`@("![('!R:6YT("0D
M,BP@9FEL97-;)"0R73L@;ELD)#)=(#T@,#L@9FEL97-;)"0R72`]("(B('T@
M?2!<"B`@("!%3D0@>R!F;W(@*&1I<B!I;B!F:6QE<RD@<')I;G0@9&ER+"!F
M:6QE<UMD:7)=('TG"F%M7U]B87-E7VQI<W0@/2!<"B`@<V5D("<D)"%..R0D
M(4X[)"0A3CLD)"%..R0D(4X[)"0A3CLD)"%..W,O7&XO("]G)R!\(%P*("!S
M960@)R0D(4X[)"0A3CLD)"%..R0D(4X[<R]<;B\@+V<G"F%M7U]U;FEN<W1A
M;&Q?9FEL97-?9G)O;5]D:7(@/2![(%P*("!T97-T("UZ("(D)&9I;&5S(B!<
M"B`@("!\?"![('1E<W0@(2`M9"`B)"1D:7(B("8F('1E<W0@(2`M9B`B)"1D
M:7(B("8F('1E<W0@(2`M<B`B)"1D:7(B.R!](%P*("`@('Q\('L@96-H;R`B
M("@@8V0@)R0D9&ER)R`F)B!R;2`M9B(@)"1F:6QE<R`B*2([(%P*("`@("`@
M("`@)"AA;5]?8V0I("(D)&1I<B(@)B8@<FT@+68@)"1F:6QE<SL@?3L@7`H@
M('T*86U?7VEN<W1A;&QD:7)S(#T@(B0H1$535$1)4BDD*'!Y=&AO;F1I<BDB
M"D1!5$$@/2`D*&YO8F%S95]P>71H;VY?1$%402D*86U?7W1A9V=E9%]F:6QE
M<R`]("0H2$5!1$524RD@)"A33U520T53*2`D*%1!1U-?1DE,15,I("0H3$E3
M4"D*04))7U1714%+4U]34D-$25(@/2!`04))7U1714%+4U]34D-$25)`"D%#
M3$]#04P@/2!`04-,3T-!3$`*04Q,3T-!5$]27T@@/2!`04Q,3T-!5$]27TA`
M"D%,3$]#051/4E].04U%(#T@0$%,3$]#051/4E].04U%0`I!351!4B`]($!!
M351!4D`*04U?1$5&055,5%]615)"3U-)5%D@/2!`04U?1$5&055,5%]615)"
M3U-)5%E`"D%2(#T@0$%20`I!4R`]($!!4T`*051/34E#25197U-20T1)4B`]
M($!!5$]-24-)5%E?4U)#1$E20`I!5$]-24-?1DQ!1U,@/2!`051/34E#7T9,
M04=30`I!5$]-24-?5T]21%]34D-$25(@/2!`051/34E#7U=/4D1?4U)#1$E2
M0`I!551/0T].1B`]($!!551/0T].1D`*05543TA%041%4B`]($!!551/2$5!
M1$520`I!551/34%+12`]($!!551/34%+14`*05=+(#T@0$%72T`*0D%324-?
M1DE,15]#0R`]($!"05-)0U]&24Q%7T-#0`I"05-)0U]&24Q%7T@@/2!`0D%3
M24-?1DE,15](0`I#0R`]($!#0T`*0T-/1$5#5E1?0T,@/2!`0T-/1$5#5E1?
M0T-`"D-#3TQ,051%7T-#(#T@0$-#3TQ,051%7T-#0`I#0U194$5?0T,@/2!`
M0T-465!%7T-#0`I#1DQ!1U,@/2!`0T9,04=30`I#3$]#04Q%7T-#(#T@0$-,
M3T-!3$5?0T-`"D-,3T-!3$5?2"`]($!#3$]#04Q%7TA`"D-,3T-!3$5?24Y4
M15).04Q?2"`]($!#3$]#04Q%7TE.5$523D%,7TA`"D--15-304=%4U]#0R`]
M($!#34534T%'15-?0T-`"D--15-304=%4U]((#T@0$--15-304=%4U](0`I#
M34].15E?0T,@/2!`0TU/3D597T-#0`I#3E5-15))0U]#0R`]($!#3E5-15))
M0U]#0T`*0U!0(#T@0$-04$`*0U!01DQ!1U,@/2!`0U!01DQ!1U-`"D-055]$
M149)3D537U-20T1)4B`]($!#4%5?1$5&24Y%4U]34D-$25)`"D-055]/4%1?
M0DE44U]204Y$3TT@/2!`0U!57T]05%]"25137U)!3D1/34`*0U!57T]05%]%
M6%1?4D%.1$]-(#T@0$-055]/4%1?15A47U)!3D1/34`*0U-41$E/7T@@/2!`
M0U-41$E/7TA`"D-424U%7T-#(#T@0$-424U%7T-#0`I#5$E-15]((#T@0$-4
M24U%7TA`"D-86"`]($!#6%A`"D-86$-04"`]($!#6%A#4%!`"D-86$9)3%0@
M/2!`0UA81DE,5$`*0UA81DQ!1U,@/2!`0UA81DQ!1U-`"D-91U!!5$A?5R`]
M($!#64=0051(7U=`"D-?24Y#3%5$15]$25(@/2!`0U])3D-,541%7T1)4D`*
M1$),051%6"`]($!$0DQ!5$580`I$14)51U]&3$%'4R`]($!$14)51U]&3$%'
M4T`*1$5&4R`]($!$14930`I$3U0@/2!`1$]40`I$3UA91T5.(#T@0$1/6%E'
M14Y`"D1364U55$E,(#T@0$1364U55$E,0`I$54U00DE.(#T@0$1535!"24Y`
M"D5#2$]?0R`]($!%0TA/7T-`"D5#2$]?3B`]($!%0TA/7TY`"D5#2$]?5"`]
M($!%0TA/7U1`"D5'4D50(#T@0$5'4D500`I%4E)/4E]#3TY35$%.5%-?4U)#
M1$E2(#T@0$524D]27T-/3E-404Y44U]34D-$25)`"D5814585"`]($!%6$5%
M6%1`"D585%)!7T-&3$%'4R`]($!%6%1205]#1DQ!1U-`"D585%)!7T-86%]&
M3$%'4R`]($!%6%1205]#6%A?1DQ!1U-`"D9'4D50(#T@0$9'4D500`I'3$E"
M0UA87TE.0TQ51$53(#T@0$=,24)#6%A?24Y#3%5$15-`"D=,24)#6%A?3$E"
M4R`]($!'3$E"0UA87TQ)0E-`"D=215`@/2!`1U)%4$`*2%=#05!?0T9,04=3
M(#T@0$A70T%07T-&3$%'4T`*24Y35$%,3"`]($!)3E-404Q,0`I)3E-404Q,
M7T1!5$$@/2!`24Y35$%,3%]$051!0`I)3E-404Q,7U!23T=204T@/2!`24Y3
M5$%,3%]04D]'4D%-0`I)3E-404Q,7U-#4DE05"`]($!)3E-404Q,7U-#4DE0
M5$`*24Y35$%,3%]35%))4%]04D]'4D%-(#T@0$E.4U1!3$Q?4U1225!?4%)/
M1U)!34`*3$0@/2!`3$1`"DQ$1DQ!1U,@/2!`3$1&3$%'4T`*3$E"24-/3E8@
M/2!`3$E"24-/3E9`"DQ)0D]"2E,@/2!`3$E"3T)*4T`*3$E"4R`]($!,24)3
M0`I,24)43T],(#T@0$Q)0E1/3TQ`"DQ)4$\@/2!`3$E03T`*3$Y?4R`]($!,
M3E]30`I,3TY'7T1/54),15]#3TU0051?1DQ!1U,@/2!`3$].1U]$3U5"3$5?
M0T]-4$%47T9,04=30`I,5$Q)0DE#3TY6(#T@0$Q43$E"24-/3E9`"DQ43$E"
M3T)*4R`]($!,5$Q)0D]"2E-`"DU!24Y4(#T@0$U!24Y40`I-04M%24Y&3R`]
M($!-04M%24Y&3T`*34M$25)?4"`]($!-2T1)4E]00`I.32`]($!.34`*3DU%
M1$E4(#T@0$Y-141)5$`*3T)*1%5-4"`]($!/0DI$54U00`I/0DI%6%0@/2!`
M3T)*15A40`I/4%1)34E:15]#6%A&3$%'4R`]($!/4%1)34E:15]#6%A&3$%'
M4T`*3U!47TQ$1DQ!1U,@/2!`3U!47TQ$1DQ!1U-`"D]37TE.0U]34D-$25(@
M/2!`3U-?24Y#7U-20T1)4D`*3U1/3TP@/2!`3U1/3TQ`"D]43T],-C0@/2!`
M3U1/3TPV-$`*4$%#2T%'12`]($!004-+04=%0`I004-+04=%7T)51U)%4$]2
M5"`]($!004-+04=%7T)51U)%4$]25$`*4$%#2T%'15].04U%(#T@0%!!0TM!
M1T5?3D%-14`*4$%#2T%'15]35%))3D<@/2!`4$%#2T%'15]35%))3D=`"E!!
M0TM!1T5?5$%23D%-12`]($!004-+04=%7U1!4DY!345`"E!!0TM!1T5?55),
M(#T@0%!!0TM!1T5?55),0`I004-+04=%7U9%4E-)3TX@/2!`4$%#2T%'15]6
M15)324].0`I0051(7U-%4$%2051/4B`]($!0051(7U-%4$%2051/4D`*4$1&
M3$%415@@/2!`4$1&3$%415A`"E)!3DQ)0B`]($!204Y,24)`"E-%0U1)3TY?
M1DQ!1U,@/2!`4T5#5$E/3E]&3$%'4T`*4T5#5$E/3E],1$9,04=3(#T@0%-%
M0U1)3TY?3$1&3$%'4T`*4T5$(#T@0%-%1$`*4T547TU!2T4@/2!`4T547TU!
M2T5`"E-(14Q,(#T@0%-(14Q,0`I35%))4"`]($!35%))4$`*4UE-5D527T9)
M3$4@/2!`4UE-5D527T9)3$5`"E1/4$Q%5D5,7TE.0TQ51$53(#T@0%1/4$Q%
M5D5,7TE.0TQ51$530`I54T5?3DQ3(#T@0%5315].3%-`"E9%4E-)3TX@/2!`
M5D524TE/3D`*5E167T-86$9,04=3(#T@0%945E]#6%A&3$%'4T`*5E167T-8
M6$Q)3DM&3$%'4R`]($!65%9?0UA83$E.2T9,04=30`I65%9?4$-(7T-86$9,
M04=3(#T@0%945E]00TA?0UA81DQ!1U-`"E=!4DY?1DQ!1U,@/2!`5T%23E]&
M3$%'4T`*6$U,0T%404Q/1R`]($!834Q#051!3$]'0`I834Q,24Y4(#T@0%A-
M3$Q)3E1`"EA33%104D]#(#T@0%A33%104D]#0`I84TQ?4U193$5?1$E2(#T@
M0%A33%]35%E,15]$25)`"F%B<U]B=6EL9&1I<B`]($!A8G-?8G5I;&1D:7)`
M"F%B<U]S<F-D:7(@/2!`86)S7W-R8V1I<D`*86)S7W1O<%]B=6EL9&1I<B`]
M($!A8G-?=&]P7V)U:6QD9&ER0`IA8G-?=&]P7W-R8V1I<B`]($!A8G-?=&]P
M7W-R8V1I<D`*86-?8W1?0T,@/2!`86-?8W1?0T-`"F%C7V-T7T-86"`]($!A
M8U]C=%]#6%A`"F%C7V-T7T1535!"24X@/2!`86-?8W1?1%5-4$))3D`*86U?
M7VQE861I;F=?9&]T(#T@0&%M7U]L96%D:6YG7V1O=$`*86U?7W1A<B`]($!A
M;5]?=&%R0`IA;5]?=6YT87(@/2!`86U?7W5N=&%R0`IB87-E;&EN95]D:7(@
M/2!`8F%S96QI;F5?9&ER0`IB87-E;&EN95]S=6)D:7)?<W=I=&-H(#T@0&)A
M<V5L:6YE7W-U8F1I<E]S=VET8VA`"F)I;F1I<B`]($!B:6YD:7)`"F)U:6QD
M(#T@0&)U:6QD0`IB=6EL9%]A;&EA<R`]($!B=6EL9%]A;&EA<T`*8G5I;&1?
M8W!U(#T@0&)U:6QD7V-P=4`*8G5I;&1?;W,@/2!`8G5I;&1?;W-`"F)U:6QD
M7W9E;F1O<B`]($!B=6EL9%]V96YD;W)`"F)U:6QD9&ER(#T@0&)U:6QD9&ER
M0`IC:&5C:U]M<V=F;70@/2!`8VAE8VM?;7-G9FUT0`ID871A9&ER(#T@0&1A
M=&%D:7)`"F1A=&%R;V]T9&ER(#T@0&1A=&%R;V]T9&ER0`ID;V-D:7(@/2!`
M9&]C9&ER0`ID=FED:7(@/2!`9'9I9&ER0`IE;F%B;&5?<VAA<F5D(#T@0&5N
M86)L95]S:&%R961`"F5N86)L95]S=&%T:6,@/2!`96YA8FQE7W-T871I8T`*
M97AE8U]P<F5F:7@@/2!`97AE8U]P<F5F:7A`"F=E=%]G8V-?8F%S95]V97(@
M/2!`9V5T7V=C8U]B87-E7W9E<D`*9VQI8F-X>%]-3T9)3$53(#T@0&=L:6)C
M>'A?34]&24Q%4T`*9VQI8F-X>%]00TA&3$%'4R`]($!G;&EB8WAX7U!#2$9,
M04=30`IG;&EB8WAX7U!/1DE,15,@/2!`9VQI8F-X>%]03T9)3$530`IG;&EB
M8WAX7V)U:6QD9&ER(#T@0&=L:6)C>'A?8G5I;&1D:7)`"F=L:6)C>'A?8V]M
M<&EL97)?<&EC7V9L86<@/2!`9VQI8F-X>%]C;VUP:6QE<E]P:6-?9FQA9T`*
M9VQI8F-X>%]C;VUP:6QE<E]S:&%R961?9FQA9R`]($!G;&EB8WAX7V-O;7!I
M;&5R7W-H87)E9%]F;&%G0`IG;&EB8WAX7V-X>#DX7V%B:2`]($!G;&EB8WAX
M7V-X>#DX7V%B:4`*9VQI8F-X>%]L;V-A;&5D:7(@/2!`9VQI8F-X>%]L;V-A
M;&5D:7)`"F=L:6)C>'A?;'1?<&EC7V9L86<@/2!`9VQI8F-X>%]L=%]P:6-?
M9FQA9T`*9VQI8F-X>%]P<F5F:7AD:7(@/2!`9VQI8F-X>%]P<F5F:7AD:7)`
M"F=L:6)C>'A?<W)C9&ER(#T@0&=L:6)C>'A?<W)C9&ER0`IG;&EB8WAX7W1O
M;VQE>&5C9&ER(#T@0&=L:6)C>'A?=&]O;&5X96-D:7)`"F=L:6)C>'A?=&]O
M;&5X96-L:6)D:7(@/2!`9VQI8F-X>%]T;V]L97AE8VQI8F1I<D`*9WAX7VEN
M8VQU9&5?9&ER(#T@0&=X>%]I;F-L=61E7V1I<D`*:&]S="`]($!H;W-T0`IH
M;W-T7V%L:6%S(#T@0&AO<W1?86QI87-`"FAO<W1?8W!U(#T@0&AO<W1?8W!U
M0`IH;W-T7V]S(#T@0&AO<W1?;W-`"FAO<W1?=F5N9&]R(#T@0&AO<W1?=F5N
M9&]R0`IH=&UL9&ER(#T@0&AT;6QD:7)`"FEN8VQU9&5D:7(@/2!`:6YC;'5D
M961I<D`*:6YF;V1I<B`]($!I;F9O9&ER0`II;G-T86QL7W-H(#T@0&EN<W1A
M;&Q?<VA`"FQI8F1I<B`]($!L:6)D:7)`"FQI8F5X96-D:7(@/2!`;&EB97AE
M8V1I<D`*;&EB=&]O;%]615)324].(#T@0&QI8G1O;VQ?5D524TE/3D`*;&]C
M86QE9&ER(#T@0&QO8V%L961I<D`*;&]C86QS=&%T961I<B`]($!L;V-A;'-T
M871E9&ER0`IL=%]H;W-T7V9L86=S(#T@0&QT7VAO<W1?9FQA9W-`"FUA;F1I
M<B`]($!M86YD:7)`"FUK9&ER7W`@/2!`;6MD:7)?<$`*;75L=&E?8F%S961I
M<B`]($!M=6QT:5]B87-E9&ER0`IO;&1I;F-L=61E9&ER(#T@0&]L9&EN8VQU
M9&5D:7)`"G!D9F1I<B`]($!P9&9D:7)`"G!O<G1?<W!E8VEF:6-?<WEM8F]L
M7V9I;&5S(#T@0'!O<G1?<W!E8VEF:6-?<WEM8F]L7V9I;&5S0`IP<F5F:7@@
M/2!`<')E9FEX0`IP<F]G<F%M7W1R86YS9F]R;5]N86UE(#T@0'!R;V=R86U?
M=')A;G-F;W)M7VYA;65`"G!S9&ER(#T@0'!S9&ER0`IP>71H;VY?;6]D7V1I
M<B`]($!P>71H;VY?;6]D7V1I<D`*<V)I;F1I<B`]($!S8FEN9&ER0`IS:&%R
M961S=&%T961I<B`]($!S:&%R961S=&%T961I<D`*<W)C9&ER(#T@0'-R8V1I
M<D`*<WES8V]N9F1I<B`]($!S>7-C;VYF9&ER0`IT87)G970@/2!`=&%R9V5T
M0`IT87)G971?86QI87,@/2!`=&%R9V5T7V%L:6%S0`IT87)G971?8W!U(#T@
M0'1A<F=E=%]C<'5`"G1A<F=E=%]O<R`]($!T87)G971?;W-`"G1A<F=E=%]V
M96YD;W(@/2!`=&%R9V5T7W9E;F1O<D`*=&AR96%D7VAE861E<B`]($!T:')E
M861?:&5A9&5R0`IT;W!?8G5I;&1?<')E9FEX(#T@0'1O<%]B=6EL9%]P<F5F
M:7A`"G1O<%]B=6EL9&1I<B`]($!T;W!?8G5I;&1D:7)`"G1O<%]S<F-D:7(@
M/2!`=&]P7W-R8V1I<D`*=&]P;&5V96Q?8G5I;&1D:7(@/2!`=&]P;&5V96Q?
M8G5I;&1D:7)`"G1O<&QE=F5L7W-R8V1I<B`]($!T;W!L979E;%]S<F-D:7)`
M"@HC($UA>2!B92!U<V5D(&)Y('9A<FEO=7,@<W5B<W1I='5T:6]N('9A<FEA
M8FQE<RX*9V-C7W9E<G-I;VX@.CT@)"AS:&5L;"!`9V5T7V=C8U]B87-E7W9E
M<D`@)"AT;W!?<W)C9&ER*2\N+B]G8V,O0D%312U615(I"DU!24Y47T-(05)3
M150@/2!L871I;C$*;6MI;G-T86QL9&ER<R`]("0H4TA%3$PI("0H=&]P;&5V
M96Q?<W)C9&ER*2]M:VEN<W1A;&QD:7)S"E!71%]#3TU-04Y$(#T@)"1[4%=$
M0TU$+7!W9'T*4U1!35`@/2!E8VAO('1I;65S=&%M<"`^"G1O;VQE>&5C9&ER
M(#T@)"AG;&EB8WAX7W1O;VQE>&5C9&ER*0IT;V]L97AE8VQI8F1I<B`]("0H
M9VQI8F-X>%]T;V]L97AE8VQI8F1I<BD*0$5.04),15]715)23U)?1D%,4T5`
M5T524D]27T9,04<@/2`*0$5.04),15]715)23U)?5%)514!715)23U)?1DQ!
M1R`]("U797)R;W(*0$5.04),15]%6%1%4DY?5$5-4$Q!5$5?1D%,4T5`6%1%
M35!,051%7T9,04=3(#T@"D!%3D%"3$5?15A415).7U1%35!,051%7U12545`
M6%1%35!,051%7T9,04=3(#T@+69N;RUI;7!L:6-I="UT96UP;&%T97,*"B,@
M5&AE<V4@8FET<R!A<F4@86QL(&9I9W5R960@;W5T(&9R;VT@8V]N9FEG=7)E
M+B`@3&]O:R!I;B!A8VEN8VQU9&4N;30*(R!O<B!C;VYF:6=U<F4N86,@=&\@
M<V5E(&AO=R!T:&5Y(&%R92!S970N("!3964@1TQ)0D-86%]%6%!/4E1?1DQ!
M1U,N"D-/3D9)1U]#6%A&3$%'4R`](%P*"20H4T5#5$E/3E]&3$%'4RD@)"A(
M5T-!4%]#1DQ!1U,I("UF<F%N9&]M+7-E960])$`*"E=!4DY?0UA81DQ!1U,@
M/2!<"@DD*%=!4DY?1DQ!1U,I("0H5T524D]27T9,04<I("UF9&EA9VYO<W1I
M8W,M<VAO=RUL;V-A=&EO;CUO;F-E(`H*"B,@+4DO+40@9FQA9W,@=&\@<&%S
M<R!W:&5N(&-O;7!I;&EN9RX*04U?0U!01DQ!1U,@/2`D*$=,24)#6%A?24Y#
M3%5$15,I("0H0U!01DQ!1U,I"D!%3D%"3$5?4%E42$].1$E27T9!3%-%0'!Y
M=&AO;F1I<B`]("0H9&%T861I<BDO9V-C+20H9V-C7W9E<G-I;VXI+W!Y=&AO
M;@I`14Y!0DQ%7U!95$A/3D1)4E]44E5%0'!Y=&AO;F1I<B`]("0H<')E9FEX
M*2\D*'!Y=&AO;E]M;V1?9&ER*0IN;V)A<V5?<'ET:&]N7T1!5$$@/2!<"B`@
M("!L:6)S=&1C>'@O=C8O<')I;G1E<G,N<'D@7`H@("`@;&EB<W1D8WAX+W8V
M+WAM971H;V1S+G!Y(%P*("`@(&QI8G-T9&-X>"]V-B]?7VEN:71?7RYP>2!<
M"B`@("!L:6)S=&1C>'@O7U]I;FET7U\N<'D*"F%L;#H@86QL+6%M"@HN4U5&
M1DE815,Z"B0H<W)C9&ER*2]-86ME9FEL92YI;CH@0$U!24Y404E.15)?34]$
M15]44E5%0"`D*'-R8V1I<BDO36%K969I;&4N86T@)"AT;W!?<W)C9&ER*2]F
M<F%G;65N="YA;2`D*&%M7U]C;VYF:6=U<F5?9&5P<RD*"4!F;W(@9&5P(&EN
M("0_.R!D;R!<"@D@(&-A<V4@)R0H86U?7V-O;F9I9W5R95]D97!S*2<@:6X@
M7`H)("`@("HD)&1E<"HI(%P*"2`@("`@("@@8V0@)"AT;W!?8G5I;&1D:7(I
M("8F("0H34%+12D@)"A!35]-04M%1DQ!1U,I(&%M+2UR969R97-H("D@7`H)
M("`@("`@("`F)B![(&EF('1E<W0@+68@)$`[('1H96X@97AI="`P.R!E;'-E
M(&)R96%K.R!F:3L@?3L@7`H)("`@("`@97AI="`Q.SL@7`H)("!E<V%C.R!<
M"@ED;VYE.R!<"@EE8VAO("<@8V0@)"AT;W!?<W)C9&ER*2`F)B`D*$%55$]-
M04M%*2`M+69O<F5I9VX@+2UI9VYO<F4M9&5P<R!P>71H;VXO36%K969I;&4G
M.R!<"@DD*&%M7U]C9"D@)"AT;W!?<W)C9&ER*2`F)B!<"@D@("0H05543TU!
M2T4I("TM9F]R96EG;B`M+6EG;F]R92UD97!S('!Y=&AO;B]-86ME9FEL90I-
M86ME9FEL93H@)"AS<F-D:7(I+TUA:V5F:6QE+FEN("0H=&]P7V)U:6QD9&ER
M*2]C;VYF:6<N<W1A='5S"@E`8V%S92`G)#\G(&EN(%P*"2`@*F-O;F9I9RYS
M=&%T=7,J*2!<"@D@("`@8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H34%+12D@
M)"A!35]-04M%1DQ!1U,I(&%M+2UR969R97-H.SL@7`H)("`J*2!<"@D@("`@
M96-H;R`G(&-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*%-(14Q,*2`N+V-O;F9I
M9RYS=&%T=7,@)"AS=6)D:7(I+R1`("0H86U?7V1E<&9I;&5S7VUA>6)E*2<[
M(%P*"2`@("!C9"`D*'1O<%]B=6EL9&1I<BD@)B8@)"A32$5,3"D@+B]C;VYF
M:6<N<W1A='5S("0H<W5B9&ER*2\D0"`D*&%M7U]D97!F:6QE<U]M87EB92D[
M.R!<"@EE<V%C.PHD*'1O<%]S<F-D:7(I+V9R86=M96YT+F%M("0H86U?7V5M
M<'1Y*3H*"B0H=&]P7V)U:6QD9&ER*2]C;VYF:6<N<W1A='5S.B`D*'1O<%]S
M<F-D:7(I+V-O;F9I9W5R92`D*$-/3D9)1U]35$%455-?1$5014Y$14Y#2453
M*0H)8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H34%+12D@)"A!35]-04M%1DQ!
M1U,I(&%M+2UR969R97-H"@HD*'1O<%]S<F-D:7(I+V-O;F9I9W5R93H@0$U!
M24Y404E.15)?34]$15]44E5%0"`D*&%M7U]C;VYF:6=U<F5?9&5P<RD*"6-D
M("0H=&]P7V)U:6QD9&ER*2`F)B`D*$U!2T4I("0H04U?34%+149,04=3*2!A
M;2TM<F5F<F5S:`HD*$%#3$]#04Q?330I.B!`34%)3E1!24Y%4E]-3T1%7U12
M545`("0H86U?7V%C;&]C86Q?;31?9&5P<RD*"6-D("0H=&]P7V)U:6QD9&ER
M*2`F)B`D*$U!2T4I("0H04U?34%+149,04=3*2!A;2TM<F5F<F5S:`HD*&%M
M7U]A8VQO8V%L7VTT7V1E<',I.@H*;6]S=&QY8VQE86XM;&EB=&]O;#H*"2UR
M;2`M9B`J+FQO"@IC;&5A;BUL:6)T;V]L.@H)+7)M("UR9B`N;&EB<R!?;&EB
M<PII;G-T86QL+6YO8F%S95]P>71H;VY$051!.B`D*&YO8F%S95]P>71H;VY?
M1$%402D*"4`D*$Y/4DU!3%])3E-404Q,*0H)0&QI<W0])R0H;F]B87-E7W!Y
M=&AO;E]$051!*2<[('1E<W0@+6X@(B0H<'ET:&]N9&ER*2(@?'P@;&ES=#T[
M(%P*"6EF('1E<W0@+6X@(B0D;&ES="([('1H96X@7`H)("!E8VAO("(@)"A-
M2T1)4E]0*2`G)"A$15-41$E2*20H<'ET:&]N9&ER*2<B.R!<"@D@("0H34M$
M25)?4"D@(B0H1$535$1)4BDD*'!Y=&AO;F1I<BDB('Q\(&5X:70@,3L@7`H)
M9FD[(%P*"20H86U?7VYO8F%S95]L:7-T*2!\('=H:6QE(')E860@9&ER(&9I
M;&5S.R!D;R!<"@D@('AF:6QE<ST[(&9O<B!F:6QE(&EN("0D9FEL97,[(&1O
M(%P*"2`@("!I9B!T97-T("UF("(D)&9I;&4B.R!T:&5N('AF:6QE<STB)"1X
M9FEL97,@)"1F:6QE(CL@7`H)("`@(&5L<V4@>&9I;&5S/2(D)'AF:6QE<R`D
M*'-R8V1I<BDO)"1F:6QE(CL@9FD[(&1O;F4[(%P*"2`@=&5S="`M>B`B)"1X
M9FEL97,B('Q\('L@7`H)("`@('1E<W0@(G@D)&1I<B(@/2!X+B!\?"![(%P*
M"2`@("`@(&5C:&\@(B`D*$U+1$E27U`I("<D*$1%4U1$25(I)"AP>71H;VYD
M:7(I+R0D9&ER)R([(%P*"2`@("`@("0H34M$25)?4"D@(B0H1$535$1)4BDD
M*'!Y=&AO;F1I<BDO)"1D:7(B.R!].R!<"@D@("`@96-H;R`B("0H24Y35$%,
M3%]$051!*2`D)'AF:6QE<R`G)"A$15-41$E2*20H<'ET:&]N9&ER*2\D)&1I
M<B<B.R!<"@D@("`@)"A)3E-404Q,7T1!5$$I("0D>&9I;&5S("(D*$1%4U1$
M25(I)"AP>71H;VYD:7(I+R0D9&ER(B!\?"!E>&ET("0D/SL@?3L@7`H)9&]N
M90H*=6YI;G-T86QL+6YO8F%S95]P>71H;VY$051!.@H)0"0H3D]234%,7U5.
M24Y35$%,3"D*"4!L:7-T/2<D*&YO8F%S95]P>71H;VY?1$%402DG.R!T97-T
M("UN("(D*'!Y=&AO;F1I<BDB('Q\(&QI<W0].R!<"@DD*&%M7U]N;V)A<V5?
M<W1R:7!?<V5T=7`I.R!F:6QE<SU@)"AA;5]?;F]B87-E7W-T<FEP*6`[(%P*
M"61I<CTG)"A$15-41$E2*20H<'ET:&]N9&ER*2<[("0H86U?7W5N:6YS=&%L
M;%]F:6QE<U]F<F]M7V1I<BD*=&%G<R!404=3.@H*8W1A9W,@0U1!1U,Z"@IC
M<V-O<&4@8W-C;W!E;&ES=#H*"F-H96-K+6%M.B!A;&PM86T*8VAE8VLZ(&-H
M96-K+6%M"F%L;"UA;3H@36%K969I;&4@)"A$051!*2!A;&PM;&]C86P*:6YS
M=&%L;&1I<G,Z"@EF;W(@9&ER(&EN("(D*$1%4U1$25(I)"AP>71H;VYD:7(I
M(CL@9&\@7`H)("!T97-T("UZ("(D)&1I<B(@?'P@)"A-2T1)4E]0*2`B)"1D
M:7(B.R!<"@ED;VYE"FEN<W1A;&PZ(&EN<W1A;&PM86T*:6YS=&%L;"UE>&5C
M.B!I;G-T86QL+65X96,M86T*:6YS=&%L;"UD871A.B!I;G-T86QL+61A=&$M
M86T*=6YI;G-T86QL.B!U;FEN<W1A;&PM86T*"FEN<W1A;&PM86TZ(&%L;"UA
M;0H)0"0H34%+12D@)"A!35]-04M%1DQ!1U,I(&EN<W1A;&PM97AE8RUA;2!I
M;G-T86QL+61A=&$M86T*"FEN<W1A;&QC:&5C:SH@:6YS=&%L;&-H96-K+6%M
M"FEN<W1A;&PM<W1R:7`Z"@EI9B!T97-T("UZ("<D*%-44DE0*2<[('1H96X@
M7`H)("`D*$U!2T4I("0H04U?34%+149,04=3*2!)3E-404Q,7U!23T=204T]
M(B0H24Y35$%,3%]35%))4%]04D]'4D%-*2(@7`H)("`@(&EN<W1A;&Q?<VA?
M4%)/1U)!33TB)"A)3E-404Q,7U-44DE07U!23T=204TI(B!)3E-404Q,7U-4
M4DE07T9,04<]+7,@7`H)("`@("`@:6YS=&%L;#L@7`H)96QS92!<"@D@("0H
M34%+12D@)"A!35]-04M%1DQ!1U,I($E.4U1!3$Q?4%)/1U)!33TB)"A)3E-4
M04Q,7U-44DE07U!23T=204TI(B!<"@D@("`@:6YS=&%L;%]S:%]04D]'4D%-
M/2(D*$E.4U1!3$Q?4U1225!?4%)/1U)!32DB($E.4U1!3$Q?4U1225!?1DQ!
M1STM<R!<"@D@("`@(DE.4U1!3$Q?4%)/1U)!35]%3E8]4U1225!04D]'/2<D
M*%-44DE0*2<B(&EN<W1A;&P[(%P*"69I"FUO<W1L>6-L96%N+6=E;F5R:6,Z
M"@IC;&5A;BUG96YE<FEC.@H*9&ES=&-L96%N+6=E;F5R:6,Z"@DM=&5S="`M
M>B`B)"A#3TY&24=?0TQ%04Y?1DE,15,I(B!\?"!R;2`M9B`D*$-/3D9)1U]#
M3$5!3E]&24Q%4RD*"2UT97-T("X@/2`B)"AS<F-D:7(I(B!\?"!T97-T("UZ
M("(D*$-/3D9)1U]#3$5!3E]64$%42%]&24Q%4RDB('Q\(')M("UF("0H0T].
M1DE'7T-,14%.7U90051(7T9)3$53*0H*;6%I;G1A:6YE<BUC;&5A;BUG96YE
M<FEC.@H)0&5C:&\@(E1H:7,@8V]M;6%N9"!I<R!I;G1E;F1E9"!F;W(@;6%I
M;G1A:6YE<G,@=&\@=7-E(@H)0&5C:&\@(FET(&1E;&5T97,@9FEL97,@=&AA
M="!M87D@<F5Q=6ER92!S<&5C:6%L('1O;VQS('1O(')E8G5I;&0N(@IC;&5A
M;CH@8VQE86XM86T*"F-L96%N+6%M.B!C;&5A;BUG96YE<FEC(&-L96%N+6QI
M8G1O;VP@;6]S=&QY8VQE86XM86T*"F1I<W1C;&5A;CH@9&ES=&-L96%N+6%M
M"@DM<FT@+68@36%K969I;&4*9&ES=&-L96%N+6%M.B!C;&5A;BUA;2!D:7-T
M8VQE86XM9V5N97)I8PH*9'9I.B!D=FDM86T*"F1V:2UA;3H*"FAT;6PZ(&AT
M;6PM86T*"FAT;6PM86TZ"@II;F9O.B!I;F9O+6%M"@II;F9O+6%M.@H*:6YS
M=&%L;"UD871A+6%M.B!I;G-T86QL+61A=&$M;&]C86P@:6YS=&%L;"UN;V)A
M<V5?<'ET:&]N1$%400H*:6YS=&%L;"UD=FDZ(&EN<W1A;&PM9'9I+6%M"@II
M;G-T86QL+61V:2UA;3H*"FEN<W1A;&PM97AE8RUA;3H*"FEN<W1A;&PM:'1M
M;#H@:6YS=&%L;"UH=&UL+6%M"@II;G-T86QL+6AT;6PM86TZ"@II;G-T86QL
M+6EN9F\Z(&EN<W1A;&PM:6YF;RUA;0H*:6YS=&%L;"UI;F9O+6%M.@H*:6YS
M=&%L;"UM86XZ"@II;G-T86QL+7!D9CH@:6YS=&%L;"UP9&8M86T*"FEN<W1A
M;&PM<&1F+6%M.@H*:6YS=&%L;"UP<SH@:6YS=&%L;"UP<RUA;0H*:6YS=&%L
M;"UP<RUA;3H*"FEN<W1A;&QC:&5C:RUA;3H*"FUA:6YT86EN97(M8VQE86XZ
M(&UA:6YT86EN97(M8VQE86XM86T*"2UR;2`M9B!-86ME9FEL90IM86EN=&%I
M;F5R+6-L96%N+6%M.B!D:7-T8VQE86XM86T@;6%I;G1A:6YE<BUC;&5A;BUG
M96YE<FEC"@IM;W-T;'EC;&5A;CH@;6]S=&QY8VQE86XM86T*"FUO<W1L>6-L
M96%N+6%M.B!M;W-T;'EC;&5A;BUG96YE<FEC(&UO<W1L>6-L96%N+6QI8G1O
M;VP*"G!D9CH@<&1F+6%M"@IP9&8M86TZ"@IP<SH@<',M86T*"G!S+6%M.@H*
M=6YI;G-T86QL+6%M.B!U;FEN<W1A;&PM;F]B87-E7W!Y=&AO;D1!5$$*"BY-
M04M%.B!I;G-T86QL+6%M(&EN<W1A;&PM<W1R:7`*"BY02$].63H@86QL(&%L
M;"UA;2!A;&PM;&]C86P@8VAE8VL@8VAE8VLM86T@8VQE86X@8VQE86XM9V5N
M97)I8R!<"@EC;&5A;BUL:6)T;V]L(&-S8V]P96QI<W0M86T@8W1A9W,M86T@
M9&ES=&-L96%N(%P*"61I<W1C;&5A;BUG96YE<FEC(&1I<W1C;&5A;BUL:6)T
M;V]L(&1V:2!D=FDM86T@:'1M;"!H=&UL+6%M(%P*"6EN9F\@:6YF;RUA;2!I
M;G-T86QL(&EN<W1A;&PM86T@:6YS=&%L;"UD871A(&EN<W1A;&PM9&%T82UA
M;2!<"@EI;G-T86QL+61A=&$M;&]C86P@:6YS=&%L;"UD=FD@:6YS=&%L;"UD
M=FDM86T@:6YS=&%L;"UE>&5C(%P*"6EN<W1A;&PM97AE8RUA;2!I;G-T86QL
M+6AT;6P@:6YS=&%L;"UH=&UL+6%M(&EN<W1A;&PM:6YF;R!<"@EI;G-T86QL
M+6EN9F\M86T@:6YS=&%L;"UM86X@:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%4
M02!<"@EI;G-T86QL+7!D9B!I;G-T86QL+7!D9BUA;2!I;G-T86QL+7!S(&EN
M<W1A;&PM<',M86T@7`H):6YS=&%L;"US=')I<"!I;G-T86QL8VAE8VL@:6YS
M=&%L;&-H96-K+6%M(&EN<W1A;&QD:7)S(%P*"6UA:6YT86EN97(M8VQE86X@
M;6%I;G1A:6YE<BUC;&5A;BUG96YE<FEC(&UO<W1L>6-L96%N(%P*"6UO<W1L
M>6-L96%N+6=E;F5R:6,@;6]S=&QY8VQE86XM;&EB=&]O;"!P9&8@<&1F+6%M
M('!S('!S+6%M(%P*"71A9W,M86T@=6YI;G-T86QL('5N:6YS=&%L;"UA;2!U
M;FEN<W1A;&PM;F]B87-E7W!Y=&AO;D1!5$$*"BY04D5#24]54SH@36%K969I
M;&4*"@IA;&PM;&]C86PZ(&=D8BYP>0H*9V1B+G!Y.B!H;V]K+FEN($UA:V5F
M:6QE"@ES960@+64@)W,L0'!Y=&AO;F1I<D`L)"AP>71H;VYD:7(I+"<@7`H)
M("`@("UE("=S+$!T;V]L97AE8VQI8F1I<D`L)"AT;V]L97AE8VQI8F1I<BDL
M)R`\("0H<W)C9&ER*2]H;V]K+FEN(#X@)$`*"FEN<W1A;&PM9&%T82UL;V-A
M;#H@9V1B+G!Y"@E`)"AM:V1I<E]P*2`D*$1%4U1$25(I)"AT;V]L97AE8VQI
M8F1I<BD*"4!H97)E/6!P=V1@.R!C9"`D*$1%4U1$25(I)"AT;V]L97AE8VQI
M8F1I<BD[(%P*"2`@9F]R(&9I;&4@:6X@;&EB<W1D8RLK+BH[(&1O(%P*"2`@
M("!C87-E("0D9FEL92!I;B!<"@D@("`@("`J+6=D8BYP>2D@.SL@7`H)("`@
M("`@*BYL82D@.SL@7`H)("`@("`@*BD@:68@=&5S="`M:"`D)&9I;&4[('1H
M96X@7`H)("`@("`@("`@("!C;VYT:6YU93L@7`H)("`@("`@("`@9FD[(%P*
M"2`@("`@("`@(&QI8FYA;64])"1F:6QE.SL@7`H)("`@(&5S86,[(%P*"2`@
M9&]N93L@7`H)8V0@)"1H97)E.R!<"@EE8VAO("(@)"A)3E-404Q,7T1!5$$I
M(&=D8BYP>2`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BDO)"1L:6)N86UE
M+6=D8BYP>2([(%P*"20H24Y35$%,3%]$051!*2!G9&(N<'D@)"A$15-41$E2
M*20H=&]O;&5X96-L:6)D:7(I+R0D;&EB;F%M92UG9&(N<'D*"B,@5&5L;"!V
M97)S:6]N<R!;,RXU.2PS+C8S*2!O9B!'3E4@;6%K92!T;R!N;W0@97AP;W)T
M(&%L;"!V87)I86)L97,N"B,@3W1H97)W:7-E(&$@<WES=&5M(&QI;6ET("AF
M;W(@4WES5B!A="!L96%S="D@;6%Y(&)E(&5X8V5E9&5D+@HN3D]%6%!/4E0Z
M"@``````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
C````````````````````````````````````````````````
`
end
SHAR_EOF
  (set 20 20 08 08 09 35 15 'share-gdb.tar'
   eval "${shar_touch}") && \
  chmod 0664 'share-gdb.tar'
if test $? -ne 0
then ${echo} "restore of share-gdb.tar failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'share-gdb.tar': 'MD5 check failed'
       ) << \SHAR_EOF
99214e3d112d3fd3a7fc3ad5a8b0abf0  share-gdb.tar
SHAR_EOF

else
test `LC_ALL=C wc -c < 'share-gdb.tar'` -ne 143360 && \
  ${echo} "restoration warning:  size of 'share-gdb.tar' is not 143360"
  fi
fi
# ============= tmux-256color.tinfo ==============
if test -n "${keep_file}" && test -f 'tmux-256color.tinfo'
then
${echo} "x - SKIPPING tmux-256color.tinfo (file already exists)"

else
${echo} "x - extracting tmux-256color.tinfo (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'tmux-256color.tinfo' &&
#       Reconstructed via infocmp from file: /usr/share/terminfo/74/tmux-256color
tmux-256color|tmux with 256 colors,
X        am, hs, km, mir, msgr, xenl,
X        colors#0x100, cols#80, it#8, lines#24, pairs#0x7fff,
X        acsc=++\,\,--..00``aaffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~,
X        bel=^G, blink=\E[5m, bold=\E[1m, cbt=\E[Z, civis=\E[?25l,
X        clear=\E[H\E[J, cnorm=\E[34h\E[?25h, cr=\r,
X        csr=\E[%i%p1%d;%p2%dr, cub=\E[%p1%dD, cub1=^H,
X        cud=\E[%p1%dB, cud1=\n, cuf=\E[%p1%dC, cuf1=\E[C,
X        cup=\E[%i%p1%d;%p2%dH, cuu=\E[%p1%dA, cuu1=\EM,
X        cvvis=\E[34l, dch=\E[%p1%dP, dch1=\E[P, dim=\E[2m,
X        dl=\E[%p1%dM, dl1=\E[M, dsl=\E]0;\007, ed=\E[J, el=\E[K,
X        el1=\E[1K, enacs=\E(B\E)0, flash=\Eg, fsl=^G, home=\E[H,
X        ht=^I, hts=\EH, ich=\E[%p1%d@, il=\E[%p1%dL, il1=\E[L,
X        ind=\n, is2=\E)0, kDC=\E[3;2~, kEND=\E[1;2F, kHOM=\E[1;2H,
X        kIC=\E[2;2~, kLFT=\E[1;2D, kNXT=\E[6;2~, kPRV=\E[5;2~,
X        kRIT=\E[1;2C, kbs=^H, kcbt=\E[Z, kcub1=\EOD, kcud1=\EOB,
X        kcuf1=\EOC, kcuu1=\EOA, kdch1=\E[3~, kend=\E[4~, kf1=\EOP,
X        kf10=\E[21~, kf11=\E[23~, kf12=\E[24~, kf13=\E[1;2P,
X        kf14=\E[1;2Q, kf15=\E[1;2R, kf16=\E[1;2S, kf17=\E[15;2~,
X        kf18=\E[17;2~, kf19=\E[18;2~, kf2=\EOQ, kf20=\E[19;2~,
X        kf21=\E[20;2~, kf22=\E[21;2~, kf23=\E[23;2~,
X        kf24=\E[24;2~, kf25=\E[1;5P, kf26=\E[1;5Q, kf27=\E[1;5R,
X        kf28=\E[1;5S, kf29=\E[15;5~, kf3=\EOR, kf30=\E[17;5~,
X        kf31=\E[18;5~, kf32=\E[19;5~, kf33=\E[20;5~,
X        kf34=\E[21;5~, kf35=\E[23;5~, kf36=\E[24;5~,
X        kf37=\E[1;6P, kf38=\E[1;6Q, kf39=\E[1;6R, kf4=\EOS,
X        kf40=\E[1;6S, kf41=\E[15;6~, kf42=\E[17;6~,
X        kf43=\E[18;6~, kf44=\E[19;6~, kf45=\E[20;6~,
X        kf46=\E[21;6~, kf47=\E[23;6~, kf48=\E[24;6~,
X        kf49=\E[1;3P, kf5=\E[15~, kf50=\E[1;3Q, kf51=\E[1;3R,
X        kf52=\E[1;3S, kf53=\E[15;3~, kf54=\E[17;3~,
X        kf55=\E[18;3~, kf56=\E[19;3~, kf57=\E[20;3~,
X        kf58=\E[21;3~, kf59=\E[23;3~, kf6=\E[17~, kf60=\E[24;3~,
X        kf61=\E[1;4P, kf62=\E[1;4Q, kf63=\E[1;4R, kf7=\E[18~,
X        kf8=\E[19~, kf9=\E[20~, khome=\E[1~, kich1=\E[2~,
X        kind=\E[1;2B, kmous=\E[M, knp=\E[6~, kpp=\E[5~,
X        kri=\E[1;2A, nel=\EE, op=\E[39;49m, rc=\E8, rev=\E[7m,
X        ri=\EM, ritm=\E[23m, rmacs=^O, rmcup=\E[?1049l, rmir=\E[4l,
X        rmkx=\E[?1l\E>, rmso=\E[27m, rmul=\E[24m,
X        rs2=\Ec\E[?1000l\E[?25h, sc=\E7,
X        setab=\E[%?%p1%{8}%<%t4%p1%d%e%p1%{16}%<%t10%p1%{8}%-%d%e48;5;%p1%d%;m,
X        setaf=\E[%?%p1%{8}%<%t3%p1%d%e%p1%{16}%<%t9%p1%{8}%-%d%e38;5;%p1%d%;m,
X        sgr=\E[0%?%p6%t;1%;%?%p1%t;3%;%?%p2%t;4%;%?%p3%t;7%;%?%p4%t;5%;%?%p5%t;2%;m%?%p9%t\016%e\017%;,
X        sgr0=\E[m\017, sitm=\E[3m, smacs=^N, smcup=\E[?1049h,
X        smir=\E[4h, smkx=\E[?1h\E=, smso=\E[7m, smul=\E[4m,
X        tbc=\E[3g, tsl=\E]0;,
SHAR_EOF
  (set 20 20 08 05 14 55 38 'tmux-256color.tinfo'
   eval "${shar_touch}") && \
  chmod 0664 'tmux-256color.tinfo'
if test $? -ne 0
then ${echo} "restore of tmux-256color.tinfo failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'tmux-256color.tinfo': 'MD5 check failed'
       ) << \SHAR_EOF
6ab6c2f0e9d36f696206c718d24287c3  tmux-256color.tinfo
SHAR_EOF

else
test `LC_ALL=C wc -c < 'tmux-256color.tinfo'` -ne 2836 && \
  ${echo} "restoration warning:  size of 'tmux-256color.tinfo' is not 2836"
  fi
fi
# ============= uudecode.pl ==============
if test -n "${keep_file}" && test -f 'uudecode.pl'
then
${echo} "x - SKIPPING uudecode.pl (file already exists)"

else
${echo} "x - extracting uudecode.pl (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'uudecode.pl' &&
#!/usr/bin/env perl
X
$_=<>;
m/^begin ([0-7]+) (.+)$/ or die("Unable to find header");
my ($mode,$filename) = (oct($1), $2);
X
open(my $fh, '>', $filename) or die("Unable to open: '$filename'");
binmode $fh;
while($_=<>) {
X    last if m/^end$/;
X    my $out = unpack 'u*', $_;
X    print $fh $out;
}
close($fh);
chmod $mode, $filename;
SHAR_EOF
  (set 20 20 08 05 14 55 38 'uudecode.pl'
   eval "${shar_touch}") && \
  chmod 0775 'uudecode.pl'
if test $? -ne 0
then ${echo} "restore of uudecode.pl failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'uudecode.pl': 'MD5 check failed'
       ) << \SHAR_EOF
8cc88c63f51338cd0ff71f04d846ac3a  uudecode.pl
SHAR_EOF

else
test `LC_ALL=C wc -c < 'uudecode.pl'` -ne 332 && \
  ${echo} "restoration warning:  size of 'uudecode.pl' is not 332"
  fi
fi
# ============= runcron ==============
if test -n "${keep_file}" && test -f 'runcron'
then
${echo} "x - SKIPPING runcron (file already exists)"

else
${echo} "x - extracting runcron (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'runcron' &&
#!/usr/bin/env bash
X
# Exit on any errors
set -e
X
# A function to output on stderr
function echoerr() { echo "$@" 1>&2; }
X
# Configuration
CRONDIR=~/.local/etc/cron
X
# Get this script name
script="$0"
X
# Sanity check
scriptdir="$1"
if [ -z "${scriptdir}" ]; then
X    echoerr "Usage: ${script} <directory>"
X    echoerr ""
X    echoerr "Run all scripts inside a directory."
X    exit 1
fi
X
SCRIPTDIR="${CRONDIR}/${scriptdir}"
if [ ! -d "${SCRIPTDIR}" ]; then
X    echoerr "Directory: '${SCRIPTDIR}' doesn't exist. ABORTING!"
X    exit 1
fi
X
X
# Load custom cron environment if present
if [ -e "${CRONDIR}/environ.bash" ]; then
X    source "${CRONDIR}/environ.bash"
fi
X
# Run the commands
for script in "${SCRIPTDIR}"/*
do
X    if [ -f "${script}" -a -x "${script}" ]; then
X        echo "Running script: '${script}' ..."
X        echo "---------------"
X        ( "${script}" )
X        echo -e "\f"
X    fi
done
X
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'runcron'
   eval "${shar_touch}") && \
  chmod 0775 'runcron'
if test $? -ne 0
then ${echo} "restore of runcron failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'runcron': 'MD5 check failed'
       ) << \SHAR_EOF
0b2ab5f23034f9404b7dcff31ae0e52a  runcron
SHAR_EOF

else
test `LC_ALL=C wc -c < 'runcron'` -ne 901 && \
  ${echo} "restoration warning:  size of 'runcron' is not 901"
  fi
fi
# ============= vscode-term.env ==============
if test -n "${keep_file}" && test -f 'vscode-term.env'
then
${echo} "x - SKIPPING vscode-term.env (file already exists)"

else
${echo} "x - extracting vscode-term.env (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'vscode-term.env' &&
# This is needed for terminals launched by vscode under windows
PATH="$/usr/bin:/usr/local/bin${PATH:+:${PATH}}"
export PATH
source ~/.bash_profile
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'vscode-term.env'
   eval "${shar_touch}") && \
  chmod 0664 'vscode-term.env'
if test $? -ne 0
then ${echo} "restore of vscode-term.env failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'vscode-term.env': 'MD5 check failed'
       ) << \SHAR_EOF
66b61a26ae40540d0b6d39c0d4cf6cd3  vscode-term.env
SHAR_EOF

else
test `LC_ALL=C wc -c < 'vscode-term.env'` -ne 149 && \
  ${echo} "restoration warning:  size of 'vscode-term.env' is not 149"
  fi
fi
# ============= vscode.sh ==============
if test -n "${keep_file}" && test -f 'vscode.sh'
then
${echo} "x - SKIPPING vscode.sh (file already exists)"

else
${echo} "x - extracting vscode.sh (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'vscode.sh' &&
VSCODE_HOME="${HOME}/.local/opt/vscode"
export VSCODE_HOME
PATH="${PATH}:${VSCODE_HOME}/bin"
export PATH
X
SHAR_EOF
  (set 20 20 08 05 14 55 38 'vscode.sh'
   eval "${shar_touch}") && \
  chmod 0664 'vscode.sh'
if test $? -ne 0
then ${echo} "restore of vscode.sh failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'vscode.sh': 'MD5 check failed'
       ) << \SHAR_EOF
f804ad894b9f592885bf210a856038f2  vscode.sh
SHAR_EOF

else
test `LC_ALL=C wc -c < 'vscode.sh'` -ne 106 && \
  ${echo} "restoration warning:  size of 'vscode.sh' is not 106"
  fi
fi
# ============= apt-cyg ==============
if test -n "${keep_file}" && test -f 'apt-cyg'
then
${echo} "x - SKIPPING apt-cyg (file already exists)"

else
${echo} "x - extracting apt-cyg (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'apt-cyg' &&
#!/bin/bash
# apt-cyg: install tool for Cygwin similar to debian apt-get
#
# The MIT License (MIT)
#
# Copyright (c) 2013 Trans-code Design
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
X
if [ ${BASH_VERSINFO}${BASH_VERSINFO[1]} -lt 42 ]
then
X  echo 'Bash version 4.2+ required'
X  exit
fi
X
usage="\
NAME
X  apt-cyg - package manager utility
X
SYNOPSIS
X  apt-cyg [operation] [options] [targets]
X
DESCRIPTION
X  apt-cyg is a package management utility that tracks installed packages on a
X  Cygwin system. Invoking apt-cyg involves specifying an operation with any
X  potential options and targets to operate on. A target is usually a package
X  name, file name, URL, or a search string. Targets can be provided as command
X  line arguments.
X
OPERATIONS
X  install
X    Install package(s).
X
X  remove
X    Remove package(s) from the system.
X
X  update
X    Download a fresh copy of the master package list (setup.ini) from the
X    server defined in setup.rc.
X
X  download
X    Retrieve package(s) from the server, but do not install/upgrade anything.
X
X  show
X    Display information on given package(s).
X
X  depends
X    Produce a dependency tree for a package.
X
X  rdepends
X    Produce a tree of packages that depend on the named package.
X
X  list
X    Search each locally-installed package for names that match regexp. If no
X    package names are provided in the command line, all installed packages will
X    be queried.
X
X  listall
X    This will search each package in the master package list (setup.ini) for
X    names that match regexp.
X
X  category
X    Display all packages that are members of a named category.
X
X  listfiles
X    List all files owned by a given package. Multiple packages can be specified
X    on the command line.
X
X  search
X    Search for downloaded packages that own the specified file(s). The path can
X    be relative or absolute, and one or more files can be specified.
X
X  searchall
X    Search cygwin.com to retrieve file information about packages. The provided
X    target is considered to be a filename and searchall will return the
X    package(s) which contain this file.
X
X  mirror
X    Set the mirror; a full URL to a location where the database, packages, and
X    signatures for this repository can be found. If no URL is provided, display
X    current mirror.
X
X  cache
X    Set the package cache directory. If a file is not found in cache directory,
X    it will be downloaded. Unix and Windows forms are accepted, as well as
X    absolute or regular paths. If no directory is provided, display current
X    cache.
X
OPTIONS
X  --nodeps
X    Specify this option to skip all dependency checks.
X
X  --version
X    Display version and exit.
"
X
version="\
apt-cyg version 1
X
The MIT License (MIT)
X
Copyright (c) 2005-9 Stephen Jungels
"
X
function wget {
X  if command wget -h &>/dev/null
X  then
X    command wget "$@"
X  else
X    warn wget is not installed, using lynx as fallback
X    set "${*: -1}"
X    lynx -source "$1" > "${1##*/}"
X  fi
}
X
function find-workspace {
X  # default working directory and mirror
X  
X  # work wherever setup worked last, if possible
X  cache=$(awk '
X  BEGIN {
X    RS = "\n\\<"
X    FS = "\n\t"
X  }
X  $1 == "last-cache" {
X    print $2
X  }
X  ' /etc/setup/setup.rc)
X
X  mirror=$(awk '
X  /last-mirror/ {
X    getline
X    print $1
X  }
X  ' /etc/setup/setup.rc)
X  mirrordir=$(sed '
X  s / %2f g
X  s : %3a g
X  ' <<< "$mirror")
X
X  mkdir -p "$cache/$mirrordir/$arch"
X  cd "$cache/$mirrordir/$arch"
X  if [ -e setup.ini ]
X  then
X    return 0
X  else
X    get-setup
X    return 1
X  fi
}
X
function get-setup {
X  touch setup.ini
X  mv setup.ini setup.ini-save
X  wget -N $mirror/$arch/setup.bz2
X  if [ -e setup.bz2 ]
X  then
X    bunzip2 setup.bz2
X    mv setup setup.ini
X    echo Updated setup.ini
X  else
X    echo Error updating setup.ini, reverting
X    mv setup.ini-save setup.ini
X  fi
}
X
function check-packages {
X  if [[ $pks ]]
X  then
X    return 0
X  else
X    echo No packages found.
X    return 1
X  fi
}
X
function warn {
X  printf '\e[1;31m%s\e[m\n' "$*" >&2
}
X
function apt-update {
X  if find-workspace
X  then
X    get-setup
X  fi
}
X
function apt-category {
X  check-packages
X  find-workspace
X  for pkg in "${pks[@]}"
X  do
X    awk '
X    $1 == "@" {
X      pck = $2
X    }
X    $1 == "category:" && $0 ~ query {
X      print pck
X    }
X    ' query="$pks" setup.ini
X  done
}
X
function apt-list {
X  local sbq
X  for pkg in "${pks[@]}"
X  do
X    let sbq++ && echo
X    awk 'NR>1 && $1~pkg && $0=$1' pkg="$pkg" /etc/setup/installed.db
X  done
X  let sbq && return
X  awk 'NR>1 && $0=$1' /etc/setup/installed.db
}
X
function apt-listall {
X  check-packages
X  find-workspace
X  local sbq
X  for pkg in "${pks[@]}"
X  do
X    let sbq++ && echo
X    awk '$1~pkg && $0=$1' RS='\n\n@ ' FS='\n' pkg="$pkg" setup.ini
X  done
}
X
function apt-listfiles {
X  check-packages
X  find-workspace
X  local pkg sbq
X  for pkg in "${pks[@]}"
X  do
X    (( sbq++ )) && echo
X    if [ ! -e /etc/setup/"$pkg".lst.gz ]
X    then
X      download "$pkg"
X    fi
X    gzip -cd /etc/setup/"$pkg".lst.gz
X  done
}
X
function apt-show {
X  find-workspace
X  check-packages
X  for pkg in "${pks[@]}"
X  do
X    (( notfirst++ )) && echo
X    awk '
X    $1 == query {
X      print
X      fd++
X    }
X    END {
X      if (! fd)
X        print "Unable to locate package " query
X    }
X    ' RS='\n\n@ ' FS='\n' query="$pkg" setup.ini
X  done
}
X
function apt-depends {
X  find-workspace
X  check-packages
X  for pkg in "${pks[@]}"
X  do
X    awk '
X    @include "join"
X    $1 == "@" {
X      apg = $2
X    }
X    $1 == "requires:" {
X      for (z=2; z<=NF; z++)
X        reqs[apg][z-1] = $z
X    }
X    END {
X      prpg(ENVIRON["pkg"])
X    }
X    function smartmatch(small, large,    values) {
X      for (each in large)
X        values[large[each]]
X      return small in values
X    }
X    function prpg(fpg) {
X      if (smartmatch(fpg, spath)) return
X      spath[length(spath)+1] = fpg
X      print join(spath, 1, length(spath), " > ")
X      if (isarray(reqs[fpg]))
X        for (each in reqs[fpg])
X          prpg(reqs[fpg][each])
X      delete spath[length(spath)]
X    }
X    ' setup.ini
X  done
}
X
function apt-rdepends {
X  find-workspace
X  for pkg in "${pks[@]}"
X  do
X    awk '
X    @include "join"
X    $1 == "@" {
X      apg = $2
X    }
X    $1 == "requires:" {
X      for (z=2; z<=NF; z++)
X        reqs[$z][length(reqs[$z])+1] = apg
X    }
X    END {
X      prpg(ENVIRON["pkg"])
X    }
X    function smartmatch(small, large,    values) {
X      for (each in large)
X        values[large[each]]
X      return small in values
X    }
X    function prpg(fpg) {
X      if (smartmatch(fpg, spath)) return
X      spath[length(spath)+1] = fpg
X      print join(spath, 1, length(spath), " < ")
X      if (isarray(reqs[fpg]))
X        for (each in reqs[fpg])
X          prpg(reqs[fpg][each])
X      delete spath[length(spath)]
X    }
X    ' setup.ini
X  done
}
X
function apt-download {
X  check-packages
X  find-workspace
X  local pkg sbq
X  for pkg in "${pks[@]}"
X  do
X    (( sbq++ )) && echo
X    download "$pkg"
X  done
}
X
function download {
X  local pkg digest digactual
X  pkg=$1
X  # look for package and save desc file
X
X  awk '$1 == pc' RS='\n\n@ ' FS='\n' pc=$pkg setup.ini > desc
X  if [ ! -s desc ]
X  then
X    echo Unable to locate package $pkg
X    exit 1
X  fi
X
X  # download and unpack the bz2 or xz file
X
X  # pick the latest version, which comes first
X  set -- $(awk '$1 == "install:"' desc)
X  if (( ! $# ))
X  then
X    echo 'Could not find "install" in package description: obsolete package?'
X    exit 1
X  fi
X
X  dn=$(dirname $2)
X  bn=$(basename $2)
X
X  # check the md5
X  digest=$4
X  case ${#digest} in
X   32) hash=md5sum    ;;
X  128) hash=sha512sum ;;
X  esac
X  mkdir -p "$cache/$mirrordir/$dn"
X  cd "$cache/$mirrordir/$dn"
X  if ! test -e $bn || ! $hash -c <<< "$digest $bn"
X  then
X    wget -O $bn $mirror/$dn/$bn
X    $hash -c <<< "$digest $bn" || exit
X  fi
X
X  tar tf $bn | gzip > /etc/setup/"$pkg".lst.gz
X  cd ~-
X  mv desc "$cache/$mirrordir/$dn"
X  echo $dn $bn > /tmp/dwn
}
X
function apt-search {
X  check-packages
X  echo Searching downloaded packages...
X  for pkg in "${pks[@]}"
X  do
X    key=$(type -P "$pkg" | sed s./..)
X    [[ $key ]] || key=$pkg
X    for manifest in /etc/setup/*.lst.gz
X    do
X      if gzip -cd $manifest | grep -q "$key"
X      then
X        package=$(sed '
X        s,/etc/setup/,,
X        s,.lst.gz,,
X        ' <<< $manifest)
X        echo $package
X      fi
X    done
X  done
}
X
function apt-searchall {
X  cd /tmp
X  for pkg in "${pks[@]}"
X  do
X    printf -v qs 'text=1&arch=%s&grep=%s' $arch "$pkg"
X    wget -O matches cygwin.com/cgi-bin2/package-grep.cgi?"$qs"
X    awk '
X    NR == 1 {next}
X    mc[$1]++ {next}
X    /-debuginfo-/ {next}
X    /^cygwin32-/ {next}
X    {print $1}
X    ' FS=-[[:digit:]] matches
X  done
}
X
function apt-install {
X  check-packages
X  find-workspace
X  local pkg dn bn requires wr package sbq script
X  for pkg in "${pks[@]}"
X  do
X
X  if grep -q "^$pkg " /etc/setup/installed.db
X  then
X    echo Package $pkg is already installed, skipping
X    continue
X  fi
X  (( sbq++ )) && echo
X  echo Installing $pkg
X
X  download $pkg
X  read dn bn </tmp/dwn
X  echo Unpacking...
X
X  cd "$cache/$mirrordir/$dn"
X  tar -x -C / -f $bn
X  # update the package database
X
X  awk '
X  ins != 1 && pkg < $1 {
X    print pkg, bz, 0
X    ins = 1
X  }
X  1
X  END {
X    if (ins != 1) print pkg, bz, 0
X  }
X  ' pkg="$pkg" bz=$bn /etc/setup/installed.db > /tmp/awk.$$
X  mv /etc/setup/installed.db /etc/setup/installed.db-save
X  mv /tmp/awk.$$ /etc/setup/installed.db
X
X  [ -v nodeps ] && continue
X  # recursively install required packages
X
X  requires=$(awk '$1=="requires", $0=$2' FS=': ' desc)
X  cd ~-
X  wr=0
X  if [[ $requires ]]
X  then
X    echo Package $pkg requires the following packages, installing:
X    echo $requires
X    for package in $requires
X    do
X      if grep -q "^$package " /etc/setup/installed.db
X      then
X        echo Package $package is already installed, skipping
X        continue
X      fi
X      apt-cyg install --noscripts $package || (( wr++ ))
X    done
X  fi
X  if (( wr ))
X  then
X    echo some required packages did not install, continuing
X  fi
X
X  # run all postinstall scripts
X
X  [ -v noscripts ] && continue
X  find /etc/postinstall -name '*.sh' | while read script
X  do
X    echo Running $script
X    $script
X    mv $script $script.done
X  done
X  echo Package $pkg installed
X
X  done
}
X
function apt-remove {
X  check-packages
X  cd /etc
X  cygcheck awk bash bunzip2 grep gzip mv sed tar xz > setup/essential.lst
X  for pkg in "${pks[@]}"
X  do
X
X  if ! grep -q "^$pkg " setup/installed.db
X  then
X    echo Package $pkg is not installed, skipping
X    continue
X  fi
X
X  if [ ! -e setup/"$pkg".lst.gz ]
X  then
X    warn Package manifest missing, cannot remove $pkg. Exiting
X    exit 1
X  fi
X  gzip -dk setup/"$pkg".lst.gz
X  awk '
X  NR == FNR {
X    if ($NF) ess[$NF]
X    next
X  }
X  $NF in ess {
X    exit 1
X  }
X  ' FS='[/\\\\]' setup/{essential,$pkg}.lst
X  esn=$?
X  if [ $esn = 0 ]
X  then
X    echo Removing $pkg
X    if [ -e preremove/"$pkg".sh ]
X    then
X      preremove/"$pkg".sh
X      rm preremove/"$pkg".sh
X    fi
X    mapfile dt < setup/"$pkg".lst
X    for each in ${dt[*]}
X    do
X      [ -f /$each ] && rm /$each
X    done
X    for each in ${dt[*]}
X    do
X      [ -d /$each ] && rmdir --i /$each
X    done
X    rm -f setup/"$pkg".lst.gz postinstall/"$pkg".sh.done
X    awk -i inplace '$1 != ENVIRON["pkg"]' setup/installed.db
X    echo Package $pkg removed
X  fi
X  rm setup/"$pkg".lst
X  if [ $esn = 1 ]
X  then
X    warn apt-cyg cannot remove package $pkg, exiting
X    exit 1
X  fi
X
X  done
}
X
function apt-mirror {
X  if [ "$pks" ]
X  then
X    awk -i inplace '
X    1
X    /last-mirror/ {
X      getline
X      print "\t" pks
X    }
X    ' pks="$pks" /etc/setup/setup.rc
X    echo Mirror set to "$pks".
X  else
X    awk '
X    /last-mirror/ {
X      getline
X      print $1
X    }
X    ' /etc/setup/setup.rc
X  fi
}
X
function apt-cache {
X  if [ "$pks" ]
X  then
X    vas=$(cygpath -aw "$pks")
X    awk -i inplace '
X    1
X    /last-cache/ {
X      getline
X      print "\t" vas
X    }
X    ' vas="${vas//\\/\\\\}" /etc/setup/setup.rc
X    echo Cache set to "$vas".
X  else
X    awk '
X    /last-cache/ {
X      getline
X      print $1
X    }
X    ' /etc/setup/setup.rc
X  fi
}
X
if [ -p /dev/stdin ]
then
X  mapfile -t pks
fi
X
# process options
until [ $# = 0 ]
do
X  case "$1" in
X
X    --nodeps)
X      nodeps=1
X      shift
X    ;;
X
X    --noscripts)
X      noscripts=1
X      shift
X    ;;
X
X    --version)
X      printf "$version"
X      exit
X    ;;
X
X    update)
X      command=$1
X      shift
X    ;;
X
X    list | cache  | remove | depends | listall  | download | listfiles |\
X    show | mirror | search | install | category | rdepends | searchall )
X      if [[ $command ]]
X      then
X        pks+=("$1")
X      else
X        command=$1
X      fi
X      shift
X    ;;
X
X    *)
X      pks+=("$1")
X      shift
X    ;;
X
X  esac
done
X
set -a
X
if type -t apt-$command | grep -q function
then
X  readonly arch=${HOSTTYPE/i6/x}
X  apt-$command
else
X  printf "$usage"
fi
SHAR_EOF
  (set 20 20 08 08 09 35 15 'apt-cyg'
   eval "${shar_touch}") && \
  chmod 0775 'apt-cyg'
if test $? -ne 0
then ${echo} "restore of apt-cyg failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'apt-cyg': 'MD5 check failed'
       ) << \SHAR_EOF
034378fe4711a009ee146b13e058bd48  apt-cyg
SHAR_EOF

else
test `LC_ALL=C wc -c < 'apt-cyg'` -ne 13765 && \
  ${echo} "restoration warning:  size of 'apt-cyg' is not 13765"
  fi
fi
# ============= byzanz-helper.1 ==============
if test -n "${keep_file}" && test -f 'byzanz-helper.1'
then
${echo} "x - SKIPPING byzanz-helper.1 (file already exists)"

else
${echo} "x - extracting byzanz-helper.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'byzanz-helper.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "BYZANZ-HELPER 1"
X.TH BYZANZ-HELPER 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
byzanz\-helper \- Helper script to record an X\-Window with byzanz\-record
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBbyzanz-helper\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBbyzanz-helper\fR [\fB\s-1OPTIONS\s0\fR] \fB\-o\fR \fI\s-1FILE\s0\fR
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool helps record a specific \fBX11\fR window using \fBbyzanz-record\fR. When
run, the script will ask the user to pick the desired X\-Window using the mouse.
The recording will then start for the specified duration.
X.PP
Internally the script uses \fBxwininfo\fR to obtain the position and size of the
recorded video. These parameters are not updated while the video is recorded.
It the recorded window is moved it will leave the area of recording and be
only partially visible in the resulting video.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-o\fR \fI\s-1FILE\s0\fR|\fB\-\-output\fR=\fI\s-1FILE\s0\fR" 4
X.IX Item "-o FILE|--output=FILE"
Sets the output file for the recorded video.
X.IP "\fB\-t\fR \fI\s-1DURATION\s0\fR|\fB\-\-duration\fR=\fI\s-1DURATION\s0\fR" 4
X.IX Item "-t DURATION|--duration=DURATION"
Sets the recording duration in seconds. Default is 30 seconds.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
\&\fBbyzanz\-record\fR\|(1), \fBbyzanz\-playback\fR\|(1), \fBxwininfo\fR\|(1)
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2018 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1MIT\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 15 'byzanz-helper.1'
   eval "${shar_touch}") && \
  chmod 0664 'byzanz-helper.1'
if test $? -ne 0
then ${echo} "restore of byzanz-helper.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'byzanz-helper.1': 'MD5 check failed'
       ) << \SHAR_EOF
bf0e3a39a6c8f289d644e504075f9c40  byzanz-helper.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'byzanz-helper.1'` -ne 5751 && \
  ${echo} "restoration warning:  size of 'byzanz-helper.1' is not 5751"
  fi
fi
# ============= codefmt.1 ==============
if test -n "${keep_file}" && test -f 'codefmt.1'
then
${echo} "x - SKIPPING codefmt.1 (file already exists)"

else
${echo} "x - extracting codefmt.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'codefmt.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "CODEFMT 1"
X.TH CODEFMT 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
codefmt \- Code Formatter tool
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBcodefmt\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBcodefmt\fR [\fB\s-1OPTIONS\s0\fR] [\fB\s-1FILE\s0\fR ...]
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool format tabular data into fixed size columns.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-e\fR \fIEOL-SEPARATOR\fR|\fB\-\-eol\fR=\fIEOL-SEPARATOR\fR" 4
X.IX Item "-e EOL-SEPARATOR|--eol=EOL-SEPARATOR"
Sets the end-of-line separator. Default value is: \f(CW\*(C` \e\e\*(C'\fR.
X.IP "\fB\-s\fR \fICOLUMN-SEPARATOR\fR|\fB\-\-separator\fR=\fICOLUMN-SEPARATOR\fR" 4
X.IX Item "-s COLUMN-SEPARATOR|--separator=COLUMN-SEPARATOR"
Sets the end-of-line separator. Default value is: \f(CW\*(C` \*(C'\fR.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
\&\fBfmt\fR\|(1), \fBcolumn\fR\|(1), \fBcodemv\fR\|(1)
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2019 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1GPL\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 15 'codefmt.1'
   eval "${shar_touch}") && \
  chmod 0664 'codefmt.1'
if test $? -ne 0
then ${echo} "restore of codefmt.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'codefmt.1': 'MD5 check failed'
       ) << \SHAR_EOF
354af6a34d0fc0bddd596ad7a74ea214  codefmt.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'codefmt.1'` -ne 5278 && \
  ${echo} "restoration warning:  size of 'codefmt.1' is not 5278"
  fi
fi
# ============= codemv.1 ==============
if test -n "${keep_file}" && test -f 'codemv.1'
then
${echo} "x - SKIPPING codemv.1 (file already exists)"

else
${echo} "x - extracting codemv.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'codemv.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "CODEMV 1"
X.TH CODEMV 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
codemv \- Code Mover Tool
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBcodemv\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBcodemv\fR [\fB\s-1OPTIONS\s0\fR]...
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool divert part of its input to a specified file.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-a\fR \fI\s-1FILE\s0\fR|\fB\-\-append\fR=\fI\s-1FILE\s0\fR" 4
X.IX Item "-a FILE|--append=FILE"
Sets the file where diverted input is appended. This option is mutually
exclusive with the \fB\-o\fR option.
X.IP "\fB\-c\fR|\fB\-\-copy\fR" 4
X.IX Item "-c|--copy"
Copy to stdout the whole input.
X.IP "\fB\-o\fR \fI\s-1FILE\s0\fR|\fB\-\-overwrite\fR=\fI\s-1FILE\s0\fR" 4
X.IX Item "-o FILE|--overwrite=FILE"
Sets the file overwritten by the diverted input. This option is mutually
exclusive with the \fB\-o\fR option.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
\&\fBfmt\fR\|(1), \fBcolumn\fR\|(1), \fBcodefmt\fR\|(1)
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2019 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1GPL\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 15 'codemv.1'
   eval "${shar_touch}") && \
  chmod 0664 'codemv.1'
if test $? -ne 0
then ${echo} "restore of codemv.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'codemv.1': 'MD5 check failed'
       ) << \SHAR_EOF
bbcdd621efdeffd70e96929c2a04408f  codemv.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'codemv.1'` -ne 5359 && \
  ${echo} "restoration warning:  size of 'codemv.1' is not 5359"
  fi
fi
# ============= plgen.1 ==============
if test -n "${keep_file}" && test -f 'plgen.1'
then
${echo} "x - SKIPPING plgen.1 (file already exists)"

else
${echo} "x - extracting plgen.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'plgen.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "PLGEN 1"
X.TH PLGEN 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
plgen \- Code Formatter tool
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBplgen\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBplgen\fR [\fB\s-1OPTIONS\s0\fR] \-c \fB\s-1FILE\s0\fR
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool format tabular data into fixed size columns.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-c\fR \fI\s-1FILE\s0\fR" 4
X.IX Item "-c FILE"
Sets the input file to compile.
X.IP "\fB\-o\fR \fI\s-1OUTPUT\s0\fR" 4
X.IX Item "-o OUTPUT"
Sets the output file to generate.
X.SH "INPUT FILE FORMAT"
X.IX Header "INPUT FILE FORMAT"
The input file describe a simple data record. The file format is line oriented
and should start with a header:
X.PP
X.Vb 8
\&    :class\-name: The::Class::Name
\&    :version: 0.0.2a
\&    # Some comment
\&    #
\&    # Field       Default\-Value   Item\-Type_opt
\&    field\-name\-1  \*(Aq\*(Aq
\&    field\-name\-2  []              Item::Type
\&    field\-name\-3  0
X.Ve
X.PP
The following methods are created for scalar fields:
X.IP "\fBget_field_name()\fR" 5
X.IX Item "get_field_name()"
Gets the scalar value of the field.
X.IP "set_field_name(\fI\f(CI$new_value\fI\fR)" 5
X.IX Item "set_field_name($new_value)"
Sets the scalar value of the new field.
X.PP
For array fields, the following methods are created:
X.IP "\fBcount_field_name()\fR" 5
X.IX Item "count_field_name()"
Returns the count of elements in the array.
X.IP "\fBget_field_name()\fR" 5
X.IX Item "get_field_name()"
Which returns a list.
X.IP "set_field_name(\fI\f(CI@new_values\fI\fR)" 5
X.IX Item "set_field_name(@new_values)"
Which copies the items in the internal array.
X.IP "push_field_name(\fI\f(CI@new_values\fI\fR)" 5
X.IX Item "push_field_name(@new_values)"
Which append items to the internal array.
X.IP "\fBclear_field_name()\fR" 5
X.IX Item "clear_field_name()"
Which clears the internal array.
X.IP "apply_field_name(\fIsub {...}\fR)" 5
X.IX Item "apply_field_name(sub {...})"
Which applies the sub on the array's items.
X.SH "DIAGNOSTICS"
X.IX Header "DIAGNOSTICS"
X.SH "CONFIGURATION AND ENVIRONMENT"
X.IX Header "CONFIGURATION AND ENVIRONMENT"
X.SH "DEPENDENCIES"
X.IX Header "DEPENDENCIES"
X.SH "INCOMPATIBILITIES"
X.IX Header "INCOMPATIBILITIES"
X.SH "BUGS AND LIMITATIONS"
X.IX Header "BUGS AND LIMITATIONS"
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2019 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1GPL\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 15 'plgen.1'
   eval "${shar_touch}") && \
  chmod 0664 'plgen.1'
if test $? -ne 0
then ${echo} "restore of plgen.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'plgen.1': 'MD5 check failed'
       ) << \SHAR_EOF
b98f7ac1bf09b035349305df2d1d00b2  plgen.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'plgen.1'` -ne 6704 && \
  ${echo} "restoration warning:  size of 'plgen.1' is not 6704"
  fi
fi
# ============= ffmpeg-helper.1 ==============
if test -n "${keep_file}" && test -f 'ffmpeg-helper.1'
then
${echo} "x - SKIPPING ffmpeg-helper.1 (file already exists)"

else
${echo} "x - extracting ffmpeg-helper.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'ffmpeg-helper.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "FFMPEG-HELPER 1"
X.TH FFMPEG-HELPER 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
ffmpeg\-helper \- Helper script to record an X\-Window with ffmpeg\-record
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBffmpeg-helper\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBffmpeg-helper\fR [\fB\s-1OPTIONS\s0\fR] \fB\-o\fR \fI\s-1FILE\s0\fR
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool helps record a specific \fBX11\fR window using \fBffmpeg\fR. When
run, the script will ask the user to pick the desired X\-Window using the mouse.
The recording will then start for the specified duration.
X.PP
Internally the script uses \fBxwininfo\fR to obtain the position and size of the
recorded video. These parameters are not updated while the video is recorded.
It the recorded window is moved it will leave the area of recording and be
only partially visible in the resulting video.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-o\fR \fI\s-1FILE\s0\fR|\fB\-\-output\fR=\fI\s-1FILE\s0\fR" 4
X.IX Item "-o FILE|--output=FILE"
Sets the output file for the recorded video.
X.IP "\fB\-t\fR \fI\s-1DURATION\s0\fR|\fB\-\-duration\fR=\fI\s-1DURATION\s0\fR" 4
X.IX Item "-t DURATION|--duration=DURATION"
Sets the recording duration in seconds. Default is 30 seconds.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
\&\fBffmpeg\fR\|(1), \fBxwininfo\fR\|(1)
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2018 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1MIT\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 16 'ffmpeg-helper.1'
   eval "${shar_touch}") && \
  chmod 0664 'ffmpeg-helper.1'
if test $? -ne 0
then ${echo} "restore of ffmpeg-helper.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'ffmpeg-helper.1': 'MD5 check failed'
       ) << \SHAR_EOF
6b0417e933ea3930be7b55a6b8aded2a  ffmpeg-helper.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'ffmpeg-helper.1'` -ne 5707 && \
  ${echo} "restoration warning:  size of 'ffmpeg-helper.1' is not 5707"
  fi
fi
# ============= hyper-v.1 ==============
if test -n "${keep_file}" && test -f 'hyper-v.1'
then
${echo} "x - SKIPPING hyper-v.1 (file already exists)"

else
${echo} "x - extracting hyper-v.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'hyper-v.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "HYPER-V 1"
X.TH HYPER-V 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
hyper\-v \- Starts and stop the hyper\-v windows hypervisor
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBhyper-v\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBhyper-v\fR \-\-start
X.PP
\&\fBhyper-v\fR \-\-stop
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tools enables or disables the hyper-v service on Windows 10. Note that for
the change to take effect one has to reboot the computer.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fBstart\fR" 4
X.IX Item "start"
Mark the hyper-v service as running the next time windows starts.
X.IP "\fBstop\fR" 4
X.IX Item "stop"
Mark the hyper-v service as not running the next time windows starts.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2018 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1MIT\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 16 'hyper-v.1'
   eval "${shar_touch}") && \
  chmod 0664 'hyper-v.1'
if test $? -ne 0
then ${echo} "restore of hyper-v.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'hyper-v.1': 'MD5 check failed'
       ) << \SHAR_EOF
ddca6072309e19b788ab6097fa0ce7a5  hyper-v.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'hyper-v.1'` -ne 5125 && \
  ${echo} "restoration warning:  size of 'hyper-v.1' is not 5125"
  fi
fi
# ============= msvc-shell.1 ==============
if test -n "${keep_file}" && test -f 'msvc-shell.1'
then
${echo} "x - SKIPPING msvc-shell.1 (file already exists)"

else
${echo} "x - extracting msvc-shell.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'msvc-shell.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "MSVC-SHELL 1"
X.TH MSVC-SHELL 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
msvc\-shell \- MS\-VC++ build environment shell spawner
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBmsvc-shell\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBmsvc-shell\fR [\fB\s-1OPTIONS\s0\fR] \fB\s-1VC_OPTIONS\s0\fR
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool wraps the \fBvcvarsall.bat\fR batch script provided with visual studio
to setup the build environment. Calling this script allows to spawn a shell
with the same configuration that \fBvcvarsall.bat\fR setup when called in a
windows console.
X.PP
The tool also setup a \fB\s-1VS_KIT\s0\fR environment variable in the spawned shell to
indicate the parameters that were passed to \fBvcvarsall.bat\fR.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-p\fR \fIpath/to/vcvarsall.bat\fR|\fB\-\-vcvarsall\-path\fR=\fIpath/to/vcvarsall.bat\fR" 4
X.IX Item "-p path/to/vcvarsall.bat|--vcvarsall-path=path/to/vcvarsall.bat"
Sets the path to the \fBvcvarsall.bat\fR batch script. Before Visual Studio 2017
it was possible to deduce the path to this script from the environment variable
set at install time, but this is no longer the case.
X.SH "VC_OPTIONS"
X.IX Header "VC_OPTIONS"
The \fBvcvarsall.bat\fR script accepts parameters to indicate which architecture,
platform, \s-1SDK,\s0 etc. is targeted by the environment it sets up.
X.PP
Run the script without \fB\s-1VC_OPTIONS\s0\fR to get more information in the error
message printed by \fBvcvarsall.bat\fR.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2017 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1MIT\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 16 'msvc-shell.1'
   eval "${shar_touch}") && \
  chmod 0664 'msvc-shell.1'
if test $? -ne 0
then ${echo} "restore of msvc-shell.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'msvc-shell.1': 'MD5 check failed'
       ) << \SHAR_EOF
7d7a7917fa0a92f34a7cf42a2efb4159  msvc-shell.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'msvc-shell.1'` -ne 5911 && \
  ${echo} "restoration warning:  size of 'msvc-shell.1' is not 5911"
  fi
fi
# ============= sixel2tmux.1 ==============
if test -n "${keep_file}" && test -f 'sixel2tmux.1'
then
${echo} "x - SKIPPING sixel2tmux.1 (file already exists)"

else
${echo} "x - extracting sixel2tmux.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'sixel2tmux.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "SIXEL2TMUX 1"
X.TH SIXEL2TMUX 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
sixel2tmux \- Script converting sixel input into tmux's DCS escape sequence
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fBsixel2tmux\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fBsixel2tmux\fR [\fB\s-1OPTIONS\s0\fR]
X.PP
GNUTERM=sixelgd gnuplot \-e 'plot sin(x)' | \fBsixel2tmux\fR
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool converts standard input into a \fItmux\fR specific \fB\s-1DCS\s0\fR escape sequence
and outputs it to a terminal.
X.PP
The output of the program should be directed to a terminal. In case no terminal
is specified, the script will use \fI/dev/tty\fR.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-t\fR \fI\s-1TERMINAL\s0\fR|\fB\-\-terminal\fR=\fI\s-1TERMINAL\s0\fR" 4
X.IX Item "-t TERMINAL|--terminal=TERMINAL"
Sets the terminal used to output the tmux \s-1DCS\s0 escape sequence. In case the
terminal is not specified, the default value is: \fI/dev/tty\fR.
X.Sp
The special name: '\-' means \fIstdout\fR
X.IP "\fB\-l\fR=\fI\s-1INCEPTION\s0\fR|\fB\-\-inception\-level\fR=\fI\s-1INCEPTION\s0\fR" 4
X.IX Item "-l=INCEPTION|--inception-level=INCEPTION"
Sets the \fBtmux\fR inception level. This is needed in case you connect to another
\&\fBtmux\fR session from within a \fBtmux\fR session. Default value is 0 unless the
\&\fB\s-1TMUX\s0\fR environment variable is set, in which case the default value is 1.
X.SH "ENVIRONMENT VARIABLES"
X.IX Header "ENVIRONMENT VARIABLES"
X.IP "\s-1TMUX\s0" 4
X.IX Item "TMUX"
The \fB\s-1TMUX\s0\fR environment variable is used to find out if we are running inside
a \fBtmux\fR pane.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
\&\fBxterm\fR\|(1), \fBtmux\fR\|(1)
X.IP "\fIXTerm Control Sequences\fR" 4
X.IX Item "XTerm Control Sequences"
X.Vb 1
\&    https://invisible\-island.net/xterm/ctlseqs/ctlseqs.html#h2\-Operating\-System\-Commands
X.Ve
X.IP "\fIDevice Control String Sequences\fR" 4
X.IX Item "Device Control String Sequences"
X.Vb 1
\&    https://vt100.net/docs/vt510\-rm/chapter4.html
X.Ve
X.IP "\fITMux \s-1DCS\s0 Sequences\fR" 4
X.IX Item "TMux DCS Sequences"
X.Vb 1
\&    see tmux changelog
X.Ve
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2017 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1MIT\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 16 'sixel2tmux.1'
   eval "${shar_touch}") && \
  chmod 0664 'sixel2tmux.1'
if test $? -ne 0
then ${echo} "restore of sixel2tmux.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'sixel2tmux.1': 'MD5 check failed'
       ) << \SHAR_EOF
a30059e7b6514f839accd72754e3e536  sixel2tmux.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'sixel2tmux.1'` -ne 6506 && \
  ${echo} "restoration warning:  size of 'sixel2tmux.1' is not 6506"
  fi
fi
# ============= yank.1 ==============
if test -n "${keep_file}" && test -f 'yank.1'
then
${echo} "x - SKIPPING yank.1 (file already exists)"

else
${echo} "x - extracting yank.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'yank.1' &&
X.\" Automatically generated by Pod::Man 4.11 (Pod::Simple 3.35)
X.\"
X.\" Standard preamble:
X.\" ========================================================================
X.de Sp \" Vertical space (when we can't use .PP)
X.if t .sp .5v
X.if n .sp
X..
X.de Vb \" Begin verbatim text
X.ft CW
X.nf
X.ne \\$1
X..
X.de Ve \" End verbatim text
X.ft R
X.fi
X..
X.\" Set up some character translations and predefined strings.  \*(-- will
X.\" give an unbreakable dash, \*(PI will give pi, \*(L" will give a left
X.\" double quote, and \*(R" will give a right double quote.  \*(C+ will
X.\" give a nicer C++.  Capital omega is used to do unbreakable dashes and
X.\" therefore won't be available.  \*(C` and \*(C' expand to `' in nroff,
X.\" nothing in troff, for use with C<>.
X.tr \(*W-
X.ds C+ C\v'-.1v'\h'-1p'\s-2+\h'-1p'+\s0\v'.1v'\h'-1p'
X.ie n \{\
X.    ds -- \(*W-
X.    ds PI pi
X.    if (\n(.H=4u)&(1m=24u) .ds -- \(*W\h'-12u'\(*W\h'-12u'-\" diablo 10 pitch
X.    if (\n(.H=4u)&(1m=20u) .ds -- \(*W\h'-12u'\(*W\h'-8u'-\"  diablo 12 pitch
X.    ds L" ""
X.    ds R" ""
X.    ds C` ""
X.    ds C' ""
'br\}
X.el\{\
X.    ds -- \|\(em\|
X.    ds PI \(*p
X.    ds L" ``
X.    ds R" ''
X.    ds C`
X.    ds C'
'br\}
X.\"
X.\" Escape single quotes in literal strings from groff's Unicode transform.
X.ie \n(.g .ds Aq \(aq
X.el       .ds Aq '
X.\"
X.\" If the F register is >0, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{\
X.    if \nF \{\
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{\
X.            nr % 0
X.            nr F 2
X.        \}
X.    \}
X.\}
X.rr rF
X.\"
X.\" Accent mark definitions (@(#)ms.acc 1.5 88/02/08 SMI; from UCB 4.2).
X.\" Fear.  Run.  Save yourself.  No user-serviceable parts.
X.    \" fudge factors for nroff and troff
X.if n \{\
X.    ds #H 0
X.    ds #V .8m
X.    ds #F .3m
X.    ds #[ \f1
X.    ds #] \fP
X.\}
X.if t \{\
X.    ds #H ((1u-(\\\\n(.fu%2u))*.13m)
X.    ds #V .6m
X.    ds #F 0
X.    ds #[ \&
X.    ds #] \&
X.\}
X.    \" simple accents for nroff and troff
X.if n \{\
X.    ds ' \&
X.    ds ` \&
X.    ds ^ \&
X.    ds , \&
X.    ds ~ ~
X.    ds /
X.\}
X.if t \{\
X.    ds ' \\k:\h'-(\\n(.wu*8/10-\*(#H)'\'\h"|\\n:u"
X.    ds ` \\k:\h'-(\\n(.wu*8/10-\*(#H)'\`\h'|\\n:u'
X.    ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'^\h'|\\n:u'
X.    ds , \\k:\h'-(\\n(.wu*8/10)',\h'|\\n:u'
X.    ds ~ \\k:\h'-(\\n(.wu-\*(#H-.1m)'~\h'|\\n:u'
X.    ds / \\k:\h'-(\\n(.wu*8/10-\*(#H)'\z\(sl\h'|\\n:u'
X.\}
X.    \" troff and (daisy-wheel) nroff accents
X.ds : \\k:\h'-(\\n(.wu*8/10-\*(#H+.1m+\*(#F)'\v'-\*(#V'\z.\h'.2m+\*(#F'.\h'|\\n:u'\v'\*(#V'
X.ds 8 \h'\*(#H'\(*b\h'-\*(#H'
X.ds o \\k:\h'-(\\n(.wu+\w'\(de'u-\*(#H)/2u'\v'-.3n'\*(#[\z\(de\v'.3n'\h'|\\n:u'\*(#]
X.ds d- \h'\*(#H'\(pd\h'-\w'~'u'\v'-.25m'\f2\(hy\fP\v'.25m'\h'-\*(#H'
X.ds D- D\\k:\h'-\w'D'u'\v'-.11m'\z\(hy\v'.11m'\h'|\\n:u'
X.ds th \*(#[\v'.3m'\s+1I\s-1\v'-.3m'\h'-(\w'I'u*2/3)'\s-1o\s+1\*(#]
X.ds Th \*(#[\s+2I\s-2\h'-\w'I'u*3/5'\v'-.3m'o\v'.3m'\*(#]
X.ds ae a\h'-(\w'a'u*4/10)'e
X.ds Ae A\h'-(\w'A'u*4/10)'E
X.    \" corrections for vroff
X.if v .ds ~ \\k:\h'-(\\n(.wu*9/10-\*(#H)'\s-2\u~\d\s+2\h'|\\n:u'
X.if v .ds ^ \\k:\h'-(\\n(.wu*10/11-\*(#H)'\v'-.4m'^\v'.4m'\h'|\\n:u'
X.    \" for low resolution devices (crt and lpr)
X.if \n(.H>23 .if \n(.V>19 \
\{\
X.    ds : e
X.    ds 8 ss
X.    ds o a
X.    ds d- d\h'-1'\(ga
X.    ds D- D\h'-1'\(hy
X.    ds th \o'bp'
X.    ds Th \o'LP'
X.    ds ae ae
X.    ds Ae AE
X.\}
X.rm #[ #] #H #V #F C
X.\" ========================================================================
X.\"
X.IX Title "YANK 1"
X.TH YANK 1 "2020-08-05" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
X.\" For nroff, turn off justification.  Always turn off hyphenation; it makes
X.\" way too many mistakes in technical documents.
X.if n .ad l
X.nh
X.SH "NAME"
yank \- Script converting input into OSC 5\-2 escape sequence
X.SH "SYNOPSIS"
X.IX Header "SYNOPSIS"
\&\fByank\fR \fB\-h\fR|\fB\-\-help\fR
X.PP
\&\fByank\fR [\fB\s-1OPTIONS\s0\fR]
X.PP
echo \*(L"Text To Copy\*(R" | \fByank\fR
X.SH "DESCRIPTION"
X.IX Header "DESCRIPTION"
This tool converts standard input into \fB\s-1OSC 5\-2\s0\fR escape sequence and outputs
it to a terminal. These escape sequences are interpreted by terminals to set
their \fBselection\fR buffer. For \fBXTerm\fR it means the \fBX11\fR copy/paste buffer.
X.PP
The script can used to provide seamless copy/paste capabilities between a host
and a remote session. For instance a user running \fBvim\fR through \fBtmux\fR on a
remote host connected by \fBssh\fR running on its \fBWindows\fR laptop.
X.PP
The output of the program should be directed to a terminal. In case no terminal
is specified, the script will use \fI/dev/tty\fR.
X.SH "OPTIONS"
X.IX Header "OPTIONS"
X.IP "\fB\-h\fR|\fB\-\-help\fR" 4
X.IX Item "-h|--help"
Print the usage, help and version information for this program and exit.
X.IP "\fB\-t\fR \fI\s-1TERMINAL\s0\fR|\fB\-\-terminal\fR=\fI\s-1TERMINAL\s0\fR" 4
X.IX Item "-t TERMINAL|--terminal=TERMINAL"
Sets the terminal used to output the \s-1OSC 5\-2\s0 escape sequence. In case the
terminal is not specified, the default value is: \fI/dev/tty\fR.
X.IP "\fB\-\-tmux\-tty\fR" 4
X.IX Item "--tmux-tty"
Sets the terminal used to output the \s-1OSC 5\-2\s0 escape sequence to the \fBtmux\fR pane
tty. In case the program is unable to find out \fBtmux\fR pane's tty, the value of
the \fB\-\-terminal\fR option is taken into account.
X.IP "\fB\-l\fR=\fI\s-1INCEPTION\s0\fR|\fB\-\-inception\-level\fR=\fI\s-1INCEPTION\s0\fR" 4
X.IX Item "-l=INCEPTION|--inception-level=INCEPTION"
Sets the \fBtmux\fR inception level. This is needed in case you connect to another
\&\fBtmux\fR session from within a \fBtmux\fR session. Default value is 0 unless the
\&\fB\s-1TMUX\s0\fR environment variable is set, in which case the default value is 1.
X.SH "LIMITATIONS"
X.IX Header "LIMITATIONS"
No more than 74994 bytes of data can be transmitted through the \s-1OSC 5\-2\s0 escape
sequence.
X.SH "ENVIRONMENT VARIABLES"
X.IX Header "ENVIRONMENT VARIABLES"
X.IP "\s-1TMUX\s0" 4
X.IX Item "TMUX"
The \fB\s-1TMUX\s0\fR environment variable is used to find out if we are running inside
a \fBtmux\fR pane.
X.SH "SEE ALSO"
X.IX Header "SEE ALSO"
\&\fBxterm\fR\|(1), \fBtmux\fR\|(1)
X.IP "\fIXTerm Control Sequences\fR" 4
X.IX Item "XTerm Control Sequences"
X.Vb 1
\&    https://invisible\-island.net/xterm/ctlseqs/ctlseqs.html#h2\-Operating\-System\-Commands
X.Ve
X.IP "\fIDevice Control String Sequences\fR" 4
X.IX Item "Device Control String Sequences"
X.Vb 1
\&    https://vt100.net/docs/vt510\-rm/chapter4.html
X.Ve
X.IP "\fITMux \s-1DCS\s0 Sequences\fR" 4
X.IX Item "TMux DCS Sequences"
X.Vb 1
\&    see tmux changelog
X.Ve
X.SH "AUTHOR"
X.IX Header "AUTHOR"
Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.SH "COPYRIGHT AND LICENSE"
X.IX Header "COPYRIGHT AND LICENSE"
Copyright (C) 2017 by Frederic \s-1JARDON\s0 <frederic.jardon@gmail.com>
X.PP
This program is free software; you can redistribute it and/or modify
it under the \s-1MIT\s0 license.
SHAR_EOF
  (set 20 20 08 08 09 35 16 'yank.1'
   eval "${shar_touch}") && \
  chmod 0664 'yank.1'
if test $? -ne 0
then ${echo} "restore of yank.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'yank.1': 'MD5 check failed'
       ) << \SHAR_EOF
e14a7dde69c5ba2cbea7c4e5ae66179c  yank.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'yank.1'` -ne 7189 && \
  ${echo} "restoration warning:  size of 'yank.1' is not 7189"
  fi
fi
if rm -fr ${lock_dir}
then ${echo} "x - removed lock directory ${lock_dir}."
else ${echo} "x - failed to remove lock directory ${lock_dir}."
     exit 1
fi
exit 0
SETUP_SHAR_EOF
/bin/sh setup.shar
# =============================================================================

# Make uudecode available if not present on system
if ! has_prog uudecode; then
    mv uudecode.pl uudecode
    chmod 0755 uudecode
    export PATH="${PWD}:${PATH}"
fi


# Prepare backups directory
DATE=$(date '+%Y%m%d')
HOUR=$(date '+%H%M%S')
BACKUPDIR="${PREFIX}/.backups/${DATE}/${HOUR}"
install -m 0700 -d "${BACKUPDIR}"

# Backup files
echo "shell ..."
if [ -e "${PREFIX}/.profile" ]; then
    cp -f "${PREFIX}/.profile" "${BACKUPDIR}"
fi
if [ -e "${PREFIX}/.bash_profile" ]; then
    cp -f "${PREFIX}/.bash_profile" "${BACKUPDIR}"
fi
if [ -e "${PREFIX}/.bashrc" ]; then
    cp -f "${PREFIX}/.bashrc" "${BACKUPDIR}"
fi
if [ ! -e "${PREFIX}/.path_dirs" ]; then
    cat <<DOT_PROFILE_PATHS_EOF > "${PREFIX}/.path_dirs"
# Directory path in this file are scanned by .bash_profile
# to setup the following variables:
#  - PATH
#  - LD_LIBRARY_PATH
#  - MANPATH
#  - INFOPATH
#  - PERL5LIB
#  - PKG_CONFIG_PATH

${PREFIX}/.local
${PREFIX}/.local/share/perl5
DOT_PROFILE_PATHS_EOF
fi
install -m 0644 dot_profile      "${PREFIX}/.profile"
install -m 0644 dot_bash_profile "${PREFIX}/.bash_profile"
install -m 0644 dot_bashrc       "${PREFIX}/.bashrc"

# .local setup
echo "local ..."
install -m 0755 -d "${PREFIX}/.local/bin"
install -m 0755 -d "${PREFIX}/.local/lib"
install -m 0755 -d "${PREFIX}/.local/opt"
install -m 0755 -d "${PREFIX}/.local/share"
install -m 0755 -d "${PREFIX}/.local/share/man/man1"
install -m 0755 -d "${PREFIX}/.local/var"
install -m 0755 -d "${PREFIX}/.local/var/lock"
install -m 0755 -d "${PREFIX}/.local/var/log"
install -m 0755 -d "${PREFIX}/.local/var/run"
install -m 0755 -d "${PREFIX}/.local/etc/cron"
install -m 0755 -d "${PREFIX}/.local/etc/profile.d"
install -m 0755 runcron "${PREFIX}/.local/bin"
PATH="${PATH}:${PREFIX}/.local/bin"
export PATH

# Cron setup
echo "cron ..."
if has_prog crontab; then
    install -m 0755 -d "${PREFIX}/.local/etc/cron"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/hourly"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/daily"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/daily-4"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/daily-8"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/daily-12"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/daily-16"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/daily-20"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/weekly"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/monthly"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/yearly"
    install -m 0755 -d "${PREFIX}/.local/etc/cron/commands"
    touch "${PREFIX}/.local/etc/cron/environ.bash"

    crontab -l > "${BACKUPDIR}/crontab"
    tmpcrontab=$(mktemp)
    grep -v "${PREFIX}/.local/bin/runcron" "${BACKUPDIR}/crontab" \
         > "${tmpcrontab}"
    echo "0  * * * *" "${PREFIX}/.local/bin/runcron hourly"   >> "${tmpcrontab}"
    echo "0  0 * * *" "${PREFIX}/.local/bin/runcron daily"    >> "${tmpcrontab}"
    echo "0  4 * * *" "${PREFIX}/.local/bin/runcron daily-4"  >> "${tmpcrontab}"
    echo "0  8 * * *" "${PREFIX}/.local/bin/runcron daily-8"  >> "${tmpcrontab}"
    echo "0 12 * * *" "${PREFIX}/.local/bin/runcron daily-12" >> "${tmpcrontab}"
    echo "0 16 * * *" "${PREFIX}/.local/bin/runcron daily-16" >> "${tmpcrontab}"
    echo "0 20 * * *" "${PREFIX}/.local/bin/runcron daily-20" >> "${tmpcrontab}"
    echo "0  0 * * 0" "${PREFIX}/.local/bin/runcron weekly"   >> "${tmpcrontab}"
    echo "0  0 1 * *" "${PREFIX}/.local/bin/runcron monthly"  >> "${tmpcrontab}"
    echo "0  0 1 1 *" "${PREFIX}/.local/bin/runcron yearly"   >> "${tmpcrontab}"
    crontab "${tmpcrontab}"
    rm -f "${tmpcrontab}"
fi

# iMatix environment
install -m 0644 ibase.sh "${PREFIX}/.local/etc/profile.d"

# Cygwin
if [[ "${os_name}" == CYGWIN* ]]; then
    echo "Cygwin ..."
    if [ -e "${PREFIX}/.XWinrc" ]; then
        cp -f "${PREFIX}/.XWinrc" "${BACKUPDIR}"
    fi
    install -m 0644 dot_XWinrc         "${PREFIX}/.XWinrc"
    install -m 0755 scripts/hyper-v    "${PREFIX}/.local/bin"
    install -m 0644 hyper-v.1          "${PREFIX}/.local/share/man/man1"
    install -m 0755 scripts/msvc-shell "${PREFIX}/.local/bin"
    install -m 0644 msvc-shell.1       "${PREFIX}/.local/share/man/man1"
    install -m 0755 apt-cyg            "${PREFIX}/.local/bin"
fi

# VSCode on cygwin
if [[ "${os_name}" == CYGWIN* ]]; then
    if [[ ! -d "${PREFIX}/.local/opt/vscode" ]]; then
        curl -L -o 'vscode.zip' 'https://update.code.visualstudio.com/latest/win32-x64-archive/stable'
        install -d "${PREFIX}/.local/opt/vscode"
        unzip -d "${PREFIX}/.local/opt/vscode" 'vscode.zip'
        find "${PREFIX}/.local/opt/vscode" -name \*.dll -exec chmod 'a+x' {} \;
        find "${PREFIX}/.local/opt/vscode" -name \*.exe -exec chmod 'a+x' {} \;
    fi
    install -m 0644 vscode.sh          "${PREFIX}/.local/etc/profile.d"
    install -m 0644 vscode-term.env    "${PREFIX}/.local/etc/profile.d"
fi

# Python
echo "Python ..."
echo " - checking if pip3 is installed"
if ! has_prog pip3; then
    easy_install_prog=$(compgen -c 'easy_install-3' | head -n 1)
    if has_prog "${easy_install_prog}"; then
        echo " - installing pip3 with easy_install-3"
        if ! has_prog pip3; then
             "${easy_install_prog}" --user pip > install.log 2>&1
        fi
    fi
fi
echo " - checking if pip2 is installed"
if ! has_prog pip2; then
    easy_install_prog=$(compgen -c 'easy_install-2' | head -n 1)
    if has_prog "${easy_install_prog}"; then
        echo " - installing pip2 with easy_install-2"
        if ! has_prog pip2; then
             "${easy_install_prog}" --user pip > install.log 2>&1
        fi
    fi
fi
if has_prog pip3; then
    echo " - installing neovim plugin with pip3"
    pip3 install --user neovim > install.log 2>&1
fi
echo " - checking if cppman is installed"
if ! has_prog cppman; then
    if has_prog pip3; then
        echo " - installing cppman plugin with pip3"
        pip3 install --user cppman > install.log 2>&1
    fi
fi
if has_prog pip3 && ! has_prog syntrax; then
    pip3 install --user syntrax
fi

# Ruby
if [ -e "${PREFIX}/.gemrc" ]; then
    cp -f "${PREFIX}/.gemrc" "${BACKUPDIR}"
fi
install -m 0644 dot_gemrc "${PREFIX}/.gemrc"

# XWindow
echo "XWindow ..."
if [ -e "${PREFIX}/.xprofile" ]; then
    cp -f "${PREFIX}/.xprofile" "${BACKUPDIR}"
fi
install -m 0644 dot_xprofile "${PREFIX}/.xprofile"
if [ -e "${PREFIX}/.Xresources" ]; then
    cp -f "${PREFIX}/.Xresources" "${BACKUPDIR}"
fi
install -m 0644 dot_Xresources "${PREFIX}/.Xresources"
if [ ! -e "${PREFIX}/.Xresources.user" ]; then
    install -m 0644 dot_Xresources_user "${PREFIX}/.Xresources.user"
fi

if has_prog fc-cache; then
    # Fonts
    echo "nerd fonts ..."
    install -d "${PREFIX}/.fonts"
    install -d "${PREFIX}/.local/share/fonts"
    if [ ! -d "${PREFIX}/.local/share/fonts/nerd-fonts" ]; then
        install -d "${PREFIX}/.local/share/fonts/nerd-fonts"
        curl -O 'https://raw.githubusercontent.com/fjardon/nerd-fonts/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf' \
            > install.log 2>&1
        mv 'DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf' 'DejaVu Sans Mono Nerd Font Complete Mono.ttf'
        install -m 0644 'DejaVu Sans Mono Nerd Font Complete Mono.ttf' "${PREFIX}/.local/share/fonts/nerd-fonts/"
        fc-cache -f "${PREFIX}/.local/share/fonts"
    fi
fi

# vim
echo "vim ..."
if [ -e "${PREFIX}/.vimrc" ]; then
    cp -f "${PREFIX}/.vimrc" "${BACKUPDIR}"
fi
if [ ! -e "${PREFIX}/.vim/autoload/plug.vim" ]; then
    curl -fLo "${PREFIX}/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
install -m 0644 dot_vimrc "${PREFIX}/.vimrc"
vim +PlugInstall +qall

# tmux
echo "tmux ..."
if [ -e "${PREFIX}/.tmux.conf" ]; then
    cp -f "${PREFIX}/.tmux.conf" "${BACKUPDIR}"
fi
TMUX_CONF="dot_tmux_conf"
if has_prog 'tmux'; then
    TMUX_VERSION_MAJOR=$(tmux -V | awk -F[[:space:].] '{print $2}')
    if [ "${TMUX_VERSION_MAJOR}" -ge 3 ]; then
        TMUX_CONF="dot_tmux_3_conf"
    fi
fi
install -m 0644 "${TMUX_CONF}" "${PREFIX}/.tmux.conf"
install -m 0755 scripts/yank   "${PREFIX}/.local/bin"
install -m 0644 yank.1         "${PREFIX}/.local/share/man/man1"

echo "terminfo ..."
if has_prog tic; then
    has_tmux256_terminfo=""
    if [ -e /lib/terminfo/t/tmux-256color ]; then
        has_tmux256_terminfo="y"
    fi
    if [ -e /usr/share/terminfo/t/tmux-256color ]; then
        has_tmux256_terminfo="y"
    fi
    if [ -e "${PREFIX}/.terminfo/t/tmux-256color" ]; then
        has_tmux256_terminfo="y"
    fi
    if [ -z "${has_tmux256_terminfo}" ]; then
        mkdir -p "${PREFIX}/.terminfo"
        tic -o "${PREFIX}/.terminfo" tmux-256color.tinfo
    fi
fi

# Perl
echo "Perl ..."
if [ ! -e "${PREFIX}/.local/share/perl5" ]; then
    perl_local_lib=local-lib-2.000023
    curl -O "http://www.cpan.org/authors/id/H/HA/HAARG/${perl_local_lib}.tar.gz"
    tar zxvf "${perl_local_lib}.tar.gz"
    cd  "${perl_local_lib}"
    perl Makefile.PL "--bootstrap=${PREFIX}/.local/share/perl5" > install.log 2>&1
    make test > install.log 2>&1 && make install > install.log 2>&1
    cd ..
    perl "-I${PREFIX}/.local/share/perl5/lib/perl5" "-Mlocal::lib=${PREFIX}/.local/share/perl5" \
        > "${PREFIX}/.local/etc/profile.d/perl5.sh"
    . "${PREFIX}/.local/etc/profile.d/perl5.sh"
fi

# Scripts
install -m 0755 scripts/codefmt       "${PREFIX}/.local/bin"
install -m 0644 codefmt.1             "${PREFIX}/.local/share/man/man1"
install -m 0755 scripts/codemv        "${PREFIX}/.local/bin"
install -m 0644 codemv.1              "${PREFIX}/.local/share/man/man1"
install -m 0755 scripts/plgen         "${PREFIX}/.local/bin"
install -m 0644 plgen.1               "${PREFIX}/.local/share/man/man1"
install -m 0755 scripts/sixel2tmux    "${PREFIX}/.local/bin"
install -m 0644 sixel2tmux.1          "${PREFIX}/.local/share/man/man1"
install -m 0755 scripts/byzanz-helper "${PREFIX}/.local/bin"
install -m 0644 byzanz-helper.1       "${PREFIX}/.local/share/man/man1"
install -m 0755 scripts/ffmpeg-helper "${PREFIX}/.local/bin"
install -m 0644 ffmpeg-helper.1       "${PREFIX}/.local/share/man/man1"

# Autoconf cache
echo "Autoconf cache ..."
if [ ! -e "${PREFIX}/.local/etc/config.site" ]; then
    cp config.site "${PREFIX}/.local/etc/config.site"
fi

# Gdb pretty printers
if [ ! -e "${PREFIX}/.local/share/gdb" ]; then
    mkdir -p "${PREFIX}/.local/share/gdb"
    tar xvf share-gdb.tar -C "${PREFIX}/.local/share/gdb"
    if [ -e "${PREFIX}/.gdbinit" ]; then
        cp -f "${PREFIX}/.gdbinit" "${BACKUPDIR}"
    fi
    cp dot_gdbinit "${PREFIX}/.gdbinit"
fi

# Gnulib
echo "Gnulib ..."
if ! has_prog gnulib-tool; then
    if [ ! -e "${PREFIX}/.local/share/gnulib" ]; then
        git clone git://git.savannah.gnu.org/gnulib.git "${PREFIX}/.local/share/gnulib" > install.log 2>&1
    fi
    ln -s "${PREFIX}/.local/share/gnulib/gnulib-tool" "${PREFIX}/.local/bin/gnulib-tool"
fi

# TeX
echo "TeX ..."
if has_prog kpsewhich; then
    texmf_home=$(kpsewhich -var-value TEXMFHOME)
    if [ ! -e "${texmf_home}/tex/latex/createspace" ]; then
        mkdir -p "${texmf_home}/tex/latex/"
        git clone https://github.com/aginiewicz/createspace.git "${texmf_home}/tex/latex/createspace" > install.log 2>&1
    fi
fi

# Asciidoctor
echo "Asciidoctor ..."
if has_prog gem && has_prog bison && has_prog flex && has_prog cmake; then
    gem install --user-install pygments.rb
    gem install --user-install asciimath
    gem install --user-install asciidoctor-pdf
    gem install --user-install mathematical
    gem install --user-install asciidoctor-mathematical
    gem install --user-install asciidoctor-diagram
fi


