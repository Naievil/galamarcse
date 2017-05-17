;############## Move right (A = distance, HL->X)

move_right:
        push    hl
        push    af              ; push distance
        add     a,(hl)
        ld      b,a             ; B = new X coordinate
        ld      (hl),a
        ld      b,(hl)          
        inc     hl
        ld      a,(hl)          ; A =  coordinate
        inc     hl
        ld      e,(hl)
        inc     hl
        ld      d,(hl)          ; DE = image pointer
        ld      l,a
        
        push    de
        ;call    Draw_Sprite_Packed
        
        pop     hl              ; HL -> image
        pop     de              ; D = distance/width (final value for erase)
        ld      e,(hl)          ; E = height (final value for erase)
        pop     hl              ; HL -> X
        ld      a,(hl)          ; A = new X
        sub     d
        ld      b,a             ; B = old X (final value for erase)
        inc     hl
        ld      c,(hl)
        ;jp      Erase_Rectangle
        
;############## Move left (A = -distance, HL->X)

move_left:
        push    hl
        push    af              ; push distance
        add     a,(hl)
        ld      b,a             ; B = new X coordinate
        ld      (hl),a
        ld      b,(hl)          
        inc     hl
        ld      a,(hl)          ; A =  coordinate
        inc     hl
#ifdef  TI84CE
        ld      de,(hl)
#else
        ld      e,(hl)
        inc     hl
        ld      d,(hl)          ; DE = image pointer
#endif
        ld      l,a
        
        push    de
        ;call    Draw_Sprite_Packed
        
        pop     hl              ; HL -> image
        pop     af              ; A = -distance/width
        neg                     ; A = distance/width
        ld      d,a             ; D = width (final value for erase)
        ld      e,(hl)          ; E = height (final value for erase)
        inc     hl
        ld      c,(hl)          ; C = sprite width
        pop     hl              ; HL -> X
        ld      a,(hl)          ; A = new X
        add     a,c             ; A = past the edge X
        ld      b,a             ; B = X (final value for erase)
        inc     hl
        ld      c,(hl)
        ;jp      Erase_Rectangle