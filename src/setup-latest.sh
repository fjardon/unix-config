#!/usr/bin/env bash

# =============================================================================
# Exit on any errors
set -e
function echoerr() { echo "$@" 1>&2; }
# =============================================================================

# =============================================================================
# Configure some shell variables
PATH=${PATH}:${HOME}/.local/bin
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HOME}/.local/lib
DATAROOTDIR="${HOME}/.local/share"
# =============================================================================

# =============================================================================
# Autodetect current install capabilities
function has_prog() {
    hash "$1" > /dev/null 2>&1
    return $?
}

REQUIRED_PROGS=(git grep install mktemp sed)
has_errors=
for p in ${REQUIRED_PROGS[@]};
do
    if ! has_prog "${p}"; then
       echoerr " - ${p} required"
       has_errors=Yes
    fi
done
[[ -z "${has_errors}" ]] || exit 1

build_idutils=
if has_prog mkid && has_prog curl && has_prog gcc && has_prog make && has_prog tar; then
    build_idutils=Yes
fi

build_global=
if has_prog global && has_prog curl && has_prog gcc && has_prog make && has_prog tar; then
    build_global=Yes
fi

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
lock_dir=_sh10352
# Made on 2016-12-30 11:27 CET by <fjardon@yoda>.
# Source directory was '/home/fjardon/workspace/unix-config/src'.
#
# Existing files will *not* be overwritten, unless '-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   2366 -rw-r--r-- dot_profile
#   2762 -rw-r--r-- dot_bashrc
#   3647 -rw-r--r-- dot_emacs
#    901 -rwxr-xr-x runcron
#   4139 -rw-r--r-- dot_vimrc
#    663 -rw-r--r-- dot_Xresources
#   4076 -rw-r--r-- dot_XWinrc
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
# ============= dot_profile ==============
if test -n "${keep_file}" && test -f 'dot_profile'
then
${echo} "x - SKIPPING dot_profile (file already exists)"

