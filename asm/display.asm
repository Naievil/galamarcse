; Patrick Davidson's display routine codes

;############## Erase rectangle
; B = X coordinate
; C = Y coordinate
; E = height
; D = width

Erase_Rectangle:
        ld      a,c
Erase_Rectangle_A:
        cp      244
        ret     nc              ; below the bottom, so exit
        sub     12
        jr      nc,erase_no_top_clip
        
        add     a,e             ; A = remaining height
        ret     nc
        ret     z
        ld      e,a
        
        ld      hl,0            ; set minimum Y to 0
        ld      a,$50
        call    Write_Display_Control
        ld      a,$20           ; set current Y
        call    Write_Display_Control   
        jr      erase_vertical_clip_done
        
erase_no_top_clip:
        ld      l,a             ; set minimum Y
        ld      h,0
        ld      a,$50
        call    Write_Display_Control
        ld      a,$20           ; set current Y
        call    Write_Display_Control   
        
        ld      a,l
        add     a,e             ; A = bottom Y coordinate
        ld      a,232
        sub     e
        sub     l               ; A = # lines remaining
        jr      nc,erase_vertical_clip_done
        add     a,e
        ld      e,a

erase_vertical_clip_done:       ; E = real height, vertical registers set
        ld      a,b
        sub     48
        ld      l,a
        ld      h,0
        add     hl,hl           ; HL = full X coordinate
        ld      a,$52
        call    Write_Display_Control
        ld      a,$21           ; set current X
        call    Write_Display_Control
        ld      a,b
        add     a,d
        sub     48
        ld      l,a
        ld      h,0
        add     hl,hl
        dec     hl
        ld      a,$53           ; set maximum X
        call    Write_Display_Control
        
        ld      a,$22
        out     ($10),a
        out     ($10),a 
        xor     a
Erase_Clipped_Loop:             ; D = height, E = width
        ld      b,d
Erase_Clipped_Inner_Loop        ; 57 clocks per loop, 28.5 clocks per pixel
        out     ($11),a
        out     ($11),a
        out     ($11),a
        out     ($11),a
        djnz    Erase_Clipped_Inner_Loop
        dec     e
        jr      nz,Erase_Clipped_Loop   
        ret
        
;############## Draw a sprite
; B = X coordinate divided by 2
; L = Y coordinate
; DE -> sprite (first byte is height in pixels, second byte is width in bytes, then packed pixels)

clipped_entire_top:
        pop     bc
        ret
        
Draw_Sprite_Packed:
        ld      a,l
        cp      244
        ret     nc              ; draw nothing if starting below the bottom
        sub     12
        jr      nc,draw_packed_no_top_clip
        
        push    bc
        
        neg                     ; A = # of lines to clip
        ld      b,a
        
        ld      hl,0            ; set minimum Y to 0
        ld      a,$50
        call    Write_Display_Control
        ld      a,$20           ; set current Y
        call    Write_Display_Control   
        
        ex      de,hl
        ld      a,(hl)
        sub     b               ; remove top lines from height
        jr      c,clipped_entire_top
        jr      z,clipped_entire_top
        inc     hl
        ld      c,(hl)
        inc     hl
        
        ld      e,c
        ld      d,0
loop_clip_top:
        add     hl,de
        add     hl,de
        add     hl,de
        add     hl,de
        djnz    loop_clip_top
        
        pop     bc              ; B = X coordinate / 2
        ld      c,e             ; C = width in bytes
        jr      draw_packed_vertical_clip_done
        
draw_packed_no_top_clip:
        ld      l,a
        ld      h,0
        ld      a,$50           ; set minimum Y
        call    Write_Display_Control
        ld      a,$20           ; set current Y
        call    Write_Display_Control   
        
        ex      de,hl           ; E = Y coordinate of top (screen coords)
        ld      a,(hl)          ; A = height of sprite
        inc     hl
        ld      c,(hl)          ; C = width of sprite in bytes
        inc     hl
        
        add     a,e             ; A = bottom row + 1
        cp      233
        jr      c,no_bottom_clip
        ld      a,232
        sub     e
        jr      draw_packed_vertical_clip_done
        
no_bottom_clip:
        sub     e               ; A = height
                
; At this point we have finished vertical clipping and set the Y register
; A = height of the sprite (excluding rows clipped out)
; HL -> pixel data of first pixel of first row to draw
; B = X coordinate
; C = width of sprite in bytes
draw_packed_vertical_clip_done:

draw_packed_no_horizontal_clip:
        ld      (draw_packed_loop-1),a
        
        ld      a,c
        add     a,a
        add     a,a
        add     a,c             ; A = width in bytes * 5                
        ld      (draw_packed_line-1),a
        
        ex      de,hl
        push    bc
        ld      a,b
        sub     48
        ld      l,a             ; set minimum X
        ld      h,0
        add     hl,hl
        ld      a,$52
        call    Write_Display_Control
        ld      a,$21           ; set current X
        call    Write_Display_Control
        pop     bc
        
        ld      a,b             ; set maximum X
        add     a,c
        sub     48
        ld      l,a
        ld      h,0
        add     hl,hl
        dec     hl
        ld      a,$53
        call    Write_Display_Control
        
        ld      a,$22
        out     ($10),a
        out     ($10),a 
        
        ex      de,hl
        ld      d,1
draw_packed_loop:
        ld      b,1
draw_packed_line:
        outi                    ; 77 clocks per loop, 38.5 clocks per pixel
        outi
        outi
        outi
        djnz    draw_packed_line
        dec     d
        jr      nz,draw_packed_loop
        ret
		

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
		
;############## Clear the screen (in black)
;##############      Function adapted from Calcuzap by Patrick Davidson (huge thank you!)

Clear_Screen:   
        call    Full_Window
        
        ld      a,$20
        ld      hl,0            ; set write Y coordinate
        call    Write_Display_Control
        ld      a,$21           ; set write X coordinate
        call    Write_Display_Control
        
        ld      a,$22
        out     ($10),a
        out     ($10),a

        ld      bc,320*240*2/3
		ld		e, 0

;############## screen_write_loop: 
; E  -> $XX color input
; BC -> loop times
screen_write_loop:
        ld		a, e
        out     ($11),a
        out     ($11),a
        out     ($11),a
        dec     bc
        ld      a,b
        or      c
        jr      nz,screen_write_loop
        ret