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
# This is a shell archive (produced by GNU sharutils 4.14).
# To extract the files from this archive, save it to some FILE, remove
# everything before the '#!/bin/sh' line above, then type 'sh FILE'.
#
lock_dir=_sh12663
# Made on 2019-07-18 11:35 CEST by <fjardon@DiskStation>.
# Source directory was '/home/fjardon/workspace/github/unix-config/src'.
#
# Existing files will *not* be overwritten, unless '-c' is specified.
#
# This shar contains:
# length mode       name
# ------ ---------- ------------------------------------------
#   8094 -rwxr-xr-x scripts/codefmt
#   4686 -rwxr-xr-x scripts/codemv
#    601 -rw-r--r-- config.site
#    455 -rw-r--r-- dot_bash_profile
#   3065 -rw-r--r-- dot_bashrc
#    214 -rw-r--r-- dot_gdbinit
#   2479 -rw-r--r-- dot_profile
#   3140 -rw-r--r-- dot_tmux_conf
#   4125 -rw-r--r-- dot_vimrc
#    922 -rw-r--r-- dot_Xresources
#   4076 -rw-r--r-- dot_XWinrc
#   2541 -rwxr-xr-x scripts/byzanz-helper
#   3766 -rwxr-xr-x scripts/ffmpeg-helper
#   1820 -rwxr-xr-x scripts/hyper-v
#    195 -rw-r--r-- ibase.sh
#   6065 -rwxr-xr-x scripts/msvc-shell
#   3591 -rwxr-xr-x scripts/sixel2tmux
#   4128 -rwxr-xr-x scripts/yank
#   2836 -rw-r--r-- tmux-256color.tinfo
#    901 -rwxr-xr-x runcron
# 143360 -rw-r--r-- share-gdb.tar
#  13765 -rwxr-xr-x apt-cyg
#   5755 -rw-r--r-- byzanz-helper.1
#   5282 -rw-r--r-- codefmt.1
#   5363 -rw-r--r-- codemv.1
#   5711 -rw-r--r-- ffmpeg-helper.1
#   5129 -rw-r--r-- hyper-v.1
#   5915 -rw-r--r-- msvc-shell.1
#   6510 -rw-r--r-- sixel2tmux.1
#   7193 -rw-r--r-- yank.1
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
  (set 20 19 07 18 11 34 19 'scripts/codefmt'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/codefmt'
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
if test ! -d 'scripts'; then
  mkdir 'scripts'
if test $? -eq 0
then ${echo} "x - created directory scripts."
else ${echo} "x - failed to create directory scripts."
     exit 1
fi
fi
if test -n "${keep_file}" && test -f 'scripts/codemv'
then
${echo} "x - SKIPPING scripts/codemv (file already exists)"

else
${echo} "x - extracting scripts/codemv (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'scripts/codemv' &&
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
  (set 20 19 07 18 11 34 19 'scripts/codemv'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/codemv'
if test $? -ne 0
then ${echo} "restore of scripts/codemv failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/codemv': 'MD5 check failed'
       ) << \SHAR_EOF
c6e87f1769739326591d4863f0247678  scripts/codemv
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/codemv'` -ne 4686 && \
  ${echo} "restoration warning:  size of 'scripts/codemv' is not 4686"
  fi
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
  (set 20 19 06 12 17 03 55 'config.site'
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
  (set 20 19 05 28 21 38 47 'dot_bash_profile'
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
  (set 20 19 05 28 21 38 47 'dot_bashrc'
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
  (set 20 19 03 12 14 07 56 'dot_gdbinit'
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
  (set 20 19 05 28 21 38 47 'dot_profile'
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
  (set 20 18 09 06 10 08 24 'dot_tmux_conf'
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
  (set 20 18 09 06 10 08 24 'dot_vimrc'
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
  (set 20 18 11 01 14 34 59 'dot_Xresources'
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
  (set 20 17 07 06 09 11 31 'dot_XWinrc'
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
# ============= scripts/byzanz-helper ==============
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
  (set 20 19 07 18 11 34 19 'scripts/byzanz-helper'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/byzanz-helper'
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
  (set 20 19 07 18 11 34 19 'scripts/ffmpeg-helper'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/ffmpeg-helper'
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
  (set 20 19 07 18 11 34 19 'scripts/hyper-v'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/hyper-v'
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
  (set 20 19 05 28 21 38 48 'ibase.sh'
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
X    # Save current context to restore it later
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
X    # Get path to vcvarsall.bat
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
GetOptionsFromArray(
X    \@ARGV,
X    'help|h'             => \$opt_help,
X    'p|vcvarsall-path=s' => \$opt_p,
) or croak('Error parsing command line arguments');
X
# Handle help option
pod2usage(-exitval => 0) if $opt_help;
X
# Clean '-p' option
$opt_p = Cygwin::win_to_posix_path($opt_p)
X    if(defined($opt_p));
if(! defined($opt_p)) {
X    my @default_vs_paths = get_default_vs_paths();
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
  (set 20 19 07 18 11 34 19 'scripts/msvc-shell'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/msvc-shell'
if test $? -ne 0
then ${echo} "restore of scripts/msvc-shell failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'scripts/msvc-shell': 'MD5 check failed'
       ) << \SHAR_EOF
2681a16bdcf181e668426daaf9b5494e  scripts/msvc-shell
SHAR_EOF

else
test `LC_ALL=C wc -c < 'scripts/msvc-shell'` -ne 6065 && \
  ${echo} "restoration warning:  size of 'scripts/msvc-shell' is not 6065"
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
  (set 20 19 07 18 11 34 19 'scripts/sixel2tmux'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/sixel2tmux'
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
  (set 20 19 07 18 11 34 19 'scripts/yank'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/yank'
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
  (set 20 18 03 19 11 02 44 'tmux-256color.tinfo'
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
  (set 20 17 07 06 09 11 31 'runcron'
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
M`````````````#`P,#`W-34`,#`P,C`P,@`P,#`P,30T`#`P,#`P,#`P,#`P
M`#$S-3$T,#,V-3`W`#`Q,#4U,``@-0``````````````````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````!U<W1A<B`@`&9J87)D
M;VX`````````````````````````````````=7-E<G,`````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````N+W!Y=&AO;B\`````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````,#`P,#<U-0`P,#`R,#`R`#`P
M,#`Q-#0`,#`P,#`P,#`P,#``,3,U,30P,S8U,3$`,#$R,#8T`"`U````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````'5S=&%R("``9FIA<F1O;@````````````````````````````````!U
M<V5R<P``````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````"XO<'ET:&]N+VQI
M8G-T9&-X>"\`````````````````````````````````````````````````
M```````````````````````````````````````````````````````````P
M,#`P-S4U`#`P,#(P,#(`,#`P,#$T-``P,#`P,#`P,#`P,``Q,S4Q-#`S-C4Q
M,0`P,30P-S``(#4`````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````=7-T87(@(`!F:F%R9&]N````````````
M`````````````````````'5S97)S````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````+B]P>71H;VXO;&EB<W1D8WAX+W8V+P``````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````#`P,#`W-34`,#`P,C`P,@`P,#`P,30T`#`P,#`P
M,#`P,#`P`#$S-3$T,#,V-3$Q`#`Q-#0R,P`@-0``````````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````````````!U<W1A<B`@
M`&9J87)D;VX`````````````````````````````````=7-E<G,`````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````N+W!Y=&AO;B]L:6)S=&1C>'@O=C8O
M>&UE=&AO9',N<'D`````````````````````````````````````````````
M````````````````````````````````````````````,#`P,#8T-``P,#`R
M,#`R`#`P,#`Q-#0`,#`P,#`P-C<P,#,`,3,U,30P,S8U,3$`,#$V-C,V`"`P
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````'5S=&%R("``9FIA<F1O;@``````````````````````````
M``````!U<V5R<P``````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````````````",@6&UE
M=&AO9',@9F]R(&QI8G-T9&,K*RX*"B,@0V]P>7)I9VAT("A#*2`R,#$T+3(P
M,3D@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N+"!);F,N"@HC(%1H:7,@<')O
M9W)A;2!I<R!F<F5E('-O9G1W87)E.R!Y;W4@8V%N(')E9&ES=')I8G5T92!I
M="!A;F0O;W(@;6]D:69Y"B,@:70@=6YD97(@=&AE('1E<FUS(&]F('1H92!'
M3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS92!A<R!P=6)L:7-H960@8GD*(R!T
M:&4@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N.R!E:71H97(@=F5R<VEO;B`S
M(&]F('1H92!,:6-E;G-E+"!O<@HC("AA="!Y;W5R(&]P=&EO;BD@86YY(&QA
M=&5R('9E<G-I;VXN"B,*(R!4:&ES('!R;V=R86T@:7,@9&ES=')I8G5T960@
M:6X@=&AE(&AO<&4@=&AA="!I="!W:6QL(&)E('5S969U;"P*(R!B=70@5TE4
M2$]55"!!3ED@5T%24D%.5%D[('=I=&AO=70@979E;B!T:&4@:6UP;&EE9"!W
M87)R86YT>2!O9@HC($U%4D-(04Y404))3$E462!O<B!&251.15-3($9/4B!!
M(%!!4E1)0U5,05(@4%524$]312X@(%-E92!T:&4*(R!'3E4@1V5N97)A;"!0
M=6)L:6,@3&EC96YS92!F;W(@;6]R92!D971A:6QS+@HC"B,@66]U('-H;W5L
M9"!H879E(')E8V5I=F5D(&$@8V]P>2!O9B!T:&4@1TY5($=E;F5R86P@4'5B
M;&EC($QI8V5N<V4*(R!A;&]N9R!W:71H('1H:7,@<')O9W)A;2X@($EF(&YO
M="P@<V5E(#QH='1P.B\O=W=W+F=N=2YO<F<O;&EC96YS97,O/BX*"FEM<&]R
M="!G9&(*:6UP;W)T(&=D8BYX;65T:&]D"FEM<&]R="!R90H*;6%T8VAE<E]N
M86UE7W!R969I>"`]("=L:6)S=&1C*RLZ.B<*"F1E9B!G971?8F]O;%]T>7!E
M*"DZ"B`@("!R971U<FX@9V1B+FQO;VMU<%]T>7!E*"=B;V]L)RD*"F1E9B!G
M971?<W1D7W-I>F5?='EP92@I.@H@("`@<F5T=7)N(&=D8BYL;V]K=7!?='EP
M92@G<W1D.CIS:7IE7W0G*0H*8VQA<W,@3&EB4W1D0WAX6$UE=&AO9"AG9&(N
M>&UE=&AO9"Y8365T:&]D*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!N86UE
M+"!W;W)K97)?8VQA<W,I.@H@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V0N
M7U]I;FET7U\H<V5L9BP@;F%M92D*("`@("`@("!S96QF+G=O<FME<E]C;&%S
M<R`]('=O<FME<E]C;&%S<PH*(R!8;65T:&]D<R!F;W(@<W1D.CIA<G)A>0H*
M8VQA<W,@07)R87E7;W)K97)"87-E*&=D8BYX;65T:&]D+EA-971H;V17;W)K
M97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE*3H*
M("`@("`@("!S96QF+E]V86Q?='EP92`]('9A;%]T>7!E"B`@("`@("`@<V5L
M9BY?<VEZ92`]('-I>F4*"B`@("!D968@;G5L;%]V86QU92AS96QF*3H*("`@
M("`@("!N=6QL<'1R(#T@9V1B+G!A<G-E7V%N9%]E=F%L*"<H=F]I9"`J*2`P
M)RD*("`@("`@("!R971U<FX@;G5L;'!T<BYC87-T*'-E;&8N7W9A;%]T>7!E
M+G!O:6YT97(H*2DN9&5R969E<F5N8V4H*0H*8VQA<W,@07)R87E3:7IE5V]R
M:V5R*$%R<F%Y5V]R:V5R0F%S92DZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@
M=F%L7W1Y<&4L('-I>F4I.@H@("`@("`@($%R<F%Y5V]R:V5R0F%S92Y?7VEN
M:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92D*"B`@("!D968@9V5T7V%R9U]T
M>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?
M<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7W-T
M9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@
M("`@("`@(')E='5R;B!S96QF+E]S:7IE"@IC;&%S<R!!<G)A>45M<'1Y5V]R
M:V5R*$%R<F%Y5V]R:V5R0F%S92DZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@
M=F%L7W1Y<&4L('-I>F4I.@H@("`@("`@($%R<F%Y5V]R:V5R0F%S92Y?7VEN
M:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92D*"B`@("!D968@9V5T7V%R9U]T
M>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?
M<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7V)O
M;VQ?='EP92@I"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@
M("`@<F5T=7)N("AI;G0H<V5L9BY?<VEZ92D@/3T@,"D*"F-L87-S($%R<F%Y
M1G)O;G17;W)K97(H07)R87E7;W)K97)"87-E*3H*("`@(&1E9B!?7VEN:71?
M7RAS96QF+"!V86Q?='EP92P@<VEZ92DZ"B`@("`@("`@07)R87E7;W)K97)"
M87-E+E]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G
M971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@
M9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R
M;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI
M.@H@("`@("`@(&EF(&EN="AS96QF+E]S:7IE*2`^(#`Z"B`@("`@("`@("`@
M(')E='5R;B!O8FI;)U]-7V5L96US)UU;,%T*("`@("`@("!E;'-E.@H@("`@
M("`@("`@("!R971U<FX@<V5L9BYN=6QL7W9A;'5E*"D*"F-L87-S($%R<F%Y
M0F%C:U=O<FME<BA!<G)A>5=O<FME<D)A<V4I.@H@("`@9&5F(%]?:6YI=%]?
M*'-E;&8L('9A;%]T>7!E+"!S:7IE*3H*("`@("`@("!!<G)A>5=O<FME<D)A
M<V4N7U]I;FET7U\H<V5L9BP@=F%L7W1Y<&4L('-I>F4I"@H@("`@9&5F(&=E
M=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D
M968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N
M('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ
M"B`@("`@("`@:68@:6YT*'-E;&8N7W-I>F4I(#X@,#H*("`@("`@("`@("`@
M<F5T=7)N(&]B:ELG7TU?96QE;7,G75MS96QF+E]S:7IE("T@,5T*("`@("`@
M("!E;'-E.@H@("`@("`@("`@("!R971U<FX@<V5L9BYN=6QL7W9A;'5E*"D*
M"F-L87-S($%R<F%Y0717;W)K97(H07)R87E7;W)K97)"87-E*3H*("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!V86Q?='EP92P@<VEZ92DZ"B`@("`@("`@07)R
M87E7;W)K97)"87-E+E]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE*0H*
M("`@(&1E9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!G
M971?<W1D7W-I>F5?='EP92@I"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y
M<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@
M("`@:68@:6YT*&EN9&5X*2`^/2!I;G0H<V5L9BY?<VEZ92DZ"B`@("`@("`@
M("`@(')A:7-E($EN9&5X17)R;W(H)T%R<F%Y(&EN9&5X("(E9"(@<VAO=6QD
M(&YO="!B92`^/2`E9"XG("4*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`H*&EN="AI;F1E>"DL('-E;&8N7W-I>F4I*2D*("`@("`@("!R971U<FX@
M;V)J6R=?35]E;&5M<R==6VEN9&5X70H*8VQA<W,@07)R87E3=6)S8W)I<'17
M;W)K97(H07)R87E7;W)K97)"87-E*3H*("`@(&1E9B!?7VEN:71?7RAS96QF
M+"!V86Q?='EP92P@<VEZ92DZ"B`@("`@("`@07)R87E7;W)K97)"87-E+E]?
M:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!S:7IE*0H*("`@(&1E9B!G971?87)G
M7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!G971?<W1D7W-I>F5?='EP
M92@I"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHL(&EN9&5X
M*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C
M86QL7U\H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@:68@:6YT*'-E;&8N
M7W-I>F4I(#X@,#H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?96QE;7,G
M75MI;F1E>%T*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@<V5L
M9BYN=6QL7W9A;'5E*"D*"F-L87-S($%R<F%Y365T:&]D<TUA=&-H97(H9V1B
M+GAM971H;V0N6$UE=&AO9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8I.@H@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R+E]?:6YI
M=%]?*'-E;&8L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@;6%T8VAE<E]N86UE7W!R969I>"`K("=A<G)A>2<I"B`@("`@
M("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@("`@("`@("`@("=S:7IE)SH@
M3&EB4W1D0WAX6$UE=&AO9"@G<VEZ92<L($%R<F%Y4VEZ95=O<FME<BDL"B`@
M("`@("`@("`@("=E;7!T>2<Z($QI8E-T9$-X>%A-971H;V0H)V5M<'1Y)RP@
M07)R87E%;7!T>5=O<FME<BDL"B`@("`@("`@("`@("=F<F]N="<Z($QI8E-T
M9$-X>%A-971H;V0H)V9R;VYT)RP@07)R87E&<F]N=%=O<FME<BDL"B`@("`@
M("`@("`@("=B86-K)SH@3&EB4W1D0WAX6$UE=&AO9"@G8F%C:R<L($%R<F%Y
M0F%C:U=O<FME<BDL"B`@("`@("`@("`@("=A="<Z($QI8E-T9$-X>%A-971H
M;V0H)V%T)RP@07)R87E!=%=O<FME<BDL"B`@("`@("`@("`@("=O<&5R871O
M<EM=)SH@3&EB4W1D0WAX6$UE=&AO9"@G;W!E<F%T;W);72<L($%R<F%Y4W5B
M<V-R:7!T5V]R:V5R*2P*("`@("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S
M(#T@6W-E;&8N7VUE=&AO9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO
M9%]D:6-T70H*("`@(&1E9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H
M;V1?;F%M92DZ"B`@("`@("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<
M9"LZ.BD_87)R87D\+BH^)"<L(&-L87-S7W1Y<&4N=&%G*3H*("`@("`@("`@
M("`@<F5T=7)N($YO;F4*("`@("`@("!M971H;V0@/2!S96QF+E]M971H;V1?
M9&EC="YG970H;65T:&]D7VYA;64I"B`@("`@("`@:68@;65T:&]D(&ES($YO
M;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@("`@("`@("`@("!R971U<FX@
M3F]N90H@("`@("`@('1R>3H*("`@("`@("`@("`@=F%L=65?='EP92`](&-L
M87-S7W1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("`@("`@<VEZ
M92`](&-L87-S7W1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,2D*("`@("`@("!E
M>&-E<'0Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@<F5T=7)N
M(&UE=&AO9"YW;W)K97)?8VQA<W,H=F%L=65?='EP92P@<VEZ92D*"B,@6&UE
M=&AO9',@9F]R('-T9#HZ9&5Q=64*"F-L87-S($1E<75E5V]R:V5R0F%S92AG
M9&(N>&UE=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!V86Q?='EP92DZ"B`@("`@("`@<V5L9BY?=F%L7W1Y<&4@/2!V86Q?
M='EP90H@("`@("`@('-E;&8N7V)U9G-I>F4@/2`U,3(@+R\@=F%L7W1Y<&4N
M<VEZ96]F(&]R(#$*"B`@("!D968@<VEZ92AS96QF+"!O8FHI.@H@("`@("`@
M(&9I<G-T7VYO9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?
M;F]D92=="B`@("`@("`@;&%S=%]N;V1E(#T@;V)J6R=?35]I;7!L)UU;)U]-
M7V9I;FES:"==6R=?35]N;V1E)UT*("`@("`@("!C=7(@/2!O8FI;)U]-7VEM
M<&PG75LG7TU?9FEN:7-H)UU;)U]-7V-U<B=="B`@("`@("`@9FER<W0@/2!O
M8FI;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7V9I<G-T)UT*("`@("`@
M("!R971U<FX@*&QA<W1?;F]D92`M(&9I<G-T7VYO9&4I("H@<V5L9BY?8G5F
M<VEZ92`K("AC=7(@+2!F:7)S="D*"B`@("!D968@:6YD97@H<V5L9BP@;V)J
M+"!I9'@I.@H@("`@("`@(&9I<G-T7VYO9&4@/2!O8FI;)U]-7VEM<&PG75LG
M7TU?<W1A<G0G75LG7TU?;F]D92=="B`@("`@("`@:6YD97A?;F]D92`](&9I
M<G-T7VYO9&4@*R!I;G0H:61X*2`O+R!S96QF+E]B=69S:7IE"B`@("`@("`@
M<F5T=7)N(&EN9&5X7VYO9&5;,%U;:61X("4@<V5L9BY?8G5F<VEZ95T*"F-L
M87-S($1E<75E16UP='E7;W)K97(H1&5Q=657;W)K97)"87-E*3H*("`@(&1E
M9B!G971?87)G7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@
M("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E
M='5R;B!G971?8F]O;%]T>7!E*"D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@
M;V)J*3H*("`@("`@("!R971U<FX@*&]B:ELG7TU?:6UP;"==6R=?35]S=&%R
M="==6R=?35]C=7(G72`]/0H@("`@("`@("`@("`@("`@;V)J6R=?35]I;7!L
M)UU;)U]-7V9I;FES:"==6R=?35]C=7(G72D*"F-L87-S($1E<75E4VEZ95=O
M<FME<BA$97%U95=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?='EP97,H
M<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T7W)E<W5L
M=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ
M95]T>7!E*"D*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@
M("!R971U<FX@<V5L9BYS:7IE*&]B:BD*"F-L87-S($1E<75E1G)O;G17;W)K
M97(H1&5Q=657;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G7W1Y<&5S*'-E
M;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U;'1?
M='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP
M90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R
M;B!O8FI;)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?8W5R)UU;,%T*"F-L
M87-S($1E<75E0F%C:U=O<FME<BA$97%U95=O<FME<D)A<V4I.@H@("`@9&5F
M(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@
M("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T
M=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B
M:BDZ"B`@("`@("`@:68@*&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G75LG
M7TU?8W5R)UT@/3T*("`@("`@("`@("`@;V)J6R=?35]I;7!L)UU;)U]-7V9I
M;FES:"==6R=?35]F:7)S="==*3H*("`@("`@("`@("`@<')E=E]N;V1E(#T@
M;V)J6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]N;V1E)UT@+2`Q"B`@
M("`@("`@("`@(')E='5R;B!P<F5V7VYO9&5;,%U;<V5L9BY?8G5F<VEZ92`M
M(#%="B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N(&]B:ELG7TU?
M:6UP;"==6R=?35]F:6YI<V@G75LG7TU?8W5R)UU;+3%="@IC;&%S<R!$97%U
M95-U8G-C<FEP=%=O<FME<BA$97%U95=O<FME<D)A<V4I.@H@("`@9&5F(&=E
M=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ
M95]T>7!E*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@
M<W5B<V-R:7!T*3H*("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@;V)J+"!S=6)S8W)I<'0I.@H@("`@("`@
M(')E='5R;B!S96QF+FEN9&5X*&]B:BP@<W5B<V-R:7!T*0H*8VQA<W,@1&5Q
M=65!=%=O<FME<BA$97%U95=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?
M='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E
M*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@:6YD97@I
M.@H@("`@("`@(')E='5R;B!S96QF+E]V86Q?='EP90H*("`@(&1E9B!?7V-A
M;&Q?7RAS96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("!D97%U95]S:7IE(#T@
M:6YT*'-E;&8N<VEZ92AO8FHI*0H@("`@("`@(&EF(&EN="AI;F1E>"D@/CT@
M9&5Q=65?<VEZ93H*("`@("`@("`@("`@<F%I<V4@26YD97A%<G)O<B@G1&5Q
M=64@:6YD97@@(B5D(B!S:&]U;&0@;F]T(&)E(#X]("5D+B<@)0H@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("AI;G0H:6YD97@I+"!D97%U95]S:7IE
M*2D*("`@("`@("!E;'-E.@H@("`@("`@("`@(')E='5R;B!S96QF+FEN9&5X
M*&]B:BP@:6YD97@I"@IC;&%S<R!$97%U94UE=&AO9'--871C:&5R*&=D8BYX
M;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF
M*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BY?7VEN:71?
M7RAS96QF+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@(&UA=&-H97)?;F%M95]P<F5F:7@@*R`G9&5Q=64G*0H@("`@("`@
M('-E;&8N7VUE=&AO9%]D:6-T(#T@>PH@("`@("`@("`@("`G96UP='DG.B!,
M:6)3=&1#>'A8365T:&]D*"=E;7!T>2<L($1E<75E16UP='E7;W)K97(I+`H@
M("`@("`@("`@("`G<VEZ92<Z($QI8E-T9$-X>%A-971H;V0H)W-I>F4G+"!$
M97%U95-I>F57;W)K97(I+`H@("`@("`@("`@("`G9G)O;G0G.B!,:6)3=&1#
M>'A8365T:&]D*"=F<F]N="<L($1E<75E1G)O;G17;W)K97(I+`H@("`@("`@
M("`@("`G8F%C:R<Z($QI8E-T9$-X>%A-971H;V0H)V)A8VLG+"!$97%U94)A
M8VM7;W)K97(I+`H@("`@("`@("`@("`G;W!E<F%T;W);72<Z($QI8E-T9$-X
M>%A-971H;V0H)V]P97)A=&]R6UTG+"!$97%U95-U8G-C<FEP=%=O<FME<BDL
M"B`@("`@("`@("`@("=A="<Z($QI8E-T9$-X>%A-971H;V0H)V%T)RP@1&5Q
M=65!=%=O<FME<BD*("`@("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@
M6W-E;&8N7VUE=&AO9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D
M:6-T70H*("`@(&1E9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?
M;F%M92DZ"B`@("`@("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ
M.BD_9&5Q=64\+BH^)"<L(&-L87-S7W1Y<&4N=&%G*3H*("`@("`@("`@("`@
M<F5T=7)N($YO;F4*("`@("`@("!M971H;V0@/2!S96QF+E]M971H;V1?9&EC
M="YG970H;65T:&]D7VYA;64I"B`@("`@("`@:68@;65T:&]D(&ES($YO;F4@
M;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@("`@("`@("`@("!R971U<FX@3F]N
M90H@("`@("`@(')E='5R;B!M971H;V0N=V]R:V5R7V-L87-S*&-L87-S7W1Y
M<&4N=&5M<&QA=&5?87)G=6UE;G0H,"DI"@HC(%AM971H;V1S(&9O<B!S=&0Z
M.F9O<G=A<F1?;&ES=`H*8VQA<W,@1F]R=V%R9$QI<W17;W)K97)"87-E*&=D
M8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E9B!?7VEN:71?7RAS
M96QF+"!V86Q?='EP92P@;F]D95]T>7!E*3H*("`@("`@("!S96QF+E]V86Q?
M='EP92`]('9A;%]T>7!E"B`@("`@("`@<V5L9BY?;F]D95]T>7!E(#T@;F]D
M95]T>7!E"@H@("`@9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@
M<F5T=7)N($YO;F4*"F-L87-S($9O<G=A<F1,:7-T16UP='E7;W)K97(H1F]R
M=V%R9$QI<W17;W)K97)"87-E*3H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H
M<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7V)O;VQ?='EP92@I"@H@
M("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&]B
M:ELG7TU?:6UP;"==6R=?35]H96%D)UU;)U]-7VYE>'0G72`]/2`P"@IC;&%S
M<R!&;W)W87)D3&ES=$9R;VYT5V]R:V5R*$9O<G=A<F1,:7-T5V]R:V5R0F%S
M92DZ"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@
M("`@<F5T=7)N('-E;&8N7W9A;%]T>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E
M;&8L(&]B:BDZ"B`@("`@("`@;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]H
M96%D)UU;)U]-7VYE>'0G72YC87-T*'-E;&8N7VYO9&5?='EP92D*("`@("`@
M("!V86Q?861D<F5S<R`](&YO9&5;)U]-7W-T;W)A9V4G75LG7TU?<W1O<F%G
M92==+F%D9')E<W,*("`@("`@("!R971U<FX@=F%L7V%D9')E<W,N8V%S="AS
M96QF+E]V86Q?='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*"F-L87-S
M($9O<G=A<F1,:7-T365T:&]D<TUA=&-H97(H9V1B+GAM971H;V0N6$UE=&AO
M9$UA=&-H97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8I.@H@("`@("`@(&UA
M=&-H97)?;F%M92`](&UA=&-H97)?;F%M95]P<F5F:7@@*R`G9F]R=V%R9%]L
M:7-T)PH@("`@("`@(&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R+E]?:6YI
M=%]?*'-E;&8L(&UA=&-H97)?;F%M92D*("`@("`@("!S96QF+E]M971H;V1?
M9&EC="`]('L*("`@("`@("`@("`@)V5M<'1Y)SH@3&EB4W1D0WAX6$UE=&AO
M9"@G96UP='DG+"!&;W)W87)D3&ES=$5M<'1Y5V]R:V5R*2P*("`@("`@("`@
M("`@)V9R;VYT)SH@3&EB4W1D0WAX6$UE=&AO9"@G9G)O;G0G+"!&;W)W87)D
M3&ES=$9R;VYT5V]R:V5R*0H@("`@("`@('T*("`@("`@("!S96QF+FUE=&AO
M9',@/2!;<V5L9BY?;65T:&]D7V1I8W1;;5T@9F]R(&T@:6X@<V5L9BY?;65T
M:&]D7V1I8W1="@H@("`@9&5F(&UA=&-H*'-E;&8L(&-L87-S7W1Y<&4L(&UE
M=&AO9%]N86UE*3H*("`@("`@("!I9B!N;W0@<F4N;6%T8V@H)UYS=&0Z.BA?
M7UQD*SHZ*3]F;W)W87)D7VQI<W0\+BH^)"<L(&-L87-S7W1Y<&4N=&%G*3H*
M("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!M971H;V0@/2!S96QF
M+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA;64I"B`@("`@("`@:68@;65T
M:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE;F%B;&5D.@H@("`@("`@("`@
M("!R971U<FX@3F]N90H@("`@("`@('9A;%]T>7!E(#T@8VQA<W-?='EP92YT
M96UP;&%T95]A<F=U;65N="@P*0H@("`@("`@(&YO9&5?='EP92`](&=D8BYL
M;V]K=7!?='EP92AS='(H8VQA<W-?='EP92D@*R`G.CI?3F]D92<I+G!O:6YT
M97(H*0H@("`@("`@(')E='5R;B!M971H;V0N=V]R:V5R7V-L87-S*'9A;%]T
M>7!E+"!N;V1E7W1Y<&4I"@HC(%AM971H;V1S(&9O<B!S=&0Z.FQI<W0*"F-L
M87-S($QI<W17;W)K97)"87-E*&=D8BYX;65T:&]D+EA-971H;V17;W)K97(I
M.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;%]T>7!E+"!N;V1E7W1Y<&4I
M.@H@("`@("`@('-E;&8N7W9A;%]T>7!E(#T@=F%L7W1Y<&4*("`@("`@("!S
M96QF+E]N;V1E7W1Y<&4@/2!N;V1E7W1Y<&4*"B`@("!D968@9V5T7V%R9U]T
M>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?
M=F%L=65?9G)O;5]N;V1E*'-E;&8L(&YO9&4I.@H@("`@("`@(&YO9&4@/2!N
M;V1E+F1E<F5F97)E;F-E*"D*("`@("`@("!I9B!N;V1E+G1Y<&4N9FEE;&1S
M*"E;,5TN;F%M92`]/2`G7TU?9&%T82<Z"B`@("`@("`@("`@(",@0RLK,#,@
M:6UP;&5M96YT871I;VXL(&YO9&4@8V]N=&%I;G,@=&AE('9A;'5E(&%S(&$@
M;65M8F5R"B`@("`@("`@("`@(')E='5R;B!N;V1E6R=?35]D871A)UT*("`@
M("`@("`C($,K*S$Q(&EM<&QE;65N=&%T:6]N+"!N;V1E('-T;W)E<R!V86QU
M92!I;B!?7V%L:6=N961?;65M8G5F"B`@("`@("`@861D<B`](&YO9&5;)U]-
M7W-T;W)A9V4G72YA9&1R97-S"B`@("`@("`@<F5T=7)N(&%D9'(N8V%S="AS
M96QF+E]V86Q?='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*"F-L87-S
M($QI<W1%;7!T>5=O<FME<BA,:7-T5V]R:V5R0F%S92DZ"B`@("!D968@9V5T
M7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]B
M;V]L7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@(&)A<V5?;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]N;V1E)UT*("`@
M("`@("!I9B!B87-E7VYO9&5;)U]-7VYE>'0G72`]/2!B87-E7VYO9&4N861D
M<F5S<SH*("`@("`@("`@("`@<F5T=7)N(%1R=64*("`@("`@("!E;'-E.@H@
M("`@("`@("`@("!R971U<FX@1F%L<V4*"F-L87-S($QI<W13:7IE5V]R:V5R
M*$QI<W17;W)K97)"87-E*3H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L
M9BP@;V)J*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*
M("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(&)E9VEN7VYO
M9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?;F]D92==6R=?35]N97AT)UT*("`@
M("`@("!E;F1?;F]D92`](&]B:ELG7TU?:6UP;"==6R=?35]N;V1E)UTN861D
M<F5S<PH@("`@("`@('-I>F4@/2`P"B`@("`@("`@=VAI;&4@8F5G:6Y?;F]D
M92`A/2!E;F1?;F]D93H*("`@("`@("`@("`@8F5G:6Y?;F]D92`](&)E9VEN
M7VYO9&5;)U]-7VYE>'0G70H@("`@("`@("`@("!S:7IE("L](#$*("`@("`@
M("!R971U<FX@<VEZ90H*8VQA<W,@3&ES=$9R;VYT5V]R:V5R*$QI<W17;W)K
M97)"87-E*3H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*
M("`@("`@("!R971U<FX@<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL
M7U\H<V5L9BP@;V)J*3H*("`@("`@("!N;V1E(#T@;V)J6R=?35]I;7!L)UU;
M)U]-7VYO9&4G75LG7TU?;F5X="==+F-A<W0H<V5L9BY?;F]D95]T>7!E*0H@
M("`@("`@(')E='5R;B!S96QF+F=E=%]V86QU95]F<F]M7VYO9&4H;F]D92D*
M"F-L87-S($QI<W1"86-K5V]R:V5R*$QI<W17;W)K97)"87-E*3H*("`@(&1E
M9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*
M("`@("`@("!P<F5V7VYO9&4@/2!O8FI;)U]-7VEM<&PG75LG7TU?;F]D92==
M6R=?35]P<F5V)UTN8V%S="AS96QF+E]N;V1E7W1Y<&4I"B`@("`@("`@<F5T
M=7)N('-E;&8N9V5T7W9A;'5E7V9R;VU?;F]D92AP<F5V7VYO9&4I"@IC;&%S
M<R!,:7-T365T:&]D<TUA=&-H97(H9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H
M97(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8I.@H@("`@("`@(&=D8BYX;65T
M:&]D+EA-971H;V1-871C:&5R+E]?:6YI=%]?*'-E;&8L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@;6%T8VAE<E]N86UE
M7W!R969I>"`K("=L:7-T)RD*("`@("`@("!S96QF+E]M971H;V1?9&EC="`]
M('L*("`@("`@("`@("`@)V5M<'1Y)SH@3&EB4W1D0WAX6$UE=&AO9"@G96UP
M='DG+"!,:7-T16UP='E7;W)K97(I+`H@("`@("`@("`@("`G<VEZ92<Z($QI
M8E-T9$-X>%A-971H;V0H)W-I>F4G+"!,:7-T4VEZ95=O<FME<BDL"B`@("`@
M("`@("`@("=F<F]N="<Z($QI8E-T9$-X>%A-971H;V0H)V9R;VYT)RP@3&ES
M=$9R;VYT5V]R:V5R*2P*("`@("`@("`@("`@)V)A8VLG.B!,:6)3=&1#>'A8
M365T:&]D*"=B86-K)RP@3&ES=$)A8VM7;W)K97(I"B`@("`@("`@?0H@("`@
M("`@('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@
M;2!I;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@
M8VQA<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM
M871C:"@G7G-T9#HZ*%]?7&0K.CHI/RA?7V-X>#$Q.CHI/VQI<W0\+BH^)"<L
M(&-L87-S7W1Y<&4N=&%G*3H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@
M("`@("!M971H;V0@/2!S96QF+E]M971H;V1?9&EC="YG970H;65T:&]D7VYA
M;64I"B`@("`@("`@:68@;65T:&]D(&ES($YO;F4@;W(@;F]T(&UE=&AO9"YE
M;F%B;&5D.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@('9A;%]T
M>7!E(#T@8VQA<W-?='EP92YT96UP;&%T95]A<F=U;65N="@P*0H@("`@("`@
M(&YO9&5?='EP92`](&=D8BYL;V]K=7!?='EP92AS='(H8VQA<W-?='EP92D@
M*R`G.CI?3F]D92<I+G!O:6YT97(H*0H@("`@("`@(')E='5R;B!M971H;V0N
M=V]R:V5R7V-L87-S*'9A;%]T>7!E+"!N;V1E7W1Y<&4I"@HC(%AM971H;V1S
M(&9O<B!S=&0Z.G9E8W1O<@H*8VQA<W,@5F5C=&]R5V]R:V5R0F%S92AG9&(N
M>&UE=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF
M+"!V86Q?='EP92DZ"B`@("`@("`@<V5L9BY?=F%L7W1Y<&4@/2!V86Q?='EP
M90H*("`@(&1E9B!S:7IE*'-E;&8L(&]B:BDZ"B`@("`@("`@:68@<V5L9BY?
M=F%L7W1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7T)/3TPZ"B`@("`@("`@
M("`@('-T87)T(#T@;V)J6R=?35]I;7!L)UU;)U]-7W-T87)T)UU;)U]-7W`G
M70H@("`@("`@("`@("!F:6YI<V@@/2!O8FI;)U]-7VEM<&PG75LG7TU?9FEN
M:7-H)UU;)U]-7W`G70H@("`@("`@("`@("!F:6YI<VA?;V9F<V5T(#T@;V)J
M6R=?35]I;7!L)UU;)U]-7V9I;FES:"==6R=?35]O9F9S970G70H@("`@("`@
M("`@("!B:71?<VEZ92`]('-T87)T+F1E<F5F97)E;F-E*"DN='EP92YS:7IE
M;V8@*B`X"B`@("`@("`@("`@(')E='5R;B`H9FEN:7-H("T@<W1A<G0I("H@
M8FET7W-I>F4@*R!F:6YI<VA?;V9F<V5T"B`@("`@("`@96QS93H*("`@("`@
M("`@("`@<F5T=7)N(&]B:ELG7TU?:6UP;"==6R=?35]F:6YI<V@G72`M(&]B
M:ELG7TU?:6UP;"==6R=?35]S=&%R="=="@H@("`@9&5F(&=E="AS96QF+"!O
M8FHL(&EN9&5X*3H*("`@("`@("!I9B!S96QF+E]V86Q?='EP92YC;V1E(#T]
M(&=D8BY465!%7T-/1$5?0D]/3#H*("`@("`@("`@("`@<W1A<G0@/2!O8FI;
M)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?<"=="B`@("`@("`@("`@(&)I
M=%]S:7IE(#T@<W1A<G0N9&5R969E<F5N8V4H*2YT>7!E+G-I>F5O9B`J(#@*
M("`@("`@("`@("`@=F%L<"`]('-T87)T("L@:6YD97@@+R\@8FET7W-I>F4*
M("`@("`@("`@("`@;V9F<V5T(#T@:6YD97@@)2!B:71?<VEZ90H@("`@("`@
M("`@("!R971U<FX@*'9A;'`N9&5R969E<F5N8V4H*2`F("@Q(#P\(&]F9G-E
M="DI(#X@,`H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')E='5R;B!O8FI;
M)U]-7VEM<&PG75LG7TU?<W1A<G0G75MI;F1E>%T*"F-L87-S(%9E8W1O<D5M
M<'1Y5V]R:V5R*%9E8W1O<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]A<F=?
M='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@9V5T
M7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(&=E=%]B
M;V]L7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@(')E='5R;B!I;G0H<V5L9BYS:7IE*&]B:BDI(#T](#`*"F-L87-S(%9E
M8W1O<E-I>F57;W)K97(H5F5C=&]R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T
M7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E
M9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O
M8FHI.@H@("`@("`@(')E='5R;B!S96QF+G-I>F4H;V)J*0H*8VQA<W,@5F5C
M=&]R1G)O;G17;W)K97(H5F5C=&]R5V]R:V5R0F%S92DZ"B`@("!D968@9V5T
M7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E
M9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@
M<V5L9BY?=F%L7W1Y<&4*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*
M("`@("`@("!R971U<FX@<V5L9BYG970H;V)J+"`P*0H*8VQA<W,@5F5C=&]R
M0F%C:U=O<FME<BA696-T;W)7;W)K97)"87-E*3H*("`@(&1E9B!G971?87)G
M7W1Y<&5S*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E
M=%]R97-U;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF
M+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@(')E='5R;B!S96QF+F=E="AO8FHL(&EN="AS96QF+G-I>F4H;V)J*2D@
M+2`Q*0H*8VQA<W,@5F5C=&]R0717;W)K97(H5F5C=&]R5V]R:V5R0F%S92DZ
M"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@
M9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H
M<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@<F5T=7)N('-E;&8N7W9A;%]T
M>7!E"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BP@:6YD97@I.@H@("`@
M("`@('-I>F4@/2!I;G0H<V5L9BYS:7IE*&]B:BDI"B`@("`@("`@:68@:6YT
M*&EN9&5X*2`^/2!S:7IE.@H@("`@("`@("`@("!R86ES92!);F1E>$5R<F]R
M*"=696-T;W(@:6YD97@@(B5D(B!S:&]U;&0@;F]T(&)E(#X]("5D+B<@)0H@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("@H:6YT*&EN9&5X*2P@<VEZ
M92DI*0H@("`@("`@(')E='5R;B!S96QF+F=E="AO8FHL(&EN="AI;F1E>"DI
M"@IC;&%S<R!696-T;W)3=6)S8W)I<'17;W)K97(H5F5C=&]R5V]R:V5R0F%S
M92DZ"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF*3H*("`@("`@("!R971U
M<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!G971?<F5S=6QT7W1Y
M<&4H<V5L9BP@;V)J+"!S=6)S8W)I<'0I.@H@("`@("`@(')E='5R;B!S96QF
M+E]V86Q?='EP90H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHL('-U8G-C
M<FEP="DZ"B`@("`@("`@<F5T=7)N('-E;&8N9V5T*&]B:BP@:6YT*'-U8G-C
M<FEP="DI"@IC;&%S<R!696-T;W)-971H;V1S36%T8VAE<BAG9&(N>&UE=&AO
M9"Y8365T:&]D36%T8VAE<BDZ"B`@("!D968@7U]I;FET7U\H<V5L9BDZ"B`@
M("`@("`@9V1B+GAM971H;V0N6$UE=&AO9$UA=&-H97(N7U]I;FET7U\H<V5L
M9BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!M871C:&5R7VYA;65?<')E9FEX("L@)W9E8W1O<B<I"B`@("`@("`@<V5L
M9BY?;65T:&]D7V1I8W0@/2!["B`@("`@("`@("`@("=S:7IE)SH@3&EB4W1D
M0WAX6$UE=&AO9"@G<VEZ92<L(%9E8W1O<E-I>F57;W)K97(I+`H@("`@("`@
M("`@("`G96UP='DG.B!,:6)3=&1#>'A8365T:&]D*"=E;7!T>2<L(%9E8W1O
M<D5M<'1Y5V]R:V5R*2P*("`@("`@("`@("`@)V9R;VYT)SH@3&EB4W1D0WAX
M6$UE=&AO9"@G9G)O;G0G+"!696-T;W)&<F]N=%=O<FME<BDL"B`@("`@("`@
M("`@("=B86-K)SH@3&EB4W1D0WAX6$UE=&AO9"@G8F%C:R<L(%9E8W1O<D)A
M8VM7;W)K97(I+`H@("`@("`@("`@("`G870G.B!,:6)3=&1#>'A8365T:&]D
M*"=A="<L(%9E8W1O<D%T5V]R:V5R*2P*("`@("`@("`@("`@)V]P97)A=&]R
M6UTG.B!,:6)3=&1#>'A8365T:&]D*"=O<&5R871O<EM=)RP*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%9E8W1O<E-U8G-C
M<FEP=%=O<FME<BDL"B`@("`@("`@?0H@("`@("`@('-E;&8N;65T:&]D<R`]
M(%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@;2!I;B!S96QF+E]M971H;V1?
M9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@8VQA<W-?='EP92P@;65T:&]D
M7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM871C:"@G7G-T9#HZ*%]?7&0K
M.CHI/W9E8W1O<CPN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@
M("!R971U<FX@3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D
M:6-T+F=E="AM971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N
M92!O<B!N;W0@;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E='5R;B!.
M;VYE"B`@("`@("`@<F5T=7)N(&UE=&AO9"YW;W)K97)?8VQA<W,H8VQA<W-?
M='EP92YT96UP;&%T95]A<F=U;65N="@P*2D*"B,@6&UE=&AO9',@9F]R(&%S
M<V]C:6%T:79E(&-O;G1A:6YE<G,*"F-L87-S($%S<V]C:6%T:79E0V]N=&%I
M;F5R5V]R:V5R0F%S92AG9&(N>&UE=&AO9"Y8365T:&]D5V]R:V5R*3H*("`@
M(&1E9B!?7VEN:71?7RAS96QF+"!U;F]R9&5R960I.@H@("`@("`@('-E;&8N
M7W5N;W)D97)E9"`]('5N;W)D97)E9`H*("`@(&1E9B!N;V1E7V-O=6YT*'-E
M;&8L(&]B:BDZ"B`@("`@("`@:68@<V5L9BY?=6YO<F1E<F5D.@H@("`@("`@
M("`@("!R971U<FX@;V)J6R=?35]H)UU;)U]-7V5L96UE;G1?8V]U;G0G70H@
M("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')E='5R;B!O8FI;)U]-7W0G75LG
M7TU?:6UP;"==6R=?35]N;V1E7V-O=6YT)UT*"B`@("!D968@9V5T7V%R9U]T
M>7!E<RAS96QF*3H*("`@("`@("!R971U<FX@3F]N90H*8VQA<W,@07-S;V-I
M871I=F5#;VYT86EN97)%;7!T>5=O<FME<BA!<W-O8VEA=&EV94-O;G1A:6YE
M<E=O<FME<D)A<V4I.@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS96QF+"!O
M8FHI.@H@("`@("`@(')E='5R;B!G971?8F]O;%]T>7!E*"D*"B`@("!D968@
M7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@:6YT*'-E;&8N
M;F]D95]C;W5N="AO8FHI*2`]/2`P"@IC;&%S<R!!<W-O8VEA=&EV94-O;G1A
M:6YE<E-I>F57;W)K97(H07-S;V-I871I=F5#;VYT86EN97)7;W)K97)"87-E
M*3H*("`@(&1E9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@
M("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E9B!?7V-A;&Q?
M7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+FYO9&5?8V]U;G0H
M;V)J*0H*8VQA<W,@07-S;V-I871I=F5#;VYT86EN97)-971H;V1S36%T8VAE
M<BAG9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BDZ"B`@("!D968@7U]I;FET
M7U\H<V5L9BP@;F%M92DZ"B`@("`@("`@9V1B+GAM971H;V0N6$UE=&AO9$UA
M=&-H97(N7U]I;FET7U\H<V5L9BP*("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("!M871C:&5R7VYA;65?<')E9FEX("L@;F%M
M92D*("`@("`@("!S96QF+E]N86UE(#T@;F%M90H@("`@("`@('-E;&8N7VUE
M=&AO9%]D:6-T(#T@>PH@("`@("`@("`@("`G<VEZ92<Z($QI8E-T9$-X>%A-
M971H;V0H)W-I>F4G+"!!<W-O8VEA=&EV94-O;G1A:6YE<E-I>F57;W)K97(I
M+`H@("`@("`@("`@("`G96UP='DG.B!,:6)3=&1#>'A8365T:&]D*"=E;7!T
M>2<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@07-S
M;V-I871I=F5#;VYT86EN97)%;7!T>5=O<FME<BDL"B`@("`@("`@?0H@("`@
M("`@('-E;&8N;65T:&]D<R`](%MS96QF+E]M971H;V1?9&EC=%MM72!F;W(@
M;2!I;B!S96QF+E]M971H;V1?9&EC=%T*"B`@("!D968@;6%T8V@H<V5L9BP@
M8VQA<W-?='EP92P@;65T:&]D7VYA;64I.@H@("`@("`@(&EF(&YO="!R92YM
M871C:"@G7G-T9#HZ*%]?7&0K.CHI/R5S/"XJ/B0G("4@<V5L9BY?;F%M92P@
M8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U<FX@3F]N90H@("`@
M("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E="AM971H;V1?;F%M
M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N;W0@;65T:&]D+F5N
M86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@=6YO<F1E
M<F5D(#T@)W5N;W)D97)E9"<@:6X@<V5L9BY?;F%M90H@("`@("`@(')E='5R
M;B!M971H;V0N=V]R:V5R7V-L87-S*'5N;W)D97)E9"D*"B,@6&UE=&AO9',@
M9F]R('-T9#HZ=6YI<75E7W!T<@H*8VQA<W,@56YI<75E4'1R1V5T5V]R:V5R
M*&=D8BYX;65T:&]D+EA-971H;V17;W)K97(I.@H@("`@(DEM<&QE;65N=',@
M<W1D.CIU;FEQ=65?<'1R/%0^.CIG970H*2!A;F0@<W1D.CIU;FEQ=65?<'1R
M/%0^.CIO<&5R871O<BT^*"DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L
M96U?='EP92DZ"B`@("`@("`@<V5L9BY?:7-?87)R87D@/2!E;&5M7W1Y<&4N
M8V]D92`]/2!G9&(N5%E015]#3T1%7T%24D%9"B`@("`@("`@:68@<V5L9BY?
M:7-?87)R87DZ"B`@("`@("`@("`@('-E;&8N7V5L96U?='EP92`](&5L96U?
M='EP92YT87)G970H*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N
M7V5L96U?='EP92`](&5L96U?='EP90H*("`@(&1E9B!G971?87)G7W1Y<&5S
M*'-E;&8I.@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F(&=E=%]R97-U
M;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]E;&5M
M7W1Y<&4N<&]I;G1E<B@I"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M971H
M;V1?;F%M92DZ"B`@("`@("`@(F]P97)A=&]R+3X@:7,@;F]T('-U<'!O<G1E
M9"!F;W(@=6YI<75E7W!T<CQ46UT^(@H@("`@("`@(')E='5R;B!M971H;V1?
M;F%M92`]/2`G9V5T)R!O<B!N;W0@<V5L9BY?:7-?87)R87D*"B`@("!D968@
M7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@("!I;7!L7W1Y<&4@/2!O8FHN
M9&5R969E<F5N8V4H*2YT>7!E+F9I96QD<R@I6S!=+G1Y<&4N=&%G"B`@("`@
M("`@(R!#:&5C:R!F;W(@;F5W(&EM<&QE;65N=&%T:6]N<R!F:7)S=#H*("`@
M("`@("!I9B!R92YM871C:"@G7G-T9#HZ*%]?7&0K.CHI/U]?=6YI<5]P=')?
M*&1A=&%\:6UP;"D\+BH^)"<L(&EM<&Q?='EP92DZ"B`@("`@("`@("`@('1U
M<&QE7VUE;6)E<B`](&]B:ELG7TU?="==6R=?35]T)UT*("`@("`@("!E;&EF
M(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_='5P;&4\+BH^)"<L(&EM<&Q?
M='EP92DZ"B`@("`@("`@("`@('1U<&QE7VUE;6)E<B`](&]B:ELG7TU?="==
M"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@
M("!T=7!L95]I;7!L7W1Y<&4@/2!T=7!L95]M96UB97(N='EP92YF:65L9',H
M*5LP72YT>7!E(",@7U1U<&QE7VEM<&P*("`@("`@("!T=7!L95]H96%D7W1Y
M<&4@/2!T=7!L95]I;7!L7W1Y<&4N9FEE;&1S*"E;,5TN='EP92`@(",@7TAE
M861?8F%S90H@("`@("`@(&AE861?9FEE;&0@/2!T=7!L95]H96%D7W1Y<&4N
M9FEE;&1S*"E;,%T*("`@("`@("!I9B!H96%D7V9I96QD+FYA;64@/3T@)U]-
M7VAE861?:6UP;"<Z"B`@("`@("`@("`@(')E='5R;B!T=7!L95]M96UB97);
M)U]-7VAE861?:6UP;"=="B`@("`@("`@96QI9B!H96%D7V9I96QD+FES7V)A
M<V5?8VQA<W,Z"B`@("`@("`@("`@(')E='5R;B!T=7!L95]M96UB97(N8V%S
M="AH96%D7V9I96QD+G1Y<&4I"B`@("`@("`@96QS93H*("`@("`@("`@("`@
M<F5T=7)N($YO;F4*"F-L87-S(%5N:7%U95!T<D1E<F5F5V]R:V5R*%5N:7%U
M95!T<D=E=%=O<FME<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z.G5N:7%U95]P
M='(\5#XZ.F]P97)A=&]R*B@I(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!E
M;&5M7W1Y<&4I.@H@("`@("`@(%5N:7%U95!T<D=E=%=O<FME<BY?7VEN:71?
M7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E=%]R97-U;'1?='EP92AS
M96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!S96QF+E]E;&5M7W1Y<&4*"B`@
M("!D968@7W-U<'!O<G1S*'-E;&8L(&UE=&AO9%]N86UE*3H*("`@("`@("`B
M;W!E<F%T;W(J(&ES(&YO="!S=7!P;W)T960@9F]R('5N:7%U95]P='(\5%M=
M/B(*("`@("`@("!R971U<FX@;F]T('-E;&8N7VES7V%R<F%Y"@H@("`@9&5F
M(%]?8V%L;%]?*'-E;&8L(&]B:BDZ"B`@("`@("`@<F5T=7)N(%5N:7%U95!T
M<D=E=%=O<FME<BY?7V-A;&Q?7RAS96QF+"!O8FHI+F1E<F5F97)E;F-E*"D*
M"F-L87-S(%5N:7%U95!T<E-U8G-C<FEP=%=O<FME<BA5;FEQ=650=')'9717
M;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D.CIU;FEQ=65?<'1R/%0^.CIO
M<&5R871O<EM=*'-I>F5?="DB"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&5L
M96U?='EP92DZ"B`@("`@("`@56YI<75E4'1R1V5T5V]R:V5R+E]?:6YI=%]?
M*'-E;&8L(&5L96U?='EP92D*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF
M*3H*("`@("`@("!R971U<FX@9V5T7W-T9%]S:7IE7W1Y<&4H*0H*("`@(&1E
M9B!G971?<F5S=6QT7W1Y<&4H<V5L9BP@;V)J+"!I;F1E>"DZ"B`@("`@("`@
M<F5T=7)N('-E;&8N7V5L96U?='EP90H*("`@(&1E9B!?<W5P<&]R=',H<V5L
M9BP@;65T:&]D7VYA;64I.@H@("`@("`@(")O<&5R871O<EM=(&ES(&]N;'D@
M<W5P<&]R=&5D(&9O<B!U;FEQ=65?<'1R/%1;73XB"B`@("`@("`@<F5T=7)N
M('-E;&8N7VES7V%R<F%Y"@H@("`@9&5F(%]?8V%L;%]?*'-E;&8L(&]B:BP@
M:6YD97@I.@H@("`@("`@(')E='5R;B!5;FEQ=650=')'9717;W)K97(N7U]C
M86QL7U\H<V5L9BP@;V)J*5MI;F1E>%T*"F-L87-S(%5N:7%U95!T<DUE=&AO
M9'--871C:&5R*&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E
M9B!?7VEN:71?7RAS96QF*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D
M36%T8VAE<BY?7VEN:71?7RAS96QF+`H@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@(&UA=&-H97)?;F%M95]P<F5F:7@@*R`G
M=6YI<75E7W!T<B<I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@
M("`@("`@("`@("=G970G.B!,:6)3=&1#>'A8365T:&]D*"=G970G+"!5;FEQ
M=650=')'9717;W)K97(I+`H@("`@("`@("`@("`G;W!E<F%T;W(M/B<Z($QI
M8E-T9$-X>%A-971H;V0H)V]P97)A=&]R+3XG+"!5;FEQ=650=')'9717;W)K
M97(I+`H@("`@("`@("`@("`G;W!E<F%T;W(J)SH@3&EB4W1D0WAX6$UE=&AO
M9"@G;W!E<F%T;W(J)RP@56YI<75E4'1R1&5R9697;W)K97(I+`H@("`@("`@
M("`@("`G;W!E<F%T;W);72<Z($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R
M6UTG+"!5;FEQ=650=')3=6)S8W)I<'17;W)K97(I+`H@("`@("`@('T*("`@
M("`@("!S96QF+FUE=&AO9',@/2!;<V5L9BY?;65T:&]D7V1I8W1;;5T@9F]R
M(&T@:6X@<V5L9BY?;65T:&]D7V1I8W1="@H@("`@9&5F(&UA=&-H*'-E;&8L
M(&-L87-S7W1Y<&4L(&UE=&AO9%]N86UE*3H*("`@("`@("!I9B!N;W0@<F4N
M;6%T8V@H)UYS=&0Z.BA?7UQD*SHZ*3]U;FEQ=65?<'1R/"XJ/B0G+"!C;&%S
M<U]T>7!E+G1A9RDZ"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@
M;65T:&]D(#T@<V5L9BY?;65T:&]D7V1I8W0N9V5T*&UE=&AO9%]N86UE*0H@
M("`@("`@(&EF(&UE=&AO9"!I<R!.;VYE(&]R(&YO="!M971H;V0N96YA8FQE
M9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*("`@("`@("!W;W)K97(@/2!M
M971H;V0N=V]R:V5R7V-L87-S*&-L87-S7W1Y<&4N=&5M<&QA=&5?87)G=6UE
M;G0H,"DI"B`@("`@("`@:68@=V]R:V5R+E]S=7!P;W)T<RAM971H;V1?;F%M
M92DZ"B`@("`@("`@("`@(')E='5R;B!W;W)K97(*("`@("`@("!R971U<FX@
M3F]N90H*(R!8;65T:&]D<R!F;W(@<W1D.CIS:&%R961?<'1R"@IC;&%S<R!3
M:&%R9610=')'9717;W)K97(H9V1B+GAM971H;V0N6$UE=&AO9%=O<FME<BDZ
M"B`@("`B26UP;&5M96YT<R!S=&0Z.G-H87)E9%]P='(\5#XZ.F=E="@I(&%N
M9"!S=&0Z.G-H87)E9%]P='(\5#XZ.F]P97)A=&]R+3XH*2(*"B`@("!D968@
M7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@("`@("!S96QF+E]I<U]A
M<G)A>2`](&5L96U?='EP92YC;V1E(#T](&=D8BY465!%7T-/1$5?05)205D*
M("`@("`@("!I9B!S96QF+E]I<U]A<G)A>3H*("`@("`@("`@("`@<V5L9BY?
M96QE;5]T>7!E(#T@96QE;5]T>7!E+G1A<F=E="@I"B`@("`@("`@96QS93H*
M("`@("`@("`@("`@<V5L9BY?96QE;5]T>7!E(#T@96QE;5]T>7!E"@H@("`@
M9&5F(&=E=%]A<F=?='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N($YO;F4*
M"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BDZ"B`@("`@("`@
M<F5T=7)N('-E;&8N7V5L96U?='EP92YP;VEN=&5R*"D*"B`@("!D968@7W-U
M<'!O<G1S*'-E;&8L(&UE=&AO9%]N86UE*3H*("`@("`@("`B;W!E<F%T;W(M
M/B!I<R!N;W0@<W5P<&]R=&5D(&9O<B!S:&%R961?<'1R/%1;73XB"B`@("`@
M("`@<F5T=7)N(&UE=&AO9%]N86UE(#T]("=G970G(&]R(&YO="!S96QF+E]I
M<U]A<G)A>0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@
M(')E='5R;B!O8FI;)U]-7W!T<B=="@IC;&%S<R!3:&%R9610=')$97)E9E=O
M<FME<BA3:&%R9610=')'9717;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D
M.CIS:&%R961?<'1R/%0^.CIO<&5R871O<BHH*2(*"B`@("!D968@7U]I;FET
M7U\H<V5L9BP@96QE;5]T>7!E*3H*("`@("`@("!3:&%R9610=')'9717;W)K
M97(N7U]I;FET7U\H<V5L9BP@96QE;5]T>7!E*0H*("`@(&1E9B!G971?<F5S
M=6QT7W1Y<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@<V5L9BY?96QE
M;5]T>7!E"@H@("`@9&5F(%]S=7!P;W)T<RAS96QF+"!M971H;V1?;F%M92DZ
M"B`@("`@("`@(F]P97)A=&]R*B!I<R!N;W0@<W5P<&]R=&5D(&9O<B!S:&%R
M961?<'1R/%1;73XB"B`@("`@("`@<F5T=7)N(&YO="!S96QF+E]I<U]A<G)A
M>0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@("`@(')E='5R
M;B!3:&%R9610=')'9717;W)K97(N7U]C86QL7U\H<V5L9BP@;V)J*2YD97)E
M9F5R96YC92@I"@IC;&%S<R!3:&%R9610=')3=6)S8W)I<'17;W)K97(H4VAA
M<F5D4'1R1V5T5V]R:V5R*3H*("`@("));7!L96UE;G1S('-T9#HZ<VAA<F5D
M7W!T<CQ4/CHZ;W!E<F%T;W);72AS:7IE7W0I(@H*("`@(&1E9B!?7VEN:71?
M7RAS96QF+"!E;&5M7W1Y<&4I.@H@("`@("`@(%-H87)E9%!T<D=E=%=O<FME
M<BY?7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E=%]A<F=?
M='EP97,H<V5L9BDZ"B`@("`@("`@<F5T=7)N(&=E=%]S=&1?<VEZ95]T>7!E
M*"D*"B`@("!D968@9V5T7W)E<W5L=%]T>7!E*'-E;&8L(&]B:BP@:6YD97@I
M.@H@("`@("`@(')E='5R;B!S96QF+E]E;&5M7W1Y<&4*"B`@("!D968@7W-U
M<'!O<G1S*'-E;&8L(&UE=&AO9%]N86UE*3H*("`@("`@("`B;W!E<F%T;W);
M72!I<R!O;FQY('-U<'!O<G1E9"!F;W(@<VAA<F5D7W!T<CQ46UT^(@H@("`@
M("`@(')E='5R;B!S96QF+E]I<U]A<G)A>0H*("`@(&1E9B!?7V-A;&Q?7RAS
M96QF+"!O8FHL(&EN9&5X*3H*("`@("`@("`C($-H96-K(&)O=6YD<R!I9B!?
M96QE;5]T>7!E(&ES(&%N(&%R<F%Y(&]F(&MN;W=N(&)O=6YD"B`@("`@("`@
M;2`](')E+FUA=&-H*"<N*EQ;*%QD*RE=)"<L('-T<BAS96QF+E]E;&5M7W1Y
M<&4I*0H@("`@("`@(&EF(&T@86YD(&EN9&5X(#X](&EN="AM+F=R;W5P*#$I
M*3H*("`@("`@("`@("`@<F%I<V4@26YD97A%<G)O<B@G<VAA<F5D7W!T<CPE
M<SX@:6YD97@@(B5D(B!S:&]U;&0@;F]T(&)E(#X]("5D+B<@)0H@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("AS96QF+E]E;&5M7W1Y<&4L(&EN="AI
M;F1E>"DL(&EN="AM+F=R;W5P*#$I*2DI"B`@("`@("`@<F5T=7)N(%-H87)E
M9%!T<D=E=%=O<FME<BY?7V-A;&Q?7RAS96QF+"!O8FHI6VEN9&5X70H*8VQA
M<W,@4VAA<F5D4'1R57-E0V]U;G17;W)K97(H9V1B+GAM971H;V0N6$UE=&AO
M9%=O<FME<BDZ"B`@("`B26UP;&5M96YT<R!S=&0Z.G-H87)E9%]P='(\5#XZ
M.G5S95]C;W5N="@I(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!E;&5M7W1Y
M<&4I.@H@("`@("`@(%-H87)E9%!T<E5S94-O=6YT5V]R:V5R+E]?:6YI=%]?
M*'-E;&8L(&5L96U?='EP92D*"B`@("!D968@9V5T7V%R9U]T>7!E<RAS96QF
M*3H*("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!G971?<F5S=6QT7W1Y
M<&4H<V5L9BP@;V)J*3H*("`@("`@("!R971U<FX@9V1B+FQO;VMU<%]T>7!E
M*"=L;VYG)RD*"B`@("!D968@7U]C86QL7U\H<V5L9BP@;V)J*3H*("`@("`@
M("!R969C;W5N=',@/2!;)U]-7W)E9F-O=6YT)UU;)U]-7W!I)UT*("`@("`@
M("!R971U<FX@<F5F8V]U;G1S6R=?35]U<V5?8V]U;G0G72!I9B!R969C;W5N
M=',@96QS92`P"@IC;&%S<R!3:&%R9610=')5;FEQ=657;W)K97(H4VAA<F5D
M4'1R57-E0V]U;G17;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D.CIS:&%R
M961?<'1R/%0^.CIU;FEQ=64H*2(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@
M96QE;5]T>7!E*3H*("`@("`@("!3:&%R9610=')5<V5#;W5N=%=O<FME<BY?
M7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E=%]R97-U;'1?
M='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G9&(N;&]O:W5P7W1Y
M<&4H)V)O;VPG*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@("`@
M("`@(')E='5R;B!3:&%R9610=')5<V5#;W5N=%=O<FME<BY?7V-A;&Q?7RAS
M96QF+"!O8FHI(#T](#$*"F-L87-S(%-H87)E9%!T<DUE=&AO9'--871C:&5R
M*&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E9B!?7VEN:71?
M7RAS96QF*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE<BY?
M7VEN:71?7RAS96QF+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@(&UA=&-H97)?;F%M95]P<F5F:7@@*R`G<VAA<F5D7W!T
M<B<I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@("`@("`@("`@
M("=G970G.B!,:6)3=&1#>'A8365T:&]D*"=G970G+"!3:&%R9610=')'9717
M;W)K97(I+`H@("`@("`@("`@("`G;W!E<F%T;W(M/B<Z($QI8E-T9$-X>%A-
M971H;V0H)V]P97)A=&]R+3XG+"!3:&%R9610=')'9717;W)K97(I+`H@("`@
M("`@("`@("`G;W!E<F%T;W(J)SH@3&EB4W1D0WAX6$UE=&AO9"@G;W!E<F%T
M;W(J)RP@4VAA<F5D4'1R1&5R9697;W)K97(I+`H@("`@("`@("`@("`G;W!E
M<F%T;W);72<Z($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R6UTG+"!3:&%R
M9610=')3=6)S8W)I<'17;W)K97(I+`H@("`@("`@("`@("`G=7-E7V-O=6YT
M)SH@3&EB4W1D0WAX6$UE=&AO9"@G=7-E7V-O=6YT)RP@4VAA<F5D4'1R57-E
M0V]U;G17;W)K97(I+`H@("`@("`@("`@("`G=6YI<75E)SH@3&EB4W1D0WAX
M6$UE=&AO9"@G=6YI<75E)RP@4VAA<F5D4'1R56YI<75E5V]R:V5R*2P*("`@
M("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE=&AO9%]D
M:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T70H*("`@(&1E9B!M
M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@("`@("`@
M:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_<VAA<F5D7W!T<CPN
M*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U<FX@3F]N
M90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E="AM971H
M;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N;W0@;65T
M:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@
M=V]R:V5R(#T@;65T:&]D+G=O<FME<E]C;&%S<RAC;&%S<U]T>7!E+G1E;7!L
M871E7V%R9W5M96YT*#`I*0H@("`@("`@(&EF('=O<FME<BY?<W5P<&]R=',H
M;65T:&]D7VYA;64I.@H@("`@("`@("`@("!R971U<FX@=V]R:V5R"B`@("`@
M("`@<F5T=7)N($YO;F4*#`ID968@<F5G:7-T97)?;&EB<W1D8WAX7WAM971H
M;V1S*&QO8W5S*3H*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?
M;6%T8VAE<BAL;V-U<RP@07)R87E-971H;V1S36%T8VAE<B@I*0H@("`@9V1B
M+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*&QO8W5S+"!&;W)W
M87)D3&ES=$UE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO9"YR96=I
M<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L($1E<75E365T:&]D<TUA=&-H
M97(H*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE
M<BAL;V-U<RP@3&ES=$UE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO
M9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L(%9E8W1O<DUE=&AO
M9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D
M7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N=&%I;F5R
M365T:&]D<TUA=&-H97(H)W-E="<I*0H@("`@9V1B+GAM971H;V0N<F5G:7-T
M97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO8W5S+"!!<W-O8VEA=&EV
M94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=M87`G*2D*("`@(&=D8BYX;65T
M:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE<B@*("`@("`@("!L;V-U<RP@
M07-S;V-I871I=F5#;VYT86EN97)-971H;V1S36%T8VAE<B@G;75L=&ES970G
M*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE<B@*
M("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H;V1S36%T
M8VAE<B@G;75L=&EM87`G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM
M971H;V1?;6%T8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT
M86EN97)-971H;V1S36%T8VAE<B@G=6YO<F1E<F5D7W-E="<I*0H@("`@9V1B
M+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO
M8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=U;F]R
M9&5R961?;6%P)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T:&]D
M7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N=&%I;F5R
M365T:&]D<TUA=&-H97(H)W5N;W)D97)E9%]M=6QT:7-E="<I*0H@("`@9V1B
M+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO
M8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=U;F]R
M9&5R961?;75L=&EM87`G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM
M971H;V1?;6%T8VAE<BAL;V-U<RP@56YI<75E4'1R365T:&]D<TUA=&-H97(H
M*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE<BAL
M;V-U<RP@4VAA<F5D4'1R365T:&]D<TUA=&-H97(H*2D*````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```N+W!Y=&AO;B]L:6)S=&1C>'@O=C8O7U]I;FET7U\N<'D`````````````
M````````````````````````````````````````````````````````````
M````````````````,#`P,#8T-``P,#`R,#`R`#`P,#`Q-#0`,#`P,#`P,#(R
M,3$`,3,U,30P,S8U,3$`,#$V-3,P`"`P````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````'5S=&%R("``9FIA
M<F1O;@````````````````````````````````!U<V5R<P``````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````",@0V]P>7)I9VAT("A#*2`R,#$T+3(P,3D@
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
M9&(*"B,@3&]A9"!T:&4@>&UE=&AO9',@:68@1T1"('-U<'!O<G1S('1H96TN
M"F1E9B!G9&)?:&%S7WAM971H;V1S*"DZ"B`@("!T<GDZ"B`@("`@("`@:6UP
M;W)T(&=D8BYX;65T:&]D"B`@("`@("`@<F5T=7)N(%1R=64*("`@(&5X8V5P
M="!);7!O<G1%<G)O<CH*("`@("`@("!R971U<FX@1F%L<V4*"F1E9B!R96=I
M<W1E<E]L:6)S=&1C>'A?<')I;G1E<G,H;V)J*3H*("`@(",@3&]A9"!T:&4@
M<')E='1Y+7!R:6YT97)S+@H@("`@9G)O;2`N<')I;G1E<G,@:6UP;W)T(')E
M9VES=&5R7VQI8G-T9&-X>%]P<FEN=&5R<PH@("`@<F5G:7-T97)?;&EB<W1D
M8WAX7W!R:6YT97)S*&]B:BD*"B`@("!I9B!G9&)?:&%S7WAM971H;V1S*"DZ
M"B`@("`@("`@9G)O;2`N>&UE=&AO9',@:6UP;W)T(')E9VES=&5R7VQI8G-T
M9&-X>%]X;65T:&]D<PH@("`@("`@(')E9VES=&5R7VQI8G-T9&-X>%]X;65T
M:&]D<RAO8FHI"@``````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````"XO<'ET:&]N+VQI8G-T9&-X>"]V
M-B]P<FEN=&5R<RYP>0``````````````````````````````````````````
M```````````````````````````````````````````````P,#`P-C0T`#`P
M,#(P,#(`,#`P,#$T-``P,#`P,#(Q-#8V-@`Q,S4Q-#`S-C4Q,0`P,38V-C(`
M(#``````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````=7-T87(@(`!F:F%R9&]N````````````````````````
M`````````'5S97)S````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````(R!0
M<F5T='DM<')I;G1E<G,@9F]R(&QI8G-T9&,K*RX*"B,@0V]P>7)I9VAT("A#
M*2`R,#`X+3(P,3D@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N+"!);F,N"@HC
M(%1H:7,@<')O9W)A;2!I<R!F<F5E('-O9G1W87)E.R!Y;W4@8V%N(')E9&ES
M=')I8G5T92!I="!A;F0O;W(@;6]D:69Y"B,@:70@=6YD97(@=&AE('1E<FUS
M(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS92!A<R!P=6)L:7-H
M960@8GD*(R!T:&4@1G)E92!3;V9T=V%R92!&;W5N9&%T:6]N.R!E:71H97(@
M=F5R<VEO;B`S(&]F('1H92!,:6-E;G-E+"!O<@HC("AA="!Y;W5R(&]P=&EO
M;BD@86YY(&QA=&5R('9E<G-I;VXN"B,*(R!4:&ES('!R;V=R86T@:7,@9&ES
M=')I8G5T960@:6X@=&AE(&AO<&4@=&AA="!I="!W:6QL(&)E('5S969U;"P*
M(R!B=70@5TE42$]55"!!3ED@5T%24D%.5%D[('=I=&AO=70@979E;B!T:&4@
M:6UP;&EE9"!W87)R86YT>2!O9@HC($U%4D-(04Y404))3$E462!O<B!&251.
M15-3($9/4B!!(%!!4E1)0U5,05(@4%524$]312X@(%-E92!T:&4*(R!'3E4@
M1V5N97)A;"!0=6)L:6,@3&EC96YS92!F;W(@;6]R92!D971A:6QS+@HC"B,@
M66]U('-H;W5L9"!H879E(')E8V5I=F5D(&$@8V]P>2!O9B!T:&4@1TY5($=E
M;F5R86P@4'5B;&EC($QI8V5N<V4*(R!A;&]N9R!W:71H('1H:7,@<')O9W)A
M;2X@($EF(&YO="P@<V5E(#QH='1P.B\O=W=W+F=N=2YO<F<O;&EC96YS97,O
M/BX*"FEM<&]R="!G9&(*:6UP;W)T(&ET97)T;V]L<PII;7!O<G0@<F4*:6UP
M;W)T('-Y<PH*(R,C(%!Y=&AO;B`R("L@4'ET:&]N(#,@8V]M<&%T:6)I;&ET
M>2!C;V1E"@HC(%)E<V]U<F-E<R!A8F]U="!C;VUP871I8FEL:71Y.@HC"B,@
M("H@/&AT='`Z+R]P>71H;VYH;W-T960N;W)G+W-I>"\^.B!$;V-U;65N=&%T
M:6]N(&]F('1H92`B<VEX(B!M;V1U;&4*"B,@1DE8344Z(%1H92!H86YD;&EN
M9R!O9B!E+F<N('-T9#HZ8F%S:6-?<W1R:6YG("AA="!L96%S="!O;B!C:&%R
M*0HC('!R;V)A8FQY(&YE961S('5P9&%T:6YG('1O('=O<FL@=VET:"!0>71H
M;VX@,R=S(&YE=R!S=')I;F<@<G5L97,N"B,*(R!);B!P87)T:6-U;&%R+"!0
M>71H;VX@,R!H87,@82!S97!A<F%T92!T>7!E("AC86QL960@8GET92D@9F]R
M"B,@8GET97-T<FEN9W,L(&%N9"!A('-P96-I86P@8B(B('-Y;G1A>"!F;W(@
M=&AE(&)Y=&4@;&ET97)A;',[('1H92!O;&0*(R!S='(H*2!T>7!E(&AA<R!B
M965N(')E9&5F:6YE9"!T;R!A;'=A>7,@<W1O<F4@56YI8V]D92!T97AT+@HC
M"B,@5V4@<')O8F%B;'D@8V%N)W0@9&\@;75C:"!A8F]U="!T:&ES('5N=&EL
M('1H:7,@1T1"(%!2(&ES(&%D9')E<W-E9#H*(R`\:'1T<',Z+R]S;W5R8V5W
M87)E+F]R9R]B=6=Z:6QL82]S:&]W7V)U9RYC9VD_:60],3<Q,S@^"@II9B!S
M>7,N=F5R<VEO;E]I;F9O6S!=(#X@,CH*("`@(",C(R!0>71H;VX@,R!S='5F
M9@H@("`@271E<F%T;W(@/2!O8FIE8W0*("`@(",@4'ET:&]N(#,@9F]L9',@
M=&AE<V4@:6YT;R!T:&4@;F]R;6%L(&9U;F-T:6]N<RX*("`@(&EM87`@/2!M
M87`*("`@(&EZ:7`@/2!Z:7`*("`@(",@06QS;RP@:6YT('-U8G-U;65S(&QO
M;F<*("`@(&QO;F<@/2!I;G0*96QS93H*("`@(",C(R!0>71H;VX@,B!S='5F
M9@H@("`@8VQA<W,@271E<F%T;W(Z"B`@("`@("`@(B(B0V]M<&%T:6)I;&ET
M>2!M:7AI;B!F;W(@:71E<F%T;W)S"@H@("`@("`@($EN<W1E860@;V8@=W)I
M=&EN9R!N97AT*"D@;65T:&]D<R!F;W(@:71E<F%T;W)S+"!W<FET90H@("`@
M("`@(%]?;F5X=%]?*"D@;65T:&]D<R!A;F0@=7-E('1H:7,@;6EX:6X@=&\@
M;6%K92!T:&5M('=O<FL@:6X*("`@("`@("!0>71H;VX@,B!A<R!W96QL(&%S
M(%!Y=&AO;B`S+@H*("`@("`@("!)9&5A('-T;VQE;B!F<F]M('1H92`B<VEX
M(B!D;V-U;65N=&%T:6]N.@H@("`@("`@(#QH='1P.B\O<'ET:&]N:&]S=&5D
M+F]R9R]S:7@O(W-I>"Y)=&5R871O<CX*("`@("`@("`B(B(*"B`@("`@("`@
M9&5F(&YE>'0H<V5L9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF+E]?;F5X
M=%]?*"D*"B`@("`C($EN(%!Y=&AO;B`R+"!W92!S=&EL;"!N965D('1H97-E
M(&9R;VT@:71E<G1O;VQS"B`@("!F<F]M(&ET97)T;V]L<R!I;7!O<G0@:6UA
M<"P@:7II<`H*(R!4<GD@=&\@=7-E('1H92!N97<M<W1Y;&4@<')E='1Y+7!R
M:6YT:6YG(&EF(&%V86EL86)L92X*7W5S95]G9&)?<'`@/2!4<G5E"G1R>3H*
M("`@(&EM<&]R="!G9&(N<')I;G1I;F<*97AC97!T($EM<&]R=$5R<F]R.@H@
M("`@7W5S95]G9&)?<'`@/2!&86QS90H*(R!4<GD@=&\@:6YS=&%L;"!T>7!E
M+7!R:6YT97)S+@I?=7-E7W1Y<&5?<')I;G1I;F<@/2!&86QS90IT<GDZ"B`@
M("!I;7!O<G0@9V1B+G1Y<&5S"B`@("!I9B!H87-A='1R*&=D8BYT>7!E<RP@
M)U1Y<&50<FEN=&5R)RDZ"B`@("`@("`@7W5S95]T>7!E7W!R:6YT:6YG(#T@
M5')U90IE>&-E<'0@26UP;W)T17)R;W(Z"B`@("!P87-S"@HC(%-T87)T:6YG
M('=I=&@@=&AE('1Y<&4@3U))1RP@<V5A<F-H(&9O<B!T:&4@;65M8F5R('1Y
M<&4@3D%-12X@(%1H:7,*(R!H86YD;&5S('-E87)C:&EN9R!U<'=A<F0@=&AR
M;W5G:"!S=7!E<F-L87-S97,N("!4:&ES(&ES(&YE961E9"!T;PHC('=O<FL@
M87)O=6YD(&AT='`Z+R]S;W5R8V5W87)E+F]R9R]B=6=Z:6QL82]S:&]W7V)U
M9RYC9VD_:60],3,V,34N"F1E9B!F:6YD7W1Y<&4H;W)I9RP@;F%M92DZ"B`@
M("!T>7`@/2!O<FEG+G-T<FEP7W1Y<&5D969S*"D*("`@('=H:6QE(%1R=64Z
M"B`@("`@("`@(R!3=')I<"!C=BUQ=6%L:69I97)S+B`@4%(@-C<T-#`N"B`@
M("`@("`@<V5A<F-H(#T@)R5S.CHE<R<@)2`H='EP+G5N<75A;&EF:65D*"DL
M(&YA;64I"B`@("`@("`@=')Y.@H@("`@("`@("`@("!R971U<FX@9V1B+FQO
M;VMU<%]T>7!E*'-E87)C:"D*("`@("`@("!E>&-E<'0@4G5N=&EM945R<F]R
M.@H@("`@("`@("`@("!P87-S"B`@("`@("`@(R!4:&4@='EP92!W87,@;F]T
M(&9O=6YD+"!S;R!T<GD@=&AE('-U<&5R8VQA<W,N("!792!O;FQY(&YE960*
M("`@("`@("`C('1O(&-H96-K('1H92!F:7)S="!S=7!E<F-L87-S+"!S;R!W
M92!D;VXG="!B;W1H97(@=VET:`H@("`@("`@(",@86YY=&AI;F<@9F%N8VEE
M<B!H97)E+@H@("`@("`@(&9I96QD(#T@='EP+F9I96QD<R@I6S!="B`@("`@
M("`@:68@;F]T(&9I96QD+FES7V)A<V5?8VQA<W,Z"B`@("`@("`@("`@(')A
M:7-E(%9A;'5E17)R;W(H(D-A;FYO="!F:6YD('1Y<&4@)7,Z.B5S(B`E("AS
M='(H;W)I9RDL(&YA;64I*0H@("`@("`@('1Y<"`](&9I96QD+G1Y<&4*"E]V
M97)S:6]N961?;F%M97-P86-E(#T@)U]?.#HZ)PH*9&5F(&ES7W-P96-I86QI
M>F%T:6]N7V]F*'@L('1E;7!L871E7VYA;64I.@H@("`@(E1E<W0@:68@82!T
M>7!E(&ES(&$@9VEV96X@=&5M<&QA=&4@:6YS=&%N=&EA=&EO;BXB"B`@("!G
M;&]B86P@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@(&EF('1Y<&4H>"D@:7,@
M9V1B+E1Y<&4Z"B`@("`@("`@>"`]('@N=&%G"B`@("!I9B!?=F5R<VEO;F5D
M7VYA;65S<&%C93H*("`@("`@("!R971U<FX@<F4N;6%T8V@H)UYS=&0Z.B@E
M<RD_)7,\+BH^)"<@)2`H7W9E<G-I;VYE9%]N86UE<W!A8V4L('1E;7!L871E
M7VYA;64I+"!X*2!I<R!N;W0@3F]N90H@("`@<F5T=7)N(')E+FUA=&-H*"=>
M<W1D.CHE<SPN*CXD)R`E('1E;7!L871E7VYA;64L('@I(&ES(&YO="!.;VYE
M"@ID968@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92DZ"B`@
M("!G;&]B86P@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@(&EF(%]V97)S:6]N
M961?;F%M97-P86-E.@H@("`@("`@(')E='5R;B!T>7!E;F%M92YR97!L86-E
M*%]V97)S:6]N961?;F%M97-P86-E+"`G)RD*("`@(')E='5R;B!T>7!E;F%M
M90H*9&5F('-T<FEP7VEN;&EN95]N86UE<W!A8V5S*'1Y<&5?<W1R*3H*("`@
M(")296UO=F4@:VYO=VX@:6YL:6YE(&YA;65S<&%C97,@9G)O;2!T:&4@8V%N
M;VYI8V%L(&YA;64@;V8@82!T>7!E+B(*("`@('1Y<&5?<W1R(#T@<W1R:7!?
M=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E7W-T<BD*("`@('1Y<&5?<W1R(#T@
M='EP95]S='(N<F5P;&%C92@G<W1D.CI?7V-X>#$Q.CHG+"`G<W1D.CHG*0H@
M("`@97AP=%]N<R`]("=S=&0Z.F5X<&5R:6UE;G1A;#HZ)PH@("`@9F]R(&QF
M='-?;G,@:6X@*"=F=6YD86UE;G1A;'-?=C$G+"`G9G5N9&%M96YT86QS7W8R
M)RDZ"B`@("`@("`@='EP95]S='(@/2!T>7!E7W-T<BYR97!L86-E*&5X<'1?
M;G,K;&9T<U]N<RLG.CHG+"!E>'!T7VYS*0H@("`@9G-?;G,@/2!E>'!T7VYS
M("L@)V9I;&5S>7-T96TZ.B<*("`@('1Y<&5?<W1R(#T@='EP95]S='(N<F5P
M;&%C92AF<U]N<RLG=C$Z.B<L(&9S7VYS*0H@("`@<F5T=7)N('1Y<&5?<W1R
M"@ID968@9V5T7W1E;7!L871E7V%R9U]L:7-T*'1Y<&5?;V)J*3H*("`@(")2
M971U<FX@82!T>7!E)W,@=&5M<&QA=&4@87)G=6UE;G1S(&%S(&$@;&ES="(*
M("`@(&X@/2`P"B`@("!T96UP;&%T95]A<F=S(#T@6UT*("`@('=H:6QE(%1R
M=64Z"B`@("`@("`@=')Y.@H@("`@("`@("`@("!T96UP;&%T95]A<F=S+F%P
M<&5N9"AT>7!E7V]B:BYT96UP;&%T95]A<F=U;65N="AN*2D*("`@("`@("!E
M>&-E<'0Z"B`@("`@("`@("`@(')E='5R;B!T96UP;&%T95]A<F=S"B`@("`@
M("`@;B`K/2`Q"@IC;&%S<R!3;6%R=%!T<DET97)A=&]R*$ET97)A=&]R*3H*
M("`@(")!;B!I=&5R871O<B!F;W(@<VUA<G0@<&]I;G1E<B!T>7!E<R!W:71H
M(&$@<VEN9VQE("=C:&EL9"<@=F%L=64B"@H@("`@9&5F(%]?:6YI=%]?*'-E
M;&8L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@7U]I
M=&5R7U\H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8*"B`@("!D968@7U]N
M97AT7U\H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYV86P@:7,@3F]N93H*("`@
M("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@('-E;&8N=F%L
M+"!V86P@/2!.;VYE+"!S96QF+G9A;`H@("`@("`@(')E='5R;B`H)V=E="@I
M)RP@=F%L*0H*8VQA<W,@4VAA<F5D4&]I;G1E<E!R:6YT97(Z"B`@("`B4')I
M;G0@82!S:&%R961?<'1R(&]R('=E86M?<'1R(@H*("`@(&1E9B!?7VEN:71?
M7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M
M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@
M("`@<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF+G!O:6YT97(@/2!V86Q;
M)U]-7W!T<B=="@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!R
M971U<FX@4VUA<G10='))=&5R871O<BAS96QF+G!O:6YT97(I"@H@("`@9&5F
M('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@<W1A=&4@/2`G96UP='DG"B`@
M("`@("`@<F5F8V]U;G1S(#T@<V5L9BYV86Q;)U]-7W)E9F-O=6YT)UU;)U]-
M7W!I)UT*("`@("`@("!I9B!R969C;W5N=',@(3T@,#H*("`@("`@("`@("`@
M=7-E8V]U;G0@/2!R969C;W5N='-;)U]-7W5S95]C;W5N="=="B`@("`@("`@
M("`@('=E86MC;W5N="`](')E9F-O=6YT<ULG7TU?=V5A:U]C;W5N="=="B`@
M("`@("`@("`@(&EF('5S96-O=6YT(#T](#`Z"B`@("`@("`@("`@("`@("!S
M=&%T92`]("=E>'!I<F5D+"!W96%K(&-O=6YT("5D)R`E('=E86MC;W5N=`H@
M("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@<W1A=&4@/2`G=7-E
M(&-O=6YT("5D+"!W96%K(&-O=6YT("5D)R`E("AU<V5C;W5N="P@=V5A:V-O
M=6YT("T@,2D*("`@("`@("!R971U<FX@)R5S/"5S/B`H)7,I)R`E("AS96QF
M+G1Y<&5N86UE+"!S='(H<V5L9BYV86PN='EP92YT96UP;&%T95]A<F=U;65N
M="@P*2DL('-T871E*0H*8VQA<W,@56YI<75E4&]I;G1E<E!R:6YT97(Z"B`@
M("`B4')I;G0@82!U;FEQ=65?<'1R(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L
M9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*("`@
M("`@("!I;7!L7W1Y<&4@/2!V86PN='EP92YF:65L9',H*5LP72YT>7!E+G1A
M9PH@("`@("`@(",@0VAE8VL@9F]R(&YE=R!I;7!L96UE;G1A=&EO;G,@9FER
M<W0Z"B`@("`@("`@:68@:7-?<W!E8VEA;&EZ871I;VY?;V8H:6UP;%]T>7!E
M+"`G7U]U;FEQ7W!T<E]D871A)RD@7`H@("`@("`@("`@("!O<B!I<U]S<&5C
M:6%L:7IA=&EO;E]O9BAI;7!L7W1Y<&4L("=?7W5N:7%?<'1R7VEM<&PG*3H*
M("`@("`@("`@("`@='5P;&5?;65M8F5R(#T@=F%L6R=?35]T)UU;)U]-7W0G
M70H@("`@("`@(&5L:68@:7-?<W!E8VEA;&EZ871I;VY?;V8H:6UP;%]T>7!E
M+"`G='5P;&4G*3H*("`@("`@("`@("`@='5P;&5?;65M8F5R(#T@=F%L6R=?
M35]T)UT*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R86ES92!686QU945R
M<F]R*")5;G-U<'!O<G1E9"!I;7!L96UE;G1A=&EO;B!F;W(@=6YI<75E7W!T
M<CH@)7,B("4@:6UP;%]T>7!E*0H@("`@("`@('1U<&QE7VEM<&Q?='EP92`]
M('1U<&QE7VUE;6)E<BYT>7!E+F9I96QD<R@I6S!=+G1Y<&4@(R!?5'5P;&5?
M:6UP;`H@("`@("`@('1U<&QE7VAE861?='EP92`]('1U<&QE7VEM<&Q?='EP
M92YF:65L9',H*5LQ72YT>7!E("`@(R!?2&5A9%]B87-E"B`@("`@("`@:&5A
M9%]F:65L9"`]('1U<&QE7VAE861?='EP92YF:65L9',H*5LP70H@("`@("`@
M(&EF(&AE861?9FEE;&0N;F%M92`]/2`G7TU?:&5A9%]I;7!L)SH*("`@("`@
M("`@("`@<V5L9BYP;VEN=&5R(#T@='5P;&5?;65M8F5R6R=?35]H96%D7VEM
M<&PG70H@("`@("`@(&5L:68@:&5A9%]F:65L9"YI<U]B87-E7V-L87-S.@H@
M("`@("`@("`@("!S96QF+G!O:6YT97(@/2!T=7!L95]M96UB97(N8V%S="AH
M96%D7V9I96QD+G1Y<&4I"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F%I
M<V4@5F%L=65%<G)O<B@B56YS=7!P;W)T960@:6UP;&5M96YT871I;VX@9F]R
M('1U<&QE(&EN('5N:7%U95]P='(Z("5S(B`E(&EM<&Q?='EP92D*"B`@("!D
M968@8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(')E='5R;B!3;6%R=%!T<DET
M97)A=&]R*'-E;&8N<&]I;G1E<BD*"B`@("!D968@=&]?<W1R:6YG("AS96QF
M*3H*("`@("`@("!R971U<FX@*"=S=&0Z.G5N:7%U95]P='(\)7,^)R`E("AS
M='(H<V5L9BYV86PN='EP92YT96UP;&%T95]A<F=U;65N="@P*2DI*0H*9&5F
M(&=E=%]V86QU95]F<F]M7V%L:6=N961?;65M8G5F*&)U9BP@=F%L='EP92DZ
M"B`@("`B(B)2971U<FYS('1H92!V86QU92!H96QD(&EN(&$@7U]G;G5?8WAX
M.CI?7V%L:6=N961?;65M8G5F+B(B(@H@("`@<F5T=7)N(&)U9ELG7TU?<W1O
M<F%G92==+F%D9')E<W,N8V%S="AV86QT>7!E+G!O:6YT97(H*2DN9&5R969E
M<F5N8V4H*0H*9&5F(&=E=%]V86QU95]F<F]M7VQI<W1?;F]D92AN;V1E*3H*
M("`@("(B(E)E='5R;G,@=&AE('9A;'5E(&AE;&0@:6X@86X@7TQI<W1?;F]D
M93Q?5F%L/B(B(@H@("`@=')Y.@H@("`@("`@(&UE;6)E<B`](&YO9&4N='EP
M92YF:65L9',H*5LQ72YN86UE"B`@("`@("`@:68@;65M8F5R(#T]("=?35]D
M871A)SH*("`@("`@("`@("`@(R!#*RLP,R!I;7!L96UE;G1A=&EO;BP@;F]D
M92!C;VYT86EN<R!T:&4@=F%L=64@87,@82!M96UB97(*("`@("`@("`@("`@
M<F5T=7)N(&YO9&5;)U]-7V1A=&$G70H@("`@("`@(&5L:68@;65M8F5R(#T]
M("=?35]S=&]R86=E)SH*("`@("`@("`@("`@(R!#*RLQ,2!I;7!L96UE;G1A
M=&EO;BP@;F]D92!S=&]R97,@=F%L=64@:6X@7U]A;&EG;F5D7VUE;6)U9@H@
M("`@("`@("`@("!V86QT>7!E(#T@;F]D92YT>7!E+G1E;7!L871E7V%R9W5M
M96YT*#`I"B`@("`@("`@("`@(')E='5R;B!G971?=F%L=65?9G)O;5]A;&EG
M;F5D7VUE;6)U9BAN;V1E6R=?35]S=&]R86=E)UTL('9A;'1Y<&4I"B`@("!E
M>&-E<'0Z"B`@("`@("`@<&%S<PH@("`@<F%I<V4@5F%L=65%<G)O<B@B56YS
M=7!P;W)T960@:6UP;&5M96YT871I;VX@9F]R("5S(B`E('-T<BAN;V1E+G1Y
M<&4I*0H*8VQA<W,@4W1D3&ES=%!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z
M.FQI<W0B"@H@("`@8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*("`@("`@
M("!D968@7U]I;FET7U\H<V5L9BP@;F]D971Y<&4L(&AE860I.@H@("`@("`@
M("`@("!S96QF+FYO9&5T>7!E(#T@;F]D971Y<&4*("`@("`@("`@("`@<V5L
M9BYB87-E(#T@:&5A9%LG7TU?;F5X="=="B`@("`@("`@("`@('-E;&8N:&5A
M9"`](&AE860N861D<F5S<PH@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*
M("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E='5R
M;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("`@
M("`@:68@<V5L9BYB87-E(#T]('-E;&8N:&5A9#H*("`@("`@("`@("`@("`@
M(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@96QT(#T@<V5L9BYB
M87-E+F-A<W0H<V5L9BYN;V1E='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@
M("`@("!S96QF+F)A<V4@/2!E;'1;)U]-7VYE>'0G70H@("`@("`@("`@("!C
M;W5N="`]('-E;&8N8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E
M;&8N8V]U;G0@*R`Q"B`@("`@("`@("`@('9A;"`](&=E=%]V86QU95]F<F]M
M7VQI<W1?;F]D92AE;'0I"B`@("`@("`@("`@(')E='5R;B`H)ULE9%TG("4@
M8V]U;G0L('9A;"D*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L
M('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE
M9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P*
M"B`@("!D968@8VAI;&1R96XH<V5L9BDZ"B`@("`@("`@;F]D971Y<&4@/2!F
M:6YD7W1Y<&4H<V5L9BYV86PN='EP92P@)U].;V1E)RD*("`@("`@("!N;V1E
M='EP92`](&YO9&5T>7!E+G-T<FEP7W1Y<&5D969S*"DN<&]I;G1E<B@I"B`@
M("`@("`@<F5T=7)N('-E;&8N7VET97)A=&]R*&YO9&5T>7!E+"!S96QF+G9A
M;%LG7TU?:6UP;"==6R=?35]N;V1E)UTI"@H@("`@9&5F('1O7W-T<FEN9RAS
M96QF*3H*("`@("`@("!I9B!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]N;V1E
M)UTN861D<F5S<R`]/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]N;V1E)UU;
M)U]-7VYE>'0G73H*("`@("`@("`@("`@<F5T=7)N("=E;7!T>2`E<R<@)2`H
M<V5L9BYT>7!E;F%M92D*("`@("`@("!R971U<FX@)R5S)R`E("AS96QF+G1Y
M<&5N86UE*0H*8VQA<W,@3F]D94ET97)A=&]R4')I;G1E<CH*("`@(&1E9B!?
M7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L+"!C;VYT;F%M92DZ"B`@("`@
M("`@<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N86UE(#T@='EP
M96YA;64*("`@("`@("!S96QF+F-O;G1N86UE(#T@8V]N=&YA;64*"B`@("!D
M968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(&EF(&YO="!S96QF+G9A;%LG
M7TU?;F]D92==.@H@("`@("`@("`@("!R971U<FX@)VYO;BUD97)E9F5R96YC
M96%B;&4@:71E<F%T;W(@9F]R('-T9#HZ)7,G("4@*'-E;&8N8V]N=&YA;64I
M"B`@("`@("`@;F]D971Y<&4@/2!F:6YD7W1Y<&4H<V5L9BYV86PN='EP92P@
M)U].;V1E)RD*("`@("`@("!N;V1E='EP92`](&YO9&5T>7!E+G-T<FEP7W1Y
M<&5D969S*"DN<&]I;G1E<B@I"B`@("`@("`@;F]D92`]('-E;&8N=F%L6R=?
M35]N;V1E)UTN8V%S="AN;V1E='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@
M(')E='5R;B!S='(H9V5T7W9A;'5E7V9R;VU?;&ES=%]N;V1E*&YO9&4I*0H*
M8VQA<W,@4W1D3&ES=$ET97)A=&]R4')I;G1E<BA.;V1E271E<F%T;W)0<FEN
M=&5R*3H*("`@(")0<FEN="!S=&0Z.FQI<W0Z.FET97)A=&]R(@H*("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!.;V1E
M271E<F%T;W)0<FEN=&5R+E]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PL
M("=L:7-T)RD*"F-L87-S(%-T9$9W9$QI<W1)=&5R871O<E!R:6YT97(H3F]D
M94ET97)A=&]R4')I;G1E<BDZ"B`@("`B4')I;G0@<W1D.CIF;W)W87)D7VQI
M<W0Z.FET97)A=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M
M92P@=F%L*3H*("`@("`@("!.;V1E271E<F%T;W)0<FEN=&5R+E]?:6YI=%]?
M*'-E;&8L('1Y<&5N86UE+"!V86PL("=F;W)W87)D7VQI<W0G*0H*8VQA<W,@
M4W1D4VQI<W10<FEN=&5R.@H@("`@(E!R:6YT(&$@7U]G;G5?8WAX.CIS;&ES
M="(*"B`@("!C;&%S<R!?:71E<F%T;W(H271E<F%T;W(I.@H@("`@("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!N;V1E='EP92P@:&5A9"DZ"B`@("`@("`@("`@
M('-E;&8N;F]D971Y<&4@/2!N;V1E='EP90H@("`@("`@("`@("!S96QF+F)A
M<V4@/2!H96%D6R=?35]H96%D)UU;)U]-7VYE>'0G70H@("`@("`@("`@("!S
M96QF+F-O=6YT(#T@,`H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@
M("`@("`@("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS
M96QF*3H*("`@("`@("`@("`@:68@<V5L9BYB87-E(#T](#`Z"B`@("`@("`@
M("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@(&5L="`]
M('-E;&8N8F%S92YC87-T*'-E;&8N;F]D971Y<&4I+F1E<F5F97)E;F-E*"D*
M("`@("`@("`@("`@<V5L9BYB87-E(#T@96QT6R=?35]N97AT)UT*("`@("`@
M("`@("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@("`@("`@("`@('-E;&8N8V]U
M;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@("`@("!R971U<FX@*"=;)61=
M)R`E(&-O=6YT+"!E;'1;)U]-7V1A=&$G72D*"B`@("!D968@7U]I;FET7U\H
M<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*
M"B`@("!D968@8VAI;&1R96XH<V5L9BDZ"B`@("`@("`@;F]D971Y<&4@/2!F
M:6YD7W1Y<&4H<V5L9BYV86PN='EP92P@)U].;V1E)RD*("`@("`@("!N;V1E
M='EP92`](&YO9&5T>7!E+G-T<FEP7W1Y<&5D969S*"DN<&]I;G1E<B@I"B`@
M("`@("`@<F5T=7)N('-E;&8N7VET97)A=&]R*&YO9&5T>7!E+"!S96QF+G9A
M;"D*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(&EF('-E;&8N
M=F%L6R=?35]H96%D)UU;)U]-7VYE>'0G72`]/2`P.@H@("`@("`@("`@("!R
M971U<FX@)V5M<'1Y(%]?9VYU7V-X>#HZ<VQI<W0G"B`@("`@("`@<F5T=7)N
M("=?7V=N=5]C>'@Z.G-L:7-T)PH*8VQA<W,@4W1D4VQI<W1)=&5R871O<E!R
M:6YT97(Z"B`@("`B4')I;G0@7U]G;G5?8WAX.CIS;&ES=#HZ:71E<F%T;W(B
M"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@
M("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*
M("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-7VYO9&4G73H*("`@("`@("`@
M("`@<F5T=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!?
M7V=N=5]C>'@Z.G-L:7-T)PH@("`@("`@(&YO9&5T>7!E(#T@9FEN9%]T>7!E
M*'-E;&8N=F%L+G1Y<&4L("=?3F]D92<I"B`@("`@("`@;F]D971Y<&4@/2!N
M;V1E='EP92YS=')I<%]T>7!E9&5F<R@I+G!O:6YT97(H*0H@("`@("`@(')E
M='5R;B!S='(H<V5L9BYV86Q;)U]-7VYO9&4G72YC87-T*&YO9&5T>7!E*2YD
M97)E9F5R96YC92@I6R=?35]D871A)UTI"@IC;&%S<R!3=&1696-T;W)0<FEN
M=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIV96-T;W(B"@H@("`@8VQA<W,@7VET
M97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\@*'-E;&8L
M('-T87)T+"!F:6YI<V@L(&)I='9E8RDZ"B`@("`@("`@("`@('-E;&8N8FET
M=F5C(#T@8FET=F5C"B`@("`@("`@("`@(&EF(&)I='9E8SH*("`@("`@("`@
M("`@("`@('-E;&8N:71E;2`@(#T@<W1A<G1;)U]-7W`G70H@("`@("`@("`@
M("`@("`@<V5L9BYS;R`@("`@/2!S=&%R=%LG7TU?;V9F<V5T)UT*("`@("`@
M("`@("`@("`@('-E;&8N9FEN:7-H(#T@9FEN:7-H6R=?35]P)UT*("`@("`@
M("`@("`@("`@('-E;&8N9F\@("`@(#T@9FEN:7-H6R=?35]O9F9S970G70H@
M("`@("`@("`@("`@("`@:71Y<&4@/2!S96QF+FET96TN9&5R969E<F5N8V4H
M*2YT>7!E"B`@("`@("`@("`@("`@("!S96QF+FES:7IE(#T@."`J(&ET>7!E
M+G-I>F5O9@H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@<V5L
M9BYI=&5M(#T@<W1A<G0*("`@("`@("`@("`@("`@('-E;&8N9FEN:7-H(#T@
M9FEN:7-H"B`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E
M9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@
M("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!C;W5N="`]
M('-E;&8N8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U
M;G0@*R`Q"B`@("`@("`@("`@(&EF('-E;&8N8FET=F5C.@H@("`@("`@("`@
M("`@("`@:68@<V5L9BYI=&5M(#T]('-E;&8N9FEN:7-H(&%N9"!S96QF+G-O
M(#X]('-E;&8N9F\Z"B`@("`@("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET
M97)A=&EO;@H@("`@("`@("`@("`@("`@96QT(#T@8F]O;"AS96QF+FET96TN
M9&5R969E<F5N8V4H*2`F("@Q(#P\('-E;&8N<V\I*0H@("`@("`@("`@("`@
M("`@<V5L9BYS;R`]('-E;&8N<V\@*R`Q"B`@("`@("`@("`@("`@("!I9B!S
M96QF+G-O(#X]('-E;&8N:7-I>F4Z"B`@("`@("`@("`@("`@("`@("`@<V5L
M9BYI=&5M(#T@<V5L9BYI=&5M("L@,0H@("`@("`@("`@("`@("`@("`@('-E
M;&8N<V\@/2`P"B`@("`@("`@("`@("`@("!R971U<FX@*"=;)61=)R`E(&-O
M=6YT+"!E;'0I"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!I
M9B!S96QF+FET96T@/3T@<V5L9BYF:6YI<V@Z"B`@("`@("`@("`@("`@("`@
M("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("`@("`@96QT(#T@
M<V5L9BYI=&5M+F1E<F5F97)E;F-E*"D*("`@("`@("`@("`@("`@('-E;&8N
M:71E;2`]('-E;&8N:71E;2`K(#$*("`@("`@("`@("`@("`@(')E='5R;B`H
M)ULE9%TG("4@8V]U;G0L(&5L="D*"B`@("!D968@7U]I;FET7U\H<V5L9BP@
M='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP
M7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV
M86P@/2!V86P*("`@("`@("!S96QF+FES7V)O;VP@/2!V86PN='EP92YT96UP
M;&%T95]A<F=U;65N="@P*2YC;V1E(#T](&=D8BY465!%7T-/1$5?0D]/3`H*
M("`@(&1E9B!C:&EL9')E;BAS96QF*3H*("`@("`@("!R971U<FX@<V5L9BY?
M:71E<F%T;W(H<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A<G0G72P*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@<V5L9BYV86Q;)U]-7VEM<&PG
M75LG7TU?9FEN:7-H)UTL"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M('-E;&8N:7-?8F]O;"D*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I.@H@("`@
M("`@('-T87)T(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A<G0G70H@
M("`@("`@(&9I;FES:"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7V9I;FES
M:"=="B`@("`@("`@96YD(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?96YD
M7V]F7W-T;W)A9V4G70H@("`@("`@(&EF('-E;&8N:7-?8F]O;#H*("`@("`@
M("`@("`@<W1A<G0@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]S=&%R="==
M6R=?35]P)UT*("`@("`@("`@("`@<V\@("`@/2!S96QF+G9A;%LG7TU?:6UP
M;"==6R=?35]S=&%R="==6R=?35]O9F9S970G70H@("`@("`@("`@("!F:6YI
M<V@@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G75LG7TU?<"==
M"B`@("`@("`@("`@(&9O("`@("`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-
M7V9I;FES:"==6R=?35]O9F9S970G70H@("`@("`@("`@("!I='EP92`]('-T
M87)T+F1E<F5F97)E;F-E*"DN='EP90H@("`@("`@("`@("!B;"`](#@@*B!I
M='EP92YS:7IE;V8*("`@("`@("`@("`@;&5N9W1H("`@/2`H8FP@+2!S;RD@
M*R!B;"`J("@H9FEN:7-H("T@<W1A<G0I("T@,2D@*R!F;PH@("`@("`@("`@
M("!C87!A8VET>2`](&)L("H@*&5N9"`M('-T87)T*0H@("`@("`@("`@("!R
M971U<FX@*"<E<SQB;V]L/B!O9B!L96YG=&@@)60L(&-A<&%C:71Y("5D)PH@
M("`@("`@("`@("`@("`@("`@("4@*'-E;&8N='EP96YA;64L(&EN="`H;&5N
M9W1H*2P@:6YT("AC87!A8VET>2DI*0H@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@(')E='5R;B`H)R5S(&]F(&QE;F=T:"`E9"P@8V%P86-I='D@)60G"B`@
M("`@("`@("`@("`@("`@("`@)2`H<V5L9BYT>7!E;F%M92P@:6YT("AF:6YI
M<V@@+2!S=&%R="DL(&EN="`H96YD("T@<W1A<G0I*2D*"B`@("!D968@9&ES
M<&QA>5]H:6YT*'-E;&8I.@H@("`@("`@(')E='5R;B`G87)R87DG"@IC;&%S
M<R!3=&1696-T;W))=&5R871O<E!R:6YT97(Z"B`@("`B4')I;G0@<W1D.CIV
M96-T;W(Z.FET97)A=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E
M;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!T
M;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@;F]T('-E;&8N=F%L6R=?35]C
M=7)R96YT)UTZ"B`@("`@("`@("`@(')E='5R;B`G;F]N+61E<F5F97)E;F-E
M86)L92!I=&5R871O<B!F;W(@<W1D.CIV96-T;W(G"B`@("`@("`@<F5T=7)N
M('-T<BAS96QF+G9A;%LG7TU?8W5R<F5N="==+F1E<F5F97)E;F-E*"DI"@HC
M(%1/1$\@861D('!R:6YT97(@9F]R('9E8W1O<CQB;V]L/B=S(%]":71?:71E
M<F%T;W(@86YD(%]":71?8V]N<W1?:71E<F%T;W(*"F-L87-S(%-T9%1U<&QE
M4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ='5P;&4B"@H@("`@8VQA<W,@
M7VET97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!`<W1A=&EC;65T:&]D"B`@
M("`@("`@9&5F(%]I<U]N;VYE;7!T>5]T=7!L92`H;F]D97,I.@H@("`@("`@
M("`@("!I9B!L96X@*&YO9&5S*2`]/2`R.@H@("`@("`@("`@("`@("`@:68@
M:7-?<W!E8VEA;&EZ871I;VY?;V8@*&YO9&5S6S%=+G1Y<&4L("=?7W1U<&QE
M7V)A<V4G*3H*("`@("`@("`@("`@("`@("`@("!R971U<FX@5')U90H@("`@
M("`@("`@("!E;&EF(&QE;B`H;F]D97,I(#T](#$Z"B`@("`@("`@("`@("`@
M("!R971U<FX@5')U90H@("`@("`@("`@("!E;&EF(&QE;B`H;F]D97,I(#T]
M(#`Z"B`@("`@("`@("`@("`@("!R971U<FX@1F%L<V4*("`@("`@("`@("`@
M<F%I<V4@5F%L=65%<G)O<B@B5&]P(&]F('1U<&QE('1R964@9&]E<R!N;W0@
M8V]N<VES="!O9B!A('-I;F=L92!N;V1E+B(I"@H@("`@("`@(&1E9B!?7VEN
M:71?7R`H<V5L9BP@:&5A9"DZ"B`@("`@("`@("`@('-E;&8N:&5A9"`](&AE
M860*"B`@("`@("`@("`@(",@4V5T('1H92!B87-E(&-L87-S(&%S('1H92!I
M;FET:6%L(&AE860@;V8@=&AE"B`@("`@("`@("`@(",@='5P;&4N"B`@("`@
M("`@("`@(&YO9&5S(#T@<V5L9BYH96%D+G1Y<&4N9FEE;&1S("@I"B`@("`@
M("`@("`@(&EF('-E;&8N7VES7VYO;F5M<'1Y7W1U<&QE("AN;V1E<RDZ"B`@
M("`@("`@("`@("`@("`C(%-E="!T:&4@86-T=6%L(&AE860@=&\@=&AE(&9I
M<G-T('!A:7(N"B`@("`@("`@("`@("`@("!S96QF+FAE860@(#T@<V5L9BYH
M96%D+F-A<W0@*&YO9&5S6S!=+G1Y<&4I"B`@("`@("`@("`@('-E;&8N8V]U
M;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?7R`H<V5L9BDZ"B`@("`@("`@
M("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7R`H<V5L9BDZ
M"B`@("`@("`@("`@(",@0VAE8VL@9F]R(&9U<G1H97(@<F5C=7)S:6]N<R!I
M;B!T:&4@:6YH97)I=&%N8V4@=')E92X*("`@("`@("`@("`@(R!&;W(@82!'
M0T,@-2L@='5P;&4@<V5L9BYH96%D(&ES($YO;F4@869T97(@=FES:71I;F<@
M86QL(&YO9&5S.@H@("`@("`@("`@("!I9B!N;W0@<V5L9BYH96%D.@H@("`@
M("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!N
M;V1E<R`]('-E;&8N:&5A9"YT>7!E+F9I96QD<R`H*0H@("`@("`@("`@("`C
M($9O<B!A($=#0R`T+G@@='5P;&4@=&AE<F4@:7,@82!F:6YA;"!N;V1E('=I
M=&@@;F\@9FEE;&1S.@H@("`@("`@("`@("!I9B!L96X@*&YO9&5S*2`]/2`P
M.@H@("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@
M("`@("`C($-H96-K('1H870@=&AI<R!I=&5R871I;VX@:&%S(&%N(&5X<&5C
M=&5D('-T<G5C='5R92X*("`@("`@("`@("`@:68@;&5N("AN;V1E<RD@/B`R
M.@H@("`@("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@B0V%N;F]T('!A
M<G-E(&UO<F4@=&AA;B`R(&YO9&5S(&EN(&$@='5P;&4@=')E92XB*0H*("`@
M("`@("`@("`@:68@;&5N("AN;V1E<RD@/3T@,3H*("`@("`@("`@("`@("`@
M(",@5&AI<R!I<R!T:&4@;&%S="!N;V1E(&]F(&$@1T-#(#4K('-T9#HZ='5P
M;&4N"B`@("`@("`@("`@("`@("!I;7!L(#T@<V5L9BYH96%D+F-A<W0@*&YO
M9&5S6S!=+G1Y<&4I"B`@("`@("`@("`@("`@("!S96QF+FAE860@/2!.;VYE
M"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("`C($5I=&AE<B!A
M(&YO9&4@8F5F;W)E('1H92!L87-T(&YO9&4L(&]R('1H92!L87-T(&YO9&4@
M;V8*("`@("`@("`@("`@("`@(",@82!'0T,@-"YX('1U<&QE("AW:&EC:"!H
M87,@86X@96UP='D@<&%R96YT*2X*"B`@("`@("`@("`@("`@("`C("T@3&5F
M="!N;V1E(&ES('1H92!N97AT(')E8W5R<VEO;B!P87)E;G0N"B`@("`@("`@
M("`@("`@("`C("T@4FEG:'0@;F]D92!I<R!T:&4@86-T=6%L(&-L87-S(&-O
M;G1A:6YE9"!I;B!T:&4@='5P;&4N"@H@("`@("`@("`@("`@("`@(R!0<F]C
M97-S(')I9VAT(&YO9&4N"B`@("`@("`@("`@("`@("!I;7!L(#T@<V5L9BYH
M96%D+F-A<W0@*&YO9&5S6S%=+G1Y<&4I"@H@("`@("`@("`@("`@("`@(R!0
M<F]C97-S(&QE9G0@;F]D92!A;F0@<V5T(&ET(&%S(&AE860N"B`@("`@("`@
M("`@("`@("!S96QF+FAE860@(#T@<V5L9BYH96%D+F-A<W0@*&YO9&5S6S!=
M+G1Y<&4I"@H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K
M(#$*"B`@("`@("`@("`@(",@1FEN86QL>2P@8VAE8VL@=&AE(&EM<&QE;65N
M=&%T:6]N+B`@268@:70@:7,*("`@("`@("`@("`@(R!W<F%P<&5D(&EN(%]-
M7VAE861?:6UP;"!R971U<FX@=&AA="P@;W1H97)W:7-E(')E='5R;@H@("`@
M("`@("`@("`C('1H92!V86QU92`B87,@:7,B+@H@("`@("`@("`@("!F:65L
M9',@/2!I;7!L+G1Y<&4N9FEE;&1S("@I"B`@("`@("`@("`@(&EF(&QE;B`H
M9FEE;&1S*2`\(#$@;W(@9FEE;&1S6S!=+FYA;64@(3T@(E]-7VAE861?:6UP
M;"(Z"B`@("`@("`@("`@("`@("!R971U<FX@*"=;)61=)R`E('-E;&8N8V]U
M;G0L(&EM<&PI"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!R
M971U<FX@*"=;)61=)R`E('-E;&8N8V]U;G0L(&EM<&Q;)U]-7VAE861?:6UP
M;"==*0H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ
M"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE
M<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P["@H@("`@
M9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!R971U<FX@<V5L9BY?:71E
M<F%T;W(@*'-E;&8N=F%L*0H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@
M("`@("`@(&EF(&QE;B`H<V5L9BYV86PN='EP92YF:65L9',@*"DI(#T](#`Z
M"B`@("`@("`@("`@(')E='5R;B`G96UP='D@)7,G("4@*'-E;&8N='EP96YA
M;64I"B`@("`@("`@<F5T=7)N("<E<R!C;VYT86EN:6YG)R`E("AS96QF+G1Y
M<&5N86UE*0H*8VQA<W,@4W1D4W1A8VM/<E%U975E4')I;G1E<CH*("`@(")0
M<FEN="!A('-T9#HZ<W1A8VL@;W(@<W1D.CIQ=65U92(*"B`@("!D968@7U]I
M;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP
M96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@
M("`@("`@('-E;&8N=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ
M97(H=F%L6R=C)UTI"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@
M("!R971U<FX@<V5L9BYV:7-U86QI>F5R+F-H:6QD<F5N*"D*"B`@("!D968@
M=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!R971U<FX@)R5S('=R87!P:6YG
M.B`E<R<@)2`H<V5L9BYT>7!E;F%M92P*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@<V5L9BYV:7-U86QI>F5R+G1O7W-T<FEN9R@I*0H*
M("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(&EF(&AA<V%T
M='(@*'-E;&8N=FES=6%L:7IE<BP@)V1I<W!L87E?:&EN="<I.@H@("`@("`@
M("`@("!R971U<FX@<V5L9BYV:7-U86QI>F5R+F1I<W!L87E?:&EN="`H*0H@
M("`@("`@(')E='5R;B!.;VYE"@IC;&%S<R!28G1R965)=&5R871O<BA)=&5R
M871O<BDZ"B`@("`B(B(*("`@(%1U<FX@86X@4D(M=')E92UB87-E9"!C;VYT
M86EN97(@*'-T9#HZ;6%P+"!S=&0Z.G-E="!E=&,N*2!I;G1O"B`@("!A(%!Y
M=&AO;B!I=&5R86)L92!O8FIE8W0N"B`@("`B(B(*"B`@("!D968@7U]I;FET
M7U\H<V5L9BP@<F)T<F5E*3H*("`@("`@("!S96QF+G-I>F4@/2!R8G1R965;
M)U]-7W0G75LG7TU?:6UP;"==6R=?35]N;V1E7V-O=6YT)UT*("`@("`@("!S
M96QF+FYO9&4@/2!R8G1R965;)U]-7W0G75LG7TU?:6UP;"==6R=?35]H96%D
M97(G75LG7TU?;&5F="=="B`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@("!D
M968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8*"B`@("!D
M968@7U]L96Y?7RAS96QF*3H*("`@("`@("!R971U<FX@:6YT("AS96QF+G-I
M>F4I"@H@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N
M8V]U;G0@/3T@<V5L9BYS:7IE.@H@("`@("`@("`@("!R86ES92!3=&]P271E
M<F%T:6]N"B`@("`@("`@<F5S=6QT(#T@<V5L9BYN;V1E"B`@("`@("`@<V5L
M9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@:68@<V5L9BYC;W5N
M="`\('-E;&8N<VEZ93H*("`@("`@("`@("`@(R!#;VUP=71E('1H92!N97AT
M(&YO9&4N"B`@("`@("`@("`@(&YO9&4@/2!S96QF+FYO9&4*("`@("`@("`@
M("`@:68@;F]D92YD97)E9F5R96YC92@I6R=?35]R:6=H="==.@H@("`@("`@
M("`@("`@("`@;F]D92`](&YO9&4N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G
M70H@("`@("`@("`@("`@("`@=VAI;&4@;F]D92YD97)E9F5R96YC92@I6R=?
M35]L969T)UTZ"B`@("`@("`@("`@("`@("`@("`@;F]D92`](&YO9&4N9&5R
M969E<F5N8V4H*5LG7TU?;&5F="=="B`@("`@("`@("`@(&5L<V4Z"B`@("`@
M("`@("`@("`@("!P87)E;G0@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7W!A
M<F5N="=="B`@("`@("`@("`@("`@("!W:&EL92!N;V1E(#T]('!A<F5N="YD
M97)E9F5R96YC92@I6R=?35]R:6=H="==.@H@("`@("`@("`@("`@("`@("`@
M(&YO9&4@/2!P87)E;G0*("`@("`@("`@("`@("`@("`@("!P87)E;G0@/2!P
M87)E;G0N9&5R969E<F5N8V4H*5LG7TU?<&%R96YT)UT*("`@("`@("`@("`@
M("`@(&EF(&YO9&4N9&5R969E<F5N8V4H*5LG7TU?<FEG:'0G72`A/2!P87)E
M;G0Z"B`@("`@("`@("`@("`@("`@("`@;F]D92`]('!A<F5N=`H@("`@("`@
M("`@("!S96QF+FYO9&4@/2!N;V1E"B`@("`@("`@<F5T=7)N(')E<W5L=`H*
M9&5F(&=E=%]V86QU95]F<F]M7U)B7W1R965?;F]D92AN;V1E*3H*("`@("(B
M(E)E='5R;G,@=&AE('9A;'5E(&AE;&0@:6X@86X@7U)B7W1R965?;F]D93Q?
M5F%L/B(B(@H@("`@=')Y.@H@("`@("`@(&UE;6)E<B`](&YO9&4N='EP92YF
M:65L9',H*5LQ72YN86UE"B`@("`@("`@:68@;65M8F5R(#T]("=?35]V86QU
M95]F:65L9"<Z"B`@("`@("`@("`@(",@0RLK,#,@:6UP;&5M96YT871I;VXL
M(&YO9&4@8V]N=&%I;G,@=&AE('9A;'5E(&%S(&$@;65M8F5R"B`@("`@("`@
M("`@(')E='5R;B!N;V1E6R=?35]V86QU95]F:65L9"=="B`@("`@("`@96QI
M9B!M96UB97(@/3T@)U]-7W-T;W)A9V4G.@H@("`@("`@("`@("`C($,K*S$Q
M(&EM<&QE;65N=&%T:6]N+"!N;V1E('-T;W)E<R!V86QU92!I;B!?7V%L:6=N
M961?;65M8G5F"B`@("`@("`@("`@('9A;'1Y<&4@/2!N;V1E+G1Y<&4N=&5M
M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("`@("`@<F5T=7)N(&=E=%]V86QU
M95]F<F]M7V%L:6=N961?;65M8G5F*&YO9&5;)U]-7W-T;W)A9V4G72P@=F%L
M='EP92D*("`@(&5X8V5P=#H*("`@("`@("!P87-S"B`@("!R86ES92!686QU
M945R<F]R*")5;G-U<'!O<G1E9"!I;7!L96UE;G1A=&EO;B!F;W(@)7,B("4@
M<W1R*&YO9&4N='EP92DI"@HC(%1H:7,@:7,@82!P<F5T='D@<')I;G1E<B!F
M;W(@<W1D.CI?4F)?=')E95]I=&5R871O<B`H=VAI8V@@:7,*(R!S=&0Z.FUA
M<#HZ:71E<F%T;W(I+"!A;F0@:&%S(&YO=&AI;F<@=&\@9&\@=VET:"!T:&4@
M4F)T<F5E271E<F%T;W(*(R!C;&%S<R!A8F]V92X*8VQA<W,@4W1D4F)T<F5E
M271E<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT('-T9#HZ;6%P.CII=&5R871O
M<BP@<W1D.CIS970Z.FET97)A=&]R+"!E=&,N(@H*("`@(&1E9B!?7VEN:71?
M7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V
M86P*("`@("`@("!V86QT>7!E(#T@<V5L9BYV86PN='EP92YT96UP;&%T95]A
M<F=U;65N="@P*2YS=')I<%]T>7!E9&5F<R@I"B`@("`@("`@;F]D971Y<&4@
M/2`G7U)B7W1R965?;F]D93PG("L@<W1R*'9A;'1Y<&4I("L@)SXG"B`@("`@
M("`@:68@7W9E<G-I;VYE9%]N86UE<W!A8V4@86YD('1Y<&5N86UE+G-T87)T
M<W=I=&@H)W-T9#HZ)R`K(%]V97)S:6]N961?;F%M97-P86-E*3H*("`@("`@
M("`@("`@;F]D971Y<&4@/2!?=F5R<VEO;F5D7VYA;65S<&%C92`K(&YO9&5T
M>7!E"B`@("`@("`@;F]D971Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H)W-T9#HZ
M)R`K(&YO9&5T>7!E*0H@("`@("`@('-E;&8N;&EN:U]T>7!E(#T@;F]D971Y
M<&4N<W1R:7!?='EP961E9G,H*2YP;VEN=&5R*"D*"B`@("!D968@=&]?<W1R
M:6YG("AS96QF*3H*("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-7VYO9&4G
M73H*("`@("`@("`@("`@<F5T=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET
M97)A=&]R(&9O<B!A<W-O8VEA=&EV92!C;VYT86EN97(G"B`@("`@("`@;F]D
M92`]('-E;&8N=F%L6R=?35]N;V1E)UTN8V%S="AS96QF+FQI;FM?='EP92DN
M9&5R969E<F5N8V4H*0H@("`@("`@(')E='5R;B!S='(H9V5T7W9A;'5E7V9R
M;VU?4F)?=')E95]N;V1E*&YO9&4I*0H*8VQA<W,@4W1D1&5B=6=)=&5R871O
M<E!R:6YT97(Z"B`@("`B4')I;G0@82!D96)U9R!E;F%B;&5D('9E<G-I;VX@
M;V8@86X@:71E<F%T;W(B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E
M;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(",@2G5S
M="!S=')I<"!A=V%Y('1H92!E;F-A<'-U;&%T:6YG(%]?9VYU7V1E8G5G.CI?
M4V%F95]I=&5R871O<@H@("`@(R!A;F0@<F5T=7)N('1H92!W<F%P<&5D(&ET
M97)A=&]R('9A;'5E+@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@
M("`@8F%S95]T>7!E(#T@9V1B+FQO;VMU<%]T>7!E*"=?7V=N=5]D96)U9SHZ
M7U-A9F5?:71E<F%T;W)?8F%S92<I"B`@("`@("`@:71Y<&4@/2!S96QF+G9A
M;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@<V%F95]S97$@
M/2!S96QF+G9A;"YC87-T*&)A<V5?='EP92E;)U]-7W-E<75E;F-E)UT*("`@
M("`@("!I9B!N;W0@<V%F95]S97$Z"B`@("`@("`@("`@(')E='5R;B!S='(H
M<V5L9BYV86PN8V%S="AI='EP92DI"B`@("`@("`@:68@<V5L9BYV86Q;)U]-
M7W9E<G-I;VXG72`A/2!S869E7W-E<5LG7TU?=F5R<VEO;B==.@H@("`@("`@
M("`@("!R971U<FX@(FEN=F%L:60@:71E<F%T;W(B"B`@("`@("`@<F5T=7)N
M('-T<BAS96QF+G9A;"YC87-T*&ET>7!E*2D*"F1E9B!N=6U?96QE;65N=',H
M;G5M*3H*("`@("(B(E)E='5R;B!E:71H97(@(C$@96QE;65N="(@;W(@(DX@
M96QE;65N=',B(&1E<&5N9&EN9R!O;B!T:&4@87)G=6UE;G0N(B(B"B`@("!R
M971U<FX@)S$@96QE;65N="<@:68@;G5M(#T](#$@96QS92`G)60@96QE;65N
M=',G("4@;G5M"@IC;&%S<R!3=&1-87!0<FEN=&5R.@H@("`@(E!R:6YT(&$@
M<W1D.CIM87`@;W(@<W1D.CIM=6QT:6UA<"(*"B`@("`C(%1U<FX@86X@4F)T
M<F5E271E<F%T;W(@:6YT;R!A('!R971T>2UP<FEN="!I=&5R871O<BX*("`@
M(&-L87-S(%]I=&5R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H
M<V5L9BP@<F)I=&5R+"!T>7!E*3H*("`@("`@("`@("`@<V5L9BYR8FET97(@
M/2!R8FET97(*("`@("`@("`@("`@<V5L9BYC;W5N="`](#`*("`@("`@("`@
M("`@<V5L9BYT>7!E(#T@='EP90H*("`@("`@("!D968@7U]I=&5R7U\H<V5L
M9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE
M>'1?7RAS96QF*3H*("`@("`@("`@("`@:68@<V5L9BYC;W5N="`E(#(@/3T@
M,#H*("`@("`@("`@("`@("`@(&X@/2!N97AT*'-E;&8N<F)I=&5R*0H@("`@
M("`@("`@("`@("`@;B`](&XN8V%S="AS96QF+G1Y<&4I+F1E<F5F97)E;F-E
M*"D*("`@("`@("`@("`@("`@(&X@/2!G971?=F%L=65?9G)O;5]28E]T<F5E
M7VYO9&4H;BD*("`@("`@("`@("`@("`@('-E;&8N<&%I<B`](&X*("`@("`@
M("`@("`@("`@(&ET96T@/2!N6R=F:7)S="=="B`@("`@("`@("`@(&5L<V4Z
M"B`@("`@("`@("`@("`@("!I=&5M(#T@<V5L9BYP86ER6R=S96-O;F0G70H@
M("`@("`@("`@("!R97-U;'0@/2`H)ULE9%TG("4@<V5L9BYC;W5N="P@:71E
M;2D*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@
M("`@("`@("`@(')E='5R;B!R97-U;'0*"B`@("!D968@7U]I;FET7U\@*'-E
M;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S
M=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E
M;&8N=F%L(#T@=F%L"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@
M("`@<F5T=7)N("<E<R!W:71H("5S)R`E("AS96QF+G1Y<&5N86UE+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@;G5M7V5L96UE;G1S*&QE;BA2
M8G1R965)=&5R871O<B`H<V5L9BYV86PI*2DI"@H@("`@9&5F(&-H:6QD<F5N
M("AS96QF*3H*("`@("`@("!R97!?='EP92`](&9I;F1?='EP92AS96QF+G9A
M;"YT>7!E+"`G7U)E<%]T>7!E)RD*("`@("`@("!N;V1E(#T@9FEN9%]T>7!E
M*')E<%]T>7!E+"`G7TQI;FM?='EP92<I"B`@("`@("`@;F]D92`](&YO9&4N
M<W1R:7!?='EP961E9G,H*0H@("`@("`@(')E='5R;B!S96QF+E]I=&5R("A2
M8G1R965)=&5R871O<B`H<V5L9BYV86PI+"!N;V1E*0H*("`@(&1E9B!D:7-P
M;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(')E='5R;B`G;6%P)PH*8VQA<W,@
M4W1D4V5T4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ<V5T(&]R('-T9#HZ
M;75L=&ES970B"@H@("`@(R!4=7)N(&%N(%)B=')E94ET97)A=&]R(&EN=&\@
M82!P<F5T='DM<')I;G0@:71E<F%T;W(N"B`@("!C;&%S<R!?:71E<BA)=&5R
M871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L(')B:71E<BP@='EP
M92DZ"B`@("`@("`@("`@('-E;&8N<F)I=&5R(#T@<F)I=&5R"B`@("`@("`@
M("`@('-E;&8N8V]U;G0@/2`P"B`@("`@("`@("`@('-E;&8N='EP92`]('1Y
M<&4*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R
M971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@
M("`@("`@(&ET96T@/2!N97AT*'-E;&8N<F)I=&5R*0H@("`@("`@("`@("!I
M=&5M(#T@:71E;2YC87-T*'-E;&8N='EP92DN9&5R969E<F5N8V4H*0H@("`@
M("`@("`@("!I=&5M(#T@9V5T7W9A;'5E7V9R;VU?4F)?=')E95]N;V1E*&ET
M96TI"B`@("`@("`@("`@(",@1DE8344Z('1H:7,@:7,@=V5I<F0@+BXN('=H
M870@=&\@9&\_"B`@("`@("`@("`@(",@36%Y8F4@82`G<V5T)R!D:7-P;&%Y
M(&AI;G0_"B`@("`@("`@("`@(')E<W5L="`]("@G6R5D72<@)2!S96QF+F-O
M=6YT+"!I=&5M*0H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N
M="`K(#$*("`@("`@("`@("`@<F5T=7)N(')E<W5L=`H*("`@(&1E9B!?7VEN
M:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E
M;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@
M("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS96QF
M*3H*("`@("`@("!R971U<FX@)R5S('=I=&@@)7,G("4@*'-E;&8N='EP96YA
M;64L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!N=6U?96QE;65N
M=',H;&5N*%)B=')E94ET97)A=&]R("AS96QF+G9A;"DI*2D*"B`@("!D968@
M8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(')E<%]T>7!E(#T@9FEN9%]T>7!E
M*'-E;&8N=F%L+G1Y<&4L("=?4F5P7W1Y<&4G*0H@("`@("`@(&YO9&4@/2!F
M:6YD7W1Y<&4H<F5P7W1Y<&4L("=?3&EN:U]T>7!E)RD*("`@("`@("!N;V1E
M(#T@;F]D92YS=')I<%]T>7!E9&5F<R@I"B`@("`@("`@<F5T=7)N('-E;&8N
M7VET97(@*%)B=')E94ET97)A=&]R("AS96QF+G9A;"DL(&YO9&4I"@IC;&%S
M<R!3=&1":71S9710<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIB:71S970B
M"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@
M("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E
M*'1Y<&5N86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F('1O
M7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@(R!)9B!T96UP;&%T95]A<F=U;65N
M="!H86YD;&5D('9A;'5E<RP@=V4@8V]U;&0@<')I;G0@=&AE"B`@("`@("`@
M(R!S:7IE+B`@3W(@=V4@8V]U;&0@=7-E(&$@<F5G97AP(&]N('1H92!T>7!E
M+@H@("`@("`@(')E='5R;B`G)7,G("4@*'-E;&8N='EP96YA;64I"@H@("`@
M9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!T<GDZ"B`@("`@("`@("`@
M(",@06X@96UP='D@8FET<V5T(&UA>2!N;W0@:&%V92!A;GD@;65M8F5R<R!W
M:&EC:"!W:6QL"B`@("`@("`@("`@(",@<F5S=6QT(&EN(&%N(&5X8V5P=&EO
M;B!B96EN9R!T:')O=VXN"B`@("`@("`@("`@('=O<F1S(#T@<V5L9BYV86Q;
M)U]-7W<G70H@("`@("`@(&5X8V5P=#H*("`@("`@("`@("`@<F5T=7)N(%M=
M"@H@("`@("`@('=T>7!E(#T@=V]R9',N='EP90H*("`@("`@("`C(%1H92!?
M35]W(&UE;6)E<B!C86X@8F4@96ET:&5R(&%N('5N<VEG;F5D(&QO;F<L(&]R
M(&%N"B`@("`@("`@(R!A<G)A>2X@(%1H:7,@9&5P96YD<R!O;B!T:&4@=&5M
M<&QA=&4@<W!E8VEA;&EZ871I;VX@=7-E9"X*("`@("`@("`C($EF(&ET(&ES
M(&$@<VEN9VQE(&QO;F<L(&-O;G9E<G0@=&\@82!S:6YG;&4@96QE;65N="!L
M:7-T+@H@("`@("`@(&EF('=T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]!
M4E)!63H*("`@("`@("`@("`@='-I>F4@/2!W='EP92YT87)G970@*"DN<VEZ
M96]F"B`@("`@("`@96QS93H*("`@("`@("`@("`@=V]R9',@/2!;=V]R9'-=
M"B`@("`@("`@("`@('1S:7IE(#T@=W1Y<&4N<VEZ96]F"@H@("`@("`@(&YW
M;W)D<R`]('=T>7!E+G-I>F5O9B`O('1S:7IE"B`@("`@("`@<F5S=6QT(#T@
M6UT*("`@("`@("!B>71E(#T@,`H@("`@("`@('=H:6QE(&)Y=&4@/"!N=V]R
M9',Z"B`@("`@("`@("`@('<@/2!W;W)D<UMB>71E70H@("`@("`@("`@("!B
M:70@/2`P"B`@("`@("`@("`@('=H:6QE('<@(3T@,#H*("`@("`@("`@("`@
M("`@(&EF("AW("8@,2D@(3T@,#H*("`@("`@("`@("`@("`@("`@("`C($%N
M;W1H97(@<W!O="!W:&5R92!W92!C;W5L9"!U<V4@)W-E="<_"B`@("`@("`@
M("`@("`@("`@("`@<F5S=6QT+F%P<&5N9"@H)ULE9%TG("4@*&)Y=&4@*B!T
M<VEZ92`J(#@@*R!B:70I+"`Q*2D*("`@("`@("`@("`@("`@(&)I="`](&)I
M="`K(#$*("`@("`@("`@("`@("`@('<@/2!W(#X^(#$*("`@("`@("`@("`@
M8GET92`](&)Y=&4@*R`Q"B`@("`@("`@<F5T=7)N(')E<W5L=`H*8VQA<W,@
M4W1D1&5Q=650<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CID97%U92(*"B`@
M("!C;&%S<R!?:71E<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?
M*'-E;&8L(&YO9&4L('-T87)T+"!E;F0L(&QA<W0L(&)U9F9E<E]S:7IE*3H*
M("`@("`@("`@("`@<V5L9BYN;V1E(#T@;F]D90H@("`@("`@("`@("!S96QF
M+G`@/2!S=&%R=`H@("`@("`@("`@("!S96QF+F5N9"`](&5N9`H@("`@("`@
M("`@("!S96QF+FQA<W0@/2!L87-T"B`@("`@("`@("`@('-E;&8N8G5F9F5R
M7W-I>F4@/2!B=69F97)?<VEZ90H@("`@("`@("`@("!S96QF+F-O=6YT(#T@
M,`H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E
M='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@
M("`@("`@:68@<V5L9BYP(#T]('-E;&8N;&%S=#H*("`@("`@("`@("`@("`@
M(')A:7-E(%-T;W!)=&5R871I;VX*"B`@("`@("`@("`@(')E<W5L="`]("@G
M6R5D72<@)2!S96QF+F-O=6YT+"!S96QF+G`N9&5R969E<F5N8V4H*2D*("`@
M("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"@H@("`@("`@
M("`@("`C($%D=F%N8V4@=&AE("=C=7(G('!O:6YT97(N"B`@("`@("`@("`@
M('-E;&8N<"`]('-E;&8N<"`K(#$*("`@("`@("`@("`@:68@<V5L9BYP(#T]
M('-E;&8N96YD.@H@("`@("`@("`@("`@("`@(R!)9B!W92!G;W0@=&\@=&AE
M(&5N9"!O9B!T:&ES(&)U8VME="P@;6]V92!T;R!T:&4*("`@("`@("`@("`@
M("`@(",@;F5X="!B=6-K970N"B`@("`@("`@("`@("`@("!S96QF+FYO9&4@
M/2!S96QF+FYO9&4@*R`Q"B`@("`@("`@("`@("`@("!S96QF+G`@/2!S96QF
M+FYO9&5;,%T*("`@("`@("`@("`@("`@('-E;&8N96YD(#T@<V5L9BYP("L@
M<V5L9BYB=69F97)?<VEZ90H*("`@("`@("`@("`@<F5T=7)N(')E<W5L=`H*
M("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@
M("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT
M>7!E;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@('-E;&8N
M96QT='EP92`]('9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I"B`@("`@
M("`@<VEZ92`]('-E;&8N96QT='EP92YS:7IE;V8*("`@("`@("!I9B!S:7IE
M(#P@-3$R.@H@("`@("`@("`@("!S96QF+F)U9F9E<E]S:7IE(#T@:6YT("@U
M,3(@+R!S:7IE*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E;&8N8G5F
M9F5R7W-I>F4@/2`Q"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@
M("!S=&%R="`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UT*("`@
M("`@("!E;F0@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G70H*
M("`@("`@("!D96QT85]N(#T@96YD6R=?35]N;V1E)UT@+2!S=&%R=%LG7TU?
M;F]D92==("T@,0H@("`@("`@(&1E;'1A7W,@/2!S=&%R=%LG7TU?;&%S="==
M("T@<W1A<G1;)U]-7V-U<B=="B`@("`@("`@9&5L=&%?92`](&5N9%LG7TU?
M8W5R)UT@+2!E;F1;)U]-7V9I<G-T)UT*"B`@("`@("`@<VEZ92`]('-E;&8N
M8G5F9F5R7W-I>F4@*B!D96QT85]N("L@9&5L=&%?<R`K(&1E;'1A7V4*"B`@
M("`@("`@<F5T=7)N("<E<R!W:71H("5S)R`E("AS96QF+G1Y<&5N86UE+"!N
M=6U?96QE;65N=',H;&]N9RAS:7IE*2DI"@H@("`@9&5F(&-H:6QD<F5N*'-E
M;&8I.@H@("`@("`@('-T87)T(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?
M<W1A<G0G70H@("`@("`@(&5N9"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-
M7V9I;FES:"=="B`@("`@("`@<F5T=7)N('-E;&8N7VET97(H<W1A<G1;)U]-
M7VYO9&4G72P@<W1A<G1;)U]-7V-U<B==+"!S=&%R=%LG7TU?;&%S="==+`H@
M("`@("`@("`@("`@("`@("`@("`@("`@(&5N9%LG7TU?8W5R)UTL('-E;&8N
M8G5F9F5R7W-I>F4I"@H@("`@9&5F(&1I<W!L87E?:&EN="`H<V5L9BDZ"B`@
M("`@("`@<F5T=7)N("=A<G)A>2<*"F-L87-S(%-T9$1E<75E271E<F%T;W)0
M<FEN=&5R.@H@("`@(E!R:6YT('-T9#HZ9&5Q=64Z.FET97)A=&]R(@H*("`@
M(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S
M96QF+G9A;"`]('9A;`H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@
M("`@:68@;F]T('-E;&8N=F%L6R=?35]C=7(G73H*("`@("`@("`@("`@<F5T
M=7)N("=N;VXM9&5R969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.F1E
M<75E)PH@("`@("`@(')E='5R;B!S='(H<V5L9BYV86Q;)U]-7V-U<B==+F1E
M<F5F97)E;F-E*"DI"@IC;&%S<R!3=&13=')I;F=0<FEN=&5R.@H@("`@(E!R
M:6YT(&$@<W1D.CIB87-I8U]S=')I;F<@;V8@<V]M92!K:6YD(@H*("`@(&1E
M9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF
M+G9A;"`]('9A;`H@("`@("`@('-E;&8N;F5W7W-T<FEN9R`]('1Y<&5N86UE
M+F9I;F0H(CHZ7U]C>'@Q,3HZ8F%S:6-?<W1R:6YG(BD@(3T@+3$*"B`@("!D
M968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(",@36%K92!S=7)E("9S=')I
M;F<@=V]R:W,L('1O;RX*("`@("`@("!T>7!E(#T@<V5L9BYV86PN='EP90H@
M("`@("`@(&EF('1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@
M("`@("`@("`@='EP92`]('1Y<&4N=&%R9V5T("@I"@H@("`@("`@(",@0V%L
M8W5L871E('1H92!L96YG=&@@;V8@=&AE('-T<FEN9R!S;R!T:&%T('1O7W-T
M<FEN9R!R971U<FYS"B`@("`@("`@(R!T:&4@<W1R:6YG(&%C8V]R9&EN9R!T
M;R!L96YG=&@L(&YO="!A8V-O<F1I;F<@=&\@9FER<W0@;G5L;`H@("`@("`@
M(",@96YC;W5N=&5R960N"B`@("`@("`@<'1R(#T@<V5L9BYV86P@6R=?35]D
M871A<&QU<R==6R=?35]P)UT*("`@("`@("!I9B!S96QF+FYE=U]S=')I;F<Z
M"B`@("`@("`@("`@(&QE;F=T:"`]('-E;&8N=F%L6R=?35]S=')I;F=?;&5N
M9W1H)UT*("`@("`@("`@("`@(R!H='1P<SHO+W-O=7)C97=A<F4N;W)G+V)U
M9WII;&QA+W-H;W=?8G5G+F-G:3]I9#TQ-S<R.`H@("`@("`@("`@("!P='(@
M/2!P='(N8V%S="AP='(N='EP92YS=')I<%]T>7!E9&5F<R@I*0H@("`@("`@
M(&5L<V4Z"B`@("`@("`@("`@(')E86QT>7!E(#T@='EP92YU;G%U86QI9FEE
M9"`H*2YS=')I<%]T>7!E9&5F<R`H*0H@("`@("`@("`@("!R97!T>7!E(#T@
M9V1B+FQO;VMU<%]T>7!E("AS='(@*')E86QT>7!E*2`K("<Z.E]297`G*2YP
M;VEN=&5R("@I"B`@("`@("`@("`@(&AE861E<B`]('!T<BYC87-T*')E<'1Y
M<&4I("T@,0H@("`@("`@("`@("!L96YG=&@@/2!H96%D97(N9&5R969E<F5N
M8V4@*"E;)U]-7VQE;F=T:"=="B`@("`@("`@:68@:&%S871T<BAP='(L(")L
M87IY7W-T<FEN9R(I.@H@("`@("`@("`@("!R971U<FX@<'1R+FQA>GE?<W1R
M:6YG("AL96YG=&@@/2!L96YG=&@I"B`@("`@("`@<F5T=7)N('!T<BYS=')I
M;F<@*&QE;F=T:"`](&QE;F=T:"D*"B`@("!D968@9&ES<&QA>5]H:6YT("AS
M96QF*3H*("`@("`@("!R971U<FX@)W-T<FEN9R<*"F-L87-S(%1R,4AA<VAT
M86)L94ET97)A=&]R*$ET97)A=&]R*3H*("`@(&1E9B!?7VEN:71?7R`H<V5L
M9BP@:&%S:"DZ"B`@("`@("`@<V5L9BYB=6-K971S(#T@:&%S:%LG7TU?8G5C
M:V5T<R=="B`@("`@("`@<V5L9BYB=6-K970@/2`P"B`@("`@("`@<V5L9BYB
M=6-K971?8V]U;G0@/2!H87-H6R=?35]B=6-K971?8V]U;G0G70H@("`@("`@
M('-E;&8N;F]D95]T>7!E(#T@9FEN9%]T>7!E*&AA<V@N='EP92P@)U].;V1E
M)RDN<&]I;G1E<B@I"B`@("`@("`@<V5L9BYN;V1E(#T@,`H@("`@("`@('=H
M:6QE('-E;&8N8G5C:V5T("$]('-E;&8N8G5C:V5T7V-O=6YT.@H@("`@("`@
M("`@("!S96QF+FYO9&4@/2!S96QF+F)U8VME='-;<V5L9BYB=6-K971="B`@
M("`@("`@("`@(&EF('-E;&8N;F]D93H*("`@("`@("`@("`@("`@(&)R96%K
M"B`@("`@("`@("`@('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K970@*R`Q"@H@
M("`@9&5F(%]?:71E<E]?("AS96QF*3H*("`@("`@("!R971U<FX@<V5L9@H*
M("`@(&1E9B!?7VYE>'1?7R`H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYN;V1E
M(#T](#`Z"B`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@
M("!N;V1E(#T@<V5L9BYN;V1E+F-A<W0H<V5L9BYN;V1E7W1Y<&4I"B`@("`@
M("`@<F5S=6QT(#T@;F]D92YD97)E9F5R96YC92@I6R=?35]V)UT*("`@("`@
M("!S96QF+FYO9&4@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7VYE>'0G73L*
M("`@("`@("!I9B!S96QF+FYO9&4@/3T@,#H*("`@("`@("`@("`@<V5L9BYB
M=6-K970@/2!S96QF+F)U8VME="`K(#$*("`@("`@("`@("`@=VAI;&4@<V5L
M9BYB=6-K970@(3T@<V5L9BYB=6-K971?8V]U;G0Z"B`@("`@("`@("`@("`@
M("!S96QF+FYO9&4@/2!S96QF+F)U8VME='-;<V5L9BYB=6-K971="B`@("`@
M("`@("`@("`@("!I9B!S96QF+FYO9&4Z"B`@("`@("`@("`@("`@("`@("`@
M8G)E86L*("`@("`@("`@("`@("`@('-E;&8N8G5C:V5T(#T@<V5L9BYB=6-K
M970@*R`Q"B`@("`@("`@<F5T=7)N(')E<W5L=`H*8VQA<W,@4W1D2&%S:'1A
M8FQE271E<F%T;W(H271E<F%T;W(I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M(&AA<V@I.@H@("`@("`@('-E;&8N;F]D92`](&AA<VA;)U]-7V)E9F]R95]B
M96=I;B==6R=?35]N>'0G70H@("`@("`@('-E;&8N;F]D95]T>7!E(#T@9FEN
M9%]T>7!E*&AA<V@N='EP92P@)U]?;F]D95]T>7!E)RDN<&]I;G1E<B@I"@H@
M("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF"@H@
M("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@(&EF('-E;&8N;F]D92`]
M/2`P.@H@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@
M96QT(#T@<V5L9BYN;V1E+F-A<W0H<V5L9BYN;V1E7W1Y<&4I+F1E<F5F97)E
M;F-E*"D*("`@("`@("!S96QF+FYO9&4@/2!E;'1;)U]-7VYX="=="B`@("`@
M("`@=F%L<'1R(#T@96QT6R=?35]S=&]R86=E)UTN861D<F5S<PH@("`@("`@
M('9A;'!T<B`]('9A;'!T<BYC87-T*&5L="YT>7!E+G1E;7!L871E7V%R9W5M
M96YT*#`I+G!O:6YT97(H*2D*("`@("`@("!R971U<FX@=F%L<'1R+F1E<F5F
M97)E;F-E*"D*"F-L87-S(%1R,55N;W)D97)E9%-E=%!R:6YT97(Z"B`@("`B
M4')I;G0@82!T<C$Z.G5N;W)D97)E9%]S970B"@H@("`@9&5F(%]?:6YI=%]?
M("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE
M(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@
M("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!H87-H=&%B;&4@*'-E;&8I.@H@
M("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S=VET:"@G<W1D.CIT<C$G
M*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=F%L"B`@("`@("`@<F5T=7)N
M('-E;&8N=F%L6R=?35]H)UT*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*
M("`@("`@("!C;W5N="`]('-E;&8N:&%S:'1A8FQE*"E;)U]-7V5L96UE;G1?
M8V]U;G0G70H@("`@("`@(')E='5R;B`G)7,@=VET:"`E<R<@)2`H<V5L9BYT
M>7!E;F%M92P@;G5M7V5L96UE;G1S*&-O=6YT*2D*"B`@("!`<W1A=&EC;65T
M:&]D"B`@("!D968@9F]R;6%T7V-O=6YT("AI*3H*("`@("`@("!R971U<FX@
M)ULE9%TG("4@:0H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@
M8V]U;G1E<B`](&EM87`@*'-E;&8N9F]R;6%T7V-O=6YT+"!I=&5R=&]O;',N
M8V]U;G0H*2D*("`@("`@("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H
M)W-T9#HZ='(Q)RDZ"B`@("`@("`@("`@(')E='5R;B!I>FEP("AC;W5N=&5R
M+"!4<C%(87-H=&%B;&5)=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI"B`@
M("`@("`@<F5T=7)N(&EZ:7`@*&-O=6YT97(L(%-T9$AA<VAT86)L94ET97)A
M=&]R("AS96QF+FAA<VAT86)L92@I*2D*"F-L87-S(%1R,55N;W)D97)E9$UA
M<%!R:6YT97(Z"B`@("`B4')I;G0@82!T<C$Z.G5N;W)D97)E9%]M87`B"@H@
M("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@
M("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT
M>7!E;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!H87-H
M=&%B;&4@*'-E;&8I.@H@("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S
M=VET:"@G<W1D.CIT<C$G*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=F%L
M"B`@("`@("`@<F5T=7)N('-E;&8N=F%L6R=?35]H)UT*"B`@("!D968@=&]?
M<W1R:6YG("AS96QF*3H*("`@("`@("!C;W5N="`]('-E;&8N:&%S:'1A8FQE
M*"E;)U]-7V5L96UE;G1?8V]U;G0G70H@("`@("`@(')E='5R;B`G)7,@=VET
M:"`E<R<@)2`H<V5L9BYT>7!E;F%M92P@;G5M7V5L96UE;G1S*&-O=6YT*2D*
M"B`@("!`<W1A=&EC;65T:&]D"B`@("!D968@9FQA='1E;B`H;&ES="DZ"B`@
M("`@("`@9F]R(&5L="!I;B!L:7-T.@H@("`@("`@("`@("!F;W(@:2!I;B!E
M;'0Z"B`@("`@("`@("`@("`@("!Y:65L9"!I"@H@("`@0'-T871I8VUE=&AO
M9`H@("`@9&5F(&9O<FUA=%]O;F4@*&5L="DZ"B`@("`@("`@<F5T=7)N("AE
M;'1;)V9I<G-T)UTL(&5L=%LG<V5C;VYD)UTI"@H@("`@0'-T871I8VUE=&AO
M9`H@("`@9&5F(&9O<FUA=%]C;W5N="`H:2DZ"B`@("`@("`@<F5T=7)N("=;
M)61=)R`E(&D*"B`@("!D968@8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(&-O
M=6YT97(@/2!I;6%P("AS96QF+F9O<FUA=%]C;W5N="P@:71E<G1O;VQS+F-O
M=6YT*"DI"B`@("`@("`@(R!-87`@;W9E<B!T:&4@:&%S:"!T86)L92!A;F0@
M9FQA='1E;B!T:&4@<F5S=6QT+@H@("`@("`@(&EF('-E;&8N='EP96YA;64N
M<W1A<G1S=VET:"@G<W1D.CIT<C$G*3H*("`@("`@("`@("`@9&%T82`]('-E
M;&8N9FQA='1E;B`H:6UA<"`H<V5L9BYF;W)M871?;VYE+"!4<C%(87-H=&%B
M;&5)=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI*0H@("`@("`@("`@("`C
M(%II<"!T:&4@='=O(&ET97)A=&]R<R!T;V=E=&AE<BX*("`@("`@("`@("`@
M<F5T=7)N(&EZ:7`@*&-O=6YT97(L(&1A=&$I"B`@("`@("`@9&%T82`]('-E
M;&8N9FQA='1E;B`H:6UA<"`H<V5L9BYF;W)M871?;VYE+"!3=&1(87-H=&%B
M;&5)=&5R871O<B`H<V5L9BYH87-H=&%B;&4H*2DI*0H@("`@("`@(",@6FEP
M('1H92!T=V\@:71E<F%T;W)S('1O9V5T:&5R+@H@("`@("`@(')E='5R;B!I
M>FEP("AC;W5N=&5R+"!D871A*0H*("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E
M;&8I.@H@("`@("`@(')E='5R;B`G;6%P)PH*8VQA<W,@4W1D1F]R=V%R9$QI
M<W10<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIF;W)W87)D7VQI<W0B"@H@
M("`@8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I
M;FET7U\H<V5L9BP@;F]D971Y<&4L(&AE860I.@H@("`@("`@("`@("!S96QF
M+FYO9&5T>7!E(#T@;F]D971Y<&4*("`@("`@("`@("`@<V5L9BYB87-E(#T@
M:&5A9%LG7TU?;F5X="=="B`@("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@
M("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N
M('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@
M("!I9B!S96QF+F)A<V4@/3T@,#H*("`@("`@("`@("`@("`@(')A:7-E(%-T
M;W!)=&5R871I;VX*("`@("`@("`@("`@96QT(#T@<V5L9BYB87-E+F-A<W0H
M<V5L9BYN;V1E='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!S96QF
M+F)A<V4@/2!E;'1;)U]-7VYE>'0G70H@("`@("`@("`@("!C;W5N="`]('-E
M;&8N8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@
M*R`Q"B`@("`@("`@("`@('9A;'!T<B`](&5L=%LG7TU?<W1O<F%G92==+F%D
M9')E<W,*("`@("`@("`@("`@=F%L<'1R(#T@=F%L<'1R+F-A<W0H96QT+G1Y
M<&4N=&5M<&QA=&5?87)G=6UE;G0H,"DN<&]I;G1E<B@I*0H@("`@("`@("`@
M("!R971U<FX@*"=;)61=)R`E(&-O=6YT+"!V86QP='(N9&5R969E<F5N8V4H
M*2D*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@
M("`@("`@<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N86UE(#T@
M<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*"B`@("!D968@
M8VAI;&1R96XH<V5L9BDZ"B`@("`@("`@;F]D971Y<&4@/2!F:6YD7W1Y<&4H
M<V5L9BYV86PN='EP92P@)U].;V1E)RD*("`@("`@("!N;V1E='EP92`](&YO
M9&5T>7!E+G-T<FEP7W1Y<&5D969S*"DN<&]I;G1E<B@I"B`@("`@("`@<F5T
M=7)N('-E;&8N7VET97)A=&]R*&YO9&5T>7!E+"!S96QF+G9A;%LG7TU?:6UP
M;"==6R=?35]H96%D)UTI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@
M("`@("!I9B!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]H96%D)UU;)U]-7VYE
M>'0G72`]/2`P.@H@("`@("`@("`@("!R971U<FX@)V5M<'1Y("5S)R`E('-E
M;&8N='EP96YA;64*("`@("`@("!R971U<FX@)R5S)R`E('-E;&8N='EP96YA
M;64*"F-L87-S(%-I;F=L94]B:D-O;G1A:6YE<E!R:6YT97(H;V)J96-T*3H*
M("`@(")"87-E(&-L87-S(&9O<B!P<FEN=&5R<R!O9B!C;VYT86EN97)S(&]F
M('-I;F=L92!O8FIE8W1S(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@=F%L
M+"!V:7HL(&AI;G0@/2!.;VYE*3H*("`@("`@("!S96QF+F-O;G1A:6YE9%]V
M86QU92`]('9A;`H@("`@("`@('-E;&8N=FES=6%L:7IE<B`]('9I>@H@("`@
M("`@('-E;&8N:&EN="`](&AI;G0*"B`@("!D968@7W)E8V]G;FEZ92AS96QF
M+"!T>7!E*3H*("`@("`@("`B(B)2971U<FX@5%E012!A<R!A('-T<FEN9R!A
M9G1E<B!A<'!L>6EN9R!T>7!E('!R:6YT97)S(B(B"B`@("`@("`@9VQO8F%L
M(%]U<V5?='EP95]P<FEN=&EN9PH@("`@("`@(&EF(&YO="!?=7-E7W1Y<&5?
M<')I;G1I;F<Z"B`@("`@("`@("`@(')E='5R;B!S='(H='EP92D*("`@("`@
M("!R971U<FX@9V1B+G1Y<&5S+F%P<&QY7W1Y<&5?<F5C;V=N:7IE<G,H9V1B
M+G1Y<&5S+F=E=%]T>7!E7W)E8V]G;FEZ97)S*"DL"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@('1Y<&4I(&]R('-T
M<BAT>7!E*0H*("`@(&-L87-S(%]C;VYT86EN960H271E<F%T;W(I.@H@("`@
M("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@=F%L*3H*("`@("`@("`@("`@<V5L
M9BYV86P@/2!V86P*"B`@("`@("`@9&5F(%]?:71E<E]?("AS96QF*3H*("`@
M("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E
M;&8I.@H@("`@("`@("`@("!I9B!S96QF+G9A;"!I<R!.;VYE.@H@("`@("`@
M("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!R971V
M86P@/2!S96QF+G9A;`H@("`@("`@("`@("!S96QF+G9A;"`]($YO;F4*("`@
M("`@("`@("`@<F5T=7)N("@G6V-O;G1A:6YE9"!V86QU95TG+"!R971V86PI
M"@H@("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!I9B!S96QF+F-O
M;G1A:6YE9%]V86QU92!I<R!.;VYE.@H@("`@("`@("`@("!R971U<FX@<V5L
M9BY?8V]N=&%I;F5D("A.;VYE*0H@("`@("`@(&EF(&AA<V%T='(@*'-E;&8N
M=FES=6%L:7IE<BP@)V-H:6QD<F5N)RDZ"B`@("`@("`@("`@(')E='5R;B!S
M96QF+G9I<W5A;&EZ97(N8VAI;&1R96X@*"D*("`@("`@("!R971U<FX@<V5L
M9BY?8V]N=&%I;F5D("AS96QF+F-O;G1A:6YE9%]V86QU92D*"B`@("!D968@
M9&ES<&QA>5]H:6YT("AS96QF*3H*("`@("`@("`C(&EF(&-O;G1A:6YE9"!V
M86QU92!I<R!A(&UA<"!W92!W86YT('1O(&1I<W!L87D@:6X@=&AE('-A;64@
M=V%Y"B`@("`@("`@:68@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI
M;&1R96XG*2!A;F0@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G9&ES<&QA
M>5]H:6YT)RDZ"B`@("`@("`@("`@(')E='5R;B!S96QF+G9I<W5A;&EZ97(N
M9&ES<&QA>5]H:6YT("@I"B`@("`@("`@<F5T=7)N('-E;&8N:&EN=`H*8VQA
M<W,@4W1D17AP06YY4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0<FEN=&5R
M*3H*("`@(")0<FEN="!A('-T9#HZ86YY(&]R('-T9#HZ97AP97)I;65N=&%L
M.CIA;GDB"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L
M*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA
M;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<F4N
M<W5B*"=><W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V7&0Z.B<L
M("=S=&0Z.F5X<&5R:6UE;G1A;#HZ)RP@<V5L9BYT>7!E;F%M92P@,2D*("`@
M("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@('-E;&8N8V]N=&%I;F5D7W1Y
M<&4@/2!.;VYE"B`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@3F]N90H@("`@
M("`@('9I<W5A;&EZ97(@/2!.;VYE"B`@("`@("`@;6=R(#T@<V5L9BYV86Q;
M)U]-7VUA;F%G97(G70H@("`@("`@(&EF(&UG<B`A/2`P.@H@("`@("`@("`@
M("!F=6YC(#T@9V1B+F)L;V-K7V9O<E]P8RAI;G0H;6=R+F-A<W0H9V1B+FQO
M;VMU<%]T>7!E*"=I;G1P=')?="<I*2DI"B`@("`@("`@("`@(&EF(&YO="!F
M=6YC.@H@("`@("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@B26YV86QI
M9"!F=6YC=&EO;B!P;VEN=&5R(&EN("5S(B`E('-E;&8N='EP96YA;64I"B`@
M("`@("`@("`@(')X(#T@<B(B(BA[,'TZ.E]-86YA9V5R7UQW*SPN*CXI.CI?
M4U]M86YA9V5<*"AE;G5M("D_>S!].CI?3W`L("AC;VYS="![,'U\>S!](&-O
M;G-T*2`_7"HL("AU;FEO;B`I/WLP?3HZ7T%R9R`_7"I<*2(B(BYF;W)M870H
M='EP96YA;64I"B`@("`@("`@("`@(&T@/2!R92YM871C:"AR>"P@9G5N8RYF
M=6YC=&EO;BYN86UE*0H@("`@("`@("`@("!I9B!N;W0@;3H*("`@("`@("`@
M("`@("`@(')A:7-E(%9A;'5E17)R;W(H(E5N:VYO=VX@;6%N86=E<B!F=6YC
M=&EO;B!I;B`E<R(@)2!S96QF+G1Y<&5N86UE*0H*("`@("`@("`@("`@;6=R
M;F%M92`](&TN9W)O=7`H,2D*("`@("`@("`@("`@(R!&25A-12!N965D('1O
M(&5X<&%N9"`G<W1D.CIS=')I;F<G('-O('1H870@9V1B+FQO;VMU<%]T>7!E
M('=O<FMS"B`@("`@("`@("`@(&EF("=S=&0Z.G-T<FEN9R<@:6X@;6=R;F%M
M93H*("`@("`@("`@("`@("`@(&UG<FYA;64@/2!R92YS=6(H(G-T9#HZ<W1R
M:6YG*#\A7'<I(BP@<W1R*&=D8BYL;V]K=7!?='EP92@G<W1D.CIS=')I;F<G
M*2YS=')I<%]T>7!E9&5F<R@I*2P@;2YG<F]U<"@Q*2D*"B`@("`@("`@("`@
M(&UG<G1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H;6=R;F%M92D*("`@("`@("`@
M("`@<V5L9BYC;VYT86EN961?='EP92`](&UG<G1Y<&4N=&5M<&QA=&5?87)G
M=6UE;G0H,"D*("`@("`@("`@("`@=F%L<'1R(#T@3F]N90H@("`@("`@("`@
M("!I9B`G.CI?36%N86=E<E]I;G1E<FYA;"<@:6X@;6=R;F%M93H*("`@("`@
M("`@("`@("`@('9A;'!T<B`]('-E;&8N=F%L6R=?35]S=&]R86=E)UU;)U]-
M7V)U9F9E<B==+F%D9')E<W,*("`@("`@("`@("`@96QI9B`G.CI?36%N86=E
M<E]E>'1E<FYA;"<@:6X@;6=R;F%M93H*("`@("`@("`@("`@("`@('9A;'!T
M<B`]('-E;&8N=F%L6R=?35]S=&]R86=E)UU;)U]-7W!T<B=="B`@("`@("`@
M("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!R86ES92!686QU945R<F]R*")5
M;FMN;W=N(&UA;F%G97(@9G5N8W1I;VX@:6X@)7,B("4@<V5L9BYT>7!E;F%M
M92D*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@=F%L<'1R+F-A<W0H
M<V5L9BYC;VYT86EN961?='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*
M("`@("`@("`@("`@=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ
M97(H8V]N=&%I;F5D7W9A;'5E*0H@("`@("`@('-U<&5R*%-T9$5X<$%N>5!R
M:6YT97(L('-E;&8I+E]?:6YI=%]?("AC;VYT86EN961?=F%L=64L('9I<W5A
M;&EZ97(I"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@:68@
M<V5L9BYC;VYT86EN961?='EP92!I<R!.;VYE.@H@("`@("`@("`@("!R971U
M<FX@)R5S(%MN;R!C;VYT86EN960@=F%L=65=)R`E('-E;&8N='EP96YA;64*
M("`@("`@("!D97-C(#T@(B5S(&-O;G1A:6YI;F<@(B`E('-E;&8N='EP96YA
M;64*("`@("`@("!I9B!H87-A='1R("AS96QF+G9I<W5A;&EZ97(L("=C:&EL
M9')E;B<I.@H@("`@("`@("`@("!R971U<FX@9&5S8R`K('-E;&8N=FES=6%L
M:7IE<BYT;U]S=')I;F<@*"D*("`@("`@("!V86QT>7!E(#T@<V5L9BY?<F5C
M;V=N:7IE("AS96QF+F-O;G1A:6YE9%]T>7!E*0H@("`@("`@(')E='5R;B!D
M97-C("L@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AS='(H=F%L='EP92DI
M"@IC;&%S<R!3=&1%>'!/<'1I;VYA;%!R:6YT97(H4VEN9VQE3V)J0V]N=&%I
M;F5R4')I;G1E<BDZ"B`@("`B4')I;G0@82!S=&0Z.F]P=&EO;F%L(&]R('-T
M9#HZ97AP97)I;65N=&%L.CIO<'1I;VYA;"(*"B`@("!D968@7U]I;FET7U\@
M*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('9A;'1Y<&4@/2!S96QF
M+E]R96-O9VYI>F4@*'9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I*0H@
M("`@("`@('1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT
M>7!E;F%M92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<F4N<W5B*"=><W1D
M.CHH97AP97)I;65N=&%L.CI\*2AF=6YD86UE;G1A;'-?=EQD.CI\*2@N*BDG
M+"!R)W-T9#HZ7#%<,SPE<SXG("4@=F%L='EP92P@='EP96YA;64L(#$I"B`@
M("`@("`@<&%Y;&]A9"`]('9A;%LG7TU?<&%Y;&]A9"=="B`@("`@("`@:68@
M<V5L9BYT>7!E;F%M92YS=&%R='-W:71H*"=S=&0Z.F5X<&5R:6UE;G1A;"<I
M.@H@("`@("`@("`@("!E;F=A9V5D(#T@=F%L6R=?35]E;F=A9V5D)UT*("`@
M("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@<&%Y;&]A9`H@("`@("`@(&5L
M<V4Z"B`@("`@("`@("`@(&5N9V%G960@/2!P87EL;V%D6R=?35]E;F=A9V5D
M)UT*("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@<&%Y;&]A9%LG7TU?
M<&%Y;&]A9"=="B`@("`@("`@("`@('1R>3H*("`@("`@("`@("`@("`@(",@
M4VEN8V4@1T-#(#D*("`@("`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`]
M(&-O;G1A:6YE9%]V86QU95LG7TU?=F%L=64G70H@("`@("`@("`@("!E>&-E
M<'0Z"B`@("`@("`@("`@("`@("!P87-S"B`@("`@("`@=FES=6%L:7IE<B`]
M(&=D8BYD969A=6QT7W9I<W5A;&EZ97(@*&-O;G1A:6YE9%]V86QU92D*("`@
M("`@("!I9B!N;W0@96YG86=E9#H*("`@("`@("`@("`@8V]N=&%I;F5D7W9A
M;'5E(#T@3F]N90H@("`@("`@('-U<&5R("A3=&1%>'!/<'1I;VYA;%!R:6YT
M97(L('-E;&8I+E]?:6YI=%]?("AC;VYT86EN961?=F%L=64L('9I<W5A;&EZ
M97(I"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@:68@<V5L
M9BYC;VYT86EN961?=F%L=64@:7,@3F]N93H*("`@("`@("`@("`@<F5T=7)N
M("(E<R!;;F\@8V]N=&%I;F5D('9A;'5E72(@)2!S96QF+G1Y<&5N86UE"B`@
M("`@("`@:68@:&%S871T<B`H<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG
M*3H*("`@("`@("`@("`@<F5T=7)N("(E<R!C;VYT86EN:6YG("5S(B`E("AS
M96QF+G1Y<&5N86UE+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@('-E;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H*2D*("`@("`@
M("!R971U<FX@<V5L9BYT>7!E;F%M90H*8VQA<W,@4W1D5F%R:6%N=%!R:6YT
M97(H4VEN9VQE3V)J0V]N=&%I;F5R4')I;G1E<BDZ"B`@("`B4')I;G0@82!S
M=&0Z.G9A<FEA;G0B"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE
M+"!V86PI.@H@("`@("`@(&%L=&5R;F%T:79E<R`](&=E=%]T96UP;&%T95]A
M<F=?;&ES="AV86PN='EP92D*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R
M:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF
M+G1Y<&5N86UE(#T@(B5S/"5S/B(@)2`H<V5L9BYT>7!E;F%M92P@)RP@)RYJ
M;VEN*%MS96QF+E]R96-O9VYI>F4H86QT*2!F;W(@86QT(&EN(&%L=&5R;F%T
M:79E<UTI*0H@("`@("`@('-E;&8N:6YD97@@/2!V86Q;)U]-7VEN9&5X)UT*
M("`@("`@("!I9B!S96QF+FEN9&5X(#X](&QE;BAA;'1E<FYA=&EV97,I.@H@
M("`@("`@("`@("!S96QF+F-O;G1A:6YE9%]T>7!E(#T@3F]N90H@("`@("`@
M("`@("!C;VYT86EN961?=F%L=64@/2!.;VYE"B`@("`@("`@("`@('9I<W5A
M;&EZ97(@/2!.;VYE"B`@("`@("`@96QS93H*("`@("`@("`@("`@<V5L9BYC
M;VYT86EN961?='EP92`](&%L=&5R;F%T:79E<UMI;G0H<V5L9BYI;F1E>"E=
M"B`@("`@("`@("`@(&%D9'(@/2!V86Q;)U]-7W4G75LG7TU?9FER<W0G75LG
M7TU?<W1O<F%G92==+F%D9')E<W,*("`@("`@("`@("`@8V]N=&%I;F5D7W9A
M;'5E(#T@861D<BYC87-T*'-E;&8N8V]N=&%I;F5D7W1Y<&4N<&]I;G1E<B@I
M*2YD97)E9F5R96YC92@I"B`@("`@("`@("`@('9I<W5A;&EZ97(@/2!G9&(N
M9&5F875L=%]V:7-U86QI>F5R*&-O;G1A:6YE9%]V86QU92D*("`@("`@("!S
M=7!E<B`H4W1D5F%R:6%N=%!R:6YT97(L('-E;&8I+E]?:6YI=%]?*&-O;G1A
M:6YE9%]V86QU92P@=FES=6%L:7IE<BP@)V%R<F%Y)RD*"B`@("!D968@=&]?
M<W1R:6YG*'-E;&8I.@H@("`@("`@(&EF('-E;&8N8V]N=&%I;F5D7W9A;'5E
M(&ES($YO;F4Z"B`@("`@("`@("`@(')E='5R;B`B)7,@6VYO(&-O;G1A:6YE
M9"!V86QU95TB("4@<V5L9BYT>7!E;F%M90H@("`@("`@(&EF(&AA<V%T='(H
M<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG*3H*("`@("`@("`@("`@<F5T
M=7)N("(E<R!;:6YD97@@)61=(&-O;G1A:6YI;F<@)7,B("4@*'-E;&8N='EP
M96YA;64L('-E;&8N:6YD97@L"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("!S96QF+G9I<W5A;&EZ97(N=&]?
M<W1R:6YG*"DI"B`@("`@("`@<F5T=7)N("(E<R!;:6YD97@@)61=(B`E("AS
M96QF+G1Y<&5N86UE+"!S96QF+FEN9&5X*0H*8VQA<W,@4W1D3F]D94AA;F1L
M95!R:6YT97(H4VEN9VQE3V)J0V]N=&%I;F5R4')I;G1E<BDZ"B`@("`B4')I
M;G0@82!C;VYT86EN97(@;F]D92!H86YD;&4B"@H@("`@9&5F(%]?:6YI=%]?
M*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L=65?='EP
M92`]('9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#$I"B`@("`@("`@;F]D
M971Y<&4@/2!V86PN='EP92YT96UP;&%T95]A<F=U;65N="@R*2YT96UP;&%T
M95]A<F=U;65N="@P*0H@("`@("`@('-E;&8N:7-?<F)?=')E95]N;V1E(#T@
M:7-?<W!E8VEA;&EZ871I;VY?;V8H;F]D971Y<&4N;F%M92P@)U]28E]T<F5E
M7VYO9&4G*0H@("`@("`@('-E;&8N:7-?;6%P7VYO9&4@/2!V86PN='EP92YT
M96UP;&%T95]A<F=U;65N="@P*2`A/2!S96QF+G9A;'5E7W1Y<&4*("`@("`@
M("!N;V1E<'1R(#T@=F%L6R=?35]P='(G70H@("`@("`@(&EF(&YO9&5P='(Z
M"B`@("`@("`@("`@(&EF('-E;&8N:7-?<F)?=')E95]N;V1E.@H@("`@("`@
M("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@9V5T7W9A;'5E7V9R;VU?4F)?
M=')E95]N;V1E*&YO9&5P='(N9&5R969E<F5N8V4H*2D*("`@("`@("`@("`@
M96QS93H*("`@("`@("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`](&=E=%]V
M86QU95]F<F]M7V%L:6=N961?;65M8G5F*&YO9&5P=');)U]-7W-T;W)A9V4G
M72P*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@('-E;&8N=F%L=65?='EP92D*("`@("`@
M("`@("`@=FES=6%L:7IE<B`](&=D8BYD969A=6QT7W9I<W5A;&EZ97(H8V]N
M=&%I;F5D7W9A;'5E*0H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(&-O;G1A
M:6YE9%]V86QU92`]($YO;F4*("`@("`@("`@("`@=FES=6%L:7IE<B`]($YO
M;F4*("`@("`@("!O<'1A;&QO8R`]('9A;%LG7TU?86QL;V,G70H@("`@("`@
M('-E;&8N86QL;V,@/2!O<'1A;&QO8ULG7TU?<&%Y;&]A9"==(&EF(&]P=&%L
M;&]C6R=?35]E;F=A9V5D)UT@96QS92!.;VYE"B`@("`@("`@<W5P97(H4W1D
M3F]D94AA;F1L95!R:6YT97(L('-E;&8I+E]?:6YI=%]?*&-O;G1A:6YE9%]V
M86QU92P@=FES=6%L:7IE<BP*("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@)V%R<F%Y)RD*"B`@("!D968@=&]?
M<W1R:6YG*'-E;&8I.@H@("`@("`@(&1E<V,@/2`G;F]D92!H86YD;&4@9F]R
M("<*("`@("`@("!I9B!N;W0@<V5L9BYI<U]R8E]T<F5E7VYO9&4Z"B`@("`@
M("`@("`@(&1E<V,@*ST@)W5N;W)D97)E9"`G"B`@("`@("`@:68@<V5L9BYI
M<U]M87!?;F]D93H*("`@("`@("`@("`@9&5S8R`K/2`G;6%P)SL*("`@("`@
M("!E;'-E.@H@("`@("`@("`@("!D97-C("L]("=S970G.PH*("`@("`@("!I
M9B!S96QF+F-O;G1A:6YE9%]V86QU93H*("`@("`@("`@("`@9&5S8R`K/2`G
M('=I=&@@96QE;65N="<*("`@("`@("`@("`@:68@:&%S871T<BAS96QF+G9I
M<W5A;&EZ97(L("=C:&EL9')E;B<I.@H@("`@("`@("`@("`@("`@<F5T=7)N
M("(E<R`]("5S(B`E("AD97-C+"!S96QF+G9I<W5A;&EZ97(N=&]?<W1R:6YG
M*"DI"B`@("`@("`@("`@(')E='5R;B!D97-C"B`@("`@("`@96QS93H*("`@
M("`@("`@("`@<F5T=7)N("=E;7!T>2`E<R<@)2!D97-C"@IC;&%S<R!3=&1%
M>'!3=')I;F=6:65W4')I;G1E<CH*("`@(")0<FEN="!A('-T9#HZ8F%S:6-?
M<W1R:6YG7W9I97<@;W(@<W1D.CIE>'!E<FEM96YT86PZ.F)A<VEC7W-T<FEN
M9U]V:65W(@H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A
M;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG
M("AS96QF*3H*("`@("`@("!P='(@/2!S96QF+G9A;%LG7TU?<W1R)UT*("`@
M("`@("!L96X@/2!S96QF+G9A;%LG7TU?;&5N)UT*("`@("`@("!I9B!H87-A
M='1R("AP='(L(")L87IY7W-T<FEN9R(I.@H@("`@("`@("`@("!R971U<FX@
M<'1R+FQA>GE?<W1R:6YG("AL96YG=&@@/2!L96XI"B`@("`@("`@<F5T=7)N
M('!T<BYS=')I;F<@*&QE;F=T:"`](&QE;BD*"B`@("!D968@9&ES<&QA>5]H
M:6YT("AS96QF*3H*("`@("`@("!R971U<FX@)W-T<FEN9R<*"F-L87-S(%-T
M9$5X<%!A=&A0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIE>'!E<FEM96YT
M86PZ.F9I;&5S>7-T96TZ.G!A=&@B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF
M+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@
M("`@('-T87)T(#T@<V5L9BYV86Q;)U]-7V-M<'1S)UU;)U]-7VEM<&PG75LG
M7TU?<W1A<G0G70H@("`@("`@(&9I;FES:"`]('-E;&8N=F%L6R=?35]C;7!T
M<R==6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="B`@("`@("`@<V5L9BYN=6U?
M8VUP=',@/2!I;G0@*&9I;FES:"`M('-T87)T*0H*("`@(&1E9B!?<&%T:%]T
M>7!E*'-E;&8I.@H@("`@("`@('0@/2!S='(H<V5L9BYV86Q;)U]-7W1Y<&4G
M72D*("`@("`@("!I9B!T6RTY.ET@/3T@)U]2;V]T7V1I<B<Z"B`@("`@("`@
M("`@(')E='5R;B`B<F]O="UD:7)E8W1O<GDB"B`@("`@("`@:68@=%LM,3`Z
M72`]/2`G7U)O;W1?;F%M92<Z"B`@("`@("`@("`@(')E='5R;B`B<F]O="UN
M86UE(@H@("`@("`@(')E='5R;B!.;VYE"@H@("`@9&5F('1O7W-T<FEN9R`H
M<V5L9BDZ"B`@("`@("`@<&%T:"`]("(E<R(@)2!S96QF+G9A;"!;)U]-7W!A
M=&AN86UE)UT*("`@("`@("!I9B!S96QF+FYU;5]C;7!T<R`]/2`P.@H@("`@
M("`@("`@("!T(#T@<V5L9BY?<&%T:%]T>7!E*"D*("`@("`@("`@("`@:68@
M=#H*("`@("`@("`@("`@("`@('!A=&@@/2`G)7,@6R5S72<@)2`H<&%T:"P@
M="D*("`@("`@("!R971U<FX@(F9I;&5S>7-T96TZ.G!A=&@@)7,B("4@<&%T
M:`H*("`@(&-L87-S(%]I=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L(&-M<'1S*3H*("`@("`@("`@("`@<V5L9BYI=&5M
M(#T@8VUP='-;)U]-7VEM<&PG75LG7TU?<W1A<G0G70H@("`@("`@("`@("!S
M96QF+F9I;FES:"`](&-M<'1S6R=?35]I;7!L)UU;)U]-7V9I;FES:"=="B`@
M("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?
M7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F
M(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF+FET96T@/3T@
M<V5L9BYF:6YI<V@Z"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T
M:6]N"B`@("`@("`@("`@(&ET96T@/2!S96QF+FET96TN9&5R969E<F5N8V4H
M*0H@("`@("`@("`@("!C;W5N="`]('-E;&8N8V]U;G0*("`@("`@("`@("`@
M<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"B`@("`@("`@("`@('-E;&8N
M:71E;2`]('-E;&8N:71E;2`K(#$*("`@("`@("`@("`@<&%T:"`](&ET96U;
M)U]-7W!A=&AN86UE)UT*("`@("`@("`@("`@="`](%-T9$5X<%!A=&A0<FEN
M=&5R*&ET96TN='EP92YN86UE+"!I=&5M*2Y?<&%T:%]T>7!E*"D*("`@("`@
M("`@("`@:68@;F]T('0Z"B`@("`@("`@("`@("`@("!T(#T@8V]U;G0*("`@
M("`@("`@("`@<F5T=7)N("@G6R5S72<@)2!T+"!P871H*0H*("`@(&1E9B!C
M:&EL9')E;BAS96QF*3H*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T;W(H
M<V5L9BYV86Q;)U]-7V-M<'1S)UTI"@IC;&%S<R!3=&10871H4')I;G1E<CH*
M("`@(")0<FEN="!A('-T9#HZ9FEL97-Y<W1E;3HZ<&%T:"(*"B`@("!D968@
M7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('1Y<&5N86UE"B`@
M("`@("`@:6UP;"`]('-E;&8N=F%L6R=?35]C;7!T<R==6R=?35]I;7!L)UU;
M)U]-7W0G75LG7TU?="==6R=?35]H96%D7VEM<&PG70H@("`@("`@('-E;&8N
M='EP92`](&EM<&PN8V%S="AG9&(N;&]O:W5P7W1Y<&4H)W5I;G1P=')?="<I
M*2`F(#,*("`@("`@("!I9B!S96QF+G1Y<&4@/3T@,#H*("`@("`@("`@("`@
M<V5L9BYI;7!L(#T@:6UP;`H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@('-E
M;&8N:6UP;"`]($YO;F4*"B`@("!D968@7W!A=&A?='EP92AS96QF*3H*("`@
M("`@("!T(#T@<W1R*'-E;&8N='EP92YC87-T*&=D8BYL;V]K=7!?='EP92AS
M96QF+G1Y<&5N86UE("L@)SHZ7U1Y<&4G*2DI"B`@("`@("`@:68@=%LM.3I=
M(#T]("=?4F]O=%]D:7(G.@H@("`@("`@("`@("!R971U<FX@(G)O;W0M9&ER
M96-T;W)Y(@H@("`@("`@(&EF('1;+3$P.ET@/3T@)U]2;V]T7VYA;64G.@H@
M("`@("`@("`@("!R971U<FX@(G)O;W0M;F%M92(*("`@("`@("!R971U<FX@
M3F]N90H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@('!A=&@@
M/2`B)7,B("4@<V5L9BYV86P@6R=?35]P871H;F%M92=="B`@("`@("`@:68@
M<V5L9BYT>7!E("$](#`Z"B`@("`@("`@("`@('0@/2!S96QF+E]P871H7W1Y
M<&4H*0H@("`@("`@("`@("!I9B!T.@H@("`@("`@("`@("`@("`@<&%T:"`]
M("<E<R!;)7-=)R`E("AP871H+"!T*0H@("`@("`@(')E='5R;B`B9FEL97-Y
M<W1E;3HZ<&%T:"`E<R(@)2!P871H"@H@("`@8VQA<W,@7VET97)A=&]R*$ET
M97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@:6UP;"P@<&%T
M:'1Y<&4I.@H@("`@("`@("`@("!I9B!I;7!L.@H@("`@("`@("`@("`@("`@
M(R!792!C86XG="!A8V-E<W,@7TEM<&PZ.E]-7W-I>F4@8F5C875S92!?26UP
M;"!I<R!I;F-O;7!L971E"B`@("`@("`@("`@("`@("`C('-O(&-A<W0@=&\@
M:6YT*B!T;R!A8V-E<W,@=&AE(%]-7W-I>F4@;65M8F5R(&%T(&]F9G-E="!Z
M97)O+`H@("`@("`@("`@("`@("`@:6YT7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y
M<&4H)VEN="<I"B`@("`@("`@("`@("`@("!C;7!T7W1Y<&4@/2!G9&(N;&]O
M:W5P7W1Y<&4H<&%T:'1Y<&4K)SHZ7T-M<'0G*0H@("`@("`@("`@("`@("`@
M8VAA<E]T>7!E(#T@9V1B+FQO;VMU<%]T>7!E*"=C:&%R)RD*("`@("`@("`@
M("`@("`@(&EM<&P@/2!I;7!L+F-A<W0H:6YT7W1Y<&4N<&]I;G1E<B@I*0H@
M("`@("`@("`@("`@("`@<VEZ92`](&EM<&PN9&5R969E<F5N8V4H*0H@("`@
M("`@("`@("`@("`@(W-E;&8N8V%P86-I='D@/2`H:6UP;"`K(#$I+F1E<F5F
M97)E;F-E*"D*("`@("`@("`@("`@("`@(&EF(&AA<V%T='(H9V1B+E1Y<&4L
M("=A;&EG;F]F)RDZ"B`@("`@("`@("`@("`@("`@("`@<VEZ96]F7TEM<&P@
M/2!M87@H,B`J(&EN=%]T>7!E+G-I>F5O9BP@8VUP=%]T>7!E+F%L:6=N;V8I
M"B`@("`@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@("`@('-I
M>F5O9E]);7!L(#T@,B`J(&EN=%]T>7!E+G-I>F5O9@H@("`@("`@("`@("`@
M("`@8F5G:6X@/2!I;7!L+F-A<W0H8VAA<E]T>7!E+G!O:6YT97(H*2D@*R!S
M:7IE;V9?26UP;`H@("`@("`@("`@("`@("`@<V5L9BYI=&5M(#T@8F5G:6XN
M8V%S="AC;7!T7W1Y<&4N<&]I;G1E<B@I*0H@("`@("`@("`@("`@("`@<V5L
M9BYF:6YI<V@@/2!S96QF+FET96T@*R!S:7IE"B`@("`@("`@("`@("`@("!S
M96QF+F-O=6YT(#T@,`H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@
M("`@<V5L9BYI=&5M(#T@3F]N90H@("`@("`@("`@("`@("`@<V5L9BYF:6YI
M<V@@/2!.;VYE"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@
M("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I
M.@H@("`@("`@("`@("!I9B!S96QF+FET96T@/3T@<V5L9BYF:6YI<V@Z"B`@
M("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@
M(&ET96T@/2!S96QF+FET96TN9&5R969E<F5N8V4H*0H@("`@("`@("`@("!C
M;W5N="`]('-E;&8N8V]U;G0*("`@("`@("`@("`@<V5L9BYC;W5N="`]('-E
M;&8N8V]U;G0@*R`Q"B`@("`@("`@("`@('-E;&8N:71E;2`]('-E;&8N:71E
M;2`K(#$*("`@("`@("`@("`@<&%T:"`](&ET96U;)U]-7W!A=&AN86UE)UT*
M("`@("`@("`@("`@="`](%-T9%!A=&A0<FEN=&5R*&ET96TN='EP92YN86UE
M+"!I=&5M*2Y?<&%T:%]T>7!E*"D*("`@("`@("`@("`@:68@;F]T('0Z"B`@
M("`@("`@("`@("`@("!T(#T@8V]U;G0*("`@("`@("`@("`@<F5T=7)N("@G
M6R5S72<@)2!T+"!P871H*0H*("`@(&1E9B!C:&EL9')E;BAS96QF*3H*("`@
M("`@("!R971U<FX@<V5L9BY?:71E<F%T;W(H<V5L9BYI;7!L+"!S96QF+G1Y
M<&5N86UE*0H*"F-L87-S(%-T9%!A:7)0<FEN=&5R.@H@("`@(E!R:6YT(&$@
M<W1D.CIP86ER(&]B:F5C="P@=VET:"`G9FER<W0G(&%N9"`G<V5C;VYD)R!A
M<R!C:&EL9')E;B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L
M('9A;"DZ"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!C;&%S<R!?:71E
M<BA)=&5R871O<BDZ"B`@("`@("`@(D%N(&ET97)A=&]R(&9O<B!S=&0Z.G!A
M:7(@='EP97,N(%)E='5R;G,@)V9I<G-T)R!T:&5N("=S96-O;F0G+B(*"B`@
M("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L('9A;"DZ"B`@("`@("`@("`@('-E
M;&8N=F%L(#T@=F%L"B`@("`@("`@("`@('-E;&8N=VAI8V@@/2`G9FER<W0G
M"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T
M=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@
M("`@("!I9B!S96QF+G=H:6-H(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!R
M86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@('=H:6-H(#T@<V5L9BYW
M:&EC:`H@("`@("`@("`@("!I9B!W:&EC:"`]/2`G9FER<W0G.@H@("`@("`@
M("`@("`@("`@<V5L9BYW:&EC:"`]("=S96-O;F0G"B`@("`@("`@("`@(&5L
M<V4Z"B`@("`@("`@("`@("`@("!S96QF+G=H:6-H(#T@3F]N90H@("`@("`@
M("`@("!R971U<FX@*'=H:6-H+"!S96QF+G9A;%MW:&EC:%TI"@H@("`@9&5F
M(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R*'-E
M;&8N=F%L*0H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@<F5T
M=7)N($YO;F4*"@HC($$@(G)E9W5L87(@97AP<F5S<VEO;B(@<')I;G1E<B!W
M:&EC:"!C;VYF;W)M<R!T;R!T:&4*(R`B4W5B4')E='1Y4')I;G1E<B(@<')O
M=&]C;VP@9G)O;2!G9&(N<')I;G1I;F<N"F-L87-S(%)X4')I;G1E<BAO8FIE
M8W0I.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(&YA;64L(&9U;F-T:6]N*3H*
M("`@("`@("!S=7!E<BA2>%!R:6YT97(L('-E;&8I+E]?:6YI=%]?*"D*("`@
M("`@("!S96QF+FYA;64@/2!N86UE"B`@("`@("`@<V5L9BYF=6YC=&EO;B`]
M(&9U;F-T:6]N"B`@("`@("`@<V5L9BYE;F%B;&5D(#T@5')U90H*("`@(&1E
M9B!I;G9O:V4H<V5L9BP@=F%L=64I.@H@("`@("`@(&EF(&YO="!S96QF+F5N
M86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@(&EF('9A
M;'5E+G1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@
M("`@:68@:&%S871T<BAG9&(N5F%L=64L(G)E9F5R96YC961?=F%L=64B*3H*
M("`@("`@("`@("`@("`@('9A;'5E(#T@=F%L=64N<F5F97)E;F-E9%]V86QU
M92@I"@H@("`@("`@(')E='5R;B!S96QF+F9U;F-T:6]N*'-E;&8N;F%M92P@
M=F%L=64I"@HC($$@<')E='1Y+7!R:6YT97(@=&AA="!C;VYF;W)M<R!T;R!T
M:&4@(E!R971T>5!R:6YT97(B('!R;W1O8V]L(&9R;VT*(R!G9&(N<')I;G1I
M;F<N("!)="!C86X@86QS;R!B92!U<V5D(&1I<F5C=&QY(&%S(&%N(&]L9"US
M='EL92!P<FEN=&5R+@IC;&%S<R!0<FEN=&5R*&]B:F5C="DZ"B`@("!D968@
M7U]I;FET7U\H<V5L9BP@;F%M92DZ"B`@("`@("`@<W5P97(H4')I;G1E<BP@
M<V5L9BDN7U]I;FET7U\H*0H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@
M("`@("!S96QF+G-U8G!R:6YT97)S(#T@6UT*("`@("`@("!S96QF+FQO;VMU
M<"`]('M]"B`@("`@("`@<V5L9BYE;F%B;&5D(#T@5')U90H@("`@("`@('-E
M;&8N8V]M<&EL961?<G@@/2!R92YC;VUP:6QE*"=>*%MA+7I!+5HP+3E?.ETK
M*2@\+BH^*3\D)RD*"B`@("!D968@861D*'-E;&8L(&YA;64L(&9U;F-T:6]N
M*3H*("`@("`@("`C($$@<VUA;&P@<V%N:71Y(&-H96-K+@H@("`@("`@(",@
M1DE8344*("`@("`@("!I9B!N;W0@<V5L9BYC;VUP:6QE9%]R>"YM871C:"AN
M86UE*3H*("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@G;&EB<W1D8RLK
M('!R;V=R86UM:6YG(&5R<F]R.B`B)7,B(&1O97,@;F]T(&UA=&-H)R`E(&YA
M;64I"B`@("`@("`@<')I;G1E<B`](%)X4')I;G1E<BAN86UE+"!F=6YC=&EO
M;BD*("`@("`@("!S96QF+G-U8G!R:6YT97)S+F%P<&5N9"AP<FEN=&5R*0H@
M("`@("`@('-E;&8N;&]O:W5P6VYA;65=(#T@<')I;G1E<@H*("`@(",@061D
M(&$@;F%M92!U<VEN9R!?1TQ)0D-86%]"14=)3E].04U%4U!!0T5?5D524TE/
M3BX*("`@(&1E9B!A9&1?=F5R<VEO;BAS96QF+"!B87-E+"!N86UE+"!F=6YC
M=&EO;BDZ"B`@("`@("`@<V5L9BYA9&0H8F%S92`K(&YA;64L(&9U;F-T:6]N
M*0H@("`@("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@("`@
M("!V8F%S92`](')E+G-U8B@G7BAS=&1\7U]G;G5?8WAX*3HZ)RP@<B=<9SPP
M/B5S)R`E(%]V97)S:6]N961?;F%M97-P86-E+"!B87-E*0H@("`@("`@("`@
M("!S96QF+F%D9"AV8F%S92`K(&YA;64L(&9U;F-T:6]N*0H*("`@(",@061D
M(&$@;F%M92!U<VEN9R!?1TQ)0D-86%]"14=)3E].04U%4U!!0T5?0T].5$%)
M3D52+@H@("`@9&5F(&%D9%]C;VYT86EN97(H<V5L9BP@8F%S92P@;F%M92P@
M9G5N8W1I;VXI.@H@("`@("`@('-E;&8N861D7W9E<G-I;VXH8F%S92P@;F%M
M92P@9G5N8W1I;VXI"B`@("`@("`@<V5L9BYA9&1?=F5R<VEO;BAB87-E("L@
M)U]?8WAX,3DY.#HZ)RP@;F%M92P@9G5N8W1I;VXI"@H@("`@0'-T871I8VUE
M=&AO9`H@("`@9&5F(&=E=%]B87-I8U]T>7!E*'1Y<&4I.@H@("`@("`@(",@
M268@:70@<&]I;G1S('1O(&$@<F5F97)E;F-E+"!G970@=&AE(')E9F5R96YC
M92X*("`@("`@("!I9B!T>7!E+F-O9&4@/3T@9V1B+E194$5?0T]$15]2148Z
M"B`@("`@("`@("`@('1Y<&4@/2!T>7!E+G1A<F=E="`H*0H*("`@("`@("`C
M($=E="!T:&4@=6YQ=6%L:69I960@='EP92P@<W1R:7!P960@;V8@='EP961E
M9G,N"B`@("`@("`@='EP92`]('1Y<&4N=6YQ=6%L:69I960@*"DN<W1R:7!?
M='EP961E9G,@*"D*"B`@("`@("`@<F5T=7)N('1Y<&4N=&%G"@H@("`@9&5F
M(%]?8V%L;%]?*'-E;&8L('9A;"DZ"B`@("`@("`@='EP96YA;64@/2!S96QF
M+F=E=%]B87-I8U]T>7!E*'9A;"YT>7!E*0H@("`@("`@(&EF(&YO="!T>7!E
M;F%M93H*("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@(R!!;&P@
M=&AE('1Y<&5S('=E(&UA=&-H(&%R92!T96UP;&%T92!T>7!E<RP@<V\@=V4@
M8V%N('5S92!A"B`@("`@("`@(R!D:6-T:6]N87)Y+@H@("`@("`@(&UA=&-H
M(#T@<V5L9BYC;VUP:6QE9%]R>"YM871C:"AT>7!E;F%M92D*("`@("`@("!I
M9B!N;W0@;6%T8V@Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@
M(&)A<V5N86UE(#T@;6%T8V@N9W)O=7`H,2D*"B`@("`@("`@:68@=F%L+G1Y
M<&4N8V]D92`]/2!G9&(N5%E015]#3T1%7U)%1CH*("`@("`@("`@("`@:68@
M:&%S871T<BAG9&(N5F%L=64L(G)E9F5R96YC961?=F%L=64B*3H*("`@("`@
M("`@("`@("`@('9A;"`]('9A;"YR969E<F5N8V5D7W9A;'5E*"D*"B`@("`@
M("`@:68@8F%S96YA;64@:6X@<V5L9BYL;V]K=7`Z"B`@("`@("`@("`@(')E
M='5R;B!S96QF+FQO;VMU<%MB87-E;F%M95TN:6YV;VME*'9A;"D*"B`@("`@
M("`@(R!#86YN;W0@9FEN9"!A('!R971T>2!P<FEN=&5R+B`@4F5T=7)N($YO
M;F4N"B`@("`@("`@<F5T=7)N($YO;F4*"FQI8G-T9&-X>%]P<FEN=&5R(#T@
M3F]N90H*8VQA<W,@5&5M<&QA=&54>7!E4')I;G1E<BAO8FIE8W0I.@H@("`@
M<B(B(@H@("`@02!T>7!E('!R:6YT97(@9F]R(&-L87-S('1E;7!L871E<R!W
M:71H(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G1S+@H*("`@(%)E8V]G;FEZ
M97,@<W!E8VEA;&EZ871I;VYS(&]F(&-L87-S('1E;7!L871E<R!A;F0@<')I
M;G1S('1H96T@=VET:&]U=`H@("`@86YY('1E;7!L871E(&%R9W5M96YT<R!T
M:&%T('5S92!A(&1E9F%U;'0@=&5M<&QA=&4@87)G=6UE;G0N"B`@("!4>7!E
M('!R:6YT97)S(&%R92!R96-U<G-I=F5L>2!A<'!L:65D('1O('1H92!T96UP
M;&%T92!A<F=U;65N=',N"@H@("`@92YG+B!R97!L86-E(")S=&0Z.G9E8W1O
M<CQ4+"!S=&0Z.F%L;&]C871O<CQ4/B`^(B!W:71H(")S=&0Z.G9E8W1O<CQ4
M/B(N"B`@("`B(B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@9&5F
M87)G<RDZ"B`@("`@("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@('-E;&8N
M9&5F87)G<R`](&1E9F%R9W,*("`@("`@("!S96QF+F5N86)L960@/2!4<G5E
M"@H@("`@8VQA<W,@7W)E8V]G;FEZ97(H;V)J96-T*3H*("`@("`@("`B5&AE
M(')E8V]G;FEZ97(@8VQA<W,@9F]R(%1E;7!L871E5'EP95!R:6YT97(N(@H*
M("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@9&5F87)G<RDZ"B`@
M("`@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@("`@("`@<V5L9BYD
M969A<F=S(#T@9&5F87)G<PH@("`@("`@("`@("`C('-E;&8N='EP95]O8FH@
M/2!.;VYE"@H@("`@("`@(&1E9B!R96-O9VYI>F4H<V5L9BP@='EP95]O8FHI
M.@H@("`@("`@("`@("`B(B(*("`@("`@("`@("`@268@='EP95]O8FH@:7,@
M82!S<&5C:6%L:7IA=&EO;B!O9B!S96QF+FYA;64@=&AA="!U<V5S(&%L;"!T
M:&4*("`@("`@("`@("`@9&5F875L="!T96UP;&%T92!A<F=U;65N=',@9F]R
M('1H92!C;&%S<R!T96UP;&%T92P@=&AE;B!R971U<FX*("`@("`@("`@("`@
M82!S=')I;F<@<F5P<F5S96YT871I;VX@;V8@=&AE('1Y<&4@=VET:&]U="!D
M969A=6QT(&%R9W5M96YT<RX*("`@("`@("`@("`@3W1H97)W:7-E+"!R971U
M<FX@3F]N92X*("`@("`@("`@("`@(B(B"@H@("`@("`@("`@("!I9B!T>7!E
M7V]B:BYT86<@:7,@3F]N93H*("`@("`@("`@("`@("`@(')E='5R;B!.;VYE
M"@H@("`@("`@("`@("!I9B!N;W0@='EP95]O8FHN=&%G+G-T87)T<W=I=&@H
M<V5L9BYN86UE*3H*("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@
M("`@("`@("!T96UP;&%T95]A<F=S(#T@9V5T7W1E;7!L871E7V%R9U]L:7-T
M*'1Y<&5?;V)J*0H@("`@("`@("`@("!D:7-P;&%Y961?87)G<R`](%M="B`@
M("`@("`@("`@(')E<75I<F5?9&5F875L=&5D(#T@1F%L<V4*("`@("`@("`@
M("`@9F]R(&X@:6X@<F%N9V4H;&5N*'1E;7!L871E7V%R9W,I*3H*("`@("`@
M("`@("`@("`@(",@5&AE(&%C='5A;"!T96UP;&%T92!A<F=U;65N="!I;B!T
M:&4@='EP93H*("`@("`@("`@("`@("`@('1A<F<@/2!T96UP;&%T95]A<F=S
M6VY="B`@("`@("`@("`@("`@("`C(%1H92!D969A=6QT('1E;7!L871E(&%R
M9W5M96YT(&9O<B!T:&4@8VQA<W,@=&5M<&QA=&4Z"B`@("`@("`@("`@("`@
M("!D969A<F<@/2!S96QF+F1E9F%R9W,N9V5T*&XI"B`@("`@("`@("`@("`@
M("!I9B!D969A<F<@:7,@;F]T($YO;F4Z"B`@("`@("`@("`@("`@("`@("`@
M(R!3=6)S=&ET=71E(&]T:&5R('1E;7!L871E(&%R9W5M96YT<R!I;G1O('1H
M92!D969A=6QT.@H@("`@("`@("`@("`@("`@("`@(&1E9F%R9R`](&1E9F%R
M9RYF;W)M870H*G1E;7!L871E7V%R9W,I"B`@("`@("`@("`@("`@("`@("`@
M(R!&86EL('1O(')E8V]G;FEZ92!T:&4@='EP92`H8GD@<F5T=7)N:6YG($YO
M;F4I"B`@("`@("`@("`@("`@("`@("`@(R!U;FQE<W,@=&AE(&%C='5A;"!A
M<F=U;65N="!I<R!T:&4@<V%M92!A<R!T:&4@9&5F875L="X*("`@("`@("`@
M("`@("`@("`@("!T<GDZ"B`@("`@("`@("`@("`@("`@("`@("`@(&EF('1A
M<F<@(3T@9V1B+FQO;VMU<%]T>7!E*&1E9F%R9RDZ"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("!R971U<FX@3F]N90H@("`@("`@("`@("`@("`@("`@
M(&5X8V5P="!G9&(N97)R;W(Z"B`@("`@("`@("`@("`@("`@("`@("`@(",@
M5'EP92!L;V]K=7`@9F%I;&5D+"!J=7-T('5S92!S=')I;F<@8V]M<&%R:7-O
M;CH*("`@("`@("`@("`@("`@("`@("`@("`@:68@=&%R9RYT86<@(3T@9&5F
M87)G.@H@("`@("`@("`@("`@("`@("`@("`@("`@("`@<F5T=7)N($YO;F4*
M("`@("`@("`@("`@("`@("`@("`C($%L;"!S=6)S97%U96YT(&%R9W,@;75S
M="!H879E(&1E9F%U;'1S.@H@("`@("`@("`@("`@("`@("`@(')E<75I<F5?
M9&5F875L=&5D(#T@5')U90H@("`@("`@("`@("`@("`@96QI9B!R97%U:7)E
M7V1E9F%U;'1E9#H*("`@("`@("`@("`@("`@("`@("!R971U<FX@3F]N90H@
M("`@("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@("`@("`C(%)E
M8W5R<VEV96QY(&%P<&QY(')E8V]G;FEZ97)S('1O('1H92!T96UP;&%T92!A
M<F=U;65N=`H@("`@("`@("`@("`@("`@("`@(",@86YD(&%D9"!I="!T;R!T
M:&4@87)G=6UE;G1S('1H870@=VEL;"!B92!D:7-P;&%Y960Z"B`@("`@("`@
M("`@("`@("`@("`@9&ES<&QA>65D7V%R9W,N87!P96YD*'-E;&8N7W)E8V]G
M;FEZ95]S=6)T>7!E*'1A<F<I*0H*("`@("`@("`@("`@(R!4:&ES(&%S<W5M
M97,@;F\@8VQA<W,@=&5M<&QA=&5S(&EN('1H92!N97-T960M;F%M92US<&5C
M:69I97(Z"B`@("`@("`@("`@('1E;7!L871E7VYA;64@/2!T>7!E7V]B:BYT
M86=;,#IT>7!E7V]B:BYT86<N9FEN9"@G/"<I70H@("`@("`@("`@("!T96UP
M;&%T95]N86UE(#T@<W1R:7!?:6YL:6YE7VYA;65S<&%C97,H=&5M<&QA=&5?
M;F%M92D*"B`@("`@("`@("`@(')E='5R;B!T96UP;&%T95]N86UE("L@)SPG
M("L@)RP@)RYJ;VEN*&1I<W!L87EE9%]A<F=S*2`K("<^)PH*("`@("`@("!D
M968@7W)E8V]G;FEZ95]S=6)T>7!E*'-E;&8L('1Y<&5?;V)J*3H*("`@("`@
M("`@("`@(B(B0V]N=F5R="!A(&=D8BY4>7!E('1O(&$@<W1R:6YG(&)Y(&%P
M<&QY:6YG(')E8V]G;FEZ97)S+`H@("`@("`@("`@("!O<B!I9B!T:&%T(&9A
M:6QS('1H96X@<VEM<&QY(&-O;G9E<G1I;F<@=&\@82!S=')I;F<N(B(B"@H@
M("`@("`@("`@("!I9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?
M4%12.@H@("`@("`@("`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ95]S
M=6)T>7!E*'1Y<&5?;V)J+G1A<F=E="@I*2`K("<J)PH@("`@("`@("`@("!I
M9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?05)205DZ"B`@("`@
M("`@("`@("`@("!T>7!E7W-T<B`]('-E;&8N7W)E8V]G;FEZ95]S=6)T>7!E
M*'1Y<&5?;V)J+G1A<F=E="@I*0H@("`@("`@("`@("`@("`@:68@<W1R*'1Y
M<&5?;V)J+G-T<FEP7W1Y<&5D969S*"DI+F5N9'-W:71H*"=;72<I.@H@("`@
M("`@("`@("`@("`@("`@(')E='5R;B!T>7!E7W-T<B`K("=;72<@(R!A<G)A
M>2!O9B!U;FMN;W=N(&)O=6YD"B`@("`@("`@("`@("`@("!R971U<FX@(B5S
M6R5D72(@)2`H='EP95]S='(L('1Y<&5?;V)J+G)A;F=E*"E;,5T@*R`Q*0H@
M("`@("`@("`@("!I9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?
M4D5&.@H@("`@("`@("`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ95]S
M=6)T>7!E*'1Y<&5?;V)J+G1A<F=E="@I*2`K("<F)PH@("`@("`@("`@("!I
M9B!H87-A='1R*&=D8BP@)U194$5?0T]$15]25D%,545?4D5&)RDZ"B`@("`@
M("`@("`@("`@("!I9B!T>7!E7V]B:BYC;V1E(#T](&=D8BY465!%7T-/1$5?
M4E9!3%5%7U)%1CH*("`@("`@("`@("`@("`@("`@("!R971U<FX@<V5L9BY?
M<F5C;V=N:7IE7W-U8G1Y<&4H='EP95]O8FHN=&%R9V5T*"DI("L@)R8F)PH*
M("`@("`@("`@("`@='EP95]S='(@/2!G9&(N='EP97,N87!P;'E?='EP95]R
M96-O9VYI>F5R<R@*("`@("`@("`@("`@("`@("`@("!G9&(N='EP97,N9V5T
M7W1Y<&5?<F5C;V=N:7IE<G,H*2P@='EP95]O8FHI"B`@("`@("`@("`@(&EF
M('1Y<&5?<W1R.@H@("`@("`@("`@("`@("`@<F5T=7)N('1Y<&5?<W1R"B`@
M("`@("`@("`@(')E='5R;B!S='(H='EP95]O8FHI"@H@("`@9&5F(&EN<W1A
M;G1I871E*'-E;&8I.@H@("`@("`@(")2971U<FX@82!R96-O9VYI>F5R(&]B
M:F5C="!F;W(@=&AI<R!T>7!E('!R:6YT97(N(@H@("`@("`@(')E='5R;B!S
M96QF+E]R96-O9VYI>F5R*'-E;&8N;F%M92P@<V5L9BYD969A<F=S*0H*9&5F
M(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@;F%M92P@9&5F
M87)G<RDZ"B`@("!R(B(B"B`@("!!9&0@82!T>7!E('!R:6YT97(@9F]R(&$@
M8VQA<W,@=&5M<&QA=&4@=VET:"!D969A=6QT('1E;7!L871E(&%R9W5M96YT
M<RX*"B`@("!!<F=S.@H@("`@("`@(&YA;64@*'-T<BDZ(%1H92!T96UP;&%T
M92UN86UE(&]F('1H92!C;&%S<R!T96UP;&%T92X*("`@("`@("!D969A<F=S
M("AD:6-T(&EN=#IS=')I;F<I(%1H92!D969A=6QT('1E;7!L871E(&%R9W5M
M96YT<RX*"B`@("!4>7!E<R!I;B!D969A<F=S(&-A;B!R969E<B!T;R!T:&4@
M3G1H('1E;7!L871E+6%R9W5M96YT('5S:6YG('M.?0H@("`@*'=I=&@@>F5R
M;RUB87-E9"!I;F1I8V5S*2X*"B`@("!E+F<N("=U;F]R9&5R961?;6%P)R!H
M87,@=&AE<V4@9&5F87)G<SH*("`@('L@,CH@)W-T9#HZ:&%S:#Q[,'T^)RP*
M("`@("`@,SH@)W-T9#HZ97%U86Q?=&\\>S!]/B<L"B`@("`@(#0Z("=S=&0Z
M.F%L;&]C871O<CQS=&0Z.G!A:7(\8V]N<W0@>S!]+"![,7T^(#XG('T*"B`@
M("`B(B(*("`@('!R:6YT97(@/2!496UP;&%T951Y<&50<FEN=&5R*"=S=&0Z
M.B<K;F%M92P@9&5F87)G<RD*("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E
M7W!R:6YT97(H;V)J+"!P<FEN=&5R*0H*("`@(",@061D('1Y<&4@<')I;G1E
M<B!F;W(@<V%M92!T>7!E(&EN(&1E8G5G(&YA;65S<&%C93H*("`@('!R:6YT
M97(@/2!496UP;&%T951Y<&50<FEN=&5R*"=S=&0Z.E]?9&5B=6<Z.B<K;F%M
M92P@9&5F87)G<RD*("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT
M97(H;V)J+"!P<FEN=&5R*0H*("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E
M.@H@("`@("`@(",@061D('-E8V]N9"!T>7!E('!R:6YT97(@9F]R('-A;64@
M='EP92!I;B!V97)S:6]N960@;F%M97-P86-E.@H@("`@("`@(&YS(#T@)W-T
M9#HZ)R`K(%]V97)S:6]N961?;F%M97-P86-E"B`@("`@("`@(R!04B`X-C$Q
M,B!#86YN;W0@=7-E(&1I8W0@8V]M<')E:&5N<VEO;B!H97)E.@H@("`@("`@
M(&1E9F%R9W,@/2!D:6-T*"AN+"!D+G)E<&QA8V4H)W-T9#HZ)RP@;G,I*2!F
M;W(@*&XL9"D@:6X@9&5F87)G<RYI=&5M<R@I*0H@("`@("`@('!R:6YT97(@
M/2!496UP;&%T951Y<&50<FEN=&5R*&YS*VYA;64L(&1E9F%R9W,I"B`@("`@
M("`@9V1B+G1Y<&5S+G)E9VES=&5R7W1Y<&5?<')I;G1E<BAO8FHL('!R:6YT
M97(I"@IC;&%S<R!&:6QT97)I;F=4>7!E4')I;G1E<BAO8FIE8W0I.@H@("`@
M<B(B(@H@("`@02!T>7!E('!R:6YT97(@=&AA="!U<V5S('1Y<&5D968@;F%M
M97,@9F]R(&-O;6UO;B!T96UP;&%T92!S<&5C:6%L:7IA=&EO;G,N"@H@("`@
M07)G<SH*("`@("`@("!M871C:"`H<W1R*3H@5&AE(&-L87-S('1E;7!L871E
M('1O(')E8V]G;FEZ92X*("`@("`@("!N86UE("AS='(I.B!4:&4@='EP961E
M9BUN86UE('1H870@=VEL;"!B92!U<V5D(&EN<W1E860N"@H@("`@0VAE8VMS
M(&EF(&$@<W!E8VEA;&EZ871I;VX@;V8@=&AE(&-L87-S('1E;7!L871E("=M
M871C:"<@:7,@=&AE('-A;64@='EP90H@("`@87,@=&AE('1Y<&5D968@)VYA
M;64G+"!A;F0@<')I;G1S(&ET(&%S("=N86UE)R!I;G-T96%D+@H*("`@(&4N
M9RX@:68@86X@:6YS=&%N=&EA=&EO;B!O9B!S=&0Z.F)A<VEC7VES=')E86T\
M0RP@5#X@:7,@=&AE('-A;64@='EP92!A<PH@("`@<W1D.CII<W1R96%M('1H
M96X@<')I;G0@:70@87,@<W1D.CII<W1R96%M+@H@("`@(B(B"@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L(&UA=&-H+"!N86UE*3H*("`@("`@("!S96QF+FUA
M=&-H(#T@;6%T8V@*("`@("`@("!S96QF+FYA;64@/2!N86UE"B`@("`@("`@
M<V5L9BYE;F%B;&5D(#T@5')U90H*("`@(&-L87-S(%]R96-O9VYI>F5R*&]B
M:F5C="DZ"B`@("`@("`@(E1H92!R96-O9VYI>F5R(&-L87-S(&9O<B!496UP
M;&%T951Y<&50<FEN=&5R+B(*"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M(&UA=&-H+"!N86UE*3H*("`@("`@("`@("`@<V5L9BYM871C:"`](&UA=&-H
M"B`@("`@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@("`@("`@<V5L
M9BYT>7!E7V]B:B`]($YO;F4*"B`@("`@("`@9&5F(')E8V]G;FEZ92AS96QF
M+"!T>7!E7V]B:BDZ"B`@("`@("`@("`@("(B(@H@("`@("`@("`@("!)9B!T
M>7!E7V]B:B!S=&%R=',@=VET:"!S96QF+FUA=&-H(&%N9"!I<R!T:&4@<V%M
M92!T>7!E(&%S"B`@("`@("`@("`@('-E;&8N;F%M92!T:&5N(')E='5R;B!S
M96QF+FYA;64L(&]T:&5R=VES92!.;VYE+@H@("`@("`@("`@("`B(B(*("`@
M("`@("`@("`@:68@='EP95]O8FHN=&%G(&ES($YO;F4Z"B`@("`@("`@("`@
M("`@("!R971U<FX@3F]N90H*("`@("`@("`@("`@:68@<V5L9BYT>7!E7V]B
M:B!I<R!.;VYE.@H@("`@("`@("`@("`@("`@:68@;F]T('1Y<&5?;V)J+G1A
M9RYS=&%R='-W:71H*'-E;&8N;6%T8V@I.@H@("`@("`@("`@("`@("`@("`@
M(",@1FEL=&5R(&1I9&XG="!M871C:"X*("`@("`@("`@("`@("`@("`@("!R
M971U<FX@3F]N90H@("`@("`@("`@("`@("`@=')Y.@H@("`@("`@("`@("`@
M("`@("`@('-E;&8N='EP95]O8FH@/2!G9&(N;&]O:W5P7W1Y<&4H<V5L9BYN
M86UE*2YS=')I<%]T>7!E9&5F<R@I"B`@("`@("`@("`@("`@("!E>&-E<'0Z
M"B`@("`@("`@("`@("`@("`@("`@<&%S<PH@("`@("`@("`@("!I9B!S96QF
M+G1Y<&5?;V)J(#T]('1Y<&5?;V)J.@H@("`@("`@("`@("`@("`@<F5T=7)N
M('-T<FEP7VEN;&EN95]N86UE<W!A8V5S*'-E;&8N;F%M92D*("`@("`@("`@
M("`@<F5T=7)N($YO;F4*"B`@("!D968@:6YS=&%N=&EA=&4H<V5L9BDZ"B`@
M("`@("`@(E)E='5R;B!A(')E8V]G;FEZ97(@;V)J96-T(&9O<B!T:&ES('1Y
M<&4@<')I;G1E<BXB"B`@("`@("`@<F5T=7)N('-E;&8N7W)E8V]G;FEZ97(H
M<V5L9BYM871C:"P@<V5L9BYN86UE*0H*9&5F(&%D9%]O;F5?='EP95]P<FEN
M=&5R*&]B:BP@;6%T8V@L(&YA;64I.@H@("`@<')I;G1E<B`]($9I;'1E<FEN
M9U1Y<&50<FEN=&5R*"=S=&0Z.B<@*R!M871C:"P@)W-T9#HZ)R`K(&YA;64I
M"B`@("!G9&(N='EP97,N<F5G:7-T97)?='EP95]P<FEN=&5R*&]B:BP@<')I
M;G1E<BD*("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E.@H@("`@("`@(&YS
M(#T@)W-T9#HZ)R`K(%]V97)S:6]N961?;F%M97-P86-E"B`@("`@("`@<')I
M;G1E<B`]($9I;'1E<FEN9U1Y<&50<FEN=&5R*&YS("L@;6%T8V@L(&YS("L@
M;F%M92D*("`@("`@("!G9&(N='EP97,N<F5G:7-T97)?='EP95]P<FEN=&5R
M*&]B:BP@<')I;G1E<BD*"F1E9B!R96=I<W1E<E]T>7!E7W!R:6YT97)S*&]B
M:BDZ"B`@("!G;&]B86P@7W5S95]T>7!E7W!R:6YT:6YG"@H@("`@:68@;F]T
M(%]U<V5?='EP95]P<FEN=&EN9SH*("`@("`@("!R971U<FX*"B`@("`C($%D
M9"!T>7!E('!R:6YT97)S(&9O<B!T>7!E9&5F<R!S=&0Z.G-T<FEN9RP@<W1D
M.CIW<W1R:6YG(&5T8RX*("`@(&9O<B!C:"!I;B`H)R<L("=W)RP@)W4X)RP@
M)W4Q-B<L("=U,S(G*3H*("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO
M8FHL("=B87-I8U]S=')I;F<G+"!C:"`K("=S=')I;F<G*0H@("`@("`@(&%D
M9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)U]?8WAX,3$Z.F)A<VEC7W-T<FEN
M9R<L(&-H("L@)W-T<FEN9R<I"B`@("`@("`@(R!4>7!E9&5F<R!F;W(@7U]C
M>'@Q,3HZ8F%S:6-?<W1R:6YG('5S960@=&\@8F4@:6X@;F%M97-P86-E(%]?
M8WAX,3$Z"B`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G7U]C
M>'@Q,3HZ8F%S:6-?<W1R:6YG)RP*("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`G7U]C>'@Q,3HZ)R`K(&-H("L@)W-T<FEN9R<I"B`@("`@("`@861D
M7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G8F%S:6-?<W1R:6YG7W9I97<G+"!C
M:"`K("=S=')I;F=?=FEE=R<I"@H@("`@(R!!9&0@='EP92!P<FEN=&5R<R!F
M;W(@='EP961E9G,@<W1D.CII<W1R96%M+"!S=&0Z.G=I<W1R96%M(&5T8RX*
M("`@(&9O<B!C:"!I;B`H)R<L("=W)RDZ"B`@("`@("`@9F]R('@@:6X@*"=I
M;W,G+"`G<W1R96%M8G5F)RP@)VES=')E86TG+"`G;W-T<F5A;2<L("=I;W-T
M<F5A;2<L"B`@("`@("`@("`@("`@("`@("=F:6QE8G5F)RP@)VEF<W1R96%M
M)RP@)V]F<W1R96%M)RP@)V9S=')E86TG*3H*("`@("`@("`@("`@861D7V]N
M95]T>7!E7W!R:6YT97(H;V)J+"`G8F%S:6-?)R`K('@L(&-H("L@>"D*("`@
M("`@("!F;W(@>"!I;B`H)W-T<FEN9V)U9B<L("=I<W1R:6YG<W1R96%M)RP@
M)V]S=')I;F=S=')E86TG+`H@("`@("`@("`@("`@("`@("`G<W1R:6YG<W1R
M96%M)RDZ"B`@("`@("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@
M)V)A<VEC7R<@*R!X+"!C:"`K('@I"B`@("`@("`@("`@(",@/'-S=')E86T^
M('1Y<&5S(&%R92!I;B!?7V-X>#$Q(&YA;65S<&%C92P@8G5T('1Y<&5D969S
M(&%R96XG=#H*("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J
M+"`G7U]C>'@Q,3HZ8F%S:6-?)R`K('@L(&-H("L@>"D*"B`@("`C($%D9"!T
M>7!E('!R:6YT97)S(&9O<B!T>7!E9&5F<R!R96=E>"P@=W)E9V5X+"!C;6%T
M8V@L('=C;6%T8V@@971C+@H@("`@9F]R(&%B:2!I;B`H)R<L("=?7V-X>#$Q
M.CHG*3H*("`@("`@("!F;W(@8V@@:6X@*"<G+"`G=R<I.@H@("`@("`@("`@
M("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL(&%B:2`K("=B87-I8U]R96=E
M>"<L(&%B:2`K(&-H("L@)W)E9V5X)RD*("`@("`@("!F;W(@8V@@:6X@*"=C
M)RP@)W,G+"`G=V,G+"`G=W,G*3H*("`@("`@("`@("`@861D7V]N95]T>7!E
M7W!R:6YT97(H;V)J+"!A8FD@*R`G;6%T8VA?<F5S=6QT<R<L(&%B:2`K(&-H
M("L@)VUA=&-H)RD*("`@("`@("`@("`@9F]R('@@:6X@*"=S=6)?;6%T8V@G
M+"`G<F5G97A?:71E<F%T;W(G+"`G<F5G97A?=&]K96Y?:71E<F%T;W(G*3H*
M("`@("`@("`@("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@86)I
M("L@>"P@86)I("L@8V@@*R!X*0H*("`@(",@3F]T92!T:&%T('=E(&-A;B=T
M(&AA=F4@82!P<FEN=&5R(&9O<B!S=&0Z.G=S=')E86UP;W,L(&)E8V%U<V4*
M("`@(",@:70@:7,@=&AE('-A;64@='EP92!A<R!S=&0Z.G-T<F5A;7!O<RX*
M("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)V9P;W,G+"`G<W1R96%M
M<&]S)RD*"B`@("`C($%D9"!T>7!E('!R:6YT97)S(&9O<B`\8VAR;VYO/B!T
M>7!E9&5F<RX*("`@(&9O<B!D=7(@:6X@*"=N86YO<V5C;VYD<R<L("=M:6-R
M;W-E8V]N9',G+"`G;6EL;&ES96-O;F1S)RP*("`@("`@("`@("`@("`@("=S
M96-O;F1S)RP@)VUI;G5T97,G+"`G:&]U<G,G*3H*("`@("`@("!A9&1?;VYE
M7W1Y<&5?<')I;G1E<BAO8FHL("=D=7)A=&EO;B<L(&1U<BD*"B`@("`C($%D
M9"!T>7!E('!R:6YT97)S(&9O<B`\<F%N9&]M/B!T>7!E9&5F<RX*("`@(&%D
M9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)VQI;F5A<E]C;VYG<G5E;G1I86Q?
M96YG:6YE)RP@)VUI;G-T9%]R86YD,"<I"B`@("!A9&1?;VYE7W1Y<&5?<')I
M;G1E<BAO8FHL("=L:6YE87)?8V]N9W)U96YT:6%L7V5N9VEN92<L("=M:6YS
M=&1?<F%N9"<I"B`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=M97)S
M96YN95]T=VES=&5R7V5N9VEN92<L("=M=#$Y.3,W)RD*("`@(&%D9%]O;F5?
M='EP95]P<FEN=&5R*&]B:BP@)VUE<G-E;FYE7W1W:7-T97)?96YG:6YE)RP@
M)VUT,3DY,S=?-C0G*0H@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G
M<W5B=')A8W1?=VET:%]C87)R>5]E;F=I;F4G+"`G<F%N;'5X,C1?8F%S92<I
M"B`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=S=6)T<F%C=%]W:71H
M7V-A<G)Y7V5N9VEN92<L("=R86YL=7@T.%]B87-E)RD*("`@(&%D9%]O;F5?
M='EP95]P<FEN=&5R*&]B:BP@)V1I<V-A<F1?8FQO8VM?96YG:6YE)RP@)W)A
M;FQU>#(T)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)V1I<V-A
M<F1?8FQO8VM?96YG:6YE)RP@)W)A;FQU>#0X)RD*("`@(&%D9%]O;F5?='EP
M95]P<FEN=&5R*&]B:BP@)W-H=69F;&5?;W)D97)?96YG:6YE)RP@)VMN=71H
M7V(G*0H*("`@(",@061D('1Y<&4@<')I;G1E<G,@9F]R(&5X<&5R:6UE;G1A
M;#HZ8F%S:6-?<W1R:6YG7W9I97<@='EP961E9G,N"B`@("!N<R`]("=E>'!E
M<FEM96YT86PZ.F9U;F1A;65N=&%L<U]V,3HZ)PH@("`@9F]R(&-H(&EN("@G
M)RP@)W<G+"`G=3@G+"`G=3$V)RP@)W4S,B<I.@H@("`@("`@(&%D9%]O;F5?
M='EP95]P<FEN=&5R*&]B:BP@;G,@*R`G8F%S:6-?<W1R:6YG7W9I97<G+`H@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@(&YS("L@8V@@*R`G<W1R:6YG
M7W9I97<G*0H*("`@(",@1&\@;F]T('-H;W<@9&5F875L=&5D('1E;7!L871E
M(&%R9W5M96YT<R!I;B!C;&%S<R!T96UP;&%T97,N"B`@("!A9&1?;VYE7W1E
M;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=U;FEQ=65?<'1R)RP*("`@("`@
M("`@("`@>R`Q.B`G<W1D.CID969A=6QT7V1E;&5T93Q[,'T^)R!]*0H@("`@
M861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G9&5Q=64G+"![
M(#$Z("=S=&0Z.F%L;&]C871O<CQ[,'T^)WTI"B`@("!A9&1?;VYE7W1E;7!L
M871E7W1Y<&5?<')I;G1E<BAO8FHL("=F;W)W87)D7VQI<W0G+"![(#$Z("=S
M=&0Z.F%L;&]C871O<CQ[,'T^)WTI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y
M<&5?<')I;G1E<BAO8FHL("=L:7-T)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\
M>S!]/B=]*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J
M+"`G7U]C>'@Q,3HZ;&ES="<L('L@,3H@)W-T9#HZ86QL;V-A=&]R/'LP?3XG
M?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W9E
M8W1O<B<L('L@,3H@)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O
M;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)VUA<"<L"B`@("`@("`@
M("`@('L@,CH@)W-T9#HZ;&5S<SQ[,'T^)RP*("`@("`@("`@("`@("`S.B`G
M<W1D.CIA;&QO8V%T;W(\<W1D.CIP86ER/'LP?2!C;VYS="P@>S%]/CXG('TI
M"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=M=6QT
M:6UA<"<L"B`@("`@("`@("`@('L@,CH@)W-T9#HZ;&5S<SQ[,'T^)RP*("`@
M("`@("`@("`@("`S.B`G<W1D.CIA;&QO8V%T;W(\<W1D.CIP86ER/'LP?2!C
M;VYS="P@>S%]/CXG('TI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I
M;G1E<BAO8FHL("=S970G+`H@("`@("`@("`@("![(#$Z("=S=&0Z.FQE<W,\
M>S!]/B<L(#(Z("=S=&0Z.F%L;&]C871O<CQ[,'T^)R!]*0H@("`@861D7V]N
M95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G;75L=&ES970G+`H@("`@
M("`@("`@("![(#$Z("=S=&0Z.FQE<W,\>S!]/B<L(#(Z("=S=&0Z.F%L;&]C
M871O<CQ[,'T^)R!]*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT
M97(H;V)J+"`G=6YO<F1E<F5D7VUA<"<L"B`@("`@("`@("`@('L@,CH@)W-T
M9#HZ:&%S:#Q[,'T^)RP*("`@("`@("`@("`@("`S.B`G<W1D.CIE<75A;%]T
M;SQ[,'T^)RP*("`@("`@("`@("`@("`T.B`G<W1D.CIA;&QO8V%T;W(\<W1D
M.CIP86ER/'LP?2!C;VYS="P@>S%]/CXG?2D*("`@(&%D9%]O;F5?=&5M<&QA
M=&5?='EP95]P<FEN=&5R*&]B:BP@)W5N;W)D97)E9%]M=6QT:6UA<"<L"B`@
M("`@("`@("`@('L@,CH@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@("`@("`@("`@
M("`S.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@("`@("`@("`@("`T.B`G
M<W1D.CIA;&QO8V%T;W(\<W1D.CIP86ER/'LP?2!C;VYS="P@>S%]/CXG?2D*
M("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W5N;W)D
M97)E9%]S970G+`H@("`@("`@("`@("![(#$Z("=S=&0Z.FAA<V@\>S!]/B<L
M"B`@("`@("`@("`@("`@,CH@)W-T9#HZ97%U86Q?=&\\>S!]/B<L"B`@("`@
M("`@("`@("`@,SH@)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O
M;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W5N;W)D97)E9%]M=6QT
M:7-E="<L"B`@("`@("`@("`@('L@,3H@)W-T9#HZ:&%S:#Q[,'T^)RP*("`@
M("`@("`@("`@("`R.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@("`@("`@
M("`@("`S.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H*9&5F(')E9VES=&5R
M7VQI8G-T9&-X>%]P<FEN=&5R<R`H;V)J*3H*("`@(")296=I<W1E<B!L:6)S
M=&1C*RL@<')E='1Y+7!R:6YT97)S('=I=&@@;V)J9FEL92!/8FHN(@H*("`@
M(&=L;V)A;"!?=7-E7V=D8E]P<`H@("`@9VQO8F%L(&QI8G-T9&-X>%]P<FEN
M=&5R"@H@("`@:68@7W5S95]G9&)?<'`Z"B`@("`@("`@9V1B+G!R:6YT:6YG
M+G)E9VES=&5R7W!R971T>5]P<FEN=&5R*&]B:BP@;&EB<W1D8WAX7W!R:6YT
M97(I"B`@("!E;'-E.@H@("`@("`@(&EF(&]B:B!I<R!.;VYE.@H@("`@("`@
M("`@("!O8FH@/2!G9&(*("`@("`@("!O8FHN<')E='1Y7W!R:6YT97)S+F%P
M<&5N9"AL:6)S=&1C>'A?<')I;G1E<BD*"B`@("!R96=I<W1E<E]T>7!E7W!R
M:6YT97)S*&]B:BD*"F1E9B!B=6EL9%]L:6)S=&1C>'A?9&EC=&EO;F%R>2`H
M*3H*("`@(&=L;V)A;"!L:6)S=&1C>'A?<')I;G1E<@H*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R(#T@4')I;G1E<B@B;&EB<W1D8RLK+78V(BD*"B`@("`C(&QI
M8G-T9&,K*R!O8FIE8W1S(')E<75I<FEN9R!P<F5T='DM<')I;G1I;F<N"B`@
M("`C($EN(&]R9&5R(&9R;VTZ"B`@("`C(&AT='`Z+R]G8V,N9VYU+F]R9R]O
M;FQI;F5D;V-S+VQI8G-T9&,K*R]L871E<W0M9&]X>6=E;B]A,#$X-#<N:'1M
M;`H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@
M)V)A<VEC7W-T<FEN9R<L(%-T9%-T<FEN9U!R:6YT97(I"B`@("!L:6)S=&1C
M>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CI?7V-X>#$Q.CHG+"`G8F%S
M:6-?<W1R:6YG)RP@4W1D4W1R:6YG4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)V)I='-E="<L(%-T9$)I
M='-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I
M;F5R*"=S=&0Z.B<L("=D97%U92<L(%-T9$1E<75E4')I;G1E<BD*("`@(&QI
M8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)VQI<W0G
M+"!3=&1,:7-T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C
M;VYT86EN97(H)W-T9#HZ7U]C>'@Q,3HZ)RP@)VQI<W0G+"!3=&1,:7-T4')I
M;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T
M9#HZ)RP@)VUA<"<L(%-T9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I
M;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=M=6QT:6UA<"<L(%-T9$UA
M<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R
M*"=S=&0Z.B<L("=M=6QT:7-E="<L(%-T9%-E=%!R:6YT97(I"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G<&%I<B<L(%-T
M9%!A:7)0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I
M;VXH)W-T9#HZ)RP@)W!R:6]R:71Y7W%U975E)RP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@(%-T9%-T86-K3W)1=65U95!R:6YT97(I"B`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G<75E
M=64G+"!3=&13=&%C:T]R475E=650<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R
M:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)W1U<&QE)RP@4W1D5'5P;&50
M<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G
M<W1D.CHG+"`G<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=S=&%C:R<L(%-T9%-T86-K
M3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R
M<VEO;B@G<W1D.CHG+"`G=6YI<75E7W!T<B<L(%5N:7%U95!O:6YT97)0<FEN
M=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D
M.CHG+"`G=F5C=&]R)RP@4W1D5F5C=&]R4')I;G1E<BD*("`@(",@=F5C=&]R
M/&)O;VP^"@H@("`@(R!0<FEN=&5R(')E9VES=')A=&EO;G,@9F]R(&-L87-S
M97,@8V]M<&EL960@=VET:"`M1%]'3$E"0UA87T1%0E5'+@H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.F)I='-E="<L(%-T9$)I
M='-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ9&5Q=64G+"!3=&1$97%U95!R:6YT97(I"B`@("!L:6)S=&1C
M>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ;&ES="<L(%-T9$QI<W10
M<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B
M=6<Z.FUA<"<L(%-T9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&0H)W-T9#HZ7U]D96)U9SHZ;75L=&EM87`G+"!3=&1-87!0<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.FUU
M;'1I<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R
M+F%D9"@G<W1D.CI?7V1E8G5G.CIP<FEO<FET>5]Q=65U92<L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIQ=65U92<L
M(%-T9%-T86-K3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&0H)W-T9#HZ7U]D96)U9SHZ<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIS=&%C:R<L
M(%-T9%-T86-K3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&0H)W-T9#HZ7U]D96)U9SHZ=6YI<75E7W!T<B<L(%5N:7%U95!O:6YT
M97)0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?
M9&5B=6<Z.G9E8W1O<B<L(%-T9%9E8W1O<E!R:6YT97(I"@H@("`@(R!4:&5S
M92!A<F4@=&AE(%12,2!A;F0@0RLK,3$@<')I;G1E<G,N"B`@("`C($9O<B!A
M<G)A>2`M('1H92!D969A=6QT($=$0B!P<F5T='DM<')I;G1E<B!S965M<R!R
M96%S;VYA8FQE+@H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH
M)W-T9#HZ)RP@)W-H87)E9%]P='(G+"!3:&%R9610;VEN=&5R4')I;G1E<BD*
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=W
M96%K7W!T<B<L(%-H87)E9%!O:6YT97)0<FEN=&5R*0H@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G=6YO<F1E<F5D7VUA
M<"<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N
M;W)D97)E9$UA<%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?
M8V]N=&%I;F5R*"=S=&0Z.B<L("=U;F]R9&5R961?<V5T)RP*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D4V5T4')I
M;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T
M9#HZ)RP@)W5N;W)D97)E9%]M=6QT:6UA<"<L"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9$UA<%!R:6YT97(I"B`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=U
M;F]R9&5R961?;75L=&ES970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("!4<C%5;F]R9&5R96139710<FEN=&5R*0H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G9F]R=V%R9%]L
M:7-T)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D
M1F]R=V%R9$QI<W10<FEN=&5R*0H*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@)W-H87)E9%]P='(G+"!3:&%R9610
M;VEN=&5R4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S
M:6]N*"=S=&0Z.G1R,3HZ)RP@)W=E86M?<'1R)RP@4VAA<F5D4&]I;G1E<E!R
M:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D
M.CIT<C$Z.B<L("=U;F]R9&5R961?;6%P)RP*("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9$UA<%!R:6YT97(I"B`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIT<C$Z.B<L("=U
M;F]R9&5R961?<V5T)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@(%1R,55N;W)D97)E9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I
M;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIT<C$Z.B<L("=U;F]R9&5R961?;75L
M=&EM87`G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q
M56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]M=6QT:7-E="<L
M"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R
M96139710<FEN=&5R*0H*("`@(",@5&AE<V4@87)E('1H92!#*RLQ,2!P<FEN
M=&5R(')E9VES=')A=&EO;G,@9F]R("U$7T=,24)#6%A?1$5"54<@8V%S97,N
M"B`@("`C(%1H92!T<C$@;F%M97-P86-E(&-O;G1A:6YE<G,@9&\@;F]T(&AA
M=F4@86YY(&1E8G5G(&5Q=6EV86QE;G1S+`H@("`@(R!S;R!D;R!N;W0@<F5G
M:7-T97(@<')I;G1E<G,@9F]R('1H96TN"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&0H)W-T9#HZ7U]D96)U9SHZ=6YO<F1E<F5D7VUA<"<L"B`@("`@("`@
M("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;F]R9&5R
M961?<V5T)RP*("`@("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R
M96139710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z
M.E]?9&5B=6<Z.G5N;W)D97)E9%]M=6QT:6UA<"<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T
M9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;F]R9&5R961?;75L
M=&ES970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N;W)D97)E
M9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ9F]R=V%R9%]L:7-T)RP*("`@("`@("`@("`@("`@("`@("`@
M("`@("!3=&1&;W)W87)D3&ES=%!R:6YT97(I"@H@("`@(R!,:6)R87)Y($9U
M;F1A;65N=&%L<R!44R!C;VUP;VYE;G1S"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N=&%L
M<U]V,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=A
M;GDG+"!3=&1%>'!!;GE0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7W9E<G-I;VXH)W-T9#HZ97AP97)I;65N=&%L.CIF=6YD86UE;G1A;'-?
M=C$Z.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G;W!T
M:6]N86PG+"!3=&1%>'!/<'1I;VYA;%!R:6YT97(I"B`@("!L:6)S=&1C>'A?
M<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A
M;65N=&%L<U]V,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("=B87-I8U]S=')I;F=?=FEE=R<L(%-T9$5X<%-T<FEN9U9I97=0<FEN
M=&5R*0H@("`@(R!&:6QE<WES=&5M(%13(&-O;7!O;F5N=',*("`@(&QI8G-T
M9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ
M9FEL97-Y<W1E;3HZ=C$Z.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`G<&%T:"<L(%-T9$5X<%!A=&A0<FEN=&5R*0H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ97AP97)I;65N=&%L.CIF
M:6QE<WES=&5M.CIV,3HZ7U]C>'@Q,3HZ)RP*("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("=P871H)RP@4W1D17AP4&%T:%!R:6YT97(I"B`@
M("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIF:6QE<WES
M=&5M.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@)W!A
M=&@G+"!3=&10871H4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]V97)S:6]N*"=S=&0Z.F9I;&5S>7-T96TZ.E]?8WAX,3$Z.B<L"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G<&%T:"<L(%-T9%!A=&A0
M<FEN=&5R*0H*("`@(",@0RLK,3<@8V]M<&]N96YT<PH@("`@;&EB<W1D8WAX
M7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("=A;GDG+"!3=&1%>'!!;GE0<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=O<'1I;VYA;"<L(%-T
M9$5X<$]P=&EO;F%L4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]V97)S:6]N*"=S=&0Z.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`G8F%S:6-?<W1R:6YG7W9I97<G+"!3=&1%>'!3=')I;F=6:65W
M4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G=F%R
M:6%N="<L(%-T9%9A<FEA;G10<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("=?3F]D95]H86YD;&4G+"!3=&1.;V1E2&%N9&QE4')I
M;G1E<BD*"B`@("`C($5X=&5N<VEO;G,N"B`@("!L:6)S=&1C>'A?<')I;G1E
M<BYA9&1?=F5R<VEO;B@G7U]G;G5?8WAX.CHG+"`G<VQI<W0G+"!3=&13;&ES
M=%!R:6YT97(I"@H@("`@:68@5')U93H*("`@("`@("`C(%1H97-E('-H;W5L
M9&XG="!B92!N96-E<W-A<GDL(&EF($=$0B`B<')I;G0@*FDB('=O<FME9"X*
M("`@("`@("`C($)U="!I="!O9G1E;B!D;V5S;B=T+"!S;R!H97)E('1H97D@
M87)E+@H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H
M)W-T9#HZ)RP@)U],:7-T7VET97)A=&]R)RP*("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@(%-T9$QI<W1)=&5R871O<E!R:6YT97(I
M"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D
M.CHG+"`G7TQI<W1?8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@4W1D3&ES=$ET97)A=&]R4')I;G1E
M<BD*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D
M.CHG+"`G7U)B7W1R965?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@(%-T9%)B=')E94ET97)A=&]R4')I;G1E<BD*
M("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG
M+"`G7U)B7W1R965?8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@(%-T9%)B=')E94ET97)A=&]R4')I;G1E
M<BD*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S
M=&0Z.B<L("=?1&5Q=65?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@4W1D1&5Q=65)=&5R871O<E!R:6YT97(I
M"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D
M.CHG+"`G7T1E<75E7V-O;G-T7VET97)A=&]R)RP*("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@(%-T9$1E<75E271E<F%T;W)0<FEN
M=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=?
M7V=N=5]C>'@Z.B<L("=?7VYO<FUA;%]I=&5R871O<B<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D5F5C=&]R271E<F%T;W)0
M<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N
M*"=?7V=N=5]C>'@Z.B<L("=?4VQI<W1?:71E<F%T;W(G+`H@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@(%-T9%-L:7-T271E<F%T;W)0
M<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN
M97(H)W-T9#HZ)RP@)U]&=V1?;&ES=%]I=&5R871O<B<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1&=V1,:7-T271E<F%T
M;W)0<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT
M86EN97(H)W-T9#HZ)RP@)U]&=V1?;&ES=%]C;VYS=%]I=&5R871O<B<L"B`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1&=V1,
M:7-T271E<F%T;W)0<FEN=&5R*0H*("`@("`@("`C($1E8G5G("AC;VUP:6QE
M9"!W:71H("U$7T=,24)#6%A?1$5"54<I('!R:6YT97(*("`@("`@("`C(')E
M9VES=')A=&EO;G,N"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=?
M7V=N=5]D96)U9SHZ7U-A9F5?:71E<F%T;W(G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("!3=&1$96)U9TET97)A=&]R4')I;G1E<BD*"F)U:6QD
M7VQI8G-T9&-X>%]D:6-T:6]N87)Y("@I"@``````````````````````````
M````````````````````````````````````````````````````````````
M````````````+B]P>71H;VXO;&EB<W1D8WAX+U]?:6YI=%]?+G!Y````````
M````````````````````````````````````````````````````````````
M`````````````````````````#`P,#`V-#0`,#`P,C`P,@`P,#`P,30T`#`P
M,#`P,#`P,#`Q`#$S-3$T,#,V-3$Q`#`Q-C$W,``@,```````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````````````````!U<W1A
M<B`@`&9J87)D;VX`````````````````````````````````=7-E<G,`````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````*````````````````````````
M````````````````````````````````````````````````````````````
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
M<'ET:&]N+TUA:V5F:6QE+FEN````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````P,#`P-C0T`#`P,#(P,#(`,#`P,#$T-``P,#`P,#`T-#4Q,``Q
M,S4Q-#`S-C4Q,0`P,30Q,S4`(#``````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````=7-T87(@(`!F:F%R9&]N
M`````````````````````````````````'5S97)S````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````(R!-86ME9FEL92YI;B!G96YE<F%T960@8GD@875T
M;VUA:V4@,2XQ-2XQ(&9R;VT@36%K969I;&4N86TN"B,@0&-O;F9I9W5R95]I
M;G!U=$`*"B,@0V]P>7)I9VAT("A#*2`Q.3DT+3(P,3<@1G)E92!3;V9T=V%R
M92!&;W5N9&%T:6]N+"!);F,N"@HC(%1H:7,@36%K969I;&4N:6X@:7,@9G)E
M92!S;V9T=V%R93L@=&AE($9R964@4V]F='=A<F4@1F]U;F1A=&EO;@HC(&=I
M=F5S('5N;&EM:71E9"!P97)M:7-S:6]N('1O(&-O<'D@86YD+V]R(&1I<W1R
M:6)U=&4@:70L"B,@=VET:"!O<B!W:71H;W5T(&UO9&EF:6-A=&EO;G,L(&%S
M(&QO;F<@87,@=&AI<R!N;W1I8V4@:7,@<')E<V5R=F5D+@H*(R!4:&ES('!R
M;V=R86T@:7,@9&ES=')I8G5T960@:6X@=&AE(&AO<&4@=&AA="!I="!W:6QL
M(&)E('5S969U;"P*(R!B=70@5TE42$]55"!!3ED@5T%24D%.5%DL('1O('1H
M92!E>'1E;G0@<&5R;6ET=&5D(&)Y(&QA=SL@=VET:&]U=`HC(&5V96X@=&AE
M(&EM<&QI960@=V%R<F%N='D@;V8@34520TA!3E1!0DE,2519(&]R($9)5$Y%
M4U,@1D]2($$*(R!005)424-53$%2(%!54E!/4T4N"@I`4T547TU!2T5`"@I6
M4$%42"`]($!S<F-D:7)`"F%M7U]I<U]G;G5?;6%K92`]('L@7`H@(&EF('1E
M<W0@+7H@)R0H34%+14Q%5D5,*2<[('1H96X@7`H@("`@9F%L<V4[(%P*("!E
M;&EF('1E<W0@+6X@)R0H34%+15](3U-4*2<[('1H96X@7`H@("`@=')U93L@
M7`H@(&5L:68@=&5S="`M;B`G)"A-04M%7U9%4E-)3TXI)R`F)B!T97-T("UN
M("<D*$-54D1)4BDG.R!T:&5N(%P*("`@('1R=64[(%P*("!E;'-E(%P*("`@
M(&9A;'-E.R!<"B`@9FD[(%P*?0IA;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T
M:6]N(#T@7`H@(&-A<V4@)"1[=&%R9V5T7V]P=&EO;BU](&EN(%P*("`@("`@
M/RD@.SL@7`H@("`@("`J*2!E8VAO(")A;5]?;6%K95]R=6YN:6YG7W=I=&A?
M;W!T:6]N.B!I;G1E<FYA;"!E<G)O<CH@:6YV86QI9"(@7`H@("`@("`@("`@
M("`@(")T87)G970@;W!T:6]N("<D)'MT87)G971?;W!T:6]N+7TG('-P96-I
M9FEE9"(@/B8R.R!<"B`@("`@("`@(&5X:70@,3L[(%P*("!E<V%C.R!<"B`@
M:&%S7V]P=#UN;SL@7`H@('-A;F5?;6%K969L86=S/20D34%+149,04=3.R!<
M"B`@:68@)"AA;5]?:7-?9VYU7VUA:V4I.R!T:&5N(%P*("`@('-A;F5?;6%K
M969L86=S/20D349,04=3.R!<"B`@96QS92!<"B`@("!C87-E("0D34%+149,
M04=3(&EN(%P*("`@("`@*EQ<6UP@7`E=*BD@7`H@("`@("`@(&)S/5Q<.R!<
M"B`@("`@("`@<V%N95]M86ME9FQA9W,]8'!R:6YT9B`G)7-<;B<@(B0D34%+
M149,04=3(B!<"B`@("`@("`@("!\('-E9"`B<R\D)&)S)"1B<ULD)&)S("0D
M8G,)72HO+V<B8#L[(%P*("`@(&5S86,[(%P*("!F:3L@7`H@('-K:7!?;F5X
M=#UN;SL@7`H@('-T<FEP7W1R86EL;W!T("@I(%P*("![(%P*("`@(&9L9SU@
M<')I;G1F("<E<UQN)R`B)"1F;&<B('P@<V5D(")S+R0D,2XJ)"0O+R)@.R!<
M"B`@?3L@7`H@(&9O<B!F;&<@:6X@)"1S86YE7VUA:V5F;&%G<SL@9&\@7`H@
M("`@=&5S="`D)'-K:7!?;F5X="`]('EE<R`F)B![('-K:7!?;F5X=#UN;SL@
M8V]N=&EN=64[('T[(%P*("`@(&-A<V4@)"1F;&<@:6X@7`H@("`@("`J/2I\
M+2TJ*2!C;VYT:6YU93L[(%P*("`@("`@("`M*DDI('-T<FEP7W1R86EL;W!T
M("=))SL@<VMI<%]N97AT/7EE<SL[(%P*("`@("`@+2I)/RHI('-T<FEP7W1R
M86EL;W!T("=))SL[(%P*("`@("`@("`M*D\I('-T<FEP7W1R86EL;W!T("=/
M)SL@<VMI<%]N97AT/7EE<SL[(%P*("`@("`@+2I//RHI('-T<FEP7W1R86EL
M;W!T("=/)SL[(%P*("`@("`@("`M*FPI('-T<FEP7W1R86EL;W!T("=L)SL@
M<VMI<%]N97AT/7EE<SL[(%P*("`@("`@+2IL/RHI('-T<FEP7W1R86EL;W!T
M("=L)SL[(%P*("`@("`@+5MD141M72D@<VMI<%]N97AT/7EE<SL[(%P*("`@
M("`@+5M*5%TI('-K:7!?;F5X=#UY97,[.R!<"B`@("!E<V%C.R!<"B`@("!C
M87-E("0D9FQG(&EN(%P*("`@("`@*B0D=&%R9V5T7V]P=&EO;BHI(&AA<U]O
M<'0]>65S.R!B<F5A:SL[(%P*("`@(&5S86,[(%P*("!D;VYE.R!<"B`@=&5S
M="`D)&AA<U]O<'0@/2!Y97,*86U?7VUA:V5?9')Y<G5N(#T@*'1A<F=E=%]O
M<'1I;VX];CL@)"AA;5]?;6%K95]R=6YN:6YG7W=I=&A?;W!T:6]N*2D*86U?
M7VUA:V5?:V5E<&=O:6YG(#T@*'1A<F=E=%]O<'1I;VX]:SL@)"AA;5]?;6%K
M95]R=6YN:6YG7W=I=&A?;W!T:6]N*2D*<&MG9&%T861I<B`]("0H9&%T861I
M<BDO0%!!0TM!1T5`"G!K9VEN8VQU9&5D:7(@/2`D*&EN8VQU9&5D:7(I+T!0
M04-+04=%0`IP:V=L:6)D:7(@/2`D*&QI8F1I<BDO0%!!0TM!1T5`"G!K9VQI
M8F5X96-D:7(@/2`D*&QI8F5X96-D:7(I+T!004-+04=%0`IA;5]?8V0@/2!#
M1%!!5$@](B0D>UI32%]615)324].*RY])"A0051(7U-%4$%2051/4BDB("8F
M(&-D"FEN<W1A;&Q?<VA?1$%402`]("0H:6YS=&%L;%]S:"D@+6,@+6T@-C0T
M"FEN<W1A;&Q?<VA?4%)/1U)!32`]("0H:6YS=&%L;%]S:"D@+6,*:6YS=&%L
M;%]S:%]30U))4%0@/2`D*&EN<W1A;&Q?<V@I("UC"DE.4U1!3$Q?2$5!1$52
M(#T@)"A)3E-404Q,7T1!5$$I"G1R86YS9F]R;2`]("0H<')O9W)A;5]T<F%N
M<V9O<FU?;F%M92D*3D]234%,7TE.4U1!3$P@/2`Z"E!215])3E-404Q,(#T@
M.@I03U-47TE.4U1!3$P@/2`Z"DY/4DU!3%]53DE.4U1!3$P@/2`Z"E!215]5
M3DE.4U1!3$P@/2`Z"E!/4U1?54Y)3E-404Q,(#T@.@IB=6EL9%]T<FEP;&5T
M(#T@0&)U:6QD0`IH;W-T7W1R:7!L970@/2!`:&]S=$`*=&%R9V5T7W1R:7!L
M970@/2!`=&%R9V5T0`IS=6)D:7(@/2!P>71H;VX*04-,3T-!3%]--"`]("0H
M=&]P7W-R8V1I<BDO86-L;V-A;"YM-`IA;5]?86-L;V-A;%]M-%]D97!S(#T@
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O86-X+FTT(%P*"20H=&]P7W-R8V1I
M<BDO+BXO8V]N9FEG+V5N86)L92YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O
M;F9I9R]F=71E>"YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]H=V-A
M<',N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O:6-O;G8N;30@7`H)
M)"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;&5A9"UD;W0N;30@7`H))"AT;W!?
M<W)C9&ER*2\N+B]C;VYF:6<O;&EB+6QD+FTT(%P*"20H=&]P7W-R8V1I<BDO
M+BXO8V]N9FEG+VQI8BUL:6YK+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N
M9FEG+VQI8BUP<F5F:7@N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O
M;'1H;W-T9FQA9W,N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;75L
M=&DN;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;F\M97AE8W5T86)L
M97,N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O;W9E<G)I9&4N;30@
M7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O<W1D:6YT+FTT(%P*"20H=&]P
M7W-R8V1I<BDO+BXO8V]N9FEG+W5N=VEN9%]I<&EN9F\N;30@7`H))"AT;W!?
M<W)C9&ER*2\N+B]L:6)T;V]L+FTT("0H=&]P7W-R8V1I<BDO+BXO;'1O<'1I
M;VYS+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO;'1S=6=A<BYM-"`D*'1O<%]S
M<F-D:7(I+RXN+VQT=F5R<VEO;BYM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+VQT
M?F]B<V]L971E+FTT("0H=&]P7W-R8V1I<BDO8W)O<W-C;VYF:6<N;30@7`H)
M)"AT;W!?<W)C9&ER*2]L:6YK86=E+FTT("0H=&]P7W-R8V1I<BDO86-I;F-L
M=61E+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V=C*RMF:6QT+FTT
M(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+W1L<RYM-"`D*'1O<%]S<F-D
M:7(I+RXN+V-O;F9I9R]G=&AR+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N
M9FEG+V-E="YM-"`D*'1O<%]S<F-D:7(I+V-O;F9I9W5R92YA8PIA;5]?8V]N
M9FEG=7)E7V1E<',@/2`D*&%M7U]A8VQO8V%L7VTT7V1E<',I("0H0T].1DE'
M55)%7T1%4$5.1$5.0TE%4RD@7`H))"A!0TQ/0T%,7TTT*0I$25-47T-/34U/
M3B`]("0H<W)C9&ER*2]-86ME9FEL92YA;0I#3TY&24=?2$5!1$52(#T@)"AT
M;W!?8G5I;&1D:7(I+V-O;F9I9RYH"D-/3D9)1U]#3$5!3E]&24Q%4R`]"D-/
M3D9)1U]#3$5!3E]64$%42%]&24Q%4R`]"D%-7U9?4"`]("0H86U?7W9?4%]`
M04U?5D`I"F%M7U]V7U!?(#T@)"AA;5]?=E]07T!!35]$149!54Q47U9`*0IA
M;5]?=E]07S`@/2!F86QS90IA;5]?=E]07S$@/2`Z"D%-7U9?1T5.(#T@)"AA
M;5]?=E]'14Y?0$%-7U9`*0IA;5]?=E]'14Y?(#T@)"AA;5]?=E]'14Y?0$%-
M7T1%1D%53%1?5D`I"F%M7U]V7T=%3E\P(#T@0&5C:&\@(B`@1T5.("`@("`B
M("1`.PIA;5]?=E]'14Y?,2`](`I!35]67V%T(#T@)"AA;5]?=E]A=%]`04U?
M5D`I"F%M7U]V7V%T7R`]("0H86U?7W9?871?0$%-7T1%1D%53%1?5D`I"F%M
M7U]V7V%T7S`@/2!`"F%M7U]V7V%T7S$@/2`*9&5P8V]M<"`]"F%M7U]D97!F
M:6QE<U]M87EB92`]"E-/55)#15,@/0IA;5]?8V%N7W)U;E]I;G-T86QL:6YF
M;R`](%P*("!C87-E("0D04U?55!$051%7TE.1D]?1$E2(&EN(%P*("`@(&Y\
M;F]\3D\I(&9A;'-E.SL@7`H@("`@*BD@*&EN<W1A;&PM:6YF;R`M+79E<G-I
M;VXI(#XO9&5V+VYU;&P@,CXF,3L[(%P*("!E<V%C"F%M7U]V<&%T:%]A9&I?
M<V5T=7`@/2!S<F-D:7)S=')I<#U@96-H;R`B)"AS<F-D:7(I(B!\('-E9"`G
M<WPN?"Y\9R=@.PIA;5]?=G!A=&A?861J(#T@8V%S92`D)'`@:6X@7`H@("`@
M)"AS<F-D:7(I+RHI(&8]8&5C:&\@(B0D<"(@?"!S960@(G-\7B0D<W)C9&ER
M<W1R:7`O?'PB8#L[(%P*("`@("HI(&8])"1P.SL@7`H@(&5S86,["F%M7U]S
M=')I<%]D:7(@/2!F/6!E8VAO("0D<"!\('-E9"`M92`G<WQ>+BHO?'PG8#L*
M86U?7VEN<W1A;&Q?;6%X(#T@-#`*86U?7VYO8F%S95]S=')I<%]S971U<"`]
M(%P*("!S<F-D:7)S=')I<#U@96-H;R`B)"AS<F-D:7(I(B!\('-E9"`G<R];
M72Y;7B0D7%PJ?%TO7%Q<7"8O9R=@"F%M7U]N;V)A<V5?<W1R:7`@/2!<"B`@
M9F]R('`@:6X@)"1L:7-T.R!D;R!E8VAO("(D)'`B.R!D;VYE('P@<V5D("UE
M(")S?"0D<W)C9&ER<W1R:7`O?'PB"F%M7U]N;V)A<V5?;&ES="`]("0H86U?
M7VYO8F%S95]S=')I<%]S971U<"D[(%P*("!F;W(@<"!I;B`D)&QI<W0[(&1O
M(&5C:&\@(B0D<"`D)'`B.R!D;VYE('P@7`H@('-E9"`B<WP@)"1S<F-D:7)S
M=')I<"]\('P[(B<@+R`N*EPO+R%S+R`N*B\@+B\[(',L7"@@+BI<*2];7B]=
M*B0D+%PQ+"<@?"!<"B`@)"A!5TLI("="14=)3B![(&9I;&5S6R(N(ET@/2`B
M(B!]('L@9FEL97-;)"0R72`](&9I;&5S6R0D,ET@(B`B("0D,3L@7`H@("`@
M:68@*"LK;ELD)#)=(#T]("0H86U?7VEN<W1A;&Q?;6%X*2D@7`H@("`@("![
M('!R:6YT("0D,BP@9FEL97-;)"0R73L@;ELD)#)=(#T@,#L@9FEL97-;)"0R
M72`]("(B('T@?2!<"B`@("!%3D0@>R!F;W(@*&1I<B!I;B!F:6QE<RD@<')I
M;G0@9&ER+"!F:6QE<UMD:7)=('TG"F%M7U]B87-E7VQI<W0@/2!<"B`@<V5D
M("<D)"%..R0D(4X[)"0A3CLD)"%..R0D(4X[)"0A3CLD)"%..W,O7&XO("]G
M)R!\(%P*("!S960@)R0D(4X[)"0A3CLD)"%..R0D(4X[<R]<;B\@+V<G"F%M
M7U]U;FEN<W1A;&Q?9FEL97-?9G)O;5]D:7(@/2![(%P*("!T97-T("UZ("(D
M)&9I;&5S(B!<"B`@("!\?"![('1E<W0@(2`M9"`B)"1D:7(B("8F('1E<W0@
M(2`M9B`B)"1D:7(B("8F('1E<W0@(2`M<B`B)"1D:7(B.R!](%P*("`@('Q\
M('L@96-H;R`B("@@8V0@)R0D9&ER)R`F)B!R;2`M9B(@)"1F:6QE<R`B*2([
M(%P*("`@("`@("`@)"AA;5]?8V0I("(D)&1I<B(@)B8@<FT@+68@)"1F:6QE
M<SL@?3L@7`H@('T*86U?7VEN<W1A;&QD:7)S(#T@(B0H1$535$1)4BDD*'!Y
M=&AO;F1I<BDB"D1!5$$@/2`D*&YO8F%S95]P>71H;VY?1$%402D*86U?7W1A
M9V=E9%]F:6QE<R`]("0H2$5!1$524RD@)"A33U520T53*2`D*%1!1U-?1DE,
M15,I("0H3$E34"D*04))7U1714%+4U]34D-$25(@/2!`04))7U1714%+4U]3
M4D-$25)`"D%#3$]#04P@/2!`04-,3T-!3$`*04Q,3T-!5$]27T@@/2!`04Q,
M3T-!5$]27TA`"D%,3$]#051/4E].04U%(#T@0$%,3$]#051/4E].04U%0`I!
M351!4B`]($!!351!4D`*04U?1$5&055,5%]615)"3U-)5%D@/2!`04U?1$5&
M055,5%]615)"3U-)5%E`"D%2(#T@0$%20`I!4R`]($!!4T`*051/34E#2519
M7U-20T1)4B`]($!!5$]-24-)5%E?4U)#1$E20`I!5$]-24-?1DQ!1U,@/2!`
M051/34E#7T9,04=30`I!5$]-24-?5T]21%]34D-$25(@/2!`051/34E#7U=/
M4D1?4U)#1$E20`I!551/0T].1B`]($!!551/0T].1D`*05543TA%041%4B`]
M($!!551/2$5!1$520`I!551/34%+12`]($!!551/34%+14`*05=+(#T@0$%7
M2T`*0D%324-?1DE,15]#0R`]($!"05-)0U]&24Q%7T-#0`I"05-)0U]&24Q%
M7T@@/2!`0D%324-?1DE,15](0`I#0R`]($!#0T`*0T-/1$5#5E1?0T,@/2!`
M0T-/1$5#5E1?0T-`"D-#3TQ,051%7T-#(#T@0$-#3TQ,051%7T-#0`I#0U19
M4$5?0T,@/2!`0T-465!%7T-#0`I#1DQ!1U,@/2!`0T9,04=30`I#3$]#04Q%
M7T-#(#T@0$-,3T-!3$5?0T-`"D-,3T-!3$5?2"`]($!#3$]#04Q%7TA`"D-,
M3T-!3$5?24Y415).04Q?2"`]($!#3$]#04Q%7TE.5$523D%,7TA`"D--15-3
M04=%4U]#0R`]($!#34534T%'15-?0T-`"D--15-304=%4U]((#T@0$--15-3
M04=%4U](0`I#34].15E?0T,@/2!`0TU/3D597T-#0`I#3E5-15))0U]#0R`]
M($!#3E5-15))0U]#0T`*0U!0(#T@0$-04$`*0U!01DQ!1U,@/2!`0U!01DQ!
M1U-`"D-055]$149)3D537U-20T1)4B`]($!#4%5?1$5&24Y%4U]34D-$25)`
M"D-055]/4%1?0DE44U]204Y$3TT@/2!`0U!57T]05%]"25137U)!3D1/34`*
M0U!57T]05%]%6%1?4D%.1$]-(#T@0$-055]/4%1?15A47U)!3D1/34`*0U-4
M1$E/7T@@/2!`0U-41$E/7TA`"D-424U%7T-#(#T@0$-424U%7T-#0`I#5$E-
M15]((#T@0$-424U%7TA`"D-86"`]($!#6%A`"D-86$-04"`]($!#6%A#4%!`
M"D-86$9)3%0@/2!`0UA81DE,5$`*0UA81DQ!1U,@/2!`0UA81DQ!1U-`"D-9
M1U!!5$A?5R`]($!#64=0051(7U=`"D-?24Y#3%5$15]$25(@/2!`0U])3D-,
M541%7T1)4D`*1$),051%6"`]($!$0DQ!5$580`I$14)51U]&3$%'4R`]($!$
M14)51U]&3$%'4T`*1$5&4R`]($!$14930`I$3U0@/2!`1$]40`I$3UA91T5.
M(#T@0$1/6%E'14Y`"D1364U55$E,(#T@0$1364U55$E,0`I$54U00DE.(#T@
M0$1535!"24Y`"D5#2$]?0R`]($!%0TA/7T-`"D5#2$]?3B`]($!%0TA/7TY`
M"D5#2$]?5"`]($!%0TA/7U1`"D5'4D50(#T@0$5'4D500`I%4E)/4E]#3TY3
M5$%.5%-?4U)#1$E2(#T@0$524D]27T-/3E-404Y44U]34D-$25)`"D581458
M5"`]($!%6$5%6%1`"D585%)!7T-&3$%'4R`]($!%6%1205]#1DQ!1U-`"D58
M5%)!7T-86%]&3$%'4R`]($!%6%1205]#6%A?1DQ!1U-`"D9'4D50(#T@0$9'
M4D500`I'3$E"0UA87TE.0TQ51$53(#T@0$=,24)#6%A?24Y#3%5$15-`"D=,
M24)#6%A?3$E"4R`]($!'3$E"0UA87TQ)0E-`"D=215`@/2!`1U)%4$`*2%=#
M05!?0T9,04=3(#T@0$A70T%07T-&3$%'4T`*24Y35$%,3"`]($!)3E-404Q,
M0`I)3E-404Q,7T1!5$$@/2!`24Y35$%,3%]$051!0`I)3E-404Q,7U!23T=2
M04T@/2!`24Y35$%,3%]04D]'4D%-0`I)3E-404Q,7U-#4DE05"`]($!)3E-4
M04Q,7U-#4DE05$`*24Y35$%,3%]35%))4%]04D]'4D%-(#T@0$E.4U1!3$Q?
M4U1225!?4%)/1U)!34`*3$0@/2!`3$1`"DQ$1DQ!1U,@/2!`3$1&3$%'4T`*
M3$E"24-/3E8@/2!`3$E"24-/3E9`"DQ)0D]"2E,@/2!`3$E"3T)*4T`*3$E"
M4R`]($!,24)30`I,24)43T],(#T@0$Q)0E1/3TQ`"DQ)4$\@/2!`3$E03T`*
M3$Y?4R`]($!,3E]30`I,3TY'7T1/54),15]#3TU0051?1DQ!1U,@/2!`3$].
M1U]$3U5"3$5?0T]-4$%47T9,04=30`I,5$Q)0DE#3TY6(#T@0$Q43$E"24-/
M3E9`"DQ43$E"3T)*4R`]($!,5$Q)0D]"2E-`"DU!24Y4(#T@0$U!24Y40`I-
M04M%24Y&3R`]($!-04M%24Y&3T`*34M$25)?4"`]($!-2T1)4E]00`I.32`]
M($!.34`*3DU%1$E4(#T@0$Y-141)5$`*3T)*1%5-4"`]($!/0DI$54U00`I/
M0DI%6%0@/2!`3T)*15A40`I/4%1)34E:15]#6%A&3$%'4R`]($!/4%1)34E:
M15]#6%A&3$%'4T`*3U!47TQ$1DQ!1U,@/2!`3U!47TQ$1DQ!1U-`"D]37TE.
M0U]34D-$25(@/2!`3U-?24Y#7U-20T1)4D`*3U1/3TP@/2!`3U1/3TQ`"D]4
M3T],-C0@/2!`3U1/3TPV-$`*4$%#2T%'12`]($!004-+04=%0`I004-+04=%
M7T)51U)%4$]25"`]($!004-+04=%7T)51U)%4$]25$`*4$%#2T%'15].04U%
M(#T@0%!!0TM!1T5?3D%-14`*4$%#2T%'15]35%))3D<@/2!`4$%#2T%'15]3
M5%))3D=`"E!!0TM!1T5?5$%23D%-12`]($!004-+04=%7U1!4DY!345`"E!!
M0TM!1T5?55),(#T@0%!!0TM!1T5?55),0`I004-+04=%7U9%4E-)3TX@/2!`
M4$%#2T%'15]615)324].0`I0051(7U-%4$%2051/4B`]($!0051(7U-%4$%2
M051/4D`*4$1&3$%415@@/2!`4$1&3$%415A`"E)!3DQ)0B`]($!204Y,24)`
M"E-%0U1)3TY?1DQ!1U,@/2!`4T5#5$E/3E]&3$%'4T`*4T5#5$E/3E],1$9,
M04=3(#T@0%-%0U1)3TY?3$1&3$%'4T`*4T5$(#T@0%-%1$`*4T547TU!2T4@
M/2!`4T547TU!2T5`"E-(14Q,(#T@0%-(14Q,0`I35%))4"`]($!35%))4$`*
M4UE-5D527T9)3$4@/2!`4UE-5D527T9)3$5`"E1/4$Q%5D5,7TE.0TQ51$53
M(#T@0%1/4$Q%5D5,7TE.0TQ51$530`I54T5?3DQ3(#T@0%5315].3%-`"E9%
M4E-)3TX@/2!`5D524TE/3D`*5E167T-86$9,04=3(#T@0%945E]#6%A&3$%'
M4T`*5E167T-86$Q)3DM&3$%'4R`]($!65%9?0UA83$E.2T9,04=30`I65%9?
M4$-(7T-86$9,04=3(#T@0%945E]00TA?0UA81DQ!1U-`"E=!4DY?1DQ!1U,@
M/2!`5T%23E]&3$%'4T`*6$U,0T%404Q/1R`]($!834Q#051!3$]'0`I834Q,
M24Y4(#T@0%A-3$Q)3E1`"EA33%104D]#(#T@0%A33%104D]#0`I84TQ?4U19
M3$5?1$E2(#T@0%A33%]35%E,15]$25)`"F%B<U]B=6EL9&1I<B`]($!A8G-?
M8G5I;&1D:7)`"F%B<U]S<F-D:7(@/2!`86)S7W-R8V1I<D`*86)S7W1O<%]B
M=6EL9&1I<B`]($!A8G-?=&]P7V)U:6QD9&ER0`IA8G-?=&]P7W-R8V1I<B`]
M($!A8G-?=&]P7W-R8V1I<D`*86-?8W1?0T,@/2!`86-?8W1?0T-`"F%C7V-T
M7T-86"`]($!A8U]C=%]#6%A`"F%C7V-T7T1535!"24X@/2!`86-?8W1?1%5-
M4$))3D`*86U?7VQE861I;F=?9&]T(#T@0&%M7U]L96%D:6YG7V1O=$`*86U?
M7W1A<B`]($!A;5]?=&%R0`IA;5]?=6YT87(@/2!`86U?7W5N=&%R0`IB87-E
M;&EN95]D:7(@/2!`8F%S96QI;F5?9&ER0`IB87-E;&EN95]S=6)D:7)?<W=I
M=&-H(#T@0&)A<V5L:6YE7W-U8F1I<E]S=VET8VA`"F)I;F1I<B`]($!B:6YD
M:7)`"F)U:6QD(#T@0&)U:6QD0`IB=6EL9%]A;&EA<R`]($!B=6EL9%]A;&EA
M<T`*8G5I;&1?8W!U(#T@0&)U:6QD7V-P=4`*8G5I;&1?;W,@/2!`8G5I;&1?
M;W-`"F)U:6QD7W9E;F1O<B`]($!B=6EL9%]V96YD;W)`"F)U:6QD9&ER(#T@
M0&)U:6QD9&ER0`IC:&5C:U]M<V=F;70@/2!`8VAE8VM?;7-G9FUT0`ID871A
M9&ER(#T@0&1A=&%D:7)`"F1A=&%R;V]T9&ER(#T@0&1A=&%R;V]T9&ER0`ID
M;V-D:7(@/2!`9&]C9&ER0`ID=FED:7(@/2!`9'9I9&ER0`IE;F%B;&5?<VAA
M<F5D(#T@0&5N86)L95]S:&%R961`"F5N86)L95]S=&%T:6,@/2!`96YA8FQE
M7W-T871I8T`*97AE8U]P<F5F:7@@/2!`97AE8U]P<F5F:7A`"F=E=%]G8V-?
M8F%S95]V97(@/2!`9V5T7V=C8U]B87-E7W9E<D`*9VQI8F-X>%]-3T9)3$53
M(#T@0&=L:6)C>'A?34]&24Q%4T`*9VQI8F-X>%]00TA&3$%'4R`]($!G;&EB
M8WAX7U!#2$9,04=30`IG;&EB8WAX7U!/1DE,15,@/2!`9VQI8F-X>%]03T9)
M3$530`IG;&EB8WAX7V)U:6QD9&ER(#T@0&=L:6)C>'A?8G5I;&1D:7)`"F=L
M:6)C>'A?8V]M<&EL97)?<&EC7V9L86<@/2!`9VQI8F-X>%]C;VUP:6QE<E]P
M:6-?9FQA9T`*9VQI8F-X>%]C;VUP:6QE<E]S:&%R961?9FQA9R`]($!G;&EB
M8WAX7V-O;7!I;&5R7W-H87)E9%]F;&%G0`IG;&EB8WAX7V-X>#DX7V%B:2`]
M($!G;&EB8WAX7V-X>#DX7V%B:4`*9VQI8F-X>%]L;V-A;&5D:7(@/2!`9VQI
M8F-X>%]L;V-A;&5D:7)`"F=L:6)C>'A?;'1?<&EC7V9L86<@/2!`9VQI8F-X
M>%]L=%]P:6-?9FQA9T`*9VQI8F-X>%]P<F5F:7AD:7(@/2!`9VQI8F-X>%]P
M<F5F:7AD:7)`"F=L:6)C>'A?<W)C9&ER(#T@0&=L:6)C>'A?<W)C9&ER0`IG
M;&EB8WAX7W1O;VQE>&5C9&ER(#T@0&=L:6)C>'A?=&]O;&5X96-D:7)`"F=L
M:6)C>'A?=&]O;&5X96-L:6)D:7(@/2!`9VQI8F-X>%]T;V]L97AE8VQI8F1I
M<D`*9WAX7VEN8VQU9&5?9&ER(#T@0&=X>%]I;F-L=61E7V1I<D`*:&]S="`]
M($!H;W-T0`IH;W-T7V%L:6%S(#T@0&AO<W1?86QI87-`"FAO<W1?8W!U(#T@
M0&AO<W1?8W!U0`IH;W-T7V]S(#T@0&AO<W1?;W-`"FAO<W1?=F5N9&]R(#T@
M0&AO<W1?=F5N9&]R0`IH=&UL9&ER(#T@0&AT;6QD:7)`"FEN8VQU9&5D:7(@
M/2!`:6YC;'5D961I<D`*:6YF;V1I<B`]($!I;F9O9&ER0`II;G-T86QL7W-H
M(#T@0&EN<W1A;&Q?<VA`"FQI8F1I<B`]($!L:6)D:7)`"FQI8F5X96-D:7(@
M/2!`;&EB97AE8V1I<D`*;&EB=&]O;%]615)324].(#T@0&QI8G1O;VQ?5D52
M4TE/3D`*;&]C86QE9&ER(#T@0&QO8V%L961I<D`*;&]C86QS=&%T961I<B`]
M($!L;V-A;'-T871E9&ER0`IL=%]H;W-T7V9L86=S(#T@0&QT7VAO<W1?9FQA
M9W-`"FUA;F1I<B`]($!M86YD:7)`"FUK9&ER7W`@/2!`;6MD:7)?<$`*;75L
M=&E?8F%S961I<B`]($!M=6QT:5]B87-E9&ER0`IO;&1I;F-L=61E9&ER(#T@
M0&]L9&EN8VQU9&5D:7)`"G!D9F1I<B`]($!P9&9D:7)`"G!O<G1?<W!E8VEF
M:6-?<WEM8F]L7V9I;&5S(#T@0'!O<G1?<W!E8VEF:6-?<WEM8F]L7V9I;&5S
M0`IP<F5F:7@@/2!`<')E9FEX0`IP<F]G<F%M7W1R86YS9F]R;5]N86UE(#T@
M0'!R;V=R86U?=')A;G-F;W)M7VYA;65`"G!S9&ER(#T@0'!S9&ER0`IP>71H
M;VY?;6]D7V1I<B`]($!P>71H;VY?;6]D7V1I<D`*<V)I;F1I<B`]($!S8FEN
M9&ER0`IS:&%R961S=&%T961I<B`]($!S:&%R961S=&%T961I<D`*<W)C9&ER
M(#T@0'-R8V1I<D`*<WES8V]N9F1I<B`]($!S>7-C;VYF9&ER0`IT87)G970@
M/2!`=&%R9V5T0`IT87)G971?86QI87,@/2!`=&%R9V5T7V%L:6%S0`IT87)G
M971?8W!U(#T@0'1A<F=E=%]C<'5`"G1A<F=E=%]O<R`]($!T87)G971?;W-`
M"G1A<F=E=%]V96YD;W(@/2!`=&%R9V5T7W9E;F1O<D`*=&AR96%D7VAE861E
M<B`]($!T:')E861?:&5A9&5R0`IT;W!?8G5I;&1?<')E9FEX(#T@0'1O<%]B
M=6EL9%]P<F5F:7A`"G1O<%]B=6EL9&1I<B`]($!T;W!?8G5I;&1D:7)`"G1O
M<%]S<F-D:7(@/2!`=&]P7W-R8V1I<D`*=&]P;&5V96Q?8G5I;&1D:7(@/2!`
M=&]P;&5V96Q?8G5I;&1D:7)`"G1O<&QE=F5L7W-R8V1I<B`]($!T;W!L979E
M;%]S<F-D:7)`"@HC($UA>2!B92!U<V5D(&)Y('9A<FEO=7,@<W5B<W1I='5T
M:6]N('9A<FEA8FQE<RX*9V-C7W9E<G-I;VX@.CT@)"AS:&5L;"!`9V5T7V=C
M8U]B87-E7W9E<D`@)"AT;W!?<W)C9&ER*2\N+B]G8V,O0D%312U615(I"DU!
M24Y47T-(05)3150@/2!L871I;C$*;6MI;G-T86QL9&ER<R`]("0H4TA%3$PI
M("0H=&]P;&5V96Q?<W)C9&ER*2]M:VEN<W1A;&QD:7)S"E!71%]#3TU-04Y$
M(#T@)"1[4%=$0TU$+7!W9'T*4U1!35`@/2!E8VAO('1I;65S=&%M<"`^"G1O
M;VQE>&5C9&ER(#T@)"AG;&EB8WAX7W1O;VQE>&5C9&ER*0IT;V]L97AE8VQI
M8F1I<B`]("0H9VQI8F-X>%]T;V]L97AE8VQI8F1I<BD*0$5.04),15]715)2
M3U)?1D%,4T5`5T524D]27T9,04<@/2`*0$5.04),15]715)23U)?5%)514!7
M15)23U)?1DQ!1R`]("U797)R;W(*0$5.04),15]%6%1%4DY?5$5-4$Q!5$5?
M1D%,4T5`6%1%35!,051%7T9,04=3(#T@"D!%3D%"3$5?15A415).7U1%35!,
M051%7U12545`6%1%35!,051%7T9,04=3(#T@+69N;RUI;7!L:6-I="UT96UP
M;&%T97,*"B,@5&AE<V4@8FET<R!A<F4@86QL(&9I9W5R960@;W5T(&9R;VT@
M8V]N9FEG=7)E+B`@3&]O:R!I;B!A8VEN8VQU9&4N;30*(R!O<B!C;VYF:6=U
M<F4N86,@=&\@<V5E(&AO=R!T:&5Y(&%R92!S970N("!3964@1TQ)0D-86%]%
M6%!/4E1?1DQ!1U,N"D-/3D9)1U]#6%A&3$%'4R`](%P*"20H4T5#5$E/3E]&
M3$%'4RD@)"A(5T-!4%]#1DQ!1U,I("UF<F%N9&]M+7-E960])$`*"E=!4DY?
M0UA81DQ!1U,@/2!<"@DD*%=!4DY?1DQ!1U,I("0H5T524D]27T9,04<I("UF
M9&EA9VYO<W1I8W,M<VAO=RUL;V-A=&EO;CUO;F-E(`H*"B,@+4DO+40@9FQA
M9W,@=&\@<&%S<R!W:&5N(&-O;7!I;&EN9RX*04U?0U!01DQ!1U,@/2`D*$=,
M24)#6%A?24Y#3%5$15,I("0H0U!01DQ!1U,I"D!%3D%"3$5?4%E42$].1$E2
M7T9!3%-%0'!Y=&AO;F1I<B`]("0H9&%T861I<BDO9V-C+20H9V-C7W9E<G-I
M;VXI+W!Y=&AO;@I`14Y!0DQ%7U!95$A/3D1)4E]44E5%0'!Y=&AO;F1I<B`]
M("0H<')E9FEX*2\D*'!Y=&AO;E]M;V1?9&ER*0IN;V)A<V5?<'ET:&]N7T1!
M5$$@/2!<"B`@("!L:6)S=&1C>'@O=C8O<')I;G1E<G,N<'D@7`H@("`@;&EB
M<W1D8WAX+W8V+WAM971H;V1S+G!Y(%P*("`@(&QI8G-T9&-X>"]V-B]?7VEN
M:71?7RYP>2!<"B`@("!L:6)S=&1C>'@O7U]I;FET7U\N<'D*"F%L;#H@86QL
M+6%M"@HN4U5&1DE815,Z"B0H<W)C9&ER*2]-86ME9FEL92YI;CH@0$U!24Y4
M04E.15)?34]$15]44E5%0"`D*'-R8V1I<BDO36%K969I;&4N86T@)"AT;W!?
M<W)C9&ER*2]F<F%G;65N="YA;2`D*&%M7U]C;VYF:6=U<F5?9&5P<RD*"4!F
M;W(@9&5P(&EN("0_.R!D;R!<"@D@(&-A<V4@)R0H86U?7V-O;F9I9W5R95]D
M97!S*2<@:6X@7`H)("`@("HD)&1E<"HI(%P*"2`@("`@("@@8V0@)"AT;W!?
M8G5I;&1D:7(I("8F("0H34%+12D@)"A!35]-04M%1DQ!1U,I(&%M+2UR969R
M97-H("D@7`H)("`@("`@("`F)B![(&EF('1E<W0@+68@)$`[('1H96X@97AI
M="`P.R!E;'-E(&)R96%K.R!F:3L@?3L@7`H)("`@("`@97AI="`Q.SL@7`H)
M("!E<V%C.R!<"@ED;VYE.R!<"@EE8VAO("<@8V0@)"AT;W!?<W)C9&ER*2`F
M)B`D*$%55$]-04M%*2`M+69O<F5I9VX@+2UI9VYO<F4M9&5P<R!P>71H;VXO
M36%K969I;&4G.R!<"@DD*&%M7U]C9"D@)"AT;W!?<W)C9&ER*2`F)B!<"@D@
M("0H05543TU!2T4I("TM9F]R96EG;B`M+6EG;F]R92UD97!S('!Y=&AO;B]-
M86ME9FEL90I-86ME9FEL93H@)"AS<F-D:7(I+TUA:V5F:6QE+FEN("0H=&]P
M7V)U:6QD9&ER*2]C;VYF:6<N<W1A='5S"@E`8V%S92`G)#\G(&EN(%P*"2`@
M*F-O;F9I9RYS=&%T=7,J*2!<"@D@("`@8V0@)"AT;W!?8G5I;&1D:7(I("8F
M("0H34%+12D@)"A!35]-04M%1DQ!1U,I(&%M+2UR969R97-H.SL@7`H)("`J
M*2!<"@D@("`@96-H;R`G(&-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*%-(14Q,
M*2`N+V-O;F9I9RYS=&%T=7,@)"AS=6)D:7(I+R1`("0H86U?7V1E<&9I;&5S
M7VUA>6)E*2<[(%P*"2`@("!C9"`D*'1O<%]B=6EL9&1I<BD@)B8@)"A32$5,
M3"D@+B]C;VYF:6<N<W1A='5S("0H<W5B9&ER*2\D0"`D*&%M7U]D97!F:6QE
M<U]M87EB92D[.R!<"@EE<V%C.PHD*'1O<%]S<F-D:7(I+V9R86=M96YT+F%M
M("0H86U?7V5M<'1Y*3H*"B0H=&]P7V)U:6QD9&ER*2]C;VYF:6<N<W1A='5S
M.B`D*'1O<%]S<F-D:7(I+V-O;F9I9W5R92`D*$-/3D9)1U]35$%455-?1$50
M14Y$14Y#2453*0H)8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H34%+12D@)"A!
M35]-04M%1DQ!1U,I(&%M+2UR969R97-H"@HD*'1O<%]S<F-D:7(I+V-O;F9I
M9W5R93H@0$U!24Y404E.15)?34]$15]44E5%0"`D*&%M7U]C;VYF:6=U<F5?
M9&5P<RD*"6-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*$U!2T4I("0H04U?34%+
M149,04=3*2!A;2TM<F5F<F5S:`HD*$%#3$]#04Q?330I.B!`34%)3E1!24Y%
M4E]-3T1%7U12545`("0H86U?7V%C;&]C86Q?;31?9&5P<RD*"6-D("0H=&]P
M7V)U:6QD9&ER*2`F)B`D*$U!2T4I("0H04U?34%+149,04=3*2!A;2TM<F5F
M<F5S:`HD*&%M7U]A8VQO8V%L7VTT7V1E<',I.@H*;6]S=&QY8VQE86XM;&EB
M=&]O;#H*"2UR;2`M9B`J+FQO"@IC;&5A;BUL:6)T;V]L.@H)+7)M("UR9B`N
M;&EB<R!?;&EB<PII;G-T86QL+6YO8F%S95]P>71H;VY$051!.B`D*&YO8F%S
M95]P>71H;VY?1$%402D*"4`D*$Y/4DU!3%])3E-404Q,*0H)0&QI<W0])R0H
M;F]B87-E7W!Y=&AO;E]$051!*2<[('1E<W0@+6X@(B0H<'ET:&]N9&ER*2(@
M?'P@;&ES=#T[(%P*"6EF('1E<W0@+6X@(B0D;&ES="([('1H96X@7`H)("!E
M8VAO("(@)"A-2T1)4E]0*2`G)"A$15-41$E2*20H<'ET:&]N9&ER*2<B.R!<
M"@D@("0H34M$25)?4"D@(B0H1$535$1)4BDD*'!Y=&AO;F1I<BDB('Q\(&5X
M:70@,3L@7`H)9FD[(%P*"20H86U?7VYO8F%S95]L:7-T*2!\('=H:6QE(')E
M860@9&ER(&9I;&5S.R!D;R!<"@D@('AF:6QE<ST[(&9O<B!F:6QE(&EN("0D
M9FEL97,[(&1O(%P*"2`@("!I9B!T97-T("UF("(D)&9I;&4B.R!T:&5N('AF
M:6QE<STB)"1X9FEL97,@)"1F:6QE(CL@7`H)("`@(&5L<V4@>&9I;&5S/2(D
M)'AF:6QE<R`D*'-R8V1I<BDO)"1F:6QE(CL@9FD[(&1O;F4[(%P*"2`@=&5S
M="`M>B`B)"1X9FEL97,B('Q\('L@7`H)("`@('1E<W0@(G@D)&1I<B(@/2!X
M+B!\?"![(%P*"2`@("`@(&5C:&\@(B`D*$U+1$E27U`I("<D*$1%4U1$25(I
M)"AP>71H;VYD:7(I+R0D9&ER)R([(%P*"2`@("`@("0H34M$25)?4"D@(B0H
M1$535$1)4BDD*'!Y=&AO;F1I<BDO)"1D:7(B.R!].R!<"@D@("`@96-H;R`B
M("0H24Y35$%,3%]$051!*2`D)'AF:6QE<R`G)"A$15-41$E2*20H<'ET:&]N
M9&ER*2\D)&1I<B<B.R!<"@D@("`@)"A)3E-404Q,7T1!5$$I("0D>&9I;&5S
M("(D*$1%4U1$25(I)"AP>71H;VYD:7(I+R0D9&ER(B!\?"!E>&ET("0D/SL@
M?3L@7`H)9&]N90H*=6YI;G-T86QL+6YO8F%S95]P>71H;VY$051!.@H)0"0H
M3D]234%,7U5.24Y35$%,3"D*"4!L:7-T/2<D*&YO8F%S95]P>71H;VY?1$%4
M02DG.R!T97-T("UN("(D*'!Y=&AO;F1I<BDB('Q\(&QI<W0].R!<"@DD*&%M
M7U]N;V)A<V5?<W1R:7!?<V5T=7`I.R!F:6QE<SU@)"AA;5]?;F]B87-E7W-T
M<FEP*6`[(%P*"61I<CTG)"A$15-41$E2*20H<'ET:&]N9&ER*2<[("0H86U?
M7W5N:6YS=&%L;%]F:6QE<U]F<F]M7V1I<BD*=&%G<R!404=3.@H*8W1A9W,@
M0U1!1U,Z"@IC<V-O<&4@8W-C;W!E;&ES=#H*"F-H96-K+6%M.B!A;&PM86T*
M8VAE8VLZ(&-H96-K+6%M"F%L;"UA;3H@36%K969I;&4@)"A$051!*2!A;&PM
M;&]C86P*:6YS=&%L;&1I<G,Z"@EF;W(@9&ER(&EN("(D*$1%4U1$25(I)"AP
M>71H;VYD:7(I(CL@9&\@7`H)("!T97-T("UZ("(D)&1I<B(@?'P@)"A-2T1)
M4E]0*2`B)"1D:7(B.R!<"@ED;VYE"FEN<W1A;&PZ(&EN<W1A;&PM86T*:6YS
M=&%L;"UE>&5C.B!I;G-T86QL+65X96,M86T*:6YS=&%L;"UD871A.B!I;G-T
M86QL+61A=&$M86T*=6YI;G-T86QL.B!U;FEN<W1A;&PM86T*"FEN<W1A;&PM
M86TZ(&%L;"UA;0H)0"0H34%+12D@)"A!35]-04M%1DQ!1U,I(&EN<W1A;&PM
M97AE8RUA;2!I;G-T86QL+61A=&$M86T*"FEN<W1A;&QC:&5C:SH@:6YS=&%L
M;&-H96-K+6%M"FEN<W1A;&PM<W1R:7`Z"@EI9B!T97-T("UZ("<D*%-44DE0
M*2<[('1H96X@7`H)("`D*$U!2T4I("0H04U?34%+149,04=3*2!)3E-404Q,
M7U!23T=204T](B0H24Y35$%,3%]35%))4%]04D]'4D%-*2(@7`H)("`@(&EN
M<W1A;&Q?<VA?4%)/1U)!33TB)"A)3E-404Q,7U-44DE07U!23T=204TI(B!)
M3E-404Q,7U-44DE07T9,04<]+7,@7`H)("`@("`@:6YS=&%L;#L@7`H)96QS
M92!<"@D@("0H34%+12D@)"A!35]-04M%1DQ!1U,I($E.4U1!3$Q?4%)/1U)!
M33TB)"A)3E-404Q,7U-44DE07U!23T=204TI(B!<"@D@("`@:6YS=&%L;%]S
M:%]04D]'4D%-/2(D*$E.4U1!3$Q?4U1225!?4%)/1U)!32DB($E.4U1!3$Q?
M4U1225!?1DQ!1STM<R!<"@D@("`@(DE.4U1!3$Q?4%)/1U)!35]%3E8]4U12
M25!04D]'/2<D*%-44DE0*2<B(&EN<W1A;&P[(%P*"69I"FUO<W1L>6-L96%N
M+6=E;F5R:6,Z"@IC;&5A;BUG96YE<FEC.@H*9&ES=&-L96%N+6=E;F5R:6,Z
M"@DM=&5S="`M>B`B)"A#3TY&24=?0TQ%04Y?1DE,15,I(B!\?"!R;2`M9B`D
M*$-/3D9)1U]#3$5!3E]&24Q%4RD*"2UT97-T("X@/2`B)"AS<F-D:7(I(B!\
M?"!T97-T("UZ("(D*$-/3D9)1U]#3$5!3E]64$%42%]&24Q%4RDB('Q\(')M
M("UF("0H0T].1DE'7T-,14%.7U90051(7T9)3$53*0H*;6%I;G1A:6YE<BUC
M;&5A;BUG96YE<FEC.@H)0&5C:&\@(E1H:7,@8V]M;6%N9"!I<R!I;G1E;F1E
M9"!F;W(@;6%I;G1A:6YE<G,@=&\@=7-E(@H)0&5C:&\@(FET(&1E;&5T97,@
M9FEL97,@=&AA="!M87D@<F5Q=6ER92!S<&5C:6%L('1O;VQS('1O(')E8G5I
M;&0N(@IC;&5A;CH@8VQE86XM86T*"F-L96%N+6%M.B!C;&5A;BUG96YE<FEC
M(&-L96%N+6QI8G1O;VP@;6]S=&QY8VQE86XM86T*"F1I<W1C;&5A;CH@9&ES
M=&-L96%N+6%M"@DM<FT@+68@36%K969I;&4*9&ES=&-L96%N+6%M.B!C;&5A
M;BUA;2!D:7-T8VQE86XM9V5N97)I8PH*9'9I.B!D=FDM86T*"F1V:2UA;3H*
M"FAT;6PZ(&AT;6PM86T*"FAT;6PM86TZ"@II;F9O.B!I;F9O+6%M"@II;F9O
M+6%M.@H*:6YS=&%L;"UD871A+6%M.B!I;G-T86QL+61A=&$M;&]C86P@:6YS
M=&%L;"UN;V)A<V5?<'ET:&]N1$%400H*:6YS=&%L;"UD=FDZ(&EN<W1A;&PM
M9'9I+6%M"@II;G-T86QL+61V:2UA;3H*"FEN<W1A;&PM97AE8RUA;3H*"FEN
M<W1A;&PM:'1M;#H@:6YS=&%L;"UH=&UL+6%M"@II;G-T86QL+6AT;6PM86TZ
M"@II;G-T86QL+6EN9F\Z(&EN<W1A;&PM:6YF;RUA;0H*:6YS=&%L;"UI;F9O
M+6%M.@H*:6YS=&%L;"UM86XZ"@II;G-T86QL+7!D9CH@:6YS=&%L;"UP9&8M
M86T*"FEN<W1A;&PM<&1F+6%M.@H*:6YS=&%L;"UP<SH@:6YS=&%L;"UP<RUA
M;0H*:6YS=&%L;"UP<RUA;3H*"FEN<W1A;&QC:&5C:RUA;3H*"FUA:6YT86EN
M97(M8VQE86XZ(&UA:6YT86EN97(M8VQE86XM86T*"2UR;2`M9B!-86ME9FEL
M90IM86EN=&%I;F5R+6-L96%N+6%M.B!D:7-T8VQE86XM86T@;6%I;G1A:6YE
M<BUC;&5A;BUG96YE<FEC"@IM;W-T;'EC;&5A;CH@;6]S=&QY8VQE86XM86T*
M"FUO<W1L>6-L96%N+6%M.B!M;W-T;'EC;&5A;BUG96YE<FEC(&UO<W1L>6-L
M96%N+6QI8G1O;VP*"G!D9CH@<&1F+6%M"@IP9&8M86TZ"@IP<SH@<',M86T*
M"G!S+6%M.@H*=6YI;G-T86QL+6%M.B!U;FEN<W1A;&PM;F]B87-E7W!Y=&AO
M;D1!5$$*"BY-04M%.B!I;G-T86QL+6%M(&EN<W1A;&PM<W1R:7`*"BY02$].
M63H@86QL(&%L;"UA;2!A;&PM;&]C86P@8VAE8VL@8VAE8VLM86T@8VQE86X@
M8VQE86XM9V5N97)I8R!<"@EC;&5A;BUL:6)T;V]L(&-S8V]P96QI<W0M86T@
M8W1A9W,M86T@9&ES=&-L96%N(%P*"61I<W1C;&5A;BUG96YE<FEC(&1I<W1C
M;&5A;BUL:6)T;V]L(&1V:2!D=FDM86T@:'1M;"!H=&UL+6%M(%P*"6EN9F\@
M:6YF;RUA;2!I;G-T86QL(&EN<W1A;&PM86T@:6YS=&%L;"UD871A(&EN<W1A
M;&PM9&%T82UA;2!<"@EI;G-T86QL+61A=&$M;&]C86P@:6YS=&%L;"UD=FD@
M:6YS=&%L;"UD=FDM86T@:6YS=&%L;"UE>&5C(%P*"6EN<W1A;&PM97AE8RUA
M;2!I;G-T86QL+6AT;6P@:6YS=&%L;"UH=&UL+6%M(&EN<W1A;&PM:6YF;R!<
M"@EI;G-T86QL+6EN9F\M86T@:6YS=&%L;"UM86X@:6YS=&%L;"UN;V)A<V5?
M<'ET:&]N1$%402!<"@EI;G-T86QL+7!D9B!I;G-T86QL+7!D9BUA;2!I;G-T
M86QL+7!S(&EN<W1A;&PM<',M86T@7`H):6YS=&%L;"US=')I<"!I;G-T86QL
M8VAE8VL@:6YS=&%L;&-H96-K+6%M(&EN<W1A;&QD:7)S(%P*"6UA:6YT86EN
M97(M8VQE86X@;6%I;G1A:6YE<BUC;&5A;BUG96YE<FEC(&UO<W1L>6-L96%N
M(%P*"6UO<W1L>6-L96%N+6=E;F5R:6,@;6]S=&QY8VQE86XM;&EB=&]O;"!P
M9&8@<&1F+6%M('!S('!S+6%M(%P*"71A9W,M86T@=6YI;G-T86QL('5N:6YS
M=&%L;"UA;2!U;FEN<W1A;&PM;F]B87-E7W!Y=&AO;D1!5$$*"BY04D5#24]5
M4SH@36%K969I;&4*"@IA;&PM;&]C86PZ(&=D8BYP>0H*9V1B+G!Y.B!H;V]K
M+FEN($UA:V5F:6QE"@ES960@+64@)W,L0'!Y=&AO;F1I<D`L)"AP>71H;VYD
M:7(I+"<@7`H)("`@("UE("=S+$!T;V]L97AE8VQI8F1I<D`L)"AT;V]L97AE
M8VQI8F1I<BDL)R`\("0H<W)C9&ER*2]H;V]K+FEN(#X@)$`*"FEN<W1A;&PM
M9&%T82UL;V-A;#H@9V1B+G!Y"@E`)"AM:V1I<E]P*2`D*$1%4U1$25(I)"AT
M;V]L97AE8VQI8F1I<BD*"4!H97)E/6!P=V1@.R!C9"`D*$1%4U1$25(I)"AT
M;V]L97AE8VQI8F1I<BD[(%P*"2`@9F]R(&9I;&4@:6X@;&EB<W1D8RLK+BH[
M(&1O(%P*"2`@("!C87-E("0D9FEL92!I;B!<"@D@("`@("`J+6=D8BYP>2D@
M.SL@7`H)("`@("`@*BYL82D@.SL@7`H)("`@("`@*BD@:68@=&5S="`M:"`D
M)&9I;&4[('1H96X@7`H)("`@("`@("`@("!C;VYT:6YU93L@7`H)("`@("`@
M("`@9FD[(%P*"2`@("`@("`@(&QI8FYA;64])"1F:6QE.SL@7`H)("`@(&5S
M86,[(%P*"2`@9&]N93L@7`H)8V0@)"1H97)E.R!<"@EE8VAO("(@)"A)3E-4
M04Q,7T1!5$$I(&=D8BYP>2`D*$1%4U1$25(I)"AT;V]L97AE8VQI8F1I<BDO
M)"1L:6)N86UE+6=D8BYP>2([(%P*"20H24Y35$%,3%]$051!*2!G9&(N<'D@
M)"A$15-41$E2*20H=&]O;&5X96-L:6)D:7(I+R0D;&EB;F%M92UG9&(N<'D*
M"B,@5&5L;"!V97)S:6]N<R!;,RXU.2PS+C8S*2!O9B!'3E4@;6%K92!T;R!N
M;W0@97AP;W)T(&%L;"!V87)I86)L97,N"B,@3W1H97)W:7-E(&$@<WES=&5M
M(&QI;6ET("AF;W(@4WES5B!A="!L96%S="D@;6%Y(&)E(&5X8V5E9&5D+@HN
M3D]%6%!/4E0Z"@``````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````N+W!Y=&AO;B]H;V]K+FEN````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````,#`P,#8T-``P,#`R,#`R`#`P,#`Q
M-#0`,#`P,#`P,#0U,#``,3,U,30P,S8U,3$`,#$S,S4S`"`P````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`'5S=&%R("``9FIA<F1O;@````````````````````````````````!U<V5R
M<P``````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````",@+2HM('!Y=&AO;B`M
M*BT*(R!#;W!Y<FEG:'0@*$,I(#(P,#DM,C`Q.2!&<F5E(%-O9G1W87)E($9O
M=6YD871I;VXL($EN8RX*"B,@5&AI<R!P<F]G<F%M(&ES(&9R964@<V]F='=A
M<F4[('EO=2!C86X@<F5D:7-T<FEB=71E(&ET(&%N9"]O<B!M;V1I9GD*(R!I
M="!U;F1E<B!T:&4@=&5R;7,@;V8@=&AE($=.52!'96YE<F%L(%!U8FQI8R!,
M:6-E;G-E(&%S('!U8FQI<VAE9"!B>0HC('1H92!&<F5E(%-O9G1W87)E($9O
M=6YD871I;VX[(&5I=&AE<B!V97)S:6]N(#,@;V8@=&AE($QI8V5N<V4L(&]R
M"B,@*&%T('EO=7(@;W!T:6]N*2!A;GD@;&%T97(@=F5R<VEO;BX*(PHC(%1H
M:7,@<')O9W)A;2!I<R!D:7-T<FEB=71E9"!I;B!T:&4@:&]P92!T:&%T(&ET
M('=I;&P@8F4@=7-E9G5L+`HC(&)U="!7251(3U54($%.62!705)204Y463L@
M=VET:&]U="!E=F5N('1H92!I;7!L:65D('=A<G)A;G1Y(&]F"B,@34520TA!
M3E1!0DE,2519(&]R($9)5$Y%4U,@1D]2($$@4$%25$E#54Q!4B!055)03U-%
M+B`@4V5E('1H90HC($=.52!'96YE<F%L(%!U8FQI8R!,:6-E;G-E(&9O<B!M
M;W)E(&1E=&%I;',N"B,*(R!9;W4@<VAO=6QD(&AA=F4@<F5C96EV960@82!C
M;W!Y(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS90HC(&%L;VYG
M('=I=&@@=&AI<R!P<F]G<F%M+B`@268@;F]T+"!S964@/&AT='`Z+R]W=W<N
M9VYU+F]R9R]L:6-E;G-E<R\^+@H*:6UP;W)T('-Y<PII;7!O<G0@9V1B"FEM
M<&]R="!O<PII;7!O<G0@;W,N<&%T:`H*<'ET:&]N9&ER(#T@)T!P>71H;VYD
M:7)`)PIL:6)D:7(@/2`G0'1O;VQE>&5C;&EB9&ER0"<*"B,@5&AI<R!F:6QE
M(&UI9VAT(&)E(&QO861E9"!W:&5N('1H97)E(&ES(&YO(&-U<G)E;G0@;V)J
M9FEL92X@(%1H:7,*(R!C86X@:&%P<&5N(&EF('1H92!U<V5R(&QO861S(&ET
M(&UA;G5A;&QY+B`@26X@=&AI<R!C87-E('=E(&1O;B=T"B,@=7!D871E('-Y
M<RYP871H.R!I;G-T96%D('=E(&IU<W0@:&]P92!T:&4@=7-E<B!M86YA9V5D
M('1O(&1O('1H870*(R!B969O<F5H86YD+@II9B!G9&(N8W5R<F5N=%]O8FIF
M:6QE("@I(&ES(&YO="!.;VYE.@H@("`@(R!5<&1A=&4@;6]D=6QE('!A=&@N
M("!792!W86YT('1O(&9I;F0@=&AE(')E;&%T:79E('!A=&@@9G)O;2!L:6)D
M:7(*("`@(",@=&\@<'ET:&]N9&ER+"!A;F0@=&AE;B!W92!W86YT('1O(&%P
M<&QY('1H870@<F5L871I=F4@<&%T:"!T;R!T:&4*("`@(",@9&ER96-T;W)Y
M(&AO;&1I;F<@=&AE(&]B:F9I;&4@=VET:"!W:&EC:"!T:&ES(&9I;&4@:7,@
M87-S;V-I871E9"X*("`@(",@5&AI<R!P<F5S97)V97,@<F5L;V-A=&%B:6QI
M='D@;V8@=&AE(&=C8R!T<F5E+@H*("`@(",@1&\@82!S:6UP;&4@;F]R;6%L
M:7IA=&EO;B!T:&%T(')E;6]V97,@9'5P;&EC871E('-E<&%R871O<G,N"B`@
M("!P>71H;VYD:7(@/2!O<RYP871H+FYO<FUP871H("AP>71H;VYD:7(I"B`@
M("!L:6)D:7(@/2!O<RYP871H+FYO<FUP871H("AL:6)D:7(I"@H@("`@<')E
M9FEX(#T@;W,N<&%T:"YC;VUM;VYP<F5F:7@@*%ML:6)D:7(L('!Y=&AO;F1I
M<ETI"B`@("`C($EN('-O;64@8FEZ87)R92!C;VYF:6=U<F%T:6]N('=E(&UI
M9VAT(&AA=F4@9F]U;F0@82!M871C:"!I;B!T:&4*("`@(",@;6ED9&QE(&]F
M(&$@9&ER96-T;W)Y(&YA;64N"B`@("!I9B!P<F5F:7A;+3%=("$]("<O)SH*
M("`@("`@("!P<F5F:7@@/2!O<RYP871H+F1I<FYA;64@*'!R969I>"D@*R`G
M+R<*"B`@("`C(%-T<FEP(&]F9B!T:&4@<')E9FEX+@H@("`@<'ET:&]N9&ER
M(#T@<'ET:&]N9&ER6VQE;B`H<')E9FEX*3I="B`@("!L:6)D:7(@/2!L:6)D
M:7);;&5N("AP<F5F:7@I.ET*"B`@("`C($-O;7!U=&4@=&AE("(N+B)S(&YE
M961E9"!T;R!G970@9G)O;2!L:6)D:7(@=&\@=&AE('!R969I>"X*("`@(&1O
M=&1O=',@/2`H)RXN)R`K(&]S+G-E<"D@*B!L96X@*&QI8F1I<BYS<&QI="`H
M;W,N<V5P*2D*"B`@("!O8FIF:6QE(#T@9V1B+F-U<G)E;G1?;V)J9FEL92`H
M*2YF:6QE;F%M90H@("`@9&ER7R`](&]S+G!A=&@N:F]I;B`H;W,N<&%T:"YD
M:7)N86UE("AO8FIF:6QE*2P@9&]T9&]T<RP@<'ET:&]N9&ER*0H*("`@(&EF
M(&YO="!D:7)?(&EN('-Y<RYP871H.@H@("`@("`@('-Y<RYP871H+FEN<V5R
M="@P+"!D:7)?*0H*(R!#86QL(&$@9G5N8W1I;VX@87,@82!P;&%I;B!I;7!O
M<G0@=V]U;&0@;F]T(&5X96-U=&4@8F]D>2!O9B!T:&4@:6YC;'5D960@9FEL
M90HC(&]N(')E<&5A=&5D(')E;&]A9',@;V8@=&AI<R!O8FIE8W0@9FEL92X*
M9G)O;2!L:6)S=&1C>'@N=C8@:6UP;W)T(')E9VES=&5R7VQI8G-T9&-X>%]P
M<FEN=&5R<PIR96=I<W1E<E]L:6)S=&1C>'A?<')I;G1E<G,H9V1B+F-U<G)E
M;G1?;V)J9FEL92@I*0H`````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````N+W!Y=&AO;B]-86ME9FEL92YA
M;0``````````````````````````````````````````````````````````
M````````````````````````````````````````````````,#`P,#8T-``P
M,#`R,#`R`#`P,#`Q-#0`,#`P,#`P,#0S,S<`,3,U,30P,S8U,3$`,#$T,3(W
M`"`P````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````'5S=&%R("``9FIA<F1O;@``````````````````````
M``````````!U<V5R<P``````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````````````````````",C
M($UA:V5F:6QE(&9O<B!T:&4@<'ET:&]N('-U8F1I<F5C=&]R>2!O9B!T:&4@
M1TY5($,K*R!3=&%N9&%R9"!L:6)R87)Y+@HC(PHC(R!#;W!Y<FEG:'0@*$,I
M(#(P,#DM,C`Q.2!&<F5E(%-O9G1W87)E($9O=6YD871I;VXL($EN8RX*(R,*
M(R,@5&AI<R!F:6QE(&ES('!A<G0@;V8@=&AE(&QI8G-T9&,K*R!V97)S:6]N
M(#,@9&ES=')I8G5T:6]N+@HC(R!0<F]C97-S('1H:7,@9FEL92!W:71H(&%U
M=&]M86ME('1O('!R;V1U8V4@36%K969I;&4N:6XN"@HC(R!4:&ES(&9I;&4@
M:7,@<&%R="!O9B!T:&4@1TY5($E33R!#*RL@3&EB<F%R>2X@(%1H:7,@;&EB
M<F%R>2!I<R!F<F5E"B,C('-O9G1W87)E.R!Y;W4@8V%N(')E9&ES=')I8G5T
M92!I="!A;F0O;W(@;6]D:69Y(&ET('5N9&5R('1H90HC(R!T97)M<R!O9B!T
M:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4@87,@<'5B;&ES:&5D(&)Y
M('1H90HC(R!&<F5E(%-O9G1W87)E($9O=6YD871I;VX[(&5I=&AE<B!V97)S
M:6]N(#,L(&]R("AA="!Y;W5R(&]P=&EO;BD*(R,@86YY(&QA=&5R('9E<G-I
M;VXN"B,C"B,C(%1H:7,@;&EB<F%R>2!I<R!D:7-T<FEB=71E9"!I;B!T:&4@
M:&]P92!T:&%T(&ET('=I;&P@8F4@=7-E9G5L+`HC(R!B=70@5TE42$]55"!!
M3ED@5T%24D%.5%D[('=I=&AO=70@979E;B!T:&4@:6UP;&EE9"!W87)R86YT
M>2!O9@HC(R!-15)#2$%.5$%"24Q)5%D@;W(@1DE43D534R!&3U(@02!005)4
M24-53$%2(%!54E!/4T4N("!3964@=&AE"B,C($=.52!'96YE<F%L(%!U8FQI
M8R!,:6-E;G-E(&9O<B!M;W)E(&1E=&%I;',N"B,C"B,C(%EO=2!S:&]U;&0@
M:&%V92!R96-E:79E9"!A(&-O<'D@;V8@=&AE($=.52!'96YE<F%L(%!U8FQI
M8R!,:6-E;G-E(&%L;VYG"B,C('=I=&@@=&AI<R!L:6)R87)Y.R!S964@=&AE
M(&9I;&4@0T]064E.1S,N("!)9B!N;W0@<V5E"B,C(#QH='1P.B\O=W=W+F=N
M=2YO<F<O;&EC96YS97,O/BX*"FEN8VQU9&4@)"AT;W!?<W)C9&ER*2]F<F%G
M;65N="YA;0H*(R,@5VAE<F4@=&\@:6YS=&%L;"!T:&4@;6]D=6QE(&-O9&4N
M"FEF($5.04),15]0651(3TY$25(*<'ET:&]N9&ER(#T@)"AP<F5F:7@I+R0H
M<'ET:&]N7VUO9%]D:7(I"F5L<V4*<'ET:&]N9&ER(#T@)"AD871A9&ER*2]G
M8V,M)"AG8V-?=F5R<VEO;BDO<'ET:&]N"F5N9&EF"@IA;&PM;&]C86PZ(&=D
M8BYP>0H*;F]B87-E7W!Y=&AO;E]$051!(#T@7`H@("`@;&EB<W1D8WAX+W8V
M+W!R:6YT97)S+G!Y(%P*("`@(&QI8G-T9&-X>"]V-B]X;65T:&]D<RYP>2!<
M"B`@("!L:6)S=&1C>'@O=C8O7U]I;FET7U\N<'D@7`H@("`@;&EB<W1D8WAX
M+U]?:6YI=%]?+G!Y"@IG9&(N<'DZ(&AO;VLN:6X@36%K969I;&4*"7-E9"`M
M92`G<RQ`<'ET:&]N9&ER0"PD*'!Y=&AO;F1I<BDL)R!<"@D@("`@+64@)W,L
M0'1O;VQE>&5C;&EB9&ER0"PD*'1O;VQE>&5C;&EB9&ER*2PG(#P@)"AS<F-D
M:7(I+VAO;VLN:6X@/B`D0`H*:6YS=&%L;"UD871A+6QO8V%L.B!G9&(N<'D*
M"4`D*&UK9&ER7W`I("0H1$535$1)4BDD*'1O;VQE>&5C;&EB9&ER*0HC(R!7
M92!W86YT('1O(&EN<W1A;&P@9V1B+G!Y(&%S(%-/34542$E.1RUG9&(N<'DN
M("!33TU%5$A)3D<@:7,@=&AE"B,C(&9U;&P@;F%M92!O9B!T:&4@9FEN86P@
M;&EB<F%R>2X@(%=E('=A;G0@=&\@:6=N;W)E('-Y;6QI;FMS+"!T:&4*(R,@
M+FQA(&9I;&4L(&%N9"!A;GD@<')E=FEO=7,@+6=D8BYP>2!F:6QE+B`@5&AI
M<R!I<R!I;FAE<F5N=&QY"B,C(&9R86=I;&4L(&)U="!T:&5R92!D;V5S(&YO
M="!S965M('1O(&)E(&$@8F5T=&5R(&]P=&EO;BP@8F5C875S90HC(R!L:6)T
M;V]L(&AI9&5S('1H92!R96%L(&YA;65S(&9R;VT@=7,N"@E`:&5R93U@<'=D
M8#L@8V0@)"A$15-41$E2*20H=&]O;&5X96-L:6)D:7(I.R!<"@D@(&9O<B!F
M:6QE(&EN(&QI8G-T9&,K*RXJ.R!D;R!<"@D@("`@8V%S92`D)&9I;&4@:6X@
M7`H)("`@("`@*BUG9&(N<'DI(#L[(%P*"2`@("`@("HN;&$I(#L[(%P*"2`@
M("`@("HI(&EF('1E<W0@+6@@)"1F:6QE.R!T:&5N(%P*"2`@("`@("`@("`@
M8V]N=&EN=64[(%P*"2`@("`@("`@(&9I.R!<"@D@("`@("`@("!L:6)N86UE
M/20D9FEL93L[(%P*"2`@("!E<V%C.R!<"@D@(&1O;F4[(%P*"6-D("0D:&5R
M93L@7`H)96-H;R`B("0H24Y35$%,3%]$051!*2!G9&(N<'D@)"A$15-41$E2
M*20H=&]O;&5X96-L:6)D:7(I+R0D;&EB;F%M92UG9&(N<'DB.R!<"@DD*$E.
M4U1!3$Q?1$%402D@9V1B+G!Y("0H1$535$1)4BDD*'1O;VQE>&5C;&EB9&ER
M*2\D)&QI8FYA;64M9V1B+G!Y"@``````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
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
  (set 20 19 07 18 11 35 06 'share-gdb.tar'
   eval "${shar_touch}") && \
  chmod 0644 'share-gdb.tar'
if test $? -ne 0
then ${echo} "restore of share-gdb.tar failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'share-gdb.tar': 'MD5 check failed'
       ) << \SHAR_EOF
099d18b35e84a8bc62b896accae9c175  share-gdb.tar
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
  (set 20 19 07 18 11 35 06 'apt-cyg'
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
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH BYZANZ-HELPER 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 07 18 11 35 08 'byzanz-helper.1'
   eval "${shar_touch}") && \
  chmod 0644 'byzanz-helper.1'
if test $? -ne 0
then ${echo} "restore of byzanz-helper.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'byzanz-helper.1': 'MD5 check failed'
       ) << \SHAR_EOF
88549734537472a8163c673dcd6ab3e0  byzanz-helper.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'byzanz-helper.1'` -ne 5755 && \
  ${echo} "restoration warning:  size of 'byzanz-helper.1' is not 5755"
  fi
fi
# ============= codefmt.1 ==============
if test -n "${keep_file}" && test -f 'codefmt.1'
then
${echo} "x - SKIPPING codefmt.1 (file already exists)"

else
${echo} "x - extracting codefmt.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'codefmt.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH CODEFMT 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
\&\fIfmt\fR\|(1), \fIcolumn\fR\|(1), \fIcodemv\fR\|(1)
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
  (set 20 19 07 18 11 35 09 'codefmt.1'
   eval "${shar_touch}") && \
  chmod 0644 'codefmt.1'
if test $? -ne 0
then ${echo} "restore of codefmt.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'codefmt.1': 'MD5 check failed'
       ) << \SHAR_EOF
c7542418e0e4bcfee5533d4b0b9d4196  codefmt.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'codefmt.1'` -ne 5282 && \
  ${echo} "restoration warning:  size of 'codefmt.1' is not 5282"
  fi
fi
# ============= codemv.1 ==============
if test -n "${keep_file}" && test -f 'codemv.1'
then
${echo} "x - SKIPPING codemv.1 (file already exists)"

else
${echo} "x - extracting codemv.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'codemv.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH CODEMV 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
\&\fIfmt\fR\|(1), \fIcolumn\fR\|(1), \fIcodefmt\fR\|(1)
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
  (set 20 19 07 18 11 35 09 'codemv.1'
   eval "${shar_touch}") && \
  chmod 0644 'codemv.1'
if test $? -ne 0
then ${echo} "restore of codemv.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'codemv.1': 'MD5 check failed'
       ) << \SHAR_EOF
a7da275e52b92ad1ae6f59794cfdb1f6  codemv.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'codemv.1'` -ne 5363 && \
  ${echo} "restoration warning:  size of 'codemv.1' is not 5363"
  fi
fi
# ============= ffmpeg-helper.1 ==============
if test -n "${keep_file}" && test -f 'ffmpeg-helper.1'
then
${echo} "x - SKIPPING ffmpeg-helper.1 (file already exists)"

else
${echo} "x - extracting ffmpeg-helper.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'ffmpeg-helper.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH FFMPEG-HELPER 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 07 18 11 35 10 'ffmpeg-helper.1'
   eval "${shar_touch}") && \
  chmod 0644 'ffmpeg-helper.1'
if test $? -ne 0
then ${echo} "restore of ffmpeg-helper.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'ffmpeg-helper.1': 'MD5 check failed'
       ) << \SHAR_EOF
33c45ab4d7b1afbfe7a391132bd9d32a  ffmpeg-helper.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'ffmpeg-helper.1'` -ne 5711 && \
  ${echo} "restoration warning:  size of 'ffmpeg-helper.1' is not 5711"
  fi
fi
# ============= hyper-v.1 ==============
if test -n "${keep_file}" && test -f 'hyper-v.1'
then
${echo} "x - SKIPPING hyper-v.1 (file already exists)"

else
${echo} "x - extracting hyper-v.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'hyper-v.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH HYPER-V 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 07 18 11 35 11 'hyper-v.1'
   eval "${shar_touch}") && \
  chmod 0644 'hyper-v.1'
if test $? -ne 0
then ${echo} "restore of hyper-v.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'hyper-v.1': 'MD5 check failed'
       ) << \SHAR_EOF
aa285f0594321ea182bd01ff93f24281  hyper-v.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'hyper-v.1'` -ne 5129 && \
  ${echo} "restoration warning:  size of 'hyper-v.1' is not 5129"
  fi
fi
# ============= msvc-shell.1 ==============
if test -n "${keep_file}" && test -f 'msvc-shell.1'
then
${echo} "x - SKIPPING msvc-shell.1 (file already exists)"

else
${echo} "x - extracting msvc-shell.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'msvc-shell.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH MSVC-SHELL 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 07 18 11 35 12 'msvc-shell.1'
   eval "${shar_touch}") && \
  chmod 0644 'msvc-shell.1'
if test $? -ne 0
then ${echo} "restore of msvc-shell.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'msvc-shell.1': 'MD5 check failed'
       ) << \SHAR_EOF
b4ad90fed16cf83be00e6e951c8d3591  msvc-shell.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'msvc-shell.1'` -ne 5915 && \
  ${echo} "restoration warning:  size of 'msvc-shell.1' is not 5915"
  fi
fi
# ============= sixel2tmux.1 ==============
if test -n "${keep_file}" && test -f 'sixel2tmux.1'
then
${echo} "x - SKIPPING sixel2tmux.1 (file already exists)"

else
${echo} "x - extracting sixel2tmux.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'sixel2tmux.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH SIXEL2TMUX 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 07 18 11 35 13 'sixel2tmux.1'
   eval "${shar_touch}") && \
  chmod 0644 'sixel2tmux.1'
if test $? -ne 0
then ${echo} "restore of sixel2tmux.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'sixel2tmux.1': 'MD5 check failed'
       ) << \SHAR_EOF
175a3ec0a9883e28a1bd116d04907974  sixel2tmux.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'sixel2tmux.1'` -ne 6510 && \
  ${echo} "restoration warning:  size of 'sixel2tmux.1' is not 6510"
  fi
fi
# ============= yank.1 ==============
if test -n "${keep_file}" && test -f 'yank.1'
then
${echo} "x - SKIPPING yank.1 (file already exists)"

else
${echo} "x - extracting yank.1 (text)"
  sed 's/^X//' << 'SHAR_EOF' > 'yank.1' &&
X.\" Automatically generated by Pod::Man 2.28 (Pod::Simple 3.28)
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
X.\" If the F register is turned on, we'll generate index entries on stderr for
X.\" titles (.TH), headers (.SH), subsections (.SS), items (.Ip), and index
X.\" entries marked with X<> in POD.  Of course, you'll have to process the
X.\" output yourself in some meaningful fashion.
X.\"
X.\" Avoid warning from groff about undefined register 'F'.
X.de IX
X..
X.nr rF 0
X.if \n(.g .if rF .nr rF 1
X.if (\n(rF:(\n(.g==0)) \{
X.    if \nF \{
X.        de IX
X.        tm Index:\\$1\t\\n%\t"\\$2"
X..
X.        if !\nF==2 \{
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
X.TH YANK 1 "2019-07-18" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 07 18 11 35 14 'yank.1'
   eval "${shar_touch}") && \
  chmod 0644 'yank.1'
if test $? -ne 0
then ${echo} "restore of yank.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'yank.1': 'MD5 check failed'
       ) << \SHAR_EOF
8710ee2124c2ca64c9e07ce6175b12a1  yank.1
SHAR_EOF

else
test `LC_ALL=C wc -c < 'yank.1'` -ne 7193 && \
  ${echo} "restoration warning:  size of 'yank.1' is not 7193"
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
install -m 0755 -d "${PREFIX}/.local/share"
install -m 0755 -d "${PREFIX}/.local/share/man/man1"
install -m 0755 -d "${PREFIX}/.local/var"
install -m 0755 -d "${PREFIX}/.local/var/lock"
install -m 0755 -d "${PREFIX}/.local/var/log"
install -m 0755 -d "${PREFIX}/.local/var/run"
install -m 0755 -d "${PREFIX}/.local/etc/cron"
install -m 0755 -d "${PREFIX}/.local/etc/profile.d"
install -m 0755 runcron "${PREFIX}/.local/bin"
export PATH="${PATH}:${PREFIX}/.local/bin"

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
    if [ -e "${PREFIX}/.Xresources" ]; then
        cp -f "${PREFIX}/.Xresources" "${BACKUPDIR}"
    fi
    install -m 0644 dot_Xresources "${PREFIX}/.Xresources"

    # Fonts
    echo "nerd fonts ..."
    install -d "${PREFIX}/.fonts"
    install -d "${PREFIX}/.local/share/fonts"
    if has_prog fc-cache; then
        if [ ! -d "${PREFIX}/.local/share/fonts/nerd-fonts" ]; then
            install -d "${PREFIX}/.local/share/fonts/nerd-fonts"
            curl -O 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/2.0.0/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf' \
                > install.log 2>&1
            mv 'DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf' 'DejaVu Sans Mono Nerd Font Complete.ttf'
            install -m 0644 'DejaVu Sans Mono Nerd Font Complete.ttf' "${PREFIX}/.local/share/fonts/nerd-fonts/"
            fc-cache -f "${PREFIX}/.local/share/fonts"
        fi
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
install -m 0644 dot_tmux_conf "${PREFIX}/.tmux.conf"
install -m 0755 scripts/yank  "${PREFIX}/.local/bin"
install -m 0644 yank.1        "${PREFIX}/.local/share/man/man1"

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

