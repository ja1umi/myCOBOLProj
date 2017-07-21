       >>SOURCE FORMAT IS FREE
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GREAT-DECISION-2017.
      *>
      *> GREAT DECISION 2017
      *>====================
      *>
      *> This program is inspired by the following two pieces of work:
      *> 1) A joke computer program, named 'great decision', the multipurpose
      *> interactive assistance tool for decision-making, which was published in
      *> the annual magazine 'AhSki!' for computer hobbyists in 1983 in Japan, and
      *> 2) My favorite scene from the TV program SPACE:1999 season 1 episode 1 'Breakaway',
      *> which featured Martin Landau and which is produced by ITC Entertainment and
      *> Italian broadcaster RAI. 
      *>
      *> As a COBOL beginner, this program is also dedicated to Jean E. Sammet,
      *> a designer of COBOL language, passed away on May 20, 2017. Now, COBOL is
      *> available not only for developers, but also for computer hobbyists, like me!
      *>
      *> USAGE
      *> =====
      *> 
      *> Once executed, you are asked to input a word describing what you are facing.
      *> After pressing ENTER key, you are asked again to fill in the blank run-on
      *> entries (up to 3 lines) to describe the details. Remember to press ENTER key.
      *> Please be patient for a few seconds and see the divine messages to find out 
      *> whether the computer's advise works for you. 
      *>
      *> AUTHOR: JA1UMI a.k.a. Kasumi YOSHINO (at Twitter @yKasumi)
      *> DATE-WRITTEN: July 20, 2017
      *> 
      *> Date       Change Description
      *> 0720-2017  Initial Release
      *> 0721-2017  Fixed colorization issue
      *> 
       ENVIRONMENT DIVISION.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 WS-S1     PIC X(13).
       01 WS-S2     PIC X(26).
       01 WS-DUMMY  PIC X(01).
       01 WS-PAD    PIC X(26).
       COPY screenio.

       SCREEN SECTION.
       01 CLEAR-SCREEN.
         02 BLANK SCREEN.
       01 INPUT-SCREEN1.
         02 BLANK SCREEN.
         02 FOREGROUND-COLOR COB-COLOR-GREEN.
         02 LINE 1  COL 1  VALUE "-------------------------------".
         02 LINE 2  COL 1  VALUE "-TO BE DONE OR NOT TO BE DONE:-".
         02 LINE 3  COL 1  VALUE "-   WHAT IS YOUR PROBLEM ?    -".
         02 LINE 4  COL 1  VALUE "-------------------------------".
         02 LINE 5  COL 1  VALUE "-         PLEASE NAME         -".
         02 LINE 6  COL 1  VALUE "-   THE PROBLEM IN ONE WORD   -".
         02 LINE 7  COL 1  VALUE "-                             -".
         02 LINE 7  COL 10 PIC X(13) TO WS-S1.
         02 LINE 8  COL 1  VALUE "-------------------------------".
         02 LINE 9  COL 1  VALUE "   PRESS ENTER TO REGISTER     ".
       01 INPUT-SCREEN2.
         02 BLANK SCREEN.
         02 LINE 1  COL 1  VALUE "----------------------------".
         02 LINE 2  COL 1  VALUE "- PLEASE FILL IN THE BELOW -".
         02 LINE 3  COL 1  VALUE "-RUN-ON ENTRIES TO DESCRIBE-".
         02 LINE 4  COL 1  VALUE "-       THE DETAILS        -".
         02 LINE 5  COL 1  VALUE "----------------------------".
         02 LINE 6  COL 1  VALUE "-                          -".
         02 LINE 7  COL 1  VALUE "-                          -".
         02 LINE 8  COL 1  VALUE "-                          -".
         02 LINE 6  COL 2  PIC X(26) TO WS-S2.
         02 LINE 7  COL 2  PIC X(26) TO WS-S2.
         02 LINE 8  COL 2  PIC X(26) TO WS-S2.
         02 LINE 9  COL 1  VALUE "----------------------------".
         02 LINE 10 COL 1  VALUE "  PRESS ENTER TO REGISTER   ".
       01 OUTPUT-SCREEN-COMMON.
         02 BLANK SCREEN.
         02 LINE 1  COL 1  VALUE "----------------------------".
         02 LINE 2  COL 1  VALUE "-    EMERGENCY OPERATION   -".
         02 LINE 3  COL 1  VALUE "-                          -".
         02 LINE 3  COL 2  PIC X(26) FROM WS-PAD.
         02 LINE 4  COL 1  VALUE "----------------------------".                                 
         02 LINE 5  COL 1  VALUE "-     INDEFINITE FACTORS   -".
         02 LINE 6  COL 1  VALUE "----------------------------".
         02 LINE 7  COL 1  VALUE "PRESS ENTER TO CONTINUE ->  ".
       01 OUTPUT-SCREEN1.
         02 LINE 7  COL 1  VALUE "-  1: YOU ARE ON A UNKNOWN -".
         02 LINE 8  COL 1  VALUE "-           PATH           -".
         02 LINE 9  COL 1  VALUE "----------------------------".
         02 LINE 10 COL 1  VALUE "PRESS ENTER TO CONTINUE ->  ".
       01 OUTPUT-SCREEN2.
         02 LINE 7  COL 1  VALUE "-  2: CONSTANTLY CHANGING  -".
         02 LINE 8  COL 1  VALUE "-     OF THE ENVIRONMENT   -".
         02 LINE 9  COL 1  VALUE "-          FOR YOU         -".
         02 LINE 10 COL 1  VALUE "----------------------------".
         02 LINE 11 COL 1  VALUE "PRESS ENTER TO CONTINUE ->  ".
       01 OUTPUT-SCREEN3.
         02 LINE 7  COL 1  VALUE "-   3: INSUFFICIENT DATA   -".
         02 LINE 8  COL 1  VALUE "-        TO COMPUTE A      -".
         02 LINE 9  COL 1  VALUE "-      APPROPRIATE PLAN    -".
         02 LINE 10 COL 1  VALUE "----------------------------".
         02 LINE 11 COL 1  VALUE "PRESS ENTER TO CONTINUE ->  ".
       01 OUTPUT-SCREEN4.
         02 LINE 7  COL 1  VALUE "-ALL FACTORS IN MEMORY BANK-".
         02 LINE 8  COL 1  VALUE "-        RELATING TO       -".
         02 LINE 9  COL 2  PIC X(26) FROM WS-PAD.
         02 LINE 10 COL 1  VALUE "-       INAPPLICABLE       -".
         02 LINE 11 COL 1  VALUE "----------------------------".
         02 LINE 12 COL 1  VALUE "PRESS ENTER TO CONTINUE ->  ".
       01 OUTPUT-SCREEN5.
         02 LINE 7  COL 1  VALUE "-     INSUFFICIENT DATA    -".
         02 LINE 8  COL 1  VALUE "-AVAILABLE UNDER PREVAILING-".
         02 LINE 9  COL 1  VALUE "-      CIRCUMSTANCES       -".
         02 LINE 10 COL 1  VALUE "----------------------------".
         02 LINE 11 COL 1  VALUE "PRESS ENTER TO CONTINUE ->  ".
         02 LINE 12 COL 1  VALUE "                            ".
       01 OUTPUT-SCREEN6.
         02 BLANK SCREEN.
         02 LINE 1  COL 1  VALUE "----------------------------".
         02 LINE 2  COL 1  VALUE "-           HUMAN          -".
         02 LINE 3  COL 1  VALUE "-         DECISION         -".
         02 LINE 4  COL 1  VALUE "-         REQUIRED         -".
         02 LINE 5  COL 1  VALUE "----------------------------".
         02 LINE 6  COL 1  VALUE "PRESS ENTER TO QUIT ->      ".
         02 LINE 9  COL 1  VALUE "R.I.P. Martin Landau.".

       PROCEDURE DIVISION.
       ACCEPT INPUT-SCREEN1.
       ACCEPT INPUT-SCREEN2.
       DISPLAY CLEAR-SCREEN.
       CALL 'C$SLEEP' USING 2.
       CALL 'C$TOUPPER' USING WS-S1, BY VALUE FUNCTION LENGTH(WS-S1).
       MOVE WS-S1 TO WS-PAD.
       CALL 'C$JUSTIFY' USING WS-PAD, "Centering"
       DISPLAY OUTPUT-SCREEN-COMMON.
       ACCEPT  WS-DUMMY AT LINE 7  COL 27.
       DISPLAY OUTPUT-SCREEN1.
       ACCEPT  WS-DUMMY AT LINE 10 COL 27.
       DISPLAY OUTPUT-SCREEN2.
       ACCEPT  WS-DUMMY AT LINE 11 COL 27.
       DISPLAY OUTPUT-SCREEN3.
       ACCEPT  WS-DUMMY AT LINE 11 COL 27.
       MOVE FUNCTION CONCATENATE("OPERATION ", FUNCTION TRIM(WS-S1, TRAILING)) TO WS-PAD.
       CALL 'C$JUSTIFY' USING WS-PAD, "Centering"
       DISPLAY OUTPUT-SCREEN4.
       ACCEPT  WS-DUMMY AT LINE 12 COL 27.
       DISPLAY OUTPUT-SCREEN5.
       ACCEPT  WS-DUMMY AT LINE 11 COL 27.
       DISPLAY OUTPUT-SCREEN6.
       ACCEPT  WS-DUMMY AT LINE 6 COL 23.

       GOBACK.
       END PROGRAM GREAT-DECISION-2017.
