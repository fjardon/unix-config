IBASE="${HOME}/.local/share/ibase"
export IBASE

PATH="${PATH}:${IBASE}/bin"
export PATH

BOOM_MODEL=debug,st
export BOOM_MODEL

PERL5LIB="${PERL5LIB}${PERL5LIB:+:}${IBASE}/bin"
export PERL5LIB

