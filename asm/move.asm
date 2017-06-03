;############## Move right		

move_right:
		ld		hl, (rightcount)
		ld		a, l
		cp      0
		jr      z, move_right_start    ; if we are good to go 
		dec     hl
		ld		(rightcount), hl
		ret 
move_right_start
		call    resetrightcount
		ld		hl, (playerx)
		inc		hl
		ld		(playerx), hl
		ret

		
;############## Move left

move_left:
		ld		hl, (leftcount)
		ld		a, l
		cp      2
		jr      z, move_left_start
		dec     hl
		ld      (leftcount), hl
		ret
move_left_start:
		call    resetleftcount
		ld		hl, (playerx)
		dec		hl
		ld		(playerx), hl
		ret
		
resetrightcount:	
	ld		hl, 3
	ld		(rightcount), hl
	ret
resetleftcount:
	ld		hl, 3
	ld		(leftcount), hl
	ret