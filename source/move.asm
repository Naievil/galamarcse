;############## Move right

move_right:
		ld 		hl, (playerx)
		inc 	hl
		ld 		(playerx), hl
		call 	DrawPlayer
		call	DeletePlayerLeft		
		jr mainloop
		
;############## Move left

move_left:
		ld hl,(playerx)
		dec hl
		ld (playerx), hl
		call DrawPlayer
		call	DeletePlayerRight
		jr mainloop
