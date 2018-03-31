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

REQUIRED_PROGS=(curl git grep install mktemp sed)
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
lock_dir=_sh09452
# Made on 2018-03-31 13:01 CEST by <frede@darthvader>.
# Source directory was '/home/frede/Documents/workspace/github/unix-config/src'.
#
# Existing files will *not* be overwritten, unless '-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#    456 -rw-r--r-- dot_bash_profile
#   3087 -rw-r--r-- dot_bashrc
#   2158 -rw-r--r-- dot_profile
#   2889 -rw-r--r-- dot_tmux_conf
#   4933 -rw-r--r-- dot_vimrc
#    637 -rw-r--r-- dot_Xresources
#   4076 -rw-r--r-- dot_XWinrc
#   2836 -rw-r--r-- tmux-256color.tinfo
#    901 -rwxr-xr-x runcron
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
  (set 20 18 02 01 18 48 58 'dot_bash_profile'
   eval "${shar_touch}") && \
  chmod 0644 'dot_bash_profile'
if test $? -ne 0
then ${echo} "restore of dot_bash_profile failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_bash_profile': 'MD5 check failed'
       ) << \SHAR_EOF
abefa303889936dd08889dbe573e894c  dot_bash_profile
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_bash_profile'` -ne 456 && \
  ${echo} "restoration warning:  size of 'dot_bash_profile' is not 456"
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
X    export SYSTEM_PERL5LIB="${PERL5LIB}"
X    export SYSTEM_PKG_CONFIG_PATH="${PKG_CONFIG_PATH}"
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
X            PATH="${xtrad}/bin:${PATH}"
X        fi
X        
X        # Set PATH so it includes user's private lib if it exists
X        if [ -d "${xtrad}/lib" ]; then
X            PATH="${xtrad}/lib:${PATH}"
X            LD_LIBRARY_PATH="${xtrad}/lib:${LD_LIBRARY_PATH}"
X        fi
X        
X        # Set PKG_CONFIG_PATH so it includes user's private if it exists
X        if [ -d "${xtrad}/lib/pkgconfig" ]; then
X            PKG_CONFIG_PATH="${xtrad}/lib/pkgconfig:${PKG_CONFIG_PATH}"
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
X            INFOPATH="${xtrad}/info:${INFOPATH}"
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
  (set 20 18 02 01 18 48 58 'dot_profile'
   eval "${shar_touch}") && \
  chmod 0644 'dot_profile'
if test $? -ne 0
then ${echo} "restore of dot_profile failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_profile': 'MD5 check failed'
       ) << \SHAR_EOF
