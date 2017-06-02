;###############  Flash App Header
;###############
;###############  Layout borrowed from Patrick Davidson's Calcuzap


#include        "asm\ti84pcse.inc"
#define WORDLEN 2

#include        "asm\data.asm" 
data_save       =plotSScreen
score_save      =saveSScreen
load_address    =$8100

;############## Flash app header
; 

        .org    $4000
        .db     $80,$0f,0,0,0,0         ; master field
        .db     $80,$47,"Galamar"		; app name: 8 chars long, change 8 to 6, 1, 2, etc to match the number of chars you have in your name)
        .db     $80,$90                 ; disable splash screen  
        .db     $80,$81,1               ; 1 page add
        .db     $80,$12,$01,$0f         ; 10F signing key (for 84+CSE)
        .db     $03,$20,$09,$00         ; empty date stamp
        .db     $02,$00                 ; empty date signature
        .db     $80,$70                 ; final field of flash header
        
        ld      a,1
        out     ($20),a         ; maximum CPU speed
        ld      a,$45
        out     ($30),a         ; set timer frequency to 2048Hz  
                
        ld      hl,0
        add     hl,sp
        ld      sp,$8100        ; new stack at $8100
        push    hl              ; save old stack
        
        ld      a,$87           ; set temporary page at $8000
        out     (7),a
        
        ld      hl,compressed_data
        ld      de,load_address
        call    Decompress           
        call    load_address    ; run main game code
        
        ld      a,$81           ; restore usual RAM at $8000
        out     (7),a

        ld      de,data_save    ; copy permanent data from our page
        ld      hl,saved_flag
        ld      bc,data_end-saved_flag
        ldir
        ld      de,score_save
        ld      hl,high_scores
        ld      bc,TABLE_SIZE
        ldir

        xor     a               ; restore usual RAM at $C000
        out     (5),a        
        
        pop     hl              ; restore stack pointer
        ld      sp,hl
                
        bcall(_DrawStatusBar)
        bcall(_ClrScrn)
        bjump(_JForceCmdNoChar)

#include        "exec\lite86.asm"

compressed_data:
#import compressed.bin
        
#if     ($ > $8000)        
        .echo   "Overflow of available flash space on page 0 by ",eval($ - $8000)
        .error  "!!!!!!!!!!!!!!!!!!!! DISASTER !!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
#endif
#if     ($ > $7FA0)        
        .echo   "Overflow after adding certificate by ",eval($ - $7FA0)
#else
        .echo   "Bytes left over in flash: ",eval($7FA0 - $)
#endif