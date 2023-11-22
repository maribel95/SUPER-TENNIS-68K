# SUPER-TENNIS-68K
Tennis video game programmed with the easy68k assembler.

It consists of two squares hitting a ball until they reach 6 points.

Includes:
  - Manual
  - Choose between two Brazilian songs
  - Play alone or against a friend
  - Record mode. That is, if the player does not press any button for a certain period of time, an automatic video of what the game is like will be played.


In the main file we would find the following includes:

```assembler

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

```
