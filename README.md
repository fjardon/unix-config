= unix-config

Common unix user home directory configuration scripts.

= Principles

o The configuration should work for a real UNIX and Cygwin.
o It should be as fast as possible.
o It should be productive.

= XTerm

xterm -rv -sb -rightbar -tn xterm-256color

== Command Line Options

o -rightbar, force scrollbar to the right side of VT100 screen.
o -rv, this option indicates that reverse video should be simulated by swapping
  the foreground and background colors. The corresponding resource name is
  reverseVideo.
o -sb, this option indicates that some number of lines tha are scrolled off the
  top of the window should be saved and that a scrollbar should be displayed so
  that those lines can be viewed. This option may be turned on and off from the
  "VT Options" menu.
o -tm <string>, series of terminal setting keywords and the character that
  should be bound to those functions (see stty and ttyModes resources)
o -tn <terminal-name>, This option specified the name of the terminal type to
  be set in the TERM environment variable. It corresponds to the termName
  resource. This terminal type must exist in the terminal database (termcap or
  terminfo, depending on how xterm is built) and should have li# and co#
  entries. If the terminal type is not found, xterm uses the built-in list
  "xterm", "vt102", etc.
o -u8 Sets the utf8 resource.

In order to use emacs correctly we must uncheck:
- Backarrow Key (BS/DEL)

Lots of things can configured through Xresources:

o Xterm's reported terminal: xterm*termName: xterm-256color  We don't
  recommend to use this setting as it would apply to all xterms displayed by
  the X server, independently of their real capacities.
o reverseVideo, Specified whether or not reverse video should be simulated.
  The default is "false".
o rightScrollBar, Specifies whether or not the scrollbar should be displayed on
  the right rather than the left. The default is "false".
o geometry, Specifies the preferred size and position of the VT102 window.
  There is no default for this resource.

xterm*backarrowKeyIsErase: true
xterm*utf8: 2
xterm*utf8Fonts: true
xterm*utf8Title: true
xterm*reverseVideo: true
xterm*rightScrollBar: true
xterm*termName: xterm-256color

xterm*eightBitInput: true
xterm*faceName: Liberation
xterm*renderFont: true
xterm*vt100.initialFont: 3
xterm*dynamicColors: true

# xterm*vt100.altSendsEscape: true
# xterm*allowBoldFonts: false


== Setting the terminal name

Before setting the terminal name we must ensure this name exists in the
terminfo DB.

In order to check if a terminal exists in the terminfo database, one can use
the 'tput' program:

o $(tput -Txterm colors) gives the number of colors supported by 'xterm' in the
  terminfo DB.
o $(tput -Txterm-256color colors) gives the number of colors supported by
  'xterm-256color' in the terminfo DB.

These invokations also sets the exit code. A non existent terminal name will
produce an exit code != 0.

== Testing terminal capabilities

    msgcat --color=test

== XTerm's specific control sequences

see: http://invisible-island.net/xterm/ctlseqs/ctlseqs.txt


== XWin configuration

It is possible to have specific menus in taskbar based on WM_NAME.

=== Startxwin

  1.  startxwin loads the file /etc/X11/xinit/startxwinrc
  2.  the configuration file create a xsession error file in:
      $HOME/.xsession-errors
  3.  source /etc/X11/xinit/xinitrc-common
    a) source /etc/profile.d/lang.sh
    b) source $HOME/.profile (not .bash_profile)
    c) xrdb -nocpp -merge /etc/X11/Xresources
    d) xrdb -merge $HOME/.Xresources
  4.  calls trayer (taskbar like tool)
  5.  starts some daemons
  6.  starts pulse-audio-x11
  7.  starts gnome-keyring-daemon
  8.  starts other daemons
  9.  starts fbxkb (language switcher)
  10. executes xwin-xdg-menu




=== X Files

  o $HOME/.xsession
  o $HOME/.Xclients
 

How to check if terminal has got 256 colors ?

    msgcat --color=test

 
