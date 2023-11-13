*------------------------------------------------------------------------------
* Title      : BALL MANAGEMENT
* Written by : ODILO FORTES & MARIBEL CRESPI
* Date       :
* Description:
*------------------------------------------------------------------------------
; -----------------------------------------------------------------------------
BALLINIT
; INITS THE BALL
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W #SCRWIDTH/2,(BALLX)   ; Starting X coord.
            MOVE.W #250,(BALLY)          ; Starting Y coord.
    
            MOVE.W #-25,(BALLYSPD)  ; Starting Y speed.
            MOVE.W #-6,D6           ; Starting X speed (it will go to the
                                    ; player losing, in case of a tie it will
                                    ; go to left player).
            MOVE.W (SCORE1),D7
            CMP.W (SCORE2),D7
            BLE .MOVEXSPD
            MULS.W #-1,D6
.MOVEXSPD
            MOVE.W D6,(BALLXSPD)
                        
            RTS

; -----------------------------------------------------------------------------
BALLUPD
; UPDATES THE BALL
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

; --- SETTING BALL X&Y TOP SPEED --- (IT MUST NOT GO TOO FAST)
; -- X
.XSIGN
            CMP.W   #0,(BALLXSPD)
            BLT     .XNEG
.XPOS
            CMP.W   #BALLXTOP,(BALLXSPD)
            BLT     .YSIGN
            MOVE.W  #BALLXTOP,(BALLXSPD)
            BRA     .YSIGN
.XNEG    
            CMP.W   #-BALLXTOP,(BALLXSPD)
            BGT     .YSIGN
            MOVE.W  #-BALLXTOP,(BALLXSPD)
; -- Y
.YSIGN
            CMP.W   #0,(BALLYSPD)
            BLT     .YNEG
.YPOS
            CMP.W   #BALLYTOP,(BALLYSPD)
            BLT     VERTICAL
            MOVE.W  #BALLYTOP,(BALLYSPD)
            BRA     VERTICAL
.YNEG    
            CMP.W   #-BALLYTOP,(BALLYSPD)
            BGT     VERTICAL
            MOVE.W  #-BALLYTOP,(BALLYSPD)

;------------------------- VERTICAL -------------------------------------------
VERTICAL
            MOVE.W (BALLYSPD),D0            ; Vertical speed in D0.
            ADD.W   D0,(BALLY)                ; Y speed modifies Y.                 
            ADDQ.W  #2,D0
            MOVE.W  D0,(BALLYSPD)           ; Gravity modifies Y speed.
.CHECKTOP
            CMP.W   #BALLRAD+1,(BALLY)
            BGT     .CHECKBOT
.TOPFIX
            MOVE.W  #BALLRAD+1,(BALLY)
            JSR     NEGYSPD
            BRA     .PLAYER1   
.TOPFIXED            
.CHECKBOT
            CMP.W #SCRHEIGH-1-GRASHEIG-BALLRAD,(BALLY) ; Check bottom or under.
            BLT .PLAYER1                            ; Si no, pasamos a lateral.
.FIXBOT
            MOVE.W  #SCRHEIGH-1-GRASHEIG-BALLRAD,(BALLY) ; Fix position
            
            JSR     FRICYSPD
            JSR     NEGYSPD
            
            CMP.W   #SCRWIDTH/2,(BALLX) ; Lets check which team got scored.
            BGT     .ZONE2HIT
.ZONE1HIT
            CMP.W   #TOUCHES,(WARNING1) ; Only add point if it touched twice.
            BNE .NOSCORE1
            
            ADDQ.W  #1,(SCORE2)         ; +1 point,
            
            CMP.W #3,(OPTCHSD)          ; 0=PLAYER, 1=IA, 3=ATTRACT MODE
            BNE .NOADD1
                                        ; If vs IA, we will add as much speed
                                        ; as goals it has been scored.
            MOVE.W (PLR1XSPD),D7
            ADD.W (SPEEDIA),D7
            MOVE.W D7,(PLR1XSPD)        ; SPEED = BASEXSPDD + RIVAL GOALS
.NOADD1
            MOVE.W #STACOUNT,(STANEXT)    ; Activate countdown for next point.
.NOSCORE1
            ADDQ.W  #1,(WARNING1)

            CMP.W   #MAXSCORE,(SCORE2)  ; Avoid goals overflow error.
            BLE.W   .PLAYER1            ; If 7 or less goals, OK.
            
            CLR.W   (SCORE2)            ; This line will never be reached, as
                                        ; we go to gameover state before we get
                                        ; here, but it exists 'just in case' 
                                        ; (the scoreboard does not process a
                                        ; score higher than 7).
            BRA     .PLAYER1
