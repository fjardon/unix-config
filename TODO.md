TODO
====

[ ] Move XTerm*fontFaceName out of .Xresources
    The true-type fonts are rendered client-side, this means they should be
    configured to a font that is present on the client not the server. The
    .Xresources are loaded on the server and thus should only configure
    values not dependent on the client. A better resource files here would be
    .Xdefaults
[ ] Setup remote connections
  [ ] Add a .local/share/desktop-directories/RemoteAccess.directories file
    -------
    [Desktop Entry]
    Name=Remote Access
    Comment=Remote Access Shortcuts
    Icon=network-workgroup
    Type=Directory
    -------
  [ ] Add a .local/share/applications/ssh-<hostname>.desktop file for each
      remote connection
    -------
    [Desktop Entry]
    Name=SSH-<hostname>
    GenericName=SSH-<hostname>
    Comment=SSH to <hostname>
    Exec=xterm -e ssh <hostname>
    Terminal=false
    Type=Application
    Encoding=UTF-8
    Icon=xterm-color
    Categories=RemoteAccess;
    Keywords=shell;prompt;command;commandline;cmd;
    -------
  [ ] Add a .config/menus/xwin-applications.menu with the following snippets
    -------
    <!-- Remote Access-->
    <Menu>
      <Name>Remote Access</Name>
      <Directory>RemoteAccess.directory</Directory>
      <Include>
        <And>
          <Category>RemoteAccess</Category>
        </And>
      </Include>
    </Menu>   <!-- End Remote Access -->
    -------
    A template file can usually be found in
    /etc/xdg/menus/xwin-applications.menu




[ ] Setup template
  [ ] Split the setup into multiple scripts called from the main template

[.] Utilities
  [.] Install gdb pretty printers.
      See: http://sourceware.org/gdb/wiki/STLSupport
      [ ] check the pretty printers match user's gcc and install in a versioned
          directory
  [ ] Install lcov when missing
  [ ] Install pelican
  [ ] Install perl if user has an incomplete version
      [ ] Ask before and abort if unsure

[x] Vim Plugins:
  [x] Move to vim-plug
  [x] Install it prior to updating the .vimrc
  [x] Fix font download url
  [ ] Test YouCompleteMe
  [ ] Fix devicons to add icons for csharp/ csproj

[ ] T4 syntax highlighting for vim

[ ] Vim as an IDE
  [ ] Improve project or integrate in nerdtree or start anew ?
  [ ] shortcut to show/hide quickfix without giving focus to quickfix window
  [ ] shortcut to show/hide project window
  [ ] It is possible for a plugin to inegrate with nerdtree events, this could
      help re-implement some of the featues of project.tar.gz. For instance,
      in and out scripts, could be implemented that way.
  [ ] It is possible for a plugin to install nerdtree menu item.

[ ] Tmux: include https://github.com/erikw/tmux-powerline
  [ ] split the configuration file in pieces
    [ ] One configuration file for theming
    [ ] One configuration file for bindings
    [ ] One configuration file for user settings
    [ ] Main configuration file not editable by user and putting pieces together
    [ ] Fix the yank script to directly interact with tmux if possible
  [ ] Dialog script to configure the theme of the tmux configuration
    [ ] Colors
    [ ] Icons used for tabs in status bar

[/] Fonts:
  [x] Fix font download url
  [ ] fonts and Xresources installed only if `xterm` is present on host

[ ] Better detection of prerequisites:
  [ ] gcc (for gnu global)
  [ ] perl (for substitution and templating)
  [ ] make

[/] Vim:
  [ ] Extract as much knowledge as possible from:
  http://stevelosh.com/blog/2010/09/coming-home-to-vim/#why-i-came-back-to-vim
  [ ] https://coderoncode.com/tools/2017/04/16/vim-the-perfect-ide.html
  [ ] Split configuration in pieces
    [ ] one file for user plugin
    [ ] one file for user customization

[ ] Better cygwin support:
  [ ] Create a cygwin package with all good tools for developers (as requires)
  [x] Configure XWinrc only if cygwin is detected
  [/] Add perl script to generate visual-c++ equivalent of vcvarsall.bat
      Beware install path is different depending on 32 or 64 bits
    [x] msvc-shell script included
    [x] Add support for vs professional
    [ ] Add non interactive mode so that one can use msvc-shell to launch a
        script in the VC ready environment. For instance to make a VC++ build.
  [ ] Install a shortcut to launch X-server at startup
      C:\cygwin64\bin\run.exe --quote /usr/bin/bash.exe -l -c "cd; exec /usr/bin/startxwin"
      Paths can be found with cygpath -F <folder-id>

[ ] Better install:
  [ ] Before replacing the .bashrc, extract customization (after the marker line
      and copy them at the end of the new .bashrc.
      This will solve most of the problems with setup scripts (perl, ruby, ...)
      which updates the .bashrc with host specific lines.

[ ] Better setup:
  [ ] Use dialog to let user choose what he wants to install (similar to linux
      kernel build system)
      see: http://invisible-island.net/dialog/manpage/dialog.html
  [ ] Many options in UI may refer to the same configuration file (for
      instance bashrc), the setup will use a template and subtitute parts of
      the file accordingly. For instance one could enable alias and history,
      but not ssh-agent launch part of the .bashrc)
  [ ] Help user setup its ssh keys (through GUI)
  [ ] Help user create XDG configs for remote sessions

[ ] Possibility to run setup.sh directly from a curl pipe (as is the current:
   fashion ...)

DONE
====

[x] Add ssh-agent stuff...
[x] apt-cyg should be embedded in installer
  [x] checkout the file at make time and embedd in the shar


Add include-if in .gitconfig:

[includeIf "gitdir:~/perso/"]
    path = ~/perso/gitconfig
[includeIf "gitdir:~/Documents/Perso/"]
    path = ~/perso/gitconfig

