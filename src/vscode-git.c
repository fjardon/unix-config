/*===========================================================================*\
 *                                                                           *
 *  vscode-git - Visual Studio Code wrapper for cygwin's git                 *
 *                                                                           *
 *  Copyright (c) 2020 Frederic Jardon  <frederic.jardon@gmail.com>          *
 *                                                                           *
 *  ------------------ GPL Licensed Source Code ------------------           *
 *  Frederic Jardon makes this software available under the GNU              *
 *  General Public License (GPL) license for open source projects.           *
 *  For details of the GPL license please see www.gnu.org or read            *
 *  the file license.gpl provided in this package.                           *
 *                                                                           *
 *  This program is free software; you can redistribute it and/or            *
 *  modify it under the terms of the GNU General Public License as           *
 *  published by the Free Software Foundation; either version 3 of           *
 *  the License, or (at your option) any later version.                      *
 *                                                                           *
 *  This program is distributed in the hope that it will be useful,          *
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of           *
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            *
 *  GNU General Public License for more details.                             *
 *                                                                           *
 *  You should have received a copy of the GNU General Public                *
 *  License along with this program in the file 'license.gpl'; if            *
 *  not, see <http://www.gnu.org/licenses/>.                                 *
 *  --------------------------------------------------------------           *
\*===========================================================================*/


#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <locale.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include <sys/cygwin.h>

static char    buf[32768];
static wchar_t wbuf[32768];

int
exec_git(int argc, char* argv[]) {
    argv[0] = "git";
    execv("/usr/bin/git", argv);
    perror("exec failed");
    return 1;
}

int
handle_parent(int argc, char* argv[]) {
    ssize_t err;
    int     len, nbw;
    while(fgets(buf, sizeof(buf), stdin)) {
        len = strlen(buf);
        if(len > 0)
            buf[len-1] = '\0';

        err = cygwin_conv_path(CCP_POSIX_TO_WIN_W, buf, wbuf, 32768);
        if(err) {
            perror("cygwin_conv_path failed");
            return 1;
        }

        nbw = wcstombs(buf, wbuf, 32767);
        if(nbw > 0)
            buf[nbw] = '\0';
        fprintf(stdout, "%s\n", buf);
        fflush(stdout);
    }
    return 0;
}


int
main(int argc, char* argv[]) {
    int m_pipe[2];
    int child_status, parent_status;
    pid_t pid;

    setlocale(LC_CTYPE, "");

    if(argc < 2 || strcmp("rev-parse", argv[1]))
        return exec_git(argc, argv);

    if (pipe(m_pipe)) {
        perror("pipe failed");
        return 1;
    }
    fflush(stdin);

    pid = fork();
    if ((pid_t)0 == pid) {
        dup2(m_pipe[1], 1);
        close(m_pipe[0]);
        child_status = exec_git(argc, argv);
        return child_status;
    }
    else {
        dup2(m_pipe[0], 0);
        close(m_pipe[1]);
        parent_status = handle_parent(argc, argv);
        waitpid(pid, &child_status, 0);
        if(parent_status != 0)
            return parent_status;
        if(WIFEXITED(child_status))
            return WEXITSTATUS(child_status);
    }
    return 1;
}

