;############## Patrick Davidson data structures
; Naievil: data structures maintained to provide example


#define rs(size) =rscount \ #define rscount eval(rscount + size)

;############## High score storage definitions

SCORELEN	=6
NAME_LEN	=26
SCORE_COUNT	=12
ENTRYLEN	=SCORELEN + NAME_LEN + 1
TABLE_SIZE      =ENTRYLEN * SCORE_COUNT
     
high_scores     =$10000-TABLE_SIZE
high_scores_end =high_scores + TABLE_SIZE
last_score      =high_scores_end - ENTRYLEN

;############## Data structures for objects in arrays

#define rscount 0
b_type          rs(     1)      ; player bullet structure
b_x             rs(     1)
b_y             rs(     1)
b_image         rs(     WORDLEN)
b_size          rs(     0)
b_count         =22

#define rscount 0
e_type          rs(     1)      ; enemy structure
e_x             rs(     1)
e_y             rs(     1)
e_image         rs(     WORDLEN)
e_misc          rs(     1)
e_dmg           rs(     1)
e_pattern       rs(     WORDLEN)
e_size          rs(     0)
e_count         =21


#define rscount 0
eb_type         rs(     1)      ; enemy bullet structure
eb_x            rs(     1)
eb_y            rs(     1)
eb_image        rs(     WORDLEN)
eb_misc         rs(     1)
eb_size         rs(     0)
eb_count        =25

;############## Allocation of storage within statVars

#define rscount $FC00

saved_flag      rs(     1)
data_start      rs(     0)
bullets         rs(     b_count * b_size)
rand_inc        rs(     1)
rand_counter    rs(     1)
enemies         rs(     e_count * e_size)
enemy_bullets   rs(     eb_count * eb_size)
lives           rs(     1)
player_cd       rs(     1)
score_inc       rs(     1)
level           rs(     1)
enemy_delay     rs(     1)
enemy_entry     rs(     WORDLEN)
enemy_image     rs(     WORDLEN)
p_x             rs(     1)
p_y             rs(     1)
p_image         rs(     WORDLEN)
p_weapon        rs(     1)
flag_spin       rs(     1)
delay_amount    rs(     WORDLEN)
score           rs(     7)
bonus_countdown rs(     1)
data_end        rs(     0)
frame_count     rs(     WORDLEN)
fire_pressed    rs(     1)
enemies_left    rs(     1)
all_data_end    rs(     0)

#if     rscount > (high_scores)
        .error  "!!!!!!!!!!!!!!!! data structure is oversized"
#endif