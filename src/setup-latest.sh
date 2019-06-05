#!/usr/bin/env bash

# =============================================================================
# Exit on any errors
set -e
function echoerr() { echo "$@" 1>&2; }
# =============================================================================

# =============================================================================
# Configure some shell variables
PATH="${PATH}:${HOME}/.local/bin"
LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${HOME}/.local/lib"
DATAROOTDIR="${HOME}/.local/share"
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
lock_dir=_sh41827
# Made on 2019-06-05 22:09 CEST by <frede@darthvader>.
# Source directory was '/home/frede/Documents/workspace/github/unix-config/src'.
#
# Existing files will *not* be overwritten, unless '-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#    601 -rw-r--r-- config.site
#    455 -rw-r--r-- dot_bash_profile
#   3065 -rw-r--r-- dot_bashrc
#    214 -rw-r--r-- dot_gdbinit
#   2479 -rw-r--r-- dot_profile
#   3140 -rw-r--r-- dot_tmux_conf
#   4125 -rw-r--r-- dot_vimrc
#    922 -rw-r--r-- dot_Xresources
#   4076 -rw-r--r-- dot_XWinrc
#   2541 -rwxr-xr-x byzanz-helper
#   3766 -rwxr-xr-x ffmpeg-helper
#   1820 -rwxr-xr-x hyper-v
#    195 -rw-r--r-- ibase.sh
#   5848 -rwxr-xr-x msvc-shell
#   3591 -rw-r--r-- sixel2tmux
#   4128 -rwxr-xr-x yank
#   2836 -rw-r--r-- tmux-256color.tinfo
#    901 -rwxr-xr-x runcron
# 143360 -rw-r--r-- share-gdb.tar
#  13765 -rwxr-xr-x apt-cyg
#   5665 -rw-r--r-- byzanz-helper.1
#   5621 -rw-r--r-- ffmpeg-helper.1
#   5039 -rw-r--r-- hyper-v.1
#   5825 -rw-r--r-- msvc-shell.1
#   6420 -rw-r--r-- sixel2tmux.1
#   7103 -rw-r--r-- yank.1
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
  (set 20 19 06 05 22 08 34 'config.site'
   eval "${shar_touch}") && \
  chmod 0644 'config.site'
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
  (set 20 19 04 07 13 28 42 'dot_bash_profile'
   eval "${shar_touch}") && \
  chmod 0644 'dot_bash_profile'
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
  (set 20 19 05 27 20 00 55 'dot_bashrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_bashrc'
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
${echo} "x - extracting dot_gdbinit (texte)"
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
  (set 20 19 04 07 13 28 13 'dot_gdbinit'
   eval "${shar_touch}") && \
  chmod 0644 'dot_gdbinit'
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
  (set 20 19 04 07 13 29 32 'dot_profile'
   eval "${shar_touch}") && \
  chmod 0644 'dot_profile'
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
${echo} "x - extracting dot_tmux_conf (texte)"
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
M=&%L:6-S7>Z"N"`G"G-E="`M9V$@<W1A='5S+6QE9G0@)R-;9F<]8V]L;W(R
M,C(L8F<]8V]L;W5R,C,X7>^)K"`C5R<@(R!W:6YD;W<@;F%M90IS970@+6=A
M('-T871U<RUL969T("<C6V9G/6-O;&]U<C(S."QB9SUC;VQO=7(R,S4L;F]B
M;VQD+&YO=6YD97)S8V]R92QN;VET86QI8W-=[H*X("<*<V5T("UG82!S=&%T
M=7,M;&5F="`G(UMF9SUC;VQO=7(R,C(L8F<]8V]L;W5R,C,U7>^`AR`C*'=H
M;V%M:2DG(",@=VEN9&]W(&YA;64*<V5T("UG82!S=&%T=7,M;&5F="`G(UMF
M9SUC;VQO=7(R,S4L8F<]8V]L;W5R,C,U+&YO8F]L9"QN;W5N9&5R<V-O<F4L
M;F]I=&%L:6-S7>Z"N"`G"@IS970@+6<@('-T871U<RUR:6=H="`G(UMF9SUC
M;VQO=7(R,S4L8F<]8V]L;W5R,C,U+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I
M=&%L:6-S7>Z"NB`G"G-E="`M9V$@<W1A='5S+7)I9VAT("<C6V9G/6-O;&]U
M<C$R,2QB9SUC;VQO=7(R,S5=[YF/("5R)R`C(&AO=7(L(&1A>2P@>65A<@IS
M970@+6=A('-T871U<RUR:6=H="`G(UMF9SUC;VQO=7(R,S@L8F<]8V]L;W5R
M,C,U+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S7>Z"NB`G"G-E="`M
M9V$@<W1A='5S+7)I9VAT("<C6V9G/6-O;&]U<C(R,BQB9SUC;VQO=7(R,SA=
M[Y&S("-()R`C(&AO<W1N86UE"@IS971W("UG("!W:6YD;W<M<W1A='5S+69O
M<FUA="`G(UMF9SUC;VQO=7(R,SA=[H*Z)PIS971W("UG82!W:6YD;W<M<W1A
M='5S+69O<FUA="`G(UMF9SUC;VQO=7(R,C(L8F<]8V]L;W5R,C,X72-)("-7
M)PIS971W("UG82!W:6YD;W<M<W1A='5S+69O<FUA="`G(UMF9SUC;VQO=7(R
M,S@L8F<]8V]L;W5R,C,U7>Z"N"<*<V5T=R`M9V$@=VEN9&]W+7-T871U<RUF
M;W)M870@)R-;;F]B;VQD+&YO=6YD97)S8V]R92QN;VET86QI8W-=)PH*<V5T
M=R`M9R`@=VEN9&]W+7-T871U<RUC=7)R96YT+69O<FUA="`G(UMF9SUC;VQO
M=7(Q-31=[H*Z)PIS971W("UG82!W:6YD;W<M<W1A='5S+6-U<G)E;G0M9F]R
M;6%T("<C6V9G/6-O;&]U<C(S,BQB9SUC;VQO=7(Q-31=(TD@(U<C1B<*<V5T
M=R`M9V$@=VEN9&]W+7-T871U<RUC=7)R96YT+69O<FUA="`G(UMF9SUC;VQO
M=7(Q-30L8F<]8V]L;W5R,C,U7>Z"N"<*<V5T=R`M9V$@=VEN9&]W+7-T871U
M<RUC=7)R96YT+69O<FUA="`G(UMF9SUC;VQO=7(R,S@L8F<]8V]L;W5R,C,U
C+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S72<*"@H]
`
end
SHAR_EOF
  (set 20 18 08 02 22 33 10 'dot_tmux_conf'
   eval "${shar_touch}") && \
  chmod 0644 'dot_tmux_conf'
if test $? -ne 0
then ${echo} "restore of dot_tmux_conf failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_tmux_conf': 'MD5 check failed'
       ) << \SHAR_EOF
684f6c62e10035c5bbc86d06d30df210  dot_tmux_conf
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_tmux_conf'` -ne 3140 && \
  ${echo} "restoration warning:  size of 'dot_tmux_conf' is not 3140"
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
"Plug 'rosenfeld/conque-term'      	" Consoles as buffers
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
"Plug 'tpope/vim-abolish'
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
  (set 20 18 04 04 21 11 18 'dot_vimrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_vimrc'
if test $? -ne 0
then ${echo} "restore of dot_vimrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_vimrc': 'MD5 check failed'
       ) << \SHAR_EOF
76aa0dafac70549c3758327970f61403  dot_vimrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_vimrc'` -ne 4125 && \
  ${echo} "restoration warning:  size of 'dot_vimrc' is not 4125"
  fi
fi
# ============= dot_Xresources ==============
if test -n "${keep_file}" && test -f 'dot_Xresources'
then
${echo} "x - SKIPPING dot_Xresources (file already exists)"

else
${echo} "x - extracting dot_Xresources (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_Xresources' &&
XXTerm*eightBitInput: true
XXTerm*faceName: DejaVuSansMono NF
XXTerm*renderFont: true
XXTerm*reverseVideo: true
XXTerm*rightScrollBar: true
XXTerm*scrollBar: true
XXTerm*termName: xterm-256color
XXTerm*toolBar: false
XXTerm*utf8: 2
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
! Sixel enabling
XXTerm*decTerminalID: vt340
! Sixel with more than 16 colors
XXTerm*numColorRegisters: 256
X
SHAR_EOF
  (set 20 18 11 07 20 09 15 'dot_Xresources'
   eval "${shar_touch}") && \
  chmod 0644 'dot_Xresources'
if test $? -ne 0
then ${echo} "restore of dot_Xresources failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_Xresources': 'MD5 check failed'
       ) << \SHAR_EOF
ad95919ba13b8c78d737f8dbc472bdd5  dot_Xresources
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_Xresources'` -ne 922 && \
  ${echo} "restoration warning:  size of 'dot_Xresources' is not 922"
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
  (set 20 18 02 01 18 48 58 'dot_XWinrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_XWinrc'
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
# ============= byzanz-helper ==============
if test -n "${keep_file}" && test -f 'byzanz-helper'
then
${echo} "x - SKIPPING byzanz-helper (file already exists)"

else
${echo} "x - extracting byzanz-helper (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'byzanz-helper' &&
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
  (set 20 18 04 03 08 04 45 'byzanz-helper'
   eval "${shar_touch}") && \
  chmod 0755 'byzanz-helper'
if test $? -ne 0
then ${echo} "restore of byzanz-helper failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'byzanz-helper': 'MD5 check failed'
       ) << \SHAR_EOF
ba44a6190023b1b48776340b2bb6a277  byzanz-helper
SHAR_EOF

else
test `LC_ALL=C wc -c < 'byzanz-helper'` -ne 2541 && \
  ${echo} "restoration warning:  size of 'byzanz-helper' is not 2541"
  fi
fi
# ============= ffmpeg-helper ==============
if test -n "${keep_file}" && test -f 'ffmpeg-helper'
then
${echo} "x - SKIPPING ffmpeg-helper (file already exists)"

else
${echo} "x - extracting ffmpeg-helper (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'ffmpeg-helper' &&
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
  (set 20 18 04 03 19 52 23 'ffmpeg-helper'
   eval "${shar_touch}") && \
  chmod 0755 'ffmpeg-helper'
if test $? -ne 0
then ${echo} "restore of ffmpeg-helper failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'ffmpeg-helper': 'MD5 check failed'
       ) << \SHAR_EOF
730d1c68192b332ed5091a88717971de  ffmpeg-helper
SHAR_EOF

else
test `LC_ALL=C wc -c < 'ffmpeg-helper'` -ne 3766 && \
  ${echo} "restoration warning:  size of 'ffmpeg-helper' is not 3766"
  fi
fi
# ============= hyper-v ==============
if test -n "${keep_file}" && test -f 'hyper-v'
then
${echo} "x - SKIPPING hyper-v (file already exists)"

else
${echo} "x - extracting hyper-v (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'hyper-v' &&
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
  (set 20 18 09 02 15 42 12 'hyper-v'
   eval "${shar_touch}") && \
  chmod 0755 'hyper-v'
if test $? -ne 0
then ${echo} "restore of hyper-v failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'hyper-v': 'MD5 check failed'
       ) << \SHAR_EOF
931cccf0a443d53c5f44be782f9a4583  hyper-v
SHAR_EOF

else
test `LC_ALL=C wc -c < 'hyper-v'` -ne 1820 && \
  ${echo} "restoration warning:  size of 'hyper-v' is not 1820"
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
  (set 20 19 06 05 22 06 47 'ibase.sh'
   eval "${shar_touch}") && \
  chmod 0644 'ibase.sh'
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
# ============= msvc-shell ==============
if test -n "${keep_file}" && test -f 'msvc-shell'
then
${echo} "x - SKIPPING msvc-shell (file already exists)"

else
${echo} "x - extracting msvc-shell (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'msvc-shell' &&
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
use Storable;
X
sub call_vcvarsall {
X    my ($opts) = @_;
X
X    # save current context to restore it later
X    my %saved_ENV = (%ENV);
X    my $cwd = getcwd;
X
X    # Get environment
X    my $env = $opts->{ENV};
X    $env //= \%ENV;
X
X    # Get path to comspec
X    my $comspec_win=$env->{'COMSPEC'};
X    croak("Unable to find 'COMSPEC' in the environment!")
X        if(!defined($comspec_win));
X    my $comspec_path = Cygwin::win_to_posix_path($comspec_win);
X
X    # get path to vcvarsall.bat
X    my $vcvarsall_bat_path = $opts->{vcvarsall_bat_path};
X    croak("'vcvarsall_bat_path' parameter is mandatory")
X        if(!defined($vcvarsall_bat_path));
X
X    # Get vcvarsall.bat arguments
X    my $vcvarsall_args = $opts->{args};
X    $vcvarsall_args  //= [];
X
X    # Get paths to scripts and bash
X    my $bat_dir      = dirname($vcvarsall_bat_path);
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
X    my $tmp_bat_dir    = dirname($tmp_bat);
X    # Close the temporary file handle to avoid 'text file is busy' errors
X    close($tmp_bat_handle);
X
X    # Compute parameters
X    my $vcvarsall_params = join(' ', @{$vcvarsall_args});
X
X    open(my $fh, '>', $tmp_bat) or
X        croak("Unable to create batch file");
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
X    my %vc_env = %{retrieve($tmp_env_filename)};
X
X    # Check for errors
X    croak("Error while setuping VC++ environment")
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
X
# Load the full windows environment
Cygwin::sync_winenv();
X
# Parse options
my ($opt_help, $opt_p);
GetOptionsFromArray(
X    \@ARGV,
X    'help|h'             => \$opt_help,
X    'p|vcvarsall-path=s' => \$opt_p,
) or croak('Error parsing command line arguments');
X
# Handle help option
pod2usage(-exitval => 0) if $opt_help;
X
# Clean -p option
$opt_p = Cygwin::win_to_posix_path($opt_p)
X    if(defined($opt_p));
my @default_vs_paths = ();
push(@default_vs_paths, $ENV{'ProgramW6432'})
X    if(exists($ENV{'ProgramW6432'}));
push(@default_vs_paths, $ENV{'ProgramFiles(x86)'})
X    if(exists($ENV{'ProgramFiles(x86)'}));
@default_vs_paths = map { Cygwin::win_to_posix_path($_) } @default_vs_paths;
@default_vs_paths = map { $_.'/Microsoft Visual Studio/2017' } @default_vs_paths;
@default_vs_paths = map { $_.'/Community', $_.'/Professional', $_.'/Enterprise' } @default_vs_paths;
@default_vs_paths = map { $_.'/VC/Auxiliary/Build/vcvarsall.bat' } @default_vs_paths;
if(! defined($opt_p)) {
X    my @found_vcvars = grep { -f $_ } @default_vs_paths;
X    if(@found_vcvars) {
X        $opt_p = $found_vcvars[0];
X        print "Using 'vcvarsall.bat' found in path: ".dirname($opt_p)."\n";
X    }
}
if(! defined($opt_p)) {
X    print STDERR "Unable to find a suitable path to 'vcvarsall.bat'. Please use option '-p'\n";
X    pod2usage(-exitval => 1);
}
if(! -f $opt_p) {
X    print STDERR "The path specified by option '-p' is not valid.\n";
X    pod2usage(-exitval => 1);
}
X
call_vcvarsall({
X        vcvarsall_bat_path => $opt_p,
X        args => \@ARGV,
X    });
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
  (set 20 18 09 26 08 02 32 'msvc-shell'
   eval "${shar_touch}") && \
  chmod 0755 'msvc-shell'
if test $? -ne 0
then ${echo} "restore of msvc-shell failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'msvc-shell': 'MD5 check failed'
       ) << \SHAR_EOF
a2b514f31ae000c23d99b3b3659803f6  msvc-shell
SHAR_EOF

else
test `LC_ALL=C wc -c < 'msvc-shell'` -ne 5848 && \
  ${echo} "restoration warning:  size of 'msvc-shell' is not 5848"
  fi
fi
# ============= sixel2tmux ==============
if test -n "${keep_file}" && test -f 'sixel2tmux'
then
${echo} "x - SKIPPING sixel2tmux (file already exists)"

else
${echo} "x - extracting sixel2tmux (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'sixel2tmux' &&
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
  (set 20 18 11 07 20 09 15 'sixel2tmux'
   eval "${shar_touch}") && \
  chmod 0644 'sixel2tmux'
if test $? -ne 0
then ${echo} "restore of sixel2tmux failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'sixel2tmux': 'MD5 check failed'
       ) << \SHAR_EOF
1502bceaaa5049181d318128b8e4d58d  sixel2tmux
SHAR_EOF

else
test `LC_ALL=C wc -c < 'sixel2tmux'` -ne 3591 && \
  ${echo} "restoration warning:  size of 'sixel2tmux' is not 3591"
  fi
fi
# ============= yank ==============
if test -n "${keep_file}" && test -f 'yank'
then
${echo} "x - SKIPPING yank (file already exists)"

else
${echo} "x - extracting yank (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'yank' &&
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
  (set 20 18 04 01 15 36 07 'yank'
   eval "${shar_touch}") && \
  chmod 0755 'yank'
if test $? -ne 0
then ${echo} "restore of yank failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'yank': 'MD5 check failed'
       ) << \SHAR_EOF
b5528cfbfa7966be5377b78960cd2e28  yank
SHAR_EOF

else
test `LC_ALL=C wc -c < 'yank'` -ne 4128 && \
  ${echo} "restoration warning:  size of 'yank' is not 4128"
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
  (set 20 18 03 31 10 51 09 'tmux-256color.tinfo'
   eval "${shar_touch}") && \
  chmod 0644 'tmux-256color.tinfo'
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
  (set 20 18 02 01 18 48 58 'runcron'
   eval "${shar_touch}") && \
  chmod 0755 'runcron'
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
# ============= share-gdb.tar ==============
if test -n "${keep_file}" && test -f 'share-gdb.tar'
then
${echo} "x - SKIPPING share-gdb.tar (file already exists)"

else
${echo} "x - extracting share-gdb.tar (texte)"
  sed 's/^X//' << 'SHAR_EOF' | uudecode &&
begin 600 share-gdb.tar
M+B\`````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````#`P,#`W-34`,#8P,3<U,0`P-C`Q-S4Q`#`P,#`P,#`P,#`P
M`#$S-#<V,#(P-C`U`#`Q,#$W,``@-0``````````````````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````!U<W1A<B`@`&9R961E
M````````````````````````````````````9G)E9&4`````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````N+W!Y=&AO;B\`````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````,#`P,#<U-0`P-C`Q-S4Q`#`V
M,#$W-3$`,#`P,#`P,#`P,#``,3,T-S8P,C`V,#8`,#$Q-3$R`"`U````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````'5S=&%R("``9G)E9&4```````````````````````````````````!F
M<F5D90``````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````"XO<'ET:&]N+VAO
M;VLN:6X`````````````````````````````````````````````````````
M```````````````````````````````````````````````````````````P
M,#`P-C0T`#`V,#$W-3$`,#8P,3<U,0`P,#`P,#`P-#4P,``Q,S0W-C`R,#8P
M-@`P,3,P,#$`(#``````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````=7-T87(@(`!F<F5D90``````````````
M`````````````````````&9R961E````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````(R`M*BT@<'ET:&]N("TJ+0HC($-O<'ER:6=H="`H0RD@,C`P.2TR
M,#$Y($9R964@4V]F='=A<F4@1F]U;F1A=&EO;BP@26YC+@H*(R!4:&ES('!R
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
M```````````````P,#`P-S4U`#`V,#$W-3$`,#8P,3<U,0`P,#`P,#`P,#`P
M,``Q,S0W-C`R,#8P-@`P,3,U,38`(#4`````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````=7-T87(@(`!F<F5D
M90```````````````````````````````````&9R961E````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````+B]P>71H;VXO;&EB<W1D8WAX+W8V+P``````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````#`P,#`W-34`,#8P,3<U,0`P
M-C`Q-S4Q`#`P,#`P,#`P,#`P`#$S-#<V,#(P-C`V`#`Q-#`U,0`@-0``````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````!U<W1A<B`@`&9R961E````````````````````````````````````
M9G)E9&4`````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````````N+W!Y=&AO;B]L
M:6)S=&1C>'@O=C8O<')I;G1E<G,N<'D`````````````````````````````
M````````````````````````````````````````````````````````````
M,#`P,#8T-``P-C`Q-S4Q`#`V,#$W-3$`,#`P,#`R,30W,34`,3,T-S8P,C`V
M,#8`,#$V,S`S`"`P````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````'5S=&%R("``9G)E9&4`````````````
M``````````````````````!F<F5D90``````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````",@4')E='1Y+7!R:6YT97)S(&9O<B!L:6)S=&1C*RLN"@HC($-O
M<'ER:6=H="`H0RD@,C`P."TR,#$Y($9R964@4V]F='=A<F4@1F]U;F1A=&EO
M;BP@26YC+@H*(R!4:&ES('!R;V=R86T@:7,@9G)E92!S;V9T=V%R93L@>6]U
M(&-A;B!R961I<W1R:6)U=&4@:70@86YD+V]R(&UO9&EF>0HC(&ET('5N9&5R
M('1H92!T97)M<R!O9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@
M87,@<'5B;&ES:&5D(&)Y"B,@=&AE($9R964@4V]F='=A<F4@1F]U;F1A=&EO
M;CL@96ET:&5R('9E<G-I;VX@,R!O9B!T:&4@3&EC96YS92P@;W(*(R`H870@
M>6]U<B!O<'1I;VXI(&%N>2!L871E<B!V97)S:6]N+@HC"B,@5&AI<R!P<F]G
M<F%M(&ES(&1I<W1R:6)U=&5D(&EN('1H92!H;W!E('1H870@:70@=VEL;"!B
M92!U<V5F=6PL"B,@8G5T(%=)5$A/550@04Y9(%=!4E)!3E19.R!W:71H;W5T
M(&5V96X@=&AE(&EM<&QI960@=V%R<F%N='D@;V8*(R!-15)#2$%.5$%"24Q)
M5%D@;W(@1DE43D534R!&3U(@02!005)424-53$%2(%!54E!/4T4N("!3964@
M=&AE"B,@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@9F]R(&UO<F4@9&5T
M86EL<RX*(PHC(%EO=2!S:&]U;&0@:&%V92!R96-E:79E9"!A(&-O<'D@;V8@
M=&AE($=.52!'96YE<F%L(%!U8FQI8R!,:6-E;G-E"B,@86QO;F<@=VET:"!T
M:&ES('!R;V=R86TN("!)9B!N;W0L('-E92`\:'1T<#HO+W=W=RYG;G4N;W)G
M+VQI8V5N<V5S+SXN"@II;7!O<G0@9V1B"FEM<&]R="!I=&5R=&]O;',*:6UP
M;W)T(')E"FEM<&]R="!S>7,*"B,C(R!0>71H;VX@,B`K(%!Y=&AO;B`S(&-O
M;7!A=&EB:6QI='D@8V]D90H*(R!297-O=7)C97,@86)O=70@8V]M<&%T:6)I
M;&ET>3H*(PHC("`J(#QH='1P.B\O<'ET:&]N:&]S=&5D+F]R9R]S:7@O/CH@
M1&]C=6UE;G1A=&EO;B!O9B!T:&4@(G-I>"(@;6]D=6QE"@HC($9)6$U%.B!4
M:&4@:&%N9&QI;F<@;V8@92YG+B!S=&0Z.F)A<VEC7W-T<FEN9R`H870@;&5A
M<W0@;VX@8VAA<BD*(R!P<F]B86)L>2!N965D<R!U<&1A=&EN9R!T;R!W;W)K
M('=I=&@@4'ET:&]N(#,G<R!N97<@<W1R:6YG(')U;&5S+@HC"B,@26X@<&%R
M=&EC=6QA<BP@4'ET:&]N(#,@:&%S(&$@<V5P87)A=&4@='EP92`H8V%L;&5D
M(&)Y=&4I(&9O<@HC(&)Y=&5S=')I;F=S+"!A;F0@82!S<&5C:6%L(&(B(B!S
M>6YT87@@9F]R('1H92!B>71E(&QI=&5R86QS.R!T:&4@;VQD"B,@<W1R*"D@
M='EP92!H87,@8F5E;B!R961E9FEN960@=&\@86QW87ES('-T;W)E(%5N:6-O
M9&4@=&5X="X*(PHC(%=E('!R;V)A8FQY(&-A;B=T(&1O(&UU8V@@86)O=70@
M=&AI<R!U;G1I;"!T:&ES($=$0B!04B!I<R!A9&1R97-S960Z"B,@/&AT='!S
M.B\O<V]U<F-E=V%R92YO<F<O8G5G>FEL;&$O<VAO=U]B=6<N8V=I/VED/3$W
M,3,X/@H*:68@<WES+G9E<G-I;VY?:6YF;ULP72`^(#(Z"B`@("`C(R,@4'ET
M:&]N(#,@<W1U9F8*("`@($ET97)A=&]R(#T@;V)J96-T"B`@("`C(%!Y=&AO
M;B`S(&9O;&1S('1H97-E(&EN=&\@=&AE(&YO<FUA;"!F=6YC=&EO;G,N"B`@
M("!I;6%P(#T@;6%P"B`@("!I>FEP(#T@>FEP"B`@("`C($%L<V\L(&EN="!S
M=6)S=6UE<R!L;VYG"B`@("!L;VYG(#T@:6YT"F5L<V4Z"B`@("`C(R,@4'ET
M:&]N(#(@<W1U9F8*("`@(&-L87-S($ET97)A=&]R.@H@("`@("`@("(B(D-O
M;7!A=&EB:6QI='D@;6EX:6X@9F]R(&ET97)A=&]R<PH*("`@("`@("!);G-T
M96%D(&]F('=R:71I;F<@;F5X="@I(&UE=&AO9',@9F]R(&ET97)A=&]R<RP@
M=W)I=&4*("`@("`@("!?7VYE>'1?7R@I(&UE=&AO9',@86YD('5S92!T:&ES
M(&UI>&EN('1O(&UA:V4@=&AE;2!W;W)K(&EN"B`@("`@("`@4'ET:&]N(#(@
M87,@=V5L;"!A<R!0>71H;VX@,RX*"B`@("`@("`@261E82!S=&]L96X@9G)O
M;2!T:&4@(G-I>"(@9&]C=6UE;G1A=&EO;CH*("`@("`@("`\:'1T<#HO+W!Y
M=&AO;FAO<W1E9"YO<F<O<VEX+R-S:7@N271E<F%T;W(^"B`@("`@("`@(B(B
M"@H@("`@("`@(&1E9B!N97AT*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@
M<V5L9BY?7VYE>'1?7R@I"@H@("`@(R!);B!0>71H;VX@,BP@=V4@<W1I;&P@
M;F5E9"!T:&5S92!F<F]M(&ET97)T;V]L<PH@("`@9G)O;2!I=&5R=&]O;',@
M:6UP;W)T(&EM87`L(&EZ:7`*"B,@5')Y('1O('5S92!T:&4@;F5W+7-T>6QE
M('!R971T>2UP<FEN=&EN9R!I9B!A=F%I;&%B;&4N"E]U<V5?9V1B7W!P(#T@
M5')U90IT<GDZ"B`@("!I;7!O<G0@9V1B+G!R:6YT:6YG"F5X8V5P="!);7!O
M<G1%<G)O<CH*("`@(%]U<V5?9V1B7W!P(#T@1F%L<V4*"B,@5')Y('1O(&EN
M<W1A;&P@='EP92UP<FEN=&5R<RX*7W5S95]T>7!E7W!R:6YT:6YG(#T@1F%L
M<V4*=')Y.@H@("`@:6UP;W)T(&=D8BYT>7!E<PH@("`@:68@:&%S871T<BAG
M9&(N='EP97,L("=4>7!E4')I;G1E<B<I.@H@("`@("`@(%]U<V5?='EP95]P
M<FEN=&EN9R`](%1R=64*97AC97!T($EM<&]R=$5R<F]R.@H@("`@<&%S<PH*
M(R!3=&%R=&EN9R!W:71H('1H92!T>7!E($]224<L('-E87)C:"!F;W(@=&AE
M(&UE;6)E<B!T>7!E($Y!344N("!4:&ES"B,@:&%N9&QE<R!S96%R8VAI;F<@
M=7!W87)D('1H<F]U9V@@<W5P97)C;&%S<V5S+B`@5&AI<R!I<R!N965D960@
M=&\*(R!W;W)K(&%R;W5N9"!H='1P.B\O<V]U<F-E=V%R92YO<F<O8G5G>FEL
M;&$O<VAO=U]B=6<N8V=I/VED/3$S-C$U+@ID968@9FEN9%]T>7!E*&]R:6<L
M(&YA;64I.@H@("`@='EP(#T@;W)I9RYS=')I<%]T>7!E9&5F<R@I"B`@("!W
M:&EL92!4<G5E.@H@("`@("`@(",@4W1R:7`@8W8M<75A;&EF:65R<RX@(%!2
M(#8W-#0P+@H@("`@("`@('-E87)C:"`]("<E<SHZ)7,G("4@*'1Y<"YU;G%U
M86QI9FEE9"@I+"!N86UE*0H@("`@("`@('1R>3H*("`@("`@("`@("`@<F5T
M=7)N(&=D8BYL;V]K=7!?='EP92AS96%R8V@I"B`@("`@("`@97AC97!T(%)U
M;G1I;65%<G)O<CH*("`@("`@("`@("`@<&%S<PH@("`@("`@(",@5&AE('1Y
M<&4@=V%S(&YO="!F;W5N9"P@<V\@=')Y('1H92!S=7!E<F-L87-S+B`@5V4@
M;VYL>2!N965D"B`@("`@("`@(R!T;R!C:&5C:R!T:&4@9FER<W0@<W5P97)C
M;&%S<RP@<V\@=V4@9&]N)W0@8F]T:&5R('=I=&@*("`@("`@("`C(&%N>71H
M:6YG(&9A;F-I97(@:&5R92X*("`@("`@("!F:65L9"`]('1Y<"YF:65L9',H
M*5LP70H@("`@("`@(&EF(&YO="!F:65L9"YI<U]B87-E7V-L87-S.@H@("`@
M("`@("`@("!R86ES92!686QU945R<F]R*")#86YN;W0@9FEN9"!T>7!E("5S
M.CHE<R(@)2`H<W1R*&]R:6<I+"!N86UE*2D*("`@("`@("!T>7`@/2!F:65L
M9"YT>7!E"@I?=F5R<VEO;F5D7VYA;65S<&%C92`]("=?7S@Z.B<*"F1E9B!I
M<U]S<&5C:6%L:7IA=&EO;E]O9BAX+"!T96UP;&%T95]N86UE*3H*("`@(")4
M97-T(&EF(&$@='EP92!I<R!A(&=I=F5N('1E;7!L871E(&EN<W1A;G1I871I
M;VXN(@H@("`@9VQO8F%L(%]V97)S:6]N961?;F%M97-P86-E"B`@("!I9B!T
M>7!E*'@I(&ES(&=D8BY4>7!E.@H@("`@("`@('@@/2!X+G1A9PH@("`@:68@
M7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@("`@<F5T=7)N(')E+FUA=&-H
M*"=><W1D.CHH)7,I/R5S/"XJ/B0G("4@*%]V97)S:6]N961?;F%M97-P86-E
M+"!T96UP;&%T95]N86UE*2P@>"D@:7,@;F]T($YO;F4*("`@(')E='5R;B!R
M92YM871C:"@G7G-T9#HZ)7,\+BH^)"<@)2!T96UP;&%T95]N86UE+"!X*2!I
M<R!N;W0@3F]N90H*9&5F('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP
M96YA;64I.@H@("`@9VQO8F%L(%]V97)S:6]N961?;F%M97-P86-E"B`@("!I
M9B!?=F5R<VEO;F5D7VYA;65S<&%C93H*("`@("`@("!R971U<FX@='EP96YA
M;64N<F5P;&%C92A?=F5R<VEO;F5D7VYA;65S<&%C92P@)R<I"B`@("!R971U
M<FX@='EP96YA;64*"F1E9B!S=')I<%]I;FQI;F5?;F%M97-P86-E<RAT>7!E
M7W-T<BDZ"B`@("`B4F5M;W9E(&MN;W=N(&EN;&EN92!N86UE<W!A8V5S(&9R
M;VT@=&AE(&-A;F]N:6-A;"!N86UE(&]F(&$@='EP92XB"B`@("!T>7!E7W-T
M<B`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP95]S='(I"B`@("!T
M>7!E7W-T<B`]('1Y<&5?<W1R+G)E<&QA8V4H)W-T9#HZ7U]C>'@Q,3HZ)RP@
M)W-T9#HZ)RD*("`@(&5X<'1?;G,@/2`G<W1D.CIE>'!E<FEM96YT86PZ.B<*
M("`@(&9O<B!L9G1S7VYS(&EN("@G9G5N9&%M96YT86QS7W8Q)RP@)V9U;F1A
M;65N=&%L<U]V,B<I.@H@("`@("`@('1Y<&5?<W1R(#T@='EP95]S='(N<F5P
M;&%C92AE>'!T7VYS*VQF='-?;G,K)SHZ)RP@97AP=%]N<RD*("`@(&9S7VYS
M(#T@97AP=%]N<R`K("=F:6QE<WES=&5M.CHG"B`@("!T>7!E7W-T<B`]('1Y
M<&5?<W1R+G)E<&QA8V4H9G-?;G,K)W8Q.CHG+"!F<U]N<RD*("`@(')E='5R
M;B!T>7!E7W-T<@H*9&5F(&=E=%]T96UP;&%T95]A<F=?;&ES="AT>7!E7V]B
M:BDZ"B`@("`B4F5T=7)N(&$@='EP92=S('1E;7!L871E(&%R9W5M96YT<R!A
M<R!A(&QI<W0B"B`@("!N(#T@,`H@("`@=&5M<&QA=&5?87)G<R`](%M="B`@
M("!W:&EL92!4<G5E.@H@("`@("`@('1R>3H*("`@("`@("`@("`@=&5M<&QA
M=&5?87)G<RYA<'!E;F0H='EP95]O8FHN=&5M<&QA=&5?87)G=6UE;G0H;BDI
M"B`@("`@("`@97AC97!T.@H@("`@("`@("`@("!R971U<FX@=&5M<&QA=&5?
M87)G<PH@("`@("`@(&X@*ST@,0H*8VQA<W,@4VUA<G10='))=&5R871O<BA)
M=&5R871O<BDZ"B`@("`B06X@:71E<F%T;W(@9F]R('-M87)T('!O:6YT97(@
M='EP97,@=VET:"!A('-I;F=L92`G8VAI;&0G('9A;'5E(@H*("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"@H@
M("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF"@H@
M("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N=F%L(&ES
M($YO;F4Z"B`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@
M("!S96QF+G9A;"P@=F%L(#T@3F]N92P@<V5L9BYV86P*("`@("`@("!R971U
M<FX@*"=G970H*2<L('9A;"D*"F-L87-S(%-H87)E9%!O:6YT97)0<FEN=&5R
M.@H@("`@(E!R:6YT(&$@<VAA<F5D7W!T<B!O<B!W96%K7W!T<B(*"B`@("!D
M968@7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E
M;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N
M86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYP;VEN
M=&5R(#T@=F%L6R=?35]P='(G70H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ
M"B`@("`@("`@<F5T=7)N(%-M87)T4'1R271E<F%T;W(H<V5L9BYP;VEN=&5R
M*0H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@('-T871E(#T@
M)V5M<'1Y)PH@("`@("`@(')E9F-O=6YT<R`]('-E;&8N=F%L6R=?35]R969C
M;W5N="==6R=?35]P:2=="B`@("`@("`@:68@<F5F8V]U;G1S("$](#`Z"B`@
M("`@("`@("`@('5S96-O=6YT(#T@<F5F8V]U;G1S6R=?35]U<V5?8V]U;G0G
M70H@("`@("`@("`@("!W96%K8V]U;G0@/2!R969C;W5N='-;)U]-7W=E86M?
M8V]U;G0G70H@("`@("`@("`@("!I9B!U<V5C;W5N="`]/2`P.@H@("`@("`@
M("`@("`@("`@<W1A=&4@/2`G97AP:7)E9"P@=V5A:R!C;W5N="`E9"<@)2!W
M96%K8V]U;G0*("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@('-T
M871E(#T@)W5S92!C;W5N="`E9"P@=V5A:R!C;W5N="`E9"<@)2`H=7-E8V]U
M;G0L('=E86MC;W5N="`M(#$I"B`@("`@("`@<F5T=7)N("<E<SPE<SX@*"5S
M*2<@)2`H<V5L9BYT>7!E;F%M92P@<W1R*'-E;&8N=F%L+G1Y<&4N=&5M<&QA
M=&5?87)G=6UE;G0H,"DI+"!S=&%T92D*"F-L87-S(%5N:7%U95!O:6YT97)0
M<FEN=&5R.@H@("`@(E!R:6YT(&$@=6YI<75E7W!T<B(*"B`@("!D968@7U]I
M;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L
M(#T@=F%L"B`@("`@("`@:6UP;%]T>7!E(#T@=F%L+G1Y<&4N9FEE;&1S*"E;
M,%TN='EP92YT86<*("`@("`@("`C($-H96-K(&9O<B!N97<@:6UP;&5M96YT
M871I;VYS(&9I<G-T.@H@("`@("`@(&EF(&ES7W-P96-I86QI>F%T:6]N7V]F
M*&EM<&Q?='EP92P@)U]?=6YI<5]P=')?9&%T82<I(%P*("`@("`@("`@("`@
M;W(@:7-?<W!E8VEA;&EZ871I;VY?;V8H:6UP;%]T>7!E+"`G7U]U;FEQ7W!T
M<E]I;7!L)RDZ"B`@("`@("`@("`@('1U<&QE7VUE;6)E<B`]('9A;%LG7TU?
M="==6R=?35]T)UT*("`@("`@("!E;&EF(&ES7W-P96-I86QI>F%T:6]N7V]F
M*&EM<&Q?='EP92P@)W1U<&QE)RDZ"B`@("`@("`@("`@('1U<&QE7VUE;6)E
M<B`]('9A;%LG7TU?="=="B`@("`@("`@96QS93H*("`@("`@("`@("`@<F%I
M<V4@5F%L=65%<G)O<B@B56YS=7!P;W)T960@:6UP;&5M96YT871I;VX@9F]R
M('5N:7%U95]P='(Z("5S(B`E(&EM<&Q?='EP92D*("`@("`@("!T=7!L95]I
M;7!L7W1Y<&4@/2!T=7!L95]M96UB97(N='EP92YF:65L9',H*5LP72YT>7!E
M(",@7U1U<&QE7VEM<&P*("`@("`@("!T=7!L95]H96%D7W1Y<&4@/2!T=7!L
M95]I;7!L7W1Y<&4N9FEE;&1S*"E;,5TN='EP92`@(",@7TAE861?8F%S90H@
M("`@("`@(&AE861?9FEE;&0@/2!T=7!L95]H96%D7W1Y<&4N9FEE;&1S*"E;
M,%T*("`@("`@("!I9B!H96%D7V9I96QD+FYA;64@/3T@)U]-7VAE861?:6UP
M;"<Z"B`@("`@("`@("`@('-E;&8N<&]I;G1E<B`]('1U<&QE7VUE;6)E<ELG
M7TU?:&5A9%]I;7!L)UT*("`@("`@("!E;&EF(&AE861?9FEE;&0N:7-?8F%S
M95]C;&%S<SH*("`@("`@("`@("`@<V5L9BYP;VEN=&5R(#T@='5P;&5?;65M
M8F5R+F-A<W0H:&5A9%]F:65L9"YT>7!E*0H@("`@("`@(&5L<V4Z"B`@("`@
M("`@("`@(')A:7-E(%9A;'5E17)R;W(H(E5N<W5P<&]R=&5D(&EM<&QE;65N
M=&%T:6]N(&9O<B!T=7!L92!I;B!U;FEQ=65?<'1R.B`E<R(@)2!I;7!L7W1Y
M<&4I"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!R971U<FX@
M4VUA<G10='))=&5R871O<BAS96QF+G!O:6YT97(I"@H@("`@9&5F('1O7W-T
M<FEN9R`H<V5L9BDZ"B`@("`@("`@<F5T=7)N("@G<W1D.CIU;FEQ=65?<'1R
M/"5S/B<@)2`H<W1R*'-E;&8N=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H
M,"DI*2D*"F1E9B!G971?=F%L=65?9G)O;5]A;&EG;F5D7VUE;6)U9BAB=68L
M('9A;'1Y<&4I.@H@("`@(B(B4F5T=7)N<R!T:&4@=F%L=64@:&5L9"!I;B!A
M(%]?9VYU7V-X>#HZ7U]A;&EG;F5D7VUE;6)U9BXB(B(*("`@(')E='5R;B!B
M=69;)U]-7W-T;W)A9V4G72YA9&1R97-S+F-A<W0H=F%L='EP92YP;VEN=&5R
M*"DI+F1E<F5F97)E;F-E*"D*"F1E9B!G971?=F%L=65?9G)O;5]L:7-T7VYO
M9&4H;F]D92DZ"B`@("`B(B)2971U<FYS('1H92!V86QU92!H96QD(&EN(&%N
M(%],:7-T7VYO9&4\7U9A;#XB(B(*("`@('1R>3H*("`@("`@("!M96UB97(@
M/2!N;V1E+G1Y<&4N9FEE;&1S*"E;,5TN;F%M90H@("`@("`@(&EF(&UE;6)E
M<B`]/2`G7TU?9&%T82<Z"B`@("`@("`@("`@(",@0RLK,#,@:6UP;&5M96YT
M871I;VXL(&YO9&4@8V]N=&%I;G,@=&AE('9A;'5E(&%S(&$@;65M8F5R"B`@
M("`@("`@("`@(')E='5R;B!N;V1E6R=?35]D871A)UT*("`@("`@("!E;&EF
M(&UE;6)E<B`]/2`G7TU?<W1O<F%G92<Z"B`@("`@("`@("`@(",@0RLK,3$@
M:6UP;&5M96YT871I;VXL(&YO9&4@<W1O<F5S('9A;'5E(&EN(%]?86QI9VYE
M9%]M96UB=68*("`@("`@("`@("`@=F%L='EP92`](&YO9&4N='EP92YT96UP
M;&%T95]A<F=U;65N="@P*0H@("`@("`@("`@("!R971U<FX@9V5T7W9A;'5E
M7V9R;VU?86QI9VYE9%]M96UB=68H;F]D95LG7TU?<W1O<F%G92==+"!V86QT
M>7!E*0H@("`@97AC97!T.@H@("`@("`@('!A<W,*("`@(')A:7-E(%9A;'5E
M17)R;W(H(E5N<W5P<&]R=&5D(&EM<&QE;65N=&%T:6]N(&9O<B`E<R(@)2!S
M='(H;F]D92YT>7!E*2D*"F-L87-S(%-T9$QI<W10<FEN=&5R.@H@("`@(E!R
M:6YT(&$@<W1D.CIL:7-T(@H*("`@(&-L87-S(%]I=&5R871O<BA)=&5R871O
M<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YO9&5T>7!E+"!H96%D
M*3H*("`@("`@("`@("`@<V5L9BYN;V1E='EP92`](&YO9&5T>7!E"B`@("`@
M("`@("`@('-E;&8N8F%S92`](&AE861;)U]-7VYE>'0G70H@("`@("`@("`@
M("!S96QF+FAE860@/2!H96%D+F%D9')E<W,*("`@("`@("`@("`@<V5L9BYC
M;W5N="`](#`*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@
M("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ
M"B`@("`@("`@("`@(&EF('-E;&8N8F%S92`]/2!S96QF+FAE860Z"B`@("`@
M("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@(&5L
M="`]('-E;&8N8F%S92YC87-T*'-E;&8N;F]D971Y<&4I+F1E<F5F97)E;F-E
M*"D*("`@("`@("`@("`@<V5L9BYB87-E(#T@96QT6R=?35]N97AT)UT*("`@
M("`@("`@("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@("`@("`@("`@('-E;&8N
M8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@("`@("!V86P@/2!G971?
M=F%L=65?9G)O;5]L:7-T7VYO9&4H96QT*0H@("`@("`@("`@("!R971U<FX@
M*"=;)61=)R`E(&-O=6YT+"!V86PI"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I
M<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(&YO
M9&5T>7!E(#T@9FEN9%]T>7!E*'-E;&8N=F%L+G1Y<&4L("=?3F]D92<I"B`@
M("`@("`@;F]D971Y<&4@/2!N;V1E='EP92YS=')I<%]T>7!E9&5F<R@I+G!O
M:6YT97(H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R871O<BAN;V1E='EP
M92P@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?;F]D92==*0H*("`@(&1E9B!T
M;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYV86Q;)U]-7VEM<&PG
M75LG7TU?;F]D92==+F%D9')E<W,@/3T@<V5L9BYV86Q;)U]-7VEM<&PG75LG
M7TU?;F]D92==6R=?35]N97AT)UTZ"B`@("`@("`@("`@(')E='5R;B`G96UP
M='D@)7,G("4@*'-E;&8N='EP96YA;64I"B`@("`@("`@<F5T=7)N("<E<R<@
M)2`H<V5L9BYT>7!E;F%M92D*"F-L87-S($YO9&5)=&5R871O<E!R:6YT97(Z
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"P@8V]N=&YA
M;64I.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYT>7!E
M;F%M92`]('1Y<&5N86UE"B`@("`@("`@<V5L9BYC;VYT;F%M92`](&-O;G1N
M86UE"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I9B!N;W0@
M<V5L9BYV86Q;)U]-7VYO9&4G73H*("`@("`@("`@("`@<F5T=7)N("=N;VXM
M9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.B5S)R`E("AS96QF
M+F-O;G1N86UE*0H@("`@("`@(&YO9&5T>7!E(#T@9FEN9%]T>7!E*'-E;&8N
M=F%L+G1Y<&4L("=?3F]D92<I"B`@("`@("`@;F]D971Y<&4@/2!N;V1E='EP
M92YS=')I<%]T>7!E9&5F<R@I+G!O:6YT97(H*0H@("`@("`@(&YO9&4@/2!S
M96QF+G9A;%LG7TU?;F]D92==+F-A<W0H;F]D971Y<&4I+F1E<F5F97)E;F-E
M*"D*("`@("`@("!R971U<FX@<W1R*&=E=%]V86QU95]F<F]M7VQI<W1?;F]D
M92AN;V1E*2D*"F-L87-S(%-T9$QI<W1)=&5R871O<E!R:6YT97(H3F]D94ET
M97)A=&]R4')I;G1E<BDZ"B`@("`B4')I;G0@<W1D.CIL:7-T.CII=&5R871O
M<B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@
M("`@("`@3F]D94ET97)A=&]R4')I;G1E<BY?7VEN:71?7RAS96QF+"!T>7!E
M;F%M92P@=F%L+"`G;&ES="<I"@IC;&%S<R!3=&1&=V1,:7-T271E<F%T;W)0
M<FEN=&5R*$YO9&5)=&5R871O<E!R:6YT97(I.@H@("`@(E!R:6YT('-T9#HZ
M9F]R=V%R9%]L:7-T.CII=&5R871O<B(*"B`@("!D968@7U]I;FET7U\H<V5L
M9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@3F]D94ET97)A=&]R4')I;G1E
M<BY?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L+"`G9F]R=V%R9%]L:7-T
M)RD*"F-L87-S(%-T9%-L:7-T4')I;G1E<CH*("`@(")0<FEN="!A(%]?9VYU
M7V-X>#HZ<VQI<W0B"@H@("`@8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*
M("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@;F]D971Y<&4L(&AE860I.@H@
M("`@("`@("`@("!S96QF+FYO9&5T>7!E(#T@;F]D971Y<&4*("`@("`@("`@
M("`@<V5L9BYB87-E(#T@:&5A9%LG7TU?:&5A9"==6R=?35]N97AT)UT*("`@
M("`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@("`@("`@9&5F(%]?:71E<E]?
M*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@
M7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N8F%S92`]/2`P
M.@H@("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@
M("`@("!E;'0@/2!S96QF+F)A<V4N8V%S="AS96QF+FYO9&5T>7!E*2YD97)E
M9F5R96YC92@I"B`@("`@("`@("`@('-E;&8N8F%S92`](&5L=%LG7TU?;F5X
M="=="B`@("`@("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@("`@("`@("`@
M("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@("`@<F5T
M=7)N("@G6R5D72<@)2!C;W5N="P@96QT6R=?35]D871A)UTI"@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(&YO
M9&5T>7!E(#T@9FEN9%]T>7!E*'-E;&8N=F%L+G1Y<&4L("=?3F]D92<I"B`@
M("`@("`@;F]D971Y<&4@/2!N;V1E='EP92YS=')I<%]T>7!E9&5F<R@I+G!O
M:6YT97(H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R871O<BAN;V1E='EP
M92P@<V5L9BYV86PI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@
M("!I9B!S96QF+G9A;%LG7TU?:&5A9"==6R=?35]N97AT)UT@/3T@,#H*("`@
M("`@("`@("`@<F5T=7)N("=E;7!T>2!?7V=N=5]C>'@Z.G-L:7-T)PH@("`@
M("`@(')E='5R;B`G7U]G;G5?8WAX.CIS;&ES="<*"F-L87-S(%-T9%-L:7-T
M271E<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT(%]?9VYU7V-X>#HZ<VQI<W0Z
M.FET97)A=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@
M=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!T;U]S=')I
M;F<H<V5L9BDZ"B`@("`@("`@:68@;F]T('-E;&8N=F%L6R=?35]N;V1E)UTZ
M"B`@("`@("`@("`@(')E='5R;B`G;F]N+61E<F5F97)E;F-E86)L92!I=&5R
M871O<B!F;W(@7U]G;G5?8WAX.CIS;&ES="<*("`@("`@("!N;V1E='EP92`]
M(&9I;F1?='EP92AS96QF+G9A;"YT>7!E+"`G7TYO9&4G*0H@("`@("`@(&YO
M9&5T>7!E(#T@;F]D971Y<&4N<W1R:7!?='EP961E9G,H*2YP;VEN=&5R*"D*
M("`@("`@("!R971U<FX@<W1R*'-E;&8N=F%L6R=?35]N;V1E)UTN8V%S="AN
M;V1E='EP92DN9&5R969E<F5N8V4H*5LG7TU?9&%T82==*0H*8VQA<W,@4W1D
M5F5C=&]R4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ=F5C=&]R(@H*("`@
M(&-L87-S(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI
M=%]?("AS96QF+"!S=&%R="P@9FEN:7-H+"!B:71V96,I.@H@("`@("`@("`@
M("!S96QF+F)I='9E8R`](&)I='9E8PH@("`@("`@("`@("!I9B!B:71V96,Z
M"B`@("`@("`@("`@("`@("!S96QF+FET96T@("`]('-T87)T6R=?35]P)UT*
M("`@("`@("`@("`@("`@('-E;&8N<V\@("`@(#T@<W1A<G1;)U]-7V]F9G-E
M="=="B`@("`@("`@("`@("`@("!S96QF+F9I;FES:"`](&9I;FES:%LG7TU?
M<"=="B`@("`@("`@("`@("`@("!S96QF+F9O("`@("`](&9I;FES:%LG7TU?
M;V9F<V5T)UT*("`@("`@("`@("`@("`@(&ET>7!E(#T@<V5L9BYI=&5M+F1E
M<F5F97)E;F-E*"DN='EP90H@("`@("`@("`@("`@("`@<V5L9BYI<VEZ92`]
M(#@@*B!I='EP92YS:7IE;V8*("`@("`@("`@("`@96QS93H*("`@("`@("`@
M("`@("`@('-E;&8N:71E;2`]('-T87)T"B`@("`@("`@("`@("`@("!S96QF
M+F9I;FES:"`](&9I;FES:`H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*
M("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E='5R
M;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("`@
M("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@("`@("`@("`@('-E;&8N8V]U;G0@
M/2!S96QF+F-O=6YT("L@,0H@("`@("`@("`@("!I9B!S96QF+F)I='9E8SH*
M("`@("`@("`@("`@("`@(&EF('-E;&8N:71E;2`]/2!S96QF+F9I;FES:"!A
M;F0@<V5L9BYS;R`^/2!S96QF+F9O.@H@("`@("`@("`@("`@("`@("`@(')A
M:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@("`@(&5L="`]('-E;&8N
M:71E;2YD97)E9F5R96YC92@I"B`@("`@("`@("`@("`@("!I9B!E;'0@)B`H
M,2`\/"!S96QF+G-O*3H*("`@("`@("`@("`@("`@("`@("!O8FET(#T@,0H@
M("`@("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@("`@("!O8FET
M(#T@,`H@("`@("`@("`@("`@("`@<V5L9BYS;R`]('-E;&8N<V\@*R`Q"B`@
M("`@("`@("`@("`@("!I9B!S96QF+G-O(#X]('-E;&8N:7-I>F4Z"B`@("`@
M("`@("`@("`@("`@("`@<V5L9BYI=&5M(#T@<V5L9BYI=&5M("L@,0H@("`@
M("`@("`@("`@("`@("`@('-E;&8N<V\@/2`P"B`@("`@("`@("`@("`@("!R
M971U<FX@*"=;)61=)R`E(&-O=6YT+"!O8FET*0H@("`@("`@("`@("!E;'-E
M.@H@("`@("`@("`@("`@("`@:68@<V5L9BYI=&5M(#T]('-E;&8N9FEN:7-H
M.@H@("`@("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@
M("`@("`@("`@("`@(&5L="`]('-E;&8N:71E;2YD97)E9F5R96YC92@I"B`@
M("`@("`@("`@("`@("!S96QF+FET96T@/2!S96QF+FET96T@*R`Q"B`@("`@
M("`@("`@("`@("!R971U<FX@*"=;)61=)R`E(&-O=6YT+"!E;'0I"@H@("`@
M9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E
M;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N
M86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYI<U]B
M;V]L(#T@=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"DN8V]D92`@/3T@
M9V1B+E194$5?0T]$15]"3T],"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@
M("`@("`@(')E='5R;B!S96QF+E]I=&5R871O<BAS96QF+G9A;%LG7TU?:6UP
M;"==6R=?35]S=&%R="==+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G72P*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@<V5L9BYI<U]B;V]L*0H*("`@(&1E9B!T
M;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@<W1A<G0@/2!S96QF+G9A;%LG7TU?
M:6UP;"==6R=?35]S=&%R="=="B`@("`@("`@9FEN:7-H(#T@<V5L9BYV86Q;
M)U]-7VEM<&PG75LG7TU?9FEN:7-H)UT*("`@("`@("!E;F0@/2!S96QF+G9A
M;%LG7TU?:6UP;"==6R=?35]E;F1?;V9?<W1O<F%G92=="B`@("`@("`@:68@
M<V5L9BYI<U]B;V]L.@H@("`@("`@("`@("!S=&%R="`]('-E;&8N=F%L6R=?
M35]I;7!L)UU;)U]-7W-T87)T)UU;)U]-7W`G70H@("`@("`@("`@("!S;R`@
M("`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;)U]-7V]F9G-E
M="=="B`@("`@("`@("`@(&9I;FES:"`]('-E;&8N=F%L6R=?35]I;7!L)UU;
M)U]-7V9I;FES:"==6R=?35]P)UT*("`@("`@("`@("`@9F\@("`@(#T@<V5L
M9BYV86Q;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7V]F9G-E="=="B`@
M("`@("`@("`@(&ET>7!E(#T@<W1A<G0N9&5R969E<F5N8V4H*2YT>7!E"B`@
M("`@("`@("`@(&)L(#T@."`J(&ET>7!E+G-I>F5O9@H@("`@("`@("`@("!L
M96YG=&@@("`]("AB;"`M('-O*2`K(&)L("H@*"AF:6YI<V@@+2!S=&%R="D@
M+2`Q*2`K(&9O"B`@("`@("`@("`@(&-A<&%C:71Y(#T@8FP@*B`H96YD("T@
M<W1A<G0I"B`@("`@("`@("`@(')E='5R;B`H)R5S/&)O;VP^(&]F(&QE;F=T
M:"`E9"P@8V%P86-I='D@)60G"B`@("`@("`@("`@("`@("`@("`@)2`H<V5L
M9BYT>7!E;F%M92P@:6YT("AL96YG=&@I+"!I;G0@*&-A<&%C:71Y*2DI"B`@
M("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N("@G)7,@;V8@;&5N9W1H
M("5D+"!C87!A8VET>2`E9"<*("`@("`@("`@("`@("`@("`@("`E("AS96QF
M+G1Y<&5N86UE+"!I;G0@*&9I;FES:"`M('-T87)T*2P@:6YT("AE;F0@+2!S
M=&%R="DI*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0H<V5L9BDZ"B`@("`@("`@
M<F5T=7)N("=A<G)A>2<*"F-L87-S(%-T9%9E8W1O<DET97)A=&]R4')I;G1E
M<CH*("`@(")0<FEN="!S=&0Z.G9E8W1O<CHZ:71E<F%T;W(B"@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I
M9B!N;W0@<V5L9BYV86Q;)U]-7V-U<G)E;G0G73H*("`@("`@("`@("`@<F5T
M=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.G9E
M8W1O<B<*("`@("`@("!R971U<FX@<W1R*'-E;&8N=F%L6R=?35]C=7)R96YT
M)UTN9&5R969E<F5N8V4H*2D*"F-L87-S(%-T9%1U<&QE4')I;G1E<CH*("`@
M(")0<FEN="!A('-T9#HZ='5P;&4B"@H@("`@8VQA<W,@7VET97)A=&]R*$ET
M97)A=&]R*3H*("`@("`@("!`<W1A=&EC;65T:&]D"B`@("`@("`@9&5F(%]I
M<U]N;VYE;7!T>5]T=7!L92`H;F]D97,I.@H@("`@("`@("`@("!I9B!L96X@
M*&YO9&5S*2`]/2`R.@H@("`@("`@("`@("`@("`@:68@:7-?<W!E8VEA;&EZ
M871I;VY?;V8@*&YO9&5S6S%=+G1Y<&4L("=?7W1U<&QE7V)A<V4G*3H*("`@
M("`@("`@("`@("`@("`@("!R971U<FX@5')U90H@("`@("`@("`@("!E;&EF
M(&QE;B`H;F]D97,I(#T](#$Z"B`@("`@("`@("`@("`@("!R971U<FX@5')U
M90H@("`@("`@("`@("!E;&EF(&QE;B`H;F]D97,I(#T](#`Z"B`@("`@("`@
M("`@("`@("!R971U<FX@1F%L<V4*("`@("`@("`@("`@<F%I<V4@5F%L=65%
M<G)O<B@B5&]P(&]F('1U<&QE('1R964@9&]E<R!N;W0@8V]N<VES="!O9B!A
M('-I;F=L92!N;V1E+B(I"@H@("`@("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@
M:&5A9"DZ"B`@("`@("`@("`@('-E;&8N:&5A9"`](&AE860*"B`@("`@("`@
M("`@(",@4V5T('1H92!B87-E(&-L87-S(&%S('1H92!I;FET:6%L(&AE860@
M;V8@=&AE"B`@("`@("`@("`@(",@='5P;&4N"B`@("`@("`@("`@(&YO9&5S
M(#T@<V5L9BYH96%D+G1Y<&4N9FEE;&1S("@I"B`@("`@("`@("`@(&EF('-E
M;&8N7VES7VYO;F5M<'1Y7W1U<&QE("AN;V1E<RDZ"B`@("`@("`@("`@("`@
M("`C(%-E="!T:&4@86-T=6%L(&AE860@=&\@=&AE(&9I<G-T('!A:7(N"B`@
M("`@("`@("`@("`@("!S96QF+FAE860@(#T@<V5L9BYH96%D+F-A<W0@*&YO
M9&5S6S!=+G1Y<&4I"B`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@
M("`@(&1E9B!?7VET97)?7R`H<V5L9BDZ"B`@("`@("`@("`@(')E='5R;B!S
M96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7R`H<V5L9BDZ"B`@("`@("`@("`@
M(",@0VAE8VL@9F]R(&9U<G1H97(@<F5C=7)S:6]N<R!I;B!T:&4@:6YH97)I
M=&%N8V4@=')E92X*("`@("`@("`@("`@(R!&;W(@82!'0T,@-2L@='5P;&4@
M<V5L9BYH96%D(&ES($YO;F4@869T97(@=FES:71I;F<@86QL(&YO9&5S.@H@
M("`@("`@("`@("!I9B!N;W0@<V5L9BYH96%D.@H@("`@("`@("`@("`@("`@
M<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!N;V1E<R`]('-E;&8N
M:&5A9"YT>7!E+F9I96QD<R`H*0H@("`@("`@("`@("`C($9O<B!A($=#0R`T
M+G@@='5P;&4@=&AE<F4@:7,@82!F:6YA;"!N;V1E('=I=&@@;F\@9FEE;&1S
M.@H@("`@("`@("`@("!I9B!L96X@*&YO9&5S*2`]/2`P.@H@("`@("`@("`@
M("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("`C($-H96-K
M('1H870@=&AI<R!I=&5R871I;VX@:&%S(&%N(&5X<&5C=&5D('-T<G5C='5R
M92X*("`@("`@("`@("`@:68@;&5N("AN;V1E<RD@/B`R.@H@("`@("`@("`@
M("`@("`@<F%I<V4@5F%L=65%<G)O<B@B0V%N;F]T('!A<G-E(&UO<F4@=&AA
M;B`R(&YO9&5S(&EN(&$@='5P;&4@=')E92XB*0H*("`@("`@("`@("`@:68@
M;&5N("AN;V1E<RD@/3T@,3H*("`@("`@("`@("`@("`@(",@5&AI<R!I<R!T
M:&4@;&%S="!N;V1E(&]F(&$@1T-#(#4K('-T9#HZ='5P;&4N"B`@("`@("`@
M("`@("`@("!I;7!L(#T@<V5L9BYH96%D+F-A<W0@*&YO9&5S6S!=+G1Y<&4I
M"B`@("`@("`@("`@("`@("!S96QF+FAE860@/2!.;VYE"B`@("`@("`@("`@
M(&5L<V4Z"B`@("`@("`@("`@("`@("`C($5I=&AE<B!A(&YO9&4@8F5F;W)E
M('1H92!L87-T(&YO9&4L(&]R('1H92!L87-T(&YO9&4@;V8*("`@("`@("`@
M("`@("`@(",@82!'0T,@-"YX('1U<&QE("AW:&EC:"!H87,@86X@96UP='D@
M<&%R96YT*2X*"B`@("`@("`@("`@("`@("`C("T@3&5F="!N;V1E(&ES('1H
M92!N97AT(')E8W5R<VEO;B!P87)E;G0N"B`@("`@("`@("`@("`@("`C("T@
M4FEG:'0@;F]D92!I<R!T:&4@86-T=6%L(&-L87-S(&-O;G1A:6YE9"!I;B!T
M:&4@='5P;&4N"@H@("`@("`@("`@("`@("`@(R!0<F]C97-S(')I9VAT(&YO
M9&4N"B`@("`@("`@("`@("`@("!I;7!L(#T@<V5L9BYH96%D+F-A<W0@*&YO
M9&5S6S%=+G1Y<&4I"@H@("`@("`@("`@("`@("`@(R!0<F]C97-S(&QE9G0@
M;F]D92!A;F0@<V5T(&ET(&%S(&AE860N"B`@("`@("`@("`@("`@("!S96QF
M+FAE860@(#T@<V5L9BYH96%D+F-A<W0@*&YO9&5S6S!=+G1Y<&4I"@H@("`@
M("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*"B`@("`@("`@
M("`@(",@1FEN86QL>2P@8VAE8VL@=&AE(&EM<&QE;65N=&%T:6]N+B`@268@
M:70@:7,*("`@("`@("`@("`@(R!W<F%P<&5D(&EN(%]-7VAE861?:6UP;"!R
M971U<FX@=&AA="P@;W1H97)W:7-E(')E='5R;@H@("`@("`@("`@("`C('1H
M92!V86QU92`B87,@:7,B+@H@("`@("`@("`@("!F:65L9',@/2!I;7!L+G1Y
M<&4N9FEE;&1S("@I"B`@("`@("`@("`@(&EF(&QE;B`H9FEE;&1S*2`\(#$@
M;W(@9FEE;&1S6S!=+FYA;64@(3T@(E]-7VAE861?:6UP;"(Z"B`@("`@("`@
M("`@("`@("!R971U<FX@*"=;)61=)R`E('-E;&8N8V]U;G0L(&EM<&PI"B`@
M("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!R971U<FX@*"=;)61=
M)R`E('-E;&8N8V]U;G0L(&EM<&Q;)U]-7VAE861?:6UP;"==*0H*("`@(&1E
M9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L
M9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA
M;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P["@H@("`@9&5F(&-H:6QD<F5N
M("AS96QF*3H*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T;W(@*'-E;&8N
M=F%L*0H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@(&EF(&QE
M;B`H<V5L9BYV86PN='EP92YF:65L9',@*"DI(#T](#`Z"B`@("`@("`@("`@
M(')E='5R;B`G96UP='D@)7,G("4@*'-E;&8N='EP96YA;64I"B`@("`@("`@
M<F5T=7)N("<E<R!C;VYT86EN:6YG)R`E("AS96QF+G1Y<&5N86UE*0H*8VQA
M<W,@4W1D4W1A8VM/<E%U975E4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ
M<W1A8VL@;W(@<W1D.CIQ=65U92(*"B`@("!D968@7U]I;FET7U\@*'-E;&8L
M('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I
M<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N
M=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H=F%L6R=C)UTI
M"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!R971U<FX@<V5L
M9BYV:7-U86QI>F5R+F-H:6QD<F5N*"D*"B`@("!D968@=&]?<W1R:6YG("AS
M96QF*3H*("`@("`@("!R971U<FX@)R5S('=R87!P:6YG.B`E<R<@)2`H<V5L
M9BYT>7!E;F%M92P*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@<V5L9BYV:7-U86QI>F5R+G1O7W-T<FEN9R@I*0H*("`@(&1E9B!D:7-P
M;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(&EF(&AA<V%T='(@*'-E;&8N=FES
M=6%L:7IE<BP@)V1I<W!L87E?:&EN="<I.@H@("`@("`@("`@("!R971U<FX@
M<V5L9BYV:7-U86QI>F5R+F1I<W!L87E?:&EN="`H*0H@("`@("`@(')E='5R
M;B!.;VYE"@IC;&%S<R!28G1R965)=&5R871O<BA)=&5R871O<BDZ"B`@("`B
M(B(*("`@(%1U<FX@86X@4D(M=')E92UB87-E9"!C;VYT86EN97(@*'-T9#HZ
M;6%P+"!S=&0Z.G-E="!E=&,N*2!I;G1O"B`@("!A(%!Y=&AO;B!I=&5R86)L
M92!O8FIE8W0N"B`@("`B(B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@<F)T
M<F5E*3H*("`@("`@("!S96QF+G-I>F4@/2!R8G1R965;)U]-7W0G75LG7TU?
M:6UP;"==6R=?35]N;V1E7V-O=6YT)UT*("`@("`@("!S96QF+FYO9&4@/2!R
M8G1R965;)U]-7W0G75LG7TU?:6UP;"==6R=?35]H96%D97(G75LG7TU?;&5F
M="=="B`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@("!D968@7U]I=&5R7U\H
M<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8*"B`@("!D968@7U]L96Y?7RAS
M96QF*3H*("`@("`@("!R971U<FX@:6YT("AS96QF+G-I>F4I"@H@("`@9&5F
M(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N8V]U;G0@/3T@<V5L
M9BYS:7IE.@H@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@
M("`@<F5S=6QT(#T@<V5L9BYN;V1E"B`@("`@("`@<V5L9BYC;W5N="`]('-E
M;&8N8V]U;G0@*R`Q"B`@("`@("`@:68@<V5L9BYC;W5N="`\('-E;&8N<VEZ
M93H*("`@("`@("`@("`@(R!#;VUP=71E('1H92!N97AT(&YO9&4N"B`@("`@
M("`@("`@(&YO9&4@/2!S96QF+FYO9&4*("`@("`@("`@("`@:68@;F]D92YD
M97)E9F5R96YC92@I6R=?35]R:6=H="==.@H@("`@("`@("`@("`@("`@;F]D
M92`](&YO9&4N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G70H@("`@("`@("`@
M("`@("`@=VAI;&4@;F]D92YD97)E9F5R96YC92@I6R=?35]L969T)UTZ"B`@
M("`@("`@("`@("`@("`@("`@;F]D92`](&YO9&4N9&5R969E<F5N8V4H*5LG
M7TU?;&5F="=="B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!P
M87)E;G0@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7W!A<F5N="=="B`@("`@
M("`@("`@("`@("!W:&EL92!N;V1E(#T]('!A<F5N="YD97)E9F5R96YC92@I
M6R=?35]R:6=H="==.@H@("`@("`@("`@("`@("`@("`@(&YO9&4@/2!P87)E
M;G0*("`@("`@("`@("`@("`@("`@("!P87)E;G0@/2!P87)E;G0N9&5R969E
M<F5N8V4H*5LG7TU?<&%R96YT)UT*("`@("`@("`@("`@("`@(&EF(&YO9&4N
M9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G72`A/2!P87)E;G0Z"B`@("`@("`@
M("`@("`@("`@("`@;F]D92`]('!A<F5N=`H@("`@("`@("`@("!S96QF+FYO
M9&4@/2!N;V1E"B`@("`@("`@<F5T=7)N(')E<W5L=`H*9&5F(&=E=%]V86QU
M95]F<F]M7U)B7W1R965?;F]D92AN;V1E*3H*("`@("(B(E)E='5R;G,@=&AE
M('9A;'5E(&AE;&0@:6X@86X@7U)B7W1R965?;F]D93Q?5F%L/B(B(@H@("`@
M=')Y.@H@("`@("`@(&UE;6)E<B`](&YO9&4N='EP92YF:65L9',H*5LQ72YN
M86UE"B`@("`@("`@:68@;65M8F5R(#T]("=?35]V86QU95]F:65L9"<Z"B`@
M("`@("`@("`@(",@0RLK,#,@:6UP;&5M96YT871I;VXL(&YO9&4@8V]N=&%I
M;G,@=&AE('9A;'5E(&%S(&$@;65M8F5R"B`@("`@("`@("`@(')E='5R;B!N
M;V1E6R=?35]V86QU95]F:65L9"=="B`@("`@("`@96QI9B!M96UB97(@/3T@
M)U]-7W-T;W)A9V4G.@H@("`@("`@("`@("`C($,K*S$Q(&EM<&QE;65N=&%T
M:6]N+"!N;V1E('-T;W)E<R!V86QU92!I;B!?7V%L:6=N961?;65M8G5F"B`@
M("`@("`@("`@('9A;'1Y<&4@/2!N;V1E+G1Y<&4N=&5M<&QA=&5?87)G=6UE
M;G0H,"D*("`@("`@("`@("`@<F5T=7)N(&=E=%]V86QU95]F<F]M7V%L:6=N
M961?;65M8G5F*&YO9&5;)U]-7W-T;W)A9V4G72P@=F%L='EP92D*("`@(&5X
M8V5P=#H*("`@("`@("!P87-S"B`@("!R86ES92!686QU945R<F]R*")5;G-U
M<'!O<G1E9"!I;7!L96UE;G1A=&EO;B!F;W(@)7,B("4@<W1R*&YO9&4N='EP
M92DI"@HC(%1H:7,@:7,@82!P<F5T='D@<')I;G1E<B!F;W(@<W1D.CI?4F)?
M=')E95]I=&5R871O<B`H=VAI8V@@:7,*(R!S=&0Z.FUA<#HZ:71E<F%T;W(I
M+"!A;F0@:&%S(&YO=&AI;F<@=&\@9&\@=VET:"!T:&4@4F)T<F5E271E<F%T
M;W(*(R!C;&%S<R!A8F]V92X*8VQA<W,@4W1D4F)T<F5E271E<F%T;W)0<FEN
M=&5R.@H@("`@(E!R:6YT('-T9#HZ;6%P.CII=&5R871O<BP@<W1D.CIS970Z
M.FET97)A=&]R+"!E=&,N(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP
M96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*("`@("`@("!V
M86QT>7!E(#T@<V5L9BYV86PN='EP92YT96UP;&%T95]A<F=U;65N="@P*2YS
M=')I<%]T>7!E9&5F<R@I"B`@("`@("`@;F]D971Y<&4@/2`G7U)B7W1R965?
M;F]D93PG("L@<W1R*'9A;'1Y<&4I("L@)SXG"B`@("`@("`@:68@7W9E<G-I
M;VYE9%]N86UE<W!A8V4@86YD('1Y<&5N86UE+G-T87)T<W=I=&@H)W-T9#HZ
M)R`K(%]V97)S:6]N961?;F%M97-P86-E*3H*("`@("`@("`@("`@;F]D971Y
M<&4@/2!?=F5R<VEO;F5D7VYA;65S<&%C92`K(&YO9&5T>7!E"B`@("`@("`@
M;F]D971Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H)W-T9#HZ)R`K(&YO9&5T>7!E
M*0H@("`@("`@('-E;&8N;&EN:U]T>7!E(#T@;F]D971Y<&4N<W1R:7!?='EP
M961E9G,H*2YP;VEN=&5R*"D*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*
M("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-7VYO9&4G73H*("`@("`@("`@
M("`@<F5T=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!A
M<W-O8VEA=&EV92!C;VYT86EN97(G"B`@("`@("`@;F]D92`]('-E;&8N=F%L
M6R=?35]N;V1E)UTN8V%S="AS96QF+FQI;FM?='EP92DN9&5R969E<F5N8V4H
M*0H@("`@("`@(')E='5R;B!S='(H9V5T7W9A;'5E7V9R;VU?4F)?=')E95]N
M;V1E*&YO9&4I*0H*8VQA<W,@4W1D1&5B=6=)=&5R871O<E!R:6YT97(Z"B`@
M("`B4')I;G0@82!D96)U9R!E;F%B;&5D('9E<G-I;VX@;V8@86X@:71E<F%T
M;W(B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*
M("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(",@2G5S="!S=')I<"!A=V%Y
M('1H92!E;F-A<'-U;&%T:6YG(%]?9VYU7V1E8G5G.CI?4V%F95]I=&5R871O
M<@H@("`@(R!A;F0@<F5T=7)N('1H92!W<F%P<&5D(&ET97)A=&]R('9A;'5E
M+@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@8F%S95]T>7!E
M(#T@9V1B+FQO;VMU<%]T>7!E*"=?7V=N=5]D96)U9SHZ7U-A9F5?:71E<F%T
M;W)?8F%S92<I"B`@("`@("`@:71Y<&4@/2!S96QF+G9A;"YT>7!E+G1E;7!L
M871E7V%R9W5M96YT*#`I"B`@("`@("`@<V%F95]S97$@/2!S96QF+G9A;"YC
M87-T*&)A<V5?='EP92E;)U]-7W-E<75E;F-E)UT*("`@("`@("!I9B!N;W0@
M<V%F95]S97$Z"B`@("`@("`@("`@(')E='5R;B!S='(H<V5L9BYV86PN8V%S
M="AI='EP92DI"B`@("`@("`@:68@<V5L9BYV86Q;)U]-7W9E<G-I;VXG72`A
M/2!S869E7W-E<5LG7TU?=F5R<VEO;B==.@H@("`@("`@("`@("!R971U<FX@
M(FEN=F%L:60@:71E<F%T;W(B"B`@("`@("`@<F5T=7)N('-T<BAS96QF+G9A
M;"YC87-T*&ET>7!E*2D*"F1E9B!N=6U?96QE;65N=',H;G5M*3H*("`@("(B
M(E)E='5R;B!E:71H97(@(C$@96QE;65N="(@;W(@(DX@96QE;65N=',B(&1E
M<&5N9&EN9R!O;B!T:&4@87)G=6UE;G0N(B(B"B`@("!R971U<FX@)S$@96QE
M;65N="<@:68@;G5M(#T](#$@96QS92`G)60@96QE;65N=',G("4@;G5M"@IC
M;&%S<R!3=&1-87!0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIM87`@;W(@
M<W1D.CIM=6QT:6UA<"(*"B`@("`C(%1U<FX@86X@4F)T<F5E271E<F%T;W(@
M:6YT;R!A('!R971T>2UP<FEN="!I=&5R871O<BX*("`@(&-L87-S(%]I=&5R
M*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@<F)I=&5R
M+"!T>7!E*3H*("`@("`@("`@("`@<V5L9BYR8FET97(@/2!R8FET97(*("`@
M("`@("`@("`@<V5L9BYC;W5N="`](#`*("`@("`@("`@("`@<V5L9BYT>7!E
M(#T@='EP90H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@
M("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*
M("`@("`@("`@("`@:68@<V5L9BYC;W5N="`E(#(@/3T@,#H*("`@("`@("`@
M("`@("`@(&X@/2!N97AT*'-E;&8N<F)I=&5R*0H@("`@("`@("`@("`@("`@
M;B`](&XN8V%S="AS96QF+G1Y<&4I+F1E<F5F97)E;F-E*"D*("`@("`@("`@
M("`@("`@(&X@/2!G971?=F%L=65?9G)O;5]28E]T<F5E7VYO9&4H;BD*("`@
M("`@("`@("`@("`@('-E;&8N<&%I<B`](&X*("`@("`@("`@("`@("`@(&ET
M96T@/2!N6R=F:7)S="=="B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@
M("`@("!I=&5M(#T@<V5L9BYP86ER6R=S96-O;F0G70H@("`@("`@("`@("!R
M97-U;'0@/2`H)ULE9%TG("4@<V5L9BYC;W5N="P@:71E;2D*("`@("`@("`@
M("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@("`@(')E
M='5R;B!R97-U;'0*"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE
M+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N
M961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L
M"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@<F5T=7)N("<E
M<R!W:71H("5S)R`E("AS96QF+G1Y<&5N86UE+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@;G5M7V5L96UE;G1S*&QE;BA28G1R965)=&5R871O
M<B`H<V5L9BYV86PI*2DI"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@
M("`@("!R97!?='EP92`](&9I;F1?='EP92AS96QF+G9A;"YT>7!E+"`G7U)E
M<%]T>7!E)RD*("`@("`@("!N;V1E(#T@9FEN9%]T>7!E*')E<%]T>7!E+"`G
M7TQI;FM?='EP92<I"B`@("`@("`@;F]D92`](&YO9&4N<W1R:7!?='EP961E
M9G,H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R("A28G1R965)=&5R871O
M<B`H<V5L9BYV86PI+"!N;V1E*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E
M;&8I.@H@("`@("`@(')E='5R;B`G;6%P)PH*8VQA<W,@4W1D4V5T4')I;G1E
M<CH*("`@(")0<FEN="!A('-T9#HZ<V5T(&]R('-T9#HZ;75L=&ES970B"@H@
M("`@(R!4=7)N(&%N(%)B=')E94ET97)A=&]R(&EN=&\@82!P<F5T='DM<')I
M;G0@:71E<F%T;W(N"B`@("!C;&%S<R!?:71E<BA)=&5R871O<BDZ"B`@("`@
M("`@9&5F(%]?:6YI=%]?*'-E;&8L(')B:71E<BP@='EP92DZ"B`@("`@("`@
M("`@('-E;&8N<F)I=&5R(#T@<F)I=&5R"B`@("`@("`@("`@('-E;&8N8V]U
M;G0@/2`P"B`@("`@("`@("`@('-E;&8N='EP92`]('1Y<&4*"B`@("`@("`@
M9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*
M("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&ET96T@
M/2!N97AT*'-E;&8N<F)I=&5R*0H@("`@("`@("`@("!I=&5M(#T@:71E;2YC
M87-T*'-E;&8N='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!I=&5M
M(#T@9V5T7W9A;'5E7V9R;VU?4F)?=')E95]N;V1E*&ET96TI"B`@("`@("`@
M("`@(",@1DE8344Z('1H:7,@:7,@=V5I<F0@+BXN('=H870@=&\@9&\_"B`@
M("`@("`@("`@(",@36%Y8F4@82`G<V5T)R!D:7-P;&%Y(&AI;G0_"B`@("`@
M("`@("`@(')E<W5L="`]("@G6R5D72<@)2!S96QF+F-O=6YT+"!I=&5M*0H@
M("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@
M("`@("`@<F5T=7)N(')E<W5L=`H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@
M='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP
M7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV
M86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!R
M971U<FX@)R5S('=I=&@@)7,G("4@*'-E;&8N='EP96YA;64L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("!N=6U?96QE;65N=',H;&5N*%)B=')E
M94ET97)A=&]R("AS96QF+G9A;"DI*2D*"B`@("!D968@8VAI;&1R96X@*'-E
M;&8I.@H@("`@("`@(')E<%]T>7!E(#T@9FEN9%]T>7!E*'-E;&8N=F%L+G1Y
M<&4L("=?4F5P7W1Y<&4G*0H@("`@("`@(&YO9&4@/2!F:6YD7W1Y<&4H<F5P
M7W1Y<&4L("=?3&EN:U]T>7!E)RD*("`@("`@("!N;V1E(#T@;F]D92YS=')I
M<%]T>7!E9&5F<R@I"B`@("`@("`@<F5T=7)N('-E;&8N7VET97(@*%)B=')E
M94ET97)A=&]R("AS96QF+G9A;"DL(&YO9&4I"@IC;&%S<R!3=&1":71S9710
M<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIB:71S970B"@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP
M96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@
M("`@("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L
M9BDZ"B`@("`@("`@(R!)9B!T96UP;&%T95]A<F=U;65N="!H86YD;&5D('9A
M;'5E<RP@=V4@8V]U;&0@<')I;G0@=&AE"B`@("`@("`@(R!S:7IE+B`@3W(@
M=V4@8V]U;&0@=7-E(&$@<F5G97AP(&]N('1H92!T>7!E+@H@("`@("`@(')E
M='5R;B`G)7,G("4@*'-E;&8N='EP96YA;64I"@H@("`@9&5F(&-H:6QD<F5N
M("AS96QF*3H*("`@("`@("!T<GDZ"B`@("`@("`@("`@(",@06X@96UP='D@
M8FET<V5T(&UA>2!N;W0@:&%V92!A;GD@;65M8F5R<R!W:&EC:"!W:6QL"B`@
M("`@("`@("`@(",@<F5S=6QT(&EN(&%N(&5X8V5P=&EO;B!B96EN9R!T:')O
M=VXN"B`@("`@("`@("`@('=O<F1S(#T@<V5L9BYV86Q;)U]-7W<G70H@("`@
M("`@(&5X8V5P=#H*("`@("`@("`@("`@<F5T=7)N(%M="@H@("`@("`@('=T
M>7!E(#T@=V]R9',N='EP90H*("`@("`@("`C(%1H92!?35]W(&UE;6)E<B!C
M86X@8F4@96ET:&5R(&%N('5N<VEG;F5D(&QO;F<L(&]R(&%N"B`@("`@("`@
M(R!A<G)A>2X@(%1H:7,@9&5P96YD<R!O;B!T:&4@=&5M<&QA=&4@<W!E8VEA
M;&EZ871I;VX@=7-E9"X*("`@("`@("`C($EF(&ET(&ES(&$@<VEN9VQE(&QO
M;F<L(&-O;G9E<G0@=&\@82!S:6YG;&4@96QE;65N="!L:7-T+@H@("`@("`@
M(&EF('=T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]!4E)!63H*("`@("`@
M("`@("`@='-I>F4@/2!W='EP92YT87)G970@*"DN<VEZ96]F"B`@("`@("`@
M96QS93H*("`@("`@("`@("`@=V]R9',@/2!;=V]R9'-="B`@("`@("`@("`@
M('1S:7IE(#T@=W1Y<&4N<VEZ96]F"@H@("`@("`@(&YW;W)D<R`]('=T>7!E
M+G-I>F5O9B`O('1S:7IE"B`@("`@("`@<F5S=6QT(#T@6UT*("`@("`@("!B
M>71E(#T@,`H@("`@("`@('=H:6QE(&)Y=&4@/"!N=V]R9',Z"B`@("`@("`@
M("`@('<@/2!W;W)D<UMB>71E70H@("`@("`@("`@("!B:70@/2`P"B`@("`@
M("`@("`@('=H:6QE('<@(3T@,#H*("`@("`@("`@("`@("`@(&EF("AW("8@
M,2D@(3T@,#H*("`@("`@("`@("`@("`@("`@("`C($%N;W1H97(@<W!O="!W
M:&5R92!W92!C;W5L9"!U<V4@)W-E="<_"B`@("`@("`@("`@("`@("`@("`@
M<F5S=6QT+F%P<&5N9"@H)ULE9%TG("4@*&)Y=&4@*B!T<VEZ92`J(#@@*R!B
M:70I+"`Q*2D*("`@("`@("`@("`@("`@(&)I="`](&)I="`K(#$*("`@("`@
M("`@("`@("`@('<@/2!W(#X^(#$*("`@("`@("`@("`@8GET92`](&)Y=&4@
M*R`Q"B`@("`@("`@<F5T=7)N(')E<W5L=`H*8VQA<W,@4W1D1&5Q=650<FEN
M=&5R.@H@("`@(E!R:6YT(&$@<W1D.CID97%U92(*"B`@("!C;&%S<R!?:71E
M<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YO9&4L
M('-T87)T+"!E;F0L(&QA<W0L(&)U9F9E<E]S:7IE*3H*("`@("`@("`@("`@
M<V5L9BYN;V1E(#T@;F]D90H@("`@("`@("`@("!S96QF+G`@/2!S=&%R=`H@
M("`@("`@("`@("!S96QF+F5N9"`](&5N9`H@("`@("`@("`@("!S96QF+FQA
M<W0@/2!L87-T"B`@("`@("`@("`@('-E;&8N8G5F9F5R7W-I>F4@/2!B=69F
M97)?<VEZ90H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*("`@("`@("!D
M968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF"@H@
M("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("`@("`@:68@<V5L
M9BYP(#T]('-E;&8N;&%S=#H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)
M=&5R871I;VX*"B`@("`@("`@("`@(')E<W5L="`]("@G6R5D72<@)2!S96QF
M+F-O=6YT+"!S96QF+G`N9&5R969E<F5N8V4H*2D*("`@("`@("`@("`@<V5L
M9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"@H@("`@("`@("`@("`C($%D=F%N
M8V4@=&AE("=C=7(G('!O:6YT97(N"B`@("`@("`@("`@('-E;&8N<"`]('-E
M;&8N<"`K(#$*("`@("`@("`@("`@:68@<V5L9BYP(#T]('-E;&8N96YD.@H@
M("`@("`@("`@("`@("`@(R!)9B!W92!G;W0@=&\@=&AE(&5N9"!O9B!T:&ES
M(&)U8VME="P@;6]V92!T;R!T:&4*("`@("`@("`@("`@("`@(",@;F5X="!B
M=6-K970N"B`@("`@("`@("`@("`@("!S96QF+FYO9&4@/2!S96QF+FYO9&4@
M*R`Q"B`@("`@("`@("`@("`@("!S96QF+G`@/2!S96QF+FYO9&5;,%T*("`@
M("`@("`@("`@("`@('-E;&8N96YD(#T@<V5L9BYP("L@<V5L9BYB=69F97)?
M<VEZ90H*("`@("`@("`@("`@<F5T=7)N(')E<W5L=`H*("`@(&1E9B!?7VEN
M:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N
M86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@
M("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@('-E;&8N96QT='EP92`]('9A
M;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@<VEZ92`]('-E
M;&8N96QT='EP92YS:7IE;V8*("`@("`@("!I9B!S:7IE(#P@-3$R.@H@("`@
M("`@("`@("!S96QF+F)U9F9E<E]S:7IE(#T@:6YT("@U,3(@+R!S:7IE*0H@
M("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N8G5F9F5R7W-I>F4@/2`Q
M"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!S=&%R="`]('-E
M;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UT*("`@("`@("!E;F0@/2!S
M96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G70H*("`@("`@("!D96QT
M85]N(#T@96YD6R=?35]N;V1E)UT@+2!S=&%R=%LG7TU?;F]D92==("T@,0H@
M("`@("`@(&1E;'1A7W,@/2!S=&%R=%LG7TU?;&%S="==("T@<W1A<G1;)U]-
M7V-U<B=="B`@("`@("`@9&5L=&%?92`](&5N9%LG7TU?8W5R)UT@+2!E;F1;
M)U]-7V9I<G-T)UT*"B`@("`@("`@<VEZ92`]('-E;&8N8G5F9F5R7W-I>F4@
M*B!D96QT85]N("L@9&5L=&%?<R`K(&1E;'1A7V4*"B`@("`@("`@<F5T=7)N
M("<E<R!W:71H("5S)R`E("AS96QF+G1Y<&5N86UE+"!N=6U?96QE;65N=',H
M;&]N9RAS:7IE*2DI"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@
M('-T87)T(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A<G0G70H@("`@
M("`@(&5N9"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="B`@
M("`@("`@<F5T=7)N('-E;&8N7VET97(H<W1A<G1;)U]-7VYO9&4G72P@<W1A
M<G1;)U]-7V-U<B==+"!S=&%R=%LG7TU?;&%S="==+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@(&5N9%LG7TU?8W5R)UTL('-E;&8N8G5F9F5R7W-I>F4I
M"@H@("`@9&5F(&1I<W!L87E?:&EN="`H<V5L9BDZ"B`@("`@("`@<F5T=7)N
M("=A<G)A>2<*"F-L87-S(%-T9$1E<75E271E<F%T;W)0<FEN=&5R.@H@("`@
M(E!R:6YT('-T9#HZ9&5Q=64Z.FET97)A=&]R(@H*("`@(&1E9B!?7VEN:71?
M7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A
M;`H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@;F]T('-E
M;&8N=F%L6R=?35]C=7(G73H*("`@("`@("`@("`@<F5T=7)N("=N;VXM9&5R
M969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.F1E<75E)PH@("`@("`@
M(')E='5R;B!S='(H<V5L9BYV86Q;)U]-7V-U<B==+F1E<F5F97)E;F-E*"DI
M"@IC;&%S<R!3=&13=')I;F=0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIB
M87-I8U]S=')I;F<@;V8@<V]M92!K:6YD(@H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H@
M("`@("`@('-E;&8N;F5W7W-T<FEN9R`]('1Y<&5N86UE+F9I;F0H(CHZ7U]C
M>'@Q,3HZ8F%S:6-?<W1R:6YG(BD@(3T@+3$*"B`@("!D968@=&]?<W1R:6YG
M*'-E;&8I.@H@("`@("`@(",@36%K92!S=7)E("9S=')I;F<@=V]R:W,L('1O
M;RX*("`@("`@("!T>7!E(#T@<V5L9BYV86PN='EP90H@("`@("`@(&EF('1Y
M<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@("`@='EP
M92`]('1Y<&4N=&%R9V5T("@I"@H@("`@("`@(",@0V%L8W5L871E('1H92!L
M96YG=&@@;V8@=&AE('-T<FEN9R!S;R!T:&%T('1O7W-T<FEN9R!R971U<FYS
M"B`@("`@("`@(R!T:&4@<W1R:6YG(&%C8V]R9&EN9R!T;R!L96YG=&@L(&YO
M="!A8V-O<F1I;F<@=&\@9FER<W0@;G5L;`H@("`@("`@(",@96YC;W5N=&5R
M960N"B`@("`@("`@<'1R(#T@<V5L9BYV86P@6R=?35]D871A<&QU<R==6R=?
M35]P)UT*("`@("`@("!I9B!S96QF+FYE=U]S=')I;F<Z"B`@("`@("`@("`@
M(&QE;F=T:"`]('-E;&8N=F%L6R=?35]S=')I;F=?;&5N9W1H)UT*("`@("`@
M("`@("`@(R!H='1P<SHO+W-O=7)C97=A<F4N;W)G+V)U9WII;&QA+W-H;W=?
M8G5G+F-G:3]I9#TQ-S<R.`H@("`@("`@("`@("!P='(@/2!P='(N8V%S="AP
M='(N='EP92YS=')I<%]T>7!E9&5F<R@I*0H@("`@("`@(&5L<V4Z"B`@("`@
M("`@("`@(')E86QT>7!E(#T@='EP92YU;G%U86QI9FEE9"`H*2YS=')I<%]T
M>7!E9&5F<R`H*0H@("`@("`@("`@("!R97!T>7!E(#T@9V1B+FQO;VMU<%]T
M>7!E("AS='(@*')E86QT>7!E*2`K("<Z.E]297`G*2YP;VEN=&5R("@I"B`@
M("`@("`@("`@(&AE861E<B`]('!T<BYC87-T*')E<'1Y<&4I("T@,0H@("`@
M("`@("`@("!L96YG=&@@/2!H96%D97(N9&5R969E<F5N8V4@*"E;)U]-7VQE
M;F=T:"=="B`@("`@("`@:68@:&%S871T<BAP='(L(")L87IY7W-T<FEN9R(I
M.@H@("`@("`@("`@("!R971U<FX@<'1R+FQA>GE?<W1R:6YG("AL96YG=&@@
M/2!L96YG=&@I"B`@("`@("`@<F5T=7)N('!T<BYS=')I;F<@*&QE;F=T:"`]
M(&QE;F=T:"D*"B`@("!D968@9&ES<&QA>5]H:6YT("AS96QF*3H*("`@("`@
M("!R971U<FX@)W-T<FEN9R<*"F-L87-S(%1R,4AA<VAT86)L94ET97)A=&]R
M*$ET97)A=&]R*3H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@:&%S:"DZ"B`@
M("`@("`@<V5L9BYB=6-K971S(#T@:&%S:%LG7TU?8G5C:V5T<R=="B`@("`@
M("`@<V5L9BYB=6-K970@/2`P"B`@("`@("`@<V5L9BYB=6-K971?8V]U;G0@
M/2!H87-H6R=?35]B=6-K971?8V]U;G0G70H@("`@("`@('-E;&8N;F]D95]T
M>7!E(#T@9FEN9%]T>7!E*&AA<V@N='EP92P@)U].;V1E)RDN<&]I;G1E<B@I
M"B`@("`@("`@<V5L9BYN;V1E(#T@,`H@("`@("`@('=H:6QE('-E;&8N8G5C
M:V5T("$]('-E;&8N8G5C:V5T7V-O=6YT.@H@("`@("`@("`@("!S96QF+FYO
M9&4@/2!S96QF+F)U8VME='-;<V5L9BYB=6-K971="B`@("`@("`@("`@(&EF
M('-E;&8N;F]D93H*("`@("`@("`@("`@("`@(&)R96%K"B`@("`@("`@("`@
M('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K970@*R`Q"@H@("`@9&5F(%]?:71E
M<E]?("AS96QF*3H*("`@("`@("!R971U<FX@<V5L9@H*("`@(&1E9B!?7VYE
M>'1?7R`H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYN;V1E(#T](#`Z"B`@("`@
M("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("!N;V1E(#T@<V5L
M9BYN;V1E+F-A<W0H<V5L9BYN;V1E7W1Y<&4I"B`@("`@("`@<F5S=6QT(#T@
M;F]D92YD97)E9F5R96YC92@I6R=?35]V)UT*("`@("`@("!S96QF+FYO9&4@
M/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7VYE>'0G73L*("`@("`@("!I9B!S
M96QF+FYO9&4@/3T@,#H*("`@("`@("`@("`@<V5L9BYB=6-K970@/2!S96QF
M+F)U8VME="`K(#$*("`@("`@("`@("`@=VAI;&4@<V5L9BYB=6-K970@(3T@
M<V5L9BYB=6-K971?8V]U;G0Z"B`@("`@("`@("`@("`@("!S96QF+FYO9&4@
M/2!S96QF+F)U8VME='-;<V5L9BYB=6-K971="B`@("`@("`@("`@("`@("!I
M9B!S96QF+FYO9&4Z"B`@("`@("`@("`@("`@("`@("`@8G)E86L*("`@("`@
M("`@("`@("`@('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K970@*R`Q"B`@("`@
M("`@<F5T=7)N(')E<W5L=`H*8VQA<W,@4W1D2&%S:'1A8FQE271E<F%T;W(H
M271E<F%T;W(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&AA<V@I.@H@("`@
M("`@('-E;&8N;F]D92`](&AA<VA;)U]-7V)E9F]R95]B96=I;B==6R=?35]N
M>'0G70H@("`@("`@('-E;&8N;F]D95]T>7!E(#T@9FEN9%]T>7!E*&AA<V@N
M='EP92P@)U]?;F]D95]T>7!E)RDN<&]I;G1E<B@I"@H@("`@9&5F(%]?:71E
M<E]?*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF"@H@("`@9&5F(%]?;F5X
M=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N;F]D92`]/2`P.@H@("`@("`@
M("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@96QT(#T@<V5L9BYN
M;V1E+F-A<W0H<V5L9BYN;V1E7W1Y<&4I+F1E<F5F97)E;F-E*"D*("`@("`@
M("!S96QF+FYO9&4@/2!E;'1;)U]-7VYX="=="B`@("`@("`@=F%L<'1R(#T@
M96QT6R=?35]S=&]R86=E)UTN861D<F5S<PH@("`@("`@('9A;'!T<B`]('9A
M;'!T<BYC87-T*&5L="YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I+G!O:6YT
M97(H*2D*("`@("`@("!R971U<FX@=F%L<'1R+F1E<F5F97)E;F-E*"D*"F-L
M87-S(%1R,55N;W)D97)E9%-E=%!R:6YT97(Z"B`@("`B4')I;G0@82!T<C$Z
M.G5N;W)D97)E9%]S970B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E
M;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R
M<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G9A;"`]
M('9A;`H*("`@(&1E9B!H87-H=&%B;&4@*'-E;&8I.@H@("`@("`@(&EF('-E
M;&8N='EP96YA;64N<W1A<G1S=VET:"@G<W1D.CIT<C$G*3H*("`@("`@("`@
M("`@<F5T=7)N('-E;&8N=F%L"B`@("`@("`@<F5T=7)N('-E;&8N=F%L6R=?
M35]H)UT*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!C;W5N
M="`]('-E;&8N:&%S:'1A8FQE*"E;)U]-7V5L96UE;G1?8V]U;G0G70H@("`@
M("`@(')E='5R;B`G)7,@=VET:"`E<R<@)2`H<V5L9BYT>7!E;F%M92P@;G5M
M7V5L96UE;G1S*&-O=6YT*2D*"B`@("!`<W1A=&EC;65T:&]D"B`@("!D968@
M9F]R;6%T7V-O=6YT("AI*3H*("`@("`@("!R971U<FX@)ULE9%TG("4@:0H*
M("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@8V]U;G1E<B`](&EM
M87`@*'-E;&8N9F]R;6%T7V-O=6YT+"!I=&5R=&]O;',N8V]U;G0H*2D*("`@
M("`@("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H)W-T9#HZ='(Q)RDZ
M"B`@("`@("`@("`@(')E='5R;B!I>FEP("AC;W5N=&5R+"!4<C%(87-H=&%B
M;&5)=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI"B`@("`@("`@<F5T=7)N
M(&EZ:7`@*&-O=6YT97(L(%-T9$AA<VAT86)L94ET97)A=&]R("AS96QF+FAA
M<VAT86)L92@I*2D*"F-L87-S(%1R,55N;W)D97)E9$UA<%!R:6YT97(Z"B`@
M("`B4')I;G0@82!T<C$Z.G5N;W)D97)E9%]M87`B"@H@("`@9&5F(%]?:6YI
M=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N
M86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@
M("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!H87-H=&%B;&4@*'-E;&8I
M.@H@("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S=VET:"@G<W1D.CIT
M<C$G*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=F%L"B`@("`@("`@<F5T
M=7)N('-E;&8N=F%L6R=?35]H)UT*"B`@("!D968@=&]?<W1R:6YG("AS96QF
M*3H*("`@("`@("!C;W5N="`]('-E;&8N:&%S:'1A8FQE*"E;)U]-7V5L96UE
M;G1?8V]U;G0G70H@("`@("`@(')E='5R;B`G)7,@=VET:"`E<R<@)2`H<V5L
M9BYT>7!E;F%M92P@;G5M7V5L96UE;G1S*&-O=6YT*2D*"B`@("!`<W1A=&EC
M;65T:&]D"B`@("!D968@9FQA='1E;B`H;&ES="DZ"B`@("`@("`@9F]R(&5L
M="!I;B!L:7-T.@H@("`@("`@("`@("!F;W(@:2!I;B!E;'0Z"B`@("`@("`@
M("`@("`@("!Y:65L9"!I"@H@("`@0'-T871I8VUE=&AO9`H@("`@9&5F(&9O
M<FUA=%]O;F4@*&5L="DZ"B`@("`@("`@<F5T=7)N("AE;'1;)V9I<G-T)UTL
M(&5L=%LG<V5C;VYD)UTI"@H@("`@0'-T871I8VUE=&AO9`H@("`@9&5F(&9O
M<FUA=%]C;W5N="`H:2DZ"B`@("`@("`@<F5T=7)N("=;)61=)R`E(&D*"B`@
M("!D968@8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(&-O=6YT97(@/2!I;6%P
M("AS96QF+F9O<FUA=%]C;W5N="P@:71E<G1O;VQS+F-O=6YT*"DI"B`@("`@
M("`@(R!-87`@;W9E<B!T:&4@:&%S:"!T86)L92!A;F0@9FQA='1E;B!T:&4@
M<F5S=6QT+@H@("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S=VET:"@G
M<W1D.CIT<C$G*3H*("`@("`@("`@("`@9&%T82`]('-E;&8N9FQA='1E;B`H
M:6UA<"`H<V5L9BYF;W)M871?;VYE+"!4<C%(87-H=&%B;&5)=&5R871O<B`H
M<V5L9BYH87-H=&%B;&4H*2DI*0H@("`@("`@("`@("`C(%II<"!T:&4@='=O
M(&ET97)A=&]R<R!T;V=E=&AE<BX*("`@("`@("`@("`@<F5T=7)N(&EZ:7`@
M*&-O=6YT97(L(&1A=&$I"B`@("`@("`@9&%T82`]('-E;&8N9FQA='1E;B`H
M:6UA<"`H<V5L9BYF;W)M871?;VYE+"!3=&1(87-H=&%B;&5)=&5R871O<B`H
M<V5L9BYH87-H=&%B;&4H*2DI*0H@("`@("`@(",@6FEP('1H92!T=V\@:71E
M<F%T;W)S('1O9V5T:&5R+@H@("`@("`@(')E='5R;B!I>FEP("AC;W5N=&5R
M+"!D871A*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@
M(')E='5R;B`G;6%P)PH*8VQA<W,@4W1D1F]R=V%R9$QI<W10<FEN=&5R.@H@
M("`@(E!R:6YT(&$@<W1D.CIF;W)W87)D7VQI<W0B"@H@("`@8VQA<W,@7VET
M97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@
M;F]D971Y<&4L(&AE860I.@H@("`@("`@("`@("!S96QF+FYO9&5T>7!E(#T@
M;F]D971Y<&4*("`@("`@("`@("`@<V5L9BYB87-E(#T@:&5A9%LG7TU?;F5X
M="=="B`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E9B!?
M7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@
M("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF+F)A
M<V4@/3T@,#H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*
M("`@("`@("`@("`@96QT(#T@<V5L9BYB87-E+F-A<W0H<V5L9BYN;V1E='EP
M92DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!S96QF+F)A<V4@/2!E;'1;
M)U]-7VYE>'0G70H@("`@("`@("`@("!C;W5N="`]('-E;&8N8V]U;G0*("`@
M("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@
M("`@('9A;'!T<B`](&5L=%LG7TU?<W1O<F%G92==+F%D9')E<W,*("`@("`@
M("`@("`@=F%L<'1R(#T@=F%L<'1R+F-A<W0H96QT+G1Y<&4N=&5M<&QA=&5?
M87)G=6UE;G0H,"DN<&]I;G1E<B@I*0H@("`@("`@("`@("!R971U<FX@*"=;
M)61=)R`E(&-O=6YT+"!V86QP='(N9&5R969E<F5N8V4H*2D*"B`@("!D968@
M7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV
M86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO
M;F5D7VYA;65S<&%C92AT>7!E;F%M92D*"B`@("!D968@8VAI;&1R96XH<V5L
M9BDZ"B`@("`@("`@;F]D971Y<&4@/2!F:6YD7W1Y<&4H<V5L9BYV86PN='EP
M92P@)U].;V1E)RD*("`@("`@("!N;V1E='EP92`](&YO9&5T>7!E+G-T<FEP
M7W1Y<&5D969S*"DN<&]I;G1E<B@I"B`@("`@("`@<F5T=7)N('-E;&8N7VET
M97)A=&]R*&YO9&5T>7!E+"!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]H96%D
M)UTI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I9B!S96QF
M+G9A;%LG7TU?:6UP;"==6R=?35]H96%D)UU;)U]-7VYE>'0G72`]/2`P.@H@
M("`@("`@("`@("!R971U<FX@)V5M<'1Y("5S)R`E('-E;&8N='EP96YA;64*
M("`@("`@("!R971U<FX@)R5S)R`E('-E;&8N='EP96YA;64*"F-L87-S(%-I
M;F=L94]B:D-O;G1A:6YE<E!R:6YT97(H;V)J96-T*3H*("`@(")"87-E(&-L
M87-S(&9O<B!P<FEN=&5R<R!O9B!C;VYT86EN97)S(&]F('-I;F=L92!O8FIE
M8W1S(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@=F%L+"!V:7HL(&AI;G0@
M/2!.;VYE*3H*("`@("`@("!S96QF+F-O;G1A:6YE9%]V86QU92`]('9A;`H@
M("`@("`@('-E;&8N=FES=6%L:7IE<B`]('9I>@H@("`@("`@('-E;&8N:&EN
M="`](&AI;G0*"B`@("!D968@7W)E8V]G;FEZ92AS96QF+"!T>7!E*3H*("`@
M("`@("`B(B)2971U<FX@5%E012!A<R!A('-T<FEN9R!A9G1E<B!A<'!L>6EN
M9R!T>7!E('!R:6YT97)S(B(B"B`@("`@("`@9VQO8F%L(%]U<V5?='EP95]P
M<FEN=&EN9PH@("`@("`@(&EF(&YO="!?=7-E7W1Y<&5?<')I;G1I;F<Z"B`@
M("`@("`@("`@(')E='5R;B!S='(H='EP92D*("`@("`@("!R971U<FX@9V1B
M+G1Y<&5S+F%P<&QY7W1Y<&5?<F5C;V=N:7IE<G,H9V1B+G1Y<&5S+F=E=%]T
M>7!E7W)E8V]G;FEZ97)S*"DL"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@('1Y<&4I(&]R('-T<BAT>7!E*0H*("`@
M(&-L87-S(%]C;VYT86EN960H271E<F%T;W(I.@H@("`@("`@(&1E9B!?7VEN
M:71?7R`H<V5L9BP@=F%L*3H*("`@("`@("`@("`@<V5L9BYV86P@/2!V86P*
M"B`@("`@("`@9&5F(%]?:71E<E]?("AS96QF*3H*("`@("`@("`@("`@<F5T
M=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@
M("`@("!I9B!S96QF+G9A;"!I<R!.;VYE.@H@("`@("`@("`@("`@("`@<F%I
M<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!R971V86P@/2!S96QF+G9A
M;`H@("`@("`@("`@("!S96QF+G9A;"`]($YO;F4*("`@("`@("`@("`@<F5T
M=7)N("@G6V-O;G1A:6YE9"!V86QU95TG+"!R971V86PI"@H@("`@9&5F(&-H
M:6QD<F5N("AS96QF*3H*("`@("`@("!I9B!S96QF+F-O;G1A:6YE9%]V86QU
M92!I<R!.;VYE.@H@("`@("`@("`@("!R971U<FX@<V5L9BY?8V]N=&%I;F5D
M("A.;VYE*0H@("`@("`@(&EF(&AA<V%T='(@*'-E;&8N=FES=6%L:7IE<BP@
M)V-H:6QD<F5N)RDZ"B`@("`@("`@("`@(')E='5R;B!S96QF+G9I<W5A;&EZ
M97(N8VAI;&1R96X@*"D*("`@("`@("!R971U<FX@<V5L9BY?8V]N=&%I;F5D
M("AS96QF+F-O;G1A:6YE9%]V86QU92D*"B`@("!D968@9&ES<&QA>5]H:6YT
M("AS96QF*3H*("`@("`@("`C(&EF(&-O;G1A:6YE9"!V86QU92!I<R!A(&UA
M<"!W92!W86YT('1O(&1I<W!L87D@:6X@=&AE('-A;64@=V%Y"B`@("`@("`@
M:68@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG*2!A;F0@
M:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G9&ES<&QA>5]H:6YT)RDZ"B`@
M("`@("`@("`@(')E='5R;B!S96QF+G9I<W5A;&EZ97(N9&ES<&QA>5]H:6YT
M("@I"B`@("`@("`@<F5T=7)N('-E;&8N:&EN=`H*8VQA<W,@4W1D17AP06YY
M4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0<FEN=&5R*3H*("`@(")0<FEN
M="!A('-T9#HZ86YY(&]R('-T9#HZ97AP97)I;65N=&%L.CIA;GDB"@H@("`@
M9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S
M96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E
M;F%M92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<F4N<W5B*"=><W1D.CIE
M>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V7&0Z.B<L("=S=&0Z.F5X<&5R
M:6UE;G1A;#HZ)RP@<V5L9BYT>7!E;F%M92P@,2D*("`@("`@("!S96QF+G9A
M;"`]('9A;`H@("`@("`@('-E;&8N8V]N=&%I;F5D7W1Y<&4@/2!.;VYE"B`@
M("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@3F]N90H@("`@("`@('9I<W5A;&EZ
M97(@/2!.;VYE"B`@("`@("`@;6=R(#T@<V5L9BYV86Q;)U]-7VUA;F%G97(G
M70H@("`@("`@(&EF(&UG<B`A/2`P.@H@("`@("`@("`@("!F=6YC(#T@9V1B
M+F)L;V-K7V9O<E]P8RAI;G0H;6=R+F-A<W0H9V1B+FQO;VMU<%]T>7!E*"=I
M;G1P=')?="<I*2DI"B`@("`@("`@("`@(&EF(&YO="!F=6YC.@H@("`@("`@
M("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@B26YV86QI9"!F=6YC=&EO;B!P
M;VEN=&5R(&EN("5S(B`E('-E;&8N='EP96YA;64I"B`@("`@("`@("`@(')X
M(#T@<B(B(BA[,'TZ.E]-86YA9V5R7UQW*SPN*CXI.CI?4U]M86YA9V5<*"AE
M;G5M("D_>S!].CI?3W`L("AC;VYS="![,'U\>S!](&-O;G-T*2`_7"HL("AU
M;FEO;B`I/WLP?3HZ7T%R9R`_7"I<*2(B(BYF;W)M870H='EP96YA;64I"B`@
M("`@("`@("`@(&T@/2!R92YM871C:"AR>"P@9G5N8RYF=6YC=&EO;BYN86UE
M*0H@("`@("`@("`@("!I9B!N;W0@;3H*("`@("`@("`@("`@("`@(')A:7-E
M(%9A;'5E17)R;W(H(E5N:VYO=VX@;6%N86=E<B!F=6YC=&EO;B!I;B`E<R(@
M)2!S96QF+G1Y<&5N86UE*0H*("`@("`@("`@("`@;6=R;F%M92`](&TN9W)O
M=7`H,2D*("`@("`@("`@("`@(R!&25A-12!N965D('1O(&5X<&%N9"`G<W1D
M.CIS=')I;F<G('-O('1H870@9V1B+FQO;VMU<%]T>7!E('=O<FMS"B`@("`@
M("`@("`@(&EF("=S=&0Z.G-T<FEN9R<@:6X@;6=R;F%M93H*("`@("`@("`@
M("`@("`@(&UG<FYA;64@/2!R92YS=6(H(G-T9#HZ<W1R:6YG*#\A7'<I(BP@
M<W1R*&=D8BYL;V]K=7!?='EP92@G<W1D.CIS=')I;F<G*2YS=')I<%]T>7!E
M9&5F<R@I*2P@;2YG<F]U<"@Q*2D*"B`@("`@("`@("`@(&UG<G1Y<&4@/2!G
M9&(N;&]O:W5P7W1Y<&4H;6=R;F%M92D*("`@("`@("`@("`@<V5L9BYC;VYT
M86EN961?='EP92`](&UG<G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@
M("`@("`@("`@=F%L<'1R(#T@3F]N90H@("`@("`@("`@("!I9B`G.CI?36%N
M86=E<E]I;G1E<FYA;"<@:6X@;6=R;F%M93H*("`@("`@("`@("`@("`@('9A
M;'!T<B`]('-E;&8N=F%L6R=?35]S=&]R86=E)UU;)U]-7V)U9F9E<B==+F%D
M9')E<W,*("`@("`@("`@("`@96QI9B`G.CI?36%N86=E<E]E>'1E<FYA;"<@
M:6X@;6=R;F%M93H*("`@("`@("`@("`@("`@('9A;'!T<B`]('-E;&8N=F%L
M6R=?35]S=&]R86=E)UU;)U]-7W!T<B=="B`@("`@("`@("`@(&5L<V4Z"B`@
M("`@("`@("`@("`@("!R86ES92!686QU945R<F]R*")5;FMN;W=N(&UA;F%G
M97(@9G5N8W1I;VX@:6X@)7,B("4@<V5L9BYT>7!E;F%M92D*("`@("`@("`@
M("`@8V]N=&%I;F5D7W9A;'5E(#T@=F%L<'1R+F-A<W0H<V5L9BYC;VYT86EN
M961?='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*("`@("`@("`@("`@
M=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H8V]N=&%I;F5D
M7W9A;'5E*0H@("`@("`@('-U<&5R*%-T9$5X<$%N>5!R:6YT97(L('-E;&8I
M+E]?:6YI=%]?("AC;VYT86EN961?=F%L=64L('9I<W5A;&EZ97(I"@H@("`@
M9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYC;VYT86EN
M961?='EP92!I<R!.;VYE.@H@("`@("`@("`@("!R971U<FX@)R5S(%MN;R!C
M;VYT86EN960@=F%L=65=)R`E('-E;&8N='EP96YA;64*("`@("`@("!D97-C
M(#T@(B5S(&-O;G1A:6YI;F<@(B`E('-E;&8N='EP96YA;64*("`@("`@("!I
M9B!H87-A='1R("AS96QF+G9I<W5A;&EZ97(L("=C:&EL9')E;B<I.@H@("`@
M("`@("`@("!R971U<FX@9&5S8R`K('-E;&8N=FES=6%L:7IE<BYT;U]S=')I
M;F<@*"D*("`@("`@("!V86QT>7!E(#T@<V5L9BY?<F5C;V=N:7IE("AS96QF
M+F-O;G1A:6YE9%]T>7!E*0H@("`@("`@(')E='5R;B!D97-C("L@<W1R:7!?
M=F5R<VEO;F5D7VYA;65S<&%C92AS='(H=F%L='EP92DI"@IC;&%S<R!3=&1%
M>'!/<'1I;VYA;%!R:6YT97(H4VEN9VQE3V)J0V]N=&%I;F5R4')I;G1E<BDZ
M"B`@("`B4')I;G0@82!S=&0Z.F]P=&EO;F%L(&]R('-T9#HZ97AP97)I;65N
M=&%L.CIO<'1I;VYA;"(*"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N
M86UE+"!V86PI.@H@("`@("`@('9A;'1Y<&4@/2!S96QF+E]R96-O9VYI>F4@
M*'9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I*0H@("`@("`@('1Y<&5N
M86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@
M("`@("!S96QF+G1Y<&5N86UE(#T@<F4N<W5B*"=><W1D.CHH97AP97)I;65N
M=&%L.CI\*2AF=6YD86UE;G1A;'-?=EQD.CI\*2@N*BDG+"!R)W-T9#HZ7#%<
M,SPE<SXG("4@=F%L='EP92P@='EP96YA;64L(#$I"B`@("`@("`@<&%Y;&]A
M9"`]('9A;%LG7TU?<&%Y;&]A9"=="B`@("`@("`@:68@<V5L9BYT>7!E;F%M
M92YS=&%R='-W:71H*"=S=&0Z.F5X<&5R:6UE;G1A;"<I.@H@("`@("`@("`@
M("!E;F=A9V5D(#T@=F%L6R=?35]E;F=A9V5D)UT*("`@("`@("`@("`@8V]N
M=&%I;F5D7W9A;'5E(#T@<&%Y;&]A9`H@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@(&5N9V%G960@/2!P87EL;V%D6R=?35]E;F=A9V5D)UT*("`@("`@("`@
M("`@8V]N=&%I;F5D7W9A;'5E(#T@<&%Y;&]A9%LG7TU?<&%Y;&]A9"=="B`@
M("`@("`@("`@('1R>3H*("`@("`@("`@("`@("`@(",@4VEN8V4@1T-#(#D*
M("`@("`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`](&-O;G1A:6YE9%]V
M86QU95LG7TU?=F%L=64G70H@("`@("`@("`@("!E>&-E<'0Z"B`@("`@("`@
M("`@("`@("!P87-S"B`@("`@("`@=FES=6%L:7IE<B`](&=D8BYD969A=6QT
M7W9I<W5A;&EZ97(@*&-O;G1A:6YE9%]V86QU92D*("`@("`@("!I9B!N;W0@
M96YG86=E9#H*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@3F]N90H@
M("`@("`@('-U<&5R("A3=&1%>'!/<'1I;VYA;%!R:6YT97(L('-E;&8I+E]?
M:6YI=%]?("AC;VYT86EN961?=F%L=64L('9I<W5A;&EZ97(I"@H@("`@9&5F
M('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYC;VYT86EN961?
M=F%L=64@:7,@3F]N93H*("`@("`@("`@("`@<F5T=7)N("(E<R!;;F\@8V]N
M=&%I;F5D('9A;'5E72(@)2!S96QF+G1Y<&5N86UE"B`@("`@("`@:68@:&%S
M871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG*3H*("`@("`@("`@
M("`@<F5T=7)N("(E<R!C;VYT86EN:6YG("5S(B`E("AS96QF+G1Y<&5N86UE
M+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@('-E
M;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H*2D*("`@("`@("!R971U<FX@<V5L
M9BYT>7!E;F%M90H*8VQA<W,@4W1D5F%R:6%N=%!R:6YT97(H4VEN9VQE3V)J
M0V]N=&%I;F5R4')I;G1E<BDZ"B`@("`B4')I;G0@82!S=&0Z.G9A<FEA;G0B
M"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@
M("`@(&%L=&5R;F%T:79E<R`](&=E=%]T96UP;&%T95]A<F=?;&ES="AV86PN
M='EP92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D
M7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@
M(B5S/"5S/B(@)2`H<V5L9BYT>7!E;F%M92P@)RP@)RYJ;VEN*%MS96QF+E]R
M96-O9VYI>F4H86QT*2!F;W(@86QT(&EN(&%L=&5R;F%T:79E<UTI*0H@("`@
M("`@('-E;&8N:6YD97@@/2!V86Q;)U]-7VEN9&5X)UT*("`@("`@("!I9B!S
M96QF+FEN9&5X(#X](&QE;BAA;'1E<FYA=&EV97,I.@H@("`@("`@("`@("!S
M96QF+F-O;G1A:6YE9%]T>7!E(#T@3F]N90H@("`@("`@("`@("!C;VYT86EN
M961?=F%L=64@/2!.;VYE"B`@("`@("`@("`@('9I<W5A;&EZ97(@/2!.;VYE
M"B`@("`@("`@96QS93H*("`@("`@("`@("`@<V5L9BYC;VYT86EN961?='EP
M92`](&%L=&5R;F%T:79E<UMI;G0H<V5L9BYI;F1E>"E="B`@("`@("`@("`@
M(&%D9'(@/2!V86Q;)U]-7W4G75LG7TU?9FER<W0G75LG7TU?<W1O<F%G92==
M+F%D9')E<W,*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@861D<BYC
M87-T*'-E;&8N8V]N=&%I;F5D7W1Y<&4N<&]I;G1E<B@I*2YD97)E9F5R96YC
M92@I"B`@("`@("`@("`@('9I<W5A;&EZ97(@/2!G9&(N9&5F875L=%]V:7-U
M86QI>F5R*&-O;G1A:6YE9%]V86QU92D*("`@("`@("!S=7!E<B`H4W1D5F%R
M:6%N=%!R:6YT97(L('-E;&8I+E]?:6YI=%]?*&-O;G1A:6YE9%]V86QU92P@
M=FES=6%L:7IE<BP@)V%R<F%Y)RD*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I
M.@H@("`@("`@(&EF('-E;&8N8V]N=&%I;F5D7W9A;'5E(&ES($YO;F4Z"B`@
M("`@("`@("`@(')E='5R;B`B)7,@6VYO(&-O;G1A:6YE9"!V86QU95TB("4@
M<V5L9BYT>7!E;F%M90H@("`@("`@(&EF(&AA<V%T='(H<V5L9BYV:7-U86QI
M>F5R+"`G8VAI;&1R96XG*3H*("`@("`@("`@("`@<F5T=7)N("(E<R!;:6YD
M97@@)61=(&-O;G1A:6YI;F<@)7,B("4@*'-E;&8N='EP96YA;64L('-E;&8N
M:6YD97@L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("!S96QF+G9I<W5A;&EZ97(N=&]?<W1R:6YG*"DI"B`@
M("`@("`@<F5T=7)N("(E<R!;:6YD97@@)61=(B`E("AS96QF+G1Y<&5N86UE
M+"!S96QF+FEN9&5X*0H*8VQA<W,@4W1D3F]D94AA;F1L95!R:6YT97(H4VEN
M9VQE3V)J0V]N=&%I;F5R4')I;G1E<BDZ"B`@("`B4')I;G0@82!C;VYT86EN
M97(@;F]D92!H86YD;&4B"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N
M86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L=65?='EP92`]('9A;"YT>7!E
M+G1E;7!L871E7V%R9W5M96YT*#$I"B`@("`@("`@;F]D971Y<&4@/2!V86PN
M='EP92YT96UP;&%T95]A<F=U;65N="@R*2YT96UP;&%T95]A<F=U;65N="@P
M*0H@("`@("`@('-E;&8N:7-?<F)?=')E95]N;V1E(#T@:7-?<W!E8VEA;&EZ
M871I;VY?;V8H;F]D971Y<&4N;F%M92P@)U]28E]T<F5E7VYO9&4G*0H@("`@
M("`@('-E;&8N:7-?;6%P7VYO9&4@/2!V86PN='EP92YT96UP;&%T95]A<F=U
M;65N="@P*2`A/2!S96QF+G9A;'5E7W1Y<&4*("`@("`@("!N;V1E<'1R(#T@
M=F%L6R=?35]P='(G70H@("`@("`@(&EF(&YO9&5P='(Z"B`@("`@("`@("`@
M(&EF('-E;&8N:7-?<F)?=')E95]N;V1E.@H@("`@("`@("`@("`@("`@8V]N
M=&%I;F5D7W9A;'5E(#T@9V5T7W9A;'5E7V9R;VU?4F)?=')E95]N;V1E*&YO
M9&5P='(N9&5R969E<F5N8V4H*2D*("`@("`@("`@("`@96QS93H*("`@("`@
M("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`](&=E=%]V86QU95]F<F]M7V%L
M:6=N961?;65M8G5F*&YO9&5P=');)U]-7W-T;W)A9V4G72P*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@('-E;&8N=F%L=65?='EP92D*("`@("`@("`@("`@=FES=6%L
M:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H8V]N=&%I;F5D7W9A;'5E
M*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`]
M($YO;F4*("`@("`@("`@("`@=FES=6%L:7IE<B`]($YO;F4*("`@("`@("!O
M<'1A;&QO8R`]('9A;%LG7TU?86QL;V,G70H@("`@("`@('-E;&8N86QL;V,@
M/2!O<'1A;&QO8ULG7TU?<&%Y;&]A9"==(&EF(&]P=&%L;&]C6R=?35]E;F=A
M9V5D)UT@96QS92!.;VYE"B`@("`@("`@<W5P97(H4W1D3F]D94AA;F1L95!R
M:6YT97(L('-E;&8I+E]?:6YI=%]?*&-O;G1A:6YE9%]V86QU92P@=FES=6%L
M:7IE<BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@)V%R<F%Y)RD*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I
M.@H@("`@("`@(&1E<V,@/2`G;F]D92!H86YD;&4@9F]R("<*("`@("`@("!I
M9B!N;W0@<V5L9BYI<U]R8E]T<F5E7VYO9&4Z"B`@("`@("`@("`@(&1E<V,@
M*ST@)W5N;W)D97)E9"`G"B`@("`@("`@:68@<V5L9BYI<U]M87!?;F]D93H*
M("`@("`@("`@("`@9&5S8R`K/2`G;6%P)SL*("`@("`@("!E;'-E.@H@("`@
M("`@("`@("!D97-C("L]("=S970G.PH*("`@("`@("!I9B!S96QF+F-O;G1A
M:6YE9%]V86QU93H*("`@("`@("`@("`@9&5S8R`K/2`G('=I=&@@96QE;65N
M="<*("`@("`@("`@("`@:68@:&%S871T<BAS96QF+G9I<W5A;&EZ97(L("=C
M:&EL9')E;B<I.@H@("`@("`@("`@("`@("`@<F5T=7)N("(E<R`]("5S(B`E
M("AD97-C+"!S96QF+G9I<W5A;&EZ97(N=&]?<W1R:6YG*"DI"B`@("`@("`@
M("`@(')E='5R;B!D97-C"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T
M=7)N("=E;7!T>2`E<R<@)2!D97-C"@IC;&%S<R!3=&1%>'!3=')I;F=6:65W
M4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ8F%S:6-?<W1R:6YG7W9I97<@
M;W(@<W1D.CIE>'!E<FEM96YT86PZ.F)A<VEC7W-T<FEN9U]V:65W(@H*("`@
M(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@
M<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@
M("`@("!P='(@/2!S96QF+G9A;%LG7TU?<W1R)UT*("`@("`@("!L96X@/2!S
M96QF+G9A;%LG7TU?;&5N)UT*("`@("`@("!I9B!H87-A='1R("AP='(L(")L
M87IY7W-T<FEN9R(I.@H@("`@("`@("`@("!R971U<FX@<'1R+FQA>GE?<W1R
M:6YG("AL96YG=&@@/2!L96XI"B`@("`@("`@<F5T=7)N('!T<BYS=')I;F<@
M*&QE;F=T:"`](&QE;BD*"B`@("!D968@9&ES<&QA>5]H:6YT("AS96QF*3H*
M("`@("`@("!R971U<FX@)W-T<FEN9R<*"F-L87-S(%-T9$5X<%!A=&A0<FEN
M=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIE>'!E<FEM96YT86PZ.F9I;&5S>7-T
M96TZ.G!A=&@B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@
M=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@('-T87)T(#T@
M<V5L9BYV86Q;)U]-7V-M<'1S)UU;)U]-7VEM<&PG75LG7TU?<W1A<G0G70H@
M("`@("`@(&9I;FES:"`]('-E;&8N=F%L6R=?35]C;7!T<R==6R=?35]I;7!L
M)UU;)U]-7V9I;FES:"=="B`@("`@("`@<V5L9BYN=6U?8VUP=',@/2!I;G0@
M*&9I;FES:"`M('-T87)T*0H*("`@(&1E9B!?<&%T:%]T>7!E*'-E;&8I.@H@
M("`@("`@('0@/2!S='(H<V5L9BYV86Q;)U]-7W1Y<&4G72D*("`@("`@("!I
M9B!T6RTY.ET@/3T@)U]2;V]T7V1I<B<Z"B`@("`@("`@("`@(')E='5R;B`B
M<F]O="UD:7)E8W1O<GDB"B`@("`@("`@:68@=%LM,3`Z72`]/2`G7U)O;W1?
M;F%M92<Z"B`@("`@("`@("`@(')E='5R;B`B<F]O="UN86UE(@H@("`@("`@
M(')E='5R;B!.;VYE"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@
M("`@<&%T:"`]("(E<R(@)2!S96QF+G9A;"!;)U]-7W!A=&AN86UE)UT*("`@
M("`@("!I9B!S96QF+FYU;5]C;7!T<R`]/2`P.@H@("`@("`@("`@("!T(#T@
M<V5L9BY?<&%T:%]T>7!E*"D*("`@("`@("`@("`@:68@=#H*("`@("`@("`@
M("`@("`@('!A=&@@/2`G)7,@6R5S72<@)2`H<&%T:"P@="D*("`@("`@("!R
M971U<FX@(F9I;&5S>7-T96TZ.G!A=&@@)7,B("4@<&%T:`H*("`@(&-L87-S
M(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L(&-M<'1S*3H*("`@("`@("`@("`@<V5L9BYI=&5M(#T@8VUP='-;)U]-
M7VEM<&PG75LG7TU?<W1A<G0G70H@("`@("`@("`@("!S96QF+F9I;FES:"`]
M(&-M<'1S6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="B`@("`@("`@("`@('-E
M;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@
M("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E
M;&8I.@H@("`@("`@("`@("!I9B!S96QF+FET96T@/3T@<V5L9BYF:6YI<V@Z
M"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@
M("`@(&ET96T@/2!S96QF+FET96TN9&5R969E<F5N8V4H*0H@("`@("`@("`@
M("!C;W5N="`]('-E;&8N8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]
M('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@("`@('-E;&8N:71E;2`]('-E;&8N
M:71E;2`K(#$*("`@("`@("`@("`@<&%T:"`](&ET96U;)U]-7W!A=&AN86UE
M)UT*("`@("`@("`@("`@="`](%-T9$5X<%!A=&A0<FEN=&5R*&ET96TN='EP
M92YN86UE+"!I=&5M*2Y?<&%T:%]T>7!E*"D*("`@("`@("`@("`@:68@;F]T
M('0Z"B`@("`@("`@("`@("`@("!T(#T@8V]U;G0*("`@("`@("`@("`@<F5T
M=7)N("@G6R5S72<@)2!T+"!P871H*0H*("`@(&1E9B!C:&EL9')E;BAS96QF
M*3H*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T;W(H<V5L9BYV86Q;)U]-
M7V-M<'1S)UTI"@IC;&%S<R!3=&10871H4')I;G1E<CH*("`@(")0<FEN="!A
M('-T9#HZ9FEL97-Y<W1E;3HZ<&%T:"(*"B`@("!D968@7U]I;FET7U\@*'-E
M;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@
M("`@("`@<V5L9BYT>7!E;F%M92`]('1Y<&5N86UE"B`@("`@("`@:6UP;"`]
M('-E;&8N=F%L6R=?35]C;7!T<R==6R=?35]I;7!L)UU;)U]-7W0G75LG7TU?
M="==6R=?35]H96%D7VEM<&PG70H@("`@("`@('-E;&8N='EP92`](&EM<&PN
M8V%S="AG9&(N;&]O:W5P7W1Y<&4H)W5I;G1P=')?="<I*2`F(#,*("`@("`@
M("!I9B!S96QF+G1Y<&4@/3T@,#H*("`@("`@("`@("`@<V5L9BYI;7!L(#T@
M:6UP;`H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N:6UP;"`]($YO
M;F4*"B`@("!D968@7W!A=&A?='EP92AS96QF*3H*("`@("`@("!T(#T@<W1R
M*'-E;&8N='EP92YC87-T*&=D8BYL;V]K=7!?='EP92AS96QF+G1Y<&5N86UE
M("L@)SHZ7U1Y<&4G*2DI"B`@("`@("`@:68@=%LM.3I=(#T]("=?4F]O=%]D
M:7(G.@H@("`@("`@("`@("!R971U<FX@(G)O;W0M9&ER96-T;W)Y(@H@("`@
M("`@(&EF('1;+3$P.ET@/3T@)U]2;V]T7VYA;64G.@H@("`@("`@("`@("!R
M971U<FX@(G)O;W0M;F%M92(*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E
M9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@('!A=&@@/2`B)7,B("4@<V5L
M9BYV86P@6R=?35]P871H;F%M92=="B`@("`@("`@:68@<V5L9BYT>7!E("$]
M(#`Z"B`@("`@("`@("`@('0@/2!S96QF+E]P871H7W1Y<&4H*0H@("`@("`@
M("`@("!I9B!T.@H@("`@("`@("`@("`@("`@<&%T:"`]("<E<R!;)7-=)R`E
M("AP871H+"!T*0H@("`@("`@(')E='5R;B`B9FEL97-Y<W1E;3HZ<&%T:"`E
M<R(@)2!P871H"@H@("`@8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*("`@
M("`@("!D968@7U]I;FET7U\H<V5L9BP@:6UP;"P@<&%T:'1Y<&4I.@H@("`@
M("`@("`@("!I9B!I;7!L.@H@("`@("`@("`@("`@("`@(R!792!C86XG="!A
M8V-E<W,@7TEM<&PZ.E]-7W-I>F4@8F5C875S92!?26UP;"!I<R!I;F-O;7!L
M971E"B`@("`@("`@("`@("`@("`C('-O(&-A<W0@=&\@:6YT*B!T;R!A8V-E
M<W,@=&AE(%]-7W-I>F4@;65M8F5R(&%T(&]F9G-E="!Z97)O+`H@("`@("`@
M("`@("`@("`@:6YT7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H)VEN="<I"B`@
M("`@("`@("`@("`@("!C;7!T7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H<&%T
M:'1Y<&4K)SHZ7T-M<'0G*0H@("`@("`@("`@("`@("`@8VAA<E]T>7!E(#T@
M9V1B+FQO;VMU<%]T>7!E*"=C:&%R)RD*("`@("`@("`@("`@("`@(&EM<&P@
M/2!I;7!L+F-A<W0H:6YT7W1Y<&4N<&]I;G1E<B@I*0H@("`@("`@("`@("`@
M("`@<VEZ92`](&EM<&PN9&5R969E<F5N8V4H*0H@("`@("`@("`@("`@("`@
M(W-E;&8N8V%P86-I='D@/2`H:6UP;"`K(#$I+F1E<F5F97)E;F-E*"D*("`@
M("`@("`@("`@("`@(&EF(&AA<V%T='(H9V1B+E1Y<&4L("=A;&EG;F]F)RDZ
M"B`@("`@("`@("`@("`@("`@("`@<VEZ96]F7TEM<&P@/2!M87@H,B`J(&EN
M=%]T>7!E+G-I>F5O9BP@8VUP=%]T>7!E+F%L:6=N;V8I"B`@("`@("`@("`@
M("`@("!E;'-E.@H@("`@("`@("`@("`@("`@("`@('-I>F5O9E]);7!L(#T@
M,B`J(&EN=%]T>7!E+G-I>F5O9@H@("`@("`@("`@("`@("`@8F5G:6X@/2!I
M;7!L+F-A<W0H8VAA<E]T>7!E+G!O:6YT97(H*2D@*R!S:7IE;V9?26UP;`H@
M("`@("`@("`@("`@("`@<V5L9BYI=&5M(#T@8F5G:6XN8V%S="AC;7!T7W1Y
M<&4N<&]I;G1E<B@I*0H@("`@("`@("`@("`@("`@<V5L9BYF:6YI<V@@/2!S
M96QF+FET96T@*R!S:7IE"B`@("`@("`@("`@("`@("!S96QF+F-O=6YT(#T@
M,`H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@<V5L9BYI=&5M
M(#T@3F]N90H@("`@("`@("`@("`@("`@<V5L9BYF:6YI<V@@/2!.;VYE"@H@
M("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N
M('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@
M("!I9B!S96QF+FET96T@/3T@<V5L9BYF:6YI<V@Z"B`@("`@("`@("`@("`@
M("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@(&ET96T@/2!S96QF
M+FET96TN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!C;W5N="`]('-E;&8N
M8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q
M"B`@("`@("`@("`@('-E;&8N:71E;2`]('-E;&8N:71E;2`K(#$*("`@("`@
M("`@("`@<&%T:"`](&ET96U;)U]-7W!A=&AN86UE)UT*("`@("`@("`@("`@
M="`](%-T9%!A=&A0<FEN=&5R*&ET96TN='EP92YN86UE+"!I=&5M*2Y?<&%T
M:%]T>7!E*"D*("`@("`@("`@("`@:68@;F]T('0Z"B`@("`@("`@("`@("`@
M("!T(#T@8V]U;G0*("`@("`@("`@("`@<F5T=7)N("@G6R5S72<@)2!T+"!P
M871H*0H*("`@(&1E9B!C:&EL9')E;BAS96QF*3H*("`@("`@("!R971U<FX@
M<V5L9BY?:71E<F%T;W(H<V5L9BYI;7!L+"!S96QF+G1Y<&5N86UE*0H*"F-L
M87-S(%-T9%!A:7)0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIP86ER(&]B
M:F5C="P@=VET:"`G9FER<W0G(&%N9"`G<V5C;VYD)R!A<R!C:&EL9')E;B(*
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@
M("`@<V5L9BYV86P@/2!V86P*"B`@("!C;&%S<R!?:71E<BA)=&5R871O<BDZ
M"B`@("`@("`@(D%N(&ET97)A=&]R(&9O<B!S=&0Z.G!A:7(@='EP97,N(%)E
M='5R;G,@)V9I<G-T)R!T:&5N("=S96-O;F0G+B(*"B`@("`@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L('9A;"DZ"B`@("`@("`@("`@('-E;&8N=F%L(#T@=F%L
M"B`@("`@("`@("`@('-E;&8N=VAI8V@@/2`G9FER<W0G"@H@("`@("`@(&1E
M9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@
M("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF
M+G=H:6-H(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E
M<F%T:6]N"B`@("`@("`@("`@('=H:6-H(#T@<V5L9BYW:&EC:`H@("`@("`@
M("`@("!I9B!W:&EC:"`]/2`G9FER<W0G.@H@("`@("`@("`@("`@("`@<V5L
M9BYW:&EC:"`]("=S96-O;F0G"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@("`@("!S96QF+G=H:6-H(#T@3F]N90H@("`@("`@("`@("!R971U<FX@
M*'=H:6-H+"!S96QF+G9A;%MW:&EC:%TI"@H@("`@9&5F(&-H:6QD<F5N*'-E
M;&8I.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R*'-E;&8N=F%L*0H*("`@
M(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"@HC
M($$@(G)E9W5L87(@97AP<F5S<VEO;B(@<')I;G1E<B!W:&EC:"!C;VYF;W)M
M<R!T;R!T:&4*(R`B4W5B4')E='1Y4')I;G1E<B(@<')O=&]C;VP@9G)O;2!G
M9&(N<')I;G1I;F<N"F-L87-S(%)X4')I;G1E<BAO8FIE8W0I.@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L(&YA;64L(&9U;F-T:6]N*3H*("`@("`@("!S=7!E
M<BA2>%!R:6YT97(L('-E;&8I+E]?:6YI=%]?*"D*("`@("`@("!S96QF+FYA
M;64@/2!N86UE"B`@("`@("`@<V5L9BYF=6YC=&EO;B`](&9U;F-T:6]N"B`@
M("`@("`@<V5L9BYE;F%B;&5D(#T@5')U90H*("`@(&1E9B!I;G9O:V4H<V5L
M9BP@=F%L=64I.@H@("`@("`@(&EF(&YO="!S96QF+F5N86)L960Z"B`@("`@
M("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@(&EF('9A;'5E+G1Y<&4N8V]D
M92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@("`@:68@:&%S871T
M<BAG9&(N5F%L=64L(G)E9F5R96YC961?=F%L=64B*3H*("`@("`@("`@("`@
M("`@('9A;'5E(#T@=F%L=64N<F5F97)E;F-E9%]V86QU92@I"@H@("`@("`@
M(')E='5R;B!S96QF+F9U;F-T:6]N*'-E;&8N;F%M92P@=F%L=64I"@HC($$@
M<')E='1Y+7!R:6YT97(@=&AA="!C;VYF;W)M<R!T;R!T:&4@(E!R971T>5!R
M:6YT97(B('!R;W1O8V]L(&9R;VT*(R!G9&(N<')I;G1I;F<N("!)="!C86X@
M86QS;R!B92!U<V5D(&1I<F5C=&QY(&%S(&%N(&]L9"US='EL92!P<FEN=&5R
M+@IC;&%S<R!0<FEN=&5R*&]B:F5C="DZ"B`@("!D968@7U]I;FET7U\H<V5L
M9BP@;F%M92DZ"B`@("`@("`@<W5P97(H4')I;G1E<BP@<V5L9BDN7U]I;FET
M7U\H*0H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@("!S96QF+G-U
M8G!R:6YT97)S(#T@6UT*("`@("`@("!S96QF+FQO;VMU<"`]('M]"B`@("`@
M("`@<V5L9BYE;F%B;&5D(#T@5')U90H@("`@("`@('-E;&8N8V]M<&EL961?
M<G@@/2!R92YC;VUP:6QE*"=>*%MA+7I!+5HP+3E?.ETK*2@\+BH^*3\D)RD*
M"B`@("!D968@861D*'-E;&8L(&YA;64L(&9U;F-T:6]N*3H*("`@("`@("`C
M($$@<VUA;&P@<V%N:71Y(&-H96-K+@H@("`@("`@(",@1DE8344*("`@("`@
M("!I9B!N;W0@<V5L9BYC;VUP:6QE9%]R>"YM871C:"AN86UE*3H*("`@("`@
M("`@("`@<F%I<V4@5F%L=65%<G)O<B@G;&EB<W1D8RLK('!R;V=R86UM:6YG
M(&5R<F]R.B`B)7,B(&1O97,@;F]T(&UA=&-H)R`E(&YA;64I"B`@("`@("`@
M<')I;G1E<B`](%)X4')I;G1E<BAN86UE+"!F=6YC=&EO;BD*("`@("`@("!S
M96QF+G-U8G!R:6YT97)S+F%P<&5N9"AP<FEN=&5R*0H@("`@("`@('-E;&8N
M;&]O:W5P6VYA;65=(#T@<')I;G1E<@H*("`@(",@061D(&$@;F%M92!U<VEN
M9R!?1TQ)0D-86%]"14=)3E].04U%4U!!0T5?5D524TE/3BX*("`@(&1E9B!A
M9&1?=F5R<VEO;BAS96QF+"!B87-E+"!N86UE+"!F=6YC=&EO;BDZ"B`@("`@
M("`@<V5L9BYA9&0H8F%S92`K(&YA;64L(&9U;F-T:6]N*0H@("`@("`@(&EF
M(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@("`@("!V8F%S92`](')E
M+G-U8B@G7BAS=&1\7U]G;G5?8WAX*3HZ)RP@<B=<9SPP/B5S)R`E(%]V97)S
M:6]N961?;F%M97-P86-E+"!B87-E*0H@("`@("`@("`@("!S96QF+F%D9"AV
M8F%S92`K(&YA;64L(&9U;F-T:6]N*0H*("`@(",@061D(&$@;F%M92!U<VEN
M9R!?1TQ)0D-86%]"14=)3E].04U%4U!!0T5?0T].5$%)3D52+@H@("`@9&5F
M(&%D9%]C;VYT86EN97(H<V5L9BP@8F%S92P@;F%M92P@9G5N8W1I;VXI.@H@
M("`@("`@('-E;&8N861D7W9E<G-I;VXH8F%S92P@;F%M92P@9G5N8W1I;VXI
M"B`@("`@("`@<V5L9BYA9&1?=F5R<VEO;BAB87-E("L@)U]?8WAX,3DY.#HZ
M)RP@;F%M92P@9G5N8W1I;VXI"@H@("`@0'-T871I8VUE=&AO9`H@("`@9&5F
M(&=E=%]B87-I8U]T>7!E*'1Y<&4I.@H@("`@("`@(",@268@:70@<&]I;G1S
M('1O(&$@<F5F97)E;F-E+"!G970@=&AE(')E9F5R96YC92X*("`@("`@("!I
M9B!T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]2148Z"B`@("`@("`@("`@
M('1Y<&4@/2!T>7!E+G1A<F=E="`H*0H*("`@("`@("`C($=E="!T:&4@=6YQ
M=6%L:69I960@='EP92P@<W1R:7!P960@;V8@='EP961E9G,N"B`@("`@("`@
M='EP92`]('1Y<&4N=6YQ=6%L:69I960@*"DN<W1R:7!?='EP961E9G,@*"D*
M"B`@("`@("`@<F5T=7)N('1Y<&4N=&%G"@H@("`@9&5F(%]?8V%L;%]?*'-E
M;&8L('9A;"DZ"B`@("`@("`@='EP96YA;64@/2!S96QF+F=E=%]B87-I8U]T
M>7!E*'9A;"YT>7!E*0H@("`@("`@(&EF(&YO="!T>7!E;F%M93H*("`@("`@
M("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@(R!!;&P@=&AE('1Y<&5S('=E
M(&UA=&-H(&%R92!T96UP;&%T92!T>7!E<RP@<V\@=V4@8V%N('5S92!A"B`@
M("`@("`@(R!D:6-T:6]N87)Y+@H@("`@("`@(&UA=&-H(#T@<V5L9BYC;VUP
M:6QE9%]R>"YM871C:"AT>7!E;F%M92D*("`@("`@("!I9B!N;W0@;6%T8V@Z
M"B`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@(&)A<V5N86UE(#T@
M;6%T8V@N9W)O=7`H,2D*"B`@("`@("`@:68@=F%L+G1Y<&4N8V]D92`]/2!G
M9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@("`@:68@:&%S871T<BAG9&(N
M5F%L=64L(G)E9F5R96YC961?=F%L=64B*3H*("`@("`@("`@("`@("`@('9A
M;"`]('9A;"YR969E<F5N8V5D7W9A;'5E*"D*"B`@("`@("`@:68@8F%S96YA
M;64@:6X@<V5L9BYL;V]K=7`Z"B`@("`@("`@("`@(')E='5R;B!S96QF+FQO
M;VMU<%MB87-E;F%M95TN:6YV;VME*'9A;"D*"B`@("`@("`@(R!#86YN;W0@
M9FEN9"!A('!R971T>2!P<FEN=&5R+B`@4F5T=7)N($YO;F4N"B`@("`@("`@
M<F5T=7)N($YO;F4*"FQI8G-T9&-X>%]P<FEN=&5R(#T@3F]N90H*8VQA<W,@
M5&5M<&QA=&54>7!E4')I;G1E<BAO8FIE8W0I.@H@("`@<B(B(@H@("`@02!T
M>7!E('!R:6YT97(@9F]R(&-L87-S('1E;7!L871E<R!W:71H(&1E9F%U;'0@
M=&5M<&QA=&4@87)G=6UE;G1S+@H*("`@(%)E8V]G;FEZ97,@<W!E8VEA;&EZ
M871I;VYS(&]F(&-L87-S('1E;7!L871E<R!A;F0@<')I;G1S('1H96T@=VET
M:&]U=`H@("`@86YY('1E;7!L871E(&%R9W5M96YT<R!T:&%T('5S92!A(&1E
M9F%U;'0@=&5M<&QA=&4@87)G=6UE;G0N"B`@("!4>7!E('!R:6YT97)S(&%R
M92!R96-U<G-I=F5L>2!A<'!L:65D('1O('1H92!T96UP;&%T92!A<F=U;65N
M=',N"@H@("`@92YG+B!R97!L86-E(")S=&0Z.G9E8W1O<CQ4+"!S=&0Z.F%L
M;&]C871O<CQ4/B`^(B!W:71H(")S=&0Z.G9E8W1O<CQ4/B(N"B`@("`B(B(*
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@9&5F87)G<RDZ"B`@("`@
M("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@('-E;&8N9&5F87)G<R`](&1E
M9F%R9W,*("`@("`@("!S96QF+F5N86)L960@/2!4<G5E"@H@("`@8VQA<W,@
M7W)E8V]G;FEZ97(H;V)J96-T*3H*("`@("`@("`B5&AE(')E8V]G;FEZ97(@
M8VQA<W,@9F]R(%1E;7!L871E5'EP95!R:6YT97(N(@H*("`@("`@("!D968@
M7U]I;FET7U\H<V5L9BP@;F%M92P@9&5F87)G<RDZ"B`@("`@("`@("`@('-E
M;&8N;F%M92`](&YA;64*("`@("`@("`@("`@<V5L9BYD969A<F=S(#T@9&5F
M87)G<PH@("`@("`@("`@("`C('-E;&8N='EP95]O8FH@/2!.;VYE"@H@("`@
M("`@(&1E9B!R96-O9VYI>F4H<V5L9BP@='EP95]O8FHI.@H@("`@("`@("`@
M("`B(B(*("`@("`@("`@("`@268@='EP95]O8FH@:7,@82!S<&5C:6%L:7IA
M=&EO;B!O9B!S96QF+FYA;64@=&AA="!U<V5S(&%L;"!T:&4*("`@("`@("`@
M("`@9&5F875L="!T96UP;&%T92!A<F=U;65N=',@9F]R('1H92!C;&%S<R!T
M96UP;&%T92P@=&AE;B!R971U<FX*("`@("`@("`@("`@82!S=')I;F<@<F5P
M<F5S96YT871I;VX@;V8@=&AE('1Y<&4@=VET:&]U="!D969A=6QT(&%R9W5M
M96YT<RX*("`@("`@("`@("`@3W1H97)W:7-E+"!R971U<FX@3F]N92X*("`@
M("`@("`@("`@(B(B"@H@("`@("`@("`@("!I9B!T>7!E7V]B:BYT86<@:7,@
M3F]N93H*("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@("`@
M("!I9B!N;W0@='EP95]O8FHN=&%G+G-T87)T<W=I=&@H<V5L9BYN86UE*3H*
M("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@("`@("!T96UP
M;&%T95]A<F=S(#T@9V5T7W1E;7!L871E7V%R9U]L:7-T*'1Y<&5?;V)J*0H@
M("`@("`@("`@("!D:7-P;&%Y961?87)G<R`](%M="B`@("`@("`@("`@(')E
M<75I<F5?9&5F875L=&5D(#T@1F%L<V4*("`@("`@("`@("`@9F]R(&X@:6X@
M<F%N9V4H;&5N*'1E;7!L871E7V%R9W,I*3H*("`@("`@("`@("`@("`@(",@
M5&AE(&%C='5A;"!T96UP;&%T92!A<F=U;65N="!I;B!T:&4@='EP93H*("`@
M("`@("`@("`@("`@('1A<F<@/2!T96UP;&%T95]A<F=S6VY="B`@("`@("`@
M("`@("`@("`C(%1H92!D969A=6QT('1E;7!L871E(&%R9W5M96YT(&9O<B!T
M:&4@8VQA<W,@=&5M<&QA=&4Z"B`@("`@("`@("`@("`@("!D969A<F<@/2!S
M96QF+F1E9F%R9W,N9V5T*&XI"B`@("`@("`@("`@("`@("!I9B!D969A<F<@
M:7,@;F]T($YO;F4Z"B`@("`@("`@("`@("`@("`@("`@(R!3=6)S=&ET=71E
M(&]T:&5R('1E;7!L871E(&%R9W5M96YT<R!I;G1O('1H92!D969A=6QT.@H@
M("`@("`@("`@("`@("`@("`@(&1E9F%R9R`](&1E9F%R9RYF;W)M870H*G1E
M;7!L871E7V%R9W,I"B`@("`@("`@("`@("`@("`@("`@(R!&86EL('1O(')E
M8V]G;FEZ92!T:&4@='EP92`H8GD@<F5T=7)N:6YG($YO;F4I"B`@("`@("`@
M("`@("`@("`@("`@(R!U;FQE<W,@=&AE(&%C='5A;"!A<F=U;65N="!I<R!T
M:&4@<V%M92!A<R!T:&4@9&5F875L="X*("`@("`@("`@("`@("`@("`@("!T
M<GDZ"B`@("`@("`@("`@("`@("`@("`@("`@(&EF('1A<F<@(3T@9V1B+FQO
M;VMU<%]T>7!E*&1E9F%R9RDZ"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!R971U<FX@3F]N90H@("`@("`@("`@("`@("`@("`@(&5X8V5P="!G9&(N
M97)R;W(Z"B`@("`@("`@("`@("`@("`@("`@("`@(",@5'EP92!L;V]K=7`@
M9F%I;&5D+"!J=7-T('5S92!S=')I;F<@8V]M<&%R:7-O;CH*("`@("`@("`@
M("`@("`@("`@("`@("`@:68@=&%R9RYT86<@(3T@9&5F87)G.@H@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("`@("`@
M("`@("`@("`C($%L;"!S=6)S97%U96YT(&%R9W,@;75S="!H879E(&1E9F%U
M;'1S.@H@("`@("`@("`@("`@("`@("`@(')E<75I<F5?9&5F875L=&5D(#T@
M5')U90H@("`@("`@("`@("`@("`@96QI9B!R97%U:7)E7V1E9F%U;'1E9#H*
M("`@("`@("`@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@("`@("`@
M("`@96QS93H*("`@("`@("`@("`@("`@("`@("`C(%)E8W5R<VEV96QY(&%P
M<&QY(')E8V]G;FEZ97)S('1O('1H92!T96UP;&%T92!A<F=U;65N=`H@("`@
M("`@("`@("`@("`@("`@(",@86YD(&%D9"!I="!T;R!T:&4@87)G=6UE;G1S
M('1H870@=VEL;"!B92!D:7-P;&%Y960Z"B`@("`@("`@("`@("`@("`@("`@
M9&ES<&QA>65D7V%R9W,N87!P96YD*'-E;&8N7W)E8V]G;FEZ95]S=6)T>7!E
M*'1A<F<I*0H*("`@("`@("`@("`@(R!4:&ES(&%S<W5M97,@;F\@8VQA<W,@
M=&5M<&QA=&5S(&EN('1H92!N97-T960M;F%M92US<&5C:69I97(Z"B`@("`@
M("`@("`@('1E;7!L871E7VYA;64@/2!T>7!E7V]B:BYT86=;,#IT>7!E7V]B
M:BYT86<N9FEN9"@G/"<I70H@("`@("`@("`@("!T96UP;&%T95]N86UE(#T@
M<W1R:7!?:6YL:6YE7VYA;65S<&%C97,H=&5M<&QA=&5?;F%M92D*"B`@("`@
M("`@("`@(')E='5R;B!T96UP;&%T95]N86UE("L@)SPG("L@)RP@)RYJ;VEN
M*&1I<W!L87EE9%]A<F=S*2`K("<^)PH*("`@("`@("!D968@7W)E8V]G;FEZ
M95]S=6)T>7!E*'-E;&8L('1Y<&5?;V)J*3H*("`@("`@("`@("`@(B(B0V]N
M=F5R="!A(&=D8BY4>7!E('1O(&$@<W1R:6YG(&)Y(&%P<&QY:6YG(')E8V]G
M;FEZ97)S+`H@("`@("`@("`@("!O<B!I9B!T:&%T(&9A:6QS('1H96X@<VEM
M<&QY(&-O;G9E<G1I;F<@=&\@82!S=')I;F<N(B(B"@H@("`@("`@("`@("!I
M9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?4%12.@H@("`@("`@
M("`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ95]S=6)T>7!E*'1Y<&5?
M;V)J+G1A<F=E="@I*2`K("<J)PH@("`@("`@("`@("!I9B!T>7!E7V]B:BYC
M;V1E(#T](&=D8BY465!%7T-/1$5?05)205DZ"B`@("`@("`@("`@("`@("!T
M>7!E7W-T<B`]('-E;&8N7W)E8V]G;FEZ95]S=6)T>7!E*'1Y<&5?;V)J+G1A
M<F=E="@I*0H@("`@("`@("`@("`@("`@:68@<W1R*'1Y<&5?;V)J+G-T<FEP
M7W1Y<&5D969S*"DI+F5N9'-W:71H*"=;72<I.@H@("`@("`@("`@("`@("`@
M("`@(')E='5R;B!T>7!E7W-T<B`K("=;72<@(R!A<G)A>2!O9B!U;FMN;W=N
M(&)O=6YD"B`@("`@("`@("`@("`@("!R971U<FX@(B5S6R5D72(@)2`H='EP
M95]S='(L('1Y<&5?;V)J+G)A;F=E*"E;,5T@*R`Q*0H@("`@("`@("`@("!I
M9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?4D5&.@H@("`@("`@
M("`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ95]S=6)T>7!E*'1Y<&5?
M;V)J+G1A<F=E="@I*2`K("<F)PH@("`@("`@("`@("!I9B!H87-A='1R*&=D
M8BP@)U194$5?0T]$15]25D%,545?4D5&)RDZ"B`@("`@("`@("`@("`@("!I
M9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?4E9!3%5%7U)%1CH*
M("`@("`@("`@("`@("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N:7IE7W-U
M8G1Y<&4H='EP95]O8FHN=&%R9V5T*"DI("L@)R8F)PH*("`@("`@("`@("`@
M='EP95]S='(@/2!G9&(N='EP97,N87!P;'E?='EP95]R96-O9VYI>F5R<R@*
M("`@("`@("`@("`@("`@("`@("!G9&(N='EP97,N9V5T7W1Y<&5?<F5C;V=N
M:7IE<G,H*2P@='EP95]O8FHI"B`@("`@("`@("`@(&EF('1Y<&5?<W1R.@H@
M("`@("`@("`@("`@("`@<F5T=7)N('1Y<&5?<W1R"B`@("`@("`@("`@(')E
M='5R;B!S='(H='EP95]O8FHI"@H@("`@9&5F(&EN<W1A;G1I871E*'-E;&8I
M.@H@("`@("`@(")2971U<FX@82!R96-O9VYI>F5R(&]B:F5C="!F;W(@=&AI
M<R!T>7!E('!R:6YT97(N(@H@("`@("`@(')E='5R;B!S96QF+E]R96-O9VYI
M>F5R*'-E;&8N;F%M92P@<V5L9BYD969A<F=S*0H*9&5F(&%D9%]O;F5?=&5M
M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@;F%M92P@9&5F87)G<RDZ"B`@("!R
M(B(B"B`@("!!9&0@82!T>7!E('!R:6YT97(@9F]R(&$@8VQA<W,@=&5M<&QA
M=&4@=VET:"!D969A=6QT('1E;7!L871E(&%R9W5M96YT<RX*"B`@("!!<F=S
M.@H@("`@("`@(&YA;64@*'-T<BDZ(%1H92!T96UP;&%T92UN86UE(&]F('1H
M92!C;&%S<R!T96UP;&%T92X*("`@("`@("!D969A<F=S("AD:6-T(&EN=#IS
M=')I;F<I(%1H92!D969A=6QT('1E;7!L871E(&%R9W5M96YT<RX*"B`@("!4
M>7!E<R!I;B!D969A<F=S(&-A;B!R969E<B!T;R!T:&4@3G1H('1E;7!L871E
M+6%R9W5M96YT('5S:6YG('M.?0H@("`@*'=I=&@@>F5R;RUB87-E9"!I;F1I
M8V5S*2X*"B`@("!E+F<N("=U;F]R9&5R961?;6%P)R!H87,@=&AE<V4@9&5F
M87)G<SH*("`@('L@,CH@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@("`@,SH@)W-T
M9#HZ97%U86Q?=&\\>S!]/B<L"B`@("`@(#0Z("=S=&0Z.F%L;&]C871O<CQS
M=&0Z.G!A:7(\8V]N<W0@>S!]+"![,7T^(#XG('T*"B`@("`B(B(*("`@('!R
M:6YT97(@/2!496UP;&%T951Y<&50<FEN=&5R*"=S=&0Z.B<K;F%M92P@9&5F
M87)G<RD*("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT97(H;V)J
M+"!P<FEN=&5R*0H*("`@(",@061D('1Y<&4@<')I;G1E<B!F;W(@<V%M92!T
M>7!E(&EN(&1E8G5G(&YA;65S<&%C93H*("`@('!R:6YT97(@/2!496UP;&%T
M951Y<&50<FEN=&5R*"=S=&0Z.E]?9&5B=6<Z.B<K;F%M92P@9&5F87)G<RD*
M("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT97(H;V)J+"!P<FEN
M=&5R*0H*("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@(",@
M061D('-E8V]N9"!T>7!E('!R:6YT97(@9F]R('-A;64@='EP92!I;B!V97)S
M:6]N960@;F%M97-P86-E.@H@("`@("`@(&YS(#T@)W-T9#HZ)R`K(%]V97)S
M:6]N961?;F%M97-P86-E"B`@("`@("`@(R!04B`X-C$Q,B!#86YN;W0@=7-E
M(&1I8W0@8V]M<')E:&5N<VEO;B!H97)E.@H@("`@("`@(&1E9F%R9W,@/2!D
M:6-T*"AN+"!D+G)E<&QA8V4H)W-T9#HZ)RP@;G,I*2!F;W(@*&XL9"D@:6X@
M9&5F87)G<RYI=&5M<R@I*0H@("`@("`@('!R:6YT97(@/2!496UP;&%T951Y
M<&50<FEN=&5R*&YS*VYA;64L(&1E9F%R9W,I"B`@("`@("`@9V1B+G1Y<&5S
M+G)E9VES=&5R7W1Y<&5?<')I;G1E<BAO8FHL('!R:6YT97(I"@IC;&%S<R!&
M:6QT97)I;F=4>7!E4')I;G1E<BAO8FIE8W0I.@H@("`@<B(B(@H@("`@02!T
M>7!E('!R:6YT97(@=&AA="!U<V5S('1Y<&5D968@;F%M97,@9F]R(&-O;6UO
M;B!T96UP;&%T92!S<&5C:6%L:7IA=&EO;G,N"@H@("`@07)G<SH*("`@("`@
M("!M871C:"`H<W1R*3H@5&AE(&-L87-S('1E;7!L871E('1O(')E8V]G;FEZ
M92X*("`@("`@("!N86UE("AS='(I.B!4:&4@='EP961E9BUN86UE('1H870@
M=VEL;"!B92!U<V5D(&EN<W1E860N"@H@("`@0VAE8VMS(&EF(&$@<W!E8VEA
M;&EZ871I;VX@;V8@=&AE(&-L87-S('1E;7!L871E("=M871C:"<@:7,@=&AE
M('-A;64@='EP90H@("`@87,@=&AE('1Y<&5D968@)VYA;64G+"!A;F0@<')I
M;G1S(&ET(&%S("=N86UE)R!I;G-T96%D+@H*("`@(&4N9RX@:68@86X@:6YS
M=&%N=&EA=&EO;B!O9B!S=&0Z.F)A<VEC7VES=')E86T\0RP@5#X@:7,@=&AE
M('-A;64@='EP92!A<PH@("`@<W1D.CII<W1R96%M('1H96X@<')I;G0@:70@
M87,@<W1D.CII<W1R96%M+@H@("`@(B(B"@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L(&UA=&-H+"!N86UE*3H*("`@("`@("!S96QF+FUA=&-H(#T@;6%T8V@*
M("`@("`@("!S96QF+FYA;64@/2!N86UE"B`@("`@("`@<V5L9BYE;F%B;&5D
M(#T@5')U90H*("`@(&-L87-S(%]R96-O9VYI>F5R*&]B:F5C="DZ"B`@("`@
M("`@(E1H92!R96-O9VYI>F5R(&-L87-S(&9O<B!496UP;&%T951Y<&50<FEN
M=&5R+B(*"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&UA=&-H+"!N86UE
M*3H*("`@("`@("`@("`@<V5L9BYM871C:"`](&UA=&-H"B`@("`@("`@("`@
M('-E;&8N;F%M92`](&YA;64*("`@("`@("`@("`@<V5L9BYT>7!E7V]B:B`]
M($YO;F4*"B`@("`@("`@9&5F(')E8V]G;FEZ92AS96QF+"!T>7!E7V]B:BDZ
M"B`@("`@("`@("`@("(B(@H@("`@("`@("`@("!)9B!T>7!E7V]B:B!S=&%R
M=',@=VET:"!S96QF+FUA=&-H(&%N9"!I<R!T:&4@<V%M92!T>7!E(&%S"B`@
M("`@("`@("`@('-E;&8N;F%M92!T:&5N(')E='5R;B!S96QF+FYA;64L(&]T
M:&5R=VES92!.;VYE+@H@("`@("`@("`@("`B(B(*("`@("`@("`@("`@:68@
M='EP95]O8FHN=&%G(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!R971U<FX@
M3F]N90H*("`@("`@("`@("`@:68@<V5L9BYT>7!E7V]B:B!I<R!.;VYE.@H@
M("`@("`@("`@("`@("`@:68@;F]T('1Y<&5?;V)J+G1A9RYS=&%R='-W:71H
M*'-E;&8N;6%T8V@I.@H@("`@("`@("`@("`@("`@("`@(",@1FEL=&5R(&1I
M9&XG="!M871C:"X*("`@("`@("`@("`@("`@("`@("!R971U<FX@3F]N90H@
M("`@("`@("`@("`@("`@=')Y.@H@("`@("`@("`@("`@("`@("`@('-E;&8N
M='EP95]O8FH@/2!G9&(N;&]O:W5P7W1Y<&4H<V5L9BYN86UE*2YS=')I<%]T
M>7!E9&5F<R@I"B`@("`@("`@("`@("`@("!E>&-E<'0Z"B`@("`@("`@("`@
M("`@("`@("`@<&%S<PH@("`@("`@("`@("!I9B!S96QF+G1Y<&5?;V)J(#T]
M('1Y<&5?;V)J.@H@("`@("`@("`@("`@("`@<F5T=7)N('-T<FEP7VEN;&EN
M95]N86UE<W!A8V5S*'-E;&8N;F%M92D*("`@("`@("`@("`@<F5T=7)N($YO
M;F4*"B`@("!D968@:6YS=&%N=&EA=&4H<V5L9BDZ"B`@("`@("`@(E)E='5R
M;B!A(')E8V]G;FEZ97(@;V)J96-T(&9O<B!T:&ES('1Y<&4@<')I;G1E<BXB
M"B`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ97(H<V5L9BYM871C:"P@
M<V5L9BYN86UE*0H*9&5F(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@;6%T
M8V@L(&YA;64I.@H@("`@<')I;G1E<B`]($9I;'1E<FEN9U1Y<&50<FEN=&5R
M*"=S=&0Z.B<@*R!M871C:"P@)W-T9#HZ)R`K(&YA;64I"B`@("!G9&(N='EP
M97,N<F5G:7-T97)?='EP95]P<FEN=&5R*&]B:BP@<')I;G1E<BD*("`@(&EF
M(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@(&YS(#T@)W-T9#HZ)R`K
M(%]V97)S:6]N961?;F%M97-P86-E"B`@("`@("`@<')I;G1E<B`]($9I;'1E
M<FEN9U1Y<&50<FEN=&5R*&YS("L@;6%T8V@L(&YS("L@;F%M92D*("`@("`@
M("!G9&(N='EP97,N<F5G:7-T97)?='EP95]P<FEN=&5R*&]B:BP@<')I;G1E
M<BD*"F1E9B!R96=I<W1E<E]T>7!E7W!R:6YT97)S*&]B:BDZ"B`@("!G;&]B
M86P@7W5S95]T>7!E7W!R:6YT:6YG"@H@("`@:68@;F]T(%]U<V5?='EP95]P
M<FEN=&EN9SH*("`@("`@("!R971U<FX*"B`@("`C($%D9"!T>7!E('!R:6YT
M97)S(&9O<B!T>7!E9&5F<R!S=&0Z.G-T<FEN9RP@<W1D.CIW<W1R:6YG(&5T
M8RX*("`@(&9O<B!C:"!I;B`H)R<L("=W)RP@)W4X)RP@)W4Q-B<L("=U,S(G
M*3H*("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=B87-I8U]S
M=')I;F<G+"!C:"`K("=S=')I;F<G*0H@("`@("`@(&%D9%]O;F5?='EP95]P
M<FEN=&5R*&]B:BP@)U]?8WAX,3$Z.F)A<VEC7W-T<FEN9R<L(&-H("L@)W-T
M<FEN9R<I"B`@("`@("`@(R!4>7!E9&5F<R!F;W(@7U]C>'@Q,3HZ8F%S:6-?
M<W1R:6YG('5S960@=&\@8F4@:6X@;F%M97-P86-E(%]?8WAX,3$Z"B`@("`@
M("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G7U]C>'@Q,3HZ8F%S:6-?
M<W1R:6YG)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G7U]C>'@Q
M,3HZ)R`K(&-H("L@)W-T<FEN9R<I"B`@("`@("`@861D7V]N95]T>7!E7W!R
M:6YT97(H;V)J+"`G8F%S:6-?<W1R:6YG7W9I97<G+"!C:"`K("=S=')I;F=?
M=FEE=R<I"@H@("`@(R!!9&0@='EP92!P<FEN=&5R<R!F;W(@='EP961E9G,@
M<W1D.CII<W1R96%M+"!S=&0Z.G=I<W1R96%M(&5T8RX*("`@(&9O<B!C:"!I
M;B`H)R<L("=W)RDZ"B`@("`@("`@9F]R('@@:6X@*"=I;W,G+"`G<W1R96%M
M8G5F)RP@)VES=')E86TG+"`G;W-T<F5A;2<L("=I;W-T<F5A;2<L"B`@("`@
M("`@("`@("`@("`@("=F:6QE8G5F)RP@)VEF<W1R96%M)RP@)V]F<W1R96%M
M)RP@)V9S=')E86TG*3H*("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT
M97(H;V)J+"`G8F%S:6-?)R`K('@L(&-H("L@>"D*("`@("`@("!F;W(@>"!I
M;B`H)W-T<FEN9V)U9B<L("=I<W1R:6YG<W1R96%M)RP@)V]S=')I;F=S=')E
M86TG+`H@("`@("`@("`@("`@("`@("`G<W1R:6YG<W1R96%M)RDZ"B`@("`@
M("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)V)A<VEC7R<@*R!X
M+"!C:"`K('@I"B`@("`@("`@("`@(",@/'-S=')E86T^('1Y<&5S(&%R92!I
M;B!?7V-X>#$Q(&YA;65S<&%C92P@8G5T('1Y<&5D969S(&%R96XG=#H*("`@
M("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G7U]C>'@Q,3HZ
M8F%S:6-?)R`K('@L(&-H("L@>"D*"B`@("`C($%D9"!T>7!E('!R:6YT97)S
M(&9O<B!T>7!E9&5F<R!R96=E>"P@=W)E9V5X+"!C;6%T8V@L('=C;6%T8V@@
M971C+@H@("`@9F]R(&%B:2!I;B`H)R<L("=?7V-X>#$Q.CHG*3H*("`@("`@
M("!F;W(@8V@@:6X@*"<G+"`G=R<I.@H@("`@("`@("`@("!A9&1?;VYE7W1Y
M<&5?<')I;G1E<BAO8FHL(&%B:2`K("=B87-I8U]R96=E>"<L(&%B:2`K(&-H
M("L@)W)E9V5X)RD*("`@("`@("!F;W(@8V@@:6X@*"=C)RP@)W,G+"`G=V,G
M+"`G=W,G*3H*("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J
M+"!A8FD@*R`G;6%T8VA?<F5S=6QT<R<L(&%B:2`K(&-H("L@)VUA=&-H)RD*
M("`@("`@("`@("`@9F]R('@@:6X@*"=S=6)?;6%T8V@G+"`G<F5G97A?:71E
M<F%T;W(G+"`G<F5G97A?=&]K96Y?:71E<F%T;W(G*3H*("`@("`@("`@("`@
M("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@86)I("L@>"P@86)I("L@
M8V@@*R!X*0H*("`@(",@3F]T92!T:&%T('=E(&-A;B=T(&AA=F4@82!P<FEN
M=&5R(&9O<B!S=&0Z.G=S=')E86UP;W,L(&)E8V%U<V4*("`@(",@:70@:7,@
M=&AE('-A;64@='EP92!A<R!S=&0Z.G-T<F5A;7!O<RX*("`@(&%D9%]O;F5?
M='EP95]P<FEN=&5R*&]B:BP@)V9P;W,G+"`G<W1R96%M<&]S)RD*"B`@("`C
M($%D9"!T>7!E('!R:6YT97)S(&9O<B`\8VAR;VYO/B!T>7!E9&5F<RX*("`@
M(&9O<B!D=7(@:6X@*"=N86YO<V5C;VYD<R<L("=M:6-R;W-E8V]N9',G+"`G
M;6EL;&ES96-O;F1S)RP*("`@("`@("`@("`@("`@("=S96-O;F1S)RP@)VUI
M;G5T97,G+"`G:&]U<G,G*3H*("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E
M<BAO8FHL("=D=7)A=&EO;B<L(&1U<BD*"B`@("`C($%D9"!T>7!E('!R:6YT
M97)S(&9O<B`\<F%N9&]M/B!T>7!E9&5F<RX*("`@(&%D9%]O;F5?='EP95]P
M<FEN=&5R*&]B:BP@)VQI;F5A<E]C;VYG<G5E;G1I86Q?96YG:6YE)RP@)VUI
M;G-T9%]R86YD,"<I"B`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=L
M:6YE87)?8V]N9W)U96YT:6%L7V5N9VEN92<L("=M:6YS=&1?<F%N9"<I"B`@
M("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=M97)S96YN95]T=VES=&5R
M7V5N9VEN92<L("=M=#$Y.3,W)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R
M*&]B:BP@)VUE<G-E;FYE7W1W:7-T97)?96YG:6YE)RP@)VUT,3DY,S=?-C0G
M*0H@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G<W5B=')A8W1?=VET
M:%]C87)R>5]E;F=I;F4G+"`G<F%N;'5X,C1?8F%S92<I"B`@("!A9&1?;VYE
M7W1Y<&5?<')I;G1E<BAO8FHL("=S=6)T<F%C=%]W:71H7V-A<G)Y7V5N9VEN
M92<L("=R86YL=7@T.%]B87-E)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R
M*&]B:BP@)V1I<V-A<F1?8FQO8VM?96YG:6YE)RP@)W)A;FQU>#(T)RD*("`@
M(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)V1I<V-A<F1?8FQO8VM?96YG
M:6YE)RP@)W)A;FQU>#0X)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B
M:BP@)W-H=69F;&5?;W)D97)?96YG:6YE)RP@)VMN=71H7V(G*0H*("`@(",@
M061D('1Y<&4@<')I;G1E<G,@9F]R(&5X<&5R:6UE;G1A;#HZ8F%S:6-?<W1R
M:6YG7W9I97<@='EP961E9G,N"B`@("!N<R`]("=E>'!E<FEM96YT86PZ.F9U
M;F1A;65N=&%L<U]V,3HZ)PH@("`@9F]R(&-H(&EN("@G)RP@)W<G+"`G=3@G
M+"`G=3$V)RP@)W4S,B<I.@H@("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R
M*&]B:BP@;G,@*R`G8F%S:6-?<W1R:6YG7W9I97<G+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(&YS("L@8V@@*R`G<W1R:6YG7W9I97<G*0H*("`@
M(",@1&\@;F]T('-H;W<@9&5F875L=&5D('1E;7!L871E(&%R9W5M96YT<R!I
M;B!C;&%S<R!T96UP;&%T97,N"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?
M<')I;G1E<BAO8FHL("=U;FEQ=65?<'1R)RP*("`@("`@("`@("`@>R`Q.B`G
M<W1D.CID969A=6QT7V1E;&5T93Q[,'T^)R!]*0H@("`@861D7V]N95]T96UP
M;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G9&5Q=64G+"![(#$Z("=S=&0Z.F%L
M;&]C871O<CQ[,'T^)WTI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I
M;G1E<BAO8FHL("=F;W)W87)D7VQI<W0G+"![(#$Z("=S=&0Z.F%L;&]C871O
M<CQ[,'T^)WTI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO
M8FHL("=L:7-T)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@
M861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G7U]C>'@Q,3HZ
M;&ES="<L('L@,3H@)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O
M;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W9E8W1O<B<L('L@,3H@
M)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?
M='EP95]P<FEN=&5R*&]B:BP@)VUA<"<L"B`@("`@("`@("`@('L@,CH@)W-T
M9#HZ;&5S<SQ[,'T^)RP*("`@("`@("`@("`@("`S.B`G<W1D.CIA;&QO8V%T
M;W(\<W1D.CIP86ER/'LP?2!C;VYS="P@>S%]/CXG('TI"B`@("!A9&1?;VYE
M7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=M=6QT:6UA<"<L"B`@("`@
M("`@("`@('L@,CH@)W-T9#HZ;&5S<SQ[,'T^)RP*("`@("`@("`@("`@("`S
M.B`G<W1D.CIA;&QO8V%T;W(\<W1D.CIP86ER/'LP?2!C;VYS="P@>S%]/CXG
M('TI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=S
M970G+`H@("`@("`@("`@("![(#$Z("=S=&0Z.FQE<W,\>S!]/B<L(#(Z("=S
M=&0Z.F%L;&]C871O<CQ[,'T^)R!]*0H@("`@861D7V]N95]T96UP;&%T95]T
M>7!E7W!R:6YT97(H;V)J+"`G;75L=&ES970G+`H@("`@("`@("`@("![(#$Z
M("=S=&0Z.FQE<W,\>S!]/B<L(#(Z("=S=&0Z.F%L;&]C871O<CQ[,'T^)R!]
M*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO
M<F1E<F5D7VUA<"<L"B`@("`@("`@("`@('L@,CH@)W-T9#HZ:&%S:#Q[,'T^
M)RP*("`@("`@("`@("`@("`S.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@
M("`@("`@("`@("`T.B`G<W1D.CIA;&QO8V%T;W(\<W1D.CIP86ER/'LP?2!C
M;VYS="P@>S%]/CXG?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN
M=&5R*&]B:BP@)W5N;W)D97)E9%]M=6QT:6UA<"<L"B`@("`@("`@("`@('L@
M,CH@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@("`@("`@("`@("`S.B`G<W1D.CIE
M<75A;%]T;SQ[,'T^)RP*("`@("`@("`@("`@("`T.B`G<W1D.CIA;&QO8V%T
M;W(\<W1D.CIP86ER/'LP?2!C;VYS="P@>S%]/CXG?2D*("`@(&%D9%]O;F5?
M=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W5N;W)D97)E9%]S970G+`H@
M("`@("`@("`@("![(#$Z("=S=&0Z.FAA<V@\>S!]/B<L"B`@("`@("`@("`@
M("`@,CH@)W-T9#HZ97%U86Q?=&\\>S!]/B<L"B`@("`@("`@("`@("`@,SH@
M)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?
M='EP95]P<FEN=&5R*&]B:BP@)W5N;W)D97)E9%]M=6QT:7-E="<L"B`@("`@
M("`@("`@('L@,3H@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@("`@("`@("`@("`R
M.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@("`@("`@("`@("`S.B`G<W1D
M.CIA;&QO8V%T;W(\>S!]/B=]*0H*9&5F(')E9VES=&5R7VQI8G-T9&-X>%]P
M<FEN=&5R<R`H;V)J*3H*("`@(")296=I<W1E<B!L:6)S=&1C*RL@<')E='1Y
M+7!R:6YT97)S('=I=&@@;V)J9FEL92!/8FHN(@H*("`@(&=L;V)A;"!?=7-E
M7V=D8E]P<`H@("`@9VQO8F%L(&QI8G-T9&-X>%]P<FEN=&5R"@H@("`@:68@
M7W5S95]G9&)?<'`Z"B`@("`@("`@9V1B+G!R:6YT:6YG+G)E9VES=&5R7W!R
M971T>5]P<FEN=&5R*&]B:BP@;&EB<W1D8WAX7W!R:6YT97(I"B`@("!E;'-E
M.@H@("`@("`@(&EF(&]B:B!I<R!.;VYE.@H@("`@("`@("`@("!O8FH@/2!G
M9&(*("`@("`@("!O8FHN<')E='1Y7W!R:6YT97)S+F%P<&5N9"AL:6)S=&1C
M>'A?<')I;G1E<BD*"B`@("!R96=I<W1E<E]T>7!E7W!R:6YT97)S*&]B:BD*
M"F1E9B!B=6EL9%]L:6)S=&1C>'A?9&EC=&EO;F%R>2`H*3H*("`@(&=L;V)A
M;"!L:6)S=&1C>'A?<')I;G1E<@H*("`@(&QI8G-T9&-X>%]P<FEN=&5R(#T@
M4')I;G1E<B@B;&EB<W1D8RLK+78V(BD*"B`@("`C(&QI8G-T9&,K*R!O8FIE
M8W1S(')E<75I<FEN9R!P<F5T='DM<')I;G1I;F<N"B`@("`C($EN(&]R9&5R
M(&9R;VTZ"B`@("`C(&AT='`Z+R]G8V,N9VYU+F]R9R]O;FQI;F5D;V-S+VQI
M8G-T9&,K*R]L871E<W0M9&]X>6=E;B]A,#$X-#<N:'1M;`H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)V)A<VEC7W-T<FEN
M9R<L(%-T9%-T<FEN9U!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA
M9&1?=F5R<VEO;B@G<W1D.CI?7V-X>#$Q.CHG+"`G8F%S:6-?<W1R:6YG)RP@
M4W1D4W1R:6YG4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C
M;VYT86EN97(H)W-T9#HZ)RP@)V)I='-E="<L(%-T9$)I='-E=%!R:6YT97(I
M"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L
M("=D97%U92<L(%-T9$1E<75E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)VQI<W0G+"!3=&1,:7-T4')I
M;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T
M9#HZ7U]C>'@Q,3HZ)RP@)VQI<W0G+"!3=&1,:7-T4')I;G1E<BD*("`@(&QI
M8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)VUA<"<L
M(%-T9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N
M=&%I;F5R*"=S=&0Z.B<L("=M=6QT:6UA<"<L(%-T9$UA<%!R:6YT97(I"B`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=M
M=6QT:7-E="<L(%-T9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G<&%I<B<L(%-T9%!A:7)0<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@
M)W!R:6]R:71Y7W%U975E)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@(%-T9%-T86-K3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?
M<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G<75E=64G+"!3=&13=&%C
M:T]R475E=650<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E
M<G-I;VXH)W-T9#HZ)RP@)W1U<&QE)RP@4W1D5'5P;&50<FEN=&5R*0H@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G<V5T
M)RP@4W1D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V
M97)S:6]N*"=S=&0Z.B<L("=S=&%C:R<L(%-T9%-T86-K3W)1=65U95!R:6YT
M97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG
M+"`G=6YI<75E7W!T<B<L(%5N:7%U95!O:6YT97)0<FEN=&5R*0H@("`@;&EB
M<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G=F5C=&]R
M)RP@4W1D5F5C=&]R4')I;G1E<BD*("`@(",@=F5C=&]R/&)O;VP^"@H@("`@
M(R!0<FEN=&5R(')E9VES=')A=&EO;G,@9F]R(&-L87-S97,@8V]M<&EL960@
M=VET:"`M1%]'3$E"0UA87T1%0E5'+@H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D*"=S=&0Z.E]?9&5B=6<Z.F)I='-E="<L(%-T9$)I='-E=%!R:6YT97(I
M"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ9&5Q
M=64G+"!3=&1$97%U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA
M9&0H)W-T9#HZ7U]D96)U9SHZ;&ES="<L(%-T9$QI<W10<FEN=&5R*0H@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.FUA<"<L(%-T
M9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ;75L=&EM87`G+"!3=&1-87!0<FEN=&5R*0H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.FUU;'1I<V5T)RP@4W1D
M4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?
M7V1E8G5G.CIP<FEO<FET>5]Q=65U92<L"B`@("`@("`@("`@("`@("`@("`@
M("`@("`@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIQ=65U92<L(%-T9%-T86-K3W)1
M=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIS=&%C:R<L(%-T9%-T86-K3W)1
M=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ=6YI<75E7W!T<B<L(%5N:7%U95!O:6YT97)0<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G9E8W1O
M<B<L(%-T9%9E8W1O<E!R:6YT97(I"@H@("`@(R!4:&5S92!A<F4@=&AE(%12
M,2!A;F0@0RLK,3$@<')I;G1E<G,N"B`@("`C($9O<B!A<G)A>2`M('1H92!D
M969A=6QT($=$0B!P<F5T='DM<')I;G1E<B!S965M<R!R96%S;VYA8FQE+@H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)W-H
M87)E9%]P='(G+"!3:&%R9610;VEN=&5R4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=W96%K7W!T<B<L(%-H
M87)E9%!O:6YT97)0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7V-O;G1A:6YE<B@G<W1D.CHG+"`G=6YO<F1E<F5D7VUA<"<L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9$UA<%!R
M:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S
M=&0Z.B<L("=U;F]R9&5R961?<V5T)RP*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D4V5T4')I;G1E<BD*("`@(&QI
M8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)W5N;W)D
M97)E9%]M=6QT:6UA<"<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@(%1R,55N;W)D97)E9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?
M<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=U;F]R9&5R961?;75L
M=&ES970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!4
M<C%5;F]R9&5R96139710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G9F]R=V%R9%]L:7-T)RP*("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D1F]R=V%R9$QI<W10
M<FEN=&5R*0H*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.G1R,3HZ)RP@)W-H87)E9%]P='(G+"!3:&%R9610;VEN=&5R4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R
M,3HZ)RP@)W=E86M?<'1R)RP@4VAA<F5D4&]I;G1E<E!R:6YT97(I"B`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIT<C$Z.B<L("=U
M;F]R9&5R961?;6%P)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@(%1R,55N;W)D97)E9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I
M;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIT<C$Z.B<L("=U;F]R9&5R961?<V5T
M)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D
M97)E9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R
M<VEO;B@G<W1D.CIT<C$Z.B<L("=U;F]R9&5R961?;75L=&EM87`G+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P
M4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]M=6QT:7-E="<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R96139710<FEN=&5R
M*0H*("`@(",@5&AE<V4@87)E('1H92!#*RLQ,2!P<FEN=&5R(')E9VES=')A
M=&EO;G,@9F]R("U$7T=,24)#6%A?1$5"54<@8V%S97,N"B`@("`C(%1H92!T
M<C$@;F%M97-P86-E(&-O;G1A:6YE<G,@9&\@;F]T(&AA=F4@86YY(&1E8G5G
M(&5Q=6EV86QE;G1S+`H@("`@(R!S;R!D;R!N;W0@<F5G:7-T97(@<')I;G1E
M<G,@9F]R('1H96TN"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ=6YO<F1E<F5D7VUA<"<L"B`@("`@("`@("`@("`@("`@("`@
M("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;F]R9&5R961?<V5T)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R96139710<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N
M;W)D97)E9%]M=6QT:6UA<"<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R
M+F%D9"@G<W1D.CI?7V1E8G5G.CIU;F]R9&5R961?;75L=&ES970G+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9%-E=%!R:6YT97(I
M"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ9F]R
M=V%R9%]L:7-T)RP*("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1&;W)W
M87)D3&ES=%!R:6YT97(I"@H@("`@(R!,:6)R87)Y($9U;F1A;65N=&%L<R!4
M4R!C;VUP;VYE;G1S"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO
M;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V,3HZ)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=A;GDG+"!3=&1%>'!!
M;GE0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ97AP97)I;65N=&%L.CIF=6YD86UE;G1A;'-?=C$Z.B<L"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G;W!T:6]N86PG+"!3=&1%
M>'!/<'1I;VYA;%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?
M=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V,3HZ
M)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=B87-I8U]S
M=')I;F=?=FEE=R<L(%-T9$5X<%-T<FEN9U9I97=0<FEN=&5R*0H@("`@(R!&
M:6QE<WES=&5M(%13(&-O;7!O;F5N=',*("`@(&QI8G-T9&-X>%]P<FEN=&5R
M+F%D9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ9FEL97-Y<W1E;3HZ
M=C$Z.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G<&%T
M:"<L(%-T9$5X<%!A=&A0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7W9E<G-I;VXH)W-T9#HZ97AP97)I;65N=&%L.CIF:6QE<WES=&5M.CIV
M,3HZ7U]C>'@Q,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("=P871H)RP@4W1D17AP4&%T:%!R:6YT97(I"B`@("!L:6)S=&1C>'A?
M<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIF:6QE<WES=&5M.CHG+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@)W!A=&@G+"!3=&10871H
M4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.F9I;&5S>7-T96TZ.E]?8WAX,3$Z.B<L"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`G<&%T:"<L(%-T9%!A=&A0<FEN=&5R*0H*("`@
M(",@0RLK,3<@8V]M<&]N96YT<PH@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7W9E<G-I;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("=A;GDG+"!3=&1%>'!!;GE0<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("=O<'1I;VYA;"<L(%-T9$5X<$]P=&EO;F%L
M4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G8F%S
M:6-?<W1R:6YG7W9I97<G+"!3=&1%>'!3=')I;F=6:65W4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G=F%R:6%N="<L(%-T9%9A
M<FEA;G10<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I
M;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("=?3F]D95]H86YD;&4G+"!3=&1.;V1E2&%N9&QE4')I;G1E<BD*"B`@("`C
M($5X=&5N<VEO;G,N"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO
M;B@G7U]G;G5?8WAX.CHG+"`G<VQI<W0G+"!3=&13;&ES=%!R:6YT97(I"@H@
M("`@:68@5')U93H*("`@("`@("`C(%1H97-E('-H;W5L9&XG="!B92!N96-E
M<W-A<GDL(&EF($=$0B`B<')I;G0@*FDB('=O<FME9"X*("`@("`@("`C($)U
M="!I="!O9G1E;B!D;V5S;B=T+"!S;R!H97)E('1H97D@87)E+@H@("`@("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)U],
M:7-T7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@(%-T9$QI<W1)=&5R871O<E!R:6YT97(I"B`@("`@("`@;&EB
M<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G7TQI<W1?
M8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@4W1D3&ES=$ET97)A=&]R4')I;G1E<BD*("`@("`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G7U)B7W1R
M965?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@(%-T9%)B=')E94ET97)A=&]R4')I;G1E<BD*("`@("`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G7U)B7W1R965?
M8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@(%-T9%)B=')E94ET97)A=&]R4')I;G1E<BD*("`@("`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=?1&5Q
M=65?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@4W1D1&5Q=65)=&5R871O<E!R:6YT97(I"B`@("`@("`@;&EB
M<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G7T1E<75E
M7V-O;G-T7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@(%-T9$1E<75E271E<F%T;W)0<FEN=&5R*0H@("`@("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=?7V=N=5]C>'@Z.B<L
M("=?7VYO<FUA;%]I=&5R871O<B<L"B`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@4W1D5F5C=&]R271E<F%T;W)0<FEN=&5R*0H@("`@
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=?7V=N=5]C>'@Z
M.B<L("=?4VQI<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(%-T9%-L:7-T271E<F%T;W)0<FEN=&5R*0H@("`@
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@
M)U]&=V1?;&ES=%]I=&5R871O<B<L"B`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("!3=&1&=V1,:7-T271E<F%T;W)0<FEN=&5R*0H@
M("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ
M)RP@)U]&=V1?;&ES=%]C;VYS=%]I=&5R871O<B<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1&=V1,:7-T271E<F%T;W)0
M<FEN=&5R*0H*("`@("`@("`C($1E8G5G("AC;VUP:6QE9"!W:71H("U$7T=,
M24)#6%A?1$5"54<I('!R:6YT97(*("`@("`@("`C(')E9VES=')A=&EO;G,N
M"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=?7V=N=5]D96)U9SHZ
M7U-A9F5?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!3=&1$96)U9TET97)A=&]R4')I;G1E<BD*"F)U:6QD7VQI8G-T9&-X>%]D
M:6-T:6]N87)Y("@I"@``````````````````````````````````````````
M`````````````````````````"XO<'ET:&]N+VQI8G-T9&-X>"]V-B]X;65T
M:&]D<RYP>0``````````````````````````````````````````````````
M```````````````````````````````````````P,#`P-C0T`#`V,#$W-3$`
M,#8P,3<U,0`P,#`P,#`V-S`P,P`Q,S0W-C`R,#8P-@`P,38R-C0`(#``````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````=7-T87(@(`!F<F5D90``````````````````````````````````
M`&9R961E````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````(R!8;65T:&]D
M<R!F;W(@;&EB<W1D8RLK+@H*(R!#;W!Y<FEG:'0@*$,I(#(P,30M,C`Q.2!&
M<F5E(%-O9G1W87)E($9O=6YD871I;VXL($EN8RX*"B,@5&AI<R!P<F]G<F%M
M(&ES(&9R964@<V]F='=A<F4[('EO=2!C86X@<F5D:7-T<FEB=71E(&ET(&%N
M9"]O<B!M;V1I9GD*(R!I="!U;F1E<B!T:&4@=&5R;7,@;V8@=&AE($=.52!'
M96YE<F%L(%!U8FQI8R!,:6-E;G-E(&%S('!U8FQI<VAE9"!B>0HC('1H92!&
M<F5E(%-O9G1W87)E($9O=6YD871I;VX[(&5I=&AE<B!V97)S:6]N(#,@;V8@
M=&AE($QI8V5N<V4L(&]R"B,@*&%T('EO=7(@;W!T:6]N*2!A;GD@;&%T97(@
M=F5R<VEO;BX*(PHC(%1H:7,@<')O9W)A;2!I<R!D:7-T<FEB=71E9"!I;B!T
M:&4@:&]P92!T:&%T(&ET('=I;&P@8F4@=7-E9G5L+`HC(&)U="!7251(3U54
M($%.62!705)204Y463L@=VET:&]U="!E=F5N('1H92!I;7!L:65D('=A<G)A
M;G1Y(&]F"B,@34520TA!3E1!0DE,2519(&]R($9)5$Y%4U,@1D]2($$@4$%2
M5$E#54Q!4B!055)03U-%+B`@4V5E('1H90HC($=.52!'96YE<F%L(%!U8FQI
M8R!,:6-E;G-E(&9O<B!M;W)E(&1E=&%I;',N"B,*(R!9;W4@<VAO=6QD(&AA
M=F4@<F5C96EV960@82!C;W!Y(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@
M3&EC96YS90HC(&%L;VYG('=I=&@@=&AI<R!P<F]G<F%M+B`@268@;F]T+"!S
M964@/&AT='`Z+R]W=W<N9VYU+F]R9R]L:6-E;G-E<R\^+@H*:6UP;W)T(&=D
M8@II;7!O<G0@9V1B+GAM971H;V0*:6UP;W)T(')E"@IM871C:&5R7VYA;65?
M<')E9FEX(#T@)VQI8G-T9&,K*SHZ)PH*9&5F(&=E=%]B;V]L7W1Y<&4H*3H*
M("`@(')E='5R;B!G9&(N;&]O:W5P7W1Y<&4H)V)O;VPG*0H*9&5F(&=E=%]S
M=&1?<VEZ95]T>7!E*"DZ"B`@("!R971U<FX@9V1B+FQO;VMU<%]T>7!E*"=S
M=&0Z.G-I>F5?="<I"@IC;&%S<R!,:6)3=&1#>'A8365T:&]D*&=D8BYX;65T
M:&]D+EA-971H;V0I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YA;64L('=O
M<FME<E]C;&%S<RDZ"B`@("`@("`@9V1B+GAM971H;V0N6$UE=&AO9"Y?7VEN
M:71?7RAS96QF+"!N86UE*0H@("`@("`@('-E;&8N=V]R:V5R7V-L87-S(#T@
M=V]R:V5R7V-L87-S"@HC(%AM971H;V1S(&9O<B!S=&0Z.F%R<F%Y"@IC;&%S
M<R!!<G)A>5=O<FME<D)A<V4H9V1B+GAM971H;V0N6$UE=&AO9%=O<FME<BDZ
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I.@H@("`@
M("`@('-E;&8N7W9A;%]T>7!E(#T@=F%L7W1Y<&4*("`@("`@("!S96QF+E]S
M:7IE(#T@<VEZ90H*("`@(&1E9B!N=6QL7W9A;'5E*'-E;&8I.@H@("`@("`@
M(&YU;&QP='(@/2!G9&(N<&%R<V5?86YD7V5V86PH)RAV;VED("HI(#`G*0H@
M("`@("`@(')E='5R;B!N=6QL<'1R+F-A<W0H<V5L9BY?=F%L7W1Y<&4N<&]I
M;G1E<B@I*2YD97)E9F5R96YC92@I"@IC;&%S<R!!<G)A>5-I>F57;W)K97(H
M07)R87E7;W)K97)"87-E*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?
M='EP92P@<VEZ92DZ"B`@("`@("`@07)R87E7;W)K97)"87-E+E]?:6YI=%]?
M*'-E;&8L('9A;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U
M;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?<W1D7W-I
M>F5?='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@
M("`@<F5T=7)N('-E;&8N7W-I>F4*"F-L87-S($%R<F%Y16UP='E7;W)K97(H
M07)R87E7;W)K97)"87-E*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?
M='EP92P@<VEZ92DZ"B`@("`@("`@07)R87E7;W)K97)"87-E+E]?:6YI=%]?
M*'-E;&8L('9A;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U
M;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?8F]O;%]T
M>7!E*"D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R
M971U<FX@*&EN="AS96QF+E]S:7IE*2`]/2`P*0H*8VQA<W,@07)R87E&<F]N
M=%=O<FME<BA!<G)A>5=O<FME<D)A<V4I.@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L('9A;%]T>7!E+"!S:7IE*3H*("`@("`@("!!<G)A>5=O<FME<D)A<V4N
M7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I"@H@("`@9&5F(&=E=%]A
M<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@
M9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E
M;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@
M("`@("`@:68@:6YT*'-E;&8N7W-I>F4I(#X@,#H*("`@("`@("`@("`@<F5T
M=7)N(&]B:ELG7TU?96QE;7,G75LP70H@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@(')E='5R;B!S96QF+FYU;&Q?=F%L=64H*0H*8VQA<W,@07)R87E"86-K
M5V]R:V5R*$%R<F%Y5V]R:V5R0F%S92DZ"B`@("!D968@7U]I;FET7U\H<V5L
M9BP@=F%L7W1Y<&4L('-I>F4I.@H@("`@("`@($%R<F%Y5V]R:V5R0F%S92Y?
M7VEN:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92D*"B`@("!D968@9V5T7V%R
M9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G
M971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L
M9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@
M("`@("!I9B!I;G0H<V5L9BY?<VEZ92D@/B`P.@H@("`@("`@("`@("!R971U
M<FX@;V)J6R=?35]E;&5M<R==6W-E;&8N7W-I>F4@+2`Q70H@("`@("`@(&5L
M<V4Z"B`@("`@("`@("`@(')E='5R;B!S96QF+FYU;&Q?=F%L=64H*0H*8VQA
M<W,@07)R87E!=%=O<FME<BA!<G)A>5=O<FME<D)A<V4I.@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE*3H*("`@("`@("!!<G)A>5=O
M<FME<D)A<V4N7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I"@H@("`@
M9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S
M=&1?<VEZ95]T>7!E*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L
M(&]B:BP@:6YD97@I.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*
M("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!I
M9B!I;G0H:6YD97@I(#X](&EN="AS96QF+E]S:7IE*3H*("`@("`@("`@("`@
M<F%I<V4@26YD97A%<G)O<B@G07)R87D@:6YD97@@(B5D(B!S:&]U;&0@;F]T
M(&)E(#X]("5D+B<@)0H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("@H
M:6YT*&EN9&5X*2P@<V5L9BY?<VEZ92DI*0H@("`@("`@(')E='5R;B!O8FI;
M)U]-7V5L96US)UU;:6YD97A="@IC;&%S<R!!<G)A>5-U8G-C<FEP=%=O<FME
M<BA!<G)A>5=O<FME<D)A<V4I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A
M;%]T>7!E+"!S:7IE*3H*("`@("`@("!!<G)A>5=O<FME<D)A<V4N7U]I;FET
M7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I"@H@("`@9&5F(&=E=%]A<F=?='EP
M97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*
M"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@:6YD97@I.@H@
M("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?
M7RAS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!I9B!I;G0H<V5L9BY?<VEZ
M92D@/B`P.@H@("`@("`@("`@("!R971U<FX@;V)J6R=?35]E;&5M<R==6VEN
M9&5X70H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')E='5R;B!S96QF+FYU
M;&Q?=F%L=64H*0H*8VQA<W,@07)R87E-971H;V1S36%T8VAE<BAG9&(N>&UE
M=&AO9"Y8365T:&]D36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BDZ
M"B`@("`@("`@9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H
M<V5L9BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("!M871C:&5R7VYA;65?<')E9FEX("L@)V%R<F%Y)RD*("`@("`@("!S
M96QF+E]M971H;V1?9&EC="`]('L*("`@("`@("`@("`@)W-I>F4G.B!,:6)3
M=&1#>'A8365T:&]D*"=S:7IE)RP@07)R87E3:7IE5V]R:V5R*2P*("`@("`@
M("`@("`@)V5M<'1Y)SH@3&EB4W1D0WAX6$UE=&AO9"@G96UP='DG+"!!<G)A
M>45M<'1Y5V]R:V5R*2P*("`@("`@("`@("`@)V9R;VYT)SH@3&EB4W1D0WAX
M6$UE=&AO9"@G9G)O;G0G+"!!<G)A>49R;VYT5V]R:V5R*2P*("`@("`@("`@
M("`@)V)A8VLG.B!,:6)3=&1#>'A8365T:&]D*"=B86-K)RP@07)R87E"86-K
M5V]R:V5R*2P*("`@("`@("`@("`@)V%T)SH@3&EB4W1D0WAX6$UE=&AO9"@G
M870G+"!!<G)A>4%T5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R6UTG
M.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R871O<EM=)RP@07)R87E3=6)S8W)I
M<'17;W)K97(I+`H@("`@("`@('T*("`@("`@("!S96QF+FUE=&AO9',@/2!;
M<V5L9BY?;65T:&]D7V1I8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T:&]D7V1I
M8W1="@H@("`@9&5F(&UA=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE=&AO9%]N
M86UE*3H*("`@("`@("!I9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ
M*3]A<G)A>3PN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@("!R
M971U<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T
M+F=E="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O
M<B!N;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE
M"B`@("`@("`@=')Y.@H@("`@("`@("`@("!V86QU95]T>7!E(#T@8VQA<W-?
M='EP92YT96UP;&%T95]A<F=U;65N="@P*0H@("`@("`@("`@("!S:7IE(#T@
M8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N="@Q*0H@("`@("`@(&5X8V5P
M=#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!R971U<FX@;65T
M:&]D+G=O<FME<E]C;&%S<RAV86QU95]T>7!E+"!S:7IE*0H*(R!8;65T:&]D
M<R!F;W(@<W1D.CID97%U90H*8VQA<W,@1&5Q=657;W)K97)"87-E*&=D8BYX
M;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M('9A;%]T>7!E*3H*("`@("`@("!S96QF+E]V86Q?='EP92`]('9A;%]T>7!E
M"B`@("`@("`@<V5L9BY?8G5F<VEZ92`](#4Q,B`O+R!V86Q?='EP92YS:7IE
M;V8@;W(@,0H*("`@(&1E9B!S:7IE*'-E;&8L(&]B:BDZ"B`@("`@("`@9FER
M<W1?;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]S=&%R="==6R=?35]N;V1E
M)UT*("`@("`@("!L87-T7VYO9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?9FEN
M:7-H)UU;)U]-7VYO9&4G70H@("`@("`@(&-U<B`](&]B:ELG7TU?:6UP;"==
M6R=?35]F:6YI<V@G75LG7TU?8W5R)UT*("`@("`@("!F:7)S="`](&]B:ELG
M7TU?:6UP;"==6R=?35]F:6YI<V@G75LG7TU?9FER<W0G70H@("`@("`@(')E
M='5R;B`H;&%S=%]N;V1E("T@9FER<W1?;F]D92D@*B!S96QF+E]B=69S:7IE
M("L@*&-U<B`M(&9I<G-T*0H*("`@(&1E9B!I;F1E>"AS96QF+"!O8FHL(&ED
M>"DZ"B`@("`@("`@9FER<W1?;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]S
M=&%R="==6R=?35]N;V1E)UT*("`@("`@("!I;F1E>%]N;V1E(#T@9FER<W1?
M;F]D92`K(&EN="AI9'@I("\O('-E;&8N7V)U9G-I>F4*("`@("`@("!R971U
M<FX@:6YD97A?;F]D95LP75MI9'@@)2!S96QF+E]B=69S:7IE70H*8VQA<W,@
M1&5Q=65%;7!T>5=O<FME<BA$97%U95=O<FME<D)A<V4I.@H@("`@9&5F(&=E
M=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D
M968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N
M(&=E=%]B;V]L7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI
M.@H@("`@("`@(')E='5R;B`H;V)J6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;
M)U]-7V-U<B==(#T]"B`@("`@("`@("`@("`@("!O8FI;)U]-7VEM<&PG75LG
M7TU?9FEN:7-H)UU;)U]-7V-U<B==*0H*8VQA<W,@1&5Q=653:7IE5V]R:V5R
M*$1E<75E5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF
M*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y
M<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y
M<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E
M='5R;B!S96QF+G-I>F4H;V)J*0H*8VQA<W,@1&5Q=65&<F]N=%=O<FME<BA$
M97%U95=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ
M"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E
M*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@
M("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&]B
M:ELG7TU?:6UP;"==6R=?35]S=&%R="==6R=?35]C=7(G75LP70H*8VQA<W,@
M1&5Q=65"86-K5V]R:V5R*$1E<75E5V]R:V5R0F%S92DZ"B`@("!D968@9V5T
M7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E
M9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*
M("`@("`@("!I9B`H;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]C
M=7(G72`]/0H@("`@("`@("`@("!O8FI;)U]-7VEM<&PG75LG7TU?9FEN:7-H
M)UU;)U]-7V9I<G-T)UTI.@H@("`@("`@("`@("!P<F5V7VYO9&4@/2!O8FI;
M)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7VYO9&4G72`M(#$*("`@("`@
M("`@("`@<F5T=7)N('!R979?;F]D95LP75MS96QF+E]B=69S:7IE("T@,5T*
M("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@;V)J6R=?35]I;7!L
M)UU;)U]-7V9I;FES:"==6R=?35]C=7(G75LM,5T*"F-L87-S($1E<75E4W5B
M<V-R:7!T5V]R:V5R*$1E<75E5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R
M9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y
M<&4H*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!S=6)S
M8W)I<'0I.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E
M9B!?7V-A;&Q?7RAS96QF+"!O8FHL('-U8G-C<FEP="DZ"B`@("`@("`@<F5T
M=7)N('-E;&8N:6YD97@H;V)J+"!S=6)S8W)I<'0I"@IC;&%S<R!$97%U94%T
M5V]R:V5R*$1E<75E5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E
M<RAS96QF*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*
M("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@
M("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?
M*'-E;&8L(&]B:BP@:6YD97@I.@H@("`@("`@(&1E<75E7W-I>F4@/2!I;G0H
M<V5L9BYS:7IE*&]B:BDI"B`@("`@("`@:68@:6YT*&EN9&5X*2`^/2!D97%U
M95]S:7IE.@H@("`@("`@("`@("!R86ES92!);F1E>$5R<F]R*"=$97%U92!I
M;F1E>"`B)60B('-H;W5L9"!N;W0@8F4@/CT@)60N)R`E"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@*&EN="AI;F1E>"DL(&1E<75E7W-I>F4I*0H@
M("`@("`@(&5L<V4Z"B`@("`@("`@("`@<F5T=7)N('-E;&8N:6YD97@H;V)J
M+"!I;F1E>"D*"F-L87-S($1E<75E365T:&]D<TUA=&-H97(H9V1B+GAM971H
M;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8I.@H@
M("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R+E]?:6YI=%]?*'-E
M;&8L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@;6%T8VAE<E]N86UE7W!R969I>"`K("=D97%U92<I"B`@("`@("`@<V5L
M9BY?;65T:&]D7V1I8W0@/2!["B`@("`@("`@("`@("=E;7!T>2<Z($QI8E-T
M9$-X>%A-971H;V0H)V5M<'1Y)RP@1&5Q=65%;7!T>5=O<FME<BDL"B`@("`@
M("`@("`@("=S:7IE)SH@3&EB4W1D0WAX6$UE=&AO9"@G<VEZ92<L($1E<75E
M4VEZ95=O<FME<BDL"B`@("`@("`@("`@("=F<F]N="<Z($QI8E-T9$-X>%A-
M971H;V0H)V9R;VYT)RP@1&5Q=65&<F]N=%=O<FME<BDL"B`@("`@("`@("`@
M("=B86-K)SH@3&EB4W1D0WAX6$UE=&AO9"@G8F%C:R<L($1E<75E0F%C:U=O
M<FME<BDL"B`@("`@("`@("`@("=O<&5R871O<EM=)SH@3&EB4W1D0WAX6$UE
M=&AO9"@G;W!E<F%T;W);72<L($1E<75E4W5B<V-R:7!T5V]R:V5R*2P*("`@
M("`@("`@("`@)V%T)SH@3&EB4W1D0WAX6$UE=&AO9"@G870G+"!$97%U94%T
M5V]R:V5R*0H@("`@("`@('T*("`@("`@("!S96QF+FUE=&AO9',@/2!;<V5L
M9BY?;65T:&]D7V1I8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T:&]D7V1I8W1=
M"@H@("`@9&5F(&UA=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE=&AO9%]N86UE
M*3H*("`@("`@("!I9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]D
M97%U93PN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U
M<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E
M="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N
M;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@
M("`@("`@<F5T=7)N(&UE=&AO9"YW;W)K97)?8VQA<W,H8VQA<W-?='EP92YT
M96UP;&%T95]A<F=U;65N="@P*2D*"B,@6&UE=&AO9',@9F]R('-T9#HZ9F]R
M=V%R9%]L:7-T"@IC;&%S<R!&;W)W87)D3&ES=%=O<FME<D)A<V4H9V1B+GAM
M971H;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M('9A;%]T>7!E+"!N;V1E7W1Y<&4I.@H@("`@("`@('-E;&8N7W9A;%]T>7!E
M(#T@=F%L7W1Y<&4*("`@("`@("!S96QF+E]N;V1E7W1Y<&4@/2!N;V1E7W1Y
M<&4*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U
M<FX@3F]N90H*8VQA<W,@1F]R=V%R9$QI<W1%;7!T>5=O<FME<BA&;W)W87)D
M3&ES=%=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF
M+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?8F]O;%]T>7!E*"D*"B`@("!D
M968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@;V)J6R=?
M35]I;7!L)UU;)U]-7VAE860G75LG7TU?;F5X="==(#T](#`*"F-L87-S($9O
M<G=A<F1,:7-T1G)O;G17;W)K97(H1F]R=V%R9$QI<W17;W)K97)"87-E*3H*
M("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R
M971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@
M;V)J*3H*("`@("`@("!N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7VAE860G
M75LG7TU?;F5X="==+F-A<W0H<V5L9BY?;F]D95]T>7!E*0H@("`@("`@('9A
M;%]A9&1R97-S(#T@;F]D95LG7TU?<W1O<F%G92==6R=?35]S=&]R86=E)UTN
M861D<F5S<PH@("`@("`@(')E='5R;B!V86Q?861D<F5S<RYC87-T*'-E;&8N
M7W9A;%]T>7!E+G!O:6YT97(H*2DN9&5R969E<F5N8V4H*0H*8VQA<W,@1F]R
M=V%R9$QI<W1-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D36%T
M8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@("`@("`@;6%T8VAE
M<E]N86UE(#T@;6%T8VAE<E]N86UE7W!R969I>"`K("=F;W)W87)D7VQI<W0G
M"B`@("`@("`@9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H
M<V5L9BP@;6%T8VAE<E]N86UE*0H@("`@("`@('-E;&8N7VUE=&AO9%]D:6-T
M(#T@>PH@("`@("`@("`@("`G96UP='DG.B!,:6)3=&1#>'A8365T:&]D*"=E
M;7!T>2<L($9O<G=A<F1,:7-T16UP='E7;W)K97(I+`H@("`@("`@("`@("`G
M9G)O;G0G.B!,:6)3=&1#>'A8365T:&]D*"=F<F]N="<L($9O<G=A<F1,:7-T
M1G)O;G17;W)K97(I"B`@("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`]
M(%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?
M9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D
M7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K
M.CHI/V9O<G=A<F1?;&ES=#PN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@
M("`@("`@("!R971U<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE
M=&AO9%]D:6-T+F=E="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@
M:7,@3F]N92!O<B!N;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E
M='5R;B!.;VYE"B`@("`@("`@=F%L7W1Y<&4@/2!C;&%S<U]T>7!E+G1E;7!L
M871E7V%R9W5M96YT*#`I"B`@("`@("`@;F]D95]T>7!E(#T@9V1B+FQO;VMU
M<%]T>7!E*'-T<BAC;&%S<U]T>7!E*2`K("<Z.E].;V1E)RDN<&]I;G1E<B@I
M"B`@("`@("`@<F5T=7)N(&UE=&AO9"YW;W)K97)?8VQA<W,H=F%L7W1Y<&4L
M(&YO9&5?='EP92D*"B,@6&UE=&AO9',@9F]R('-T9#HZ;&ES=`H*8VQA<W,@
M3&ES=%=O<FME<D)A<V4H9V1B+GAM971H;V0N6$UE=&AO9%=O<FME<BDZ"B`@
M("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L(&YO9&5?='EP92DZ"B`@
M("`@("`@<V5L9BY?=F%L7W1Y<&4@/2!V86Q?='EP90H@("`@("`@('-E;&8N
M7VYO9&5?='EP92`](&YO9&5?='EP90H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]V86QU
M95]F<F]M7VYO9&4H<V5L9BP@;F]D92DZ"B`@("`@("`@;F]D92`](&YO9&4N
M9&5R969E<F5N8V4H*0H@("`@("`@(&EF(&YO9&4N='EP92YF:65L9',H*5LQ
M72YN86UE(#T]("=?35]D871A)SH*("`@("`@("`@("`@(R!#*RLP,R!I;7!L
M96UE;G1A=&EO;BP@;F]D92!C;VYT86EN<R!T:&4@=F%L=64@87,@82!M96UB
M97(*("`@("`@("`@("`@<F5T=7)N(&YO9&5;)U]-7V1A=&$G70H@("`@("`@
M(",@0RLK,3$@:6UP;&5M96YT871I;VXL(&YO9&4@<W1O<F5S('9A;'5E(&EN
M(%]?86QI9VYE9%]M96UB=68*("`@("`@("!A9&1R(#T@;F]D95LG7TU?<W1O
M<F%G92==+F%D9')E<W,*("`@("`@("!R971U<FX@861D<BYC87-T*'-E;&8N
M7W9A;%]T>7!E+G!O:6YT97(H*2DN9&5R969E<F5N8V4H*0H*8VQA<W,@3&ES
M=$5M<'1Y5V]R:V5R*$QI<W17;W)K97)"87-E*3H*("`@(&1E9B!G971?<F5S
M=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7V)O;VQ?
M='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@
M8F%S95]N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7VYO9&4G70H@("`@("`@
M(&EF(&)A<V5?;F]D95LG7TU?;F5X="==(#T](&)A<V5?;F]D92YA9&1R97-S
M.@H@("`@("`@("`@("!R971U<FX@5')U90H@("`@("`@(&5L<V4Z"B`@("`@
M("`@("`@(')E='5R;B!&86QS90H*8VQA<W,@3&ES=%-I>F57;W)K97(H3&ES
M=%=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O
M8FHI.@H@("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@
M9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@8F5G:6Y?;F]D92`]
M(&]B:ELG7TU?:6UP;"==6R=?35]N;V1E)UU;)U]-7VYE>'0G70H@("`@("`@
M(&5N9%]N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7VYO9&4G72YA9&1R97-S
M"B`@("`@("`@<VEZ92`](#`*("`@("`@("!W:&EL92!B96=I;E]N;V1E("$]
M(&5N9%]N;V1E.@H@("`@("`@("`@("!B96=I;E]N;V1E(#T@8F5G:6Y?;F]D
M95LG7TU?;F5X="=="B`@("`@("`@("`@('-I>F4@*ST@,0H@("`@("`@(')E
M='5R;B!S:7IE"@IC;&%S<R!,:7-T1G)O;G17;W)K97(H3&ES=%=O<FME<D)A
M<V4I.@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@
M("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS
M96QF+"!O8FHI.@H@("`@("`@(&YO9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?
M;F]D92==6R=?35]N97AT)UTN8V%S="AS96QF+E]N;V1E7W1Y<&4I"B`@("`@
M("`@<F5T=7)N('-E;&8N9V5T7W9A;'5E7V9R;VU?;F]D92AN;V1E*0H*8VQA
M<W,@3&ES=$)A8VM7;W)K97(H3&ES=%=O<FME<D)A<V4I.@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF
M+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@('!R979?;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]N;V1E)UU;)U]-
M7W!R978G72YC87-T*'-E;&8N7VYO9&5?='EP92D*("`@("`@("!R971U<FX@
M<V5L9BYG971?=F%L=65?9G)O;5]N;V1E*'!R979?;F]D92D*"F-L87-S($QI
M<W1-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BDZ
M"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@("`@("`@9V1B+GAM971H;V0N
M6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L9BP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!M871C:&5R7VYA;65?<')E
M9FEX("L@)VQI<W0G*0H@("`@("`@('-E;&8N7VUE=&AO9%]D:6-T(#T@>PH@
M("`@("`@("`@("`G96UP='DG.B!,:6)3=&1#>'A8365T:&]D*"=E;7!T>2<L
M($QI<W1%;7!T>5=O<FME<BDL"B`@("`@("`@("`@("=S:7IE)SH@3&EB4W1D
M0WAX6$UE=&AO9"@G<VEZ92<L($QI<W13:7IE5V]R:V5R*2P*("`@("`@("`@
M("`@)V9R;VYT)SH@3&EB4W1D0WAX6$UE=&AO9"@G9G)O;G0G+"!,:7-T1G)O
M;G17;W)K97(I+`H@("`@("`@("`@("`G8F%C:R<Z($QI8E-T9$-X>%A-971H
M;V0H)V)A8VLG+"!,:7-T0F%C:U=O<FME<BD*("`@("`@("!]"B`@("`@("`@
M<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE=&AO9%]D:6-T6VU=(&9O<B!M(&EN
M('-E;&8N7VUE=&AO9%]D:6-T70H*("`@(&1E9B!M871C:"AS96QF+"!C;&%S
M<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@("`@("`@:68@;F]T(')E+FUA=&-H
M*"=><W1D.CHH7U]<9"LZ.BD_*%]?8WAX,3$Z.BD_;&ES=#PN*CXD)RP@8VQA
M<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@
M(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E="AM971H;V1?;F%M92D*
M("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N;W0@;65T:&]D+F5N86)L
M960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@=F%L7W1Y<&4@
M/2!C;&%S<U]T>7!E+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@;F]D
M95]T>7!E(#T@9V1B+FQO;VMU<%]T>7!E*'-T<BAC;&%S<U]T>7!E*2`K("<Z
M.E].;V1E)RDN<&]I;G1E<B@I"B`@("`@("`@<F5T=7)N(&UE=&AO9"YW;W)K
M97)?8VQA<W,H=F%L7W1Y<&4L(&YO9&5?='EP92D*"B,@6&UE=&AO9',@9F]R
M('-T9#HZ=F5C=&]R"@IC;&%S<R!696-T;W)7;W)K97)"87-E*&=D8BYX;65T
M:&]D+EA-971H;V17;W)K97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A
M;%]T>7!E*3H*("`@("`@("!S96QF+E]V86Q?='EP92`]('9A;%]T>7!E"@H@
M("`@9&5F('-I>F4H<V5L9BP@;V)J*3H*("`@("`@("!I9B!S96QF+E]V86Q?
M='EP92YC;V1E(#T](&=D8BY465!%7T-/1$5?0D]/3#H*("`@("`@("`@("`@
M<W1A<G0@/2!O8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?<"=="B`@
M("`@("`@("`@(&9I;FES:"`](&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G
M75LG7TU?<"=="B`@("`@("`@("`@(&9I;FES:%]O9F9S970@/2!O8FI;)U]-
M7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7V]F9G-E="=="B`@("`@("`@("`@
M(&)I=%]S:7IE(#T@<W1A<G0N9&5R969E<F5N8V4H*2YT>7!E+G-I>F5O9B`J
M(#@*("`@("`@("`@("`@<F5T=7)N("AF:6YI<V@@+2!S=&%R="D@*B!B:71?
M<VEZ92`K(&9I;FES:%]O9F9S970*("`@("`@("!E;'-E.@H@("`@("`@("`@
M("!R971U<FX@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==("T@;V)J6R=?
M35]I;7!L)UU;)U]-7W-T87)T)UT*"B`@("!D968@9V5T*'-E;&8L(&]B:BP@
M:6YD97@I.@H@("`@("`@(&EF('-E;&8N7W9A;%]T>7!E+F-O9&4@/3T@9V1B
M+E194$5?0T]$15]"3T],.@H@("`@("`@("`@("!S=&%R="`](&]B:ELG7TU?
M:6UP;"==6R=?35]S=&%R="==6R=?35]P)UT*("`@("`@("`@("`@8FET7W-I
M>F4@/2!S=&%R="YD97)E9F5R96YC92@I+G1Y<&4N<VEZ96]F("H@.`H@("`@
M("`@("`@("!V86QP(#T@<W1A<G0@*R!I;F1E>"`O+R!B:71?<VEZ90H@("`@
M("`@("`@("!O9F9S970@/2!I;F1E>"`E(&)I=%]S:7IE"B`@("`@("`@("`@
M(')E='5R;B`H=F%L<"YD97)E9F5R96YC92@I("8@*#$@/#P@;V9F<V5T*2D@
M/B`P"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?
M:6UP;"==6R=?35]S=&%R="==6VEN9&5X70H*8VQA<W,@5F5C=&]R16UP='E7
M;W)K97(H5F5C=&]R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E
M<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S
M=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7V)O;VQ?
M='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@
M<F5T=7)N(&EN="AS96QF+G-I>F4H;V)J*2D@/3T@,`H*8VQA<W,@5F5C=&]R
M4VEZ95=O<FME<BA696-T;W)7;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G
M7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?
M<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ
M"B`@("`@("`@<F5T=7)N('-E;&8N<VEZ92AO8FHI"@IC;&%S<R!696-T;W)&
M<F]N=%=O<FME<BA696-T;W)7;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G
M7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF
M+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@(')E='5R;B!S96QF+F=E="AO8FHL(#`I"@IC;&%S<R!696-T;W)"86-K
M5V]R:V5R*%9E8W1O<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP
M97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E
M<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A
M;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@
M<F5T=7)N('-E;&8N9V5T*&]B:BP@:6YT*'-E;&8N<VEZ92AO8FHI*2`M(#$I
M"@IC;&%S<R!696-T;W)!=%=O<FME<BA696-T;W)7;W)K97)"87-E*3H*("`@
M(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!G971?
M<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF
M+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*
M"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@
M<VEZ92`](&EN="AS96QF+G-I>F4H;V)J*2D*("`@("`@("!I9B!I;G0H:6YD
M97@I(#X]('-I>F4Z"B`@("`@("`@("`@(')A:7-E($EN9&5X17)R;W(H)U9E
M8W1O<B!I;F1E>"`B)60B('-H;W5L9"!N;W0@8F4@/CT@)60N)R`E"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@*"AI;G0H:6YD97@I+"!S:7IE*2DI
M"B`@("`@("`@<F5T=7)N('-E;&8N9V5T*&]B:BP@:6YT*&EN9&5X*2D*"F-L
M87-S(%9E8W1O<E-U8G-C<FEP=%=O<FME<BA696-T;W)7;W)K97)"87-E*3H*
M("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!G
M971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHL('-U8G-C<FEP="DZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A
M;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BP@<W5B<V-R:7!T
M*3H*("`@("`@("!R971U<FX@<V5L9BYG970H;V)J+"!I;G0H<W5B<V-R:7!T
M*2D*"F-L87-S(%9E8W1O<DUE=&AO9'--871C:&5R*&=D8BYX;65T:&]D+EA-
M971H;V1-871C:&5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF*3H*("`@("`@
M("!G9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BY?7VEN:71?7RAS96QF+`H@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(&UA
M=&-H97)?;F%M95]P<F5F:7@@*R`G=F5C=&]R)RD*("`@("`@("!S96QF+E]M
M971H;V1?9&EC="`]('L*("`@("`@("`@("`@)W-I>F4G.B!,:6)3=&1#>'A8
M365T:&]D*"=S:7IE)RP@5F5C=&]R4VEZ95=O<FME<BDL"B`@("`@("`@("`@
M("=E;7!T>2<Z($QI8E-T9$-X>%A-971H;V0H)V5M<'1Y)RP@5F5C=&]R16UP
M='E7;W)K97(I+`H@("`@("`@("`@("`G9G)O;G0G.B!,:6)3=&1#>'A8365T
M:&]D*"=F<F]N="<L(%9E8W1O<D9R;VYT5V]R:V5R*2P*("`@("`@("`@("`@
M)V)A8VLG.B!,:6)3=&1#>'A8365T:&]D*"=B86-K)RP@5F5C=&]R0F%C:U=O
M<FME<BDL"B`@("`@("`@("`@("=A="<Z($QI8E-T9$-X>%A-971H;V0H)V%T
M)RP@5F5C=&]R0717;W)K97(I+`H@("`@("`@("`@("`G;W!E<F%T;W);72<Z
M($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R6UTG+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@5F5C=&]R4W5B<V-R:7!T
M5V]R:V5R*2P*("`@("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E
M;&8N7VUE=&AO9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T
M70H*("`@(&1E9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M
M92DZ"B`@("`@("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_
M=F5C=&]R/"XJ/B0G+"!C;&%S<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E
M='5R;B!.;VYE"B`@("`@("`@;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N
M9V5T*&UE=&AO9%]N86UE*0H@("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R
M(&YO="!M971H;V0N96YA8FQE9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*
M("`@("`@("!R971U<FX@;65T:&]D+G=O<FME<E]C;&%S<RAC;&%S<U]T>7!E
M+G1E;7!L871E7V%R9W5M96YT*#`I*0H*(R!8;65T:&]D<R!F;W(@87-S;V-I
M871I=F4@8V]N=&%I;F5R<PH*8VQA<W,@07-S;V-I871I=F5#;VYT86EN97)7
M;W)K97)"87-E*&=D8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L('5N;W)D97)E9"DZ"B`@("`@("`@<V5L9BY?=6YO
M<F1E<F5D(#T@=6YO<F1E<F5D"@H@("`@9&5F(&YO9&5?8V]U;G0H<V5L9BP@
M;V)J*3H*("`@("`@("!I9B!S96QF+E]U;F]R9&5R960Z"B`@("`@("`@("`@
M(')E='5R;B!O8FI;)U]-7V@G75LG7TU?96QE;65N=%]C;W5N="=="B`@("`@
M("`@96QS93H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?="==6R=?35]I
M;7!L)UU;)U]-7VYO9&5?8V]U;G0G70H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@IC;&%S<R!!<W-O8VEA=&EV
M94-O;G1A:6YE<D5M<'1Y5V]R:V5R*$%S<V]C:6%T:79E0V]N=&%I;F5R5V]R
M:V5R0F%S92DZ"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ
M"B`@("`@("`@<F5T=7)N(&=E=%]B;V]L7W1Y<&4H*0H*("`@(&1E9B!?7V-A
M;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!I;G0H<V5L9BYN;V1E
M7V-O=6YT*&]B:BDI(#T](#`*"F-L87-S($%S<V]C:6%T:79E0V]N=&%I;F5R
M4VEZ95=O<FME<BA!<W-O8VEA=&EV94-O;G1A:6YE<E=O<FME<D)A<V4I.@H@
M("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E
M='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E
M;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N;F]D95]C;W5N="AO8FHI
M"@IC;&%S<R!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*&=D
M8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!N86UE*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE
M<BY?7VEN:71?7RAS96QF+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(&UA=&-H97)?;F%M95]P<F5F:7@@*R!N86UE*0H@
M("`@("`@('-E;&8N7VYA;64@/2!N86UE"B`@("`@("`@<V5L9BY?;65T:&]D
M7V1I8W0@/2!["B`@("`@("`@("`@("=S:7IE)SH@3&EB4W1D0WAX6$UE=&AO
M9"@G<VEZ92<L($%S<V]C:6%T:79E0V]N=&%I;F5R4VEZ95=O<FME<BDL"B`@
M("`@("`@("`@("=E;7!T>2<Z($QI8E-T9$-X>%A-971H;V0H)V5M<'1Y)RP*
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!!<W-O8VEA
M=&EV94-O;G1A:6YE<D5M<'1Y5V]R:V5R*2P*("`@("`@("!]"B`@("`@("`@
M<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE=&AO9%]D:6-T6VU=(&9O<B!M(&EN
M('-E;&8N7VUE=&AO9%]D:6-T70H*("`@(&1E9B!M871C:"AS96QF+"!C;&%S
M<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@("`@("`@:68@;F]T(')E+FUA=&-H
M*"=><W1D.CHH7U]<9"LZ.BD_)7,\+BH^)"<@)2!S96QF+E]N86UE+"!C;&%S
M<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@
M;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N9V5T*&UE=&AO9%]N86UE*0H@
M("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R(&YO="!M971H;V0N96YA8FQE
M9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!U;F]R9&5R960@
M/2`G=6YO<F1E<F5D)R!I;B!S96QF+E]N86UE"B`@("`@("`@<F5T=7)N(&UE
M=&AO9"YW;W)K97)?8VQA<W,H=6YO<F1E<F5D*0H*(R!8;65T:&]D<R!F;W(@
M<W1D.CIU;FEQ=65?<'1R"@IC;&%S<R!5;FEQ=650=')'9717;W)K97(H9V1B
M+GAM971H;V0N6$UE=&AO9%=O<FME<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z
M.G5N:7%U95]P='(\5#XZ.F=E="@I(&%N9"!S=&0Z.G5N:7%U95]P='(\5#XZ
M.F]P97)A=&]R+3XH*2(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@96QE;5]T
M>7!E*3H*("`@("`@("!S96QF+E]I<U]A<G)A>2`](&5L96U?='EP92YC;V1E
M(#T](&=D8BY465!%7T-/1$5?05)205D*("`@("`@("!I9B!S96QF+E]I<U]A
M<G)A>3H*("`@("`@("`@("`@<V5L9BY?96QE;5]T>7!E(#T@96QE;5]T>7!E
M+G1A<F=E="@I"B`@("`@("`@96QS93H*("`@("`@("`@("`@<V5L9BY?96QE
M;5]T>7!E(#T@96QE;5]T>7!E"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L
M9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T
M>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7V5L96U?='EP
M92YP;VEN=&5R*"D*"B`@("!D968@7W-U<'!O<G1S*'-E;&8L(&UE=&AO9%]N
M86UE*3H*("`@("`@("`B;W!E<F%T;W(M/B!I<R!N;W0@<W5P<&]R=&5D(&9O
M<B!U;FEQ=65?<'1R/%1;73XB"B`@("`@("`@<F5T=7)N(&UE=&AO9%]N86UE
M(#T]("=G970G(&]R(&YO="!S96QF+E]I<U]A<G)A>0H*("`@(&1E9B!?7V-A
M;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(&EM<&Q?='EP92`](&]B:BYD97)E
M9F5R96YC92@I+G1Y<&4N9FEE;&1S*"E;,%TN='EP92YT86<*("`@("`@("`C
M($-H96-K(&9O<B!N97<@:6UP;&5M96YT871I;VYS(&9I<G-T.@H@("`@("`@
M(&EF(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_7U]U;FEQ7W!T<E\H9&%T
M87QI;7!L*3PN*CXD)RP@:6UP;%]T>7!E*3H*("`@("`@("`@("`@='5P;&5?
M;65M8F5R(#T@;V)J6R=?35]T)UU;)U]-7W0G70H@("`@("`@(&5L:68@<F4N
M;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]T=7!L93PN*CXD)RP@:6UP;%]T>7!E
M*3H*("`@("`@("`@("`@='5P;&5?;65M8F5R(#T@;V)J6R=?35]T)UT*("`@
M("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@('1U
M<&QE7VEM<&Q?='EP92`]('1U<&QE7VUE;6)E<BYT>7!E+F9I96QD<R@I6S!=
M+G1Y<&4@(R!?5'5P;&5?:6UP;`H@("`@("`@('1U<&QE7VAE861?='EP92`]
M('1U<&QE7VEM<&Q?='EP92YF:65L9',H*5LQ72YT>7!E("`@(R!?2&5A9%]B
M87-E"B`@("`@("`@:&5A9%]F:65L9"`]('1U<&QE7VAE861?='EP92YF:65L
M9',H*5LP70H@("`@("`@(&EF(&AE861?9FEE;&0N;F%M92`]/2`G7TU?:&5A
M9%]I;7!L)SH*("`@("`@("`@("`@<F5T=7)N('1U<&QE7VUE;6)E<ELG7TU?
M:&5A9%]I;7!L)UT*("`@("`@("!E;&EF(&AE861?9FEE;&0N:7-?8F%S95]C
M;&%S<SH*("`@("`@("`@("`@<F5T=7)N('1U<&QE7VUE;6)E<BYC87-T*&AE
M861?9FEE;&0N='EP92D*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U
M<FX@3F]N90H*8VQA<W,@56YI<75E4'1R1&5R9697;W)K97(H56YI<75E4'1R
M1V5T5V]R:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ=6YI<75E7W!T<CQ4
M/CHZ;W!E<F%T;W(J*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?
M='EP92DZ"B`@("`@("`@56YI<75E4'1R1V5T5V]R:V5R+E]?:6YI=%]?*'-E
M;&8L(&5L96U?='EP92D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L
M(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7V5L96U?='EP90H*("`@(&1E
M9B!?<W5P<&]R=',H<V5L9BP@;65T:&]D7VYA;64I.@H@("`@("`@(")O<&5R
M871O<BH@:7,@;F]T('-U<'!O<G1E9"!F;W(@=6YI<75E7W!T<CQ46UT^(@H@
M("`@("`@(')E='5R;B!N;W0@<V5L9BY?:7-?87)R87D*"B`@("!D968@7U]C
M86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@56YI<75E4'1R1V5T
M5V]R:V5R+E]?8V%L;%]?*'-E;&8L(&]B:BDN9&5R969E<F5N8V4H*0H*8VQA
M<W,@56YI<75E4'1R4W5B<V-R:7!T5V]R:V5R*%5N:7%U95!T<D=E=%=O<FME
M<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z.G5N:7%U95]P='(\5#XZ.F]P97)A
M=&]R6UTH<VEZ95]T*2(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@96QE;5]T
M>7!E*3H*("`@("`@("!5;FEQ=650=')'9717;W)K97(N7U]I;FET7U\H<V5L
M9BP@96QE;5]T>7!E*0H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@
M("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U
M<FX@<V5L9BY?96QE;5]T>7!E"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M
M971H;V1?;F%M92DZ"B`@("`@("`@(F]P97)A=&]R6UT@:7,@;VYL>2!S=7!P
M;W)T960@9F]R('5N:7%U95]P='(\5%M=/B(*("`@("`@("!R971U<FX@<V5L
M9BY?:7-?87)R87D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!I;F1E
M>"DZ"B`@("`@("`@<F5T=7)N(%5N:7%U95!T<D=E=%=O<FME<BY?7V-A;&Q?
M7RAS96QF+"!O8FHI6VEN9&5X70H*8VQA<W,@56YI<75E4'1R365T:&]D<TUA
M=&-H97(H9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8I.@H@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C
M:&5R+E]?:6YI=%]?*'-E;&8L"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@;6%T8VAE<E]N86UE7W!R969I>"`K("=U;FEQ
M=65?<'1R)RD*("`@("`@("!S96QF+E]M971H;V1?9&EC="`]('L*("`@("`@
M("`@("`@)V=E="<Z($QI8E-T9$-X>%A-971H;V0H)V=E="<L(%5N:7%U95!T
M<D=E=%=O<FME<BDL"B`@("`@("`@("`@("=O<&5R871O<BT^)SH@3&EB4W1D
M0WAX6$UE=&AO9"@G;W!E<F%T;W(M/B<L(%5N:7%U95!T<D=E=%=O<FME<BDL
M"B`@("`@("`@("`@("=O<&5R871O<BHG.B!,:6)3=&1#>'A8365T:&]D*"=O
M<&5R871O<BHG+"!5;FEQ=650=')$97)E9E=O<FME<BDL"B`@("`@("`@("`@
M("=O<&5R871O<EM=)SH@3&EB4W1D0WAX6$UE=&AO9"@G;W!E<F%T;W);72<L
M(%5N:7%U95!T<E-U8G-C<FEP=%=O<FME<BDL"B`@("`@("`@?0H@("`@("`@
M('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@;2!I
M;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@8VQA
M<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM871C
M:"@G7G-T9#HZ*%]?7&0K.CHI/W5N:7%U95]P='(\+BH^)"<L(&-L87-S7W1Y
M<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M971H
M;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@("`@
M("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@
M("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@('=O<FME<B`](&UE=&AO
M9"YW;W)K97)?8VQA<W,H8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N="@P
M*2D*("`@("`@("!I9B!W;W)K97(N7W-U<'!O<G1S*&UE=&AO9%]N86UE*3H*
M("`@("`@("`@("`@<F5T=7)N('=O<FME<@H@("`@("`@(')E='5R;B!.;VYE
M"@HC(%AM971H;V1S(&9O<B!S=&0Z.G-H87)E9%]P='(*"F-L87-S(%-H87)E
M9%!T<D=E=%=O<FME<BAG9&(N>&UE=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@
M("));7!L96UE;G1S('-T9#HZ<VAA<F5D7W!T<CQ4/CHZ9V5T*"D@86YD('-T
M9#HZ<VAA<F5D7W!T<CQ4/CHZ;W!E<F%T;W(M/B@I(@H*("`@(&1E9B!?7VEN
M:71?7RAS96QF+"!E;&5M7W1Y<&4I.@H@("`@("`@('-E;&8N7VES7V%R<F%Y
M(#T@96QE;5]T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]!4E)!60H@("`@
M("`@(&EF('-E;&8N7VES7V%R<F%Y.@H@("`@("`@("`@("!S96QF+E]E;&5M
M7W1Y<&4@/2!E;&5M7W1Y<&4N=&%R9V5T*"D*("`@("`@("!E;'-E.@H@("`@
M("`@("`@("!S96QF+E]E;&5M7W1Y<&4@/2!E;&5M7W1Y<&4*"B`@("!D968@
M9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@
M(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U
M<FX@<V5L9BY?96QE;5]T>7!E+G!O:6YT97(H*0H*("`@(&1E9B!?<W5P<&]R
M=',H<V5L9BP@;65T:&]D7VYA;64I.@H@("`@("`@(")O<&5R871O<BT^(&ES
M(&YO="!S=7!P;W)T960@9F]R('-H87)E9%]P='(\5%M=/B(*("`@("`@("!R
M971U<FX@;65T:&]D7VYA;64@/3T@)V=E="<@;W(@;F]T('-E;&8N7VES7V%R
M<F%Y"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T
M=7)N(&]B:ELG7TU?<'1R)UT*"F-L87-S(%-H87)E9%!T<D1E<F5F5V]R:V5R
M*%-H87)E9%!T<D=E=%=O<FME<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z.G-H
M87)E9%]P='(\5#XZ.F]P97)A=&]R*B@I(@H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!E;&5M7W1Y<&4I.@H@("`@("`@(%-H87)E9%!T<D=E=%=O<FME<BY?
M7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E=%]R97-U;'1?
M='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]E;&5M7W1Y
M<&4*"B`@("!D968@7W-U<'!O<G1S*'-E;&8L(&UE=&AO9%]N86UE*3H*("`@
M("`@("`B;W!E<F%T;W(J(&ES(&YO="!S=7!P;W)T960@9F]R('-H87)E9%]P
M='(\5%M=/B(*("`@("`@("!R971U<FX@;F]T('-E;&8N7VES7V%R<F%Y"@H@
M("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(%-H
M87)E9%!T<D=E=%=O<FME<BY?7V-A;&Q?7RAS96QF+"!O8FHI+F1E<F5F97)E
M;F-E*"D*"F-L87-S(%-H87)E9%!T<E-U8G-C<FEP=%=O<FME<BA3:&%R9610
M=')'9717;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D.CIS:&%R961?<'1R
M/%0^.CIO<&5R871O<EM=*'-I>F5?="DB"@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L(&5L96U?='EP92DZ"B`@("`@("`@4VAA<F5D4'1R1V5T5V]R:V5R+E]?
M:6YI=%]?*'-E;&8L(&5L96U?='EP92D*"B`@("!D968@9V5T7V%R9U]T>7!E
M<RAS96QF*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*
M("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@
M("`@("`@<F5T=7)N('-E;&8N7V5L96U?='EP90H*("`@(&1E9B!?<W5P<&]R
M=',H<V5L9BP@;65T:&]D7VYA;64I.@H@("`@("`@(")O<&5R871O<EM=(&ES
M(&]N;'D@<W5P<&]R=&5D(&9O<B!S:&%R961?<'1R/%1;73XB"B`@("`@("`@
M<F5T=7)N('-E;&8N7VES7V%R<F%Y"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L
M(&]B:BP@:6YD97@I.@H@("`@("`@(",@0VAE8VL@8F]U;F1S(&EF(%]E;&5M
M7W1Y<&4@:7,@86X@87)R87D@;V8@:VYO=VX@8F]U;F0*("`@("`@("!M(#T@
M<F4N;6%T8V@H)RXJ7%LH7&0K*5TD)RP@<W1R*'-E;&8N7V5L96U?='EP92DI
M"B`@("`@("`@:68@;2!A;F0@:6YD97@@/CT@:6YT*&TN9W)O=7`H,2DI.@H@
M("`@("`@("`@("!R86ES92!);F1E>$5R<F]R*"=S:&%R961?<'1R/"5S/B!I
M;F1E>"`B)60B('-H;W5L9"!N;W0@8F4@/CT@)60N)R`E"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@*'-E;&8N7V5L96U?='EP92P@:6YT*&EN9&5X
M*2P@:6YT*&TN9W)O=7`H,2DI*2D*("`@("`@("!R971U<FX@4VAA<F5D4'1R
M1V5T5V]R:V5R+E]?8V%L;%]?*'-E;&8L(&]B:BE;:6YD97A="@IC;&%S<R!3
M:&%R9610=')5<V5#;W5N=%=O<FME<BAG9&(N>&UE=&AO9"Y8365T:&]D5V]R
M:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ<VAA<F5D7W!T<CQ4/CHZ=7-E
M7V-O=6YT*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?='EP92DZ
M"B`@("`@("`@4VAA<F5D4'1R57-E0V]U;G17;W)K97(N7U]I;FET7U\H<V5L
M9BP@96QE;5]T>7!E*0H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@
M("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G9&(N;&]O:W5P7W1Y<&4H)VQO
M;F<G*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E
M9F-O=6YT<R`](%LG7TU?<F5F8V]U;G0G75LG7TU?<&DG70H@("`@("`@(')E
M='5R;B!R969C;W5N='-;)U]-7W5S95]C;W5N="==(&EF(')E9F-O=6YT<R!E
M;'-E(#`*"F-L87-S(%-H87)E9%!T<E5N:7%U95=O<FME<BA3:&%R9610=')5
M<V5#;W5N=%=O<FME<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z.G-H87)E9%]P
M='(\5#XZ.G5N:7%U92@I(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!E;&5M
M7W1Y<&4I.@H@("`@("`@(%-H87)E9%!T<E5S94-O=6YT5V]R:V5R+E]?:6YI
M=%]?*'-E;&8L(&5L96U?='EP92D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E
M*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=D8BYL;V]K=7!?='EP92@G
M8F]O;"<I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@
M<F5T=7)N(%-H87)E9%!T<E5S94-O=6YT5V]R:V5R+E]?8V%L;%]?*'-E;&8L
M(&]B:BD@/3T@,0H*8VQA<W,@4VAA<F5D4'1R365T:&]D<TUA=&-H97(H9V1B
M+GAM971H;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8I.@H@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R+E]?:6YI
M=%]?*'-E;&8L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@;6%T8VAE<E]N86UE7W!R969I>"`K("=S:&%R961?<'1R)RD*
M("`@("`@("!S96QF+E]M971H;V1?9&EC="`]('L*("`@("`@("`@("`@)V=E
M="<Z($QI8E-T9$-X>%A-971H;V0H)V=E="<L(%-H87)E9%!T<D=E=%=O<FME
M<BDL"B`@("`@("`@("`@("=O<&5R871O<BT^)SH@3&EB4W1D0WAX6$UE=&AO
M9"@G;W!E<F%T;W(M/B<L(%-H87)E9%!T<D=E=%=O<FME<BDL"B`@("`@("`@
M("`@("=O<&5R871O<BHG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R871O<BHG
M+"!3:&%R9610=')$97)E9E=O<FME<BDL"B`@("`@("`@("`@("=O<&5R871O
M<EM=)SH@3&EB4W1D0WAX6$UE=&AO9"@G;W!E<F%T;W);72<L(%-H87)E9%!T
M<E-U8G-C<FEP=%=O<FME<BDL"B`@("`@("`@("`@("=U<V5?8V]U;G0G.B!,
M:6)3=&1#>'A8365T:&]D*"=U<V5?8V]U;G0G+"!3:&%R9610=')5<V5#;W5N
M=%=O<FME<BDL"B`@("`@("`@("`@("=U;FEQ=64G.B!,:6)3=&1#>'A8365T
M:&]D*"=U;FEQ=64G+"!3:&%R9610=')5;FEQ=657;W)K97(I+`H@("`@("`@
M('T*("`@("`@("!S96QF+FUE=&AO9',@/2!;<V5L9BY?;65T:&]D7V1I8W1;
M;5T@9F]R(&T@:6X@<V5L9BY?;65T:&]D7V1I8W1="@H@("`@9&5F(&UA=&-H
M*'-E;&8L(&-L87-S7W1Y<&4L(&UE=&AO9%]N86UE*3H*("`@("`@("!I9B!N
M;W0@<F4N;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]S:&%R961?<'1R/"XJ/B0G
M+"!C;&%S<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@
M("`@("`@;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N9V5T*&UE=&AO9%]N
M86UE*0H@("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R(&YO="!M971H;V0N
M96YA8FQE9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!W;W)K
M97(@/2!M971H;V0N=V]R:V5R7V-L87-S*&-L87-S7W1Y<&4N=&5M<&QA=&5?
M87)G=6UE;G0H,"DI"B`@("`@("`@:68@=V]R:V5R+E]S=7!P;W)T<RAM971H
M;V1?;F%M92DZ"B`@("`@("`@("`@(')E='5R;B!W;W)K97(*("`@("`@("!R
M971U<FX@3F]N90H,"F1E9B!R96=I<W1E<E]L:6)S=&1C>'A?>&UE=&AO9',H
M;&]C=7,I.@H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C
M:&5R*&QO8W5S+"!!<G)A>4UE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE
M=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L($9O<G=A<F1,
M:7-T365T:&]D<TUA=&-H97(H*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R
M7WAM971H;V1?;6%T8VAE<BAL;V-U<RP@1&5Q=65-971H;V1S36%T8VAE<B@I
M*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*&QO
M8W5S+"!,:7-T365T:&]D<TUA=&-H97(H*2D*("`@(&=D8BYX;65T:&]D+G)E
M9VES=&5R7WAM971H;V1?;6%T8VAE<BAL;V-U<RP@5F5C=&]R365T:&]D<TUA
M=&-H97(H*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T
M8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H
M;V1S36%T8VAE<B@G<V5T)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X
M;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N
M=&%I;F5R365T:&]D<TUA=&-H97(H)VUA<"<I*0H@("`@9V1B+GAM971H;V0N
M<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO8W5S+"!!<W-O
M8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=M=6QT:7-E="<I*0H@
M("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@
M("`@(&QO8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R
M*"=M=6QT:6UA<"<I*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO
M9%]M871C:&5R*`H@("`@("`@(&QO8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE
M<DUE=&AO9'--871C:&5R*"=U;F]R9&5R961?<V5T)RDI"B`@("!G9&(N>&UE
M=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L
M($%S<V]C:6%T:79E0V]N=&%I;F5R365T:&]D<TUA=&-H97(H)W5N;W)D97)E
M9%]M87`G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T
M8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H
M;V1S36%T8VAE<B@G=6YO<F1E<F5D7VUU;'1I<V5T)RDI"B`@("!G9&(N>&UE
M=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L
M($%S<V]C:6%T:79E0V]N=&%I;F5R365T:&]D<TUA=&-H97(H)W5N;W)D97)E
M9%]M=6QT:6UA<"<I*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO
M9%]M871C:&5R*&QO8W5S+"!5;FEQ=650=')-971H;V1S36%T8VAE<B@I*0H@
M("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*&QO8W5S
M+"!3:&%R9610=')-971H;V1S36%T8VAE<B@I*0H`````````````````````
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
M`````````````````````````````````````````````````````````"XO
M<'ET:&]N+VQI8G-T9&-X>"]V-B]?7VEN:71?7RYP>0``````````````````
M````````````````````````````````````````````````````````````
M```````````P,#`P-C0T`#`V,#$W-3$`,#8P,3<U,0`P,#`P,#`P,C(Q,0`Q
M,S0W-C`R,#8P-@`P,38Q-38`(#``````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````=7-T87(@(`!F<F5D90``
M`````````````````````````````````&9R961E````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````(R!#;W!Y<FEG:'0@*$,I(#(P,30M,C`Q.2!&<F5E
M(%-O9G1W87)E($9O=6YD871I;VXL($EN8RX*"B,@5&AI<R!P<F]G<F%M(&ES
M(&9R964@<V]F='=A<F4[('EO=2!C86X@<F5D:7-T<FEB=71E(&ET(&%N9"]O
M<B!M;V1I9GD*(R!I="!U;F1E<B!T:&4@=&5R;7,@;V8@=&AE($=.52!'96YE
M<F%L(%!U8FQI8R!,:6-E;G-E(&%S('!U8FQI<VAE9"!B>0HC('1H92!&<F5E
M(%-O9G1W87)E($9O=6YD871I;VX[(&5I=&AE<B!V97)S:6]N(#,@;V8@=&AE
M($QI8V5N<V4L(&]R"B,@*&%T('EO=7(@;W!T:6]N*2!A;GD@;&%T97(@=F5R
M<VEO;BX*(PHC(%1H:7,@<')O9W)A;2!I<R!D:7-T<FEB=71E9"!I;B!T:&4@
M:&]P92!T:&%T(&ET('=I;&P@8F4@=7-E9G5L+`HC(&)U="!7251(3U54($%.
M62!705)204Y463L@=VET:&]U="!E=F5N('1H92!I;7!L:65D('=A<G)A;G1Y
M(&]F"B,@34520TA!3E1!0DE,2519(&]R($9)5$Y%4U,@1D]2($$@4$%25$E#
M54Q!4B!055)03U-%+B`@4V5E('1H90HC($=.52!'96YE<F%L(%!U8FQI8R!,
M:6-E;G-E(&9O<B!M;W)E(&1E=&%I;',N"B,*(R!9;W4@<VAO=6QD(&AA=F4@
M<F5C96EV960@82!C;W!Y(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@3&EC
M96YS90HC(&%L;VYG('=I=&@@=&AI<R!P<F]G<F%M+B`@268@;F]T+"!S964@
M/&AT='`Z+R]W=W<N9VYU+F]R9R]L:6-E;G-E<R\^+@H*:6UP;W)T(&=D8@H*
M(R!,;V%D('1H92!X;65T:&]D<R!I9B!'1$(@<W5P<&]R=',@=&AE;2X*9&5F
M(&=D8E]H87-?>&UE=&AO9',H*3H*("`@('1R>3H*("`@("`@("!I;7!O<G0@
M9V1B+GAM971H;V0*("`@("`@("!R971U<FX@5')U90H@("`@97AC97!T($EM
M<&]R=$5R<F]R.@H@("`@("`@(')E='5R;B!&86QS90H*9&5F(')E9VES=&5R
M7VQI8G-T9&-X>%]P<FEN=&5R<RAO8FHI.@H@("`@(R!,;V%D('1H92!P<F5T
M='DM<')I;G1E<G,N"B`@("!F<F]M("YP<FEN=&5R<R!I;7!O<G0@<F5G:7-T
M97)?;&EB<W1D8WAX7W!R:6YT97)S"B`@("!R96=I<W1E<E]L:6)S=&1C>'A?
M<')I;G1E<G,H;V)J*0H*("`@(&EF(&=D8E]H87-?>&UE=&AO9',H*3H*("`@
M("`@("!F<F]M("YX;65T:&]D<R!I;7!O<G0@<F5G:7-T97)?;&EB<W1D8WAX
M7WAM971H;V1S"B`@("`@("`@<F5G:7-T97)?;&EB<W1D8WAX7WAM971H;V1S
M*&]B:BD*````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````+B]P>71H;VXO;&EB<W1D8WAX+U]?:6YI
M=%]?+G!Y````````````````````````````````````````````````````
M`````````````````````````````````````````#`P,#`V-#0`,#8P,3<U
M,0`P-C`Q-S4Q`#`P,#`P,#`P,#`Q`#$S-#<V,#(P-C`V`#`Q-38Q-@`@,```
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````````!U<W1A<B`@`&9R961E````````````````````````````````
M````9G)E9&4`````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````````````*````````
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
M`````````````"XO<'ET:&]N+TUA:V5F:6QE+F%M````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````P,#`P-C0T`#`V,#$W-3$`,#8P,3<U,0`P
M,#`P,#`P-#,S-P`Q,S0W-C`R,#8P-@`P,3,U-34`(#``````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````=7-T
M87(@(`!F<F5D90```````````````````````````````````&9R961E````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````(R,@36%K969I;&4@9F]R('1H
M92!P>71H;VX@<W5B9&ER96-T;W)Y(&]F('1H92!'3E4@0RLK(%-T86YD87)D
M(&QI8G)A<GDN"B,C"B,C($-O<'ER:6=H="`H0RD@,C`P.2TR,#$Y($9R964@
M4V]F='=A<F4@1F]U;F1A=&EO;BP@26YC+@HC(PHC(R!4:&ES(&9I;&4@:7,@
M<&%R="!O9B!T:&4@;&EB<W1D8RLK('9E<G-I;VX@,R!D:7-T<FEB=71I;VXN
M"B,C(%!R;V-E<W,@=&AI<R!F:6QE('=I=&@@875T;VUA:V4@=&\@<')O9'5C
M92!-86ME9FEL92YI;BX*"B,C(%1H:7,@9FEL92!I<R!P87)T(&]F('1H92!'
M3E4@25-/($,K*R!,:6)R87)Y+B`@5&AI<R!L:6)R87)Y(&ES(&9R964*(R,@
M<V]F='=A<F4[('EO=2!C86X@<F5D:7-T<FEB=71E(&ET(&%N9"]O<B!M;V1I
M9GD@:70@=6YD97(@=&AE"B,C('1E<FUS(&]F('1H92!'3E4@1V5N97)A;"!0
M=6)L:6,@3&EC96YS92!A<R!P=6)L:7-H960@8GD@=&AE"B,C($9R964@4V]F
M='=A<F4@1F]U;F1A=&EO;CL@96ET:&5R('9E<G-I;VX@,RP@;W(@*&%T('EO
M=7(@;W!T:6]N*0HC(R!A;GD@;&%T97(@=F5R<VEO;BX*(R,*(R,@5&AI<R!L
M:6)R87)Y(&ES(&1I<W1R:6)U=&5D(&EN('1H92!H;W!E('1H870@:70@=VEL
M;"!B92!U<V5F=6PL"B,C(&)U="!7251(3U54($%.62!705)204Y463L@=VET
M:&]U="!E=F5N('1H92!I;7!L:65D('=A<G)A;G1Y(&]F"B,C($U%4D-(04Y4
M04))3$E462!O<B!&251.15-3($9/4B!!(%!!4E1)0U5,05(@4%524$]312X@
M(%-E92!T:&4*(R,@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@9F]R(&UO
M<F4@9&5T86EL<RX*(R,*(R,@66]U('-H;W5L9"!H879E(')E8V5I=F5D(&$@
M8V]P>2!O9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@86QO;F<*
M(R,@=VET:"!T:&ES(&QI8G)A<GD[('-E92!T:&4@9FEL92!#3U!924Y',RX@
M($EF(&YO="!S964*(R,@/&AT='`Z+R]W=W<N9VYU+F]R9R]L:6-E;G-E<R\^
M+@H*:6YC;'5D92`D*'1O<%]S<F-D:7(I+V9R86=M96YT+F%M"@HC(R!7:&5R
M92!T;R!I;G-T86QL('1H92!M;V1U;&4@8V]D92X*:68@14Y!0DQ%7U!95$A/
M3D1)4@IP>71H;VYD:7(@/2`D*'!R969I>"DO)"AP>71H;VY?;6]D7V1I<BD*
M96QS90IP>71H;VYD:7(@/2`D*&1A=&%D:7(I+V=C8RTD*&=C8U]V97)S:6]N
M*2]P>71H;VX*96YD:68*"F%L;"UL;V-A;#H@9V1B+G!Y"@IN;V)A<V5?<'ET
M:&]N7T1!5$$@/2!<"B`@("!L:6)S=&1C>'@O=C8O<')I;G1E<G,N<'D@7`H@
M("`@;&EB<W1D8WAX+W8V+WAM971H;V1S+G!Y(%P*("`@(&QI8G-T9&-X>"]V
M-B]?7VEN:71?7RYP>2!<"B`@("!L:6)S=&1C>'@O7U]I;FET7U\N<'D*"F=D
M8BYP>3H@:&]O:RYI;B!-86ME9FEL90H)<V5D("UE("=S+$!P>71H;VYD:7)`
M+"0H<'ET:&]N9&ER*2PG(%P*"2`@("`M92`G<RQ`=&]O;&5X96-L:6)D:7)`
M+"0H=&]O;&5X96-L:6)D:7(I+"<@/"`D*'-R8V1I<BDO:&]O:RYI;B`^("1`
M"@II;G-T86QL+61A=&$M;&]C86PZ(&=D8BYP>0H)0"0H;6MD:7)?<"D@)"A$
M15-41$E2*20H=&]O;&5X96-L:6)D:7(I"B,C(%=E('=A;G0@=&\@:6YS=&%L
M;"!G9&(N<'D@87,@4T]-151(24Y'+6=D8BYP>2X@(%-/34542$E.1R!I<R!T
M:&4*(R,@9G5L;"!N86UE(&]F('1H92!F:6YA;"!L:6)R87)Y+B`@5V4@=V%N
M="!T;R!I9VYO<F4@<WEM;&EN:W,L('1H90HC(R`N;&$@9FEL92P@86YD(&%N
M>2!P<F5V:6]U<R`M9V1B+G!Y(&9I;&4N("!4:&ES(&ES(&EN:&5R96YT;'D*
M(R,@9G)A9VEL92P@8G5T('1H97)E(&1O97,@;F]T('-E96T@=&\@8F4@82!B
M971T97(@;W!T:6]N+"!B96-A=7-E"B,C(&QI8G1O;VP@:&ED97,@=&AE(')E
M86P@;F%M97,@9G)O;2!U<RX*"4!H97)E/6!P=V1@.R!C9"`D*$1%4U1$25(I
M)"AT;V]L97AE8VQI8F1I<BD[(%P*"2`@9F]R(&9I;&4@:6X@;&EB<W1D8RLK
M+BH[(&1O(%P*"2`@("!C87-E("0D9FEL92!I;B!<"@D@("`@("`J+6=D8BYP
M>2D@.SL@7`H)("`@("`@*BYL82D@.SL@7`H)("`@("`@*BD@:68@=&5S="`M
M:"`D)&9I;&4[('1H96X@7`H)("`@("`@("`@("!C;VYT:6YU93L@7`H)("`@
M("`@("`@9FD[(%P*"2`@("`@("`@(&QI8FYA;64])"1F:6QE.SL@7`H)("`@
M(&5S86,[(%P*"2`@9&]N93L@7`H)8V0@)"1H97)E.R!<"@EE8VAO("(@)"A)
M3E-404Q,7T1!5$$I(&=D8BYP>2`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I
M<BDO)"1L:6)N86UE+6=D8BYP>2([(%P*"20H24Y35$%,3%]$051!*2!G9&(N
M<'D@)"A$15-41$E2*20H=&]O;&5X96-L:6)D:7(I+R0D;&EB;F%M92UG9&(N
M<'D*````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````"XO<'ET:&]N+TUA:V5F:6QE+FEN````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````P,#`P-C0T`#`V,#$W
M-3$`,#8P,3<U,0`P,#`P,#`T-#4Q,``Q,S0W-C`R,#8P-@`P,3,U-C,`(#``
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````=7-T87(@(`!F<F5D90``````````````````````````````
M`````&9R961E````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````(R!-86ME
M9FEL92YI;B!G96YE<F%T960@8GD@875T;VUA:V4@,2XQ-2XQ(&9R;VT@36%K
M969I;&4N86TN"B,@0&-O;F9I9W5R95]I;G!U=$`*"B,@0V]P>7)I9VAT("A#
M*2`Q.3DT+3(P,3<@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N+"!);F,N"@HC
M(%1H:7,@36%K969I;&4N:6X@:7,@9G)E92!S;V9T=V%R93L@=&AE($9R964@
M4V]F='=A<F4@1F]U;F1A=&EO;@HC(&=I=F5S('5N;&EM:71E9"!P97)M:7-S
M:6]N('1O(&-O<'D@86YD+V]R(&1I<W1R:6)U=&4@:70L"B,@=VET:"!O<B!W
M:71H;W5T(&UO9&EF:6-A=&EO;G,L(&%S(&QO;F<@87,@=&AI<R!N;W1I8V4@
M:7,@<')E<V5R=F5D+@H*(R!4:&ES('!R;V=R86T@:7,@9&ES=')I8G5T960@
M:6X@=&AE(&AO<&4@=&AA="!I="!W:6QL(&)E('5S969U;"P*(R!B=70@5TE4
M2$]55"!!3ED@5T%24D%.5%DL('1O('1H92!E>'1E;G0@<&5R;6ET=&5D(&)Y
M(&QA=SL@=VET:&]U=`HC(&5V96X@=&AE(&EM<&QI960@=V%R<F%N='D@;V8@
M34520TA!3E1!0DE,2519(&]R($9)5$Y%4U,@1D]2($$*(R!005)424-53$%2
M(%!54E!/4T4N"@I`4T547TU!2T5`"@I64$%42"`]($!S<F-D:7)`"F%M7U]I
M<U]G;G5?;6%K92`]('L@7`H@(&EF('1E<W0@+7H@)R0H34%+14Q%5D5,*2<[
M('1H96X@7`H@("`@9F%L<V4[(%P*("!E;&EF('1E<W0@+6X@)R0H34%+15](
M3U-4*2<[('1H96X@7`H@("`@=')U93L@7`H@(&5L:68@=&5S="`M;B`G)"A-
M04M%7U9%4E-)3TXI)R`F)B!T97-T("UN("<D*$-54D1)4BDG.R!T:&5N(%P*
M("`@('1R=64[(%P*("!E;'-E(%P*("`@(&9A;'-E.R!<"B`@9FD[(%P*?0IA
M;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N(#T@7`H@(&-A<V4@)"1[=&%R
M9V5T7V]P=&EO;BU](&EN(%P*("`@("`@/RD@.SL@7`H@("`@("`J*2!E8VAO
M(")A;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N.B!I;G1E<FYA;"!E<G)O
M<CH@:6YV86QI9"(@7`H@("`@("`@("`@("`@(")T87)G970@;W!T:6]N("<D
M)'MT87)G971?;W!T:6]N+7TG('-P96-I9FEE9"(@/B8R.R!<"B`@("`@("`@
M(&5X:70@,3L[(%P*("!E<V%C.R!<"B`@:&%S7V]P=#UN;SL@7`H@('-A;F5?
M;6%K969L86=S/20D34%+149,04=3.R!<"B`@:68@)"AA;5]?:7-?9VYU7VUA
M:V4I.R!T:&5N(%P*("`@('-A;F5?;6%K969L86=S/20D349,04=3.R!<"B`@
M96QS92!<"B`@("!C87-E("0D34%+149,04=3(&EN(%P*("`@("`@*EQ<6UP@
M7`E=*BD@7`H@("`@("`@(&)S/5Q<.R!<"B`@("`@("`@<V%N95]M86ME9FQA
M9W,]8'!R:6YT9B`G)7-<;B<@(B0D34%+149,04=3(B!<"B`@("`@("`@("!\
M('-E9"`B<R\D)&)S)"1B<ULD)&)S("0D8G,)72HO+V<B8#L[(%P*("`@(&5S
M86,[(%P*("!F:3L@7`H@('-K:7!?;F5X=#UN;SL@7`H@('-T<FEP7W1R86EL
M;W!T("@I(%P*("![(%P*("`@(&9L9SU@<')I;G1F("<E<UQN)R`B)"1F;&<B
M('P@<V5D(")S+R0D,2XJ)"0O+R)@.R!<"B`@?3L@7`H@(&9O<B!F;&<@:6X@
M)"1S86YE7VUA:V5F;&%G<SL@9&\@7`H@("`@=&5S="`D)'-K:7!?;F5X="`]
M('EE<R`F)B![('-K:7!?;F5X=#UN;SL@8V]N=&EN=64[('T[(%P*("`@(&-A
M<V4@)"1F;&<@:6X@7`H@("`@("`J/2I\+2TJ*2!C;VYT:6YU93L[(%P*("`@
M("`@("`M*DDI('-T<FEP7W1R86EL;W!T("=))SL@<VMI<%]N97AT/7EE<SL[
M(%P*("`@("`@+2I)/RHI('-T<FEP7W1R86EL;W!T("=))SL[(%P*("`@("`@
M("`M*D\I('-T<FEP7W1R86EL;W!T("=/)SL@<VMI<%]N97AT/7EE<SL[(%P*
M("`@("`@+2I//RHI('-T<FEP7W1R86EL;W!T("=/)SL[(%P*("`@("`@("`M
M*FPI('-T<FEP7W1R86EL;W!T("=L)SL@<VMI<%]N97AT/7EE<SL[(%P*("`@
M("`@+2IL/RHI('-T<FEP7W1R86EL;W!T("=L)SL[(%P*("`@("`@+5MD141M
M72D@<VMI<%]N97AT/7EE<SL[(%P*("`@("`@+5M*5%TI('-K:7!?;F5X=#UY
M97,[.R!<"B`@("!E<V%C.R!<"B`@("!C87-E("0D9FQG(&EN(%P*("`@("`@
M*B0D=&%R9V5T7V]P=&EO;BHI(&AA<U]O<'0]>65S.R!B<F5A:SL[(%P*("`@
M(&5S86,[(%P*("!D;VYE.R!<"B`@=&5S="`D)&AA<U]O<'0@/2!Y97,*86U?
M7VUA:V5?9')Y<G5N(#T@*'1A<F=E=%]O<'1I;VX];CL@)"AA;5]?;6%K95]R
M=6YN:6YG7W=I=&A?;W!T:6]N*2D*86U?7VUA:V5?:V5E<&=O:6YG(#T@*'1A
M<F=E=%]O<'1I;VX]:SL@)"AA;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N
M*2D*<&MG9&%T861I<B`]("0H9&%T861I<BDO0%!!0TM!1T5`"G!K9VEN8VQU
M9&5D:7(@/2`D*&EN8VQU9&5D:7(I+T!004-+04=%0`IP:V=L:6)D:7(@/2`D
M*&QI8F1I<BDO0%!!0TM!1T5`"G!K9VQI8F5X96-D:7(@/2`D*&QI8F5X96-D
M:7(I+T!004-+04=%0`IA;5]?8V0@/2!#1%!!5$@](B0D>UI32%]615)324].
M*RY])"A0051(7U-%4$%2051/4BDB("8F(&-D"FEN<W1A;&Q?<VA?1$%402`]
M("0H:6YS=&%L;%]S:"D@+6,@+6T@-C0T"FEN<W1A;&Q?<VA?4%)/1U)!32`]
M("0H:6YS=&%L;%]S:"D@+6,*:6YS=&%L;%]S:%]30U))4%0@/2`D*&EN<W1A
M;&Q?<V@I("UC"DE.4U1!3$Q?2$5!1$52(#T@)"A)3E-404Q,7T1!5$$I"G1R
M86YS9F]R;2`]("0H<')O9W)A;5]T<F%N<V9O<FU?;F%M92D*3D]234%,7TE.
M4U1!3$P@/2`Z"E!215])3E-404Q,(#T@.@I03U-47TE.4U1!3$P@/2`Z"DY/
M4DU!3%]53DE.4U1!3$P@/2`Z"E!215]53DE.4U1!3$P@/2`Z"E!/4U1?54Y)
M3E-404Q,(#T@.@IB=6EL9%]T<FEP;&5T(#T@0&)U:6QD0`IH;W-T7W1R:7!L
M970@/2!`:&]S=$`*=&%R9V5T7W1R:7!L970@/2!`=&%R9V5T0`IS=6)D:7(@
M/2!P>71H;VX*04-,3T-!3%]--"`]("0H=&]P7W-R8V1I<BDO86-L;V-A;"YM
M-`IA;5]?86-L;V-A;%]M-%]D97!S(#T@)"AT;W!?<W)C9&ER*2\N+B]C;VYF
M:6<O86-X+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V5N86)L92YM
M-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]F=71E>"YM-"!<"@DD*'1O
M<%]S<F-D:7(I+RXN+V-O;F9I9R]H=V-A<',N;30@7`H))"AT;W!?<W)C9&ER
M*2\N+B]C;VYF:6<O:6-O;G8N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF
M:6<O;&5A9"UD;W0N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;&EB
M+6QD+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VQI8BUL:6YK+FTT
M(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VQI8BUP<F5F:7@N;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;'1H;W-T9FQA9W,N;30@7`H))"AT
M;W!?<W)C9&ER*2\N+B]C;VYF:6<O;75L=&DN;30@7`H))"AT;W!?<W)C9&ER
M*2\N+B]C;VYF:6<O;F\M97AE8W5T86)L97,N;30@7`H))"AT;W!?<W)C9&ER
M*2\N+B]C;VYF:6<O;W9E<G)I9&4N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C
M;VYF:6<O<W1D:6YT+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+W5N
M=VEN9%]I<&EN9F\N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]L:6)T;V]L+FTT
M("0H=&]P7W-R8V1I<BDO+BXO;'1O<'1I;VYS+FTT(%P*"20H=&]P7W-R8V1I
M<BDO+BXO;'1S=6=A<BYM-"`D*'1O<%]S<F-D:7(I+RXN+VQT=F5R<VEO;BYM
M-"!<"@DD*'1O<%]S<F-D:7(I+RXN+VQT?F]B<V]L971E+FTT("0H=&]P7W-R
M8V1I<BDO8W)O<W-C;VYF:6<N;30@7`H))"AT;W!?<W)C9&ER*2]L:6YK86=E
M+FTT("0H=&]P7W-R8V1I<BDO86-I;F-L=61E+FTT(%P*"20H=&]P7W-R8V1I
M<BDO+BXO8V]N9FEG+V=C*RMF:6QT+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO
M8V]N9FEG+W1L<RYM-"`D*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]G=&AR+FTT
M(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V-E="YM-"`D*'1O<%]S<F-D
M:7(I+V-O;F9I9W5R92YA8PIA;5]?8V]N9FEG=7)E7V1E<',@/2`D*&%M7U]A
M8VQO8V%L7VTT7V1E<',I("0H0T].1DE'55)%7T1%4$5.1$5.0TE%4RD@7`H)
M)"A!0TQ/0T%,7TTT*0I$25-47T-/34U/3B`]("0H<W)C9&ER*2]-86ME9FEL
M92YA;0I#3TY&24=?2$5!1$52(#T@)"AT;W!?8G5I;&1D:7(I+V-O;F9I9RYH
M"D-/3D9)1U]#3$5!3E]&24Q%4R`]"D-/3D9)1U]#3$5!3E]64$%42%]&24Q%
M4R`]"D%-7U9?4"`]("0H86U?7W9?4%]`04U?5D`I"F%M7U]V7U!?(#T@)"AA
M;5]?=E]07T!!35]$149!54Q47U9`*0IA;5]?=E]07S`@/2!F86QS90IA;5]?
M=E]07S$@/2`Z"D%-7U9?1T5.(#T@)"AA;5]?=E]'14Y?0$%-7U9`*0IA;5]?
M=E]'14Y?(#T@)"AA;5]?=E]'14Y?0$%-7T1%1D%53%1?5D`I"F%M7U]V7T=%
M3E\P(#T@0&5C:&\@(B`@1T5.("`@("`B("1`.PIA;5]?=E]'14Y?,2`](`I!
M35]67V%T(#T@)"AA;5]?=E]A=%]`04U?5D`I"F%M7U]V7V%T7R`]("0H86U?
M7W9?871?0$%-7T1%1D%53%1?5D`I"F%M7U]V7V%T7S`@/2!`"F%M7U]V7V%T
M7S$@/2`*9&5P8V]M<"`]"F%M7U]D97!F:6QE<U]M87EB92`]"E-/55)#15,@
M/0IA;5]?8V%N7W)U;E]I;G-T86QL:6YF;R`](%P*("!C87-E("0D04U?55!$
M051%7TE.1D]?1$E2(&EN(%P*("`@(&Y\;F]\3D\I(&9A;'-E.SL@7`H@("`@
M*BD@*&EN<W1A;&PM:6YF;R`M+79E<G-I;VXI(#XO9&5V+VYU;&P@,CXF,3L[
M(%P*("!E<V%C"F%M7U]V<&%T:%]A9&I?<V5T=7`@/2!S<F-D:7)S=')I<#U@
M96-H;R`B)"AS<F-D:7(I(B!\('-E9"`G<WPN?"Y\9R=@.PIA;5]?=G!A=&A?
M861J(#T@8V%S92`D)'`@:6X@7`H@("`@)"AS<F-D:7(I+RHI(&8]8&5C:&\@
M(B0D<"(@?"!S960@(G-\7B0D<W)C9&ER<W1R:7`O?'PB8#L[(%P*("`@("HI
M(&8])"1P.SL@7`H@(&5S86,["F%M7U]S=')I<%]D:7(@/2!F/6!E8VAO("0D
M<"!\('-E9"`M92`G<WQ>+BHO?'PG8#L*86U?7VEN<W1A;&Q?;6%X(#T@-#`*
M86U?7VYO8F%S95]S=')I<%]S971U<"`](%P*("!S<F-D:7)S=')I<#U@96-H
M;R`B)"AS<F-D:7(I(B!\('-E9"`G<R];72Y;7B0D7%PJ?%TO7%Q<7"8O9R=@
M"F%M7U]N;V)A<V5?<W1R:7`@/2!<"B`@9F]R('`@:6X@)"1L:7-T.R!D;R!E
M8VAO("(D)'`B.R!D;VYE('P@<V5D("UE(")S?"0D<W)C9&ER<W1R:7`O?'PB
M"F%M7U]N;V)A<V5?;&ES="`]("0H86U?7VYO8F%S95]S=')I<%]S971U<"D[
M(%P*("!F;W(@<"!I;B`D)&QI<W0[(&1O(&5C:&\@(B0D<"`D)'`B.R!D;VYE
M('P@7`H@('-E9"`B<WP@)"1S<F-D:7)S=')I<"]\('P[(B<@+R`N*EPO+R%S
M+R`N*B\@+B\[(',L7"@@+BI<*2];7B]=*B0D+%PQ+"<@?"!<"B`@)"A!5TLI
M("="14=)3B![(&9I;&5S6R(N(ET@/2`B(B!]('L@9FEL97-;)"0R72`](&9I
M;&5S6R0D,ET@(B`B("0D,3L@7`H@("`@:68@*"LK;ELD)#)=(#T]("0H86U?
M7VEN<W1A;&Q?;6%X*2D@7`H@("`@("![('!R:6YT("0D,BP@9FEL97-;)"0R
M73L@;ELD)#)=(#T@,#L@9FEL97-;)"0R72`]("(B('T@?2!<"B`@("!%3D0@
M>R!F;W(@*&1I<B!I;B!F:6QE<RD@<')I;G0@9&ER+"!F:6QE<UMD:7)=('TG
M"F%M7U]B87-E7VQI<W0@/2!<"B`@<V5D("<D)"%..R0D(4X[)"0A3CLD)"%.
M.R0D(4X[)"0A3CLD)"%..W,O7&XO("]G)R!\(%P*("!S960@)R0D(4X[)"0A
M3CLD)"%..R0D(4X[<R]<;B\@+V<G"F%M7U]U;FEN<W1A;&Q?9FEL97-?9G)O
M;5]D:7(@/2![(%P*("!T97-T("UZ("(D)&9I;&5S(B!<"B`@("!\?"![('1E
M<W0@(2`M9"`B)"1D:7(B("8F('1E<W0@(2`M9B`B)"1D:7(B("8F('1E<W0@
M(2`M<B`B)"1D:7(B.R!](%P*("`@('Q\('L@96-H;R`B("@@8V0@)R0D9&ER
M)R`F)B!R;2`M9B(@)"1F:6QE<R`B*2([(%P*("`@("`@("`@)"AA;5]?8V0I
M("(D)&1I<B(@)B8@<FT@+68@)"1F:6QE<SL@?3L@7`H@('T*86U?7VEN<W1A
M;&QD:7)S(#T@(B0H1$535$1)4BDD*'!Y=&AO;F1I<BDB"D1!5$$@/2`D*&YO
M8F%S95]P>71H;VY?1$%402D*86U?7W1A9V=E9%]F:6QE<R`]("0H2$5!1$52
M4RD@)"A33U520T53*2`D*%1!1U-?1DE,15,I("0H3$E34"D*04))7U1714%+
M4U]34D-$25(@/2!`04))7U1714%+4U]34D-$25)`"D%#3$]#04P@/2!`04-,
M3T-!3$`*04Q,3T-!5$]27T@@/2!`04Q,3T-!5$]27TA`"D%,3$]#051/4E].
M04U%(#T@0$%,3$]#051/4E].04U%0`I!351!4B`]($!!351!4D`*04U?1$5&
M055,5%]615)"3U-)5%D@/2!`04U?1$5&055,5%]615)"3U-)5%E`"D%2(#T@
M0$%20`I!4R`]($!!4T`*051/34E#25197U-20T1)4B`]($!!5$]-24-)5%E?
M4U)#1$E20`I!5$]-24-?1DQ!1U,@/2!`051/34E#7T9,04=30`I!5$]-24-?
M5T]21%]34D-$25(@/2!`051/34E#7U=/4D1?4U)#1$E20`I!551/0T].1B`]
M($!!551/0T].1D`*05543TA%041%4B`]($!!551/2$5!1$520`I!551/34%+
M12`]($!!551/34%+14`*05=+(#T@0$%72T`*0D%324-?1DE,15]#0R`]($!"
M05-)0U]&24Q%7T-#0`I"05-)0U]&24Q%7T@@/2!`0D%324-?1DE,15](0`I#
M0R`]($!#0T`*0T-/1$5#5E1?0T,@/2!`0T-/1$5#5E1?0T-`"D-#3TQ,051%
M7T-#(#T@0$-#3TQ,051%7T-#0`I#0U194$5?0T,@/2!`0T-465!%7T-#0`I#
M1DQ!1U,@/2!`0T9,04=30`I#3$]#04Q%7T-#(#T@0$-,3T-!3$5?0T-`"D-,
M3T-!3$5?2"`]($!#3$]#04Q%7TA`"D-,3T-!3$5?24Y415).04Q?2"`]($!#
M3$]#04Q%7TE.5$523D%,7TA`"D--15-304=%4U]#0R`]($!#34534T%'15-?
M0T-`"D--15-304=%4U]((#T@0$--15-304=%4U](0`I#34].15E?0T,@/2!`
M0TU/3D597T-#0`I#3E5-15))0U]#0R`]($!#3E5-15))0U]#0T`*0U!0(#T@
M0$-04$`*0U!01DQ!1U,@/2!`0U!01DQ!1U-`"D-055]$149)3D537U-20T1)
M4B`]($!#4%5?1$5&24Y%4U]34D-$25)`"D-055]/4%1?0DE44U]204Y$3TT@
M/2!`0U!57T]05%]"25137U)!3D1/34`*0U!57T]05%]%6%1?4D%.1$]-(#T@
M0$-055]/4%1?15A47U)!3D1/34`*0U-41$E/7T@@/2!`0U-41$E/7TA`"D-4
M24U%7T-#(#T@0$-424U%7T-#0`I#5$E-15]((#T@0$-424U%7TA`"D-86"`]
M($!#6%A`"D-86$-04"`]($!#6%A#4%!`"D-86$9)3%0@/2!`0UA81DE,5$`*
M0UA81DQ!1U,@/2!`0UA81DQ!1U-`"D-91U!!5$A?5R`]($!#64=0051(7U=`
M"D-?24Y#3%5$15]$25(@/2!`0U])3D-,541%7T1)4D`*1$),051%6"`]($!$
M0DQ!5$580`I$14)51U]&3$%'4R`]($!$14)51U]&3$%'4T`*1$5&4R`]($!$
M14930`I$3U0@/2!`1$]40`I$3UA91T5.(#T@0$1/6%E'14Y`"D1364U55$E,
M(#T@0$1364U55$E,0`I$54U00DE.(#T@0$1535!"24Y`"D5#2$]?0R`]($!%
M0TA/7T-`"D5#2$]?3B`]($!%0TA/7TY`"D5#2$]?5"`]($!%0TA/7U1`"D5'
M4D50(#T@0$5'4D500`I%4E)/4E]#3TY35$%.5%-?4U)#1$E2(#T@0$524D]2
M7T-/3E-404Y44U]34D-$25)`"D5814585"`]($!%6$5%6%1`"D585%)!7T-&
M3$%'4R`]($!%6%1205]#1DQ!1U-`"D585%)!7T-86%]&3$%'4R`]($!%6%12
M05]#6%A?1DQ!1U-`"D9'4D50(#T@0$9'4D500`I'3$E"0UA87TE.0TQ51$53
M(#T@0$=,24)#6%A?24Y#3%5$15-`"D=,24)#6%A?3$E"4R`]($!'3$E"0UA8
M7TQ)0E-`"D=215`@/2!`1U)%4$`*2%=#05!?0T9,04=3(#T@0$A70T%07T-&
M3$%'4T`*24Y35$%,3"`]($!)3E-404Q,0`I)3E-404Q,7T1!5$$@/2!`24Y3
M5$%,3%]$051!0`I)3E-404Q,7U!23T=204T@/2!`24Y35$%,3%]04D]'4D%-
M0`I)3E-404Q,7U-#4DE05"`]($!)3E-404Q,7U-#4DE05$`*24Y35$%,3%]3
M5%))4%]04D]'4D%-(#T@0$E.4U1!3$Q?4U1225!?4%)/1U)!34`*3$0@/2!`
M3$1`"DQ$1DQ!1U,@/2!`3$1&3$%'4T`*3$E"24-/3E8@/2!`3$E"24-/3E9`
M"DQ)0D]"2E,@/2!`3$E"3T)*4T`*3$E"4R`]($!,24)30`I,24)43T],(#T@
M0$Q)0E1/3TQ`"DQ)4$\@/2!`3$E03T`*3$Y?4R`]($!,3E]30`I,3TY'7T1/
M54),15]#3TU0051?1DQ!1U,@/2!`3$].1U]$3U5"3$5?0T]-4$%47T9,04=3
M0`I,5$Q)0DE#3TY6(#T@0$Q43$E"24-/3E9`"DQ43$E"3T)*4R`]($!,5$Q)
M0D]"2E-`"DU!24Y4(#T@0$U!24Y40`I-04M%24Y&3R`]($!-04M%24Y&3T`*
M34M$25)?4"`]($!-2T1)4E]00`I.32`]($!.34`*3DU%1$E4(#T@0$Y-141)
M5$`*3T)*1%5-4"`]($!/0DI$54U00`I/0DI%6%0@/2!`3T)*15A40`I/4%1)
M34E:15]#6%A&3$%'4R`]($!/4%1)34E:15]#6%A&3$%'4T`*3U!47TQ$1DQ!
M1U,@/2!`3U!47TQ$1DQ!1U-`"D]37TE.0U]34D-$25(@/2!`3U-?24Y#7U-2
M0T1)4D`*3U1/3TP@/2!`3U1/3TQ`"D]43T],-C0@/2!`3U1/3TPV-$`*4$%#
M2T%'12`]($!004-+04=%0`I004-+04=%7T)51U)%4$]25"`]($!004-+04=%
M7T)51U)%4$]25$`*4$%#2T%'15].04U%(#T@0%!!0TM!1T5?3D%-14`*4$%#
M2T%'15]35%))3D<@/2!`4$%#2T%'15]35%))3D=`"E!!0TM!1T5?5$%23D%-
M12`]($!004-+04=%7U1!4DY!345`"E!!0TM!1T5?55),(#T@0%!!0TM!1T5?
M55),0`I004-+04=%7U9%4E-)3TX@/2!`4$%#2T%'15]615)324].0`I0051(
M7U-%4$%2051/4B`]($!0051(7U-%4$%2051/4D`*4$1&3$%415@@/2!`4$1&
M3$%415A`"E)!3DQ)0B`]($!204Y,24)`"E-%0U1)3TY?1DQ!1U,@/2!`4T5#
M5$E/3E]&3$%'4T`*4T5#5$E/3E],1$9,04=3(#T@0%-%0U1)3TY?3$1&3$%'
M4T`*4T5$(#T@0%-%1$`*4T547TU!2T4@/2!`4T547TU!2T5`"E-(14Q,(#T@
M0%-(14Q,0`I35%))4"`]($!35%))4$`*4UE-5D527T9)3$4@/2!`4UE-5D52
M7T9)3$5`"E1/4$Q%5D5,7TE.0TQ51$53(#T@0%1/4$Q%5D5,7TE.0TQ51$53
M0`I54T5?3DQ3(#T@0%5315].3%-`"E9%4E-)3TX@/2!`5D524TE/3D`*5E16
M7T-86$9,04=3(#T@0%945E]#6%A&3$%'4T`*5E167T-86$Q)3DM&3$%'4R`]
M($!65%9?0UA83$E.2T9,04=30`I65%9?4$-(7T-86$9,04=3(#T@0%945E]0
M0TA?0UA81DQ!1U-`"E=!4DY?1DQ!1U,@/2!`5T%23E]&3$%'4T`*6$U,0T%4
M04Q/1R`]($!834Q#051!3$]'0`I834Q,24Y4(#T@0%A-3$Q)3E1`"EA33%10
M4D]#(#T@0%A33%104D]#0`I84TQ?4U193$5?1$E2(#T@0%A33%]35%E,15]$
M25)`"F%B<U]B=6EL9&1I<B`]($!A8G-?8G5I;&1D:7)`"F%B<U]S<F-D:7(@
M/2!`86)S7W-R8V1I<D`*86)S7W1O<%]B=6EL9&1I<B`]($!A8G-?=&]P7V)U
M:6QD9&ER0`IA8G-?=&]P7W-R8V1I<B`]($!A8G-?=&]P7W-R8V1I<D`*86-?
M8W1?0T,@/2!`86-?8W1?0T-`"F%C7V-T7T-86"`]($!A8U]C=%]#6%A`"F%C
M7V-T7T1535!"24X@/2!`86-?8W1?1%5-4$))3D`*86U?7VQE861I;F=?9&]T
M(#T@0&%M7U]L96%D:6YG7V1O=$`*86U?7W1A<B`]($!A;5]?=&%R0`IA;5]?
M=6YT87(@/2!`86U?7W5N=&%R0`IB87-E;&EN95]D:7(@/2!`8F%S96QI;F5?
M9&ER0`IB87-E;&EN95]S=6)D:7)?<W=I=&-H(#T@0&)A<V5L:6YE7W-U8F1I
M<E]S=VET8VA`"F)I;F1I<B`]($!B:6YD:7)`"F)U:6QD(#T@0&)U:6QD0`IB
M=6EL9%]A;&EA<R`]($!B=6EL9%]A;&EA<T`*8G5I;&1?8W!U(#T@0&)U:6QD
M7V-P=4`*8G5I;&1?;W,@/2!`8G5I;&1?;W-`"F)U:6QD7W9E;F1O<B`]($!B
M=6EL9%]V96YD;W)`"F)U:6QD9&ER(#T@0&)U:6QD9&ER0`IC:&5C:U]M<V=F
M;70@/2!`8VAE8VM?;7-G9FUT0`ID871A9&ER(#T@0&1A=&%D:7)`"F1A=&%R
M;V]T9&ER(#T@0&1A=&%R;V]T9&ER0`ID;V-D:7(@/2!`9&]C9&ER0`ID=FED
M:7(@/2!`9'9I9&ER0`IE;F%B;&5?<VAA<F5D(#T@0&5N86)L95]S:&%R961`
M"F5N86)L95]S=&%T:6,@/2!`96YA8FQE7W-T871I8T`*97AE8U]P<F5F:7@@
M/2!`97AE8U]P<F5F:7A`"F=E=%]G8V-?8F%S95]V97(@/2!`9V5T7V=C8U]B
M87-E7W9E<D`*9VQI8F-X>%]-3T9)3$53(#T@0&=L:6)C>'A?34]&24Q%4T`*
M9VQI8F-X>%]00TA&3$%'4R`]($!G;&EB8WAX7U!#2$9,04=30`IG;&EB8WAX
M7U!/1DE,15,@/2!`9VQI8F-X>%]03T9)3$530`IG;&EB8WAX7V)U:6QD9&ER
M(#T@0&=L:6)C>'A?8G5I;&1D:7)`"F=L:6)C>'A?8V]M<&EL97)?<&EC7V9L
M86<@/2!`9VQI8F-X>%]C;VUP:6QE<E]P:6-?9FQA9T`*9VQI8F-X>%]C;VUP
M:6QE<E]S:&%R961?9FQA9R`]($!G;&EB8WAX7V-O;7!I;&5R7W-H87)E9%]F
M;&%G0`IG;&EB8WAX7V-X>#DX7V%B:2`]($!G;&EB8WAX7V-X>#DX7V%B:4`*
M9VQI8F-X>%]L;V-A;&5D:7(@/2!`9VQI8F-X>%]L;V-A;&5D:7)`"F=L:6)C
M>'A?;'1?<&EC7V9L86<@/2!`9VQI8F-X>%]L=%]P:6-?9FQA9T`*9VQI8F-X
M>%]P<F5F:7AD:7(@/2!`9VQI8F-X>%]P<F5F:7AD:7)`"F=L:6)C>'A?<W)C
M9&ER(#T@0&=L:6)C>'A?<W)C9&ER0`IG;&EB8WAX7W1O;VQE>&5C9&ER(#T@
M0&=L:6)C>'A?=&]O;&5X96-D:7)`"F=L:6)C>'A?=&]O;&5X96-L:6)D:7(@
M/2!`9VQI8F-X>%]T;V]L97AE8VQI8F1I<D`*9WAX7VEN8VQU9&5?9&ER(#T@
M0&=X>%]I;F-L=61E7V1I<D`*:&]S="`]($!H;W-T0`IH;W-T7V%L:6%S(#T@
M0&AO<W1?86QI87-`"FAO<W1?8W!U(#T@0&AO<W1?8W!U0`IH;W-T7V]S(#T@
M0&AO<W1?;W-`"FAO<W1?=F5N9&]R(#T@0&AO<W1?=F5N9&]R0`IH=&UL9&ER
M(#T@0&AT;6QD:7)`"FEN8VQU9&5D:7(@/2!`:6YC;'5D961I<D`*:6YF;V1I
M<B`]($!I;F9O9&ER0`II;G-T86QL7W-H(#T@0&EN<W1A;&Q?<VA`"FQI8F1I
M<B`]($!L:6)D:7)`"FQI8F5X96-D:7(@/2!`;&EB97AE8V1I<D`*;&EB=&]O
M;%]615)324].(#T@0&QI8G1O;VQ?5D524TE/3D`*;&]C86QE9&ER(#T@0&QO
M8V%L961I<D`*;&]C86QS=&%T961I<B`]($!L;V-A;'-T871E9&ER0`IL=%]H
M;W-T7V9L86=S(#T@0&QT7VAO<W1?9FQA9W-`"FUA;F1I<B`]($!M86YD:7)`
M"FUK9&ER7W`@/2!`;6MD:7)?<$`*;75L=&E?8F%S961I<B`]($!M=6QT:5]B
M87-E9&ER0`IO;&1I;F-L=61E9&ER(#T@0&]L9&EN8VQU9&5D:7)`"G!D9F1I
M<B`]($!P9&9D:7)`"G!O<G1?<W!E8VEF:6-?<WEM8F]L7V9I;&5S(#T@0'!O
M<G1?<W!E8VEF:6-?<WEM8F]L7V9I;&5S0`IP<F5F:7@@/2!`<')E9FEX0`IP
M<F]G<F%M7W1R86YS9F]R;5]N86UE(#T@0'!R;V=R86U?=')A;G-F;W)M7VYA
M;65`"G!S9&ER(#T@0'!S9&ER0`IP>71H;VY?;6]D7V1I<B`]($!P>71H;VY?
M;6]D7V1I<D`*<V)I;F1I<B`]($!S8FEN9&ER0`IS:&%R961S=&%T961I<B`]
M($!S:&%R961S=&%T961I<D`*<W)C9&ER(#T@0'-R8V1I<D`*<WES8V]N9F1I
M<B`]($!S>7-C;VYF9&ER0`IT87)G970@/2!`=&%R9V5T0`IT87)G971?86QI
M87,@/2!`=&%R9V5T7V%L:6%S0`IT87)G971?8W!U(#T@0'1A<F=E=%]C<'5`
M"G1A<F=E=%]O<R`]($!T87)G971?;W-`"G1A<F=E=%]V96YD;W(@/2!`=&%R
M9V5T7W9E;F1O<D`*=&AR96%D7VAE861E<B`]($!T:')E861?:&5A9&5R0`IT
M;W!?8G5I;&1?<')E9FEX(#T@0'1O<%]B=6EL9%]P<F5F:7A`"G1O<%]B=6EL
M9&1I<B`]($!T;W!?8G5I;&1D:7)`"G1O<%]S<F-D:7(@/2!`=&]P7W-R8V1I
M<D`*=&]P;&5V96Q?8G5I;&1D:7(@/2!`=&]P;&5V96Q?8G5I;&1D:7)`"G1O
M<&QE=F5L7W-R8V1I<B`]($!T;W!L979E;%]S<F-D:7)`"@HC($UA>2!B92!U
M<V5D(&)Y('9A<FEO=7,@<W5B<W1I='5T:6]N('9A<FEA8FQE<RX*9V-C7W9E
M<G-I;VX@.CT@)"AS:&5L;"!`9V5T7V=C8U]B87-E7W9E<D`@)"AT;W!?<W)C
M9&ER*2\N+B]G8V,O0D%312U615(I"DU!24Y47T-(05)3150@/2!L871I;C$*
M;6MI;G-T86QL9&ER<R`]("0H4TA%3$PI("0H=&]P;&5V96Q?<W)C9&ER*2]M
M:VEN<W1A;&QD:7)S"E!71%]#3TU-04Y$(#T@)"1[4%=$0TU$+7!W9'T*4U1!
M35`@/2!E8VAO('1I;65S=&%M<"`^"G1O;VQE>&5C9&ER(#T@)"AG;&EB8WAX
M7W1O;VQE>&5C9&ER*0IT;V]L97AE8VQI8F1I<B`]("0H9VQI8F-X>%]T;V]L
M97AE8VQI8F1I<BD*0$5.04),15]715)23U)?1D%,4T5`5T524D]27T9,04<@
M/2`*0$5.04),15]715)23U)?5%)514!715)23U)?1DQ!1R`]("U797)R;W(*
M0$5.04),15]%6%1%4DY?5$5-4$Q!5$5?1D%,4T5`6%1%35!,051%7T9,04=3
M(#T@"D!%3D%"3$5?15A415).7U1%35!,051%7U12545`6%1%35!,051%7T9,
M04=3(#T@+69N;RUI;7!L:6-I="UT96UP;&%T97,*"B,@5&AE<V4@8FET<R!A
M<F4@86QL(&9I9W5R960@;W5T(&9R;VT@8V]N9FEG=7)E+B`@3&]O:R!I;B!A
M8VEN8VQU9&4N;30*(R!O<B!C;VYF:6=U<F4N86,@=&\@<V5E(&AO=R!T:&5Y
M(&%R92!S970N("!3964@1TQ)0D-86%]%6%!/4E1?1DQ!1U,N"D-/3D9)1U]#
M6%A&3$%'4R`](%P*"20H4T5#5$E/3E]&3$%'4RD@)"A(5T-!4%]#1DQ!1U,I
M("UF<F%N9&]M+7-E960])$`*"E=!4DY?0UA81DQ!1U,@/2!<"@DD*%=!4DY?
M1DQ!1U,I("0H5T524D]27T9,04<I("UF9&EA9VYO<W1I8W,M<VAO=RUL;V-A
M=&EO;CUO;F-E(`H*"B,@+4DO+40@9FQA9W,@=&\@<&%S<R!W:&5N(&-O;7!I
M;&EN9RX*04U?0U!01DQ!1U,@/2`D*$=,24)#6%A?24Y#3%5$15,I("0H0U!0
M1DQ!1U,I"D!%3D%"3$5?4%E42$].1$E27T9!3%-%0'!Y=&AO;F1I<B`]("0H
M9&%T861I<BDO9V-C+20H9V-C7W9E<G-I;VXI+W!Y=&AO;@I`14Y!0DQ%7U!9
M5$A/3D1)4E]44E5%0'!Y=&AO;F1I<B`]("0H<')E9FEX*2\D*'!Y=&AO;E]M
M;V1?9&ER*0IN;V)A<V5?<'ET:&]N7T1!5$$@/2!<"B`@("!L:6)S=&1C>'@O
M=C8O<')I;G1E<G,N<'D@7`H@("`@;&EB<W1D8WAX+W8V+WAM971H;V1S+G!Y
M(%P*("`@(&QI8G-T9&-X>"]V-B]?7VEN:71?7RYP>2!<"B`@("!L:6)S=&1C
M>'@O7U]I;FET7U\N<'D*"F%L;#H@86QL+6%M"@HN4U5&1DE815,Z"B0H<W)C
M9&ER*2]-86ME9FEL92YI;CH@0$U!24Y404E.15)?34]$15]44E5%0"`D*'-R
M8V1I<BDO36%K969I;&4N86T@)"AT;W!?<W)C9&ER*2]F<F%G;65N="YA;2`D
M*&%M7U]C;VYF:6=U<F5?9&5P<RD*"4!F;W(@9&5P(&EN("0_.R!D;R!<"@D@
M(&-A<V4@)R0H86U?7V-O;F9I9W5R95]D97!S*2<@:6X@7`H)("`@("HD)&1E
M<"HI(%P*"2`@("`@("@@8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H34%+12D@
M)"A!35]-04M%1DQ!1U,I(&%M+2UR969R97-H("D@7`H)("`@("`@("`F)B![
M(&EF('1E<W0@+68@)$`[('1H96X@97AI="`P.R!E;'-E(&)R96%K.R!F:3L@
M?3L@7`H)("`@("`@97AI="`Q.SL@7`H)("!E<V%C.R!<"@ED;VYE.R!<"@EE
M8VAO("<@8V0@)"AT;W!?<W)C9&ER*2`F)B`D*$%55$]-04M%*2`M+69O<F5I
M9VX@+2UI9VYO<F4M9&5P<R!P>71H;VXO36%K969I;&4G.R!<"@DD*&%M7U]C
M9"D@)"AT;W!?<W)C9&ER*2`F)B!<"@D@("0H05543TU!2T4I("TM9F]R96EG
M;B`M+6EG;F]R92UD97!S('!Y=&AO;B]-86ME9FEL90I-86ME9FEL93H@)"AS
M<F-D:7(I+TUA:V5F:6QE+FEN("0H=&]P7V)U:6QD9&ER*2]C;VYF:6<N<W1A
M='5S"@E`8V%S92`G)#\G(&EN(%P*"2`@*F-O;F9I9RYS=&%T=7,J*2!<"@D@
M("`@8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H34%+12D@)"A!35]-04M%1DQ!
M1U,I(&%M+2UR969R97-H.SL@7`H)("`J*2!<"@D@("`@96-H;R`G(&-D("0H
M=&]P7V)U:6QD9&ER*2`F)B`D*%-(14Q,*2`N+V-O;F9I9RYS=&%T=7,@)"AS
M=6)D:7(I+R1`("0H86U?7V1E<&9I;&5S7VUA>6)E*2<[(%P*"2`@("!C9"`D
M*'1O<%]B=6EL9&1I<BD@)B8@)"A32$5,3"D@+B]C;VYF:6<N<W1A='5S("0H
M<W5B9&ER*2\D0"`D*&%M7U]D97!F:6QE<U]M87EB92D[.R!<"@EE<V%C.PHD
M*'1O<%]S<F-D:7(I+V9R86=M96YT+F%M("0H86U?7V5M<'1Y*3H*"B0H=&]P
M7V)U:6QD9&ER*2]C;VYF:6<N<W1A='5S.B`D*'1O<%]S<F-D:7(I+V-O;F9I
M9W5R92`D*$-/3D9)1U]35$%455-?1$5014Y$14Y#2453*0H)8V0@)"AT;W!?
M8G5I;&1D:7(I("8F("0H34%+12D@)"A!35]-04M%1DQ!1U,I(&%M+2UR969R
M97-H"@HD*'1O<%]S<F-D:7(I+V-O;F9I9W5R93H@0$U!24Y404E.15)?34]$
M15]44E5%0"`D*&%M7U]C;VYF:6=U<F5?9&5P<RD*"6-D("0H=&]P7V)U:6QD
M9&ER*2`F)B`D*$U!2T4I("0H04U?34%+149,04=3*2!A;2TM<F5F<F5S:`HD
M*$%#3$]#04Q?330I.B!`34%)3E1!24Y%4E]-3T1%7U12545`("0H86U?7V%C
M;&]C86Q?;31?9&5P<RD*"6-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*$U!2T4I
M("0H04U?34%+149,04=3*2!A;2TM<F5F<F5S:`HD*&%M7U]A8VQO8V%L7VTT
M7V1E<',I.@H*;6]S=&QY8VQE86XM;&EB=&]O;#H*"2UR;2`M9B`J+FQO"@IC
M;&5A;BUL:6)T;V]L.@H)+7)M("UR9B`N;&EB<R!?;&EB<PII;G-T86QL+6YO
M8F%S95]P>71H;VY$051!.B`D*&YO8F%S95]P>71H;VY?1$%402D*"4`D*$Y/
M4DU!3%])3E-404Q,*0H)0&QI<W0])R0H;F]B87-E7W!Y=&AO;E]$051!*2<[
M('1E<W0@+6X@(B0H<'ET:&]N9&ER*2(@?'P@;&ES=#T[(%P*"6EF('1E<W0@
M+6X@(B0D;&ES="([('1H96X@7`H)("!E8VAO("(@)"A-2T1)4E]0*2`G)"A$
M15-41$E2*20H<'ET:&]N9&ER*2<B.R!<"@D@("0H34M$25)?4"D@(B0H1$53
M5$1)4BDD*'!Y=&AO;F1I<BDB('Q\(&5X:70@,3L@7`H)9FD[(%P*"20H86U?
M7VYO8F%S95]L:7-T*2!\('=H:6QE(')E860@9&ER(&9I;&5S.R!D;R!<"@D@
M('AF:6QE<ST[(&9O<B!F:6QE(&EN("0D9FEL97,[(&1O(%P*"2`@("!I9B!T
M97-T("UF("(D)&9I;&4B.R!T:&5N('AF:6QE<STB)"1X9FEL97,@)"1F:6QE
M(CL@7`H)("`@(&5L<V4@>&9I;&5S/2(D)'AF:6QE<R`D*'-R8V1I<BDO)"1F
M:6QE(CL@9FD[(&1O;F4[(%P*"2`@=&5S="`M>B`B)"1X9FEL97,B('Q\('L@
M7`H)("`@('1E<W0@(G@D)&1I<B(@/2!X+B!\?"![(%P*"2`@("`@(&5C:&\@
M(B`D*$U+1$E27U`I("<D*$1%4U1$25(I)"AP>71H;VYD:7(I+R0D9&ER)R([
M(%P*"2`@("`@("0H34M$25)?4"D@(B0H1$535$1)4BDD*'!Y=&AO;F1I<BDO
M)"1D:7(B.R!].R!<"@D@("`@96-H;R`B("0H24Y35$%,3%]$051!*2`D)'AF
M:6QE<R`G)"A$15-41$E2*20H<'ET:&]N9&ER*2\D)&1I<B<B.R!<"@D@("`@
M)"A)3E-404Q,7T1!5$$I("0D>&9I;&5S("(D*$1%4U1$25(I)"AP>71H;VYD
M:7(I+R0D9&ER(B!\?"!E>&ET("0D/SL@?3L@7`H)9&]N90H*=6YI;G-T86QL
M+6YO8F%S95]P>71H;VY$051!.@H)0"0H3D]234%,7U5.24Y35$%,3"D*"4!L
M:7-T/2<D*&YO8F%S95]P>71H;VY?1$%402DG.R!T97-T("UN("(D*'!Y=&AO
M;F1I<BDB('Q\(&QI<W0].R!<"@DD*&%M7U]N;V)A<V5?<W1R:7!?<V5T=7`I
M.R!F:6QE<SU@)"AA;5]?;F]B87-E7W-T<FEP*6`[(%P*"61I<CTG)"A$15-4
M1$E2*20H<'ET:&]N9&ER*2<[("0H86U?7W5N:6YS=&%L;%]F:6QE<U]F<F]M
M7V1I<BD*=&%G<R!404=3.@H*8W1A9W,@0U1!1U,Z"@IC<V-O<&4@8W-C;W!E
M;&ES=#H*"F-H96-K+6%M.B!A;&PM86T*8VAE8VLZ(&-H96-K+6%M"F%L;"UA
M;3H@36%K969I;&4@)"A$051!*2!A;&PM;&]C86P*:6YS=&%L;&1I<G,Z"@EF
M;W(@9&ER(&EN("(D*$1%4U1$25(I)"AP>71H;VYD:7(I(CL@9&\@7`H)("!T
M97-T("UZ("(D)&1I<B(@?'P@)"A-2T1)4E]0*2`B)"1D:7(B.R!<"@ED;VYE
M"FEN<W1A;&PZ(&EN<W1A;&PM86T*:6YS=&%L;"UE>&5C.B!I;G-T86QL+65X
M96,M86T*:6YS=&%L;"UD871A.B!I;G-T86QL+61A=&$M86T*=6YI;G-T86QL
M.B!U;FEN<W1A;&PM86T*"FEN<W1A;&PM86TZ(&%L;"UA;0H)0"0H34%+12D@
M)"A!35]-04M%1DQ!1U,I(&EN<W1A;&PM97AE8RUA;2!I;G-T86QL+61A=&$M
M86T*"FEN<W1A;&QC:&5C:SH@:6YS=&%L;&-H96-K+6%M"FEN<W1A;&PM<W1R
M:7`Z"@EI9B!T97-T("UZ("<D*%-44DE0*2<[('1H96X@7`H)("`D*$U!2T4I
M("0H04U?34%+149,04=3*2!)3E-404Q,7U!23T=204T](B0H24Y35$%,3%]3
M5%))4%]04D]'4D%-*2(@7`H)("`@(&EN<W1A;&Q?<VA?4%)/1U)!33TB)"A)
M3E-404Q,7U-44DE07U!23T=204TI(B!)3E-404Q,7U-44DE07T9,04<]+7,@
M7`H)("`@("`@:6YS=&%L;#L@7`H)96QS92!<"@D@("0H34%+12D@)"A!35]-
M04M%1DQ!1U,I($E.4U1!3$Q?4%)/1U)!33TB)"A)3E-404Q,7U-44DE07U!2
M3T=204TI(B!<"@D@("`@:6YS=&%L;%]S:%]04D]'4D%-/2(D*$E.4U1!3$Q?
M4U1225!?4%)/1U)!32DB($E.4U1!3$Q?4U1225!?1DQ!1STM<R!<"@D@("`@
M(DE.4U1!3$Q?4%)/1U)!35]%3E8]4U1225!04D]'/2<D*%-44DE0*2<B(&EN
M<W1A;&P[(%P*"69I"FUO<W1L>6-L96%N+6=E;F5R:6,Z"@IC;&5A;BUG96YE
M<FEC.@H*9&ES=&-L96%N+6=E;F5R:6,Z"@DM=&5S="`M>B`B)"A#3TY&24=?
M0TQ%04Y?1DE,15,I(B!\?"!R;2`M9B`D*$-/3D9)1U]#3$5!3E]&24Q%4RD*
M"2UT97-T("X@/2`B)"AS<F-D:7(I(B!\?"!T97-T("UZ("(D*$-/3D9)1U]#
M3$5!3E]64$%42%]&24Q%4RDB('Q\(')M("UF("0H0T].1DE'7T-,14%.7U90
M051(7T9)3$53*0H*;6%I;G1A:6YE<BUC;&5A;BUG96YE<FEC.@H)0&5C:&\@
M(E1H:7,@8V]M;6%N9"!I<R!I;G1E;F1E9"!F;W(@;6%I;G1A:6YE<G,@=&\@
M=7-E(@H)0&5C:&\@(FET(&1E;&5T97,@9FEL97,@=&AA="!M87D@<F5Q=6ER
M92!S<&5C:6%L('1O;VQS('1O(')E8G5I;&0N(@IC;&5A;CH@8VQE86XM86T*
M"F-L96%N+6%M.B!C;&5A;BUG96YE<FEC(&-L96%N+6QI8G1O;VP@;6]S=&QY
M8VQE86XM86T*"F1I<W1C;&5A;CH@9&ES=&-L96%N+6%M"@DM<FT@+68@36%K
M969I;&4*9&ES=&-L96%N+6%M.B!C;&5A;BUA;2!D:7-T8VQE86XM9V5N97)I
M8PH*9'9I.B!D=FDM86T*"F1V:2UA;3H*"FAT;6PZ(&AT;6PM86T*"FAT;6PM
M86TZ"@II;F9O.B!I;F9O+6%M"@II;F9O+6%M.@H*:6YS=&%L;"UD871A+6%M
M.B!I;G-T86QL+61A=&$M;&]C86P@:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%4
M00H*:6YS=&%L;"UD=FDZ(&EN<W1A;&PM9'9I+6%M"@II;G-T86QL+61V:2UA
M;3H*"FEN<W1A;&PM97AE8RUA;3H*"FEN<W1A;&PM:'1M;#H@:6YS=&%L;"UH
M=&UL+6%M"@II;G-T86QL+6AT;6PM86TZ"@II;G-T86QL+6EN9F\Z(&EN<W1A
M;&PM:6YF;RUA;0H*:6YS=&%L;"UI;F9O+6%M.@H*:6YS=&%L;"UM86XZ"@II
M;G-T86QL+7!D9CH@:6YS=&%L;"UP9&8M86T*"FEN<W1A;&PM<&1F+6%M.@H*
M:6YS=&%L;"UP<SH@:6YS=&%L;"UP<RUA;0H*:6YS=&%L;"UP<RUA;3H*"FEN
M<W1A;&QC:&5C:RUA;3H*"FUA:6YT86EN97(M8VQE86XZ(&UA:6YT86EN97(M
M8VQE86XM86T*"2UR;2`M9B!-86ME9FEL90IM86EN=&%I;F5R+6-L96%N+6%M
M.B!D:7-T8VQE86XM86T@;6%I;G1A:6YE<BUC;&5A;BUG96YE<FEC"@IM;W-T
M;'EC;&5A;CH@;6]S=&QY8VQE86XM86T*"FUO<W1L>6-L96%N+6%M.B!M;W-T
M;'EC;&5A;BUG96YE<FEC(&UO<W1L>6-L96%N+6QI8G1O;VP*"G!D9CH@<&1F
M+6%M"@IP9&8M86TZ"@IP<SH@<',M86T*"G!S+6%M.@H*=6YI;G-T86QL+6%M
M.B!U;FEN<W1A;&PM;F]B87-E7W!Y=&AO;D1!5$$*"BY-04M%.B!I;G-T86QL
M+6%M(&EN<W1A;&PM<W1R:7`*"BY02$].63H@86QL(&%L;"UA;2!A;&PM;&]C
M86P@8VAE8VL@8VAE8VLM86T@8VQE86X@8VQE86XM9V5N97)I8R!<"@EC;&5A
M;BUL:6)T;V]L(&-S8V]P96QI<W0M86T@8W1A9W,M86T@9&ES=&-L96%N(%P*
M"61I<W1C;&5A;BUG96YE<FEC(&1I<W1C;&5A;BUL:6)T;V]L(&1V:2!D=FDM
M86T@:'1M;"!H=&UL+6%M(%P*"6EN9F\@:6YF;RUA;2!I;G-T86QL(&EN<W1A
M;&PM86T@:6YS=&%L;"UD871A(&EN<W1A;&PM9&%T82UA;2!<"@EI;G-T86QL
M+61A=&$M;&]C86P@:6YS=&%L;"UD=FD@:6YS=&%L;"UD=FDM86T@:6YS=&%L
M;"UE>&5C(%P*"6EN<W1A;&PM97AE8RUA;2!I;G-T86QL+6AT;6P@:6YS=&%L
M;"UH=&UL+6%M(&EN<W1A;&PM:6YF;R!<"@EI;G-T86QL+6EN9F\M86T@:6YS
M=&%L;"UM86X@:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%402!<"@EI;G-T86QL
M+7!D9B!I;G-T86QL+7!D9BUA;2!I;G-T86QL+7!S(&EN<W1A;&PM<',M86T@
M7`H):6YS=&%L;"US=')I<"!I;G-T86QL8VAE8VL@:6YS=&%L;&-H96-K+6%M
M(&EN<W1A;&QD:7)S(%P*"6UA:6YT86EN97(M8VQE86X@;6%I;G1A:6YE<BUC
M;&5A;BUG96YE<FEC(&UO<W1L>6-L96%N(%P*"6UO<W1L>6-L96%N+6=E;F5R
M:6,@;6]S=&QY8VQE86XM;&EB=&]O;"!P9&8@<&1F+6%M('!S('!S+6%M(%P*
M"71A9W,M86T@=6YI;G-T86QL('5N:6YS=&%L;"UA;2!U;FEN<W1A;&PM;F]B
M87-E7W!Y=&AO;D1!5$$*"BY04D5#24]54SH@36%K969I;&4*"@IA;&PM;&]C
M86PZ(&=D8BYP>0H*9V1B+G!Y.B!H;V]K+FEN($UA:V5F:6QE"@ES960@+64@
M)W,L0'!Y=&AO;F1I<D`L)"AP>71H;VYD:7(I+"<@7`H)("`@("UE("=S+$!T
M;V]L97AE8VQI8F1I<D`L)"AT;V]L97AE8VQI8F1I<BDL)R`\("0H<W)C9&ER
M*2]H;V]K+FEN(#X@)$`*"FEN<W1A;&PM9&%T82UL;V-A;#H@9V1B+G!Y"@E`
M)"AM:V1I<E]P*2`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BD*"4!H97)E
M/6!P=V1@.R!C9"`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BD[(%P*"2`@
M9F]R(&9I;&4@:6X@;&EB<W1D8RLK+BH[(&1O(%P*"2`@("!C87-E("0D9FEL
M92!I;B!<"@D@("`@("`J+6=D8BYP>2D@.SL@7`H)("`@("`@*BYL82D@.SL@
M7`H)("`@("`@*BD@:68@=&5S="`M:"`D)&9I;&4[('1H96X@7`H)("`@("`@
M("`@("!C;VYT:6YU93L@7`H)("`@("`@("`@9FD[(%P*"2`@("`@("`@(&QI
M8FYA;64])"1F:6QE.SL@7`H)("`@(&5S86,[(%P*"2`@9&]N93L@7`H)8V0@
M)"1H97)E.R!<"@EE8VAO("(@)"A)3E-404Q,7T1!5$$I(&=D8BYP>2`D*$1%
M4U1$25(I)"AT;V]L97AE8VQI8F1I<BDO)"1L:6)N86UE+6=D8BYP>2([(%P*
M"20H24Y35$%,3%]$051!*2!G9&(N<'D@)"A$15-41$E2*20H=&]O;&5X96-L
M:6)D:7(I+R0D;&EB;F%M92UG9&(N<'D*"B,@5&5L;"!V97)S:6]N<R!;,RXU
M.2PS+C8S*2!O9B!'3E4@;6%K92!T;R!N;W0@97AP;W)T(&%L;"!V87)I86)L
M97,N"B,@3W1H97)W:7-E(&$@<WES=&5M(&QI;6ET("AF;W(@4WES5B!A="!L
M96%S="D@;6%Y(&)E(&5X8V5E9&5D+@HN3D]%6%!/4E0Z"@``````````````
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
  (set 20 19 06 05 22 09 43 'share-gdb.tar'
   eval "${shar_touch}") && \
  chmod 0644 'share-gdb.tar'
if test $? -ne 0
then ${echo} "restore of share-gdb.tar failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'share-gdb.tar': 'MD5 check failed'
       ) << \SHAR_EOF
dc7ddbc69bab819d4c8d6ddb4b256c1c  share-gdb.tar
SHAR_EOF

else
test `LC_ALL=C wc -c < 'share-gdb.tar'` -ne 143360 && \
  ${echo} "restoration warning:  size of 'share-gdb.tar' is not 143360"
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
  (set 20 19 06 05 22 09 43 'apt-cyg'
   eval "${shar_touch}") && \
  chmod 0755 'apt-cyg'
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
X.\" Automatically generated by Pod::Man 4.09 (Pod::Simple 3.35)
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
X.if !\nF .nr F 0
X.if \nF>0 \{\
X.    de IX
X.    tm Index:\\$1\t\\n%\t"\\$2"
X..
X.    if !\nF==2 \{\
X.        nr % 0
X.        nr F 2
X.    \}
X.\}
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
X.TH BYZANZ-HELPER 1 "2018-04-03" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
\&\fIbyzanz\-record\fR\|(1), \fIbyzanz\-playback\fR\|(1), \fIxwininfo\fR\|(1)
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
  (set 20 19 06 05 22 09 44 'byzanz-helper.1'
   eval "${shar_touch}") && \
  chmod 0644 'byzanz-helper.1'
if test $? -ne 0
then ${echo} "restore of byzanz-helper.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'byzanz-helper.1': 'MD5 check failed'
       ) << \SHAR_EOF
02449e6a54af42324394655b8bb51369  byzanz-helper.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'byzanz-helper.1'` -ne 5665 && \
  ${echo} "restoration warning:  size of 'byzanz-helper.1' is not 5665"
  fi
fi
# ============= ffmpeg-helper.1 ==============
if test -n "${keep_file}" && test -f 'ffmpeg-helper.1'
then
${echo} "x - SKIPPING ffmpeg-helper.1 (file already exists)"

else
${echo} "x - extracting ffmpeg-helper.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'ffmpeg-helper.1' &&
X.\" Automatically generated by Pod::Man 4.09 (Pod::Simple 3.35)
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
X.if !\nF .nr F 0
X.if \nF>0 \{\
X.    de IX
X.    tm Index:\\$1\t\\n%\t"\\$2"
X..
X.    if !\nF==2 \{\
X.        nr % 0
X.        nr F 2
X.    \}
X.\}
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
X.TH FFMPEG-HELPER 1 "2018-04-03" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
\&\fIffmpeg\fR\|(1), \fIxwininfo\fR\|(1)
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
  (set 20 19 06 05 22 09 44 'ffmpeg-helper.1'
   eval "${shar_touch}") && \
  chmod 0644 'ffmpeg-helper.1'
if test $? -ne 0
then ${echo} "restore of ffmpeg-helper.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'ffmpeg-helper.1': 'MD5 check failed'
       ) << \SHAR_EOF
c52e9378db97901eb277f512e84a2e0b  ffmpeg-helper.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'ffmpeg-helper.1'` -ne 5621 && \
  ${echo} "restoration warning:  size of 'ffmpeg-helper.1' is not 5621"
  fi
fi
# ============= hyper-v.1 ==============
if test -n "${keep_file}" && test -f 'hyper-v.1'
then
${echo} "x - SKIPPING hyper-v.1 (file already exists)"

else
${echo} "x - extracting hyper-v.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'hyper-v.1' &&
X.\" Automatically generated by Pod::Man 4.09 (Pod::Simple 3.35)
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
X.if !\nF .nr F 0
X.if \nF>0 \{\
X.    de IX
X.    tm Index:\\$1\t\\n%\t"\\$2"
X..
X.    if !\nF==2 \{\
X.        nr % 0
X.        nr F 2
X.    \}
X.\}
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
X.TH HYPER-V 1 "2018-09-02" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 06 05 22 09 44 'hyper-v.1'
   eval "${shar_touch}") && \
  chmod 0644 'hyper-v.1'
if test $? -ne 0
then ${echo} "restore of hyper-v.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'hyper-v.1': 'MD5 check failed'
       ) << \SHAR_EOF
a352260862a2e69e73b17e99e9625943  hyper-v.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'hyper-v.1'` -ne 5039 && \
  ${echo} "restoration warning:  size of 'hyper-v.1' is not 5039"
  fi
fi
# ============= msvc-shell.1 ==============
if test -n "${keep_file}" && test -f 'msvc-shell.1'
then
${echo} "x - SKIPPING msvc-shell.1 (file already exists)"

else
${echo} "x - extracting msvc-shell.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'msvc-shell.1' &&
X.\" Automatically generated by Pod::Man 4.09 (Pod::Simple 3.35)
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
X.if !\nF .nr F 0
X.if \nF>0 \{\
X.    de IX
X.    tm Index:\\$1\t\\n%\t"\\$2"
X..
X.    if !\nF==2 \{\
X.        nr % 0
X.        nr F 2
X.    \}
X.\}
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
X.TH MSVC-SHELL 1 "2018-09-26" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 06 05 22 09 45 'msvc-shell.1'
   eval "${shar_touch}") && \
  chmod 0644 'msvc-shell.1'
if test $? -ne 0
then ${echo} "restore of msvc-shell.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'msvc-shell.1': 'MD5 check failed'
       ) << \SHAR_EOF
1696cb53eeb5eab916c154f36475082f  msvc-shell.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'msvc-shell.1'` -ne 5825 && \
  ${echo} "restoration warning:  size of 'msvc-shell.1' is not 5825"
  fi
fi
# ============= sixel2tmux.1 ==============
if test -n "${keep_file}" && test -f 'sixel2tmux.1'
then
${echo} "x - SKIPPING sixel2tmux.1 (file already exists)"

else
${echo} "x - extracting sixel2tmux.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'sixel2tmux.1' &&
X.\" Automatically generated by Pod::Man 4.09 (Pod::Simple 3.35)
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
X.if !\nF .nr F 0
X.if \nF>0 \{\
X.    de IX
X.    tm Index:\\$1\t\\n%\t"\\$2"
X..
X.    if !\nF==2 \{\
X.        nr % 0
X.        nr F 2
X.    \}
X.\}
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
X.TH SIXEL2TMUX 1 "2018-11-07" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
\&\fIxterm\fR\|(1), \fItmux\fR\|(1)
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
  (set 20 19 06 05 22 09 45 'sixel2tmux.1'
   eval "${shar_touch}") && \
  chmod 0644 'sixel2tmux.1'
if test $? -ne 0
then ${echo} "restore of sixel2tmux.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'sixel2tmux.1': 'MD5 check failed'
       ) << \SHAR_EOF
52bb0f5afcc9dbc669874b56cd7c2103  sixel2tmux.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'sixel2tmux.1'` -ne 6420 && \
  ${echo} "restoration warning:  size of 'sixel2tmux.1' is not 6420"
  fi
fi
# ============= yank.1 ==============
if test -n "${keep_file}" && test -f 'yank.1'
then
${echo} "x - SKIPPING yank.1 (file already exists)"

else
${echo} "x - extracting yank.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'yank.1' &&
X.\" Automatically generated by Pod::Man 4.09 (Pod::Simple 3.35)
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
X.if !\nF .nr F 0
X.if \nF>0 \{\
X.    de IX
X.    tm Index:\\$1\t\\n%\t"\\$2"
X..
X.    if !\nF==2 \{\
X.        nr % 0
X.        nr F 2
X.    \}
X.\}
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
X.TH YANK 1 "2018-04-01" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
\&\fIxterm\fR\|(1), \fItmux\fR\|(1)
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
  (set 20 19 06 05 22 09 46 'yank.1'
   eval "${shar_touch}") && \
  chmod 0644 'yank.1'
if test $? -ne 0
then ${echo} "restore of yank.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'yank.1': 'MD5 check failed'
       ) << \SHAR_EOF
5b4e03faee62735be16fa96307b62c32  yank.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'yank.1'` -ne 7103 && \
  ${echo} "restoration warning:  size of 'yank.1' is not 7103"
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


# Prepare backups directory
DATE=$(date '+%Y%m%d')
HOUR=$(date '+%H%M%S')
BACKUPDIR="${HOME}/.backups/${DATE}/${HOUR}"
install -m 0700 -d "${BACKUPDIR}"

# Backup files
echo "shell ..."
if [ -e ~/.profile ]; then
    cp -f ~/.profile "${BACKUPDIR}"
fi
if [ -e ~/.bash_profile ]; then
    cp -f ~/.bash_profile "${BACKUPDIR}"
fi
if [ -e ~/.bashrc ]; then
    cp -f ~/.bashrc "${BACKUPDIR}"
fi
if [ ! -e ~/.path_dirs ]; then
    cat <<DOT_PROFILE_PATHS_EOF > ~/.path_dirs
# Directory path in this file are scanned by .bash_profile
# to setup the following variables:
#  - PATH
#  - LD_LIBRARY_PATH
#  - MANPATH
#  - INFOPATH
#  - PERL5LIB
#  - PKG_CONFIG_PATH

${HOME}/.local
${HOME}/.local/share/perl5
DOT_PROFILE_PATHS_EOF
fi
install -m 0644 dot_profile      ~/.profile
install -m 0644 dot_bash_profile ~/.bash_profile
install -m 0644 dot_bashrc       ~/.bashrc

# .local setup
echo "local ..."
install -m 0755 -d ~/.local/bin
install -m 0755 -d ~/.local/lib
install -m 0755 -d ~/.local/share
install -m 0755 -d ~/.local/share/man/man1
install -m 0755 -d ~/.local/var
install -m 0755 -d ~/.local/var/lock
install -m 0755 -d ~/.local/var/log
install -m 0755 -d ~/.local/var/run
install -m 0755 -d ~/.local/etc/cron
install -m 0755 -d ~/.local/etc/profile.d
install -m 0755 runcron ~/.local/bin
export PATH="${PATH}:~/.local/bin"

# Cron setup
echo "cron ..."
if has_prog crontab; then
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

# iMatix environment
install -m 0644 ibase.sh ~/.local/etc/profile.d

# Cygwin
if [[ "${os_name}" == CYGWIN* ]]; then
    echo "Cygwin ..."
    if [ -e ~/.XWinrc ]; then
        cp -f ~/.XWinrc "${BACKUPDIR}"
    fi
    install -m 0644 dot_XWinrc ~/.XWinrc
    install -m 0755 hyper-v ~/.local/bin
    install -m 0644 hyper-v.1 ~/.local/share/man/man1
    install -m 0755 msvc-shell ~/.local/bin
    install -m 0644 msvc-shell.1 ~/.local/share/man/man1
    install -m 0755 apt-cyg ~/.local/bin
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

# XWindow
if has_prog xterm; then
    echo "XWindow ..."
    if [ -e ~/.Xresources ]; then
        cp -f ~/.Xresources "${BACKUPDIR}"
    fi
    install -m 0644 dot_Xresources ~/.Xresources

    # Fonts
    echo "nerd fonts ..."
    install -d ~/.fonts
    install -d ~/.local/share/fonts
    if has_prog fc-cache; then
        if [ ! -d ~/.local/share/fonts/nerd-fonts ]; then
            install -d ~/.local/share/fonts/nerd-fonts
            curl -O 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/2.0.0/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf' \
                > install.log 2>&1
            mv 'DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf' 'DejaVu Sans Mono Nerd Font Complete.ttf'
            install -m 0644 'DejaVu Sans Mono Nerd Font Complete.ttf' ~/.local/share/fonts/nerd-fonts/
            fc-cache -f ~/.local/share/fonts
        fi
    fi
fi

# vim
echo "vim ..."
if [ -e ~/.vimrc ]; then
    cp -f ~/.vimrc "${BACKUPDIR}"
fi
if [ ! -e ~/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
install -m 0644 dot_vimrc ~/.vimrc
vim +PlugInstall +qall

# tmux
echo "tmux ..."
if [ -e ~/.tmux.conf ]; then
    cp -f ~/.tmux.conf "${BACKUPDIR}"
fi
install -m 0644 dot_tmux_conf ~/.tmux.conf
install -m 0755 yank ~/.local/bin
install -m 0644 yank.1 ~/.local/share/man/man1

echo "terminfo ..."
if has_prog tic; then
    has_tmux256_terminfo=""
    if [ -e /lib/terminfo/t/tmux-256color ]; then
        has_tmux256_terminfo="y"
    fi
    if [ -e /usr/share/terminfo/t/tmux-256color ]; then
        has_tmux256_terminfo="y"
    fi
    if [ -e ~/.terminfo/t/tmux-256color ]; then
        has_tmux256_terminfo="y"
    fi
    if [ -z "${has_tmux256_terminfo}" ]; then
        mkdir -p ~/.terminfo
        tic -o ~/.terminfo tmux-256color.tinfo
    fi
fi

# Perl
echo "Perl ..."
if [ ! -e ~/.local/share/perl5 ]; then
    perl_local_lib=local-lib-2.000023
    curl -O "http://www.cpan.org/authors/id/H/HA/HAARG/${perl_local_lib}.tar.gz"
    tar zxvf "${perl_local_lib}.tar.gz"
    cd  "${perl_local_lib}"
    perl Makefile.PL "--bootstrap=${HOME}/.local/share/perl5" > install.log 2>&1
    make test > install.log 2>&1 && make install > install.log 2>&1
    cd ..
    perl "-I${HOME}/.local/share/perl5/lib/perl5" "-Mlocal::lib=${HOME}/.local/share/perl5" \
        > ~/.local/etc/profile.d/perl5.sh
    . ~/.local/etc/profile.d/perl5.sh
fi

# Sixel tools
install -m 0755 sixel2tmux ~/.local/bin
install -m 0644 sixel2tmux.1 ~/.local/share/man/man1

# Screencast tools
install -m 0755 byzanz-helper ~/.local/bin
install -m 0644 byzanz-helper.1 ~/.local/share/man/man1
install -m 0755 ffmpeg-helper ~/.local/bin
install -m 0644 ffmpeg-helper.1 ~/.local/share/man/man1

# Autoconf cache
echo "Autoconf cache ..."
if [ ! -e ~/.local/etc/config.site ]; then
    cp config.site ~/.local/etc/config.site
fi

# Gdb pretty printers
if [ ! -e ~/.local/share/gdb ]; then
    mkdir -p ~/.local/share/gdb
    tar xvf share-gdb.tar -C ~/.local/share/gdb
    cp -f ~/.gdbinit "${BACKUPDIR}"
    cp dot_gdbinit ~/.gdbinit
fi

# Gnulib
echo "Gnulib ..."
if ! has_prog gnulib-tool; then
    if [ ! -e ~/.local/share/gnulib ]; then
        git clone git://git.savannah.gnu.org/gnulib.git ~/.local/share/gnulib > install.log 2>&1
    fi
    ln -s ~/.local/share/gnulib/gnulib-tool ~/.local/bin/gnulib-tool
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