.ZONE2HIT                               ; Same but opposite case.
            CMP.W   #TOUCHES,(WARNING2)
            BNE .NOSCORE2
            
            ADDQ.W  #1,(SCORE1)
            
            CMP.W #0,(OPTCHSD)          ; 0=PLAYER, 1=IA, 3=ATTRACT MODE
            BEQ .NOADD2
                                        ; If vs IA, we will add as much speed
                                        ; as goals it has been scored.
            MOVE.W (PLR2XSPD),D7
            ADD.W (SPEEDIA),D7
            MOVE.W D7,(PLR2XSPD)        ; SPEED = BASEXSPDD + RIVAL GOALS
.NOADD2            
            MOVE.W #STACOUNT,(STANEXT)
.NOSCORE2
            ADDQ.W  #1,(WARNING2)
            
            CMP.W   #MAXSCORE,(SCORE1)
            BLE.W   .PLAYER1
            
            CLR.W   (SCORE1)            ; Same as above.
.SEPATOP    ;POR HACER

; --- PLAYER1-BALL COLLISIONS ---
.PLAYER1

            MOVE.W  (PLAYER1X),D0
            MOVE.W  D0,D1
.LEFTZONE               ; Discards left zone.
            SUB.W   #BALLRAD/2+PLRWIDTH/2,D1
            CMP.W   (BALLX),D1
            BGT     ENDPLR1
.RGHTZONE               ; Discards right zone.            
            MOVE.W  D0,D1
            ADD.W   #BALLRAD/2+PLRWIDTH/2,D1
            CMP.W   (BALLX),D1
            BLT     ENDPLR1
.TOPZONE               ; Discards top zone.
            MOVE.W  (PLAYER1Y),D0
            SUB.W   #PLRHEIGH/2,D0
            SUB.W   #2*BALLRAD,D0 ; We substract an extra ballrad/2 for hitbox.
            CMP.W   (BALLY),D0
            BGT     ENDPLR1
.BOTZONE               ; Discards bottom zone.
            MOVE.W  (PLAYER1Y),D0
            ADD.W   #PLRHEIGH/2,D0
            ADD.W   #BALLRAD/2,D0
            CMP.W   (BALLY),D0
            BLT     ENDPLR1
                        ; Confirmed: player 1 is in touch with the ball.

            MOVE.W  (BALLYSPD),D0   ; Accelerate a bit the ball towards
            ADD.W   #2,D0           ; the air.
            MULS.W  #-1,D0
            MOVE.W  D0,(BALLYSPD)
            
            MOVE.W  (PLAYER1Y),D0               ; Fix ball collision.
            SUB.W   #PLRHEIGH/2+2*BALLRAD,D0
            MOVE.W  D0,(BALLY)

            MOVE.W  (PLR1XACC),D0   ; If the player was moving in this frame,
            ADD.W   D0,(BALLXSPD)   ; the ball will receive an x boost.

ENDPLR1
; --- PLAYER2-BALL COLLISIONS ---
.PLAYER2
            MOVE.W  (PLAYER2X),D0
            MOVE.W  D0,D1
.LEFTZONE               ; Discards left zone.
            SUB.W   #BALLRAD/2+PLRWIDTH/2,D1
            CMP.W   (BALLX),D1
            BGT     ENDPLR2
.RGHTZONE               ; Discards right zone.
            MOVE.W  D0,D1
            ADD.W   #BALLRAD/2+PLRWIDTH/2,D1
            CMP.W   (BALLX),D1
            BLT     ENDPLR2
.TOPZONE               ; Discards top zone.
            MOVE.W  (PLAYER2Y),D0
            SUB.W   #PLRHEIGH/2,D0
            SUB.W   #BALLRAD*2,D0
            CMP.W   (BALLY),D0
            BGT     ENDPLR2
