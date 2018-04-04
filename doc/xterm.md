# XTerm

Example command line invokation of xterm in 256 colors mode.

    xterm -rv -sb -rightbar -tn xterm-256color

## Command Line Options


| Option | Description                                           |
| ---  | ---                                                 |
| \-rightbar | force scrollbar to the right side of VT100 screen. |
| \-rv       | this option indicates that reverse video should be simulated by swapping the foreground and background colors. The corresponding resource name is _reverseVideo_. |
| \-sb       | this option indicates that some number of lines that are scrolled off the top of the window should be saved and that a scrollbar should be displayed so that those lines can be viewed. This option may be turned on and off from the _VT Options_ menu.|
| \-tm _string_ | series of terminal setting keywords and the character that should be bound to those functions (see _stty_ and _ttyModes_ resources) |
| \-tn _terminal-name_ | This option specified the name of the terminal type to be set in the *TERM* environment variable. It corresponds to the _termName_ resource. This terminal type must exist in the terminal database (_termcap_ or _terminfo_, depending on how xterm is built) and should have _li#_ and _co#_ entries. If the terminal type is not found, xterm uses the built-in list _xterm_, _vt102_, etc. |
| \-u8       | Sets the _utf8_ resource. |


In order to use emacs correctly we must uncheck:

- Backarrow Key (BS/DEL)

Lots of things can configured through Xresources:

- Xterm's reported terminal: xterm*termName: xterm-256color  We don't recommend to use this setting as it would apply to all xterms displayed by the X server, independently of their real capacities.
- reverseVideo, Specified whether or not reverse video should be simulated. The default is "false".
- rightScrollBar, Specifies whether or not the scrollbar should be displayed on the right rather than the left. The default is "false".
- geometry, Specifies the preferred size and position of the VT102 window. There is no default for this resource.


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
     \# xterm*vt100.altSendsEscape: true
     \# xterm*allowBoldFonts: false


### Setting the terminal name

Before setting the terminal name we must ensure this name exists in the
terminfo DB.

In order to check if a terminal exists in the terminfo database, one can use
the 'tput' program:

- `$(tput -Txterm colors)` gives the number of colors supported by 'xterm' in the
  terminfo DB.
- `$(tput -Txterm-256color colors)` gives the number of colors supported by
  'xterm-256color' in the terminfo DB.

These invokations also sets the exit code. A non existent terminal name will
produce an exit code != 0.

### Testing terminal capabilities

How to check if terminal has got 256 colors ?

    msgcat --color=test


### XTerm's specific control sequences

see: http://invisible-island.net/xterm/ctlseqs/ctlseqs.txt


