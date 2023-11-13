*------------------------------------------------------------------------------
* Title      : MANAGEMENT OF NUMBERS (AS SCORES AND COUNTDOWN)
* Written by : ODILO FORTES & MARIBEL CRESPI
* Date       :
* Description:
*------------------------------------------------------------------------------

DRAWSC1
           MOVEM.L D5-D6/A0,-(A7)
           MOVE.W D0,-(A7)
            
           JSR NUMCOL               ; Get team 1 colors
           MOVE.W   #BOARD1X,D5     ; Get board 1 x coord.
           MOVE.W   #BOARDY,D6
           

           MOVE.W (SCORE1),D0
           EXT.L D0
           LSL.L #2,D0
           MOVE.L D0,A0
           MOVE.L SCORVECT(A0),A0
           JSR (A0)

           MOVE.W (A7)+,D0
           MOVEM.L (A7)+,D5-D6/A0
           RTS


DRAWSC2
           MOVEM.L D5-D6/A0,-(A7)
           MOVE.W D0,-(A7)
            
           JSR NUMCOL               ; Same but player 2.
           MOVE.W   #BOARD2X,D5
           MOVE.W   #BOARDY,D6
           
           MOVE.W (SCORE2),D0
           EXT.L D0
           LSL.L #2,D0
           MOVE.L D0,A0
           MOVE.L SCORVECT(A0),A0
           JSR (A0)
           
           MOVE.W (A7)+,D0
           MOVEM.L (A7)+,D5-D6/A0
           RTS

    ; Vector to jump to the number to be drawn.
SCORVECT   DC.L    ZERO,ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN



NUMCOL
           MOVE.B #80,D0            ; Task pen color
           MOVE.L #SCORECOL,D1      ; GRANATE
           TRAP #15
           
           MOVE.B #81,D0            ; Task fill color
           MOVE.L #SCORECOL,D1       ; GRANATE
           TRAP #15
           RTS
           
NUMBACKG
           CMP.W #SCRWIDTH/2,D5
           BEQ .NUMCOUNT

           MOVE.B #80,D0            ; Task pen color
           MOVE.L #SCBOFCOL,D1      ; GRIS
           TRAP #15
           
           MOVE.B #81,D0            ; Task fill color
           MOVE.L #SCBOFCOL,D1       ; GRIS
           TRAP #15
           RTS
.NUMCOUNT
           MOVE.B #80,D0            ; Task pen color
           MOVE.L #BACKGCOL,D1      ; GRIS
           TRAP #15
           
           MOVE.B #81,D0            ; Task fill color
           MOVE.L #BACKGCOL,D1       ; GRIS
           TRAP #15
           RTS
           
SETCENTER
           MOVE.W D5,D1             ;D5 CONTAINS THE X CENTER
           MOVE.W D6,D2        ;D6 CONTAINS THE Y CENTER
           MOVE.W D1,D3
           MOVE.W D2,D4
           RTS

ZERO
           MOVEM.L D0-D4,-(A7)
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR NUMBACKG
           
           MOVE.B #87,D0
           
           JSR SETCENTER
           SUB.W #10,D1
           SUB.W #15,D2
           ADD.W #10,D3
           ADD.W #15,D4
           TRAP #15
           
           MOVEM.L (A7)+,D0-D4
           RTS

ONE
           MOVEM.L D0-D4,-(A7)
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #10,D1
           SUB.W #25,D2
           ;ADD.W #0,D3
           SUB.W #15,D4
           TRAP #15
           
           JSR SETCENTER
           ;ADD.W #0,D1
           SUB.W #25,D2
           ADD.W #10,D3
           ADD.W #25,D4
           TRAP #15
           
           MOVEM.L (A7)+,D0-D4
           RTS
TWO
           MOVEM.L D0-D4,-(A7)

           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR NUMBACKG
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #15,D2
           ADD.W #10,D3
           SUB.W #5,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #10,D1
           ADD.W #5,D2
           ADD.W #20,D3
           ADD.W #15,D4
           TRAP #15
           
           MOVEM.L (A7)+,D0-D4
           RTS
THREE
           MOVEM.L D0-D4,-(A7)
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR NUMBACKG
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #15,D2
           ADD.W #10,D3
           SUB.W #5,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #20,D1
           ADD.W #5,D2
           ADD.W #10,D3
           ADD.W #15,D4
           TRAP #15

           MOVEM.L (A7)+,D0-D4
           RTS
FOUR
           MOVEM.L D0-D4,-(A7)
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR NUMBACKG
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           ADD.W #5,D2
           ADD.W #10,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #10,D1
           SUB.W #25,D2
           ADD.W #10,D3
           SUB.W #5,D4
           TRAP #15
           
           MOVEM.L (A7)+,D0-D4
           RTS
FIVE
           MOVEM.L D0-D4,-(A7)
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR NUMBACKG
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #10,D1
           SUB.W #15,D2
           ADD.W #20,D3
           SUB.W #5,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #20,D1
           ADD.W #5,D2
           ADD.W #10,D3
           ADD.W #15,D4
           TRAP #15

           MOVEM.L (A7)+,D0-D4
           RTS
SIX
           MOVEM.L D0-D4,-(A7)
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           
           JSR NUMBACKG
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #10,D1
           SUB.W #15,D2
           ADD.W #20,D3
           SUB.W #5,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #10,D1
           ADD.W #5,D2
           ADD.W #10,D3
           ADD.W #15,D4
           TRAP #15

           MOVEM.L (A7)+,D0-D4
           RTS
SEVEN
           MOVEM.L D0-D4,-(A7)
           
           MOVE.B #87,D0
           JSR SETCENTER
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           SUB.W #15,D4
           TRAP #15
           
           MOVE.B #87,D0
           JSR SETCENTER
           ADD.W #10,D1
           SUB.W #15,D2
           ADD.W #20,D3
           SUB.W #5,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #5,D2
           ADD.W #10,D3
           ADD.W #5,D4
           TRAP #15

           JSR SETCENTER
           SUB.W #10,D1
           ADD.W #5,D2
           ADD.W #15,D4
           TRAP #15
           
           JSR SETCENTER
           SUB.W #20,D1
           ADD.W #15,D2
           SUB.W #10,D3
           ADD.W #25,D4
           TRAP #15
           
           MOVEM.L (A7)+,D0-D4
           RTS



NADA
           JSR NUMBACKG
           JSR SETCENTER
           MOVE.B #87,D0
           SUB.W #20,D1
           SUB.W #25,D2
           ADD.W #20,D3
           ADD.W #25,D4
           TRAP #15
           RTS
           
INTROCOL

           MOVE.B #80,D0            ; Task pen color
           MOVE.L #INTBGCOL,D1      ; GRANATE
           TRAP #15

           MOVE.B #81,D0            ; Task fill color
           MOVE.L #INTBGCOL,D1       ; GRANATE
           TRAP #15
           RTS
           












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
