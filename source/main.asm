mainloop:
	ld a,$ff
	out (1),a
	nop \ nop
	ld a,%11111100
	out (1),a
	nop \ nop
	in a,(1)
	cp $ff
	jr z,mainloop
	bit 1,a
	jr z,move_left
	bit 2,a
	jr z,move_right
	jp mainloop