9178fc533b6b631e75e50716c872727d  dot_profile
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_profile'` -ne 2158 && \
  ${echo} "restoration warning:  size of 'dot_profile' is not 2158"
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
M=R`M9R!M;V1E+6ME>7,@=FD@("`@("`@("`@("`@(`IS970@+7,@9F]C=7,M
M979E;G1S(&]N"@HC<V5T("UQ("UG('-T871U<RUU=&8X(&]N"G-E='<@+7$@
M+6<@=71F."!O;@H*(R!C,"UC:&%N9V4M:6YT97)V86P@:6YT97)V86P@(R!P
M<F5V96YT<R!F;&]O9&EN9R!T;R!B<F5A:R!#=')L*T,*(R!C,"UC:&%N9V4M
M=')I9V=E<B!T<FEG9V5R("`@(R`*"B,@+2TM(&1I<W!L87D@+2TM+2TM+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+0IS970@+6<@8F%S92UI;F1E>"`Q("`@("`@("`@(R!S=&%R="!W:6YD;W<@
M;G5M8F5R:6YG(&%T(#$*<V5T=R`M9R!P86YE+6)A<V4M:6YD97@@,2`@(",@
M<W1A<G0@<&%N92!N=6UB97)I;F<@870@,0H*<V5T=R`M9R!A=71O;6%T:6,M
M<F5N86UE(&]N(",@<F5N86UE('=I;F1O=R!T;R!C=7)R96YT('!R;V=R86T*
M<V5T("UG(')E;G5M8F5R+7=I;F1O=W,@;VX@(",@<F5N86UE('=I;F1O=R!W
M:&5N('=I;F1O=R!I<R!C;&]S960*"G-E="`M9R!S970M=&ET;&5S(&]N("`@
M("`@("`C('-E="!T97)M:6YA;"!T:71L90IS970@+6<@<V5T+71I=&QE<RUS
M=')I;F<@)R-H("`@(U,@("`C22`C5R<*"G-E="`M9R!D:7-P;&%Y+7!A;F5S
M+71I;64@.#`P(",@;&]N9V5R('!A;F4@:6YD:6-A=&]R(&1I<W!L87D@=&EM
M90IS970@+6<@9&ES<&QA>2UT:6UE(#$P,#`@("`@("`C(&QO;F=E<B!S=&%T
M=7,@:6YD:6-A=&]R(&1I<W!L87D@=&EM90IS970@+6<@<W1A='5S+6EN=&5R
M=F%L(#$P("`@("`C(')E9G)E<V@@<W1A='5S(&5V97)Y(#$P('-E8V]N9',*
M"B,@86-T:79I='D*<V5T("UG(&UO;FET;W(M86-T:79I='D@;VX*<V5T("UG
M('9I<W5A;"UA8W1I=FET>2!O9F8*"B,@+2TM('-T871U<R!T:&5M92`M+2TM
M+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM+2TM
M+0IS970@+6<@<W1A='5S+6)G("=C;VQO=7(R,S4G"G-E="`M9R!M97-S86=E
M+6-O;6UA;F0M9F<@)V-O;&]U<C(R,B<*<V5T("UG('-T871U<RUJ=7-T:69Y
M("=C96YT<F4G"G-E="`M9R!S=&%T=7,M;&5F="UL96YG=&@@)S$P,"<*<V5T
M("UG('-T871U<R`G;VXG"G-E="`M9R!P86YE+6%C=&EV92UB;W)D97(M9F<@
M)V-O;&]U<C$U-"<*<V5T("UG(&UE<W-A9V4M8F<@)V-O;&]U<C(S."<*<V5T
M("UG('-T871U<RUR:6=H="UL96YG=&@@)S$P,"<*<V5T("UG('-T871U<RUR
M:6=H="UA='1R("=N;VYE)PIS970@+6<@;65S<V%G92UF9R`G8V]L;W5R,C(R
M)PIS970@+6<@;65S<V%G92UC;VUM86YD+6)G("=C;VQO=7(R,S@G"G-E="`M
M9R!S=&%T=7,M871T<B`G;F]N92<*<V5T("UG('!A;F4M8F]R9&5R+69G("=C
M;VQO=7(R,S@G"G-E="`M9R!S=&%T=7,M;&5F="UA='1R("=N;VYE)PIS971W
M("UG('=I;F1O=RUS=&%T=7,M9F<@)V-O;&]U<C$R,2<*<V5T=R`M9R!W:6YD
M;W<M<W1A='5S+6%T='(@)VYO;F4G"G-E='<@+6<@=VEN9&]W+7-T871U<RUA
M8W1I=FET>2UB9R`G8V]L;W5R,C,U)PIS971W("UG('=I;F1O=RUS=&%T=7,M
M86-T:79I='DM871T<B`G;F]N92<*<V5T=R`M9R!W:6YD;W<M<W1A='5S+6%C
M=&EV:71Y+69G("=C;VQO=7(Q-30G"G-E='<@+6<@=VEN9&]W+7-T871U<RUS
M97!A<F%T;W(@)R<*<V5T=R`M9R!W:6YD;W<M<W1A='5S+6)G("=C;VQO=7(R
M,S4G"G-E="`M9R!S=&%T=7,M;&5F="`G(UMF9SUC;VQO=7(R,S(L8F<]8V]L
M;W5R,34T72`C4R`C6V9G/6-O;&]U<C$U-"QB9SUC;VQO=7(R,S@L;F]B;VQD
M+&YO=6YD97)S8V]R92QN;VET86QI8W-=[H*P(UMF9SUC;VQO=7(R,C(L8F<]
M8V]L;W5R,C,X72`C5R`C6V9G/6-O;&]U<C(S."QB9SUC;VQO=7(R,S4L;F]B
M;VQD+&YO=6YD97)S8V]R92QN;VET86QI8W-=[H*P(UMF9SUC;VQO=7(Q,C$L
M8F<]8V]L;W5R,C,U72`C*'=H;V%M:2D@[H*Q(",H=7!T:6UE("!\(&-U="`M
M9"`B("(@+68@,2PR+#,I("-;9F<]8V]L;W5R,C,U+&)G/6-O;&]U<C(S-2QN
M;V)O;&0L;F]U;F1E<G-C;W)E+&YO:71A;&EC<UWN@K`G"G-E="`M9R!S=&%T
M=7,M<FEG:'0@)R-;9F<]8V]L;W5R,C,U+&)G/6-O;&]U<C(S-2QN;V)O;&0L
M;F]U;F1E<G-C;W)E+&YO:71A;&EC<UWN@K(C6V9G/6-O;&]U<C$R,2QB9SUC
M;VQO=7(R,S5=("5R(.Z"LR`E82#N@K,@)5D@(UMF9SUC;VQO=7(R,S@L8F<]
M8V]L;W5R,C,U+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S7>Z"LB-;
M9F<]8V]L;W5R,C(R+&)G/6-O;&]U<C(S.%T@(T@@(UMF9SUC;VQO=7(Q-30L
M8F<]8V]L;W5R,C,X+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S7>Z"
MLB-;9F<]8V]L;W5R,C,R+&)G/6-O;&]U<C$U-%T@(RAR86EN8F%R9B`M+6)A
M='1E<GD@+2UR96UA:6YI;F<@+2UN;RUR9V(I("<*<V5T=R`M9R!W:6YD;W<M
M<W1A='5S+69O<FUA="`G(UMF9SUC;VQO=7(R,S4L8F<]8V]L;W5R,C,U+&YO
M8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S7>Z"L"-;9&5F875L=%T@(TD@
M[H*Q("-7("-;9F<]8V]L;W5R,C,U+&)G/6-O;&]U<C(S-2QN;V)O;&0L;F]U
M;F1E<G-C;W)E+&YO:71A;&EC<UWN@K`G"G-E='<@+6<@=VEN9&]W+7-T871U
M<RUC=7)R96YT+69O<FUA="`G(UMF9SUC;VQO=7(R,S4L8F<]8V]L;W5R,C,X
M+&YO8F]L9"QN;W5N9&5R<V-O<F4L;F]I=&%L:6-S7>Z"L"-;9F<]8V]L;W5R
M,C(R+&)G/6-O;&]U<C(S.%T@(TD@[H*Q("-7(.Z"L2`C1B`C6V9G/6-O;&]U
M<C(S."QB9SUC;VQO=7(R,S4L;F]B;VQD+&YO=6YD97)S8V]R92QN;VET86QI
)8W-=[H*P)PH*
`
end
SHAR_EOF
  (set 20 18 03 31 11 41 59 'dot_tmux_conf'
   eval "${shar_touch}") && \
  chmod 0644 'dot_tmux_conf'
if test $? -ne 0
then ${echo} "restore of dot_tmux_conf failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_tmux_conf': 'MD5 check failed'
       ) << \SHAR_EOF
7f2bd72c0c11481a1daa9626be005c3d  dot_tmux_conf
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_tmux_conf'` -ne 2889 && \
  ${echo} "restoration warning:  size of 'dot_tmux_conf' is not 2889"
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
filetype plugin indent on
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
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
X
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
X
" Code/project navigation
Plugin 'scrooloose/nerdtree' 	    	" Project and file navigation
Plugin 'majutsushi/tagbar'          	" Class/module browser
Plugin 'ervandew/supertab'
Plugin 'BufOnly.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'SirVer/ultisnips'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'godlygeek/tabular'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'benmills/vimux'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'gilsondev/searchtasks.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'tpope/vim-dispatch'
X
" Programming
Plugin 'honza/vim-snippets'
Plugin 'Townk/vim-autoclose'
Plugin 'vim-syntastic/syntastic'
Plugin 'neomake/neomake'
X
" Markdown / Writting
Plugin 'reedes/vim-pencil'
Plugin 'tpope/vim-markdown'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'LanguageTool'
X
" Theming
Plugin 'ryanoasis/vim-devicons'
Plugin 'vim-airline/vim-airline'   	" Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fisadev/FixedTaskList.vim'  	" Pending tasks list
Plugin 'rosenfeld/conque-term'      	" Consoles as buffers
Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
Plugin 'ctags.vim'
X
" language support
Plugin 'elixir-lang/vim-elixir'
Plugin 'leafgarland/typescript-vim'
X
" solarized color theme
Plugin 'altercation/vim-colors-solarized'
X
" Git support
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
X
" Abolish (completion, typo fixes, casing)
Plugin 'tpope/vim-abolish'
X
" Repeat (repeat plugin commands)
Plugin 'tpope/vim-repeat'
X
" Project support
Plugin 'vim-scripts/project.tar.gz'
X
" Scratch buffer
Plugin 'vim-scripts/scratch.vim'
X
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
X
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
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
map <F2> :TaskList<CR>
SHAR_EOF
  (set 20 18 03 31 10 51 09 'dot_vimrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_vimrc'
if test $? -ne 0
then ${echo} "restore of dot_vimrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_vimrc': 'MD5 check failed'
       ) << \SHAR_EOF
ec36a3912e6494d33abc780035137632  dot_vimrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_vimrc'` -ne 4933 && \
  ${echo} "restoration warning:  size of 'dot_vimrc' is not 4933"
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
XXTerm*faceName: DejaVuSansMonoForPowerline NF
XXTerm*renderFont: true
XXTerm*reverseVideo: true
XXTerm*rightScrollBar: true
XXTerm*scrollBar: true
XXTerm*termName: xterm-256color
XXTerm*toolBar: false
XXTerm*utf8: 2
XXTerm*utf8Fonts: true
XXTerm*utf8Title: true
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
SHAR_EOF
  (set 20 18 03 31 10 51 09 'dot_Xresources'
   eval "${shar_touch}") && \
  chmod 0644 'dot_Xresources'
if test $? -ne 0
then ${echo} "restore of dot_Xresources failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_Xresources': 'MD5 check failed'
       ) << \SHAR_EOF
d811037451a6553daf8a38d44ec9ba57  dot_Xresources
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_Xresources'` -ne 637 && \
  ${echo} "restoration warning:  size of 'dot_Xresources' is not 637"
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

    git clone https://github.com/transcode-open/apt-cyg.git apt-cyg
    install -m 0755 apt-cyg/apt-cyg ~/.local/bin
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
            git clone https://github.com/ryanoasis/nerd-fonts.git
            cp -r nerd-fonts/patched-fonts/DejaVuSansMono \
                       ~/.local/share/fonts/nerd-fonts/
            fc-cache -f ~/.local/share/fonts
        fi
    fi
fi

# vim
echo "vim ..."
if [ -e ~/.vimrc ]; then
    cp -f ~/.vimrc "${BACKUPDIR}"
fi
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
install -m 0644 dot_vimrc ~/.vimrc

# tmux
echo "tmux ..."
if [ -e ~/.tmux.conf ]; then
    cp -f ~/.tmux.conf "${BACKUPDIR}"
fi
install -m 0644 dot_tmux_conf ~/.tmux.conf

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

# Python
echo "Python ..."
if ! has_prog pip3; then
    easy_install_prog=$(compgen -c 'easy_install-3' | head -n 1)
    if has_prog "${easy_install_prog}"; then
        if ! has_prog pip3; then
             "${easy_install_prog}" --user pip
        fi
    fi
fi
if ! has_prog pip2; then
    easy_install_prog=$(compgen -c 'easy_install-2' | head -n 1)
    if has_prog "${easy_install_prog}"; then
        if ! has_prog pip2; then
             "${easy_install_prog}" --user pip
        fi
    fi
fi
if ! has_prog cppman; then
    if has_prog pip3; then
        pip3 install --user cppman
    fi
fi

# Perl
echo "Perl ..."
if [ ! -e ~/.local/share/perl5 ]; then
    perl_local_lib=local-lib-2.000023
    curl -O "http://www.cpan.org/authors/id/H/HA/HAARG/${perl_local_lib}.tar.gz"
    tar zxvf "${perl_local_lib}.tar.gz"
    cd  "${perl_local_lib}"
    perl Makefile.PL "--bootstrap=${HOME}/.local/share/perl5"
    make test && make install
    cd ..
    perl "-I${HOME}/.local/share/perl5/lib/perl5" "-Mlocal::lib=${HOME}/.local/share/perl5" \
        > ~/.local/etc/profile.d/perl5.sh
    . ~/.local/etc/profile.d/perl5.sh
fi

# Gnulib
echo "Gnulib ..."
if ! has_prog gnulib-tool; then
    if [ ! -e ~/.local/share/gnulib ]; then
        git clone git://git.savannah.gnu.org/gnulib.git ~/.local/share/gnulib
    fi
    ln -s ~/.local/share/gnulib/gnulib-tool ~/.local/bin/gnulib-tool
fi

# TeX
echo "TeX ..."
if has_prog kpsewhich; then
    texmf_home=$(kpsewhich -var-value TEXMFHOME)
    if [ ! -e "${texmf_home}/tex/latex/createspace" ]; then
        mkdir -p "${texmf_home}/tex/latex/"
        git clone https://github.com/aginiewicz/createspace.git "${texmf_home}/tex/latex/createspace"
    fi
fi

