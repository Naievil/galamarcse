; Patrick Davidson's display routine codes

Display_Org:
        ld      a,3             ; adjust origin drawing mode
        ld      hl,$1038
        call    Write_Display_Control
        jr      Full_Window
        
Display_Normal:
        ld      a,3             ; normal drawing mode
        ld      hl,$10B8
        call    Write_Display_Control
        
Full_Window:
        ld      a,$50           ; Set minimum Y
        ld      hl,0
        call    Write_Display_Control
        
        inc     a               ; Set maximum Y
        ld      l,239
        call    Write_Display_Control   
        
        ld      hl,0            ; Set minimum X
        inc     a
        call    Write_Display_Control
        
        inc     a               ; Set maximum X
        ld      hl,319 
        
;############## Write HL to display register A

Write_Display_Control:
        out     ($10),a
        out     ($10),a
        ld      c,$11
        out     (c),h
        out     (c),l
        ret