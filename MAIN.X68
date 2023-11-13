.
; =============================================================================
; TITLE    : SUPER TENNIS
; AUTHOR   : ODILO FORTES & MARIBEL CRESPI
; HISTORY  : 10-OCT-2020 - CREATION
;            11-OCT-2020 - MINOR CHANGES
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

            INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; GAME CONSTANTS
            
            INCLUDE "STATES.X68"            ; MANEJO DE LOS ESTADOS
            INCLUDE "MAP.X68"               ; MAPA DE LA PISTA
            INCLUDE "PLAYER1.X68"           ; JUGADOR 1
            INCLUDE "PLAYER2.X68"           ; JUGADOR 2
            INCLUDE "BALL.X68"              ; PELOTA
            INCLUDE "NUMBERS.X68"           ; DIBUJADO DE PUNTUACIONES
            INCLUDE "AUDIO.X68"             ; AUDIO
            INCLUDE "COUNTDOWN.X68"         ; CUENTA ATRAS
            INCLUDE "FILES.X68"             ; TXT
            
            
            
            

; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT                 ; INITIALIZE SYSTEM-RELATED STUFF

            JSR     STAINIT                 ; INICIAMOS EL ESTADO DEL JUEGO


; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            JSR     STAUPD                  ; ACTUALIZAMOS LA LOGICA DEL JUEGO

; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            JSR     STAPLOT                 ; ACTUALIZAMOS LOS GRAFICOS

            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP                   ; MAIN LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START













































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
