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
		
;############## Draw player to starting point

DrawPlayerStart:
	xor a
	ld l,0
	ld h,0
	ld (playery),hl
	ld l,0
	ld h,0
	ld (playerx),hl
	
	ld ix,img_player		; load in image data
	ld hl,(playery)			; load in y component
	ld de,(playerx)			; load in x component
	call DrawSprite_8Bit
	ret
	
;############### DrawRandomRec: Draws a randomly generated rectangle, destroys all registers
	
DrawRandomRec:
	ld b,240		; random location
	call RandInt
	ld l,a
	call RandInt
	ld h,a
	ld b, 255		; 255 color bound (inclusive)
	call RandInt
	ld c, a
	call RandInt
	ld b, a	
    call ColorRectangle
	ret	