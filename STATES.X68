; =============================================================================
; TITLE    : GAME STATE MANAGEMENT
; AUTHOR   : ODILO FORTES & MARIBEL CRESPI
; HISTORY  : XX-XXX-201X - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            MOVE.W #-1,(STACUR)
            MOVE.W #0,(STANEXT)
            
            RTS

; -----------------------------------------------------------------------------
STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STANEXT),D0
            CMP.W   (STACUR),D0
            BEQ     .DOUPD
            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .INITBL(A0),A0
            JSR     (A0)
.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .UPDTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
.INITBL     DC.L    STAINTRI,STAPLAYI,STAGOLI,STAGOVRI,STAINFOI
.UPDTBL     DC.L    STAINTRU,STAPLAYU,STAGOLU,STAGOVRU,STAINFOU

     
; -----------------------------------------------------------------------------
STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0/A0,-(A7)
            CLR.L   D0
            MOVE.W  (STACUR),D0
            LSL.L   #2,D0
            MOVE.L  D0,A0
            MOVE.L  .PLTTBL(A0),A0
            JSR     (A0)
            MOVEM.L (A7)+,D0/A0
            RTS
            
.PLTTBL     DC.L    STAINTRP,STAPLAYP,STAGOLP,STAGOVRP,STAINFOP

*******************************************************************************
; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS
            
*******************************************************************************       
; ----------------------------------------------------------------------------- 
STAINTRI
; INTRO STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR FILWRITE
            JSR FILREAD

            CLR.W (ATRBAR)  ; The attract mode loading bar starts at 0. It will
                            ; reset even if we come from instructions or game
                            ; over state.

            CLR.W (SCORE1)  ; We will init the map several times during the
            CLR.W (SCORE2)  ; game, so we only want to clear score once.
            
            MOVE.W #BASEXSPD,(PLR1XSPD)    ; BASEXSPD is the base speed. It
            MOVE.W #BASEXSPD,(PLR2XSPD)    ; only changes for IAs. They get
                                           ; bonus speed when losing. But the
                                           ; initial speed is the same for both
                                           ; human and IA.
            JSR STPSOUND

            MOVE.W #VSIA,(OPTCHSD)
            MOVE.W #DINHO2,(MSCCHSD)
            
            RTS


; -----------------------------------------------------------------------------
STAINTRU
; INTRO STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP.W #BARWIDTH,(ATRBAR)
            BNE .SKIP
            MOVE.W #ATRMODE,(OPTCHSD)
            MOVE.W #STACOUNT,(STANEXT)
            BRA .END
.SKIP
            ADDQ.W #1,(ATRBAR)

.NOATTRACT
            BTST.B  #KBDBITF1,(KBDEDGE)         ; W PRESSED?
            BEQ .NOINFO
            MOVE.W #STAINFO,(STANEXT)
.NOINFO            
            CMP #CHSMUSIC,(OPTCHSD)
            BNE .NOMUSIC
               
            BTST.B #KBDBITLF,(KBDEDGE)           ; Left key pressed?
            BNE .LEFT                          ; Yes: move left, No: skip.

            BTST.B #KBDBITRT,(KBDEDGE)           ; Right key pressed?
            BNE .RIGHT                         ; Yes: move right, No: skip.
.NOMUSIC
            BTST.B  #KBDBITUP,(KBDEDGE)
            BNE     .UP
            BTST.B  #KBDBITDN,(KBDEDGE)
            BNE     .DOWN
            BTST.B  #KBDBITPS,(KBDEDGE) ; ESPACIO
            BEQ     .END
            CMP #CHSMUSIC,(OPTCHSD)
            BEQ .END                    ; NO PUEDES INICIAR SI ESTAS EN MUSICA
            MOVE.W #STACOUNT,(STANEXT)
.END        
            RTS 

