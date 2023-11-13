*-----------------------------------------------------------
* Title      : PLAYER1
* Written by : ODILO FORTES & MARIBEL CRESPI
* Date       : 
* Description: 
*-----------------------------------------------------------

; -----------------------------------------------------------------------------
PLR1INIT
; INITIALIZES THE PLAYER 
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVE.W  #SCRWIDTH/4,(PLAYER1X)                     ; INITIAL X.
            MOVE.W  #SCRHEIGH-GRASHEIG-1-PLRHEIGH/2,(PLAYER1Y) ; INITIAL Y.
            
            CLR.W   (PLR1YACC)        ; INITIAL Y SPEED
            RTS

; -----------------------------------------------------------------------------
PLR1UPD
; UPDATES THE PLAYER MOTION
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------

; --- GRAVITY ---
            MOVE.W (PLR1YACC),D0    ; Y speed adds to y coord.
            ADD.W D0,(PLAYER1Y)         
            
            ADDQ.W  #2,(PLR1YACC)       ; Gravity modifies Y speed for next
                                        ; frame (will fall faster).
            
            CLR.W (PLR1XACC)    ; This represents the speed of the player in
                                ; this frame.
            
; --- CHECKING GROUND ---
            CMP.W #SCRHEIGH-GRASHEIG-1-PLRHEIGH/2,(PLAYER1Y)  ; Correct height?
            BLT .CHCKMODE                                     ; Yes, np.
            MOVE.W #SCRHEIGH-GRASHEIG-1-PLRHEIGH/2,(PLAYER1Y) ; No, fix Y.
            CLR.B (PLR1YACC)                                  ; Also Y speed=0.
            
.CHCKMODE
            CMP.W #ATRMODE,(OPTCHSD)      ; 0=PLAYER, 1=IA, 3=ATRMODE
            BEQ .IA
            
*******************************************************************************
************************* PVP & IA MODE - PRESSED KEYS ************************
*******************************************************************************
.PLAYER
            BTST.B #KBDBITF1,(KBDVAL)       ; Up key pressed?
            BEQ .KEYS1                      ; No: BEQ and skip JSR.
            JSR .MOVEUP                     ; Yes: JSR.
.KEYS1    
            BTST.B #KBDBITF3,(KBDVAL)       ; Same logic.
            BEQ .KEYS2
            JSR .MOVEL
.KEYS2
            BTST.B #KBDBITF2,(KBDVAL)
            BEQ .KEYS3
            JMP .MOVER
.KEYS3
            RTS
 
*******************************************************************************
**************************** ATR MODE - MOVEMENT ******************************
*******************************************************************************
.IA
            CMP.W #SCRWIDTH/2,(BALLX)   ; If the ball is not on the IA side, it
            BGT .RTS                    ; will not move.

            MOVE.W (PLAYER1X),D7
            CMP.W (BALLX),D7
            BGT .MOVEL
            BRA .MOVER





            
 
; --- RESULT OF PRESSED KEYS ---
.MOVEUP
            CMP.W   #SCRHEIGH-GRASHEIG-1-PLRHEIGH/2,(PLAYER1Y) ; Player in air?
            BLT     .RTS                                     ; Yes: no jump.
            MOVE.W  #-20,(PLR1YACC)        ; No, lets jump setting YSPD.
            RTS
.MOVEL 
            CMP.W #PLRWIDTH/2+BOUNDMAR,(PLAYER1X) ; Check left bound.
            BGT .DOL                                ; If correct: do left.
            MOVE.W  #PLRWIDTH/2+BOUNDMAR,(PLAYER1X) ; No: correct X.
            RTS
.DOL
            MOVE.W (PLR1XSPD),D7
            SUB.W D7,(PLAYER1X)               ; Sub XSPD to X.
            SUB.W D7,(PLR1XACC)               ; Player x spd in the frame
            RTS
.MOVER
            CMP.W #(SCRWIDTH-PLRWIDTH-SEPAWIDT)/2-1,(PLAYER1X) ;Check bound.
            BLT .DOR                                ; If correct: do right.
            MOVE.W #(SCRWIDTH-PLRWIDTH-SEPAWIDT)/2-1,(PLAYER1X) ; No:Correct X.
            RTS
.DOR
            MOVE.W (PLR1XSPD),D7
            ADD.W D7,(PLAYER1X)               ; Add XSPD to X.
            ADD.W D7,(PLR1XACC)               ; Player x spd in the frame.

.RTS                ; The best way to combine branches + RTS.
            RTS            

; -----------------------------------------------------------------------------
PLR1PLOT
; PLOTS THE PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - D0,D1,D2,D3,D4
; -----------------------------------------------------------------------------

            MOVEM.L D0-D4,-(A7)     ; Save registers.
                       
            MOVE.B #80,D0           ; Pen color task.
            MOVE.L #PLR1PCOL,D1     ; Color.
            TRAP #15                ; Set.
            
            MOVE.B #81,D0           ; Fill color task.
            MOVE.L #PLR1FCOL,D1     ; Color.
            TRAP #15                ; Set.
            
            MOVE.B #87,D0           ; Drawing player (just a square).
            MOVE.W (PLAYER1X),D1
            MOVE.W (PLAYER1Y),D2
            MOVE.W D1,D3
            MOVE.W D2,D4
            SUB.W #PLRWIDTH/2,D1
            SUB.W #PLRHEIGH/2,D2
            ADD.W #PLRWIDTH/2,D3
            ADD.W #PLRHEIGH/2,D4
            TRAP #15
            
            MOVEM.L (A7)+,D0-D4     ; Get registers back.
            RTS
            










































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
