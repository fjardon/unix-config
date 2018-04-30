TODO
====

[ ] Plugins:
  [x] Move to vim-plug
  [ ] Install it prior to updating the .vimrc

[ ] Tmux: include https://github.com/erikw/tmux-powerline
  [ ] split the configuration file in pieces
    [ ] One configuration file for theming
    [ ] One configuration file for bindings
    [ ] One configuration file for user settings
    [ ] Main configuration file not editable by user and putting pieces together

[ ] Fonts:
  [ ] update Xresources using the fc-list name instead of hard coding
  [ ] Fix font download url
  [ ] fonts and Xresources installed only if `xterm` is present on host
  [ ] Ask user if he wants to patch his own fonts instead of installing nerd

[ ] Better detection of prerequisites:
  [ ] gcc (for gnu global)
  [ ] perl (for substitution and templating)
  [ ] make

[/] Vim:
  [ ] Extract as much knowledge as possible from:
  http://stevelosh.com/blog/2010/09/coming-home-to-vim/#why-i-came-back-to-vim
  [ ] https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html

[ ] Better cygwin support:
  [ ] Create a cygwin package with all good tools for developers (as requires)
  [x] Configure XWinrc only if cygwin is detected
  [.] Add perl script to generate visual-c++ equivalent of vcvarsall.bat
      Beware install path is different depending on 32 or 64 bits
    [ ] Add support for vs professional
  [ ] Install a shortcut to launch X-server at startup
      C:\cygwin64\bin\run.exe --quote /usr/bin/bash.exe -l -c "cd; exec /usr/bin/startxwin"
      Paths can be found with cygpath -F <folder-id>

[ ] Better install:
  [ ] Before replacing the .bashrc, extract customization (after the marker line
      and copy them at the end of the new .bashrc.
      This will solve most of the problems with setup scripts (perl, ruby, ...)
      which updates the .bashrc with host specific lines.

[ ] Better UI:
  [ ] Use dialog to let user choose what he wants to install (similar to linux
      kernel build system)
      see: http://invisible-island.net/dialog/manpage/dialog.html
  [ ] Many options in UI may refer to the same configuration file (for
      instance bashrc), the setup will use a template and subtitute parts of
      the file accordingly. For instance one could enable alias and history,
      but not ssh-agent launch part of the .bashrc)
  [ ] Help user setup its ssh keys (through GUI)

[ ] Possibility to run setup.sh directly from a curl pipe (as is the current:
   fashion ...)

DONE
====

[x] Add ssh-agent stuff...
