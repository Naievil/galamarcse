;
; Lite86 II Decompression Routine
; written by Kirk Meyer
;
; NOTE: This must be called as a function
;       unless you modify the "ret z" line.
;
; Inputs:
;   HL -> the compressed data
;   DE -> where to store the output
;
; Outputs:
;   AF, BC, DE, HL trashed
;
Decompress:
 ld a,(hl)
 inc hl
 scf
 adc a,a
 .db $06
DecompressLoop:
 add a,a
 jr z,Decompress
 jr c,DecompressChunk
 ldi
 jr DecompressLoop
DecompressChunk:
 ld b,a
 ld c,$1F
 ld a,(hl)
 cp c
 ret z
 push bc 
 inc hl
 ld b,(hl)
 inc hl
 push hl
 ld l,b
 ld b,a
 or c
 rlca
 rlca
 rlca
 ld h,a
 ld a,b
 and c
 add a,3
 ld c,a
 ld b,0
 add hl,de
 ldir
 pop hl
 pop af
 jr DecompressLoop