.BOTZONE               ; Discards bottom zone.
            MOVE.W  (PLAYER2Y),D0
            ADD.W   #PLRHEIGH/2,D0
            ADD.W   #BALLRAD/2,D0
            CMP.W   (BALLY),D0
            BLT     ENDPLR2
                        ; Confirmed: player 2 is in touch with the ball.
            
            MOVE.W  (BALLYSPD),D0   ; Accelerate a bit the ball towards
            ADD.W   #2,D0           ; the air.
            MULS.W  #-1,D0
            MOVE.W  D0,(BALLYSPD)
            
            MOVE.W  (PLAYER2Y),D0               ; Fix ball collision.
            SUB.W   #PLRHEIGH/2+BALLRAD*2,D0
            MOVE.W  D0,(BALLY)

            MOVE.W  (PLR2XACC),D0   ; If the player was moving in this frame,
            ADD.W   D0,(BALLXSPD)   ; the ball will receive an x boost.
ENDPLR2
            
; ---------------------------- LATERAL COLLISION ------------------------------
.LATERAL
            MOVE.W  (BALLXSPD),D0       ; Ball speed adds to X coordinate.
            ADD.W   D0,(BALLX)
            
; ----- BOUNDS -----
            CMP.W   #BOUNDMAR+BALLRAD,(BALLX)
            BLT     .LBOUND

            CMP.W   #SCRWIDTH-BOUNDMAR-BALLRAD,(BALLX)
            BGT     .RBOUND
            
; ----- SEPARATOR -----
            CMP.W   #SCRWIDTH/2-SEPAWIDT/2-BALLRAD-1,(BALLX)
            BLT     .ENDMOVE
   
            CMP.W   #SCRWIDTH/2+SEPAWIDT/2+BALLRAD+1,(BALLX)
            BGT     .ENDMOVE
            
            CMP.W   #SCRHEIGH-GRASHEIG-SEPAHEIG-BALLRAD-1,(BALLY)
            BLT     .ENDMOVE
            ; Separator collision
                                
            CMP.W   #0,(BALLXSPD)   ; If XSPD is positive, we touched the
            BLT     .LSEP           ; separator from the left.
.RSEP
            MOVE.W  #SCRWIDTH/2-SEPAWIDT/2-BALLRAD-1,(BALLX)
            JSR     NEGXSPD
            BRA     .ENDMOVE
.LSEP
            MOVE.W  #SCRWIDTH/2+SEPAWIDT/2+BALLRAD+1,(BALLX)  
            JSR     NEGXSPD
            BRA     .ENDMOVE    

.RBOUND
            MOVE.W  #SCRWIDTH-BOUNDMAR-BALLRAD,(BALLX)
            JSR     NEGXSPD
            BRA     .ENDMOVE
.LBOUND
            MOVE.W  #BOUNDMAR+BALLRAD,(BALLX)
            JSR     NEGXSPD
.ENDMOVE
            RTS

            
; --- UPDATE SUBRUTINES --------------------------

; IT WILL NEGATE THE X AXIS SPEED OF THE BALL,
NEGXSPD
    MOVE.W (BALLXSPD),D7
    MULS.W #-1,D7
    MOVE.W D7,(BALLXSPD)
    RTS
    
; IT WILL NEGATE THE Y AXIS SPEED OF THE BALL.
NEGYSPD
    MOVE.W (BALLYSPD),D7
    MULS.W #-1,D7
    MOVE.W D7,(BALLYSPD)
    RTS
    
; APPLIES FRICTION TO SPEED OF THE BALL. SIGN DOES NOT MATTER, IT WILL BE
; USED BEFORE OR AFTER THE NEGATION OF THE SPEED. BE VERY CAREFUL!!!
; IT SUBSTRACTS X SPEED. SPEED MUST BE POSITIVE.
FRICXSPD
    SUB.W   #BALLFRX,(BALLXSPD)
    RTS
    
; IT SUBSTRACTS Y SPEED. SPEED MUST BE POSITIVE.
FRICYSPD
    SUB.W   #BALLFRY,(BALLYSPD)
    RTS

; -----------------------------------------------------------------------------
BALLPLOT
; PLOTS THE BALL
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            
            MOVE.B #80,D0           ; Pen color task.
            MOVE.L #BALLPCOL,D1     ; Color.
            TRAP #15
            
            MOVE.B #81,D0           ; Fill color rask.
            MOVE.L #BALLFCOL,D1     ; Color.
            TRAP #15
            
            MOVE.B #88,D0           ; Draw ellipse.
            MOVE.W (BALLX),D1
            MOVE.W (BALLY),D2
            MOVE.W D1,D3
            MOVE.W D2,D4
            SUB.W #BALLRAD,D1
            SUB.W #BALLRAD,D2
            ADD.W #BALLRAD,D3
            ADD.W #BALLRAD,D4
            TRAP #15
       
            MOVEM.L (A7)+,D0-D4
            RTS






























































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
