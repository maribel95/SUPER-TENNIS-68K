# SUPER-TENNIS-68K
Tennis video game programmed with the easy68k assembler.
It consists of two squares hitting a ball until they reach 6 points.

The original idea of this game is based on the popular game Sports Heads: Tennis Open.

In this case we find a small two-part map through a stick in the center, which represents the network. You will have to beat your opponent in tennis. It is a game designed for 2 players, where you will have to maneuver a square on the court. Time your jumps well to hit the ball and pass it to the other side with the intention of beating your rival. If the ball touches thrice your field, then you lose the game. One touch will be indicated by yellow color. The second touch will be notified as red colour. When the ball touches your rival field, then you will be safe again.

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
- [X] Key codes.
- [X] Screen dimensions.
- [X] Dynamic memory constants.

### SYSTEM.X68 FILE

- [X] Initializes the screen, screen-related interrupt and vars.
- [X] System initializes.
- [X] Manages screen timer, increases the interrupt counter and updates double buffer.
- [X] Trap service routine in charge of displaying current frame and clearing buffer for the next one.
- [X] Initializes system variables.
- [X] Updates system variables.
- [X] Dynamic memory management.
- [X] Manage output pointers.

### CONST.X68 FILE

- [X] Map related constants like background color, grass height, width of separatos, ...
- [X] Players related constants like width and hegiht of square, base speed stat, color of each player, ...
- [X] Ball related constants like its radius, friction applied to the ball, color, ...
- [X] Scoreboard related constants like width, height, color, ...
- [X] Score number related constants, like background color, ... 
- [X] State related constants, for managing menu options.

### STATES.X68 FILE

Here we can find subroutines that manages the possible game states.

- [X] State manager.
- [X] Perform init state and update state.
- [X] Performs state plot.
- [X] Empty subroutine for cases with nothing to do.

And then, these are the differents states or screens which game is able to run. In each one of them we would find both init, update and plot subroutines.

-  Intro.
-  Menu.
-  Play.
-  After goal.
-  Game Over.
-  Attract mode.


### MAP.X68 FILE

Manages all the things related to the map. Here we find subroutines which inits, updates and plots the map.

- [X] Grass color, sky color, lines court.
- [X] Scoreboard.
- [X] Warning lines.
- [X] Draws the tennis net.


### PLAYER1.X68 AND PLAYER2.X68 FILES

In that files is managed the interactions of each players. Both are practically the same, but in player2 file there are the extra code for the IA movement.

- [X] Initializes player.
- [X] Updates player motion: gravity, checking ground, pressed keys.
- [X] Plots the player.

### BALL.X68 FILE

- [X] Manages players and map limits colisions.
- [X] Init, update and plot.
- [X] Manages gravity, speed, friction.

### NUMBERS.X68 FILE

- [X] Draws each scoreboard number in the map.

### AUDIO.X68 FILE 

- [X] Load, plays and stop music.
- [X] Management of file music rutes.

### COUNTDOWN.X68 FILE

- [X] Manages countdown numbers
- [X] Inits the ball

### FILES.X68 FILE

Manages input and output file operations. Basically read and write instructions.

## Game images:

Game over against the AI:
![Captura de pantalla 2023-11-22 113925](https://github.com/maribel95/SUPER-TENNIS-68K/assets/61268027/8f0c97dd-3dd7-477e-bbb6-22eab8e58aca)

Yellow warning of the field line:
![Captura de pantalla 2023-11-22 113833](https://github.com/maribel95/SUPER-TENNIS-68K/assets/61268027/507b1a09-cd41-42c9-853b-e46adf2794cf)

Red warning:

![Captura de pantalla 2023-11-22 113804](https://github.com/maribel95/SUPER-TENNIS-68K/assets/61268027/5e6baf0d-1a00-4005-8da1-4bb5dcf94a2f)

Beginning of the game countdown:

![Captura de pantalla 2023-11-22 113753](https://github.com/maribel95/SUPER-TENNIS-68K/assets/61268027/4b2640d6-1f3d-4eba-b24b-29856835cd1e)












