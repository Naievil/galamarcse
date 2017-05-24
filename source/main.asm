;############################################;
;#			Galamar Base Loop Code			#;
;#	  Based off of Calcuzap's loop code 	#;
;############################################;

mainloop:
	;ld      a,(score+4)
    ;or      1
    ;ld      hl,rand_inc				; pretty sure this is used for bonus...
    ;add     a,(hl)
    ;ld      (hl),a
        
    ;ld      hl,(frame_count)		; |
    ;inc     hl						; |
    ;ld      (frame_count),hl		; -> increase frame count by 1
    ;ld      bc,33*4*256+232
    ;ld      hl,score
    ;call    Draw_String
    ld      a,%10111111    			; mask most keys (allow 2nd)
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
        ld      a,(hl)				; >
        or      a					; > no idea what this does
        jr      nz,fire_done		; > 
        inc     (hl)				; set our fire_pressed active
        call    firebullet     		; actual bullet firing
        jr      fire_done		
		
no_fire:
        xor     a
        ld      (hl),a				; set fire_pressed to 0
		 
fire_done:

        ;call    player_bullets
        ;call    process_enemies
        ;call    hit_enemy
        ;call    process_enemy_bullets
        ;ld      hl,(lives)
        ;ld      a,h
        ;or      l
        ;ld      hl,lose_message
        ;jp      z,check_highscore
		
		call	UpdateStars			; update/redraw stars
		
        ld 		a,$ff
		out 	(1),a
		nop \ nop
		ld 		a,%11111100
		out 	(1),a
		nop \ nop
		call	DrawPlayer	
		in 		a,(1)
		cp 		$ff
		jr 		z,mainloop
		bit 	1,a
		jr 		z,move_left
		bit 	2,a
		jr 		z,move_right			
		jp 		mainloop