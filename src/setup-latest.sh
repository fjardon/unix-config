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
lock_dir=_sh00699
# Made on 2019-04-07 13:29 CEST by <frede@darthvader>.
# Source directory was '/home/frede/Documents/workspace/github/unix-config/src'.
#
# Existing files will *not* be overwritten, unless '-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#    439 -rw-r--r-- config.site
#    455 -rw-r--r-- dot_bash_profile
#   3087 -rw-r--r-- dot_bashrc
#    214 -rw-r--r-- dot_gdbinit
#   2479 -rw-r--r-- dot_profile
#   3140 -rw-r--r-- dot_tmux_conf
#   4125 -rw-r--r-- dot_vimrc
#    922 -rw-r--r-- dot_Xresources
#   4076 -rw-r--r-- dot_XWinrc
#   2541 -rwxr-xr-x byzanz-helper
#   3766 -rwxr-xr-x ffmpeg-helper
#   1820 -rwxr-xr-x hyper-v
#   5848 -rwxr-xr-x msvc-shell
#   3591 -rw-r--r-- sixel2tmux
#   4128 -rwxr-xr-x yank
#   2836 -rw-r--r-- tmux-256color.tinfo
#    901 -rwxr-xr-x runcron
# 133120 -rw-r--r-- share-gdb.tar
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
X  cache_file="${prefix}/var/${CC}-config.cache"
fi
X
SHAR_EOF
  (set 20 18 11 07 20 09 15 'config.site'
   eval "${shar_touch}") && \
  chmod 0644 'config.site'
if test $? -ne 0
then ${echo} "restore of config.site failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'config.site': 'MD5 check failed'
       ) << \SHAR_EOF
9a31f4ee2391cf018c040cffeb71bc3a  config.site
SHAR_EOF

else
test `LC_ALL=C wc -c < 'config.site'` -ne 439 && \
  ${echo} "restoration warning:  size of 'config.site' is not 439"
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
X        DEFAULT_FG=$(tput setaf $(expr ${NCOLORS} + 1))
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
PS1="${SETXTERMTITLE}${VIM_LED}${VS_LED}${GREEN_FG}\\u@\\h ${MAGENTA_FG}\\t ${YELLOW_FG}\\w${WHITE_FG}\n\$ "
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
  (set 20 18 02 01 18 48 58 'dot_bashrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_bashrc'
if test $? -ne 0
then ${echo} "restore of dot_bashrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_bashrc': 'MD5 check failed'
       ) << \SHAR_EOF
