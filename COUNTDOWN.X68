*-----------------------------------------------------------
* Title      : COUNTDOWN AFTER GOAL OR MATCH START
* Written by : ODILO FORTES & MARIBEL CRESPI
* Date       :
* Description:
*-----------------------------------------------------------



; -----------------------------------------------------------------------------
COUNTINIT
; INITS THE BALL
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W #SCRWIDTH/2,D5
            MOVE.W #SCRHEIGH/3,D6
            
            MOVE.W #4,(PRINTN)
            RTS

; -----------------------------------------------------------------------------
COUNTUPD
; UPDATES THE BALL
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.B (SCRCYCCT),D0
            AND.W #%00001111,D0
            CMP.B  #0,D0
            BNE .END
            
            SUBQ.W #1,(PRINTN)
            
.END
            RTS

; -----------------------------------------------------------------------------
COUNTPLOT
; PLOTS THE BALL
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
;-----------------------------------------------------------------------------

            CMP #3,(PRINTN)
            BEQ .PRINT3
            
            CMP #2,(PRINTN)
            BEQ .PRINT2
            
            CMP #1,(PRINTN)
            BEQ .PRINT1
            
            CMP #0,(PRINTN)
            BEQ .READY

            BRA NOTHING
            
.PRINT3
            JSR THREE
            BRA NOTHING
            
.PRINT2
            JSR TWO
            BRA NOTHING
            
.PRINT1
            JSR ONE
            BRA NOTHING

.READY
            MOVE.W #STAGAME,(STANEXT)
            
NOTHING
            RTS





























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
