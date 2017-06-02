;############## Galamar by Ryan Baldwin - title/etc implementation

ShowTitle: 
    call    Clear_Screen
	ret

;############## LoadStars:	Initial load of all y positions per 6 stars
LoadStars:
	
	ld		hl, 24		
	ld		(star1y), hl
	
	ld		hl, 112
	ld		(star2y), hl
		
	ld		hl, 200
	ld		(star3y), hl
	
	ld		hl, 105
	ld		(star4y), hl
	
	ld		hl, 150
	ld		(star5y), hl
	
	ld		hl, 62
	ld		(star6y), hl
	ret
