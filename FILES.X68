*------------------------------------------------------------------------------
* Title      : FILES MANAGEMENT OF WRITE AND READ
* Written by : ODILO FORTES & MARIBEL CRESPI
* Date       :
* Description:
*------------------------------------------------------------------------------


; -----------------------------------------------------------------------------
FILWRITE
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------
;------------------------------------------------------------------------------
        
        MOVEM.L  D0-D2/A1,-(A7) ; SAVE REGISTERS
        MOVE.W #IAXEXTRA,(SPEEDFIL)
;------------------          CLOSE FILES         -----------------------------
        MOVE.W  #50,D0                  ; TASK TO CLOSE ALL FILES
        TRAP    #15       
;-----------------           OPEN FILE        ---------------------------------
        LEA.L   DIRFILE,A1          ; EN A1 METEMOS LA DIRECCION DEL FICHERO
        MOVE.W   #51,D0             ; TASK TO OPEN THE FILE  
        TRAP    #15     

;------------------          WRITE FILE     -----------------------------------      
        ;PREPARAR TRAP 54
        LEA.L   SPEEDFIL,A1
        MOVE.L  #SIZEINT,D2             ; TAMAÑO DE UN INT
        MOVEQ   #54,D0                  ; ESCRIBIR NUEVA PARTIDA EN EL FICHERO 
        TRAP    #15
;-----------------         CLOSE FILES        --------------------------------        
        MOVE.W   #50,D0
        TRAP    #15     
        MOVEM.L  (A7)+,A1/D0-D2
        RTS  
        
        
; -----------------------------------------------------------------------------
FILREAD
; INPUT     - NONE
; OUTPUT    - NONE
; MODIFIES  - NONE
; -----------------------------------------------------------------------------

        MOVEM.L  D0-D2/A1,-(A7) ; SAVE REGISTERS
;------------------          CLOSE FILES         -----------------------------
        MOVE.W  #50,D0                  ; TASK TO CLOSE ALL FILES
        TRAP    #15       
;-----------------           OPEN FILE        ---------------------------------
        LEA.L   DIRFILE,A1           ; EN A1 METEMOS LA DIRECCION DEL FICHERO     
        MOVEQ   #51,D0               ; TASK TO OPEN THE FILE  
        TRAP    #15
;----------------            READ FILE      -----------------------------------
        ;READ THE LAST SCORE
        MOVEQ.L #SIZEINT,D2          ; NUMERO DE BYTES A LEER
        MOVEQ   #53,D0                ; TAREA PARA LEER UN FICHERO
        LEA.L   SPEEDIA,A1           ; EL BUFFER DE DATOS SERÁ PLRGAMES
        TRAP    #15
;-----------------         CLOSE FILES        --------------------------------
        MOVEQ   #50,D0
        TRAP    #15     
        MOVEM.L  (A7)+,A1/D0-D2
        RTS  
        
; --- VARIABLES Y CONSTANTES DE FICHERO ---------------------------------------
SIZEINT    EQU     4                     ; tamaño de un entero (dato a salvar)
SPEEDFIL   DS.L    1                      ; BUFFER FOR DATA READ FROM FILE
SPEEDIA    DS.L    1                      ; PLAYER GAMES BUFFER DE LECTURA
DIRFILE    DC.B    'FILES/SPEEDIA.txt',0 ; path a fichero donde salvar score
           DS.W    0










*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
