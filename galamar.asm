;   _____              _                   __  __              _____  
;  / ____|     /\     | |          /\     |  \/  |     /\     |  __ \ 
; | |  __     /  \    | |         /  \    | \  / |    /  \    | |__) |
; | | |_ |   / /\ \   | |        / /\ \   | |\/| |   / /\ \   |  _  / 
; | |__| |  / ____ \  | |____   / ____ \  | |  | |  / ____ \  | | \ \ 
;  \_____| /_/    \_\ |______| /_/    \_\ |_|  |_| /_/    \_\ |_|  \_\
;
;
; 							A TI-84 Shooter
;					 Ryan Baldwin (rabaldwi@ncsu.edu)     
;
;
; Program Name: Galamar (and other various tests)
; Author: 		Ryan Baldwin (rabaldwi@ncsu.edu)
; Version:		0.1a
; Date: 		16/5/2017

.nolist

temp1			.equ cmdShadow
playerx			.equ temp1					;2 bytes
playery			.equ playerx+2				;2 bytes
player_img		.equ playery+2				;2 more bytes
time_delay		.equ player_img+2			;additional two more bytes of space
fire_pressed	.equ time_delay+1
bullets			.equ fire_pressed+1
star1y			.equ bullets+2
temp2			.equ savesscreen
star2y			.equ temp2
star3y			.equ star2y+2
star4y			.equ star3y+2
star5y			.equ star4y+2
star6y			.equ star5y+2
laserpower		.equ star6y+2
.list

ASMStart:

#define bcall(label) rst $28 \ .dw label

;Initialize game screen and start loop
InitGame:
	ld      a,1
    out     ($20),a         ; maximum CPU speed
    ld      a,$45
    out     ($30),a         ; set timer frequency to 2048Hz
		
	bcall(_ClrLCDFull)
	
   	call 	ShowTitle		 	; clears the screen, show title when created
	call	LoadStars
	call 	DrawPlayerStart 	; draws player starting position
	call	DrawLevel
	ld		a, 20
	ld		(time_delay), a		; record our time delay
	call 	timer_wait_done
	jp		Display_Normal
	
	