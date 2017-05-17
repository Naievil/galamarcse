;############## Move right (A = distance, HL->X)

move_right:
		ld hl,(playerx)
		inc hl
		ld (playerx),hl
		call DrawPlayer
		jr mainloop
;############## Move left (A = -distance, HL->X)

move_left:
		ld hl,(playerx)
		dec hl
		ld (playerx),hl
		call DrawPlayer
		jr mainloop
