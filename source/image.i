Sprite_8Bit_Palette:
	.db 0d, 0d, $FF, $FF, $18, $18, $E0, $E0  ; black, white, blue, red
img_player:
	.dw Sprite_8Bit_Palette
    .db 15,16
    .db 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.db 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.db 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0
	.db 0,0,0,0,0,0,1,1,1,0,0,0,0,0,0
	.db 0,0,0,0,0,0,1,1,1,0,0,0,0,0,0
	.db 0,0,0,0,0,0,1,1,1,0,0,0,0,0,0
	.db 0,0,0,3,0,0,1,1,1,0,0,3,0,0,0
	.db 0,0,0,3,0,1,1,1,1,1,0,3,0,0,0
	.db 3,0,0,1,2,1,1,3,1,1,2,1,0,0,3
	.db 3,0,0,2,1,1,3,3,3,1,1,2,0,0,3
	.db 1,0,0,1,1,1,3,1,3,1,1,1,0,0,1
	.db 1,0,1,1,1,1,1,1,1,1,1,1,1,0,1
	.db 1,1,1,1,1,3,1,1,1,3,1,1,1,1,1
	.db 1,1,1,0,3,3,1,1,1,3,3,0,1,1,1
	.db 1,1,0,0,3,3,0,1,0,3,3,0,0,1,1
	.db 1,0,0,0,0,0,0,1,0,0,0,0,0,0,1	