.UP         
            CMP.W #VSIA,(OPTCHSD)     ; SI YA ESTAS ARRIBA, NO AVANZAS
            BEQ .END              ; IF WE ARE YET IN THIS OPTION, WE CAN'T MOVE
            CLR.W (ATRBAR)       ; Attract mode loading bar resets.
            CMP.W #VSPLAYER,(OPTCHSD) ;SI VSPLAYER ENTONCES A VSIA
            BEQ .IAOPTION
            BRA .PLYOPTION          ; VSPLAYER, POR DECARTE
            
.DOWN       
            CMP.W #CHSMUSIC,(OPTCHSD) ; If we are in music, do nothing.
            BEQ .END
            CLR.W (ATRBAR)         ; Attract mode loading bar resets.
            CMP #VSIA,(OPTCHSD)     ; SI ESTABAS EN VSIA BAJAS A VSPLAYER
            BEQ .PLYOPTION          ; CANT SCROLL MORE
            BRA .MSCOPTION         ; POR DESCARTE

.LEFT
            CLR.W (ATRBAR)         ; Attract mode loading bar resets.
            CMP #DINHO1,(MSCCHSD)
            BEQ .CHDINHO2                ; CANT SCROLL MORE
            MOVE.W  #DINHO1,(MSCCHSD)
            BRA .END

.RIGHT
            CLR.W (ATRBAR)         ; Attract mode loading bar resets.
            CMP #DINHO2,(MSCCHSD)
            BEQ .CHDINHO1              ; CANT SCROLL MORE
            MOVE.W  #DINHO2,(MSCCHSD)
            BRA .END
            
.CHDINHO1
            MOVE.W  #DINHO1,(MSCCHSD)
            BRA .END

.CHDINHO2
            MOVE.W  #DINHO2,(MSCCHSD)
            BRA .END            

.IAOPTION
            MOVE.W #VSIA,(OPTCHSD)
            BRA .END
.PLYOPTION
            MOVE.W #VSPLAYER,(OPTCHSD)
            BRA .END
.MSCOPTION
            MOVE.W #CHSMUSIC,(OPTCHSD)
            BRA .END


; -----------------------------------------------------------------------------
STAINTRP
; INTRO STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4/A1,-(A7)

            ; First, lets plot the empty attract mode loading bar.
            
            MOVE.B #80,D0       ; PCOL.
            MOVE.L #BARCOL,D1
            TRAP #15
            
            MOVE.B #81,D0       ; FCOL ("EMPTY").
            MOVE.L #BAREMPTY,D1
            TRAP #15
            
            MOVE.B #87,D0
            MOVE.W #SCRWIDTH/2,D1
            MOVE.W #BARY,D2
            MOVE.W D1,D3
            MOVE.W D2,D4
            SUB.W #BARWIDTH/2,D1
            SUB.W #BARHEIGH/2,D2
            ADD.W #BARWIDTH/2,D3
            ADD.W #BARHEIGH/2,D4
            TRAP #15

            ; Now, lets plot the actual loaded progress of the bar.
            ; We keep D1,D2 and D4 from before. Lets temporarily save
            ; D1 in D3 to set color. Also, we want the copy in D3.
            MOVE.W D1,D3
            
            MOVE.B #81,D0       ; FCOL ("FULL").
            MOVE.L #BARCOL,D1
            TRAP #15            ; Set.
            
            MOVE.B #87,D0       ; Draw rectangle progress bar.
            
            MOVE.W D3,D1        ; Recover
            
            MOVE.W (ATRBAR),D3
            ADD.W D1,D3         ; Add progress (ATRBAR).
            TRAP #15            ; Draw.


.OPTIONS           
 ; FIRST STRING
            JSR INTROCOL
            MOVE.W #((80-20)/2)<<8|6,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR0,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
             
                       
 ; GAME OPTION
            CMP #VSIA,(OPTCHSD)
            BNE .NOVSIA
            JSR NUMCOL
.NOVSIA            
            MOVE.W #((80-20)/2)<<8|12,D1 ; VS IA
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR1,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
            JSR INTROCOL
            
 ; THIRD STRING           
            CMP #VSPLAYER,(OPTCHSD)     ; PVP
            BNE .NOPLAYER
            JSR NUMCOL
