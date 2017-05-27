Sprite_8Bit_Palette:
	.db 0d, 0d, $FF, $FF, $18, $18, $E0, $E0, $E0, 0d  ; black, white, blue, red, redblack
img_playerold:
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
	
	.db 0
	
img_player:
	.dw Sprite_8Bit_Palette
    .db 15,16
    .db 0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
    .db 0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
    .db 0,1,0,0,0,0,0,0,0,0,0,0,0,1,0
    .db 1,1,0,0,0,0,0,1,0,0,0,0,0,1,1
    .db 3,3,0,0,0,0,0,3,0,0,0,0,0,3,3
    .db 1,1,0,0,0,0,0,1,0,0,0,0,0,1,1
    .db 1,1,0,0,0,0,0,1,0,0,0,0,0,1,1
    .db 1,1,0,0,1,0,0,1,0,0,1,0,0,1,1
    .db 1,1,0,0,1,0,0,1,0,0,1,0,0,1,1
    .db 1,1,3,2,1,1,1,0,1,0,1,2,3,1,1
    .db 1,1,3,2,1,1,1,0,1,1,1,2,3,1,1
    .db 1,1,3,2,1,1,3,0,3,1,1,2,3,1,1
    .db 1,1,0,0,1,1,1,1,1,1,1,0,0,1,1
    .db 1,1,0,0,1,1,0,0,0,1,1,0,0,1,1
    .db 1,1,0,0,0,1,3,0,3,1,0,0,0,1,1
    .db 1,0,0,0,0,1,1,1,1,1,0,0,0,0,1
	
	.db 0
	
LogoPalette:
.db FFh, DDh
.db 00h, 00h


img_logo:
	.dw LogoPalette
	.db 45, 220
	.incbmp "../assets/logo.png"
	
pauselogo:
	.dw LogoPalette
	.db	100, 30
	.incbmp "../assets/paused.png"
