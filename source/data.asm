;############## Data structure template used from Calcuzap

#define rs(size) =rscount \ #define rscount eval(rscount + size)
;############## Data structures for objects in arrays

#define rscount 0
b_type          rs(     1)      ; player bullet structure
b_x             rs(     1)
b_y             rs(     1)
b_image         rs(     2)
b_size          rs(     0)
b_count         =8

#define rscount 0
e_type          rs(     1)      ; enemy structure
e_x             rs(     1)
e_y             rs(     1)
e_image         rs(     2)
e_misc          rs(     1)
e_dmg           rs(     1)
e_pattern       rs(     2)
e_size          rs(     0)
e_count         =16


#define rscount 0
eb_type         rs(     1)      ; enemy bullet structure
eb_x            rs(     1)
eb_y            rs(     1)
eb_image        rs(     2)
eb_misc         rs(     1)
eb_size         rs(     0)
eb_count        =25

;############## Allocation of storage within statVars

#define rscount $FC00

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
enemy_entry     rs(     2)
enemy_image     rs(     2)
p_x             rs(     1)
p_y             rs(     1)
p_image         rs(     2)
p_weapon        rs(     1)
flag_spin       rs(     1)
delay_amount    rs(     2)
score           rs(     7)
bonus_countdown rs(     1)
data_end        rs(     0)
frame_count     rs(     2)
fire_pressed    rs(     1)
enemies_left    rs(     1)
all_data_end    rs(     0)