.NOPLAYER
            
            MOVE.W #((80-20)/2)<<8|14,D1 ; TEXTO
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR2,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
            JSR INTROCOL
            
;--- OBA OBA
             CMP #DINHO1,(MSCCHSD)
             BNE .ISDINHO2
            
             CMP #CHSMUSIC,(OPTCHSD)     ; PVP
             BNE .NOMUSIC1
             JSR NUMCOL
  
            
.NOMUSIC1        
            MOVE.W #((80-20)/2)<<8|16,D1 ; OBA OBA TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR4,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
            JSR INTROCOL
            BRA .LSTSTRNG
            
;--- SAMBA     
.ISDINHO2    
            CMP #CHSMUSIC,(OPTCHSD)     ; MUSICA
            BNE .NOMUSIC2
 
            JSR NUMCOL

.NOMUSIC2
            MOVE.W #((80-20)/2)<<8|16,D1 ; SAMBA TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR5,A1  ; STRING POINTER
            MOVE.B #13,D0
            
            TRAP #15
            JSR INTROCOL
; FOURTH STRING      
.LSTSTRNG     
            
            MOVE.W #((80-28)/2)<<8|20,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR6,A1  ; STRING POINTER
            MOVE.B #13,D0
            
            TRAP #15            
            
            
            BTST.B #3,(SCRCYCCT)
            BEQ .END
            MOVE.W #((80-22)/2)<<8|22,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR3,A1  ; STRING POINTER
            MOVE.B #13,D0
            
            TRAP #15            
            
            
.END            
            MOVEM.L (A7)+,D0-D4/A1
            RTS
            

            
.STR0       DC.B     'SUPER TENNIS 68K',0 ; 16 CHARACTERS
.STR1       DC.B     'PLAYER VS IA',0 ;12 CHARACTERS
.STR2       DC.B     'PLAYER VS PLAYER',0 ; 16 CHARACTERS
.STR3       DC.B     'PRESS SPACE TO PLAY!!',0 ; 22 CHARS
.STR4       DC.B     'SONG:  < OBA OBA >',0 // 20 CHARACTERS
.STR5       DC.B     'SONG:  <  SAMBA  >',0 // 18 CHARACTERS
.STR6       DC.B     'PRESS W TO SEE INSTRUCTIONS',0 ; 27 CHARS ->28
            DS.W 0       

; -----------------------------------------------------------------------------
STAINFOI
; MENU STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
STAINFOU
; MENU STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

            BTST.B  #KBDBITF1,(KBDEDGE)         ; W PRESSED?
            BEQ .NOW
            MOVE.W #STAINTRO,(STANEXT)
.NOW
            RTS

; -----------------------------------------------------------------------------
STAINFOP
; MENU STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)
            JSR INTROCOL
            
            MOVE.W #((80-60)/2)<<8|6,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR0,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15

            MOVE.W #((80-60)/2)<<8|8,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR1,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
            
            MOVE.W #((80-60)/2)<<8|10,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR2,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15

            MOVE.W #((80-60)/2)<<8|14,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR3,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
            
            MOVE.W #((80-60)/2)<<8|16,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR4,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15

            MOVE.W #((80-60)/2)<<8|18,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR5,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15    

            MOVE.W #((80-60)/2)<<8|20,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR6,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15  
     
            BTST.B #3,(SCRCYCCT)
            BEQ .END
            MOVE.W #((80-60)/2)<<8|24,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR7,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15   
.END            
            MOVEM.L (A7)+,D0-D1/A1
            RTS
            
.STR0       DC.B     'GAME CONTROLS:',0 
.STR1       DC.B     'WASD TO MOVE PLAYER 1.',0 
.STR2       DC.B     'ARROWS TO MOVE PLAYER 2.',0 
.STR3       DC.B     'ABOUT THE GAME:',0 
.STR4       DC.B     'DO NOT LET THE BALL TOUCH YOUR ZONE 3 TIMES IN A ROW.',0 
.STR5       DC.B     'IF THAT HAPPENS, THE RIVAL GETS 1 POINT.',0
.STR6       DC.B     'THE FIRST TO SCORE 7 POINTS WIN.',0 
.STR7       DC.B     'PUSH W TO RETURN TO MENU',0 
            DS.W 0
            

