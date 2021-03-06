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
; Version:		0.3a
; Date: 		2/6/2017

.nolist
temp1			.equ cmdShadow
playerx			.equ temp1
playery			.equ playerx+2
rightcount		.equ playery+2
leftcount		.equ rightcount+2
.list

ASMStart:

#define bcall(label) rst $28 \ .dw label
#define push_all	push af \ push bc \ push de \ push hl \ push ix \ push iy
#define	pop_all		push iy \ pop ix \ pop hl \ pop de \ pop bc \ pop af 
 
;Initialize game screen and start loop
InitGame:
	push    iy
	ld      a,1
    out     ($20),a         ; maximum CPU speed
    ld      a,$45
    out     ($30),a         ; set timer frequency to 2048Hz
	
	ld		hl, 0
	ld 		(playerx), hl
	ld		hl, 240-16
	ld		(playery), hl
	
	call    resetrightcount
	call    resetleftcount
		
	bcall(_ClrLCDFull)
	
	
   	call 	ShowTitle		 	; clears the screen, show title when created
	call	LoadStars
	call 	DrawPlayer	     	; draws player starting position
	call	DrawLevel
	ld		a, 20
	ld		(time_delay), a		; record our time delay
	call 	timer_wait_done
	pop     iy
	ret
	