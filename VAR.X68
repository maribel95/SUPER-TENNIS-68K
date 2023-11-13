; =============================================================================
; TITLE    : GAME VARIABLES
; AUTHOR   : ODILO FORTES & MARIBEL CRESPI
; HISTORY  :
; =============================================================================

; --- PLAYER RELATED VARIABLES ------------------------------------------------

; --- PLAYER 1 ---

PLAYER1X    DS.W    1       ; PLAYER 1 X COORDINATE
PLAYER1Y    DS.W    1       ; PLAYER 1 Y COORDINATE

PLR1XSPD    DS.W    1       ; PLAYER 1 X SPEED

PLR1XACC    DS.W    1       ; PLAYER 1 X ACCELERATION
PLR1YACC    DS.W    1       ; PLAYER 1 Y ACCELERATION

SCORE1      DS.W    1       ; PLAYER 1 SCORE

; --- PLAYER 2 ---

PLAYER2X    DS.W    1       ; PLAYER 2 X COORDINATE
PLAYER2Y    DS.W    1       ; PLAYER 2 Y COORDINATE

PLR2XSPD    DS.W    1       ; PLAYER 2 X SPEED

PLR2XACC    DS.W    1       ; PLAYER 2 X ACCELERATION
PLR2YACC    DS.W    1       ; PLAYER 2 Y ACCELERATION

SCORE2      DS.W    1       ; PLAYER 2 SCORE

; --- BALL RELATED VARIABLES --------------------------------------------------

BALLX       DS.W    1
BALLY       DS.W    1

BALLXSPD    DS.W    1
BALLYSPD    DS.W    1

; --- MAP RELATED VARIABLES ---------------------------------------------------

WARNING1    DS.W    1       ; COUNTER TO KNOW IF TEAM 1 (OR 2) FIELD HAS BEEN
WARNING2    DS.W    1       ; ALREADY TOUCHED BY THE BALL. ZERO OR NON ZERO.

; --- MATCH START COUNTDOWN RELATED VARIABLES ---------------------------------

PRINTN      DS.W    1

; --- STATE MANAGEMENT VARIABLES  ------------------------------------------------

STACUR      DS.W    1   ; CURRENT STATE
STANEXT     DS.W    1   ; NEXT STATE

OPTCHSD     DS.W    1   ; WHAT OPTION DID THE PLAYER CHOSE
MSCCHSD     DS.W    1   ; WHAT MUSIC CHOSE THE PLAYER

ATRBAR      DS.W    1   ; IF IT FULLY LOADS, THEN WE ENTER ATTRACT MODE.
                        ; THE BAR RESETS WITH EVERY PRESSED KEY.















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