; -----------------------------------------------------------------------------
STAPLAYI
; PLAY STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR LOADMUSI
            JSR PLAYMUSI
            JSR MAPINIT
            JSR MAPPLOT
            
            JSR PLR1INIT
            JSR PLR2INIT
            
            JMP BALLINIT

; -----------------------------------------------------------------------------
STAPLAYU
; PLAY STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP.W #ATRMODE,(OPTCHSD)    ; Check keys to return in attract mode.
            BNE .SKIP
            JSR STAATRU
.SKIP
            JSR MAPUPD

            JSR PLR1UPD
            JSR PLR2UPD
            
            JSR BALLUPD    
            
            CMP #MAXSCORE,(SCORE1)
            BEQ .GAMEOVER
            CMP #MAXSCORE,(SCORE2)
            BEQ .GAMEOVER
            RTS
.GAMEOVER
            MOVE.W #STAGOVER,(STANEXT)
            
; -----------------------------------------------------------------------------
STAPLAYP
; PLAY STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR MAPPLOT
            
            JSR PLR1PLOT
            JSR PLR2PLOT
            
            JSR BALLPLOT
            
            CMP.W #ATRMODE,(OPTCHSD)    ; Display text during attract mode.
            BNE .RTS
            JMP STAATRP     
.RTS
            RTS
            

*******************************************************************************
; -----------------------------------------------------------------------------
STAGOLI
; AFTER GOAL STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            ;MOVE.W #STAGOVER,(STANEXT)
            JSR MAPINIT
            JSR BALLINIT
            JSR PLR1INIT
            JSR PLR2INIT
            
            CLR.B (SCRCYCCT)
            
            JSR COUNTINIT
            CMP #2,(MSCCHSD)
            BEQ .END
            CMP #6,(SCORE1)
            BEQ .COLMUSIC
            CMP #6,(SCORE2)
            BEQ .COLMUSIC
.END
            RTS
.COLMUSIC
            MOVE.W #2,(MSCCHSD)
            JSR STPSOUND
            JSR LOADMUSI
            JMP PLAYMUSI

; -----------------------------------------------------------------------------
STAGOLU
; AFTER GOAL STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP.W #ATRMODE,(OPTCHSD)    ; Check keys to return in attract mode.
            BNE .SKIP
            JSR STAATRU
.SKIP            
            JSR COUNTUPD  ; STATE CHANGES INSIDE COUNTUPD

.RTS                      
            RTS

; -----------------------------------------------------------------------------
STAGOLP
; AFTER GOAL STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            
            JSR MAPPLOT
            JSR BALLPLOT
            JSR PLR1PLOT
            JSR PLR2PLOT
            
            JSR NUMCOL
            JSR COUNTPLOT
            
            CMP.W #ATRMODE,(OPTCHSD)    ; Display text during attract mode.
            BNE .RTS
            JMP STAATRP     
.RTS
            RTS



*******************************************************************************
; -----------------------------------------------------------------------------
STAGOVRI
; GAME OVER STATE INIT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
STAGOVRU
; GAME OVER STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B #KBDBITPS,(KBDEDGE)
            BEQ    .RTS
            MOVE.W #STAINTRO,(STANEXT)
            
            CMP.W #ATRMODE,(OPTCHSD)    ; Check keys to return in attract mode.
            BNE .RTS
            JSR STAATRU
.RTS
            RTS
            

