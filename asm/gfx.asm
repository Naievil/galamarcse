;############## Galamar by Ryan Baldwin - graphics routines
		
;############## DrawPlayerStart: Draw our player to midway starting point	
DrawPlayerStart:	
	xor 	a
	ld 		l,240-16				; middle of bottom screen y
	ld 		h,0
	ld 		(playery),hl
	ld 		l,(320-15)/2			; middle of bottom screen x
	ld 		h,0
	ld 		(playerx),hl
	
	ld 		ix,img_player		; load in image data
	ld 		hl,(playery)			; load in y component
	ld 		de,(playerx)			; load in x component
	call 	Draw_8Bit	
	ret
	
;############## DrawLevel: Draws the world and the siding
DrawLevel:

	ld		de, 272
	ld		bc,	0
	ld		hl,	272
	ld		ix,	240
	ld		iy, $bd74
	call	Color_Line
	ld		de, 46
	ld		bc, 0
	ld		hl,	46
	ld		ix, 240
	call	Color_Line
	ld		de, 0
	ld		hl, 0
	ld 		ix, img_logo
	call	Draw_1Bit
	ret
	
;############## DrawRandomRec: Draws a randomly generated rectangle, destroys all registers
DrawRandomRec:
	ld 		b,4		; random location
	call 	RandInt
	ld 		l,a
	call 	RandInt
	ld 		h,a
	ld 		b, 4		; 255 color bound (inclusive)
	call 	RandInt
	ld 		c, a
	call 	RandInt
	ld 		b, a	
    call 	Color_Rectangle
	ret	
	
DrawPlayer:
	ld 		ix,img_player			; load in image data
	ld 		hl,(playery)			; load in y component
	ld 		de,(playerx)			; load in x component
	call	Draw_8Bit
	ret
	
DeletePlayerLeft:
	ld 		hl, (playerx)
	ld		de, (playery)
	ld 		iy, $00
	dec 	hl
DeleteLeftLoop:
	inc 	de
	call 	Color_Pixel
	ld		a,e
	cp		240
	jp		nz, DeleteLeftLoop
	ret

DeletePlayerRight:
	ld 		hl, (playerx)
	ld		de, (playery)
	ld 		iy, $00
	ld 		b, 0		
	ld		c, 15
	add		hl, bc
DeleteRightLoop:
	inc 	de
	call 	Color_Pixel
	ld		a,e
	cp		240
	jp		nz, DeleteRightLoop
	ret	
	
;################ UpdateStars: Jump location called from main after timer goes off, which redraws stars
	
UpdateStars:
	call		UpdateStar1
	call		UpdateStar2
	call		UpdateStar3
	call		UpdateStar4
	call		UpdateStar5
	call		UpdateStar6
	call		Reset_Y
	ret
	
setblue:
	ld		iy, 1818h
	ret

setwhite:
	ld		iy, $ffff
	ret
	
setred:
	ld		iy, 8080h
	ret

setblack:
	ld		iy, 0000h
	ret
	
setgreen:
	ld		iy, 2525h
	ret
	
;################ UpdateStarX: Increments position of star, redraws
	
UpdateStar1:
	ld		de, (star1y)		
	ld		hl, 68
	inc 	de
	ld		(star1y), de
	call	setblue
	call 	Color_Pixel
	
	ld		de, (star1y)
	ld		hl, 68
	call	FillinStar

	ret
	
UpdateStar2:
	ld		de, (star2y)		
	ld		hl, 112				
	inc 	de
	ld		(star2y), de
	call	setwhite
	call 	Color_Pixel
	
	ld		de, (star2y)
	ld		hl, 112
	call	FillinStar
	ret
	
UpdateStar3:
	ld		de, (star3y)		
	ld		hl, 146
	inc 	de
	ld		(star3y), de
	call	setred
	call 	Color_Pixel
	
	ld		de, (star3y)
	ld		hl, 146
	call	FillinStar
	ret
	
UpdateStar4:
	ld		de, (star4y)		
	ld		hl, 180
	inc 	de
	ld		(star4y), de
	call	setblue
	call 	Color_Pixel
	
	ld		de, (star4y)
	ld		hl, 180
	call	FillinStar
	ret
	
UpdateStar5:
	ld		de, (star5y)		
	ld		hl, 214
	inc 	de
	ld		(star5y), de
	call	setgreen
	call 	Color_Pixel
	
	ld		de, (star5y)
	ld		hl, 214
	call	FillinStar
	ret
	
UpdateStar6:
	ld		de, (star6y)		
	ld		hl, 248
	inc 	de
	ld		(star6y), de
	call	setwhite
	call 	Color_Pixel
	
	ld		de, (star6y)
	ld		hl, 248
	call	FillinStar
	ret
	
FillinStar:
	dec 	de
	dec		de
	ld		iy, 0000h
	call 	Color_Pixel
	ret 
	
Reset_Y:
	ld		ix, 0
	ld		de, (star1y)
	ld		a, e
	cp		241
	jr		z, Reset_Y1
	ld		de, (star2y)
	ld		a, e
	cp		241
	jr		z, Reset_Y2
	ld		de, (star3y)
	ld		a, e
	cp		241
	jr		z, Reset_Y3
	ld		de, (star4y)
	ld		a, e
	cp		241
	jr		z, Reset_Y4
	ld		de, (star5y)
	ld		a, e
	cp		241
	jr		z, Reset_Y5
	ld		de, (star6y)
	ld		a, e
	cp		241
	jr		z, Reset_Y6
	ret
	
Reset_Y1:
	ld		(star1y), ix
	ret
Reset_Y2:
	ld		(star2y), ix
	ret
Reset_Y3:
	ld		(star3y), ix
	ret
Reset_Y4:
	ld		(star4y), ix
	ret
Reset_Y5:
	ld		(star5y), ix
	ret
Reset_Y6:
	ld		(star6y), ix
	ret
	
Draw_1Bit:
	ret
	
Draw_8Bit:
	ret
	
Color_Line:
	ret
	
Color_Rectangle:
	ret
	
RandInt:
	ret

; Color_Pixel: takes in hl as x, de for y, iy as 8 bit color
Color_Pixel:
		; *************
		;  Set X coord
		; *************
		ld      a, $21          ; set write X coordinate
        ; we don't change value of HL since it already contains the X value!
        call    Write_Display_Control
		
		; *************
		;  Set Y cord
		; *************
		ld		h, 0			; y coord will ALWAYS be < 256 so no need for first bit
		ld		l, e
        ld      a,$20           ; set write Y coordinate
        call    Write_Display_Control
        
        ld      a,$22
        out     ($10),a
        out     ($10),a

        ld      bc, 1
		ld		e, IYL
		call	screen_write_loop
		
		ret