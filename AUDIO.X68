; =============================================================================
; TITLE    : AUDIO 
; AUTHOR   : ODILO FORTES & MARIBEL CRESPI
; HISTORY  : 
;-------------------------------------------------------------------------------

        
        
; -----------------------------------------------------------------------------
LOADMUSI
; LOADS ALL SOUND FILES ON MEMORY
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            ;Guardar registros
            MOVEM.L     D0-D2/A1,-(A7)
            
            CMP #1,(MSCCHSD) 
            BEQ .PLAYM2         ; BRANCH IF THE PLAYER WANTS TO LISTEN SAMBA
            CMP #0,(MSCCHSD)
            BEQ .PLAYM1         ; BRANCH IF THE PLAYER WANTS TO LISTEN OBA OBA
            LEA.L .MUSIC3,A1
.DOIT                            
            MOVE.W       #70,D0              ; Task for sound
            
            TRAP        #15                  ; Trap
            ;Restaurar registros
            MOVEM.L     (A7)+,D0-D2/A1
            RTS
            
.PLAYM2
            LEA.L .MUSIC2,A1 ; SAMBA 
            BRA .DOIT
.PLAYM1
            LEA.L .MUSIC1,A1 ; OBA OBA
            BRA .DOIT

; RUTAS DE ARCHIVOS -----------------------------------------------------------

.MUSIC1      DC.B    'MEDIA/OBA.wav',0
.MUSIC2      DC.B    'MEDIA/Samba.wav',0
.MUSIC3      DC.B    'MEDIA/LAST.wav',0
             DS.W    0
             
.LOADSONG    DC.L    .MUSIC1,.MUSIC2             
                

; -----------------------------------------------------------------------------
PLAYMUSI
; PLAYS SOUNDS DURING GAME PLAY
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0,-(A7)
            
            MOVE.B #71,D0
            TRAP #15
            
            MOVEM.L (A7)+,D0
            RTS

; -----------------------------------------------------------------------------
STPSOUND
; STOPS ALL THE SONGS
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
        
        
        MOVE.W #76,D0
        MOVE.L #3,D2
        TRAP #15
        RTS
        
      





















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
