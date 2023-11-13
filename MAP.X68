*-----------------------------------------------------------
* Title      : MAP RELATED THINGS
* Written by : ODILO FORTES & MARIBEL CRESPI
* Date       : 
* Description:
*-----------------------------------------------------------

; -----------------------------------------------------------------------------
MAPINIT
; INITS THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CLR.W   (WARNING1)
            CLR.W   (WARNING2)
            
            RTS

; -----------------------------------------------------------------------------
MAPUPD
; UPDATES THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            CMP.W   #(SCRWIDTH+SEPAWIDT)/2,(BALLX)
            BLT     .NEXT1
            CLR.W   (WARNING1)
            RTS
.NEXT1
            CMP.W   #(SCRWIDTH-SEPAWIDT)/2,(BALLX)
            BGT     .END
            CLR.W   (WARNING2)
.END
            RTS

; -----------------------------------------------------------------------------
MAPPLOT
; PLOTS THE MAP
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

           MOVEM.L D0-D4,-(A7)      ; Guardamos todos los registros en la pila.

;----------------------     FONDO DE COLOR AZUL CIELO       -------------------

           MOVE.B #80,D0            ; Task para el color del contorno.
           MOVE.L #BACKGCOL,D1      ; Color cian.
           TRAP #15                 ; Set.
           
           MOVE.B #81,D0            ; Task para el color de relleno.
           ;MOVE.L #BACKGCOL,D1     ; Mismo color, ya lo tenemos en D1.
           TRAP #15                 ; Set.
           
           
           MOVE.B #87,D0            ; Task para dibujar un rectangulo(fondo).
                                    ; Dejaremos un borde negro por defecto.
           MOVE.W #BOUNDMAR,D1                  ; Origen X.
           MOVE.W #BOUNDMAR,D2                  ; Origen Y.
           MOVE.W #SCRWIDTH-BOUNDMAR-1,D3       ; Final X.
           MOVE.W #SCRHEIGH-BOUNDMAR-1,D4       ; Final Y.
           TRAP #15                             ; Set.
           
;--------------------       CÉSPED DE LA PISTA          -----------------------
            
           MOVE.B #80,D0            ; Task para el color del contorno.
           MOVE.L #GRASPCOL,D1      ; Color verde oscuro.
           TRAP #15                 ; Set.
           
           MOVE.B #81,D0            ; Task para el color de relleno.
           MOVE.L #GRASFCOL,D1      ; Color verde claro.
           TRAP #15                 ; Set.
           
           MOVE.B #87,D0            ; Task para dibujar un rectangulo(hierba).
           MOVE.W #BOUNDMAR,D1                  ; Origen X.
           MOVE.W #SCRHEIGH-GRASHEIG,D2         ; Origen Y.
           ;MOVE.W #SCRWIDTH-BOUNDMAR-1,D3      ; D3 y D4 igual que antes.
           ;MOVE.W #SCRHEIGH-BOUNDMAR-1,D4
           TRAP #15                             ; Set.

;--------------------       DETALLES DE LA PISTA (LINEAS)         -------------

           MOVE.B #80,D0            ; Task para el color del contorno.
           MOVE.L #LINECOL,D1       ; Color blanco.
           TRAP #15                 ; Set
           
           MOVE.B #81,D0            ; Color de relleno
           ;MOVE.L #LINECOL,D1      ; Color blanco, lo tenemos de antes.
           TRAP #15                 ; Set.
           
           MOVE.B #87,D0            ; Task para dibujar un rectangulo(linea 1).
           MOVE.W #BOUNDMAR,D1                      ; Origen X.
           ;MOVE.W SCRHEIGH-GRASHEIG,D2             ; Origen Y, de antes.
           ;MOVE.W #SCRWIDTH-BOUNDMAR-1,D3          ; Final X, de antes.
           MOVE.W #SCRHEIGH-GRASHEIG+LINEWIDT,D4    ; Origen Y + LINEWIDT.
           TRAP #15                                 ; Set.
           
           MOVE.B #87,D0            ; Task rectangulo, para la linea central.
           MOVE.W #SCRWIDTH/2-LINEWIDT/2-1,D1      
           ;MOVE.W #SCRHEIGH-GRASHEIG,D2            ; Origen Y, de antes.
           MOVE.W #SCRWIDTH/2+LINEWIDT/2+1,D3
           MOVE.W #SCRHEIGH-BOUNDMAR-1,D4
           TRAP #15
           