1dea44e461421fa564278faf53da91ea  dot_bashrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_bashrc'` -ne 3087 && \
  ${echo} "restoration warning:  size of 'dot_bashrc' is not 3087"
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
M`#$S-#4R,S4W-#0W`#`Q,#(P,P`@-0``````````````````````````````
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
M,#$W-3$`,#`P,#`P,#`P,#``,3,T-3(S-3<T-3$`,#$Q-3$W`"`U````````
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
M,#`P-C0T`#`V,#$W-3$`,#8P,3<U,0`P,#`P,#`P-#4P,``Q,S0U,C,U-S0U
M,0`P,3,P,#8`(#``````````````````````````````````````````````
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
M,``Q,S0U,C,U-S0U,0`P,3,U,C,`(#4`````````````````````````````
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
M-C`Q-S4Q`#`P,#`P,#`P,#`P`#$S-#4R,S4W-#4Q`#`Q-#`U-@`@-0``````
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
M,#`P,#8T-``P-C`Q-S4Q`#`V,#$W-3$`,#`P,#`R,3,S,S8`,3,T-3(S-3<T
M-3$`,#$V,S`V`"`P````````````````````````````````````````````
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
M,%TN='EP92YT86<*("`@("`@("!I9B!I<U]S<&5C:6%L:7IA=&EO;E]O9BAI
M;7!L7W1Y<&4L("=?7W5N:7%?<'1R7VEM<&PG*3H@(R!.97<@:6UP;&5M96YT
M871I;VX*("`@("`@("`@("`@<V5L9BYP;VEN=&5R(#T@=F%L6R=?35]T)UU;
M)U]-7W0G75LG7TU?:&5A9%]I;7!L)UT*("`@("`@("!E;&EF(&ES7W-P96-I
M86QI>F%T:6]N7V]F*&EM<&Q?='EP92P@)W1U<&QE)RDZ"B`@("`@("`@("`@
M('-E;&8N<&]I;G1E<B`]('9A;%LG7TU?="==6R=?35]H96%D7VEM<&PG70H@
M("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')A:7-E(%9A;'5E17)R;W(H(E5N
M<W5P<&]R=&5D(&EM<&QE;65N=&%T:6]N(&9O<B!U;FEQ=65?<'1R.B`E<R(@
M)2!I;7!L7W1Y<&4I"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@
M("!R971U<FX@4VUA<G10='))=&5R871O<BAS96QF+G!O:6YT97(I"@H@("`@
M9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@<F5T=7)N("@G<W1D.CIU
M;FEQ=65?<'1R/"5S/B<@)2`H<W1R*'-E;&8N=F%L+G1Y<&4N=&5M<&QA=&5?
M87)G=6UE;G0H,"DI*2D*"F1E9B!G971?=F%L=65?9G)O;5]A;&EG;F5D7VUE
M;6)U9BAB=68L('9A;'1Y<&4I.@H@("`@(B(B4F5T=7)N<R!T:&4@=F%L=64@
M:&5L9"!I;B!A(%]?9VYU7V-X>#HZ7U]A;&EG;F5D7VUE;6)U9BXB(B(*("`@
M(')E='5R;B!B=69;)U]-7W-T;W)A9V4G72YA9&1R97-S+F-A<W0H=F%L='EP
M92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*"F1E9B!G971?=F%L=65?9G)O
M;5]L:7-T7VYO9&4H;F]D92DZ"B`@("`B(B)2971U<FYS('1H92!V86QU92!H
M96QD(&EN(&%N(%],:7-T7VYO9&4\7U9A;#XB(B(*("`@('1R>3H*("`@("`@
M("!M96UB97(@/2!N;V1E+G1Y<&4N9FEE;&1S*"E;,5TN;F%M90H@("`@("`@
M(&EF(&UE;6)E<B`]/2`G7TU?9&%T82<Z"B`@("`@("`@("`@(",@0RLK,#,@
M:6UP;&5M96YT871I;VXL(&YO9&4@8V]N=&%I;G,@=&AE('9A;'5E(&%S(&$@
M;65M8F5R"B`@("`@("`@("`@(')E='5R;B!N;V1E6R=?35]D871A)UT*("`@
M("`@("!E;&EF(&UE;6)E<B`]/2`G7TU?<W1O<F%G92<Z"B`@("`@("`@("`@
M(",@0RLK,3$@:6UP;&5M96YT871I;VXL(&YO9&4@<W1O<F5S('9A;'5E(&EN
M(%]?86QI9VYE9%]M96UB=68*("`@("`@("`@("`@=F%L='EP92`](&YO9&4N
M='EP92YT96UP;&%T95]A<F=U;65N="@P*0H@("`@("`@("`@("!R971U<FX@
M9V5T7W9A;'5E7V9R;VU?86QI9VYE9%]M96UB=68H;F]D95LG7TU?<W1O<F%G
M92==+"!V86QT>7!E*0H@("`@97AC97!T.@H@("`@("`@('!A<W,*("`@(')A
M:7-E(%9A;'5E17)R;W(H(E5N<W5P<&]R=&5D(&EM<&QE;65N=&%T:6]N(&9O
M<B`E<R(@)2!S='(H;F]D92YT>7!E*2D*"F-L87-S(%-T9$QI<W10<FEN=&5R
M.@H@("`@(E!R:6YT(&$@<W1D.CIL:7-T(@H*("`@(&-L87-S(%]I=&5R871O
M<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YO9&5T
M>7!E+"!H96%D*3H*("`@("`@("`@("`@<V5L9BYN;V1E='EP92`](&YO9&5T
M>7!E"B`@("`@("`@("`@('-E;&8N8F%S92`](&AE861;)U]-7VYE>'0G70H@
M("`@("`@("`@("!S96QF+FAE860@/2!H96%D+F%D9')E<W,*("`@("`@("`@
M("`@<V5L9BYC;W5N="`](#`*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I
M.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT
M7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N8F%S92`]/2!S96QF+FAE
M860Z"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@
M("`@("`@(&5L="`]('-E;&8N8F%S92YC87-T*'-E;&8N;F]D971Y<&4I+F1E
M<F5F97)E;F-E*"D*("`@("`@("`@("`@<V5L9BYB87-E(#T@96QT6R=?35]N
M97AT)UT*("`@("`@("`@("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@("`@("`@
M("`@('-E;&8N8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@("`@("!V
M86P@/2!G971?=F%L=65?9G)O;5]L:7-T7VYO9&4H96QT*0H@("`@("`@("`@
M("!R971U<FX@*"=;)61=)R`E(&-O=6YT+"!V86PI"@H@("`@9&5F(%]?:6YI
M=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA
M;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@
M("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@
M("`@("`@(&YO9&5T>7!E(#T@9FEN9%]T>7!E*'-E;&8N=F%L+G1Y<&4L("=?
M3F]D92<I"B`@("`@("`@;F]D971Y<&4@/2!N;V1E='EP92YS=')I<%]T>7!E
M9&5F<R@I+G!O:6YT97(H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R871O
M<BAN;V1E='EP92P@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?;F]D92==*0H*
M("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYV86Q;
M)U]-7VEM<&PG75LG7TU?;F]D92==+F%D9')E<W,@/3T@<V5L9BYV86Q;)U]-
M7VEM<&PG75LG7TU?;F]D92==6R=?35]N97AT)UTZ"B`@("`@("`@("`@(')E
M='5R;B`G96UP='D@)7,G("4@*'-E;&8N='EP96YA;64I"B`@("`@("`@<F5T
M=7)N("<E<R<@)2`H<V5L9BYT>7!E;F%M92D*"F-L87-S($YO9&5)=&5R871O
M<E!R:6YT97(Z"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A
M;"P@8V]N=&YA;64I.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@
M<V5L9BYT>7!E;F%M92`]('1Y<&5N86UE"B`@("`@("`@<V5L9BYC;VYT;F%M
M92`](&-O;G1N86UE"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@
M("!I9B!N;W0@<V5L9BYV86Q;)U]-7VYO9&4G73H*("`@("`@("`@("`@<F5T
M=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.B5S
M)R`E("AS96QF+F-O;G1N86UE*0H@("`@("`@(&YO9&5T>7!E(#T@9FEN9%]T
M>7!E*'-E;&8N=F%L+G1Y<&4L("=?3F]D92<I"B`@("`@("`@;F]D971Y<&4@
M/2!N;V1E='EP92YS=')I<%]T>7!E9&5F<R@I+G!O:6YT97(H*0H@("`@("`@
M(&YO9&4@/2!S96QF+G9A;%LG7TU?;F]D92==+F-A<W0H;F]D971Y<&4I+F1E
M<F5F97)E;F-E*"D*("`@("`@("!R971U<FX@<W1R*&=E=%]V86QU95]F<F]M
M7VQI<W1?;F]D92AN;V1E*2D*"F-L87-S(%-T9$QI<W1)=&5R871O<E!R:6YT
M97(H3F]D94ET97)A=&]R4')I;G1E<BDZ"B`@("`B4')I;G0@<W1D.CIL:7-T
M.CII=&5R871O<B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L
M('9A;"DZ"B`@("`@("`@3F]D94ET97)A=&]R4')I;G1E<BY?7VEN:71?7RAS
M96QF+"!T>7!E;F%M92P@=F%L+"`G;&ES="<I"@IC;&%S<R!3=&1&=V1,:7-T
M271E<F%T;W)0<FEN=&5R*$YO9&5)=&5R871O<E!R:6YT97(I.@H@("`@(E!R
M:6YT('-T9#HZ9F]R=V%R9%]L:7-T.CII=&5R871O<B(*"B`@("!D968@7U]I
M;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@3F]D94ET97)A
M=&]R4')I;G1E<BY?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L+"`G9F]R
M=V%R9%]L:7-T)RD*"F-L87-S(%-T9%-L:7-T4')I;G1E<CH*("`@(")0<FEN
M="!A(%]?9VYU7V-X>#HZ<VQI<W0B"@H@("`@8VQA<W,@7VET97)A=&]R*$ET
M97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@;F]D971Y<&4L
M(&AE860I.@H@("`@("`@("`@("!S96QF+FYO9&5T>7!E(#T@;F]D971Y<&4*
M("`@("`@("`@("`@<V5L9BYB87-E(#T@:&5A9%LG7TU?:&5A9"==6R=?35]N
M97AT)UT*("`@("`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@("`@("`@9&5F
M(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@
M("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N
M8F%S92`]/2`P.@H@("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO
M;@H@("`@("`@("`@("!E;'0@/2!S96QF+F)A<V4N8V%S="AS96QF+FYO9&5T
M>7!E*2YD97)E9F5R96YC92@I"B`@("`@("`@("`@('-E;&8N8F%S92`](&5L
M=%LG7TU?;F5X="=="B`@("`@("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@
M("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@
M("`@("`@<F5T=7)N("@G6R5D72<@)2!C;W5N="P@96QT6R=?35]D871A)UTI
M"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@
M("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I.@H@
M("`@("`@(&YO9&5T>7!E(#T@9FEN9%]T>7!E*'-E;&8N=F%L+G1Y<&4L("=?
M3F]D92<I"B`@("`@("`@;F]D971Y<&4@/2!N;V1E='EP92YS=')I<%]T>7!E
M9&5F<R@I+G!O:6YT97(H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R871O
M<BAN;V1E='EP92P@<V5L9BYV86PI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF
M*3H*("`@("`@("!I9B!S96QF+G9A;%LG7TU?:&5A9"==6R=?35]N97AT)UT@
M/3T@,#H*("`@("`@("`@("`@<F5T=7)N("=E;7!T>2!?7V=N=5]C>'@Z.G-L
M:7-T)PH@("`@("`@(')E='5R;B`G7U]G;G5?8WAX.CIS;&ES="<*"F-L87-S
M(%-T9%-L:7-T271E<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT(%]?9VYU7V-X
M>#HZ<VQI<W0Z.FET97)A=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T
M>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E
M9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@;F]T('-E;&8N=F%L6R=?
M35]N;V1E)UTZ"B`@("`@("`@("`@(')E='5R;B`G;F]N+61E<F5F97)E;F-E
M86)L92!I=&5R871O<B!F;W(@7U]G;G5?8WAX.CIS;&ES="<*("`@("`@("!N
M;V1E='EP92`](&9I;F1?='EP92AS96QF+G9A;"YT>7!E+"`G7TYO9&4G*0H@
M("`@("`@(&YO9&5T>7!E(#T@;F]D971Y<&4N<W1R:7!?='EP961E9G,H*2YP
M;VEN=&5R*"D*("`@("`@("!R971U<FX@<W1R*'-E;&8N=F%L6R=?35]N;V1E
M)UTN8V%S="AN;V1E='EP92DN9&5R969E<F5N8V4H*5LG7TU?9&%T82==*0H*
M8VQA<W,@4W1D5F5C=&]R4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ=F5C
M=&]R(@H*("`@(&-L87-S(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@
M9&5F(%]?:6YI=%]?("AS96QF+"!S=&%R="P@9FEN:7-H+"!B:71V96,I.@H@
M("`@("`@("`@("!S96QF+F)I='9E8R`](&)I='9E8PH@("`@("`@("`@("!I
M9B!B:71V96,Z"B`@("`@("`@("`@("`@("!S96QF+FET96T@("`]('-T87)T
M6R=?35]P)UT*("`@("`@("`@("`@("`@('-E;&8N<V\@("`@(#T@<W1A<G1;
M)U]-7V]F9G-E="=="B`@("`@("`@("`@("`@("!S96QF+F9I;FES:"`](&9I
M;FES:%LG7TU?<"=="B`@("`@("`@("`@("`@("!S96QF+F9O("`@("`](&9I
M;FES:%LG7TU?;V9F<V5T)UT*("`@("`@("`@("`@("`@(&ET>7!E(#T@<V5L
M9BYI=&5M+F1E<F5F97)E;F-E*"DN='EP90H@("`@("`@("`@("`@("`@<V5L
M9BYI<VEZ92`](#@@*B!I='EP92YS:7IE;V8*("`@("`@("`@("`@96QS93H*
M("`@("`@("`@("`@("`@('-E;&8N:71E;2`]('-T87)T"B`@("`@("`@("`@
M("`@("!S96QF+F9I;FES:"`](&9I;FES:`H@("`@("`@("`@("!S96QF+F-O
M=6YT(#T@,`H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@
M("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*
M("`@("`@("`@("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@("`@("`@("`@('-E
M;&8N8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@("`@("!I9B!S96QF
M+F)I='9E8SH*("`@("`@("`@("`@("`@(&EF('-E;&8N:71E;2`]/2!S96QF
M+F9I;FES:"!A;F0@<V5L9BYS;R`^/2!S96QF+F9O.@H@("`@("`@("`@("`@
M("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@("`@(&5L
M="`]('-E;&8N:71E;2YD97)E9F5R96YC92@I"B`@("`@("`@("`@("`@("!I
M9B!E;'0@)B`H,2`\/"!S96QF+G-O*3H*("`@("`@("`@("`@("`@("`@("!O
M8FET(#T@,0H@("`@("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@
M("`@("!O8FET(#T@,`H@("`@("`@("`@("`@("`@<V5L9BYS;R`]('-E;&8N
M<V\@*R`Q"B`@("`@("`@("`@("`@("!I9B!S96QF+G-O(#X]('-E;&8N:7-I
M>F4Z"B`@("`@("`@("`@("`@("`@("`@<V5L9BYI=&5M(#T@<V5L9BYI=&5M
M("L@,0H@("`@("`@("`@("`@("`@("`@('-E;&8N<V\@/2`P"B`@("`@("`@
M("`@("`@("!R971U<FX@*"=;)61=)R`E(&-O=6YT+"!O8FET*0H@("`@("`@
M("`@("!E;'-E.@H@("`@("`@("`@("`@("`@:68@<V5L9BYI=&5M(#T]('-E
M;&8N9FEN:7-H.@H@("`@("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R
M871I;VX*("`@("`@("`@("`@("`@(&5L="`]('-E;&8N:71E;2YD97)E9F5R
M96YC92@I"B`@("`@("`@("`@("`@("!S96QF+FET96T@/2!S96QF+FET96T@
M*R`Q"B`@("`@("`@("`@("`@("!R971U<FX@*"=;)61=)R`E(&-O=6YT+"!E
M;'0I"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@
M("`@("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P
M86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@
M<V5L9BYI<U]B;V]L(#T@=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"DN
M8V]D92`@/3T@9V1B+E194$5?0T]$15]"3T],"@H@("`@9&5F(&-H:6QD<F5N
M*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R871O<BAS96QF+G9A
M;%LG7TU?:6UP;"==6R=?35]S=&%R="==+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G72P*
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@<V5L9BYI<U]B;V]L*0H*
M("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@<W1A<G0@/2!S96QF
M+G9A;%LG7TU?:6UP;"==6R=?35]S=&%R="=="B`@("`@("`@9FEN:7-H(#T@
M<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UT*("`@("`@("!E;F0@
M/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]E;F1?;V9?<W1O<F%G92=="B`@
M("`@("`@:68@<V5L9BYI<U]B;V]L.@H@("`@("`@("`@("!S=&%R="`]('-E
M;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;)U]-7W`G70H@("`@("`@
M("`@("!S;R`@("`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;
M)U]-7V]F9G-E="=="B`@("`@("`@("`@(&9I;FES:"`]('-E;&8N=F%L6R=?
M35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]P)UT*("`@("`@("`@("`@9F\@
M("`@(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7V]F
M9G-E="=="B`@("`@("`@("`@(&ET>7!E(#T@<W1A<G0N9&5R969E<F5N8V4H
M*2YT>7!E"B`@("`@("`@("`@(&)L(#T@."`J(&ET>7!E+G-I>F5O9@H@("`@
M("`@("`@("!L96YG=&@@("`]("AB;"`M('-O*2`K(&)L("H@*"AF:6YI<V@@
M+2!S=&%R="D@+2`Q*2`K(&9O"B`@("`@("`@("`@(&-A<&%C:71Y(#T@8FP@
M*B`H96YD("T@<W1A<G0I"B`@("`@("`@("`@(')E='5R;B`H)R5S/&)O;VP^
M(&]F(&QE;F=T:"`E9"P@8V%P86-I='D@)60G"B`@("`@("`@("`@("`@("`@
M("`@)2`H<V5L9BYT>7!E;F%M92P@:6YT("AL96YG=&@I+"!I;G0@*&-A<&%C
M:71Y*2DI"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N("@G)7,@
M;V8@;&5N9W1H("5D+"!C87!A8VET>2`E9"<*("`@("`@("`@("`@("`@("`@
M("`E("AS96QF+G1Y<&5N86UE+"!I;G0@*&9I;FES:"`M('-T87)T*2P@:6YT
M("AE;F0@+2!S=&%R="DI*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0H<V5L9BDZ
M"B`@("`@("`@<F5T=7)N("=A<G)A>2<*"F-L87-S(%-T9%9E8W1O<DET97)A
M=&]R4')I;G1E<CH*("`@(")0<FEN="!S=&0Z.G9E8W1O<CHZ:71E<F%T;W(B
M"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@
M("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*
M("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-7V-U<G)E;G0G73H*("`@("`@
M("`@("`@<F5T=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O
M<B!S=&0Z.G9E8W1O<B<*("`@("`@("!R971U<FX@<W1R*'-E;&8N=F%L6R=?
M35]C=7)R96YT)UTN9&5R969E<F5N8V4H*2D*"F-L87-S(%-T9%1U<&QE4')I
M;G1E<CH*("`@(")0<FEN="!A('-T9#HZ='5P;&4B"@H@("`@8VQA<W,@7VET
M97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!`<W1A=&EC;65T:&]D"B`@("`@
M("`@9&5F(%]I<U]N;VYE;7!T>5]T=7!L92`H;F]D97,I.@H@("`@("`@("`@
M("!I9B!L96X@*&YO9&5S*2`]/2`R.@H@("`@("`@("`@("`@("`@:68@:7-?
M<W!E8VEA;&EZ871I;VY?;V8@*&YO9&5S6S%=+G1Y<&4L("=?7W1U<&QE7V)A
M<V4G*3H*("`@("`@("`@("`@("`@("`@("!R971U<FX@5')U90H@("`@("`@
M("`@("!E;&EF(&QE;B`H;F]D97,I(#T](#$Z"B`@("`@("`@("`@("`@("!R
M971U<FX@5')U90H@("`@("`@("`@("!E;&EF(&QE;B`H;F]D97,I(#T](#`Z
M"B`@("`@("`@("`@("`@("!R971U<FX@1F%L<V4*("`@("`@("`@("`@<F%I
M<V4@5F%L=65%<G)O<B@B5&]P(&]F('1U<&QE('1R964@9&]E<R!N;W0@8V]N
M<VES="!O9B!A('-I;F=L92!N;V1E+B(I"@H@("`@("`@(&1E9B!?7VEN:71?
M7R`H<V5L9BP@:&5A9"DZ"B`@("`@("`@("`@('-E;&8N:&5A9"`](&AE860*
M"B`@("`@("`@("`@(",@4V5T('1H92!B87-E(&-L87-S(&%S('1H92!I;FET
M:6%L(&AE860@;V8@=&AE"B`@("`@("`@("`@(",@='5P;&4N"B`@("`@("`@
M("`@(&YO9&5S(#T@<V5L9BYH96%D+G1Y<&4N9FEE;&1S("@I"B`@("`@("`@
M("`@(&EF('-E;&8N7VES7VYO;F5M<'1Y7W1U<&QE("AN;V1E<RDZ"B`@("`@
M("`@("`@("`@("`C(%-E="!T:&4@86-T=6%L(&AE860@=&\@=&AE(&9I<G-T
M('!A:7(N"B`@("`@("`@("`@("`@("!S96QF+FAE860@(#T@<V5L9BYH96%D
M+F-A<W0@*&YO9&5S6S!=+G1Y<&4I"B`@("`@("`@("`@('-E;&8N8V]U;G0@
M/2`P"@H@("`@("`@(&1E9B!?7VET97)?7R`H<V5L9BDZ"B`@("`@("`@("`@
M(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7R`H<V5L9BDZ"B`@
M("`@("`@("`@(",@0VAE8VL@9F]R(&9U<G1H97(@<F5C=7)S:6]N<R!I;B!T
M:&4@:6YH97)I=&%N8V4@=')E92X*("`@("`@("`@("`@(R!&;W(@82!'0T,@
M-2L@='5P;&4@<V5L9BYH96%D(&ES($YO;F4@869T97(@=FES:71I;F<@86QL
M(&YO9&5S.@H@("`@("`@("`@("!I9B!N;W0@<V5L9BYH96%D.@H@("`@("`@
M("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!N;V1E
M<R`]('-E;&8N:&5A9"YT>7!E+F9I96QD<R`H*0H@("`@("`@("`@("`C($9O
M<B!A($=#0R`T+G@@='5P;&4@=&AE<F4@:7,@82!F:6YA;"!N;V1E('=I=&@@
M;F\@9FEE;&1S.@H@("`@("`@("`@("!I9B!L96X@*&YO9&5S*2`]/2`P.@H@
M("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@
M("`C($-H96-K('1H870@=&AI<R!I=&5R871I;VX@:&%S(&%N(&5X<&5C=&5D
M('-T<G5C='5R92X*("`@("`@("`@("`@:68@;&5N("AN;V1E<RD@/B`R.@H@
M("`@("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@B0V%N;F]T('!A<G-E
M(&UO<F4@=&AA;B`R(&YO9&5S(&EN(&$@='5P;&4@=')E92XB*0H*("`@("`@
M("`@("`@:68@;&5N("AN;V1E<RD@/3T@,3H*("`@("`@("`@("`@("`@(",@
M5&AI<R!I<R!T:&4@;&%S="!N;V1E(&]F(&$@1T-#(#4K('-T9#HZ='5P;&4N
M"B`@("`@("`@("`@("`@("!I;7!L(#T@<V5L9BYH96%D+F-A<W0@*&YO9&5S
M6S!=+G1Y<&4I"B`@("`@("`@("`@("`@("!S96QF+FAE860@/2!.;VYE"B`@
M("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("`C($5I=&AE<B!A(&YO
M9&4@8F5F;W)E('1H92!L87-T(&YO9&4L(&]R('1H92!L87-T(&YO9&4@;V8*
M("`@("`@("`@("`@("`@(",@82!'0T,@-"YX('1U<&QE("AW:&EC:"!H87,@
M86X@96UP='D@<&%R96YT*2X*"B`@("`@("`@("`@("`@("`C("T@3&5F="!N
M;V1E(&ES('1H92!N97AT(')E8W5R<VEO;B!P87)E;G0N"B`@("`@("`@("`@
M("`@("`C("T@4FEG:'0@;F]D92!I<R!T:&4@86-T=6%L(&-L87-S(&-O;G1A
M:6YE9"!I;B!T:&4@='5P;&4N"@H@("`@("`@("`@("`@("`@(R!0<F]C97-S
M(')I9VAT(&YO9&4N"B`@("`@("`@("`@("`@("!I;7!L(#T@<V5L9BYH96%D
M+F-A<W0@*&YO9&5S6S%=+G1Y<&4I"@H@("`@("`@("`@("`@("`@(R!0<F]C
M97-S(&QE9G0@;F]D92!A;F0@<V5T(&ET(&%S(&AE860N"B`@("`@("`@("`@
M("`@("!S96QF+FAE860@(#T@<V5L9BYH96%D+F-A<W0@*&YO9&5S6S!=+G1Y
M<&4I"@H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*
M"B`@("`@("`@("`@(",@1FEN86QL>2P@8VAE8VL@=&AE(&EM<&QE;65N=&%T
M:6]N+B`@268@:70@:7,*("`@("`@("`@("`@(R!W<F%P<&5D(&EN(%]-7VAE
M861?:6UP;"!R971U<FX@=&AA="P@;W1H97)W:7-E(')E='5R;@H@("`@("`@
M("`@("`C('1H92!V86QU92`B87,@:7,B+@H@("`@("`@("`@("!F:65L9',@
M/2!I;7!L+G1Y<&4N9FEE;&1S("@I"B`@("`@("`@("`@(&EF(&QE;B`H9FEE
M;&1S*2`\(#$@;W(@9FEE;&1S6S!=+FYA;64@(3T@(E]-7VAE861?:6UP;"(Z
M"B`@("`@("`@("`@("`@("!R971U<FX@*"=;)61=)R`E('-E;&8N8V]U;G0L
M(&EM<&PI"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!R971U
M<FX@*"=;)61=)R`E('-E;&8N8V]U;G0L(&EM<&Q;)U]-7VAE861?:6UP;"==
M*0H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@
M("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A
M8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P["@H@("`@9&5F
M(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T
M;W(@*'-E;&8N=F%L*0H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@
M("`@(&EF(&QE;B`H<V5L9BYV86PN='EP92YF:65L9',@*"DI(#T](#`Z"B`@
M("`@("`@("`@(')E='5R;B`G96UP='D@)7,G("4@*'-E;&8N='EP96YA;64I
M"B`@("`@("`@<F5T=7)N("<E<R!C;VYT86EN:6YG)R`E("AS96QF+G1Y<&5N
M86UE*0H*8VQA<W,@4W1D4W1A8VM/<E%U975E4')I;G1E<CH*("`@(")0<FEN
M="!A('-T9#HZ<W1A8VL@;W(@<W1D.CIQ=65U92(*"B`@("!D968@7U]I;FET
M7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA
M;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@
M("`@('-E;&8N=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H
M=F%L6R=C)UTI"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!R
M971U<FX@<V5L9BYV:7-U86QI>F5R+F-H:6QD<F5N*"D*"B`@("!D968@=&]?
M<W1R:6YG("AS96QF*3H*("`@("`@("!R971U<FX@)R5S('=R87!P:6YG.B`E
M<R<@)2`H<V5L9BYT>7!E;F%M92P*("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@<V5L9BYV:7-U86QI>F5R+G1O7W-T<FEN9R@I*0H*("`@
M(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(&EF(&AA<V%T='(@
M*'-E;&8N=FES=6%L:7IE<BP@)V1I<W!L87E?:&EN="<I.@H@("`@("`@("`@
M("!R971U<FX@<V5L9BYV:7-U86QI>F5R+F1I<W!L87E?:&EN="`H*0H@("`@
M("`@(')E='5R;B!.;VYE"@IC;&%S<R!28G1R965)=&5R871O<BA)=&5R871O
M<BDZ"B`@("`B(B(*("`@(%1U<FX@86X@4D(M=')E92UB87-E9"!C;VYT86EN
M97(@*'-T9#HZ;6%P+"!S=&0Z.G-E="!E=&,N*2!I;G1O"B`@("!A(%!Y=&AO
M;B!I=&5R86)L92!O8FIE8W0N"B`@("`B(B(*"B`@("!D968@7U]I;FET7U\H
M<V5L9BP@<F)T<F5E*3H*("`@("`@("!S96QF+G-I>F4@/2!R8G1R965;)U]-
M7W0G75LG7TU?:6UP;"==6R=?35]N;V1E7V-O=6YT)UT*("`@("`@("!S96QF
M+FYO9&4@/2!R8G1R965;)U]-7W0G75LG7TU?:6UP;"==6R=?35]H96%D97(G
M75LG7TU?;&5F="=="B`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@("!D968@
M7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8*"B`@("!D968@
M7U]L96Y?7RAS96QF*3H*("`@("`@("!R971U<FX@:6YT("AS96QF+G-I>F4I
M"@H@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N8V]U
M;G0@/3T@<V5L9BYS:7IE.@H@("`@("`@("`@("!R86ES92!3=&]P271E<F%T
M:6]N"B`@("`@("`@<F5S=6QT(#T@<V5L9BYN;V1E"B`@("`@("`@<V5L9BYC
M;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@:68@<V5L9BYC;W5N="`\
M('-E;&8N<VEZ93H*("`@("`@("`@("`@(R!#;VUP=71E('1H92!N97AT(&YO
M9&4N"B`@("`@("`@("`@(&YO9&4@/2!S96QF+FYO9&4*("`@("`@("`@("`@
M:68@;F]D92YD97)E9F5R96YC92@I6R=?35]R:6=H="==.@H@("`@("`@("`@
M("`@("`@;F]D92`](&YO9&4N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G70H@
M("`@("`@("`@("`@("`@=VAI;&4@;F]D92YD97)E9F5R96YC92@I6R=?35]L
M969T)UTZ"B`@("`@("`@("`@("`@("`@("`@;F]D92`](&YO9&4N9&5R969E
M<F5N8V4H*5LG7TU?;&5F="=="B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@("`@("!P87)E;G0@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7W!A<F5N
M="=="B`@("`@("`@("`@("`@("!W:&EL92!N;V1E(#T]('!A<F5N="YD97)E
M9F5R96YC92@I6R=?35]R:6=H="==.@H@("`@("`@("`@("`@("`@("`@(&YO
M9&4@/2!P87)E;G0*("`@("`@("`@("`@("`@("`@("!P87)E;G0@/2!P87)E
M;G0N9&5R969E<F5N8V4H*5LG7TU?<&%R96YT)UT*("`@("`@("`@("`@("`@
M(&EF(&YO9&4N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G72`A/2!P87)E;G0Z
M"B`@("`@("`@("`@("`@("`@("`@;F]D92`]('!A<F5N=`H@("`@("`@("`@
M("!S96QF+FYO9&4@/2!N;V1E"B`@("`@("`@<F5T=7)N(')E<W5L=`H*9&5F
M(&=E=%]V86QU95]F<F]M7U)B7W1R965?;F]D92AN;V1E*3H*("`@("(B(E)E
M='5R;G,@=&AE('9A;'5E(&AE;&0@:6X@86X@7U)B7W1R965?;F]D93Q?5F%L
M/B(B(@H@("`@=')Y.@H@("`@("`@(&UE;6)E<B`](&YO9&4N='EP92YF:65L
M9',H*5LQ72YN86UE"B`@("`@("`@:68@;65M8F5R(#T]("=?35]V86QU95]F
M:65L9"<Z"B`@("`@("`@("`@(",@0RLK,#,@:6UP;&5M96YT871I;VXL(&YO
M9&4@8V]N=&%I;G,@=&AE('9A;'5E(&%S(&$@;65M8F5R"B`@("`@("`@("`@
M(')E='5R;B!N;V1E6R=?35]V86QU95]F:65L9"=="B`@("`@("`@96QI9B!M
M96UB97(@/3T@)U]-7W-T;W)A9V4G.@H@("`@("`@("`@("`C($,K*S$Q(&EM
M<&QE;65N=&%T:6]N+"!N;V1E('-T;W)E<R!V86QU92!I;B!?7V%L:6=N961?
M;65M8G5F"B`@("`@("`@("`@('9A;'1Y<&4@/2!N;V1E+G1Y<&4N=&5M<&QA
M=&5?87)G=6UE;G0H,"D*("`@("`@("`@("`@<F5T=7)N(&=E=%]V86QU95]F
M<F]M7V%L:6=N961?;65M8G5F*&YO9&5;)U]-7W-T;W)A9V4G72P@=F%L='EP
M92D*("`@(&5X8V5P=#H*("`@("`@("!P87-S"B`@("!R86ES92!686QU945R
M<F]R*")5;G-U<'!O<G1E9"!I;7!L96UE;G1A=&EO;B!F;W(@)7,B("4@<W1R
M*&YO9&4N='EP92DI"@HC(%1H:7,@:7,@82!P<F5T='D@<')I;G1E<B!F;W(@
M<W1D.CI?4F)?=')E95]I=&5R871O<B`H=VAI8V@@:7,*(R!S=&0Z.FUA<#HZ
M:71E<F%T;W(I+"!A;F0@:&%S(&YO=&AI;F<@=&\@9&\@=VET:"!T:&4@4F)T
M<F5E271E<F%T;W(*(R!C;&%S<R!A8F]V92X*8VQA<W,@4W1D4F)T<F5E271E
M<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT('-T9#HZ;6%P.CII=&5R871O<BP@
M<W1D.CIS970Z.FET97)A=&]R+"!E=&,N(@H*("`@(&1E9B!?7VEN:71?7R`H
M<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*
M("`@("`@("!V86QT>7!E(#T@<V5L9BYV86PN='EP92YT96UP;&%T95]A<F=U
M;65N="@P*2YS=')I<%]T>7!E9&5F<R@I"B`@("`@("`@;F]D971Y<&4@/2`G
M7U)B7W1R965?;F]D93PG("L@<W1R*'9A;'1Y<&4I("L@)SXG"B`@("`@("`@
M:68@7W9E<G-I;VYE9%]N86UE<W!A8V4@86YD('1Y<&5N86UE+G-T87)T<W=I
M=&@H)W-T9#HZ)R`K(%]V97)S:6]N961?;F%M97-P86-E*3H*("`@("`@("`@
M("`@;F]D971Y<&4@/2!?=F5R<VEO;F5D7VYA;65S<&%C92`K(&YO9&5T>7!E
M"B`@("`@("`@;F]D971Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H)W-T9#HZ)R`K
M(&YO9&5T>7!E*0H@("`@("`@('-E;&8N;&EN:U]T>7!E(#T@;F]D971Y<&4N
M<W1R:7!?='EP961E9G,H*2YP;VEN=&5R*"D*"B`@("!D968@=&]?<W1R:6YG
M("AS96QF*3H*("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-7VYO9&4G73H*
M("`@("`@("`@("`@<F5T=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A
M=&]R(&9O<B!A<W-O8VEA=&EV92!C;VYT86EN97(G"B`@("`@("`@;F]D92`]
M('-E;&8N=F%L6R=?35]N;V1E)UTN8V%S="AS96QF+FQI;FM?='EP92DN9&5R
M969E<F5N8V4H*0H@("`@("`@(')E='5R;B!S='(H9V5T7W9A;'5E7V9R;VU?
M4F)?=')E95]N;V1E*&YO9&4I*0H*8VQA<W,@4W1D1&5B=6=)=&5R871O<E!R
M:6YT97(Z"B`@("`B4')I;G0@82!D96)U9R!E;F%B;&5D('9E<G-I;VX@;V8@
M86X@:71E<F%T;W(B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M
M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(",@2G5S="!S
M=')I<"!A=V%Y('1H92!E;F-A<'-U;&%T:6YG(%]?9VYU7V1E8G5G.CI?4V%F
M95]I=&5R871O<@H@("`@(R!A;F0@<F5T=7)N('1H92!W<F%P<&5D(&ET97)A
M=&]R('9A;'5E+@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@
M8F%S95]T>7!E(#T@9V1B+FQO;VMU<%]T>7!E*"=?7V=N=5]D96)U9SHZ7U-A
M9F5?:71E<F%T;W)?8F%S92<I"B`@("`@("`@:71Y<&4@/2!S96QF+G9A;"YT
M>7!E+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@<V%F95]S97$@/2!S
M96QF+G9A;"YC87-T*&)A<V5?='EP92E;)U]-7W-E<75E;F-E)UT*("`@("`@
M("!I9B!N;W0@<V%F95]S97$Z"B`@("`@("`@("`@(')E='5R;B!S='(H<V5L
M9BYV86PN8V%S="AI='EP92DI"B`@("`@("`@:68@<V5L9BYV86Q;)U]-7W9E
M<G-I;VXG72`A/2!S869E7W-E<5LG7TU?=F5R<VEO;B==.@H@("`@("`@("`@
M("!R971U<FX@(FEN=F%L:60@:71E<F%T;W(B"B`@("`@("`@<F5T=7)N('-T
M<BAS96QF+G9A;"YC87-T*&ET>7!E*2D*"F1E9B!N=6U?96QE;65N=',H;G5M
M*3H*("`@("(B(E)E='5R;B!E:71H97(@(C$@96QE;65N="(@;W(@(DX@96QE
M;65N=',B(&1E<&5N9&EN9R!O;B!T:&4@87)G=6UE;G0N(B(B"B`@("!R971U
M<FX@)S$@96QE;65N="<@:68@;G5M(#T](#$@96QS92`G)60@96QE;65N=',G
M("4@;G5M"@IC;&%S<R!3=&1-87!0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D
M.CIM87`@;W(@<W1D.CIM=6QT:6UA<"(*"B`@("`C(%1U<FX@86X@4F)T<F5E
M271E<F%T;W(@:6YT;R!A('!R971T>2UP<FEN="!I=&5R871O<BX*("`@(&-L
M87-S(%]I=&5R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L
M9BP@<F)I=&5R+"!T>7!E*3H*("`@("`@("`@("`@<V5L9BYR8FET97(@/2!R
M8FET97(*("`@("`@("`@("`@<V5L9BYC;W5N="`](#`*("`@("`@("`@("`@
M<V5L9BYT>7!E(#T@='EP90H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ
M"B`@("`@("`@("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?
M7RAS96QF*3H*("`@("`@("`@("`@:68@<V5L9BYC;W5N="`E(#(@/3T@,#H*
M("`@("`@("`@("`@("`@(&X@/2!N97AT*'-E;&8N<F)I=&5R*0H@("`@("`@
M("`@("`@("`@;B`](&XN8V%S="AS96QF+G1Y<&4I+F1E<F5F97)E;F-E*"D*
M("`@("`@("`@("`@("`@(&X@/2!G971?=F%L=65?9G)O;5]28E]T<F5E7VYO
M9&4H;BD*("`@("`@("`@("`@("`@('-E;&8N<&%I<B`](&X*("`@("`@("`@
M("`@("`@(&ET96T@/2!N6R=F:7)S="=="B`@("`@("`@("`@(&5L<V4Z"B`@
M("`@("`@("`@("`@("!I=&5M(#T@<V5L9BYP86ER6R=S96-O;F0G70H@("`@
M("`@("`@("!R97-U;'0@/2`H)ULE9%TG("4@<V5L9BYC;W5N="P@:71E;2D*
M("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@
M("`@("`@(')E='5R;B!R97-U;'0*"B`@("!D968@7U]I;FET7U\@*'-E;&8L
M('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I
M<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@
M<F5T=7)N("<E<R!W:71H("5S)R`E("AS96QF+G1Y<&5N86UE+`H@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@;G5M7V5L96UE;G1S*&QE;BA28G1R
M965)=&5R871O<B`H<V5L9BYV86PI*2DI"@H@("`@9&5F(&-H:6QD<F5N("AS
M96QF*3H*("`@("`@("!R97!?='EP92`](&9I;F1?='EP92AS96QF+G9A;"YT
M>7!E+"`G7U)E<%]T>7!E)RD*("`@("`@("!N;V1E(#T@9FEN9%]T>7!E*')E
M<%]T>7!E+"`G7TQI;FM?='EP92<I"B`@("`@("`@;F]D92`](&YO9&4N<W1R
M:7!?='EP961E9G,H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R("A28G1R
M965)=&5R871O<B`H<V5L9BYV86PI+"!N;V1E*0H*("`@(&1E9B!D:7-P;&%Y
M7VAI;G0@*'-E;&8I.@H@("`@("`@(')E='5R;B`G;6%P)PH*8VQA<W,@4W1D
M4V5T4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ<V5T(&]R('-T9#HZ;75L
M=&ES970B"@H@("`@(R!4=7)N(&%N(%)B=')E94ET97)A=&]R(&EN=&\@82!P
M<F5T='DM<')I;G0@:71E<F%T;W(N"B`@("!C;&%S<R!?:71E<BA)=&5R871O
M<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L(')B:71E<BP@='EP92DZ
M"B`@("`@("`@("`@('-E;&8N<F)I=&5R(#T@<F)I=&5R"B`@("`@("`@("`@
M('-E;&8N8V]U;G0@/2`P"B`@("`@("`@("`@('-E;&8N='EP92`]('1Y<&4*
M"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R971U
M<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@
M("`@(&ET96T@/2!N97AT*'-E;&8N<F)I=&5R*0H@("`@("`@("`@("!I=&5M
M(#T@:71E;2YC87-T*'-E;&8N='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@
M("`@("!I=&5M(#T@9V5T7W9A;'5E7V9R;VU?4F)?=')E95]N;V1E*&ET96TI
M"B`@("`@("`@("`@(",@1DE8344Z('1H:7,@:7,@=V5I<F0@+BXN('=H870@
M=&\@9&\_"B`@("`@("`@("`@(",@36%Y8F4@82`G<V5T)R!D:7-P;&%Y(&AI
M;G0_"B`@("`@("`@("`@(')E<W5L="`]("@G6R5D72<@)2!S96QF+F-O=6YT
M+"!I=&5M*0H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K
M(#$*("`@("`@("`@("`@<F5T=7)N(')E<W5L=`H*("`@(&1E9B!?7VEN:71?
M7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M
M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@
M("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*
M("`@("`@("!R971U<FX@)R5S('=I=&@@)7,G("4@*'-E;&8N='EP96YA;64L
M"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!N=6U?96QE;65N=',H
M;&5N*%)B=')E94ET97)A=&]R("AS96QF+G9A;"DI*2D*"B`@("!D968@8VAI
M;&1R96X@*'-E;&8I.@H@("`@("`@(')E<%]T>7!E(#T@9FEN9%]T>7!E*'-E
M;&8N=F%L+G1Y<&4L("=?4F5P7W1Y<&4G*0H@("`@("`@(&YO9&4@/2!F:6YD
M7W1Y<&4H<F5P7W1Y<&4L("=?3&EN:U]T>7!E)RD*("`@("`@("!N;V1E(#T@
M;F]D92YS=')I<%]T>7!E9&5F<R@I"B`@("`@("`@<F5T=7)N('-E;&8N7VET
M97(@*%)B=')E94ET97)A=&]R("AS96QF+G9A;"DL(&YO9&4I"@IC;&%S<R!3
M=&1":71S9710<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIB:71S970B"@H@
M("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@
M('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y
M<&5N86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T
M<FEN9R`H<V5L9BDZ"B`@("`@("`@(R!)9B!T96UP;&%T95]A<F=U;65N="!H
M86YD;&5D('9A;'5E<RP@=V4@8V]U;&0@<')I;G0@=&AE"B`@("`@("`@(R!S
M:7IE+B`@3W(@=V4@8V]U;&0@=7-E(&$@<F5G97AP(&]N('1H92!T>7!E+@H@
M("`@("`@(')E='5R;B`G)7,G("4@*'-E;&8N='EP96YA;64I"@H@("`@9&5F
M(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!T<GDZ"B`@("`@("`@("`@(",@
M06X@96UP='D@8FET<V5T(&UA>2!N;W0@:&%V92!A;GD@;65M8F5R<R!W:&EC
M:"!W:6QL"B`@("`@("`@("`@(",@<F5S=6QT(&EN(&%N(&5X8V5P=&EO;B!B
M96EN9R!T:')O=VXN"B`@("`@("`@("`@('=O<F1S(#T@<V5L9BYV86Q;)U]-
M7W<G70H@("`@("`@(&5X8V5P=#H*("`@("`@("`@("`@<F5T=7)N(%M="@H@
M("`@("`@('=T>7!E(#T@=V]R9',N='EP90H*("`@("`@("`C(%1H92!?35]W
M(&UE;6)E<B!C86X@8F4@96ET:&5R(&%N('5N<VEG;F5D(&QO;F<L(&]R(&%N
M"B`@("`@("`@(R!A<G)A>2X@(%1H:7,@9&5P96YD<R!O;B!T:&4@=&5M<&QA
M=&4@<W!E8VEA;&EZ871I;VX@=7-E9"X*("`@("`@("`C($EF(&ET(&ES(&$@
M<VEN9VQE(&QO;F<L(&-O;G9E<G0@=&\@82!S:6YG;&4@96QE;65N="!L:7-T
M+@H@("`@("`@(&EF('=T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]!4E)!
M63H*("`@("`@("`@("`@='-I>F4@/2!W='EP92YT87)G970@*"DN<VEZ96]F
M"B`@("`@("`@96QS93H*("`@("`@("`@("`@=V]R9',@/2!;=V]R9'-="B`@
M("`@("`@("`@('1S:7IE(#T@=W1Y<&4N<VEZ96]F"@H@("`@("`@(&YW;W)D
M<R`]('=T>7!E+G-I>F5O9B`O('1S:7IE"B`@("`@("`@<F5S=6QT(#T@6UT*
M("`@("`@("!B>71E(#T@,`H@("`@("`@('=H:6QE(&)Y=&4@/"!N=V]R9',Z
M"B`@("`@("`@("`@('<@/2!W;W)D<UMB>71E70H@("`@("`@("`@("!B:70@
M/2`P"B`@("`@("`@("`@('=H:6QE('<@(3T@,#H*("`@("`@("`@("`@("`@
M(&EF("AW("8@,2D@(3T@,#H*("`@("`@("`@("`@("`@("`@("`C($%N;W1H
M97(@<W!O="!W:&5R92!W92!C;W5L9"!U<V4@)W-E="<_"B`@("`@("`@("`@
M("`@("`@("`@<F5S=6QT+F%P<&5N9"@H)ULE9%TG("4@*&)Y=&4@*B!T<VEZ
M92`J(#@@*R!B:70I+"`Q*2D*("`@("`@("`@("`@("`@(&)I="`](&)I="`K
M(#$*("`@("`@("`@("`@("`@('<@/2!W(#X^(#$*("`@("`@("`@("`@8GET
M92`](&)Y=&4@*R`Q"B`@("`@("`@<F5T=7)N(')E<W5L=`H*8VQA<W,@4W1D
M1&5Q=650<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CID97%U92(*"B`@("!C
M;&%S<R!?:71E<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L(&YO9&4L('-T87)T+"!E;F0L(&QA<W0L(&)U9F9E<E]S:7IE*3H*("`@
M("`@("`@("`@<V5L9BYN;V1E(#T@;F]D90H@("`@("`@("`@("!S96QF+G`@
M/2!S=&%R=`H@("`@("`@("`@("!S96QF+F5N9"`](&5N9`H@("`@("`@("`@
M("!S96QF+FQA<W0@/2!L87-T"B`@("`@("`@("`@('-E;&8N8G5F9F5R7W-I
M>F4@/2!B=69F97)?<VEZ90H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*
M("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E='5R
M;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("`@
M("`@:68@<V5L9BYP(#T]('-E;&8N;&%S=#H*("`@("`@("`@("`@("`@(')A
M:7-E(%-T;W!)=&5R871I;VX*"B`@("`@("`@("`@(')E<W5L="`]("@G6R5D
M72<@)2!S96QF+F-O=6YT+"!S96QF+G`N9&5R969E<F5N8V4H*2D*("`@("`@
M("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"@H@("`@("`@("`@
M("`C($%D=F%N8V4@=&AE("=C=7(G('!O:6YT97(N"B`@("`@("`@("`@('-E
M;&8N<"`]('-E;&8N<"`K(#$*("`@("`@("`@("`@:68@<V5L9BYP(#T]('-E
M;&8N96YD.@H@("`@("`@("`@("`@("`@(R!)9B!W92!G;W0@=&\@=&AE(&5N
M9"!O9B!T:&ES(&)U8VME="P@;6]V92!T;R!T:&4*("`@("`@("`@("`@("`@
M(",@;F5X="!B=6-K970N"B`@("`@("`@("`@("`@("!S96QF+FYO9&4@/2!S
M96QF+FYO9&4@*R`Q"B`@("`@("`@("`@("`@("!S96QF+G`@/2!S96QF+FYO
M9&5;,%T*("`@("`@("`@("`@("`@('-E;&8N96YD(#T@<V5L9BYP("L@<V5L
M9BYB=69F97)?<VEZ90H*("`@("`@("`@("`@<F5T=7)N(')E<W5L=`H*("`@
M(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S
M96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E
M;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@('-E;&8N96QT
M='EP92`]('9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@
M<VEZ92`]('-E;&8N96QT='EP92YS:7IE;V8*("`@("`@("!I9B!S:7IE(#P@
M-3$R.@H@("`@("`@("`@("!S96QF+F)U9F9E<E]S:7IE(#T@:6YT("@U,3(@
M+R!S:7IE*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N8G5F9F5R
M7W-I>F4@/2`Q"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!S
M=&%R="`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UT*("`@("`@
M("!E;F0@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G70H*("`@
M("`@("!D96QT85]N(#T@96YD6R=?35]N;V1E)UT@+2!S=&%R=%LG7TU?;F]D
M92==("T@,0H@("`@("`@(&1E;'1A7W,@/2!S=&%R=%LG7TU?;&%S="==("T@
M<W1A<G1;)U]-7V-U<B=="B`@("`@("`@9&5L=&%?92`](&5N9%LG7TU?8W5R
M)UT@+2!E;F1;)U]-7V9I<G-T)UT*"B`@("`@("`@<VEZ92`]('-E;&8N8G5F
M9F5R7W-I>F4@*B!D96QT85]N("L@9&5L=&%?<R`K(&1E;'1A7V4*"B`@("`@
M("`@<F5T=7)N("<E<R!W:71H("5S)R`E("AS96QF+G1Y<&5N86UE+"!N=6U?
M96QE;65N=',H;&]N9RAS:7IE*2DI"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I
M.@H@("`@("`@('-T87)T(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A
M<G0G70H@("`@("`@(&5N9"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7V9I
M;FES:"=="B`@("`@("`@<F5T=7)N('-E;&8N7VET97(H<W1A<G1;)U]-7VYO
M9&4G72P@<W1A<G1;)U]-7V-U<B==+"!S=&%R=%LG7TU?;&%S="==+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@(&5N9%LG7TU?8W5R)UTL('-E;&8N8G5F
M9F5R7W-I>F4I"@H@("`@9&5F(&1I<W!L87E?:&EN="`H<V5L9BDZ"B`@("`@
M("`@<F5T=7)N("=A<G)A>2<*"F-L87-S(%-T9$1E<75E271E<F%T;W)0<FEN
M=&5R.@H@("`@(E!R:6YT('-T9#HZ9&5Q=64Z.FET97)A=&]R(@H*("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF
M+G9A;"`]('9A;`H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@
M:68@;F]T('-E;&8N=F%L6R=?35]C=7(G73H*("`@("`@("`@("`@<F5T=7)N
M("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.F1E<75E
M)PH@("`@("`@(')E='5R;B!S='(H<V5L9BYV86Q;)U]-7V-U<B==+F1E<F5F
M97)E;F-E*"DI"@IC;&%S<R!3=&13=')I;F=0<FEN=&5R.@H@("`@(E!R:6YT
M(&$@<W1D.CIB87-I8U]S=')I;F<@;V8@<V]M92!K:6YD(@H*("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A
M;"`]('9A;`H@("`@("`@('-E;&8N;F5W7W-T<FEN9R`]('1Y<&5N86UE+F9I
M;F0H(CHZ7U]C>'@Q,3HZ8F%S:6-?<W1R:6YG(BD@(3T@+3$*"B`@("!D968@
M=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(",@36%K92!S=7)E("9S=')I;F<@
M=V]R:W,L('1O;RX*("`@("`@("!T>7!E(#T@<V5L9BYV86PN='EP90H@("`@
M("`@(&EF('1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@
M("`@("`@='EP92`]('1Y<&4N=&%R9V5T("@I"@H@("`@("`@(",@0V%L8W5L
M871E('1H92!L96YG=&@@;V8@=&AE('-T<FEN9R!S;R!T:&%T('1O7W-T<FEN
M9R!R971U<FYS"B`@("`@("`@(R!T:&4@<W1R:6YG(&%C8V]R9&EN9R!T;R!L
M96YG=&@L(&YO="!A8V-O<F1I;F<@=&\@9FER<W0@;G5L;`H@("`@("`@(",@
M96YC;W5N=&5R960N"B`@("`@("`@<'1R(#T@<V5L9BYV86P@6R=?35]D871A
M<&QU<R==6R=?35]P)UT*("`@("`@("!I9B!S96QF+FYE=U]S=')I;F<Z"B`@
M("`@("`@("`@(&QE;F=T:"`]('-E;&8N=F%L6R=?35]S=')I;F=?;&5N9W1H
M)UT*("`@("`@("`@("`@(R!H='1P<SHO+W-O=7)C97=A<F4N;W)G+V)U9WII
M;&QA+W-H;W=?8G5G+F-G:3]I9#TQ-S<R.`H@("`@("`@("`@("!P='(@/2!P
M='(N8V%S="AP='(N='EP92YS=')I<%]T>7!E9&5F<R@I*0H@("`@("`@(&5L
M<V4Z"B`@("`@("`@("`@(')E86QT>7!E(#T@='EP92YU;G%U86QI9FEE9"`H
M*2YS=')I<%]T>7!E9&5F<R`H*0H@("`@("`@("`@("!R97!T>7!E(#T@9V1B
M+FQO;VMU<%]T>7!E("AS='(@*')E86QT>7!E*2`K("<Z.E]297`G*2YP;VEN
M=&5R("@I"B`@("`@("`@("`@(&AE861E<B`]('!T<BYC87-T*')E<'1Y<&4I
M("T@,0H@("`@("`@("`@("!L96YG=&@@/2!H96%D97(N9&5R969E<F5N8V4@
M*"E;)U]-7VQE;F=T:"=="B`@("`@("`@:68@:&%S871T<BAP='(L(")L87IY
M7W-T<FEN9R(I.@H@("`@("`@("`@("!R971U<FX@<'1R+FQA>GE?<W1R:6YG
M("AL96YG=&@@/2!L96YG=&@I"B`@("`@("`@<F5T=7)N('!T<BYS=')I;F<@
M*&QE;F=T:"`](&QE;F=T:"D*"B`@("!D968@9&ES<&QA>5]H:6YT("AS96QF
M*3H*("`@("`@("!R971U<FX@)W-T<FEN9R<*"F-L87-S(%1R,4AA<VAT86)L
M94ET97)A=&]R*$ET97)A=&]R*3H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@
M:&%S:"DZ"B`@("`@("`@<V5L9BYB=6-K971S(#T@:&%S:%LG7TU?8G5C:V5T
M<R=="B`@("`@("`@<V5L9BYB=6-K970@/2`P"B`@("`@("`@<V5L9BYB=6-K
M971?8V]U;G0@/2!H87-H6R=?35]B=6-K971?8V]U;G0G70H@("`@("`@('-E
M;&8N;F]D95]T>7!E(#T@9FEN9%]T>7!E*&AA<V@N='EP92P@)U].;V1E)RDN
M<&]I;G1E<B@I"B`@("`@("`@<V5L9BYN;V1E(#T@,`H@("`@("`@('=H:6QE
M('-E;&8N8G5C:V5T("$]('-E;&8N8G5C:V5T7V-O=6YT.@H@("`@("`@("`@
M("!S96QF+FYO9&4@/2!S96QF+F)U8VME='-;<V5L9BYB=6-K971="B`@("`@
M("`@("`@(&EF('-E;&8N;F]D93H*("`@("`@("`@("`@("`@(&)R96%K"B`@
M("`@("`@("`@('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K970@*R`Q"@H@("`@
M9&5F(%]?:71E<E]?("AS96QF*3H*("`@("`@("!R971U<FX@<V5L9@H*("`@
M(&1E9B!?7VYE>'1?7R`H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYN;V1E(#T]
M(#`Z"B`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("!N
M;V1E(#T@<V5L9BYN;V1E+F-A<W0H<V5L9BYN;V1E7W1Y<&4I"B`@("`@("`@
M<F5S=6QT(#T@;F]D92YD97)E9F5R96YC92@I6R=?35]V)UT*("`@("`@("!S
M96QF+FYO9&4@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7VYE>'0G73L*("`@
M("`@("!I9B!S96QF+FYO9&4@/3T@,#H*("`@("`@("`@("`@<V5L9BYB=6-K
M970@/2!S96QF+F)U8VME="`K(#$*("`@("`@("`@("`@=VAI;&4@<V5L9BYB
M=6-K970@(3T@<V5L9BYB=6-K971?8V]U;G0Z"B`@("`@("`@("`@("`@("!S
M96QF+FYO9&4@/2!S96QF+F)U8VME='-;<V5L9BYB=6-K971="B`@("`@("`@
M("`@("`@("!I9B!S96QF+FYO9&4Z"B`@("`@("`@("`@("`@("`@("`@8G)E
M86L*("`@("`@("`@("`@("`@('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K970@
M*R`Q"B`@("`@("`@<F5T=7)N(')E<W5L=`H*8VQA<W,@4W1D2&%S:'1A8FQE
M271E<F%T;W(H271E<F%T;W(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&AA
M<V@I.@H@("`@("`@('-E;&8N;F]D92`](&AA<VA;)U]-7V)E9F]R95]B96=I
M;B==6R=?35]N>'0G70H@("`@("`@('-E;&8N;F]D95]T>7!E(#T@9FEN9%]T
M>7!E*&AA<V@N='EP92P@)U]?;F]D95]T>7!E)RDN<&]I;G1E<B@I"@H@("`@
M9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF"@H@("`@
M9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N;F]D92`]/2`P
M.@H@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@96QT
M(#T@<V5L9BYN;V1E+F-A<W0H<V5L9BYN;V1E7W1Y<&4I+F1E<F5F97)E;F-E
M*"D*("`@("`@("!S96QF+FYO9&4@/2!E;'1;)U]-7VYX="=="B`@("`@("`@
M=F%L<'1R(#T@96QT6R=?35]S=&]R86=E)UTN861D<F5S<PH@("`@("`@('9A
M;'!T<B`]('9A;'!T<BYC87-T*&5L="YT>7!E+G1E;7!L871E7V%R9W5M96YT
M*#`I+G!O:6YT97(H*2D*("`@("`@("!R971U<FX@=F%L<'1R+F1E<F5F97)E
M;F-E*"D*"F-L87-S(%1R,55N;W)D97)E9%-E=%!R:6YT97(Z"B`@("`B4')I
M;G0@82!T<C$Z.G5N;W)D97)E9%]S970B"@H@("`@9&5F(%]?:6YI=%]?("AS
M96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@
M<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S
M96QF+G9A;"`]('9A;`H*("`@(&1E9B!H87-H=&%B;&4@*'-E;&8I.@H@("`@
M("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S=VET:"@G<W1D.CIT<C$G*3H*
M("`@("`@("`@("`@<F5T=7)N('-E;&8N=F%L"B`@("`@("`@<F5T=7)N('-E
M;&8N=F%L6R=?35]H)UT*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@
M("`@("!C;W5N="`]('-E;&8N:&%S:'1A8FQE*"E;)U]-7V5L96UE;G1?8V]U
M;G0G70H@("`@("`@(')E='5R;B`G)7,@=VET:"`E<R<@)2`H<V5L9BYT>7!E
M;F%M92P@;G5M7V5L96UE;G1S*&-O=6YT*2D*"B`@("!`<W1A=&EC;65T:&]D
M"B`@("!D968@9F]R;6%T7V-O=6YT("AI*3H*("`@("`@("!R971U<FX@)ULE
M9%TG("4@:0H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@8V]U
M;G1E<B`](&EM87`@*'-E;&8N9F]R;6%T7V-O=6YT+"!I=&5R=&]O;',N8V]U
M;G0H*2D*("`@("`@("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H)W-T
M9#HZ='(Q)RDZ"B`@("`@("`@("`@(')E='5R;B!I>FEP("AC;W5N=&5R+"!4
M<C%(87-H=&%B;&5)=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI"B`@("`@
M("`@<F5T=7)N(&EZ:7`@*&-O=6YT97(L(%-T9$AA<VAT86)L94ET97)A=&]R
M("AS96QF+FAA<VAT86)L92@I*2D*"F-L87-S(%1R,55N;W)D97)E9$UA<%!R
M:6YT97(Z"B`@("`B4')I;G0@82!T<C$Z.G5N;W)D97)E9%]M87`B"@H@("`@
M9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S
M96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E
M;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!H87-H=&%B
M;&4@*'-E;&8I.@H@("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S=VET
M:"@G<W1D.CIT<C$G*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=F%L"B`@
M("`@("`@<F5T=7)N('-E;&8N=F%L6R=?35]H)UT*"B`@("!D968@=&]?<W1R
M:6YG("AS96QF*3H*("`@("`@("!C;W5N="`]('-E;&8N:&%S:'1A8FQE*"E;
M)U]-7V5L96UE;G1?8V]U;G0G70H@("`@("`@(')E='5R;B`G)7,@=VET:"`E
M<R<@)2`H<V5L9BYT>7!E;F%M92P@;G5M7V5L96UE;G1S*&-O=6YT*2D*"B`@
M("!`<W1A=&EC;65T:&]D"B`@("!D968@9FQA='1E;B`H;&ES="DZ"B`@("`@
M("`@9F]R(&5L="!I;B!L:7-T.@H@("`@("`@("`@("!F;W(@:2!I;B!E;'0Z
M"B`@("`@("`@("`@("`@("!Y:65L9"!I"@H@("`@0'-T871I8VUE=&AO9`H@
M("`@9&5F(&9O<FUA=%]O;F4@*&5L="DZ"B`@("`@("`@<F5T=7)N("AE;'1;
M)V9I<G-T)UTL(&5L=%LG<V5C;VYD)UTI"@H@("`@0'-T871I8VUE=&AO9`H@
M("`@9&5F(&9O<FUA=%]C;W5N="`H:2DZ"B`@("`@("`@<F5T=7)N("=;)61=
M)R`E(&D*"B`@("!D968@8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(&-O=6YT
M97(@/2!I;6%P("AS96QF+F9O<FUA=%]C;W5N="P@:71E<G1O;VQS+F-O=6YT
M*"DI"B`@("`@("`@(R!-87`@;W9E<B!T:&4@:&%S:"!T86)L92!A;F0@9FQA
M='1E;B!T:&4@<F5S=6QT+@H@("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A
M<G1S=VET:"@G<W1D.CIT<C$G*3H*("`@("`@("`@("`@9&%T82`]('-E;&8N
M9FQA='1E;B`H:6UA<"`H<V5L9BYF;W)M871?;VYE+"!4<C%(87-H=&%B;&5)
M=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI*0H@("`@("`@("`@("`C(%II
M<"!T:&4@='=O(&ET97)A=&]R<R!T;V=E=&AE<BX*("`@("`@("`@("`@<F5T
M=7)N(&EZ:7`@*&-O=6YT97(L(&1A=&$I"B`@("`@("`@9&%T82`]('-E;&8N
M9FQA='1E;B`H:6UA<"`H<V5L9BYF;W)M871?;VYE+"!3=&1(87-H=&%B;&5)
M=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI*0H@("`@("`@(",@6FEP('1H
M92!T=V\@:71E<F%T;W)S('1O9V5T:&5R+@H@("`@("`@(')E='5R;B!I>FEP
M("AC;W5N=&5R+"!D871A*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I
M.@H@("`@("`@(')E='5R;B`G;6%P)PH*8VQA<W,@4W1D1F]R=V%R9$QI<W10
M<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIF;W)W87)D7VQI<W0B"@H@("`@
M8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET
M7U\H<V5L9BP@;F]D971Y<&4L(&AE860I.@H@("`@("`@("`@("!S96QF+FYO
M9&5T>7!E(#T@;F]D971Y<&4*("`@("`@("`@("`@<V5L9BYB87-E(#T@:&5A
M9%LG7TU?;F5X="=="B`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@
M("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E
M;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I
M9B!S96QF+F)A<V4@/3T@,#H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)
M=&5R871I;VX*("`@("`@("`@("`@96QT(#T@<V5L9BYB87-E+F-A<W0H<V5L
M9BYN;V1E='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!S96QF+F)A
M<V4@/2!E;'1;)U]-7VYE>'0G70H@("`@("`@("`@("!C;W5N="`]('-E;&8N
M8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q
M"B`@("`@("`@("`@('9A;'!T<B`](&5L=%LG7TU?<W1O<F%G92==+F%D9')E
M<W,*("`@("`@("`@("`@=F%L<'1R(#T@=F%L<'1R+F-A<W0H96QT+G1Y<&4N
M=&5M<&QA=&5?87)G=6UE;G0H,"DN<&]I;G1E<B@I*0H@("`@("`@("`@("!R
M971U<FX@*"=;)61=)R`E(&-O=6YT+"!V86QP='(N9&5R969E<F5N8V4H*2D*
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@
M("`@<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R
M:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*"B`@("!D968@8VAI
M;&1R96XH<V5L9BDZ"B`@("`@("`@;F]D971Y<&4@/2!F:6YD7W1Y<&4H<V5L
M9BYV86PN='EP92P@)U].;V1E)RD*("`@("`@("!N;V1E='EP92`](&YO9&5T
M>7!E+G-T<FEP7W1Y<&5D969S*"DN<&]I;G1E<B@I"B`@("`@("`@<F5T=7)N
M('-E;&8N7VET97)A=&]R*&YO9&5T>7!E+"!S96QF+G9A;%LG7TU?:6UP;"==
M6R=?35]H96%D)UTI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@
M("!I9B!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]H96%D)UU;)U]-7VYE>'0G
M72`]/2`P.@H@("`@("`@("`@("!R971U<FX@)V5M<'1Y("5S)R`E('-E;&8N
M='EP96YA;64*("`@("`@("!R971U<FX@)R5S)R`E('-E;&8N='EP96YA;64*
M"F-L87-S(%-I;F=L94]B:D-O;G1A:6YE<E!R:6YT97(H;V)J96-T*3H*("`@
M(")"87-E(&-L87-S(&9O<B!P<FEN=&5R<R!O9B!C;VYT86EN97)S(&]F('-I
M;F=L92!O8FIE8W1S(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@=F%L+"!V
M:7HL(&AI;G0@/2!.;VYE*3H*("`@("`@("!S96QF+F-O;G1A:6YE9%]V86QU
M92`]('9A;`H@("`@("`@('-E;&8N=FES=6%L:7IE<B`]('9I>@H@("`@("`@
M('-E;&8N:&EN="`](&AI;G0*"B`@("!D968@7W)E8V]G;FEZ92AS96QF+"!T
M>7!E*3H*("`@("`@("`B(B)2971U<FX@5%E012!A<R!A('-T<FEN9R!A9G1E
M<B!A<'!L>6EN9R!T>7!E('!R:6YT97)S(B(B"B`@("`@("`@9VQO8F%L(%]U
M<V5?='EP95]P<FEN=&EN9PH@("`@("`@(&EF(&YO="!?=7-E7W1Y<&5?<')I
M;G1I;F<Z"B`@("`@("`@("`@(')E='5R;B!S='(H='EP92D*("`@("`@("!R
M971U<FX@9V1B+G1Y<&5S+F%P<&QY7W1Y<&5?<F5C;V=N:7IE<G,H9V1B+G1Y
M<&5S+F=E=%]T>7!E7W)E8V]G;FEZ97)S*"DL"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@('1Y<&4I(&]R('-T<BAT
M>7!E*0H*("`@(&-L87-S(%]C;VYT86EN960H271E<F%T;W(I.@H@("`@("`@
M(&1E9B!?7VEN:71?7R`H<V5L9BP@=F%L*3H*("`@("`@("`@("`@<V5L9BYV
M86P@/2!V86P*"B`@("`@("`@9&5F(%]?:71E<E]?("AS96QF*3H*("`@("`@
M("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I
M.@H@("`@("`@("`@("!I9B!S96QF+G9A;"!I<R!.;VYE.@H@("`@("`@("`@
M("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!R971V86P@
M/2!S96QF+G9A;`H@("`@("`@("`@("!S96QF+G9A;"`]($YO;F4*("`@("`@
M("`@("`@<F5T=7)N("@G6V-O;G1A:6YE9"!V86QU95TG+"!R971V86PI"@H@
M("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!I9B!S96QF+F-O;G1A
M:6YE9%]V86QU92!I<R!.;VYE.@H@("`@("`@("`@("!R971U<FX@<V5L9BY?
M8V]N=&%I;F5D("A.;VYE*0H@("`@("`@(&EF(&AA<V%T='(@*'-E;&8N=FES
M=6%L:7IE<BP@)V-H:6QD<F5N)RDZ"B`@("`@("`@("`@(')E='5R;B!S96QF
M+G9I<W5A;&EZ97(N8VAI;&1R96X@*"D*("`@("`@("!R971U<FX@<V5L9BY?
M8V]N=&%I;F5D("AS96QF+F-O;G1A:6YE9%]V86QU92D*"B`@("!D968@9&ES
M<&QA>5]H:6YT("AS96QF*3H*("`@("`@("`C(&EF(&-O;G1A:6YE9"!V86QU
M92!I<R!A(&UA<"!W92!W86YT('1O(&1I<W!L87D@:6X@=&AE('-A;64@=V%Y
M"B`@("`@("`@:68@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R
M96XG*2!A;F0@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G9&ES<&QA>5]H
M:6YT)RDZ"B`@("`@("`@("`@(')E='5R;B!S96QF+G9I<W5A;&EZ97(N9&ES
M<&QA>5]H:6YT("@I"B`@("`@("`@<F5T=7)N('-E;&8N:&EN=`H*8VQA<W,@
M4W1D17AP06YY4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0<FEN=&5R*3H*
M("`@(")0<FEN="!A('-T9#HZ86YY(&]R('-T9#HZ97AP97)I;65N=&%L.CIA
M;GDB"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*
M("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S
M<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<F4N<W5B
M*"=><W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V7&0Z.B<L("=S
M=&0Z.F5X<&5R:6UE;G1A;#HZ)RP@<V5L9BYT>7!E;F%M92P@,2D*("`@("`@
M("!S96QF+G9A;"`]('9A;`H@("`@("`@('-E;&8N8V]N=&%I;F5D7W1Y<&4@
M/2!.;VYE"B`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@3F]N90H@("`@("`@
M('9I<W5A;&EZ97(@/2!.;VYE"B`@("`@("`@;6=R(#T@<V5L9BYV86Q;)U]-
M7VUA;F%G97(G70H@("`@("`@(&EF(&UG<B`A/2`P.@H@("`@("`@("`@("!F
M=6YC(#T@9V1B+F)L;V-K7V9O<E]P8RAI;G0H;6=R+F-A<W0H9V1B+FQO;VMU
M<%]T>7!E*"=I;G1P=')?="<I*2DI"B`@("`@("`@("`@(&EF(&YO="!F=6YC
M.@H@("`@("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@B26YV86QI9"!F
M=6YC=&EO;B!P;VEN=&5R(&EN("5S(B`E('-E;&8N='EP96YA;64I"B`@("`@
M("`@("`@(')X(#T@<B(B(BA[,'TZ.E]-86YA9V5R7UQW*SPN*CXI.CI?4U]M
M86YA9V5<*"AE;G5M("D_>S!].CI?3W`L("AC;VYS="![,'U\>S!](&-O;G-T
M*2`_7"HL("AU;FEO;B`I/WLP?3HZ7T%R9R`_7"I<*2(B(BYF;W)M870H='EP
M96YA;64I"B`@("`@("`@("`@(&T@/2!R92YM871C:"AR>"P@9G5N8RYF=6YC
M=&EO;BYN86UE*0H@("`@("`@("`@("!I9B!N;W0@;3H*("`@("`@("`@("`@
M("`@(')A:7-E(%9A;'5E17)R;W(H(E5N:VYO=VX@;6%N86=E<B!F=6YC=&EO
M;B!I;B`E<R(@)2!S96QF+G1Y<&5N86UE*0H*("`@("`@("`@("`@;6=R;F%M
M92`](&TN9W)O=7`H,2D*("`@("`@("`@("`@(R!&25A-12!N965D('1O(&5X
M<&%N9"`G<W1D.CIS=')I;F<G('-O('1H870@9V1B+FQO;VMU<%]T>7!E('=O
M<FMS"B`@("`@("`@("`@(&EF("=S=&0Z.G-T<FEN9R<@:6X@;6=R;F%M93H*
M("`@("`@("`@("`@("`@(&UG<FYA;64@/2!R92YS=6(H(G-T9#HZ<W1R:6YG
M*#\A7'<I(BP@<W1R*&=D8BYL;V]K=7!?='EP92@G<W1D.CIS=')I;F<G*2YS
M=')I<%]T>7!E9&5F<R@I*2P@;2YG<F]U<"@Q*2D*"B`@("`@("`@("`@(&UG
M<G1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H;6=R;F%M92D*("`@("`@("`@("`@
M<V5L9BYC;VYT86EN961?='EP92`](&UG<G1Y<&4N=&5M<&QA=&5?87)G=6UE
M;G0H,"D*("`@("`@("`@("`@=F%L<'1R(#T@3F]N90H@("`@("`@("`@("!I
M9B`G.CI?36%N86=E<E]I;G1E<FYA;"<@:6X@;6=R;F%M93H*("`@("`@("`@
M("`@("`@('9A;'!T<B`]('-E;&8N=F%L6R=?35]S=&]R86=E)UU;)U]-7V)U
M9F9E<B==+F%D9')E<W,*("`@("`@("`@("`@96QI9B`G.CI?36%N86=E<E]E
M>'1E<FYA;"<@:6X@;6=R;F%M93H*("`@("`@("`@("`@("`@('9A;'!T<B`]
M('-E;&8N=F%L6R=?35]S=&]R86=E)UU;)U]-7W!T<B=="B`@("`@("`@("`@
M(&5L<V4Z"B`@("`@("`@("`@("`@("!R86ES92!686QU945R<F]R*")5;FMN
M;W=N(&UA;F%G97(@9G5N8W1I;VX@:6X@)7,B("4@<V5L9BYT>7!E;F%M92D*
M("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@=F%L<'1R+F-A<W0H<V5L
M9BYC;VYT86EN961?='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*("`@
M("`@("`@("`@=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H
M8V]N=&%I;F5D7W9A;'5E*0H@("`@("`@('-U<&5R*%-T9$5X<$%N>5!R:6YT
M97(L('-E;&8I+E]?:6YI=%]?("AC;VYT86EN961?=F%L=64L('9I<W5A;&EZ
M97(I"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@:68@<V5L
M9BYC;VYT86EN961?='EP92!I<R!.;VYE.@H@("`@("`@("`@("!R971U<FX@
M)R5S(%MN;R!C;VYT86EN960@=F%L=65=)R`E('-E;&8N='EP96YA;64*("`@
M("`@("!D97-C(#T@(B5S(&-O;G1A:6YI;F<@(B`E('-E;&8N='EP96YA;64*
M("`@("`@("!I9B!H87-A='1R("AS96QF+G9I<W5A;&EZ97(L("=C:&EL9')E
M;B<I.@H@("`@("`@("`@("!R971U<FX@9&5S8R`K('-E;&8N=FES=6%L:7IE
M<BYT;U]S=')I;F<@*"D*("`@("`@("!V86QT>7!E(#T@<V5L9BY?<F5C;V=N
M:7IE("AS96QF+F-O;G1A:6YE9%]T>7!E*0H@("`@("`@(')E='5R;B!D97-C
M("L@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AS='(H=F%L='EP92DI"@IC
M;&%S<R!3=&1%>'!/<'1I;VYA;%!R:6YT97(H4VEN9VQE3V)J0V]N=&%I;F5R
M4')I;G1E<BDZ"B`@("`B4')I;G0@82!S=&0Z.F]P=&EO;F%L(&]R('-T9#HZ
M97AP97)I;65N=&%L.CIO<'1I;VYA;"(*"B`@("!D968@7U]I;FET7U\@*'-E
M;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('9A;'1Y<&4@/2!S96QF+E]R
M96-O9VYI>F4@*'9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I*0H@("`@
M("`@('1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E
M;F%M92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<F4N<W5B*"=><W1D.CHH
M97AP97)I;65N=&%L.CI\*2AF=6YD86UE;G1A;'-?=EQD.CI\*2@N*BDG+"!R
M)W-T9#HZ7#%<,SPE<SXG("4@=F%L='EP92P@='EP96YA;64L(#$I"B`@("`@
M("`@<&%Y;&]A9"`]('9A;%LG7TU?<&%Y;&]A9"=="B`@("`@("`@:68@<V5L
M9BYT>7!E;F%M92YS=&%R='-W:71H*"=S=&0Z.F5X<&5R:6UE;G1A;"<I.@H@
M("`@("`@("`@("!E;F=A9V5D(#T@=F%L6R=?35]E;F=A9V5D)UT*("`@("`@
M("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@<&%Y;&]A9`H@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@(&5N9V%G960@/2!P87EL;V%D6R=?35]E;F=A9V5D)UT*
M("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@<&%Y;&]A9%LG7TU?<&%Y
M;&]A9"=="B`@("`@("`@("`@('1R>3H*("`@("`@("`@("`@("`@(",@4VEN
M8V4@1T-#(#D*("`@("`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`](&-O
M;G1A:6YE9%]V86QU95LG7TU?=F%L=64G70H@("`@("`@("`@("!E>&-E<'0Z
M"B`@("`@("`@("`@("`@("!P87-S"B`@("`@("`@=FES=6%L:7IE<B`](&=D
M8BYD969A=6QT7W9I<W5A;&EZ97(@*&-O;G1A:6YE9%]V86QU92D*("`@("`@
M("!I9B!N;W0@96YG86=E9#H*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E
M(#T@3F]N90H@("`@("`@('-U<&5R("A3=&1%>'!/<'1I;VYA;%!R:6YT97(L
M('-E;&8I+E]?:6YI=%]?("AC;VYT86EN961?=F%L=64L('9I<W5A;&EZ97(I
M"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYC
M;VYT86EN961?=F%L=64@:7,@3F]N93H*("`@("`@("`@("`@<F5T=7)N("(E
M<R!;;F\@8V]N=&%I;F5D('9A;'5E72(@)2!S96QF+G1Y<&5N86UE"B`@("`@
M("`@:68@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG*3H*
M("`@("`@("`@("`@<F5T=7)N("(E<R!C;VYT86EN:6YG("5S(B`E("AS96QF
M+G1Y<&5N86UE+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@('-E;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H*2D*("`@("`@("!R
M971U<FX@<V5L9BYT>7!E;F%M90H*8VQA<W,@4W1D5F%R:6%N=%!R:6YT97(H
M4VEN9VQE3V)J0V]N=&%I;F5R4')I;G1E<BDZ"B`@("`B4')I;G0@82!S=&0Z
M.G9A<FEA;G0B"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V
M86PI.@H@("`@("`@(&%L=&5R;F%T:79E<R`](&=E=%]T96UP;&%T95]A<F=?
M;&ES="AV86PN='EP92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?
M=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G1Y
M<&5N86UE(#T@(B5S/"5S/B(@)2`H<V5L9BYT>7!E;F%M92P@)RP@)RYJ;VEN
M*%MS96QF+E]R96-O9VYI>F4H86QT*2!F;W(@86QT(&EN(&%L=&5R;F%T:79E
M<UTI*0H@("`@("`@('-E;&8N:6YD97@@/2!V86Q;)U]-7VEN9&5X)UT*("`@
M("`@("!I9B!S96QF+FEN9&5X(#X](&QE;BAA;'1E<FYA=&EV97,I.@H@("`@
M("`@("`@("!S96QF+F-O;G1A:6YE9%]T>7!E(#T@3F]N90H@("`@("`@("`@
M("!C;VYT86EN961?=F%L=64@/2!.;VYE"B`@("`@("`@("`@('9I<W5A;&EZ
M97(@/2!.;VYE"B`@("`@("`@96QS93H*("`@("`@("`@("`@<V5L9BYC;VYT
M86EN961?='EP92`](&%L=&5R;F%T:79E<UMI;G0H<V5L9BYI;F1E>"E="B`@
M("`@("`@("`@(&%D9'(@/2!V86Q;)U]-7W4G75LG7TU?9FER<W0G75LG7TU?
M<W1O<F%G92==+F%D9')E<W,*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E
M(#T@861D<BYC87-T*'-E;&8N8V]N=&%I;F5D7W1Y<&4N<&]I;G1E<B@I*2YD
M97)E9F5R96YC92@I"B`@("`@("`@("`@('9I<W5A;&EZ97(@/2!G9&(N9&5F
M875L=%]V:7-U86QI>F5R*&-O;G1A:6YE9%]V86QU92D*("`@("`@("!S=7!E
M<B`H4W1D5F%R:6%N=%!R:6YT97(L('-E;&8I+E]?:6YI=%]?*&-O;G1A:6YE
M9%]V86QU92P@=FES=6%L:7IE<BP@)V%R<F%Y)RD*"B`@("!D968@=&]?<W1R
M:6YG*'-E;&8I.@H@("`@("`@(&EF('-E;&8N8V]N=&%I;F5D7W9A;'5E(&ES
M($YO;F4Z"B`@("`@("`@("`@(')E='5R;B`B)7,@6VYO(&-O;G1A:6YE9"!V
M86QU95TB("4@<V5L9BYT>7!E;F%M90H@("`@("`@(&EF(&AA<V%T='(H<V5L
M9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG*3H*("`@("`@("`@("`@<F5T=7)N
M("(E<R!;:6YD97@@)61=(&-O;G1A:6YI;F<@)7,B("4@*'-E;&8N='EP96YA
M;64L('-E;&8N:6YD97@L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("!S96QF+G9I<W5A;&EZ97(N=&]?<W1R
M:6YG*"DI"B`@("`@("`@<F5T=7)N("(E<R!;:6YD97@@)61=(B`E("AS96QF
M+G1Y<&5N86UE+"!S96QF+FEN9&5X*0H*8VQA<W,@4W1D3F]D94AA;F1L95!R
M:6YT97(H4VEN9VQE3V)J0V]N=&%I;F5R4')I;G1E<BDZ"B`@("`B4')I;G0@
M82!C;VYT86EN97(@;F]D92!H86YD;&4B"@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L=65?='EP92`]
M('9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#$I"B`@("`@("`@;F]D971Y
M<&4@/2!V86PN='EP92YT96UP;&%T95]A<F=U;65N="@R*2YT96UP;&%T95]A
M<F=U;65N="@P*0H@("`@("`@('-E;&8N:7-?<F)?=')E95]N;V1E(#T@:7-?
M<W!E8VEA;&EZ871I;VY?;V8H;F]D971Y<&4N;F%M92P@)U]28E]T<F5E7VYO
M9&4G*0H@("`@("`@('-E;&8N:7-?;6%P7VYO9&4@/2!V86PN='EP92YT96UP
M;&%T95]A<F=U;65N="@P*2`A/2!S96QF+G9A;'5E7W1Y<&4*("`@("`@("!N
M;V1E<'1R(#T@=F%L6R=?35]P='(G70H@("`@("`@(&EF(&YO9&5P='(Z"B`@
M("`@("`@("`@(&EF('-E;&8N:7-?<F)?=')E95]N;V1E.@H@("`@("`@("`@
M("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@9V5T7W9A;'5E7V9R;VU?4F)?=')E
M95]N;V1E*&YO9&5P='(N9&5R969E<F5N8V4H*2D*("`@("`@("`@("`@96QS
M93H*("`@("`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`](&=E=%]V86QU
M95]F<F]M7V%L:6=N961?;65M8G5F*&YO9&5P=');)U]-7W-T;W)A9V4G72P*
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@('-E;&8N=F%L=65?='EP92D*("`@("`@("`@
M("`@=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H8V]N=&%I
M;F5D7W9A;'5E*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(&-O;G1A:6YE
M9%]V86QU92`]($YO;F4*("`@("`@("`@("`@=FES=6%L:7IE<B`]($YO;F4*
M("`@("`@("!O<'1A;&QO8R`]('9A;%LG7TU?86QL;V,G70H@("`@("`@('-E
M;&8N86QL;V,@/2!O<'1A;&QO8ULG7TU?<&%Y;&]A9"==(&EF(&]P=&%L;&]C
M6R=?35]E;F=A9V5D)UT@96QS92!.;VYE"B`@("`@("`@<W5P97(H4W1D3F]D
M94AA;F1L95!R:6YT97(L('-E;&8I+E]?:6YI=%]?*&-O;G1A:6YE9%]V86QU
M92P@=FES=6%L:7IE<BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@)V%R<F%Y)RD*"B`@("!D968@=&]?<W1R
M:6YG*'-E;&8I.@H@("`@("`@(&1E<V,@/2`G;F]D92!H86YD;&4@9F]R("<*
M("`@("`@("!I9B!N;W0@<V5L9BYI<U]R8E]T<F5E7VYO9&4Z"B`@("`@("`@
M("`@(&1E<V,@*ST@)W5N;W)D97)E9"`G"B`@("`@("`@:68@<V5L9BYI<U]M
M87!?;F]D93H*("`@("`@("`@("`@9&5S8R`K/2`G;6%P)SL*("`@("`@("!E
M;'-E.@H@("`@("`@("`@("!D97-C("L]("=S970G.PH*("`@("`@("!I9B!S
M96QF+F-O;G1A:6YE9%]V86QU93H*("`@("`@("`@("`@9&5S8R`K/2`G('=I
M=&@@96QE;65N="<*("`@("`@("`@("`@:68@:&%S871T<BAS96QF+G9I<W5A
M;&EZ97(L("=C:&EL9')E;B<I.@H@("`@("`@("`@("`@("`@<F5T=7)N("(E
M<R`]("5S(B`E("AD97-C+"!S96QF+G9I<W5A;&EZ97(N=&]?<W1R:6YG*"DI
M"B`@("`@("`@("`@(')E='5R;B!D97-C"B`@("`@("`@96QS93H*("`@("`@
M("`@("`@<F5T=7)N("=E;7!T>2`E<R<@)2!D97-C"@IC;&%S<R!3=&1%>'!3
M=')I;F=6:65W4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ8F%S:6-?<W1R
M:6YG7W9I97<@;W(@<W1D.CIE>'!E<FEM96YT86PZ.F)A<VEC7W-T<FEN9U]V
M:65W(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ
M"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS
M96QF*3H*("`@("`@("!P='(@/2!S96QF+G9A;%LG7TU?<W1R)UT*("`@("`@
M("!L96X@/2!S96QF+G9A;%LG7TU?;&5N)UT*("`@("`@("!I9B!H87-A='1R
M("AP='(L(")L87IY7W-T<FEN9R(I.@H@("`@("`@("`@("!R971U<FX@<'1R
M+FQA>GE?<W1R:6YG("AL96YG=&@@/2!L96XI"B`@("`@("`@<F5T=7)N('!T
M<BYS=')I;F<@*&QE;F=T:"`](&QE;BD*"B`@("!D968@9&ES<&QA>5]H:6YT
M("AS96QF*3H*("`@("`@("!R971U<FX@)W-T<FEN9R<*"F-L87-S(%-T9$5X
M<%!A=&A0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIE>'!E<FEM96YT86PZ
M.F9I;&5S>7-T96TZ.G!A=&@B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T
M>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@
M('-T87)T(#T@<V5L9BYV86Q;)U]-7V-M<'1S)UU;)U]-7VEM<&PG75LG7TU?
M<W1A<G0G70H@("`@("`@(&9I;FES:"`]('-E;&8N=F%L6R=?35]C;7!T<R==
M6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="B`@("`@("`@<V5L9BYN=6U?8VUP
M=',@/2!I;G0@*&9I;FES:"`M('-T87)T*0H*("`@(&1E9B!?<&%T:%]T>7!E
M*'-E;&8I.@H@("`@("`@('0@/2!S='(H<V5L9BYV86Q;)U]-7W1Y<&4G72D*
M("`@("`@("!I9B!T6RTY.ET@/3T@)U]2;V]T7V1I<B<Z"B`@("`@("`@("`@
M(')E='5R;B`B<F]O="UD:7)E8W1O<GDB"B`@("`@("`@:68@=%LM,3`Z72`]
M/2`G7U)O;W1?;F%M92<Z"B`@("`@("`@("`@(')E='5R;B`B<F]O="UN86UE
M(@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L
M9BDZ"B`@("`@("`@<&%T:"`]("(E<R(@)2!S96QF+G9A;"!;)U]-7W!A=&AN
M86UE)UT*("`@("`@("!I9B!S96QF+FYU;5]C;7!T<R`]/2`P.@H@("`@("`@
M("`@("!T(#T@<V5L9BY?<&%T:%]T>7!E*"D*("`@("`@("`@("`@:68@=#H*
M("`@("`@("`@("`@("`@('!A=&@@/2`G)7,@6R5S72<@)2`H<&%T:"P@="D*
M("`@("`@("!R971U<FX@(F9I;&5S>7-T96TZ.G!A=&@@)7,B("4@<&%T:`H*
M("`@(&-L87-S(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?
M:6YI=%]?*'-E;&8L(&-M<'1S*3H*("`@("`@("`@("`@<V5L9BYI=&5M(#T@
M8VUP='-;)U]-7VEM<&PG75LG7TU?<W1A<G0G70H@("`@("`@("`@("!S96QF
M+F9I;FES:"`](&-M<'1S6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="B`@("`@
M("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?7RAS
M96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?
M;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF+FET96T@/3T@<V5L
M9BYF:6YI<V@Z"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N
M"B`@("`@("`@("`@(&ET96T@/2!S96QF+FET96TN9&5R969E<F5N8V4H*0H@
M("`@("`@("`@("!C;W5N="`]('-E;&8N8V]U;G0*("`@("`@("`@("`@<V5L
M9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@("`@('-E;&8N:71E
M;2`]('-E;&8N:71E;2`K(#$*("`@("`@("`@("`@<&%T:"`](&ET96U;)U]-
M7W!A=&AN86UE)UT*("`@("`@("`@("`@="`](%-T9$5X<%!A=&A0<FEN=&5R
M*&ET96TN='EP92YN86UE+"!I=&5M*2Y?<&%T:%]T>7!E*"D*("`@("`@("`@
M("`@:68@;F]T('0Z"B`@("`@("`@("`@("`@("!T(#T@8V]U;G0*("`@("`@
M("`@("`@<F5T=7)N("@G6R5S72<@)2!T+"!P871H*0H*("`@(&1E9B!C:&EL
M9')E;BAS96QF*3H*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T;W(H<V5L
M9BYV86Q;)U]-7V-M<'1S)UTI"@IC;&%S<R!3=&10871H4')I;G1E<CH*("`@
M(")0<FEN="!A('-T9#HZ9FEL97-Y<W1E;3HZ<&%T:"(*"B`@("!D968@7U]I
M;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L
M(#T@=F%L"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('1Y<&5N86UE"B`@("`@
M("`@:6UP;"`]('-E;&8N=F%L6R=?35]C;7!T<R==6R=?35]I;7!L)UU;)U]-
M7W0G75LG7TU?="==6R=?35]H96%D7VEM<&PG70H@("`@("`@('-E;&8N='EP
M92`](&EM<&PN8V%S="AG9&(N;&]O:W5P7W1Y<&4H)W5I;G1P=')?="<I*2`F
M(#,*("`@("`@("!I9B!S96QF+G1Y<&4@/3T@,#H*("`@("`@("`@("`@<V5L
M9BYI;7!L(#T@:6UP;`H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N
M:6UP;"`]($YO;F4*"B`@("!D968@7W!A=&A?='EP92AS96QF*3H*("`@("`@
M("!T(#T@<W1R*'-E;&8N='EP92YC87-T*&=D8BYL;V]K=7!?='EP92AS96QF
M+G1Y<&5N86UE("L@)SHZ7U1Y<&4G*2DI"B`@("`@("`@:68@=%LM.3I=(#T]
M("=?4F]O=%]D:7(G.@H@("`@("`@("`@("!R971U<FX@(G)O;W0M9&ER96-T
M;W)Y(@H@("`@("`@(&EF('1;+3$P.ET@/3T@)U]2;V]T7VYA;64G.@H@("`@
M("`@("`@("!R971U<FX@(G)O;W0M;F%M92(*("`@("`@("!R971U<FX@3F]N
M90H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@('!A=&@@/2`B
M)7,B("4@<V5L9BYV86P@6R=?35]P871H;F%M92=="B`@("`@("`@:68@<V5L
M9BYT>7!E("$](#`Z"B`@("`@("`@("`@('0@/2!S96QF+E]P871H7W1Y<&4H
M*0H@("`@("`@("`@("!I9B!T.@H@("`@("`@("`@("`@("`@<&%T:"`]("<E
M<R!;)7-=)R`E("AP871H+"!T*0H@("`@("`@(')E='5R;B`B9FEL97-Y<W1E
M;3HZ<&%T:"`E<R(@)2!P871H"@H@("`@8VQA<W,@7VET97)A=&]R*$ET97)A
M=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@:6UP;"P@<&%T:'1Y
M<&4I.@H@("`@("`@("`@("!I9B!I;7!L.@H@("`@("`@("`@("`@("`@(R!7
M92!C86XG="!A8V-E<W,@7TEM<&PZ.E]-7W-I>F4@8F5C875S92!?26UP;"!I
M<R!I;F-O;7!L971E"B`@("`@("`@("`@("`@("`C('-O(&-A<W0@=&\@:6YT
M*B!T;R!A8V-E<W,@=&AE(%]-7W-I>F4@;65M8F5R(&%T(&]F9G-E="!Z97)O
M+`H@("`@("`@("`@("`@("`@:6YT7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H
M)VEN="<I"B`@("`@("`@("`@("`@("!C;7!T7W1Y<&4@/2!G9&(N;&]O:W5P
M7W1Y<&4H<&%T:'1Y<&4K)SHZ7T-M<'0G*0H@("`@("`@("`@("`@("`@8VAA
M<E]T>7!E(#T@9V1B+FQO;VMU<%]T>7!E*"=C:&%R)RD*("`@("`@("`@("`@
M("`@(&EM<&P@/2!I;7!L+F-A<W0H:6YT7W1Y<&4N<&]I;G1E<B@I*0H@("`@
M("`@("`@("`@("`@<VEZ92`](&EM<&PN9&5R969E<F5N8V4H*0H@("`@("`@
M("`@("`@("`@(W-E;&8N8V%P86-I='D@/2`H:6UP;"`K(#$I+F1E<F5F97)E
M;F-E*"D*("`@("`@("`@("`@("`@(&EF(&AA<V%T='(H9V1B+E1Y<&4L("=A
M;&EG;F]F)RDZ"B`@("`@("`@("`@("`@("`@("`@<VEZ96]F7TEM<&P@/2!M
M87@H,B`J(&EN=%]T>7!E+G-I>F5O9BP@8VUP=%]T>7!E+F%L:6=N;V8I"B`@
M("`@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@("`@('-I>F5O
M9E]);7!L(#T@,B`J(&EN=%]T>7!E+G-I>F5O9@H@("`@("`@("`@("`@("`@
M8F5G:6X@/2!I;7!L+F-A<W0H8VAA<E]T>7!E+G!O:6YT97(H*2D@*R!S:7IE
M;V9?26UP;`H@("`@("`@("`@("`@("`@<V5L9BYI=&5M(#T@8F5G:6XN8V%S
M="AC;7!T7W1Y<&4N<&]I;G1E<B@I*0H@("`@("`@("`@("`@("`@<V5L9BYF
M:6YI<V@@/2!S96QF+FET96T@*R!S:7IE"B`@("`@("`@("`@("`@("!S96QF
M+F-O=6YT(#T@,`H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@
M<V5L9BYI=&5M(#T@3F]N90H@("`@("`@("`@("`@("`@<V5L9BYF:6YI<V@@
M/2!.;VYE"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@
M("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@
M("`@("`@("`@("!I9B!S96QF+FET96T@/3T@<V5L9BYF:6YI<V@Z"B`@("`@
M("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@(&ET
M96T@/2!S96QF+FET96TN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!C;W5N
M="`]('-E;&8N8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N
M8V]U;G0@*R`Q"B`@("`@("`@("`@('-E;&8N:71E;2`]('-E;&8N:71E;2`K
M(#$*("`@("`@("`@("`@<&%T:"`](&ET96U;)U]-7W!A=&AN86UE)UT*("`@
M("`@("`@("`@="`](%-T9%!A=&A0<FEN=&5R*&ET96TN='EP92YN86UE+"!I
M=&5M*2Y?<&%T:%]T>7!E*"D*("`@("`@("`@("`@:68@;F]T('0Z"B`@("`@
M("`@("`@("`@("!T(#T@8V]U;G0*("`@("`@("`@("`@<F5T=7)N("@G6R5S
M72<@)2!T+"!P871H*0H*("`@(&1E9B!C:&EL9')E;BAS96QF*3H*("`@("`@
M("!R971U<FX@<V5L9BY?:71E<F%T;W(H<V5L9BYI;7!L+"!S96QF+G1Y<&5N
M86UE*0H*"F-L87-S(%-T9%!A:7)0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D
M.CIP86ER(&]B:F5C="P@=VET:"`G9FER<W0G(&%N9"`G<V5C;VYD)R!A<R!C
M:&EL9')E;B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A
M;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!C;&%S<R!?:71E<BA)
M=&5R871O<BDZ"B`@("`@("`@(D%N(&ET97)A=&]R(&9O<B!S=&0Z.G!A:7(@
M='EP97,N(%)E='5R;G,@)V9I<G-T)R!T:&5N("=S96-O;F0G+B(*"B`@("`@
M("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;"DZ"B`@("`@("`@("`@('-E;&8N
M=F%L(#T@=F%L"B`@("`@("`@("`@('-E;&8N=VAI8V@@/2`G9FER<W0G"@H@
M("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N
M('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@
M("!I9B!S96QF+G=H:6-H(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!R86ES
M92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@('=H:6-H(#T@<V5L9BYW:&EC
M:`H@("`@("`@("`@("!I9B!W:&EC:"`]/2`G9FER<W0G.@H@("`@("`@("`@
M("`@("`@<V5L9BYW:&EC:"`]("=S96-O;F0G"B`@("`@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@("`@("!S96QF+G=H:6-H(#T@3F]N90H@("`@("`@("`@
M("!R971U<FX@*'=H:6-H+"!S96QF+G9A;%MW:&EC:%TI"@H@("`@9&5F(&-H
M:6QD<F5N*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R*'-E;&8N
M=F%L*0H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@<F5T=7)N
M($YO;F4*"@HC($$@(G)E9W5L87(@97AP<F5S<VEO;B(@<')I;G1E<B!W:&EC
M:"!C;VYF;W)M<R!T;R!T:&4*(R`B4W5B4')E='1Y4')I;G1E<B(@<')O=&]C
M;VP@9G)O;2!G9&(N<')I;G1I;F<N"F-L87-S(%)X4')I;G1E<BAO8FIE8W0I
M.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YA;64L(&9U;F-T:6]N*3H*("`@
M("`@("!S=7!E<BA2>%!R:6YT97(L('-E;&8I+E]?:6YI=%]?*"D*("`@("`@
M("!S96QF+FYA;64@/2!N86UE"B`@("`@("`@<V5L9BYF=6YC=&EO;B`](&9U
M;F-T:6]N"B`@("`@("`@<V5L9BYE;F%B;&5D(#T@5')U90H*("`@(&1E9B!I
M;G9O:V4H<V5L9BP@=F%L=64I.@H@("`@("`@(&EF(&YO="!S96QF+F5N86)L
M960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@(&EF('9A;'5E
M+G1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@("`@
M:68@:&%S871T<BAG9&(N5F%L=64L(G)E9F5R96YC961?=F%L=64B*3H*("`@
M("`@("`@("`@("`@('9A;'5E(#T@=F%L=64N<F5F97)E;F-E9%]V86QU92@I
M"@H@("`@("`@(')E='5R;B!S96QF+F9U;F-T:6]N*'-E;&8N;F%M92P@=F%L
M=64I"@HC($$@<')E='1Y+7!R:6YT97(@=&AA="!C;VYF;W)M<R!T;R!T:&4@
M(E!R971T>5!R:6YT97(B('!R;W1O8V]L(&9R;VT*(R!G9&(N<')I;G1I;F<N
M("!)="!C86X@86QS;R!B92!U<V5D(&1I<F5C=&QY(&%S(&%N(&]L9"US='EL
M92!P<FEN=&5R+@IC;&%S<R!0<FEN=&5R*&]B:F5C="DZ"B`@("!D968@7U]I
M;FET7U\H<V5L9BP@;F%M92DZ"B`@("`@("`@<W5P97(H4')I;G1E<BP@<V5L
M9BDN7U]I;FET7U\H*0H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@
M("!S96QF+G-U8G!R:6YT97)S(#T@6UT*("`@("`@("!S96QF+FQO;VMU<"`]
M('M]"B`@("`@("`@<V5L9BYE;F%B;&5D(#T@5')U90H@("`@("`@('-E;&8N
M8V]M<&EL961?<G@@/2!R92YC;VUP:6QE*"=>*%MA+7I!+5HP+3E?.ETK*2@\
M+BH^*3\D)RD*"B`@("!D968@861D*'-E;&8L(&YA;64L(&9U;F-T:6]N*3H*
M("`@("`@("`C($$@<VUA;&P@<V%N:71Y(&-H96-K+@H@("`@("`@(",@1DE8
M344*("`@("`@("!I9B!N;W0@<V5L9BYC;VUP:6QE9%]R>"YM871C:"AN86UE
M*3H*("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@G;&EB<W1D8RLK('!R
M;V=R86UM:6YG(&5R<F]R.B`B)7,B(&1O97,@;F]T(&UA=&-H)R`E(&YA;64I
M"B`@("`@("`@<')I;G1E<B`](%)X4')I;G1E<BAN86UE+"!F=6YC=&EO;BD*
M("`@("`@("!S96QF+G-U8G!R:6YT97)S+F%P<&5N9"AP<FEN=&5R*0H@("`@
M("`@('-E;&8N;&]O:W5P6VYA;65=(#T@<')I;G1E<@H*("`@(",@061D(&$@
M;F%M92!U<VEN9R!?1TQ)0D-86%]"14=)3E].04U%4U!!0T5?5D524TE/3BX*
M("`@(&1E9B!A9&1?=F5R<VEO;BAS96QF+"!B87-E+"!N86UE+"!F=6YC=&EO
M;BDZ"B`@("`@("`@<V5L9BYA9&0H8F%S92`K(&YA;64L(&9U;F-T:6]N*0H@
M("`@("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@("`@("!V
M8F%S92`](')E+G-U8B@G7BAS=&1\7U]G;G5?8WAX*3HZ)RP@<B=<9SPP/B5S
M)R`E(%]V97)S:6]N961?;F%M97-P86-E+"!B87-E*0H@("`@("`@("`@("!S
M96QF+F%D9"AV8F%S92`K(&YA;64L(&9U;F-T:6]N*0H*("`@(",@061D(&$@
M;F%M92!U<VEN9R!?1TQ)0D-86%]"14=)3E].04U%4U!!0T5?0T].5$%)3D52
M+@H@("`@9&5F(&%D9%]C;VYT86EN97(H<V5L9BP@8F%S92P@;F%M92P@9G5N
M8W1I;VXI.@H@("`@("`@('-E;&8N861D7W9E<G-I;VXH8F%S92P@;F%M92P@
M9G5N8W1I;VXI"B`@("`@("`@<V5L9BYA9&1?=F5R<VEO;BAB87-E("L@)U]?
M8WAX,3DY.#HZ)RP@;F%M92P@9G5N8W1I;VXI"@H@("`@0'-T871I8VUE=&AO
M9`H@("`@9&5F(&=E=%]B87-I8U]T>7!E*'1Y<&4I.@H@("`@("`@(",@268@
M:70@<&]I;G1S('1O(&$@<F5F97)E;F-E+"!G970@=&AE(')E9F5R96YC92X*
M("`@("`@("!I9B!T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]2148Z"B`@
M("`@("`@("`@('1Y<&4@/2!T>7!E+G1A<F=E="`H*0H*("`@("`@("`C($=E
M="!T:&4@=6YQ=6%L:69I960@='EP92P@<W1R:7!P960@;V8@='EP961E9G,N
M"B`@("`@("`@='EP92`]('1Y<&4N=6YQ=6%L:69I960@*"DN<W1R:7!?='EP
M961E9G,@*"D*"B`@("`@("`@<F5T=7)N('1Y<&4N=&%G"@H@("`@9&5F(%]?
M8V%L;%]?*'-E;&8L('9A;"DZ"B`@("`@("`@='EP96YA;64@/2!S96QF+F=E
M=%]B87-I8U]T>7!E*'9A;"YT>7!E*0H@("`@("`@(&EF(&YO="!T>7!E;F%M
M93H*("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@(R!!;&P@=&AE
M('1Y<&5S('=E(&UA=&-H(&%R92!T96UP;&%T92!T>7!E<RP@<V\@=V4@8V%N
M('5S92!A"B`@("`@("`@(R!D:6-T:6]N87)Y+@H@("`@("`@(&UA=&-H(#T@
M<V5L9BYC;VUP:6QE9%]R>"YM871C:"AT>7!E;F%M92D*("`@("`@("!I9B!N
M;W0@;6%T8V@Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@(&)A
M<V5N86UE(#T@;6%T8V@N9W)O=7`H,2D*"B`@("`@("`@:68@=F%L+G1Y<&4N
M8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@("`@:68@:&%S
M871T<BAG9&(N5F%L=64L(G)E9F5R96YC961?=F%L=64B*3H*("`@("`@("`@
M("`@("`@('9A;"`]('9A;"YR969E<F5N8V5D7W9A;'5E*"D*"B`@("`@("`@
M:68@8F%S96YA;64@:6X@<V5L9BYL;V]K=7`Z"B`@("`@("`@("`@(')E='5R
M;B!S96QF+FQO;VMU<%MB87-E;F%M95TN:6YV;VME*'9A;"D*"B`@("`@("`@
M(R!#86YN;W0@9FEN9"!A('!R971T>2!P<FEN=&5R+B`@4F5T=7)N($YO;F4N
M"B`@("`@("`@<F5T=7)N($YO;F4*"FQI8G-T9&-X>%]P<FEN=&5R(#T@3F]N
M90H*8VQA<W,@5&5M<&QA=&54>7!E4')I;G1E<BAO8FIE8W0I.@H@("`@<B(B
M(@H@("`@02!T>7!E('!R:6YT97(@9F]R(&-L87-S('1E;7!L871E<R!W:71H
M(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G1S+@H*("`@(%)E8V]G;FEZ97,@
M<W!E8VEA;&EZ871I;VYS(&]F(&-L87-S('1E;7!L871E<R!A;F0@<')I;G1S
M('1H96T@=VET:&]U=`H@("`@86YY('1E;7!L871E(&%R9W5M96YT<R!T:&%T
M('5S92!A(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G0N"B`@("!4>7!E('!R
M:6YT97)S(&%R92!R96-U<G-I=F5L>2!A<'!L:65D('1O('1H92!T96UP;&%T
M92!A<F=U;65N=',N"@H@("`@92YG+B!R97!L86-E(")S=&0Z.G9E8W1O<CQ4
M+"!S=&0Z.F%L;&]C871O<CQ4/B`^(B!W:71H(")S=&0Z.G9E8W1O<CQ4/B(N
M"B`@("`B(B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@9&5F87)G
M<RDZ"B`@("`@("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@('-E;&8N9&5F
M87)G<R`](&1E9F%R9W,*("`@("`@("!S96QF+F5N86)L960@/2!4<G5E"@H@
M("`@8VQA<W,@7W)E8V]G;FEZ97(H;V)J96-T*3H*("`@("`@("`B5&AE(')E
M8V]G;FEZ97(@8VQA<W,@9F]R(%1E;7!L871E5'EP95!R:6YT97(N(@H*("`@
M("`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@9&5F87)G<RDZ"B`@("`@
M("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@("`@("`@<V5L9BYD969A
M<F=S(#T@9&5F87)G<PH@("`@("`@("`@("`C('-E;&8N='EP95]O8FH@/2!.
M;VYE"@H@("`@("`@(&1E9B!R96-O9VYI>F4H<V5L9BP@='EP95]O8FHI.@H@
M("`@("`@("`@("`B(B(*("`@("`@("`@("`@268@='EP95]O8FH@:7,@82!S
M<&5C:6%L:7IA=&EO;B!O9B!S96QF+FYA;64@=&AA="!U<V5S(&%L;"!T:&4*
M("`@("`@("`@("`@9&5F875L="!T96UP;&%T92!A<F=U;65N=',@9F]R('1H
M92!C;&%S<R!T96UP;&%T92P@=&AE;B!R971U<FX*("`@("`@("`@("`@82!S
M=')I;F<@<F5P<F5S96YT871I;VX@;V8@=&AE('1Y<&4@=VET:&]U="!D969A
M=6QT(&%R9W5M96YT<RX*("`@("`@("`@("`@3W1H97)W:7-E+"!R971U<FX@
M3F]N92X*("`@("`@("`@("`@(B(B"@H@("`@("`@("`@("!I9B!T>7!E7V]B
M:BYT86<@:7,@3F]N93H*("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"@H@
M("`@("`@("`@("!I9B!N;W0@='EP95]O8FHN=&%G+G-T87)T<W=I=&@H<V5L
M9BYN86UE*3H*("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@
M("`@("!T96UP;&%T95]A<F=S(#T@9V5T7W1E;7!L871E7V%R9U]L:7-T*'1Y
M<&5?;V)J*0H@("`@("`@("`@("!D:7-P;&%Y961?87)G<R`](%M="B`@("`@
M("`@("`@(')E<75I<F5?9&5F875L=&5D(#T@1F%L<V4*("`@("`@("`@("`@
M9F]R(&X@:6X@<F%N9V4H;&5N*'1E;7!L871E7V%R9W,I*3H*("`@("`@("`@
M("`@("`@(",@5&AE(&%C='5A;"!T96UP;&%T92!A<F=U;65N="!I;B!T:&4@
M='EP93H*("`@("`@("`@("`@("`@('1A<F<@/2!T96UP;&%T95]A<F=S6VY=
M"B`@("`@("`@("`@("`@("`C(%1H92!D969A=6QT('1E;7!L871E(&%R9W5M
M96YT(&9O<B!T:&4@8VQA<W,@=&5M<&QA=&4Z"B`@("`@("`@("`@("`@("!D
M969A<F<@/2!S96QF+F1E9F%R9W,N9V5T*&XI"B`@("`@("`@("`@("`@("!I
M9B!D969A<F<@:7,@;F]T($YO;F4Z"B`@("`@("`@("`@("`@("`@("`@(R!3
M=6)S=&ET=71E(&]T:&5R('1E;7!L871E(&%R9W5M96YT<R!I;G1O('1H92!D
M969A=6QT.@H@("`@("`@("`@("`@("`@("`@(&1E9F%R9R`](&1E9F%R9RYF
M;W)M870H*G1E;7!L871E7V%R9W,I"B`@("`@("`@("`@("`@("`@("`@(R!&
M86EL('1O(')E8V]G;FEZ92!T:&4@='EP92`H8GD@<F5T=7)N:6YG($YO;F4I
M"B`@("`@("`@("`@("`@("`@("`@(R!U;FQE<W,@=&AE(&%C='5A;"!A<F=U
M;65N="!I<R!T:&4@<V%M92!A<R!T:&4@9&5F875L="X*("`@("`@("`@("`@
M("`@("`@("!T<GDZ"B`@("`@("`@("`@("`@("`@("`@("`@(&EF('1A<F<@
M(3T@9V1B+FQO;VMU<%]T>7!E*&1E9F%R9RDZ"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@("`@("`@("`@("`@(&5X
M8V5P="!G9&(N97)R;W(Z"B`@("`@("`@("`@("`@("`@("`@("`@(",@5'EP
M92!L;V]K=7`@9F%I;&5D+"!J=7-T('5S92!S=')I;F<@8V]M<&%R:7-O;CH*
M("`@("`@("`@("`@("`@("`@("`@("`@:68@=&%R9RYT86<@(3T@9&5F87)G
M.@H@("`@("`@("`@("`@("`@("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@
M("`@("`@("`@("`@("`@("`C($%L;"!S=6)S97%U96YT(&%R9W,@;75S="!H
M879E(&1E9F%U;'1S.@H@("`@("`@("`@("`@("`@("`@(')E<75I<F5?9&5F
M875L=&5D(#T@5')U90H@("`@("`@("`@("`@("`@96QI9B!R97%U:7)E7V1E
M9F%U;'1E9#H*("`@("`@("`@("`@("`@("`@("!R971U<FX@3F]N90H@("`@
M("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@("`@("`C(%)E8W5R
M<VEV96QY(&%P<&QY(')E8V]G;FEZ97)S('1O('1H92!T96UP;&%T92!A<F=U
M;65N=`H@("`@("`@("`@("`@("`@("`@(",@86YD(&%D9"!I="!T;R!T:&4@
M87)G=6UE;G1S('1H870@=VEL;"!B92!D:7-P;&%Y960Z"B`@("`@("`@("`@
M("`@("`@("`@9&ES<&QA>65D7V%R9W,N87!P96YD*'-E;&8N7W)E8V]G;FEZ
M95]S=6)T>7!E*'1A<F<I*0H*("`@("`@("`@("`@(R!4:&ES(&%S<W5M97,@
M;F\@8VQA<W,@=&5M<&QA=&5S(&EN('1H92!N97-T960M;F%M92US<&5C:69I
M97(Z"B`@("`@("`@("`@('1E;7!L871E7VYA;64@/2!T>7!E7V]B:BYT86=;
M,#IT>7!E7V]B:BYT86<N9FEN9"@G/"<I70H@("`@("`@("`@("!T96UP;&%T
M95]N86UE(#T@<W1R:7!?:6YL:6YE7VYA;65S<&%C97,H=&5M<&QA=&5?;F%M
M92D*"B`@("`@("`@("`@(')E='5R;B!T96UP;&%T95]N86UE("L@)SPG("L@
M)RP@)RYJ;VEN*&1I<W!L87EE9%]A<F=S*2`K("<^)PH*("`@("`@("!D968@
M7W)E8V]G;FEZ95]S=6)T>7!E*'-E;&8L('1Y<&5?;V)J*3H*("`@("`@("`@
M("`@(B(B0V]N=F5R="!A(&=D8BY4>7!E('1O(&$@<W1R:6YG(&)Y(&%P<&QY
M:6YG(')E8V]G;FEZ97)S+`H@("`@("`@("`@("!O<B!I9B!T:&%T(&9A:6QS
M('1H96X@<VEM<&QY(&-O;G9E<G1I;F<@=&\@82!S=')I;F<N(B(B"@H@("`@
M("`@("`@("!I9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?4%12
M.@H@("`@("`@("`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ95]S=6)T
M>7!E*'1Y<&5?;V)J+G1A<F=E="@I*2`K("<J)PH@("`@("`@("`@("!I9B!T
M>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?05)205DZ"B`@("`@("`@
M("`@("`@("!T>7!E7W-T<B`]('-E;&8N7W)E8V]G;FEZ95]S=6)T>7!E*'1Y
M<&5?;V)J+G1A<F=E="@I*0H@("`@("`@("`@("`@("`@:68@<W1R*'1Y<&5?
M;V)J+G-T<FEP7W1Y<&5D969S*"DI+F5N9'-W:71H*"=;72<I.@H@("`@("`@
M("`@("`@("`@("`@(')E='5R;B!T>7!E7W-T<B`K("=;72<@(R!A<G)A>2!O
M9B!U;FMN;W=N(&)O=6YD"B`@("`@("`@("`@("`@("!R971U<FX@(B5S6R5D
M72(@)2`H='EP95]S='(L('1Y<&5?;V)J+G)A;F=E*"E;,5T@*R`Q*0H@("`@
M("`@("`@("!I9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?4D5&
M.@H@("`@("`@("`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ95]S=6)T
M>7!E*'1Y<&5?;V)J+G1A<F=E="@I*2`K("<F)PH@("`@("`@("`@("!I9B!H
M87-A='1R*&=D8BP@)U194$5?0T]$15]25D%,545?4D5&)RDZ"B`@("`@("`@
M("`@("`@("!I9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?4E9!
M3%5%7U)%1CH*("`@("`@("`@("`@("`@("`@("!R971U<FX@<V5L9BY?<F5C
M;V=N:7IE7W-U8G1Y<&4H='EP95]O8FHN=&%R9V5T*"DI("L@)R8F)PH*("`@
M("`@("`@("`@='EP95]S='(@/2!G9&(N='EP97,N87!P;'E?='EP95]R96-O
M9VYI>F5R<R@*("`@("`@("`@("`@("`@("`@("!G9&(N='EP97,N9V5T7W1Y
M<&5?<F5C;V=N:7IE<G,H*2P@='EP95]O8FHI"B`@("`@("`@("`@(&EF('1Y
M<&5?<W1R.@H@("`@("`@("`@("`@("`@<F5T=7)N('1Y<&5?<W1R"B`@("`@
M("`@("`@(')E='5R;B!S='(H='EP95]O8FHI"@H@("`@9&5F(&EN<W1A;G1I
M871E*'-E;&8I.@H@("`@("`@(")2971U<FX@82!R96-O9VYI>F5R(&]B:F5C
M="!F;W(@=&AI<R!T>7!E('!R:6YT97(N(@H@("`@("`@(')E='5R;B!S96QF
M+E]R96-O9VYI>F5R*'-E;&8N;F%M92P@<V5L9BYD969A<F=S*0H*9&5F(&%D
M9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@;F%M92P@9&5F87)G
M<RDZ"B`@("!R(B(B"B`@("!!9&0@82!T>7!E('!R:6YT97(@9F]R(&$@8VQA
M<W,@=&5M<&QA=&4@=VET:"!D969A=6QT('1E;7!L871E(&%R9W5M96YT<RX*
M"B`@("!!<F=S.@H@("`@("`@(&YA;64@*'-T<BDZ(%1H92!T96UP;&%T92UN
M86UE(&]F('1H92!C;&%S<R!T96UP;&%T92X*("`@("`@("!D969A<F=S("AD
M:6-T(&EN=#IS=')I;F<I(%1H92!D969A=6QT('1E;7!L871E(&%R9W5M96YT
M<RX*"B`@("!4>7!E<R!I;B!D969A<F=S(&-A;B!R969E<B!T;R!T:&4@3G1H
M('1E;7!L871E+6%R9W5M96YT('5S:6YG('M.?0H@("`@*'=I=&@@>F5R;RUB
M87-E9"!I;F1I8V5S*2X*"B`@("!E+F<N("=U;F]R9&5R961?;6%P)R!H87,@
M=&AE<V4@9&5F87)G<SH*("`@('L@,CH@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@
M("`@,SH@)W-T9#HZ97%U86Q?=&\\>S!]/B<L"B`@("`@(#0Z("=S=&0Z.F%L
M;&]C871O<CQS=&0Z.G!A:7(\8V]N<W0@>S!]+"![,7T^(#XG('T*"B`@("`B
M(B(*("`@('!R:6YT97(@/2!496UP;&%T951Y<&50<FEN=&5R*"=S=&0Z.B<K
M;F%M92P@9&5F87)G<RD*("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R
M:6YT97(H;V)J+"!P<FEN=&5R*0H@("`@:68@7W9E<G-I;VYE9%]N86UE<W!A
M8V4Z"B`@("`@("`@(R!!9&0@<V5C;VYD('1Y<&4@<')I;G1E<B!F;W(@<V%M
M92!T>7!E(&EN('9E<G-I;VYE9"!N86UE<W!A8V4Z"B`@("`@("`@;G,@/2`G
M<W1D.CHG("L@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@("`@("`C(%!2(#@V
M,3$R($-A;FYO="!U<V4@9&EC="!C;VUP<F5H96YS:6]N(&AE<F4Z"B`@("`@
M("`@9&5F87)G<R`](&1I8W0H*&XL(&0N<F5P;&%C92@G<W1D.CHG+"!N<RDI
M(&9O<B`H;BQD*2!I;B!D969A<F=S+FET96US*"DI"B`@("`@("`@<')I;G1E
M<B`](%1E;7!L871E5'EP95!R:6YT97(H;G,K;F%M92P@9&5F87)G<RD*("`@
M("`@("!G9&(N='EP97,N<F5G:7-T97)?='EP95]P<FEN=&5R*&]B:BP@<')I
M;G1E<BD*"F-L87-S($9I;'1E<FEN9U1Y<&50<FEN=&5R*&]B:F5C="DZ"B`@
M("!R(B(B"B`@("!!('1Y<&4@<')I;G1E<B!T:&%T('5S97,@='EP961E9B!N
M86UE<R!F;W(@8V]M;6]N('1E;7!L871E('-P96-I86QI>F%T:6]N<RX*"B`@
M("!!<F=S.@H@("`@("`@(&UA=&-H("AS='(I.B!4:&4@8VQA<W,@=&5M<&QA
M=&4@=&\@<F5C;V=N:7IE+@H@("`@("`@(&YA;64@*'-T<BDZ(%1H92!T>7!E
M9&5F+6YA;64@=&AA="!W:6QL(&)E('5S960@:6YS=&5A9"X*"B`@("!#:&5C
M:W,@:68@82!S<&5C:6%L:7IA=&EO;B!O9B!T:&4@8VQA<W,@=&5M<&QA=&4@
M)VUA=&-H)R!I<R!T:&4@<V%M92!T>7!E"B`@("!A<R!T:&4@='EP961E9B`G
M;F%M92<L(&%N9"!P<FEN=',@:70@87,@)VYA;64G(&EN<W1E860N"@H@("`@
M92YG+B!I9B!A;B!I;G-T86YT:6%T:6]N(&]F('-T9#HZ8F%S:6-?:7-T<F5A
M;3Q#+"!4/B!I<R!T:&4@<V%M92!T>7!E(&%S"B`@("!S=&0Z.FES=')E86T@
M=&AE;B!P<FEN="!I="!A<R!S=&0Z.FES=')E86TN"B`@("`B(B(*"B`@("!D
M968@7U]I;FET7U\H<V5L9BP@;6%T8V@L(&YA;64I.@H@("`@("`@('-E;&8N
M;6%T8V@@/2!M871C:`H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@
M("!S96QF+F5N86)L960@/2!4<G5E"@H@("`@8VQA<W,@7W)E8V]G;FEZ97(H
M;V)J96-T*3H*("`@("`@("`B5&AE(')E8V]G;FEZ97(@8VQA<W,@9F]R(%1E
M;7!L871E5'EP95!R:6YT97(N(@H*("`@("`@("!D968@7U]I;FET7U\H<V5L
M9BP@;6%T8V@L(&YA;64I.@H@("`@("`@("`@("!S96QF+FUA=&-H(#T@;6%T
M8V@*("`@("`@("`@("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@("`@("!S
M96QF+G1Y<&5?;V)J(#T@3F]N90H*("`@("`@("!D968@<F5C;V=N:7IE*'-E
M;&8L('1Y<&5?;V)J*3H*("`@("`@("`@("`@(B(B"B`@("`@("`@("`@($EF
M('1Y<&5?;V)J('-T87)T<R!W:71H('-E;&8N;6%T8V@@86YD(&ES('1H92!S
M86UE('1Y<&4@87,*("`@("`@("`@("`@<V5L9BYN86UE('1H96X@<F5T=7)N
M('-E;&8N;F%M92P@;W1H97)W:7-E($YO;F4N"B`@("`@("`@("`@("(B(@H@
M("`@("`@("`@("!I9B!T>7!E7V]B:BYT86<@:7,@3F]N93H*("`@("`@("`@
M("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@("`@("!I9B!S96QF+G1Y<&5?
M;V)J(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!I9B!N;W0@='EP95]O8FHN
M=&%G+G-T87)T<W=I=&@H<V5L9BYM871C:"DZ"B`@("`@("`@("`@("`@("`@
M("`@(R!&:6QT97(@9&ED;B=T(&UA=&-H+@H@("`@("`@("`@("`@("`@("`@
M(')E='5R;B!.;VYE"B`@("`@("`@("`@("`@("!T<GDZ"B`@("`@("`@("`@
M("`@("`@("`@<V5L9BYT>7!E7V]B:B`](&=D8BYL;V]K=7!?='EP92AS96QF
M+FYA;64I+G-T<FEP7W1Y<&5D969S*"D*("`@("`@("`@("`@("`@(&5X8V5P
M=#H*("`@("`@("`@("`@("`@("`@("!P87-S"B`@("`@("`@("`@(&EF('-E
M;&8N='EP95]O8FH@/3T@='EP95]O8FHZ"B`@("`@("`@("`@("`@("!R971U
M<FX@<W1R:7!?:6YL:6YE7VYA;65S<&%C97,H<V5L9BYN86UE*0H@("`@("`@
M("`@("!R971U<FX@3F]N90H*("`@(&1E9B!I;G-T86YT:6%T92AS96QF*3H*
M("`@("`@("`B4F5T=7)N(&$@<F5C;V=N:7IE<B!O8FIE8W0@9F]R('1H:7,@
M='EP92!P<FEN=&5R+B(*("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N:7IE
M<BAS96QF+FUA=&-H+"!S96QF+FYA;64I"@ID968@861D7V]N95]T>7!E7W!R
M:6YT97(H;V)J+"!M871C:"P@;F%M92DZ"B`@("!P<FEN=&5R(#T@1FEL=&5R
M:6YG5'EP95!R:6YT97(H)W-T9#HZ)R`K(&UA=&-H+"`G<W1D.CHG("L@;F%M
M92D*("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT97(H;V)J+"!P
M<FEN=&5R*0H@("`@:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@("`@
M;G,@/2`G<W1D.CHG("L@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@("`@("!P
M<FEN=&5R(#T@1FEL=&5R:6YG5'EP95!R:6YT97(H;G,@*R!M871C:"P@;G,@
M*R!N86UE*0H@("`@("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT
M97(H;V)J+"!P<FEN=&5R*0H*9&5F(')E9VES=&5R7W1Y<&5?<')I;G1E<G,H
M;V)J*3H*("`@(&=L;V)A;"!?=7-E7W1Y<&5?<')I;G1I;F<*"B`@("!I9B!N
M;W0@7W5S95]T>7!E7W!R:6YT:6YG.@H@("`@("`@(')E='5R;@H*("`@(",@
M061D('1Y<&4@<')I;G1E<G,@9F]R('1Y<&5D969S('-T9#HZ<W1R:6YG+"!S
M=&0Z.G=S=')I;F<@971C+@H@("`@9F]R(&-H(&EN("@G)RP@)W<G+"`G=3@G
M+"`G=3$V)RP@)W4S,B<I.@H@("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R
M*&]B:BP@)V)A<VEC7W-T<FEN9R<L(&-H("L@)W-T<FEN9R<I"B`@("`@("`@
M861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G7U]C>'@Q,3HZ8F%S:6-?<W1R
M:6YG)RP@8V@@*R`G<W1R:6YG)RD*("`@("`@("`C(%1Y<&5D969S(&9O<B!?
M7V-X>#$Q.CIB87-I8U]S=')I;F<@=7-E9"!T;R!B92!I;B!N86UE<W!A8V4@
M7U]C>'@Q,3H*("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=?
M7V-X>#$Q.CIB87-I8U]S=')I;F<G+`H@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("=?7V-X>#$Q.CHG("L@8V@@*R`G<W1R:6YG)RD*("`@("`@("!A
M9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=B87-I8U]S=')I;F=?=FEE=R<L
M(&-H("L@)W-T<FEN9U]V:65W)RD*"B`@("`C($%D9"!T>7!E('!R:6YT97)S
M(&9O<B!T>7!E9&5F<R!S=&0Z.FES=')E86TL('-T9#HZ=VES=')E86T@971C
M+@H@("`@9F]R(&-H(&EN("@G)RP@)W<G*3H*("`@("`@("!F;W(@>"!I;B`H
M)VEO<R<L("=S=')E86UB=68G+"`G:7-T<F5A;2<L("=O<W1R96%M)RP@)VEO
M<W1R96%M)RP*("`@("`@("`@("`@("`@("`@)V9I;&5B=68G+"`G:69S=')E
M86TG+"`G;V9S=')E86TG+"`G9G-T<F5A;2<I.@H@("`@("`@("`@("!A9&1?
M;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=B87-I8U\G("L@>"P@8V@@*R!X*0H@
M("`@("`@(&9O<B!X(&EN("@G<W1R:6YG8G5F)RP@)VES=')I;F=S=')E86TG
M+"`G;W-T<FEN9W-T<F5A;2<L"B`@("`@("`@("`@("`@("`@("=S=')I;F=S
M=')E86TG*3H*("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J
M+"`G8F%S:6-?)R`K('@L(&-H("L@>"D*("`@("`@("`@("`@(R`\<W-T<F5A
M;3X@='EP97,@87)E(&EN(%]?8WAX,3$@;F%M97-P86-E+"!B=70@='EP961E
M9G,@87)E;B=T.@H@("`@("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO
M8FHL("=?7V-X>#$Q.CIB87-I8U\G("L@>"P@8V@@*R!X*0H*("`@(",@061D
M('1Y<&4@<')I;G1E<G,@9F]R('1Y<&5D969S(')E9V5X+"!W<F5G97@L(&-M
M871C:"P@=V-M871C:"!E=&,N"B`@("!F;W(@86)I(&EN("@G)RP@)U]?8WAX
M,3$Z.B<I.@H@("`@("`@(&9O<B!C:"!I;B`H)R<L("=W)RDZ"B`@("`@("`@
M("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@86)I("L@)V)A<VEC7W)E
M9V5X)RP@86)I("L@8V@@*R`G<F5G97@G*0H@("`@("`@(&9O<B!C:"!I;B`H
M)V,G+"`G<R<L("=W8R<L("=W<R<I.@H@("`@("`@("`@("!A9&1?;VYE7W1Y
M<&5?<')I;G1E<BAO8FHL(&%B:2`K("=M871C:%]R97-U;'1S)RP@86)I("L@
M8V@@*R`G;6%T8V@G*0H@("`@("`@("`@("!F;W(@>"!I;B`H)W-U8E]M871C
M:"<L("=R96=E>%]I=&5R871O<B<L("=R96=E>%]T;VME;E]I=&5R871O<B<I
M.@H@("`@("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"!A
M8FD@*R!X+"!A8FD@*R!C:"`K('@I"@H@("`@(R!.;W1E('1H870@=V4@8V%N
M)W0@:&%V92!A('!R:6YT97(@9F]R('-T9#HZ=W-T<F5A;7!O<RP@8F5C875S
M90H@("`@(R!I="!I<R!T:&4@<V%M92!T>7!E(&%S('-T9#HZ<W1R96%M<&]S
M+@H@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G9G!O<R<L("=S=')E
M86UP;W,G*0H*("`@(",@061D('1Y<&4@<')I;G1E<G,@9F]R(#QC:')O;F\^
M('1Y<&5D969S+@H@("`@9F]R(&1U<B!I;B`H)VYA;F]S96-O;F1S)RP@)VUI
M8W)O<V5C;VYD<R<L("=M:6QL:7-E8V]N9',G+`H@("`@("`@("`@("`@("`@
M)W-E8V]N9',G+"`G;6EN=71E<R<L("=H;W5R<R<I.@H@("`@("`@(&%D9%]O
M;F5?='EP95]P<FEN=&5R*&]B:BP@)V1U<F%T:6]N)RP@9'5R*0H*("`@(",@
M061D('1Y<&4@<')I;G1E<G,@9F]R(#QR86YD;VT^('1Y<&5D969S+@H@("`@
M861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G;&EN96%R7V-O;F=R=65N=&EA
M;%]E;F=I;F4G+"`G;6EN<W1D7W)A;F0P)RD*("`@(&%D9%]O;F5?='EP95]P
M<FEN=&5R*&]B:BP@)VQI;F5A<E]C;VYG<G5E;G1I86Q?96YG:6YE)RP@)VUI
M;G-T9%]R86YD)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)VUE
M<G-E;FYE7W1W:7-T97)?96YG:6YE)RP@)VUT,3DY,S<G*0H@("`@861D7V]N
M95]T>7!E7W!R:6YT97(H;V)J+"`G;65R<V5N;F5?='=I<W1E<E]E;F=I;F4G
M+"`G;70Q.3DS-U\V-"<I"B`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL
M("=S=6)T<F%C=%]W:71H7V-A<G)Y7V5N9VEN92<L("=R86YL=7@R-%]B87-E
M)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)W-U8G1R86-T7W=I
M=&A?8V%R<GE?96YG:6YE)RP@)W)A;FQU>#0X7V)A<V4G*0H@("`@861D7V]N
M95]T>7!E7W!R:6YT97(H;V)J+"`G9&ES8V%R9%]B;&]C:U]E;F=I;F4G+"`G
M<F%N;'5X,C0G*0H@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G9&ES
M8V%R9%]B;&]C:U]E;F=I;F4G+"`G<F%N;'5X-#@G*0H@("`@861D7V]N95]T
M>7!E7W!R:6YT97(H;V)J+"`G<VAU9F9L95]O<F1E<E]E;F=I;F4G+"`G:VYU
M=&A?8B<I"@H@("`@(R!!9&0@='EP92!P<FEN=&5R<R!F;W(@97AP97)I;65N
M=&%L.CIB87-I8U]S=')I;F=?=FEE=R!T>7!E9&5F<RX*("`@(&YS(#T@)V5X
M<&5R:6UE;G1A;#HZ9G5N9&%M96YT86QS7W8Q.CHG"B`@("!F;W(@8V@@:6X@
M*"<G+"`G=R<L("=U."<L("=U,38G+"`G=3,R)RDZ"B`@("`@("`@861D7V]N
M95]T>7!E7W!R:6YT97(H;V)J+"!N<R`K("=B87-I8U]S=')I;F=?=FEE=R<L
M"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@;G,@*R!C:"`K("=S=')I
M;F=?=FEE=R<I"@H@("`@(R!$;R!N;W0@<VAO=R!D969A=6QT960@=&5M<&QA
M=&4@87)G=6UE;G1S(&EN(&-L87-S('1E;7!L871E<RX*("`@(&%D9%]O;F5?
M=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W5N:7%U95]P='(G+`H@("`@
M("`@("`@("![(#$Z("=S=&0Z.F1E9F%U;'1?9&5L971E/'LP?3XG('TI"B`@
M("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=D97%U92<L
M('L@,3H@)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M
M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)V9O<G=A<F1?;&ES="<L('L@,3H@
M)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?
M='EP95]P<FEN=&5R*&]B:BP@)VQI<W0G+"![(#$Z("=S=&0Z.F%L;&]C871O
M<CQ[,'T^)WTI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO
M8FHL("=?7V-X>#$Q.CIL:7-T)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\>S!]
M/B=]*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G
M=F5C=&]R)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@861D
M7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G;6%P)RP*("`@("`@
M("`@("`@>R`R.B`G<W1D.CIL97-S/'LP?3XG+`H@("`@("`@("`@("`@(#,Z
M("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^/B<@
M?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)VUU
M;'1I;6%P)RP*("`@("`@("`@("`@>R`R.B`G<W1D.CIL97-S/'LP?3XG+`H@
M("`@("`@("`@("`@(#,Z("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!]
M(&-O;G-T+"![,7T^/B<@?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P
M<FEN=&5R*&]B:BP@)W-E="<L"B`@("`@("`@("`@('L@,3H@)W-T9#HZ;&5S
M<SQ[,'T^)RP@,CH@)W-T9#HZ86QL;V-A=&]R/'LP?3XG('TI"B`@("!A9&1?
M;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=M=6QT:7-E="<L"B`@
M("`@("`@("`@('L@,3H@)W-T9#HZ;&5S<SQ[,'T^)RP@,CH@)W-T9#HZ86QL
M;V-A=&]R/'LP?3XG('TI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I
M;G1E<BAO8FHL("=U;F]R9&5R961?;6%P)RP*("`@("`@("`@("`@>R`R.B`G
M<W1D.CIH87-H/'LP?3XG+`H@("`@("`@("`@("`@(#,Z("=S=&0Z.F5Q=6%L
M7W1O/'LP?3XG+`H@("`@("`@("`@("`@(#0Z("=S=&0Z.F%L;&]C871O<CQS
M=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^/B=]*0H@("`@861D7V]N95]T96UP
M;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO<F1E<F5D7VUU;'1I;6%P)RP*
M("`@("`@("`@("`@>R`R.B`G<W1D.CIH87-H/'LP?3XG+`H@("`@("`@("`@
M("`@(#,Z("=S=&0Z.F5Q=6%L7W1O/'LP?3XG+`H@("`@("`@("`@("`@(#0Z
M("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^/B=]
M*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO
M<F1E<F5D7W-E="<L"B`@("`@("`@("`@('L@,3H@)W-T9#HZ:&%S:#Q[,'T^
M)RP*("`@("`@("`@("`@("`R.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@
M("`@("`@("`@("`S.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@861D
M7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO<F1E<F5D7VUU
M;'1I<V5T)RP*("`@("`@("`@("`@>R`Q.B`G<W1D.CIH87-H/'LP?3XG+`H@
M("`@("`@("`@("`@(#(Z("=S=&0Z.F5Q=6%L7W1O/'LP?3XG+`H@("`@("`@
M("`@("`@(#,Z("=S=&0Z.F%L;&]C871O<CQ[,'T^)WTI"@ID968@<F5G:7-T
M97)?;&EB<W1D8WAX7W!R:6YT97)S("AO8FHI.@H@("`@(E)E9VES=&5R(&QI
M8G-T9&,K*R!P<F5T='DM<')I;G1E<G,@=VET:"!O8FIF:6QE($]B:BXB"@H@
M("`@9VQO8F%L(%]U<V5?9V1B7W!P"B`@("!G;&]B86P@;&EB<W1D8WAX7W!R
M:6YT97(*"B`@("!I9B!?=7-E7V=D8E]P<#H*("`@("`@("!G9&(N<')I;G1I
M;F<N<F5G:7-T97)?<')E='1Y7W!R:6YT97(H;V)J+"!L:6)S=&1C>'A?<')I
M;G1E<BD*("`@(&5L<V4Z"B`@("`@("`@:68@;V)J(&ES($YO;F4Z"B`@("`@
M("`@("`@(&]B:B`](&=D8@H@("`@("`@(&]B:BYP<F5T='E?<')I;G1E<G,N
M87!P96YD*&QI8G-T9&-X>%]P<FEN=&5R*0H*("`@(')E9VES=&5R7W1Y<&5?
M<')I;G1E<G,H;V)J*0H*9&5F(&)U:6QD7VQI8G-T9&-X>%]D:6-T:6]N87)Y
M("@I.@H@("`@9VQO8F%L(&QI8G-T9&-X>%]P<FEN=&5R"@H@("`@;&EB<W1D
M8WAX7W!R:6YT97(@/2!0<FEN=&5R*")L:6)S=&1C*RLM=C8B*0H*("`@(",@
M;&EB<W1D8RLK(&]B:F5C=',@<F5Q=6ER:6YG('!R971T>2UP<FEN=&EN9RX*
M("`@(",@26X@;W)D97(@9G)O;3H*("`@(",@:'1T<#HO+V=C8RYG;G4N;W)G
M+V]N;&EN961O8W,O;&EB<W1D8RLK+VQA=&5S="UD;WAY9V5N+V$P,3@T-RYH
M=&UL"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG
M+"`G8F%S:6-?<W1R:6YG)RP@4W1D4W1R:6YG4')I;G1E<BD*("`@(&QI8G-T
M9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.E]?8WAX,3$Z.B<L("=B
M87-I8U]S=')I;F<G+"!3=&13=')I;F=0<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G8FET<V5T)RP@4W1D
M0FET<V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT
M86EN97(H)W-T9#HZ)RP@)V1E<75E)RP@4W1D1&5Q=650<FEN=&5R*0H@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G;&ES
M="<L(%-T9$QI<W10<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7V-O;G1A:6YE<B@G<W1D.CI?7V-X>#$Q.CHG+"`G;&ES="<L(%-T9$QI<W10
M<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G
M<W1D.CHG+"`G;6%P)RP@4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)VUU;'1I;6%P)RP@4W1D
M36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN
M97(H)W-T9#HZ)RP@)VUU;'1I<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@(&QI
M8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=P86ER)RP@
M4W1D4&%I<E!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R
M<VEO;B@G<W1D.CHG+"`G<')I;W)I='E?<75E=64G+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=Q
M=65U92<L(%-T9%-T86-K3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?
M<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G='5P;&4G+"!3=&14=7!L
M95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R
M*"=S=&0Z.B<L("=S970G+"!3=&139710<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)W-T86-K)RP@4W1D4W1A
M8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V
M97)S:6]N*"=S=&0Z.B<L("=U;FEQ=65?<'1R)RP@56YI<75E4&]I;G1E<E!R
M:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S
M=&0Z.B<L("=V96-T;W(G+"!3=&1696-T;W)0<FEN=&5R*0H@("`@(R!V96-T
M;W(\8F]O;#X*"B`@("`C(%!R:6YT97(@<F5G:7-T<F%T:6]N<R!F;W(@8VQA
M<W-E<R!C;VUP:6QE9"!W:71H("U$7T=,24)#6%A?1$5"54<N"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ8FET<V5T)RP@4W1D
M0FET<V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D
M.CI?7V1E8G5G.CID97%U92<L(%-T9$1E<75E4')I;G1E<BD*("`@(&QI8G-T
M9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIL:7-T)RP@4W1D3&ES
M=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D
M96)U9SHZ;6%P)RP@4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIM=6QT:6UA<"<L(%-T9$UA<%!R:6YT
M97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ
M;75L=&ES970G+"!3=&139710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D*"=S=&0Z.E]?9&5B=6<Z.G!R:6]R:71Y7W%U975E)RP*("`@("`@
M("`@("`@("`@("`@("`@("`@("!3=&13=&%C:T]R475E=650<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G%U975E
M)RP@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIS970G+"!3=&139710<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G-T86-K
M)RP@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;FEQ=65?<'1R)RP@56YI<75E4&]I
M;G1E<E!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ=F5C=&]R)RP@4W1D5F5C=&]R4')I;G1E<BD*"B`@("`C(%1H
M97-E(&%R92!T:&4@5%(Q(&%N9"!#*RLQ,2!P<FEN=&5R<RX*("`@(",@1F]R
M(&%R<F%Y("T@=&AE(&1E9F%U;'0@1T1"('!R971T>2UP<FEN=&5R('-E96US
M(')E87-O;F%B;&4N"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO
M;B@G<W1D.CHG+"`G<VAA<F5D7W!T<B<L(%-H87)E9%!O:6YT97)0<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@
M)W=E86M?<'1R)RP@4VAA<F5D4&]I;G1E<E!R:6YT97(I"B`@("!L:6)S=&1C
M>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=U;F]R9&5R961?
M;6%P)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q
M56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]C;VYT86EN97(H)W-T9#HZ)RP@)W5N;W)D97)E9%]S970G+`H@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R96139710
M<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G
M<W1D.CHG+"`G=6YO<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@
M)W5N;W)D97)E9%]M=6QT:7-E="<L"B`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@(%1R,55N;W)D97)E9%-E=%!R:6YT97(I"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=F;W)W87)D
M7VQI<W0G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3
M=&1&;W)W87)D3&ES=%!R:6YT97(I"@H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7W9E<G-I;VXH)W-T9#HZ='(Q.CHG+"`G<VAA<F5D7W!T<B<L(%-H87)E
M9%!O:6YT97)0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E
M<G-I;VXH)W-T9#HZ='(Q.CHG+"`G=V5A:U]P='(G+"!3:&%R9610;VEN=&5R
M4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]M87`G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@
M)W5N;W)D97)E9%]S970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@5'(Q56YO<F1E<F5D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]M
M=6QT:6UA<"<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!4
M<C%5;F]R9&5R961-87!0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7W9E<G-I;VXH)W-T9#HZ='(Q.CHG+"`G=6YO<F1E<F5D7VUU;'1I<V5T
M)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D
M97)E9%-E=%!R:6YT97(I"@H@("`@(R!4:&5S92!A<F4@=&AE($,K*S$Q('!R
M:6YT97(@<F5G:7-T<F%T:6]N<R!F;W(@+41?1TQ)0D-86%]$14)51R!C87-E
M<RX*("`@(",@5&AE('1R,2!N86UE<W!A8V4@8V]N=&%I;F5R<R!D;R!N;W0@
M:&%V92!A;GD@9&5B=6<@97%U:79A;&5N=',L"B`@("`C('-O(&1O(&YO="!R
M96=I<W1E<B!P<FEN=&5R<R!F;W(@=&AE;2X*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;F]R9&5R961?;6%P)RP*("`@("`@
M("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R961-87!0<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N;W)D
M97)E9%]S970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D
M97)E9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T
M9#HZ7U]D96)U9SHZ=6YO<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@("`@
M("`@("`@("`@("`@("!4<C%5;F]R9&5R961-87!0<FEN=&5R*0H@("`@;&EB
M<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N;W)D97)E9%]M
M=6QT:7-E="<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E
M<F5D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D
M.CI?7V1E8G5G.CIF;W)W87)D7VQI<W0G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@(%-T9$9O<G=A<F1,:7-T4')I;G1E<BD*"B`@("`C($QI8G)A<GD@
M1G5N9&%M96YT86QS(%13(&-O;7!O;F5N=',*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ9G5N9&%M96YT
M86QS7W8Q.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M)V%N>2<L(%-T9$5X<$%N>5!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L
M<U]V,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=O
M<'1I;VYA;"<L(%-T9$5X<$]P=&EO;F%L4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ9G5N
M9&%M96YT86QS7W8Q.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@)V)A<VEC7W-T<FEN9U]V:65W)RP@4W1D17AP4W1R:6YG5FEE=U!R
M:6YT97(I"B`@("`C($9I;&5S>7-T96T@5%,@8V]M<&]N96YT<PH@("`@;&EB
M<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ97AP97)I;65N=&%L
M.CIF:6QE<WES=&5M.CIV,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("=P871H)RP@4W1D17AP4&%T:%!R:6YT97(I"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ
M.F9I;&5S>7-T96TZ.G8Q.CI?7V-X>#$Q.CHG+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@)W!A=&@G+"!3=&1%>'!0871H4')I;G1E<BD*
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F9I;&5S
M>7-T96TZ.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G
M<&%T:"<L(%-T9%!A=&A0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7W9E<G-I;VXH)W-T9#HZ9FEL97-Y<W1E;3HZ7U]C>'@Q,3HZ)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=P871H)RP@4W1D4&%T
M:%!R:6YT97(I"@H@("`@(R!#*RLQ-R!C;VUP;VYE;G1S"B`@("!L:6)S=&1C
M>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@)V%N>2<L(%-T9$5X<$%N>5!R:6YT97(I
M"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+`H@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@)V]P=&EO;F%L)RP@
M4W1D17AP3W!T:6]N86Q0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("=B87-I8U]S=')I;F=?=FEE=R<L(%-T9$5X<%-T<FEN9U9I
M97=0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=V
M87)I86YT)RP@4W1D5F%R:6%N=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I
M;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@)U].;V1E7VAA;F1L92<L(%-T9$YO9&5(86YD;&50
M<FEN=&5R*0H*("`@(",@17AT96YS:6]N<RX*("`@(&QI8G-T9&-X>%]P<FEN
M=&5R+F%D9%]V97)S:6]N*"=?7V=N=5]C>'@Z.B<L("=S;&ES="<L(%-T9%-L
M:7-T4')I;G1E<BD*"B`@("!I9B!4<G5E.@H@("`@("`@(",@5&AE<V4@<VAO
M=6QD;B=T(&)E(&YE8V5S<V%R>2P@:68@1T1"(")P<FEN="`J:2(@=V]R:V5D
M+@H@("`@("`@(",@0G5T(&ET(&]F=&5N(&1O97-N)W0L('-O(&AE<F4@=&AE
M>2!A<F4N"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE
M<B@G<W1D.CHG+"`G7TQI<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@4W1D3&ES=$ET97)A=&]R4')I;G1E
M<BD*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S
M=&0Z.B<L("=?3&ES=%]C;VYS=%]I=&5R871O<B<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1,:7-T271E<F%T;W)0<FEN
M=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.B<L("=?4F)?=')E95]I=&5R871O<B<L"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@4W1D4F)T<F5E271E<F%T;W)0<FEN=&5R
M*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z
M.B<L("=?4F)?=')E95]C;VYS=%]I=&5R871O<B<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@4W1D4F)T<F5E271E<F%T;W)0<FEN
M=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H
M)W-T9#HZ)RP@)U]$97%U95]I=&5R871O<B<L"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("!3=&1$97%U94ET97)A=&]R4')I;G1E
M<BD*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S
M=&0Z.B<L("=?1&5Q=65?8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D1&5Q=65)=&5R871O<E!R
M:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)U]?9VYU7V-X>#HZ)RP@)U]?;F]R;6%L7VET97)A=&]R)RP*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1696-T;W))=&5R871O
M<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I
M;VXH)U]?9VYU7V-X>#HZ)RP@)U]3;&ES=%]I=&5R871O<B<L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D4VQI<W1)=&5R871O
M<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A
M:6YE<B@G<W1D.CHG+"`G7T9W9%]L:7-T7VET97)A=&]R)RP*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%-T9$9W9$QI<W1)=&5R
M871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O
M;G1A:6YE<B@G<W1D.CHG+"`G7T9W9%]L:7-T7V-O;G-T7VET97)A=&]R)RP*
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%-T9$9W
M9$QI<W1)=&5R871O<E!R:6YT97(I"@H@("`@("`@(",@1&5B=6<@*&-O;7!I
M;&5D('=I=&@@+41?1TQ)0D-86%]$14)51RD@<')I;G1E<@H@("`@("`@(",@
M<F5G:7-T<F%T:6]N<RX*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H
M)U]?9VYU7V1E8G5G.CI?4V%F95]I=&5R871O<B<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(%-T9$1E8G5G271E<F%T;W)0<FEN=&5R*0H*8G5I
M;&1?;&EB<W1D8WAX7V1I8W1I;VYA<GD@*"D*````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```N+W!Y=&AO;B]L:6)S=&1C>'@O=C8O>&UE=&AO9',N<'D`````````````
M````````````````````````````````````````````````````````````
M````````````````,#`P,#8T-``P-C`Q-S4Q`#`V,#$W-3$`,#`P,#`P-C8P
M-S$`,3,T-3(S-3<T-3$`,#$V,C<U`"`P````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````'5S=&%R("``9G)E
M9&4```````````````````````````````````!F<F5D90``````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````",@6&UE=&AO9',@9F]R(&QI8G-T9&,K*RX*
M"B,@0V]P>7)I9VAT("A#*2`R,#$T+3(P,3D@1G)E92!3;V9T=V%R92!&;W5N
M9&%T:6]N+"!);F,N"@HC(%1H:7,@<')O9W)A;2!I<R!F<F5E('-O9G1W87)E
M.R!Y;W4@8V%N(')E9&ES=')I8G5T92!I="!A;F0O;W(@;6]D:69Y"B,@:70@
M=6YD97(@=&AE('1E<FUS(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@3&EC
M96YS92!A<R!P=6)L:7-H960@8GD*(R!T:&4@1G)E92!3;V9T=V%R92!&;W5N
M9&%T:6]N.R!E:71H97(@=F5R<VEO;B`S(&]F('1H92!,:6-E;G-E+"!O<@HC
M("AA="!Y;W5R(&]P=&EO;BD@86YY(&QA=&5R('9E<G-I;VXN"B,*(R!4:&ES
M('!R;V=R86T@:7,@9&ES=')I8G5T960@:6X@=&AE(&AO<&4@=&AA="!I="!W
M:6QL(&)E('5S969U;"P*(R!B=70@5TE42$]55"!!3ED@5T%24D%.5%D[('=I
M=&AO=70@979E;B!T:&4@:6UP;&EE9"!W87)R86YT>2!O9@HC($U%4D-(04Y4
M04))3$E462!O<B!&251.15-3($9/4B!!(%!!4E1)0U5,05(@4%524$]312X@
M(%-E92!T:&4*(R!'3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS92!F;W(@;6]R
M92!D971A:6QS+@HC"B,@66]U('-H;W5L9"!H879E(')E8V5I=F5D(&$@8V]P
M>2!O9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4*(R!A;&]N9R!W
M:71H('1H:7,@<')O9W)A;2X@($EF(&YO="P@<V5E(#QH='1P.B\O=W=W+F=N
M=2YO<F<O;&EC96YS97,O/BX*"FEM<&]R="!G9&(*:6UP;W)T(&=D8BYX;65T
M:&]D"FEM<&]R="!R90H*;6%T8VAE<E]N86UE7W!R969I>"`]("=L:6)S=&1C
M*RLZ.B<*"F1E9B!G971?8F]O;%]T>7!E*"DZ"B`@("!R971U<FX@9V1B+FQO
M;VMU<%]T>7!E*"=B;V]L)RD*"F1E9B!G971?<W1D7W-I>F5?='EP92@I.@H@
M("`@<F5T=7)N(&=D8BYL;V]K=7!?='EP92@G<W1D.CIS:7IE7W0G*0H*8VQA
M<W,@3&EB4W1D0WAX6$UE=&AO9"AG9&(N>&UE=&AO9"Y8365T:&]D*3H*("`@
M(&1E9B!?7VEN:71?7RAS96QF+"!N86UE+"!W;W)K97)?8VQA<W,I.@H@("`@
M("`@(&=D8BYX;65T:&]D+EA-971H;V0N7U]I;FET7U\H<V5L9BP@;F%M92D*
M("`@("`@("!S96QF+G=O<FME<E]C;&%S<R`]('=O<FME<E]C;&%S<PH*(R!8
M;65T:&]D<R!F;W(@<W1D.CIA<G)A>0H*8VQA<W,@07)R87E7;W)K97)"87-E
M*&=D8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@9&5F(%]?:6YI=%]?
M*'-E;&8L('9A;%]T>7!E+"!S:7IE*3H*("`@("`@("!S96QF+E]V86Q?='EP
M92`]('9A;%]T>7!E"B`@("`@("`@<V5L9BY?<VEZ92`]('-I>F4*"B`@("!D
M968@;G5L;%]V86QU92AS96QF*3H*("`@("`@("!N=6QL<'1R(#T@9V1B+G!A
M<G-E7V%N9%]E=F%L*"<H=F]I9"`J*2`P)RD*("`@("`@("!R971U<FX@;G5L
M;'!T<BYC87-T*'-E;&8N7W9A;%]T>7!E+G!O:6YT97(H*2DN9&5R969E<F5N
M8V4H*0H*8VQA<W,@07)R87E3:7IE5V]R:V5R*$%R<F%Y5V]R:V5R0F%S92DZ
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I.@H@("`@
M("`@($%R<F%Y5V]R:V5R0F%S92Y?7VEN:71?7RAS96QF+"!V86Q?='EP92P@
M<VEZ92D*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R
M971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J
M*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E
M9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]S
M:7IE"@IC;&%S<R!!<G)A>45M<'1Y5V]R:V5R*$%R<F%Y5V]R:V5R0F%S92DZ
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I.@H@("`@
M("`@($%R<F%Y5V]R:V5R0F%S92Y?7VEN:71?7RAS96QF+"!V86Q?='EP92P@
M<VEZ92D*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R
M971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J
M*3H*("`@("`@("!R971U<FX@9V5T7V)O;VQ?='EP92@I"@H@("`@9&5F(%]?
M8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N("AI;G0H<V5L9BY?
M<VEZ92D@/3T@,"D*"F-L87-S($%R<F%Y1G)O;G17;W)K97(H07)R87E7;W)K
M97)"87-E*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?='EP92P@<VEZ
M92DZ"B`@("`@("`@07)R87E7;W)K97)"87-E+E]?:6YI=%]?*'-E;&8L('9A
M;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@
M("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@
M(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(&EF(&EN="AS96QF
M+E]S:7IE*2`^(#`Z"B`@("`@("`@("`@(')E='5R;B!O8FI;)U]-7V5L96US
M)UU;,%T*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@<V5L9BYN
M=6QL7W9A;'5E*"D*"F-L87-S($%R<F%Y0F%C:U=O<FME<BA!<G)A>5=O<FME
M<D)A<V4I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE
M*3H*("`@("`@("!!<G)A>5=O<FME<D)A<V4N7U]I;FET7U\H<V5L9BP@=F%L
M7W1Y<&4L('-I>F4I"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E
M;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@
M9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@:68@:6YT*'-E;&8N
M7W-I>F4I(#X@,#H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?96QE;7,G
M75MS96QF+E]S:7IE("T@,5T*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R
M971U<FX@<V5L9BYN=6QL7W9A;'5E*"D*"F-L87-S($%R<F%Y0717;W)K97(H
M07)R87E7;W)K97)"87-E*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?
M='EP92P@<VEZ92DZ"B`@("`@("`@07)R87E7;W)K97)"87-E+E]?:6YI=%]?
M*'-E;&8L('9A;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@
M("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHL(&EN9&5X*3H*("`@
M("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H
M<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@:68@:6YT*&EN9&5X*2`^/2!I
M;G0H<V5L9BY?<VEZ92DZ"B`@("`@("`@("`@(')A:7-E($EN9&5X17)R;W(H
M)T%R<F%Y(&EN9&5X("(E9"(@<VAO=6QD(&YO="!B92`^/2`E9"XG("4*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`H*&EN="AI;F1E>"DL('-E;&8N
M7W-I>F4I*2D*("`@("`@("!R971U<FX@;V)J6R=?35]E;&5M<R==6VEN9&5X
M70H*8VQA<W,@07)R87E3=6)S8W)I<'17;W)K97(H07)R87E7;W)K97)"87-E
M*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92DZ"B`@
M("`@("`@07)R87E7;W)K97)"87-E+E]?:6YI=%]?*'-E;&8L('9A;%]T>7!E
M+"!S:7IE*0H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@
M(')E='5R;B!G971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E=%]R97-U
M;'1?='EP92AS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U<FX@<V5L
M9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!I;F1E
M>"DZ"B`@("`@("`@:68@:6YT*'-E;&8N7W-I>F4I(#X@,#H*("`@("`@("`@
M("`@<F5T=7)N(&]B:ELG7TU?96QE;7,G75MI;F1E>%T*("`@("`@("!E;'-E
M.@H@("`@("`@("`@("!R971U<FX@<V5L9BYN=6QL7W9A;'5E*"D*"F-L87-S
M($%R<F%Y365T:&]D<TUA=&-H97(H9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H
M97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8I.@H@("`@("`@(&=D8BYX;65T
M:&]D+EA-971H;V1-871C:&5R+E]?:6YI=%]?*'-E;&8L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@;6%T8VAE<E]N86UE
M7W!R969I>"`K("=A<G)A>2<I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@
M/2!["B`@("`@("`@("`@("=S:7IE)SH@3&EB4W1D0WAX6$UE=&AO9"@G<VEZ
M92<L($%R<F%Y4VEZ95=O<FME<BDL"B`@("`@("`@("`@("=E;7!T>2<Z($QI
M8E-T9$-X>%A-971H;V0H)V5M<'1Y)RP@07)R87E%;7!T>5=O<FME<BDL"B`@
M("`@("`@("`@("=F<F]N="<Z($QI8E-T9$-X>%A-971H;V0H)V9R;VYT)RP@
M07)R87E&<F]N=%=O<FME<BDL"B`@("`@("`@("`@("=B86-K)SH@3&EB4W1D
M0WAX6$UE=&AO9"@G8F%C:R<L($%R<F%Y0F%C:U=O<FME<BDL"B`@("`@("`@
M("`@("=A="<Z($QI8E-T9$-X>%A-971H;V0H)V%T)RP@07)R87E!=%=O<FME
M<BDL"B`@("`@("`@("`@("=O<&5R871O<EM=)SH@3&EB4W1D0WAX6$UE=&AO
M9"@G;W!E<F%T;W);72<L($%R<F%Y4W5B<V-R:7!T5V]R:V5R*2P*("`@("`@
M("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE=&AO9%]D:6-T
M6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T70H*("`@(&1E9B!M871C
M:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@("`@("`@:68@
M;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_87)R87D\+BH^)"<L(&-L
M87-S7W1Y<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@
M("!M971H;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I
M"B`@("`@("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B
M;&5D.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@('1R>3H*("`@
M("`@("`@("`@=F%L=65?='EP92`](&-L87-S7W1Y<&4N=&5M<&QA=&5?87)G
M=6UE;G0H,"D*("`@("`@("`@("`@<VEZ92`](&-L87-S7W1Y<&4N=&5M<&QA
M=&5?87)G=6UE;G0H,2D*("`@("`@("!E>&-E<'0Z"B`@("`@("`@("`@(')E
M='5R;B!.;VYE"B`@("`@("`@<F5T=7)N(&UE=&AO9"YW;W)K97)?8VQA<W,H
M=F%L=65?='EP92P@<VEZ92D*"B,@6&UE=&AO9',@9F]R('-T9#HZ9&5Q=64*
M"F-L87-S($1E<75E5V]R:V5R0F%S92AG9&(N>&UE=&AO9"Y8365T:&]D5V]R
M:V5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?='EP92DZ"B`@("`@
M("`@<V5L9BY?=F%L7W1Y<&4@/2!V86Q?='EP90H@("`@("`@('-E;&8N7V)U
M9G-I>F4@/2`U,3(@+R\@=F%L7W1Y<&4N<VEZ96]F(&]R(#$*"B`@("!D968@
M<VEZ92AS96QF+"!O8FHI.@H@("`@("`@(&9I<G-T7VYO9&4@/2!O8FI;)U]-
M7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?;F]D92=="B`@("`@("`@;&%S=%]N
M;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]N;V1E)UT*
M("`@("`@("!C=7(@/2!O8FI;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-
M7V-U<B=="B`@("`@("`@9FER<W0@/2!O8FI;)U]-7VEM<&PG75LG7TU?9FEN
M:7-H)UU;)U]-7V9I<G-T)UT*("`@("`@("!R971U<FX@*&QA<W1?;F]D92`M
M(&9I<G-T7VYO9&4I("H@<V5L9BY?8G5F<VEZ92`K("AC=7(@+2!F:7)S="D*
M"B`@("!D968@:6YD97@H<V5L9BP@;V)J+"!I9'@I.@H@("`@("`@(&9I<G-T
M7VYO9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?;F]D92==
M"B`@("`@("`@:6YD97A?;F]D92`](&9I<G-T7VYO9&4@*R!I;G0H:61X*2`O
M+R!S96QF+E]B=69S:7IE"B`@("`@("`@<F5T=7)N(&EN9&5X7VYO9&5;,%U;
M:61X("4@<V5L9BY?8G5F<VEZ95T*"F-L87-S($1E<75E16UP='E7;W)K97(H
M1&5Q=657;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I
M.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP
M92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G971?8F]O;%]T>7!E*"D*
M"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M*&]B:ELG7TU?:6UP;"==6R=?35]S=&%R="==6R=?35]C=7(G72`]/0H@("`@
M("`@("`@("`@("`@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]C
M=7(G72D*"F-L87-S($1E<75E4VEZ95=O<FME<BA$97%U95=O<FME<D)A<V4I
M.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N
M($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@
M("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*"B`@("!D968@7U]C
M86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BYS:7IE*&]B
M:BD*"F-L87-S($1E<75E1G)O;G17;W)K97(H1&5Q=657;W)K97)"87-E*3H*
M("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.
M;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@
M("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS
M96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!O8FI;)U]-7VEM<&PG75LG7TU?
M<W1A<G0G75LG7TU?8W5R)UU;,%T*"F-L87-S($1E<75E0F%C:U=O<FME<BA$
M97%U95=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ
M"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E
M*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@
M("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@:68@*&]B:ELG
M7TU?:6UP;"==6R=?35]F:6YI<V@G75LG7TU?8W5R)UT@/3T*("`@("`@("`@
M("`@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]F:7)S="==*3H*
M("`@("`@("`@("`@<')E=E]N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7V9I
M;FES:"==6R=?35]N;V1E)UT@+2`Q"B`@("`@("`@("`@(')E='5R;B!P<F5V
M7VYO9&5;,%U;<V5L9BY?8G5F<VEZ92`M(#%="B`@("`@("`@96QS93H*("`@
M("`@("`@("`@<F5T=7)N(&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G75LG
M7TU?8W5R)UU;+3%="@IC;&%S<R!$97%U95-U8G-C<FEP=%=O<FME<BA$97%U
M95=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*"B`@("!D968@9V5T
M7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@<W5B<V-R:7!T*3H*("`@("`@("!R
M971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@
M;V)J+"!S=6)S8W)I<'0I.@H@("`@("`@(')E='5R;B!S96QF+FEN9&5X*&]B
M:BP@<W5B<V-R:7!T*0H*8VQA<W,@1&5Q=65!=%=O<FME<BA$97%U95=O<FME
M<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@
M<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E*"D*"B`@("!D968@9V5T7W)E<W5L
M=%]T>7!E*'-E;&8L(&]B:BP@:6YD97@I.@H@("`@("`@(')E='5R;B!S96QF
M+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHL(&EN9&5X
M*3H*("`@("`@("!D97%U95]S:7IE(#T@:6YT*'-E;&8N<VEZ92AO8FHI*0H@
M("`@("`@(&EF(&EN="AI;F1E>"D@/CT@9&5Q=65?<VEZ93H*("`@("`@("`@
M("`@<F%I<V4@26YD97A%<G)O<B@G1&5Q=64@:6YD97@@(B5D(B!S:&]U;&0@
M;F]T(&)E(#X]("5D+B<@)0H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("AI;G0H:6YD97@I+"!D97%U95]S:7IE*2D*("`@("`@("!E;'-E.@H@("`@
M("`@("`@(')E='5R;B!S96QF+FEN9&5X*&]B:BP@:6YD97@I"@IC;&%S<R!$
M97%U94UE=&AO9'--871C:&5R*&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R
M*3H*("`@(&1E9B!?7VEN:71?7RAS96QF*3H*("`@("`@("!G9&(N>&UE=&AO
M9"Y8365T:&]D36%T8VAE<BY?7VEN:71?7RAS96QF+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(&UA=&-H97)?;F%M95]P
M<F5F:7@@*R`G9&5Q=64G*0H@("`@("`@('-E;&8N7VUE=&AO9%]D:6-T(#T@
M>PH@("`@("`@("`@("`G96UP='DG.B!,:6)3=&1#>'A8365T:&]D*"=E;7!T
M>2<L($1E<75E16UP='E7;W)K97(I+`H@("`@("`@("`@("`G<VEZ92<Z($QI
M8E-T9$-X>%A-971H;V0H)W-I>F4G+"!$97%U95-I>F57;W)K97(I+`H@("`@
M("`@("`@("`G9G)O;G0G.B!,:6)3=&1#>'A8365T:&]D*"=F<F]N="<L($1E
M<75E1G)O;G17;W)K97(I+`H@("`@("`@("`@("`G8F%C:R<Z($QI8E-T9$-X
M>%A-971H;V0H)V)A8VLG+"!$97%U94)A8VM7;W)K97(I+`H@("`@("`@("`@
M("`G;W!E<F%T;W);72<Z($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R6UTG
M+"!$97%U95-U8G-C<FEP=%=O<FME<BDL"B`@("`@("`@("`@("=A="<Z($QI
M8E-T9$-X>%A-971H;V0H)V%T)RP@1&5Q=65!=%=O<FME<BD*("`@("`@("!]
M"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE=&AO9%]D:6-T6VU=
M(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T70H*("`@(&1E9B!M871C:"AS
M96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@("`@("`@:68@;F]T
M(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_9&5Q=64\+BH^)"<L(&-L87-S
M7W1Y<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M
M971H;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@
M("`@("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D
M.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@(')E='5R;B!M971H
M;V0N=V]R:V5R7V-L87-S*&-L87-S7W1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H
M,"DI"@HC(%AM971H;V1S(&9O<B!S=&0Z.F9O<G=A<F1?;&ES=`H*8VQA<W,@
M1F]R=V%R9$QI<W17;W)K97)"87-E*&=D8BYX;65T:&]D+EA-971H;V1-871C
M:&5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?='EP92P@;F]D95]T
M>7!E*3H*("`@("`@("!S96QF+E]V86Q?='EP92`]('9A;%]T>7!E"B`@("`@
M("`@<V5L9BY?;F]D95]T>7!E(#T@;F]D95]T>7!E"@H@("`@9&5F(&=E=%]A
M<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"F-L87-S($9O
M<G=A<F1,:7-T16UP='E7;W)K97(H1F]R=V%R9$QI<W17;W)K97)"87-E*3H*
M("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R
M971U<FX@9V5T7V)O;VQ?='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L
M(&]B:BDZ"B`@("`@("`@<F5T=7)N(&]B:ELG7TU?:6UP;"==6R=?35]H96%D
M)UU;)U]-7VYE>'0G72`]/2`P"@IC;&%S<R!&;W)W87)D3&ES=$9R;VYT5V]R
M:V5R*$9O<G=A<F1,:7-T5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7W)E<W5L
M=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T
M>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@;F]D
M92`](&]B:ELG7TU?:6UP;"==6R=?35]H96%D)UU;)U]-7VYE>'0G72YC87-T
M*'-E;&8N7VYO9&5?='EP92D*("`@("`@("!V86Q?861D<F5S<R`](&YO9&5;
M)U]-7W-T;W)A9V4G75LG7TU?<W1O<F%G92==+F%D9')E<W,*("`@("`@("!R
M971U<FX@=F%L7V%D9')E<W,N8V%S="AS96QF+E]V86Q?='EP92YP;VEN=&5R
M*"DI+F1E<F5F97)E;F-E*"D*"F-L87-S($9O<G=A<F1,:7-T365T:&]D<TUA
M=&-H97(H9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?
M:6YI=%]?*'-E;&8I.@H@("`@("`@(&UA=&-H97)?;F%M92`](&UA=&-H97)?
M;F%M95]P<F5F:7@@*R`G9F]R=V%R9%]L:7-T)PH@("`@("`@(&=D8BYX;65T
M:&]D+EA-971H;V1-871C:&5R+E]?:6YI=%]?*'-E;&8L(&UA=&-H97)?;F%M
M92D*("`@("`@("!S96QF+E]M971H;V1?9&EC="`]('L*("`@("`@("`@("`@
M)V5M<'1Y)SH@3&EB4W1D0WAX6$UE=&AO9"@G96UP='DG+"!&;W)W87)D3&ES
M=$5M<'1Y5V]R:V5R*2P*("`@("`@("`@("`@)V9R;VYT)SH@3&EB4W1D0WAX
M6$UE=&AO9"@G9G)O;G0G+"!&;W)W87)D3&ES=$9R;VYT5V]R:V5R*0H@("`@
M("`@('T*("`@("`@("!S96QF+FUE=&AO9',@/2!;<V5L9BY?;65T:&]D7V1I
M8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T:&]D7V1I8W1="@H@("`@9&5F(&UA
M=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE=&AO9%]N86UE*3H*("`@("`@("!I
M9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]F;W)W87)D7VQI<W0\
M+BH^)"<L(&-L87-S7W1Y<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO
M;F4*("`@("`@("!M971H;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T
M:&]D7VYA;64I"B`@("`@("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE
M=&AO9"YE;F%B;&5D.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@
M('9A;%]T>7!E(#T@8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N="@P*0H@
M("`@("`@(&YO9&5?='EP92`](&=D8BYL;V]K=7!?='EP92AS='(H8VQA<W-?
M='EP92D@*R`G.CI?3F]D92<I+G!O:6YT97(H*0H@("`@("`@(')E='5R;B!M
M971H;V0N=V]R:V5R7V-L87-S*'9A;%]T>7!E+"!N;V1E7W1Y<&4I"@HC(%AM
M971H;V1S(&9O<B!S=&0Z.FQI<W0*"F-L87-S($QI<W17;W)K97)"87-E*&=D
M8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L('9A;%]T>7!E+"!N;V1E7W1Y<&4I.@H@("`@("`@('-E;&8N7W9A;%]T
M>7!E(#T@=F%L7W1Y<&4*("`@("`@("!S96QF+E]N;V1E7W1Y<&4@/2!N;V1E
M7W1Y<&4*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R
M971U<FX@3F]N90H*("`@(&1E9B!G971?=F%L=65?9G)O;5]N;V1E*'-E;&8L
M(&YO9&4I.@H@("`@("`@(&YO9&4@/2!N;V1E+F1E<F5F97)E;F-E*"D*("`@
M("`@("!I9B!N;V1E+G1Y<&4N9FEE;&1S*"E;,5TN;F%M92`]/2`G7TU?9&%T
M82<Z"B`@("`@("`@("`@(",@0RLK,#,@:6UP;&5M96YT871I;VXL(&YO9&4@
M8V]N=&%I;G,@=&AE('9A;'5E(&%S(&$@;65M8F5R"B`@("`@("`@("`@(')E
M='5R;B!N;V1E6R=?35]D871A)UT*("`@("`@("`C($,K*S$Q(&EM<&QE;65N
M=&%T:6]N+"!N;V1E('-T;W)E<R!V86QU92!I;B!?7V%L:6=N961?;65M8G5F
M"B`@("`@("`@861D<B`](&YO9&5;)U]-7W-T;W)A9V4G72YA9&1R97-S"B`@
M("`@("`@<F5T=7)N(&%D9'(N8V%S="AS96QF+E]V86Q?='EP92YP;VEN=&5R
M*"DI+F1E<F5F97)E;F-E*"D*"F-L87-S($QI<W1%;7!T>5=O<FME<BA,:7-T
M5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B
M:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]B;V]L7W1Y<&4H*0H*("`@(&1E9B!?
M7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(&)A<V5?;F]D92`](&]B:ELG
M7TU?:6UP;"==6R=?35]N;V1E)UT*("`@("`@("!I9B!B87-E7VYO9&5;)U]-
M7VYE>'0G72`]/2!B87-E7VYO9&4N861D<F5S<SH*("`@("`@("`@("`@<F5T
M=7)N(%1R=64*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@1F%L
M<V4*"F-L87-S($QI<W13:7IE5V]R:V5R*$QI<W17;W)K97)"87-E*3H*("`@
M(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U
M<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF
M+"!O8FHI.@H@("`@("`@(&)E9VEN7VYO9&4@/2!O8FI;)U]-7VEM<&PG75LG
M7TU?;F]D92==6R=?35]N97AT)UT*("`@("`@("!E;F1?;F]D92`](&]B:ELG
M7TU?:6UP;"==6R=?35]N;V1E)UTN861D<F5S<PH@("`@("`@('-I>F4@/2`P
M"B`@("`@("`@=VAI;&4@8F5G:6Y?;F]D92`A/2!E;F1?;F]D93H*("`@("`@
M("`@("`@8F5G:6Y?;F]D92`](&)E9VEN7VYO9&5;)U]-7VYE>'0G70H@("`@
M("`@("`@("!S:7IE("L](#$*("`@("`@("!R971U<FX@<VEZ90H*8VQA<W,@
M3&ES=$9R;VYT5V]R:V5R*$QI<W17;W)K97)"87-E*3H*("`@(&1E9B!G971?
M<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?
M=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@
M("!N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-7VYO9&4G75LG7TU?;F5X="==
M+F-A<W0H<V5L9BY?;F]D95]T>7!E*0H@("`@("`@(')E='5R;B!S96QF+F=E
M=%]V86QU95]F<F]M7VYO9&4H;F]D92D*"F-L87-S($QI<W1"86-K5V]R:V5R
M*$QI<W17;W)K97)"87-E*3H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L
M9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D
M968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!P<F5V7VYO9&4@/2!O
M8FI;)U]-7VEM<&PG75LG7TU?;F]D92==6R=?35]P<F5V)UTN8V%S="AS96QF
M+E]N;V1E7W1Y<&4I"B`@("`@("`@<F5T=7)N('-E;&8N9V5T7W9A;'5E7V9R
M;VU?;F]D92AP<F5V7VYO9&4I"@IC;&%S<R!,:7-T365T:&]D<TUA=&-H97(H
M9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?
M*'-E;&8I.@H@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R+E]?
M:6YI=%]?*'-E;&8L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@;6%T8VAE<E]N86UE7W!R969I>"`K("=L:7-T)RD*("`@
M("`@("!S96QF+E]M971H;V1?9&EC="`]('L*("`@("`@("`@("`@)V5M<'1Y
M)SH@3&EB4W1D0WAX6$UE=&AO9"@G96UP='DG+"!,:7-T16UP='E7;W)K97(I
M+`H@("`@("`@("`@("`G<VEZ92<Z($QI8E-T9$-X>%A-971H;V0H)W-I>F4G
M+"!,:7-T4VEZ95=O<FME<BDL"B`@("`@("`@("`@("=F<F]N="<Z($QI8E-T
M9$-X>%A-971H;V0H)V9R;VYT)RP@3&ES=$9R;VYT5V]R:V5R*2P*("`@("`@
M("`@("`@)V)A8VLG.B!,:6)3=&1#>'A8365T:&]D*"=B86-K)RP@3&ES=$)A
M8VM7;W)K97(I"B`@("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`](%MS
M96QF+E]M971H;V1?9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?9&EC
M=%T*"B`@("!D968@;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D7VYA
M;64I.@H@("`@("`@(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K.CHI
M/RA?7V-X>#$Q.CHI/VQI<W0\+BH^)"<L(&-L87-S7W1Y<&4N=&%G*3H*("`@
M("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M971H;V0@/2!S96QF+E]M
M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@("`@("`@:68@;65T:&]D
M(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@("`@("`@("`@("!R
M971U<FX@3F]N90H@("`@("`@('9A;%]T>7!E(#T@8VQA<W-?='EP92YT96UP
M;&%T95]A<F=U;65N="@P*0H@("`@("`@(&YO9&5?='EP92`](&=D8BYL;V]K
M=7!?='EP92AS='(H8VQA<W-?='EP92D@*R`G.CI?3F]D92<I+G!O:6YT97(H
M*0H@("`@("`@(')E='5R;B!M971H;V0N=V]R:V5R7V-L87-S*'9A;%]T>7!E
M+"!N;V1E7W1Y<&4I"@HC(%AM971H;V1S(&9O<B!S=&0Z.G9E8W1O<@H*8VQA
M<W,@5F5C=&]R5V]R:V5R0F%S92AG9&(N>&UE=&AO9"Y8365T:&]D5V]R:V5R
M*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!V86Q?='EP92DZ"B`@("`@("`@
M<V5L9BY?=F%L7W1Y<&4@/2!V86Q?='EP90H*("`@(&1E9B!S:7IE*'-E;&8L
M(&]B:BDZ"B`@("`@("`@:68@<V5L9BY?=F%L7W1Y<&4N8V]D92`]/2!G9&(N
M5%E015]#3T1%7T)/3TPZ"B`@("`@("`@("`@('-T87)T(#T@;V)J6R=?35]I
M;7!L)UU;)U]-7W-T87)T)UU;)U]-7W`G70H@("`@("`@("`@("!F:6YI<V@@
M/2!O8FI;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7W`G70H@("`@("`@
M("`@("!F:6YI<VA?;V9F<V5T(#T@;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES
M:"==6R=?35]O9F9S970G70H@("`@("`@("`@("!B:71?<VEZ92`]('-T87)T
M+F1E<F5F97)E;F-E*"DN='EP92YS:7IE;V8@*B`X"B`@("`@("`@("`@(')E
M='5R;B`H9FEN:7-H("T@<W1A<G0I("H@8FET7W-I>F4@*R!F:6YI<VA?;V9F
M<V5T"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?
M:6UP;"==6R=?35]F:6YI<V@G72`M(&]B:ELG7TU?:6UP;"==6R=?35]S=&%R
M="=="@H@("`@9&5F(&=E="AS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!I
M9B!S96QF+E]V86Q?='EP92YC;V1E(#T](&=D8BY465!%7T-/1$5?0D]/3#H*
M("`@("`@("`@("`@<W1A<G0@/2!O8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G
M75LG7TU?<"=="B`@("`@("`@("`@(&)I=%]S:7IE(#T@<W1A<G0N9&5R969E
M<F5N8V4H*2YT>7!E+G-I>F5O9B`J(#@*("`@("`@("`@("`@=F%L<"`]('-T
M87)T("L@:6YD97@@+R\@8FET7W-I>F4*("`@("`@("`@("`@;V9F<V5T(#T@
M:6YD97@@)2!B:71?<VEZ90H@("`@("`@("`@("!R971U<FX@*'9A;'`N9&5R
M969E<F5N8V4H*2`F("@Q(#P\(&]F9G-E="DI(#X@,`H@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@(')E='5R;B!O8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G
M75MI;F1E>%T*"F-L87-S(%9E8W1O<D5M<'1Y5V]R:V5R*%9E8W1O<E=O<FME
M<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@
M<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B
M:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]B;V]L7W1Y<&4H*0H*("`@(&1E9B!?
M7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!I;G0H<V5L9BYS
M:7IE*&]B:BDI(#T](#`*"F-L87-S(%9E8W1O<E-I>F57;W)K97(H5F5C=&]R
M5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@
M("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L
M9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*
M("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S
M96QF+G-I>F4H;V)J*0H*8VQA<W,@5F5C=&]R1G)O;G17;W)K97(H5F5C=&]R
M5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@
M("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L
M9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D
M968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BYG
M970H;V)J+"`P*0H*8VQA<W,@5F5C=&]R0F%C:U=O<FME<BA696-T;W)7;W)K
M97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@
M(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O
M8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?
M7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+F=E="AO
M8FHL(&EN="AS96QF+G-I>F4H;V)J*2D@+2`Q*0H*8VQA<W,@5F5C=&]R0717
M;W)K97(H5F5C=&]R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T>7!E
M<RAS96QF*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*
M("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@
M("`@("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?
M*'-E;&8L(&]B:BP@:6YD97@I.@H@("`@("`@('-I>F4@/2!I;G0H<V5L9BYS
M:7IE*&]B:BDI"B`@("`@("`@:68@:6YT*&EN9&5X*2`^/2!S:7IE.@H@("`@
M("`@("`@("!R86ES92!);F1E>$5R<F]R*"=696-T;W(@:6YD97@@(B5D(B!S
M:&]U;&0@;F]T(&)E(#X]("5D+B<@)0H@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("@H:6YT*&EN9&5X*2P@<VEZ92DI*0H@("`@("`@(')E='5R;B!S
M96QF+F=E="AO8FHL(&EN="AI;F1E>"DI"@IC;&%S<R!696-T;W)3=6)S8W)I
M<'17;W)K97(H5F5C=&]R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T7V%R9U]T
M>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H
M*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!S=6)S8W)I
M<'0I.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?
M7V-A;&Q?7RAS96QF+"!O8FHL('-U8G-C<FEP="DZ"B`@("`@("`@<F5T=7)N
M('-E;&8N9V5T*&]B:BP@:6YT*'-U8G-C<FEP="DI"@IC;&%S<R!696-T;W)-
M971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BDZ"B`@
M("!D968@7U]I;FET7U\H<V5L9BDZ"B`@("`@("`@9V1B+GAM971H;V0N6$UE
M=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L9BP*("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("!M871C:&5R7VYA;65?<')E9FEX
M("L@)W9E8W1O<B<I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@
M("`@("`@("`@("=S:7IE)SH@3&EB4W1D0WAX6$UE=&AO9"@G<VEZ92<L(%9E
M8W1O<E-I>F57;W)K97(I+`H@("`@("`@("`@("`G96UP='DG.B!,:6)3=&1#
M>'A8365T:&]D*"=E;7!T>2<L(%9E8W1O<D5M<'1Y5V]R:V5R*2P*("`@("`@
M("`@("`@)V9R;VYT)SH@3&EB4W1D0WAX6$UE=&AO9"@G9G)O;G0G+"!696-T
M;W)&<F]N=%=O<FME<BDL"B`@("`@("`@("`@("=B86-K)SH@3&EB4W1D0WAX
M6$UE=&AO9"@G8F%C:R<L(%9E8W1O<D)A8VM7;W)K97(I+`H@("`@("`@("`@
M("`G870G.B!,:6)3=&1#>'A8365T:&]D*"=A="<L(%9E8W1O<D%T5V]R:V5R
M*2P*("`@("`@("`@("`@)V]P97)A=&]R6UTG.B!,:6)3=&1#>'A8365T:&]D
M*"=O<&5R871O<EM=)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@(%9E8W1O<E-U8G-C<FEP=%=O<FME<BDL"B`@("`@("`@
M?0H@("`@("`@('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H;V1?9&EC=%MM
M72!F;W(@;2!I;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D968@;6%T8V@H
M<V5L9BP@8VQA<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@("`@(&EF(&YO
M="!R92YM871C:"@G7G-T9#HZ*%]?7&0K.CHI/W9E8W1O<CPN*CXD)RP@8VQA
M<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@
M(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E="AM971H;V1?;F%M92D*
M("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N;W0@;65T:&]D+F5N86)L
M960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@<F5T=7)N(&UE
M=&AO9"YW;W)K97)?8VQA<W,H8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N
M="@P*2D*"B,@6&UE=&AO9',@9F]R(&%S<V]C:6%T:79E(&-O;G1A:6YE<G,*
M"F-L87-S($%S<V]C:6%T:79E0V]N=&%I;F5R5V]R:V5R0F%S92AG9&(N>&UE
M=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!U
M;F]R9&5R960I.@H@("`@("`@('-E;&8N7W5N;W)D97)E9"`]('5N;W)D97)E
M9`H*("`@(&1E9B!N;V1E7V-O=6YT*'-E;&8L(&]B:BDZ"B`@("`@("`@:68@
M<V5L9BY?=6YO<F1E<F5D.@H@("`@("`@("`@("!R971U<FX@;V)J6R=?35]H
M)UU;)U]-7V5L96UE;G1?8V]U;G0G70H@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@(')E='5R;B!O8FI;)U]-7W0G75LG7TU?:6UP;"==6R=?35]N;V1E7V-O
M=6YT)UT*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R
M971U<FX@3F]N90H*8VQA<W,@07-S;V-I871I=F5#;VYT86EN97)%;7!T>5=O
M<FME<BA!<W-O8VEA=&EV94-O;G1A:6YE<E=O<FME<D)A<V4I.@H@("`@9&5F
M(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G
M971?8F]O;%]T>7!E*"D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*
M("`@("`@("!R971U<FX@:6YT*'-E;&8N;F]D95]C;W5N="AO8FHI*2`]/2`P
M"@IC;&%S<R!!<W-O8VEA=&EV94-O;G1A:6YE<E-I>F57;W)K97(H07-S;V-I
M871I=F5#;VYT86EN97)7;W)K97)"87-E*3H*("`@(&1E9B!G971?<F5S=6QT
M7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE
M7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@
M(')E='5R;B!S96QF+FYO9&5?8V]U;G0H;V)J*0H*8VQA<W,@07-S;V-I871I
M=F5#;VYT86EN97)-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D
M36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92DZ"B`@("`@
M("`@9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L9BP*
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!M
M871C:&5R7VYA;65?<')E9FEX("L@;F%M92D*("`@("`@("!S96QF+E]N86UE
M(#T@;F%M90H@("`@("`@('-E;&8N7VUE=&AO9%]D:6-T(#T@>PH@("`@("`@
M("`@("`G<VEZ92<Z($QI8E-T9$-X>%A-971H;V0H)W-I>F4G+"!!<W-O8VEA
M=&EV94-O;G1A:6YE<E-I>F57;W)K97(I+`H@("`@("`@("`@("`G96UP='DG
M.B!,:6)3=&1#>'A8365T:&]D*"=E;7!T>2<L"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@07-S;V-I871I=F5#;VYT86EN97)%;7!T
M>5=O<FME<BDL"B`@("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`](%MS
M96QF+E]M971H;V1?9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?9&EC
M=%T*"B`@("!D968@;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D7VYA
M;64I.@H@("`@("`@(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K.CHI
M/R5S/"XJ/B0G("4@<V5L9BY?;F%M92P@8VQA<W-?='EP92YT86<I.@H@("`@
M("`@("`@("!R971U<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE
M=&AO9%]D:6-T+F=E="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@
M:7,@3F]N92!O<B!N;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E
M='5R;B!.;VYE"B`@("`@("`@=6YO<F1E<F5D(#T@)W5N;W)D97)E9"<@:6X@
M<V5L9BY?;F%M90H@("`@("`@(')E='5R;B!M971H;V0N=V]R:V5R7V-L87-S
M*'5N;W)D97)E9"D*"B,@6&UE=&AO9',@9F]R('-T9#HZ=6YI<75E7W!T<@H*
M8VQA<W,@56YI<75E4'1R1V5T5V]R:V5R*&=D8BYX;65T:&]D+EA-971H;V17
M;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D.CIU;FEQ=65?<'1R/%0^.CIG
M970H*2!A;F0@<W1D.CIU;FEQ=65?<'1R/%0^.CIO<&5R871O<BT^*"DB"@H@
M("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?='EP92DZ"B`@("`@("`@<V5L
M9BY?:7-?87)R87D@/2!E;&5M7W1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%
M7T%24D%9"B`@("`@("`@:68@<V5L9BY?:7-?87)R87DZ"B`@("`@("`@("`@
M('-E;&8N7V5L96U?='EP92`](&5L96U?='EP92YT87)G970H*0H@("`@("`@
M(&5L<V4Z"B`@("`@("`@("`@('-E;&8N7V5L96U?='EP92`](&5L96U?='EP
M90H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R
M;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@
M("`@("`@(')E='5R;B!S96QF+E]E;&5M7W1Y<&4N<&]I;G1E<B@I"@H@("`@
M9&5F(%]S=7!P;W)T<RAS96QF+"!M971H;V1?;F%M92DZ"B`@("`@("`@(F]P
M97)A=&]R+3X@:7,@;F]T('-U<'!O<G1E9"!F;W(@=6YI<75E7W!T<CQ46UT^
M(@H@("`@("`@(')E='5R;B!M971H;V1?;F%M92`]/2`G9V5T)R!O<B!N;W0@
M<V5L9BY?:7-?87)R87D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*
M("`@("`@("!I;7!L7W1Y<&4@/2!O8FHN9&5R969E<F5N8V4H*2YT>7!E+F9I
M96QD<R@I6S!=+G1Y<&4N=&%G"B`@("`@("`@:68@<F4N;6%T8V@H)UYS=&0Z
M.BA?7UQD*SHZ*3]?7W5N:7%?<'1R7VEM<&P\+BH^)"<L(&EM<&Q?='EP92DZ
M(",@3F5W(&EM<&QE;65N=&%T:6]N"B`@("`@("`@("`@(')E='5R;B!O8FI;
M)U]-7W0G75LG7TU?="==6R=?35]H96%D7VEM<&PG70H@("`@("`@(&5L:68@
M<F4N;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]T=7!L93PN*CXD)RP@:6UP;%]T
M>7!E*3H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?="==6R=?35]H96%D
M7VEM<&PG70H@("`@("`@(')E='5R;B!.;VYE"@IC;&%S<R!5;FEQ=650=')$
M97)E9E=O<FME<BA5;FEQ=650=')'9717;W)K97(I.@H@("`@(DEM<&QE;65N
M=',@<W1D.CIU;FEQ=65?<'1R/%0^.CIO<&5R871O<BHH*2(*"B`@("!D968@
M7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@("`@("!5;FEQ=650=')'
M9717;W)K97(N7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*0H*("`@(&1E9B!G
M971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L
M9BY?96QE;5]T>7!E"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M971H;V1?
M;F%M92DZ"B`@("`@("`@(F]P97)A=&]R*B!I<R!N;W0@<W5P<&]R=&5D(&9O
M<B!U;FEQ=65?<'1R/%1;73XB"B`@("`@("`@<F5T=7)N(&YO="!S96QF+E]I
M<U]A<G)A>0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@
M(')E='5R;B!5;FEQ=650=')'9717;W)K97(N7U]C86QL7U\H<V5L9BP@;V)J
M*2YD97)E9F5R96YC92@I"@IC;&%S<R!5;FEQ=650=')3=6)S8W)I<'17;W)K
M97(H56YI<75E4'1R1V5T5V]R:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ
M=6YI<75E7W!T<CQ4/CHZ;W!E<F%T;W);72AS:7IE7W0I(@H*("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I.@H@("`@("`@(%5N:7%U95!T<D=E
M=%=O<FME<BY?7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E
M=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ
M95]T>7!E*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@
M:6YD97@I.@H@("`@("`@(')E='5R;B!S96QF+E]E;&5M7W1Y<&4*"B`@("!D
M968@7W-U<'!O<G1S*'-E;&8L(&UE=&AO9%]N86UE*3H*("`@("`@("`B;W!E
M<F%T;W);72!I<R!O;FQY('-U<'!O<G1E9"!F;W(@=6YI<75E7W!T<CQ46UT^
M(@H@("`@("`@(')E='5R;B!S96QF+E]I<U]A<G)A>0H*("`@(&1E9B!?7V-A
M;&Q?7RAS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U<FX@56YI<75E
M4'1R1V5T5V]R:V5R+E]?8V%L;%]?*'-E;&8L(&]B:BE;:6YD97A="@IC;&%S
M<R!5;FEQ=650=')-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D
M36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@("`@("`@9V1B
M+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L9BP*("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!M871C:&5R
M7VYA;65?<')E9FEX("L@)W5N:7%U95]P='(G*0H@("`@("`@('-E;&8N7VUE
M=&AO9%]D:6-T(#T@>PH@("`@("`@("`@("`G9V5T)SH@3&EB4W1D0WAX6$UE
M=&AO9"@G9V5T)RP@56YI<75E4'1R1V5T5V]R:V5R*2P*("`@("`@("`@("`@
M)V]P97)A=&]R+3XG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R871O<BT^)RP@
M56YI<75E4'1R1V5T5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R*B<Z
M($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R*B<L(%5N:7%U95!T<D1E<F5F
M5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R6UTG.B!,:6)3=&1#>'A8
M365T:&]D*"=O<&5R871O<EM=)RP@56YI<75E4'1R4W5B<V-R:7!T5V]R:V5R
M*2P*("`@("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE
M=&AO9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T70H*("`@
M(&1E9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@
M("`@("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_=6YI<75E
M7W!T<CPN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U
M<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E
M="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N
M;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@
M("`@("`@=V]R:V5R(#T@;65T:&]D+G=O<FME<E]C;&%S<RAC;&%S<U]T>7!E
M+G1E;7!L871E7V%R9W5M96YT*#`I*0H@("`@("`@(&EF('=O<FME<BY?<W5P
M<&]R=',H;65T:&]D7VYA;64I.@H@("`@("`@("`@("!R971U<FX@=V]R:V5R
M"B`@("`@("`@<F5T=7)N($YO;F4*"B,@6&UE=&AO9',@9F]R('-T9#HZ<VAA
M<F5D7W!T<@H*8VQA<W,@4VAA<F5D4'1R1V5T5V]R:V5R*&=D8BYX;65T:&]D
M+EA-971H;V17;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D.CIS:&%R961?
M<'1R/%0^.CIG970H*2!A;F0@<W1D.CIS:&%R961?<'1R/%0^.CIO<&5R871O
M<BT^*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?='EP92DZ"B`@
M("`@("`@<V5L9BY?:7-?87)R87D@/2!E;&5M7W1Y<&4N8V]D92`]/2!G9&(N
M5%E015]#3T1%7T%24D%9"B`@("`@("`@:68@<V5L9BY?:7-?87)R87DZ"B`@
M("`@("`@("`@('-E;&8N7V5L96U?='EP92`](&5L96U?='EP92YT87)G970H
M*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N7V5L96U?='EP92`]
M(&5L96U?='EP90H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@
M("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF
M+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]E;&5M7W1Y<&4N<&]I;G1E
M<B@I"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M971H;V1?;F%M92DZ"B`@
M("`@("`@(F]P97)A=&]R+3X@:7,@;F]T('-U<'!O<G1E9"!F;W(@<VAA<F5D
M7W!T<CQ46UT^(@H@("`@("`@(')E='5R;B!M971H;V1?;F%M92`]/2`G9V5T
M)R!O<B!N;W0@<V5L9BY?:7-?87)R87D*"B`@("!D968@7U]C86QL7U\H<V5L
M9BP@;V)J*3H*("`@("`@("!R971U<FX@;V)J6R=?35]P='(G70H*8VQA<W,@
M4VAA<F5D4'1R1&5R9697;W)K97(H4VAA<F5D4'1R1V5T5V]R:V5R*3H*("`@
M("));7!L96UE;G1S('-T9#HZ<VAA<F5D7W!T<CQ4/CHZ;W!E<F%T;W(J*"DB
M"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L96U?='EP92DZ"B`@("`@("`@
M4VAA<F5D4'1R1V5T5V]R:V5R+E]?:6YI=%]?*'-E;&8L(&5L96U?='EP92D*
M"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@
M<F5T=7)N('-E;&8N7V5L96U?='EP90H*("`@(&1E9B!?<W5P<&]R=',H<V5L
M9BP@;65T:&]D7VYA;64I.@H@("`@("`@(")O<&5R871O<BH@:7,@;F]T('-U
M<'!O<G1E9"!F;W(@<VAA<F5D7W!T<CQ46UT^(@H@("`@("`@(')E='5R;B!N
M;W0@<V5L9BY?:7-?87)R87D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J
M*3H*("`@("`@("!R971U<FX@4VAA<F5D4'1R1V5T5V]R:V5R+E]?8V%L;%]?
M*'-E;&8L(&]B:BDN9&5R969E<F5N8V4H*0H*8VQA<W,@4VAA<F5D4'1R4W5B
M<V-R:7!T5V]R:V5R*%-H87)E9%!T<D=E=%=O<FME<BDZ"B`@("`B26UP;&5M
M96YT<R!S=&0Z.G-H87)E9%]P='(\5#XZ.F]P97)A=&]R6UTH<VEZ95]T*2(*
M"B`@("!D968@7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@("`@("!3
M:&%R9610=')'9717;W)K97(N7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*0H*
M("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!G
M971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U<FX@<V5L9BY?96QE;5]T
M>7!E"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M971H;V1?;F%M92DZ"B`@
M("`@("`@(F]P97)A=&]R6UT@:7,@;VYL>2!S=7!P;W)T960@9F]R('-H87)E
M9%]P='(\5%M=/B(*("`@("`@("!R971U<FX@<V5L9BY?:7-?87)R87D*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@(R!#
M:&5C:R!B;W5N9',@:68@7V5L96U?='EP92!I<R!A;B!A<G)A>2!O9B!K;F]W
M;B!B;W5N9`H@("`@("`@(&T@/2!R92YM871C:"@G+BI<6RA<9"LI720G+"!S
M='(H<V5L9BY?96QE;5]T>7!E*2D*("`@("`@("!I9B!M(&%N9"!I;F1E>"`^
M/2!I;G0H;2YG<F]U<"@Q*2DZ"B`@("`@("`@("`@(')A:7-E($EN9&5X17)R
M;W(H)W-H87)E9%]P='(\)7,^(&EN9&5X("(E9"(@<VAO=6QD(&YO="!B92`^
M/2`E9"XG("4*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`H<V5L9BY?
M96QE;5]T>7!E+"!I;G0H:6YD97@I+"!I;G0H;2YG<F]U<"@Q*2DI*0H@("`@
M("`@(')E='5R;B!3:&%R9610=')'9717;W)K97(N7U]C86QL7U\H<V5L9BP@
M;V)J*5MI;F1E>%T*"F-L87-S(%-H87)E9%!T<E5S94-O=6YT5V]R:V5R*&=D
M8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D
M.CIS:&%R961?<'1R/%0^.CIU<V5?8V]U;G0H*2(*"B`@("!D968@7U]I;FET
M7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@("`@("!3:&%R9610=')5<V5#;W5N
M=%=O<FME<BY?7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E
M=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D
M968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N
M(&=D8BYL;V]K=7!?='EP92@G;&]N9R<I"@H@("`@9&5F(%]?8V%L;%]?*'-E
M;&8L(&]B:BDZ"B`@("`@("`@<F5F8V]U;G1S(#T@6R=?35]R969C;W5N="==
M6R=?35]P:2=="B`@("`@("`@<F5T=7)N(')E9F-O=6YT<ULG7TU?=7-E7V-O
M=6YT)UT@:68@<F5F8V]U;G1S(&5L<V4@,`H*8VQA<W,@4VAA<F5D4'1R56YI
M<75E5V]R:V5R*%-H87)E9%!T<E5S94-O=6YT5V]R:V5R*3H*("`@("));7!L
M96UE;G1S('-T9#HZ<VAA<F5D7W!T<CQ4/CHZ=6YI<75E*"DB"@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L(&5L96U?='EP92DZ"B`@("`@("`@4VAA<F5D4'1R
M57-E0V]U;G17;W)K97(N7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*0H*("`@
M(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U
M<FX@9V1B+FQO;VMU<%]T>7!E*"=B;V]L)RD*"B`@("!D968@7U]C86QL7U\H
M<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@4VAA<F5D4'1R57-E0V]U;G17
M;W)K97(N7U]C86QL7U\H<V5L9BP@;V)J*2`]/2`Q"@IC;&%S<R!3:&%R9610
M=')-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BDZ
M"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@("`@("`@9V1B+GAM971H;V0N
M6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L9BP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!M871C:&5R7VYA;65?<')E
M9FEX("L@)W-H87)E9%]P='(G*0H@("`@("`@('-E;&8N7VUE=&AO9%]D:6-T
M(#T@>PH@("`@("`@("`@("`G9V5T)SH@3&EB4W1D0WAX6$UE=&AO9"@G9V5T
M)RP@4VAA<F5D4'1R1V5T5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R
M+3XG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R871O<BT^)RP@4VAA<F5D4'1R
M1V5T5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R*B<Z($QI8E-T9$-X
M>%A-971H;V0H)V]P97)A=&]R*B<L(%-H87)E9%!T<D1E<F5F5V]R:V5R*2P*
M("`@("`@("`@("`@)V]P97)A=&]R6UTG.B!,:6)3=&1#>'A8365T:&]D*"=O
M<&5R871O<EM=)RP@4VAA<F5D4'1R4W5B<V-R:7!T5V]R:V5R*2P*("`@("`@
M("`@("`@)W5S95]C;W5N="<Z($QI8E-T9$-X>%A-971H;V0H)W5S95]C;W5N
M="<L(%-H87)E9%!T<E5S94-O=6YT5V]R:V5R*2P*("`@("`@("`@("`@)W5N
M:7%U92<Z($QI8E-T9$-X>%A-971H;V0H)W5N:7%U92<L(%-H87)E9%!T<E5N
M:7%U95=O<FME<BDL"B`@("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`]
M(%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?
M9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D
M7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K
M.CHI/W-H87)E9%]P='(\+BH^)"<L(&-L87-S7W1Y<&4N=&%G*3H*("`@("`@
M("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M971H;V0@/2!S96QF+E]M971H
M;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@("`@("`@:68@;65T:&]D(&ES
M($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@("`@("`@("`@("!R971U
M<FX@3F]N90H@("`@("`@('=O<FME<B`](&UE=&AO9"YW;W)K97)?8VQA<W,H
M8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N="@P*2D*("`@("`@("!I9B!W
M;W)K97(N7W-U<'!O<G1S*&UE=&AO9%]N86UE*3H*("`@("`@("`@("`@<F5T
M=7)N('=O<FME<@H@("`@("`@(')E='5R;B!.;VYE"@P*9&5F(')E9VES=&5R
M7VQI8G-T9&-X>%]X;65T:&]D<RAL;V-U<RDZ"B`@("!G9&(N>&UE=&AO9"YR
M96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L($%R<F%Y365T:&]D<TUA
M=&-H97(H*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T
M8VAE<BAL;V-U<RP@1F]R=V%R9$QI<W1-971H;V1S36%T8VAE<B@I*0H@("`@
M9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*&QO8W5S+"!$
M97%U94UE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E
M<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L($QI<W1-971H;V1S36%T8VAE<B@I
M*0H@("`@9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*&QO
M8W5S+"!696-T;W)-971H;V1S36%T8VAE<B@I*0H@("`@9V1B+GAM971H;V0N
M<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO8W5S+"!!<W-O
M8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=S970G*2D*("`@(&=D
M8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE<B@*("`@("`@("!L
M;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H;V1S36%T8VAE<B@G;6%P
M)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H
M"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N=&%I;F5R365T:&]D<TUA
M=&-H97(H)VUU;'1I<V5T)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X
M;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N
M=&%I;F5R365T:&]D<TUA=&-H97(H)VUU;'1I;6%P)RDI"B`@("!G9&(N>&UE
M=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L
M($%S<V]C:6%T:79E0V]N=&%I;F5R365T:&]D<TUA=&-H97(H)W5N;W)D97)E
M9%]S970G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T
M8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H
M;V1S36%T8VAE<B@G=6YO<F1E<F5D7VUA<"<I*0H@("`@9V1B+GAM971H;V0N
M<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO8W5S+"!!<W-O
M8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=U;F]R9&5R961?;75L
M=&ES970G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T
M8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H
M;V1S36%T8VAE<B@G=6YO<F1E<F5D7VUU;'1I;6%P)RDI"B`@("!G9&(N>&UE
M=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L(%5N:7%U95!T
M<DUE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X
M;65T:&]D7VUA=&-H97(H;&]C=7,L(%-H87)E9%!T<DUE=&AO9'--871C:&5R
M*"DI"@``````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````+B]P>71H;VXO;&EB<W1D8WAX+W8V+U]?:6YI=%]?+G!Y````
M````````````````````````````````````````````````````````````
M`````````````````````````#`P,#`V-#0`,#8P,3<U,0`P-C`Q-S4Q`#`P
M,#`P,#`R,C$Q`#$S-#4R,S4W-#4Q`#`Q-C$V,P`@,```````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````````````````!U<W1A
M<B`@`&9R961E````````````````````````````````````9G)E9&4`````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````C($-O<'ER:6=H="`H0RD@,C`Q
M-"TR,#$Y($9R964@4V]F='=A<F4@1F]U;F1A=&EO;BP@26YC+@H*(R!4:&ES
M('!R;V=R86T@:7,@9G)E92!S;V9T=V%R93L@>6]U(&-A;B!R961I<W1R:6)U
M=&4@:70@86YD+V]R(&UO9&EF>0HC(&ET('5N9&5R('1H92!T97)M<R!O9B!T
M:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@87,@<'5B;&ES:&5D(&)Y
M"B,@=&AE($9R964@4V]F='=A<F4@1F]U;F1A=&EO;CL@96ET:&5R('9E<G-I
M;VX@,R!O9B!T:&4@3&EC96YS92P@;W(*(R`H870@>6]U<B!O<'1I;VXI(&%N
M>2!L871E<B!V97)S:6]N+@HC"B,@5&AI<R!P<F]G<F%M(&ES(&1I<W1R:6)U
M=&5D(&EN('1H92!H;W!E('1H870@:70@=VEL;"!B92!U<V5F=6PL"B,@8G5T
M(%=)5$A/550@04Y9(%=!4E)!3E19.R!W:71H;W5T(&5V96X@=&AE(&EM<&QI
M960@=V%R<F%N='D@;V8*(R!-15)#2$%.5$%"24Q)5%D@;W(@1DE43D534R!&
M3U(@02!005)424-53$%2(%!54E!/4T4N("!3964@=&AE"B,@1TY5($=E;F5R
M86P@4'5B;&EC($QI8V5N<V4@9F]R(&UO<F4@9&5T86EL<RX*(PHC(%EO=2!S
M:&]U;&0@:&%V92!R96-E:79E9"!A(&-O<'D@;V8@=&AE($=.52!'96YE<F%L
M(%!U8FQI8R!,:6-E;G-E"B,@86QO;F<@=VET:"!T:&ES('!R;V=R86TN("!)
M9B!N;W0L('-E92`\:'1T<#HO+W=W=RYG;G4N;W)G+VQI8V5N<V5S+SXN"@II
M;7!O<G0@9V1B"@HC($QO860@=&AE('AM971H;V1S(&EF($=$0B!S=7!P;W)T
M<R!T:&5M+@ID968@9V1B7VAA<U]X;65T:&]D<R@I.@H@("`@=')Y.@H@("`@
M("`@(&EM<&]R="!G9&(N>&UE=&AO9`H@("`@("`@(')E='5R;B!4<G5E"B`@
M("!E>&-E<'0@26UP;W)T17)R;W(Z"B`@("`@("`@<F5T=7)N($9A;'-E"@ID
M968@<F5G:7-T97)?;&EB<W1D8WAX7W!R:6YT97)S*&]B:BDZ"B`@("`C($QO
M860@=&AE('!R971T>2UP<FEN=&5R<RX*("`@(&9R;VT@+G!R:6YT97)S(&EM
M<&]R="!R96=I<W1E<E]L:6)S=&1C>'A?<')I;G1E<G,*("`@(')E9VES=&5R
M7VQI8G-T9&-X>%]P<FEN=&5R<RAO8FHI"@H@("`@:68@9V1B7VAA<U]X;65T
M:&]D<R@I.@H@("`@("`@(&9R;VT@+GAM971H;V1S(&EM<&]R="!R96=I<W1E
M<E]L:6)S=&1C>'A?>&UE=&AO9',*("`@("`@("!R96=I<W1E<E]L:6)S=&1C
M>'A?>&UE=&AO9',H;V)J*0H`````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````N+W!Y=&AO;B]L:6)S
M=&1C>'@O7U]I;FET7U\N<'D`````````````````````````````````````
M````````````````````````````````````````````````````````,#`P
M,#8T-``P-C`Q-S4Q`#`V,#$W-3$`,#`P,#`P,#`P,#$`,3,T-3(S-3<T-3$`
M,#$U-C(S`"`P````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````'5S=&%R("``9G)E9&4`````````````````
M``````````````````!F<F5D90``````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````H`````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````+B]P>71H;VXO36%K969I;&4N86T`````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````#`P,#`V-#0`,#8P,3<U
M,0`P-C`Q-S4Q`#`P,#`P,#`T,S,W`#$S-#4R,S4W-#4Q`#`Q,S4V,@`@,```
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````````!U<W1A<B`@`&9R961E````````````````````````````````
M````9G)E9&4`````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````````````C(R!-86ME
M9FEL92!F;W(@=&AE('!Y=&AO;B!S=6)D:7)E8W1O<GD@;V8@=&AE($=.52!#
M*RL@4W1A;F1A<F0@;&EB<F%R>2X*(R,*(R,@0V]P>7)I9VAT("A#*2`R,#`Y
M+3(P,3D@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N+"!);F,N"B,C"B,C(%1H
M:7,@9FEL92!I<R!P87)T(&]F('1H92!L:6)S=&1C*RL@=F5R<VEO;B`S(&1I
M<W1R:6)U=&EO;BX*(R,@4')O8V5S<R!T:&ES(&9I;&4@=VET:"!A=71O;6%K
M92!T;R!P<F]D=6-E($UA:V5F:6QE+FEN+@H*(R,@5&AI<R!F:6QE(&ES('!A
M<G0@;V8@=&AE($=.52!)4T\@0RLK($QI8G)A<GDN("!4:&ES(&QI8G)A<GD@
M:7,@9G)E90HC(R!S;V9T=V%R93L@>6]U(&-A;B!R961I<W1R:6)U=&4@:70@
M86YD+V]R(&UO9&EF>2!I="!U;F1E<B!T:&4*(R,@=&5R;7,@;V8@=&AE($=.
M52!'96YE<F%L(%!U8FQI8R!,:6-E;G-E(&%S('!U8FQI<VAE9"!B>2!T:&4*
M(R,@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N.R!E:71H97(@=F5R<VEO;B`S
M+"!O<B`H870@>6]U<B!O<'1I;VXI"B,C(&%N>2!L871E<B!V97)S:6]N+@HC
M(PHC(R!4:&ES(&QI8G)A<GD@:7,@9&ES=')I8G5T960@:6X@=&AE(&AO<&4@
M=&AA="!I="!W:6QL(&)E('5S969U;"P*(R,@8G5T(%=)5$A/550@04Y9(%=!
M4E)!3E19.R!W:71H;W5T(&5V96X@=&AE(&EM<&QI960@=V%R<F%N='D@;V8*
M(R,@34520TA!3E1!0DE,2519(&]R($9)5$Y%4U,@1D]2($$@4$%25$E#54Q!
M4B!055)03U-%+B`@4V5E('1H90HC(R!'3E4@1V5N97)A;"!0=6)L:6,@3&EC
M96YS92!F;W(@;6]R92!D971A:6QS+@HC(PHC(R!9;W4@<VAO=6QD(&AA=F4@
M<F5C96EV960@82!C;W!Y(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@3&EC
M96YS92!A;&]N9PHC(R!W:71H('1H:7,@;&EB<F%R>3L@<V5E('1H92!F:6QE
M($-/4%E)3D<S+B`@268@;F]T('-E90HC(R`\:'1T<#HO+W=W=RYG;G4N;W)G
M+VQI8V5N<V5S+SXN"@II;F-L=61E("0H=&]P7W-R8V1I<BDO9G)A9VUE;G0N
M86T*"B,C(%=H97)E('1O(&EN<W1A;&P@=&AE(&UO9'5L92!C;V1E+@II9B!%
M3D%"3$5?4%E42$].1$E2"G!Y=&AO;F1I<B`]("0H<')E9FEX*2\D*'!Y=&AO
M;E]M;V1?9&ER*0IE;'-E"G!Y=&AO;F1I<B`]("0H9&%T861I<BDO9V-C+20H
M9V-C7W9E<G-I;VXI+W!Y=&AO;@IE;F1I9@H*86QL+6QO8V%L.B!G9&(N<'D*
M"FYO8F%S95]P>71H;VY?1$%402`](%P*("`@(&QI8G-T9&-X>"]V-B]P<FEN
M=&5R<RYP>2!<"B`@("!L:6)S=&1C>'@O=C8O>&UE=&AO9',N<'D@7`H@("`@
M;&EB<W1D8WAX+W8V+U]?:6YI=%]?+G!Y(%P*("`@(&QI8G-T9&-X>"]?7VEN
M:71?7RYP>0H*9V1B+G!Y.B!H;V]K+FEN($UA:V5F:6QE"@ES960@+64@)W,L
M0'!Y=&AO;F1I<D`L)"AP>71H;VYD:7(I+"<@7`H)("`@("UE("=S+$!T;V]L
M97AE8VQI8F1I<D`L)"AT;V]L97AE8VQI8F1I<BDL)R`\("0H<W)C9&ER*2]H
M;V]K+FEN(#X@)$`*"FEN<W1A;&PM9&%T82UL;V-A;#H@9V1B+G!Y"@E`)"AM
M:V1I<E]P*2`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BD*(R,@5V4@=V%N
M="!T;R!I;G-T86QL(&=D8BYP>2!A<R!33TU%5$A)3D<M9V1B+G!Y+B`@4T]-
M151(24Y'(&ES('1H90HC(R!F=6QL(&YA;64@;V8@=&AE(&9I;F%L(&QI8G)A
M<GDN("!792!W86YT('1O(&EG;F]R92!S>6UL:6YK<RP@=&AE"B,C("YL82!F
M:6QE+"!A;F0@86YY('!R979I;W5S("UG9&(N<'D@9FEL92X@(%1H:7,@:7,@
M:6YH97)E;G1L>0HC(R!F<F%G:6QE+"!B=70@=&AE<F4@9&]E<R!N;W0@<V5E
M;2!T;R!B92!A(&)E='1E<B!O<'1I;VXL(&)E8V%U<V4*(R,@;&EB=&]O;"!H
M:61E<R!T:&4@<F5A;"!N86UE<R!F<F]M('5S+@H)0&AE<F4]8'!W9&`[(&-D
M("0H1$535$1)4BDD*'1O;VQE>&5C;&EB9&ER*3L@7`H)("!F;W(@9FEL92!I
M;B!L:6)S=&1C*RLN*CL@9&\@7`H)("`@(&-A<V4@)"1F:6QE(&EN(%P*"2`@
M("`@("HM9V1B+G!Y*2`[.R!<"@D@("`@("`J+FQA*2`[.R!<"@D@("`@("`J
M*2!I9B!T97-T("UH("0D9FEL93L@=&AE;B!<"@D@("`@("`@("`@(&-O;G1I
M;G5E.R!<"@D@("`@("`@("!F:3L@7`H)("`@("`@("`@;&EB;F%M93TD)&9I
M;&4[.R!<"@D@("`@97-A8SL@7`H)("!D;VYE.R!<"@EC9"`D)&AE<F4[(%P*
M"65C:&\@(B`D*$E.4U1!3$Q?1$%402D@9V1B+G!Y("0H1$535$1)4BDD*'1O
M;VQE>&5C;&EB9&ER*2\D)&QI8FYA;64M9V1B+G!Y(CL@7`H))"A)3E-404Q,
M7T1!5$$I(&=D8BYP>2`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BDO)"1L
M:6)N86UE+6=D8BYP>0H`````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````+B]P>71H;VXO36%K
M969I;&4N:6X`````````````````````````````````````````````````
M`````````````````````````````````````````````````````````#`P
M,#`V-#0`,#8P,3<U,0`P-C`Q-S4Q`#`P,#`P,#0T-3$P`#$S-#4R,S4W-#4Q
M`#`Q,S4W,``@,```````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````!U<W1A<B`@`&9R961E````````````````
M````````````````````9G)E9&4`````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````C($UA:V5F:6QE+FEN(&=E;F5R871E9"!B>2!A=71O;6%K92`Q+C$U
M+C$@9G)O;2!-86ME9FEL92YA;2X*(R!`8V]N9FEG=7)E7VEN<'5T0`H*(R!#
M;W!Y<FEG:'0@*$,I(#$Y.30M,C`Q-R!&<F5E(%-O9G1W87)E($9O=6YD871I
M;VXL($EN8RX*"B,@5&AI<R!-86ME9FEL92YI;B!I<R!F<F5E('-O9G1W87)E
M.R!T:&4@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N"B,@9VEV97,@=6YL:6UI
M=&5D('!E<FUI<W-I;VX@=&\@8V]P>2!A;F0O;W(@9&ES=')I8G5T92!I="P*
M(R!W:71H(&]R('=I=&AO=70@;6]D:69I8V%T:6]N<RP@87,@;&]N9R!A<R!T
M:&ES(&YO=&EC92!I<R!P<F5S97)V960N"@HC(%1H:7,@<')O9W)A;2!I<R!D
M:7-T<FEB=71E9"!I;B!T:&4@:&]P92!T:&%T(&ET('=I;&P@8F4@=7-E9G5L
M+`HC(&)U="!7251(3U54($%.62!705)204Y462P@=&\@=&AE(&5X=&5N="!P
M97)M:71T960@8GD@;&%W.R!W:71H;W5T"B,@979E;B!T:&4@:6UP;&EE9"!W
M87)R86YT>2!O9B!-15)#2$%.5$%"24Q)5%D@;W(@1DE43D534R!&3U(@00HC
M(%!!4E1)0U5,05(@4%524$]312X*"D!3151?34%+14`*"E90051((#T@0'-R
M8V1I<D`*86U?7VES7V=N=5]M86ME(#T@>R!<"B`@:68@=&5S="`M>B`G)"A-
M04M%3$5614PI)SL@=&AE;B!<"B`@("!F86QS93L@7`H@(&5L:68@=&5S="`M
M;B`G)"A-04M%7TA/4U0I)SL@=&AE;B!<"B`@("!T<G5E.R!<"B`@96QI9B!T
M97-T("UN("<D*$U!2T5?5D524TE/3BDG("8F('1E<W0@+6X@)R0H0U521$E2
M*2<[('1H96X@7`H@("`@=')U93L@7`H@(&5L<V4@7`H@("`@9F%L<V4[(%P*
M("!F:3L@7`I]"F%M7U]M86ME7W)U;FYI;F=?=VET:%]O<'1I;VX@/2!<"B`@
M8V%S92`D)'MT87)G971?;W!T:6]N+7T@:6X@7`H@("`@("`_*2`[.R!<"B`@
M("`@("HI(&5C:&\@(F%M7U]M86ME7W)U;FYI;F=?=VET:%]O<'1I;VXZ(&EN
M=&5R;F%L(&5R<F]R.B!I;G9A;&ED(B!<"B`@("`@("`@("`@("`@(G1A<F=E
M="!O<'1I;VX@)R0D>W1A<F=E=%]O<'1I;VXM?2<@<W!E8VEF:65D(B`^)C([
M(%P*("`@("`@("`@97AI="`Q.SL@7`H@(&5S86,[(%P*("!H87-?;W!T/6YO
M.R!<"B`@<V%N95]M86ME9FQA9W,])"1-04M%1DQ!1U,[(%P*("!I9B`D*&%M
M7U]I<U]G;G5?;6%K92D[('1H96X@7`H@("`@<V%N95]M86ME9FQA9W,])"1-
M1DQ!1U,[(%P*("!E;'-E(%P*("`@(&-A<V4@)"1-04M%1DQ!1U,@:6X@7`H@
M("`@("`J7%Q;7"!<"5TJ*2!<"B`@("`@("`@8G,]7%P[(%P*("`@("`@("!S
M86YE7VUA:V5F;&%G<SU@<')I;G1F("<E<UQN)R`B)"1-04M%1DQ!1U,B(%P*
M("`@("`@("`@('P@<V5D(")S+R0D8G,D)&)S6R0D8G,@)"1B<PE=*B\O9R)@
M.SL@7`H@("`@97-A8SL@7`H@(&9I.R!<"B`@<VMI<%]N97AT/6YO.R!<"B`@
M<W1R:7!?=')A:6QO<'0@*"D@7`H@('L@7`H@("`@9FQG/6!P<FEN=&8@)R5S
M7&XG("(D)&9L9R(@?"!S960@(G,O)"0Q+BHD)"\O(F`[(%P*("!].R!<"B`@
M9F]R(&9L9R!I;B`D)'-A;F5?;6%K969L86=S.R!D;R!<"B`@("!T97-T("0D
M<VMI<%]N97AT(#T@>65S("8F('L@<VMI<%]N97AT/6YO.R!C;VYT:6YU93L@
M?3L@7`H@("`@8V%S92`D)&9L9R!I;B!<"B`@("`@("H]*GPM+2HI(&-O;G1I
M;G5E.SL@7`H@("`@("`@("TJ22D@<W1R:7!?=')A:6QO<'0@)TDG.R!S:VEP
M7VYE>'0]>65S.SL@7`H@("`@("`M*DD_*BD@<W1R:7!?=')A:6QO<'0@)TDG
M.SL@7`H@("`@("`@("TJ3RD@<W1R:7!?=')A:6QO<'0@)T\G.R!S:VEP7VYE
M>'0]>65S.SL@7`H@("`@("`M*D\_*BD@<W1R:7!?=')A:6QO<'0@)T\G.SL@
M7`H@("`@("`@("TJ;"D@<W1R:7!?=')A:6QO<'0@)VPG.R!S:VEP7VYE>'0]
M>65S.SL@7`H@("`@("`M*FP_*BD@<W1R:7!?=')A:6QO<'0@)VPG.SL@7`H@
M("`@("`M6V1%1&U=*2!S:VEP7VYE>'0]>65S.SL@7`H@("`@("`M6TI472D@
M<VMI<%]N97AT/7EE<SL[(%P*("`@(&5S86,[(%P*("`@(&-A<V4@)"1F;&<@
M:6X@7`H@("`@("`J)"1T87)G971?;W!T:6]N*BD@:&%S7V]P=#UY97,[(&)R
M96%K.SL@7`H@("`@97-A8SL@7`H@(&1O;F4[(%P*("!T97-T("0D:&%S7V]P
M="`]('EE<PIA;5]?;6%K95]D<GER=6X@/2`H=&%R9V5T7V]P=&EO;CUN.R`D
M*&%M7U]M86ME7W)U;FYI;F=?=VET:%]O<'1I;VXI*0IA;5]?;6%K95]K965P
M9V]I;F<@/2`H=&%R9V5T7V]P=&EO;CUK.R`D*&%M7U]M86ME7W)U;FYI;F=?
M=VET:%]O<'1I;VXI*0IP:V=D871A9&ER(#T@)"AD871A9&ER*2]`4$%#2T%'
M14`*<&MG:6YC;'5D961I<B`]("0H:6YC;'5D961I<BDO0%!!0TM!1T5`"G!K
M9VQI8F1I<B`]("0H;&EB9&ER*2]`4$%#2T%'14`*<&MG;&EB97AE8V1I<B`]
M("0H;&EB97AE8V1I<BDO0%!!0TM!1T5`"F%M7U]C9"`]($-$4$%42#TB)"1[
M6E-(7U9%4E-)3TXK+GTD*%!!5$A?4T5005)!5$]2*2(@)B8@8V0*:6YS=&%L
M;%]S:%]$051!(#T@)"AI;G-T86QL7W-H*2`M8R`M;2`V-#0*:6YS=&%L;%]S
M:%]04D]'4D%-(#T@)"AI;G-T86QL7W-H*2`M8PII;G-T86QL7W-H7U-#4DE0
M5"`]("0H:6YS=&%L;%]S:"D@+6,*24Y35$%,3%](14%$15(@/2`D*$E.4U1!
M3$Q?1$%402D*=')A;G-F;W)M(#T@)"AP<F]G<F%M7W1R86YS9F]R;5]N86UE
M*0I.3U)-04Q?24Y35$%,3"`](#H*4%)%7TE.4U1!3$P@/2`Z"E!/4U1?24Y3
M5$%,3"`](#H*3D]234%,7U5.24Y35$%,3"`](#H*4%)%7U5.24Y35$%,3"`]
M(#H*4$]35%]53DE.4U1!3$P@/2`Z"F)U:6QD7W1R:7!L970@/2!`8G5I;&1`
M"FAO<W1?=')I<&QE="`]($!H;W-T0`IT87)G971?=')I<&QE="`]($!T87)G
M971`"G-U8F1I<B`]('!Y=&AO;@I!0TQ/0T%,7TTT(#T@)"AT;W!?<W)C9&ER
M*2]A8VQO8V%L+FTT"F%M7U]A8VQO8V%L7VTT7V1E<',@/2`D*'1O<%]S<F-D
M:7(I+RXN+V-O;F9I9R]A8W@N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF
M:6<O96YA8FQE+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V9U=&5X
M+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VAW8V%P<RYM-"!<"@DD
M*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]I8V]N=BYM-"!<"@DD*'1O<%]S<F-D
M:7(I+RXN+V-O;F9I9R]L96%D+61O="YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN
M+V-O;F9I9R]L:6(M;&0N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O
M;&EB+6QI;FLN;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;&EB+7!R
M969I>"YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]L=&AO<W1F;&%G
M<RYM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]M=6QT:2YM-"!<"@DD
M*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]N;RUE>&5C=71A8FQE<RYM-"!<"@DD
M*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]O=F5R<FED92YM-"!<"@DD*'1O<%]S
M<F-D:7(I+RXN+V-O;F9I9R]S=&1I;G0N;30@7`H))"AT;W!?<W)C9&ER*2\N
M+B]C;VYF:6<O=6YW:6YD7VEP:6YF;RYM-"!<"@DD*'1O<%]S<F-D:7(I+RXN
M+VQI8G1O;VPN;30@)"AT;W!?<W)C9&ER*2\N+B]L=&]P=&EO;G,N;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]L='-U9V%R+FTT("0H=&]P7W-R8V1I<BDO+BXO
M;'1V97)S:6]N+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO;'1^;V)S;VQE=&4N
M;30@)"AT;W!?<W)C9&ER*2]C<F]S<V-O;F9I9RYM-"!<"@DD*'1O<%]S<F-D
M:7(I+VQI;FMA9V4N;30@)"AT;W!?<W)C9&ER*2]A8VEN8VQU9&4N;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O9V,K*V9I;'0N;30@7`H))"AT;W!?
M<W)C9&ER*2\N+B]C;VYF:6<O=&QS+FTT("0H=&]P7W-R8V1I<BDO+BXO8V]N
M9FEG+V=T:'(N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O8V5T+FTT
M("0H=&]P7W-R8V1I<BDO8V]N9FEG=7)E+F%C"F%M7U]C;VYF:6=U<F5?9&5P
M<R`]("0H86U?7V%C;&]C86Q?;31?9&5P<RD@)"A#3TY&24=54D5?1$5014Y$
M14Y#2453*2!<"@DD*$%#3$]#04Q?330I"D1)4U1?0T]-34].(#T@)"AS<F-D
M:7(I+TUA:V5F:6QE+F%M"D-/3D9)1U](14%$15(@/2`D*'1O<%]B=6EL9&1I
M<BDO8V]N9FEG+F@*0T].1DE'7T-,14%.7T9)3$53(#T*0T].1DE'7T-,14%.
M7U90051(7T9)3$53(#T*04U?5E]0(#T@)"AA;5]?=E]07T!!35]60"D*86U?
M7W9?4%\@/2`D*&%M7U]V7U!?0$%-7T1%1D%53%1?5D`I"F%M7U]V7U!?,"`]
M(&9A;'-E"F%M7U]V7U!?,2`](#H*04U?5E]'14X@/2`D*&%M7U]V7T=%3E]`
M04U?5D`I"F%M7U]V7T=%3E\@/2`D*&%M7U]V7T=%3E]`04U?1$5&055,5%]6
M0"D*86U?7W9?1T5.7S`@/2!`96-H;R`B("!'14X@("`@("(@)$`["F%M7U]V
M7T=%3E\Q(#T@"D%-7U9?870@/2`D*&%M7U]V7V%T7T!!35]60"D*86U?7W9?
M871?(#T@)"AA;5]?=E]A=%]`04U?1$5&055,5%]60"D*86U?7W9?871?,"`]
M($`*86U?7W9?871?,2`](`ID97!C;VUP(#T*86U?7V1E<&9I;&5S7VUA>6)E
M(#T*4T]54D-%4R`]"F%M7U]C86Y?<G5N7VEN<W1A;&QI;F9O(#T@7`H@(&-A
M<V4@)"1!35]54$1!5$5?24Y&3U]$25(@:6X@7`H@("`@;GQN;WQ.3RD@9F%L
M<V4[.R!<"B`@("`J*2`H:6YS=&%L;"UI;F9O("TM=F5R<VEO;BD@/B]D978O
M;G5L;"`R/B8Q.SL@7`H@(&5S86,*86U?7W9P871H7V%D:E]S971U<"`]('-R
M8V1I<G-T<FEP/6!E8VAO("(D*'-R8V1I<BDB('P@<V5D("=S?"Y\+GQG)V`[
M"F%M7U]V<&%T:%]A9&H@/2!C87-E("0D<"!I;B!<"B`@("`D*'-R8V1I<BDO
M*BD@9CU@96-H;R`B)"1P(B!\('-E9"`B<WQ>)"1S<F-D:7)S=')I<"]\?")@
M.SL@7`H@("`@*BD@9CTD)'`[.R!<"B`@97-A8SL*86U?7W-T<FEP7V1I<B`]
M(&8]8&5C:&\@)"1P('P@<V5D("UE("=S?%XN*B]\?"=@.PIA;5]?:6YS=&%L
M;%]M87@@/2`T,`IA;5]?;F]B87-E7W-T<FEP7W-E='5P(#T@7`H@('-R8V1I
M<G-T<FEP/6!E8VAO("(D*'-R8V1I<BDB('P@<V5D("=S+UM=+EM>)"1<7"I\
M72]<7%Q<)B]G)V`*86U?7VYO8F%S95]S=')I<"`](%P*("!F;W(@<"!I;B`D
M)&QI<W0[(&1O(&5C:&\@(B0D<"([(&1O;F4@?"!S960@+64@(G-\)"1S<F-D
M:7)S=')I<"]\?"(*86U?7VYO8F%S95]L:7-T(#T@)"AA;5]?;F]B87-E7W-T
M<FEP7W-E='5P*3L@7`H@(&9O<B!P(&EN("0D;&ES=#L@9&\@96-H;R`B)"1P
M("0D<"([(&1O;F4@?"!<"B`@<V5D(")S?"`D)'-R8V1I<G-T<FEP+WP@?#LB
M)R`O("XJ7"\O(7,O("XJ+R`N+SL@<RQ<*"`N*EPI+UM>+UTJ)"0L7#$L)R!\
M(%P*("`D*$%72RD@)T)%1TE.('L@9FEL97-;(BXB72`]("(B('T@>R!F:6QE
M<ULD)#)=(#T@9FEL97-;)"0R72`B("(@)"0Q.R!<"B`@("!I9B`H*RMN6R0D
M,ET@/3T@)"AA;5]?:6YS=&%L;%]M87@I*2!<"B`@("`@('L@<')I;G0@)"0R
M+"!F:6QE<ULD)#)=.R!N6R0D,ET@/2`P.R!F:6QE<ULD)#)=(#T@(B(@?2!]
M(%P*("`@($5.1"![(&9O<B`H9&ER(&EN(&9I;&5S*2!P<FEN="!D:7(L(&9I
M;&5S6V1I<ET@?2<*86U?7V)A<V5?;&ES="`](%P*("!S960@)R0D(4X[)"0A
M3CLD)"%..R0D(4X[)"0A3CLD)"%..R0D(4X[<R]<;B\@+V<G('P@7`H@('-E
M9"`G)"0A3CLD)"%..R0D(4X[)"0A3CMS+UQN+R`O9R<*86U?7W5N:6YS=&%L
M;%]F:6QE<U]F<F]M7V1I<B`]('L@7`H@('1E<W0@+7H@(B0D9FEL97,B(%P*
M("`@('Q\('L@=&5S="`A("UD("(D)&1I<B(@)B8@=&5S="`A("UF("(D)&1I
M<B(@)B8@=&5S="`A("UR("(D)&1I<B([('T@7`H@("`@?'P@>R!E8VAO("(@
M*"!C9"`G)"1D:7(G("8F(')M("UF(B`D)&9I;&5S("(I(CL@7`H@("`@("`@
M("`D*&%M7U]C9"D@(B0D9&ER(B`F)B!R;2`M9B`D)&9I;&5S.R!].R!<"B`@
M?0IA;5]?:6YS=&%L;&1I<G,@/2`B)"A$15-41$E2*20H<'ET:&]N9&ER*2(*
M1$%402`]("0H;F]B87-E7W!Y=&AO;E]$051!*0IA;5]?=&%G9V5D7V9I;&5S
M(#T@)"A(14%$15)3*2`D*%-/55)#15,I("0H5$%'4U]&24Q%4RD@)"A,25-0
M*0I!0DE?5%=%04M37U-20T1)4B`]($!!0DE?5%=%04M37U-20T1)4D`*04-,
M3T-!3"`]($!!0TQ/0T%,0`I!3$Q/0T%43U)?2"`]($!!3$Q/0T%43U)?2$`*
M04Q,3T-!5$]27TY!344@/2!`04Q,3T-!5$]27TY!345`"D%-5$%2(#T@0$%-
M5$%20`I!35]$149!54Q47U9%4D)/4TE462`]($!!35]$149!54Q47U9%4D)/
M4TE464`*05(@/2!`05)`"D%3(#T@0$%30`I!5$]-24-)5%E?4U)#1$E2(#T@
M0$%43TU)0TE465]34D-$25)`"D%43TU)0U]&3$%'4R`]($!!5$]-24-?1DQ!
M1U-`"D%43TU)0U]73U)$7U-20T1)4B`]($!!5$]-24-?5T]21%]34D-$25)`
M"D%55$]#3TY&(#T@0$%55$]#3TY&0`I!551/2$5!1$52(#T@0$%55$](14%$
M15)`"D%55$]-04M%(#T@0$%55$]-04M%0`I!5TL@/2!`05=+0`I"05-)0U]&
M24Q%7T-#(#T@0$)!4TE#7T9)3$5?0T-`"D)!4TE#7T9)3$5?2"`]($!"05-)
M0U]&24Q%7TA`"D-#(#T@0$-#0`I#0T]$14-65%]#0R`]($!#0T]$14-65%]#
M0T`*0T-/3$Q!5$5?0T,@/2!`0T-/3$Q!5$5?0T-`"D-#5%E015]#0R`]($!#
M0U194$5?0T-`"D-&3$%'4R`]($!#1DQ!1U-`"D-,3T-!3$5?0T,@/2!`0TQ/
M0T%,15]#0T`*0TQ/0T%,15]((#T@0$-,3T-!3$5?2$`*0TQ/0T%,15])3E1%
M4DY!3%]((#T@0$-,3T-!3$5?24Y415).04Q?2$`*0TU%4U-!1T537T-#(#T@
M0$--15-304=%4U]#0T`*0TU%4U-!1T537T@@/2!`0TU%4U-!1T537TA`"D--
M3TY%65]#0R`]($!#34].15E?0T-`"D-.54U%4DE#7T-#(#T@0$-.54U%4DE#
M7T-#0`I#4%`@/2!`0U!00`I#4%!&3$%'4R`]($!#4%!&3$%'4T`*0U!57T1%
M1DE.15-?4U)#1$E2(#T@0$-055]$149)3D537U-20T1)4D`*0U!57T]05%]"
M25137U)!3D1/32`]($!#4%5?3U!47T))5%-?4D%.1$]-0`I#4%5?3U!47T58
M5%]204Y$3TT@/2!`0U!57T]05%]%6%1?4D%.1$]-0`I#4U1$24]?2"`]($!#
M4U1$24]?2$`*0U1)345?0T,@/2!`0U1)345?0T-`"D-424U%7T@@/2!`0U1)
M345?2$`*0UA8(#T@0$-86$`*0UA80U!0(#T@0$-86$-04$`*0UA81DE,5"`]
M($!#6%A&24Q40`I#6%A&3$%'4R`]($!#6%A&3$%'4T`*0UE'4$%42%]7(#T@
M0$-91U!!5$A?5T`*0U])3D-,541%7T1)4B`]($!#7TE.0TQ51$5?1$E20`I$
M0DQ!5$58(#T@0$1"3$%415A`"D1%0E5'7T9,04=3(#T@0$1%0E5'7T9,04=3
M0`I$1493(#T@0$1%1E-`"D1/5"`]($!$3U1`"D1/6%E'14X@/2!`1$]864=%
M3D`*1%-9355424P@/2!`1%-9355424Q`"D1535!"24X@/2!`1%5-4$))3D`*
M14-(3U]#(#T@0$5#2$]?0T`*14-(3U].(#T@0$5#2$]?3D`*14-(3U]4(#T@
M0$5#2$]?5$`*14=215`@/2!`14=215!`"D524D]27T-/3E-404Y44U]34D-$
M25(@/2!`15)23U)?0T].4U1!3E137U-20T1)4D`*15A%15A4(#T@0$581458
M5$`*15A44D%?0T9,04=3(#T@0$585%)!7T-&3$%'4T`*15A44D%?0UA87T9,
M04=3(#T@0$585%)!7T-86%]&3$%'4T`*1D=215`@/2!`1D=215!`"D=,24)#
M6%A?24Y#3%5$15,@/2!`1TQ)0D-86%])3D-,541%4T`*1TQ)0D-86%],24)3
M(#T@0$=,24)#6%A?3$E"4T`*1U)%4"`]($!'4D500`I(5T-!4%]#1DQ!1U,@
M/2!`2%=#05!?0T9,04=30`I)3E-404Q,(#T@0$E.4U1!3$Q`"DE.4U1!3$Q?
M1$%402`]($!)3E-404Q,7T1!5$%`"DE.4U1!3$Q?4%)/1U)!32`]($!)3E-4
M04Q,7U!23T=204U`"DE.4U1!3$Q?4T-225!4(#T@0$E.4U1!3$Q?4T-225!4
M0`I)3E-404Q,7U-44DE07U!23T=204T@/2!`24Y35$%,3%]35%))4%]04D]'
M4D%-0`I,1"`]($!,1$`*3$1&3$%'4R`]($!,1$9,04=30`I,24))0T].5B`]
M($!,24))0T].5D`*3$E"3T)*4R`]($!,24)/0DI30`I,24)3(#T@0$Q)0E-`
M"DQ)0E1/3TP@/2!`3$E"5$]/3$`*3$E03R`]($!,25!/0`I,3E]3(#T@0$Q.
M7U-`"DQ/3D=?1$]50DQ%7T-/35!!5%]&3$%'4R`]($!,3TY'7T1/54),15]#
M3TU0051?1DQ!1U-`"DQ43$E"24-/3E8@/2!`3%1,24))0T].5D`*3%1,24)/
M0DI3(#T@0$Q43$E"3T)*4T`*34%)3E0@/2!`34%)3E1`"DU!2T5)3D9/(#T@
M0$U!2T5)3D9/0`I-2T1)4E]0(#T@0$U+1$E27U!`"DY-(#T@0$Y-0`I.345$
M250@/2!`3DU%1$E40`I/0DI$54U0(#T@0$]"2D1535!`"D]"2D585"`]($!/
M0DI%6%1`"D]05$E-25I%7T-86$9,04=3(#T@0$]05$E-25I%7T-86$9,04=3
M0`I/4%1?3$1&3$%'4R`]($!/4%1?3$1&3$%'4T`*3U-?24Y#7U-20T1)4B`]
M($!/4U])3D-?4U)#1$E20`I/5$]/3"`]($!/5$]/3$`*3U1/3TPV-"`]($!/
M5$]/3#8T0`I004-+04=%(#T@0%!!0TM!1T5`"E!!0TM!1T5?0E5'4D503U)4
M(#T@0%!!0TM!1T5?0E5'4D503U)40`I004-+04=%7TY!344@/2!`4$%#2T%'
M15].04U%0`I004-+04=%7U-44DE.1R`]($!004-+04=%7U-44DE.1T`*4$%#
M2T%'15]405).04U%(#T@0%!!0TM!1T5?5$%23D%-14`*4$%#2T%'15]54DP@
M/2!`4$%#2T%'15]54DQ`"E!!0TM!1T5?5D524TE/3B`]($!004-+04=%7U9%
M4E-)3TY`"E!!5$A?4T5005)!5$]2(#T@0%!!5$A?4T5005)!5$]20`I01$9,
M051%6"`]($!01$9,051%6$`*4D%.3$E"(#T@0%)!3DQ)0D`*4T5#5$E/3E]&
M3$%'4R`]($!314-424].7T9,04=30`I314-424].7TQ$1DQ!1U,@/2!`4T5#
M5$E/3E],1$9,04=30`I3140@/2!`4T5$0`I3151?34%+12`]($!3151?34%+
M14`*4TA%3$P@/2!`4TA%3$Q`"E-44DE0(#T@0%-44DE00`I364U615)?1DE,
M12`]($!364U615)?1DE,14`*5$]03$5614Q?24Y#3%5$15,@/2!`5$]03$56
M14Q?24Y#3%5$15-`"E5315].3%,@/2!`55-%7TY,4T`*5D524TE/3B`]($!6
M15)324].0`I65%9?0UA81DQ!1U,@/2!`5E167T-86$9,04=30`I65%9?0UA8
M3$E.2T9,04=3(#T@0%945E]#6%A,24Y+1DQ!1U-`"E945E]00TA?0UA81DQ!
M1U,@/2!`5E167U!#2%]#6%A&3$%'4T`*5T%23E]&3$%'4R`]($!705).7T9,
M04=30`I834Q#051!3$]'(#T@0%A-3$-!5$%,3T=`"EA-3$Q)3E0@/2!`6$U,
M3$E.5$`*6%-,5%!23T,@/2!`6%-,5%!23T-`"EA33%]35%E,15]$25(@/2!`
M6%-,7U-464Q%7T1)4D`*86)S7V)U:6QD9&ER(#T@0&%B<U]B=6EL9&1I<D`*
M86)S7W-R8V1I<B`]($!A8G-?<W)C9&ER0`IA8G-?=&]P7V)U:6QD9&ER(#T@
M0&%B<U]T;W!?8G5I;&1D:7)`"F%B<U]T;W!?<W)C9&ER(#T@0&%B<U]T;W!?
M<W)C9&ER0`IA8U]C=%]#0R`]($!A8U]C=%]#0T`*86-?8W1?0UA8(#T@0&%C
M7V-T7T-86$`*86-?8W1?1%5-4$))3B`]($!A8U]C=%]$54U00DE.0`IA;5]?
M;&5A9&EN9U]D;W0@/2!`86U?7VQE861I;F=?9&]T0`IA;5]?=&%R(#T@0&%M
M7U]T87)`"F%M7U]U;G1A<B`]($!A;5]?=6YT87)`"F)A<V5L:6YE7V1I<B`]
M($!B87-E;&EN95]D:7)`"F)A<V5L:6YE7W-U8F1I<E]S=VET8V@@/2!`8F%S
M96QI;F5?<W5B9&ER7W-W:71C:$`*8FEN9&ER(#T@0&)I;F1I<D`*8G5I;&0@
M/2!`8G5I;&1`"F)U:6QD7V%L:6%S(#T@0&)U:6QD7V%L:6%S0`IB=6EL9%]C
M<'4@/2!`8G5I;&1?8W!U0`IB=6EL9%]O<R`]($!B=6EL9%]O<T`*8G5I;&1?
M=F5N9&]R(#T@0&)U:6QD7W9E;F1O<D`*8G5I;&1D:7(@/2!`8G5I;&1D:7)`
M"F-H96-K7VUS9V9M="`]($!C:&5C:U]M<V=F;71`"F1A=&%D:7(@/2!`9&%T
M861I<D`*9&%T87)O;W1D:7(@/2!`9&%T87)O;W1D:7)`"F1O8V1I<B`]($!D
M;V-D:7)`"F1V:61I<B`]($!D=FED:7)`"F5N86)L95]S:&%R960@/2!`96YA
M8FQE7W-H87)E9$`*96YA8FQE7W-T871I8R`]($!E;F%B;&5?<W1A=&EC0`IE
M>&5C7W!R969I>"`]($!E>&5C7W!R969I>$`*9V5T7V=C8U]B87-E7W9E<B`]
M($!G971?9V-C7V)A<V5?=F5R0`IG;&EB8WAX7TU/1DE,15,@/2!`9VQI8F-X
M>%]-3T9)3$530`IG;&EB8WAX7U!#2$9,04=3(#T@0&=L:6)C>'A?4$-(1DQ!
M1U-`"F=L:6)C>'A?4$]&24Q%4R`]($!G;&EB8WAX7U!/1DE,15-`"F=L:6)C
M>'A?8G5I;&1D:7(@/2!`9VQI8F-X>%]B=6EL9&1I<D`*9VQI8F-X>%]C;VUP
M:6QE<E]P:6-?9FQA9R`]($!G;&EB8WAX7V-O;7!I;&5R7W!I8U]F;&%G0`IG
M;&EB8WAX7V-O;7!I;&5R7W-H87)E9%]F;&%G(#T@0&=L:6)C>'A?8V]M<&EL
M97)?<VAA<F5D7V9L86=`"F=L:6)C>'A?8WAX.3A?86)I(#T@0&=L:6)C>'A?
M8WAX.3A?86)I0`IG;&EB8WAX7VQO8V%L961I<B`]($!G;&EB8WAX7VQO8V%L
M961I<D`*9VQI8F-X>%]L=%]P:6-?9FQA9R`]($!G;&EB8WAX7VQT7W!I8U]F
M;&%G0`IG;&EB8WAX7W!R969I>&1I<B`]($!G;&EB8WAX7W!R969I>&1I<D`*
M9VQI8F-X>%]S<F-D:7(@/2!`9VQI8F-X>%]S<F-D:7)`"F=L:6)C>'A?=&]O
M;&5X96-D:7(@/2!`9VQI8F-X>%]T;V]L97AE8V1I<D`*9VQI8F-X>%]T;V]L
M97AE8VQI8F1I<B`]($!G;&EB8WAX7W1O;VQE>&5C;&EB9&ER0`IG>'A?:6YC
M;'5D95]D:7(@/2!`9WAX7VEN8VQU9&5?9&ER0`IH;W-T(#T@0&AO<W1`"FAO
M<W1?86QI87,@/2!`:&]S=%]A;&EA<T`*:&]S=%]C<'4@/2!`:&]S=%]C<'5`
M"FAO<W1?;W,@/2!`:&]S=%]O<T`*:&]S=%]V96YD;W(@/2!`:&]S=%]V96YD
M;W)`"FAT;6QD:7(@/2!`:'1M;&1I<D`*:6YC;'5D961I<B`]($!I;F-L=61E
M9&ER0`II;F9O9&ER(#T@0&EN9F]D:7)`"FEN<W1A;&Q?<V@@/2!`:6YS=&%L
M;%]S:$`*;&EB9&ER(#T@0&QI8F1I<D`*;&EB97AE8V1I<B`]($!L:6)E>&5C
M9&ER0`IL:6)T;V]L7U9%4E-)3TX@/2!`;&EB=&]O;%]615)324].0`IL;V-A
M;&5D:7(@/2!`;&]C86QE9&ER0`IL;V-A;'-T871E9&ER(#T@0&QO8V%L<W1A
M=&5D:7)`"FQT7VAO<W1?9FQA9W,@/2!`;'1?:&]S=%]F;&%G<T`*;6%N9&ER
M(#T@0&UA;F1I<D`*;6MD:7)?<"`]($!M:V1I<E]P0`IM=6QT:5]B87-E9&ER
M(#T@0&UU;'1I7V)A<V5D:7)`"F]L9&EN8VQU9&5D:7(@/2!`;VQD:6YC;'5D
M961I<D`*<&1F9&ER(#T@0'!D9F1I<D`*<&]R=%]S<&5C:69I8U]S>6UB;VQ?
M9FEL97,@/2!`<&]R=%]S<&5C:69I8U]S>6UB;VQ?9FEL97-`"G!R969I>"`]
M($!P<F5F:7A`"G!R;V=R86U?=')A;G-F;W)M7VYA;64@/2!`<')O9W)A;5]T
M<F%N<V9O<FU?;F%M94`*<'-D:7(@/2!`<'-D:7)`"G!Y=&AO;E]M;V1?9&ER
M(#T@0'!Y=&AO;E]M;V1?9&ER0`IS8FEN9&ER(#T@0'-B:6YD:7)`"G-H87)E
M9'-T871E9&ER(#T@0'-H87)E9'-T871E9&ER0`IS<F-D:7(@/2!`<W)C9&ER
M0`IS>7-C;VYF9&ER(#T@0'-Y<V-O;F9D:7)`"G1A<F=E="`]($!T87)G971`
M"G1A<F=E=%]A;&EA<R`]($!T87)G971?86QI87-`"G1A<F=E=%]C<'4@/2!`
M=&%R9V5T7V-P=4`*=&%R9V5T7V]S(#T@0'1A<F=E=%]O<T`*=&%R9V5T7W9E
M;F1O<B`]($!T87)G971?=F5N9&]R0`IT:')E861?:&5A9&5R(#T@0'1H<F5A
M9%]H96%D97)`"G1O<%]B=6EL9%]P<F5F:7@@/2!`=&]P7V)U:6QD7W!R969I
M>$`*=&]P7V)U:6QD9&ER(#T@0'1O<%]B=6EL9&1I<D`*=&]P7W-R8V1I<B`]
M($!T;W!?<W)C9&ER0`IT;W!L979E;%]B=6EL9&1I<B`]($!T;W!L979E;%]B
M=6EL9&1I<D`*=&]P;&5V96Q?<W)C9&ER(#T@0'1O<&QE=F5L7W-R8V1I<D`*
M"B,@36%Y(&)E('5S960@8GD@=F%R:6]U<R!S=6)S=&ET=71I;VX@=F%R:6%B
M;&5S+@IG8V-?=F5R<VEO;B`Z/2`D*'-H96QL($!G971?9V-C7V)A<V5?=F5R
M0"`D*'1O<%]S<F-D:7(I+RXN+V=C8R]"05-%+59%4BD*34%)3E1?0TA!4E-%
M5"`](&QA=&EN,0IM:VEN<W1A;&QD:7)S(#T@)"A32$5,3"D@)"AT;W!L979E
M;%]S<F-D:7(I+VUK:6YS=&%L;&1I<G,*4%=$7T-/34U!3D0@/2`D)'M05T1#
M340M<'=D?0I35$%-4"`](&5C:&\@=&EM97-T86UP(#X*=&]O;&5X96-D:7(@
M/2`D*&=L:6)C>'A?=&]O;&5X96-D:7(I"G1O;VQE>&5C;&EB9&ER(#T@)"AG
M;&EB8WAX7W1O;VQE>&5C;&EB9&ER*0I`14Y!0DQ%7U=%4E)/4E]&04Q314!7
M15)23U)?1DQ!1R`](`I`14Y!0DQ%7U=%4E)/4E]44E5%0%=%4E)/4E]&3$%'
M(#T@+5=E<G)O<@I`14Y!0DQ%7T585$523E]414U03$%415]&04Q314!85$5-
M4$Q!5$5?1DQ!1U,@/2`*0$5.04),15]%6%1%4DY?5$5-4$Q!5$5?5%)514!8
M5$5-4$Q!5$5?1DQ!1U,@/2`M9FYO+6EM<&QI8VET+71E;7!L871E<PH*(R!4
M:&5S92!B:71S(&%R92!A;&P@9FEG=7)E9"!O=70@9G)O;2!C;VYF:6=U<F4N
M("!,;V]K(&EN(&%C:6YC;'5D92YM-`HC(&]R(&-O;F9I9W5R92YA8R!T;R!S
M964@:&]W('1H97D@87)E('-E="X@(%-E92!'3$E"0UA87T584$]25%]&3$%'
M4RX*0T].1DE'7T-86$9,04=3(#T@7`H))"A314-424].7T9,04=3*2`D*$A7
M0T%07T-&3$%'4RD@+69R86YD;VTM<V5E9#TD0`H*5T%23E]#6%A&3$%'4R`]
M(%P*"20H5T%23E]&3$%'4RD@)"A715)23U)?1DQ!1RD@+69D:6%G;F]S=&EC
M<RUS:&]W+6QO8V%T:6]N/6]N8V4@"@H*(R`M22\M1"!F;&%G<R!T;R!P87-S
M('=H96X@8V]M<&EL:6YG+@I!35]#4%!&3$%'4R`]("0H1TQ)0D-86%])3D-,
M541%4RD@)"A#4%!&3$%'4RD*0$5.04),15]0651(3TY$25)?1D%,4T5`<'ET
M:&]N9&ER(#T@)"AD871A9&ER*2]G8V,M)"AG8V-?=F5R<VEO;BDO<'ET:&]N
M"D!%3D%"3$5?4%E42$].1$E27U12545`<'ET:&]N9&ER(#T@)"AP<F5F:7@I
M+R0H<'ET:&]N7VUO9%]D:7(I"FYO8F%S95]P>71H;VY?1$%402`](%P*("`@
M(&QI8G-T9&-X>"]V-B]P<FEN=&5R<RYP>2!<"B`@("!L:6)S=&1C>'@O=C8O
M>&UE=&AO9',N<'D@7`H@("`@;&EB<W1D8WAX+W8V+U]?:6YI=%]?+G!Y(%P*
M("`@(&QI8G-T9&-X>"]?7VEN:71?7RYP>0H*86QL.B!A;&PM86T*"BY3549&
M25A%4SH*)"AS<F-D:7(I+TUA:V5F:6QE+FEN.B!`34%)3E1!24Y%4E]-3T1%
M7U12545`("0H<W)C9&ER*2]-86ME9FEL92YA;2`D*'1O<%]S<F-D:7(I+V9R
M86=M96YT+F%M("0H86U?7V-O;F9I9W5R95]D97!S*0H)0&9O<B!D97`@:6X@
M)#\[(&1O(%P*"2`@8V%S92`G)"AA;5]?8V]N9FEG=7)E7V1E<',I)R!I;B!<
M"@D@("`@*B0D9&5P*BD@7`H)("`@("`@*"!C9"`D*'1O<%]B=6EL9&1I<BD@
M)B8@)"A-04M%*2`D*$%-7TU!2T5&3$%'4RD@86TM+7)E9G)E<V@@*2!<"@D@
M("`@("`@("8F('L@:68@=&5S="`M9B`D0#L@=&AE;B!E>&ET(#`[(&5L<V4@
M8G)E86L[(&9I.R!].R!<"@D@("`@("!E>&ET(#$[.R!<"@D@(&5S86,[(%P*
M"61O;F4[(%P*"65C:&\@)R!C9"`D*'1O<%]S<F-D:7(I("8F("0H05543TU!
M2T4I("TM9F]R96EG;B`M+6EG;F]R92UD97!S('!Y=&AO;B]-86ME9FEL92<[
M(%P*"20H86U?7V-D*2`D*'1O<%]S<F-D:7(I("8F(%P*"2`@)"A!551/34%+
M12D@+2UF;W)E:6=N("TM:6=N;W)E+61E<',@<'ET:&]N+TUA:V5F:6QE"DUA
M:V5F:6QE.B`D*'-R8V1I<BDO36%K969I;&4N:6X@)"AT;W!?8G5I;&1D:7(I
M+V-O;F9I9RYS=&%T=7,*"4!C87-E("<D/R<@:6X@7`H)("`J8V]N9FEG+G-T
M871U<RHI(%P*"2`@("!C9"`D*'1O<%]B=6EL9&1I<BD@)B8@)"A-04M%*2`D
M*$%-7TU!2T5&3$%'4RD@86TM+7)E9G)E<V@[.R!<"@D@("HI(%P*"2`@("!E
M8VAO("<@8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H4TA%3$PI("XO8V]N9FEG
M+G-T871U<R`D*'-U8F1I<BDO)$`@)"AA;5]?9&5P9FEL97-?;6%Y8F4I)SL@
M7`H)("`@(&-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*%-(14Q,*2`N+V-O;F9I
M9RYS=&%T=7,@)"AS=6)D:7(I+R1`("0H86U?7V1E<&9I;&5S7VUA>6)E*3L[
M(%P*"65S86,["B0H=&]P7W-R8V1I<BDO9G)A9VUE;G0N86T@)"AA;5]?96UP
M='DI.@H*)"AT;W!?8G5I;&1D:7(I+V-O;F9I9RYS=&%T=7,Z("0H=&]P7W-R
M8V1I<BDO8V]N9FEG=7)E("0H0T].1DE'7U-405154U]$15!%3D1%3D-)15,I
M"@EC9"`D*'1O<%]B=6EL9&1I<BD@)B8@)"A-04M%*2`D*$%-7TU!2T5&3$%'
M4RD@86TM+7)E9G)E<V@*"B0H=&]P7W-R8V1I<BDO8V]N9FEG=7)E.B!`34%)
M3E1!24Y%4E]-3T1%7U12545`("0H86U?7V-O;F9I9W5R95]D97!S*0H)8V0@
M)"AT;W!?8G5I;&1D:7(I("8F("0H34%+12D@)"A!35]-04M%1DQ!1U,I(&%M
M+2UR969R97-H"B0H04-,3T-!3%]--"DZ($!-04E.5$%)3D527TU/1$5?5%)5
M14`@)"AA;5]?86-L;V-A;%]M-%]D97!S*0H)8V0@)"AT;W!?8G5I;&1D:7(I
M("8F("0H34%+12D@)"A!35]-04M%1DQ!1U,I(&%M+2UR969R97-H"B0H86U?
M7V%C;&]C86Q?;31?9&5P<RDZ"@IM;W-T;'EC;&5A;BUL:6)T;V]L.@H)+7)M
M("UF("HN;&\*"F-L96%N+6QI8G1O;VPZ"@DM<FT@+7)F("YL:6)S(%]L:6)S
M"FEN<W1A;&PM;F]B87-E7W!Y=&AO;D1!5$$Z("0H;F]B87-E7W!Y=&AO;E]$
M051!*0H)0"0H3D]234%,7TE.4U1!3$PI"@E`;&ES=#TG)"AN;V)A<V5?<'ET
M:&]N7T1!5$$I)SL@=&5S="`M;B`B)"AP>71H;VYD:7(I(B!\?"!L:7-T/3L@
M7`H):68@=&5S="`M;B`B)"1L:7-T(CL@=&AE;B!<"@D@(&5C:&\@(B`D*$U+
M1$E27U`I("<D*$1%4U1$25(I)"AP>71H;VYD:7(I)R([(%P*"2`@)"A-2T1)
M4E]0*2`B)"A$15-41$E2*20H<'ET:&]N9&ER*2(@?'P@97AI="`Q.R!<"@EF
M:3L@7`H))"AA;5]?;F]B87-E7VQI<W0I('P@=VAI;&4@<F5A9"!D:7(@9FEL
M97,[(&1O(%P*"2`@>&9I;&5S/3L@9F]R(&9I;&4@:6X@)"1F:6QE<SL@9&\@
M7`H)("`@(&EF('1E<W0@+68@(B0D9FEL92([('1H96X@>&9I;&5S/2(D)'AF
M:6QE<R`D)&9I;&4B.R!<"@D@("`@96QS92!X9FEL97,](B0D>&9I;&5S("0H
M<W)C9&ER*2\D)&9I;&4B.R!F:3L@9&]N93L@7`H)("!T97-T("UZ("(D)'AF
M:6QE<R(@?'P@>R!<"@D@("`@=&5S="`B>"0D9&ER(B`]('@N('Q\('L@7`H)
M("`@("`@96-H;R`B("0H34M$25)?4"D@)R0H1$535$1)4BDD*'!Y=&AO;F1I
M<BDO)"1D:7(G(CL@7`H)("`@("`@)"A-2T1)4E]0*2`B)"A$15-41$E2*20H
M<'ET:&]N9&ER*2\D)&1I<B([('T[(%P*"2`@("!E8VAO("(@)"A)3E-404Q,
M7T1!5$$I("0D>&9I;&5S("<D*$1%4U1$25(I)"AP>71H;VYD:7(I+R0D9&ER
M)R([(%P*"2`@("`D*$E.4U1!3$Q?1$%402D@)"1X9FEL97,@(B0H1$535$1)
M4BDD*'!Y=&AO;F1I<BDO)"1D:7(B('Q\(&5X:70@)"0_.R!].R!<"@ED;VYE
M"@IU;FEN<W1A;&PM;F]B87-E7W!Y=&AO;D1!5$$Z"@E`)"A.3U)-04Q?54Y)
M3E-404Q,*0H)0&QI<W0])R0H;F]B87-E7W!Y=&AO;E]$051!*2<[('1E<W0@
M+6X@(B0H<'ET:&]N9&ER*2(@?'P@;&ES=#T[(%P*"20H86U?7VYO8F%S95]S
M=')I<%]S971U<"D[(&9I;&5S/6`D*&%M7U]N;V)A<V5?<W1R:7`I8#L@7`H)
M9&ER/2<D*$1%4U1$25(I)"AP>71H;VYD:7(I)SL@)"AA;5]?=6YI;G-T86QL
M7V9I;&5S7V9R;VU?9&ER*0IT86=S(%1!1U,Z"@IC=&%G<R!#5$%'4SH*"F-S
M8V]P92!C<V-O<&5L:7-T.@H*8VAE8VLM86TZ(&%L;"UA;0IC:&5C:SH@8VAE
M8VLM86T*86QL+6%M.B!-86ME9FEL92`D*$1!5$$I(&%L;"UL;V-A;`II;G-T
M86QL9&ER<SH*"69O<B!D:7(@:6X@(B0H1$535$1)4BDD*'!Y=&AO;F1I<BDB
M.R!D;R!<"@D@('1E<W0@+7H@(B0D9&ER(B!\?"`D*$U+1$E27U`I("(D)&1I
M<B([(%P*"61O;F4*:6YS=&%L;#H@:6YS=&%L;"UA;0II;G-T86QL+65X96,Z
M(&EN<W1A;&PM97AE8RUA;0II;G-T86QL+61A=&$Z(&EN<W1A;&PM9&%T82UA
M;0IU;FEN<W1A;&PZ('5N:6YS=&%L;"UA;0H*:6YS=&%L;"UA;3H@86QL+6%M
M"@E`)"A-04M%*2`D*$%-7TU!2T5&3$%'4RD@:6YS=&%L;"UE>&5C+6%M(&EN
M<W1A;&PM9&%T82UA;0H*:6YS=&%L;&-H96-K.B!I;G-T86QL8VAE8VLM86T*
M:6YS=&%L;"US=')I<#H*"6EF('1E<W0@+7H@)R0H4U1225`I)SL@=&AE;B!<
M"@D@("0H34%+12D@)"A!35]-04M%1DQ!1U,I($E.4U1!3$Q?4%)/1U)!33TB
M)"A)3E-404Q,7U-44DE07U!23T=204TI(B!<"@D@("`@:6YS=&%L;%]S:%]0
M4D]'4D%-/2(D*$E.4U1!3$Q?4U1225!?4%)/1U)!32DB($E.4U1!3$Q?4U12
M25!?1DQ!1STM<R!<"@D@("`@("!I;G-T86QL.R!<"@EE;'-E(%P*"2`@)"A-
M04M%*2`D*$%-7TU!2T5&3$%'4RD@24Y35$%,3%]04D]'4D%-/2(D*$E.4U1!
M3$Q?4U1225!?4%)/1U)!32DB(%P*"2`@("!I;G-T86QL7W-H7U!23T=204T]
M(B0H24Y35$%,3%]35%))4%]04D]'4D%-*2(@24Y35$%,3%]35%))4%]&3$%'
M/2US(%P*"2`@("`B24Y35$%,3%]04D]'4D%-7T5.5CU35%))4%!23T<])R0H
M4U1225`I)R(@:6YS=&%L;#L@7`H)9FD*;6]S=&QY8VQE86XM9V5N97)I8SH*
M"F-L96%N+6=E;F5R:6,Z"@ID:7-T8VQE86XM9V5N97)I8SH*"2UT97-T("UZ
M("(D*$-/3D9)1U]#3$5!3E]&24Q%4RDB('Q\(')M("UF("0H0T].1DE'7T-,
M14%.7T9)3$53*0H)+71E<W0@+B`]("(D*'-R8V1I<BDB('Q\('1E<W0@+7H@
M(B0H0T].1DE'7T-,14%.7U90051(7T9)3$53*2(@?'P@<FT@+68@)"A#3TY&
M24=?0TQ%04Y?5E!!5$A?1DE,15,I"@IM86EN=&%I;F5R+6-L96%N+6=E;F5R
M:6,Z"@E`96-H;R`B5&AI<R!C;VUM86YD(&ES(&EN=&5N9&5D(&9O<B!M86EN
M=&%I;F5R<R!T;R!U<V4B"@E`96-H;R`B:70@9&5L971E<R!F:6QE<R!T:&%T
M(&UA>2!R97%U:7)E('-P96-I86P@=&]O;',@=&\@<F5B=6EL9"XB"F-L96%N
M.B!C;&5A;BUA;0H*8VQE86XM86TZ(&-L96%N+6=E;F5R:6,@8VQE86XM;&EB
M=&]O;"!M;W-T;'EC;&5A;BUA;0H*9&ES=&-L96%N.B!D:7-T8VQE86XM86T*
M"2UR;2`M9B!-86ME9FEL90ID:7-T8VQE86XM86TZ(&-L96%N+6%M(&1I<W1C
M;&5A;BUG96YE<FEC"@ID=FDZ(&1V:2UA;0H*9'9I+6%M.@H*:'1M;#H@:'1M
M;"UA;0H*:'1M;"UA;3H*"FEN9F\Z(&EN9F\M86T*"FEN9F\M86TZ"@II;G-T
M86QL+61A=&$M86TZ(&EN<W1A;&PM9&%T82UL;V-A;"!I;G-T86QL+6YO8F%S
M95]P>71H;VY$051!"@II;G-T86QL+61V:3H@:6YS=&%L;"UD=FDM86T*"FEN
M<W1A;&PM9'9I+6%M.@H*:6YS=&%L;"UE>&5C+6%M.@H*:6YS=&%L;"UH=&UL
M.B!I;G-T86QL+6AT;6PM86T*"FEN<W1A;&PM:'1M;"UA;3H*"FEN<W1A;&PM
M:6YF;SH@:6YS=&%L;"UI;F9O+6%M"@II;G-T86QL+6EN9F\M86TZ"@II;G-T
M86QL+6UA;CH*"FEN<W1A;&PM<&1F.B!I;G-T86QL+7!D9BUA;0H*:6YS=&%L
M;"UP9&8M86TZ"@II;G-T86QL+7!S.B!I;G-T86QL+7!S+6%M"@II;G-T86QL
M+7!S+6%M.@H*:6YS=&%L;&-H96-K+6%M.@H*;6%I;G1A:6YE<BUC;&5A;CH@
M;6%I;G1A:6YE<BUC;&5A;BUA;0H)+7)M("UF($UA:V5F:6QE"FUA:6YT86EN
M97(M8VQE86XM86TZ(&1I<W1C;&5A;BUA;2!M86EN=&%I;F5R+6-L96%N+6=E
M;F5R:6,*"FUO<W1L>6-L96%N.B!M;W-T;'EC;&5A;BUA;0H*;6]S=&QY8VQE
M86XM86TZ(&UO<W1L>6-L96%N+6=E;F5R:6,@;6]S=&QY8VQE86XM;&EB=&]O
M;`H*<&1F.B!P9&8M86T*"G!D9BUA;3H*"G!S.B!P<RUA;0H*<',M86TZ"@IU
M;FEN<W1A;&PM86TZ('5N:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%400H*+DU!
M2T4Z(&EN<W1A;&PM86T@:6YS=&%L;"US=')I<`H*+E!(3TY9.B!A;&P@86QL
M+6%M(&%L;"UL;V-A;"!C:&5C:R!C:&5C:RUA;2!C;&5A;B!C;&5A;BUG96YE
M<FEC(%P*"6-L96%N+6QI8G1O;VP@8W-C;W!E;&ES="UA;2!C=&%G<RUA;2!D
M:7-T8VQE86X@7`H)9&ES=&-L96%N+6=E;F5R:6,@9&ES=&-L96%N+6QI8G1O
M;VP@9'9I(&1V:2UA;2!H=&UL(&AT;6PM86T@7`H):6YF;R!I;F9O+6%M(&EN
M<W1A;&P@:6YS=&%L;"UA;2!I;G-T86QL+61A=&$@:6YS=&%L;"UD871A+6%M
M(%P*"6EN<W1A;&PM9&%T82UL;V-A;"!I;G-T86QL+61V:2!I;G-T86QL+61V
M:2UA;2!I;G-T86QL+65X96,@7`H):6YS=&%L;"UE>&5C+6%M(&EN<W1A;&PM
M:'1M;"!I;G-T86QL+6AT;6PM86T@:6YS=&%L;"UI;F9O(%P*"6EN<W1A;&PM
M:6YF;RUA;2!I;G-T86QL+6UA;B!I;G-T86QL+6YO8F%S95]P>71H;VY$051!
M(%P*"6EN<W1A;&PM<&1F(&EN<W1A;&PM<&1F+6%M(&EN<W1A;&PM<',@:6YS
M=&%L;"UP<RUA;2!<"@EI;G-T86QL+7-T<FEP(&EN<W1A;&QC:&5C:R!I;G-T
M86QL8VAE8VLM86T@:6YS=&%L;&1I<G,@7`H);6%I;G1A:6YE<BUC;&5A;B!M
M86EN=&%I;F5R+6-L96%N+6=E;F5R:6,@;6]S=&QY8VQE86X@7`H);6]S=&QY
M8VQE86XM9V5N97)I8R!M;W-T;'EC;&5A;BUL:6)T;V]L('!D9B!P9&8M86T@
M<',@<',M86T@7`H)=&%G<RUA;2!U;FEN<W1A;&P@=6YI;G-T86QL+6%M('5N
M:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%400H*+E!214-)3U53.B!-86ME9FEL
M90H*"F%L;"UL;V-A;#H@9V1B+G!Y"@IG9&(N<'DZ(&AO;VLN:6X@36%K969I
M;&4*"7-E9"`M92`G<RQ`<'ET:&]N9&ER0"PD*'!Y=&AO;F1I<BDL)R!<"@D@
M("`@+64@)W,L0'1O;VQE>&5C;&EB9&ER0"PD*'1O;VQE>&5C;&EB9&ER*2PG
M(#P@)"AS<F-D:7(I+VAO;VLN:6X@/B`D0`H*:6YS=&%L;"UD871A+6QO8V%L
M.B!G9&(N<'D*"4`D*&UK9&ER7W`I("0H1$535$1)4BDD*'1O;VQE>&5C;&EB
M9&ER*0H)0&AE<F4]8'!W9&`[(&-D("0H1$535$1)4BDD*'1O;VQE>&5C;&EB
M9&ER*3L@7`H)("!F;W(@9FEL92!I;B!L:6)S=&1C*RLN*CL@9&\@7`H)("`@
M(&-A<V4@)"1F:6QE(&EN(%P*"2`@("`@("HM9V1B+G!Y*2`[.R!<"@D@("`@
M("`J+FQA*2`[.R!<"@D@("`@("`J*2!I9B!T97-T("UH("0D9FEL93L@=&AE
M;B!<"@D@("`@("`@("`@(&-O;G1I;G5E.R!<"@D@("`@("`@("!F:3L@7`H)
M("`@("`@("`@;&EB;F%M93TD)&9I;&4[.R!<"@D@("`@97-A8SL@7`H)("!D
M;VYE.R!<"@EC9"`D)&AE<F4[(%P*"65C:&\@(B`D*$E.4U1!3$Q?1$%402D@
M9V1B+G!Y("0H1$535$1)4BDD*'1O;VQE>&5C;&EB9&ER*2\D)&QI8FYA;64M
M9V1B+G!Y(CL@7`H))"A)3E-404Q,7T1!5$$I(&=D8BYP>2`D*$1%4U1$25(I
M)"AT;V]L97AE8VQI8F1I<BDO)"1L:6)N86UE+6=D8BYP>0H*(R!496QL('9E
M<G-I;VYS(%LS+C4Y+#,N-C,I(&]F($=.52!M86ME('1O(&YO="!E>'!O<G0@
M86QL('9A<FEA8FQE<RX*(R!/=&AE<G=I<V4@82!S>7-T96T@;&EM:70@*&9O
M<B!3>7-6(&%T(&QE87-T*2!M87D@8F4@97AC965D960N"BY.3T584$]25#H*
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
*````````````````
`
end
SHAR_EOF
  (set 20 19 04 07 13 29 46 'share-gdb.tar'
   eval "${shar_touch}") && \
  chmod 0644 'share-gdb.tar'
if test $? -ne 0
then ${echo} "restore of share-gdb.tar failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'share-gdb.tar': 'MD5 check failed'
       ) << \SHAR_EOF
2900a41898fd24d594ac78ebb74041c4  share-gdb.tar
SHAR_EOF

else
test `LC_ALL=C wc -c < 'share-gdb.tar'` -ne 133120 && \
  ${echo} "restoration warning:  size of 'share-gdb.tar' is not 133120"
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
  (set 20 19 04 07 13 29 46 'apt-cyg'
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
  (set 20 19 04 07 13 29 47 'byzanz-helper.1'
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
  (set 20 19 04 07 13 29 48 'ffmpeg-helper.1'
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
  (set 20 19 04 07 13 29 48 'hyper-v.1'
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
  (set 20 19 04 07 13 29 48 'msvc-shell.1'
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
  (set 20 19 04 07 13 29 49 'sixel2tmux.1'
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
  (set 20 19 04 07 13 29 49 'yank.1'
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

