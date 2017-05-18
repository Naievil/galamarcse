; Program Name: Galamar (and other various tests)
; Author: 		Ryan Baldwin (rabaldwi@ncsu.edu)
; Version:		0.1a
; Date: 		16/5/2017
; Written for Doors CSE 8.0 and higher (http://dcs.cemetech.net)

.nolist
.global

#include "ti84pcse.inc"
#include "dcse8.inc"

.endglobal

temp1			.equ cmdShadow
playerx			.equ temp1					;2 bytes
playery			.equ playerx+2				;2 bytes
player_img		.equ playery+2				;2 more bytes
time_delay		.equ player_img+2			;additional two more bytes of space
fire_pressed	.equ time_delay+1

.list
    .org UserMem
BinaryStart:
    .db $DE,$2A,"N",$BB,$B4,$BB,$B4,$BB,$B3,$BB,$C3,")D"   ;Disp "Needs D
    .db $BB,$BF,$BB,$BF,$BB,$C2,$BB,$C3,")CSE",$2A,$3F     ;oors CSE"
    .db $EF,$11                                            ;OpenLib(
    .db "D",$BB,$BF,$BB,$BF,$BB,$C2,$BB,$C3,"CSE",$11,$3F  ;(tokenized "DoorsCSE")
    .db $EF,$12,$3F                                        ;ExecLib
    .db $D5,$3F                                            ;Return
    .db tExtTok,tAsm84CPrgm,$3F                            ;Asm84CPrgm
HeaderStart:
    .dw ASMStart-HeaderStart        ;offset to code
    ; Header sections start here

    .dw 10
    .db ASMHEADER_FIELD_TYPE_LIB    ;== 3
    .db "DoorsCSE",8,1              ;Lib name, min major version, min minor version

    .dw endDCSIcon - startDCSIcon
    .db ASMHEADER_FIELD_TYPE_ICON

;
; DoorsCSE app icon data
;

startDCSIcon:
    .db 1 ;1 bit color
    .dw BEFFh ;BG
    .dw 0000h ;FG (big endian, black)
    .db 32, 32 ;Size
    .incbmp "assets/appicon.png"
endDCSIcon:

    .dw endDCSDesc - startDCSDesc
    .db ASMHEADER_FIELD_TYPE_DESC
startDCSDesc:
    .db "Galamar",0
endDCSDesc:

    .dw endDCSAuthor - startDCSAuthor
    .db ASMHEADER_FIELD_TYPE_AUTH
startDCSAuthor:
    .db "naievil",0
endDCSAuthor:

    ;.dw 0
    ;.db ASMHEADER_FIELD_TYPE_HALFRES

    .dw 0     ;End of header field: 0 bytes of data
    .db $ff   ;End of header field: type 255
	

ASMStart:
.relocate UserMem
.define bcall(label) rst $28 \ .dw label

;Initialize game screen and start loop
InitGame:
	ld      a,1
    out     ($20),a         ; maximum CPU speed
    ld      a,$45
    out     ($30),a         ; set timer frequency to 2048Hz
		
	call 	ClearLCDFull
   	call 	ShowTitle		 	; clears the screen, show title when created
	call 	DrawPlayerStart 	; draws player starting position
	call	DrawLevel
	ld		a, 86
	ld		(time_delay), a		; record our time delay
	call 	timer_wait_done
	ret
	
.include "source/title.asm"
.include "source/gfx.asm"
.include "source/image.i"
.include "source/main.asm"
.include "source/move.asm"
.include "source/control.asm"
;.include "source/data.asm"

.endrelocate
.end
