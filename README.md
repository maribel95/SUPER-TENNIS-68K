# SUPER-TENNIS-68K
Tennis video game programmed with the easy68k assembler.
It consists of two squares hitting a ball until they reach 6 points.

The original idea of this game is based on the popular game Sports Heads: Tennis Open.

In this case we find a small two-part map through a stick in the center, which represents the network. You will have to beat your opponent in tennis. It is a game designed for 2 players, where you will have to maneuver a square on the court. Time your jumps well to hit the ball and pass it to the other side with the intention of beating your rival.

In the main menu you can find the following options:
  - Manual
  - Choose between two Brazilian songs
  - Play alone or against a friend
  - Record mode. That is, if the player does not press any button for a certain period of time, an automatic video of what the game is like will be played.

## Code:

Next, we are going to explain a little how the game code has been built, in order to better understand how it works and what options it presents. In the main file we can find all the includes that allow the game to start:

```assembler

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

### SYSCONST.X68 FILE

In this we find all the constant values of the game. In particular for the management of:

- [X] Trap routines for system interruptions.
- [X] Key codes
- [X] Screen dimensions
- [X] Dynamic memory constants

### SYSTEM.X68 FILE

- [X] Initializes the screen, screen-related interrupt and vars.
- [X] System initializes.
- [X] Manages screen timer, increases the interrupt counter and updates double buffer.
- [X] Trap service routine in charge of displaying current frame and clearing buffer for the next one.
- [X] Initializes system variables
- [X] Updates system variables
- [X] Dynamic memory management.
- [X] Manage output pointers

### CONST.X68 FILE



