;############## Move right

move_right:
		ld 		hl,(playerx)
		ld		a,h
		cp		1						; check for right bound
		jr		nz, move_right_begin	; 
		ld		a,l						;
		cp		0						; right bound is at x = 272
		jr		z, mainloop
move_right_begin:						; the actual movement and drawing calls
		ld		hl, (playerx)
		inc 	hl						; increase our position
		ld 		(playerx), hl			; store our increased position
		call 	DrawPlayer
		call	DeletePlayerLeft		; delete leftover colors (fill in with black)
		jr 		mainloop				; back to the beginning...
		
;############## Move left

move_left:
		ld 		hl,(playerx)
		ld		a,h
		cp		0						; check for left bound
		jr		nz, move_left_begin		;
		ld		a,l						;
		cp		48						; left bound is at x = 48
		jr		z, mainloop
move_left_begin:						; the actual movement and drawing calls
		ld		hl,(playerx)
		dec 	hl						; decrease our position
		ld 		(playerx), hl			; store our decreased position
		call 	DrawPlayer
		call	DeletePlayerRight		; delete leftover colors (fill in with black)
		jr		mainloop				; back to the beginning...