; -----------------------------------------------------------------------------
STAGOVRP
; GAME OVER STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D1/A1,-(A7)
            
            JSR MAPPLOT
            JSR PLR1PLOT
            JSR PLR2PLOT
            JSR BALLPLOT
            JSR NUMCOL
            
            ; Depending on the gamemode and results, we will
            ; display diferent text. We also have to check
            ; attract mode game over.
            ; 0=vsIA, 1=vsPLAYER, 3=Attract mode
            
            ; We will ALWAYS display "GAME OVER!".
            MOVE.W #((80-12)/2)<<8|12,D1        ; COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR0,A1                      ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15

            ; If attract mode, we will just ask to press any key.
            CMP.W #ATRMODE,(OPTCHSD)
            BNE .SKIP
            JSR STAATRP  
            BRA .RTS
.SKIP            
            ; In pvp and pvb (player vs player and players vs bot).
            ; We will say 'PRESS SPACE TO RESTART!!'.
            BTST.B #3,(SCRCYCCT)
            BEQ .SKIP2
            
            MOVE.W #((80-26)/2)<<8|20,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR1,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
.SKIP2       
            ; Lets check if the mode is VSIA or VSPLAYER.
            CMP.W #VSIA,(OPTCHSD)
            BEQ .VSIA
.VSPLAYER            
            CMP.W #MAXSCORE,(SCORE1)    ; Check winner.
            BEQ .PVPPLR1
            BRA .PVPPLR2
            
.VSIA
            CMP.W #MAXSCORE,(SCORE1)    ; Check winner.
            BEQ .PVBPLR
            BRA .PVBIA
.RTS     
            MOVEM.L (A7)+,D0-D1/A1
            RTS
; -- 4 POSSIBILITIES --
.PVBPLR
            ; PLAYER WON
            MOVE.W #((80-34)/2)<<8|18,D1
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR2,A1
            MOVE.B #13,D0
            TRAP #15
            BRA .RTS
.PVBIA
            ; IA WON
            MOVE.W #((80-26)/2)<<8|18,D1
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR3,A1
            MOVE.B #13,D0
            TRAP #15
            BRA .RTS
.PVPPLR1
            ; PLAYER 1 WON
            MOVE.W #((80-20)/2)<<8|18,D1
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR4,A1
            MOVE.B #13,D0
            TRAP #15
            BRA .RTS
.PVPPLR2
            ; PLAYER 2 WON
            MOVE.W #((80-20)/2)<<8|18,D1
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR5,A1
            MOVE.B #13,D0
            TRAP #15
            BRA .RTS

            
.STR0       DC.B     ' GAME OVER! ',0                       ; ALL MODES
.STR1       DC.B     ' PRESS SPACE TO RESTART!! ',0         ; PVP & PVB
.STR2       DC.B     ' WELL DONE, YOU ARE RONALDINHO!!! ',0 ; PVB (PLAYER WIN)
.STR3       DC.B     ' BETTER LUCK NEXT TIME XD ',0         ; PVB (IA WIN)
.STR4       DC.B     ' PLAYER 1 VICTORY!! ',0               ; PVP (PLAYER1 WIN)
.STR5       DC.B     ' PLAYER 2 VICTORY!! ',0               ; PVP (PLAYER2 WIN)
            DS.W 0

; -----------------------------------------------------------------------------
STAATRU
; ATTRACT MODE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CLR.W D7
            MOVE.B (KBDVAL),D7          ; Update flags by moving a byte.
            BEQ .RTS
            MOVE.W #STAINTRO,(STANEXT)
.RTS
            RTS
            
; -----------------------------------------------------------------------------
STAATRP
; ATTRACT MODE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BTST.B #3,(SCRCYCCT)
            BEQ .END
            
            MOVEM.L D0-D1/A1,-(A7)      ; We only save if we go in.
            
            JSR NUMCOL
            
            MOVE.W #((80-24)/2)<<8|20,D1 ; FIRST TEXT COORDINATES
            MOVE.B #11,D0
            TRAP #15
            
            LEA.L .STR0,A1  ; STRING POINTER
            MOVE.B #13,D0
            TRAP #15
            
            MOVEM.L (A7)+,D0-D1/A1      ; Recover.
.END            
            RTS

.STR0       DC.B    ' PRESS ANY KEY TO START ',0   ;24 CHARS
            DS.W    0
            



























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
