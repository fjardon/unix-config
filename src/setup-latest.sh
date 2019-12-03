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
lock_dir=_sh20635
# Made on 2019-12-03 08:37 CET by <fjardon@DiskStation>.
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
#     89 -rw-r--r-- dot_gemrc
#   2479 -rw-r--r-- dot_profile
#   3140 -rw-r--r-- dot_tmux_conf
#   4125 -rw-r--r-- dot_vimrc
#    828 -rw-r--r-- dot_Xresources
#    185 -rw-r--r-- dot_Xresources_user
#   4076 -rw-r--r-- dot_XWinrc
#   2541 -rwxr-xr-x scripts/byzanz-helper
#   3766 -rwxr-xr-x scripts/ffmpeg-helper
#   1820 -rwxr-xr-x scripts/hyper-v
#    195 -rw-r--r-- ibase.sh
#   6290 -rwxr-xr-x scripts/msvc-shell
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
  (set 20 19 07 18 11 45 26 'dot_gemrc'
   eval "${shar_touch}") && \
  chmod 0644 'dot_gemrc'
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
  (set 20 19 12 03 08 33 07 'dot_Xresources'
   eval "${shar_touch}") && \
  chmod 0644 'dot_Xresources'
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
XXTerm*faceName: DejaVuSansMono NF
XXTerm*faceSize: 12
XXTerm*reverseVideo: true
XXTerm*rightScrollBar: true
XXTerm*scrollBar: true
XXTerm*toolBar: false
XXTerm*utf8: 2
XXTerm*visualBell: true
SHAR_EOF
  (set 20 19 12 03 08 33 34 'dot_Xresources_user'
   eval "${shar_touch}") && \
  chmod 0644 'dot_Xresources_user'
if test $? -ne 0
then ${echo} "restore of dot_Xresources_user failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'dot_Xresources_user': 'MD5 check failed'
       ) << \SHAR_EOF
b6f55b7a9a72e078b2411c33de2a0ec3  dot_Xresources_user
SHAR_EOF

