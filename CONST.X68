; =============================================================================
; TITLE    : GAME CONSTANTS
; AUTHOR   : ODILO FORTES & MARIBEL CRESPI
; HISTORY  :
; =============================================================================

; --- MAP RELATED CONSTANTS ---------------------------------------------------

BACKGCOL    EQU $00EBCE87       ; BACKGROUND COLOR (FILL AND PEN) -> CYAN.

GRASPCOL    EQU $00497700       ; GRASS PEN COLOR -> DARK GREEN.
GRASFCOL    EQU $004CB122       ; GRASS FILL COLOR -> LIGHT GREEN.

LINECOL     EQU $00FFFFFF       ; WHITE COLOR FOR LINES.

SEPAPCOL    EQU $00000000       ; SEPARATOR PEN COLOR -> BLACK
SEPAFCOL    EQU $00405711       ; SEPARATOR FILL COLOR -> DARK GREEN.

BOUNDMAR    EQU 2               ; MARGIN OF PIXELS FROM BOUND (LOOKS GOOD).

GRASHEIG    EQU 30              ; GRASS HEIGHT.

LINEWIDT    EQU 8               ; WIDTH OF THE LINES.

SEPAWIDT    EQU 12              ; WIDTH OF THE SEPARATOR.
SEPAHEIG    EQU 120             ; HEIGTH OF THE SEPARATOR.

SESUWIDT    EQU 36              ; SEPARATOR SUPPORT WIDTH.
SESUHEIG    EQU 4               ; SEPARATOR SUPPORT HEIGTH.

WARN1COL    EQU $0000CCFF       ; WARNING 1 COLOR.
WARN2COL    EQU $000000FF       ; WARNING 2 COLOR.

; ---   PLAYERS RELATED CONSTANTS ---------------------------------------------

IAXEXTRA    EQU 1          ; BOOST OF SPEED FOR EVERY GOAL (IA ONLY).

BASEXSPD    EQU 7          ; BASE SPEED STAT (IT WILL INCREASE FOR IAs)

PLRJMPSP    EQU -20         ; PLAYER INITIAL JUMP SPEED (NEGATIVE)

PLRWIDTH    EQU 30          ; WIDTH OF PLAYER.
PLRHEIGH    EQU 30          ; HEIGTH OF PLAYER.

; --- PLAYER 1 ---
PLR1PCOL    EQU $00000000   ; PLAYER 1 PEN COLOR.
PLR1FCOL    EQU $0000FF00   ; PLAYER 1 FILL COLOR.

; --- PLAYER 2 ---
PLR2PCOL    EQU $00000000   ; PLAYER 2 PEN COLOR.
PLR2FCOL    EQU $00BBBB00   ; PLAYER 2 FILL COLOR.

; ---   BALL RELATED CONSTANTS ------------------------------------------------

BALLRAD     EQU 10          ; BALL RADIUS.

BALLPCOL    EQU $00000000   ; BALL PEN COLOR.
BALLFCOL    EQU $0000FFFF   ; BALL FILL COLOR.

BALLFRX     EQU 1           ; X FRICTION APPLIED ON BALL.
BALLFRY     EQU 3           ; Y FRICTION APPLIED ON BALL.

BALLXTOP    EQU 30          ; BALL X TOP SPEED.
BALLYTOP    EQU 30          ; BALL Y TOP SPEED.

; --- SCOREBOARD RELATED CONSTANTS --------------------------------------------
; They are technically part of map, but they are important enough as to
; get their own space!

SCBOPCOL    EQU $00000000   ; SCOREBOARD PEN COLOR (FOR BOTH).
SCBOFCOL    EQU $00AAAAAA   ; STANDARD INNER FOR SCOREBOARD.
SCBOCOL1    EQU PLR1FCOL    ; COLOR TEAM 1 (SAME AS PLAYER1).
SCBOCOL2    EQU PLR2FCOL    ; COLOR TEAM 2 (SAME AS PLAYER2).

SCBOWIDT    EQU 140         ; SCOREBOARD WIDTH
SCBOHEIG    EQU 90          ; SCOREBOARD HEIGH
SCBOMARG    EQU 5           ; SCOREBOARD MARGIN (FOR BETTER LOOKS)

; --- SCORE NUMBER RELATED CONSTANTS ------------------------------------------

MAXSCORE    EQU 7           ; SET ONLY BETWEEN 1 AND 7

SCORECOL    EQU $003432CB   ; COLOR OF NUMBERS

BOARD1X     EQU SCRWIDTH/4      ; X COORD OF PLAYER 1 BOARD
BOARD2X     EQU (3*SCRWIDTH)/4  ; X COORD OF PLAYER 2 BOARD
BOARDY      EQU SCRHEIGH/4      ; Y COORD OF BOTH BOARDS

TOUCHES     EQU 2           ; IF THE BALL TOUCHES N TIMES THE GROUND OF A
                            ; PLAYER (WITHOUT SENDING IT TO THE OTHER PLAYER),
                            ; THEN THAT OTHER PLAYER GETS A POINT.

; --- INTRO RELATED CONSTANTS -------------------------------------------------

INTBGCOL    EQU $00000000   ; INTRO BACKGROUND COLOR.

BARCOL      EQU $000000FF   ; OUTLINE AND PROGRESS COLOR.
BAREMPTY    EQU $00000000   ; EMPTY BAR COLOR.

BARY        EQU SCRHEIGH-80 ; Y COORD OF THE ATTRACT MODE LOADING BAR.

BARWIDTH    EQU 400
BARHEIGH    EQU 10

; --- STATE RELATED CONSTANTS ---------------------------------------------------

STAINTRO   EQU  0               ; INTRO STATE
STAGAME    EQU  1               ; GAME STATE
STACOUNT   EQU  2               ; AFTER GOAL STATE
STAGOVER   EQU  3               ; GAME OVER STATE
STAINFO    EQU  4               ; INFORMATION RELATED TO THE GAME STATE

VSPLAYER   EQU  0               ; VS PLAYER MODE
VSIA       EQU  1               ; IF THE PLAYER DOESN'T HAVE FRIENDS
CHSMUSIC   EQU  2               ; IF THE PLAYER WANTS TO CHANGE THE MUSIC
ATRMODE    EQU  3               ; ATTRACT MODE

DINHO1     EQU  0               ; IF THE PLAYER PREFERS RONALDINHO 1 MUSIC
DINHO2     EQU  1               ; IF PLAYER PREFERS RONALDINHO 2 MUSIC
MUSICPKM   EQU  2               ; MUSIC FOR THE LAST POINTS






























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