else
${echo} "x - extracting dot_profile (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_profile' &&
# .bash_profile executed by bash(1) for login shells.
X
# Save system paths the first time
if [ -z "${SYSTEM_PATH}" ] ; then
X    export SYSTEM_PATH="${PATH}"
X    export SYSTEM_LD_LIBRARY_PATH="${LD_LIBRARY_PATH}"
X    export SYSTEM_PERL5LIB="${PERL5LIB}"
X    export SYSTEM_PKG_CONFIG_PATH="${PKG_CONFIG_PATH}"
fi
X
XXTRAPATHS="/opt /opt/local ${HOME}/.local"
for xtrad in ${XTRAPATHS};
do
X    # Set PATH so it includes user's private bin if it exists
X    if [ -d "${xtrad}/bin" ]; then
X        PATH="${xtrad}/bin:${PATH}"
X    fi
X    
X    # Set PATH so it includes user's private lib if it exists
X    if [ -d "${xtrad}/lib" ]; then
X        PATH="${xtrad}/lib:${PATH}"
X        LD_LIBRARY_PATH="${xtrad}/lib:${LD_LIBRARY_PATH}"
X    fi
X    
X    # Set PKG_CONFIG_PATH so it includes user's private if it exists
X    if [ -d "${xtrad}/lib/pkgconfig" ]; then
X        PKG_CONFIG_PATH="${xtrad}/lib/pkgconfig:${PKG_CONFIG_PATH}"
X    fi
X    
X    # Set MANPATH so it includes users' private man if it exists
X    if [ -d "${xtrad}/man" ]; then
X        MANPATH="${xtrad}/man:${MANPATH}"
X    fi
X    if [ -d "${xtrad}/share/man" ]; then
X        MANPATH="${xtrad}/share/man:${MANPATH}"
X    fi
X    
X    # Set INFOPATH so it includes users' private info if it exists
X    if [ -d "${xtrad}/info" ]; then
X        INFOPATH="${xtrad}/info:${INFOPATH}"
X    fi
X    
X    # Set PERL5LIB so it includes users' private perl5 if it exists
X    if [ -d "${xtrad}/lib/perl5" ]; then
X        PERL5LIB="${xtrad}/lib/perl5:${PERL5LIB}"
X    fi
X    if [ -d "${xtrad}/share/perl5" ]; then
X        PERL5LIB="${xtrad}/lib/perl5:${PERL5LIB}"
X    fi
X    for pl5 in ${xtrad}/lib/perl5/site_perl/*;
X    do
X        if [ -d "${pl5}" ]; then
X            PERL5LIB="${pl5}:${PERL5LIB}"
X        fi
X    done
X    for pl5 in ${xtrad}/share/perl5/*;
X    do
X        if [ -d "${pl5}" ]; then
X            PERL5LIB="${pl5}:${PERL5LIB}"
X        fi
X    done
X 
X    unset pl5
done
X
if [[ -f ~/.paths ]]; then
X   while read path
X   do
X	PATH="${PATH}:${path}"
X   done < ~/.paths
fi
X
export PATH
export LD_LIBRARY_PATH
export MANPATH
export INFOPATH
export PERL5LIB
X
# For nedit bug...
export XLIB_SKIP_ARGB_VISUALS=1
X
# Bash reads:
# - .bash_profile for interactive login shells
# - .bashrc for non-login intecactive shells.
# 
# source the users bashrc if it exists
if [[ -f "${HOME}/.bashrc" ]]; then
X    source "${HOME}/.bashrc"
fi
SHAR_EOF
  (set 20 16 12 18 10 56 45 'dot_profile'
   eval "${shar_touch}") && \
  chmod 0644 'dot_profile'
if test $? -ne 0
then ${echo} "restore of dot_profile failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_profile': 'MD5 check failed'
       ) << \SHAR_EOF
cadb331b31480bec7485c6021c63558e  dot_profile
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_profile'` -ne 2366 && \
  ${echo} "restoration warning:  size of 'dot_profile' is not 2366"
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
X        #RED_FG=$(tput setaf 1)
X        GREEN_FG=$(tput setaf 2)
X        YELLOW_FG=$(tput setaf 3)
X        #BLUE_FG=$(tput setaf 4)
X        MAGENTA_FG=$(tput setaf 5)
X        #CYAN_FG=$(tput setaf 6)
X        WHITE_FG=$(tput setaf 7)
X        DEFAULT_FG=$(tput setaf $(expr ${NCOLORS} + 1))
X        PS1="${GREEN_FG}\\u@\\h ${MAGENTA_FG}\\t ${YELLOW_FG}\\w${WHITE_FG}\n\$ "
X    else
X        PS1='\u@\h \t \w\n\$ '
X    fi
fi
X
if [[ "${TERM}" == *xterm* ]]; then
X    SETXTERMTITLE='\[\e]0;\h - \w\a\]\n'
X    PS1="${SETXTERMTITLE}${PS1}"
fi
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
  (set 20 16 12 10 20 16 43 'dot_bashrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_bashrc'
if test $? -ne 0
then ${echo} "restore of dot_bashrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_bashrc': 'MD5 check failed'
       ) << \SHAR_EOF
7edefe5d31a7fe45d7a80ddc0a501062  dot_bashrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_bashrc'` -ne 2762 && \
  ${echo} "restoration warning:  size of 'dot_bashrc' is not 2762"
  fi
fi
# ============= dot_emacs ==============
if test -n "${keep_file}" && test -f 'dot_emacs'
then
${echo} "x - SKIPPING dot_emacs (file already exists)"

else
${echo} "x - extracting dot_emacs (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'dot_emacs' &&
;; Enable column display in status bar
;; -----------------------------------
(column-number-mode t)
X
;; highlight .h file as c++ (doesn't do any harm to pure C files)
;; --------------------------------------------------------------
(require 'cc-mode)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
X
;; style I want to use in c++ mode
;; -------------------------------
(c-add-style "my-style" 
X	     '("stroustrup"
X	       (indent-tabs-mode . nil) ; use spaces rather than tabs
X	       (c-basic-offset . 4)     ; indent by four spaces
X                                        ; custom indentation rules
X	       (c-offsets-alist . ((inline-open . 0)  
X				   (brace-list-open . 0)
X				   (statement-case-open . +)))
X	       (c-hanging-braces-alist . (
X					  (class-close)
X					  ))
X	       (c-cleanup-list . (
X				  empty-defun-braces
X				  defun-close-semi
X				  list-close-comma
X				  scope-operator
X				  space-before-funcall
X				  compact-empty-funccall
X				  ))
X	       ))
X
;; use my-style defined above
(defun my-c++-mode-hook ()
X  (c-set-style "my-style")
X  (auto-fill-mode)         
X  (c-toggle-auto-hungry-state t)
X  (add-to-list 'c-cleanup-list 'defun-close-semi)
X  )
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
X
;; Typing while selecting overwrite the selection
;; ----------------------------------------------
(delete-selection-mode t)
X
X
;; CEDET activation
;; ----------------
(setq cedet-root-path (file-name-as-directory "~/.local/share/cedet-git"))
(load-file (concat cedet-root-path "cedet-devel-load.el"))
(add-to-list 'load-path (concat cedet-root-path "contrib"))
X
;; select which submodes we want to activate
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
X
;; Activate semantic
;;(semantic-mode 1)
X
;; Activate eassist
(require 'eassist)
X
;; customisation of modes
(defun custom-cedet-hook ()
X  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
X  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
X
X  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
X  (local-set-key "\C-c=" 'semantic-decoration-include-visit)
X
X  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
X  (local-set-key "\C-cq" 'semantic-ia-show-doc)
X  (local-set-key "\C-cs" 'semantic-ia-show-summary)
X  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
X  )
(add-hook 'c-mode-common-hook   'custom-cedet-hook)
(add-hook 'lisp-mode-hook       'custom-cedet-hook)
(add-hook 'scheme-mode-hook     'custom-cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'custom-cedet-hook)
(add-hook 'erlang-mode-hook     'custom-cedet-hook)
X
(defun custom-c-mode-cedet-hook ()
X  (local-set-key "\C-ct" 'eassist-switch-h-cpp)
X  (local-set-key "\C-xt" 'eassist-switch-h-cpp)
X  (local-set-key "\C-ce" 'eassist-list-methods)
X  (local-set-key "\C-c\C-r" 'semantic-symref)
X  )
(add-hook 'c-mode-common-hook 'custom-c-mode-cedet-hook)
X
(semanticdb-enable-gnu-global-databases 'c-mode   t)
(semanticdb-enable-gnu-global-databases 'c++-mode t)
X
(when (cedet-ectag-version-check t)
X  (semantic-load-enable-primary-ectags-support))
X
;; SRecode
(global-srecode-minor-mode t)
X
;; Enable EDE (Project Management) features
;;(global-ede-mode t)
(ede-enable-generic-projects)
X
;; Enable ECB
(add-to-list 'load-path "~/.local/share/ecb-git")
(require 'ecb)
X
SHAR_EOF
  (set 20 16 12 16 20 16 52 'dot_emacs'
   eval "${shar_touch}") && \
  chmod 0644 'dot_emacs'
if test $? -ne 0
then ${echo} "restore of dot_emacs failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_emacs': 'MD5 check failed'
       ) << \SHAR_EOF
d1dafcab6f35db51c72bd75e02c5a3b2  dot_emacs
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_emacs'` -ne 3647 && \
  ${echo} "restoration warning:  size of 'dot_emacs' is not 3647"
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
  (set 20 16 12 10 20 00 23 'runcron'
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
" Block cursor
let &t_SI.="\e[1 q"
let &t_EI.="\e[0 q"
let &t_ti.="\e[5 q"
let &t_te.="\e[0 q"
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
X
" others
Plugin 'vim-airline/vim-airline'   	" Lean & mean status/tabline for vim
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fisadev/FixedTaskList.vim'  	" Pending tasks list
Plugin 'rosenfeld/conque-term'      	" Consoles as buffers
Plugin 'tpope/vim-surround'	   	" Parentheses, brackets, quotes, XML tags, and more
Plugin 'ctags.vim'
X
" language support
Plugin 'elixir-lang/vim-elixir'
X
" solarized color theme
Plugin 'altercation/vim-colors-solarized'
X
" Git support
Plugin 'tpope/vim-fugitive'
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
set tabstop=2
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
  (set 20 16 12 30 11 26 40 'dot_vimrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_vimrc'
if test $? -ne 0
then ${echo} "restore of dot_vimrc failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_vimrc': 'MD5 check failed'
       ) << \SHAR_EOF
83ad35b9fa014dd11c7058d429657818  dot_vimrc
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_vimrc'` -ne 4139 && \
  ${echo} "restoration warning:  size of 'dot_vimrc' is not 4139"
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
XXTerm*faceName: Liberation Mono for Powerline,Literation Mono Powerline
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
  (set 20 16 12 16 20 16 52 'dot_Xresources'
   eval "${shar_touch}") && \
  chmod 0644 'dot_Xresources'
if test $? -ne 0
then ${echo} "restore of dot_Xresources failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_Xresources': 'MD5 check failed'
       ) << \SHAR_EOF
b1731e6cd910346df0e8aaf323b6d973  dot_Xresources
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_Xresources'` -ne 663 && \
  ${echo} "restoration warning:  size of 'dot_Xresources' is not 663"
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
  (set 20 16 12 10 20 00 23 'dot_XWinrc'
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
install -m 0644 dot_Xresources ~/.Xresources

if [[ "${os_name}" == CYGWIN* ]]; then
    if [ -e ~/.XWinrc ]; then
	cp -f ~/.XWinrc ${BACKUPDIR}
    fi
    install -m 0644 dot_XWinrc ~/.XWinrc
fi

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
export PATH=${PATH}:~/.local/bin

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

# fonts
echo "fonts ..."
install -d ~/.fonts
install -d ~/.local/share/fonts
if has_prog fc-cache; then
    if [ ! -e ~/.local/share/fonts/power-line ]; then
        git clone https://github.com/powerline/fonts.git \
              ~/.local/share/fonts/power-line
        fc-cache -f ~/.local/share/fonts
    fi
fi

# vim
echo "vim ..."
touch ~/.vimrc
cp -f ~/.vimrc ${BACKUPDIR}
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
install -m 0644 dot_vimrc ~/.vimrc

# Python
echo "Python ..."
if ! has_prog cppman; then
    easy_install_prog=$(compgen -c 'easy_install-3' | head -n 1)
    if has_prog "${easy_install_prog}"; then
        if ! has_prog pip3; then
            ${easy_install_prog} --user pip
        fi
    fi
    if has_prog pip3; then
        pip3 install --user cppman
    fi
fi

# emacs
echo "emacs ..."
touch ~/.emacs
cp -f ~/.emacs ${BACKUPDIR}
install -m 0644 dot_emacs ~/.emacs

if has_prog emacs && has_prog git && has_prog make; then
    echo "emacs cedet ..."
    CEDETDIR=cedet-git
    if [ ! -e "${DATAROOTDIR}/${CEDETDIR}" ]; then
	    git -C "${DATAROOTDIR}" clone \
	        'http://git.code.sf.net/p/cedet/git' ${CEDETDIR}
	    make -C "${DATAROOTDIR}/${CEDETDIR}" EMACS=emacs
    fi
fi

if has_prog emacs && has_prog git; then
    echo "emacs ecb ..."
    ECBDIR=ecb-git
    if [ ! -e "${DATAROOTDIR}/${ECBDIR}" ]; then
	      git -C "${DATAROOTDIR}" clone \
	          'https://github.com/alexott/ecb.git' ${ECBDIR}
    fi
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
    cd "${SHAR_TMPDIR}"
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
    cd "${SHAR_TMPDIR}"
fi

