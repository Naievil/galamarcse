;############################################;
;#			Galamar Base Loop Code			#;
;#	  Based off of Calcuzap's loop code 	#;
;############################################;

;#############################;
; checkinputlevel: takes in b, loads and delays into a
checkinputlevel:
		ld 		a,$ff
		out 	(1),a
		nop \ nop
		ld 		a,b
		out 	(1),a
		nop \ nop
		call	DrawPlayer	
		in 		a,(1)
		cp 		$ff
		ret
		

drawpausegame:


		; temp
		ret	
		; temp
		
		
		ld		de, 110
		ld		hl, 105
		ld		ix, pauselogo
		call	Draw_1Bit
pausegame:
		ld      a,%10111111    		; mask most keys (allow 2nd)
		out 	(1),a
		nop \ nop
		in 		a,(1)
		bit 	5,a
		jr		nz,pausegame		
		ld		h, 55
		ld		l, 105
		ld 		d, 50
		ld		e, 30
		ld		bc, 0000h
		call	Color_Rectangle

mainloop:
	
		; Draw update to score here when necessary
		
		ld      a,%10111111    		; mask most keys (allow 2nd)
		out     (1),a

timer_loop: 
        in      a,(4)
        bit     5,a
        jr      z,timer_loop
timer_wait_done:
        xor     a					
        out     ($31),a				; load 0 into loopingdata
        ld      a,(time_delay)		
        out     ($32),a          	; load our timer delay value into crystal timer
					
        ld      hl,fire_pressed		; load our fire_pressed variable

        in      a,(1)           	; shoot if 2nd is pressed
        bit     5,a					; check if bit is active
        jr      nz,no_fire			; if not active, skip
        ld      a,(hl)				; 
        or      a					; 		
        jr      nz,fire_done		; 
        inc     (hl)				; set our fire_pressed active
        call    firebullet     		; actual bullet firing
        jr      fire_done		
		
no_fire:
        xor     a
        ld      (hl),a				; set fire_pressed to 0
		 
fire_done:
		
		call	UpdateStars			; update/redraw stars
		call	DrawPlayer			; commented for speedup...redraw player in case stars go in front
		
		ld 		b,%1111101
        call	checkinputlevel
		bit 	0, a
		jr		z, drawpausegame
	
		ld 		b,%11111100
        call	checkinputlevel
		jr 		z,mainloop
		bit 	3,a
		call	z,changespeed			; for laser charge later
		ld 		b,%11111100
        call	checkinputlevel
		bit 	1,a
		jr 		z,move_left
		bit 	2,a
		jr 		z,move_right
		jr 		mainloop
		
changespeed:
	call	UpdateStars
	call	UpdateStars
	ret