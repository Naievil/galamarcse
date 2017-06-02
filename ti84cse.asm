;   _____              _                   __  __              _____  
;  / ____|     /\     | |          /\     |  \/  |     /\     |  __ \ 
; | |  __     /  \    | |         /  \    | \  / |    /  \    | |__) |
; | | |_ |   / /\ \   | |        / /\ \   | |\/| |   / /\ \   |  _  / 
; | |__| |  / ____ \  | |____   / ____ \  | |  | |  / ____ \  | | \ \ 
;  \_____| /_/    \_\ |______| /_/    \_\ |_|  |_| /_/    \_\ |_|  \_\
;
;
; 							A TI-84 Shooter
;					 Ryan Baldwin (rabaldwi@ncsu.edu)                                                  

#include        "asm\ti84pcse.inc"

    .org    $8100
	
	call    Display_Org
	call    InitGame
    jp      Display_Normal
	
#include "galamar.asm"
#include "asm\title.asm"
#include "asm\gfx.asm"
#include "asm\image.i"
#include "asm\main.asm"
#include "asm\move.asm"
#include "asm\bullets.asm"
#include "asm\display.asm"
#include "asm\data.asm"
.end