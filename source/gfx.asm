;############## Galamar by Ryan Baldwin - graphics routines

;############## Clear the screen (in black)
;##############      Function adapted from Calcuzap by Patrick Davidson (huge thank you!)

Clear_Screen:   
        call    Full_Window
        
        ld      a,$20
        ld      hl,0            ; set write Y coordinate
        call    Write_Display_Control
        ld      a,$21           ; set write X coordinate
        call    Write_Display_Control
        
        ld      a,$22
        out     ($10),a
        out     ($10),a

        ld      bc,320*240*2/3
blank_loop:
        xor     a
        out     ($11),a
        out     ($11),a
        out     ($11),a
        dec     bc
        ld      a,b
        or      c
        jr      nz,blank_loop
        ret

Full_Window:
        ld      a, $50           ; Set minimum Y
        ld      hl,0
        call    Write_Display_Control
        
        inc     a               ; Set maximum Y
        ld      l,239
        call    Write_Display_Control   
        
        ld      hl,0            ; Set minimum X
        inc     a
        call    Write_Display_Control
        
        inc     a               ; Set maximum X
        ld      hl,319 
		
;############## Write HL to display register A

Write_Display_Control:
        out     ($10),a
        out     ($10),a
        ld      c,$11
        out     (c),h
        out     (c),l
        ret
		
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
	call 	DrawSprite_8Bit	
	ret
	
;############## DrawLevel: Draws the world and the siding
DrawLevel:

	ld		de, 272
	ld		bc,	0
	ld		hl,	272
	ld		ix,	240
	ld		iy, bd74h
	call	ColorLine
	ld		de, 46
	ld		bc, 0
	ld		hl,	46
	ld		ix, 240
	call	ColorLine
	ld		de, 0
	ld		hl, 0
	ld 		ix, img_logo
	call	DrawSprite_1Bit
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
    call 	ColorRectangle
	ret	
	
DrawPlayer:
	ld 		ix,img_player			; load in image data
	ld 		hl,(playery)			; load in y component
	ld 		de,(playerx)			; load in x component
	call	DrawSprite_8Bit
	ret
	
DeletePlayerLeft:
	ld 		hl, (playerx)
	ld		de, (playery)
	ld 		iy, $0000
	dec 	hl
DeleteLeftLoop:
	inc 	de
	call 	ColorPixel
	ld		a,e
	cp		240
	jp		nz, DeleteLeftLoop
	ret

DeletePlayerRight:
	ld 		hl, (playerx)
	ld		de, (playery)
	ld 		iy, $0000
	ld 		b, 0		
	ld		c, 15
	add		hl, bc
DeleteRightLoop:
	inc 	de
	call 	ColorPixel
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
	ld		iy, ffffh
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
	call 	ColorPixel
	
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
	call 	ColorPixel
	
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
	call 	ColorPixel
	
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
	call 	ColorPixel
	
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
	call 	ColorPixel
	
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
	call 	ColorPixel
	
	ld		de, (star6y)
	ld		hl, 248
	call	FillinStar
	ret
	
FillinStar:
	dec 	de
	dec		de
	ld		iy, 0000h
	call 	ColorPixel
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