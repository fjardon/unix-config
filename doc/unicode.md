Unicode Support
===============

# General remarks

Some command line tools have support for unicode symbols (through utf8).
Eventually the responsibility to draw the unicode glyph falls down on the
graphical terminal emulator. `XTerm` has got very good utf8 support and can use
any _TrueType_ fonts. However installing the font in the `font-config` cache is
not enough under _Windows_. A _Windows_ user must also _unlock_ the font file
if the file was downloaded from internet, and install the font manually through
the configuration manager. The `font-config` name of the font is given by the
`fc-list` command. This is the name to give to `XTerm` through the
`-fa font-name` command line option or through the `.Xresources` settings.


# Iconic unicode glyphs

Patched fonts are fonts where some rarely used unicode codepoints are reassigned
to icons, such as those used by Material Design, bootstrap, and other web
framework. These unicode codepoint can then used in diverse terminal contexts,
like:

- PS1 to configure the shell prompt
- tmux status line
- vim status bar or file browser

## List of iconic unicode glyphs

| Symbol Name                                 | Hexadecimal Code | Example   |
| ---                                         | ---              | ---       |
| nf-pl-left\_hard\_divider                   | e0b0             |          |
| nf-pl-left\_soft\_divider                   | e0b1             |          |
| nf-pl-right\_hard\_divider                  | e0b2             |          |
| nf-pl-right\_soft\_divider                  | e0b3             |          |
| nf-ple-right\_half\_circle\_thick           | e0b4             |          |
| nf-ple-right\_half\_circle\_thin            | e0b5             |          |
| nf-ple-left\_half\_circle\_thick            | e0b6             |          |
| nf-ple-left\_half\_circle\_thin             | e0b7             |          |
| nf-ple-lower\_left\_triangle                | e0b8             |          |
| nf-ple-backslash\_separator                 | e0b9             |          |
| nf-ple-lower\_right\_triangle               | e0ba             |          |
| nf-ple-forwardslash\_separator              | e0bb             |          |
| nf-ple-upper\_left\_triangle                | e0bc             |          |
| nf-ple-upper\_right\_triangle               | e0be             |          |
| nf-ple-flame\_thick                         | e0c0             |          |
| nf-ple-flame\_thin                          | e0c1             |          |
| nf-ple-flame\_thick\_mirrored               | e0c2             |          |
| nf-ple-flame\_thin\_mirrored                | e0c3             |          |
| nf-ple-pixelated\_squares\_small            | e0c4             |          |
| nf-ple-pixelated\_squares\_small\_mirrored  | e0c5             |          |
| nf-ple-pixelated\_squares\_big              | e0c6             |          |
| nf-ple-pixelated\_squares\_big\_mirrored    | e0c7             |          |
| nf-ple-ice\_waveform                        | e0c8             |          |
| nf-ple-ice\_waveform\_mirrored              | e0ca             |          |
| nf-ple-honeycomb                            | e0cc             |          |
| nf-ple-honeycomb\_outline                   | e0cd             |          |
| nf-ple-trapezoid\_top\_bottom               | e0d2             |          |
| nf-ple-trapezoid\_top\_bottom\_mirrored     | e0d4             |          |
| nf-fa-television                            | f26c             |          |
| nf-fa-terminal                              | f120             |          |
| nf-fa-sitemap                               | f0e8             |          |
| nf-fa-sliders                               | f1de             |          |
| nf-fa-signal                                | f012             |          |
| nf-fa-send                                  | f1d8             |          |
| nf-fa-server                                | f233             |          |
| nf-fa-share                                 | f064             |          |
| nf-fa-shield                                | f132             |          |
| nf-fa-save                                  | f0c7             |          |
| nf-fa-repeat                                | f01e             |          |
| nf-fa-reply                                 | f112             |          |
| nf-fa-reply\_all                            | f122             |          |
| nf-fa-reorder                               | f0c9             |          |
| nf-fa-remove                                | f00d             |          |
| nf-fa-refresh                               | f021             |          |
| nf-fa-random                                | f074             |          |
| nf-fa-puzzle\_piece                         | f12e             |          |
| nf-fa-qrcode                                | f029             |          |
| nf-fa-photo                                 | f03e             |          |
| nf-fa-pie\_chart                            | f200             |          |
| nf-fa-microchip                             | f2db             |          |
| nf-fa-list                                  | f03a             |          |
| nf-fa-lock                                  | f023             |          |
| nf-fa-keyboard\_o                           | f11c             |          |
| nf-fa-inbox                                 | f01c             |          |
| nf-fa-id\_badge                             | f2c1             |          |
| nf-fa-id\_card                              | f2c2             |          |
| nf-fa-hdd\_o                                | f0a0             |          |
| nf-fa-home                                  | f015             |          |
| nf-fa-group                                 | f0c0             |          |
| nf-fa-git                                   | f1d3             |          |
| nf-fa-gear                                  | f013             |          |
| nf-fa-gears                                 | f085             |          |
| nf-fa-folder\_open                          | f07c             |          |
| nf-fa-folder\_open\_o                       | f115             |          |
| nf-fa-floppy\_o                             | f0c7             |          |
| nf-fa-flask                                 | f0c3             |          |
| nf-fa-calendar                              | f073             |          |
| nf-dev-terminal                             | e795             |          |
| nf-dev-terminal\_badge                      | e7a2             |          |
| nf-dev-database                             | e706             |          |
| nf-mdi-window\_restore                      | fab1             | 缾        |
| nf-oct-terminal                             | f489             |          |
| nf-fa-user                                  | f007             |          |
| nf-fae-maximize                             | e25d             |          |
| nf-indent-dotted\_guide                     | e621             |          |
| nf-mdi-server\_network                      | f98c             | 歷        |
| nf-oct-server                               | f473             |          |
| nf-mdi-clock                                | f64f             |          |
|                                             |                  |           |
|                                             |                  |           |
|                                             |                  |           |
|                                             |                  |           |
|                                             |                  |           |
|                                             |                  |           |