; ---------------------- SCOREBOARD -------------------------------------------
; Lets draw the two boards that show the players score.

    ; -- DRAW OUTER LEFT RECTANGLE
           MOVE.B #80,D0            ; Pen color task.
           MOVE.L #SCBOPCOL,D1      ; Color.
           TRAP #15
           
           MOVE.B #81,D0            ; Fill color task.
           MOVE.L #SCBOCOL1,D1      ; Color
           TRAP #15
            
           MOVE.B #87,D0            ; Lets draw the outer rectangle.
           MOVE.W #SCRWIDTH/4,D1
           MOVE.W #SCRHEIGH/4,D2
           MOVE.W D1,D3
           MOVE.W D2,D4
           SUB.W #SCBOWIDT/2,D1
           SUB.W #SCBOHEIG/2,D2
           ADD.W #SCBOWIDT/2,D3
           ADD.W #SCBOHEIG/2,D4
           TRAP #15
           
    ; -- DRAW OUTER RIGHT RECTANGLE (FEW MODIFICATIONS)
    
           MOVE.B #81,D0            ; Change color for the right team
           MOVE.L #SCBOCOL2,D1
           TRAP #15
    
           MOVE.B #87,D0            ; Getting the D1 value again
           MOVE.W #SCRWIDTH/4-SCBOWIDT/2,D1
           
           ADD.W #SCRWIDTH/2,D1    ; If we add SCRWIDTH/2, we will get the same
           ADD.W #SCRWIDTH/2,D3    ; rectangle on the opposite half(intended).
           TRAP #15

    ; -- DRAW INNER LEFT RECTANGLE
           
           MOVE.B #80,D0            ; Pen color task.
           MOVE.L #SCBOPCOL,D1      ; Color.
           TRAP #15
           
           MOVE.B #81,D0            ; Fill color task.
           MOVE.L #SCBOFCOL,D1      ; Color.
           TRAP #15
           
           MOVE.B #87,D0            ; Lets draw the inner rectangle.
           MOVE.W #SCRWIDTH/4,D1
           MOVE.W #SCRHEIGH/4,D2
           MOVE.W D1,D3
           MOVE.W D2,D4
           SUB.W #SCBOWIDT/2-SCBOMARG,D1
           SUB.W #SCBOHEIG/2-SCBOMARG,D2
           ADD.W #SCBOWIDT/2-SCBOMARG,D3
           ADD.W #SCBOHEIG/2-SCBOMARG,D4
           TRAP #15
           
           ADD.W #SCRWIDTH/2,D1     ; Draw inner rectangle on opposite half.
           ADD.W #SCRWIDTH/2,D3
           TRAP #15

    ; -- NOW DRAW SCORES

           JSR  DRAWSC1
           JSR  DRAWSC2
           
    ; -- BALL TOUCHED GROUND WARNINGS(COLORING THE LINES DIFFERENTLY)
            
           CMP.W #0,(WARNING1)      ; If no warnings1, dont color ground.
           BEQ .NOWARN1
           
           JSR .WARNCOL
           MOVE.W #BOUNDMAR,D1      ; X1 OF LEFT FIELD
           MOVE.W #SCRWIDTH/2,D3    ; X2 OF LEFT FIELD
           
           BRA .DRAWWARN
.NOWARN1
           CMP.W #0,(WARNING2)      ; If no warnings2, dont color ground.
           BEQ .RED
           
           JSR .WARNCOL
           MOVE.W #SCRWIDTH/2,D1
           MOVE.W #SCRWIDTH-BOUNDMAR,D3

.DRAWWARN
           BTST.B #3,(SCRCYCCT)
           BEQ .RED

           MOVE.B #87,D0            ; DRAW RECTANGLE TASK.
           MOVE.W #SCRHEIGH-GRASHEIG,D2             ; TOP LEFT Y
           MOVE.W #SCRHEIGH-GRASHEIG+LINEWIDT,D4    ; BOTTOM RIGHT Y
           TRAP #15
           
           
.RED

; -------------------           RED DE JUEGO      -----------------------------     
           
           MOVE.B #80,D0            ; Task pen color
           MOVE.L #SEPAPCOL,D1      ; Contorno negro
           TRAP #15
           
           MOVE.B #81,D0            ; Task fill color
           MOVE.L #SEPAFCOL,D1      ; Verde oscuro
           TRAP #15
           
           MOVE.B #87,D0            ; Task rectangulo grande
           MOVE.W #SCRWIDTH/2-SEPAWIDT/2,D1
           MOVE.W #SCRHEIGH-GRASHEIG-SEPAHEIG,D2    ; Altura del separador
           MOVE.W #SCRWIDTH/2+SEPAWIDT/2,D3
           MOVE.W #SCRHEIGH-GRASHEIG,D4
           TRAP #15           
           
           MOVE.W #SCRWIDTH/2-SESUWIDT/2,D1
           MOVE.W D4,D2
           MOVE.W #SCRWIDTH/2+SESUWIDT/2,D3
           MOVE.W #SCRHEIGH-GRASHEIG+SESUHEIG,D4
           TRAP #15
           
.ENDPLOT
           MOVEM.L (A7)+,D0-D4      ; Restauramos todos los registros    
           RTS

; -- SET WARNING COLOR (USED IN WARNING) --------------------------------------
.WARNCOL
           CMP.W #1,(WARNING1)      ; If the warning count is 1, then the color
           BEQ .WARN1               ; will be yellow. (Have to check both).
           CMP.W #1,(WARNING2)
           BEQ .WARN1
                                    ; Else, the color is red (1+ warning).
.WARN2
           MOVE.L #WARN2COL,D1
           BRA .SET

.WARN1
           MOVE.L #WARN1COL,D1
.SET

           MOVE.B #80,D0            ; PEN COLOR TASK.
                                    ; COLOR IS ALREADY SET.
           TRAP #15                 ; SET.
           
           MOVE.B #81,D0            ; FILL COLOR TASK.
                                    ; COLOR IS ALREADY SET.
           TRAP #15                 ; SET.
           
           RTS




























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
