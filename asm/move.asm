;############## Move right
tomain:
		jr		mainloop		

move_right:
		ld		hl, (playerx)
		inc		hl
		ld		(playerx), hl
		ret
		
;############## Move left

move_left:
		ld		hl, (playerx)
		dec		hl
		ld		(playerx), hl
		ret