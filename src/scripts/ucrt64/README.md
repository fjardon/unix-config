MSYS2 - UCRT64
==============

VcShell Script
--------------

We can configure the windows terminal to use MSYS2 using the `vcshell.bat` script.

----
cmd.exe /k "vcshell.bat --ucrt64"
----


Basic Dev. Environment Setup
----------------------------

----
pacman -S mingw-w64-ucrt-x86_64-make   mingw-w64-ucrt-x86_64-pkgconf mingw-w64-ucrt-x86_64-gcc  mingw-w64-ucrt-x86_64-gdb
----

