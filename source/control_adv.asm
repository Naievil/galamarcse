timer_loop: 
        in      a,(4)
        bit     5,a
        jr      z,timer_loop
timer_wait_done:
    xor     a
    out     ($31),a
    ld      a,(time_delay)
    out     ($32),a         	; restart timer
	;ld      hl,fire_pressed
	in      a,(1)           	; shoot if 2nd is pressed
    bit     5,a
    jr      nz,no_fire
	
   ; ld      a,(hl)
   ; or      a
   ; jr      nz,fire_done
   ; inc     (hl)
   ; call    fire_bullet     
   ; jr      fire_done
	
no_fire:						; don't do anything
        xor     a				; clear accum
        ld      (hl),a			; clear fire_pressed
		
		; ##########################################
		;call   	player_bullets			
        ;call    process_enemies			
        ;call    hit_enemy				
        ;call    process_enemy_bullets	
        ;ld      hl,(lives)
        ;ld      a,h
        ;or      l
        ;ld      hl,lose_message
        ;jp      z,check_highscore
		; ##########################################

        ld      a,%11111110
        out     (1),a           ; mask most keys (allow arrows)
		
		ld      hl,player_move_done     ; ret from move jumps here
        push    hl                      
        ld      hl,playerx
		
		in      a,(1)

        and     %1111
        add     a,a
        ld      (do_player+1),a			
		
do_player:
        jr      point_to_player_code
point_to_player_code:
        jr      player_no_move          ; 0000 all arrows pressed
        jr      player_no_move          ; all arrows pressed but down
        jr      player_right            ; all arrows pressed but left
        jr      player_right
        jr      player_left             ; 0100 all arrows pressed but right
        jr      player_left
        jr      player_no_move          ; up and down pressed
        jr      player_no_move
        jr      player_no_move          ; 1000 all arrows pressed but up
        jr      player_no_move          ; left and right pressed
        jr      player_right
        jr      player_right
        jr      player_left        		; 1100
        jr      player_left
        jr      player_no_move

player_no_move:
        xor     a
        jp      player_move_done
		
player_left:
        ld      a,(hl)
        cp      48
        ret     z				; do nothing if the coordinate is 48
        ld      a,-2
        jp      move_left

player_right:
        ld      a,(hl)
        cp      160+48-8
        ret     z
        ld      a,2
        jp      move_right
		
		
player_move_done:
        in      a,(1)
        add     a,a
        ret     nc
        add     a,a
        jp      c,timer_loop

        ;ld      hl,saved_flag
        ;set     7,(hl)
        ret