else
test `LC_ALL=C wc -c < 'dot_Xresources_user'` -ne 185 && \
  ${echo} "restoration warning:  size of 'dot_Xresources_user' is not 185"
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
  (set 20 19 12 02 13 47 14 'scripts/msvc-shell'
   eval "${shar_touch}") && \
  chmod 0755 'scripts/msvc-shell'
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
M`#$S-3<Q-#$P,C(U`#`Q,#4T-``@-0``````````````````````````````
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
M,#`Q-#0`,#`P,#`P,#`P,#``,3,U-S$T,3`R,S``,#$R,#8Q`"`U````````
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
M,#`P-S4U`#`P,#(P,#(`,#`P,#$T-``P,#`P,#`P,#`P,``Q,S4W,30Q,#(S
M,``P,30P-C4`(#4`````````````````````````````````````````````
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
M,#`P,#`P`#$S-3<Q-#$P,C,P`#`Q-#0R,``@-0``````````````````````
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
M,#`R`#`P,#`Q-#0`,#`P,#`P-C<P,#8`,3,U-S$T,3`R,S``,#$V-C,V`"`P
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
M("!R969C;W5N=',@/2!O8FI;)U]-7W)E9F-O=6YT)UU;)U]-7W!I)UT*("`@
M("`@("!R971U<FX@<F5F8V]U;G1S6R=?35]U<V5?8V]U;G0G72!I9B!R969C
M;W5N=',@96QS92`P"@IC;&%S<R!3:&%R9610=')5;FEQ=657;W)K97(H4VAA
M<F5D4'1R57-E0V]U;G17;W)K97(I.@H@("`@(DEM<&QE;65N=',@<W1D.CIS
M:&%R961?<'1R/%0^.CIU;FEQ=64H*2(*"B`@("!D968@7U]I;FET7U\H<V5L
M9BP@96QE;5]T>7!E*3H*("`@("`@("!3:&%R9610=')5<V5#;W5N=%=O<FME
M<BY?7VEN:71?7RAS96QF+"!E;&5M7W1Y<&4I"@H@("`@9&5F(&=E=%]R97-U
M;'1?='EP92AS96QF+"!O8FHI.@H@("`@("`@(')E='5R;B!G9&(N;&]O:W5P
M7W1Y<&4H)V)O;VPG*0H*("`@(&1E9B!?7V-A;&Q?7RAS96QF+"!O8FHI.@H@
M("`@("`@(')E='5R;B!3:&%R9610=')5<V5#;W5N=%=O<FME<BY?7V-A;&Q?
M7RAS96QF+"!O8FHI(#T](#$*"F-L87-S(%-H87)E9%!T<DUE=&AO9'--871C
M:&5R*&=D8BYX;65T:&]D+EA-971H;V1-871C:&5R*3H*("`@(&1E9B!?7VEN
M:71?7RAS96QF*3H*("`@("`@("!G9&(N>&UE=&AO9"Y8365T:&]D36%T8VAE
M<BY?7VEN:71?7RAS96QF+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(&UA=&-H97)?;F%M95]P<F5F:7@@*R`G<VAA<F5D
M7W!T<B<I"B`@("`@("`@<V5L9BY?;65T:&]D7V1I8W0@/2!["B`@("`@("`@
M("`@("=G970G.B!,:6)3=&1#>'A8365T:&]D*"=G970G+"!3:&%R9610=')'
M9717;W)K97(I+`H@("`@("`@("`@("`G;W!E<F%T;W(M/B<Z($QI8E-T9$-X
M>%A-971H;V0H)V]P97)A=&]R+3XG+"!3:&%R9610=')'9717;W)K97(I+`H@
M("`@("`@("`@("`G;W!E<F%T;W(J)SH@3&EB4W1D0WAX6$UE=&AO9"@G;W!E
M<F%T;W(J)RP@4VAA<F5D4'1R1&5R9697;W)K97(I+`H@("`@("`@("`@("`G
M;W!E<F%T;W);72<Z($QI8E-T9$-X>%A-971H;V0H)V]P97)A=&]R6UTG+"!3
M:&%R9610=')3=6)S8W)I<'17;W)K97(I+`H@("`@("`@("`@("`G=7-E7V-O
M=6YT)SH@3&EB4W1D0WAX6$UE=&AO9"@G=7-E7V-O=6YT)RP@4VAA<F5D4'1R
M57-E0V]U;G17;W)K97(I+`H@("`@("`@("`@("`G=6YI<75E)SH@3&EB4W1D
M0WAX6$UE=&AO9"@G=6YI<75E)RP@4VAA<F5D4'1R56YI<75E5V]R:V5R*2P*
M("`@("`@("!]"B`@("`@("`@<V5L9BYM971H;V1S(#T@6W-E;&8N7VUE=&AO
M9%]D:6-T6VU=(&9O<B!M(&EN('-E;&8N7VUE=&AO9%]D:6-T70H*("`@(&1E
M9B!M871C:"AS96QF+"!C;&%S<U]T>7!E+"!M971H;V1?;F%M92DZ"B`@("`@
M("`@:68@;F]T(')E+FUA=&-H*"=><W1D.CHH7U]<9"LZ.BD_<VAA<F5D7W!T
M<CPN*CXD)RP@8VQA<W-?='EP92YT86<I.@H@("`@("`@("`@("!R971U<FX@
M3F]N90H@("`@("`@(&UE=&AO9"`]('-E;&8N7VUE=&AO9%]D:6-T+F=E="AM
M971H;V1?;F%M92D*("`@("`@("!I9B!M971H;V0@:7,@3F]N92!O<B!N;W0@
M;65T:&]D+F5N86)L960Z"B`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@
M("`@=V]R:V5R(#T@;65T:&]D+G=O<FME<E]C;&%S<RAC;&%S<U]T>7!E+G1E
M;7!L871E7V%R9W5M96YT*#`I*0H@("`@("`@(&EF('=O<FME<BY?<W5P<&]R
M=',H;65T:&]D7VYA;64I.@H@("`@("`@("`@("!R971U<FX@=V]R:V5R"B`@
M("`@("`@<F5T=7)N($YO;F4*#`ID968@<F5G:7-T97)?;&EB<W1D8WAX7WAM
M971H;V1S*&QO8W5S*3H*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H
M;V1?;6%T8VAE<BAL;V-U<RP@07)R87E-971H;V1S36%T8VAE<B@I*0H@("`@
M9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*&QO8W5S+"!&
M;W)W87)D3&ES=$UE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO9"YR
M96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L($1E<75E365T:&]D<TUA
M=&-H97(H*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T
M8VAE<BAL;V-U<RP@3&ES=$UE=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE
M=&AO9"YR96=I<W1E<E]X;65T:&]D7VUA=&-H97(H;&]C=7,L(%9E8W1O<DUE
M=&AO9'--871C:&5R*"DI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T
M:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N=&%I
M;F5R365T:&]D<TUA=&-H97(H)W-E="<I*0H@("`@9V1B+GAM971H;V0N<F5G
M:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@(&QO8W5S+"!!<W-O8VEA
M=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=M87`G*2D*("`@(&=D8BYX
M;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE<B@*("`@("`@("!L;V-U
M<RP@07-S;V-I871I=F5#;VYT86EN97)-971H;V1S36%T8VAE<B@G;75L=&ES
M970G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE
M<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#;VYT86EN97)-971H;V1S
M36%T8VAE<B@G;75L=&EM87`G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R
M7WAM971H;V1?;6%T8VAE<B@*("`@("`@("!L;V-U<RP@07-S;V-I871I=F5#
M;VYT86EN97)-971H;V1S36%T8VAE<B@G=6YO<F1E<F5D7W-E="<I*0H@("`@
M9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@
M(&QO8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=U
M;F]R9&5R961?;6%P)RDI"B`@("!G9&(N>&UE=&AO9"YR96=I<W1E<E]X;65T
M:&]D7VUA=&-H97(H"B`@("`@("`@;&]C=7,L($%S<V]C:6%T:79E0V]N=&%I
M;F5R365T:&]D<TUA=&-H97(H)W5N;W)D97)E9%]M=6QT:7-E="<I*0H@("`@
M9V1B+GAM971H;V0N<F5G:7-T97)?>&UE=&AO9%]M871C:&5R*`H@("`@("`@
M(&QO8W5S+"!!<W-O8VEA=&EV94-O;G1A:6YE<DUE=&AO9'--871C:&5R*"=U
M;F]R9&5R961?;75L=&EM87`G*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R
M7WAM971H;V1?;6%T8VAE<BAL;V-U<RP@56YI<75E4'1R365T:&]D<TUA=&-H
M97(H*2D*("`@(&=D8BYX;65T:&]D+G)E9VES=&5R7WAM971H;V1?;6%T8VAE
M<BAL;V-U<RP@4VAA<F5D4'1R365T:&]D<TUA=&-H97(H*2D*````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
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
M,3$`,3,U-S$T,3`R,S``,#$V-3(U`"`P````````````````````````````
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
M,#(P,#(`,#`P,#$T-``P,#`P,#(R,3,S-P`Q,S4W,30Q,#(S,``P,38V-3``
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
M<B!H97)E+@H@("`@("`@(&9I96QD<R`]('1Y<"YF:65L9',H*0H@("`@("`@
M(&EF(&QE;BAF:65L9',I(&%N9"!F:65L9'-;,%TN:7-?8F%S95]C;&%S<SH*
M("`@("`@("`@("`@='EP(#T@9FEE;&1S6S!=+G1Y<&4*("`@("`@("!E;'-E
M.@H@("`@("`@("`@("!R86ES92!686QU945R<F]R*")#86YN;W0@9FEN9"!T
M>7!E("5S.CHE<R(@)2`H<W1R*&]R:6<I+"!N86UE*2D*"E]V97)S:6]N961?
M;F%M97-P86-E(#T@)U]?.#HZ)PH*9&5F(&QO;VMU<%]T96UP;%]S<&5C*'1E
M;7!L+"`J87)G<RDZ"B`@("`B(B(*("`@($QO;VMU<"!T96UP;&%T92!S<&5C
M:6%L:7IA=&EO;B!T96UP;#QA<F=S+BXN/@H@("`@(B(B"B`@("!T(#T@)WM]
M/'M]/B<N9F]R;6%T*'1E;7!L+"`G+"`G+FIO:6XH6W-T<BAA*2!F;W(@82!I
M;B!A<F=S72DI"B`@("!T<GDZ"B`@("`@("`@<F5T=7)N(&=D8BYL;V]K=7!?
M='EP92AT*0H@("`@97AC97!T(&=D8BYE<G)O<B!A<R!E.@H@("`@("`@(",@
M5'EP92!N;W0@9F]U;F0L('1R>2!A9V%I;B!I;B!V97)S:6]N960@;F%M97-P
M86-E+@H@("`@("`@(&=L;V)A;"!?=F5R<VEO;F5D7VYA;65S<&%C90H@("`@
M("`@(&EF(%]V97)S:6]N961?;F%M97-P86-E(&%N9"!?=F5R<VEO;F5D7VYA
M;65S<&%C92!N;W0@:6X@=&5M<&PZ"B`@("`@("`@("`@('0@/2!T+G)E<&QA
M8V4H)SHZ)RP@)SHZ)R`K(%]V97)S:6]N961?;F%M97-P86-E+"`Q*0H@("`@
M("`@("`@("!T<GDZ"B`@("`@("`@("`@("`@("!R971U<FX@9V1B+FQO;VMU
M<%]T>7!E*'0I"B`@("`@("`@("`@(&5X8V5P="!G9&(N97)R;W(Z"B`@("`@
M("`@("`@("`@("`C($EF('1H870@86QS;R!F86EL<RP@<F5T:')O=R!T:&4@
M;W)I9VEN86P@97AC97!T:6]N"B`@("`@("`@("`@("`@("!P87-S"B`@("`@
M("`@<F%I<V4@90H*(R!5<V4@=&AI<R!T;R!F:6YD(&-O;G1A:6YE<B!N;V1E
M('1Y<&5S(&EN<W1E860@;V8@9FEN9%]T>7!E+`HC('-E92!H='1P<SHO+V=C
M8RYG;G4N;W)G+V)U9WII;&QA+W-H;W=?8G5G+F-G:3]I9#TY,3DY-R!F;W(@
M9&5T86EL<RX*9&5F(&QO;VMU<%]N;V1E7W1Y<&4H;F]D96YA;64L(&-O;G1A
M:6YE<G1Y<&4I.@H@("`@(B(B"B`@("!,;V]K=7`@<W!E8VEA;&EZ871I;VX@
M;V8@=&5M<&QA=&4@3D]$14Y!344@8V]R<F5S<&]N9&EN9R!T;R!#3TY404E.
M15)465!%+@H@("`@92YG+B!I9B!.3T1%3D%-12!I<R`G7TQI<W1?;F]D92<@
M86YD($-/3E1!24Y%4E194$4@:7,@<W1D.CIL:7-T/&EN=#X*("`@('1H96X@
M<F5T=7)N('1H92!T>7!E('-T9#HZ7TQI<W1?;F]D93QI;G0^+@H@("`@4F5T
M=7)N<R!.;VYE(&EF(&YO="!F;W5N9"X*("`@("(B(@H@("`@(R!)9B!N;V1E
M;F%M92!I<R!U;G%U86QI9FEE9"P@87-S=6UE(&ET)W,@:6X@;F%M97-P86-E
M('-T9"X*("`@(&EF("<Z.B<@;F]T(&EN(&YO9&5N86UE.@H@("`@("`@(&YO
M9&5N86UE(#T@)W-T9#HZ)R`K(&YO9&5N86UE"B`@("!T<GDZ"B`@("`@("`@
M=F%L='EP92`](&9I;F1?='EP92AC;VYT86EN97)T>7!E+"`G=F%L=65?='EP
M92<I"B`@("!E>&-E<'0Z"B`@("`@("`@=F%L='EP92`](&-O;G1A:6YE<G1Y
M<&4N=&5M<&QA=&5?87)G=6UE;G0H,"D*("`@('9A;'1Y<&4@/2!V86QT>7!E
M+G-T<FEP7W1Y<&5D969S*"D*("`@('1R>3H*("`@("`@("!R971U<FX@;&]O
M:W5P7W1E;7!L7W-P96,H;F]D96YA;64L('9A;'1Y<&4I"B`@("!E>&-E<'0@
M9V1B+F5R<F]R(&%S(&4Z"B`@("`@("`@(R!&;W(@9&5B=6<@;6]D92!C;VYT
M86EN97)S('1H92!N;V1E(&ES(&EN('-T9#HZ7U]C>'@Q.3DX+@H@("`@("`@
M(&EF(&ES7VUE;6)E<E]O9E]N86UE<W!A8V4H;F]D96YA;64L("=S=&0G*3H*
M("`@("`@("`@("`@:68@:7-?;65M8F5R7V]F7VYA;65S<&%C92AC;VYT86EN
M97)T>7!E+"`G<W1D.CI?7V-X>#$Y.3@G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("=S=&0Z.E]?9&5B=6<G+"`G7U]G;G5?9&5B
M=6<G*3H*("`@("`@("`@("`@("`@(&YO9&5N86UE(#T@;F]D96YA;64N<F5P
M;&%C92@G.CHG+"`G.CI?7V-X>#$Y.3@Z.B<L(#$I"B`@("`@("`@("`@("`@
M("!R971U<FX@;&]O:W5P7W1E;7!L7W-P96,H;F]D96YA;64L('9A;'1Y<&4I
M"B`@("`@("`@("`@("`@("!T<GDZ"B`@("`@("`@("`@("`@("`@("`@<F5T
M=7)N(&QO;VMU<%]T96UP;%]S<&5C*&YO9&5N86UE+"!V86QT>7!E*0H@("`@
M("`@("`@("`@("`@97AC97!T(&=D8BYE<G)O<CH*("`@("`@("`@("`@("`@
M("`@("!P87-S"B`@("`@("`@<F5T=7)N($YO;F4*"F1E9B!I<U]M96UB97)?
M;V9?;F%M97-P86-E*'1Y<"P@*FYA;65S<&%C97,I.@H@("`@(B(B"B`@("!4
M97-T('=H971H97(@82!T>7!E(&ES(&$@;65M8F5R(&]F(&]N92!O9B!T:&4@
M<W!E8VEF:65D(&YA;65S<&%C97,N"B`@("!4:&4@='EP92!C86X@8F4@<W!E
M8VEF:65D(&%S(&$@<W1R:6YG(&]R(&$@9V1B+E1Y<&4@;V)J96-T+@H@("`@
M(B(B"B`@("!I9B!T>7!E*'1Y<"D@:7,@9V1B+E1Y<&4Z"B`@("`@("`@='EP
M(#T@<W1R*'1Y<"D*("`@('1Y<"`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A
M8V4H='EP*0H@("`@9F]R(&YA;65S<&%C92!I;B!N86UE<W!A8V5S.@H@("`@
M("`@(&EF('1Y<"YS=&%R='-W:71H*&YA;65S<&%C92`K("<Z.B<I.@H@("`@
M("`@("`@("!R971U<FX@5')U90H@("`@<F5T=7)N($9A;'-E"@ID968@:7-?
M<W!E8VEA;&EZ871I;VY?;V8H>"P@=&5M<&QA=&5?;F%M92DZ"B`@("`B5&5S
M="!I9B!A('1Y<&4@:7,@82!G:79E;B!T96UP;&%T92!I;G-T86YT:6%T:6]N
M+B(*("`@(&=L;V)A;"!?=F5R<VEO;F5D7VYA;65S<&%C90H@("`@:68@='EP
M92AX*2!I<R!G9&(N5'EP93H*("`@("`@("!X(#T@>"YT86<*("`@(&EF(%]V
M97)S:6]N961?;F%M97-P86-E.@H@("`@("`@(')E='5R;B!R92YM871C:"@G
M7G-T9#HZ*"5S*3\E<SPN*CXD)R`E("A?=F5R<VEO;F5D7VYA;65S<&%C92P@
M=&5M<&QA=&5?;F%M92DL('@I(&ES(&YO="!.;VYE"B`@("!R971U<FX@<F4N
M;6%T8V@H)UYS=&0Z.B5S/"XJ/B0G("4@=&5M<&QA=&5?;F%M92P@>"D@:7,@
M;F]T($YO;F4*"F1E9B!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N
M86UE*3H*("`@(&=L;V)A;"!?=F5R<VEO;F5D7VYA;65S<&%C90H@("`@:68@
M7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@("`@<F5T=7)N('1Y<&5N86UE
M+G)E<&QA8V4H7W9E<G-I;VYE9%]N86UE<W!A8V4L("<G*0H@("`@<F5T=7)N
M('1Y<&5N86UE"@ID968@<W1R:7!?:6YL:6YE7VYA;65S<&%C97,H='EP95]S
M='(I.@H@("`@(E)E;6]V92!K;F]W;B!I;FQI;F4@;F%M97-P86-E<R!F<F]M
M('1H92!C86YO;FEC86P@;F%M92!O9B!A('1Y<&4N(@H@("`@='EP95]S='(@
M/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5?<W1R*0H@("`@='EP
M95]S='(@/2!T>7!E7W-T<BYR97!L86-E*"=S=&0Z.E]?8WAX,3$Z.B<L("=S
M=&0Z.B<I"B`@("!E>'!T7VYS(#T@)W-T9#HZ97AP97)I;65N=&%L.CHG"B`@
M("!F;W(@;&9T<U]N<R!I;B`H)V9U;F1A;65N=&%L<U]V,2<L("=F=6YD86UE
M;G1A;'-?=C(G*3H*("`@("`@("!T>7!E7W-T<B`]('1Y<&5?<W1R+G)E<&QA
M8V4H97AP=%]N<RML9G1S7VYS*R<Z.B<L(&5X<'1?;G,I"B`@("!F<U]N<R`]
M(&5X<'1?;G,@*R`G9FEL97-Y<W1E;3HZ)PH@("`@='EP95]S='(@/2!T>7!E
M7W-T<BYR97!L86-E*&9S7VYS*R=V,3HZ)RP@9G-?;G,I"B`@("!R971U<FX@
M='EP95]S='(*"F1E9B!G971?=&5M<&QA=&5?87)G7VQI<W0H='EP95]O8FHI
M.@H@("`@(E)E='5R;B!A('1Y<&4G<R!T96UP;&%T92!A<F=U;65N=',@87,@
M82!L:7-T(@H@("`@;B`](#`*("`@('1E;7!L871E7V%R9W,@/2!;70H@("`@
M=VAI;&4@5')U93H*("`@("`@("!T<GDZ"B`@("`@("`@("`@('1E;7!L871E
M7V%R9W,N87!P96YD*'1Y<&5?;V)J+G1E;7!L871E7V%R9W5M96YT*&XI*0H@
M("`@("`@(&5X8V5P=#H*("`@("`@("`@("`@<F5T=7)N('1E;7!L871E7V%R
M9W,*("`@("`@("!N("L](#$*"F-L87-S(%-M87)T4'1R271E<F%T;W(H271E
M<F%T;W(I.@H@("`@(D%N(&ET97)A=&]R(&9O<B!S;6%R="!P;VEN=&5R('1Y
M<&5S('=I=&@@82!S:6YG;&4@)V-H:6QD)R!V86QU92(*"B`@("!D968@7U]I
M;FET7U\H<V5L9BP@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@
M(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("!R971U<FX@<V5L9@H*("`@
M(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("!I9B!S96QF+G9A;"!I<R!.
M;VYE.@H@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@
M<V5L9BYV86PL('9A;"`]($YO;F4L('-E;&8N=F%L"B`@("`@("`@<F5T=7)N
M("@G9V5T*"DG+"!V86PI"@IC;&%S<R!3:&%R9610;VEN=&5R4')I;G1E<CH*
M("`@(")0<FEN="!A('-H87)E9%]P='(@;W(@=V5A:U]P='(B"@H@("`@9&5F
M(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF
M+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M
M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H@("`@("`@('-E;&8N<&]I;G1E
M<B`]('9A;%LG7TU?<'1R)UT*"B`@("!D968@8VAI;&1R96X@*'-E;&8I.@H@
M("`@("`@(')E='5R;B!3;6%R=%!T<DET97)A=&]R*'-E;&8N<&]I;G1E<BD*
M"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!S=&%T92`]("=E
M;7!T>2<*("`@("`@("!R969C;W5N=',@/2!S96QF+G9A;%LG7TU?<F5F8V]U
M;G0G75LG7TU?<&DG70H@("`@("`@(&EF(')E9F-O=6YT<R`A/2`P.@H@("`@
M("`@("`@("!U<V5C;W5N="`](')E9F-O=6YT<ULG7TU?=7-E7V-O=6YT)UT*
M("`@("`@("`@("`@=V5A:V-O=6YT(#T@<F5F8V]U;G1S6R=?35]W96%K7V-O
M=6YT)UT*("`@("`@("`@("`@:68@=7-E8V]U;G0@/3T@,#H*("`@("`@("`@
M("`@("`@('-T871E(#T@)V5X<&ER960L('=E86L@8V]U;G0@)60G("4@=V5A
M:V-O=6YT"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("!S=&%T
M92`]("=U<V4@8V]U;G0@)60L('=E86L@8V]U;G0@)60G("4@*'5S96-O=6YT
M+"!W96%K8V]U;G0@+2`Q*0H@("`@("`@(')E='5R;B`G)7,\)7,^("@E<RDG
M("4@*'-E;&8N='EP96YA;64L('-T<BAS96QF+G9A;"YT>7!E+G1E;7!L871E
M7V%R9W5M96YT*#`I*2P@<W1A=&4I"@IC;&%S<R!5;FEQ=650;VEN=&5R4')I
M;G1E<CH*("`@(")0<FEN="!A('5N:7%U95]P='(B"@H@("`@9&5F(%]?:6YI
M=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]
M('9A;`H@("`@("`@(&EM<&Q?='EP92`]('9A;"YT>7!E+F9I96QD<R@I6S!=
M+G1Y<&4N=&%G"B`@("`@("`@(R!#:&5C:R!F;W(@;F5W(&EM<&QE;65N=&%T
M:6]N<R!F:7)S=#H*("`@("`@("!I9B!I<U]S<&5C:6%L:7IA=&EO;E]O9BAI
M;7!L7W1Y<&4L("=?7W5N:7%?<'1R7V1A=&$G*2!<"B`@("`@("`@("`@(&]R
M(&ES7W-P96-I86QI>F%T:6]N7V]F*&EM<&Q?='EP92P@)U]?=6YI<5]P=')?
M:6UP;"<I.@H@("`@("`@("`@("!T=7!L95]M96UB97(@/2!V86Q;)U]-7W0G
M75LG7TU?="=="B`@("`@("`@96QI9B!I<U]S<&5C:6%L:7IA=&EO;E]O9BAI
M;7!L7W1Y<&4L("=T=7!L92<I.@H@("`@("`@("`@("!T=7!L95]M96UB97(@
M/2!V86Q;)U]-7W0G70H@("`@("`@(&5L<V4Z"B`@("`@("`@("`@(')A:7-E
M(%9A;'5E17)R;W(H(E5N<W5P<&]R=&5D(&EM<&QE;65N=&%T:6]N(&9O<B!U
M;FEQ=65?<'1R.B`E<R(@)2!I;7!L7W1Y<&4I"B`@("`@("`@='5P;&5?:6UP
M;%]T>7!E(#T@='5P;&5?;65M8F5R+G1Y<&4N9FEE;&1S*"E;,%TN='EP92`C
M(%]4=7!L95]I;7!L"B`@("`@("`@='5P;&5?:&5A9%]T>7!E(#T@='5P;&5?
M:6UP;%]T>7!E+F9I96QD<R@I6S%=+G1Y<&4@("`C(%](96%D7V)A<V4*("`@
M("`@("!H96%D7V9I96QD(#T@='5P;&5?:&5A9%]T>7!E+F9I96QD<R@I6S!=
M"B`@("`@("`@:68@:&5A9%]F:65L9"YN86UE(#T]("=?35]H96%D7VEM<&PG
M.@H@("`@("`@("`@("!S96QF+G!O:6YT97(@/2!T=7!L95]M96UB97);)U]-
M7VAE861?:6UP;"=="B`@("`@("`@96QI9B!H96%D7V9I96QD+FES7V)A<V5?
M8VQA<W,Z"B`@("`@("`@("`@('-E;&8N<&]I;G1E<B`]('1U<&QE7VUE;6)E
M<BYC87-T*&AE861?9FEE;&0N='EP92D*("`@("`@("!E;'-E.@H@("`@("`@
M("`@("!R86ES92!686QU945R<F]R*")5;G-U<'!O<G1E9"!I;7!L96UE;G1A
M=&EO;B!F;W(@='5P;&4@:6X@=6YI<75E7W!T<CH@)7,B("4@:6UP;%]T>7!E
M*0H*("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@<F5T=7)N(%-M
M87)T4'1R271E<F%T;W(H<V5L9BYP;VEN=&5R*0H*("`@(&1E9B!T;U]S=')I
M;F<@*'-E;&8I.@H@("`@("`@(')E='5R;B`H)W-T9#HZ=6YI<75E7W!T<CPE
M<SXG("4@*'-T<BAS96QF+G9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#`I
M*2DI"@ID968@9V5T7W9A;'5E7V9R;VU?86QI9VYE9%]M96UB=68H8G5F+"!V
M86QT>7!E*3H*("`@("(B(E)E='5R;G,@=&AE('9A;'5E(&AE;&0@:6X@82!?
M7V=N=5]C>'@Z.E]?86QI9VYE9%]M96UB=68N(B(B"B`@("!R971U<FX@8G5F
M6R=?35]S=&]R86=E)UTN861D<F5S<RYC87-T*'9A;'1Y<&4N<&]I;G1E<B@I
M*2YD97)E9F5R96YC92@I"@ID968@9V5T7W9A;'5E7V9R;VU?;&ES=%]N;V1E
M*&YO9&4I.@H@("`@(B(B4F5T=7)N<R!T:&4@=F%L=64@:&5L9"!I;B!A;B!?
M3&ES=%]N;V1E/%]686P^(B(B"B`@("!T<GDZ"B`@("`@("`@;65M8F5R(#T@
M;F]D92YT>7!E+F9I96QD<R@I6S%=+FYA;64*("`@("`@("!I9B!M96UB97(@
M/3T@)U]-7V1A=&$G.@H@("`@("`@("`@("`C($,K*S`S(&EM<&QE;65N=&%T
M:6]N+"!N;V1E(&-O;G1A:6YS('1H92!V86QU92!A<R!A(&UE;6)E<@H@("`@
M("`@("`@("!R971U<FX@;F]D95LG7TU?9&%T82=="B`@("`@("`@96QI9B!M
M96UB97(@/3T@)U]-7W-T;W)A9V4G.@H@("`@("`@("`@("`C($,K*S$Q(&EM
M<&QE;65N=&%T:6]N+"!N;V1E('-T;W)E<R!V86QU92!I;B!?7V%L:6=N961?
M;65M8G5F"B`@("`@("`@("`@('9A;'1Y<&4@/2!N;V1E+G1Y<&4N=&5M<&QA
M=&5?87)G=6UE;G0H,"D*("`@("`@("`@("`@<F5T=7)N(&=E=%]V86QU95]F
M<F]M7V%L:6=N961?;65M8G5F*&YO9&5;)U]-7W-T;W)A9V4G72P@=F%L='EP
M92D*("`@(&5X8V5P=#H*("`@("`@("!P87-S"B`@("!R86ES92!686QU945R
M<F]R*")5;G-U<'!O<G1E9"!I;7!L96UE;G1A=&EO;B!F;W(@)7,B("4@<W1R
M*&YO9&4N='EP92DI"@IC;&%S<R!3=&1,:7-T4')I;G1E<CH*("`@(")0<FEN
M="!A('-T9#HZ;&ES="(*"B`@("!C;&%S<R!?:71E<F%T;W(H271E<F%T;W(I
M.@H@("`@("`@(&1E9B!?7VEN:71?7RAS96QF+"!N;V1E='EP92P@:&5A9"DZ
M"B`@("`@("`@("`@('-E;&8N;F]D971Y<&4@/2!N;V1E='EP90H@("`@("`@
M("`@("!S96QF+F)A<V4@/2!H96%D6R=?35]N97AT)UT*("`@("`@("`@("`@
M<V5L9BYH96%D(#T@:&5A9"YA9&1R97-S"B`@("`@("`@("`@('-E;&8N8V]U
M;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@
M("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@
M("`@("`@("`@("!I9B!S96QF+F)A<V4@/3T@<V5L9BYH96%D.@H@("`@("`@
M("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@("`@("!E;'0@
M/2!S96QF+F)A<V4N8V%S="AS96QF+FYO9&5T>7!E*2YD97)E9F5R96YC92@I
M"B`@("`@("`@("`@('-E;&8N8F%S92`](&5L=%LG7TU?;F5X="=="B`@("`@
M("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@("`@("`@("`@("!S96QF+F-O
M=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@("`@=F%L(#T@9V5T7W9A
M;'5E7V9R;VU?;&ES=%]N;V1E*&5L="D*("`@("`@("`@("`@<F5T=7)N("@G
M6R5D72<@)2!C;W5N="P@=F%L*0H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T
M>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?
M=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G9A
M;"`]('9A;`H*("`@(&1E9B!C:&EL9')E;BAS96QF*3H*("`@("`@("!N;V1E
M='EP92`](&QO;VMU<%]N;V1E7W1Y<&4H)U],:7-T7VYO9&4G+"!S96QF+G9A
M;"YT>7!E*2YP;VEN=&5R*"D*("`@("`@("!R971U<FX@<V5L9BY?:71E<F%T
M;W(H;F]D971Y<&4L('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7VYO9&4G72D*
M"B`@("!D968@=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@(&AE861N;V1E(#T@
M<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?;F]D92=="B`@("`@("`@:68@:&5A
M9&YO9&5;)U]-7VYE>'0G72`]/2!H96%D;F]D92YA9&1R97-S.@H@("`@("`@
M("`@("!R971U<FX@)V5M<'1Y("5S)R`E("AS96QF+G1Y<&5N86UE*0H@("`@
M("`@(')E='5R;B`G)7,G("4@*'-E;&8N='EP96YA;64I"@IC;&%S<R!.;V1E
M271E<F%T;W)0<FEN=&5R.@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N
M86UE+"!V86PL(&-O;G1N86UE+"!N;V1E;F%M92DZ"B`@("`@("`@<V5L9BYV
M86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N86UE(#T@='EP96YA;64*("`@
M("`@("!S96QF+F-O;G1N86UE(#T@8V]N=&YA;64*("`@("`@("!S96QF+FYO
M9&5T>7!E(#T@;&]O:W5P7VYO9&5?='EP92AN;V1E;F%M92P@=F%L+G1Y<&4I
M"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I9B!N;W0@<V5L
M9BYV86Q;)U]-7VYO9&4G73H*("`@("`@("`@("`@<F5T=7)N("=N;VXM9&5R
M969E<F5N8V5A8FQE(&ET97)A=&]R(&9O<B!S=&0Z.B5S)R`E("AS96QF+F-O
M;G1N86UE*0H@("`@("`@(&YO9&4@/2!S96QF+G9A;%LG7TU?;F]D92==+F-A
M<W0H<V5L9BYN;V1E='EP92YP;VEN=&5R*"DI+F1E<F5F97)E;F-E*"D*("`@
M("`@("!R971U<FX@<W1R*&=E=%]V86QU95]F<F]M7VQI<W1?;F]D92AN;V1E
M*2D*"F-L87-S(%-T9$QI<W1)=&5R871O<E!R:6YT97(H3F]D94ET97)A=&]R
M4')I;G1E<BDZ"B`@("`B4')I;G0@<W1D.CIL:7-T.CII=&5R871O<B(*"B`@
M("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@
M3F]D94ET97)A=&]R4')I;G1E<BY?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@
M=F%L+"`G;&ES="<L("=?3&ES=%]N;V1E)RD*"F-L87-S(%-T9$9W9$QI<W1)
M=&5R871O<E!R:6YT97(H3F]D94ET97)A=&]R4')I;G1E<BDZ"B`@("`B4')I
M;G0@<W1D.CIF;W)W87)D7VQI<W0Z.FET97)A=&]R(@H*("`@(&1E9B!?7VEN
M:71?7RAS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!.;V1E271E<F%T
M;W)0<FEN=&5R+E]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PL("=F;W)W
M87)D7VQI<W0G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@)U]&=V1?;&ES=%]N;V1E)RD*"F-L87-S(%-T9%-L:7-T4')I;G1E<CH*
M("`@(")0<FEN="!A(%]?9VYU7V-X>#HZ<VQI<W0B"@H@("`@8VQA<W,@7VET
M97)A=&]R*$ET97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@
M;F]D971Y<&4L(&AE860I.@H@("`@("`@("`@("!S96QF+FYO9&5T>7!E(#T@
M;F]D971Y<&4*("`@("`@("`@("`@<V5L9BYB87-E(#T@:&5A9%LG7TU?:&5A
M9"==6R=?35]N97AT)UT*("`@("`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@
M("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@
M<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@
M(&EF('-E;&8N8F%S92`]/2`P.@H@("`@("`@("`@("`@("`@<F%I<V4@4W1O
M<$ET97)A=&EO;@H@("`@("`@("`@("!E;'0@/2!S96QF+F)A<V4N8V%S="AS
M96QF+FYO9&5T>7!E*2YD97)E9F5R96YC92@I"B`@("`@("`@("`@('-E;&8N
M8F%S92`](&5L=%LG7TU?;F5X="=="B`@("`@("`@("`@(&-O=6YT(#T@<V5L
M9BYC;W5N=`H@("`@("`@("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K
M(#$*("`@("`@("`@("`@<F5T=7)N("@G6R5D72<@)2!C;W5N="P@96QT6R=?
M35]D871A)UTI"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V
M86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F(&-H:6QD<F5N
M*'-E;&8I.@H@("`@("`@(&YO9&5T>7!E(#T@;&]O:W5P7VYO9&5?='EP92@G
M7U]G;G5?8WAX.CI?4VQI<W1?;F]D92<L('-E;&8N=F%L+G1Y<&4I"B`@("`@
M("`@<F5T=7)N('-E;&8N7VET97)A=&]R*&YO9&5T>7!E+G!O:6YT97(H*2P@
M<V5L9BYV86PI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I
M9B!S96QF+G9A;%LG7TU?:&5A9"==6R=?35]N97AT)UT@/3T@,#H*("`@("`@
M("`@("`@<F5T=7)N("=E;7!T>2!?7V=N=5]C>'@Z.G-L:7-T)PH@("`@("`@
M(')E='5R;B`G7U]G;G5?8WAX.CIS;&ES="<*"F-L87-S(%-T9%-L:7-T271E
M<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT(%]?9VYU7V-X>#HZ<VQI<W0Z.FET
M97)A=&]R(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E;F%M92P@=F%L
M*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!T;U]S=')I;F<H
M<V5L9BDZ"B`@("`@("`@:68@;F]T('-E;&8N=F%L6R=?35]N;V1E)UTZ"B`@
M("`@("`@("`@(')E='5R;B`G;F]N+61E<F5F97)E;F-E86)L92!I=&5R871O
M<B!F;W(@7U]G;G5?8WAX.CIS;&ES="<*("`@("`@("!N;V1E='EP92`](&QO
M;VMU<%]N;V1E7W1Y<&4H)U]?9VYU7V-X>#HZ7U-L:7-T7VYO9&4G+"!S96QF
M+G9A;"YT>7!E*2YP;VEN=&5R*"D*("`@("`@("!R971U<FX@<W1R*'-E;&8N
M=F%L6R=?35]N;V1E)UTN8V%S="AN;V1E='EP92DN9&5R969E<F5N8V4H*5LG
M7TU?9&%T82==*0H*8VQA<W,@4W1D5F5C=&]R4')I;G1E<CH*("`@(")0<FEN
M="!A('-T9#HZ=F5C=&]R(@H*("`@(&-L87-S(%]I=&5R871O<BA)=&5R871O
M<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?("AS96QF+"!S=&%R="P@9FEN:7-H
M+"!B:71V96,I.@H@("`@("`@("`@("!S96QF+F)I='9E8R`](&)I='9E8PH@
M("`@("`@("`@("!I9B!B:71V96,Z"B`@("`@("`@("`@("`@("!S96QF+FET
M96T@("`]('-T87)T6R=?35]P)UT*("`@("`@("`@("`@("`@('-E;&8N<V\@
M("`@(#T@<W1A<G1;)U]-7V]F9G-E="=="B`@("`@("`@("`@("`@("!S96QF
M+F9I;FES:"`](&9I;FES:%LG7TU?<"=="B`@("`@("`@("`@("`@("!S96QF
M+F9O("`@("`](&9I;FES:%LG7TU?;V9F<V5T)UT*("`@("`@("`@("`@("`@
M(&ET>7!E(#T@<V5L9BYI=&5M+F1E<F5F97)E;F-E*"DN='EP90H@("`@("`@
M("`@("`@("`@<V5L9BYI<VEZ92`](#@@*B!I='EP92YS:7IE;V8*("`@("`@
M("`@("`@96QS93H*("`@("`@("`@("`@("`@('-E;&8N:71E;2`]('-T87)T
M"B`@("`@("`@("`@("`@("!S96QF+F9I;FES:"`](&9I;FES:`H@("`@("`@
M("`@("!S96QF+F-O=6YT(#T@,`H*("`@("`@("!D968@7U]I=&5R7U\H<V5L
M9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE
M>'1?7RAS96QF*3H*("`@("`@("`@("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@
M("`@("`@("`@('-E;&8N8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@
M("`@("!I9B!S96QF+F)I='9E8SH*("`@("`@("`@("`@("`@(&EF('-E;&8N
M:71E;2`]/2!S96QF+F9I;FES:"!A;F0@<V5L9BYS;R`^/2!S96QF+F9O.@H@
M("`@("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@
M("`@("`@("`@(&5L="`](&)O;VPH<V5L9BYI=&5M+F1E<F5F97)E;F-E*"D@
M)B`H,2`\/"!S96QF+G-O*2D*("`@("`@("`@("`@("`@('-E;&8N<V\@/2!S
M96QF+G-O("L@,0H@("`@("`@("`@("`@("`@:68@<V5L9BYS;R`^/2!S96QF
M+FES:7IE.@H@("`@("`@("`@("`@("`@("`@('-E;&8N:71E;2`]('-E;&8N
M:71E;2`K(#$*("`@("`@("`@("`@("`@("`@("!S96QF+G-O(#T@,`H@("`@
M("`@("`@("`@("`@<F5T=7)N("@G6R5D72<@)2!C;W5N="P@96QT*0H@("`@
M("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@:68@<V5L9BYI=&5M(#T]
M('-E;&8N9FEN:7-H.@H@("`@("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)
M=&5R871I;VX*("`@("`@("`@("`@("`@(&5L="`]('-E;&8N:71E;2YD97)E
M9F5R96YC92@I"B`@("`@("`@("`@("`@("!S96QF+FET96T@/2!S96QF+FET
M96T@*R`Q"B`@("`@("`@("`@("`@("!R971U<FX@*"=;)61=)R`E(&-O=6YT
M+"!E;'0I"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI
M.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M
M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@
M("`@<V5L9BYI<U]B;V]L(#T@=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H
M,"DN8V]D92`]/2!G9&(N5%E015]#3T1%7T)/3TP*"B`@("!D968@8VAI;&1R
M96XH<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7VET97)A=&]R*'-E;&8N
M=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UTL"B`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7V9I;FES:"==
M+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!S96QF+FES7V)O;VPI
M"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!S=&%R="`]('-E
M;&8N=F%L6R=?35]I;7!L)UU;)U]-7W-T87)T)UT*("`@("`@("!F:6YI<V@@
M/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G70H@("`@("`@(&5N
M9"`]('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7V5N9%]O9E]S=&]R86=E)UT*
M("`@("`@("!I9B!S96QF+FES7V)O;VPZ"B`@("`@("`@("`@('-T87)T(#T@
M<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A<G0G75LG7TU?<"=="B`@("`@
M("`@("`@('-O("`@(#T@<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?<W1A<G0G
M75LG7TU?;V9F<V5T)UT*("`@("`@("`@("`@9FEN:7-H(#T@<V5L9BYV86Q;
M)U]-7VEM<&PG75LG7TU?9FEN:7-H)UU;)U]-7W`G70H@("`@("`@("`@("!F
M;R`@("`@/2!S96QF+G9A;%LG7TU?:6UP;"==6R=?35]F:6YI<V@G75LG7TU?
M;V9F<V5T)UT*("`@("`@("`@("`@:71Y<&4@/2!S=&%R="YD97)E9F5R96YC
M92@I+G1Y<&4*("`@("`@("`@("`@8FP@/2`X("H@:71Y<&4N<VEZ96]F"B`@
M("`@("`@("`@(&QE;F=T:"`@(#T@*&)L("T@<V\I("L@8FP@*B`H*&9I;FES
M:"`M('-T87)T*2`M(#$I("L@9F\*("`@("`@("`@("`@8V%P86-I='D@/2!B
M;"`J("AE;F0@+2!S=&%R="D*("`@("`@("`@("`@<F5T=7)N("@G)7,\8F]O
M;#X@;V8@;&5N9W1H("5D+"!C87!A8VET>2`E9"<*("`@("`@("`@("`@("`@
M("`@("`E("AS96QF+G1Y<&5N86UE+"!I;G0@*&QE;F=T:"DL(&EN="`H8V%P
M86-I='DI*2D*("`@("`@("!E;'-E.@H@("`@("`@("`@("!R971U<FX@*"<E
M<R!O9B!L96YG=&@@)60L(&-A<&%C:71Y("5D)PH@("`@("`@("`@("`@("`@
M("`@("4@*'-E;&8N='EP96YA;64L(&EN="`H9FEN:7-H("T@<W1A<G0I+"!I
M;G0@*&5N9"`M('-T87)T*2DI"@H@("`@9&5F(&1I<W!L87E?:&EN="AS96QF
M*3H*("`@("`@("!R971U<FX@)V%R<F%Y)PH*8VQA<W,@4W1D5F5C=&]R271E
M<F%T;W)0<FEN=&5R.@H@("`@(E!R:6YT('-T9#HZ=F5C=&]R.CII=&5R871O
M<B(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@
M("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I
M.@H@("`@("`@(&EF(&YO="!S96QF+G9A;%LG7TU?8W5R<F5N="==.@H@("`@
M("`@("`@("!R971U<FX@)VYO;BUD97)E9F5R96YC96%B;&4@:71E<F%T;W(@
M9F]R('-T9#HZ=F5C=&]R)PH@("`@("`@(')E='5R;B!S='(H<V5L9BYV86Q;
M)U]-7V-U<G)E;G0G72YD97)E9F5R96YC92@I*0H*(R!43T1/(&%D9"!P<FEN
M=&5R(&9O<B!V96-T;W(\8F]O;#XG<R!?0FET7VET97)A=&]R(&%N9"!?0FET
M7V-O;G-T7VET97)A=&]R"@IC;&%S<R!3=&14=7!L95!R:6YT97(Z"B`@("`B
M4')I;G0@82!S=&0Z.G1U<&QE(@H*("`@(&-L87-S(%]I=&5R871O<BA)=&5R
M871O<BDZ"B`@("`@("`@0'-T871I8VUE=&AO9`H@("`@("`@(&1E9B!?:7-?
M;F]N96UP='E?='5P;&4@*&YO9&5S*3H*("`@("`@("`@("`@:68@;&5N("AN
M;V1E<RD@/3T@,CH*("`@("`@("`@("`@("`@(&EF(&ES7W-P96-I86QI>F%T
M:6]N7V]F("AN;V1E<ULQ72YT>7!E+"`G7U]T=7!L95]B87-E)RDZ"B`@("`@
M("`@("`@("`@("`@("`@<F5T=7)N(%1R=64*("`@("`@("`@("`@96QI9B!L
M96X@*&YO9&5S*2`]/2`Q.@H@("`@("`@("`@("`@("`@<F5T=7)N(%1R=64*
M("`@("`@("`@("`@96QI9B!L96X@*&YO9&5S*2`]/2`P.@H@("`@("`@("`@
M("`@("`@<F5T=7)N($9A;'-E"B`@("`@("`@("`@(')A:7-E(%9A;'5E17)R
M;W(H(E1O<"!O9B!T=7!L92!T<F5E(&1O97,@;F]T(&-O;G-I<W0@;V8@82!S
M:6YG;&4@;F]D92XB*0H*("`@("`@("!D968@7U]I;FET7U\@*'-E;&8L(&AE
M860I.@H@("`@("`@("`@("!S96QF+FAE860@/2!H96%D"@H@("`@("`@("`@
M("`C(%-E="!T:&4@8F%S92!C;&%S<R!A<R!T:&4@:6YI=&EA;"!H96%D(&]F
M('1H90H@("`@("`@("`@("`C('1U<&QE+@H@("`@("`@("`@("!N;V1E<R`]
M('-E;&8N:&5A9"YT>7!E+F9I96QD<R`H*0H@("`@("`@("`@("!I9B!S96QF
M+E]I<U]N;VYE;7!T>5]T=7!L92`H;F]D97,I.@H@("`@("`@("`@("`@("`@
M(R!3970@=&AE(&%C='5A;"!H96%D('1O('1H92!F:7)S="!P86ER+@H@("`@
M("`@("`@("`@("`@<V5L9BYH96%D("`]('-E;&8N:&5A9"YC87-T("AN;V1E
M<ULP72YT>7!E*0H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*("`@("`@
M("!D968@7U]I=&5R7U\@*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L
M9@H*("`@("`@("!D968@7U]N97AT7U\@*'-E;&8I.@H@("`@("`@("`@("`C
M($-H96-K(&9O<B!F=7)T:&5R(')E8W5R<VEO;G,@:6X@=&AE(&EN:&5R:71A
M;F-E('1R964N"B`@("`@("`@("`@(",@1F]R(&$@1T-#(#4K('1U<&QE('-E
M;&8N:&5A9"!I<R!.;VYE(&%F=&5R('9I<VET:6YG(&%L;"!N;V1E<SH*("`@
M("`@("`@("`@:68@;F]T('-E;&8N:&5A9#H*("`@("`@("`@("`@("`@(')A
M:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@;F]D97,@/2!S96QF+FAE
M860N='EP92YF:65L9',@*"D*("`@("`@("`@("`@(R!&;W(@82!'0T,@-"YX
M('1U<&QE('1H97)E(&ES(&$@9FEN86P@;F]D92!W:71H(&YO(&9I96QD<SH*
M("`@("`@("`@("`@:68@;&5N("AN;V1E<RD@/3T@,#H*("`@("`@("`@("`@
M("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@(R!#:&5C:R!T
M:&%T('1H:7,@:71E<F%T:6]N(&AA<R!A;B!E>'!E8W1E9"!S=')U8W1U<F4N
M"B`@("`@("`@("`@(&EF(&QE;B`H;F]D97,I(#X@,CH*("`@("`@("`@("`@
M("`@(')A:7-E(%9A;'5E17)R;W(H(D-A;FYO="!P87)S92!M;W)E('1H86X@
M,B!N;V1E<R!I;B!A('1U<&QE('1R964N(BD*"B`@("`@("`@("`@(&EF(&QE
M;B`H;F]D97,I(#T](#$Z"B`@("`@("`@("`@("`@("`C(%1H:7,@:7,@=&AE
M(&QA<W0@;F]D92!O9B!A($=#0R`U*R!S=&0Z.G1U<&QE+@H@("`@("`@("`@
M("`@("`@:6UP;"`]('-E;&8N:&5A9"YC87-T("AN;V1E<ULP72YT>7!E*0H@
M("`@("`@("`@("`@("`@<V5L9BYH96%D(#T@3F]N90H@("`@("`@("`@("!E
M;'-E.@H@("`@("`@("`@("`@("`@(R!%:71H97(@82!N;V1E(&)E9F]R92!T
M:&4@;&%S="!N;V1E+"!O<B!T:&4@;&%S="!N;V1E(&]F"B`@("`@("`@("`@
M("`@("`C(&$@1T-#(#0N>"!T=7!L92`H=VAI8V@@:&%S(&%N(&5M<'1Y('!A
M<F5N="DN"@H@("`@("`@("`@("`@("`@(R`M($QE9G0@;F]D92!I<R!T:&4@
M;F5X="!R96-U<G-I;VX@<&%R96YT+@H@("`@("`@("`@("`@("`@(R`M(%)I
M9VAT(&YO9&4@:7,@=&AE(&%C='5A;"!C;&%S<R!C;VYT86EN960@:6X@=&AE
M('1U<&QE+@H*("`@("`@("`@("`@("`@(",@4')O8V5S<R!R:6=H="!N;V1E
M+@H@("`@("`@("`@("`@("`@:6UP;"`]('-E;&8N:&5A9"YC87-T("AN;V1E
M<ULQ72YT>7!E*0H*("`@("`@("`@("`@("`@(",@4')O8V5S<R!L969T(&YO
M9&4@86YD('-E="!I="!A<R!H96%D+@H@("`@("`@("`@("`@("`@<V5L9BYH
M96%D("`]('-E;&8N:&5A9"YC87-T("AN;V1E<ULP72YT>7!E*0H*("`@("`@
M("`@("`@<V5L9BYC;W5N="`]('-E;&8N8V]U;G0@*R`Q"@H@("`@("`@("`@
M("`C($9I;F%L;'DL(&-H96-K('1H92!I;7!L96UE;G1A=&EO;BX@($EF(&ET
M(&ES"B`@("`@("`@("`@(",@=W)A<'!E9"!I;B!?35]H96%D7VEM<&P@<F5T
M=7)N('1H870L(&]T:&5R=VES92!R971U<FX*("`@("`@("`@("`@(R!T:&4@
M=F%L=64@(F%S(&ES(BX*("`@("`@("`@("`@9FEE;&1S(#T@:6UP;"YT>7!E
M+F9I96QD<R`H*0H@("`@("`@("`@("!I9B!L96X@*&9I96QD<RD@/"`Q(&]R
M(&9I96QD<ULP72YN86UE("$](")?35]H96%D7VEM<&PB.@H@("`@("`@("`@
M("`@("`@<F5T=7)N("@G6R5D72<@)2!S96QF+F-O=6YT+"!I;7!L*0H@("`@
M("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@<F5T=7)N("@G6R5D72<@
M)2!S96QF+F-O=6YT+"!I;7!L6R=?35]H96%D7VEM<&PG72D*"B`@("!D968@
M7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N
M='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE
M*0H@("`@("`@('-E;&8N=F%L(#T@=F%L.PH*("`@(&1E9B!C:&EL9')E;B`H
M<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7VET97)A=&]R("AS96QF+G9A
M;"D*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!I9B!L96X@
M*'-E;&8N=F%L+G1Y<&4N9FEE;&1S("@I*2`]/2`P.@H@("`@("`@("`@("!R
M971U<FX@)V5M<'1Y("5S)R`E("AS96QF+G1Y<&5N86UE*0H@("`@("`@(')E
M='5R;B`G)7,@8V]N=&%I;FEN9R<@)2`H<V5L9BYT>7!E;F%M92D*"F-L87-S
M(%-T9%-T86-K3W)1=65U95!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.G-T
M86-K(&]R('-T9#HZ<75E=64B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T
M>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y<&5N86UE(#T@<W1R:7!?
M=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*("`@("`@("!S96QF+G9I
M<W5A;&EZ97(@/2!G9&(N9&5F875L=%]V:7-U86QI>F5R*'9A;%LG8R==*0H*
M("`@(&1E9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8N
M=FES=6%L:7IE<BYC:&EL9')E;B@I"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L
M9BDZ"B`@("`@("`@<F5T=7)N("<E<R!W<F%P<&EN9SH@)7,G("4@*'-E;&8N
M='EP96YA;64L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M('-E;&8N=FES=6%L:7IE<BYT;U]S=')I;F<H*2D*"B`@("!D968@9&ES<&QA
M>5]H:6YT("AS96QF*3H*("`@("`@("!I9B!H87-A='1R("AS96QF+G9I<W5A
M;&EZ97(L("=D:7-P;&%Y7VAI;G0G*3H*("`@("`@("`@("`@<F5T=7)N('-E
M;&8N=FES=6%L:7IE<BYD:7-P;&%Y7VAI;G0@*"D*("`@("`@("!R971U<FX@
M3F]N90H*8VQA<W,@4F)T<F5E271E<F%T;W(H271E<F%T;W(I.@H@("`@(B(B
M"B`@("!4=7)N(&%N(%)"+71R964M8F%S960@8V]N=&%I;F5R("AS=&0Z.FUA
M<"P@<W1D.CIS970@971C+BD@:6YT;PH@("`@82!0>71H;VX@:71E<F%B;&4@
M;V)J96-T+@H@("`@(B(B"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L(')B=')E
M92DZ"B`@("`@("`@<V5L9BYS:7IE(#T@<F)T<F5E6R=?35]T)UU;)U]-7VEM
M<&PG75LG7TU?;F]D95]C;W5N="=="B`@("`@("`@<V5L9BYN;V1E(#T@<F)T
M<F5E6R=?35]T)UU;)U]-7VEM<&PG75LG7TU?:&5A9&5R)UU;)U]-7VQE9G0G
M70H@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@9&5F(%]?:71E<E]?*'-E
M;&8I.@H@("`@("`@(')E='5R;B!S96QF"@H@("`@9&5F(%]?;&5N7U\H<V5L
M9BDZ"B`@("`@("`@<F5T=7)N(&EN="`H<V5L9BYS:7IE*0H*("`@(&1E9B!?
M7VYE>'1?7RAS96QF*3H*("`@("`@("!I9B!S96QF+F-O=6YT(#T]('-E;&8N
M<VEZ93H*("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H@("`@("`@
M(')E<W5L="`]('-E;&8N;F]D90H@("`@("`@('-E;&8N8V]U;G0@/2!S96QF
M+F-O=6YT("L@,0H@("`@("`@(&EF('-E;&8N8V]U;G0@/"!S96QF+G-I>F4Z
M"B`@("`@("`@("`@(",@0V]M<'5T92!T:&4@;F5X="!N;V1E+@H@("`@("`@
M("`@("!N;V1E(#T@<V5L9BYN;V1E"B`@("`@("`@("`@(&EF(&YO9&4N9&5R
M969E<F5N8V4H*5LG7TU?<FEG:'0G73H*("`@("`@("`@("`@("`@(&YO9&4@
M/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-7W)I9VAT)UT*("`@("`@("`@("`@
M("`@('=H:6QE(&YO9&4N9&5R969E<F5N8V4H*5LG7TU?;&5F="==.@H@("`@
M("`@("`@("`@("`@("`@(&YO9&4@/2!N;V1E+F1E<F5F97)E;F-E*"E;)U]-
M7VQE9G0G70H@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@<&%R
M96YT(#T@;F]D92YD97)E9F5R96YC92@I6R=?35]P87)E;G0G70H@("`@("`@
M("`@("`@("`@=VAI;&4@;F]D92`]/2!P87)E;G0N9&5R969E<F5N8V4H*5LG
M7TU?<FEG:'0G73H*("`@("`@("`@("`@("`@("`@("!N;V1E(#T@<&%R96YT
M"B`@("`@("`@("`@("`@("`@("`@<&%R96YT(#T@<&%R96YT+F1E<F5F97)E
M;F-E*"E;)U]-7W!A<F5N="=="B`@("`@("`@("`@("`@("!I9B!N;V1E+F1E
M<F5F97)E;F-E*"E;)U]-7W)I9VAT)UT@(3T@<&%R96YT.@H@("`@("`@("`@
M("`@("`@("`@(&YO9&4@/2!P87)E;G0*("`@("`@("`@("`@<V5L9BYN;V1E
M(#T@;F]D90H@("`@("`@(')E='5R;B!R97-U;'0*"F1E9B!G971?=F%L=65?
M9G)O;5]28E]T<F5E7VYO9&4H;F]D92DZ"B`@("`B(B)2971U<FYS('1H92!V
M86QU92!H96QD(&EN(&%N(%]28E]T<F5E7VYO9&4\7U9A;#XB(B(*("`@('1R
M>3H*("`@("`@("!M96UB97(@/2!N;V1E+G1Y<&4N9FEE;&1S*"E;,5TN;F%M
M90H@("`@("`@(&EF(&UE;6)E<B`]/2`G7TU?=F%L=65?9FEE;&0G.@H@("`@
M("`@("`@("`C($,K*S`S(&EM<&QE;65N=&%T:6]N+"!N;V1E(&-O;G1A:6YS
M('1H92!V86QU92!A<R!A(&UE;6)E<@H@("`@("`@("`@("!R971U<FX@;F]D
M95LG7TU?=F%L=65?9FEE;&0G70H@("`@("`@(&5L:68@;65M8F5R(#T]("=?
M35]S=&]R86=E)SH*("`@("`@("`@("`@(R!#*RLQ,2!I;7!L96UE;G1A=&EO
M;BP@;F]D92!S=&]R97,@=F%L=64@:6X@7U]A;&EG;F5D7VUE;6)U9@H@("`@
M("`@("`@("!V86QT>7!E(#T@;F]D92YT>7!E+G1E;7!L871E7V%R9W5M96YT
M*#`I"B`@("`@("`@("`@(')E='5R;B!G971?=F%L=65?9G)O;5]A;&EG;F5D
M7VUE;6)U9BAN;V1E6R=?35]S=&]R86=E)UTL('9A;'1Y<&4I"B`@("!E>&-E
M<'0Z"B`@("`@("`@<&%S<PH@("`@<F%I<V4@5F%L=65%<G)O<B@B56YS=7!P
M;W)T960@:6UP;&5M96YT871I;VX@9F]R("5S(B`E('-T<BAN;V1E+G1Y<&4I
M*0H*(R!4:&ES(&ES(&$@<')E='1Y('!R:6YT97(@9F]R('-T9#HZ7U)B7W1R
M965?:71E<F%T;W(@*'=H:6-H(&ES"B,@<W1D.CIM87`Z.FET97)A=&]R*2P@
M86YD(&AA<R!N;W1H:6YG('1O(&1O('=I=&@@=&AE(%)B=')E94ET97)A=&]R
M"B,@8VQA<W,@86)O=F4N"F-L87-S(%-T9%)B=')E94ET97)A=&]R4')I;G1E
M<CH*("`@(")0<FEN="!S=&0Z.FUA<#HZ:71E<F%T;W(L('-T9#HZ<V5T.CII
M=&5R871O<BP@971C+B(*"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N
M86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@;F]D
M971Y<&4@/2!L;V]K=7!?;F]D95]T>7!E*"=?4F)?=')E95]N;V1E)RP@<V5L
M9BYV86PN='EP92D*("`@("`@("!S96QF+FQI;FM?='EP92`](&YO9&5T>7!E
M+G!O:6YT97(H*0H*("`@(&1E9B!T;U]S=')I;F<@*'-E;&8I.@H@("`@("`@
M(&EF(&YO="!S96QF+G9A;%LG7TU?;F]D92==.@H@("`@("`@("`@("!R971U
M<FX@)VYO;BUD97)E9F5R96YC96%B;&4@:71E<F%T;W(@9F]R(&%S<V]C:6%T
M:79E(&-O;G1A:6YE<B<*("`@("`@("!N;V1E(#T@<V5L9BYV86Q;)U]-7VYO
M9&4G72YC87-T*'-E;&8N;&EN:U]T>7!E*2YD97)E9F5R96YC92@I"B`@("`@
M("`@<F5T=7)N('-T<BAG971?=F%L=65?9G)O;5]28E]T<F5E7VYO9&4H;F]D
M92DI"@IC;&%S<R!3=&1$96)U9TET97)A=&]R4')I;G1E<CH*("`@(")0<FEN
M="!A(&1E8G5G(&5N86)L960@=F5R<VEO;B!O9B!A;B!I=&5R871O<B(*"B`@
M("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@
M('-E;&8N=F%L(#T@=F%L"@H@("`@(R!*=7-T('-T<FEP(&%W87D@=&AE(&5N
M8V%P<W5L871I;F<@7U]G;G5?9&5B=6<Z.E]3869E7VET97)A=&]R"B`@("`C
M(&%N9"!R971U<FX@=&AE('=R87!P960@:71E<F%T;W(@=F%L=64N"B`@("!D
M968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!B87-E7W1Y<&4@/2!G9&(N
M;&]O:W5P7W1Y<&4H)U]?9VYU7V1E8G5G.CI?4V%F95]I=&5R871O<E]B87-E
M)RD*("`@("`@("!I='EP92`]('-E;&8N=F%L+G1Y<&4N=&5M<&QA=&5?87)G
M=6UE;G0H,"D*("`@("`@("!S869E7W-E<2`]('-E;&8N=F%L+F-A<W0H8F%S
M95]T>7!E*5LG7TU?<V5Q=65N8V4G70H@("`@("`@(&EF(&YO="!S869E7W-E
M<3H*("`@("`@("`@("`@<F5T=7)N('-T<BAS96QF+G9A;"YC87-T*&ET>7!E
M*2D*("`@("`@("!I9B!S96QF+G9A;%LG7TU?=F5R<VEO;B==("$]('-A9F5?
M<V5Q6R=?35]V97)S:6]N)UTZ"B`@("`@("`@("`@(')E='5R;B`B:6YV86QI
M9"!I=&5R871O<B(*("`@("`@("!R971U<FX@<W1R*'-E;&8N=F%L+F-A<W0H
M:71Y<&4I*0H*9&5F(&YU;5]E;&5M96YT<RAN=6TI.@H@("`@(B(B4F5T=7)N
M(&5I=&AE<B`B,2!E;&5M96YT(B!O<B`B3B!E;&5M96YT<R(@9&5P96YD:6YG
M(&]N('1H92!A<F=U;65N="XB(B(*("`@(')E='5R;B`G,2!E;&5M96YT)R!I
M9B!N=6T@/3T@,2!E;'-E("<E9"!E;&5M96YT<R<@)2!N=6T*"F-L87-S(%-T
M9$UA<%!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.FUA<"!O<B!S=&0Z.FUU
M;'1I;6%P(@H*("`@(",@5'5R;B!A;B!28G1R965)=&5R871O<B!I;G1O(&$@
M<')E='1Y+7!R:6YT(&ET97)A=&]R+@H@("`@8VQA<W,@7VET97(H271E<F%T
M;W(I.@H@("`@("`@(&1E9B!?7VEN:71?7RAS96QF+"!R8FET97(L('1Y<&4I
M.@H@("`@("`@("`@("!S96QF+G)B:71E<B`](')B:71E<@H@("`@("`@("`@
M("!S96QF+F-O=6YT(#T@,`H@("`@("`@("`@("!S96QF+G1Y<&4@/2!T>7!E
M"@H@("`@("`@(&1E9B!?7VET97)?7RAS96QF*3H*("`@("`@("`@("`@<F5T
M=7)N('-E;&8*"B`@("`@("`@9&5F(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@
M("`@("!I9B!S96QF+F-O=6YT("4@,B`]/2`P.@H@("`@("`@("`@("`@("`@
M;B`](&YE>'0H<V5L9BYR8FET97(I"B`@("`@("`@("`@("`@("!N(#T@;BYC
M87-T*'-E;&8N='EP92DN9&5R969E<F5N8V4H*0H@("`@("`@("`@("`@("`@
M;B`](&=E=%]V86QU95]F<F]M7U)B7W1R965?;F]D92AN*0H@("`@("`@("`@
M("`@("`@<V5L9BYP86ER(#T@;@H@("`@("`@("`@("`@("`@:71E;2`](&Y;
M)V9I<G-T)UT*("`@("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@(&ET
M96T@/2!S96QF+G!A:7);)W-E8V]N9"=="B`@("`@("`@("`@(')E<W5L="`]
M("@G6R5D72<@)2!S96QF+F-O=6YT+"!I=&5M*0H@("`@("`@("`@("!S96QF
M+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@("`@<F5T=7)N(')E
M<W5L=`H*("`@(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ
M"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE
M<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D
M968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!R971U<FX@)R5S('=I=&@@
M)7,G("4@*'-E;&8N='EP96YA;64L"B`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("!N=6U?96QE;65N=',H;&5N*%)B=')E94ET97)A=&]R("AS96QF
M+G9A;"DI*2D*"B`@("!D968@8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(&YO
M9&4@/2!L;V]K=7!?;F]D95]T>7!E*"=?4F)?=')E95]N;V1E)RP@<V5L9BYV
M86PN='EP92DN<&]I;G1E<B@I"B`@("`@("`@<F5T=7)N('-E;&8N7VET97(@
M*%)B=')E94ET97)A=&]R("AS96QF+G9A;"DL(&YO9&4I"@H@("`@9&5F(&1I
M<W!L87E?:&EN="`H<V5L9BDZ"B`@("`@("`@<F5T=7)N("=M87`G"@IC;&%S
M<R!3=&139710<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIS970@;W(@<W1D
M.CIM=6QT:7-E="(*"B`@("`C(%1U<FX@86X@4F)T<F5E271E<F%T;W(@:6YT
M;R!A('!R971T>2UP<FEN="!I=&5R871O<BX*("`@(&-L87-S(%]I=&5R*$ET
M97)A=&]R*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@<F)I=&5R+"!T
M>7!E*3H*("`@("`@("`@("`@<V5L9BYR8FET97(@/2!R8FET97(*("`@("`@
M("`@("`@<V5L9BYC;W5N="`](#`*("`@("`@("`@("`@<V5L9BYT>7!E(#T@
M='EP90H*("`@("`@("!D968@7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@
M(')E='5R;B!S96QF"@H@("`@("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@
M("`@("`@("`@:71E;2`](&YE>'0H<V5L9BYR8FET97(I"B`@("`@("`@("`@
M(&ET96T@/2!I=&5M+F-A<W0H<V5L9BYT>7!E*2YD97)E9F5R96YC92@I"B`@
M("`@("`@("`@(&ET96T@/2!G971?=F%L=65?9G)O;5]28E]T<F5E7VYO9&4H
M:71E;2D*("`@("`@("`@("`@(R!&25A-13H@=&AI<R!I<R!W96ER9"`N+BX@
M=VAA="!T;R!D;S\*("`@("`@("`@("`@(R!-87EB92!A("=S970G(&1I<W!L
M87D@:&EN=#\*("`@("`@("`@("`@<F5S=6QT(#T@*"=;)61=)R`E('-E;&8N
M8V]U;G0L(&ET96TI"B`@("`@("`@("`@('-E;&8N8V]U;G0@/2!S96QF+F-O
M=6YT("L@,0H@("`@("`@("`@("!R971U<FX@<F5S=6QT"@H@("`@9&5F(%]?
M:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S96QF+G1Y
M<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E;F%M92D*
M("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!T;U]S=')I;F<@*'-E
M;&8I.@H@("`@("`@(')E='5R;B`G)7,@=VET:"`E<R<@)2`H<V5L9BYT>7!E
M;F%M92P*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(&YU;5]E;&5M
M96YT<RAL96XH4F)T<F5E271E<F%T;W(@*'-E;&8N=F%L*2DI*0H*("`@(&1E
M9B!C:&EL9')E;B`H<V5L9BDZ"B`@("`@("`@;F]D92`](&QO;VMU<%]N;V1E
M7W1Y<&4H)U]28E]T<F5E7VYO9&4G+"!S96QF+G9A;"YT>7!E*2YP;VEN=&5R
M*"D*("`@("`@("!R971U<FX@<V5L9BY?:71E<B`H4F)T<F5E271E<F%T;W(@
M*'-E;&8N=F%L*2P@;F]D92D*"F-L87-S(%-T9$)I='-E=%!R:6YT97(Z"B`@
M("`B4')I;G0@82!S=&0Z.F)I='-E="(*"B`@("!D968@7U]I;FET7U\H<V5L
M9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T
M<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@("`@("`@<V5L
M9BYV86P@/2!V86P*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@
M("`C($EF('1E;7!L871E7V%R9W5M96YT(&AA;F1L960@=F%L=65S+"!W92!C
M;W5L9"!P<FEN="!T:&4*("`@("`@("`C('-I>F4N("!/<B!W92!C;W5L9"!U
M<V4@82!R96=E>'`@;VX@=&AE('1Y<&4N"B`@("`@("`@<F5T=7)N("<E<R<@
M)2`H<V5L9BYT>7!E;F%M92D*"B`@("!D968@8VAI;&1R96X@*'-E;&8I.@H@
M("`@("`@('1R>3H*("`@("`@("`@("`@(R!!;B!E;7!T>2!B:71S970@;6%Y
M(&YO="!H879E(&%N>2!M96UB97)S('=H:6-H('=I;&P*("`@("`@("`@("`@
M(R!R97-U;'0@:6X@86X@97AC97!T:6]N(&)E:6YG('1H<F]W;BX*("`@("`@
M("`@("`@=V]R9',@/2!S96QF+G9A;%LG7TU?=R=="B`@("`@("`@97AC97!T
M.@H@("`@("`@("`@("!R971U<FX@6UT*"B`@("`@("`@=W1Y<&4@/2!W;W)D
M<RYT>7!E"@H@("`@("`@(",@5&AE(%]-7W<@;65M8F5R(&-A;B!B92!E:71H
M97(@86X@=6YS:6=N960@;&]N9RP@;W(@86X*("`@("`@("`C(&%R<F%Y+B`@
M5&AI<R!D97!E;F1S(&]N('1H92!T96UP;&%T92!S<&5C:6%L:7IA=&EO;B!U
M<V5D+@H@("`@("`@(",@268@:70@:7,@82!S:6YG;&4@;&]N9RP@8V]N=F5R
M="!T;R!A('-I;F=L92!E;&5M96YT(&QI<W0N"B`@("`@("`@:68@=W1Y<&4N
M8V]D92`]/2!G9&(N5%E015]#3T1%7T%24D%9.@H@("`@("`@("`@("!T<VEZ
M92`]('=T>7!E+G1A<F=E="`H*2YS:7IE;V8*("`@("`@("!E;'-E.@H@("`@
M("`@("`@("!W;W)D<R`](%MW;W)D<UT*("`@("`@("`@("`@='-I>F4@/2!W
M='EP92YS:7IE;V8*"B`@("`@("`@;G=O<F1S(#T@=W1Y<&4N<VEZ96]F("\@
M='-I>F4*("`@("`@("!R97-U;'0@/2!;70H@("`@("`@(&)Y=&4@/2`P"B`@
M("`@("`@=VAI;&4@8GET92`\(&YW;W)D<SH*("`@("`@("`@("`@=R`]('=O
M<F1S6V)Y=&5="B`@("`@("`@("`@(&)I="`](#`*("`@("`@("`@("`@=VAI
M;&4@=R`A/2`P.@H@("`@("`@("`@("`@("`@:68@*'<@)B`Q*2`A/2`P.@H@
M("`@("`@("`@("`@("`@("`@(",@06YO=&AE<B!S<&]T('=H97)E('=E(&-O
M=6QD('5S92`G<V5T)S\*("`@("`@("`@("`@("`@("`@("!R97-U;'0N87!P
M96YD*"@G6R5D72<@)2`H8GET92`J('1S:7IE("H@."`K(&)I="DL(#$I*0H@
M("`@("`@("`@("`@("`@8FET(#T@8FET("L@,0H@("`@("`@("`@("`@("`@
M=R`]('<@/CX@,0H@("`@("`@("`@("!B>71E(#T@8GET92`K(#$*("`@("`@
M("!R971U<FX@<F5S=6QT"@IC;&%S<R!3=&1$97%U95!R:6YT97(Z"B`@("`B
M4')I;G0@82!S=&0Z.F1E<75E(@H*("`@(&-L87-S(%]I=&5R*$ET97)A=&]R
M*3H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@;F]D92P@<W1A<G0L(&5N
M9"P@;&%S="P@8G5F9F5R7W-I>F4I.@H@("`@("`@("`@("!S96QF+FYO9&4@
M/2!N;V1E"B`@("`@("`@("`@('-E;&8N<"`]('-T87)T"B`@("`@("`@("`@
M('-E;&8N96YD(#T@96YD"B`@("`@("`@("`@('-E;&8N;&%S="`](&QA<W0*
M("`@("`@("`@("`@<V5L9BYB=69F97)?<VEZ92`](&)U9F9E<E]S:7IE"B`@
M("`@("`@("`@('-E;&8N8V]U;G0@/2`P"@H@("`@("`@(&1E9B!?7VET97)?
M7RAS96QF*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8*"B`@("`@("`@9&5F
M(%]?;F5X=%]?*'-E;&8I.@H@("`@("`@("`@("!I9B!S96QF+G`@/3T@<V5L
M9BYL87-T.@H@("`@("`@("`@("`@("`@<F%I<V4@4W1O<$ET97)A=&EO;@H*
M("`@("`@("`@("`@<F5S=6QT(#T@*"=;)61=)R`E('-E;&8N8V]U;G0L('-E
M;&8N<"YD97)E9F5R96YC92@I*0H@("`@("`@("`@("!S96QF+F-O=6YT(#T@
M<V5L9BYC;W5N="`K(#$*"B`@("`@("`@("`@(",@061V86YC92!T:&4@)V-U
M<B<@<&]I;G1E<BX*("`@("`@("`@("`@<V5L9BYP(#T@<V5L9BYP("L@,0H@
M("`@("`@("`@("!I9B!S96QF+G`@/3T@<V5L9BYE;F0Z"B`@("`@("`@("`@
M("`@("`C($EF('=E(&=O="!T;R!T:&4@96YD(&]F('1H:7,@8G5C:V5T+"!M
M;W9E('1O('1H90H@("`@("`@("`@("`@("`@(R!N97AT(&)U8VME="X*("`@
M("`@("`@("`@("`@('-E;&8N;F]D92`]('-E;&8N;F]D92`K(#$*("`@("`@
M("`@("`@("`@('-E;&8N<"`]('-E;&8N;F]D95LP70H@("`@("`@("`@("`@
M("`@<V5L9BYE;F0@/2!S96QF+G`@*R!S96QF+F)U9F9E<E]S:7IE"@H@("`@
M("`@("`@("!R971U<FX@<F5S=6QT"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I
M<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"B`@("`@("`@<V5L9BYE;'1T>7!E(#T@=F%L+G1Y<&4N=&5M
M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("!S:7IE(#T@<V5L9BYE;'1T>7!E
M+G-I>F5O9@H@("`@("`@(&EF('-I>F4@/"`U,3(Z"B`@("`@("`@("`@('-E
M;&8N8G5F9F5R7W-I>F4@/2!I;G0@*#4Q,B`O('-I>F4I"B`@("`@("`@96QS
M93H*("`@("`@("`@("`@<V5L9BYB=69F97)?<VEZ92`](#$*"B`@("!D968@
M=&]?<W1R:6YG*'-E;&8I.@H@("`@("`@('-T87)T(#T@<V5L9BYV86Q;)U]-
M7VEM<&PG75LG7TU?<W1A<G0G70H@("`@("`@(&5N9"`]('-E;&8N=F%L6R=?
M35]I;7!L)UU;)U]-7V9I;FES:"=="@H@("`@("`@(&1E;'1A7VX@/2!E;F1;
M)U]-7VYO9&4G72`M('-T87)T6R=?35]N;V1E)UT@+2`Q"B`@("`@("`@9&5L
M=&%?<R`]('-T87)T6R=?35]L87-T)UT@+2!S=&%R=%LG7TU?8W5R)UT*("`@
M("`@("!D96QT85]E(#T@96YD6R=?35]C=7(G72`M(&5N9%LG7TU?9FER<W0G
M70H*("`@("`@("!S:7IE(#T@<V5L9BYB=69F97)?<VEZ92`J(&1E;'1A7VX@
M*R!D96QT85]S("L@9&5L=&%?90H*("`@("`@("!R971U<FX@)R5S('=I=&@@
M)7,G("4@*'-E;&8N='EP96YA;64L(&YU;5]E;&5M96YT<RAL;VYG*'-I>F4I
M*2D*"B`@("!D968@8VAI;&1R96XH<V5L9BDZ"B`@("`@("`@<W1A<G0@/2!S
M96QF+G9A;%LG7TU?:6UP;"==6R=?35]S=&%R="=="B`@("`@("`@96YD(#T@
M<V5L9BYV86Q;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UT*("`@("`@("!R971U
M<FX@<V5L9BY?:71E<BAS=&%R=%LG7TU?;F]D92==+"!S=&%R=%LG7TU?8W5R
M)UTL('-T87)T6R=?35]L87-T)UTL"B`@("`@("`@("`@("`@("`@("`@("`@
M("`@96YD6R=?35]C=7(G72P@<V5L9BYB=69F97)?<VEZ92D*"B`@("!D968@
M9&ES<&QA>5]H:6YT("AS96QF*3H*("`@("`@("!R971U<FX@)V%R<F%Y)PH*
M8VQA<W,@4W1D1&5Q=65)=&5R871O<E!R:6YT97(Z"B`@("`B4')I;G0@<W1D
M.CID97%U93HZ:71E<F%T;W(B"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y
M<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"@H@("`@9&5F
M('1O7W-T<FEN9RAS96QF*3H*("`@("`@("!I9B!N;W0@<V5L9BYV86Q;)U]-
M7V-U<B==.@H@("`@("`@("`@("!R971U<FX@)VYO;BUD97)E9F5R96YC96%B
M;&4@:71E<F%T;W(@9F]R('-T9#HZ9&5Q=64G"B`@("`@("`@<F5T=7)N('-T
M<BAS96QF+G9A;%LG7TU?8W5R)UTN9&5R969E<F5N8V4H*2D*"F-L87-S(%-T
M9%-T<FEN9U!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.F)A<VEC7W-T<FEN
M9R!O9B!S;VUE(&MI;F0B"@H@("`@9&5F(%]?:6YI=%]?*'-E;&8L('1Y<&5N
M86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L
M9BYN97=?<W1R:6YG(#T@='EP96YA;64N9FEN9"@B.CI?7V-X>#$Q.CIB87-I
M8U]S=')I;F<B*2`A/2`M,0H*("`@(&1E9B!T;U]S=')I;F<H<V5L9BDZ"B`@
M("`@("`@(R!-86ME('-U<F4@)G-T<FEN9R!W;W)K<RP@=&]O+@H@("`@("`@
M('1Y<&4@/2!S96QF+G9A;"YT>7!E"B`@("`@("`@:68@='EP92YC;V1E(#T]
M(&=D8BY465!%7T-/1$5?4D5&.@H@("`@("`@("`@("!T>7!E(#T@='EP92YT
M87)G970@*"D*"B`@("`@("`@(R!#86QC=6QA=&4@=&AE(&QE;F=T:"!O9B!T
M:&4@<W1R:6YG('-O('1H870@=&]?<W1R:6YG(')E='5R;G,*("`@("`@("`C
M('1H92!S=')I;F<@86-C;W)D:6YG('1O(&QE;F=T:"P@;F]T(&%C8V]R9&EN
M9R!T;R!F:7)S="!N=6QL"B`@("`@("`@(R!E;F-O=6YT97)E9"X*("`@("`@
M("!P='(@/2!S96QF+G9A;"!;)U]-7V1A=&%P;'5S)UU;)U]-7W`G70H@("`@
M("`@(&EF('-E;&8N;F5W7W-T<FEN9SH*("`@("`@("`@("`@;&5N9W1H(#T@
M<V5L9BYV86Q;)U]-7W-T<FEN9U]L96YG=&@G70H@("`@("`@("`@("`C(&AT
M='!S.B\O<V]U<F-E=V%R92YO<F<O8G5G>FEL;&$O<VAO=U]B=6<N8V=I/VED
M/3$W-S(X"B`@("`@("`@("`@('!T<B`]('!T<BYC87-T*'!T<BYT>7!E+G-T
M<FEP7W1Y<&5D969S*"DI"B`@("`@("`@96QS93H*("`@("`@("`@("`@<F5A
M;'1Y<&4@/2!T>7!E+G5N<75A;&EF:65D("@I+G-T<FEP7W1Y<&5D969S("@I
M"B`@("`@("`@("`@(')E<'1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4@*'-T<B`H
M<F5A;'1Y<&4I("L@)SHZ7U)E<"<I+G!O:6YT97(@*"D*("`@("`@("`@("`@
M:&5A9&5R(#T@<'1R+F-A<W0H<F5P='EP92D@+2`Q"B`@("`@("`@("`@(&QE
M;F=T:"`](&AE861E<BYD97)E9F5R96YC92`H*5LG7TU?;&5N9W1H)UT*("`@
M("`@("!I9B!H87-A='1R*'!T<BP@(FQA>GE?<W1R:6YG(BDZ"B`@("`@("`@
M("`@(')E='5R;B!P='(N;&%Z>5]S=')I;F<@*&QE;F=T:"`](&QE;F=T:"D*
M("`@("`@("!R971U<FX@<'1R+G-T<FEN9R`H;&5N9W1H(#T@;&5N9W1H*0H*
M("`@(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(')E='5R;B`G
M<W1R:6YG)PH*8VQA<W,@5'(Q2&%S:'1A8FQE271E<F%T;W(H271E<F%T;W(I
M.@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!H87-H=&%B;&4I.@H@("`@("`@
M('-E;&8N8G5C:V5T<R`](&AA<VAT86)L95LG7TU?8G5C:V5T<R=="B`@("`@
M("`@<V5L9BYB=6-K970@/2`P"B`@("`@("`@<V5L9BYB=6-K971?8V]U;G0@
M/2!H87-H=&%B;&5;)U]-7V)U8VME=%]C;W5N="=="B`@("`@("`@<V5L9BYN
M;V1E7W1Y<&4@/2!F:6YD7W1Y<&4H:&%S:'1A8FQE+G1Y<&4L("=?3F]D92<I
M+G!O:6YT97(H*0H@("`@("`@('-E;&8N;F]D92`](#`*("`@("`@("!W:&EL
M92!S96QF+F)U8VME="`A/2!S96QF+F)U8VME=%]C;W5N=#H*("`@("`@("`@
M("`@<V5L9BYN;V1E(#T@<V5L9BYB=6-K971S6W-E;&8N8G5C:V5T70H@("`@
M("`@("`@("!I9B!S96QF+FYO9&4Z"B`@("`@("`@("`@("`@("!B<F5A:PH@
M("`@("`@("`@("!S96QF+F)U8VME="`]('-E;&8N8G5C:V5T("L@,0H*("`@
M(&1E9B!?7VET97)?7R`H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8*"B`@
M("!D968@7U]N97AT7U\@*'-E;&8I.@H@("`@("`@(&EF('-E;&8N;F]D92`]
M/2`P.@H@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@
M;F]D92`]('-E;&8N;F]D92YC87-T*'-E;&8N;F]D95]T>7!E*0H@("`@("`@
M(')E<W5L="`](&YO9&4N9&5R969E<F5N8V4H*5LG7TU?=B=="B`@("`@("`@
M<V5L9BYN;V1E(#T@;F]D92YD97)E9F5R96YC92@I6R=?35]N97AT)UT["B`@
M("`@("`@:68@<V5L9BYN;V1E(#T](#`Z"B`@("`@("`@("`@('-E;&8N8G5C
M:V5T(#T@<V5L9BYB=6-K970@*R`Q"B`@("`@("`@("`@('=H:6QE('-E;&8N
M8G5C:V5T("$]('-E;&8N8G5C:V5T7V-O=6YT.@H@("`@("`@("`@("`@("`@
M<V5L9BYN;V1E(#T@<V5L9BYB=6-K971S6W-E;&8N8G5C:V5T70H@("`@("`@
M("`@("`@("`@:68@<V5L9BYN;V1E.@H@("`@("`@("`@("`@("`@("`@(&)R
M96%K"B`@("`@("`@("`@("`@("!S96QF+F)U8VME="`]('-E;&8N8G5C:V5T
M("L@,0H@("`@("`@(')E='5R;B!R97-U;'0*"F-L87-S(%-T9$AA<VAT86)L
M94ET97)A=&]R*$ET97)A=&]R*3H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!H
M87-H=&%B;&4I.@H@("`@("`@('-E;&8N;F]D92`](&AA<VAT86)L95LG7TU?
M8F5F;W)E7V)E9VEN)UU;)U]-7VYX="=="B`@("`@("`@=F%L='EP92`](&AA
M<VAT86)L92YT>7!E+G1E;7!L871E7V%R9W5M96YT*#$I"B`@("`@("`@8V%C
M:&5D(#T@:&%S:'1A8FQE+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H.2DN=&5M
M<&QA=&5?87)G=6UE;G0H,"D*("`@("`@("!N;V1E7W1Y<&4@/2!L;V]K=7!?
M=&5M<&Q?<W!E8R@G<W1D.CI?7V1E=&%I;#HZ7TAA<VA?;F]D92<L('-T<BAV
M86QT>7!E*2P*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`G=')U92<@:68@8V%C:&5D(&5L<V4@)V9A;'-E)RD*("`@("`@("!S96QF
M+FYO9&5?='EP92`](&YO9&5?='EP92YP;VEN=&5R*"D*"B`@("!D968@7U]I
M=&5R7U\H<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8*"B`@("!D968@7U]N
M97AT7U\H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYN;V1E(#T](#`Z"B`@("`@
M("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("!E;'0@/2!S96QF
M+FYO9&4N8V%S="AS96QF+FYO9&5?='EP92DN9&5R969E<F5N8V4H*0H@("`@
M("`@('-E;&8N;F]D92`](&5L=%LG7TU?;GAT)UT*("`@("`@("!V86QP='(@
M/2!E;'1;)U]-7W-T;W)A9V4G72YA9&1R97-S"B`@("`@("`@=F%L<'1R(#T@
M=F%L<'1R+F-A<W0H96QT+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,"DN<&]I
M;G1E<B@I*0H@("`@("`@(')E='5R;B!V86QP='(N9&5R969E<F5N8V4H*0H*
M8VQA<W,@5'(Q56YO<F1E<F5D4V5T4')I;G1E<CH*("`@(")0<FEN="!A('-T
M9#HZ=6YO<F1E<F5D7W-E="!O<B!T<C$Z.G5N;W)D97)E9%]S970B"@H@("`@
M9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M92P@=F%L*3H*("`@("`@("!S
M96QF+G1Y<&5N86UE(#T@<W1R:7!?=F5R<VEO;F5D7VYA;65S<&%C92AT>7!E
M;F%M92D*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!H87-H=&%B
M;&4@*'-E;&8I.@H@("`@("`@(&EF('-E;&8N='EP96YA;64N<W1A<G1S=VET
M:"@G<W1D.CIT<C$G*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=F%L"B`@
M("`@("`@<F5T=7)N('-E;&8N=F%L6R=?35]H)UT*"B`@("!D968@=&]?<W1R
M:6YG("AS96QF*3H*("`@("`@("!C;W5N="`]('-E;&8N:&%S:'1A8FQE*"E;
M)U]-7V5L96UE;G1?8V]U;G0G70H@("`@("`@(')E='5R;B`G)7,@=VET:"`E
M<R<@)2`H<V5L9BYT>7!E;F%M92P@;G5M7V5L96UE;G1S*&-O=6YT*2D*"B`@
M("!`<W1A=&EC;65T:&]D"B`@("!D968@9F]R;6%T7V-O=6YT("AI*3H*("`@
M("`@("!R971U<FX@)ULE9%TG("4@:0H*("`@(&1E9B!C:&EL9')E;B`H<V5L
M9BDZ"B`@("`@("`@8V]U;G1E<B`](&EM87`@*'-E;&8N9F]R;6%T7V-O=6YT
M+"!I=&5R=&]O;',N8V]U;G0H*2D*("`@("`@("!I9B!S96QF+G1Y<&5N86UE
M+G-T87)T<W=I=&@H)W-T9#HZ='(Q)RDZ"B`@("`@("`@("`@(')E='5R;B!I
M>FEP("AC;W5N=&5R+"!4<C%(87-H=&%B;&5)=&5R871O<B`H<V5L9BYH87-H
M=&%B;&4H*2DI"B`@("`@("`@<F5T=7)N(&EZ:7`@*&-O=6YT97(L(%-T9$AA
M<VAT86)L94ET97)A=&]R("AS96QF+FAA<VAT86)L92@I*2D*"F-L87-S(%1R
M,55N;W)D97)E9$UA<%!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.G5N;W)D
M97)E9%]M87`@;W(@='(Q.CIU;F]R9&5R961?;6%P(@H*("`@(&1E9B!?7VEN
M:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYT>7!E
M;F%M92`]('-T<FEP7W9E<G-I;VYE9%]N86UE<W!A8V4H='EP96YA;64I"B`@
M("`@("`@<V5L9BYV86P@/2!V86P*"B`@("!D968@:&%S:'1A8FQE("AS96QF
M*3H*("`@("`@("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H)W-T9#HZ
M='(Q)RDZ"B`@("`@("`@("`@(')E='5R;B!S96QF+G9A;`H@("`@("`@(')E
M='5R;B!S96QF+G9A;%LG7TU?:"=="@H@("`@9&5F('1O7W-T<FEN9R`H<V5L
M9BDZ"B`@("`@("`@8V]U;G0@/2!S96QF+FAA<VAT86)L92@I6R=?35]E;&5M
M96YT7V-O=6YT)UT*("`@("`@("!R971U<FX@)R5S('=I=&@@)7,G("4@*'-E
M;&8N='EP96YA;64L(&YU;5]E;&5M96YT<RAC;W5N="DI"@H@("`@0'-T871I
M8VUE=&AO9`H@("`@9&5F(&9L871T96X@*&QI<W0I.@H@("`@("`@(&9O<B!E
M;'0@:6X@;&ES=#H*("`@("`@("`@("`@9F]R(&D@:6X@96QT.@H@("`@("`@
M("`@("`@("`@>6EE;&0@:0H*("`@($!S=&%T:6-M971H;V0*("`@(&1E9B!F
M;W)M871?;VYE("AE;'0I.@H@("`@("`@(')E='5R;B`H96QT6R=F:7)S="==
M+"!E;'1;)W-E8V]N9"==*0H*("`@($!S=&%T:6-M971H;V0*("`@(&1E9B!F
M;W)M871?8V]U;G0@*&DI.@H@("`@("`@(')E='5R;B`G6R5D72<@)2!I"@H@
M("`@9&5F(&-H:6QD<F5N("AS96QF*3H*("`@("`@("!C;W5N=&5R(#T@:6UA
M<"`H<V5L9BYF;W)M871?8V]U;G0L(&ET97)T;V]L<RYC;W5N="@I*0H@("`@
M("`@(",@36%P(&]V97(@=&AE(&AA<V@@=&%B;&4@86YD(&9L871T96X@=&AE
M(')E<W5L="X*("`@("`@("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H
M)W-T9#HZ='(Q)RDZ"B`@("`@("`@("`@(&1A=&$@/2!S96QF+F9L871T96X@
M*&EM87`@*'-E;&8N9F]R;6%T7V]N92P@5'(Q2&%S:'1A8FQE271E<F%T;W(@
M*'-E;&8N:&%S:'1A8FQE*"DI*2D*("`@("`@("`@("`@(R!::7`@=&AE('1W
M;R!I=&5R871O<G,@=&]G971H97(N"B`@("`@("`@("`@(')E='5R;B!I>FEP
M("AC;W5N=&5R+"!D871A*0H@("`@("`@(&1A=&$@/2!S96QF+F9L871T96X@
M*&EM87`@*'-E;&8N9F]R;6%T7V]N92P@4W1D2&%S:'1A8FQE271E<F%T;W(@
M*'-E;&8N:&%S:'1A8FQE*"DI*2D*("`@("`@("`C(%II<"!T:&4@='=O(&ET
M97)A=&]R<R!T;V=E=&AE<BX*("`@("`@("!R971U<FX@:7II<"`H8V]U;G1E
M<BP@9&%T82D*"B`@("!D968@9&ES<&QA>5]H:6YT("AS96QF*3H*("`@("`@
M("!R971U<FX@)VUA<"<*"F-L87-S(%-T9$9O<G=A<F1,:7-T4')I;G1E<CH*
M("`@(")0<FEN="!A('-T9#HZ9F]R=V%R9%]L:7-T(@H*("`@(&-L87-S(%]I
M=&5R871O<BA)=&5R871O<BDZ"B`@("`@("`@9&5F(%]?:6YI=%]?*'-E;&8L
M(&YO9&5T>7!E+"!H96%D*3H*("`@("`@("`@("`@<V5L9BYN;V1E='EP92`]
M(&YO9&5T>7!E"B`@("`@("`@("`@('-E;&8N8F%S92`](&AE861;)U]-7VYE
M>'0G70H@("`@("`@("`@("!S96QF+F-O=6YT(#T@,`H*("`@("`@("!D968@
M7U]I=&5R7U\H<V5L9BDZ"B`@("`@("`@("`@(')E='5R;B!S96QF"@H@("`@
M("`@(&1E9B!?7VYE>'1?7RAS96QF*3H*("`@("`@("`@("`@:68@<V5L9BYB
M87-E(#T](#`Z"B`@("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N
M"B`@("`@("`@("`@(&5L="`]('-E;&8N8F%S92YC87-T*'-E;&8N;F]D971Y
M<&4I+F1E<F5F97)E;F-E*"D*("`@("`@("`@("`@<V5L9BYB87-E(#T@96QT
M6R=?35]N97AT)UT*("`@("`@("`@("`@8V]U;G0@/2!S96QF+F-O=6YT"B`@
M("`@("`@("`@('-E;&8N8V]U;G0@/2!S96QF+F-O=6YT("L@,0H@("`@("`@
M("`@("!V86QP='(@/2!E;'1;)U]-7W-T;W)A9V4G72YA9&1R97-S"B`@("`@
M("`@("`@('9A;'!T<B`]('9A;'!T<BYC87-T*&5L="YT>7!E+G1E;7!L871E
M7V%R9W5M96YT*#`I+G!O:6YT97(H*2D*("`@("`@("`@("`@<F5T=7)N("@G
M6R5D72<@)2!C;W5N="P@=F%L<'1R+F1E<F5F97)E;F-E*"DI"@H@("`@9&5F
M(%]?:6YI=%]?*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N
M=F%L(#T@=F%L"B`@("`@("`@<V5L9BYT>7!E;F%M92`]('-T<FEP7W9E<G-I
M;VYE9%]N86UE<W!A8V4H='EP96YA;64I"@H@("`@9&5F(&-H:6QD<F5N*'-E
M;&8I.@H@("`@("`@(&YO9&5T>7!E(#T@;&]O:W5P7VYO9&5?='EP92@G7T9W
M9%]L:7-T7VYO9&4G+"!S96QF+G9A;"YT>7!E*2YP;VEN=&5R*"D*("`@("`@
M("!R971U<FX@<V5L9BY?:71E<F%T;W(H;F]D971Y<&4L('-E;&8N=F%L6R=?
M35]I;7!L)UU;)U]-7VAE860G72D*"B`@("!D968@=&]?<W1R:6YG*'-E;&8I
M.@H@("`@("`@(&EF('-E;&8N=F%L6R=?35]I;7!L)UU;)U]-7VAE860G75LG
M7TU?;F5X="==(#T](#`Z"B`@("`@("`@("`@(')E='5R;B`G96UP='D@)7,G
M("4@<V5L9BYT>7!E;F%M90H@("`@("`@(')E='5R;B`G)7,G("4@<V5L9BYT
M>7!E;F%M90H*8VQA<W,@4VEN9VQE3V)J0V]N=&%I;F5R4')I;G1E<BAO8FIE
M8W0I.@H@("`@(D)A<V4@8VQA<W,@9F]R('!R:6YT97)S(&]F(&-O;G1A:6YE
M<G,@;V8@<VEN9VQE(&]B:F5C=',B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF
M+"!V86PL('9I>BP@:&EN="`]($YO;F4I.@H@("`@("`@('-E;&8N8V]N=&%I
M;F5D7W9A;'5E(#T@=F%L"B`@("`@("`@<V5L9BYV:7-U86QI>F5R(#T@=FEZ
M"B`@("`@("`@<V5L9BYH:6YT(#T@:&EN=`H*("`@(&1E9B!?<F5C;V=N:7IE
M*'-E;&8L('1Y<&4I.@H@("`@("`@("(B(E)E='5R;B!465!%(&%S(&$@<W1R
M:6YG(&%F=&5R(&%P<&QY:6YG('1Y<&4@<')I;G1E<G,B(B(*("`@("`@("!G
M;&]B86P@7W5S95]T>7!E7W!R:6YT:6YG"B`@("`@("`@:68@;F]T(%]U<V5?
M='EP95]P<FEN=&EN9SH*("`@("`@("`@("`@<F5T=7)N('-T<BAT>7!E*0H@
M("`@("`@(')E='5R;B!G9&(N='EP97,N87!P;'E?='EP95]R96-O9VYI>F5R
M<RAG9&(N='EP97,N9V5T7W1Y<&5?<F5C;V=N:7IE<G,H*2P*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@='EP92D@
M;W(@<W1R*'1Y<&4I"@H@("`@8VQA<W,@7V-O;G1A:6YE9"A)=&5R871O<BDZ
M"B`@("`@("`@9&5F(%]?:6YI=%]?("AS96QF+"!V86PI.@H@("`@("`@("`@
M("!S96QF+G9A;"`]('9A;`H*("`@("`@("!D968@7U]I=&5R7U\@*'-E;&8I
M.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT
M7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N=F%L(&ES($YO;F4Z"B`@
M("`@("`@("`@("`@("!R86ES92!3=&]P271E<F%T:6]N"B`@("`@("`@("`@
M(')E='9A;"`]('-E;&8N=F%L"B`@("`@("`@("`@('-E;&8N=F%L(#T@3F]N
M90H@("`@("`@("`@("!R971U<FX@*"=;8V]N=&%I;F5D('9A;'5E72<L(')E
M='9A;"D*"B`@("!D968@8VAI;&1R96X@*'-E;&8I.@H@("`@("`@(&EF('-E
M;&8N8V]N=&%I;F5D7W9A;'5E(&ES($YO;F4Z"B`@("`@("`@("`@(')E='5R
M;B!S96QF+E]C;VYT86EN960@*$YO;F4I"B`@("`@("`@:68@:&%S871T<B`H
M<V5L9BYV:7-U86QI>F5R+"`G8VAI;&1R96XG*3H*("`@("`@("`@("`@<F5T
M=7)N('-E;&8N=FES=6%L:7IE<BYC:&EL9')E;B`H*0H@("`@("`@(')E='5R
M;B!S96QF+E]C;VYT86EN960@*'-E;&8N8V]N=&%I;F5D7W9A;'5E*0H*("`@
M(&1E9B!D:7-P;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(",@:68@8V]N=&%I
M;F5D('9A;'5E(&ES(&$@;6%P('=E('=A;G0@=&\@9&ES<&QA>2!I;B!T:&4@
M<V%M92!W87D*("`@("`@("!I9B!H87-A='1R("AS96QF+G9I<W5A;&EZ97(L
M("=C:&EL9')E;B<I(&%N9"!H87-A='1R("AS96QF+G9I<W5A;&EZ97(L("=D
M:7-P;&%Y7VAI;G0G*3H*("`@("`@("`@("`@<F5T=7)N('-E;&8N=FES=6%L
M:7IE<BYD:7-P;&%Y7VAI;G0@*"D*("`@("`@("!R971U<FX@<V5L9BYH:6YT
M"@IC;&%S<R!3=&1%>'!!;GE0<FEN=&5R*%-I;F=L94]B:D-O;G1A:6YE<E!R
M:6YT97(I.@H@("`@(E!R:6YT(&$@<W1D.CIA;GD@;W(@<W1D.CIE>'!E<FEM
M96YT86PZ.F%N>2(*"B`@("!D968@7U]I;FET7U\@*'-E;&8L('1Y<&5N86UE
M+"!V86PI.@H@("`@("`@('-E;&8N='EP96YA;64@/2!S=')I<%]V97)S:6]N
M961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N='EP96YA;64@
M/2!R92YS=6(H)UYS=&0Z.F5X<&5R:6UE;G1A;#HZ9G5N9&%M96YT86QS7W9<
M9#HZ)RP@)W-T9#HZ97AP97)I;65N=&%L.CHG+"!S96QF+G1Y<&5N86UE+"`Q
M*0H@("`@("`@('-E;&8N=F%L(#T@=F%L"B`@("`@("`@<V5L9BYC;VYT86EN
M961?='EP92`]($YO;F4*("`@("`@("!C;VYT86EN961?=F%L=64@/2!.;VYE
M"B`@("`@("`@=FES=6%L:7IE<B`]($YO;F4*("`@("`@("!M9W(@/2!S96QF
M+G9A;%LG7TU?;6%N86=E<B=="B`@("`@("`@:68@;6=R("$](#`Z"B`@("`@
M("`@("`@(&9U;F,@/2!G9&(N8FQO8VM?9F]R7W!C*&EN="AM9W(N8V%S="AG
M9&(N;&]O:W5P7W1Y<&4H)VEN='!T<E]T)RDI*2D*("`@("`@("`@("`@:68@
M;F]T(&9U;F,Z"B`@("`@("`@("`@("`@("!R86ES92!686QU945R<F]R*"))
M;G9A;&ED(&9U;F-T:6]N('!O:6YT97(@:6X@)7,B("4@<V5L9BYT>7!E;F%M
M92D*("`@("`@("`@("`@<G@@/2!R(B(B*'LP?3HZ7TUA;F%G97)?7'<K/"XJ
M/BDZ.E]37VUA;F%G95PH*&5N=6T@*3][,'TZ.E]/<"P@*&-O;G-T('LP?7Q[
M,'T@8V]N<W0I(#]<*BP@*'5N:6]N("D_>S!].CI?07)G(#]<*EPI(B(B+F9O
M<FUA="AT>7!E;F%M92D*("`@("`@("`@("`@;2`](')E+FUA=&-H*')X+"!F
M=6YC+F9U;F-T:6]N+FYA;64I"B`@("`@("`@("`@(&EF(&YO="!M.@H@("`@
M("`@("`@("`@("`@<F%I<V4@5F%L=65%<G)O<B@B56YK;F]W;B!M86YA9V5R
M(&9U;F-T:6]N(&EN("5S(B`E('-E;&8N='EP96YA;64I"@H@("`@("`@("`@
M("!M9W)N86UE(#T@;2YG<F]U<"@Q*0H@("`@("`@("`@("`C($9)6$U%(&YE
M960@=&\@97AP86YD("=S=&0Z.G-T<FEN9R<@<V\@=&AA="!G9&(N;&]O:W5P
M7W1Y<&4@=V]R:W,*("`@("`@("`@("`@:68@)W-T9#HZ<W1R:6YG)R!I;B!M
M9W)N86UE.@H@("`@("`@("`@("`@("`@;6=R;F%M92`](')E+G-U8B@B<W1D
M.CIS=')I;F<H/R%<=RDB+"!S='(H9V1B+FQO;VMU<%]T>7!E*"=S=&0Z.G-T
M<FEN9R<I+G-T<FEP7W1Y<&5D969S*"DI+"!M+F=R;W5P*#$I*0H*("`@("`@
M("`@("`@;6=R='EP92`](&=D8BYL;V]K=7!?='EP92AM9W)N86UE*0H@("`@
M("`@("`@("!S96QF+F-O;G1A:6YE9%]T>7!E(#T@;6=R='EP92YT96UP;&%T
M95]A<F=U;65N="@P*0H@("`@("`@("`@("!V86QP='(@/2!.;VYE"B`@("`@
M("`@("`@(&EF("<Z.E]-86YA9V5R7VEN=&5R;F%L)R!I;B!M9W)N86UE.@H@
M("`@("`@("`@("`@("`@=F%L<'1R(#T@<V5L9BYV86Q;)U]-7W-T;W)A9V4G
M75LG7TU?8G5F9F5R)UTN861D<F5S<PH@("`@("`@("`@("!E;&EF("<Z.E]-
M86YA9V5R7V5X=&5R;F%L)R!I;B!M9W)N86UE.@H@("`@("`@("`@("`@("`@
M=F%L<'1R(#T@<V5L9BYV86Q;)U]-7W-T;W)A9V4G75LG7TU?<'1R)UT*("`@
M("`@("`@("`@96QS93H*("`@("`@("`@("`@("`@(')A:7-E(%9A;'5E17)R
M;W(H(E5N:VYO=VX@;6%N86=E<B!F=6YC=&EO;B!I;B`E<R(@)2!S96QF+G1Y
M<&5N86UE*0H@("`@("`@("`@("!C;VYT86EN961?=F%L=64@/2!V86QP='(N
M8V%S="AS96QF+F-O;G1A:6YE9%]T>7!E+G!O:6YT97(H*2DN9&5R969E<F5N
M8V4H*0H@("`@("`@("`@("!V:7-U86QI>F5R(#T@9V1B+F1E9F%U;'1?=FES
M=6%L:7IE<BAC;VYT86EN961?=F%L=64I"B`@("`@("`@<W5P97(H4W1D17AP
M06YY4')I;G1E<BP@<V5L9BDN7U]I;FET7U\@*&-O;G1A:6YE9%]V86QU92P@
M=FES=6%L:7IE<BD*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@
M("!I9B!S96QF+F-O;G1A:6YE9%]T>7!E(&ES($YO;F4Z"B`@("`@("`@("`@
M(')E='5R;B`G)7,@6VYO(&-O;G1A:6YE9"!V86QU95TG("4@<V5L9BYT>7!E
M;F%M90H@("`@("`@(&1E<V,@/2`B)7,@8V]N=&%I;FEN9R`B("4@<V5L9BYT
M>7!E;F%M90H@("`@("`@(&EF(&AA<V%T='(@*'-E;&8N=FES=6%L:7IE<BP@
M)V-H:6QD<F5N)RDZ"B`@("`@("`@("`@(')E='5R;B!D97-C("L@<V5L9BYV
M:7-U86QI>F5R+G1O7W-T<FEN9R`H*0H@("`@("`@('9A;'1Y<&4@/2!S96QF
M+E]R96-O9VYI>F4@*'-E;&8N8V]N=&%I;F5D7W1Y<&4I"B`@("`@("`@<F5T
M=7)N(&1E<V,@*R!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'-T<BAV86QT
M>7!E*2D*"F-L87-S(%-T9$5X<$]P=&EO;F%L4')I;G1E<BA3:6YG;&5/8FI#
M;VYT86EN97)0<FEN=&5R*3H*("`@(")0<FEN="!A('-T9#HZ;W!T:6]N86P@
M;W(@<W1D.CIE>'!E<FEM96YT86PZ.F]P=&EO;F%L(@H*("`@(&1E9B!?7VEN
M:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@=F%L='EP92`]
M('-E;&8N7W)E8V]G;FEZ92`H=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H
M,"DI"B`@("`@("`@='EP96YA;64@/2!S=')I<%]V97)S:6]N961?;F%M97-P
M86-E*'1Y<&5N86UE*0H@("`@("`@('-E;&8N='EP96YA;64@/2!R92YS=6(H
M)UYS=&0Z.BAE>'!E<FEM96YT86PZ.GPI*&9U;F1A;65N=&%L<U]V7&0Z.GPI
M*"XJ*2<L('(G<W1D.CI<,5PS/"5S/B<@)2!V86QT>7!E+"!T>7!E;F%M92P@
M,2D*("`@("`@("!P87EL;V%D(#T@=F%L6R=?35]P87EL;V%D)UT*("`@("`@
M("!I9B!S96QF+G1Y<&5N86UE+G-T87)T<W=I=&@H)W-T9#HZ97AP97)I;65N
M=&%L)RDZ"B`@("`@("`@("`@(&5N9V%G960@/2!V86Q;)U]-7V5N9V%G960G
M70H@("`@("`@("`@("!C;VYT86EN961?=F%L=64@/2!P87EL;V%D"B`@("`@
M("`@96QS93H*("`@("`@("`@("`@96YG86=E9"`]('!A>6QO861;)U]-7V5N
M9V%G960G70H@("`@("`@("`@("!C;VYT86EN961?=F%L=64@/2!P87EL;V%D
M6R=?35]P87EL;V%D)UT*("`@("`@("`@("`@=')Y.@H@("`@("`@("`@("`@
M("`@(R!3:6YC92!'0T,@.0H@("`@("`@("`@("`@("`@8V]N=&%I;F5D7W9A
M;'5E(#T@8V]N=&%I;F5D7W9A;'5E6R=?35]V86QU92=="B`@("`@("`@("`@
M(&5X8V5P=#H*("`@("`@("`@("`@("`@('!A<W,*("`@("`@("!V:7-U86QI
M>F5R(#T@9V1B+F1E9F%U;'1?=FES=6%L:7IE<B`H8V]N=&%I;F5D7W9A;'5E
M*0H@("`@("`@(&EF(&YO="!E;F=A9V5D.@H@("`@("`@("`@("!C;VYT86EN
M961?=F%L=64@/2!.;VYE"B`@("`@("`@<W5P97(@*%-T9$5X<$]P=&EO;F%L
M4')I;G1E<BP@<V5L9BDN7U]I;FET7U\@*&-O;G1A:6YE9%]V86QU92P@=FES
M=6%L:7IE<BD*"B`@("!D968@=&]?<W1R:6YG("AS96QF*3H*("`@("`@("!I
M9B!S96QF+F-O;G1A:6YE9%]V86QU92!I<R!.;VYE.@H@("`@("`@("`@("!R
M971U<FX@(B5S(%MN;R!C;VYT86EN960@=F%L=65=(B`E('-E;&8N='EP96YA
M;64*("`@("`@("!I9B!H87-A='1R("AS96QF+G9I<W5A;&EZ97(L("=C:&EL
M9')E;B<I.@H@("`@("`@("`@("!R971U<FX@(B5S(&-O;G1A:6YI;F<@)7,B
M("4@*'-E;&8N='EP96YA;64L"B`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@<V5L9BYV:7-U86QI>F5R+G1O7W-T<FEN9R@I*0H@
M("`@("`@(')E='5R;B!S96QF+G1Y<&5N86UE"@IC;&%S<R!3=&1687)I86YT
M4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0<FEN=&5R*3H*("`@(")0<FEN
M="!A('-T9#HZ=F%R:6%N="(*"B`@("!D968@7U]I;FET7U\H<V5L9BP@='EP
M96YA;64L('9A;"DZ"B`@("`@("`@86QT97)N871I=F5S(#T@9V5T7W1E;7!L
M871E7V%R9U]L:7-T*'9A;"YT>7!E*0H@("`@("`@('-E;&8N='EP96YA;64@
M/2!S=')I<%]V97)S:6]N961?;F%M97-P86-E*'1Y<&5N86UE*0H@("`@("`@
M('-E;&8N='EP96YA;64@/2`B)7,\)7,^(B`E("AS96QF+G1Y<&5N86UE+"`G
M+"`G+FIO:6XH6W-E;&8N7W)E8V]G;FEZ92AA;'0I(&9O<B!A;'0@:6X@86QT
M97)N871I=F5S72DI"B`@("`@("`@<V5L9BYI;F1E>"`]('9A;%LG7TU?:6YD
M97@G70H@("`@("`@(&EF('-E;&8N:6YD97@@/CT@;&5N*&%L=&5R;F%T:79E
M<RDZ"B`@("`@("`@("`@('-E;&8N8V]N=&%I;F5D7W1Y<&4@/2!.;VYE"B`@
M("`@("`@("`@(&-O;G1A:6YE9%]V86QU92`]($YO;F4*("`@("`@("`@("`@
M=FES=6%L:7IE<B`]($YO;F4*("`@("`@("!E;'-E.@H@("`@("`@("`@("!S
M96QF+F-O;G1A:6YE9%]T>7!E(#T@86QT97)N871I=F5S6VEN="AS96QF+FEN
M9&5X*5T*("`@("`@("`@("`@861D<B`]('9A;%LG7TU?=2==6R=?35]F:7)S
M="==6R=?35]S=&]R86=E)UTN861D<F5S<PH@("`@("`@("`@("!C;VYT86EN
M961?=F%L=64@/2!A9&1R+F-A<W0H<V5L9BYC;VYT86EN961?='EP92YP;VEN
M=&5R*"DI+F1E<F5F97)E;F-E*"D*("`@("`@("`@("`@=FES=6%L:7IE<B`]
M(&=D8BYD969A=6QT7W9I<W5A;&EZ97(H8V]N=&%I;F5D7W9A;'5E*0H@("`@
M("`@('-U<&5R("A3=&1687)I86YT4')I;G1E<BP@<V5L9BDN7U]I;FET7U\H
M8V]N=&%I;F5D7W9A;'5E+"!V:7-U86QI>F5R+"`G87)R87DG*0H*("`@(&1E
M9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@:68@<V5L9BYC;VYT86EN961?
M=F%L=64@:7,@3F]N93H*("`@("`@("`@("`@<F5T=7)N("(E<R!;;F\@8V]N
M=&%I;F5D('9A;'5E72(@)2!S96QF+G1Y<&5N86UE"B`@("`@("`@:68@:&%S
M871T<BAS96QF+G9I<W5A;&EZ97(L("=C:&EL9')E;B<I.@H@("`@("`@("`@
M("!R971U<FX@(B5S(%MI;F1E>"`E9%T@8V]N=&%I;FEN9R`E<R(@)2`H<V5L
M9BYT>7!E;F%M92P@<V5L9BYI;F1E>"P*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@('-E;&8N=FES=6%L:7IE
M<BYT;U]S=')I;F<H*2D*("`@("`@("!R971U<FX@(B5S(%MI;F1E>"`E9%TB
M("4@*'-E;&8N='EP96YA;64L('-E;&8N:6YD97@I"@IC;&%S<R!3=&1.;V1E
M2&%N9&QE4')I;G1E<BA3:6YG;&5/8FI#;VYT86EN97)0<FEN=&5R*3H*("`@
M(")0<FEN="!A(&-O;G1A:6YE<B!N;V1E(&AA;F1L92(*"B`@("!D968@7U]I
M;FET7U\H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@<V5L9BYV86QU
M95]T>7!E(#T@=F%L+G1Y<&4N=&5M<&QA=&5?87)G=6UE;G0H,2D*("`@("`@
M("!N;V1E='EP92`]('9A;"YT>7!E+G1E;7!L871E7V%R9W5M96YT*#(I+G1E
M;7!L871E7V%R9W5M96YT*#`I"B`@("`@("`@<V5L9BYI<U]R8E]T<F5E7VYO
M9&4@/2!I<U]S<&5C:6%L:7IA=&EO;E]O9BAN;V1E='EP92YN86UE+"`G7U)B
M7W1R965?;F]D92<I"B`@("`@("`@<V5L9BYI<U]M87!?;F]D92`]('9A;"YT
M>7!E+G1E;7!L871E7V%R9W5M96YT*#`I("$]('-E;&8N=F%L=65?='EP90H@
M("`@("`@(&YO9&5P='(@/2!V86Q;)U]-7W!T<B=="B`@("`@("`@:68@;F]D
M97!T<CH*("`@("`@("`@("`@:68@<V5L9BYI<U]R8E]T<F5E7VYO9&4Z"B`@
M("`@("`@("`@("`@("!C;VYT86EN961?=F%L=64@/2!G971?=F%L=65?9G)O
M;5]28E]T<F5E7VYO9&4H;F]D97!T<BYD97)E9F5R96YC92@I*0H@("`@("`@
M("`@("!E;'-E.@H@("`@("`@("`@("`@("`@8V]N=&%I;F5D7W9A;'5E(#T@
M9V5T7W9A;'5E7V9R;VU?86QI9VYE9%]M96UB=68H;F]D97!T<ELG7TU?<W1O
M<F%G92==+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@<V5L9BYV86QU95]T>7!E*0H@
M("`@("`@("`@("!V:7-U86QI>F5R(#T@9V1B+F1E9F%U;'1?=FES=6%L:7IE
M<BAC;VYT86EN961?=F%L=64I"B`@("`@("`@96QS93H*("`@("`@("`@("`@
M8V]N=&%I;F5D7W9A;'5E(#T@3F]N90H@("`@("`@("`@("!V:7-U86QI>F5R
M(#T@3F]N90H@("`@("`@(&]P=&%L;&]C(#T@=F%L6R=?35]A;&QO8R=="B`@
M("`@("`@<V5L9BYA;&QO8R`](&]P=&%L;&]C6R=?35]P87EL;V%D)UT@:68@
M;W!T86QL;V-;)U]-7V5N9V%G960G72!E;'-E($YO;F4*("`@("`@("!S=7!E
M<BA3=&1.;V1E2&%N9&QE4')I;G1E<BP@<V5L9BDN7U]I;FET7U\H8V]N=&%I
M;F5D7W9A;'5E+"!V:7-U86QI>F5R+`H@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`G87)R87DG*0H*("`@(&1E
M9B!T;U]S=')I;F<H<V5L9BDZ"B`@("`@("`@9&5S8R`]("=N;V1E(&AA;F1L
M92!F;W(@)PH@("`@("`@(&EF(&YO="!S96QF+FES7W)B7W1R965?;F]D93H*
M("`@("`@("`@("`@9&5S8R`K/2`G=6YO<F1E<F5D("<*("`@("`@("!I9B!S
M96QF+FES7VUA<%]N;V1E.@H@("`@("`@("`@("!D97-C("L]("=M87`G.PH@
M("`@("`@(&5L<V4Z"B`@("`@("`@("`@(&1E<V,@*ST@)W-E="<["@H@("`@
M("`@(&EF('-E;&8N8V]N=&%I;F5D7W9A;'5E.@H@("`@("`@("`@("!D97-C
M("L]("<@=VET:"!E;&5M96YT)PH@("`@("`@("`@("!I9B!H87-A='1R*'-E
M;&8N=FES=6%L:7IE<BP@)V-H:6QD<F5N)RDZ"B`@("`@("`@("`@("`@("!R
M971U<FX@(B5S(#T@)7,B("4@*&1E<V,L('-E;&8N=FES=6%L:7IE<BYT;U]S
M=')I;F<H*2D*("`@("`@("`@("`@<F5T=7)N(&1E<V,*("`@("`@("!E;'-E
M.@H@("`@("`@("`@("!R971U<FX@)V5M<'1Y("5S)R`E(&1E<V,*"F-L87-S
M(%-T9$5X<%-T<FEN9U9I97=0<FEN=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIB
M87-I8U]S=')I;F=?=FEE=R!O<B!S=&0Z.F5X<&5R:6UE;G1A;#HZ8F%S:6-?
M<W1R:6YG7W9I97<B"@H@("`@9&5F(%]?:6YI=%]?("AS96QF+"!T>7!E;F%M
M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&1E9B!T;U]S
M=')I;F<@*'-E;&8I.@H@("`@("`@('!T<B`]('-E;&8N=F%L6R=?35]S='(G
M70H@("`@("`@(&QE;B`]('-E;&8N=F%L6R=?35]L96XG70H@("`@("`@(&EF
M(&AA<V%T='(@*'!T<BP@(FQA>GE?<W1R:6YG(BDZ"B`@("`@("`@("`@(')E
M='5R;B!P='(N;&%Z>5]S=')I;F<@*&QE;F=T:"`](&QE;BD*("`@("`@("!R
M971U<FX@<'1R+G-T<FEN9R`H;&5N9W1H(#T@;&5N*0H*("`@(&1E9B!D:7-P
M;&%Y7VAI;G0@*'-E;&8I.@H@("`@("`@(')E='5R;B`G<W1R:6YG)PH*8VQA
M<W,@4W1D17AP4&%T:%!R:6YT97(Z"B`@("`B4')I;G0@82!S=&0Z.F5X<&5R
M:6UE;G1A;#HZ9FEL97-Y<W1E;3HZ<&%T:"(*"B`@("!D968@7U]I;FET7U\@
M*'-E;&8L('1Y<&5N86UE+"!V86PI.@H@("`@("`@('-E;&8N=F%L(#T@=F%L
M"B`@("`@("`@<W1A<G0@/2!S96QF+G9A;%LG7TU?8VUP=',G75LG7TU?:6UP
M;"==6R=?35]S=&%R="=="B`@("`@("`@9FEN:7-H(#T@<V5L9BYV86Q;)U]-
M7V-M<'1S)UU;)U]-7VEM<&PG75LG7TU?9FEN:7-H)UT*("`@("`@("!S96QF
M+FYU;5]C;7!T<R`](&EN="`H9FEN:7-H("T@<W1A<G0I"@H@("`@9&5F(%]P
M871H7W1Y<&4H<V5L9BDZ"B`@("`@("`@="`]('-T<BAS96QF+G9A;%LG7TU?
M='EP92==*0H@("`@("`@(&EF('1;+3DZ72`]/2`G7U)O;W1?9&ER)SH*("`@
M("`@("`@("`@<F5T=7)N(")R;V]T+61I<F5C=&]R>2(*("`@("`@("!I9B!T
M6RTQ,#I=(#T]("=?4F]O=%]N86UE)SH*("`@("`@("`@("`@<F5T=7)N(")R
M;V]T+6YA;64B"B`@("`@("`@<F5T=7)N($YO;F4*"B`@("!D968@=&]?<W1R
M:6YG("AS96QF*3H*("`@("`@("!P871H(#T@(B5S(B`E('-E;&8N=F%L(%LG
M7TU?<&%T:&YA;64G70H@("`@("`@(&EF('-E;&8N;G5M7V-M<'1S(#T](#`Z
M"B`@("`@("`@("`@('0@/2!S96QF+E]P871H7W1Y<&4H*0H@("`@("`@("`@
M("!I9B!T.@H@("`@("`@("`@("`@("`@<&%T:"`]("<E<R!;)7-=)R`E("AP
M871H+"!T*0H@("`@("`@(')E='5R;B`B9FEL97-Y<W1E;3HZ<&%T:"`E<R(@
M)2!P871H"@H@("`@8VQA<W,@7VET97)A=&]R*$ET97)A=&]R*3H*("`@("`@
M("!D968@7U]I;FET7U\H<V5L9BP@8VUP=',I.@H@("`@("`@("`@("!S96QF
M+FET96T@/2!C;7!T<ULG7TU?:6UP;"==6R=?35]S=&%R="=="B`@("`@("`@
M("`@('-E;&8N9FEN:7-H(#T@8VUP='-;)U]-7VEM<&PG75LG7TU?9FEN:7-H
M)UT*("`@("`@("`@("`@<V5L9BYC;W5N="`](#`*"B`@("`@("`@9&5F(%]?
M:71E<E]?*'-E;&8I.@H@("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@
M("!D968@7U]N97AT7U\H<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N:71E
M;2`]/2!S96QF+F9I;FES:#H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)
M=&5R871I;VX*("`@("`@("`@("`@:71E;2`]('-E;&8N:71E;2YD97)E9F5R
M96YC92@I"B`@("`@("`@("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@("`@("`@
M("`@("!S96QF+F-O=6YT(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@("`@
M<V5L9BYI=&5M(#T@<V5L9BYI=&5M("L@,0H@("`@("`@("`@("!P871H(#T@
M:71E;5LG7TU?<&%T:&YA;64G70H@("`@("`@("`@("!T(#T@4W1D17AP4&%T
M:%!R:6YT97(H:71E;2YT>7!E+FYA;64L(&ET96TI+E]P871H7W1Y<&4H*0H@
M("`@("`@("`@("!I9B!N;W0@=#H*("`@("`@("`@("`@("`@('0@/2!C;W5N
M=`H@("`@("`@("`@("!R971U<FX@*"=;)7-=)R`E('0L('!A=&@I"@H@("`@
M9&5F(&-H:6QD<F5N*'-E;&8I.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R
M871O<BAS96QF+G9A;%LG7TU?8VUP=',G72D*"F-L87-S(%-T9%!A=&A0<FEN
M=&5R.@H@("`@(E!R:6YT(&$@<W1D.CIF:6QE<WES=&5M.CIP871H(@H*("`@
M(&1E9B!?7VEN:71?7R`H<V5L9BP@='EP96YA;64L('9A;"DZ"B`@("`@("`@
M<V5L9BYV86P@/2!V86P*("`@("`@("!S96QF+G1Y<&5N86UE(#T@='EP96YA
M;64*("`@("`@("!I;7!L(#T@<V5L9BYV86Q;)U]-7V-M<'1S)UU;)U]-7VEM
M<&PG75LG7TU?="==6R=?35]T)UU;)U]-7VAE861?:6UP;"=="B`@("`@("`@
M<V5L9BYT>7!E(#T@:6UP;"YC87-T*&=D8BYL;V]K=7!?='EP92@G=6EN='!T
M<E]T)RDI("8@,PH@("`@("`@(&EF('-E;&8N='EP92`]/2`P.@H@("`@("`@
M("`@("!S96QF+FEM<&P@/2!I;7!L"B`@("`@("`@96QS93H*("`@("`@("`@
M("`@<V5L9BYI;7!L(#T@3F]N90H*("`@(&1E9B!?<&%T:%]T>7!E*'-E;&8I
M.@H@("`@("`@('0@/2!S='(H<V5L9BYT>7!E+F-A<W0H9V1B+FQO;VMU<%]T
M>7!E*'-E;&8N='EP96YA;64@*R`G.CI?5'EP92<I*2D*("`@("`@("!I9B!T
M6RTY.ET@/3T@)U]2;V]T7V1I<B<Z"B`@("`@("`@("`@(')E='5R;B`B<F]O
M="UD:7)E8W1O<GDB"B`@("`@("`@:68@=%LM,3`Z72`]/2`G7U)O;W1?;F%M
M92<Z"B`@("`@("`@("`@(')E='5R;B`B<F]O="UN86UE(@H@("`@("`@(')E
M='5R;B!.;VYE"@H@("`@9&5F('1O7W-T<FEN9R`H<V5L9BDZ"B`@("`@("`@
M<&%T:"`]("(E<R(@)2!S96QF+G9A;"!;)U]-7W!A=&AN86UE)UT*("`@("`@
M("!I9B!S96QF+G1Y<&4@(3T@,#H*("`@("`@("`@("`@="`]('-E;&8N7W!A
M=&A?='EP92@I"B`@("`@("`@("`@(&EF('0Z"B`@("`@("`@("`@("`@("!P
M871H(#T@)R5S(%LE<UTG("4@*'!A=&@L('0I"B`@("`@("`@<F5T=7)N(")F
M:6QE<WES=&5M.CIP871H("5S(B`E('!A=&@*"B`@("!C;&%S<R!?:71E<F%T
M;W(H271E<F%T;W(I.@H@("`@("`@(&1E9B!?7VEN:71?7RAS96QF+"!I;7!L
M+"!P871H='EP92DZ"B`@("`@("`@("`@(&EF(&EM<&PZ"B`@("`@("`@("`@
M("`@("`C(%=E(&-A;B=T(&%C8V5S<R!?26UP;#HZ7TU?<VEZ92!B96-A=7-E
M(%]);7!L(&ES(&EN8V]M<&QE=&4*("`@("`@("`@("`@("`@(",@<V\@8V%S
M="!T;R!I;G0J('1O(&%C8V5S<R!T:&4@7TU?<VEZ92!M96UB97(@870@;V9F
M<V5T('IE<F\L"B`@("`@("`@("`@("`@("!I;G1?='EP92`](&=D8BYL;V]K
M=7!?='EP92@G:6YT)RD*("`@("`@("`@("`@("`@(&-M<'1?='EP92`](&=D
M8BYL;V]K=7!?='EP92AP871H='EP92LG.CI?0VUP="<I"B`@("`@("`@("`@
M("`@("!C:&%R7W1Y<&4@/2!G9&(N;&]O:W5P7W1Y<&4H)V-H87(G*0H@("`@
M("`@("`@("`@("`@:6UP;"`](&EM<&PN8V%S="AI;G1?='EP92YP;VEN=&5R
M*"DI"B`@("`@("`@("`@("`@("!S:7IE(#T@:6UP;"YD97)E9F5R96YC92@I
M"B`@("`@("`@("`@("`@("`C<V5L9BYC87!A8VET>2`]("AI;7!L("L@,2DN
M9&5R969E<F5N8V4H*0H@("`@("`@("`@("`@("`@:68@:&%S871T<BAG9&(N
M5'EP92P@)V%L:6=N;V8G*3H*("`@("`@("`@("`@("`@("`@("!S:7IE;V9?
M26UP;"`](&UA>"@R("H@:6YT7W1Y<&4N<VEZ96]F+"!C;7!T7W1Y<&4N86QI
M9VYO9BD*("`@("`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@("`@("`@("`@
M("`@<VEZ96]F7TEM<&P@/2`R("H@:6YT7W1Y<&4N<VEZ96]F"B`@("`@("`@
M("`@("`@("!B96=I;B`](&EM<&PN8V%S="AC:&%R7W1Y<&4N<&]I;G1E<B@I
M*2`K('-I>F5O9E]);7!L"B`@("`@("`@("`@("`@("!S96QF+FET96T@/2!B
M96=I;BYC87-T*&-M<'1?='EP92YP;VEN=&5R*"DI"B`@("`@("`@("`@("`@
M("!S96QF+F9I;FES:"`]('-E;&8N:71E;2`K('-I>F4*("`@("`@("`@("`@
M("`@('-E;&8N8V]U;G0@/2`P"B`@("`@("`@("`@(&5L<V4Z"B`@("`@("`@
M("`@("`@("!S96QF+FET96T@/2!.;VYE"B`@("`@("`@("`@("`@("!S96QF
M+F9I;FES:"`]($YO;F4*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@
M("`@("`@("`@("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H
M<V5L9BDZ"B`@("`@("`@("`@(&EF('-E;&8N:71E;2`]/2!S96QF+F9I;FES
M:#H*("`@("`@("`@("`@("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@
M("`@("`@:71E;2`]('-E;&8N:71E;2YD97)E9F5R96YC92@I"B`@("`@("`@
M("`@(&-O=6YT(#T@<V5L9BYC;W5N=`H@("`@("`@("`@("!S96QF+F-O=6YT
M(#T@<V5L9BYC;W5N="`K(#$*("`@("`@("`@("`@<V5L9BYI=&5M(#T@<V5L
M9BYI=&5M("L@,0H@("`@("`@("`@("!P871H(#T@:71E;5LG7TU?<&%T:&YA
M;64G70H@("`@("`@("`@("!T(#T@4W1D4&%T:%!R:6YT97(H:71E;2YT>7!E
M+FYA;64L(&ET96TI+E]P871H7W1Y<&4H*0H@("`@("`@("`@("!I9B!N;W0@
M=#H*("`@("`@("`@("`@("`@('0@/2!C;W5N=`H@("`@("`@("`@("!R971U
M<FX@*"=;)7-=)R`E('0L('!A=&@I"@H@("`@9&5F(&-H:6QD<F5N*'-E;&8I
M.@H@("`@("`@(')E='5R;B!S96QF+E]I=&5R871O<BAS96QF+FEM<&PL('-E
M;&8N='EP96YA;64I"@H*8VQA<W,@4W1D4&%I<E!R:6YT97(Z"B`@("`B4')I
M;G0@82!S=&0Z.G!A:7(@;V)J96-T+"!W:71H("=F:7)S="<@86YD("=S96-O
M;F0G(&%S(&-H:6QD<F5N(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!T>7!E
M;F%M92P@=F%L*3H*("`@("`@("!S96QF+G9A;"`]('9A;`H*("`@(&-L87-S
M(%]I=&5R*$ET97)A=&]R*3H*("`@("`@("`B06X@:71E<F%T;W(@9F]R('-T
M9#HZ<&%I<B!T>7!E<RX@4F5T=7)N<R`G9FER<W0G('1H96X@)W-E8V]N9"<N
M(@H*("`@("`@("!D968@7U]I;FET7U\H<V5L9BP@=F%L*3H*("`@("`@("`@
M("`@<V5L9BYV86P@/2!V86P*("`@("`@("`@("`@<V5L9BYW:&EC:"`]("=F
M:7)S="<*"B`@("`@("`@9&5F(%]?:71E<E]?*'-E;&8I.@H@("`@("`@("`@
M("!R971U<FX@<V5L9@H*("`@("`@("!D968@7U]N97AT7U\H<V5L9BDZ"B`@
M("`@("`@("`@(&EF('-E;&8N=VAI8V@@:7,@3F]N93H*("`@("`@("`@("`@
M("`@(')A:7-E(%-T;W!)=&5R871I;VX*("`@("`@("`@("`@=VAI8V@@/2!S
M96QF+G=H:6-H"B`@("`@("`@("`@(&EF('=H:6-H(#T]("=F:7)S="<Z"B`@
M("`@("`@("`@("`@("!S96QF+G=H:6-H(#T@)W-E8V]N9"<*("`@("`@("`@
M("`@96QS93H*("`@("`@("`@("`@("`@('-E;&8N=VAI8V@@/2!.;VYE"B`@
M("`@("`@("`@(')E='5R;B`H=VAI8V@L('-E;&8N=F%L6W=H:6-H72D*"B`@
M("!D968@8VAI;&1R96XH<V5L9BDZ"B`@("`@("`@<F5T=7)N('-E;&8N7VET
M97(H<V5L9BYV86PI"@H@("`@9&5F('1O7W-T<FEN9RAS96QF*3H*("`@("`@
M("!R971U<FX@3F]N90H*"B,@02`B<F5G=6QA<B!E>'!R97-S:6]N(B!P<FEN
M=&5R('=H:6-H(&-O;F9O<FUS('1O('1H90HC(")3=6)0<F5T='E0<FEN=&5R
M(B!P<F]T;V-O;"!F<F]M(&=D8BYP<FEN=&EN9RX*8VQA<W,@4GA0<FEN=&5R
M*&]B:F5C="DZ"B`@("!D968@7U]I;FET7U\H<V5L9BP@;F%M92P@9G5N8W1I
M;VXI.@H@("`@("`@('-U<&5R*%)X4')I;G1E<BP@<V5L9BDN7U]I;FET7U\H
M*0H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@("`@("!S96QF+F9U;F-T
M:6]N(#T@9G5N8W1I;VX*("`@("`@("!S96QF+F5N86)L960@/2!4<G5E"@H@
M("`@9&5F(&EN=F]K92AS96QF+"!V86QU92DZ"B`@("`@("`@:68@;F]T('-E
M;&8N96YA8FQE9#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@("`@("`@
M:68@=F%L=64N='EP92YC;V1E(#T](&=D8BY465!%7T-/1$5?4D5&.@H@("`@
M("`@("`@("!I9B!H87-A='1R*&=D8BY686QU92PB<F5F97)E;F-E9%]V86QU
M92(I.@H@("`@("`@("`@("`@("`@=F%L=64@/2!V86QU92YR969E<F5N8V5D
M7W9A;'5E*"D*"B`@("`@("`@<F5T=7)N('-E;&8N9G5N8W1I;VXH<V5L9BYN
M86UE+"!V86QU92D*"B,@02!P<F5T='DM<')I;G1E<B!T:&%T(&-O;F9O<FUS
M('1O('1H92`B4')E='1Y4')I;G1E<B(@<')O=&]C;VP@9G)O;0HC(&=D8BYP
M<FEN=&EN9RX@($ET(&-A;B!A;'-O(&)E('5S960@9&ER96-T;'D@87,@86X@
M;VQD+7-T>6QE('!R:6YT97(N"F-L87-S(%!R:6YT97(H;V)J96-T*3H*("`@
M(&1E9B!?7VEN:71?7RAS96QF+"!N86UE*3H*("`@("`@("!S=7!E<BA0<FEN
M=&5R+"!S96QF*2Y?7VEN:71?7R@I"B`@("`@("`@<V5L9BYN86UE(#T@;F%M
M90H@("`@("`@('-E;&8N<W5B<')I;G1E<G,@/2!;70H@("`@("`@('-E;&8N
M;&]O:W5P(#T@>WT*("`@("`@("!S96QF+F5N86)L960@/2!4<G5E"B`@("`@
M("`@<V5L9BYC;VUP:6QE9%]R>"`](')E+F-O;7!I;&4H)UXH6V$M>D$M6C`M
M.5\Z72LI*#PN*CXI/R0G*0H*("`@(&1E9B!A9&0H<V5L9BP@;F%M92P@9G5N
M8W1I;VXI.@H@("`@("`@(",@02!S;6%L;"!S86YI='D@8VAE8VLN"B`@("`@
M("`@(R!&25A-10H@("`@("`@(&EF(&YO="!S96QF+F-O;7!I;&5D7W)X+FUA
M=&-H*&YA;64I.@H@("`@("`@("`@("!R86ES92!686QU945R<F]R*"=L:6)S
M=&1C*RL@<')O9W)A;6UI;F<@97)R;W(Z("(E<R(@9&]E<R!N;W0@;6%T8V@G
M("4@;F%M92D*("`@("`@("!P<FEN=&5R(#T@4GA0<FEN=&5R*&YA;64L(&9U
M;F-T:6]N*0H@("`@("`@('-E;&8N<W5B<')I;G1E<G,N87!P96YD*'!R:6YT
M97(I"B`@("`@("`@<V5L9BYL;V]K=7!;;F%M95T@/2!P<FEN=&5R"@H@("`@
M(R!!9&0@82!N86UE('5S:6YG(%]'3$E"0UA87T)%1TE.7TY!34534$%#15]6
M15)324].+@H@("`@9&5F(&%D9%]V97)S:6]N*'-E;&8L(&)A<V4L(&YA;64L
M(&9U;F-T:6]N*3H*("`@("`@("!S96QF+F%D9"AB87-E("L@;F%M92P@9G5N
M8W1I;VXI"B`@("`@("`@:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@
M("`@("`@('9B87-E(#T@<F4N<W5B*"=>*'-T9'Q?7V=N=5]C>'@I.CHG+"!R
M)UQG/#`^)7,G("4@7W9E<G-I;VYE9%]N86UE<W!A8V4L(&)A<V4I"B`@("`@
M("`@("`@('-E;&8N861D*'9B87-E("L@;F%M92P@9G5N8W1I;VXI"@H@("`@
M(R!!9&0@82!N86UE('5S:6YG(%]'3$E"0UA87T)%1TE.7TY!34534$%#15]#
M3TY404E.15(N"B`@("!D968@861D7V-O;G1A:6YE<BAS96QF+"!B87-E+"!N
M86UE+"!F=6YC=&EO;BDZ"B`@("`@("`@<V5L9BYA9&1?=F5R<VEO;BAB87-E
M+"!N86UE+"!F=6YC=&EO;BD*("`@("`@("!S96QF+F%D9%]V97)S:6]N*&)A
M<V4@*R`G7U]C>'@Q.3DX.CHG+"!N86UE+"!F=6YC=&EO;BD*"B`@("!`<W1A
M=&EC;65T:&]D"B`@("!D968@9V5T7V)A<VEC7W1Y<&4H='EP92DZ"B`@("`@
M("`@(R!)9B!I="!P;VEN=',@=&\@82!R969E<F5N8V4L(&=E="!T:&4@<F5F
M97)E;F-E+@H@("`@("`@(&EF('1Y<&4N8V]D92`]/2!G9&(N5%E015]#3T1%
M7U)%1CH*("`@("`@("`@("`@='EP92`]('1Y<&4N=&%R9V5T("@I"@H@("`@
M("`@(",@1V5T('1H92!U;G%U86QI9FEE9"!T>7!E+"!S=')I<'!E9"!O9B!T
M>7!E9&5F<RX*("`@("`@("!T>7!E(#T@='EP92YU;G%U86QI9FEE9"`H*2YS
M=')I<%]T>7!E9&5F<R`H*0H*("`@("`@("!R971U<FX@='EP92YT86<*"B`@
M("!D968@7U]C86QL7U\H<V5L9BP@=F%L*3H*("`@("`@("!T>7!E;F%M92`]
M('-E;&8N9V5T7V)A<VEC7W1Y<&4H=F%L+G1Y<&4I"B`@("`@("`@:68@;F]T
M('1Y<&5N86UE.@H@("`@("`@("`@("!R971U<FX@3F]N90H*("`@("`@("`C
M($%L;"!T:&4@='EP97,@=V4@;6%T8V@@87)E('1E;7!L871E('1Y<&5S+"!S
M;R!W92!C86X@=7-E(&$*("`@("`@("`C(&1I8W1I;VYA<GDN"B`@("`@("`@
M;6%T8V@@/2!S96QF+F-O;7!I;&5D7W)X+FUA=&-H*'1Y<&5N86UE*0H@("`@
M("`@(&EF(&YO="!M871C:#H*("`@("`@("`@("`@<F5T=7)N($YO;F4*"B`@
M("`@("`@8F%S96YA;64@/2!M871C:"YG<F]U<"@Q*0H*("`@("`@("!I9B!V
M86PN='EP92YC;V1E(#T](&=D8BY465!%7T-/1$5?4D5&.@H@("`@("`@("`@
M("!I9B!H87-A='1R*&=D8BY686QU92PB<F5F97)E;F-E9%]V86QU92(I.@H@
M("`@("`@("`@("`@("`@=F%L(#T@=F%L+G)E9F5R96YC961?=F%L=64H*0H*
M("`@("`@("!I9B!B87-E;F%M92!I;B!S96QF+FQO;VMU<#H*("`@("`@("`@
M("`@<F5T=7)N('-E;&8N;&]O:W5P6V)A<V5N86UE72YI;G9O:V4H=F%L*0H*
M("`@("`@("`C($-A;FYO="!F:6YD(&$@<')E='1Y('!R:6YT97(N("!2971U
M<FX@3F]N92X*("`@("`@("!R971U<FX@3F]N90H*;&EB<W1D8WAX7W!R:6YT
M97(@/2!.;VYE"@IC;&%S<R!496UP;&%T951Y<&50<FEN=&5R*&]B:F5C="DZ
M"B`@("!R(B(B"B`@("!!('1Y<&4@<')I;G1E<B!F;W(@8VQA<W,@=&5M<&QA
M=&5S('=I=&@@9&5F875L="!T96UP;&%T92!A<F=U;65N=',N"@H@("`@4F5C
M;V=N:7IE<R!S<&5C:6%L:7IA=&EO;G,@;V8@8VQA<W,@=&5M<&QA=&5S(&%N
M9"!P<FEN=',@=&AE;2!W:71H;W5T"B`@("!A;GD@=&5M<&QA=&4@87)G=6UE
M;G1S('1H870@=7-E(&$@9&5F875L="!T96UP;&%T92!A<F=U;65N="X*("`@
M(%1Y<&4@<')I;G1E<G,@87)E(')E8W5R<VEV96QY(&%P<&QI960@=&\@=&AE
M('1E;7!L871E(&%R9W5M96YT<RX*"B`@("!E+F<N(')E<&QA8V4@(G-T9#HZ
M=F5C=&]R/%0L('-T9#HZ86QL;V-A=&]R/%0^(#XB('=I=&@@(G-T9#HZ=F5C
M=&]R/%0^(BX*("`@("(B(@H*("`@(&1E9B!?7VEN:71?7RAS96QF+"!N86UE
M+"!D969A<F=S*3H*("`@("`@("!S96QF+FYA;64@/2!N86UE"B`@("`@("`@
M<V5L9BYD969A<F=S(#T@9&5F87)G<PH@("`@("`@('-E;&8N96YA8FQE9"`]
M(%1R=64*"B`@("!C;&%S<R!?<F5C;V=N:7IE<BAO8FIE8W0I.@H@("`@("`@
M(")4:&4@<F5C;V=N:7IE<B!C;&%S<R!F;W(@5&5M<&QA=&54>7!E4')I;G1E
M<BXB"@H@("`@("`@(&1E9B!?7VEN:71?7RAS96QF+"!N86UE+"!D969A<F=S
M*3H*("`@("`@("`@("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@("`@("!S
M96QF+F1E9F%R9W,@/2!D969A<F=S"B`@("`@("`@("`@(",@<V5L9BYT>7!E
M7V]B:B`]($YO;F4*"B`@("`@("`@9&5F(')E8V]G;FEZ92AS96QF+"!T>7!E
M7V]B:BDZ"B`@("`@("`@("`@("(B(@H@("`@("`@("`@("!)9B!T>7!E7V]B
M:B!I<R!A('-P96-I86QI>F%T:6]N(&]F('-E;&8N;F%M92!T:&%T('5S97,@
M86QL('1H90H@("`@("`@("`@("!D969A=6QT('1E;7!L871E(&%R9W5M96YT
M<R!F;W(@=&AE(&-L87-S('1E;7!L871E+"!T:&5N(')E='5R;@H@("`@("`@
M("`@("!A('-T<FEN9R!R97!R97-E;G1A=&EO;B!O9B!T:&4@='EP92!W:71H
M;W5T(&1E9F%U;'0@87)G=6UE;G1S+@H@("`@("`@("`@("!/=&AE<G=I<V4L
M(')E='5R;B!.;VYE+@H@("`@("`@("`@("`B(B(*"B`@("`@("`@("`@(&EF
M('1Y<&5?;V)J+G1A9R!I<R!.;VYE.@H@("`@("`@("`@("`@("`@<F5T=7)N
M($YO;F4*"B`@("`@("`@("`@(&EF(&YO="!T>7!E7V]B:BYT86<N<W1A<G1S
M=VET:"AS96QF+FYA;64I.@H@("`@("`@("`@("`@("`@<F5T=7)N($YO;F4*
M"B`@("`@("`@("`@('1E;7!L871E7V%R9W,@/2!G971?=&5M<&QA=&5?87)G
M7VQI<W0H='EP95]O8FHI"B`@("`@("`@("`@(&1I<W!L87EE9%]A<F=S(#T@
M6UT*("`@("`@("`@("`@<F5Q=6ER95]D969A=6QT960@/2!&86QS90H@("`@
M("`@("`@("!F;W(@;B!I;B!R86YG92AL96XH=&5M<&QA=&5?87)G<RDI.@H@
M("`@("`@("`@("`@("`@(R!4:&4@86-T=6%L('1E;7!L871E(&%R9W5M96YT
M(&EN('1H92!T>7!E.@H@("`@("`@("`@("`@("`@=&%R9R`]('1E;7!L871E
M7V%R9W-;;ET*("`@("`@("`@("`@("`@(",@5&AE(&1E9F%U;'0@=&5M<&QA
M=&4@87)G=6UE;G0@9F]R('1H92!C;&%S<R!T96UP;&%T93H*("`@("`@("`@
M("`@("`@(&1E9F%R9R`]('-E;&8N9&5F87)G<RYG970H;BD*("`@("`@("`@
M("`@("`@(&EF(&1E9F%R9R!I<R!N;W0@3F]N93H*("`@("`@("`@("`@("`@
M("`@("`C(%-U8G-T:71U=&4@;W1H97(@=&5M<&QA=&4@87)G=6UE;G1S(&EN
M=&\@=&AE(&1E9F%U;'0Z"B`@("`@("`@("`@("`@("`@("`@9&5F87)G(#T@
M9&5F87)G+F9O<FUA="@J=&5M<&QA=&5?87)G<RD*("`@("`@("`@("`@("`@
M("`@("`C($9A:6P@=&\@<F5C;V=N:7IE('1H92!T>7!E("AB>2!R971U<FYI
M;F<@3F]N92D*("`@("`@("`@("`@("`@("`@("`C('5N;&5S<R!T:&4@86-T
M=6%L(&%R9W5M96YT(&ES('1H92!S86UE(&%S('1H92!D969A=6QT+@H@("`@
M("`@("`@("`@("`@("`@('1R>3H*("`@("`@("`@("`@("`@("`@("`@("`@
M:68@=&%R9R`A/2!G9&(N;&]O:W5P7W1Y<&4H9&5F87)G*3H*("`@("`@("`@
M("`@("`@("`@("`@("`@("`@(')E='5R;B!.;VYE"B`@("`@("`@("`@("`@
M("`@("`@97AC97!T(&=D8BYE<G)O<CH*("`@("`@("`@("`@("`@("`@("`@
M("`@(R!4>7!E(&QO;VMU<"!F86EL960L(&IU<W0@=7-E('-T<FEN9R!C;VUP
M87)I<V]N.@H@("`@("`@("`@("`@("`@("`@("`@("!I9B!T87)G+G1A9R`A
M/2!D969A<F<Z"B`@("`@("`@("`@("`@("`@("`@("`@("`@("!R971U<FX@
M3F]N90H@("`@("`@("`@("`@("`@("`@(",@06QL('-U8G-E<75E;G0@87)G
M<R!M=7-T(&AA=F4@9&5F875L=',Z"B`@("`@("`@("`@("`@("`@("`@<F5Q
M=6ER95]D969A=6QT960@/2!4<G5E"B`@("`@("`@("`@("`@("!E;&EF(')E
M<75I<F5?9&5F875L=&5D.@H@("`@("`@("`@("`@("`@("`@(')E='5R;B!.
M;VYE"B`@("`@("`@("`@("`@("!E;'-E.@H@("`@("`@("`@("`@("`@("`@
M(",@4F5C=7)S:79E;'D@87!P;'D@<F5C;V=N:7IE<G,@=&\@=&AE('1E;7!L
M871E(&%R9W5M96YT"B`@("`@("`@("`@("`@("`@("`@(R!A;F0@861D(&ET
M('1O('1H92!A<F=U;65N=',@=&AA="!W:6QL(&)E(&1I<W!L87EE9#H*("`@
M("`@("`@("`@("`@("`@("!D:7-P;&%Y961?87)G<RYA<'!E;F0H<V5L9BY?
M<F5C;V=N:7IE7W-U8G1Y<&4H=&%R9RDI"@H@("`@("`@("`@("`C(%1H:7,@
M87-S=6UE<R!N;R!C;&%S<R!T96UP;&%T97,@:6X@=&AE(&YE<W1E9"UN86UE
M+7-P96-I9FEE<CH*("`@("`@("`@("`@=&5M<&QA=&5?;F%M92`]('1Y<&5?
M;V)J+G1A9ULP.G1Y<&5?;V)J+G1A9RYF:6YD*"<\)RE="B`@("`@("`@("`@
M('1E;7!L871E7VYA;64@/2!S=')I<%]I;FQI;F5?;F%M97-P86-E<RAT96UP
M;&%T95]N86UE*0H*("`@("`@("`@("`@<F5T=7)N('1E;7!L871E7VYA;64@
M*R`G/"<@*R`G+"`G+FIO:6XH9&ES<&QA>65D7V%R9W,I("L@)SXG"@H@("`@
M("`@(&1E9B!?<F5C;V=N:7IE7W-U8G1Y<&4H<V5L9BP@='EP95]O8FHI.@H@
M("`@("`@("`@("`B(B)#;VYV97)T(&$@9V1B+E1Y<&4@=&\@82!S=')I;F<@
M8GD@87!P;'EI;F<@<F5C;V=N:7IE<G,L"B`@("`@("`@("`@(&]R(&EF('1H
M870@9F%I;',@=&AE;B!S:6UP;'D@8V]N=F5R=&EN9R!T;R!A('-T<FEN9RXB
M(B(*"B`@("`@("`@("`@(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?
M0T]$15]05%(Z"B`@("`@("`@("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N
M:7IE7W-U8G1Y<&4H='EP95]O8FHN=&%R9V5T*"DI("L@)RHG"B`@("`@("`@
M("`@(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?0T]$15]!4E)!63H*
M("`@("`@("`@("`@("`@('1Y<&5?<W1R(#T@<V5L9BY?<F5C;V=N:7IE7W-U
M8G1Y<&4H='EP95]O8FHN=&%R9V5T*"DI"B`@("`@("`@("`@("`@("!I9B!S
M='(H='EP95]O8FHN<W1R:7!?='EP961E9G,H*2DN96YD<W=I=&@H)UM=)RDZ
M"B`@("`@("`@("`@("`@("`@("`@<F5T=7)N('1Y<&5?<W1R("L@)UM=)R`C
M(&%R<F%Y(&]F('5N:VYO=VX@8F]U;F0*("`@("`@("`@("`@("`@(')E='5R
M;B`B)7-;)61=(B`E("AT>7!E7W-T<BP@='EP95]O8FHN<F%N9V4H*5LQ72`K
M(#$I"B`@("`@("`@("`@(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?
M0T]$15]2148Z"B`@("`@("`@("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N
M:7IE7W-U8G1Y<&4H='EP95]O8FHN=&%R9V5T*"DI("L@)R8G"B`@("`@("`@
M("`@(&EF(&AA<V%T='(H9V1B+"`G5%E015]#3T1%7U)604Q515]2148G*3H*
M("`@("`@("`@("`@("`@(&EF('1Y<&5?;V)J+F-O9&4@/3T@9V1B+E194$5?
M0T]$15]25D%,545?4D5&.@H@("`@("`@("`@("`@("`@("`@(')E='5R;B!S
M96QF+E]R96-O9VYI>F5?<W5B='EP92AT>7!E7V]B:BYT87)G970H*2D@*R`G
M)B8G"@H@("`@("`@("`@("!T>7!E7W-T<B`](&=D8BYT>7!E<RYA<'!L>5]T
M>7!E7W)E8V]G;FEZ97)S*`H@("`@("`@("`@("`@("`@("`@(&=D8BYT>7!E
M<RYG971?='EP95]R96-O9VYI>F5R<R@I+"!T>7!E7V]B:BD*("`@("`@("`@
M("`@:68@='EP95]S='(Z"B`@("`@("`@("`@("`@("!R971U<FX@='EP95]S
M='(*("`@("`@("`@("`@<F5T=7)N('-T<BAT>7!E7V]B:BD*"B`@("!D968@
M:6YS=&%N=&EA=&4H<V5L9BDZ"B`@("`@("`@(E)E='5R;B!A(')E8V]G;FEZ
M97(@;V)J96-T(&9O<B!T:&ES('1Y<&4@<')I;G1E<BXB"B`@("`@("`@<F5T
M=7)N('-E;&8N7W)E8V]G;FEZ97(H<V5L9BYN86UE+"!S96QF+F1E9F%R9W,I
M"@ID968@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"!N86UE
M+"!D969A<F=S*3H*("`@('(B(B(*("`@($%D9"!A('1Y<&4@<')I;G1E<B!F
M;W(@82!C;&%S<R!T96UP;&%T92!W:71H(&1E9F%U;'0@=&5M<&QA=&4@87)G
M=6UE;G1S+@H*("`@($%R9W,Z"B`@("`@("`@;F%M92`H<W1R*3H@5&AE('1E
M;7!L871E+6YA;64@;V8@=&AE(&-L87-S('1E;7!L871E+@H@("`@("`@(&1E
M9F%R9W,@*&1I8W0@:6YT.G-T<FEN9RD@5&AE(&1E9F%U;'0@=&5M<&QA=&4@
M87)G=6UE;G1S+@H*("`@(%1Y<&5S(&EN(&1E9F%R9W,@8V%N(')E9F5R('1O
M('1H92!.=&@@=&5M<&QA=&4M87)G=6UE;G0@=7-I;F<@>TY]"B`@("`H=VET
M:"!Z97)O+6)A<V5D(&EN9&EC97,I+@H*("`@(&4N9RX@)W5N;W)D97)E9%]M
M87`G(&AA<R!T:&5S92!D969A<F=S.@H@("`@>R`R.B`G<W1D.CIH87-H/'LP
M?3XG+`H@("`@("`S.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*("`@("`@-#H@
M)W-T9#HZ86QL;V-A=&]R/'-T9#HZ<&%I<CQC;VYS="![,'TL('LQ?3X@/B<@
M?0H*("`@("(B(@H@("`@<')I;G1E<B`](%1E;7!L871E5'EP95!R:6YT97(H
M)W-T9#HZ)RMN86UE+"!D969A<F=S*0H@("`@9V1B+G1Y<&5S+G)E9VES=&5R
M7W1Y<&5?<')I;G1E<BAO8FHL('!R:6YT97(I"@H@("`@(R!!9&0@='EP92!P
M<FEN=&5R(&9O<B!S86UE('1Y<&4@:6X@9&5B=6<@;F%M97-P86-E.@H@("`@
M<')I;G1E<B`](%1E;7!L871E5'EP95!R:6YT97(H)W-T9#HZ7U]D96)U9SHZ
M)RMN86UE+"!D969A<F=S*0H@("`@9V1B+G1Y<&5S+G)E9VES=&5R7W1Y<&5?
M<')I;G1E<BAO8FHL('!R:6YT97(I"@H@("`@:68@7W9E<G-I;VYE9%]N86UE
M<W!A8V4Z"B`@("`@("`@(R!!9&0@<V5C;VYD('1Y<&4@<')I;G1E<B!F;W(@
M<V%M92!T>7!E(&EN('9E<G-I;VYE9"!N86UE<W!A8V4Z"B`@("`@("`@;G,@
M/2`G<W1D.CHG("L@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@("`@("`C(%!2
M(#@V,3$R($-A;FYO="!U<V4@9&EC="!C;VUP<F5H96YS:6]N(&AE<F4Z"B`@
M("`@("`@9&5F87)G<R`](&1I8W0H*&XL(&0N<F5P;&%C92@G<W1D.CHG+"!N
M<RDI(&9O<B`H;BQD*2!I;B!D969A<F=S+FET96US*"DI"B`@("`@("`@<')I
M;G1E<B`](%1E;7!L871E5'EP95!R:6YT97(H;G,K;F%M92P@9&5F87)G<RD*
M("`@("`@("!G9&(N='EP97,N<F5G:7-T97)?='EP95]P<FEN=&5R*&]B:BP@
M<')I;G1E<BD*"F-L87-S($9I;'1E<FEN9U1Y<&50<FEN=&5R*&]B:F5C="DZ
M"B`@("!R(B(B"B`@("!!('1Y<&4@<')I;G1E<B!T:&%T('5S97,@='EP961E
M9B!N86UE<R!F;W(@8V]M;6]N('1E;7!L871E('-P96-I86QI>F%T:6]N<RX*
M"B`@("!!<F=S.@H@("`@("`@(&UA=&-H("AS='(I.B!4:&4@8VQA<W,@=&5M
M<&QA=&4@=&\@<F5C;V=N:7IE+@H@("`@("`@(&YA;64@*'-T<BDZ(%1H92!T
M>7!E9&5F+6YA;64@=&AA="!W:6QL(&)E('5S960@:6YS=&5A9"X*"B`@("!#
M:&5C:W,@:68@82!S<&5C:6%L:7IA=&EO;B!O9B!T:&4@8VQA<W,@=&5M<&QA
M=&4@)VUA=&-H)R!I<R!T:&4@<V%M92!T>7!E"B`@("!A<R!T:&4@='EP961E
M9B`G;F%M92<L(&%N9"!P<FEN=',@:70@87,@)VYA;64G(&EN<W1E860N"@H@
M("`@92YG+B!I9B!A;B!I;G-T86YT:6%T:6]N(&]F('-T9#HZ8F%S:6-?:7-T
M<F5A;3Q#+"!4/B!I<R!T:&4@<V%M92!T>7!E(&%S"B`@("!S=&0Z.FES=')E
M86T@=&AE;B!P<FEN="!I="!A<R!S=&0Z.FES=')E86TN"B`@("`B(B(*"B`@
M("!D968@7U]I;FET7U\H<V5L9BP@;6%T8V@L(&YA;64I.@H@("`@("`@('-E
M;&8N;6%T8V@@/2!M871C:`H@("`@("`@('-E;&8N;F%M92`](&YA;64*("`@
M("`@("!S96QF+F5N86)L960@/2!4<G5E"@H@("`@8VQA<W,@7W)E8V]G;FEZ
M97(H;V)J96-T*3H*("`@("`@("`B5&AE(')E8V]G;FEZ97(@8VQA<W,@9F]R
M(%1E;7!L871E5'EP95!R:6YT97(N(@H*("`@("`@("!D968@7U]I;FET7U\H
M<V5L9BP@;6%T8V@L(&YA;64I.@H@("`@("`@("`@("!S96QF+FUA=&-H(#T@
M;6%T8V@*("`@("`@("`@("`@<V5L9BYN86UE(#T@;F%M90H@("`@("`@("`@
M("!S96QF+G1Y<&5?;V)J(#T@3F]N90H*("`@("`@("!D968@<F5C;V=N:7IE
M*'-E;&8L('1Y<&5?;V)J*3H*("`@("`@("`@("`@(B(B"B`@("`@("`@("`@
M($EF('1Y<&5?;V)J('-T87)T<R!W:71H('-E;&8N;6%T8V@@86YD(&ES('1H
M92!S86UE('1Y<&4@87,*("`@("`@("`@("`@<V5L9BYN86UE('1H96X@<F5T
M=7)N('-E;&8N;F%M92P@;W1H97)W:7-E($YO;F4N"B`@("`@("`@("`@("(B
M(@H@("`@("`@("`@("!I9B!T>7!E7V]B:BYT86<@:7,@3F]N93H*("`@("`@
M("`@("`@("`@(')E='5R;B!.;VYE"@H@("`@("`@("`@("!I9B!S96QF+G1Y
M<&5?;V)J(&ES($YO;F4Z"B`@("`@("`@("`@("`@("!I9B!N;W0@='EP95]O
M8FHN=&%G+G-T87)T<W=I=&@H<V5L9BYM871C:"DZ"B`@("`@("`@("`@("`@
M("`@("`@(R!&:6QT97(@9&ED;B=T(&UA=&-H+@H@("`@("`@("`@("`@("`@
M("`@(')E='5R;B!.;VYE"B`@("`@("`@("`@("`@("!T<GDZ"B`@("`@("`@
M("`@("`@("`@("`@<V5L9BYT>7!E7V]B:B`](&=D8BYL;V]K=7!?='EP92AS
M96QF+FYA;64I+G-T<FEP7W1Y<&5D969S*"D*("`@("`@("`@("`@("`@(&5X
M8V5P=#H*("`@("`@("`@("`@("`@("`@("!P87-S"B`@("`@("`@("`@(&EF
M('-E;&8N='EP95]O8FH@/3T@='EP95]O8FHZ"B`@("`@("`@("`@("`@("!R
M971U<FX@<W1R:7!?:6YL:6YE7VYA;65S<&%C97,H<V5L9BYN86UE*0H@("`@
M("`@("`@("!R971U<FX@3F]N90H*("`@(&1E9B!I;G-T86YT:6%T92AS96QF
M*3H*("`@("`@("`B4F5T=7)N(&$@<F5C;V=N:7IE<B!O8FIE8W0@9F]R('1H
M:7,@='EP92!P<FEN=&5R+B(*("`@("`@("!R971U<FX@<V5L9BY?<F5C;V=N
M:7IE<BAS96QF+FUA=&-H+"!S96QF+FYA;64I"@ID968@861D7V]N95]T>7!E
M7W!R:6YT97(H;V)J+"!M871C:"P@;F%M92DZ"B`@("!P<FEN=&5R(#T@1FEL
M=&5R:6YG5'EP95!R:6YT97(H)W-T9#HZ)R`K(&UA=&-H+"`G<W1D.CHG("L@
M;F%M92D*("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R:6YT97(H;V)J
M+"!P<FEN=&5R*0H@("`@:68@7W9E<G-I;VYE9%]N86UE<W!A8V4Z"B`@("`@
M("`@;G,@/2`G<W1D.CHG("L@7W9E<G-I;VYE9%]N86UE<W!A8V4*("`@("`@
M("!P<FEN=&5R(#T@1FEL=&5R:6YG5'EP95!R:6YT97(H;G,@*R!M871C:"P@
M;G,@*R!N86UE*0H@("`@("`@(&=D8BYT>7!E<RYR96=I<W1E<E]T>7!E7W!R
M:6YT97(H;V)J+"!P<FEN=&5R*0H*9&5F(')E9VES=&5R7W1Y<&5?<')I;G1E
M<G,H;V)J*3H*("`@(&=L;V)A;"!?=7-E7W1Y<&5?<')I;G1I;F<*"B`@("!I
M9B!N;W0@7W5S95]T>7!E7W!R:6YT:6YG.@H@("`@("`@(')E='5R;@H*("`@
M(",@061D('1Y<&4@<')I;G1E<G,@9F]R('1Y<&5D969S('-T9#HZ<W1R:6YG
M+"!S=&0Z.G=S=')I;F<@971C+@H@("`@9F]R(&-H(&EN("@G)RP@)W<G+"`G
M=3@G+"`G=3$V)RP@)W4S,B<I.@H@("`@("`@(&%D9%]O;F5?='EP95]P<FEN
M=&5R*&]B:BP@)V)A<VEC7W-T<FEN9R<L(&-H("L@)W-T<FEN9R<I"B`@("`@
M("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G7U]C>'@Q,3HZ8F%S:6-?
M<W1R:6YG)RP@8V@@*R`G<W1R:6YG)RD*("`@("`@("`C(%1Y<&5D969S(&9O
M<B!?7V-X>#$Q.CIB87-I8U]S=')I;F<@=7-E9"!T;R!B92!I;B!N86UE<W!A
M8V4@7U]C>'@Q,3H*("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL
M("=?7V-X>#$Q.CIB87-I8U]S=')I;F<G+`H@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("=?7V-X>#$Q.CHG("L@8V@@*R`G<W1R:6YG)RD*("`@("`@
M("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=B87-I8U]S=')I;F=?=FEE
M=R<L(&-H("L@)W-T<FEN9U]V:65W)RD*"B`@("`C($%D9"!T>7!E('!R:6YT
M97)S(&9O<B!T>7!E9&5F<R!S=&0Z.FES=')E86TL('-T9#HZ=VES=')E86T@
M971C+@H@("`@9F]R(&-H(&EN("@G)RP@)W<G*3H*("`@("`@("!F;W(@>"!I
M;B`H)VEO<R<L("=S=')E86UB=68G+"`G:7-T<F5A;2<L("=O<W1R96%M)RP@
M)VEO<W1R96%M)RP*("`@("`@("`@("`@("`@("`@)V9I;&5B=68G+"`G:69S
M=')E86TG+"`G;V9S=')E86TG+"`G9G-T<F5A;2<I.@H@("`@("`@("`@("!A
M9&1?;VYE7W1Y<&5?<')I;G1E<BAO8FHL("=B87-I8U\G("L@>"P@8V@@*R!X
M*0H@("`@("`@(&9O<B!X(&EN("@G<W1R:6YG8G5F)RP@)VES=')I;F=S=')E
M86TG+"`G;W-T<FEN9W-T<F5A;2<L"B`@("`@("`@("`@("`@("`@("=S=')I
M;F=S=')E86TG*3H*("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H
M;V)J+"`G8F%S:6-?)R`K('@L(&-H("L@>"D*("`@("`@("`@("`@(R`\<W-T
M<F5A;3X@='EP97,@87)E(&EN(%]?8WAX,3$@;F%M97-P86-E+"!B=70@='EP
M961E9G,@87)E;B=T.@H@("`@("`@("`@("!A9&1?;VYE7W1Y<&5?<')I;G1E
M<BAO8FHL("=?7V-X>#$Q.CIB87-I8U\G("L@>"P@8V@@*R!X*0H*("`@(",@
M061D('1Y<&4@<')I;G1E<G,@9F]R('1Y<&5D969S(')E9V5X+"!W<F5G97@L
M(&-M871C:"P@=V-M871C:"!E=&,N"B`@("!F;W(@86)I(&EN("@G)RP@)U]?
M8WAX,3$Z.B<I.@H@("`@("`@(&9O<B!C:"!I;B`H)R<L("=W)RDZ"B`@("`@
M("`@("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@86)I("L@)V)A<VEC
M7W)E9V5X)RP@86)I("L@8V@@*R`G<F5G97@G*0H@("`@("`@(&9O<B!C:"!I
M;B`H)V,G+"`G<R<L("=W8R<L("=W<R<I.@H@("`@("`@("`@("!A9&1?;VYE
M7W1Y<&5?<')I;G1E<BAO8FHL(&%B:2`K("=M871C:%]R97-U;'1S)RP@86)I
M("L@8V@@*R`G;6%T8V@G*0H@("`@("`@("`@("!F;W(@>"!I;B`H)W-U8E]M
M871C:"<L("=R96=E>%]I=&5R871O<B<L("=R96=E>%]T;VME;E]I=&5R871O
M<B<I.@H@("`@("`@("`@("`@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J
M+"!A8FD@*R!X+"!A8FD@*R!C:"`K('@I"@H@("`@(R!.;W1E('1H870@=V4@
M8V%N)W0@:&%V92!A('!R:6YT97(@9F]R('-T9#HZ=W-T<F5A;7!O<RP@8F5C
M875S90H@("`@(R!I="!I<R!T:&4@<V%M92!T>7!E(&%S('-T9#HZ<W1R96%M
M<&]S+@H@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G9G!O<R<L("=S
M=')E86UP;W,G*0H*("`@(",@061D('1Y<&4@<')I;G1E<G,@9F]R(#QC:')O
M;F\^('1Y<&5D969S+@H@("`@9F]R(&1U<B!I;B`H)VYA;F]S96-O;F1S)RP@
M)VUI8W)O<V5C;VYD<R<L("=M:6QL:7-E8V]N9',G+`H@("`@("`@("`@("`@
M("`@)W-E8V]N9',G+"`G;6EN=71E<R<L("=H;W5R<R<I.@H@("`@("`@(&%D
M9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)V1U<F%T:6]N)RP@9'5R*0H*("`@
M(",@061D('1Y<&4@<')I;G1E<G,@9F]R(#QR86YD;VT^('1Y<&5D969S+@H@
M("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G;&EN96%R7V-O;F=R=65N
M=&EA;%]E;F=I;F4G+"`G;6EN<W1D7W)A;F0P)RD*("`@(&%D9%]O;F5?='EP
M95]P<FEN=&5R*&]B:BP@)VQI;F5A<E]C;VYG<G5E;G1I86Q?96YG:6YE)RP@
M)VUI;G-T9%]R86YD)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@
M)VUE<G-E;FYE7W1W:7-T97)?96YG:6YE)RP@)VUT,3DY,S<G*0H@("`@861D
M7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G;65R<V5N;F5?='=I<W1E<E]E;F=I
M;F4G+"`G;70Q.3DS-U\V-"<I"B`@("!A9&1?;VYE7W1Y<&5?<')I;G1E<BAO
M8FHL("=S=6)T<F%C=%]W:71H7V-A<G)Y7V5N9VEN92<L("=R86YL=7@R-%]B
M87-E)RD*("`@(&%D9%]O;F5?='EP95]P<FEN=&5R*&]B:BP@)W-U8G1R86-T
M7W=I=&A?8V%R<GE?96YG:6YE)RP@)W)A;FQU>#0X7V)A<V4G*0H@("`@861D
M7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G9&ES8V%R9%]B;&]C:U]E;F=I;F4G
M+"`G<F%N;'5X,C0G*0H@("`@861D7V]N95]T>7!E7W!R:6YT97(H;V)J+"`G
M9&ES8V%R9%]B;&]C:U]E;F=I;F4G+"`G<F%N;'5X-#@G*0H@("`@861D7V]N
M95]T>7!E7W!R:6YT97(H;V)J+"`G<VAU9F9L95]O<F1E<E]E;F=I;F4G+"`G
M:VYU=&A?8B<I"@H@("`@(R!!9&0@='EP92!P<FEN=&5R<R!F;W(@97AP97)I
M;65N=&%L.CIB87-I8U]S=')I;F=?=FEE=R!T>7!E9&5F<RX*("`@(&YS(#T@
M)V5X<&5R:6UE;G1A;#HZ9G5N9&%M96YT86QS7W8Q.CHG"B`@("!F;W(@8V@@
M:6X@*"<G+"`G=R<L("=U."<L("=U,38G+"`G=3,R)RDZ"B`@("`@("`@861D
M7V]N95]T>7!E7W!R:6YT97(H;V)J+"!N<R`K("=B87-I8U]S=')I;F=?=FEE
M=R<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@;G,@*R!C:"`K("=S
M=')I;F=?=FEE=R<I"@H@("`@(R!$;R!N;W0@<VAO=R!D969A=6QT960@=&5M
M<&QA=&4@87)G=6UE;G1S(&EN(&-L87-S('1E;7!L871E<RX*("`@(&%D9%]O
M;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)W5N:7%U95]P='(G+`H@
M("`@("`@("`@("![(#$Z("=S=&0Z.F1E9F%U;'1?9&5L971E/'LP?3XG('TI
M"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=D97%U
M92<L('L@,3H@)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?
M=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@)V9O<G=A<F1?;&ES="<L('L@
M,3H@)W-T9#HZ86QL;V-A=&]R/'LP?3XG?2D*("`@(&%D9%]O;F5?=&5M<&QA
M=&5?='EP95]P<FEN=&5R*&]B:BP@)VQI<W0G+"![(#$Z("=S=&0Z.F%L;&]C
M871O<CQ[,'T^)WTI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E
M<BAO8FHL("=?7V-X>#$Q.CIL:7-T)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\
M>S!]/B=]*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J
M+"`G=F5C=&]R)RP@>R`Q.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@
M861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G;6%P)RP*("`@
M("`@("`@("`@>R`R.B`G<W1D.CIL97-S/'LP?3XG+`H@("`@("`@("`@("`@
M(#,Z("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^
M/B<@?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP95]P<FEN=&5R*&]B:BP@
M)VUU;'1I;6%P)RP*("`@("`@("`@("`@>R`R.B`G<W1D.CIL97-S/'LP?3XG
M+`H@("`@("`@("`@("`@(#,Z("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\
M>S!](&-O;G-T+"![,7T^/B<@?2D*("`@(&%D9%]O;F5?=&5M<&QA=&5?='EP
M95]P<FEN=&5R*&]B:BP@)W-E="<L"B`@("`@("`@("`@('L@,3H@)W-T9#HZ
M;&5S<SQ[,'T^)RP@,CH@)W-T9#HZ86QL;V-A=&]R/'LP?3XG('TI"B`@("!A
M9&1?;VYE7W1E;7!L871E7W1Y<&5?<')I;G1E<BAO8FHL("=M=6QT:7-E="<L
M"B`@("`@("`@("`@('L@,3H@)W-T9#HZ;&5S<SQ[,'T^)RP@,CH@)W-T9#HZ
M86QL;V-A=&]R/'LP?3XG('TI"B`@("!A9&1?;VYE7W1E;7!L871E7W1Y<&5?
M<')I;G1E<BAO8FHL("=U;F]R9&5R961?;6%P)RP*("`@("`@("`@("`@>R`R
M.B`G<W1D.CIH87-H/'LP?3XG+`H@("`@("`@("`@("`@(#,Z("=S=&0Z.F5Q
M=6%L7W1O/'LP?3XG+`H@("`@("`@("`@("`@(#0Z("=S=&0Z.F%L;&]C871O
M<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^/B=]*0H@("`@861D7V]N95]T
M96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO<F1E<F5D7VUU;'1I;6%P
M)RP*("`@("`@("`@("`@>R`R.B`G<W1D.CIH87-H/'LP?3XG+`H@("`@("`@
M("`@("`@(#,Z("=S=&0Z.F5Q=6%L7W1O/'LP?3XG+`H@("`@("`@("`@("`@
M(#0Z("=S=&0Z.F%L;&]C871O<CQS=&0Z.G!A:7(\>S!](&-O;G-T+"![,7T^
M/B=]*0H@("`@861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G
M=6YO<F1E<F5D7W-E="<L"B`@("`@("`@("`@('L@,3H@)W-T9#HZ:&%S:#Q[
M,'T^)RP*("`@("`@("`@("`@("`R.B`G<W1D.CIE<75A;%]T;SQ[,'T^)RP*
M("`@("`@("`@("`@("`S.B`G<W1D.CIA;&QO8V%T;W(\>S!]/B=]*0H@("`@
M861D7V]N95]T96UP;&%T95]T>7!E7W!R:6YT97(H;V)J+"`G=6YO<F1E<F5D
M7VUU;'1I<V5T)RP*("`@("`@("`@("`@>R`Q.B`G<W1D.CIH87-H/'LP?3XG
M+`H@("`@("`@("`@("`@(#(Z("=S=&0Z.F5Q=6%L7W1O/'LP?3XG+`H@("`@
M("`@("`@("`@(#,Z("=S=&0Z.F%L;&]C871O<CQ[,'T^)WTI"@ID968@<F5G
M:7-T97)?;&EB<W1D8WAX7W!R:6YT97)S("AO8FHI.@H@("`@(E)E9VES=&5R
M(&QI8G-T9&,K*R!P<F5T='DM<')I;G1E<G,@=VET:"!O8FIF:6QE($]B:BXB
M"@H@("`@9VQO8F%L(%]U<V5?9V1B7W!P"B`@("!G;&]B86P@;&EB<W1D8WAX
M7W!R:6YT97(*"B`@("!I9B!?=7-E7V=D8E]P<#H*("`@("`@("!G9&(N<')I
M;G1I;F<N<F5G:7-T97)?<')E='1Y7W!R:6YT97(H;V)J+"!L:6)S=&1C>'A?
M<')I;G1E<BD*("`@(&5L<V4Z"B`@("`@("`@:68@;V)J(&ES($YO;F4Z"B`@
M("`@("`@("`@(&]B:B`](&=D8@H@("`@("`@(&]B:BYP<F5T='E?<')I;G1E
M<G,N87!P96YD*&QI8G-T9&-X>%]P<FEN=&5R*0H*("`@(')E9VES=&5R7W1Y
M<&5?<')I;G1E<G,H;V)J*0H*9&5F(&)U:6QD7VQI8G-T9&-X>%]D:6-T:6]N
M87)Y("@I.@H@("`@9VQO8F%L(&QI8G-T9&-X>%]P<FEN=&5R"@H@("`@;&EB
M<W1D8WAX7W!R:6YT97(@/2!0<FEN=&5R*")L:6)S=&1C*RLM=C8B*0H*("`@
M(",@;&EB<W1D8RLK(&]B:F5C=',@<F5Q=6ER:6YG('!R971T>2UP<FEN=&EN
M9RX*("`@(",@26X@;W)D97(@9G)O;3H*("`@(",@:'1T<#HO+V=C8RYG;G4N
M;W)G+V]N;&EN961O8W,O;&EB<W1D8RLK+VQA=&5S="UD;WAY9V5N+V$P,3@T
M-RYH=&UL"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D
M.CHG+"`G8F%S:6-?<W1R:6YG)RP@4W1D4W1R:6YG4')I;G1E<BD*("`@(&QI
M8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.E]?8WAX,3$Z.B<L
M("=B87-I8U]S=')I;F<G+"!3=&13=')I;F=0<FEN=&5R*0H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G8FET<V5T)RP@
M4W1D0FET<V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C
M;VYT86EN97(H)W-T9#HZ)RP@)V1E<75E)RP@4W1D1&5Q=650<FEN=&5R*0H@
M("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE<B@G<W1D.CHG+"`G
M;&ES="<L(%-T9$QI<W10<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N
M861D7V-O;G1A:6YE<B@G<W1D.CI?7V-X>#$Q.CHG+"`G;&ES="<L(%-T9$QI
M<W10<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE
M<B@G<W1D.CHG+"`G;6%P)RP@4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)VUU;'1I;6%P)RP@
M4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT
M86EN97(H)W-T9#HZ)RP@)VUU;'1I<V5T)RP@4W1D4V5T4')I;G1E<BD*("`@
M(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L("=P86ER
M)RP@4W1D4&%I<E!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?
M=F5R<VEO;B@G<W1D.CHG+"`G<')I;W)I='E?<75E=64G+`H@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@4W1D4W1A8VM/<E%U975E4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.B<L
M("=Q=65U92<L(%-T9%-T86-K3W)1=65U95!R:6YT97(I"B`@("!L:6)S=&1C
M>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+"`G='5P;&4G+"!3=&14
M=7!L95!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I
M;F5R*"=S=&0Z.B<L("=S970G+"!3=&139710<FEN=&5R*0H@("`@;&EB<W1D
M8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ)RP@)W-T86-K)RP@4W1D
M4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D
M9%]V97)S:6]N*"=S=&0Z.B<L("=U;FEQ=65?<'1R)RP@56YI<75E4&]I;G1E
M<E!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R
M*"=S=&0Z.B<L("=V96-T;W(G+"!3=&1696-T;W)0<FEN=&5R*0H@("`@(R!V
M96-T;W(\8F]O;#X*"B`@("`C(%!R:6YT97(@<F5G:7-T<F%T:6]N<R!F;W(@
M8VQA<W-E<R!C;VUP:6QE9"!W:71H("U$7T=,24)#6%A?1$5"54<N"B`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U9SHZ8FET<V5T)RP@
M4W1D0FET<V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G
M<W1D.CI?7V1E8G5G.CID97%U92<L(%-T9$1E<75E4')I;G1E<BD*("`@(&QI
M8G-T9&-X>%]P<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIL:7-T)RP@4W1D
M3&ES=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ
M7U]D96)U9SHZ;6%P)RP@4W1D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIM=6QT:6UA<"<L(%-T9$UA<%!R
M:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T9#HZ7U]D96)U
M9SHZ;75L=&ES970G+"!3=&139710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R
M:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G!R:6]R:71Y7W%U975E)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("!3=&13=&%C:T]R475E=650<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G%U
M975E)RP@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIS970G+"!3=&139710<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G-T
M86-K)RP@4W1D4W1A8VM/<E%U975E4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;FEQ=65?<'1R)RP@56YI<75E
M4&]I;G1E<E!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H)W-T
M9#HZ7U]D96)U9SHZ=F5C=&]R)RP@4W1D5F5C=&]R4')I;G1E<BD*"B`@("`C
M(%1H97-E(&%R92!T:&4@5%(Q(&%N9"!#*RLQ,2!P<FEN=&5R<RX*("`@(",@
M1F]R(&%R<F%Y("T@=&AE(&1E9F%U;'0@1T1"('!R971T>2UP<FEN=&5R('-E
M96US(')E87-O;F%B;&4N"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R
M<VEO;B@G<W1D.CHG+"`G<VAA<F5D7W!T<B<L(%-H87)E9%!O:6YT97)0<FEN
M=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ
M)RP@)W=E86M?<'1R)RP@4VAA<F5D4&]I;G1E<E!R:6YT97(I"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=U;F]R9&5R
M961?;6%P)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R
M+F%D9%]C;VYT86EN97(H)W-T9#HZ)RP@)W5N;W)D97)E9%]S970G+`H@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R9613
M9710<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A:6YE
M<B@G<W1D.CHG+"`G=6YO<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN97(H)W-T9#HZ
M)RP@)W5N;W)D97)E9%]M=6QT:7-E="<L"B`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@(%1R,55N;W)D97)E9%-E=%!R:6YT97(I"B`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R*"=S=&0Z.B<L("=F;W)W
M87)D7VQI<W0G+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!3=&1&;W)W87)D3&ES=%!R:6YT97(I"@H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D7W9E<G-I;VXH)W-T9#HZ='(Q.CHG+"`G<VAA<F5D7W!T<B<L(%-H
M87)E9%!O:6YT97)0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7W9E<G-I;VXH)W-T9#HZ='(Q.CHG+"`G=V5A:U]P='(G+"!3:&%R9610;VEN
M=&5R4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N
M*"=S=&0Z.G1R,3HZ)RP@)W5N;W)D97)E9%]M87`G+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@5'(Q56YO<F1E<F5D36%P4')I;G1E<BD*
M("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R,3HZ
M)RP@)W5N;W)D97)E9%]S970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@5'(Q56YO<F1E<F5D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X
M>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.G1R,3HZ)RP@)W5N;W)D97)E
M9%]M=6QT:6UA<"<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("!4<C%5;F]R9&5R961-87!0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D7W9E<G-I;VXH)W-T9#HZ='(Q.CHG+"`G=6YO<F1E<F5D7VUU;'1I
M<V5T)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N
M;W)D97)E9%-E=%!R:6YT97(I"@H@("`@(R!4:&5S92!A<F4@=&AE($,K*S$Q
M('!R:6YT97(@<F5G:7-T<F%T:6]N<R!F;W(@+41?1TQ)0D-86%]$14)51R!C
M87-E<RX*("`@(",@5&AE('1R,2!N86UE<W!A8V4@8V]N=&%I;F5R<R!D;R!N
M;W0@:&%V92!A;GD@9&5B=6<@97%U:79A;&5N=',L"B`@("`C('-O(&1O(&YO
M="!R96=I<W1E<B!P<FEN=&5R<R!F;W(@=&AE;2X*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9"@G<W1D.CI?7V1E8G5G.CIU;F]R9&5R961?;6%P)RP*("`@
M("`@("`@("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R961-87!0<FEN=&5R
M*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N
M;W)D97)E9%]S970G+`H@("`@("`@("`@("`@("`@("`@("`@("`@(%1R,55N
M;W)D97)E9%-E=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&0H
M)W-T9#HZ7U]D96)U9SHZ=6YO<F1E<F5D7VUU;'1I;6%P)RP*("`@("`@("`@
M("`@("`@("`@("`@("`@("!4<C%5;F]R9&5R961-87!0<FEN=&5R*0H@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D*"=S=&0Z.E]?9&5B=6<Z.G5N;W)D97)E
M9%]M=6QT:7-E="<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@5'(Q56YO
M<F1E<F5D4V5T4')I;G1E<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9"@G
M<W1D.CI?7V1E8G5G.CIF;W)W87)D7VQI<W0G+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@(%-T9$9O<G=A<F1,:7-T4')I;G1E<BD*"B`@("`C($QI8G)A
M<GD@1G5N9&%M96YT86QS(%13(&-O;7!O;F5N=',*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ9G5N9&%M
M96YT86QS7W8Q.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@)V%N>2<L(%-T9$5X<$%N>5!R:6YT97(I"B`@("!L:6)S=&1C>'A?<')I
M;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT86PZ.F9U;F1A;65N
M=&%L<U]V,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("=O<'1I;VYA;"<L(%-T9$5X<$]P=&EO;F%L4')I;G1E<BD*("`@(&QI8G-T
M9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F5X<&5R:6UE;G1A;#HZ
M9G5N9&%M96YT86QS7W8Q.CHG+`H@("`@("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@)V)A<VEC7W-T<FEN9U]V:65W)RP@4W1D17AP4W1R:6YG5FEE
M=U!R:6YT97(I"B`@("`C($9I;&5S>7-T96T@5%,@8V]M<&]N96YT<PH@("`@
M;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I;VXH)W-T9#HZ97AP97)I;65N
M=&%L.CIF:6QE<WES=&5M.CIV,3HZ)RP*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("=P871H)RP@4W1D17AP4&%T:%!R:6YT97(I"B`@("!L
M:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CIE>'!E<FEM96YT
M86PZ.F9I;&5S>7-T96TZ.G8Q.CI?7V-X>#$Q.CHG+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@)W!A=&@G+"!3=&1%>'!0871H4')I;G1E
M<BD*("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S=&0Z.F9I
M;&5S>7-T96TZ.B<L"B`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("`G<&%T:"<L(%-T9%!A=&A0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D7W9E<G-I;VXH)W-T9#HZ9FEL97-Y<W1E;3HZ7U]C>'@Q,3HZ)RP*
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("=P871H)RP@4W1D
M4&%T:%!R:6YT97(I"@H@("`@(R!#*RLQ-R!C;VUP;VYE;G1S"B`@("!L:6)S
M=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+`H@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@)V%N>2<L(%-T9$5X<$%N>5!R:6YT
M97(I"B`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG
M+`H@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@)V]P=&EO;F%L
M)RP@4W1D17AP3W!T:6]N86Q0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT
M97(N861D7W9E<G-I;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("=B87-I8U]S=')I;F=?=FEE=R<L(%-T9$5X<%-T<FEN
M9U9I97=0<FEN=&5R*0H@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I
M;VXH)W-T9#HZ)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@
M("=V87)I86YT)RP@4W1D5F%R:6%N=%!R:6YT97(I"B`@("!L:6)S=&1C>'A?
M<')I;G1E<BYA9&1?=F5R<VEO;B@G<W1D.CHG+`H@("`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@)U].;V1E7VAA;F1L92<L(%-T9$YO9&5(86YD
M;&50<FEN=&5R*0H*("`@(",@17AT96YS:6]N<RX*("`@(&QI8G-T9&-X>%]P
M<FEN=&5R+F%D9%]V97)S:6]N*"=?7V=N=5]C>'@Z.B<L("=S;&ES="<L(%-T
M9%-L:7-T4')I;G1E<BD*"B`@("!I9B!4<G5E.@H@("`@("`@(",@5&AE<V4@
M<VAO=6QD;B=T(&)E(&YE8V5S<V%R>2P@:68@1T1"(")P<FEN="`J:2(@=V]R
M:V5D+@H@("`@("`@(",@0G5T(&ET(&]F=&5N(&1O97-N)W0L('-O(&AE<F4@
M=&AE>2!A<F4N"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O;G1A
M:6YE<B@G<W1D.CHG+"`G7TQI<W1?:71E<F%T;W(G+`H@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D3&ES=$ET97)A=&]R4')I
M;G1E<BD*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R
M*"=S=&0Z.B<L("=?3&ES=%]C;VYS=%]I=&5R871O<B<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1,:7-T271E<F%T;W)0
M<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N
M*"=S=&0Z.B<L("=?4F)?=')E95]I=&5R871O<B<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@4W1D4F)T<F5E271E<F%T;W)0<FEN
M=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]V97)S:6]N*"=S
M=&0Z.B<L("=?4F)?=')E95]C;VYS=%]I=&5R871O<B<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D4F)T<F5E271E<F%T;W)0
M<FEN=&5R*0H@("`@("`@(&QI8G-T9&-X>%]P<FEN=&5R+F%D9%]C;VYT86EN
M97(H)W-T9#HZ)RP@)U]$97%U95]I=&5R871O<B<L"B`@("`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1$97%U94ET97)A=&]R4')I
M;G1E<BD*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA9&1?8V]N=&%I;F5R
M*"=S=&0Z.B<L("=?1&5Q=65?8V]N<W1?:71E<F%T;W(G+`H@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D1&5Q=65)=&5R871O
M<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E<G-I
M;VXH)U]?9VYU7V-X>#HZ)RP@)U]?;F]R;6%L7VET97)A=&]R)RP*("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("!3=&1696-T;W))=&5R
M871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7W9E
M<G-I;VXH)U]?9VYU7V-X>#HZ)RP@)U]3;&ES=%]I=&5R871O<B<L"B`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@4W1D4VQI<W1)=&5R
M871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D7V-O
M;G1A:6YE<B@G<W1D.CHG+"`G7T9W9%]L:7-T7VET97)A=&]R)RP*("`@("`@
M("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%-T9$9W9$QI<W1)
M=&5R871O<E!R:6YT97(I"B`@("`@("`@;&EB<W1D8WAX7W!R:6YT97(N861D
M7V-O;G1A:6YE<B@G<W1D.CHG+"`G7T9W9%]L:7-T7V-O;G-T7VET97)A=&]R
M)RP*("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@("`@(%-T
M9$9W9$QI<W1)=&5R871O<E!R:6YT97(I"@H@("`@("`@(",@1&5B=6<@*&-O
M;7!I;&5D('=I=&@@+41?1TQ)0D-86%]$14)51RD@<')I;G1E<@H@("`@("`@
M(",@<F5G:7-T<F%T:6]N<RX*("`@("`@("!L:6)S=&1C>'A?<')I;G1E<BYA
M9&0H)U]?9VYU7V1E8G5G.CI?4V%F95]I=&5R871O<B<L"B`@("`@("`@("`@
M("`@("`@("`@("`@("`@("`@(%-T9$1E8G5G271E<F%T;W)0<FEN=&5R*0H*
M8G5I;&1?;&EB<W1D8WAX7V1I8W1I;VYA<GD@*"D*````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````"XO<'ET:&]N+VQI8G-T9&-X>"]?7VEN:71?7RYP>0``````````````
M````````````````````````````````````````````````````````````
M```````````````````P,#`P-C0T`#`P,#(P,#(`,#`P,#$T-``P,#`P,#`P
M,#`P,0`Q,S4W,30Q,#(S,``P,38Q-C4`(#``````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````=7-T87(@(`!F
M:F%R9&]N`````````````````````````````````'5S97)S````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````"@``````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````````````````````N+W!Y=&AO
M;B]-86ME9FEL92YI;@``````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````,#`P,#8T-``P,#`R,#`R`#`P,#`Q-#0`,#`P,#`P-#0U,3``,3,U-S$T
M,3`R,S``,#$T,3,R`"`P````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````````````'5S=&%R("``9FIA<F1O;@``````
M``````````````````````````!U<V5R<P``````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M`````````````",@36%K969I;&4N:6X@9V5N97)A=&5D(&)Y(&%U=&]M86ME
M(#$N,34N,2!F<F]M($UA:V5F:6QE+F%M+@HC($!C;VYF:6=U<F5?:6YP=71`
M"@HC($-O<'ER:6=H="`H0RD@,3DY-"TR,#$W($9R964@4V]F='=A<F4@1F]U
M;F1A=&EO;BP@26YC+@H*(R!4:&ES($UA:V5F:6QE+FEN(&ES(&9R964@<V]F
M='=A<F4[('1H92!&<F5E(%-O9G1W87)E($9O=6YD871I;VX*(R!G:79E<R!U
M;FQI;6ET960@<&5R;6ES<VEO;B!T;R!C;W!Y(&%N9"]O<B!D:7-T<FEB=71E
M(&ET+`HC('=I=&@@;W(@=VET:&]U="!M;V1I9FEC871I;VYS+"!A<R!L;VYG
M(&%S('1H:7,@;F]T:6-E(&ES('!R97-E<G9E9"X*"B,@5&AI<R!P<F]G<F%M
M(&ES(&1I<W1R:6)U=&5D(&EN('1H92!H;W!E('1H870@:70@=VEL;"!B92!U
M<V5F=6PL"B,@8G5T(%=)5$A/550@04Y9(%=!4E)!3E19+"!T;R!T:&4@97AT
M96YT('!E<FUI='1E9"!B>2!L87<[('=I=&AO=70*(R!E=F5N('1H92!I;7!L
M:65D('=A<G)A;G1Y(&]F($U%4D-(04Y404))3$E462!O<B!&251.15-3($9/
M4B!!"B,@4$%25$E#54Q!4B!055)03U-%+@H*0%-%5%]-04M%0`H*5E!!5$@@
M/2!`<W)C9&ER0`IA;5]?:7-?9VYU7VUA:V4@/2![(%P*("!I9B!T97-T("UZ
M("<D*$U!2T5,159%3"DG.R!T:&5N(%P*("`@(&9A;'-E.R!<"B`@96QI9B!T
M97-T("UN("<D*$U!2T5?2$]35"DG.R!T:&5N(%P*("`@('1R=64[(%P*("!E
M;&EF('1E<W0@+6X@)R0H34%+15]615)324].*2<@)B8@=&5S="`M;B`G)"A#
M55)$25(I)SL@=&AE;B!<"B`@("!T<G5E.R!<"B`@96QS92!<"B`@("!F86QS
M93L@7`H@(&9I.R!<"GT*86U?7VUA:V5?<G5N;FEN9U]W:71H7V]P=&EO;B`]
M(%P*("!C87-E("0D>W1A<F=E=%]O<'1I;VXM?2!I;B!<"B`@("`@(#\I(#L[
M(%P*("`@("`@*BD@96-H;R`B86U?7VUA:V5?<G5N;FEN9U]W:71H7V]P=&EO
M;CH@:6YT97)N86P@97)R;W(Z(&EN=F%L:60B(%P*("`@("`@("`@("`@("`B
M=&%R9V5T(&]P=&EO;B`G)"1[=&%R9V5T7V]P=&EO;BU])R!S<&5C:69I960B
M(#XF,CL@7`H@("`@("`@("!E>&ET(#$[.R!<"B`@97-A8SL@7`H@(&AA<U]O
M<'0];F\[(%P*("!S86YE7VUA:V5F;&%G<STD)$U!2T5&3$%'4SL@7`H@(&EF
M("0H86U?7VES7V=N=5]M86ME*3L@=&AE;B!<"B`@("!S86YE7VUA:V5F;&%G
M<STD)$U&3$%'4SL@7`H@(&5L<V4@7`H@("`@8V%S92`D)$U!2T5&3$%'4R!I
M;B!<"B`@("`@("I<7%M<(%P)72HI(%P*("`@("`@("!B<SU<7#L@7`H@("`@
M("`@('-A;F5?;6%K969L86=S/6!P<FEN=&8@)R5S7&XG("(D)$U!2T5&3$%'
M4R(@7`H@("`@("`@("`@?"!S960@(G,O)"1B<R0D8G-;)"1B<R`D)&)S"5TJ
M+R]G(F`[.R!<"B`@("!E<V%C.R!<"B`@9FD[(%P*("!S:VEP7VYE>'0];F\[
M(%P*("!S=')I<%]T<F%I;&]P="`H*2!<"B`@>R!<"B`@("!F;&<]8'!R:6YT
M9B`G)7-<;B<@(B0D9FQG(B!\('-E9"`B<R\D)#$N*B0D+R\B8#L@7`H@('T[
M(%P*("!F;W(@9FQG(&EN("0D<V%N95]M86ME9FQA9W,[(&1O(%P*("`@('1E
M<W0@)"1S:VEP7VYE>'0@/2!Y97,@)B8@>R!S:VEP7VYE>'0];F\[(&-O;G1I
M;G5E.R!].R!<"B`@("!C87-E("0D9FQG(&EN(%P*("`@("`@*CTJ?"TM*BD@
M8V]N=&EN=64[.R!<"B`@("`@("`@+2I)*2!S=')I<%]T<F%I;&]P="`G22<[
M('-K:7!?;F5X=#UY97,[.R!<"B`@("`@("TJ23\J*2!S=')I<%]T<F%I;&]P
M="`G22<[.R!<"B`@("`@("`@+2I/*2!S=')I<%]T<F%I;&]P="`G3R<[('-K
M:7!?;F5X=#UY97,[.R!<"B`@("`@("TJ3S\J*2!S=')I<%]T<F%I;&]P="`G
M3R<[.R!<"B`@("`@("`@+2IL*2!S=')I<%]T<F%I;&]P="`G;"<[('-K:7!?
M;F5X=#UY97,[.R!<"B`@("`@("TJ;#\J*2!S=')I<%]T<F%I;&]P="`G;"<[
M.R!<"B`@("`@("U;9$5$;5TI('-K:7!?;F5X=#UY97,[.R!<"B`@("`@("U;
M2E1=*2!S:VEP7VYE>'0]>65S.SL@7`H@("`@97-A8SL@7`H@("`@8V%S92`D
M)&9L9R!I;B!<"B`@("`@("HD)'1A<F=E=%]O<'1I;VXJ*2!H87-?;W!T/7EE
M<SL@8G)E86L[.R!<"B`@("!E<V%C.R!<"B`@9&]N93L@7`H@('1E<W0@)"1H
M87-?;W!T(#T@>65S"F%M7U]M86ME7V1R>7)U;B`]("AT87)G971?;W!T:6]N
M/6X[("0H86U?7VUA:V5?<G5N;FEN9U]W:71H7V]P=&EO;BDI"F%M7U]M86ME
M7VME97!G;VEN9R`]("AT87)G971?;W!T:6]N/6L[("0H86U?7VUA:V5?<G5N
M;FEN9U]W:71H7V]P=&EO;BDI"G!K9V1A=&%D:7(@/2`D*&1A=&%D:7(I+T!0
M04-+04=%0`IP:V=I;F-L=61E9&ER(#T@)"AI;F-L=61E9&ER*2]`4$%#2T%'
M14`*<&MG;&EB9&ER(#T@)"AL:6)D:7(I+T!004-+04=%0`IP:V=L:6)E>&5C
M9&ER(#T@)"AL:6)E>&5C9&ER*2]`4$%#2T%'14`*86U?7V-D(#T@0T10051(
M/2(D)'M:4TA?5D524TE/3BLN?20H4$%42%]315!!4D%43U(I(B`F)B!C9`II
M;G-T86QL7W-H7T1!5$$@/2`D*&EN<W1A;&Q?<V@I("UC("UM(#8T-`II;G-T
M86QL7W-H7U!23T=204T@/2`D*&EN<W1A;&Q?<V@I("UC"FEN<W1A;&Q?<VA?
M4T-225!4(#T@)"AI;G-T86QL7W-H*2`M8PI)3E-404Q,7TA%041%4B`]("0H
M24Y35$%,3%]$051!*0IT<F%N<V9O<FT@/2`D*'!R;V=R86U?=')A;G-F;W)M
M7VYA;64I"DY/4DU!3%])3E-404Q,(#T@.@I04D5?24Y35$%,3"`](#H*4$]3
M5%])3E-404Q,(#T@.@I.3U)-04Q?54Y)3E-404Q,(#T@.@I04D5?54Y)3E-4
M04Q,(#T@.@I03U-47U5.24Y35$%,3"`](#H*8G5I;&1?=')I<&QE="`]($!B
M=6EL9$`*:&]S=%]T<FEP;&5T(#T@0&AO<W1`"G1A<F=E=%]T<FEP;&5T(#T@
M0'1A<F=E=$`*<W5B9&ER(#T@<'ET:&]N"D%#3$]#04Q?330@/2`D*'1O<%]S
M<F-D:7(I+V%C;&]C86PN;30*86U?7V%C;&]C86Q?;31?9&5P<R`]("0H=&]P
M7W-R8V1I<BDO+BXO8V]N9FEG+V%C>"YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN
M+V-O;F9I9R]E;F%B;&4N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O
M9G5T97@N;30@7`H))"AT;W!?<W)C9&ER*2\N+B]C;VYF:6<O:'=C87!S+FTT
M(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VEC;VYV+FTT(%P*"20H=&]P
M7W-R8V1I<BDO+BXO8V]N9FEG+VQE860M9&]T+FTT(%P*"20H=&]P7W-R8V1I
M<BDO+BXO8V]N9FEG+VQI8BUL9"YM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O
M;F9I9R]L:6(M;&EN:RYM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]L
M:6(M<')E9FEX+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VQT:&]S
M=&9L86=S+FTT(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VUU;'1I+FTT
M(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+VYO+65X96-U=&%B;&5S+FTT
M(%P*"20H=&]P7W-R8V1I<BDO+BXO8V]N9FEG+V]V97)R:61E+FTT(%P*"20H
M=&]P7W-R8V1I<BDO+BXO8V]N9FEG+W-T9&EN="YM-"!<"@DD*'1O<%]S<F-D
M:7(I+RXN+V-O;F9I9R]U;G=I;F1?:7!I;F9O+FTT(%P*"20H=&]P7W-R8V1I
M<BDO+BXO;&EB=&]O;"YM-"`D*'1O<%]S<F-D:7(I+RXN+VQT;W!T:6]N<RYM
M-"!<"@DD*'1O<%]S<F-D:7(I+RXN+VQT<W5G87(N;30@)"AT;W!?<W)C9&ER
M*2\N+B]L='9E<G-I;VXN;30@7`H))"AT;W!?<W)C9&ER*2\N+B]L='YO8G-O
M;&5T92YM-"`D*'1O<%]S<F-D:7(I+V-R;W-S8V]N9FEG+FTT(%P*"20H=&]P
M7W-R8V1I<BDO;&EN:V%G92YM-"`D*'1O<%]S<F-D:7(I+V%C:6YC;'5D92YM
M-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]G8RLK9FEL="YM-"!<"@DD
M*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]T;',N;30@)"AT;W!?<W)C9&ER*2\N
M+B]C;VYF:6<O9W1H<BYM-"!<"@DD*'1O<%]S<F-D:7(I+RXN+V-O;F9I9R]C
M970N;30@)"AT;W!?<W)C9&ER*2]C;VYF:6=U<F4N86,*86U?7V-O;F9I9W5R
M95]D97!S(#T@)"AA;5]?86-L;V-A;%]M-%]D97!S*2`D*$-/3D9)1U5215]$
M15!%3D1%3D-)15,I(%P*"20H04-,3T-!3%]--"D*1$E35%]#3TU-3TX@/2`D
M*'-R8V1I<BDO36%K969I;&4N86T*0T].1DE'7TA%041%4B`]("0H=&]P7V)U
M:6QD9&ER*2]C;VYF:6<N:`I#3TY&24=?0TQ%04Y?1DE,15,@/0I#3TY&24=?
M0TQ%04Y?5E!!5$A?1DE,15,@/0I!35]67U`@/2`D*&%M7U]V7U!?0$%-7U9`
M*0IA;5]?=E]07R`]("0H86U?7W9?4%]`04U?1$5&055,5%]60"D*86U?7W9?
M4%\P(#T@9F%L<V4*86U?7W9?4%\Q(#T@.@I!35]67T=%3B`]("0H86U?7W9?
M1T5.7T!!35]60"D*86U?7W9?1T5.7R`]("0H86U?7W9?1T5.7T!!35]$149!
M54Q47U9`*0IA;5]?=E]'14Y?,"`]($!E8VAO("(@($=%3B`@("`@(B`D0#L*
M86U?7W9?1T5.7S$@/2`*04U?5E]A="`]("0H86U?7W9?871?0$%-7U9`*0IA
M;5]?=E]A=%\@/2`D*&%M7U]V7V%T7T!!35]$149!54Q47U9`*0IA;5]?=E]A
M=%\P(#T@0`IA;5]?=E]A=%\Q(#T@"F1E<&-O;7`@/0IA;5]?9&5P9FEL97-?
M;6%Y8F4@/0I33U520T53(#T*86U?7V-A;E]R=6Y?:6YS=&%L;&EN9F\@/2!<
M"B`@8V%S92`D)$%-7U501$%415])3D9/7T1)4B!I;B!<"B`@("!N?&YO?$Y/
M*2!F86QS93L[(%P*("`@("HI("AI;G-T86QL+6EN9F\@+2UV97)S:6]N*2`^
M+V1E=B]N=6QL(#(^)C$[.R!<"B`@97-A8PIA;5]?=G!A=&A?861J7W-E='5P
M(#T@<W)C9&ER<W1R:7`]8&5C:&\@(B0H<W)C9&ER*2(@?"!S960@)W-\+GPN
M?&<G8#L*86U?7W9P871H7V%D:B`](&-A<V4@)"1P(&EN(%P*("`@("0H<W)C
M9&ER*2\J*2!F/6!E8VAO("(D)'`B('P@<V5D(")S?%XD)'-R8V1I<G-T<FEP
M+WQ\(F`[.R!<"B`@("`J*2!F/20D<#L[(%P*("!E<V%C.PIA;5]?<W1R:7!?
M9&ER(#T@9CU@96-H;R`D)'`@?"!S960@+64@)W-\7BXJ+WQ\)V`["F%M7U]I
M;G-T86QL7VUA>"`](#0P"F%M7U]N;V)A<V5?<W1R:7!?<V5T=7`@/2!<"B`@
M<W)C9&ER<W1R:7`]8&5C:&\@(B0H<W)C9&ER*2(@?"!S960@)W,O6UTN6UXD
M)%Q<*GQ=+UQ<7%PF+V<G8`IA;5]?;F]B87-E7W-T<FEP(#T@7`H@(&9O<B!P
M(&EN("0D;&ES=#L@9&\@96-H;R`B)"1P(CL@9&]N92!\('-E9"`M92`B<WPD
M)'-R8V1I<G-T<FEP+WQ\(@IA;5]?;F]B87-E7VQI<W0@/2`D*&%M7U]N;V)A
M<V5?<W1R:7!?<V5T=7`I.R!<"B`@9F]R('`@:6X@)"1L:7-T.R!D;R!E8VAO
M("(D)'`@)"1P(CL@9&]N92!\(%P*("!S960@(G-\("0D<W)C9&ER<W1R:7`O
M?"!\.R(G("\@+BI<+R\A<R\@+BHO("XO.R!S+%PH("XJ7"DO6UXO72HD)"Q<
M,2PG('P@7`H@("0H05=+*2`G0D5'24X@>R!F:6QE<ULB+B)=(#T@(B(@?2![
M(&9I;&5S6R0D,ET@/2!F:6QE<ULD)#)=("(@(B`D)#$[(%P*("`@(&EF("@K
M*VY;)"0R72`]/2`D*&%M7U]I;G-T86QL7VUA>"DI(%P*("`@("`@>R!P<FEN
M="`D)#(L(&9I;&5S6R0D,ET[(&Y;)"0R72`](#`[(&9I;&5S6R0D,ET@/2`B
M(B!]('T@7`H@("`@14Y$('L@9F]R("AD:7(@:6X@9FEL97,I('!R:6YT(&1I
M<BP@9FEL97-;9&ER72!])PIA;5]?8F%S95]L:7-T(#T@7`H@('-E9"`G)"0A
M3CLD)"%..R0D(4X[)"0A3CLD)"%..R0D(4X[)"0A3CMS+UQN+R`O9R<@?"!<
M"B`@<V5D("<D)"%..R0D(4X[)"0A3CLD)"%..W,O7&XO("]G)PIA;5]?=6YI
M;G-T86QL7V9I;&5S7V9R;VU?9&ER(#T@>R!<"B`@=&5S="`M>B`B)"1F:6QE
M<R(@7`H@("`@?'P@>R!T97-T("$@+60@(B0D9&ER(B`F)B!T97-T("$@+68@
M(B0D9&ER(B`F)B!T97-T("$@+7(@(B0D9&ER(CL@?2!<"B`@("!\?"![(&5C
M:&\@(B`H(&-D("<D)&1I<B<@)B8@<FT@+68B("0D9FEL97,@(BDB.R!<"B`@
M("`@("`@("0H86U?7V-D*2`B)"1D:7(B("8F(')M("UF("0D9FEL97,[('T[
M(%P*("!]"F%M7U]I;G-T86QL9&ER<R`]("(D*$1%4U1$25(I)"AP>71H;VYD
M:7(I(@I$051!(#T@)"AN;V)A<V5?<'ET:&]N7T1!5$$I"F%M7U]T86=G961?
M9FEL97,@/2`D*$A%041%4E,I("0H4T]54D-%4RD@)"A404=37T9)3$53*2`D
M*$Q)4U`I"D%"25]45T5!2U-?4U)#1$E2(#T@0$%"25]45T5!2U-?4U)#1$E2
M0`I!0TQ/0T%,(#T@0$%#3$]#04Q`"D%,3$]#051/4E]((#T@0$%,3$]#051/
M4E](0`I!3$Q/0T%43U)?3D%-12`]($!!3$Q/0T%43U)?3D%-14`*04U405(@
M/2!`04U405)`"D%-7T1%1D%53%1?5D520D]32519(#T@0$%-7T1%1D%53%1?
M5D520D]325190`I!4B`]($!!4D`*05,@/2!`05-`"D%43TU)0TE465]34D-$
M25(@/2!`051/34E#25197U-20T1)4D`*051/34E#7T9,04=3(#T@0$%43TU)
M0U]&3$%'4T`*051/34E#7U=/4D1?4U)#1$E2(#T@0$%43TU)0U]73U)$7U-2
M0T1)4D`*05543T-/3D8@/2!`05543T-/3D9`"D%55$](14%$15(@/2!`0554
M3TA%041%4D`*05543TU!2T4@/2!`05543TU!2T5`"D%72R`]($!!5TM`"D)!
M4TE#7T9)3$5?0T,@/2!`0D%324-?1DE,15]#0T`*0D%324-?1DE,15]((#T@
M0$)!4TE#7T9)3$5?2$`*0T,@/2!`0T-`"D-#3T1%0U947T-#(#T@0$-#3T1%
M0U947T-#0`I#0T],3$%415]#0R`]($!#0T],3$%415]#0T`*0T-465!%7T-#
M(#T@0$-#5%E015]#0T`*0T9,04=3(#T@0$-&3$%'4T`*0TQ/0T%,15]#0R`]
M($!#3$]#04Q%7T-#0`I#3$]#04Q%7T@@/2!`0TQ/0T%,15](0`I#3$]#04Q%
M7TE.5$523D%,7T@@/2!`0TQ/0T%,15])3E1%4DY!3%](0`I#34534T%'15-?
M0T,@/2!`0TU%4U-!1T537T-#0`I#34534T%'15-?2"`]($!#34534T%'15-?
M2$`*0TU/3D597T-#(#T@0$--3TY%65]#0T`*0TY5345224-?0T,@/2!`0TY5
M345224-?0T-`"D-04"`]($!#4%!`"D-04$9,04=3(#T@0$-04$9,04=30`I#
M4%5?1$5&24Y%4U]34D-$25(@/2!`0U!57T1%1DE.15-?4U)#1$E20`I#4%5?
M3U!47T))5%-?4D%.1$]-(#T@0$-055]/4%1?0DE44U]204Y$3TU`"D-055]/
M4%1?15A47U)!3D1/32`]($!#4%5?3U!47T585%]204Y$3TU`"D-35$1)3U](
M(#T@0$-35$1)3U](0`I#5$E-15]#0R`]($!#5$E-15]#0T`*0U1)345?2"`]
M($!#5$E-15](0`I#6%@@/2!`0UA80`I#6%A#4%`@/2!`0UA80U!00`I#6%A&
M24Q4(#T@0$-86$9)3%1`"D-86$9,04=3(#T@0$-86$9,04=30`I#64=0051(
M7U<@/2!`0UE'4$%42%]70`I#7TE.0TQ51$5?1$E2(#T@0$-?24Y#3%5$15]$
M25)`"D1"3$%415@@/2!`1$),051%6$`*1$5"54=?1DQ!1U,@/2!`1$5"54=?
M1DQ!1U-`"D1%1E,@/2!`1$5&4T`*1$]4(#T@0$1/5$`*1$]864=%3B`]($!$
M3UA91T5.0`I$4UE-551)3"`]($!$4UE-551)3$`*1%5-4$))3B`]($!$54U0
M0DE.0`I%0TA/7T,@/2!`14-(3U]#0`I%0TA/7TX@/2!`14-(3U].0`I%0TA/
M7U0@/2!`14-(3U]40`I%1U)%4"`]($!%1U)%4$`*15)23U)?0T].4U1!3E13
M7U-20T1)4B`]($!%4E)/4E]#3TY35$%.5%-?4U)#1$E20`I%6$5%6%0@/2!`
M15A%15A40`I%6%1205]#1DQ!1U,@/2!`15A44D%?0T9,04=30`I%6%1205]#
M6%A?1DQ!1U,@/2!`15A44D%?0UA87T9,04=30`I&1U)%4"`]($!&1U)%4$`*
M1TQ)0D-86%])3D-,541%4R`]($!'3$E"0UA87TE.0TQ51$530`I'3$E"0UA8
M7TQ)0E,@/2!`1TQ)0D-86%],24)30`I'4D50(#T@0$=215!`"DA70T%07T-&
M3$%'4R`]($!(5T-!4%]#1DQ!1U-`"DE.4U1!3$P@/2!`24Y35$%,3$`*24Y3
M5$%,3%]$051!(#T@0$E.4U1!3$Q?1$%404`*24Y35$%,3%]04D]'4D%-(#T@
M0$E.4U1!3$Q?4%)/1U)!34`*24Y35$%,3%]30U))4%0@/2!`24Y35$%,3%]3
M0U))4%1`"DE.4U1!3$Q?4U1225!?4%)/1U)!32`]($!)3E-404Q,7U-44DE0
M7U!23T=204U`"DQ$(#T@0$Q$0`I,1$9,04=3(#T@0$Q$1DQ!1U-`"DQ)0DE#
M3TY6(#T@0$Q)0DE#3TY60`I,24)/0DI3(#T@0$Q)0D]"2E-`"DQ)0E,@/2!`
M3$E"4T`*3$E"5$]/3"`]($!,24)43T],0`I,25!/(#T@0$Q)4$]`"DQ.7U,@
M/2!`3$Y?4T`*3$].1U]$3U5"3$5?0T]-4$%47T9,04=3(#T@0$Q/3D=?1$]5
M0DQ%7T-/35!!5%]&3$%'4T`*3%1,24))0T].5B`]($!,5$Q)0DE#3TY60`I,
M5$Q)0D]"2E,@/2!`3%1,24)/0DI30`I-04E.5"`]($!-04E.5$`*34%+14E.
M1D\@/2!`34%+14E.1D]`"DU+1$E27U`@/2!`34M$25)?4$`*3DT@/2!`3DU`
M"DY-141)5"`]($!.345$251`"D]"2D1535`@/2!`3T)*1%5-4$`*3T)*15A4
M(#T@0$]"2D585$`*3U!424U)6D5?0UA81DQ!1U,@/2!`3U!424U)6D5?0UA8
M1DQ!1U-`"D]05%],1$9,04=3(#T@0$]05%],1$9,04=30`I/4U])3D-?4U)#
M1$E2(#T@0$]37TE.0U]34D-$25)`"D]43T],(#T@0$]43T],0`I/5$]/3#8T
M(#T@0$]43T],-C1`"E!!0TM!1T4@/2!`4$%#2T%'14`*4$%#2T%'15]"54=2
M15!/4E0@/2!`4$%#2T%'15]"54=215!/4E1`"E!!0TM!1T5?3D%-12`]($!0
M04-+04=%7TY!345`"E!!0TM!1T5?4U1224Y'(#T@0%!!0TM!1T5?4U1224Y'
M0`I004-+04=%7U1!4DY!344@/2!`4$%#2T%'15]405).04U%0`I004-+04=%
M7U523"`]($!004-+04=%7U523$`*4$%#2T%'15]615)324].(#T@0%!!0TM!
M1T5?5D524TE/3D`*4$%42%]315!!4D%43U(@/2!`4$%42%]315!!4D%43U)`
M"E!$1DQ!5$58(#T@0%!$1DQ!5$580`I204Y,24(@/2!`4D%.3$E"0`I314-4
M24].7T9,04=3(#T@0%-%0U1)3TY?1DQ!1U-`"E-%0U1)3TY?3$1&3$%'4R`]
M($!314-424].7TQ$1DQ!1U-`"E-%1"`]($!3141`"E-%5%]-04M%(#T@0%-%
M5%]-04M%0`I32$5,3"`]($!32$5,3$`*4U1225`@/2!`4U1225!`"E-9359%
M4E]&24Q%(#T@0%-9359%4E]&24Q%0`I43U!,159%3%])3D-,541%4R`]($!4
M3U!,159%3%])3D-,541%4T`*55-%7TY,4R`]($!54T5?3DQ30`I615)324].
M(#T@0%9%4E-)3TY`"E945E]#6%A&3$%'4R`]($!65%9?0UA81DQ!1U-`"E94
M5E]#6%A,24Y+1DQ!1U,@/2!`5E167T-86$Q)3DM&3$%'4T`*5E167U!#2%]#
M6%A&3$%'4R`]($!65%9?4$-(7T-86$9,04=30`I705).7T9,04=3(#T@0%=!
M4DY?1DQ!1U-`"EA-3$-!5$%,3T<@/2!`6$U,0T%404Q/1T`*6$U,3$E.5"`]
M($!834Q,24Y40`I84TQ44%)/0R`]($!84TQ44%)/0T`*6%-,7U-464Q%7T1)
M4B`]($!84TQ?4U193$5?1$E20`IA8G-?8G5I;&1D:7(@/2!`86)S7V)U:6QD
M9&ER0`IA8G-?<W)C9&ER(#T@0&%B<U]S<F-D:7)`"F%B<U]T;W!?8G5I;&1D
M:7(@/2!`86)S7W1O<%]B=6EL9&1I<D`*86)S7W1O<%]S<F-D:7(@/2!`86)S
M7W1O<%]S<F-D:7)`"F%C7V-T7T-#(#T@0&%C7V-T7T-#0`IA8U]C=%]#6%@@
M/2!`86-?8W1?0UA80`IA8U]C=%]$54U00DE.(#T@0&%C7V-T7T1535!"24Y`
M"F%M7U]L96%D:6YG7V1O="`]($!A;5]?;&5A9&EN9U]D;W1`"F%M7U]T87(@
M/2!`86U?7W1A<D`*86U?7W5N=&%R(#T@0&%M7U]U;G1A<D`*8F%S96QI;F5?
M9&ER(#T@0&)A<V5L:6YE7V1I<D`*8F%S96QI;F5?<W5B9&ER7W-W:71C:"`]
M($!B87-E;&EN95]S=6)D:7)?<W=I=&-H0`IB:6YD:7(@/2!`8FEN9&ER0`IB
M=6EL9"`]($!B=6EL9$`*8G5I;&1?86QI87,@/2!`8G5I;&1?86QI87-`"F)U
M:6QD7V-P=2`]($!B=6EL9%]C<'5`"F)U:6QD7V]S(#T@0&)U:6QD7V]S0`IB
M=6EL9%]V96YD;W(@/2!`8G5I;&1?=F5N9&]R0`IB=6EL9&1I<B`]($!B=6EL
M9&1I<D`*8VAE8VM?;7-G9FUT(#T@0&-H96-K7VUS9V9M=$`*9&%T861I<B`]
M($!D871A9&ER0`ID871A<F]O=&1I<B`]($!D871A<F]O=&1I<D`*9&]C9&ER
M(#T@0&1O8V1I<D`*9'9I9&ER(#T@0&1V:61I<D`*96YA8FQE7W-H87)E9"`]
M($!E;F%B;&5?<VAA<F5D0`IE;F%B;&5?<W1A=&EC(#T@0&5N86)L95]S=&%T
M:6-`"F5X96-?<')E9FEX(#T@0&5X96-?<')E9FEX0`IG971?9V-C7V)A<V5?
M=F5R(#T@0&=E=%]G8V-?8F%S95]V97)`"F=L:6)C>'A?34]&24Q%4R`]($!G
M;&EB8WAX7TU/1DE,15-`"F=L:6)C>'A?4$-(1DQ!1U,@/2!`9VQI8F-X>%]0
M0TA&3$%'4T`*9VQI8F-X>%]03T9)3$53(#T@0&=L:6)C>'A?4$]&24Q%4T`*
M9VQI8F-X>%]B=6EL9&1I<B`]($!G;&EB8WAX7V)U:6QD9&ER0`IG;&EB8WAX
M7V-O;7!I;&5R7W!I8U]F;&%G(#T@0&=L:6)C>'A?8V]M<&EL97)?<&EC7V9L
M86=`"F=L:6)C>'A?8V]M<&EL97)?<VAA<F5D7V9L86<@/2!`9VQI8F-X>%]C
M;VUP:6QE<E]S:&%R961?9FQA9T`*9VQI8F-X>%]C>'@Y.%]A8FD@/2!`9VQI
M8F-X>%]C>'@Y.%]A8FE`"F=L:6)C>'A?;&]C86QE9&ER(#T@0&=L:6)C>'A?
M;&]C86QE9&ER0`IG;&EB8WAX7VQT7W!I8U]F;&%G(#T@0&=L:6)C>'A?;'1?
M<&EC7V9L86=`"F=L:6)C>'A?<')E9FEX9&ER(#T@0&=L:6)C>'A?<')E9FEX
M9&ER0`IG;&EB8WAX7W-R8V1I<B`]($!G;&EB8WAX7W-R8V1I<D`*9VQI8F-X
M>%]T;V]L97AE8V1I<B`]($!G;&EB8WAX7W1O;VQE>&5C9&ER0`IG;&EB8WAX
M7W1O;VQE>&5C;&EB9&ER(#T@0&=L:6)C>'A?=&]O;&5X96-L:6)D:7)`"F=X
M>%]I;F-L=61E7V1I<B`]($!G>'A?:6YC;'5D95]D:7)`"FAO<W0@/2!`:&]S
M=$`*:&]S=%]A;&EA<R`]($!H;W-T7V%L:6%S0`IH;W-T7V-P=2`]($!H;W-T
M7V-P=4`*:&]S=%]O<R`]($!H;W-T7V]S0`IH;W-T7W9E;F1O<B`]($!H;W-T
M7W9E;F1O<D`*:'1M;&1I<B`]($!H=&UL9&ER0`II;F-L=61E9&ER(#T@0&EN
M8VQU9&5D:7)`"FEN9F]D:7(@/2!`:6YF;V1I<D`*:6YS=&%L;%]S:"`]($!I
M;G-T86QL7W-H0`IL:6)D:7(@/2!`;&EB9&ER0`IL:6)E>&5C9&ER(#T@0&QI
M8F5X96-D:7)`"FQI8G1O;VQ?5D524TE/3B`]($!L:6)T;V]L7U9%4E-)3TY`
M"FQO8V%L961I<B`]($!L;V-A;&5D:7)`"FQO8V%L<W1A=&5D:7(@/2!`;&]C
M86QS=&%T961I<D`*;'1?:&]S=%]F;&%G<R`]($!L=%]H;W-T7V9L86=S0`IM
M86YD:7(@/2!`;6%N9&ER0`IM:V1I<E]P(#T@0&UK9&ER7W!`"FUU;'1I7V)A
M<V5D:7(@/2!`;75L=&E?8F%S961I<D`*;VQD:6YC;'5D961I<B`]($!O;&1I
M;F-L=61E9&ER0`IP9&9D:7(@/2!`<&1F9&ER0`IP;W)T7W-P96-I9FEC7W-Y
M;6)O;%]F:6QE<R`]($!P;W)T7W-P96-I9FEC7W-Y;6)O;%]F:6QE<T`*<')E
M9FEX(#T@0'!R969I>$`*<')O9W)A;5]T<F%N<V9O<FU?;F%M92`]($!P<F]G
M<F%M7W1R86YS9F]R;5]N86UE0`IP<V1I<B`]($!P<V1I<D`*<'ET:&]N7VUO
M9%]D:7(@/2!`<'ET:&]N7VUO9%]D:7)`"G-B:6YD:7(@/2!`<V)I;F1I<D`*
M<VAA<F5D<W1A=&5D:7(@/2!`<VAA<F5D<W1A=&5D:7)`"G-R8V1I<B`]($!S
M<F-D:7)`"G-Y<V-O;F9D:7(@/2!`<WES8V]N9F1I<D`*=&%R9V5T(#T@0'1A
M<F=E=$`*=&%R9V5T7V%L:6%S(#T@0'1A<F=E=%]A;&EA<T`*=&%R9V5T7V-P
M=2`]($!T87)G971?8W!U0`IT87)G971?;W,@/2!`=&%R9V5T7V]S0`IT87)G
M971?=F5N9&]R(#T@0'1A<F=E=%]V96YD;W)`"G1H<F5A9%]H96%D97(@/2!`
M=&AR96%D7VAE861E<D`*=&]P7V)U:6QD7W!R969I>"`]($!T;W!?8G5I;&1?
M<')E9FEX0`IT;W!?8G5I;&1D:7(@/2!`=&]P7V)U:6QD9&ER0`IT;W!?<W)C
M9&ER(#T@0'1O<%]S<F-D:7)`"G1O<&QE=F5L7V)U:6QD9&ER(#T@0'1O<&QE
M=F5L7V)U:6QD9&ER0`IT;W!L979E;%]S<F-D:7(@/2!`=&]P;&5V96Q?<W)C
M9&ER0`H*(R!-87D@8F4@=7-E9"!B>2!V87)I;W5S('-U8G-T:71U=&EO;B!V
M87)I86)L97,N"F=C8U]V97)S:6]N(#H]("0H<VAE;&P@0&=E=%]G8V-?8F%S
M95]V97)`("0H=&]P7W-R8V1I<BDO+BXO9V-C+T)!4T4M5D52*0I-04E.5%]#
M2$%24T54(#T@;&%T:6XQ"FUK:6YS=&%L;&1I<G,@/2`D*%-(14Q,*2`D*'1O
M<&QE=F5L7W-R8V1I<BDO;6MI;G-T86QL9&ER<PI05T1?0T]-34%.1"`]("0D
M>U!71$--1"UP=V1]"E-404U0(#T@96-H;R!T:6UE<W1A;7`@/@IT;V]L97AE
M8V1I<B`]("0H9VQI8F-X>%]T;V]L97AE8V1I<BD*=&]O;&5X96-L:6)D:7(@
M/2`D*&=L:6)C>'A?=&]O;&5X96-L:6)D:7(I"D!%3D%"3$5?5T524D]27T9!
M3%-%0%=%4E)/4E]&3$%'(#T@"D!%3D%"3$5?5T524D]27U12545`5T524D]2
M7T9,04<@/2`M5V5R<F]R"D!%3D%"3$5?15A415).7U1%35!,051%7T9!3%-%
M0%A414U03$%415]&3$%'4R`](`I`14Y!0DQ%7T585$523E]414U03$%415]4
M4E5%0%A414U03$%415]&3$%'4R`]("UF;F\M:6UP;&EC:70M=&5M<&QA=&5S
M"@HC(%1H97-E(&)I=',@87)E(&%L;"!F:6=U<F5D(&]U="!F<F]M(&-O;F9I
M9W5R92X@($QO;VL@:6X@86-I;F-L=61E+FTT"B,@;W(@8V]N9FEG=7)E+F%C
M('1O('-E92!H;W<@=&AE>2!A<F4@<V5T+B`@4V5E($=,24)#6%A?15A03U)4
M7T9,04=3+@I#3TY&24=?0UA81DQ!1U,@/2!<"@DD*%-%0U1)3TY?1DQ!1U,I
M("0H2%=#05!?0T9,04=3*2`M9G)A;F1O;2US965D/21`"@I705).7T-86$9,
M04=3(#T@7`H))"A705).7T9,04=3*2`D*%=%4E)/4E]&3$%'*2`M9F1I86=N
M;W-T:6-S+7-H;W<M;&]C871I;VX];VYC92`*"@HC("U)+RU$(&9L86=S('1O
M('!A<W,@=VAE;B!C;VUP:6QI;F<N"D%-7T-04$9,04=3(#T@)"A'3$E"0UA8
M7TE.0TQ51$53*2`D*$-04$9,04=3*0I`14Y!0DQ%7U!95$A/3D1)4E]&04Q3
M14!P>71H;VYD:7(@/2`D*&1A=&%D:7(I+V=C8RTD*&=C8U]V97)S:6]N*2]P
M>71H;VX*0$5.04),15]0651(3TY$25)?5%)514!P>71H;VYD:7(@/2`D*'!R
M969I>"DO)"AP>71H;VY?;6]D7V1I<BD*;F]B87-E7W!Y=&AO;E]$051!(#T@
M7`H@("`@;&EB<W1D8WAX+W8V+W!R:6YT97)S+G!Y(%P*("`@(&QI8G-T9&-X
M>"]V-B]X;65T:&]D<RYP>2!<"B`@("!L:6)S=&1C>'@O=C8O7U]I;FET7U\N
M<'D@7`H@("`@;&EB<W1D8WAX+U]?:6YI=%]?+G!Y"@IA;&PZ(&%L;"UA;0H*
M+E-51D9)6$53.@HD*'-R8V1I<BDO36%K969I;&4N:6XZ($!-04E.5$%)3D52
M7TU/1$5?5%)514`@)"AS<F-D:7(I+TUA:V5F:6QE+F%M("0H=&]P7W-R8V1I
M<BDO9G)A9VUE;G0N86T@)"AA;5]?8V]N9FEG=7)E7V1E<',I"@E`9F]R(&1E
M<"!I;B`D/SL@9&\@7`H)("!C87-E("<D*&%M7U]C;VYF:6=U<F5?9&5P<RDG
M(&EN(%P*"2`@("`J)"1D97`J*2!<"@D@("`@("`H(&-D("0H=&]P7V)U:6QD
M9&ER*2`F)B`D*$U!2T4I("0H04U?34%+149,04=3*2!A;2TM<F5F<F5S:"`I
M(%P*"2`@("`@("`@)B8@>R!I9B!T97-T("UF("1`.R!T:&5N(&5X:70@,#L@
M96QS92!B<F5A:SL@9FD[('T[(%P*"2`@("`@(&5X:70@,3L[(%P*"2`@97-A
M8SL@7`H)9&]N93L@7`H)96-H;R`G(&-D("0H=&]P7W-R8V1I<BD@)B8@)"A!
M551/34%+12D@+2UF;W)E:6=N("TM:6=N;W)E+61E<',@<'ET:&]N+TUA:V5F
M:6QE)SL@7`H))"AA;5]?8V0I("0H=&]P7W-R8V1I<BD@)B8@7`H)("`D*$%5
M5$]-04M%*2`M+69O<F5I9VX@+2UI9VYO<F4M9&5P<R!P>71H;VXO36%K969I
M;&4*36%K969I;&4Z("0H<W)C9&ER*2]-86ME9FEL92YI;B`D*'1O<%]B=6EL
M9&1I<BDO8V]N9FEG+G-T871U<PH)0&-A<V4@)R0_)R!I;B!<"@D@("IC;VYF
M:6<N<W1A='5S*BD@7`H)("`@(&-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*$U!
M2T4I("0H04U?34%+149,04=3*2!A;2TM<F5F<F5S:#L[(%P*"2`@*BD@7`H)
M("`@(&5C:&\@)R!C9"`D*'1O<%]B=6EL9&1I<BD@)B8@)"A32$5,3"D@+B]C
M;VYF:6<N<W1A='5S("0H<W5B9&ER*2\D0"`D*&%M7U]D97!F:6QE<U]M87EB
M92DG.R!<"@D@("`@8V0@)"AT;W!?8G5I;&1D:7(I("8F("0H4TA%3$PI("XO
M8V]N9FEG+G-T871U<R`D*'-U8F1I<BDO)$`@)"AA;5]?9&5P9FEL97-?;6%Y
M8F4I.SL@7`H)97-A8SL*)"AT;W!?<W)C9&ER*2]F<F%G;65N="YA;2`D*&%M
M7U]E;7!T>2DZ"@HD*'1O<%]B=6EL9&1I<BDO8V]N9FEG+G-T871U<SH@)"AT
M;W!?<W)C9&ER*2]C;VYF:6=U<F4@)"A#3TY&24=?4U1!5%537T1%4$5.1$5.
M0TE%4RD*"6-D("0H=&]P7V)U:6QD9&ER*2`F)B`D*$U!2T4I("0H04U?34%+
M149,04=3*2!A;2TM<F5F<F5S:`H*)"AT;W!?<W)C9&ER*2]C;VYF:6=U<F4Z
M($!-04E.5$%)3D527TU/1$5?5%)514`@)"AA;5]?8V]N9FEG=7)E7V1E<',I
M"@EC9"`D*'1O<%]B=6EL9&1I<BD@)B8@)"A-04M%*2`D*$%-7TU!2T5&3$%'
M4RD@86TM+7)E9G)E<V@*)"A!0TQ/0T%,7TTT*3H@0$U!24Y404E.15)?34]$
M15]44E5%0"`D*&%M7U]A8VQO8V%L7VTT7V1E<',I"@EC9"`D*'1O<%]B=6EL
M9&1I<BD@)B8@)"A-04M%*2`D*$%-7TU!2T5&3$%'4RD@86TM+7)E9G)E<V@*
M)"AA;5]?86-L;V-A;%]M-%]D97!S*3H*"FUO<W1L>6-L96%N+6QI8G1O;VPZ
M"@DM<FT@+68@*BYL;PH*8VQE86XM;&EB=&]O;#H*"2UR;2`M<F8@+FQI8G,@
M7VQI8G,*:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%403H@)"AN;V)A<V5?<'ET
M:&]N7T1!5$$I"@E`)"A.3U)-04Q?24Y35$%,3"D*"4!L:7-T/2<D*&YO8F%S
M95]P>71H;VY?1$%402DG.R!T97-T("UN("(D*'!Y=&AO;F1I<BDB('Q\(&QI
M<W0].R!<"@EI9B!T97-T("UN("(D)&QI<W0B.R!T:&5N(%P*"2`@96-H;R`B
M("0H34M$25)?4"D@)R0H1$535$1)4BDD*'!Y=&AO;F1I<BDG(CL@7`H)("`D
M*$U+1$E27U`I("(D*$1%4U1$25(I)"AP>71H;VYD:7(I(B!\?"!E>&ET(#$[
M(%P*"69I.R!<"@DD*&%M7U]N;V)A<V5?;&ES="D@?"!W:&EL92!R96%D(&1I
M<B!F:6QE<SL@9&\@7`H)("!X9FEL97,].R!F;W(@9FEL92!I;B`D)&9I;&5S
M.R!D;R!<"@D@("`@:68@=&5S="`M9B`B)"1F:6QE(CL@=&AE;B!X9FEL97,]
M(B0D>&9I;&5S("0D9FEL92([(%P*"2`@("!E;'-E('AF:6QE<STB)"1X9FEL
M97,@)"AS<F-D:7(I+R0D9FEL92([(&9I.R!D;VYE.R!<"@D@('1E<W0@+7H@
M(B0D>&9I;&5S(B!\?"![(%P*"2`@("!T97-T(")X)"1D:7(B(#T@>"X@?'P@
M>R!<"@D@("`@("!E8VAO("(@)"A-2T1)4E]0*2`G)"A$15-41$E2*20H<'ET
M:&]N9&ER*2\D)&1I<B<B.R!<"@D@("`@("`D*$U+1$E27U`I("(D*$1%4U1$
M25(I)"AP>71H;VYD:7(I+R0D9&ER(CL@?3L@7`H)("`@(&5C:&\@(B`D*$E.
M4U1!3$Q?1$%402D@)"1X9FEL97,@)R0H1$535$1)4BDD*'!Y=&AO;F1I<BDO
M)"1D:7(G(CL@7`H)("`@("0H24Y35$%,3%]$051!*2`D)'AF:6QE<R`B)"A$
M15-41$E2*20H<'ET:&]N9&ER*2\D)&1I<B(@?'P@97AI="`D)#\[('T[(%P*
M"61O;F4*"G5N:6YS=&%L;"UN;V)A<V5?<'ET:&]N1$%403H*"4`D*$Y/4DU!
M3%]53DE.4U1!3$PI"@E`;&ES=#TG)"AN;V)A<V5?<'ET:&]N7T1!5$$I)SL@
M=&5S="`M;B`B)"AP>71H;VYD:7(I(B!\?"!L:7-T/3L@7`H))"AA;5]?;F]B
M87-E7W-T<FEP7W-E='5P*3L@9FEL97,]8"0H86U?7VYO8F%S95]S=')I<"E@
M.R!<"@ED:7(])R0H1$535$1)4BDD*'!Y=&AO;F1I<BDG.R`D*&%M7U]U;FEN
M<W1A;&Q?9FEL97-?9G)O;5]D:7(I"G1A9W,@5$%'4SH*"F-T86=S($-404=3
M.@H*8W-C;W!E(&-S8V]P96QI<W0Z"@IC:&5C:RUA;3H@86QL+6%M"F-H96-K
M.B!C:&5C:RUA;0IA;&PM86TZ($UA:V5F:6QE("0H1$%402D@86QL+6QO8V%L
M"FEN<W1A;&QD:7)S.@H)9F]R(&1I<B!I;B`B)"A$15-41$E2*20H<'ET:&]N
M9&ER*2([(&1O(%P*"2`@=&5S="`M>B`B)"1D:7(B('Q\("0H34M$25)?4"D@
M(B0D9&ER(CL@7`H)9&]N90II;G-T86QL.B!I;G-T86QL+6%M"FEN<W1A;&PM
M97AE8SH@:6YS=&%L;"UE>&5C+6%M"FEN<W1A;&PM9&%T83H@:6YS=&%L;"UD
M871A+6%M"G5N:6YS=&%L;#H@=6YI;G-T86QL+6%M"@II;G-T86QL+6%M.B!A
M;&PM86T*"4`D*$U!2T4I("0H04U?34%+149,04=3*2!I;G-T86QL+65X96,M
M86T@:6YS=&%L;"UD871A+6%M"@II;G-T86QL8VAE8VLZ(&EN<W1A;&QC:&5C
M:RUA;0II;G-T86QL+7-T<FEP.@H):68@=&5S="`M>B`G)"A35%))4"DG.R!T
M:&5N(%P*"2`@)"A-04M%*2`D*$%-7TU!2T5&3$%'4RD@24Y35$%,3%]04D]'
M4D%-/2(D*$E.4U1!3$Q?4U1225!?4%)/1U)!32DB(%P*"2`@("!I;G-T86QL
M7W-H7U!23T=204T](B0H24Y35$%,3%]35%))4%]04D]'4D%-*2(@24Y35$%,
M3%]35%))4%]&3$%'/2US(%P*"2`@("`@(&EN<W1A;&P[(%P*"65L<V4@7`H)
M("`D*$U!2T4I("0H04U?34%+149,04=3*2!)3E-404Q,7U!23T=204T](B0H
M24Y35$%,3%]35%))4%]04D]'4D%-*2(@7`H)("`@(&EN<W1A;&Q?<VA?4%)/
M1U)!33TB)"A)3E-404Q,7U-44DE07U!23T=204TI(B!)3E-404Q,7U-44DE0
M7T9,04<]+7,@7`H)("`@("))3E-404Q,7U!23T=204U?14Y6/5-44DE04%)/
M1STG)"A35%))4"DG(B!I;G-T86QL.R!<"@EF:0IM;W-T;'EC;&5A;BUG96YE
M<FEC.@H*8VQE86XM9V5N97)I8SH*"F1I<W1C;&5A;BUG96YE<FEC.@H)+71E
M<W0@+7H@(B0H0T].1DE'7T-,14%.7T9)3$53*2(@?'P@<FT@+68@)"A#3TY&
M24=?0TQ%04Y?1DE,15,I"@DM=&5S="`N(#T@(B0H<W)C9&ER*2(@?'P@=&5S
M="`M>B`B)"A#3TY&24=?0TQ%04Y?5E!!5$A?1DE,15,I(B!\?"!R;2`M9B`D
M*$-/3D9)1U]#3$5!3E]64$%42%]&24Q%4RD*"FUA:6YT86EN97(M8VQE86XM
M9V5N97)I8SH*"4!E8VAO(")4:&ES(&-O;6UA;F0@:7,@:6YT96YD960@9F]R
M(&UA:6YT86EN97)S('1O('5S92(*"4!E8VAO(")I="!D96QE=&5S(&9I;&5S
M('1H870@;6%Y(')E<75I<F4@<W!E8VEA;"!T;V]L<R!T;R!R96)U:6QD+B(*
M8VQE86XZ(&-L96%N+6%M"@IC;&5A;BUA;3H@8VQE86XM9V5N97)I8R!C;&5A
M;BUL:6)T;V]L(&UO<W1L>6-L96%N+6%M"@ID:7-T8VQE86XZ(&1I<W1C;&5A
M;BUA;0H)+7)M("UF($UA:V5F:6QE"F1I<W1C;&5A;BUA;3H@8VQE86XM86T@
M9&ES=&-L96%N+6=E;F5R:6,*"F1V:3H@9'9I+6%M"@ID=FDM86TZ"@IH=&UL
M.B!H=&UL+6%M"@IH=&UL+6%M.@H*:6YF;SH@:6YF;RUA;0H*:6YF;RUA;3H*
M"FEN<W1A;&PM9&%T82UA;3H@:6YS=&%L;"UD871A+6QO8V%L(&EN<W1A;&PM
M;F]B87-E7W!Y=&AO;D1!5$$*"FEN<W1A;&PM9'9I.B!I;G-T86QL+61V:2UA
M;0H*:6YS=&%L;"UD=FDM86TZ"@II;G-T86QL+65X96,M86TZ"@II;G-T86QL
M+6AT;6PZ(&EN<W1A;&PM:'1M;"UA;0H*:6YS=&%L;"UH=&UL+6%M.@H*:6YS
M=&%L;"UI;F9O.B!I;G-T86QL+6EN9F\M86T*"FEN<W1A;&PM:6YF;RUA;3H*
M"FEN<W1A;&PM;6%N.@H*:6YS=&%L;"UP9&8Z(&EN<W1A;&PM<&1F+6%M"@II
M;G-T86QL+7!D9BUA;3H*"FEN<W1A;&PM<',Z(&EN<W1A;&PM<',M86T*"FEN
M<W1A;&PM<',M86TZ"@II;G-T86QL8VAE8VLM86TZ"@IM86EN=&%I;F5R+6-L
M96%N.B!M86EN=&%I;F5R+6-L96%N+6%M"@DM<FT@+68@36%K969I;&4*;6%I
M;G1A:6YE<BUC;&5A;BUA;3H@9&ES=&-L96%N+6%M(&UA:6YT86EN97(M8VQE
M86XM9V5N97)I8PH*;6]S=&QY8VQE86XZ(&UO<W1L>6-L96%N+6%M"@IM;W-T
M;'EC;&5A;BUA;3H@;6]S=&QY8VQE86XM9V5N97)I8R!M;W-T;'EC;&5A;BUL
M:6)T;V]L"@IP9&8Z('!D9BUA;0H*<&1F+6%M.@H*<',Z('!S+6%M"@IP<RUA
M;3H*"G5N:6YS=&%L;"UA;3H@=6YI;G-T86QL+6YO8F%S95]P>71H;VY$051!
M"@HN34%+13H@:6YS=&%L;"UA;2!I;G-T86QL+7-T<FEP"@HN4$A/3EDZ(&%L
M;"!A;&PM86T@86QL+6QO8V%L(&-H96-K(&-H96-K+6%M(&-L96%N(&-L96%N
M+6=E;F5R:6,@7`H)8VQE86XM;&EB=&]O;"!C<V-O<&5L:7-T+6%M(&-T86=S
M+6%M(&1I<W1C;&5A;B!<"@ED:7-T8VQE86XM9V5N97)I8R!D:7-T8VQE86XM
M;&EB=&]O;"!D=FD@9'9I+6%M(&AT;6P@:'1M;"UA;2!<"@EI;F9O(&EN9F\M
M86T@:6YS=&%L;"!I;G-T86QL+6%M(&EN<W1A;&PM9&%T82!I;G-T86QL+61A
M=&$M86T@7`H):6YS=&%L;"UD871A+6QO8V%L(&EN<W1A;&PM9'9I(&EN<W1A
M;&PM9'9I+6%M(&EN<W1A;&PM97AE8R!<"@EI;G-T86QL+65X96,M86T@:6YS
M=&%L;"UH=&UL(&EN<W1A;&PM:'1M;"UA;2!I;G-T86QL+6EN9F\@7`H):6YS
M=&%L;"UI;F9O+6%M(&EN<W1A;&PM;6%N(&EN<W1A;&PM;F]B87-E7W!Y=&AO
M;D1!5$$@7`H):6YS=&%L;"UP9&8@:6YS=&%L;"UP9&8M86T@:6YS=&%L;"UP
M<R!I;G-T86QL+7!S+6%M(%P*"6EN<W1A;&PM<W1R:7`@:6YS=&%L;&-H96-K
M(&EN<W1A;&QC:&5C:RUA;2!I;G-T86QL9&ER<R!<"@EM86EN=&%I;F5R+6-L
M96%N(&UA:6YT86EN97(M8VQE86XM9V5N97)I8R!M;W-T;'EC;&5A;B!<"@EM
M;W-T;'EC;&5A;BUG96YE<FEC(&UO<W1L>6-L96%N+6QI8G1O;VP@<&1F('!D
M9BUA;2!P<R!P<RUA;2!<"@ET86=S+6%M('5N:6YS=&%L;"!U;FEN<W1A;&PM
M86T@=6YI;G-T86QL+6YO8F%S95]P>71H;VY$051!"@HN4%)%0TE/55,Z($UA
M:V5F:6QE"@H*86QL+6QO8V%L.B!G9&(N<'D*"F=D8BYP>3H@:&]O:RYI;B!-
M86ME9FEL90H)<V5D("UE("=S+$!P>71H;VYD:7)`+"0H<'ET:&]N9&ER*2PG
M(%P*"2`@("`M92`G<RQ`=&]O;&5X96-L:6)D:7)`+"0H=&]O;&5X96-L:6)D
M:7(I+"<@/"`D*'-R8V1I<BDO:&]O:RYI;B`^("1`"@II;G-T86QL+61A=&$M
M;&]C86PZ(&=D8BYP>0H)0"0H;6MD:7)?<"D@)"A$15-41$E2*20H=&]O;&5X
M96-L:6)D:7(I"@E`:&5R93U@<'=D8#L@8V0@)"A$15-41$E2*20H=&]O;&5X
M96-L:6)D:7(I.R!<"@D@(&9O<B!F:6QE(&EN(&QI8G-T9&,K*RXJ.R!D;R!<
M"@D@("`@8V%S92`D)&9I;&4@:6X@7`H)("`@("`@*BUG9&(N<'DI(#L[(%P*
M"2`@("`@("HN;&$I(#L[(%P*"2`@("`@("HI(&EF('1E<W0@+6@@)"1F:6QE
M.R!T:&5N(%P*"2`@("`@("`@("`@8V]N=&EN=64[(%P*"2`@("`@("`@(&9I
M.R!<"@D@("`@("`@("!L:6)N86UE/20D9FEL93L[(%P*"2`@("!E<V%C.R!<
M"@D@(&1O;F4[(%P*"6-D("0D:&5R93L@7`H)96-H;R`B("0H24Y35$%,3%]$
M051!*2!G9&(N<'D@)"A$15-41$E2*20H=&]O;&5X96-L:6)D:7(I+R0D;&EB
M;F%M92UG9&(N<'DB.R!<"@DD*$E.4U1!3$Q?1$%402D@9V1B+G!Y("0H1$53
M5$1)4BDD*'1O;VQE>&5C;&EB9&ER*2\D)&QI8FYA;64M9V1B+G!Y"@HC(%1E
M;&P@=F5R<VEO;G,@6S,N-3DL,RXV,RD@;V8@1TY5(&UA:V4@=&\@;F]T(&5X
M<&]R="!A;&P@=F%R:6%B;&5S+@HC($]T:&5R=VES92!A('-Y<W1E;2!L:6UI
M="`H9F]R(%-Y<U8@870@;&5A<W0I(&UA>2!B92!E>&-E961E9"X*+DY/15A0
M3U)4.@H`````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````+B]P>71H;VXO:&]O:RYI;@``````````````````````````
M````````````````````````````````````````````````````````````
M`````````````````````````#`P,#`V-#0`,#`P,C`P,@`P,#`P,30T`#`P
M,#`P,#`T-3`P`#$S-3<Q-#$P,C,P`#`Q,S,U,``@,```````````````````
M````````````````````````````````````````````````````````````
M``````````````````````````````````````````````````````!U<W1A
M<B`@`&9J87)D;VX`````````````````````````````````=7-E<G,`````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M```````````````````````````````````C("TJ+2!P>71H;VX@+2HM"B,@
M0V]P>7)I9VAT("A#*2`R,#`Y+3(P,3D@1G)E92!3;V9T=V%R92!&;W5N9&%T
M:6]N+"!);F,N"@HC(%1H:7,@<')O9W)A;2!I<R!F<F5E('-O9G1W87)E.R!Y
M;W4@8V%N(')E9&ES=')I8G5T92!I="!A;F0O;W(@;6]D:69Y"B,@:70@=6YD
M97(@=&AE('1E<FUS(&]F('1H92!'3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS
M92!A<R!P=6)L:7-H960@8GD*(R!T:&4@1G)E92!3;V9T=V%R92!&;W5N9&%T
M:6]N.R!E:71H97(@=F5R<VEO;B`S(&]F('1H92!,:6-E;G-E+"!O<@HC("AA
M="!Y;W5R(&]P=&EO;BD@86YY(&QA=&5R('9E<G-I;VXN"B,*(R!4:&ES('!R
M;V=R86T@:7,@9&ES=')I8G5T960@:6X@=&AE(&AO<&4@=&AA="!I="!W:6QL
M(&)E('5S969U;"P*(R!B=70@5TE42$]55"!!3ED@5T%24D%.5%D[('=I=&AO
M=70@979E;B!T:&4@:6UP;&EE9"!W87)R86YT>2!O9@HC($U%4D-(04Y404))
M3$E462!O<B!&251.15-3($9/4B!!(%!!4E1)0U5,05(@4%524$]312X@(%-E
M92!T:&4*(R!'3E4@1V5N97)A;"!0=6)L:6,@3&EC96YS92!F;W(@;6]R92!D
M971A:6QS+@HC"B,@66]U('-H;W5L9"!H879E(')E8V5I=F5D(&$@8V]P>2!O
M9B!T:&4@1TY5($=E;F5R86P@4'5B;&EC($QI8V5N<V4*(R!A;&]N9R!W:71H
M('1H:7,@<')O9W)A;2X@($EF(&YO="P@<V5E(#QH='1P.B\O=W=W+F=N=2YO
M<F<O;&EC96YS97,O/BX*"FEM<&]R="!S>7,*:6UP;W)T(&=D8@II;7!O<G0@
M;W,*:6UP;W)T(&]S+G!A=&@*"G!Y=&AO;F1I<B`]("=`<'ET:&]N9&ER0"<*
M;&EB9&ER(#T@)T!T;V]L97AE8VQI8F1I<D`G"@HC(%1H:7,@9FEL92!M:6=H
M="!B92!L;V%D960@=VAE;B!T:&5R92!I<R!N;R!C=7)R96YT(&]B:F9I;&4N
M("!4:&ES"B,@8V%N(&AA<'!E;B!I9B!T:&4@=7-E<B!L;V%D<R!I="!M86YU
M86QL>2X@($EN('1H:7,@8V%S92!W92!D;VXG=`HC('5P9&%T92!S>7,N<&%T
M:#L@:6YS=&5A9"!W92!J=7-T(&AO<&4@=&AE('5S97(@;6%N86=E9"!T;R!D
M;R!T:&%T"B,@8F5F;W)E:&%N9"X*:68@9V1B+F-U<G)E;G1?;V)J9FEL92`H
M*2!I<R!N;W0@3F]N93H*("`@(",@57!D871E(&UO9'5L92!P871H+B`@5V4@
M=V%N="!T;R!F:6YD('1H92!R96QA=&EV92!P871H(&9R;VT@;&EB9&ER"B`@
M("`C('1O('!Y=&AO;F1I<BP@86YD('1H96X@=V4@=V%N="!T;R!A<'!L>2!T
M:&%T(')E;&%T:79E('!A=&@@=&\@=&AE"B`@("`C(&1I<F5C=&]R>2!H;VQD
M:6YG('1H92!O8FIF:6QE('=I=&@@=VAI8V@@=&AI<R!F:6QE(&ES(&%S<V]C
M:6%T960N"B`@("`C(%1H:7,@<')E<V5R=F5S(')E;&]C871A8FEL:71Y(&]F
M('1H92!G8V,@=')E92X*"B`@("`C($1O(&$@<VEM<&QE(&YO<FUA;&EZ871I
M;VX@=&AA="!R96UO=F5S(&1U<&QI8V%T92!S97!A<F%T;W)S+@H@("`@<'ET
M:&]N9&ER(#T@;W,N<&%T:"YN;W)M<&%T:"`H<'ET:&]N9&ER*0H@("`@;&EB
M9&ER(#T@;W,N<&%T:"YN;W)M<&%T:"`H;&EB9&ER*0H*("`@('!R969I>"`]
M(&]S+G!A=&@N8V]M;6]N<')E9FEX("A;;&EB9&ER+"!P>71H;VYD:7)=*0H@
M("`@(R!);B!S;VUE(&)I>F%R<F4@8V]N9FEG=7)A=&EO;B!W92!M:6=H="!H
M879E(&9O=6YD(&$@;6%T8V@@:6X@=&AE"B`@("`C(&UI9&1L92!O9B!A(&1I
M<F5C=&]R>2!N86UE+@H@("`@:68@<')E9FEX6RTQ72`A/2`G+R<Z"B`@("`@
M("`@<')E9FEX(#T@;W,N<&%T:"YD:7)N86UE("AP<F5F:7@I("L@)R\G"@H@
M("`@(R!3=')I<"!O9F8@=&AE('!R969I>"X*("`@('!Y=&AO;F1I<B`]('!Y
M=&AO;F1I<EML96X@*'!R969I>"DZ70H@("`@;&EB9&ER(#T@;&EB9&ER6VQE
M;B`H<')E9FEX*3I="@H@("`@(R!#;VUP=71E('1H92`B+BXB<R!N965D960@
M=&\@9V5T(&9R;VT@;&EB9&ER('1O('1H92!P<F5F:7@N"B`@("!D;W1D;W1S
M(#T@*"<N+B<@*R!O<RYS97`I("H@;&5N("AL:6)D:7(N<W!L:70@*&]S+G-E
M<"DI"@H@("`@;V)J9FEL92`](&=D8BYC=7)R96YT7V]B:F9I;&4@*"DN9FEL
M96YA;64*("`@(&1I<E\@/2!O<RYP871H+FIO:6X@*&]S+G!A=&@N9&ER;F%M
M92`H;V)J9FEL92DL(&1O=&1O=',L('!Y=&AO;F1I<BD*"B`@("!I9B!N;W0@
M9&ER7R!I;B!S>7,N<&%T:#H*("`@("`@("!S>7,N<&%T:"YI;G-E<G0H,"P@
M9&ER7RD*"B,@0V%L;"!A(&9U;F-T:6]N(&%S(&$@<&QA:6X@:6UP;W)T('=O
M=6QD(&YO="!E>&5C=71E(&)O9'D@;V8@=&AE(&EN8VQU9&5D(&9I;&4*(R!O
M;B!R97!E871E9"!R96QO861S(&]F('1H:7,@;V)J96-T(&9I;&4N"F9R;VT@
M;&EB<W1D8WAX+G8V(&EM<&]R="!R96=I<W1E<E]L:6)S=&1C>'A?<')I;G1E
M<G,*<F5G:7-T97)?;&EB<W1D8WAX7W!R:6YT97)S*&=D8BYC=7)R96YT7V]B
M:F9I;&4H*2D*````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````+B]P>71H;VXO36%K969I;&4N86T`````
M````````````````````````````````````````````````````````````
M`````````````````````````````````````````#`P,#`V-#0`,#`P,C`P
M,@`P,#`P,30T`#`P,#`P,#`T,S,W`#$S-3<Q-#$P,C,P`#`Q-#$R-``@,```
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M``````````!U<W1A<B`@`&9J87)D;VX`````````````````````````````
M````=7-E<G,`````````````````````````````````````````````````
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
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
M````````````````````````````````````````````````````````````
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
  (set 20 19 12 03 08 36 56 'share-gdb.tar'
   eval "${shar_touch}") && \
  chmod 0644 'share-gdb.tar'
if test $? -ne 0
then ${echo} "restore of share-gdb.tar failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'share-gdb.tar': 'MD5 check failed'
       ) << \SHAR_EOF
b3a832b900ac78af52ab8d30f327ae1b  share-gdb.tar
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
  (set 20 19 12 03 08 36 57 'apt-cyg'
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
  (set 20 19 12 03 08 36 58 'byzanz-helper.1'
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
  (set 20 19 12 03 08 36 59 'codefmt.1'
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
  (set 20 19 12 03 08 36 59 'codemv.1'
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
  (set 20 19 12 03 08 37 00 'ffmpeg-helper.1'
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
  (set 20 19 12 03 08 37 01 'hyper-v.1'
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
X.TH MSVC-SHELL 1 "2019-12-02" "github.com/fjardon/unix-config" "FJ Unix Config Commands"
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
  (set 20 19 12 03 08 37 02 'msvc-shell.1'
   eval "${shar_touch}") && \
  chmod 0644 'msvc-shell.1'
if test $? -ne 0
then ${echo} "restore of msvc-shell.1 failed"
fi
  if ${md5check}
  then (
       ${MD5SUM} -c >/dev/null 2>&1 || ${echo} 'msvc-shell.1': 'MD5 check failed'
       ) << \SHAR_EOF
1240e4baad8d244592e6eb741031c815  msvc-shell.1
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
  (set 20 19 12 03 08 37 03 'sixel2tmux.1'
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
  (set 20 19 12 03 08 37 04 'yank.1'
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

# Ruby
if [ -e "${PREFIX}/.gemrc" ]; then
    cp -f "${PREFIX}/.gemrc" "${BACKUPDIR}"
fi
install -m 0644 dot_gemrc "${PREFIX}/.gemrc"

# XWindow
echo "XWindow ..."
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
        curl -O 'https://raw.githubusercontent.com/ryanoasis/nerd-fonts/2.0.0/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf' \
            > install.log 2>&1
        mv 'DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete.ttf' 'DejaVu Sans Mono Nerd Font Complete.ttf'
        install -m 0644 'DejaVu Sans Mono Nerd Font Complete.ttf' "${PREFIX}/.local/share/fonts/nerd-fonts/"
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

