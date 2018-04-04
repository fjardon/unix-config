# Cygwin

 - In case cygwin mess up permissions
   * setfacl -b \<file|dir\>
   * icalcs \<file|dir\> /q /c /t /reset

One can use the following commands:

    fjardon@yoda 08:02:32 ~/workspace/tmp/fjtools
    $ find . -exec setfacl -b {} \;

    fjardon@yoda 08:03:17 ~/workspace/tmp/fjtools
    $ find . -exec chgrp Utilisateurs {} \;

    fjardon@yoda 08:03:36 ~/workspace/tmp/fjtools
    $ find . -exec setfacl -b {} \;


## XWin configuration

It is possible to have specific menus in taskbar based on WM_NAME.

### Startxwin

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


### X Files

- $HOME/.xsession
- $HOME/.Xclients



