;############## Galamar by Ryan Baldwin - title/etc implementation

ShowTitle: 
    call    Clear_Screen
	ret
	
DrawStars:
	call	DrawStar1
	call	DrawStar2
	call	DrawStar3
	call	DrawStar4
	call	DrawStar5
	call	DrawStar6
	ret
	
DrawStar1:
	ld		hl, (star1x)
	ld		de, (star1y)
	ld		iy, (star1clr)
	call	ColorPixel
	ret
DrawStar2:
	ld		hl, (star2x)
	ld		de, (star2y)
	ld		iy, (star2clr)
	call	ColorPixel
	ret
DrawStar3:
	ld		hl, (star3x)
	ld		de, (star3y)
	ld		iy, (star3clr)
	call	ColorPixel
	ret
DrawStar4:
	ld		hl, (star4x)
	ld		de, (star4y)
	ld		iy, (star4clr)
	call	ColorPixel
	ret
DrawStar5:
	ld		hl, (star5x)
	ld		de, (star5y)
	ld		iy, (star5clr)
	call	ColorPixel
	ret
DrawStar6:
	ld		hl, (star6x)
	ld		de, (star6y)
	ld		iy, (star6clr)
	call	ColorPixel
	ret


LoadStars:
	ld		de, 24
	ld		hl, 68
	ld 		(star1x), hl
	ld 		(star1y), de
	call	setblue
	ld		(star1clr), iy
	call 	DrawStar1
	
	ld		de, 112
	ld		hl, 112
	ld 		(star2x), hl
	ld 		(star2y), de
	call	setwhite
	ld		(star2clr), iy
	call 	DrawStar2
	
	ld		de, 200
	ld		hl, 146
	ld 		(star3x), hl
	ld 		(star3y), de
	call 	setred
	ld		(star3clr), iy
	call 	ColorPixel
	
	ld		de, 105
	ld		hl, 180
	ld 		(star4x), hl
	ld 		(star4y), de
	call 	setblue
	ld		(star4clr), iy
	call 	ColorPixel
	
	ld		de, 150
	ld		hl, 214
	ld 		(star5x), hl
	ld 		(star5y), de
	call 	setred
	ld		(star5clr), iy
	call 	ColorPixel
	
	ld		de, 62
	ld		hl, 248
	ld 		(star6x), hl
	ld 		(star6y), de
	call	setwhite
	ld		(star6clr), iy
	call 	ColorPixel
	
	ret
	
setblue:
	ld		iy, 1818h
	ret

setwhite:
	ld		iy, ffffh
	ret
	
setred:
	ld		iy, 8080h
	ret