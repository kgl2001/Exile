{
FOR SRAM, 0,1
clear 0, &ffff

; -*- indent-tabs-mode:nil; -*-
; these values aren't tweakable yet...
load_address=$1200
base_address=$100
swram_base_addr=$8000
swram_bank_size=$4000
	
screen_width=64
IF SRAM
screen_size_pages=$40
ELSE
screen_size_pages=$20
ENDIF

IF screen_size_pages=$20:latch_b4=1:latch_b5=0
ELIF screen_size_pages=$28:latch_b4=0:latch_b5=1
ELIF screen_size_pages=$40:latch_b4=0:latch_b5=0
ELIF screen_size_pages=$50:latch_b4=1:latch_b5=1
ELSE:ERROR "bad screen size"
ENDIF

IF (screen_size_pages*256) MOD (screen_width*8)<>0:ERROR "bad screen width":ENDIF

screen_height=(screen_size_pages*256)/(screen_width*8)
PRINT "screen height:",screen_height

screen_base_page=$80-screen_size_pages

IF NOVELLA_LOOKUP = TRUE
mode7_screen_base_addr = &7c00
ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Zero page locations
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

square_is_mapped_data=&00
intro_one=&01			; also used in plotting
intro_two=&02			; also used in plotting
intro_three=&03
npc_speed=&04
something_about_player_angle=&05
current_object_rotator=&06
current_object_rotator_low=&07
square_sprite=&08
square_orientation=&09
held_object_x_low=&0A
held_object_x=&0B
held_object_y_low=&0C
held_object_y=&0D
this_object_target_object=&0E
f3_xy=&0F
f2_xy=&10                       ; also used in plotting
this_object_extra=&11           ; also used in plotting
this_object_timer=&12
this_object_timer_old=&13
this_object_tx=&14
this_object_energy=&15
this_object_ty=&16
object_onscreen=&17
wall_collision_bottom_minus_top=&18
any_collision_top_bottom=&19
wall_collision_top_minus_bottom=&1A
wall_collision_top_or_bottom=&1B
wall_collision_angle=&1C
wall_collision_frict_y_vel=&1D
wall_collision_post_angle=&1E
underwater=&1F
this_object_water_level=&20     ; also used in plotting
npc_fed=&21
npc_type=&22                    ; also used in plotting
used_in_sound=&23
object_static=&24
bells_to_sound=&25
copy_of_stack_pointer=&26
whistle1_played=&27
sucking_damage=&28
sucking_angle_modifier=&29
screen_background_flash_counter=&2A
object_is_invisible=&2B
object_affected_by_gravity=&2C
background_processing_flag=&2D
objects_to_reserve=&2E
objects_two_reserve=&2F
child_created=&30
player_crawling=&31
gun_aim_value=&32
gun_aim_velocity=&33
firing_angle=&34
sucking_distance=&35
player_bullet=&36
this_object_angle=&37
this_object_weight=&38
this_object_flags_lefted=&39
this_object_width=&3A
this_object_supporting=&3B
this_object_height=&3C
this_object_data_pointer=&3D
this_object_target=&3E
this_object_target_old=&3F
acceleration_x=&40
this_object_type=&41
acceleration_y=&42
this_object_vel_x=&43
this_object_vel_x_old=&44
this_object_vel_y=&45
this_object_vel_y_old=&46
this_object_x_max_low=&47
this_object_x_max=&48
this_object_y_max_low=&49
this_object_y_max=&4A
this_sprite_width=&4B
this_sprite_width_old=&4C
this_sprite_height=&4D
this_sprite_height_old=&4E
this_object_x_low=&4F
this_object_x_low_old=&50
this_object_y_low=&51
this_object_y_low_old=&52
this_object_x=&53
this_object_x_old=&54
this_object_y=&55
this_object_y_old=&56
this_object_screen_x_low=&57
this_object_screen_x_low_old=&58
this_object_screen_y_low=&59
this_object_screen_y_low_old=&5A
this_object_screen_x=&5B
this_object_screen_x_old=&5C
this_object_screen_y=&5D
this_object_screen_y_old=&5E
this_sprite_a=&5F
this_sprite_a_old=&60
this_sprite_b=&61
this_sprite_b_old=&62
this_sprite_flipping_flags=&63
this_sprite_flipping_flags_old=&64
this_sprite_partflip=&65
this_sprite_vertflip_old=&66
something_plot_var=&67
some_other_plot_var=&68
bytes_per_line_in_sprite=&69
copy_of_stack_pointer_6a=&6A
bytes_per_line_on_screen=&6B
lines_in_sprite=&6C
skip_sprite_calculation_flags=&6E
this_object_flags=&6F
this_object_flags_old=&70
this_object_flipping_flags=&71
this_object_flipping_flags_old=&72
this_object_palette=&73
this_object_palette_old=&74
this_object_sprite=&75
this_object_sprite_old=&76
wall_collision_count_left=&77
wall_collision_count_top=&78
wall_collision_count_right=&79
wall_collision_count_bottom=&7A
support_delta_x_low=&7B
support_delta_x_OR_wall_y_start_lookup_pointer=&7C
support_delta_y_low_OR_wall_y_start_lookup_pointer_h_4=&7D
support_delta_y_OR_wall_y_start_base=&7E
support_overlap_x_low_OR_wall_sprite=&7F
support_overlap_x_OR_wall_y_start_lookup_pointer_4=&80
support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4=&81
support_overlap_y_OR_wall_y_start_base_4=&82
distance_OR_wall_sprite_4=&83
this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left=&84
this_object_y_max_low_bumped=&85
this_object_x_centre_low_OR_particle_x_low=&87
stack_object_x_centre_low=&88
this_object_y_centre_low_OR_particle_y_low=&89
stack_object_y_centre_low=&8A
this_object_x_centre_OR_particle_x=&8B
stack_object_x_centre=&8C
this_object_y_centre_OR_particle_y=&8D
stack_object_y_centre=&8E
screen_address=&8F
other_object_weight_OR_support_weight_delta=&90
pixel_x_low=&91
pixel_x=&92
pixel_y_low=$93:screen_address_two=$93
pixel_y=$94:screen_address_two_h=$94
square_x=&95
square_y=&97
temp_a_OR_supporting_object_xy=&98
velocity_signs_OR_pixel_colour=&99
zp_various_9a=&9A
zp_various_9b=&9B
zp_various_9c=&9C
scroll_width=zp_various_9c
sprite_row_byte_offset=$9c
zp_various_9d=&9D
zp_various_9e=&9E
number_particles_OR_this_object_gravity_flags=&9F
zp_various_a0=&A0
sprite_initial_dest_offset=zp_various_a0
scroll_height=zp_various_a0
find_carry=&A1
sprite_dest_offset=find_carry
zp_various_a2=&A2
zp_various_a3=&A3
map_address=&A4
map_address_high=&A5
current_object=&AA
other_object_minus_10_OR_this_object_width_divided_32=&AB
key_number=&AC
plotter_x=&AE
strip_length=&AF
screen_offset=&B0
screen_offset_h=&B1
screen_start_square_x_low_copy=&B2
some_screen_address_offset=&B3
velocity_x=&B4
angle=&B5
velocity_y=&B6
some_kind_of_velocity=&B7
delta_magnitude=&B8
something_player_collision_value=&B9
player_immobility_daze=&BA
player_nothrust_daze=&BB
this_object_data=&BC
new_object_data_pointer=&BD
new_object_type_pointer=&BE
this_object_offscreen=&BF
loop_counter=&C0
loop_counter_every_40=&C1
loop_counter_every_20=&C2
loop_counter_every_10=&C3
loop_counter_every_08=&C4
loop_counter_every_04=&C5
loop_counter_every_02=&C6
screen_start_square_x_low=&C7
screen_start_square_x=&C8
screen_start_square_y_low=&C9
screen_start_square_y=&CA
scroll_square_x_velocity_low=&CB
scroll_square_x_velocity_high=&CC
scroll_square_y_velocity_low=&CD
scroll_square_y_velocity_high=&CE
scroll_x_direction=&CF
scroll_y_direction=&D1
something_x_acc=&D2
gun_aim_acceleration=&D3
something_y_acc=&D4
timer_1=&D9
timer_2=&DA
timer_3=&DB
timer_4=&DC
object_held=&DD
player_angle=&DE
player_facing=&DF

org load_address

org base_address

IF SRAM
.sram_ram_begin
ENDIF
.main_begin
.wall_base_y_lookup
    equb $00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$08,$10,$18,$20,$28,$30,$38
    equb $00,$10,$20,$30,$40,$50,$60,$70
    equb $08,$28,$48,$68,$88,$A8,$C8,$E8
    equb $FF,$FF,$00,$00,$00,$00,$00,$00
    equb $60,$98,$B8,$D0,$E0,$F0,$FF,$FF
    equb $00,$00,$08,$18,$28,$40,$60,$98
    equb $00,$00,$FF,$FF,$FF,$FF,$FF,$FF
    equb $38,$30,$28,$20,$18,$10,$08,$00
    equb $70,$60,$50,$40,$30,$20,$10,$00
    equb $E8,$C8,$A8,$88,$68,$48,$28,$08
    equb $00,$00,$00,$00,$00,$00,$FF,$FF
    equb $FF,$FF,$F0,$E0,$D0,$B8,$98,$60
    equb $98,$60,$40,$28,$18,$08,$00,$00
    equb $FF,$FF,$FF,$FF,$FF,$FF,$00,$00
    equb $40,$40,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$40,$40
    equb $00,$00,$FF,$FF,$FF,$FF,$00,$00
    equb $40,$40,$00,$00,$00,$00,$40,$40
    equb $80,$68,$48,$10,$00,$00,$00,$00
    equb $00,$00,$00,$00,$10,$48,$68,$80

.process_keys
    LDX #num_keys-1
    STX key_number
.L01AC
    LDX key_number              ; index 
    LDA keys_pressed,X          ; bit 7 = pressed now
    BPL not_pressed             ; taken if not pressed now
    CMP #%11000000              ; C set if held; C clear if newly
                                ; pressed
    LDA function_table_h,X      ; get routine pointer MSB (plus
                                ; flag... see table)
    ROR A                       ; put held flag into bit 7; put table
                                ; flag into C
    BPL L01BF                   ; branch taken if newly pressed
    BCS not_pressed             ; if held, and table flag set, skip it
    AND #$7F                    ; clear out bit 7
.L01BF
    JSR call_function
.not_pressed
    DEC key_number
.L01C4
    BPL L01AC
    INC keys_processed
    RTS
.call_function
    PHA
    LDA function_table,X
    PHA
    RTS

.intro2
    CLI
    LDA #screen_base_page
    STA screen_address+1
    LDA #$00
    STA screen_address
    TAY
.L01DA
    STA (screen_address),Y ; screen_address
    INY
    BNE L01DA
    INC screen_address+1
    BPL L01DA
    LDA #$01
    LDX #screen_width
    STA $FE00 ; write to video controller (register number)
    STX $FE01 ; write to video controller (register value)
    JMP main_loop

;;  &01ff and descending is the 6502 stack
.unused_stack
    equb $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
.unused_USERV
    equb $AA,$AA
.unused_BRKV
    equb $AA,$AA
    IF P%<>$204:ERROR "IRQ1V in wrong place":ENDIF
;; IRQ1V - Main interrupt vector
    equw irq_routine
;;  tables used in particle generation
;; 
;;  &0206 = particle_life_randomness_table
;;  &0207 = particle_life_table
;;  &0208 = particle_velocity_randomness_table
;;  &0209 = particle_velocity_table
;;  &020a = particle_colour_table
;;  &020b = particle_colour_randomness_table
;;  &020c = particle_flags_table
;;          &80 = set angle based on velocity or acceleration
;;          &40 = set angle based on velocity
;;          &20 = use object x/y
;;  &020d = particle_x_randomness_table
;;  &020e = particle_y_randomness_table
;;  &020f = particle_x_velocity_randomness_table
;;  &0210 = particle_y_velocity_randomness_table
;;        6  7  8  9  a  b  c  d  e  f  0
;;        life   vel   col  f  x  y xv yv
;;        r     r        r     r  r  r  r

.particle_tables
    equb $0F,$1E,$0F,$0A,$91,$02,$A0,$1F,$1F,$03,$03; + &00 # plasma ball
    equb $0F,$03,$0F,$18,$86,$01,$ED,$00,$00,$03,$03; + &0b # jetpack thrust
    equb $FF,$00,$00,$00,$91,$46,$2A,$00,$00,$2F,$2F; + &16 # explosion
    equb $07,$05,$07,$0A,$81,$02,$20,$7F,$3F,$00,$00; + &21 # fireball
    equb $07,$02,$0F,$03,$82,$01,$2A,$00,$00,$03,$03; + &2c # icer
    equb $0F,$14,$0F,$1E,$81,$42,$00,$00,$00,$0F,$03; + &37 # engine thruster
    equb $03,$10,$01,$3F,$A8,$07,$2D,$00,$00,$00,$01; + &42 # gun aim
    equb $1C,$08,$00,$00,$88,$47,$00,$FF,$FF,$00,$00; + &4d # stars / mushroom ball
    equb $0F,$14,$07,$0A,$97,$41,$22,$00,$00,$03,$03; + &58 # flask
    equb $07,$0A,$03,$06,$97,$41,$01,$00,$00,$0F,$03; + &63 # water splashes
    equb $07,$0A,$0F,$28,$97,$41,$00,$FF,$FF,$03,$03; + &6e # wind
    equb $00,$00,$00,$00,$00,$00,$00,$00,$4C
IF SRAM
    equb                                     $F4
ELSE
    equb                                     $DF
ENDIF
    equb                                         $14 ; + &79 # (unused)
    
particle_life_randomness_table=particle_tables+0
particle_life_table=particle_tables+1
particle_velocity_randomness_table=particle_tables+2
particle_velocity_table=particle_tables+3
particle_colour_table=particle_tables+4
particle_colour_randomness_table=particle_tables+5
particle_flags_table=particle_tables+6
particle_x_randomness_table=particle_tables+7
particle_y_randomness_table=particle_tables+8
particle_x_velocity_randomness_table=particle_tables+9
particle_y_velocity_randomness_table=particle_tables+10

particles_plasma_ball=0*11
particles_jetpack_thrust=1*11
particles_explosion=2*11
particles_fireball=3*11
particles_icer=4*11
particles_engine_thruster=5*11
particles_gun_aim=6*11
particles_stars=7*11
particles_flask=8*11
particles_wind=9*11
particles_unused=10*11

;; ##############################################################################
;; 
;;    Object handlers
;;    ===============
;;    background objects:
;;    no   l   h    addr  name                                  object created          80 40 20 10
;;    &00  &d7 &20  3ef2 handle_background_invisible_switch                             -  -  +  -
;;    &01  &c8 &b0  3ee3 handle_background_teleport_beam        teleport beam           +  -  +  +
;;    &02  &a4 &91  3fbf handle_background_object_from_data     (use object_data & &7f) +  -  -  +
;;    &03  &7d &f0  3e98 handle_background_door                 door                    +  +  +  +
;;    &04  &7a &f0  3e95 handle_background_stone_door           stone door              +  +  +  +
;;    &05  &9c &b1  3fb7 handle_background_object_from_type     (use object_type)       +  -  +  +
;;    &06  &9c &b1  3fb7 handle_background_object_from_type     (use object_type)       +  -  +  +
;;    &07  &9c &b1  3fb7 handle_background_object_from_type     (use object_type)       +  -  +  +
;;    &08  &b2 &b1  3fcd handle_background_switch               switch                  +  -  +  +
;;    &09  &00 &b0  3e1b handle_background_object_emerging      (use object_type)       +  -  +  +
;;    &0a  &00 &b0  3e1b handle_background_object_emerging      (use object_type)       +  -  +  +
;;    &0b  &26 &31  3f41 handle_background_object_fixed_wind                            -  -  +  +
;;    &0c  &6f &90  3e8a handle_background_engine_thruster      engine thruster         +  -  -  +
;;    &0d  &88 &31  3fa3 handle_background_object_water                                 -  -  +  +
;;    &0e  &fd &30  3f18 handle_background_object_random_wind                           -  -  +  +
;;    &0f  &b7 &31  3fd2 handle_background_mushrooms            mushroom ball           -  -  +  +
;;    &10  &7b &02  4096 handle_explosion_type_00
;;    &11  &a3 &02  40be handle_explosion_type_40
;;    &12  &a0 &02  40bb handle_explosion_type_80
;;    &13  &aa &02  40c5 handle_explosion_type_c0
;; 
;;    stack objects:
;;  r no   l   h    addr  name                        object
;;  0:&00  &f6 &0b  &4a11 handle_player_object          player
;;    &01  &bc &0a  &48d7 handle_chatter_active         active chatter
;;    &02  &d5 &88  &46f0 handle_crew_member            pericles crew member
;;    &03  &6d &84  &4288 handle_fluffy                 fluffy
;;  1:&04  &94 &cd  &4baf handle_nest                   small nest
;;    &05  &94 &cd  &4baf handle_nest                   big nest
;;  2:&06  &48 &86  &4463 handle_frogman_red            red frogman
;;    &07  &5c &86  &4477 handle_frogman_green          green frogman
;;    &08  &5a &86  &4475 handle_frogman_cyan           cyan frogman
;;    &09  &ae &09  &47c9 handle_red_slime              red slime
;;    &0a  &0f &04  &422a handle_green_slime            green slime
;;    &0b  &4b &04  &4266 handle_yellow_ball            yellow ball
;;    &0c  &6e &09  &4789 handle_sucker                 sucker
;;    &0d  &d2 &0f  &4ded handle_sucker_deadly          deadly sucker
;;    &0e  &46 &89  &4761 handle_big_fish               big fish
;;  3:&0f  &ef &83  &420a handle_worm                   worm
;;    &10  &06 &d1  &4f21 handle_nest_dweller           pirahna
;;    &11  &06 &91  &4f21 handle_nest_dweller           wasp
;;  4:&12  &dc &c4  &42f7 handle_grenade_active         active grenade
;;    &13  &a4 &c8  &46bf handle_icer_bullet            icer bullet
;;    &14  &f9 &c7  &4614 handle_tracer_bullet          tracer bullet
;;    &15  &0b &c5  &4326 handle_cannonball           cannonball
;;    &16  &17 &c5  &4332 handle_death_ball_blue        blue death ball
;;    &17  &2f &c5  &434a handle_red_bullet             red bullet
;;    &18  &00 &c6  &441b handle_pistol_bullet          pistol bullet
;;    &19  &6d &8c  &4a88 handle_plasma_ball            plasma ball
;;    &1a  &cc &45  &43e7 handle_hover_ball             hover ball
;;    &1b  &d0 &45  &43eb handle_hover_ball_invisible   invisible hover ball
;;  5:&1c  &c3 &50  &4ede handle_robot                  magenta robot
;;    &1d  &c3 &50  &4ede handle_robot                  red robot
;;    &1e  &c7 &50  &4ee2 handle_robot_blue             blue robot
;;    &1f  &bd &50  &4ed8 handle_turret                 green/white turret
;;    &20  &bd &50  &4ed8 handle_turret                 cyan/red turret
;;    &21  &e9 &49  &4804 handle_hovering_robot         hovering robot
;;  6:&22  &04 &4a  &481f handle_clawed_robot           magenta clawed robot
;;    &23  &04 &4a  &481f handle_clawed_robot           cyan clawed robot
;;    &24  &04 &4a  &481f handle_clawed_robot           green clawed robot
;;    &25  &04 &4a  &481f handle_clawed_robot           red clawed robot
;;    &26  &e9 &08  &4704 handle_triax                  triax
;;    &27  &37 &90  &4e52 handle_maggot                 maggot
;;    &28  &55 &c3  &4170 handle_gargoyle               gargoyle
;;    &29  &d4 &86  &44ef handle_imp                    red/magenta imp
;;    &2a  &d4 &86  &44ef handle_imp                    red/yellow imp
;;    &2b  &d4 &86  &44ef handle_imp                    blue/cyan imp
;;    &2c  &d4 &86  &44ef handle_imp                    cyan/yellow imp
;;    &2d  &d4 &86  &44ef handle_imp                    red/cyan imp
;;    &2e  &16 &88  &4631 handle_bird                   green/yellow bird
;;    &2f  &16 &88  &4631 handle_bird                   white/yellow bird
;;    &30  &06 &88  &4621 handle_bird_red               red/magenta bird
;;    &31  &10 &88  &462b handle_bird_invisible         invisible bird
;;  7:&32  &e6 &02  &4000 handle_lightning              lightning
;;    &33  &7d &08  &4698 handle_mushroom_ball          red mushroom ball
;;    &34  &7d &08  &4698 handle_mushroom_ball          blue mushroom ball
;;    &35  &76 &09  &4791 handle_engine_fire            engine fire
;;    &36  &7e &c9  &4799 handle_red_drop               red drop
;;    &37  &bb &0c  &4ad6 handle_fireball               fireball
;;  8:&38  &a6 &0a  &48c1 handle_chatter_inactive       inactive chatter
;;    &39  &0b &0d  &4b26 handle_moving_fireball        moving fireball
;;    &3a  &81 &05  &439c handle_giant_wall             giant wall
;;    &3b  &fa &0d  &4c15 handle_engine_thruster        engine thruster
;;    &3c  &68 &ce  &4c83 handle_door                   horizontal door
;;    &3d  &68 &ce  &4c83 handle_door                   vertical door
;;    &3e  &68 &ce  &4c83 handle_door                   horizontal stone door
;;    &3f  &68 &ce  &4c83 handle_door                   vertical stone door
;;    &40  &8e &0d  &4ba9 handle_bush                   bush
;;    &41  &6b &0f  &4d86 handle_teleport_beam          teleport beam
;;    &42  &82 &cb  &499d handle_switch                 switch
;;    &43  &92 &05  &43ad (null function)               chest
;;    &44  &81 &11  &4f9c handle_explosion              explosion
;;    &45  &92 &05  &43ad (null function)               rock
;;    &46  &d3 &02  &40ee handle_cannon                 cannon
;;    &47  &fb &43  &4216 handle_mysterious_weapon      mysterious weapon
;;    &48  &84 &03  &419f handle_maggot_machine         maggot machine
;;    &49  &49 &0d  &4b64 handle_placeholder            placeholder
;;  9:&4a  &59 &05  &4374 handle_destinator             destinator
;;    &4b  &45 &85  &4360 handle_energy_capsule         energy capsule
;;    &4c  &8c &05  &43a7 handle_flask                  empty flask
;;    &4d  &93 &05  &43ae handle_flask_full             full flask
;;    &4e  &36 &05  &4351 handle_remote_control         remote control device
;;    &4f  &36 &05  &4351 handle_remote_control         cannon control device
;;    &50  &3d &c3  &4158 handle_grenade_inactive       inactive grenade
;;    &51  &6d &0d  &4b88 handle_collectable            cyan/yellow/green key
;;    &52  &6d &0d  &4b88 handle_collectable            red/yellow/green key
;;    &53  &6d &0d  &4b88 handle_collectable            green/yellow/red key
;;    &54  &6d &0d  &4b88 handle_collectable            yellow/white/red key
;;    &55  &af &03  &41ca handle_coronium_boulder       coronium boulder
;;    &56  &6d &0d  &4b88 handle_collectable            red/magenta/red key
;;    &57  &6d &0d  &4b88 handle_collectable            blue/cyan/green key
;;    &58  &a7 &03  &41c2 handle_coronium_crystal       coronium crystal
;;    &59  &6d &0d  &4b88 handle_collectable            jetpack booster
;;    &5a  &6d &0d  &4b88 handle_collectable            pistol
;;    &5b  &6d &0d  &4b88 handle_collectable            icer
;;    &5c  &6d &0d  &4b88 handle_collectable            discharge device
;;    &5d  &6d &0d  &4b88 handle_collectable            plasma gun
;;    &5e  &6d &0d  &4b88 handle_collectable            protection suit
;;    &5f  &6d &0d  &4b88 handle_collectable            fire immunity device
;;    &60  &6d &0d  &4b88 handle_collectable            mushroom immunity pull
;;    &61  &6d &0d  &4b88 handle_collectable            whistle 1
;;    &62  &6d &0d  &4b88 handle_collectable            whistle 2
;;    &63  &6d &0d  &4b88 handle_collectable            radiation immunity pull
;;    &64  &92 &05  &43ad (null function)               ?
;; 
;; ##############################################################################

.object_sprite_lookup
IF NOVELLA_LOOKUP = TRUE
l0296 = object_sprite_lookup+12
ENDIF
    ;;   0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $04,$14,$04,$75,$1E,$1B,$10,$10,$10,$1C,$1C,$20,$70,$70,$61,$52; 00
    equb $72,$4F,$21,$08,$08,$21,$21,$08,$08,$21,$78,$78,$13,$13,$13,$5E; 10
    equb $5E,$15,$16,$16,$16,$16,$04,$52,$45,$64,$64,$64,$64,$64,$59,$59; 20
    equb $59,$59,$6D,$63,$63,$0B,$0F,$17,$14,$17,$39,$17,$4A,$4B,$3C,$41; 30
    equb $1A,$71,$2E,$5D,$17,$20,$56,$57,$47,$22,$60,$7B,$76,$76,$58,$58; 40
    equb $21,$4D,$4D,$4D,$4D,$20,$4D,$4D,$22,$6B,$6C,$6C,$79,$6C,$04,$7A; 50
    equb $63,$7C,$7C,$79,$77; 60
.object_palette_lookup
    ;;  & &80 = can be picked up
    ;;  & &7f = palette
    ;;   0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $3E,$1B,$2E,$F2,$32,$32,$53,$05,$0F,$14,$29,$BC,$65,$65,$F7,$97; 00
    equb $D3,$C7,$EF,$7E,$5F,$3C,$5A,$11,$2D,$34,$E1,$80,$55,$1B,$4C,$59; 10
    equb $23,$72,$2E,$7B,$77,$33,$39,$8B,$44,$51,$0D,$46,$2B,$53,$35,$3C; 20
    equb $02,$01,$70,$9C,$CF,$00,$14,$10,$4B,$10,$0C,$34,$6B,$6B,$42,$42; 30
    equb $31,$6F,$15,$2E,$12,$CB,$33,$B1,$62,$00,$DB,$9F,$8F,$CF,$E5,$8E; 40
    equb $EF,$AB,$AD,$95,$9C,$91,$92,$A6,$91,$B1,$8E,$E0,$A2,$B5,$B3,$E3; 50
    equb $D5,$E3,$D7,$F0,$F1; 60
.object_gravity_flags
    ;;  & &80 = doesn't collide with other objects
    ;;  & &07 = weight; 01 = light, 06 = heavy, 07 = static
    ;;   0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $03,$23,$23,$22,$77,$77,$26,$6D,$6E,$F7,$6E,$25,$F7,$F7,$25,$69; 00
    equb $6B,$68,$04,$63,$66,$66,$65,$66,$62,$64,$69,$69,$24,$25,$26,$77; 10
    equb $77,$23,$05,$05,$05,$05,$04,$68,$77,$6A,$6C,$6B,$6B,$6C,$6C,$6C; 20
    equb $6D,$6D,$E5,$61,$61,$E4,$E5,$E8,$24,$EC,$26,$D7,$57,$57,$57,$57; 30
    equb $D6,$D7,$57,$25,$82,$26,$25,$24,$77,$74,$24,$02,$22,$24,$22,$22; 40
    equb $24,$23,$23,$23,$23,$25,$23,$23,$02,$26,$23,$23,$23,$23,$26,$25; 50
    equb $22,$22,$22,$25,$E7; 60
.object_handler_table
    ;; for background objects / explosions
    equb LO(handle_background_invisible_switch-handlers_start)   ; 
    equb LO(handle_background_teleport_beam-handlers_start)      ; 
    equb LO(handle_background_object_from_data-handlers_start)   ; 
    equb LO(handle_background_door-handlers_start)               ; 
    equb LO(handle_background_stone_door-handlers_start)         ; 
    equb LO(handle_background_object_from_type-handlers_start)   ; 
    equb LO(handle_background_object_from_type-handlers_start)   ; 
    equb LO(handle_background_object_from_type-handlers_start)   ; 
    equb LO(handle_background_switch-handlers_start)             ; 
    equb LO(handlers_start-handlers_start)                       ; 
    equb LO(handlers_start-handlers_start)                       ; 
    equb LO(handle_background_object_fixed_wind-handlers_start)  ; 
    equb LO(handle_background_engine_thruster-handlers_start)    ; 
    equb LO(handle_background_object_water-handlers_start)       ; 
    equb LO(handle_background_object_random_wind-handlers_start) ; 
    equb LO(handle_background_mushrooms-handlers_start)          ; 
    equb LO(handle_explosion_type_00-handlers_start)
    equb LO(handle_explosion_type_40-handlers_start)
    equb LO(handle_explosion_type_80-handlers_start)
    equb LO(handle_explosion_type_c0-handlers_start)
    equb LO(handle_player_object-handlers_start)
    equb LO(handle_chatter_active-handlers_start)
    equb LO(handle_crew_member-handlers_start)
    equb LO(handle_fluffy-handlers_start)
    equb LO(handle_nest-handlers_start)
    equb LO(handle_nest-handlers_start)
    equb LO(handle_frogman_red-handlers_start)
    equb LO(handle_frogman_green-handlers_start)
    equb LO(handle_frogman_cyan-handlers_start)
    equb LO(handle_red_slime-handlers_start)
    equb LO(handle_green_slime-handlers_start)
    equb LO(handle_yellow_ball-handlers_start)
    equb LO(handle_sucker-handlers_start)
    equb LO(handle_sucker_deadly-handlers_start)
    equb LO(handle_big_fish-handlers_start)
    equb LO(handle_worm-handlers_start)
    equb LO(handle_nest_dweller-handlers_start)
    equb LO(handle_nest_dweller-handlers_start)
    equb LO(handle_active_grenade-handlers_start)
    equb LO(handle_icer_bullet-handlers_start)
    equb LO(handle_tracer_bullet-handlers_start)
    equb LO(handle_cannonball-handlers_start)
    equb LO(handle_death_ball_blue-handlers_start)
    equb LO(handle_red_bullet-handlers_start)
    equb LO(handle_pistol_bullet-handlers_start)
    equb LO(handle_plasma_ball-handlers_start)
    equb LO(handle_hover_ball-handlers_start)
    equb LO(handle_hover_ball_invisible-handlers_start)
    equb LO(handle_robot-handlers_start)
    equb LO(handle_robot-handlers_start)
    equb LO(handle_robot_blue-handlers_start)
    equb LO(handle_turret-handlers_start)
    equb LO(handle_turret-handlers_start)
    equb LO(handle_hovering_robot-handlers_start)
    equb LO(handle_clawed_robot-handlers_start)
    equb LO(handle_clawed_robot-handlers_start)
    equb LO(handle_clawed_robot-handlers_start)
    equb LO(handle_clawed_robot-handlers_start)
    equb LO(handle_triax-handlers_start)
    equb LO(handle_maggot-handlers_start)
    equb LO(handle_gargoyle-handlers_start)
    equb LO(handle_imp-handlers_start)
    equb LO(handle_imp-handlers_start)
    equb LO(handle_imp-handlers_start)
    equb LO(handle_imp-handlers_start)
    equb LO(handle_imp-handlers_start)
    equb LO(handle_bird-handlers_start)
    equb LO(handle_bird-handlers_start)
    equb LO(handle_bird_red-handlers_start)
    equb LO(handle_bird_invisible-handlers_start)
    equb LO(unused_object_handler-handlers_start)
    equb LO(handle_mushroom_ball-handlers_start)
    equb LO(handle_mushroom_ball-handlers_start)
    equb LO(handle_engine_fire-handlers_start)
    equb LO(handle_red_drop-handlers_start)
    equb LO(handle_fireball-handlers_start)
    equb LO(handle_chatter_inactive-handlers_start)
    equb LO(handle_moving_fireball-handlers_start)
    equb LO(handle_giant_wall-handlers_start)
    equb LO(handle_engine_thruster-handlers_start)
    equb LO(handle_door-handlers_start)
    equb LO(handle_door-handlers_start)
    equb LO(handle_door-handlers_start)
    equb LO(handle_door-handlers_start)
    equb LO(handle_bush-handlers_start)
    equb LO(handle_teleport_beam-handlers_start)
    equb LO(handle_switch-handlers_start)
    equb LO(L43AD-handlers_start)
    equb LO(handle_explosion-handlers_start)
    equb LO(L43AD-handlers_start)
    equb LO(handle_cannon-handlers_start)
    equb LO(handle_mysterious_weapon-handlers_start)
    equb LO(handle_maggot_machine-handlers_start)
    equb LO(handle_placeholder-handlers_start)
    equb LO(handle_destinator-handlers_start)
    equb LO(handle_energy_capsule-handlers_start)
    equb LO(handle_flask-handlers_start)
    equb LO(handle_flask_full-handlers_start)
    equb LO(handle_remote_control-handlers_start)
    equb LO(handle_remote_control-handlers_start)
    equb LO(handle_grenade_inactive-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_coronium_boulder-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_coronium_crystal-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(handle_collectable-handlers_start)
    equb LO(L43AD-handlers_start)
.object_handler_table_h
    ;;  & &c0 = how the object explodes
    ;; for background objects / explosions
    equb HI(handle_background_invisible_switch-handlers_start) OR (1<<5)
    equb HI(handle_background_teleport_beam-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handle_background_object_from_data-handlers_start) OR (1<<7) OR (1<<4)
    equb HI(handle_background_door-handlers_start) OR (1<<7) OR (1<<6) OR (1<<5) OR (1<<4)
    equb HI(handle_background_stone_door-handlers_start) OR (1<<7) OR (1<<6) OR (1<<5) OR (1<<4)
    equb HI(handle_background_object_from_type-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handle_background_object_from_type-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handle_background_object_from_type-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handle_background_switch-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handlers_start-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handlers_start-handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb HI(handle_background_object_fixed_wind-handlers_start) OR (1<<5) OR (1<<4)
    equb HI(handle_background_engine_thruster-handlers_start) OR (1<<7) OR (1<<4)
    equb HI(handle_background_object_water-handlers_start) OR (1<<5) OR (1<<4)
    equb HI(handle_background_object_random_wind-handlers_start) OR (1<<5) OR (1<<4)
    equb HI(handle_background_mushrooms-handlers_start) OR (1<<5) OR (1<<4)
    equb HI(handle_explosion_type_00-handlers_start)
    equb HI(handle_explosion_type_40-handlers_start)
    equb HI(handle_explosion_type_80-handlers_start)
    equb HI(handle_explosion_type_c0-handlers_start)
    equb HI(handle_player_object-handlers_start)
    equb HI(handle_chatter_active-handlers_start)
    equb HI(handle_crew_member-handlers_start) OR (1<<7)
    equb HI(handle_fluffy-handlers_start) OR (1<<7)
    equb HI(handle_nest-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_nest-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_frogman_red-handlers_start) OR (1<<7)
    equb HI(handle_frogman_green-handlers_start) OR (1<<7)
    equb HI(handle_frogman_cyan-handlers_start) OR (1<<7)
    equb HI(handle_red_slime-handlers_start)
    equb HI(handle_green_slime-handlers_start)
    equb HI(handle_yellow_ball-handlers_start)
    equb HI(handle_sucker-handlers_start)
    equb HI(handle_sucker_deadly-handlers_start)
    equb HI(handle_big_fish-handlers_start) OR (1<<7)
    equb HI(handle_worm-handlers_start) OR (1<<7)
    equb HI(handle_nest_dweller-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_nest_dweller-handlers_start) OR (1<<7)
    equb HI(handle_active_grenade-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_icer_bullet-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_tracer_bullet-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_cannonball-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_death_ball_blue-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_red_bullet-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_pistol_bullet-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_plasma_ball-handlers_start) OR (1<<7)
    equb HI(handle_hover_ball-handlers_start) OR (1<<6)
    equb HI(handle_hover_ball_invisible-handlers_start) OR (1<<6)
    equb HI(handle_robot-handlers_start) OR (1<<6)
    equb HI(handle_robot-handlers_start) OR (1<<6)
    equb HI(handle_robot_blue-handlers_start) OR (1<<6)
    equb HI(handle_turret-handlers_start) OR (1<<6)
    equb HI(handle_turret-handlers_start) OR (1<<6)
    equb HI(handle_hovering_robot-handlers_start) OR (1<<6)
    equb HI(handle_clawed_robot-handlers_start) OR (1<<6)
    equb HI(handle_clawed_robot-handlers_start) OR (1<<6)
    equb HI(handle_clawed_robot-handlers_start) OR (1<<6)
    equb HI(handle_clawed_robot-handlers_start) OR (1<<6)
    equb HI(handle_triax-handlers_start)
    equb HI(handle_maggot-handlers_start) OR (1<<7)
    equb HI(handle_gargoyle-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_imp-handlers_start) OR (1<<7)
    equb HI(handle_imp-handlers_start) OR (1<<7)
    equb HI(handle_imp-handlers_start) OR (1<<7)
    equb HI(handle_imp-handlers_start) OR (1<<7)
    equb HI(handle_imp-handlers_start) OR (1<<7)
    equb HI(handle_bird-handlers_start) OR (1<<7)
    equb HI(handle_bird-handlers_start) OR (1<<7)
    equb HI(handle_bird_red-handlers_start) OR (1<<7)
    equb HI(handle_bird_invisible-handlers_start) OR (1<<7)
    equb HI(unused_object_handler-handlers_start)
    equb HI(handle_mushroom_ball-handlers_start)
    equb HI(handle_mushroom_ball-handlers_start)
    equb HI(handle_engine_fire-handlers_start)
    equb HI(handle_red_drop-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_fireball-handlers_start)
    equb HI(handle_chatter_inactive-handlers_start)
    equb HI(handle_moving_fireball-handlers_start)
    equb HI(handle_giant_wall-handlers_start)
    equb HI(handle_engine_thruster-handlers_start)
    equb HI(handle_door-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_door-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_door-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_door-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_bush-handlers_start)
    equb HI(handle_teleport_beam-handlers_start)
    equb HI(handle_switch-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(L43AD-handlers_start)
    equb HI(handle_explosion-handlers_start)
    equb HI(L43AD-handlers_start)
    equb HI(handle_cannon-handlers_start)
    equb HI(handle_mysterious_weapon-handlers_start) OR (1<<6)
    equb HI(handle_maggot_machine-handlers_start)
    equb HI(handle_placeholder-handlers_start)
    equb HI(handle_destinator-handlers_start)
    equb HI(handle_energy_capsule-handlers_start) OR (1<<7)
    equb HI(handle_flask-handlers_start)
    equb HI(handle_flask_full-handlers_start)
    equb HI(handle_remote_control-handlers_start)
    equb HI(handle_remote_control-handlers_start)
    equb HI(handle_grenade_inactive-handlers_start) OR (1<<7) OR (1<<6)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_coronium_boulder-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_coronium_crystal-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(handle_collectable-handlers_start)
    equb HI(L43AD-handlers_start)

;; ##############################################################################
;; 
;;    Background sprites
;;    ==================
;; 
;;    00 = bottom left, unflipped
;;    40 = top left, vertical flip
;;    80 = bottom right, horizontal flip
;;    c0 = top right, vertical & horizontal flip
;; 
;;    00 = bush
;;    01 = stone \ wall, filled in bottom left
;;    02 = turret, top, facing left
;;    03 = door, horizontal, top
;;    04 = brick wall, solid
;;    05 = brick wall, 3/4 full, \, filled in bottom left
;;    06 = brick wall, \, starting top left, ending middle right
;;    07 = stone wall, bottom edging
;;    08 = nothing ?
;;    09 = sucker, bottom
;;    0a = big pipe entrance, bottom
;;    0b = wind
;;    0c = engine exhaust, \ filled in bottom left
;;    0d = water
;;    0e = mushrooms, bottom right corner
;;    0f = mushrooms, bottom
;;    10 = green stone wall, bottom edging
;;    11 = green leaf, bottom left corner
;;    12 = brick wall, solid
;;    13 = brick wall, \, starting top middle, ending middle right, 3/4 full
;;    14 = spaceship pipework
;;    15 = thin spaceship wall, left side
;;    16 = thick spaceship wall, bottom edge
;;    17 = thin spacewship wall, bottom edge
;;    18 = flag? left side
;;    19 = nothing ?
;;    1a = half a bush, bottom left corner
;;    1b = bush, bottom left corner
;;    1c = spaceship tiny corner piece, bottom left
;;    1d = spaceship 3/4 corner piece, bottom left
;;    1e = brick wall, solid
;;    1f = brick wall, bottom half
;;    20 = horizontal brick door
;;    21 = pillar, left edge
;;    22 = green leaf, bottom left corner
;;    23 = brick \ wall, filled in bottom left
;;    24 = brick wall, \, starting top left, ending middle right
;;    25 = brick wall, \, starting middle left, ending bottom right
;;    26 = spaceship wall, \, starting top left, ending half top right
;;    27 = spaceship wall, \, starting half top left, ending middle right
;;    28 = spaceship wall, \, starting middle left, ending half bottom right
;;    29 = spaceship wall, \, starting half bottom left, ending bottom left
;;    2a = brick wall, \, very steep down
;;    2b = couple of pixels of stone edging strip, bottom
;;    2c = stone edge, bottom
;;    2d = stone wall, solid
;;    2e = stone \ wall, filled in bottom left
;;    2f = stone \ wall, starting top left, ending middle right
;;    30 = stone \ wall, starting middle left, ending bottom right
;;    31 = stone - wall, filled bottom
;;    32 = spaceship corner with pipes, filled
;;    33 = pipe, bottom
;;    34 = pipe, bottom left corner
;;    35 = pipe, left
;;    36 = spaceship - wall, filled bottom
;;    37 = spaceship corner with pipes, filled
;;    38 = spaceship pipes, half, filled bottom
;;    39 = vertical brick door
;;    3a = gargoyle, bottom left
;;    3b = brick wall, 3/4 filled bottom
;;    3c = big pipe entrance, bottom
;;    3d = spaceship support
;;    3e = computer console, bottom left
;;    3f = hydraulic leg
;; 
;; ##############################################################################

.background_sprite_lookup
;;  & &7f = sprite
;;  & &80 = vertically flipped
;;       0   1    2  3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $C6,$CE,$C6,$C6,$C6,$BB,$C6,$18,$2D,$70,$6A,$C6,$23,$39,$C6,$62 ; 0
    equb $C0,$8E,$39,$44,$47,$26,$48,$49,$DF,$C6,$99,$9A,$25,$2B,$39,$3B ; 1
    equb $3C,$55,$8E,$43,$34,$35,$27,$28,$29,$2A,$42,$BF,$40,$3D,$38,$36 ; 2
    equb $37,$3E,$33,$31,$2F,$30,$2C,$24,$32,$41,$45,$3A,$6A,$23,$60,$CC ; 3
.background_y_offset_lookup
;;       0   1    2  3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $00,$00,$00,$00,$00,$00,$00,$D0,$C5,$B0,$C7,$00,$06,$00,$00,$C0 ; 0
    equb $B0,$A0,$07,$08,$00,$04,$80,$C0,$70,$00,$B0,$80,$99,$08,$00,$80 ; 1
    equb $C0,$00,$A0,$03,$02,$82,$01,$41,$81,$C1,$04,$F0,$B0,$00,$03,$02 ; 2
    equb $82,$70,$06,$C0,$C5,$04,$80,$06,$80,$04,$99,$30,$C7,$06,$A9,$00 ; 3
.background_palette_lookup
;;       0   1    2  3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $80,$02,$91,$91,$91,$00,$91,$A8,$DC,$B8,$8C,$80,$C9,$4A,$80,$06 ; 0
    equb $88,$05,$04,$00,$02,$02,$02,$02,$02,$91,$03,$03,$02,$02,$00,$00 ; 1
    equb $00,$BC,$B1,$00,$00,$00,$01,$01,$01,$01,$00,$04,$04,$04,$04,$04 ; 2
    equb $04,$04,$02,$01,$01,$01,$02,$02,$02,$00,$00,$00,$82,$02,$64,$EE ; 3
.background_wall_y_start_base_lookup
;;       0   1    2  3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $0F,$3A,$0F,$0F,$0F,$77,$0F,$F0,$B0,$F0,$C0,$0F,$00,$F0,$0F,$F0 ; 0
    equb $0F,$0F,$00,$06,$0F,$00,$77,$B3,$0F,$0F,$0F,$0F,$90,$06,$0F,$77 ; 1
    equb $B3,$F0,$0F,$10,$07,$70,$0B,$37,$73,$B0,$00,$0F,$B3,$0F,$10,$07 ; 2
    equb $70,$77,$00,$B3,$B0,$00,$77,$00,$77,$00,$90,$2C,$C0,$00,$90,$0F ; 3
.background_wall_y_start_lookup
;;  Add &100 to get address in wall_base_y_lookup
;;        --  -V  H-  HV
    equb $00,$00,$00,$00
    equb $08,$40,$40,$08
    equb $10,$48,$48,$10
    equb $18,$50,$50,$18
    equb $38,$20,$70,$58
    equb $38,$78,$70,$80
    equb $30,$60,$68,$28
    equb $88,$90,$88,$90
    equb $A0,$50,$98,$18
    equb $18,$98,$50,$A0
.background_objects_range_minus_one
    equb $00
.background_objects_range
;;  [TOM background_objects_range 1d was 19]
    equb $1D,$39,$57,$7A,$9E,$BC,$D8,$F6,$FE
.background_objects_data_offset
;        +1  -2  -5  -6  -8  -11 -11 -13 -13
    equb $01,$FE,$FB,$FA,$F8,$F5,$F5,$F3,$F3
.background_objects_type_offset
    equb $00,$F5,$E9,$DE,$CE,$BE,$B1,$A1,$98
.background_objects_x_lookup
;        0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f   10  11  12  13  14  15  16  17  18  19  1a  1b  1c
    equb $FF,$FF,$B0,$EC,$77,$64,$9A,$AF,$DA,$C6,$36,$9F,$2E,$A9,$9C,$83,$88,$5F,$57,$BF,$9D,$4D,$45,$81,$B3,$3F,$CB,$40,$4C
;        1d  1e  1f  20  21  22  23  24  25  26  27  28  29  2a  2b  2c  2d  2e  2f  30  31  32  33  34  35  36  37  38
    equb $CA,$2F,$A7,$56,$34,$E3,$3B,$E4,$80,$E0,$64,$37,$47,$9F,$9C,$AA,$9B,$9A,$5E,$C7,$8A,$60,$9D,$A2,$B2,$98,$A9,$DB
;        39  3a  3b  3c  3d  3e  3f  40  41  42  43  44  45  46  47  48  49  4a  4b  4c  4d  4e  4f  50  51  52  53  54  55  56
    equb $28,$29,$3C,$98,$63,$CB,$61,$A3,$CE,$E9,$80,$2E,$4F,$79,$87,$B6,$97,$2D,$D6,$5C,$A0,$74,$6A,$A1,$9F,$89,$85,$6B,$AE,$65
;        57  58  59  5a  5b  5c  5d  5e  5f  60  61  62  63  64  65  66  67  68  69  6a  6b  6c  6d  6e  6f  70  71  72  73  74  75  76  77  78  79
    equb $E2,$ED,$80,$CD,$A8,$2B,$AB,$9D,$62,$E5,$70,$EC,$83,$C1,$C6,$67,$EB,$2D,$98,$AA,$CC,$A5,$9E,$A2,$D7,$E6,$E7,$94,$7C,$E3,$45,$9B,$9F,$C2,$71
;        7a  7b  7c  7d  7e  7f  80  81  82  83  84  85  86  87  88  89  8a  8b  8c  8d  8e  8f  90  91  92  93  94  95  96  97  98  99  9a  9b  9c  9d
    equb $67,$4F,$CF,$D2,$E2,$7A,$62,$DA,$76,$B2,$66,$D7,$83,$84,$80,$87,$9B,$50,$AE,$64,$A3,$63,$B8,$7F,$82,$E0,$9C,$61,$9D,$29,$46,$9F,$9A,$74,$75,$77
;        9e  9f  a0  a1  a2  a3  a4  a5  a6  a7  a8  a9  aa  ab  ac  ad  ae  af  b0  b1  b2  b3  b4  b5  b6  b7  b8  b9  ba  bb
    equb $B2,$E4,$62,$63,$82,$61,$D4,$D3,$77,$2E,$64,$86,$A5,$A0,$D1,$B4,$7F,$A3,$9F,$99,$80,$67,$DA,$89,$95,$8B,$AB,$C4,$9D,$AA
;        bc  bd  be  bf  c0  c1  c2  c3  c4  c5  c6  c7  c8  c9  ca  cb  cc  cd  ce  cf  d0  d1  d2  d3  d4  d5  d6  d7
    equb $BB,$47,$8A,$A7,$61,$9E,$2E,$D6,$7E,$DA,$AA,$AB,$45,$67,$D4,$29,$B8,$6B,$69,$9D,$94,$63,$B4,$A1,$9F,$A0,$57,$E1
;        d8  d9  da  db  dc  dd  de  df  e0  e1  e2  e3  e4  e5  e6  e7  e8  e9  ea  eb  ec  ed  ee  ef  f0  f1  f2  f3  f4  f5
    equb $7F,$A6,$B4,$53,$61,$D4,$82,$E3,$75,$C3,$84,$9E,$C6,$64,$A2,$28,$29,$9D,$83,$A8,$80,$AA,$D5,$A0,$9F,$D6,$62,$69,$2C,$A5
;        f6  f7  f8  f9  fa  fb  fc  fd 
    equb $B8,$B9,$D9,$59,$79,$39,$48,$E8
;        fe
    equb $03
    
.background_objects_handler_lookup
IF NOVELLA_LOOKUP = TRUE
l07e7 = background_objects_handler_lookup+249
ENDIF
    equb $89,$89,$89,$89,$89,$8A,$46,$C6,$06,$06,$46,$05,$05,$00,$C3,$04
    equb $83,$84,$84,$83,$88,$48,$02,$02,$42,$02,$7B,$22,$1E,$06,$06,$C6
    equb $06,$46,$46,$85,$85,$87,$89,$89,$C7,$0A,$8C,$03,$84,$83,$43,$84
    equb $84,$02,$01,$41,$01,$01,$2E,$1E,$3B,$46,$46,$06,$C6,$06,$06,$06
    equb $46,$06,$09,$C9,$89,$CA,$8A,$8A,$0A,$4A,$8A,$04,$44,$41,$01,$C8
    equb $48,$CC,$82,$02,$02,$02,$1E,$89,$09,$0A,$4A,$CA,$4A,$86,$46,$46
    equb $46,$86,$45,$47,$00,$00,$00,$00,$84,$C3,$44,$43,$43,$43,$44,$84
    equb $44,$04,$01,$08,$08,$02,$02,$82,$1E,$2D,$46,$46,$45,$46,$C6,$89
    equb $C9,$49,$89,$CA,$CA,$8A,$8A,$8A,$0A,$00,$00,$C4,$43,$04,$43,$84
    equb $44,$04,$44,$84,$41,$01,$01,$01,$C8,$42,$82,$3B,$11,$3B,$89,$C9
    equb $CA,$8A,$C6,$06,$C6,$C6,$06,$06,$85,$47,$4A,$CA,$8A,$00,$00,$44
    equb $43,$C3,$44,$44,$04,$41,$C8,$88,$C8,$C8,$02,$8C,$49,$89,$0A,$0A
    equb $8A,$C6,$06,$06,$47,$87,$CC,$41,$01,$08,$08,$08,$08,$C4,$84,$43
    equb $43,$84,$04,$83,$82,$82,$0D,$0D,$46,$06,$06,$06,$06,$45,$45,$45
    equb $06,$07,$89,$09,$8A,$4A,$4A,$CA,$CA,$4A,$00,$00,$00,$48,$08,$82
    equb $82,$82,$02,$C4,$C4,$0B,$0B,$0B,$D1,$91,$D1,$D1,$91,$91,$0D
.background_strip_cache_orientation
    equb $2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E
.background_strip_cache_sprite
; 7f6
    equb $2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E,$2E

;; 07f8 is where the game state data starts copying from
;; 07f8 - 07fe : copy of &d9 - &df when saving position

.game_time
    equb $00,$00,$00,$00
.player_deaths
    equb $00,$00,$00
.keys_collected
    equb $00; cyan/yellow/green key
    equb $00; red/yellow/green key
    equb $00; green/yellow/red key
    equb $00; yellow/white/red key
    equb $00; (unused)
    equb $00; red/magenta/red key
    equb $00; blue/cyan/green key
    equb $00; (unused)
.booster_collected
    equb $00
.pistol
    equb $00
.icer
    equb $00
    equb $00; discharge device
    equb $00; plasma gun
.protection_suit_collected
    equb $00
.fire_immunity_collected
    equb $00
.mushroom_pill_collected
    equb $00
.whistle1_collected
    equb $00
.whistle2_collected
    equb $00
.radiation_pill_collected
    equb $00
.door_timer
    equb $00
.red_mushroom_daze
    equb $00
.blue_mushroom_daze
    equb $00
.chatter_energy_level
    equb $00
.explosion_timer
    equb $00
.endgame_value
    equb $00
.earthquake_triggered
    equb $00
    equb $FF; (unused)
.teleport_last
    equb $00
.teleports_used
    equb $00
.teleports_x
    equb $32,$8E,$D2,$63
.teleport_fallback_x
    equb $99
.teleports_y
    equb $98,$C0,$C0,$C7
.teleport_fallback_y
    equb $3C
.timers_and_eor
    equb $00
.water_level_low_by_x_range
    equb $00,$00,$00,$00
.water_level_by_x_range
    equb $CE,$DF,$C1,$C1
.desired_water_level_by_x_range
    equb $CE,$DF,$C1,$C1
.imp_gift_counts
    equb $04,$0A,$01,$01,$0A
.clawed_robot_availability
    equb $80,$80,$80,$80
.clawed_robot_energy_when_last_used
    equb $00,$00,$00,$00
.pockets_used
    equb $00
    equb $50,$50,$50,$50,$50; contents of pockets
.current_weapon
    equb $00
.weapon_energy
;; 0 = jetpack, 1 = pistol, 2 = icer, 3 = discharge, 4 = plasma, 5 = suit
;;        0   1   2   3   4   5 
    equb $00,$00,$00,$00,$00,$00
.weapon_energy_h
    equb $30,$10,$10,$01,$08,$10
.energy_per_shot
    equb $01,$06,$10,$FF,$32,$00

;; ##############################################################################
;; 
;;    Object Stack (primary)
;;    ======================
;;    (&9b, &3b) &00 player
;;    (&99, &3b) &26 triax
;;    fourteen empty slots
;; 
;; ##############################################################################

.object_stack_type
;;  [TOM object_stack_type - 24 was 47]
    equb $00,$26,$D7,$57,$57,$57,$57,$D6,$D7,$57,$25,$82,$26,$25,$24,$77
.object_stack_sprite
    equb $04,$04,$02,$22,$24,$22,$22,$24,$23,$23,$23,$23,$25,$23,$23,$02
.object_stack_x_low
    equb $C0,$64,$23,$23,$23,$26,$25,$22,$22,$22,$25,$E7,$D7,$C8,$A4,$7D
    equb $7A; seventeenth slot = target
.object_stack_x
    equb $9B,$99,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
IF SRAM
    equb $B8
ELSE
    equb $BC
ENDIF
    equb     $65; eighteenth slot = waterfall (&65, &dc), for sound
    
.object_stack_y_low
;;  [TOM object_stack_y_low - 80 was 20]
IF SRAM
    equb $80,$20,$a1,$48,$5C,$5A,$AE,$0F,$4B,$6E,$Df,$46,$EF,$13,$13,$DC
ELSE
    equb $80,$20,$94,$48,$5C,$5A,$AE,$0F,$4B,$6E,$D2,$46,$EF,$06,$06,$DC
ENDIF
    equb $A4
.object_stack_y
IF SRAM
    equb $3B,$3B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $02,$DC
ELSE
    equb $3B,$3B,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $04,$DC
ENDIF
.object_stack_flags
;;  80 set = horizontal invert (facing left)
;;  40 set = vertical invert (upside down)
;;  20 set = remove from display
;;  10 set = teleporting
;;  08 set = damaged
;;  02 set = collision detected
;;  01 set at load positon?
    equb $81,$11,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
.object_stack_palette
;;  10 set = damaged
IF SRAM
    equb $7E,$39,$A2,$18,$81,$07,$75,$75,$75,$75,$9b,$78,$7e,$92,$8e,$92
ELSE
    equb $7E,$39,$A6,$0B,$81,$FA,$68,$68,$68,$68,$8E,$6B,$82,$92,$81,$92
ENDIF
.object_stack_vel_x
IF SRAM
    equb $00,$00,$84,$56,$59,$45,$8C,$93,$36,$36,$3D,$7a,$7a,$7a,$7a,$AF
ELSE
    equb $00,$00,$84,$49,$59,$45,$8C,$93,$36,$36,$3D,$6D,$6D,$6D,$6D,$AF
ENDIF
.object_stack_vel_y
IF SRAM
    equb $00,$10,$A7,$7a,$7a,$7a,$7a,$7a,$7a,$7a,$7a,$7a,$7a,$7a,$92,$20
ELSE
    equb $00,$10,$A7,$6D,$6D,$6D,$6D,$6D,$6D,$6D,$6D,$6D,$6D,$6D,$92,$20
ENDIF
.object_stack_target
;;  [TOM object_stack_target - 02 was 20]
    equb $B0,$00,$F0,$F0,$B1,$B1,$B1,$B1,$B0,$B0,$31,$90,$31,$30,$31,$02
.object_stack_tx
    equb $02,$99,$02,$0B,$0A,$88,$84,$CD,$CD,$86,$86,$86,$09,$04,$04,$09
.object_stack_energy
    equb $FF,$C8,$83,$D1,$91,$C4,$C8,$C7,$C5,$C5,$C5,$C6,$8C,$45,$45,$50
.object_stack_ty
    equb $50,$3B,$50,$50,$49,$4A,$4A,$4A,$4A,$08,$90,$C3,$86,$86,$86,$86
.object_stack_supporting
;;  [TOM object_stack_supporting - c9 was 09]
    equb $86,$88,$88,$88,$88,$02,$08,$08,$09,$C9,$0C,$0A,$0D,$05
IF SRAM
    equb                                                         $0E
ELSE
    equb                                                         $0D
ENDIF
    equb                                                             $CE
.object_stack_timer
    equb $CE,$0E,$CE,$0D,$0F,$CB,$05,$11,$05,$02,$43,$03,$0D,$05,$85,$05
.object_stack_data_pointer
    equb $00,$05,$05,$C3,$0D,$0D,$0D,$0D,$03,$0D,$0D,$03,$0D,$0D,$0D,$0D
.object_stack_extra
    equb $0D,$0D,$0D,$0D,$0D,$0D,$0D,$05,$C6,$CE,$C6,$C6,$C6,$BB,$C6,$18

;; ##############################################################################
;; 
;;    Background objects
;;    ==================
;;    no    x            handler      data         type            x, y    handler: object
;;  0:&00 : &05ef = &ff  &06ee = &89  &0987 = &7c  &0a72 = &0f  (&ff, &??) &09: worm (x 31) (unused?)
;;    &01 : &05f0 = &ff  &06ef = &89  &0988 = &60  &0a73 = &27  (&ff, &??) &09: maggot (x 24) (unused?)
;;    &02 : &05f1 = &b0  &06f0 = &89  &0989 = &04  &0a74 = &2e  (&b0, &4e) &09: green/yellow bird
;;    &03 : &05f2 = &ec  &06f1 = &89  &098a = &88  &0a75 = &07  (&ec, &c0) &09: green frogman (x 2)
;;    &04 : &05f3 = &77  &06f2 = &89  &098b = &88  &0a76 = &2f  (&77, &54) &09: white/yellow bird (x 2)
;;    &05 : &05f4 = &64  &06f3 = &8a  &098c = &a0  &0a77 = &2d  (&64, &94) &0a: red/cyan imp (x 8)
;;    &06 : &05f5 = &9a  &06f4 = &46  &098d = &a6  &0a78 = &1f  (&9a, &80) &06: green/white turret
;;    &07 : &05f6 = &af  &06f5 = &c6  &098e = &ae  &0a79 = &1f  (&af, &61) &06: green/white turret
;;    &08 : &05f7 = &da  &06f6 = &06  &098f = &83  &0a7a = &0d  (&da, &80) &06: deadly sucker
;;    &09 : &05f8 = &c6  &06f7 = &06  &0990 = &86  &0a7b = &0d  (&c6, &c0) &06: deadly sucker
;;    &0a : &05f9 = &36  &06f8 = &46  &0991 = &82  &0a7c = &0d  (&36, &8c) &06: deadly sucker
;;    &0b : &05fa = &9f  &06f9 = &05  &0992 = &80  &0a7d = &0c  (&9f, &c0) &05: sucker
;;    &0c : &05fb = &2e  &06fa = &05  &0993 = &80  &0a7e = &60  (&2e, &94) &05: mushroom immunity pull
;;    &0d : &05fc = &a9  &06fb = &00  &0994 = &ad  &0a7f = &2c  (&a9, &9c) &00: invisible switch
;;    &0e : &05fd = &9c  &06fc = &c3  &0995 = &81  &0a80 = &00  (&9c, &3c) &03: door
;;    &0f : &05fe = &83  &06fd = &04  &0996 = &f7  &0a81 = &0d  (&83, &77) &04: stone door
;;    &10 : &05ff = &88  &06fe = &83  &0997 = &a1  &0a82 = &0d  (&88, &72) &03: door
;;    &11 : &0600 = &5f  &06ff = &84  &0998 = &f1  &0a83 = &1f  (&5f, &c0) &04: stone door
;;    &12 : &0601 = &57  &0700 = &84  &0999 = &f7  &0a84 = &0d  (&57, &94) &04: stone door
;;    &13 : &0602 = &bf  &0701 = &83  &099a = &81  &0a85 = &5c  (&bf, &80) &03: door
;;    &14 : &0603 = &9d  &0702 = &88  &099b = &8a  &0a86 = &0d  (&9d, &3b) &08: switch
;;    &15 : &0604 = &4d  &0703 = &48  &099c = &ac  &0a87 = &20  (&4d, &80) &08: switch
;;    &16 : &0605 = &45  &0704 = &02  &099d = &d2  &0a88 = &05  (&45, &4e) &02: red/yellow/green key
;;    &17 : &0606 = &81  &0705 = &02  &099e = &df  &0a89 = &04  (&81, &75) &02: fire immunity device
;;    &18 : &0607 = &b3  &0706 = &42  &099f = &d4  &0a8a = &06  (&b3, &80) &02: yellow/white/red key
;;  1:&19 : &0608 = &3f  &0707 = &02  &099d = &d2  &0a7d = &0c  (&3f, &??) &02: red/yellow/green key (unused)
;;    &1a : &0609 = &cb  &0708 = &7b  &099e = &df  &0a7e = &60  (&cb, &??) &3b: brick wall, 3/4 filled bottom (unused)
;;    &1b : &060a = &40  &0709 = &22  &099f = &d4  &0a7f = &2c  (&40, &??) &22: leaf (unused)
;;    &1c : &060b = &4c  &070a = &1e  &09a0 = &a3  &0a80 = &00  (&4c, &??) &1e: brick wall
;;    &1d : &060c = &ca  &070b = &06  &09a1 = &84  &0a81 = &0d  (&ca, &58) &06: deadly sucker
;;    &1e : &060d = &2f  &070c = &06  &09a2 = &85  &0a82 = &0d  (&2f, &94) &06: deadly sucker
;;    &1f : &060e = &a7  &070d = &c6  &09a3 = &ae  &0a83 = &1f  (&a7, &80) &06: green/white turret
;;    &20 : &060f = &56  &070e = &06  &09a4 = &80  &0a84 = &0d  (&56, &94) &06: deadly sucker
;;    &21 : &0610 = &34  &070f = &46  &09a5 = &80  &0a85 = &5c  (&34, &8c) &06: discharge device
;;    &22 : &0611 = &e3  &0710 = &46  &09a6 = &88  &0a86 = &0d  (&e3, &98) &06: deadly sucker
;;    &23 : &0612 = &3b  &0711 = &85  &09a7 = &ac  &0a87 = &20  (&3b, &c0) &05: cyan/red turret
;;    &24 : &0613 = &e4  &0712 = &85  &09a8 = &c4  &0a88 = &05  (&e4, &80) &05: big nest
;;    &25 : &0614 = &80  &0713 = &87  &09a9 = &c0  &0a89 = &04  (&80, &c5) &07: small nest
;;    &26 : &0615 = &e0  &0714 = &89  &09aa = &04  &0a8a = &06  (&e0, &98) &09: red frogman
;;    &27 : &0616 = &64  &0715 = &89  &09ab = &a8  &0a8b = &31  (&64, &80) &09: invisible bird (x 10)
;;    &28 : &0617 = &37  &0716 = &c7  &09ac = &c4  &0a8c = &05  (&37, &8c) &07: big nest
;;    &29 : &0618 = &47  &0717 = &0a  &09ad = &bc  &0a8d = &2a  (&47, &c0) &0a: red/yellow imp (x 15)
;;    &2a : &0619 = &9f  &0718 = &8c  &09ae = &fd  &0a8e = &09  (&9f, &3a) &0c: engine thruster
;;    &2b : &061a = &9c  &0719 = &03  &09af = &81  &0a8f = &0d  (&9c, &3d) &03: door
;;    &2c : &061b = &aa  &071a = &84  &09b0 = &c1  &0a90 = &0d  (&aa, &98) &04: stone door
;;    &2d : &061c = &9b  &071b = &83  &09b1 = &d1  &0a91 = &1f  (&9b, &80) &03: door
;;    &2e : &061d = &9a  &071c = &43  &09b2 = &91  &0a92 = &20  (&9a, &5c) &03: door
;;    &2f : &061e = &5e  &071d = &84  &09b3 = &f1  &0a93 = &55  (&5e, &c0) &04: stone door
;;    &30 : &061f = &c7  &071e = &84  &09b4 = &f1  &0a94 = &55  (&c7, &c0) &04: stone door
;;    &31 : &0620 = &8a  &071f = &02  &09b5 = &da  &0a95 = &0d  (&8a, &71) &02: pistol
;;    &32 : &0621 = &60  &0720 = &01  &09b6 = &f7  &0a96 = &63  (&60, &98) &01: teleport beam
;;    &33 : &0622 = &9d  &0721 = &41  &09b7 = &f3  &0a97 = &0f  (&9d, &49) &01: teleport beam
;;    &34 : &0623 = &a2  &0722 = &01  &09b8 = &d8  &0a98 = &2e  (&a2, &58) &01: teleport beam
;;    &35 : &0624 = &b2  &0723 = &01  &09b9 = &88  &0a99 = &0a  (&b2, &80) &01: teleport beam
;;    &36 : &0625 = &98  &0724 = &2e  &09ba = &80  &0a9a = &1b  (&98, &80) &2e: stone wall \
;;    &37 : &0626 = &a9  &0725 = &1e  &09bb = &83  &0a9b = &37  (&a9, &80) &1e: brick wall
;;    &38 : &0627 = &db  &0726 = &3b  &09bc = &83  &0a9c = &29  (&db, &80) &3b: brick wall, top quarter empty
;;  2:&39 : &0628 = &28  &0727 = &46  &09ba = &80  &0a8e = &09  (&28, &98) &06: red slime
;;    &3a : &0629 = &29  &0728 = &46  &09bb = &83  &0a8f = &0d  (&29, &98) &06: deadly sucker
;;    &3b : &062a = &3c  &0729 = &06  &09bc = &83  &0a90 = &0d  (&3c, &80) &06: deadly sucker
;;    &3c : &062b = &98  &072a = &c6  &09bd = &b0  &0a91 = &1f  (&98, &4e) &06: green/white turret
;;    &3d : &062c = &63  &072b = &06  &09be = &aa  &0a92 = &20  (&63, &c0) &06: cyan/red turret
;;    &3e : &062d = &cb  &072c = &06  &09bf = &80  &0a93 = &55  (&cb, &dc) &06: coronium boulder
;;    &3f : &062e = &61  &072d = &06  &09c0 = &80  &0a94 = &55  (&61, &c6) &06: coronium boulder
;;    &40 : &062f = &a3  &072e = &46  &09c1 = &87  &0a95 = &0d  (&a3, &c0) &06: deadly sucker
;;    &41 : &0630 = &ce  &072f = &06  &09c2 = &80  &0a96 = &63  (&ce, &d8) &06: radiation immunity pull
;;    &42 : &0631 = &e9  &0730 = &09  &09c3 = &30  &0a97 = &0f  (&e9, &98) &09: worm (x 12)
;;    &43 : &0632 = &80  &0731 = &c9  &09c4 = &08  &0a98 = &2e  (&80, &88) &09: green/yellow bird (x 2)
;;    &44 : &0633 = &2e  &0732 = &89  &09c5 = &10  &0a99 = &0a  (&2e, &98) &09: green slime (x 4)
;;    &45 : &0634 = &4f  &0733 = &ca  &09c6 = &7c  &0a9a = &1b  (&4f, &80) &0a: invisible hover ball (x 31)
;;    &46 : &0635 = &79  &0734 = &8a  &09c7 = &04  &0a9b = &37  (&79, &76) &0a: fireball
;;    &47 : &0636 = &87  &0735 = &8a  &09c8 = &10  &0a9c = &29  (&87, &bf) &0a: red/magenta imp (x 4)
;;    &48 : &0637 = &b6  &0736 = &0a  &09c9 = &a8  &0a9d = &1a  (&b6, &80) &0a: hover ball (x 10)
;;    &49 : &0638 = &97  &0737 = &4a  &09ca = &90  &0a9e = &1a  (&97, &5c) &0a: hover ball (x 4)
;;    &4a : &0639 = &2d  &0738 = &8a  &09cb = &04  &0a9f = &37  (&2d, &c7) &0a: fireball
;;    &4b : &063a = &d6  &0739 = &04  &09cc = &c1  &0aa0 = &37  (&d6, &72) &04: stone door
;;    &4c : &063b = &5c  &073a = &44  &09cd = &f1  &0aa1 = &0a  (&5c, &b8) &04: stone door
;;    &4d : &063c = &a0  &073b = &41  &09ce = &e1  &0aa2 = &37  (&a0, &63) &01: teleport beam
;;    &4e : &063d = &74  &073c = &01  &09cf = &95  &0aa3 = &4b  (&74, &54) &01: teleport beam
;;    &4f : &063e = &6a  &073d = &c8  &09d0 = &bc  &0aa4 = &4b  (&6a, &de) &08: switch
;;    &50 : &063f = &a1  &073e = &48  &09d1 = &b4  &0aa5 = &2d  (&a1, &58) &08: switch
;;    &51 : &0640 = &9f  &073f = &cc  &09d2 = &fd  &0aa6 = &1f  (&9f, &3b) &0c: engine thruster
;;    &52 : &0641 = &89  &0740 = &82  &09d3 = &a1  &0aa7 = &20  (&89, &72) &02: hovering robot
;;    &53 : &0642 = &85  &0741 = &02  &09d4 = &d6  &0aa8 = &0d  (&85, &bf) &02: red/magenta/red key
;;    &54 : &0643 = &6b  &0742 = &02  &09d5 = &dd  &0aa9 = &0d  (&6b, &88) &02: plasma gun
;;    &55 : &0644 = &ae  &0743 = &02  &09d6 = &e2  &0aaa = &28  (&ae, &98) &02: whistle 2
;;    &56 : &0645 = &65  &0744 = &1e  &09d7 = &04  &0aab = &55  (&65, &b4) &1e: brick wall
;;  3:&57 : &0646 = &e2  &0745 = &89  &09d7 = &04  &0aa0 = &37  (&e2, &c0) &09: fireball
;;    &58 : &0647 = &ed  &0746 = &09  &09d8 = &0c  &0aa1 = &0a  (&ed, &bc) &09: green slime (x 3)
;;    &59 : &0648 = &80  &0747 = &0a  &09d9 = &04  &0aa2 = &37  (&80, &54) &0a: fireball
;;    &5a : &0649 = &cd  &0748 = &4a  &09da = &20  &0aa3 = &4b  (&cd, &7c) &0a: energy capsule (x 8)
;;    &5b : &064a = &a8  &0749 = &ca  &09db = &21  &0aa4 = &4b  (&a8, &68) &0a: energy capsule (x 8)
;;    &5c : &064b = &2b  &074a = &4a  &09dc = &a0  &0aa5 = &2d  (&2b, &80) &0a: red/cyan imp (x 8)
;;    &5d : &064c = &ab  &074b = &86  &09dd = &b0  &0aa6 = &1f  (&ab, &80) &06: green/white turret
;;    &5e : &064d = &9d  &074c = &46  &09de = &ac  &0aa7 = &20  (&9d, &6f) &06: cyan/red turret
;;    &5f : &064e = &62  &074d = &46  &09df = &83  &0aa8 = &0d  (&62, &c0) &06: deadly sucker
;;    &60 : &064f = &e5  &074e = &46  &09e0 = &81  &0aa9 = &0d  (&e5, &bc) &06: deadly sucker
;;    &61 : &0650 = &70  &074f = &86  &09e1 = &84  &0aaa = &28  (&70, &88) &06: gargoyle
;;    &62 : &0651 = &ec  &0750 = &45  &09e2 = &80  &0aab = &55  (&ec, &bc) &05: coronium boulder
;;    &63 : &0652 = &83  &0751 = &47  &09e3 = &c4  &0aac = &05  (&83, &5c) &07: big nest
;;    &64 : &0653 = &c1  &0752 = &00  &09e4 = &85  &0aad = &80  (&c1, &7c) &00: invisible switch
;;    &65 : &0654 = &c6  &0753 = &00  &09e5 = &95  &0aae = &00  (&c6, &7c) &00: invisible switch
;;    &66 : &0655 = &67  &0754 = &00  &09e6 = &a3  &0aaf = &80  (&67, &da) &00: invisible switch
;;    &67 : &0656 = &eb  &0755 = &00  &09e7 = &b5  &0ab0 = &80  (&eb, &bc) &00: invisible switch
;;    &68 : &0657 = &2d  &0756 = &84  &09e8 = &f1  &0ab1 = &20  (&2d, &94) &04: stone door
;;    &69 : &0658 = &98  &0757 = &c3  &09e9 = &ad  &0ab2 = &28  (&98, &54) &03: door
;;    &6a : &0659 = &aa  &0758 = &44  &09ea = &c1  &0ab3 = &0d  (&aa, &9c) &04: stone door
;;    &6b : &065a = &cc  &0759 = &43  &09eb = &81  &0ab4 = &0d  (&cc, &7c) &03: door
;;    &6c : &065b = &a5  &075a = &43  &09ec = &89  &0ab5 = &28  (&a5, &80) &03: door
;;    &6d : &065c = &9e  &075b = &43  &09ed = &a0  &0ab6 = &27  (&9e, &6b) &03: door
;;    &6e : &065d = &a2  &075c = &44  &09ee = &c1  &0ab7 = &31  (&a2, &c0) &04: stone door
;;    &6f : &065e = &d7  &075d = &84  &09ef = &f1  &0ab8 = &0e  (&d7, &c0) &04: stone door
;;    &70 : &065f = &e6  &075e = &44  &09f0 = &f1  &0ab9 = &08  (&e6, &bc) &04: stone door
;;    &71 : &0660 = &e7  &075f = &04  &09f1 = &c1  &0aba = &11  (&e7, &bc) &04: stone door
;;    &72 : &0661 = &94  &0760 = &01  &09f2 = &8c  &0abb = &39  (&94, &5c) &01: teleport beam
;;    &73 : &0662 = &7c  &0761 = &08  &09f3 = &a4  &0abc = &37  (&7c, &c0) &08: switch
;;    &74 : &0663 = &e3  &0762 = &08  &09f4 = &e4  &0abd = &37  (&e3, &9c) &08: switch
;;    &75 : &0664 = &45  &0763 = &02  &09f5 = &d7  &0abe = &37  (&45, &c0) &02: blue/cyan/green key
;;    &76 : &0665 = &9b  &0764 = &02  &09f6 = &9d  &0abf = &2a  (&9b, &66) &02: red robot
;;    &77 : &0666 = &9f  &0765 = &82  &09f7 = &e1  &0ac0 = &80  (&9f, &73) &02: whistle 1
;;    &78 : &0667 = &c2  &0766 = &1e  &09f8 = &a6  &0ac1 = &4a  (&c2, &7c) &1e: brick wall
;;    &79 : &0668 = &71  &0767 = &2d  &09f9 = &81  &0ac2 = &10  (&71, &88) &2d: stone wall
;;  4:&7a : &0669 = &67  &0768 = &46  &09f8 = &a6  &0ab1 = &20  (&67, &c8) &06: cyan/red turret
;;    &7b : &066a = &4f  &0769 = &46  &09f9 = &81  &0ab2 = &28  (&4f, &b8) &06: gargoyle
;;    &7c : &066b = &cf  &076a = &45  &09fa = &85  &0ab3 = &0d  (&cf, &b8) &05: deadly sucker
;;    &7d : &066c = &d2  &076b = &46  &09fb = &83  &0ab4 = &0d  (&d2, &9d) &06: deadly sucker
;;    &7e : &066d = &e2  &076c = &c6  &09fc = &83  &0ab5 = &28  (&e2, &b8) &06: gargoyle
;;    &7f : &066e = &7a  &076d = &89  &09fd = &d0  &0ab6 = &27  (&7a, &94) &09: maggot (x 20)
;;    &80 : &066f = &62  &076e = &c9  &09fe = &a8  &0ab7 = &31  (&62, &72) &09: invisible bird (x 10)
;;    &81 : &0670 = &da  &076f = &49  &09ff = &04  &0ab8 = &0e  (&da, &d8) &09: big fish
;;    &82 : &0671 = &76  &0770 = &89  &0a00 = &04  &0ab9 = &08  (&76, &94) &09: cyan frogman
;;    &83 : &0672 = &b2  &0771 = &ca  &0a01 = &d0  &0aba = &11  (&b2, &8d) &0a: wasp (x 20)
;;    &84 : &0673 = &66  &0772 = &ca  &0a02 = &88  &0abb = &39  (&66, &66) &0a: moving fireball (x 2)
;;    &85 : &0674 = &d7  &0773 = &8a  &0a03 = &04  &0abc = &37  (&d7, &6e) &0a: fireball
;;    &86 : &0675 = &83  &0774 = &8a  &0a04 = &04  &0abd = &37  (&83, &78) &0a: fireball
;;    &87 : &0676 = &84  &0775 = &8a  &0a05 = &04  &0abe = &37  (&84, &6c) &0a: fireball
;;    &88 : &0677 = &80  &0776 = &0a  &0a06 = &08  &0abf = &2a  (&80, &75) &0a: red/yellow imp (x 2)
;;    &89 : &0678 = &87  &0777 = &00  &0a07 = &bd  &0ac0 = &80  (&87, &77) &00: invisible switch
;;    &8a : &0679 = &9b  &0778 = &00  &0a08 = &8a  &0ac1 = &4a  (&9b, &3b) &00: invisible switch
;;    &8b : &067a = &50  &0779 = &c4  &0a09 = &f1  &0ac2 = &10  (&50, &60) &04: stone door
;;    &8c : &067b = &ae  &077a = &43  &0a0a = &d1  &0ac3 = &2f  (&ae, &62) &03: door
;;    &8d : &067c = &64  &077b = &04  &0a0b = &f1  &0ac4 = &30  (&64, &c8) &04: stone door
;;    &8e : &067d = &a3  &077c = &43  &0a0c = &b1  &0ac5 = &30  (&a3, &69) &03: door
;;    &8f : &067e = &63  &077d = &84  &0a0d = &f1  &0ac6 = &09  (&63, &cc) &04: stone door
;;    &90 : &067f = &b8  &077e = &44  &0a0e = &c1  &0ac7 = &0d  (&b8, &c5) &04: stone door
;;    &91 : &0680 = &7f  &077f = &04  &0a0f = &c1  &0ac8 = &09  (&7f, &94) &04: stone door
;;    &92 : &0681 = &82  &0780 = &44  &0a10 = &c1  &0ac9 = &09  (&82, &c3) &04: stone door
;;    &93 : &0682 = &e0  &0781 = &84  &0a11 = &c1  &0aca = &4f  (&e0, &b8) &04: stone door
;;    &94 : &0683 = &9c  &0782 = &41  &0a12 = &e2  &0acb = &24  (&9c, &66) &01: teleport beam
;;    &95 : &0684 = &61  &0783 = &01  &0a13 = &e4  &0acc = &4a  (&61, &d9) &01: teleport beam
;;    &96 : &0685 = &9d  &0784 = &01  &0a14 = &dc  &0acd = &04  (&9d, &58) &01: teleport beam
;;    &97 : &0686 = &29  &0785 = &01  &0a15 = &a0  &0ace = &1a  (&29, &c6) &01: teleport beam
;;    &98 : &0687 = &46  &0786 = &c8  &0a16 = &c2  &0acf = &39  (&46, &56) &08: switch
;;    &99 : &0688 = &9f  &0787 = &42  &0a17 = &cb  &0ad0 = &10  (&9f, &6b) &02: energy capsule
;;    &9a : &0689 = &9a  &0788 = &82  &0a18 = &b8  &0ad1 = &00  (&9a, &66) &02: inactive chatter
;;    &9b : &068a = &74  &0789 = &3b  &0a19 = &a8  &0ad2 = &4c  (&74, &94) &3b: brick wall, top quarter empty
;;    &9c : &068b = &75  &078a = &11  &0a1a = &10  &0ad3 = &0a  (&75, &94) &11: leaf
;;    &9d : &068c = &77  &078b = &3b  &0a1b = &98  &0ad4 = &2f  (&77, &94) &3b: brick wall, top quarter empty
;;  5:&9e : &068d = &b2  &078c = &89  &0a19 = &a8  &0ac2 = &10  (&b2, &c2) &09: pirahna (x 10)
;;    &9f : &068e = &e4  &078d = &c9  &0a1a = &10  &0ac3 = &2f  (&e4, &b4) &09: white/yellow bird (x 4)
;;    &a0 : &068f = &62  &078e = &ca  &0a1b = &98  &0ac4 = &30  (&62, &a2) &0a: red/magenta bird (x 6)
;;    &a1 : &0690 = &63  &078f = &8a  &0a1c = &a0  &0ac5 = &30  (&63, &b5) &0a: red/magenta bird (x 8)
;;    &a2 : &0691 = &82  &0790 = &c6  &0a1d = &80  &0ac6 = &09  (&82, &bf) &06: red slime
;;    &a3 : &0692 = &61  &0791 = &06  &0a1e = &83  &0ac7 = &0d  (&61, &c7) &06: deadly sucker
;;    &a4 : &0693 = &d4  &0792 = &c6  &0a1f = &80  &0ac8 = &09  (&d4, &bf) &06: red slime
;;    &a5 : &0694 = &d3  &0793 = &c6  &0a20 = &80  &0ac9 = &09  (&d3, &be) &06: red slime
;;    &a6 : &0695 = &77  &0794 = &06  &0a21 = &80  &0aca = &4f  (&77, &aa) &06: cannon control device
;;    &a7 : &0696 = &2e  &0795 = &06  &0a22 = &80  &0acb = &24  (&2e, &d6) &06: green clawed robot
;;    &a8 : &0697 = &64  &0796 = &85  &0a23 = &00  &0acc = &4a  (&64, &d6) &05: destinator
;;    &a9 : &0698 = &86  &0797 = &47  &0a24 = &c4  &0acd = &04  (&86, &56) &07: small nest
;;    &aa : &0699 = &a5  &0798 = &4a  &0a25 = &40  &0ace = &1a  (&a5, &e7) &0a: hover ball (x 16)
;;    &ab : &069a = &a0  &0799 = &ca  &0a26 = &84  &0acf = &39  (&a0, &bf) &0a: moving fireball
;;    &ac : &069b = &d1  &079a = &8a  &0a27 = &28  &0ad0 = &10  (&d1, &d3) &0a: pirahna (x 10)
;;    &ad : &069c = &b4  &079b = &00  &0a28 = &75  &0ad1 = &00  (&b4, &c2) &00: invisible switch
;;    &ae : &069d = &7f  &079c = &00  &0a29 = &bc  &0ad2 = &4c  (&7f, &77) &00: invisible switch
;;    &af : &069e = &a3  &079d = &44  &0a2a = &f1  &0ad3 = &0a  (&a3, &63) &04: stone door
;;    &b0 : &069f = &9f  &079e = &43  &0a2b = &d1  &0ad4 = &2f  (&9f, &71) &03: door
;;    &b1 : &06a0 = &99  &079f = &c3  &0a2c = &a9  &0ad5 = &29  (&99, &4c) &03: door
;;    &b2 : &06a1 = &80  &07a0 = &44  &0a2d = &f1  &0ad6 = &2c  (&80, &77) &04: stone door
;;    &b3 : &06a2 = &67  &07a1 = &44  &0a2e = &c0  &0ad7 = &37  (&67, &ce) &04: stone door
;;    &b4 : &06a3 = &da  &07a2 = &04  &0a2f = &c1  &0ad8 = &20  (&da, &6d) &04: stone door
;;    &b5 : &06a4 = &89  &07a3 = &41  &0a30 = &8f  &0ad9 = &3a  (&89, &71) &01: teleport beam
;;    &b6 : &06a5 = &95  &07a4 = &c8  &0a31 = &94  &0ada = &0d  (&95, &5d) &08: switch
;;    &b7 : &06a6 = &8b  &07a5 = &88  &0a32 = &c2  &0adb = &05  (&8b, &71) &08: switch
;;    &b8 : &06a7 = &ab  &07a6 = &c8  &0a33 = &ca  &0adc = &05  (&ab, &6b) &08: switch
;;    &b9 : &06a8 = &c4  &07a7 = &c8  &0a34 = &fa  &0add = &0d  (&c4, &c4) &08: switch
;;    &ba : &06a9 = &9d  &07a8 = &02  &0a35 = &9c  &0ade = &20  (&9d, &5d) &02: magenta robot
;;    &bb : &06aa = &aa  &07a9 = &8c  &0a36 = &fe  &0adf = &0d  (&aa, &61) &0c: engine thruster
;;  6:&bc : &06ab = &bb  &07aa = &49  &0a37 = &10  &0ad3 = &0a  (&bb, &c3) &09: green slime (x 4)
;;    &bd : &06ac = &47  &07ab = &89  &0a38 = &14  &0ad4 = &2f  (&47, &59) &09: white/yellow bird (x 5)
;;    &be : &06ad = &8a  &07ac = &0a  &0a39 = &90  &0ad5 = &29  (&8a, &78) &0a: red/magenta imp (x 4)
;;    &bf : &06ae = &a7  &07ad = &0a  &0a3a = &98  &0ad6 = &2c  (&a7, &9a) &0a: cyan/yellow imp (x 6)
;;    &c0 : &06af = &61  &07ae = &8a  &0a3b = &04  &0ad7 = &37  (&61, &d7) &0a: fireball
;;    &c1 : &06b0 = &9e  &07af = &c6  &0a3c = &a4  &0ad8 = &20  (&9e, &51) &06: cyan/red turret
;;    &c2 : &06b1 = &2e  &07b0 = &06  &0a3d = &80  &0ad9 = &3a  (&2e, &c8) &06: giant wall
;;    &c3 : &06b2 = &d6  &07b1 = &06  &0a3e = &83  &0ada = &0d  (&d6, &a1) &06: deadly sucker
;;    &c4 : &06b3 = &7e  &07b2 = &47  &0a3f = &c6  &0adb = &05  (&7e, &76) &07: big nest
;;    &c5 : &06b4 = &da  &07b3 = &87  &0a40 = &c4  &0adc = &05  (&da, &6e) &07: big nest
;;    &c6 : &06b5 = &aa  &07b4 = &cc  &0a41 = &fe  &0add = &0d  (&aa, &62) &0c: engine thruster
;;    &c7 : &06b6 = &ab  &07b5 = &41  &0a42 = &aa  &0ade = &20  (&ab, &69) &01: teleport beam
;;    &c8 : &06b7 = &45  &07b6 = &01  &0a43 = &90  &0adf = &0d  (&45, &57) &01: teleport beam
;;    &c9 : &06b8 = &67  &07b7 = &08  &0a44 = &ec  &0ae0 = &0d  (&67, &cb) &08: switch
;;    &ca : &06b9 = &d4  &07b8 = &08  &0a45 = &dc  &0ae1 = &48  (&d4, &6f) &08: switch
;;    &cb : &06ba = &29  &07b9 = &08  &0a46 = &9e  &0ae2 = &51  (&29, &c8) &08: switch
;;    &cc : &06bb = &b8  &07ba = &08  &0a47 = &f4  &0ae3 = &0c  (&b8, &c3) &08: switch
;;    &cd : &06bc = &6b  &07bb = &c4  &0a48 = &f7  &0ae4 = &55  (&6b, &e1) &04: stone door
;;    &ce : &06bd = &69  &07bc = &84  &0a49 = &f1  &0ae5 = &22  (&69, &de) &04: stone door
;;    &cf : &06be = &9d  &07bd = &43  &0a4a = &f1  &0ae6 = &04  (&9d, &56) &03: door
;;    &d0 : &06bf = &94  &07be = &43  &0a4b = &81  &0ae7 = &2e  (&94, &5f) &03: door
;;    &d1 : &06c0 = &63  &07bf = &84  &0a4c = &f1  &0ae8 = &2f  (&63, &ca) &04: stone door
;;    &d2 : &06c1 = &b4  &07c0 = &04  &0a4d = &f1  &0ae9 = &2b  (&b4, &c3) &04: stone door
;;    &d3 : &06c2 = &a1  &07c1 = &83  &0a4e = &b1  &0aea = &2a  (&a1, &6b) &03: door
;;    &d4 : &06c3 = &9f  &07c2 = &82  &0a4f = &db  &0aeb = &21  (&9f, &57) &02: icer
;;    &d5 : &06c4 = &a0  &07c3 = &82  &0a50 = &9e  &0aec = &02  (&a0, &6b) &02: blue robot
;;    &d6 : &06c5 = &57  &07c4 = &0d  &0a51 = &84  &0aed = &02  (&57, &69) &0d: water
;;    &d7 : &06c6 = &e1  &07c5 = &0d  &0a52 = &ac  &0aee = &1a  (&e1, &73) &0d: water
;;  7:&d8 : &06c7 = &7f  &07c6 = &46  &0a51 = &84  &0add = &0d  (&7f, &c1) &06: deadly sucker
;;    &d9 : &06c8 = &a6  &07c7 = &06  &0a52 = &ac  &0ade = &20  (&a6, &69) &06: cyan/red turret
;;    &da : &06c9 = &b4  &07c8 = &06  &0a53 = &80  &0adf = &0d  (&b4, &c5) &06: deadly sucker
;;    &db : &06ca = &53  &07c9 = &06  &0a54 = &80  &0ae0 = &0d  (&53, &95) &06: deadly sucker
;;    &dc : &06cb = &61  &07ca = &06  &0a55 = &80  &0ae1 = &48  (&61, &d8) &06: maggot machine
;;    &dd : &06cc = &d4  &07cb = &45  &0a56 = &80  &0ae2 = &51  (&d4, &73) &05: cyan/yellow/green key
;;    &de : &06cd = &82  &07cc = &45  &0a57 = &80  &0ae3 = &0c  (&82, &c5) &05: sucker
;;    &df : &06ce = &e3  &07cd = &45  &0a58 = &80  &0ae4 = &55  (&e3, &b5) &05: coronium boulder
;;    &e0 : &06cf = &75  &07ce = &06  &0a59 = &80  &0ae5 = &22  (&75, &87) &06: magenta clawed robot
;;    &e1 : &06d0 = &c3  &07cf = &07  &0a5a = &c0  &0ae6 = &04  (&c3, &c5) &07: small nest
;;    &e2 : &06d1 = &84  &07d0 = &89  &0a5b = &04  &0ae7 = &2e  (&84, &69) &09: green/yellow bird
;;    &e3 : &06d2 = &9e  &07d1 = &09  &0a5c = &08  &0ae8 = &2f  (&9e, &69) &09: white/yellow bird (x 2)
;;    &e4 : &06d3 = &c6  &07d2 = &8a  &0a5d = &90  &0ae9 = &2b  (&c6, &be) &0a: blue/cyan imp (x 4)
;;    &e5 : &06d4 = &64  &07d3 = &4a  &0a5e = &a2  &0aea = &2a  (&64, &c6) &0a: red/yellow imp (x 8)
;;    &e6 : &06d5 = &a2  &07d4 = &4a  &0a5f = &04  &0aeb = &21  (&a2, &5b) &0a: hovering robot
;;    &e7 : &06d6 = &28  &07d5 = &ca  &0a60 = &04  &0aec = &02  (&28, &d8) &0a: pericles crew member
;;    &e8 : &06d7 = &29  &07d6 = &ca  &0a61 = &04  &0aed = &02  (&29, &d8) &0a: pericles crew member
;;    &e9 : &06d8 = &9d  &07d7 = &4a  &0a62 = &20  &0aee = &1a  (&9d, &5b) &0a: hover ball (x 8)
;;    &ea : &06d9 = &83  &07d8 = &00  &0a63 = &bc  &0aef = &80  (&83, &76) &00: invisible switch
;;    &eb : &06da = &a8  &07d9 = &00  &0a64 = &53  &0af0 = &4b  (&a8, &69) &00: invisible switch
;;    &ec : &06db = &80  &07da = &00  &0a65 = &9d  &0af1 = &80  (&80, &c2) &00: invisible switch
;;    &ed : &06dc = &aa  &07db = &48  &0a66 = &84  &0af2 = &00  (&aa, &63) &08: switch
;;    &ee : &06dd = &d5  &07dc = &08  &0a67 = &da  &0af3 = &00  (&d5, &73) &08: switch
;;    &ef : &06de = &a0  &07dd = &82  &0a68 = &cb  &0af4 = &00  (&a0, &67) &02: energy capsule
;;    &f0 : &06df = &9f  &07de = &82  &0a69 = &de  &0af5 = &00  (&9f, &51) &02: protection suit
;;    &f1 : &06e0 = &d6  &07df = &82  &0a6a = &c5  &0af6 = &00  (&d6, &73) &02: rock
;;    &f2 : &06e1 = &62  &07e0 = &02  &0a6b = &a5  &0af7 = &00  (&62, &cc) &02: red clawed robot
;;    &f3 : &06e2 = &69  &07e1 = &c4  &0a6c = &c1  &0af8 = &00  (&69, &d1) &04: stone door
;;    &f4 : &06e3 = &2c  &07e2 = &c4  &0a6d = &f1  &0af9 = &00  (&2c, &d6) &04: stone door
;;    &f5 : &06e4 = &a5  &07e3 = &0b  &0a6e = &70  &0afa = &00  (&a5, &64) &0b: downdraught
;;  8:&f6 : &06e5 = &b8  &07e4 = &0b  &0a6f = &d0  &0af2 = &00  (&b8, &aa) &0b: updraught
;;    &f7 : &06e6 = &b9  &07e5 = &0b  &0a70 = &80  &0af3 = &00  (&b9, &de) &0b: updraught
;;    &f8 : &06e7 = &d9  &07e6 = &d1  &0a71 = &00  &0af4 = &00  (&d9, &57) &11: leaf
;;    &f9 : &06e8 = &59  &07e7 = &91  &0a72 = &00  &0af5 = &00  (&59, &8c) &11: leaf
;;    &fa : &06e9 = &79  &07e8 = &d1  &0a73 = &00  &0af6 = &00  (&79, &53) &11: leaf
;;    &fb : &06ea = &39  &07e9 = &d1  &0a74 = &00  &0af7 = &00  (&39, &80) &11: leaf
;;    &fc : &06eb = &48  &07ea = &91  &0a75 = &00  &0af8 = &00  (&48, &7d) &11: leaf
;;    &fd : &06ec = &e8  &07eb = &91  &0a76 = &00  &0af9 = &00  (&e8, &80) &11: leaf
;; 
;; ##############################################################################
.background_objects_data
;;  &80 set = not in current stack
    equb $00,$7C,$60,$04,$88,$88,$A0,$A6,$AE,$83,$86,$82,$80,$80,$AD,$81
    equb $F7,$A1,$F1,$F7,$81,$8A,$AC,$D2,$DF,$D4,$A3,$84,$85,$AE,$80,$80
    equb $88,$AC,$C4,$C0,$04,$A8,$C4,$BC,$FD,$81,$C1,$D1,$91,$F1,$F1,$DA
    equb $F7,$F3,$D8,$88,$80,$83,$83,$B0,$AA,$80,$80,$87,$80,$30,$08,$10
    equb $7C,$04,$10,$A8,$90,$04,$C1,$F1,$E1,$95,$BC,$B4,$FD,$A1,$D6,$DD
    equb $E2,$04,$0C,$04,$20,$21,$A0,$B0,$AC,$83,$81,$84,$80,$C4,$85,$95
    equb $A3,$B5,$F1,$AD,$C1,$81,$89,$A0,$C1,$F1,$F1,$C1,$8C,$A4,$E4,$D7
    equb $9D,$E1,$A6,$81,$85,$83,$83,$D0,$A8,$04,$04,$D0,$88,$04,$04,$04
    equb $08,$BD,$8A,$F1,$D1,$F1,$B1,$F1,$C1,$C1,$C1,$C1,$E2,$E4,$DC,$A0
    equb $C2,$CB,$B8,$A8,$10,$98,$A0,$80,$83,$80,$80,$80,$80,$00,$C4,$40
    equb $84,$28,$75,$BC,$F1,$D1,$A9,$F1,$C0,$C1,$8F,$94,$C2,$CA,$FA,$9C
    equb $FE,$10,$14,$90,$98,$04,$A4,$80,$83,$C6,$C4,$FE,$AA,$90,$EC,$DC
    equb $9E,$F4,$F7,$F1,$F1,$81,$F1,$F1,$B1,$DB,$9E,$84,$AC,$80,$80,$80
    equb $80,$80,$80,$80,$C0,$04,$08,$90,$A2,$04,$04,$04,$20,$BC,$53,$9D
    equb $84,$DA,$CB,$DE,$C5,$A5,$C1,$F1,$70,$D0,$80
.background_objects_type
    equb $00,$0F,$27,$2E,$07,$2F,$2D,$1F,$1F,$0D,$0D,$0D,$0C,$60,$2C,$00
    equb $0D,$0D,$1F,$0D,$5C,$0D,$20,$05,$04,$06,$31,$05,$2A,$09,$0D,$0D
    equb $1F,$20,$55,$55,$0D,$63,$0F,$2E,$0A,$1B,$37,$29,$1A,$1A,$37,$37
    equb $0A,$37,$4B,$4B,$2D,$1F,$20,$0D,$0D,$28,$55,$05,$80,$00,$80,$80
    equb $20,$28,$0D,$0D,$28,$27,$31,$0E,$08,$11,$39,$37,$37,$37,$2A,$80
    equb $4A,$10,$2F,$30,$30,$09,$0D,$09,$09,$4F,$24,$4A,$04,$1A,$39,$10
    equb $00,$4C,$0A,$2F,$29,$2C,$37,$20,$3A,$0D,$05,$05,$0D,$20,$0D,$0D
    equb $48,$51,$0C,$55,$22,$04,$2E,$2F,$2B,$2A,$21,$02,$02,$1A,$80,$4B
    equb $80

;; ##############################################################################
;; 
;;    Secondary object stack
;;    ======================
;;    (&9b, &39) &64 mysterious object 64
;;    (&a3, &5d) &43 chest
;;    (&98, &4d) &50 grenade
;;    (&98, &4d) &50 grenade
;;    (&a4, &67) &59 jetpack booster
;;    (&9f, &49) &50 grenade
;;    (&a0, &49) &46 cannon
;;    (&c0, &4e) &50 grenade
;;    (&48, &56) &50 grenade
;;    (&83, &78) &4e remote control device
;;    (&c5, &60) &45 rock
;;    (&87, &59) &53 green/yellow/red key
;;    (&97, &5e) &1d red robot
;;    (&e1, &61) &03 fluffy
;;    (&84, &5b) &50 grenade
;;    (&98, &80) &50 grenade
;;    (&99, &3c) &4a destinator
;;    (&e7, &80) &3a giant wall
;;    (&7c, &77) &4c empty flask
;;    (&00, &00) &00 (thirteen empty slots)
;; 
;; ##############################################################################
.secondary_object_stack_x
    equb $9B,$A3,$98,$98,$A4,$9F,$A0,$C0,$48,$83,$C5,$87,$97,$E1,$84,$98
    equb $99,$E7,$7C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.secondary_object_stack_y
    equb $39,$5D,$4D,$4D,$67,$49,$49,$4E,$56,$78,$60,$59,$5E,$61,$5B,$80
    equb $3C,$80,$77,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.secondary_object_stack_type
    equb $64,$43,$50,$50,$59,$50,$46,$50,$50,$4E,$45,$53,$1D,$03,$50,$50
    equb $4A,$3A,$4C,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.possible_checksum
    equb $DC
.secondary_object_stack_energy_and_low
    equb $F0,$F3,$71,$79,$FB,$42,$F5,$47,$F3,$F2,$F3,$F2,$F0,$FB,$F2,$40
IF NOVELLA_LOOKUP = TRUE
.l0b63
ENDIF
    equb $FB,$F0,$F1,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    
;;  variables used for secondary stack
.secondary_stack_object_number
    equb $00
.secondary_stack_random_1f
    equb $00
.maybe_another_checksum
    equb $43
.consider_secondary_stack_objects
    equb $00
.secondary_stack_player_odometer
    equb $00
.sprite_and
    equb $FF
.palette_value_to_pixel_lookup
equb $CA                        ; yellow bg, black bg
equb $C9                        ; green bg, red bg
equb $E3                        ; magenta bg, red bg
equb $E9                        ; cyan bg, red bg
equb $EB                        ; white bg, red bg
equb $CE                        ; yellow bg, green bg
equb $F8                        ; cyan bg, blue bg
equb $E6                        ; magenta bg, green bg
equb $CC                        ; green bg, green bg
equb $EE                        ; white bg, green bg
equb $30                        ; blue fg, blue fg
equb $DE                        ; yellow bg, cyan bg
equb $EF                        ; white bg, yellow bg
equb $CB                        ; yellow bg, red bg
equb $FB                        ; white bg, magenta bg
equb $FE                        ; white bg, cyan bg
        
.plot_sprite_screen_location_offsets_low
    equb $00
    equb $EA
    equb $00
    equb $EA
.plot_sprite_screen_location_offsets
    equb $00
    equb $EA
    equb $00
    equb $EA
.screen_offset_x_low
    equb $EA
.screen_offset_x_low_old
    equb $EA
.screen_offset_y_low
    equb $EA
.screen_offset_y_low_old
    equb $EA
.screen_offset_x
    equb $EA
.screen_offset_x_old
    equb $EA
.screen_offset_y
    equb $EA
.screen_offset_y_old
    equb $EA
.plot_sprite_screen_address_offsets_low
    equb $00
    equb $EA
    equb $00
    equb $EA
.plot_sprite_screen_address_offsets
    equb $08
    equb $EA
IF SRAM
    equb 8
ELSE
    equb $04
ENDIF
    equb $EA
.used_in_redraw_0ba1
    equb $F0
    equb $F0
    equb $F8
    equb $F8
.plot_sprite_when_to_flags_and
    equb $05
    equb $0A
IF NOVELLA_LOOKUP = TRUE
.l0ba7
ENDIF
    equb $00
IF NOVELLA_LOOKUP = TRUE
.l0ba8
ENDIF
    equb $00
first_bullet_type=$13
first_robot_type=$1c
first_clawed_robot_type=$22
first_bird_type=$2e
rcd_type=$4e

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  used for redraw objects
.set_object_velocities
LDA this_object_vel_x
STA object_stack_vel_x,Y
LDA this_object_vel_y
STA object_stack_vel_y,Y
RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.get_object_velocities
LDA object_stack_vel_x,Y
STA this_object_vel_x
LDA object_stack_vel_y,Y
STA this_object_vel_y
RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.has_object_been_fired
LDA current_object
CMP object_being_fired
RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.has_object_been_hit_by_rcd_beam
LDA #rcd_type
.has_object_been_hit_by_other
{
SEC
LDX object_being_fired
BMI L0BE7         ; if no control has been fired, leave with carry set
EOR object_stack_type,X
BNE L0BE7     ; if not the control we care about, leave with carry set
LDA #$18
JSR is_object_close_enough      ; is the object close enough?
BCS L0BE7                       ; if not, leave with carry set
JSR get_angle_between_objects   ; get angle
SBC firing_angle                ; minus firing_angle
SBC #$80                        ; minus 180 degrees
JSR make_positive
ADC distance_OR_wall_sprite_4   ; distance
CMP #$18                        ; clear if object has been hit
.L0BE7
RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; If the player has moved too far, or
;; consider_secondary_stack_objects is set look at all the objects in
;; the secondary stack, and push them into the primary stack if
;; they're near the screen. Otherwise, look at one object per cycle
;; and see if there's space for it on the primary stack - if so, push
;; it.
.consider_objects_on_secondary_stack
{
BIT consider_secondary_stack_objects
BMI push_near_objects_from_secondary_to_primary_stack
JSR get_biggest_velocity        ; for the player
LSR A
LSR A
ADC secondary_stack_player_odometer ; keep track of how far the player
                                    ; has moved
STA secondary_stack_player_odometer
BCS push_near_objects_from_secondary_to_primary_stack
DEC secondary_stack_object_number
BPL L0C0C
JSR increment_timers
AND #$1F
STA secondary_stack_random_1f
LDA #$1F
STA secondary_stack_object_number
.L0C0C
LDA secondary_stack_object_number
EOR secondary_stack_random_1f
TAX
LDY #$04                   ; only do this if there are four free slots
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.move_secondary_object_into_primary_stack
{
LDA secondary_object_stack_y,X ; look at random object on secondary
                               ; stack
BEQ L0C4D                      ; does it exist? if not, leave
LDA secondary_object_stack_type,X ; get type
JSR reserve_objects          ; find a slot to put it in, create object
BCS L0C4D                    ; if no free slot, leave
LDA secondary_object_stack_x,X
STA object_stack_x,Y           ; get x
LDA secondary_object_stack_y,X
STA object_stack_y,Y           ; get y
LDA secondary_object_stack_energy_and_low,X
PHA
ORA #$0F
STA object_stack_energy,Y       ; get top four bits of energy + &f
PLA
ASL A
ASL A
ASL A
ASL A
PHA
AND #$C0
STA object_stack_x_low,Y        ; get top two bits of x_low
PLA
ASL A
ASL A
STA object_stack_y_low,Y        ; get top two bits of y_low
LDA #$00
STA secondary_object_stack_y,X ; remove from secondary stack
.L0C4D
RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.push_near_objects_from_secondary_to_primary_stack
{
LDX #$1F                     ; start with last slot of secondary stack
.L0C50
LDA secondary_object_stack_y,X
STA this_object_y
LDA secondary_object_stack_x,X
STA this_object_x
LDY #$04 ; radius 4
STX zp_various_9e ; tmp_9e
JSR is_object_offscreen
LDX zp_various_9e ; tmp_9e
BCS L0C6A
LDY #$01                        ; if this object is near the screen
JSR move_secondary_object_into_primary_stack ; push it into the
                                             ; primary stack
.L0C6A
DEX
BPL L0C50               ; continue for the rest of the secondary stack
RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.copy_object_onto_secondary_stack
{
LDX #$1F                        ; 32 spaces on secondary stack
.L0C70
LDA secondary_object_stack_y,X ; find a free slot
BEQ secondary_stack_free_slot_found
DEX
BPL L0C70                       ; if no free slots are available
JMP flash_screen_background     ; flash the background to warn the
                                ; developer!
.secondary_stack_free_slot_found
LDA this_object_type
STA secondary_object_stack_type,X ; copy type
LDA this_object_x
STA secondary_object_stack_x,X ; copy x
LDA this_object_y
STA secondary_object_stack_y,X ; copy y
LDA this_object_x_low
ASL A
ROL A
ROL A
AND #$03
STA zp_various_9c               ; top two bits of x_low
LDA this_object_y_low
ASL A
ROL zp_various_9c
ASL A
ROL zp_various_9c               ; top two bits of y_low
LDA this_object_energy
AND #$F0
ORA zp_various_9c               ; top four bits of energy
STA secondary_object_stack_energy_and_low,X
RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.plot_object
{
LDA #%00111111                  ; objects are plotted and &3f
STA sprite_and
JSR plot_sprite
LDX current_object
LSR object_stack_flags,X
LDA skip_sprite_calculation_flags
AND #$05
CMP #$01
ROL object_stack_flags,X
LDA #%11111111
STA sprite_and          ; background is plotted and &ff
RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.teleport_player
{
    LDY object_held             ; are we holding something?
    BPL L0CEF                   ; if so leave - we can't teleport
    DEC teleports_used
    BPL L0CD1
    INC teleports_used
    LDY #$04
    BNE L0CD8
.L0CD1
    DEC teleport_last
    JSR fix_teleport_last
    TAY
.L0CD8
    LDA teleports_x,Y    ; get a position from the list of teleports
    STA this_object_tx   ; set the player's teleport position to match
    LDA teleports_y,Y
    STA this_object_ty
    JSR play_teleport_noise
    ;; Fall through to mark_this_object_as_teleporting
}
.mark_this_object_as_teleporting
{
.L0CE5
    LDA this_object_flags
    ORA #$10                    ; mark the player as teleporting
    STA this_object_flags
    LDA #$20
    STA this_object_timer       ; start the teleport timer
    ;; fall through to L0CEF
}
.L0CEF
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.mark_stack_object_as_teleporting
{
    LDA object_stack_flags,Y
    ORA #$10 ; mark as teleporting
    STA object_stack_flags,Y
    LDA #$20
    STA object_stack_timer,Y    ; start the teleport timer
    RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  If the object is teleporting, randomise its sprite accordingly
.plot_sprite_resize_if_teleporting
{
    LDA this_object_flags-2,X ; # X = 3, &70 this_object_flags_old; X
                              ; = 2, &6f this_object_flags 
    AND #$10                  ; is the object teleporting?
    BEQ L0D4A                 ; if not, skip to plot_sprite_continued
.L0D04
    TXA
    AND #$01
    TAY
    LDA this_object_timer,Y ; Y = 1, &13 this_object_timer_old; Y = 0,
                            ; &12 this_object_timer
    CPX #$02
    BCS L0D15
    STA zp_various_9c
    LSR A
    LSR A
    ADC zp_various_9c ; alter this_object_timer, not
                      ; this_object_timer_old
.L0D15
    AND #$07
    TAY
    LDA this_sprite_height-2,X ; # X = 3, &4e this_sprite_height_old ;
                               ; X = 2, &4d this_sprite_height
                               
.L0D1A
    LSR A
    DEY
    BPL L0D1A
    ROL A
    STA zp_various_9c
    LDA this_sprite_height-2,X ; # X = 3, &4e this_sprite_height_old ;
                               ; X = 2, &4d this_sprite_height
                               
    SEC
    SBC zp_various_9c
    LSR A
    AND used_in_redraw_0ba1,X ; X = 3, &0ba4 (&f8), X = 2 &0ba3 (&f8)
                              
    PHA
    CLC ; alter the sprite position and the height of the sprite based
        ; on the timer
    ADC this_sprite_b-2,X ; X = 3, &62 this_sprite_b_old ; X = 2, &61
                          ; this_sprite_b 
    ADC #$00
    STA this_sprite_b-2,X ; # X = 3, &62 this_sprite_b_old ; X = 2,
                          ; &61 this_sprite_b 
    PLA
    ADC this_object_y_low-2,X  ; X = 3, &52 this_object_y_low_old; X =
                               ; 2, &51 this_object_y_low 
    STA this_object_y_low-2,X ; # X = 3, &52 this_object_y_low_old; X
                              ; = 2, &51 this_object_y_low 
    BCC L0D3B
    INC this_object_y-2,X ; # X = 3, &56 this_object_y_old; X = 2, &55
                          ; this_object_y 
.L0D3B
    LDA zp_various_9c
    AND used_in_redraw_0ba1,X ; X = 3, &0ba4 (&f8), X = 2 &0ba3 (&f8)
                              
    STA this_sprite_height-2,X ; # X = 3, &4e this_sprite_height_old ;
                               ; X = 2, &4d this_sprite_height
                               
    DEX
    DEX
    BPL L0D04                   ; now do it again for x direction
    INX
    INX
    INX
    INX
.L0D4A
    JMP plot_sprite_continued
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.plot_sprite
    LDX #$03             ; first X = 3, previous ; then X = 2, current
    ASL skip_sprite_calculation_flags
;; Calculate various variables for the sprite, both for its previous
;; and current location. We determine the screen address at which to
;; plot, and whether the sprite crosses the edge of the screen - if
;; so, we alter its size accordingly.
.plot_sprite_calculation_loop
    BCS plot_sprite_skip_calculations
    CPX #$02                    
    BCC plot_sprite_continued   ; taken if X<2 (and therefore done)
    LDY this_object_sprite-2,X  ; this_object_sprite/this_object_sprite_old
    LDA sprite_height_lookup,Y  ; C=?? A=h7 h6 h5 h4 h3 h2 h1 h0
    LSR A                       ; C=h0 A=00 h7 h6 h5 h4 h3 h2 h1
    LDA sprite_width_lookup,Y   ; C=h0 A=w7 w6 w5 w4 w3 w2 w1 w0
    ROR A                       ; C=w0 A=h0 w7 w6 w5 w4 w3 w2 w1
    AND #$80                    ; C=w0 A=h0 00 00 00 00 00 00 00
    ROR A                       ; C=00 A=w0 h0 00 00 00 00 00 00
    EOR this_object_flipping_flags-2,X ; swap based on object flip
                                       ; flags? (So sprite can be
                                       ; flipped as part of its
                                       ; definition??)
    STA this_sprite_flipping_flags-2,X ; save for the sprite
    ASL A                        ; C = X flip flag?
    STA this_sprite_partflip-2,X ; # X = 3, &66
                                 ; this_sprite_vertflip_old ; X = 2,
                                 ; &65 this_sprite_partflip
    LDA sprite_width_lookup,Y    
    AND #%11110000            ; mask off actual width??
    STA this_sprite_width-2,X ; # X = 3, &4c this_sprite_width_old ; X
                              ; = 2, &4b this_sprite_width
    LDA sprite_height_lookup,Y
    AND #%11111000             ; mask off actual height?
    STA this_sprite_height-2,X ; # X = 3, &4e this_sprite_height_old ;
                               ; X =2, &4d this_sprite_height
    LDA sprite_offset_a_lookup,Y
    STA this_sprite_a-2,X ; # X = 3, &60 this_sprite_a_old; X = 2, &5f
                          ; this_sprite_a 
    LDA sprite_offset_b_lookup,Y
    STA this_sprite_b-2,X ; # X = 3, &62 this_sprite_b_old ; X = 2,
                          ; &61 this_sprite_b 
    JMP plot_sprite_resize_if_teleporting
    ; plot_sprite_resize_if_teleporting comes straight back here
.plot_sprite_continued
    LDA this_object_y_low-2,X ; # X = 3, &52 this_object_y_low_old; X
                              ; = 2, &51 this_object_y_low 
    AND used_in_redraw_0ba1,X ; always mask with $f8? - extract
                              ; character row index
    SEC
    SBC screen_offset_y_low-2,X ; X = 3, &0b94
                                ; screen_offset_y_low_old, X = 2,
                                ; &0b93 screen_offset_y_low
    STA this_object_screen_y_low-2,X ; X = 3, &5a
                                     ; this_object_screen_y_low_old ;
                                     ; X = 2 &59
                                     ; this_object_screen_y_low
    LDA this_object_y-2,X ; # X = 3, &56 this_object_y_old; X = 2, &55
                          ; this_object_y 
    SBC screen_offset_y-2,X ; X = 3, &0b98 screen_offset_y_old; X = 2,
                            ; &0b97 screen_offset_y 
    STA this_object_screen_y-2,X ; X = 3, &5e this_object_screen_y_old
                                 ; ; X = 2, &5d this_object_screen_y
    LDA this_object_screen_y_low-2,X ; X = 3, &5a
                                     ; this_object_screen_y_low_old ;
                                     ; X = 2 &59
                                     ; this_object_screen_y_low
    CLC
    ADC this_sprite_height-2,X ; X = 3, &4e this_sprite_height_old ; X
                               ; = 2, &4d this_sprite_height
    STA screen_address
    LDA this_object_screen_y-2,X ; X = 3, &5e this_object_screen_y_old
                                 ; ; X = 2, &5d this_object_screen_y
    ADC #$00
    STA screen_address+1
    BMI L0E06
    BCS L0DF0
    LDA screen_address
    SEC
    SBC plot_sprite_screen_address_offsets_low,X
    STA screen_address
    LDA screen_address+1
    SBC plot_sprite_screen_address_offsets,X
    STA screen_address+1
    BEQ L0DD3
    BPL plot_sprite_skip_calculations
.L0DBC
    LDA this_object_screen_y_low-2,X ; X = 3, &5a
                                     ; this_object_screen_y_low_old ;
                                     ; X = 2 &59
                                     ; this_object_screen_y_low
.L0DBE
    CLC
    ADC plot_sprite_screen_location_offsets_low,X
    STA this_object_screen_y_low-2,X ; X = 3, &5a
                                     ; this_object_screen_y_low_old ;
                                     ; X = 2 &59
                                     ; this_object_screen_y_low
    LDA this_object_screen_y-2,X ; X = 3, &5e this_object_screen_y_old
                                 ; ; X = 2, &5d this_object_screen_y
    ADC plot_sprite_screen_location_offsets,X
    STA this_object_screen_y-2,X ; X = 3, &5e this_object_screen_y_old
                                 ; ; X = 2, &5d this_object_screen_y
.plot_sprite_skip_calculations
    ROL skip_sprite_calculation_flags
    DEX ; do it again for X =2
    BMI plot_sprite_after_calculations
    JMP plot_sprite_calculation_loop
.L0DD3
    LDA screen_address
    SBC this_sprite_height-2,X ; X = 3, &4e this_sprite_height_old ; X
                               ; = 2, &4d this_sprite_height
    BCS plot_sprite_skip_calculations
    EOR used_in_redraw_0ba1,X ; # X = 3, &0ba4 (&f8), X = 2 &0ba3
                              ; (&f8) 
    STA this_sprite_height-2,X ; X = 3, &4e this_sprite_height_old ; X
                               ; = 2, &4d this_sprite_height
    LDA this_sprite_partflip-2,X ; X = 3, &66 this_sprite_vertflip_old
                                 ; ; X = 2, &65 this_sprite_partflip
    BPL L0DBC
    LDA screen_address
    SEC
    SBC used_in_redraw_0ba1,X ; # X = 3, &0ba4 (&f8), X = 2 &0ba3
                              ; (&f8) 
    ADC this_sprite_b-2,X ; X = 3, &62 this_sprite_b_old ; X = 2, &61
                          ; this_sprite_b 
    ADC #$00
    STA this_sprite_b-2,X ; # X = 3, &62 this_sprite_b_old ; X = 2,
                          ; &61 this_sprite_b 
    BCC L0DBC
.L0DF0
    LDA screen_address
    STA this_sprite_height-2,X ; # X = 3, &4e this_sprite_height_old ;
                               ; X = 2, &4d this_sprite_height
    LDA this_sprite_partflip-2,X ; X = 3, &66 this_sprite_vertflip_old
                                 ; ; X = 2, &65 this_sprite_partflip
    BMI L0E00
    LDA this_sprite_b-2,X ; # X = 3, &62 this_sprite_b_old ; X = 2,
                          ; &61 this_sprite_b 
    SBC this_object_screen_y_low-2,X ; X = 3, &5a
                                     ; this_object_screen_y_low_old ;
                                     ; X = 2 &59
                                     ; this_object_screen_y_low
    ADC #$00
    STA this_sprite_b-2,X ; # X = 3, &62 this_sprite_b_old ; X = 2,
                          ; &61 this_sprite_b 
.L0E00
    LDA #$00
    STA this_object_screen_y-2,X ; X = 3, &5e this_object_screen_y_old
                                 ; ; X = 2, &5d this_object_screen_y
    BEQ L0DBE
.L0E06
    SEC
    BCS plot_sprite_skip_calculations
.plot_sprite_after_calculations
    LDA skip_sprite_calculation_flags
    AND #$0F
    BEQ consider_whether_object_has_changed
    AND #$05
    BEQ object_needs_redrawing
    LDA skip_sprite_calculation_flags
    AND #$0A
    BEQ object_needs_redrawing
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.consider_whether_object_has_changed
    LDA this_object_y_low
    EOR this_object_y_low_old   ; y_low ?
    AND #$F8                    ; 3 fractional bits?
    BNE object_needs_redrawing
    LDA this_object_x_low
    EOR this_object_x_low_old   ; x_low ?
    AND #$F0                    ; 4 fractional bits?
    BNE object_needs_redrawing
    LDA this_object_y
    EOR this_object_y_old       ; y ?
    BNE object_needs_redrawing
    LDA this_object_x
    EOR this_object_x_old       ; x ?
    BNE object_needs_redrawing
    LDA this_object_sprite
    EOR this_object_sprite_old  ; sprite ?
    BNE object_needs_redrawing
    LDA this_object_palette
    EOR this_object_palette_old ; palette ?
    BNE object_needs_redrawing
    LDA this_object_flipping_flags
    EOR this_object_flipping_flags_old ; flipping ?
    BNE object_needs_redrawing
    LDA this_object_flags
    ORA this_object_flags_old
    AND #$10
    BNE object_needs_redrawing  ; if either is teleporting?
    LDA this_sprite_width_old   ; sprite width?
    CMP this_sprite_width
    BCS redraw_object_resized_sprite
    LDA this_sprite_flipping_flags ; this_sprite_b
    EOR scroll_square_x_velocity_high
    BMI L0E66
    LDA this_sprite_a
    ADC this_sprite_width_old
    ADC #$10
    ADC #$00
    STA this_sprite_a
.L0E66
    LDA this_sprite_width
    SEC
    SBC this_sprite_width_old
    SBC #$10
    STA this_sprite_width
    LDA scroll_square_x_velocity_high
    BMI L0EB6
    LDA this_sprite_width_old
    CLC
    ADC #$10
    ADC this_object_screen_x_low
    STA this_object_screen_x_low
    BCC L0EB6
    INC this_object_screen_x
    JMP L0EB6
.object_needs_redrawing
    JMP object_needs_redrawing_in
.redraw_object_resized_sprite

; is the new sprite taller than the old one?

    LDA this_sprite_height_old  ; old height
    CMP this_sprite_height      ; new height
    BCS L0ECB                   ; taken if old height < new height
    LDA this_sprite_partflip    ; this_sprite_vertflip_old
    EOR scroll_square_y_velocity_high
    BMI L0E9C
    LDA this_sprite_b           
    ADC this_sprite_height_old
    ADC #$08
    ADC #$00
    STA this_sprite_b           
.L0E9C
    LDA this_sprite_height
    SEC
    SBC this_sprite_height_old
    SBC #$08
    STA this_sprite_height
    LDA scroll_square_y_velocity_high
    BMI L0EB6
    LDA this_sprite_height_old
    CLC
    ADC #$08
    ADC this_object_screen_y_low
    STA this_object_screen_y_low
    BCC L0EB6
    INC this_object_screen_y
.L0EB6
    LDA #$0A
    STA skip_sprite_calculation_flags
.object_needs_redrawing_in
    LDA #$02
    STA plotter_x
    LDA #$00
    STA $00
    PHA
    TSX
    STX copy_of_stack_pointer_6a
.object_redrawing_loop
    DEC plotter_x
    BPL do_the_plotting
    PLA
.L0ECB
    RTS
    
;;  Plot an object or the background
.do_the_plotting

    LDX plotter_x     ; first X = 1, previous ; then X = 0, current
    LDA skip_sprite_calculation_flags
    AND plot_sprite_when_to_flags_and,X ; should we actually plot it?
    BNE object_redrawing_loop           ; if not, continue
    LDA this_sprite_a,X                 ; this_sprite_a(_old)

; A = abcdefgh
;
; Byte offset = fghab (32 bytes per line)
; Pixel offset = cd (4 pixels/byte)

    ASL A                       ; a bcdefgh0 
    ADC #$00                    ; 0 bcdefgha
    ASL A                       ; b cdefgha0
    ADC #$00                    ; 0 cdefghab
    AND #$1F                    ; 0 000fghab
    STA sprite_row_byte_offset  ; byte offset into row
    
;;  Use the palette value to set up zero page &00 &01 &10 &11 &02 &20
;;  &22 with pixel values representing the four colours in the palette

; Each sprite is 2bpp. Each sprite pixel is an index into this
; per-sprite palette:
;
; 0 = background
; 1 = pair right
; 2 = pair left
; 3 = primary
;
; The background is fixed - it's always colour 0.
;
; The primary colour is chosen directly - it's the top four bits of
; the sprite's palette.
;
; The pair colours come from the `palette_value_to_pixel_lookup'
; table, indexed by the bottom four bits of the sprite's palette. Each
; entry is a Mode 2 pixel value; its left pixel is the colour of index
; 2, and its right pixel is the colour of index 1.
;
; Each sprite data byte is ABCDabcd (4 pixels: Aa Bb Cc Dd). Aa and Bb
; are masked out, leaving 00CD00cd. Then each of Cc and Dd are
; processed separately.
;
; So, for Cc (left)       And for Dd (right):
;                                  
; | C | c | Idx | Val |   | D | d | Idx | Val |
; |---+---+-----+-----|   |---+---+-----+-----|
; | 0 | 0 |  0  | $00 |   | 0 | 0 |  0  | $00 |
; | 0 | 1 |  1  | $01 |   | 0 | 1 |  1  | $02 |
; | 1 | 0 |  2  | $10 |   | 1 | 0 |  2  | $20 |
; | 1 | 1 |  3  | $11 |   | 1 | 1 |  3  | $22 |
;
; So once the data has been masked out, the `Val' values are in hand.
; They are used directly as ZP addresses to look up Mode 2 pixel
; values as follows. L is the index (see above) for the left pixel,
; and R the same for the right.
;
; | Val | L | R |
; |-----+---+---|
; | $00 | 0 | 0 |
; | $01 | 1 | 0 |
; | $10 | 2 | 0 |
; | $11 | 3 | 0 |
; | $02 | 0 | 1 |
; | $20 | 0 | 2 |
; | $22 | 0 | 3 |
;
; Then add some masking and stuff...

    LDA this_object_palette,X   ; this_object_palette(_old)
    LSR A                     
    LSR A
    LSR A
    LSR A
    TAY                         ; Y = primary colour 

    LDA pixel_table,Y           ; map primary colour (0-15) to Mode 2
                                ; pixel value with that colour in both
                                ; pixels
    AND #$55                    
    STA $11                     ; &11 - primary colour right pixel
    ASL A                       
    STA $22                     ; &22 - primary colour left pixel
    
    LDA this_object_palette,X   ; this_object_palette(_old)
    AND #$0F                    ; Y = (palette>>0)&15 - pair index
    TAY
    LDA palette_value_to_pixel_lookup,Y ; get pair
    AND sprite_and              ; 00111111 or 11111111
    TAY                         
    AND #$55                    ; get right pixel
    STA $01                     ; right 1
    ASL A
    STA $02                     ; left 1
    TYA
    AND #$AA                    ; get left pixel
    STA $20                     ; left 2
    LSR A
    STA $10                     ; right 2

    LDA this_sprite_flipping_flags,X ; this_sprite_flipping_flags(_old)
    STA this_sprite_partflip         ; plot_flipping_flags - bit 7=X
                                     ; flip, bit 6=Y flip
    LSR A                            ; 0XY.....
    LSR A                            ; 00XY....
    LSR A                            ; 000XY...

; Initially, pixels need swapping if the object is X-flipped.

; If it's X-flipped, swap only if the width is odd - the effective
; start coordinate will then be the opposite parity from the screen X
; coordinate.

    AND this_sprite_width,X     ; this_sprite_width(_old)

; If screen X coordinate is odd, invert the flag.

    EOR this_object_screen_x_low,X ; this_object_screen_x_low(_old)

; I'm prepared to believe that this is correct ;)

    EOR this_sprite_a,X         ; this_sprite_a(_old)

    AND #$10                    ; combination of all of the above
    BEQ dont_swap               ; branch taken if pixel values are OK

    ; Swap. $00 is shared; there's only 3 pairs.
    
    LDA $02:LDY $01:STA $01:STY $02
    LDA $20:LDY $10:STA $10:STY $20
    LDA $22:LDY $11:STA $11:STY $22
    
.dont_swap

;;  Calculate the offset between rows in the sprite

    LDA #$20:LDY #$00           ; $0020 - +32
    BIT this_sprite_partflip    ; test .Y......
    BVS L0F41                   ; taken if Y set
    LDA #$E0:DEY                ; $ffe0 - -32
.L0F41

    STA L107C+1                 ; fix up ADC# for LSB
    STY L1084+1                 ; fix up ADC# for MSB
    
;;  Calculate the sprite address

; Put starting Y coord in A - either the sprite height, or 0,
; depending on whether it's flipped.

    LDA this_sprite_height,X    ; this_sprite_height(_old)
    BVC L0F4D                   ; taken if Y was clear above
    LDA #$00                    ; 
.L0F4D
    CLC                 ; 
    ADC this_sprite_b,X ; add sprite data Y coordinate
    ADC #$00            ; add carry - note that there will only be
                        ; carry when starting from this_sprite_height
                        ; (rather than $00), in which case the bottom
                        ; 3 bits will be clear (see
                        ; plot_sprite_calculation_loop)
    ASL A               ; |
    ADC #$00            ; | yyYYY0xx -> yYYY0xxy
    ASL A               ; |
    ADC #$00            ; | yYYY0xxy -> YYY0xxyy
    STA zp_various_9d   ; 

    AND #%11100000      ; | YYY0000 (LSB of y*32)
    ORA sprite_row_byte_offset
    ADC #LO(sprite_data)        ; get LSB of sprite address
    STA line_loop+1             ; sprite_address
    LDA zp_various_9d           ; YYY0xxyy
    AND #%00001111              ; 0000xxyy (MSB of y*32)
    ADC #HI(sprite_data)        ; 
    STA line_loop+2             ; self modifying code
    
;;  Calculate the number of bytes in a line of the sprite

    LDA this_object_screen_x_low,X ; this_object_screen_x_low(_old)
    AND #$10                       ; LSb
    ADC this_sprite_width,X        ; this_sprite_width(_old)
    STA velocity_signs_OR_pixel_colour
    ROR A                       
    AND #$F0                    
    LSR A                       ; width*8?
    STA zp_various_a0
    LDA this_sprite_a,X      ; this_sprite_a(_old)
    AND #$30                 ; sprite data pixel X coordinate bits 0/1
    ADC this_sprite_width,X  ; this_sprite_width(_old) - get inclusive
                             ; width including an extra pixel if
                             ; starting on an odd X coordinate
    ROR A                    ; wwwww000
    LSR A                    ; 0wwwww00
    LSR A                    ; 00wwwww0
    LSR A                    ; 000wwwww
    TAY                      ; 
    LSR A                    ; /2
    LSR A                    ; /4 (since 4 pixel/byte)
    STA bytes_per_line_in_sprite ; 
    
;;  Calculate the number of bytes in a line on the screen. The sprite data is
;;  unpacked into the stack - we also calculate where to put it.

    LDA this_sprite_width,X     ; this_sprite_width(_old)
    LSR A                       ; 
    LSR A                       ; 
    LSR A                       ; 
    LSR A                       ; remove the fractional bits
    STA zp_various_9d           ; sprite width in pixels
    TYA                         ; 
    AND #$03                    ; remainder due to 4 pixels/byte
    CLC                         ; 
    ADC copy_of_stack_pointer_6a ; 
    SBC #$01
    STA L1051+1 ; self modifying code
    TAX
    INX
    SBC zp_various_9d
    SBC #$02
    STA L1054+1 ; self modifying code
    LDY #$CA    ; &ca = DEX (right facing)
    BIT this_sprite_partflip    ; plot_flipping_flags
    BPL L0FAF                   ; 
    TAX
    DEX
    LDY #$E8                    ; &e8 = INX (left facing)
.L0FAF
    LDA velocity_signs_OR_pixel_colour
    AND #$10
    BEQ L0FB9
    STY L0FB8 ; self modifying code
.L0FB8 INX    ; either INX or DEX from &0fb5
.L0FB9
    STX bytes_per_line_on_screen ; 
    STY L105C                    ; self modifying code
    STY L1060                    ; self modifying code
;;  Calculate the number of lines in the sprite
    LDX plotter_x
    LDA this_sprite_height,X    ; this_sprite_height(_old)
    LSR A                       ; 
    LSR A                       ; 
    LSR A                       ; remove the fractional bits
    STA lines_in_sprite
    
;; Calculate the screen address of the sprite.
;;
;; 3 fractional bits for Y.

    LDA this_object_screen_y_low,X ; this_object_screen_y_low(_old)
    CLC                            ; LSB of Y*8
    ADC this_sprite_height,X       ; this_sprite_height(_old)
    STA screen_address             ; LSB address
    
    LDA this_object_screen_y,X  ; this_object_screen_y(_old)
    ADC #$00                    ; MSB of Y*8
    STA screen_address+1        ; MSB address
    
    JSR scroll_screen           ; 

; Currently have (Y+sprite_height)*8 in screen_address

    LDA screen_address          
    LSR screen_address+1:ROR A  ; (Y+sprite_height)*4
    LSR screen_address+1:ROR A  ; (Y+sprite_height)*2
    LSR screen_address+1:ROR A  ; Y+sprite_height
    TAY                         ; save LSB (for row)
    AND #$07                    ; get scanline, 0-7, in character row
    ORA zp_various_a0           ; width*8
    STA sprite_dest_offset      ; use that as the offset
    ORA #$07                    ; get equivalent for scanline 7 in the
                                ; row
    STA sprite_initial_dest_offset ; that's the initial value for dest
                                   ; offset after moving to previous
                                   ; row
    LDA this_object_screen_x_low,X ; this_object_screen_x_low(_old)
    AND #$E0                       ; %11100000
    ADC screen_start_square_x_low_copy ;
    STA screen_address                 ; 
    TYA                                ; get LSB (for row) back again
    AND #$F8                           ; get just the character row part
    EOR this_object_screen_x,X         ; this_object_screen_x(_old) -
                                       ; ??guess this must just be
                                       ; 1-3 bits??
    ADC some_screen_address_offset     ; ??add scrolling offset MSB,
                                       ; pre-scaled??

;; Ignoring the X coordinate's contribution, the accumulator value is
;; a row-aligned scanline coordinate: 0, 8, 16, 24, etc. Each
;; character rows is 512 ($200) bytes, so divide this value by 4 to
;; get the MSB of the base address for that character row.
;;
;; ??figure out the X values... they must be scaled already to make
;; this work??

    ROR A:ROR screen_address           ; /2
    LSR A:ROR screen_address           ; /4
    ORA #screen_base_page              ; make a screen address
    STA screen_address+1               ; save it
.plot_lines_loop
    CMP #$7F                    ; check MSB
    BNE plot_sprite_line        ; taken if no risk of overflow out of
                                ; RAM area

;; MSB is $7f, so the line being written could run over $8000.

    LDA screen_address          
    CLC
    ADC sprite_dest_offset      ; get LSB of end point
    BCC plot_sprite_line        ; taken if line won't run over $8000

;; the line being written will run over $8000, so there'll need to be
;; extra code to handle this.

    STA something_plot_var      ; LSB of end point

;; the BVC is a JMP, I think... the sprites are never wide enough to
;; cause a problem.

    LDA #$50:STA L1070               ; set L1070 to BVC
    LDA #L109C-(L1070+2):STA L1070+1 ; set L1070 to BVC L109C

.plot_sprite_line
    LDY bytes_per_line_in_sprite
;;  For each byte in the sprite data, unpack it onto the stack.
.line_loop
;; $ffff is actually sprite address, as modified by various places
;; above.
    LDA $FFFF,Y                 ; ABCDabcd
    TAX                         ; ABCDabcd ABCDabcd
    AND #$11                    ; 000D000d ABCDabcd
    STA L102B+1                 
.L102B LDA $FF                  ; 0D0D0D0D [mode 2]
    PHA                         ; push on to stack
    TXA                         ; ABCDabcd
    AND #$22                    ; 00C000c0
    STA L1034+1                 
.L1034 LDA $FF                  ; C0C0C0C0 [mode 2]
    PHA                         ; push on to stack
    TXA                         ; ABCDabcd
    LSR A                       ; 0ABCDabc
    LSR A                       ; 00ABCDab
    TAX                         ; 
    AND #$11                    ; 000B000b
    STA L1040+1
.L1040 LDA $FF                  ; 0B0B0B0B [mode 2]
    PHA                         ; push on to stack
    TXA                         ; 00ABCDab
    AND #$22                    ; 00A000a0
    STA L1049+1 
.L1049 LDA $FF                  ; A0A0A0A0 [mode 2]
    PHA                         ; push on to stack
    DEY                         ;
    BPL line_loop               ; loop for all input bytes 
    PHA                         ; erm...?
    INY                         ; Y=0
.L1051 STY $01ff                        ; actually &01XX from &0f99
.L1054 STY $01ff                        ; actually &01XX from &0fa2
    SEC
    LDY sprite_dest_offset
.L105A
    LDX bytes_per_line_on_screen
;;  Now take that data from the stack and plot it to the screen - if
;;  the plotting mode is set to overwrite, just plot it, otherwise
;;  consider what is there already - if it's background data (&80 is
;;  set), don't.
.plot_screen_loop
.L105C DEX                     ; actually either DEX or INX from &0fbb
    LDA $100,X                 ; get left/right pixel from stack
.L1060 DEX                     ; actually either DEX or INX from &0fbe
    ORA $100,X                 ; mask in other pixel from stack

;; This snippet is either EOR/BMI or BMI/EOR. `change_display_mode'
;; toggles between them.
;;
;; When EOR/BMI, the write will be skipped if this would replace
;; background on screen with sprite begin drawn.
;;
;; When BMI/EOR, this is background, and write will replace whatever's
;; on screen (though this isn't quite a perfect check as the N flag
;; only covers the left pixel - and you can sometimes tell).

.L1064 EOR (screen_address),Y   ; read the current screen data
.L1066 BMI L106A ; actually either "EOR, BMI &106a" or "BMI &1068, EOR" from &10f0
.L1068:
    STA (screen_address),Y ; plot the sprite to screen depending on plotting mode
.L106A
    TYA                         ; offset in character row
    SBC #$08                    ; next column
    TAY                         ; 
    BCS plot_screen_loop        ; taken if offset>=0

.L1070 LDX copy_of_stack_pointer_6a ; actually either "LDX &6a" or "BVC L109C" from &10c5, &10c5 or &1016, &101b
.L1072
    TXS                         ; reset stack pointer
    DEC lines_in_sprite
    BMI plotting_done           ; any more lines to do? if not, leave
    DEC find_carry              ; next screen line next time
    
;; adjust sprite data address in initial LDA in sprite loop

    LDA line_loop+1
.L107C ADC #$20 ; actually ADC #sprite_byte_offset_between_rows from &0f41
    STA line_loop+1
    
    LDA line_loop+2
.L1084 ADC #$00 ; actually ADC #sprite_byte_offset_between_rows_h from &0f44
    STA line_loop+2
    
;; if in line 7 of character row, when the BCS at L1070-2 falls
;; through, Y=$ff; line 6, $fe ... line 0, $f8. So if Y<$f9, Y=$f8,
;; meaning that was line 0 of the character row, so it's time to
;; advance to the previous character row.

    CPY #$F9
    BCS plot_sprite_line
    LDA zp_various_a0
    STA find_carry
    ; there are $200 bytes per line...
    LDA screen_address+1 
    SBC #$01                    ; actually SBC #2 - the BCS fell
                                ; through, so carry is clear
    ORA #screen_base_page       
    STA screen_address+1
    JMP plot_lines_loop         ; do it all again for the next line

.L109C

;; this handles the case where the line straddles $8000. This case is
;; handled in two passes: pass 1, just let the data get written to
;; $8000+. Pass 2, redraw the bogus part of the line at the low
;; address. Then after pass 2 put everything back as it was and carry
;; on.

;; Could be either pass...

    LDA screen_address+1        ; get screen address MSB
    CMP #$7F                    ; set C if >=$7f, i.e., pass 1
    EOR #screen_size_pages-1    ; toggle between $7f and $40/$60,
                                ; setting address for next pass
    STA screen_address+1        ; save new MSB
    BCC L10B2                   ; taken if MSB was <$7f - i.e. we just
                                ; did pass 2
                                
;; handle end of pass 1

    LDA screen_address          ; get screen address LSB
    STA some_other_plot_var     ; save for pass 2
    LDA #$00                    ; reset screen address LSB
    STA screen_address          ; screen address now $4000 or $6000
    LDY something_plot_var      ; LSB of starting address - this will
                                ; do as the dest offset now, and the
                                ; carry check will prevent writing to
                                ; <$4000 or <$6000 and bail out at the
                                ; appropriate column
    BCS L105A                   ; JMP, in effect
    
.L10B2

;; handle end of pass 2

    LDA some_other_plot_var     ; get screen address LSB, previously
                                ; saved above
    STA screen_address          ; restore screen adress LSB
    LDX copy_of_stack_pointer_6a ; restore X
    CPY #$F9                     ; same $f9 check as above
    BCC L10C3                    ; taken if this line is done

;; ??don't know about the logic here? - think it keeps L109C active
;; for as little time as possible??

    DEC something_plot_var
    CLC                         
    LDA lines_in_sprite         
    BNE L1072
    
.L10C3

;; end of sprite, so put everything back as it was and go back to the
;; normal flow for an orderly exit.

    LDA #$A6                    ; LDX $xx
    STA L1070                   
    LDA #copy_of_stack_pointer_6a ; LDX $6a
    STA L1070+1                   
    BCC L1072                   ; JMP, in effect
    
.plotting_done
    JMP object_redrawing_loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.plot_background_strip_from_cache
    JSR change_display_mode                         ; set display mode to "overwrite"
.L10D5
    DEC strip_length
    BMI change_display_mode                         ; revert display mode to "if empty", and leave
    LDX strip_length
    LDA background_strip_cache_orientation,X        ; get the square data from the cache
    STA square_orientation
    LDA background_strip_cache_sprite,X
    STA square_sprite
    JSR setup_background_sprite_values_from_08_09   ; determine which sprite/palette to use
    JSR plot_background_square                      ; plot the squre
.L10EB
    INC square_x                                      ; move to next square (modified from &375b)
    JMP L10D5

.change_display_mode
    LDX #$01 ; swap &1064-1065 and &1066-&1067
.L10F2
    LDA L1064,X ; this changes the display mode between overwriting
    LDY L1066,X ; regardless and overwriting only if empty
    STA L1066,X
    TYA
    STA L1064,X
    DEX
    BPL L10F2
.L1102
    RTS

;;  unused code
    JSR setup_background_sprite_values
.plot_background_square
    CPY #$19 ; is the square an empty space?
    BEQ L1102 ; if so, leave
    LDA #$00
    STA skip_sprite_calculation_flags
    LDA #$00
    STA this_object_flags
    STA this_object_flags_old
    JMP plot_sprite                                 ; this plots the background space

.screen_size_low_x
    equb $E0
    equb $EA; (unused)
.screen_size_low_y
    equb $C0
.screen_size_x
    equb $07
    equb $EA; (unused)
.screen_size_y
IF SRAM
    equb $07
ELSE
    equb $03
ENDIF

;; (unused)
;; (unused)
;;  Y = radius around screen to consider
;;  returns carry clear if onscreen, carry set if offscreen
.is_object_offscreen
    STY zp_various_9b ; radius
IF SRAM=0
    INC zp_various_9b ; radius
    INC zp_various_9b ; radius
ENDIF
    LDX #$02 ; in y direction first (X = 2), then x direction (X = 0)
.L1125
    LDA screen_offset_x,X ; X = 2, &0b97 screen_offset_y; X = 0, &0b95 ; screen_offset_x
    SEC
    SBC this_object_x,X ; X = 2, &55 this_object_y; X = 0, &53 this_object_x
    STA zp_various_9d ; tmp_9d                                        ; screen_offset - object
    CLC
    SBC zp_various_9b ; radius                                        ; is (screen_offset - object - radius) > 0
    BPL object_is_offscreen                         ; if so, object is offscreen
    LDA screen_size_low_x,X ; X = 2, &1119 screen_size_low_y; X = 0, &1117 screen_size_low_x
    CLC
    ADC screen_offset_x_low,X ; X = 2, &0b93 screen_offset_y_low; X = 0, &0b91 ; screen_offset_x_low
    LDA screen_size_x,X ; X = 2, &111c screen_size_y; X = 0, &111a screen_size_x
    ADC zp_various_9d
    CLC
    ADC zp_various_9b ; radius                                        ; is (screen_size + screen_offset - object + radius) < 0
    BMI object_is_offscreen                         ; if so, object is offscreen
IF SRAM=0
    DEC zp_various_9b ; radius
    DEC zp_various_9b ; radius                                        ; smaller radius in x direction
ENDIF
    DEX
    DEX
    BEQ L1125 ; and do it again for x direction
    CLC ; return carry clear if onscreen
    RTS
.object_is_offscreen
    SEC ; return carry set if offscreen
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  various lookups for background
.background_lookup
    equb $19,$2D,$ED,$6D,$AD,$2D,$ED
    equb $5E,$9E,$00,$C0,$80,$40
    equb $2E,$2F,$2E,$23; [TOM 2f was 2e]
    equb $06,$04,$06,$04,$07,$05,$05,$06,$19,$2C,$19,$2B,$00,$01,$02,$03
    equb $1A,$21,$09,$9B,$12,$10,$60,$2B,$0F,$4F,$04,$0A
.lookup_for_unmatched_hash
    equb $1B,$5A,$19,$19,$1E,$13,$24,$2C,$19
.wall_palette_zero_lookup
;;  lookup table for Y -> palette for background
    equb $8D,$82,$8B,$8F,$84,$89,$8D
.wall_palette_four_lookup
    equb $81,$82,$81,$85
equb $B2
equb $CD
equb $90
equb $95
equb $81
.wall_palette_three_lookup
    equb $B1,$97,$FD,$F3
.M1191
    equb $00
.sound_max_channels
    equb $03                    ; 3 normally, or 2 when a sample is
                                ; playing
    equb $01; (unused)
.sound_data_119c                ; read-only data
    equb $00,$40,$84,$B6
.sound_data_11a0                ; read-only data
    equb $E0,$10,$4A,$80
.sound_chip_frequency_commands
    ; used as the top 4 bits of values written to sound chip
    equb $E0                    ; 1 110 = noise control
    equb $C0                    ; 1 100 = tone 1 freq
    equb $A0                    ; 1 010 = tone 2 freq
    equb $80                    ; 1 000 = tone 3 freq
.sound_chip_volume_commands
    equb $F0                    ; 1 111 = noise volume
    equb $D0                    ; 1 101 = tone 1 volume
    equb $B0                    ; 1 011 = tone 2 volume
    equb $90                    ; 1 001 = tone 3 volume
.sound_duration
    ; storage for [1]&0xf0 of sound data
    equb $00,$00,$00,$00
    ; storage for [3]&0xf0 of sound data
    equb $00,$00,$00,$00
.sound_channel_table_indexes
; storage for [0] of sound data - used as index for
; sound_data_big_lookup_table
    equb $33,$22,$11,$00
; storage for [2] of sound data - used as index for
; sound_data_big_lookup_table
    equb $33,$22,$11,$00
.sound_channel_counters
; starts out at 0 each time a sound is started
    equb $33,$22,$11,$00
    equb $33,$22,$11,$00
.sound_data_11c4
; starts out at 0 each time a sound is started
    equb $33,$22,$11,$00
    equb $33,$22,$11,$00
.sound_duration_low
; storage for [1]&0x0f of sound data
; 0 if no sound playing on this channel.
    equb $00,$00,$00,$00
; storage for [3]&0x0f of sound data
    equb $00,$00,$00,$00
.sound_data_11d4
; stores sound_data_big_lookup_table indexes
    equb $33,$22,$11,$00,$33,$22,$11,$00
.sound_channel_distances
    equb $00,$00,$00,$00
.sound_channel_data_ls
    equb $00,$00,$00,$00
.palette_register_updating
    equb $00
.palette_register_data
;;       0:black 1:red 2:green 3:yellow 4:blue 5:magenta 6:cyan 7:white
;;       8:black 9:red a:green b:yellow c:blue d:magenta e:cyan f:white
    equb $07,$16,$25,$34,$43,$52,$61,$70,$87,$96,$A5,$B4,$C3,$D2,$E1,$F0
.keys_processed
    equb $00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ##############################################################################
;; 
;;    Function Table
;;    ==============
;;    offset sym  h  l        key     address function
;;    00      69 6a 75        copy    &3576   pause               ; mapped as END in mess
;;    01      20 59 e1        f0      &2ce2   change_to_weapon
;;    02      71 59 e1        f1      &2ce2   change_to_weapon
;;    03      72 59 e1        f2      &2ce2   change_to_weapon
;;    04      73 59 e1        f3      &2ce2   change_to_weapon
;;    05      14 59 e1        f5      &2ce2   change_to_weapon
;;    06      74 59 e1        f5      &2ce2   change_to_weapon
;;    07      75 59 e1        f6      &2ce2   change_to_weapon
;;    08      16 59 e1        f7      &2ce2   change_to_weapon
;;    09      76 59 e1        f8      &2ce2   change_to_weapon
;;    0a      77 59 e1        f9      &2ce2   change_to_weapon
;;    0b      77 28 d5        f9      &14d6   f9_pressed
;;    0c      53 69 f7        g       &34f8   retrieve_object
;;    0d      62 5b 32        space   &2d33   fire_weapon
;;    0e      25 62 1f        i       &3120   reset_gun_aim
;;    0f      19 59 1c        left    &2c1d   scroll_viewpoint
;;    10      79 59 1c        right   &2c1d   scroll_viewpoint
;;    11      39 59 1c        up      &2c1d   scroll_viewpoint
;;    12      29 59 1c        down    &2c1d   scroll_viewpoint
;;    13      46 62 28        k       &3129   lower_gun_aim
;;    14      36 62 25        o       &3126   raise_gun_aim
;;    15      47 58 80        @       &2c81   use_booster         ; mapped as \ in mess
;;    16      01 58 79        ctrl    &2c80   (null)
;;    17      60 3d 18        tab     &1e19   swap_direction
;;    18      44 59 98        y       &2c99   play_whistle_1
;;    19      35 59 ab        u       &2cac   play_whistle_2
;;    1a      23 19 c0        t       &0cc1   teleport_player
;;    1b      33 59 3b        r       &2c3c   store_teleport
;;    1c      67 64 d8        .       &32d9   throw_object
;;    1d      65 64 c7        m       &32c8   drop_object
;;    1e      66 64 b5        ,       &32b6   pick_up_object
;;    1f      51 69 b0        s       &34b1   store_object
;;    20      63 25 99        v       &129a   volume_control
;;    21      10 58 6c        q       &2c6d   move_left
;;    22      21 58 69        w       &2c6a   move_right
;;    23      37 58 72        p       &2c73   move_up
;;    24      37 77 92        p       &3b93   p_pressed
;;    25      56 58 6f        l       &2c70   move_down
;;    26      00 28 9b        shift   &149c   (null)
;; 
;; ##############################################################################

.function_table
equb LO(pause-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(change_to_weapon-1)
equb LO(f9_pressed-1)
equb LO(retrieve_object-1)
equb LO(fire_weapon-1)
equb LO(reset_gun_aim-1)
equb LO(scroll_viewpoint-1)
equb LO(scroll_viewpoint-1)
equb LO(scroll_viewpoint-1)
equb LO(scroll_viewpoint-1)
equb LO(lower_gun_aim-1)
equb LO(raise_gun_aim-1)
equb LO(use_booster-1)
equb LO(or_extra_with_0f-1)
equb LO(swap_direction-1)
equb LO(play_whistle_2-1)
equb LO(play_whistle_1-1)
equb LO(teleport_player-1)
equb LO(store_teleport-1)
equb LO(throw_object-1)
equb LO(drop_object-1)
equb LO(pick_up_object-1)
equb LO(store_object-1)
equb LO(volume_control-1)
equb LO(move_left-1)
equb LO(move_right-1)
equb LO(move_up-1)
equb LO(p_pressed-1)
equb LO(move_down-1)
equb LO(just_rts-1)
.function_table_h
equb (HI(pause-1)<<1) OR 0
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(change_to_weapon-1)<<1) OR 1
equb (HI(f9_pressed-1)<<1) OR 0
equb (HI(retrieve_object-1)<<1) OR 1
equb (HI(fire_weapon-1)<<1) OR 1
equb (HI(reset_gun_aim-1)<<1) OR 0
equb (HI(scroll_viewpoint-1)<<1) OR 1
equb (HI(scroll_viewpoint-1)<<1) OR 1
equb (HI(scroll_viewpoint-1)<<1) OR 1
equb (HI(scroll_viewpoint-1)<<1) OR 1
equb (HI(lower_gun_aim-1)<<1) OR 0
equb (HI(raise_gun_aim-1)<<1) OR 0
equb (HI(use_booster-1)<<1) OR 0
equb (HI(or_extra_with_0f-1)<<1) OR 0
equb (HI(swap_direction-1)<<1) OR 1
equb (HI(play_whistle_2-1)<<1) OR 1
equb (HI(play_whistle_1-1)<<1) OR 1
equb (HI(teleport_player-1)<<1) OR 1
equb (HI(store_teleport-1)<<1) OR 1
equb (HI(throw_object-1)<<1) OR 0
equb (HI(drop_object-1)<<1) OR 0
equb (HI(pick_up_object-1)<<1) OR 0
equb (HI(store_object-1)<<1) OR 1
equb (HI(volume_control-1)<<1) OR 1
equb (HI(move_left-1)<<1) OR 0
equb (HI(move_right-1)<<1) OR 0
equb (HI(move_up-1)<<1) OR 0
equb (HI(p_pressed-1)<<1) OR 1
equb (HI(move_down-1)<<1) OR 0
equb (HI(just_rts-1)<<1) OR 0
.keys_to_check
equb $69 ; Copy
equb $20 ; f0
equb $71 ; f1
equb $72 ; f2
equb $73 ; f3
equb $14 ; f4
equb $74 ; f5
equb $75 ; f6
equb $16 ; f7
equb $76 ; f8
equb $77 ; f9
equb $77 ; f9
equb $53 ; G
equb $62 ; Space bar
equb $25 ; I
equb $19 ; Left
equb $79 ; Right
equb $39 ; Up
equb $29 ; Down
equb $46 ; K
equb $36 ; O
equb $47 ; @
equb $01 ; Ctrl
equb $60 ; Tab
equb $44 ; Y
equb $35 ; U
equb $23 ; T
equb $33 ; R
equb $67 ; .
equb $65 ; M
equb $66 ; ,
equb $51 ; S
equb $63 ; V
equb $10 ; Q
equb $21 ; W
equb $37 ; P
equb $37 ; P
equb $56 ; L
equb $00 ; Shift
.keys_pressed
equb $00 ; Copy (0, 0x0)
equb $00 ; f0 (1, 0x1)
equb $00 ; f1 (2, 0x2)
equb $00 ; f2 (3, 0x3)
equb $00 ; f3 (4, 0x4)
equb $00 ; f4 (5, 0x5)
equb $00 ; f5 (6, 0x6)
equb $00 ; f6 (7, 0x7)
equb $00 ; f7 (8, 0x8)
equb $00 ; f8 (9, 0x9)
equb $00 ; f9 (10, 0xA)
equb $00 ; f9 (11, 0xB)
equb $00 ; G (12, 0xC)
equb $00 ; Space bar (13, 0xD)
equb $00 ; I (14, 0xE)
equb $00 ; Left (15, 0xF)
equb $00 ; Right (16, 0x10)
equb $00 ; Up (17, 0x11)
equb $00 ; Down (18, 0x12)
equb $00 ; K (19, 0x13)
equb $00 ; O (20, 0x14)
equb $00 ; @ (21, 0x15)
equb $00 ; Ctrl (22, 0x16)
equb $00 ; Tab (23, 0x17)
equb $00 ; Y (24, 0x18)
equb $00 ; U (25, 0x19)
equb $00 ; T (26, 0x1A)
equb $00 ; R (27, 0x1B)
equb $00 ; . (28, 0x1C)
equb $00 ; M (29, 0x1D)
equb $00 ; , (30, 0x1E)
equb $00 ; S (31, 0x1F)
equb $00 ; V (32, 0x20)
equb $00 ; Q (33, 0x21)
equb $00 ; W (34, 0x22)
equb $00 ; P (35, 0x23)
equb $00 ; P (36, 0x24)
equb $00 ; L (37, 0x25)
equb $00 ; Shift (38, 0x26)
ctrl_key_index=22
shift_key_index=38
boost_key_index=21
fire_key_index=13
pause_key_index=0
left_key_index=15
f8_key_index=9
num_keys=39

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.volume
    equb $FF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.increment_game_time
    INX
.increment_game_time_X
    INC game_time,X
    BEQ increment_game_time
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.volume_control
    LDA volume
    EOR #$FF
    STA volume
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF SRAM
.M129B
    bit $fe6d                   ; test user VIA IFR
    bvc M12B8                   ; branch taken if not T1 interrupt

; set T1 to smp_next_delay<<7. 

    lda #0                      ; 
    lsr smp_next_delay          ; C = smp_next_delay bit 0
    ror a                       ; LO(smp_next_delay<<7)
    sta $fe64                   
    lda smp_next_delay          ; HI(smp_next_delay<<7) 
    sta $fe65
    lda smp_next_volume_cmd     ; get next value to write - either
                                ; silence or appropriate volume command
    jsr push_sound_to_chip      ; do it
    jsr smp_next_byte           ; prepare next byte
.M12B8
ENDIF
.L12A3
    JMP leave_interrupt
.irq_routine
{
;;  IRQ1V from interrupt &0204
    TYA
    PHA
    TXA
    PHA
    BIT $FE4D ; get system VIA interrupt flag register
IF SRAM
    bpl M129B
ELSE
    BPL L12A3 ; has the VIA caused an interrupt? if not, leave
ENDIF
    LDA #$7F
    STA $FE4D ; set system VIA interrupt flag register
    BVC L12C8
    LDA #$01 ; colour 0 = cyan
    STA $FE21 ; video ULA palette register
    LDY #$18
.L12BD
    DEY
    BNE L12BD
    LDA #$03 ; colour 0 = blue
    STA $FE21 ; video ULA palette register
.Lleave_interrupt
    JMP leave_interrupt
.L12C8
    LDA water_level_on_screen
    BEQ L12D6
    LDY water_level_interrupt
    STY $FE44 ; interrupt to change colour for water
    STA $FE45
.L12D6
    LDA #$07 ; colour 0 = black
    STA $FE21 ; video ULA palette register
    INC palette_register_updating
    LDA palette_register_data_updated ; has the palette register data changed?
    BEQ no_update_to_palette
    JSR push_palette_register_data ; if so, push it to the video chip
    STY palette_register_data_updated ; and mark it as having been updated
.no_update_to_palette
    LDA #$7F            ; set port A for input on bit 7 others outputs
    STA $FE43
    LDA #$03                    ; stop auto scan
    STA $FE40
    LDX keys_processed       ; have we processed the last lot of keys?
    BEQ L12FA                ; don't check again unless we have
    LDX #num_keys-1
.L12FA
    LDA keys_to_check,X         ; has a key been pressed?
    STA $FE4F                   ; store the key sym
    LDA $FE4F                   ; read the result
    ROL A
    ROR keys_pressed,X          ; and store in keys_pressed
    DEX
    BPL L12FA
    LDA #$0B ; select auto scan of keyboard
    STA $FE40
    INX
    STX keys_processed
    BIT game_paused                                 ; is the game paused?
    BPL leave_interrupt                             ; if so, leave interrupt
    JSR increment_game_time_X
    LDA #$FF
    STA $FE43

; handle sounds

    LDX sound_max_channels
.L1323
    JSR process_sound
    BCS L1332
    LDA sound_duration,X        ; sound duration for channel
    SBC #$01                    ; subtract 2?!
    BCC sound_run_out           ; bail if sound done, or if it wasn't
                                ; playing
    STA sound_duration,X        ; update sound duration for channel
.L1332
; advance to second half of sound data
    INX
    INX
    INX
    INX
    ; process second half of sound data
    JSR process_sound
    ; wind back to first half of sound data
    DEX
    DEX
    DEX
    DEX
    BCC sound_run_out
    BNE L1345                   ; taken if tone channel
    CMP used_in_sound
    BEQ sound_run_out
.L1345
    EOR #$FF
    
; map 8-bit pitch to 10-bit frequency.
;
; A>=$b6: subtract $80, scale by 8 ($36-$7f * 8 = $1b0-$3f8)
; A>=$84: subtract $4a, scale by 4 ($3a-$6b * 4 = $e8-$1ac)
; A>=$40: subtract $10, scale by 2 ($30-$74 * 2 = $60-$e8)
; A<$40 : subtract $e0, no scale   ($20-$60 * 1 = $20-$60)

    LDY #$04
    STY used_in_sound
.L134B
    DEY
    CMP sound_data_119c,Y
; the 0th entry in sound_data_199c is 0, so this loop will eventually
; terminate with Y=0, C=1.
    BCC L134B

    SBC sound_data_11a0,Y

; scale up and shift the lost bits into the bottom of used_in_sound

.L1354
    DEY
    BMI L135D                   ; taken if Y<0
    ASL A                       ; get sign bit
    ROL used_in_sound           ; shift into used_in_sound
    JMP L1354                   ; loop
    
.L135D
; see SN76489 data sheet, section 6
; 
; Accumulator:
;
;    7    6    5    4    3    2    1    0
; +----+----+----+----+----+----+----+----+
; | F7 | F6 | F5 | F4 | F3 | F2 | F1 | F0 |
; +----+----+----+----+----+----+----+----+
;
; used_in_sound:
;
;    7    6    5    4    3    2    1    0
; +----+----+----+----+----+----+----+----+
; | x  | x  | x  | x  | x  | x  | F9 | F8 |
; +----+----+----+----+----+----+----+----+

    PHA                         
    AND #$0F                    ; get bottom 4 bits of data
    ORA sound_chip_frequency_commands,X ; mask in register value
    JSR push_sound_to_chip      ; write tone frequency bits 0-3
    PLA                         
    CPX #$00                    
    BEQ sound_run_out           ; taken if working on noise control
                                ; register, which is only 4 bits

; get top 6 bits

    LSR used_in_sound           ; 
    ROR A                       ; 87654321
    LSR used_in_sound           ; 
    ROR A                       ; 98765432
    LSR A                       ; -9876543
    LSR A                       ; --987654
    JSR push_sound_to_chip      ; write tone frequency bits 4-9
.sound_run_out

; attenuate with distance??

    LDA sound_duration,X        
    SBC sound_channel_distances,X
    BCS L1380                   ; taken if no borrow
    LDA #$00                    ; clamp to zero
.L1380
    AND volume                  ; silence if sound off
    EOR #$FF                    ; 0=max sound chip volume
    LSR A
    LSR A
    LSR A
    LSR A
    ORA sound_chip_volume_commands,X
    JSR push_sound_to_chip
    DEX
    BPL L1323                   ; taken if more channels left
}
.leave_interrupt
    PLA
    TAX
    PLA
    TAY
    LDA $FC
    RTI

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  X = channel
.process_sound
{
    CLC
    LDA sound_duration_low,X    ; is this channel playing?
    BEQ process_sound_out       ; taken if not playing. Leave with
                                ; C=0.
    LDY sound_channel_table_indexes,X ; get channel's big lookup table index
    LDA sound_channel_counters,X ; get channel's counter
    BNE L13D4                   ; branch taken if counter active?
    LDA sound_data_11c4,X       ; get channel's counter
    BNE L13B1                   ; branch taken if counter active?

; code gets here on first call for a given sound.
;
; sound_duration_low counts number of timeouts of both counters??

    DEC sound_duration_low,X    ; decrement sound duration
    BEQ process_sound_out       ; if sound done, leave with C=0

.L13B1
    INY                               ; next table index
    LDA sound_data_big_lookup_table,Y ; fetch table value
    BPL L13CC                         ; taken if bit 7 clear

; bit 7 set

    DEC sound_data_11c4,X             ; decrement channel's counter
    BPL L13C6               ; branch taken if counter still positive

    AND #$7F                ; mask off table value bit 7, which was
                            ; set
    STA sound_data_11c4,X   ; save as new channel counter
    INY                     ; next table byte
    TYA                     ; 
    STA sound_data_11d4,X   ; store table byte in channel's data
.L13C6
    LDY sound_data_11d4,X       ; get index of table byte
    LDA sound_data_big_lookup_table,Y ; fetch table byte
.L13CC
    STA sound_channel_counters,X       ; store channel's data2
    INY                         ; next table byte
    TYA
    STA sound_channel_table_indexes,X ; update channel's big lookup table index
.L13D4
    LDA sound_duration,X        ; get channel's duration
    STA used_in_sound           ;
    ADC sound_data_big_lookup_table,Y
    STA sound_duration,X
    DEC sound_channel_counters,X
    SEC
    ; leave with C=1 and A=channel's sound_duration
.process_sound_out
    RTS
}


.push_sound_to_chip
{
    STA $FE4F                   ; write value to sound chip
    LDA #$00                    
    STA $FE40                   ; latch B0=0 - enable sound write
    LDA #$22
    ;  delay ~10 cycles and finish up with A=8
.L13EE
    LSR A
    BCC L13EE
    STA $FE40                   ; latch B0=1 - disable sound write
.L13F4
    ; delay ~20 cycles
    LSR A
    BCC L13F4
    RTS
}

.play_sound2
; play_sound2 enters the routine with carry set rather than clear.
; (this always picks channel 0... presumably play_sound2 is then the
; entry point for noises rather than tones?)
    SEC
    equb $24; BIT &xx            BIT &18 ; wall_collision_bottom_minus_top
.play_sound
    CLC
    ; store registers
    STA temp_a_OR_supporting_object_xy ; temp_a
    STX velocity_signs_OR_pixel_colour ; temp_x
    STY zp_various_9a                  ; temp_y
    PHP                                ; push processor status
    PLA                                ; and pull it back again
    TAX                                ; X is processor status
    PLA                                ; get old PCL
    STA zp_various_9b ; sound_data_l          ; &9b is lsb of sound data
    CLC
    ADC #$04                    ; PCL+4
    TAY                         ; Y is lsb of new return address
    PLA                         ; get old PCH
    STA zp_various_9c ; sound_data_h          ; &9c is msb of sound data
    ADC #$00          ; carry
    PHA               ; push msb of new return address
    TYA               ; get new PCL
    PHA               ; push lsb of new return address
    TXA               ; get old status
    PHA               ; push processor status
    JSR get_object_distance_from_screen_centre
    CMP #$10                    ; is it too far away?
    BCS play_sound_out          ; if so, it makes no noise
    ASL A
    ASL A
    ASL A
    ASL A
    TAY                         ; Y = distance * 16
    PLP                         ; pull processor status
    BCC L142D                   ; taken if entry point was play_sound
    LDX #$00                    ; channel 0
    LDA sound_duration_low      ; sound_duration_low for channel 0
    BEQ sound_slot_found        ; use channel 0
    BCS find_sound_slot_loop    ; JMP, in effect
.L142D
    LDX sound_max_channels      ; start from max channel
.L1430
    LDA sound_duration_low,X    ; get channel's entry
    BEQ sound_slot_found        ; taken if this channel isn't in use
    DEX                         ; next channel
    BNE L1430                   ; loop until channel 1 inclusive some
    LDA sound_channel_data_ls+1 ; wat
    EOR sound_channel_data_ls+2 ; wat
    EOR sound_channel_data_ls+3 ; wat
    LDX sound_max_channels      ; start from max channel
.L1444
    CMP sound_channel_data_ls,X ; 
    BEQ L145E
    DEX
    BNE L1444
    LDX sound_max_channels
.find_sound_slot_loop
    TYA                         ; A = distance * 16
    CMP sound_channel_distances+1,X
    BEQ sound_slot_found        ; taken if new sound is same distance
    BCC sound_slot_found        ; taken if new sound is closer
    DEX                         ; next channel
    BEQ play_sound_out2         ; taken if couldn't find a slot
    BPL find_sound_slot_loop    ; taken if more slots left
    BMI play_sound_out2         ; JMP, in effect
.L145E
    DEX                         ; next channel
    BNE sound_slot_found        ; taken if more channels left
    LDX sound_max_channels      ; max channel
.sound_slot_found
    TYA                           ; A = distance * 16
    STA sound_channel_distances,X ; store distance
    LDA zp_various_9b             ; sound_data_l
    STA sound_channel_data_ls,X   ; store sound_data_l

    LDY #$01                      ; offset=1 - JSR pushes PC-1...
    PHP
    SEI
.L1471
    LDA (zp_various_9b),Y ; sound_data+0, sound_data+2 - pitch
                          ; increase?
    STA sound_channel_table_indexes,X ; 
    INY                   ;
    LDA (zp_various_9b),Y ; sound_data+1, sound_data+3
    AND #$F0              ; top 4 bits
    STA sound_duration,X  ; store it
    EOR (zp_various_9b),Y ; bottom 4 bits
    STA sound_duration_low,X    ; store it
    INY                         ; 
    LDA #$00                    ; 
    STA sound_channel_counters,X       ; 
    STA sound_data_11c4,X       ; 
    INX
    INX
    INX
    INX
    CPX #$08                    ; 
    BCC L1471                   ; taken if X<8
.play_sound_out
    PLP                         ; restore processor status
.play_sound_out2
    LDA temp_a_OR_supporting_object_xy ; temp_a                ; restore registers
    LDX velocity_signs_OR_pixel_colour ; temp_x
    LDY zp_various_9a ; temp_y
    SEC
.just_rts
    RTS
.play_middle_beep
    JSR play_sound
    equb $17,$E3,$2F,$72; sound data
    RTS
.play_high_beep
    JSR play_sound
    equb $17,$82,$13,$F2; sound data
    RTS
.play_low_beep
    JSR play_sound
    equb $5D,$04,$FF,$05; sound data
    RTS
.play_squeal
    JSR play_sound
    equb $33,$03,$2D,$84
    RTS
.game_paused
    equb $92
.palette_register_data_updated
    equb $01
.angle_modification_table
    equb $BF,$80,$C0,$FF,$40,$7F,$3F,$00
.something_scrolly_x
    equb $04
.scroll_offset_x
    equb $00
.something_scrolly_y
IF SRAM
    equb $04
ELSE
    equb $02
ENDIF
.scroll_offset_y
    equb $00
.player_object_number
    equb $00
IF SRAM
.M14E1
ENDIF
.always_zero
    equb $00
.call_object_handlers_when_redrawing_screen
    equb $00
.water_level_interrupt
    equb $00
.water_level_on_screen
    equb $00
.water_level_low
    equb $00
.water_level
    equb $00
.x_ranges
    equb $00,$54,$74,$A0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.f9_pressed
{
    BIT keys_pressed+shift_key_index                         ; if shift held?
    BPL L1529 ; if not, leave
;;  save our position data somewhere more stable...
    JSR null_function
    SED
    SEI
    LDA timer_2
    EOR timer_4
    AND #$7F
    EOR #$65
    STA timers_and_eor
    SEC
    LDY #$07
.L14EE
    LDA timer_1-1,Y ; copy &0d9 - 0df 
    STA $07f7,y ; background_strip_cache_sprite+1,Y ; to &07f8 - &07fe
    DEY
    BNE L14EE
    LDA #$6E
    STA zp_various_9d
    LDA #$92
.L14FD
    ADC zp_various_9d
    ADC #$15
    STA zp_various_9d
.L1503
    LDA $07f8,y ; background_strip_cache_sprite+2,Y ; modified by &151e
    PHA
    EOR possible_checksum
    STA possible_checksum
    PLA
    EOR zp_various_9d
    PHA
    EOR maybe_another_checksum
    STA maybe_another_checksum
    PLA
.L1518
    STA $2C00,Y ; modified by &1521
    INY
    BNE L14FD
    INC L1503+2 ; copy &07f8 -
    INC L1518+2 ; to &2c00 - &7fff
    BPL L14FD
    JMP zero_memory_and_loop_endlessly
.L1529
    RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.focus_on_player_maybe
    LSR consider_secondary_stack_objects            ; don't
IF SRAM
    lsr M1191
    bit M1191
    bvc focus_on_player_maybe2
    lda #0
    sta scroll_x_direction
    sta scroll_y_direction
    rts
.focus_on_player_maybe2
ENDIF
    JSR get_object_centre                           ; get centre of player
    LDX #$00 ; first, x direction
    JSR do_someting_in_one_direction_scrolls
    STA zp_various_a2
    JSR make_positive_cmp_0
    STA zp_various_9d
    CMP #$0C
    BCS L158E
    CMP #$02
    BCC L1558
    BEQ L154E
    LDY #$04
    LDA screen_start_square_x_low
    AND #$7F
    BEQ L1557
.L154E
    LDY #$02
    LDA screen_start_square_x_low
    AND #$20
    BEQ L1557
    DEY
.L1557
    TYA
.L1558
    BIT zp_various_a2
    JSR make_positive
    STA scroll_x_direction
    LDX #$02
    JSR do_someting_in_one_direction_scrolls        ; then y direction
    TAY
    JSR make_positive
    CMP zp_various_9d
    BCC L1589
    CMP #$0C
    BCS L158E
    CMP #$02
    TYA
    BCC L1582
    LDA #$01
    BIT screen_start_square_y_low
    BVS L157D
    LDA #$02
.L157D
    CPY #$00
    JSR make_positive
.L1582
    STA scroll_y_direction
    LDA #$00
    STA scroll_x_direction
    RTS
.L1589
    LDA #$00
    STA scroll_y_direction
    RTS
.L158E
    LDA #$80
    STA screen_start_square_x_low
    STA screen_start_square_y_low
    LDA this_object_y_centre_OR_particle_y
    SEC
IF SRAM
    sbc #$03
ELSE
    SBC #$01
ENDIF
    STA screen_start_square_y
    LDA this_object_x_centre_OR_particle_x
    SBC #$04
    STA screen_start_square_x
    LDA #$FE
    STA scroll_y_direction
    LDA #$00
    STA scroll_x_direction
    JSR refocus_on_player
    JSR set_screen_start_address
    LDA screen_start_square_y
    CLC
IF SRAM
    adc #$08
ELSE
    ADC #$04
ENDIF
    STA screen_start_square_y
IF SRAM
    ldx #$10
ELSE
    LDX #$08
ENDIF
.L15B8
    STX other_object_minus_10_OR_this_object_width_divided_32
    JSR refocus_on_player
    JSR redraw_screen
    JSR plot_background_strip_from_cache
    LDX other_object_minus_10_OR_this_object_width_divided_32
    DEX
    BNE L15B8
    STX scroll_y_direction
    LDA #$F0
    STA skip_sprite_calculation_flags
    STA consider_secondary_stack_objects            ; do
    RTS
.do_someting_in_one_direction_scrolls
    BIT ship_moving                                 ; is the ship moving?
    BPL ship_not_moving
    TXA
    EOR #$02
    BNE L161B
    LDA #$3B
    STA this_object_y_centre_OR_particle_y ; this_object_y_centre
.ship_not_moving
    LDA this_object_x_centre_low_OR_particle_x_low,X ; this_object_centre_x_low
    CMP screen_start_square_x_low,X
    PHP
    LDA this_object_vel_x,X
    CPX #$00
    BEQ L15EE
    CMP #$80
    ROR A
.L15EE
    JSR shift_right_three_while_keeping_sign
    CMP L161C,X
    BEQ L1601
    BPL L15FE
    DEC L161C,X
    DEC L161C,X
.L15FE
    INC L161C,X
.L1601
    LDA L161C,X
    JSR shift_right_three_while_keeping_sign
    ADC scroll_offset_x,X
    CLC
    ADC this_object_x_centre_OR_particle_x,X ; this_object_centre_x
    PLP
    SBC screen_start_square_x,X
    SEC
    SBC something_scrolly_x,X
    CMP scroll_x_direction,X
    BPL L161B
    CLC
    ADC #$01
.L161B
    RTS
.L161C
    BRK
    BRK
    BRK
.refocus_on_player
    LDY #$00
    LDX #$02 ; first X = 2, y direction, then X = 0, x direction
.L1623
    LDA scroll_x_direction,X
    BEQ L162C ; are we scrolling?
    LDA screen_start_square_x_low,X
    BNE L162C ; if so, is a new square exposed
    DEY ; if so, we need to call object handlers
.L162C
    DEX
    DEX
    BEQ L1623 ; repeat for the x direction
    STY call_object_handlers_when_redrawing_screen  ; note whether background object handlers are needed
    LDX #$02 ; first X = 2, y direction, then X = 0, x direction
.L1635
    LDA scroll_x_direction,X                          ; use the scroll direction to:
    ASL A
    LDY #$00
    BCC L163D
    DEY
.L163D
    CPX #$02
    BCC L1642
    ASL A
.L1642
    ASL A
    ASL A
    ASL A
    ASL A
    STA scroll_square_x_velocity_low,X                ; calculate scroll square velocities
    CLC
    ADC screen_start_square_x_low,X
    STA screen_start_square_x_low,X                   ; and new screen start square positions
    TYA
    STA scroll_square_x_velocity_high,X
    ADC screen_start_square_x,X
    STA screen_start_square_x,X
    DEX
    DEX
    BPL L1635 ; repeat for the x direction
    LDA screen_start_square_x_low
    STA screen_start_square_x_low_copy
    STA screen_offset
    LDA screen_start_square_y
    LSR A
    STA zp_various_9b
    LDA screen_start_square_y_low
    ROR A
    LSR zp_various_9b
    ROR A
    LSR zp_various_9b
    ROR A
    ADC screen_start_square_x
    STA zp_various_9c
    LDA zp_various_9b
    ADC #$00
    LDY #$08
.L1676
    ASL zp_various_9c
    ROL A
    BCS L167F
IF SRAM
    cmp #$00
ELSE
    CMP #$80
ENDIF
    BCC L1681
.L167F
IF SRAM
    sbc #$00
ELSE
    SBC #$80
ENDIF
.L1681
    DEY
    BNE L1676
    STA some_screen_address_offset
    LSR A
    ROR screen_offset
    LSR A
    ROR screen_offset
    STA screen_offset_h
    LDX #$02
.L1690
    LDA #$00
    SEC
    SBC scroll_square_x_velocity_low,X
    TAY
    LDA #$00
    SBC scroll_square_x_velocity_high,X
    BPL L169F
    LDA #$00
    TAY
.L169F
    STA plot_sprite_screen_location_offsets+1,X
    TYA
    STA plot_sprite_screen_location_offsets_low+1,X
    LDA scroll_square_x_velocity_low,X
    LDY scroll_square_x_velocity_high,X
    CLC
    BMI L16B1
    EOR #$FF
    SEC
    DEY
.L16B1
    ADC plot_sprite_screen_address_offsets_low,X
    STA plot_sprite_screen_address_offsets_low+1,X
    TYA
    ADC plot_sprite_screen_address_offsets,X
    STA plot_sprite_screen_address_offsets+1,X
    LDA screen_start_square_x_low,X
    STA screen_offset_x_low,X
    CLC
    ADC plot_sprite_screen_location_offsets_low+1,X
    STA screen_offset_x_low_old,X
    LDA screen_start_square_x,X
    STA screen_offset_x,X
    ADC plot_sprite_screen_location_offsets+1,X
    STA screen_offset_x_old,X
    DEX
    DEX
    BPL L1690
    LDA screen_start_square_x
    JSR get_water_level_for_x
    LDY #$01
    LDA water_level_low
    SBC screen_start_square_y_low
    STA zp_various_9c
    LDA water_level
    SBC screen_start_square_y
    BCC L1711
IF SRAM
    cmp #$08
ELSE
    CMP #$04
ENDIF
    BCS L1710
    STA zp_various_9d
    LDA zp_various_9c
    ASL A
    ROL zp_various_9d
    ASL A
    ROL zp_various_9d
    ASL A
    ROL zp_various_9d
    AND #$C0
    ADC #$70
    SEI
    STA water_level_interrupt
    LDA zp_various_9d
IF SRAM
    adc #$07
ELSE
    ADC #$17
ENDIF
    STA water_level_on_screen
    CLI
    RTS
.L1710
    DEY
.L1711
    STY water_level_on_screen
    RTS


; returns A = ?square_sprite = background sprite for square (i.e.,
; 0-63)
;
; Stores orientation flags (%xx000000) in square_orientation.
.determine_background
    LDX #$00
    STX new_object_data_pointer
    STX square_is_mapped_data
    JSR calculate_background
    STA square_sprite
    AND #$C0
    STA square_orientation      ; 
    EOR square_sprite           ; = calculate_background &3f
    CMP #$09
    BCS no_background_object

; is there a hash table point in this square?

    STA zp_various_9d ; background_object_number
    TAY               ; a = 0 - 8
    LDX background_objects_range,Y ; use background_objects_range to
                                   ; determine where to look
    LDA background_objects_x_lookup,X ; in background_objects_x_lookup

; Try to find square_x in the table. The range to search is from
; (background_objects_range-1)[X] (inclusive) to
; background_objects_range[X] (exclusive). To simplify the loop
; condition, use a sentinel: set background_objects_range[X] to
; square_x. Check after the loop whether it was an actual entry that
; was found, or the sentinel.

    PHA                  ; backup value of background_objects_x_lookup
    LDA square_x         
    STA background_objects_x_lookup,X ; push square_x at the end of
                                      ; this range
    LDX background_objects_range_minus_one,Y ; get start index
    DEX                                      ; loop fudge
.L173D
    INX                               ;next item
    CMP background_objects_x_lookup,X ;found square_x?
    BNE L173D                         ;branch taken if square_x not
                                      ;found
    TXA                               ;A = index of entry
    CMP background_objects_range,Y    ;is it the sentinel value?
    BCS no_background_object_in_hash  ;taken if so - i.e., no entry

; data_pointer = square_x + background_objects_data_offset

    ADC background_objects_data_offset,Y 
    STA new_object_data_pointer

; type_pointer = X + background_objects_data_offset + background_objects_type_offset
    CLC
    ADC background_objects_type_offset,Y 
    STA new_object_type_pointer
    
    LDA background_objects_handler_lookup,X
    JMP L1761 ; use_background_object_from_hash
    
.no_background_object_in_hash
    LDX zp_various_9d ; background_object_number
    LDA lookup_for_unmatched_hash,X
    EOR square_orientation
;;  use_background_object_from_hash                                               ; A = handler_lookup if in hash, square_sprite if not
.L1761
    STA square_sprite

; Undo sentinel.

    LDX background_objects_range,Y    
    PLA                               
    STA background_objects_x_lookup,X 

; Separate out orientation and sprite.

    LDA square_sprite
    AND #$C0
    STA square_orientation
    EOR square_sprite
    
.no_background_object
    STA square_sprite
    CMP #$10
    BCS no_objects_to_create ; do we need to create a background
                             ; object?
    TSX
    STX copy_of_stack_pointer   ; store the stack pointer
    TAX
    LDA object_handler_table_h,X
    BIT background_processing_flag ; does background_processing_flag
                                   ; match the background object?
    BEQ L178A                ; if set, call background object handlers
    AND #$0F
    LDY new_object_data_pointer
    JSR handle_background_object
.L178A
    LDA square_sprite
.no_objects_to_create
    RTS
    
;;  First, determine whether we should use mapped data or not
.calculate_background
    LDA square_y
    TAX
    LSR A
    EOR square_x
    AND #$F8
    LSR A
    ADC square_x
    LSR A
    ADC square_y
    STA zp_various_9d    ; f_xy is a function of square_x and square_y
    TXA                  ; A = square_y
    CMP #$79
    BCC L17A8                   ; taken if square_y<0x79
    CMP #$BF
    BCC not_mapped2             ; taken if square_y<0xbf

; before: square_y = 0xc0 ... 0xff
; after:  square_y = 0x7a ... 0xb9

    SBC #$46 ; y >= &c0 ; y -= &46;
    
.L17A8
; A = square_y
    CMP #$48
    BCS L17B2                   ; taken if square_y>=0x48
    CMP #$3E
    BCS not_mapped2             ; taken if square_y>=0x3e

; before: square_y = 0x00 ... 0x3d
; after:  square_y = 0x0a ... 0x47

    ADC #$0A
    
.L17B2
    STA f2_xy                  ; at this point, a function of square_y
    AND #%10101000                   
    EOR #%01101111
    LSR A
    ADC square_x
    EOR #%01100000
    ADC #%00101000
    STA f3_xy     ; f3_xy is another function of square_x and square_y
    AND #%00111000
    EOR #%10100100
    ADC f2_xy
    STA f2_xy              ; f2_xy a function of square_x and square_y
    TAY                    ; A is f2_xy
    EOR #%00101100
    ADC f3_xy                   ; A is a function of f2_xy and f3_xy
    CPY #$20
    BCS not_mapped2             ; taken if f2_xy>=0x20
    CMP #$20
    BCS not_mapped              ; if A >= &20, don't use mapped data
    DEC square_is_mapped_data
    TAY                         ; Y = A = f(f2_xy,f3_xy)
    ASL A
    ASL A
    ASL A
    EOR f2_xy
    STA map_address             ; &a4 = (A * 8) ^ &10;
    TYA                         ; A = Y = f(f2_xy,f3_xy)
    AND #$03
    ADC #HI(map_data)
    STA map_address_high        ; a5 = (A & 3) + &4f;
    LDY #LO(map_data)           ; $EC ; &4fec - &53ec
    LDA (map_address),Y         ; use mapped data
    RTS
.L17EC
    JMP L1937
.via_return_background_empty
    JMP return_background_empty
    
;  If not mapped data, are we on or above the surface?
;
.not_mapped
; A = 
    CMP #$3D
    BCC via_return_background_empty
.not_mapped2
    CPX #$4E ; if square_y < &4e, return empty space
    BCC via_return_background_empty
    BEQ L17EC ; if square_y = &4e, return bushes
    CPX #$4F
    BNE below_surface
    LDA square_x                ; if square_y = &4f, do surface
    CMP #$40
    BEQ return_background_grass_frond ; force (&40, &4f) to be a grass frond
    LDY #$01
    JMP via_background_is_114f_lookup_with_y        ; otherwise, return wall
.return_background_grass_frond
    LDA #$62 ; &62 = grass frond
    RTS
;;  Things get rather hairy below the surface...
.below_surface
    LDY zp_various_9d ; f_xy
    LDA #$00
    STA zp_various_9d
    LDA square_x
    BIT square_y
    BMI L1821
    ADC #$1D
    CMP #$5E
    JMP L1825
.L1821
    ADC #$07
    CMP #$2B
.L1825
    BCC L187C
    TYA
    AND #$E8
    CMP square_y
    BCC L187C
    STY zp_various_9d
    TXA
    ASL A
    ADC square_y
    LSR A
    ADC square_y
    AND #$E0
    ADC square_x
    AND #$E8
    BNE no_mushrooms
    LDA square_y
    BPL via_return_background_empty                     ; no mushrooms if square_y < &80
    LDA square_x
    LSR A
    LSR A
    LSR A
    TAX
.return_background_mushrooms
    LDA #$0E ; &0e = mushrooms (on floor)
    CPX #$0A
    BNE L1851
    LDA #$8E ; &8e = mushrooms (on ceiling)
.L1851
    RTS
.no_mushrooms
    TYA ; Y = f_xy
    LSR A
    LSR A
    AND #$30
    LSR A
    ADC square_x
    LSR A
    EOR square_x
    LSR A
    EOR square_x
    ADC square_x
    AND #$FD
    EOR square_x
    AND #$07
    BNE L1878
    LDA square_x
    BMI L1875
    LSR A
    ADC square_y
    AND #$30
    BEQ L1878
.L1875
    LDA #$08 ; return hash point 8
    RTS
.L1878
    CPX #$52
    BCS L187F
.L187C
    JMP background_is_114f_lookup_with_top_of_9d
.L187F
    TYA
    AND #$68
    ADC square_y
    LSR A
    ADC square_y
    LSR A
    ADC square_y
    AND #$FC
    EOR square_y
    AND #$17
    BNE L18DF
    TYA
    ADC square_x
    AND #$50
    BEQ return_background_empty
    AND square_x
    LSR A
    LSR A
    ADC square_y
    LSR A
    LSR A
    AND #$0F
    CMP #$08
    BCC L18AF
    BIT zp_various_9d
    BVC L18C1
    ORA #$04
    BNE L18C1
.L18AF
    STA zp_various_9c
    EOR #$05
    CMP #$06
    LDA zp_various_9c
    BCS L18C1
    TYA
    LSR A
    ADC square_y
    EOR square_x
    AND #$07
.L18C1
    CLC
    ADC #$1D
    PHA
    JSR some_background_calc_thing
    PLA
    BCC return_background_empty
    TAY
    LDA background_lookup,Y
    LDY square_y
    CPY #$E0
    BNE L18D7
    EOR #$40
.L18D7
    RTS
.return_background_empty
    LDY #$00
.background_is_114f_lookup_with_y
    SEC
    LDA background_lookup,Y
    RTS
.L18DF
    JSR some_background_calc_thing
    BCS background_is_114f_lookup_with_top_of_9d
    CPY #$00
    BEQ background_is_114f_lookup_with_y                ; empty space
    LDA zp_various_9d
    PHA
    STY zp_various_9c
    ROL A
    ROL A
    ROL A
    AND #$01
    ROL A
    TAY
    PLA
    ADC square_x
    ROL A
    EOR square_y
    AND #$1A
    BNE L1913
    TYA
    LDY zp_various_9c
    EOR background_lookup+7,Y
    AND #$7F
    CMP #$40
    ROL A
    AND #$07
    TAX
    LDA background_lookup+17,X
    EOR background_lookup+7,Y
    RTS
.L1913
    LDA background_lookup+13,Y
    LDY zp_various_9c
    EOR background_lookup+7,Y
    RTS
.background_is_114f_lookup_with_top_of_9d
    LDA zp_various_9d
    LSR A
    LSR A
    LSR A
    AND #$0E
    LSR A
    ADC #$01
    TAY
.via_background_is_114f_lookup_with_y
    JMP background_is_114f_lookup_with_y
.L192A
    ADC square_x
    ROL A
    ROL A
    ROL A
    AND #$02
    ADC #$19
    TAY
    JMP background_is_114f_lookup_with_y
.L1937
    LDY #$19
    LDA square_x
    LSR A
    ADC square_x
    AND #$17
    BNE L192A
    ROR zp_various_9d
    ROR A
    RTS
.some_background_calc_thing
    TXA
    LSR A
    EOR square_y
    AND #$06
    BNE L1971
    TYA
    LDY #$02
    AND #$20
    ASL A
    ASL A
    EOR #$E5
    STA L1961 ; self modifying code
    BMI L195E
    LDY #$04
.L195E
    TXA
    ADC #$16
.L1961
    ADC square_x
    AND #$5F
    TAX
    DEX
    CPX #$0C
    BCC L19A3
    BEQ L19A5
    INY
    INX
    BEQ L19A5
.L1971
    LDA square_x
    LSR A
    LSR A
    LSR A
    LSR A
    BCS L19A2
    LDA #$01
    ADC square_x
    ADC square_y
    AND #$8F
    CMP #$01
    BEQ L19A3
    TAX
    SEC
    LDA square_y
    SBC square_x
    AND #$2F
    CMP #$01
    BEQ L19A3
    LDY #$02
    CMP #$02
    BEQ L19A5
    INY
    BCC L19A5
    INY
    CPX #$02
    BEQ L19A5
    INY
    BCC L19A5
.L19A2
    RTS
.L19A3
    LDY #$00
.L19A5
    CLC
.L19A6
    RTS
.funny_table_19a7
    equb $01,$0C,$04
.player_east_of_76
    equb $00
.ship_moving
    equb $00
.weight_when_held
    equb $02,$02,$03,$04,$04,$05,$06
.can_player_support_held_object
    equb $00
.collided_in_last_cycle
    equb $00
.player_teleporting_flag
    equb $00
.main_loop
    LSR whistle1_played         ; reset whistle1
    INC loop_counter            ; increment loop counter
    LDA loop_counter
    LDY #$FF
    LDX #$05
    ;;  loop_counter_every_loop                                                     ; calculate loop_counter_every_* based on bits of loop_counter
.L19C0
    LSR A
    BCC L19C4
    INY                   ; loop_counter_every_X is &ff every X counts
.L19C4
    STY loop_counter_every_40,X
    DEX
    BPL L19C0 ; loop_counter_every_loop
    JSR process_screen_background_flash
    JSR process_objects
    JSR process_events
    LDX #$02
.L19D4
    LDA red_mushroom_daze-1,X   ; decrease mushroom_daze if not zero
    BEQ L19DC
    DEC red_mushroom_daze-1,X
.L19DC
    DEX ; for both red and blue dazes
    BPL L19D4
    LDA explosion_timer         ; increase explosion_timer if not zero
    BEQ L19E7
    INC explosion_timer
.L19E7
    JMP main_loop               ; go round the loop again
.handle_background_object
    TSX
    STX copy_of_stack_pointer
    LDX square_sprite
    BPL L19F5    ; we've already got A and calculated h of our handler
.handle_current_object
    TAX
    LDA object_handler_table_h,X ; Calculate address of object handler
.L19F5
    PHA
    LDA object_handler_table,X
    CLC
    ADC #LO(handlers_start-1)   ; -1 to account for RTS logic
    TAX
    PLA
    AND #$3F
    ADC #HI(handlers_start-1)   ; -1 to account for RTS logic
    PHA                     ; high = ((&0432, type + &14)) & 3f) + &3e
    TXA
    PHA                         ; low = (&03b9, type + &14) + &1a
    LDX this_object_data
    TXA
    CPY #$00
    RTS ; Call the object handler we've put on stack
.process_objects
    LDX #$00 ; start with object 0
.L1A0D
    STX current_object
    LDA object_stack_y,X        ; is there an object here?
    BNE process_object          ; if so, process it
    JMP next_object
.process_object
    STA this_object_y ; pull object's details from object stack into registers
    STA this_object_y_old ; keeping a copy of them before they're changed
    LDA object_stack_flags,X
    STA this_object_flags
    STA this_object_flags_old
    STA this_object_angle
    ASL A
    STA this_object_flags_lefted
    LDA object_stack_x,X
    STA this_object_x
    STA this_object_x_old
    LDA object_stack_x_low,X
    STA this_object_x_low
    STA this_object_x_low_old
    LDA object_stack_vel_y,X
    STA this_object_vel_y
    STA this_object_vel_y_old
    LDA object_stack_vel_x,X
    STA this_object_vel_x
    STA this_object_vel_x_old
    LDA object_stack_y_low,X
    STA this_object_y_low
    STA this_object_y_low_old
    LDA object_stack_sprite,X
    STA this_object_sprite
    STA this_object_sprite_old
    LDA object_stack_palette,X
    STA this_object_palette
    STA this_object_palette_old
    LDA object_stack_type,X
    STA this_object_type
    LDA object_stack_data_pointer,X
    STA this_object_data_pointer
    LDA object_stack_target,X
    STA this_object_target
    STA this_object_target_old
    AND #$1F
    STA this_object_target_object
    LDA object_stack_tx,X
    STA this_object_tx
    LDA object_stack_energy,X
    STA this_object_energy
    LDA object_stack_ty,X
    STA this_object_ty
    LDA object_stack_supporting,X
    STA this_object_supporting
    LDA object_stack_extra,X
    STA this_object_extra
    LDA object_stack_timer,X
    STA this_object_timer
    STA this_object_timer_old
    LDA current_object        ; calculate current_object_rotator[_low]
    ASL A
    ASL A
    ASL A
    ASL A
    ORA current_object
    ADC loop_counter         ; current_object * 17 + loop_counter, ie:
    STA current_object_rotator ; random number from &00-&ff, unique for each object
    AND #$0F
    STA current_object_rotator_low ; random number from &00-&0f, unique for each object
    LDA this_object_x
    JSR get_water_level_for_x   ; calculate water_level
    LDY current_object
    CPY whistle2_played
    BNE not_being_used
    ROR whistle2_played         ; reset whistle2_played
.not_being_used
    JSR get_object_gravity_flags ; get_object_weight ; calculate object weight
    STA this_object_weight
    CMP #$07 ; is the object affected by gravity?
    ROR object_affected_by_gravity
    BPL no_anti_gravity
    JSR zero_velocities         ; if not, zero its y velocity
.no_anti_gravity
    LDX this_object_sprite
    LDA sprite_width_lookup,X
    AND #$F0
    STA this_object_width       ; calculate sprite sizes for object
    LDA sprite_height_lookup,X
    AND #$F8
    STA this_object_height
    LDX #$00
    STX acceleration_x          ; reset object accelerations to 0
    STX acceleration_y
    STX gun_aim_acceleration    ; reset gun_aim_acceleration to 0
    STX object_collision_with_other_object_top_bottom
    STX object_collision_with_other_object_sides
    STX wall_collision_frict_y_vel
    STX child_created           ; reset child_created to 0
    STX wall_collision_angle
    DEX
    STX something_about_player_angle
    STX object_is_invisible     ; objects are not invisible by default
    JSR move_object             ; move object using current velocities
    LDX current_object
    BNE not_player              ; is this the player?
    LDY object_held             ; if so, are we holding something?
    BMI not_player
    JSR get_object_gravity_flags ; get_object_weight
    TAY
    LDA weight_when_held,Y
    STA this_object_weight      ; increase our weight to match
    LDX current_object
.not_player
    CPX object_held
    BNE not_held_object ; is this object being held? if so, put next to us
    LDX object_stack_sprite     ; player sprite
    LDA sprite_height_lookup,X
    SEC
    SBC this_object_height    ; half player height minus object height
    PHP
    ROR A
    EOR #$80
    AND #$F8
    ADC object_stack_y_low      ; player y_low
    STA this_object_y_low       ; set object y_low to match
    STA held_object_y_low
    LDA object_stack_y          ; player y
    ADC #$00
    PLP
    SBC #$00
    STA this_object_y           ; set object y to match
    STA held_object_y
    LDA sprite_width_lookup,X
    ADC #$0F
    LDX #$00
    BIT object_stack_flags      ; player flags
    BPL L1B33                   ; are we facing left?
    LDA this_object_width
    ADC #$10                    ; if not, add player width to x_low
    DEX
    JSR make_positive
.L1B33
    CLC
    ADC object_stack_x_low      ; player x_low
    STA this_object_x_low       ; set object x_low to match
    STA held_object_x_low
    TXA
    ADC object_stack_x          ; player x
    STA this_object_x           ; set objects x to match
    STA held_object_x
    LDY #$00 ; get player velocities
    JSR get_object_velocities   ; set object velocities to match
    LDA object_stack_flags      ; get player flags
    STA this_object_angle       ; set object flags_copy2 to match
.not_held_object
    JSR calculate_object_maxes
    BIT object_affected_by_gravity ; is the object static?
    BMI static_object
    JSR determine_what_supporting
    LDY current_object
    BNE not_player2             ; is this the player?
    LDA wall_collision_angle
    SBC player_angle
    SBC #$40
    JSR make_positive
    LSR A
    LSR A
    ADC #$C0
    ADC wall_collision_frict_y_vel
    BCC not_player2
    LSR A
    JSR damage_object        ; take damage from colliding with scenery
    STA this_object_energy
.not_player2
    LDA wall_collision_bottom_minus_top
.L1B74
    ORA object_collision_with_other_object_top_bottom
    STA any_collision_top_bottom
    LDA object_collision_with_other_object_top_bottom
    ASL A
    ORA wall_collision_top_minus_bottom ; wall_collision_count_bottom
    STA wall_collision_top_minus_bottom ; wall_collision_count_bottom
    LSR collided_in_last_cycle
    LDA this_object_flags
    AND #$FD
    STA this_object_flags
    BIT wall_collision_top_minus_bottom ; wall_collision_count_bottom
    BMI L1B98
    BIT any_collision_top_bottom
    BPL static_object
    ORA #$02 ; set flags & &02 if a collision has occurred
    STA this_object_flags
    BNE static_object
.L1B98
    LDA this_object_flags_old
    AND #$02
    BEQ static_object
    SEC
    ROR collided_in_last_cycle                      ; set if a collision occurred last cycle
    LDX #$00
    LDA wall_collision_count_right
    CMP wall_collision_count_left
    BEQ static_object                               ; have there been side collisions?
    PHP
    LDA #$10
    PLP
    JSR make_positive                               ; if so, alter x velocity accordingly
    JSR move_object_in_one_direction_with_given_velocity
    JSR calculate_object_maxes
.static_object
    LDY this_object_type
    LDA object_gravity_flags,Y
    STA number_particles_OR_this_object_gravity_flags
    ASL A
    STA this_object_offscreen
    ASL A
    AND #$C0
    ASL A
    ROL A
    ROL A
    BEQ L1BF9
    TAX
    CPX #$02
    BNE L1BDB
    JSR get_biggest_velocity
    CMP #$05
    ROR A
    EOR #$80
    AND any_collision_top_bottom
    BPL L1BDB
    INX
.L1BDB
    LDY L19A6,X ; # actually funny_table_19a7
    LDA current_object_rotator_low
    AND #$03
    CMP #$03
    BCC L1BF9
    LDA this_object_flags
    AND #$14
    CLC
    BNE L1BF9
    LDA number_particles_OR_this_object_gravity_flags
    AND #$08
    AND player_teleporting_flag
    BNE L1BF9
    JSR is_object_offscreen
.L1BF9
    ROR this_object_offscreen
    LDA this_object_flags
    AND #$10 ; is the object teleporting?
    BEQ not_teleporting
    LDA this_object_timer
    BEQ L1C3E
    CMP #$11
    BNE not_player3
    STA this_object_y
    LDX current_object
    BNE not_player3                                 ; is it the player?
    DEX
    STX player_teleporting_flag
.not_player3
    CMP #$10 ; half way through the teleport, change the square
    BNE no_teleport_square_change
    LDX current_object
    BNE not_player4                                 ; is it the player?
    STX player_teleporting_flag
.not_player4
    LDX #$02 ; in y direction first (X = 2), then x direction (X = 0)
.L1C20
    LDA this_object_width,X ; X = 2, &3c = this_object_height ; X = 0, &3a = this_object_width
    EOR #$FF
    LSR A
    STA this_object_x_low,X ; X = 2, &51 = this_object_y_low ; X = 0, &4f = this_object_x_low
    LDA this_object_tx,X ; X = 2, &16 = this_object_ty ; X = 0, &14 = this_object_tx
    STA this_object_x,X ; X = 2, &55 = this_object_y ; X = 0, &53 = this_object_x
    DEX
    DEX
    BPL L1C20
    JSR zero_velocities
    JSR play_sound                                  ; teleporting noise
    equb $33,$F3,$63,$F3; sound data
.no_teleport_square_change
    DEC this_object_timer                             ; decrement timer for teleporting object
    JMP L1D2E
.L1C3E
    LDA this_object_flags
    AND #$EF
    STA this_object_flags
    JSR gain_one_energy_point
.not_teleporting
    LDA this_object_y
    CMP #$4F ; is the object below y = &4f;
    BCS no_wind                                     ; if so, there's no wind
    LDA #$00
    STA velocity_x
    STA velocity_y
    LDA this_object_y                                 ; consider wind for (y - &4e) first
    SBC #$4E
    LDX #$02
.wind_loop
    LDY this_object_weight
    INY
    ROR zp_various_9d
    JSR make_positive_cmp_0
    CMP #$1E
    BCC L1C87
    CMP #$32
    BCC L1C6F
    DEY
    CMP #$3C
    BCC L1C6F
    DEY
.L1C6F
    SBC #$08
    ASL A
    BPL L1C78
    DEY
    DEY
    LDA #$7F
.L1C78
    INY
    BPL L1C7D
    LDY #$00
.L1C7D
    BIT zp_various_9d
    JSR make_positive
    STA velocity_x,X ; # X = 2, &b6 velocity_y; X = 0, &b4 velocity_x
    JSR L3F94
.L1C87
    LDA this_object_x                                 ; consider wind for (x - &9b) next
    SBC #$9B
    DEX
    DEX
    BEQ wind_loop
    JSR do_wind_motion
.no_wind
    LDX this_object_data_pointer ; ; this_object_data_pointer
    LDA background_objects_data,X ; object_data
    STA this_object_data
    LDA this_object_type
    CLC
    ADC #$14
    LDY this_object_supporting
    JSR handle_current_object                       ; call object handler
    LDX current_object
    CPX object_held
    BNE not_held_object2                            ; is this object being held?
    LDX #$02
.L1CAB
    LDA held_object_x_low,X
    SBC this_object_x_low,X
    PHP
    ADC #$30
    TAY
    LDA held_object_x,X                               ; has its position shifted too much?
    ADC #$00
    PLP
    SBC this_object_x,X
    BNE L1CC0
    CPY #$60
    BCC L1CC6
.L1CC0
    JSR drop_object                                 ; if so, drop it
    JSR copy_object_values_from_old
.L1CC6
    DEX
    DEX
    BEQ L1CAB
    LDA this_object_supporting                  ; is it supporting something?
    BEQ L1CD7
    TAX
    LDY object_stack_type,X                         ; type of supporting object
    ORA object_gravity_flags,Y
    EOR #$80
.L1CD7
    ORA wall_collision_top_or_bottom
    STA can_player_support_held_object
    BPL not_held_object2
    LDY #$00 ; set player velocities
    JSR set_object_velocities
.not_held_object2
    LDA this_object_energy                              ; has it got energy
    BNE not_exploding
    LDY this_object_type                                ; explosion time!
    LDA object_handler_table_h+20,Y ; object_handler_table_h                    ; object_handler_table_h &c0 determines explosion type
    AND #$C0
    ASL A
    ROL A
    ROL A
    ADC #$10
    JSR handle_current_object                       ; call explosion handler
.not_exploding
    JSR increment_timers
    LSR A
    LSR A
    ORA #$01
    CMP red_mushroom_daze
    ROR A
    EOR #$FF
    ORA object_is_invisible
    STA object_is_invisible                           ; invisible objects are visible when dazed
    LDY this_object_type
    LDA object_gravity_flags,Y
    AND #$18
    BEQ L1D2B
    TAX
    LDA this_object_data
    JSR is_this_object_marked_for_removal
    BCS L1D26
    BIT this_object_offscreen                           ; is it offscreen?
    BPL L1D26
    CPX #$10
    BEQ L1D24 ; mark_offscreen
    CLC
    ADC #$04
    equb $2C; BIT &xxxx
;;  mark_offscreen                                                                ; if so, mark it as such:
.L1D24
    ORA #$80 ; &80 in data is offscreen
.L1D26
    LDX this_object_data_pointer
    STA background_objects_data,X ; object_data
.L1D2B
    JSR accelerate_object                           ; accelerate object
.L1D2E
    LDX current_object
    CLC
    BEQ is_player
    JSR is_this_object_marked_for_removal
    BCS not_marked_for_removal                      ; if the object is marked for removal
    BIT this_object_offscreen
    BPL is_player
    BVS not_marked_for_removal
    JSR copy_object_onto_secondary_stack            ; move it to the secondary stack
.not_marked_for_removal
    LDA current_object
    JSR stop_supporting_objects                     ; stop other objects resting on it
    TAX
    LDA #$00
    CPX player_object_number
    BNE L1D51 ; is it the player? if not
    STA always_zero
.L1D51
    STA this_object_x
    STA this_object_y                                 ; remove it
    CPX object_held
    BNE L1D5B ; were we holding it?
    ROR object_held                                   ; if so, forget it
.L1D5B
    SEC
.is_player
    BIT object_is_invisible
    BMI L1D61 ; is the object invisible?
    SEC ; set if so, or being removed
.L1D61
    LDA this_object_flags_old
    ROR A
    ROR A
    AND #$C0
    STA zp_various_9c
    LSR A
    LSR A
    ORA zp_various_9c
    STA skip_sprite_calculation_flags
    LDA this_object_angle
    ASL A
    LDA this_object_flags_lefted
    ROR A
    AND #$C0
    STA this_object_flipping_flags
    LDA this_object_flags
    AND #$C0
    STA this_object_flipping_flags_old
    EOR this_object_flags
    EOR this_object_flipping_flags
    AND #$F3
    STA this_object_flags
;;  Push the object's details back into the object stack
    LDA this_object_y
    STA object_stack_y,X
    LDA this_object_x
    STA object_stack_x,X
    LDA this_object_x_low
    STA object_stack_x_low,X
    LDA this_object_vel_y
    STA object_stack_vel_y,X
    LDA this_object_vel_x
    STA object_stack_vel_x,X
    LDA this_object_flags
    STA object_stack_flags,X
    LDA this_object_y_low
    STA object_stack_y_low,X
    LDA this_object_sprite
    STA object_stack_sprite,X
    LDA this_object_palette
    STA object_stack_palette,X
    LDA this_object_type
    STA object_stack_type,X
    LDA this_object_data_pointer ; ; this_object_data_pointer
    STA object_stack_data_pointer,X
    LDA this_object_target
    AND #$E0
    ORA this_object_target_object
    STA object_stack_target,X
    LDA this_object_tx
    STA object_stack_tx,X
    LDA this_object_energy
    STA object_stack_energy,X
    LDA this_object_ty
    STA object_stack_ty,X
    LDA this_object_supporting
    ORA #$80
    STA object_stack_supporting,X
    LDA this_object_extra
    STA object_stack_extra,X
    LDA this_object_timer
    STA object_stack_timer,X
    CPX player_object_number
    BNE L1DFA
IF SRAM
    cpx M14E1
    beq M1E1F
    lda M14E1
    sta player_object_number
    sec
    ROR M1191
.M1E1F
ENDIF
    JSR focus_on_player_maybe
    JSR refocus_on_player
    JSR redraw_screen
    LDX #$00
    STX can_we_scroll_screen
.L1DFA
    JSR plot_object
    CPX player_object_number
    BNE next_object ; is it the player?
    JSR plot_background_strip_from_cache            ; if so, process some other things too
    JSR scroll_screen
    JSR particle_evolution
    JSR consider_objects_on_secondary_stack
    LDX current_object
.next_object
    INX
    CPX #$10 ; sixteen objects
    BCS L1E18
    JMP L1A0D ; loop for next one
.L1E18
    RTS
.swap_direction
    LDA #$80
    EOR player_facing
    STA player_facing
    RTS
.get_object_gravity_flags
    LDA #$07
.get_object_gravity_flags_arbitrary_and
    LDX object_stack_type,Y
    AND object_gravity_flags,X
    RTS
.stop_supporting_objects
    LDX #$0F ; starting at the last object
.L1E2B
    CMP object_stack_supporting,X                   ; are we touching object A?
    BNE L1E33
    ROR object_stack_supporting,X                   ; stop supporting object
.L1E33
    PHA
    EOR object_stack_target,X                       ; is supporting = target?
    AND #$1F
    BNE L1E3F
    TXA
    STA object_stack_target,X                       ; stop targetting object A too
.L1E3F
    PLA
    DEX ; repeat for all sixteen objects
    BPL L1E2B
    RTS
.water_orientation_lookup
    equb $00,$80,$07,$70
.pixel_table
;                                 ABCDEFGH
equb $00                        ; 00000000 0  0  
equb $03                        ; 00000011 1  1  
equb $0C                        ; 00001100 2  2  
equb $0F                        ; 00001111 3  3  
equb $30                        ; 00110000 4  4  
equb $33                        ; 00110011 5  5  
equb $3C                        ; 00111100 6  6  
equb $3F                        ; 00111111 7  7  
equb $C0                        ; 11000000 8  8  
equb $C3                        ; 11000011 9  9  
equb $CC                        ; 11001100 10 10
equb $CF                        ; 11001111 11 11
equb $F0                        ; 11110000 12 12
equb $F3                        ; 11110011 13 13
equb $FC                        ; 11111100 14 14
equb $FF                        ; 11111111 15 15
.number_of_particles
    equb $FF
.number_of_particles_x8
    equb $F8
.reserve_object_high_priority
    LDY #$00
    equb $2C; BIT &xxxx
.reserve_object
    LDY #$01
    equb $2C; BIT &xxxx
.reserve_object_low_priority
    LDY #$04
;;  A = type of object to create
;;  Y = number of slots that must be free for success
;;  &53 = x
;;  &55 = y
.reserve_objects
    STA reserve_object_in_this_slot+1 ; store desired object type
    STX L1EFE+1 ; ensure we leave with X unchanged
    TYA
    TAX
    BNE reserve_object_not_y_0                  ; Y = 0 is special
    STY objects_to_reserve
    STY objects_two_reserve
    LDY #$0F ; sixteen objects
.L1E72
    CPY current_object
    BEQ L1E95 ; keep looking if it's the current object
    LDA object_stack_y,Y                               ; is this slot free?
    BEQ reserve_object_in_this_slot                     ; if so, use it
    LDA #$50
    JSR get_object_gravity_flags_arbitrary_and
    CMP #$40
    BNE L1E95 ; keep looking if gravity_flags & &50 != &40
    LDA object_stack_flags,Y
    ROR A
    BCC L1E95
    JSR L355B
    CMP objects_to_reserve
    BCC L1E95
    STA objects_to_reserve
    STY objects_two_reserve
.L1E95
    DEY ; consider next one
    BNE L1E72
    SEC
    LDY objects_two_reserve
    BEQ L1EFE ; no free slots leave, unsuccessful
    LDA #$08
    JSR get_object_gravity_flags_arbitrary_and
    BEQ L1EAF
    LDX object_stack_data_pointer,Y
    LDA background_objects_data,X
    ADC #$03
    STA background_objects_data,X
.L1EAF
    TYA
    JSR stop_supporting_objects
    BMI reserve_object_in_this_slot
.reserve_object_not_y_0
    LDY #$00
.L1EB7
    INY
    CPY #$10 ; sixteen objects
    BCS L1EFE ; if no free slots, leave with C set
    LDA object_stack_y,Y                               ; is this slot free?
    BNE L1EB7 ; if not, keep searching
    DEX ; have we found our quota of free slots? this counts as one
    BNE L1EB7 ; if not, keep searching
.reserve_object_in_this_slot
    LDX #$00 ; actually LDX #object_type, from &1ec5
    LDA object_sprite_lookup+101,X ; object_palette_lookup
    AND #$7F
    STA object_stack_palette,Y                   ; store palette & &7f
    LDA object_sprite_lookup,X
    STA object_stack_sprite,Y                     ; store sprite
    LDA #$05
    STA object_stack_flags,Y                       ; store flags = 5
    LDA #$FF
    STA object_stack_supporting,Y                     ; supporting nothing
    TYA
    STA object_stack_target,Y                     ; store target = object's own number
    LDA #$00
    STA object_stack_data_pointer,Y
    STA object_stack_extra,Y
    STA object_stack_timer,Y                       ; store timer = 0
    STA object_stack_vel_x,Y                       ; store x velocity = 0
    STA object_stack_vel_y,Y                       ; store y velocity = 0
    TXA
    STA object_stack_type,Y                         ; store object_type
    JSR lookup_and_store_object_energy
    JSR store_object_x_y_in_stack                       ; store &53 in x, &55 in y
    CLC
.L1EFE
    LDX #$00 ; actually LDX #original_X, from &1e65
    RTS
.accelerate_object
    LDX #$02 ; X = 2, then X = 0
.L1F03
    CPX #$02
    LDA acceleration_x,X ; X = 2, &42 = acceleration_y ; X = 0, &40 = acceleration_x
    PHP
    ADC this_object_vel_x,X ; X = 2, &45 = this_object_vel_y ; X = 0, &43 = this_object_vel_x
    JSR prevent_overflow
    TAY
    PLP
    JSR make_positive
    SBC #$3F
    CMP #$40
    BCS L1F2A
    LDY this_object_vel_x,X ; X = 2, &45 = this_object_vel_y ; X = 0, &43 = this_object_vel_x
    TYA
    JSR make_positive
    CMP #$40
    BCS L1F2A
    LDA #$40
    CPY #$00
    JSR make_positive
    TAY
.L1F2A
    BIT loop_counter_every_10
    BPL L1F36
    TYA
    BEQ L1F36
    BPL L1F34+1
    INY
.L1F34
    CMP #$88
.L1F36
    STY this_object_vel_x,X ; X = 2, &45 = this_object_vel_y ; X = 0, &43 = this_object_vel_x
    DEX
    DEX
    BPL L1F03
    RTS
.create_jetpack_thrust
    LDA acceleration_x
    ORA acceleration_y
    BEQ L1F91     ; leave if we're not accelerating (??why not the RTS
                  ; immediately below??)
    LDA #$ED
    LDY this_object_sprite
    CPY #$02
    BCS L1F4D
    LDA #$EB
.L1F4D
    STA particle_flags_table+particles_jetpack_thrust ; for jetpack
                                                      ; thrust - set
                                                      ; flags to &ed
                                                      ; or &eb
                                                      ; depending on
                                                      ; orientation of
                                                      ; player
    LDY #$0B ; &0b = jetpack thrust particles
    JSR add_particle                            ; jetpack thrust
    LDA #$FF
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.scroll_screen
{
    LDA can_we_scroll_screen
    BNE L1F91 ; if not, leave
    DEC can_we_scroll_screen                        ; don't scroll again until we've redrawn objects
.L1F60
    LDA palette_register_updating
    CMP #$02
    BCC L1F60
    LDA #$00
    STA palette_register_updating
}
.set_screen_start_address
{
    PHP
    SEI
    LDA screen_offset
    STA zp_various_9c
    LDA screen_offset_h
    LSR A
    ROR zp_various_9c           ; screen_offset/2
    LSR A
    ROR zp_various_9c           ; screen_offset/4
    LSR A
    ROR zp_various_9c           ; screen_offset/8
    ADC #screen_base_page>>3    ; ($6000+screen_offset)/8
    ; set 6845 address
    LDY #12
    STY $FE00                   ; set r12
    STA $FE01
    LDA zp_various_9c
    INY
    STY $FE00                   ; set r13
    STA $FE01                   
    PLP
}
.L1F91
    RTS

.flash_screen_background
    LDY #$0B ; screen flashes for &0b cycles
    STY screen_background_flash_counter
    RTS
.process_screen_background_flash
    LDY screen_background_flash_counter         ; is the background flashing?
    BEQ L1F91 ; if not, leave
    DEC screen_background_flash_counter
    BEQ L1FA6 ; if the counter has run out, use &07
    JSR increment_timers
    AND #$20
    BEQ L1FA8 ; otherwise use either &07 or &00 at random
.L1FA6
    LDA #$07 ; &07 = colour 0 black; &00 = colour 0 white
.L1FA8
    STA palette_register_data                           ; and store it in the palette register table
    INC palette_register_data_updated           ; force it to be refreshed
    RTS
.is_it_supporting_anything_collidable
    LDY this_object_supporting                        ; are we touching anything?
    BMI L1FC7 ; if not, leave
    LDA object_stack_type,Y
    CMP #$44 ; is it an explosion? (&44)
    BEQ L1FC5 ; if so, leave
    CMP #$40 ; is it a bush? (&40)
    BEQ L1FC5 ; if so, leave
    SEC
    SBC #$25
    CMP #$02 ; or &25 - &26 ; clawed robot or triax
    BCS L1FC7 ; if not, return object number
.L1FC5
    LDY #$FF
.L1FC7
    TYA
    RTS
.does_it_collide_with_bullets_2
    JSR convert_object_to_range
    CPX #$04 ; is it range 4? (grenades and bullets)
    BEQ L1FDA ; if so, no collision
.does_it_collide_with_bullets
    CMP #$40 ; is it a bush? (&40)
    BEQ L1FDA ; if so, no collision
    CMP #$44 ; is it an explosion? (&44)
    BEQ L1FDA ; if so, no collision
    CMP #$37 ; is it a fireball? (&37)
.L1FDA
    RTS ; if so, no collision

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.plot_pixel
; divide by 8 to get screen character row

    LDA pixel_y_low       ; calculate the screen address for the pixel

    LSR pixel_y
    ROR A                       ; Y/2
    LSR pixel_y
    ROR A                       ; Y/4
    LSR pixel_y
    ROR A                       ; Y/8
    TAX
    AND #$07
    TAY                         ; Y=line in character row
    LDA pixel_x_low
    AND #%11100000
    ADC screen_start_square_x_low_copy
    STA screen_address
    TXA                         ; get Y coordinate
    AND #%11111000              ; 
    EOR pixel_x
    ADC some_screen_address_offset
    ROR A
    ROR screen_address
    LSR A
    ROR screen_address
    LDX velocity_signs_OR_pixel_colour
.L2001
    ORA #screen_base_page
    STA screen_address+1
.L2005
    LDA pixel_x_low
    AND #$10
    CMP #$10
    LDA #$AA ; &aa = left hand pixel
    BCC L2010 ; or
    LSR A ; &55 = right hand pixel
.L2010
    AND pixel_table,X
    EOR (screen_address),Y ; eor with what's already on screen
    STA (screen_address),Y ; plot pixel on screen
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.L2018
    DEY
    BPL L2005
    INY
    LDA screen_address
    SBC #$F8
    STA screen_address
    LDA screen_address+1
    SBC #$01
    BPL L2001
.plot_particle_in
    STA velocity_signs_OR_pixel_colour
.plot_particle_in_2
    SEC
    LDA particle_stack_x_low,X    ; get particle X
    SBC screen_start_square_x_low ; 
    STA pixel_x_low
    LDA particle_stack_x,X
    SBC screen_start_square_x
    CMP #$08 ; is the particle off the edge of the screen?
    BCS L207D ; if so, leave
    STA pixel_x
    LDA particle_stack_y_low,X
    SBC screen_start_square_y_low
    AND #$F8
    TAY
    LDA particle_stack_y,X
    SBC screen_start_square_y
    STA pixel_y
    BNE L2057
    CPY #$00
    BNE L2057
    BIT zp_various_a3
    BMI L2077
    RTS
.L2057
IF SRAM
    cmp #$08
ELSE
    CMP #$04
ENDIF
    BCC L2063
    BNE L207D
    CPY #$00
    BEQ L206D
    BCS L207D
.L2063
    STY pixel_y_low
    JSR plot_pixel
    BIT zp_various_a3
    BVS L2018
    RTS
.L206D
    BIT zp_various_a3
    BVC L207D
    BPL L207D
    DEC pixel_y
    LDY #$F8
.L2077
    STY pixel_y_low
    JSR plot_pixel
    SEC
.L207D
    RTS
.particle_evolution
    LDX number_of_particles
    BMI L207D                   ; leave if no particles
    LDA #$38                    ; SEC
    STA L2122                   ; &2122 = SEC
    LDA #$4C                    ; JMP $xxxx
    STA L215A                   ; &215a = JMP &2122
    LDA screen_start_square_x
    JSR get_water_level_for_x
    LDX number_of_particles_x8
.L2095
    STX zp_various_9e
    LDA particle_stack_type,X
    STA zp_various_a3
    AND #$07
    JSR plot_particle_in
    LDX zp_various_9e
    BCS L2116
    LDA zp_various_a3
    AND #$10
    BEQ L20D3
    LDY #$01
    LDA particle_stack_y,X
    CMP water_level
    BCC L20CA
    BNE L20BF
    LDA particle_stack_y_low,X
    CMP water_level_low
    BCC L20CA
.L20BF
    LDY #$FD
    JSR increment_timers
    AND #$07
    ORA #$06
    STA velocity_signs_OR_pixel_colour
.L20CA
    TYA
    ADC particle_stack_velocity_y,X
    BVS L20D3
    STA particle_stack_velocity_y,X
.L20D3
    LDA zp_various_a3
    AND #$F7
    CMP zp_various_a3
    BCS L20E1
    ADC #$01
    AND #$07
    STA velocity_signs_OR_pixel_colour
.L20E1
    DEC particle_stack_ttl,X
    BEQ L213A
.L20E6
    LDY #$01
.L20E8
    CLC
    LDA particle_stack_velocity_x,X
    PHA
    ADC particle_stack_x_low,X
    STA particle_stack_x_low,X
    BCC L20F8
    INC particle_stack_x,X
.L20F8
    PLA
    BPL L20FE
    DEC particle_stack_x,X
.L20FE
    INX
    DEY
    BEQ L20E8
    LDX zp_various_9e
    LDA zp_various_a3
    AND #$F8
    ORA velocity_signs_OR_pixel_colour
    STA particle_stack_type,X
    AND #$7F
    STA zp_various_a3
    JSR plot_particle_in_2
    LDX zp_various_9e
.L2116
    BCS L213A
    AND #$C0
    BEQ L2122
    LDA zp_various_a3
    AND #$20
    BEQ L2135
.L2122
    SEC
    TXA
    SBC #$08
    TAX
    BCC L212C
    JMP L2095
.L212C
    LDA #$60                    ; RTS
    STA L2122                   ; &2122 = RTS
    STA L215A                   ; &215a = RTS
    RTS
.L2135
    JSR plot_particle_in_2
    LDX zp_various_9e
.L213A
    LDY number_of_particles_x8
.L213D
    LDA particle_stack,Y ; particle_stack_velocity_x
    STA particle_stack,X ; particle_stack_velocity_x
    INY
    INX
    TXA
    AND #$07
    BNE L213D
    LDX zp_various_9e
    SEC
    LDA number_of_particles_x8
    SBC #$08
    STA number_of_particles_x8
    DEC number_of_particles
    BMI L212C
.L215A
; sometimes overwritten with a JMP
    RTS
    equw L2122                  ; JMP target
.add_particle_to_stack
    LDX number_of_particles
    CPX #$1F
    BEQ L2174
    INX
    STX number_of_particles
    TXA
    ASL A
    ASL A
    ASL A
    STA number_of_particles_x8
    STA zp_various_9e
    TAX
    BCC L218B
.L2174
    LDA timer_2
    AND #$F8
    TAX
    STX zp_various_9e
    LDA particle_stack+7,X ; particle_stack_type
    ORA #$80
    STA zp_various_a3
    AND #$07
    JSR plot_particle_in
    LDX zp_various_9e
    LDY find_carry
.L218B
    RTS
.add_particle
    LDA #$01
.add_particles
    STY find_carry ; particle_type
    STA number_particles_OR_this_object_gravity_flags ; number_of_particles
    LDA particle_flags_table,Y
    STA zp_various_a0 ; particle_flags
    AND #$20
    BEQ L21A5
    LDX #$06
.L219D
    LDA this_object_x-4,X ; X = 6, &55 = this_object_y ; X = 4, &53 = this_object_x 
    STA this_object_x_centre_OR_particle_x-4,X ; X = 6, &8d = particle_y ;  X = 4, &8b = particle_x 
    DEX
    DEX
    BPL L219D
.L21A5
    LDA screen_start_square_x
    CLC
    SBC this_object_x_centre_OR_particle_x
    SEC
    SBC #$01
    CMP #$F6
    BCC L218B
    LDA this_object_y_centre_OR_particle_y
    SBC screen_start_square_y
    CLC
    ADC #$01
IF SRAM
    cmp #$0a
ELSE
    CMP #$06
ENDIF
    BCS L218B
    BIT zp_various_a0 ; particle_flags
    BPL L21D7 ; if flags & &80, then:
    LDX #$40 ; use velocity if flags & &40
    BVS L21C6
    LDX #$43 ; use acceleration
.L21C6
    LDA square_is_mapped_data,X
    STA velocity_x
    LDA intro_two,X
    STA velocity_y
    JSR calculate_angle_from_velocities
    LDY find_carry ; particle_type
    EOR #$80
    STA angle
.L21D7
    JSR increment_timers
    AND particle_velocity_randomness_table,Y
    CLC
    ADC particle_velocity_table,Y
    JSR determine_velocities_from_angle
    ASL zp_various_a0 ; particle_flags # 80
    ASL zp_various_a0 ; particle_flags # 40
    ASL zp_various_a0 ; particle_flags # 20
    LDX #$02
.L21EC
    LDA #$00
    ASL zp_various_a0 ; particle_flags # 10, 4
    BCC L21F8
    LDY this_object_angle,X ; X = 2, &39 this_object_flags_lefted ; X = 0, &37 this_object_angle
    BPL L21F8
    LDA this_object_width,X ; X = 2, &3c this_object_height ; X = 0, &3a this_object_width
.L21F8
    ASL zp_various_a0 ; particle_flags # 8, 2
    BCC L21FF
    LDA this_object_width,X ; X = 2, &3c this_object_height ; X = 0, &3a this_object_width
    LSR A
.L21FF
    ADC this_object_x_centre_low_OR_particle_x_low,X
    STA this_object_x_centre_low_OR_particle_x_low,X
    BCC L2207
    INC this_object_x_centre_OR_particle_x,X
.L2207
    DEX
    DEX
    BEQ L21EC
.L220B
    LDY find_carry ; particle_type
    LDA timer_2
    AND particle_colour_randomness_table,Y
    EOR particle_colour_table,Y
    PHA
    JSR add_particle_to_stack
    PLA
    STA zp_various_a3
    AND #$07
    STA velocity_signs_OR_pixel_colour
    JSR increment_timers
    AND particle_life_randomness_table,Y
    ADC particle_life_table,Y
    STA particle_stack+6,X ; particle_stack_ttl
    STX zp_various_9c
    LDX #$FE ; first X = &fe, Y = 0 (x direction), then X = &0, Y = 1 (y direction)
.L2230
    STX zp_various_a2
    JSR increment_timers
    LSR A
    AND particle_x_velocity_randomness_table,Y    ; Y = 0, particle_x_velocity_randomness_table ; Y = 1, particle_y_velocity_randomness_table
    BCC L223D
    EOR #$FF
.L223D
    ADC velocity_y,X ; X = &fe, &b4 velocity_x ; X = &00, &b6 velocity_y
    JSR prevent_overflow
    PHA
    LDA timer_2
    AND particle_x_randomness_table,Y
    ADC this_object_y_centre_low_OR_particle_y_low,X ; X = &fe, &87 particle_x_low ; X = &00, &89 particle_y_low
    PHA
    LDA this_object_y_centre_OR_particle_y,X ; # X = &fe, &8b particle_x ; X = &00, &8d particle_y
    ADC #$00
    LDX zp_various_9c
    STA particle_stack+4,X ; particle_stack_x
    PLA
    STA particle_stack+2,X ; particle_stack_x_low
    PLA
    STA particle_stack,X ; particle_stack_velocity_x
    INC zp_various_9c
    LDX zp_various_a2
    INY
    INX
    INX
    BEQ L2230
    LDX zp_various_9e
    JSR L20E6
    BIT zp_various_a0 ; particle_flags
    BPL L2283
    LDY #$02
    INX
.L2271
    CMP #$CA
    LDA particle_stack,X ; particle_stack_velocity_x
    ADC this_object_vel_x,Y
    JSR prevent_overflow
    STA particle_stack,X ; particle_stack_velocity_x
    DEY
    DEY
    BEQ L2271+1
.L2283
    DEC number_particles_OR_this_object_gravity_flags ; number_of_particles
    BNE L220B
    RTS
.get_object_centre
    STX zp_various_9d ; temp
    LDX #$02
.L228C
    LDA this_object_width,X ; X = 2, &3c this_object_height; X = 0, &3a this_object_width
    LSR A ; halve it
    ADC this_object_x_low,X
    STA this_object_x_centre_low_OR_particle_x_low,X ; X = 2, &89 this_object_y_centre_low; X = 0, &87 this_object_x_centre_low
    LDA this_object_x,X ; X = 2, &55 this_object_y ; X = 0, &53 this_object_x
    ADC #$00
    STA this_object_x_centre_OR_particle_x,X ; X = 2, &8c this_object_y_centre; X = 0, &8b this_object_x_centre
    DEX
    DEX
    BEQ L228C
    LDX zp_various_9d ; temp
    RTS
;;  compare two object centres
;;  returns angle
;;  this_object
;;  X = other object
.get_angle_between_objects
    JSR get_object_centre
    LDY object_stack_sprite,X
    LDA sprite_width_lookup,Y
    LSR A ; add half the width
    ADC object_stack_x_low,X
    STA stack_object_x_centre_low
    LDA object_stack_x,X
    ADC #$00
    STA stack_object_x_centre
    LDA sprite_height_lookup,Y
    LSR A ; add half the height
    ADC object_stack_y_low,X
    STA stack_object_y_centre_low
    LDA object_stack_y,X
    ADC #$00
    STA stack_object_y_centre
    JSR calculate_object_centre_deltas
    JMP calculate_angle
.calculate_angle_from_this_object_velocities
    LDA this_object_vel_x
    STA velocity_x
    LDA this_object_vel_y
.L22D2
    STA velocity_y
;;  takes &b4 velocity_x, &b6 velocity_y
;;  returns &b5 angle
.calculate_angle_from_velocities
    JSR get_opposite_velocities     ; a = x_vel &b7 = y_vel
;;  takes A = velocity_x, &b7 = velocity_y
;;  returns &b5 angle
.calculate_angle
    CMP some_kind_of_velocity ; oppositite_velocity_y
    BCC no_xy_swap          ; is support_delta_x_low (A) < support_delta_y_low (&b8) ?
    TAY
    LDA some_kind_of_velocity ; oppositite_velocity_y # if not, swap A and &b7
    STY some_kind_of_velocity ; oppositite_velocity_y # ie, force A < &b7
.no_xy_swap
    ROL velocity_signs_OR_pixel_colour ; velocity_signs                        ; note the swap in &99 velocity_signs
    LDY #$08
    STY angle
.calc_angle_loop
    ASL A
    CMP some_kind_of_velocity ; oppositite_velocity_y
    BCC L22ED
    SBC some_kind_of_velocity ; oppositite_velocity_y
.L22ED
    ROL angle
    BCC calc_angle_loop
    LDA velocity_signs_OR_pixel_colour ; velocity_signs
    AND #$07
    TAY
    LDA angle
    EOR angle_modification_table,Y
    STA angle
    RTS
;;  leaves with A = support_delta_x_low, &b7 = support_delta_y_low, &b8 = delta_magnitude
.calculate_object_centre_deltas
    LDY #$04 ; first y direction (Y = 4), then x direction (Y = 2)
.L2300
    STA some_kind_of_velocity ; tmp
    LDA stack_object_x_centre_low-2,Y ; Y = 4, &8a stack_object_y_centre_low; Y = 2, &88 stack_object_x_centre_low 
    SBC this_object_x_centre_low_OR_particle_x_low-2,Y ; Y = 4, &89 this_object_y_centre_low; Y = 2, &87 this_object_x_centre_low 
    STA support_delta_x_low-2,Y ; Y = 4, &7d support_delta_y_low; Y = 2, &7b support_delta_x_low 
    LDA stack_object_x_centre-2,Y ; Y = 4, &8e stack_object_y_centre; Y = 2, &8c stack_object_x_centre 
    SBC this_object_x_centre_OR_particle_x-2,Y ; Y = 4, &8d this_object_y_centre; Y = 2, &8b this_object_x_centre 
    STA support_delta_x_OR_wall_y_start_lookup_pointer-2,Y ; Y = 4, &7e support_delta_y; Y = 2, &7c support_delta_x 
    SEC
    BPL L231A
    JSR make_positive
.L231A
    ROL velocity_signs_OR_pixel_colour ; velocity-signs
    DEY
    DEY
    BNE L2300 ; now do it again for the x direction
    ORA some_kind_of_velocity ; tmp                   ; A = support_delta_y | support_delta_x, ie largest of the two
    ASL A
.L2323
    LSR support_delta_x_OR_wall_y_start_lookup_pointer
    ROR support_delta_x_low ; halve support_delta_x
    LSR support_delta_y_OR_wall_y_start_base
    ROR support_delta_y_low_OR_wall_y_start_lookup_pointer_h_4 ; halve support_delta_y
    INY ; for each halving, increase Y
    LSR A
    BNE L2323 ; keep having A until zero
    STY delta_magnitude
    LDA support_delta_y_low_OR_wall_y_start_lookup_pointer_h_4 ; support_delta_y_low
    JSR make_positive
    STA some_kind_of_velocity
    LDA support_delta_x_low
    JMP make_positive
;;  returns &b7 as y_vel, A as x_vel
.get_opposite_velocities
    LDY #$02 ; first Y = 2, y direction, then Y = 0, x direction
    JSR L2346
    STA some_kind_of_velocity
    DEY
    DEY
.L2346
    LDA #$7F ; is the velocity negative?
    CMP velocity_x,Y ; Y = 2, &b6 velocity_y ; Y = 0, &b4 velocity_y
    LDA velocity_x,Y ; Y = 2, &b6 velocity_y ; Y = 0, &b4 velocity_y
    BCS L2354
    EOR #$FF ; if not, make it negative
    ADC #$01
.L2354
    ROL velocity_signs_OR_pixel_colour ; velocity_signs                                ; note this in velocity_signs
    RTS
;;  A = magnitude, &b5 = angle
.determine_velocities_from_angle
    STA velocity_x
    LDA angle
    STA zp_various_9d ; temp
    LDY #$05
    LDA #$00
.L2361
    LSR zp_various_9d ; temp
    BCC L2368
    CLC
    ADC velocity_x
.L2368
    ROR A
    DEY
    BNE L2361
    LSR zp_various_9d ; temp
    BCC L237A
    LDY velocity_x
    STA velocity_x
    TYA
    SBC velocity_x
    STA velocity_x
    TYA
.L237A
    LSR zp_various_9d ; temp
    BCC L2386
    EOR #$FF
    TAY
    INY
    LDA velocity_x
    STY velocity_x
.L2386
    LSR zp_various_9d ; temp
    BCC L2395
    EOR #$FF
    TAY
    INY
    LDA #$00
    SBC velocity_x
    STA velocity_x
    TYA
.L2395
    STA velocity_y
    RTS


.setup_background_sprite_values
    JSR determine_background

; (08 refers to square_sprite and 09 to square_orientation.)

.setup_background_sprite_values_from_08_09
    TAY                             ; Y = square_sprite
    LDA background_palette_lookup,Y ; what's the palette for this
                                    ; sprite?
    BNE palette_not_zero            ; palette_defined

; objects with zero palette, coloured according to Y coordinate:
;
; 05 = brick wall, 3/4 full, \, filled in bottom left
; 13 = brick wall, \, starting top middle, ending middle right, 3/4 full
; 1e = brick wall, solid
; 1f = brick wall, bottom half
; 20 = horizontal brick door
; 23 = brick \ wall, filled in bottom left
; 24 = brick wall, \, starting top left, ending middle right
; 25 = brick wall, \, starting middle left, ending bottom right
; 2a = brick wall, \, very steep down
; 3a = gargoyle, bottom left
; 3b = brick wall, 3/4 filled bottom
;
; get their palette from wall_palette_lookup[(square_y-$54)/16]

    LDA square_y                ; 
    SEC                         ; 
    SBC #$54                    ; square_y-$54
    LSR A                       ; /2
    LSR A                       ; /4
    LSR A                       ; /8
    LSR A                       ; /16
    TAX                         ; 
    LDA wall_palette_zero_lookup,X ; array lookup
    
.palette_not_zero
    CMP #$03
    BCS palette_not_two      ; taken if >=3

; palette is 1 or 2 - function of square_y<0x80
;
; square_y<0x80?0xb1+palette:(0xb1+palette)<<1+0x91

    ADC #$B1                    ; palette is $B2 (1) or $B3 (2)
    BIT square_y                ;
    BPL palette_not_six         ; taken if square_y<0x80

; square_y>=0x80

    ASL A                       ; palette is $64 (1) or $66 (2), and C
                                ; set
    ADC #$90                    ; palette is $f5 (1) or $f7 (2)
    
.palette_not_two
    CMP #$03
    BNE palette_not_three

; palette is 3 - function of x, y and orientation

    LDA square_orientation      ; C=1 %ab000000
    ROL A                       ; C=a %b0000001
    ROL A                       ; C=b %0000001a
    ROL A                       ; C=0 %000001ab
    SBC square_y                ; um
    ROR A                       ; ...
    CLC                         ; ???
    ADC square_x                ; ...
    AND #$03                    ; it's only 2 bits though
    TAX                         ; 
    LDA wall_palette_three_lookup,X ; 
.palette_not_three
    CMP #$04
    BNE palette_not_four

; palette is 4 - it's wall_palette_four_lookup[square_y>>4&7]

    LDA square_y                
    ROL A
    ROL A
    ROL A
    ROL A
    AND #$07
    TAX
    LDA wall_palette_four_lookup,X
.palette_not_four
    CMP #$05
    BNE palette_not_five

; palette is 5 - a function of y and orientation

    LDA square_y                
    ROR A                       
    ROR A                       
    EOR square_y                
    ROR A
    BCC L23EF
    LDY #$19
.L23EF
    ROR A
    SBC square_y
    AND #$40
    EOR square_orientation
    BIT square_orientation
    STA square_orientation
    LDA #$B1
    BVC palette_not_six
    ADC #$0A
.palette_not_five
    CMP #$06
    BNE palette_not_six

; palette is 6 - a function of orientation

    LDA #$9C
    BIT square_orientation
    BVC palette_not_six
    LDA #$CF
.palette_not_six
    STA this_object_palette     ; set the palette for this square
    STA this_object_palette_old
    LDA square_orientation
    STA this_object_flipping_flags ; set the orientation for this square
    STA this_object_flipping_flags_old

; Translate background sprite to object sprite.

    LDA background_sprite_lookup,Y 
    AND #$7F                       ; mask off the extra flag
    TAX                            
    STA this_object_sprite         
    STA this_object_sprite_old

; Adjust Y coordinate.

    LDA background_y_offset_lookup,Y ; Y = background sprite
    AND #$F0                         ; %11110000
    BIT square_orientation           
    BVC L2430                        ; taken if not flipped vertically
    ADC sprite_height_lookup,X       ; adjust Y to account for flip
    ORA #$07                         ; (the lower bits of
                                     ; sprite_height_lookup are used
                                     ; for something)
    EOR #$FF                         ; negate???
.L2430
    STA this_object_y_low       ; y position of start of square sprite
    STA this_object_y_low_old
    LDA #$00
    BIT square_orientation
    BPL L243F                   ; taken if not flipped horizontally
    LDA #$F2                    ; %11110010
    SBC sprite_width_lookup,X   ; 
.L243F
    STA this_object_x_low
    STA this_object_x_low_old   ; x position of start of square sprite
    LDA square_x
    STA this_object_x
    STA this_object_x_old
    LDA square_y
    STA this_object_y
    STA this_object_y_old
    RTS
    
;;  A determines X on leaving
.get_wall_start_80_83
    LDA #$04
    equb $2C; BIT &xxxx
.get_wall_start_7c_7f
    LDA #$00
    PHA
    STX L248F+1 ; self modifying code - preserve X
    JSR determine_background                        ; find out background in this square
    TAY ; Y = background
    PLA
    TAX ; X is set based on how we were called
    LDA background_wall_y_start_base_lookup,Y
    BIT square_orientation
    BVC L246A ; is the square flipped vertically? (&40)
    ASL A ; if so, consider lowest nibble
    ASL A
    ASL A
    ASL A
.L246A
    AND #$F0 ; otherwise use highest nibble
    BEQ L2470
    ORA #$0F
.L2470
    STA support_delta_y_OR_wall_y_start_base,X ; X = 0, &7e wall_y_start_base; X = 4, &82 wall_y_start_base_4
    LDA square_orientation
    ASL A ; carry set if horizontally flipped
    STA zp_various_9c ; v_flipped
    EOR background_sprite_lookup,Y                 ; sprite_lookup ^ &80 if vertically flipped
    STA support_overlap_x_low_OR_wall_sprite,X ; X = 0, &7f wall_sprite; X = 4, &83 wall_sprite_4
    LDA background_y_offset_lookup,Y               ; offset_lookup * 4
    ROL A ; + h_flipped * 2
    ASL zp_various_9c ; v_flipped
    ROL A ; + v_flipped
    AND #$3F
    TAY
    LDA background_wall_y_start_lookup,Y
    STA support_delta_x_OR_wall_y_start_lookup_pointer,X ; X = 0, &7c wall_y_start_lookup_pointer; X = 4, &80 wall_y_start_lookup_pointer_4
    LDA #$01
    STA support_delta_y_low_OR_wall_y_start_lookup_pointer_h_4,X ; X = 0, &7d wall_y_start_lookup_pointer_h; X = 4, &81 wall_y_start_lookup_pointer_h_4
.L248F
    LDX #$00 ; modified by &2456; actually LDX #X
    RTS
.scream_if_damaged
    JSR is_this_object_damaged                      ; is the object damaged?
    BCC L24A5 ; if not, leave
.scream
IF SRAM
    jsr increment_timers
    and #3
    tax
    inx                         ; 1,2,3,4 - various sounds of pain
    jsr smp_play
ELSE
    JSR play_sound
    equb $33,$03,$2D,$24; sound data
    JSR play_sound                                  ; scream!
    equb $33,$03,$2B,$25; sound data
ENDIF
.L24A5
    RTS
;;  A = damage, Y = object to damage
.take_damage
    CPY #$00 ; is it the player being damaged?
    BNE not_player_being_damaged
    STA energy_per_shot+5 ; damage
    BIT timer_2
    BMI no_daze
    LSR player_crawling
    CMP player_immobility_daze
    BCC no_daze
    STA player_immobility_daze                        ; daze the player when seriously damaged
.no_daze
    TXA ; preserve X
    PHA
    BIT protection_suit_collected                   ; have we got the protection suit?
    BPL no_protection_suit
    LDX #$05
    JSR reduce_weapon_energy_for_x                  ; drain its energy
    JSR reduce_weapon_energy_for_x
    JSR make_firing_erratic_at_low_energy
    BCS suit_working                                ; carry set if suit is working
.no_protection_suit
    LDY #$03
.L24CF
    ASL energy_per_shot+5 ; damage
    BCC L24D7
    ROR energy_per_shot+5 ; damage                                      ; if no suit, multiply the damage by 8
.L24D7
    DEY
    BNE L24CF
.suit_working
    LDA timer_2
    AND #$07
    CMP energy_per_shot+5 ; damage                                      ; for small damages, scream occasionally
    BCS L24E6
    JSR scream                                      ; but, always scream for larger ones
.L24E6
    PLA
    TAX ; restore X
    LDA energy_per_shot+5 ; damage
.not_player_being_damaged
    STA zp_various_9d ; damage
    CMP #$08
    BCC L24F9 ; if the damage is &08 or more
    LDA object_stack_flags,Y
    ORA #$08 ; mark the object as being damaged
    STA object_stack_flags,Y
.L24F9
    LDA object_stack_energy,Y
    STA zp_various_9c ; old_energy
    SEC
    SBC zp_various_9d ; damage                                        ; reduce energy by damage
    BCS L2508
    LDA #$00 ; setting to zero if too much
    equb $2C; BIT &xxxx
.set_stack_object_energy_to_one
    LDA #$01
.L2508
    STA object_stack_energy,Y
    RTS
.damage_object
    JSR take_damage                                 ; have we still got energy?
    BNE L2515 ; if so, leave
    LDA zp_various_9c ; old_energy                                    ; if we had energy before being damaged,
    BNE set_stack_object_energy_to_one              ; set energy to be one
.L2515
    RTS
.mark_stack_object_for_removal
    LDA object_stack_flags,Y
    ORA #$20
    STA object_stack_flags,Y
    RTS
.reduce_object_energy_by_one
    CLC
    LDA this_object_energy
    BEQ L2528
    SBC #$00
    STA this_object_energy
.L2528
    RTS
.mark_this_object_for_removal
    PHA
    LDA this_object_flags
    ORA #$20
    STA this_object_flags
    PLA
    SEC
    RTS
.is_this_object_marked_for_removal
    PHA
    LDA this_object_flags
    AND #$20
    CMP #$20
    PLA
    RTS
.is_this_object_damaged
    PHA
    LDA this_object_flags
    AND #$08
    CMP #$08
    PLA
    RTS
.L2545
    DEC this_object_energy
    BNE L254D
.gain_one_energy_point
    INC this_object_energy
    BEQ L2545
.L254D
    RTS
.gain_one_energy_point_if_not_immortal
    INC this_object_energy
    DEC this_object_energy
    BNE gain_one_energy_point
    RTS
;;  A = modulus
.get_sprite_from_velocity
    LDX #$03 ; scale = 8
;;  get_sprite_from_velocity_X                                                    ; scale = 2**X
;;  A = modulus, X = scale
.L2557
    STA zp_various_9c ; modulus
    JSR get_biggest_velocity
.L255C
    LSR A
    DEX
    BPL L255C ; get biggest velocity / scale
    SEC
    ADC this_object_timer                             ; add to this_object_timer
    SEC
.L2564
    SBC zp_various_9c ; modulus                                       ; mod modulus
    BCS L2564
    ADC zp_various_9c ; modulus
    STA this_object_timer                             ; store result in this_object_timer
    RTS
.change_angle_if_wall_collision
    BIT wall_collision_top_or_bottom                  ; have we collided?
    BPL L2577
    LDA wall_collision_angle
    EOR #$FF
    STA this_object_angle                             ; if so, change angle to match
.L2577
    RTS
.flip_object_in_direction_of_travel_on_random_3
    LDA #$03
.flip_object_in_direction_of_travel_on_random_a
    AND timer_1
    BNE L2584
.flip_object_in_direction_of_travel
    LDA this_object_vel_x                             ; have we got an x velocity?
    BEQ L2584
    STA this_object_angle                             ; if so, change angle to match
.L2584
    LDA this_object_angle
    RTS
.increment_timers
    ADC timer_4                                       ; quick and easy pseudo-random numbers
    ADC timer_1
    STA timer_1
    ADC timer_3
    STA timer_3
    ADC timer_2
    STA timer_2
    ADC timer_4
    STA timer_4
    RTS
.process_events
    LDA #$67 ; desired water level = &67 in endgame
    BIT endgame_value                               ; are we in the endgame?
    BMI no_maggot_machine                           ; if not, the maggot machine exists
    LDA #$60
    STA background_objects_data+2 ; background_object_data                      ; reset number of maggots
    BIT loop_counter_every_40
    BPL no_maggots                                  ; once every &40 cycles,
    LDA #$27 ; &27 = maggot
    JSR reserve_object_low_priority                     ; try to create a maggot
    BCS no_maggots                                      ; leave if we couldn't find a slot
    LDA #$D9 ; (&61, &d9)
    STA object_stack_y,Y
    LDA #$61 ; create maggot at (&61.&61, &d9.&70)
    STA object_stack_x,Y                           ; ie, by the teleporter in the maggot machine
    STA object_stack_x_low,Y
    LDA #$70
    STA object_stack_y_low,Y
.no_maggots
    LDA background_objects_data+194 ; background_object_data                    ; for stone door at (&6b, &e1)
    BIT loop_counter_every_20
    BPL L25D5 ; once every &20 cycles,
    AND #$FD
    LDY water_level_by_x_range+1 ; water_level_by_x_range_range1
    CPY #$E0
    BCS L25D5 ; open door
    ORA #$02
.L25D5
    STA background_objects_data+194 ; background_object_data                      ; for stone door at (&6b, &e1)
    AND #$02
    ASL A
    ASL A
    ASL A ; desired water level varies depending on door
    ADC #$D2 ; around &d2 if maggot machine operational
.no_maggot_machine
    STA desired_water_level_by_x_range+1 ; desired_water_level_by_x_range_range1
    LDA earthquake_triggered
    BPL no_earthquake                               ; is the earth quaking?
    ASL A
    CMP timer_3
    AND #$10
    ROL A
    BEQ L25FA
    BIT loop_counter_every_08
    BPL L25FA
    CMP #$21
    BEQ L25FA
    INC earthquake_triggered
.L25FA
    LSR A
    BNE no_earthquake
    JSR increment_timers                            ; shudder screen
    AND #$01
    ORA #$5A
    LDY #$02
    SEI
    STY $FE00                   ; set r2
    STA $FE01                   
    CLI
    LDY #$00
    BEQ L2619
.no_earthquake
    BIT endgame_value                               ; are we in the endgame?
    BMI no_waterfall_sound
    LDY #$11
.L2619
    STY current_object                                ; use the eighteenth slot for the waterfall
    BIT loop_counter_every_08
    BPL no_waterfall_sound ; every 8 cycles,
    JSR play_sound2                                 ; make a noise if it's close enough
    equb $70,$C2,$6E,$A3; sound data
.no_waterfall_sound
    LDX #$FE
    LDA loop_counter
    AND #$20 ; every &40 cycles, there's &20 cycles each
    BNE L2630 ; of &fe or &02 water level movements
    LDX #$02 ; so the water level bobs up and down
.L2630
    STX zp_various_a2 ; water_level_change
    LDX #$03
.water_level_loop
    LDA #$18
    SEC
    SBC water_level_low_by_x_range,X               ; alter the water levels to match
    LDA desired_water_level_by_x_range,X           ; aiming for the desired water level
    SBC water_level_by_x_range,X
    ADC zp_various_a2 ; water_level_change
    PHP
    LDY #$02
    JSR keep_within_range
    ADC water_level_low_by_x_range,X
    STA water_level_low_by_x_range,X
    BCC L2653
    INC water_level_by_x_range,X
.L2653
    PLP
    BPL L2659
    DEC water_level_by_x_range,X
.L2659
    DEX
    BPL water_level_loop
    LDA #$10
    STA background_processing_flag
    LDA #$07 ; consider a random square near the player
    JSR get_random_square_near_player
    JSR determine_background
    CMP #$2D ; is it empty space?
    BNE no_emerging_objects
    LDA loop_counter_every_10                         ; if so,
    BPL no_emerging_objects                         ; once every &10 cycles,
    LDA endgame_value
    AND #$80
    EOR #$80 ; objects less likely to emerge in endgame
    ORA timer_2
    CMP square_y                                      ; objects more likely to emerge deeper down
    BCS no_emerging_objects
    BIT explosion_timer                             ; is an explosion in progress?
    BMI L2688
    LDA timer_3
    AND #$70
    BNE no_emerging_objects                         ; if not, objects less likely to emerge
.L2688
    LDY #$01 ; slot 1 ?
    JSR increment_timers
    CMP #$08 ; set if >&8
    ROR A
    BIT endgame_value               ; or endgame
    BMI L269B
    BIT player_east_of_76
    JSR make_positive
.L269B
    ASL A
    BCC L269F
    INY
.L269F
    STY new_object_data_pointer
    STY new_object_type_pointer
    LDA background_objects_data,Y
    ASL A
    CMP timer_3
    BCC no_emerging_objects
    JSR store_stack_pointer_and_pull_in_tertiary_object
    BCS no_emerging_objects                         ; leave if we couldn't allocate an object
    STA object_stack_y_low,Y
    LDA object_stack_x                              ; for player
    SBC square_x
    STA object_stack_vel_x,Y                       ; aim the new object at the player
    LDA object_stack_y                              ; for player
    SBC square_y
    STA object_stack_vel_y,Y
    LDA #$80
    STA object_stack_extra,Y
.no_emerging_objects
    LDA square_y
    CMP #$4E ; are we above y = &4e ?
    BCS no_stars
    STA this_object_y_centre_OR_particle_y
    LDA square_x
    STA this_object_x_centre_OR_particle_x
    LDA #$00
    STA this_object_y_centre_low_OR_particle_y_low
    STA this_object_x_centre_low_OR_particle_x_low
    LDA player_teleporting_flag                     ; no stars while player teleporting
    ORA square_is_mapped_data                         ; no stars inside the spaceships
    BMI no_stars
    LDY #$4D ; &4d = stars
    JSR add_particle                            ; create star particle
.no_stars
    LDY earthquake_triggered
    DEY
    CPY #$C8
    ROR A
    AND endgame_value
    ORA loop_counter_every_20                         ; in the endgame / earthquake,
    BPL no_triax2                                   ; triax is much more likely to appear
    JSR increment_timers
    BNE no_triax2                                   ; random probability for triax to appear
    LDA object_stack_y
    SBC #$14 ; triax doesn't appear above y = &94
    ORA endgame_value                               ; unless we're in the end game
    BPL no_triax
    LDA #$26 ; &26 = triax
    JSR count_objects_of_type_a_in_stack            ; does triax already exist?
    BNE no_triax                                    ; if so, don't create him again
    LDA #$26 ; &26 = triax
    JSR reserve_object_low_priority                     ; otherwise, find a slot for him
    BCC setup_triax                             ; and if we find one, set him up
.no_triax
    JSR null_function                           ; odd null function call?
.no_triax2
    BIT loop_counter_every_08                         ; every 8 cycles,
    BPL no_clawed_robots
    JSR increment_timers
    AND #$03 ; pick a random clawed robot
    TAX
    LDA clawed_robot_availability,X
    BMI no_clawed_robots                            ; has it been disturbed? if not, leave
    BNE no_clawed_robots                            ; is it already in use? if so, leave
    INC clawed_robot_energy_when_last_used,X       ; damaged robots take a while to come back
    BPL no_clawed_robots
    TXA
    CLC
    ADC #$22 ; &22 - &25 = clawed robots
    JSR reserve_object_low_priority                     ; find a slot for it
    BCS no_clawed_robots ; leave if there aren't enough free slots
    LDA #$01
    STA clawed_robot_availability,X                ; mark as being in use
.setup_triax
    LDA #$FE
    STA object_stack_y,Y                           ; mark as way off screen - will teleport in
    LDA #$C0
    STA object_stack_target,Y                      ; target = player | &c0
.no_clawed_robots
    RTS
;;  A = diameter; returns &95, &97
.get_random_square_near_player
    STA zp_various_9d ; diameter
    LSR A
    STA zp_various_9c ; radius
    JSR increment_timers                            ; get a random number
    AND zp_various_9d ; diameter                                      ; modulus the diameter
    ADC object_stack_x                              ; add the player's x position
    SBC zp_various_9c ; radius                                        ; subtract the radius
    STA square_x
    LDA timer_1                                       ; do likewise for y
    AND zp_various_9d ; diameter
    ADC object_stack_y
    SBC zp_various_9c ; radius
    STA square_y
    RTS
.store_stack_pointer_and_pull_in_tertiary_object
    TSX
    STX copy_of_stack_pointer
    LDX #$06
    JMP into_tertiary_pull_in
;;  X = bullet type
.find_a_target_and_fire_at_it
    STA zp_various_9d ; tmp_a
    LDA this_object_energy
    LSR A
.L276D
    LSR A
    LSR A
    ADC #$02
    CMP timer_2
    BCC L2789 ; use energy to determine probability of firing
    STX L277F+1 ; self modifying code
    LDA zp_various_9d ; tmp_a
    JSR find_nearest_object
    BMI L2789 ; is there something to fire at? if not, leave
.L277F
    LDY #$18 ; modified by &2775, actually LDY #X    ; set bullet type
    JSR enemy_fire
    BMI L2789
    JSR invert_angle
.L2789
    RTS
;;  Y = bullet type
;;  X = target
.enemy_fire
    JSR increment_timers
    AND #$3F
    ADC #$B4
.in_enemy_fire
    STY zp_various_a0 ; enemy_bullet_type
    JSR enemy_fire_velocity_calculation
    ROR A
    SEC
    BMI L27C8
    LDA this_object_vel_x
    SBC velocity_x
    JSR prevent_overflow
    EOR this_object_angle
    BPL L27C7
    TXA
    PHA
    LDA timer_4
    AND #$03
    EOR velocity_y
    STA velocity_y
    LDA zp_various_a0 ; enemy_bullet_type
    JSR create_child_object                             ; create enemy bullets
    PLA
    BCS L27C5
    STA object_stack_target,X                      ; set target for bullet
    JSR increment_timers
    AND #$07
    EOR object_stack_vel_x,X                       ; randomise bullet's x velocity slightly
    STA object_stack_vel_x,X
.L27C5
    LDY #$FF
.L27C7
    CLC
.L27C8
    RTS
.npc_targetting
    LDA #$00
    STA npc_fed
    STX npc_type
    LDA current_object_rotator
    AND #$3F
    BNE no_absorb_find                              ; search for targets once every &40 cycles
    LDA npc_find_a,X
    LDY npc_find_y,X
    JSR find_target
    BMI no_target_27e7                                   ; have we found a target?
    ROL npc_fed
    BNE L27E5
    SEC
.L27E5
    ROL npc_fed
.no_target_27e7
    LDX npc_type
    BIT this_object_extra
    BPL no_second_find
    BVS no_second_find
    LDA npc_fed
    BEQ L27FB
    JSR flag_target_as_avoid
    JSR increment_timers
    BMI no_second_find
.L27FB
    LDA npc_find_ay,X
    TAY
    JSR find_target
    LDX npc_type
.no_second_find
    JSR increment_timers
    BMI no_absorb_find
    LDA npc_absorb_lookup,X
    TAY
    JSR find_target
.no_absorb_find
    ASL npc_fed                                 ; mark npc as not being fed
    LDX npc_type
    LDA npc_absorb_lookup,X                        ; find out what it likes to eat
    JSR absorb_object                           ; is it touching such an object?
    BNE L281E
    INC npc_fed                                 ; if so, mark it as being fed
.L281E
    LDX npc_type
    LDY npc_bit_flags_lookup,X
    LDA npc_fed
    STY zp_various_9c ; npc_bit_flags
    JSR is_this_object_damaged
    ROL A
    LDY explosion_timer
    CPY #$CF
    BEQ L2833
    CLC
.L2833
    ROL A
    LDY endgame_value
    CPY #$80
    ROL A
    LDY current_object_rotator
    CPY #$FF
    ROL A
    AND timer_2
    BEQ L2866
    LDX #$00
    LDY #$07
.L2847
    LSR A
    BCC L2851
    DEX
    BIT zp_various_9c ; npc_bit_flags
    BPL L2851
    INX
    INX
.L2851
    ASL zp_various_9c ; npc_bit_flags
    DEY
    BNE L2847
    TXA
    BEQ L2866
    AND #$C0
    BMI L285F
    LDA #$40
.L285F
    CLC
    ADC this_object_extra
    BVS L2866
    STA this_object_extra
.L2866
    RTS
.set_object_x_y_tx_ty_to_square_x_y
    LDA square_x
    STA object_stack_x,Y
    STA object_stack_tx,Y
    LDA square_y
    STA object_stack_y,Y
    STA object_stack_ty,Y
    RTS
.store_object_x_y_in_stack
    LDA this_object_x
    STA object_stack_x,Y
    LDA this_object_y
    STA object_stack_y,Y
    RTS
.get_object_x_y_to_tx_ty
    LDA object_stack_x,X
    STA this_object_tx
    LDA object_stack_y,X
    STA this_object_ty
    RTS
.store_object_tx_ty_to_seventeenth_stack_slot
    LDX #$10 ; seventeenth slot is used for targetting
    LDA this_object_tx
    STA object_stack_x,X
    LDA this_object_ty
    STA object_stack_y,X
    LDA #$80
    STA object_stack_x_low,X
    STA object_stack_y_low,X
    RTS
.zero_velocities
    LDA #$00
    STA this_object_vel_x
    STA this_object_vel_y
    RTS
.copy_object_values_from_old
    LDA this_object_y_low_old
    STA this_object_y_low
.L28AE
    LDA this_object_y_old
    STA this_object_y
    LDA this_object_x_low_old
    STA this_object_x_low
    LDA this_object_x_old
    STA this_object_x
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.zero_memory_and_loop_endlessly
    LDA #$00
    TAY
    DEY
    STA $7F08,Y
    INY
.L28C3
IF SRAM
; $f3-$c4=$2f 47
;
; Stuff between $24a6 and $313e in ExileB is 47 bytes offset in
; ExileMC, so this is probably from that...
    STA $01f3,Y
ELSE
    STA $01C4,Y ; actually STA &xxc4,Y; modified by 28c9
ENDIF
    INY
    BNE L28C3
    INC L28C3+2 ; self modifying code
    CMP L28C3 ; zero memory &01c4 - &28c3
    BNE L28C3
    ROR object_sprite_lookup+4
.L28D4
    BMI L28D4 ; endless loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.particle_stack
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
    equb $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

particle_stack_velocity_x=particle_stack+0
particle_stack_velocity_y=particle_stack+1
particle_stack_x_low=particle_stack+2
particle_stack_y_low=particle_stack+3
particle_stack_x=particle_stack+4
particle_stack_y=particle_stack+5
particle_stack_ttl=particle_stack+6
particle_stack_type=particle_stack+7

.autofire_timeout
    equb $00
.object_being_fired
    equb $FF
.whistle2_played
    equb $FF
.object_spans_two_squares_x
    equb $00
    equb $EA; (unused)
.object_spans_two_squares_y
    equb $00
.collision_velocity_flags_x
    equb $0C
    equb $EA; (unused)
.collision_velocity_flags_y
    equb $03
.support_granularity_x_or
    equb $0F
    equb $EA; (unused)
.support_granularity_y_or
    equb $07
.support_granularity_x_and
    equb $F0
    equb $EA; (unused)
.support_granularity_y_and
    equb $F8
.object_collision_with_other_object_top_bottom
    equb $00
.object_collision_with_other_object_sides
    equb $00
    equb $20; (unused?)
    equb $EA; (unused)
    equb $80; (unused?)
    equb $EA; (unused)
.something_used_in_collision_x
    equb $10
    equb $EA; (unused)
.something_used_in_collision_y
    equb $40
.object_type_ranges
    equb $00,$04,$06,$0F,$12,$1C,$22,$32,$38,$4A
.energy_by_range
    equb $7F,$3F,$7F,$07,$3F,$81,$FD,$3F,$FF,$7D
;; (unused)
;; (unused)
;; (unused)
;; (unused)
;; (unused?)
;; (unused)
;; (unused?)
;; (unused)
;; (unused)
;; ##############################################################################
;; 
;;    Ranges
;;    ======
;;    0 : player and allies
;;    1 : nests
;;    2 : big creatures
;;    3 : small creatures
;;    4 : bullets and grenades
;;    5 : robots and turrets
;;    6 : flying enemies
;;    7 : lightning, mushroom balls and ifre
;;    8 : scenery
;;    9 : equipment
;; 
;; ##############################################################################
;;        0  1  2  3  4  5  6  7  8  9
.move_npc
    LDA object_onscreen                                ; is it offscreen?
    BPL L2A11
    JSR increment_timers
    BNE L2A1E
.force_object_offscreen
    ASL this_object_offscreen
    SEC
    ROR this_object_offscreen
.L2A10
    RTS
.L2A11
    LDA wall_collision_top_or_bottom
    AND this_object_extra
    BPL L2A10
    JSR play_sound
    equb $23,$E3,$82,$12; sound data
.L2A1E
    DEC acceleration_y
    LDX #$02
.L2A22
    LDA this_object_vel_x_old,X
    JSR return_sign_as_01_or_ff
    ASL A
    STA this_object_vel_x,X
    DEX
    DEX
    BPL L2A22
    JSR copy_object_values_from_old
.move_object
    LDX #$02 ; in y direction first (X = 2), then x direction (X = 0)
    JSR L2A36 ; move_object_in_one_direction_with_given_velocity
.L2A36
    LDA this_object_vel_x,X ; X = 2, &45 this_object_vel_x; X = 0, &43 this_object_vel_x
;;  A = velocity
;;  X = direction
.move_object_in_one_direction_with_given_velocity
    BPL L2A3C
    DEC this_object_x,X ; X = 2, &55 this_object_y ; X = 0, &53 this_object_x
.L2A3C
    CLC
    ADC this_object_x_low,X ; X = 2, &51 this_object_y_low ; X = 0, &4f this_object_x_low
    STA this_object_x_low,X ; X = 2, &51 this_object_y_low ; X = 0, &4f this_object_x_low
    BCC L2A45
    INC this_object_x,X ; X = 2, &55 this_object_y ; X = 0, &53 this_object_x
.L2A45
    DEX
    DEX
    RTS
.calculate_object_maxes
    LDX #$02 ; in y direction first (X = 2), then x direction (X = 0)
.L2A4A
    LDA this_object_width,X ; X = 2, &3c this_object_height ; X = 0, &3a this_object_width
    CLC
    ADC this_object_x_low,X ; X = 2, &51 this_object_y_low ; X = 0, &4f this_object_x_low
    STA this_object_x_max_low,X ; X = 2, &49 this_object_y_max_low ; X = 0, &47 this_object_x_max_low
    PHP
    LDA this_object_x,X ; X = 2, &55 this_object_y ; X = 0, &53 this_object_x
    ADC #$00
    STA this_object_x_max,X ; X = 2, &4a this_object_y_max ; X = 0, &48 this_object_x_max
    PLP
    ROR object_spans_two_squares_x,X ; # X = 2, &29db object_spans_two_squares_y; X = 0, &29d9 object_spans_two_squares_x
    DEX
    DEX
    BEQ L2A4A
    RTS
.leave_supporting
    JMP do_object_wall_collisions
.determine_what_supporting
    LDA this_object_x
    CLC
    ADC #$02
    STA L2A85+1 ; self modifying code
    SBC #$02
    STA L2A81+1 ; self modifying code
    LDY this_object_y
    DEY
    DEY
    STY L2A8C+1 ; self modifying code
    LDY #$EF
    SEC
.consider_next_support
    INY
    BEQ leave_supporting                        ; have we looked at all sixteen objects? if so, get out
    LDA background_objects_handler_lookup+179,Y ; actually &0891 (object_stack_x)
.L2A81
    CMP #$52 ; modified by &2a6e to be CMP #(this_object_x - 2)
    BCC consider_next_support ; is the other object near us? if not, continue loop
.L2A85
    CMP #$54 ; modified by &2a69 to be CMP #(this_object_x + 2)
    BCS consider_next_support ; is the other object near us? if not, continue loop
    LDA background_objects_handler_lookup+214,Y ; actually &08b4 (object_stack_y)
.L2A8C
    SBC #$53
    CMP #$03 ; modified by &2a75 to be CMP #(this_object_y - 2)
    BCS consider_next_support ; is the other object near us? if not, continue loop
    TYA
    ADC #$10
    SBC current_object                          ; an object does not support itself!
    BEQ consider_next_support
    LDX background_objects_handler_lookup+146,Y ; actually &0870 (object_stack_sprite)
    LDA sprite_width_lookup,X
    STA zp_various_9b ; supporting_object_width
    LDA sprite_height_lookup,X
    STA zp_various_9d ; supporting_object_height
    LDA background_objects_handler_lookup+214,Y ; actually &08b4 (object_stack_y)
    STA temp_a_OR_supporting_object_xy
    LDA background_objects_handler_lookup+197,Y ; actually &08a3 (object_stack_y_low)
    LDX #$02
;;  consider_support_direction                                                  ; in y direction first (X = 2), then x direction (X = 0)
.L2AB0
    ORA support_granularity_x_or,X ; X = 2, support_granularity_y_or; X = 0, support_granularity_x_or
    SEC
    SBC this_object_x_max_low,X ; # X = 2, &49 this_object_y_max_low; X = 0, &47 this_object_x_max_low
    PHP
    AND support_granularity_x_and,X ; X = 2, support_granularity_y_and; X = 0, support_granularity_x_and
    CLC
    SBC support_granularity_x_or,X ; X = 2, support_granularity_y_or; X = 0, support_granularity_x_or
    STA support_delta_x_low,X ; X = 2, &7d support_delta_y_low; X = 0, &7b support_delta_x_low
    LDA temp_a_OR_supporting_object_xy
    SBC #$00 ; is support_y > this_y_max ?
    PLP ; if so, not touching
    SBC this_object_x_max,X ; X = 2, &4a this_object_y_max; X = 0, &49 this object_x_max
    BPL consider_next_support                   ; continue loop if not touching
    STA support_delta_x_OR_wall_y_start_lookup_pointer,X ; X = 2, &7e support_delta_y; X = 0, &7c support_delta_x
    LDA zp_various_9b,X ; X = 2, &9d supporting_object_height; X = 0, &9b supporting_object_width
    ORA support_granularity_x_or,X ; X = 2, support_granularity_y_or; X = 0, support_granularity_x_or
    SEC
    ADC this_object_width,X ; X = 2, &3c this_object_height; X = 0, &3a this_object_width
    PHP
    ORA support_granularity_x_or,X ; X = 2, support_granularity_y_or; X = 0, support_granularity_x_or
    SEC
    ADC support_delta_x_low,X ; X = 2, &7d support_delta_y_low; X = 0, &7b support_delta_x_low
    STA support_overlap_x_low_OR_wall_sprite,X ; X = 2, &81 support_overlap_y_low; X = 0, &7f support_overlap_x_low
    LDA support_delta_x_OR_wall_y_start_lookup_pointer,X ; X = 2, &7e support_delta_y; X = 0, &7c support_delta_x
    ADC #$00 ; is (this_y_max - support_y) > (this_size + support_size)?
    PLP ; if so, not touching
    ADC #$00
    BMI consider_next_support                   ; continue loop if not touching
    STA support_overlap_x_OR_wall_y_start_lookup_pointer_4,X ; X = 2, &82 support_overlap_y; X = 0, &80 support_overlap_x
    ORA support_overlap_x_low_OR_wall_sprite,X ; X = 2, &81 support_overlap_y_low; X = 0, &7f support_overlap_x_low
    BEQ consider_next_support           ; continue loop if not overlapping
    LDA background_objects_handler_lookup+179,Y ; actually &0891 (object_stack_x)
    STA temp_a_OR_supporting_object_xy
    LDA background_objects_handler_lookup+162,Y ; actually &0880 (object_stack_x_low)
    DEX ; now do it again for the x direction
    DEX
    BEQ L2AB0 ; consider_support_direction
    LDX current_object                          ; we've found two objects which overlap
    TYA ; X = current_object
    CLC
    ADC #$10 ; A = supporting_object
    BNE L2B03 ; is the player being supported
    CPX object_held                                     ; by the object they're holding?
    BEQ L2B2F ; if so, ignore this and continue loop
.L2B03
    BIT can_player_support_held_object
    BMI L2B10 ; if set, skip this next check
    CPX #$00
    BNE L2B10 ; is the player supporting
    CMP object_held                                     ; the object they're holding?
    BEQ L2B2F ; if so, ignore this and continue loop
.L2B10
    TAX
    JSR increment_timers
    ORA this_object_supporting                  ; only note the support half the time
    BPL L2B1A
    STX this_object_supporting                  ; note the supported object
.L2B1A
    JSR increment_timers
    ORA weapon_energy_h+2,Y ; actually &0946 (object_stack_supporting)
    BPL L2B27 ; only note the support in the stack half the time
    LDA current_object
    STA weapon_energy_h+2,Y ; actually &0946 (object_stack_supporting) # note the support in the stack
.L2B27
    LDX background_objects_handler_lookup+130,Y ; actually &0860 (object_stack_type)
    LDA object_gravity_flags,X
    BPL L2B32 ; is the other object intangible?
.L2B2F
    JMP consider_next_support                       ; if so, continue loop
.L2B32
    AND #$07 ; otherwise, consider it
    STA other_object_weight_OR_support_weight_delta ; other_object_weight
    LDX this_object_type
    LDA object_gravity_flags,X                  ; is this object intangible?
    BMI L2B2F ; if so, continue loop
    AND #$07 ; this object's weight
    SEC
    SBC other_object_weight_OR_support_weight_delta ; other_object_weight                               ; consider the difference in weights
    ROR zp_various_9e ; support_weight_direction
    JSR make_negative
    STA other_object_weight_OR_support_weight_delta
    STY other_object_minus_10_OR_this_object_width_divided_32 ; other_object_minus_10
    LDX #$06 ; in y direction first (X = 6), then x direction (X = 4)
    LDA #$FF
    STA zp_various_9c ; biggest_overlap
.L2B51
    LDA support_overlap_x_OR_wall_y_start_lookup_pointer_4-4,X ; X = 6, &82 support_overlap_y; X = 4, &80 support_overlap_x 
    PHP
    LSR A ; take lowest bit of support_overlap_xy
    LDA support_overlap_x_low_OR_wall_sprite-4,X ; X = 6, &81 support_overlap_y_low; X = 4, &7f support_overlap_x_low 
    ROR A ; and seven highest bits of support_overlap_xy_low
    PLP
    JSR make_positive
    CMP zp_various_9c ; biggest_overlap
    BCS no_bigger                                       ; is this bigger than biggest_overlap?
    STA zp_various_9c ; biggest_overlap                         ; if so, store it
    TXA
    TAY ; and make a note of which dimension in Y
.no_bigger
    DEX
    DEX
    BPL L2B51 ; now do it again for the x direction (X = 4)
    TYA ; Y = 4 (x direction) or Y = 6 (y direction)
    AND #$02
    TAX ; X = 0 (x direction) or X = 2 (y direction)
    LDA collision_velocity_flags_x,X ; collision_velocity_flags_xy              ; &0c (x direction) or &03 (y direction)
    STA number_particles_OR_this_object_gravity_flags ; collision_velocity_flags
    LDA object_collision_with_other_object_sides+1,Y ; &10 (x direction) or &40 (y direction)
    PHA
    AND #$C0
    STA object_collision_with_other_object_top_bottom
    PLA
    ASL A
    ASL A
    STA object_collision_with_other_object_sides
    LDA support_overlap_x_OR_wall_y_start_lookup_pointer_4-4,Y ; Y = 4, &80 support_overlap_x; Y = 6, &82 support_overlap_y 
    PHP
    JSR return_sign_as_01_or_ff
    ASL A
    CLC ; alter velocity to discourage overlap
    ADC this_object_vel_x,X ; X = 0, &43 this_object_vel_x; X = 2, &45 this_object_vel_y
    STA this_object_vel_x,X ; X = 0, &43 this_object_vel_x; X = 2, &45 this_object_vel_y
    LDA support_overlap_x_low_OR_wall_sprite-4,Y ; Y = 4, &7f support_overlap_x_low; Y = 6, &81 support_overlap_y_low 
    PLP
    JSR move_object_in_one_direction_with_given_velocity ; move objects to reflect collision
    JSR calculate_object_maxes
    LDY other_object_minus_10_OR_this_object_width_divided_32 ; other_object_minus_10
    LDX this_object_vel_x
    LDA background_strip_cache_sprite,Y ; # actually &08e6 (object_stack_vel_x)
    JSR alter_velocity_in_collision
    STX this_object_vel_x
    STA background_strip_cache_sprite,Y ; # actually &08e6 (object_stack_vel_x)
    LDX this_object_vel_y
    LDA keys_collected,Y ; # actually &08f6 (object_stack_vel_y)
    JSR alter_velocity_in_collision
    STX this_object_vel_y
    STA keys_collected,Y ; # actually &08f6 (object_stack_vel_y)
    JMP consider_next_support
.alter_velocity_in_collision
    JSR do_momentum_exchange
    JSR process_collision_velocities
    LDX #$01
    JSR process_collision_velocities
    LDA find_carry ; collision_velocity_other
    LDX zp_various_a0 ; collision_velocity_this
    RTS
.process_collision_velocities
    LDA zp_various_a2,X ; X = 0, &a2 collision_velocity_out_this; X = 2, &a3 collision_velocity_out_other
    CMP #$80
    ROR A
    LSR number_particles_OR_this_object_gravity_flags ; collision_velocity_flags                        ; &0c (x direction) or &03 (y direction)
    BCS L2BD4 ; only add if it's the right direction
    ADC zp_various_a2,X ; X = 0, &a2 collision_velocity_out_this; X = 2, &a3 collision_velocity_out_other
    JSR prevent_overflow
.L2BD4
    BIT zp_various_9e ; support_weight_direction
    BMI L2BE0
    JSR make_negative
    DEX
    BEQ L2BE0
    LDX #$01
.L2BE0
    PHA
    JSR L2BE5
    PLA
.L2BE5
    CLC
    ADC zp_various_a0,X ; X = 0, &a0 collision_velocity_this; X = 2, &a1 collision_velocity_other
    JSR prevent_overflow
    STA zp_various_a0,X ; X = 0, &a0 collision_velocity_this; X = 2, &a1 collision_velocity_other
    RTS
.do_momentum_exchange
    STA find_carry ; collision_velocity_other
    STX zp_various_a0 ; collision_velocity_this
    SEC
    SBC zp_various_a0 ; collision_velocity_other
    CMP #$80
    ROR A
    BVC L2BFC
    EOR #$80
.L2BFC
    STA zp_various_a3 ; collision_velocity_delta
    LDX other_object_weight_OR_support_weight_delta
.L2C00
    BNE L2C03
    INX
.L2C03
    CMP #$80
    ROR A ; halve the velocity for each support_weight_delta
    DEX
    BNE L2C03
    CMP #$80
    ADC #$00
    STA zp_various_a2 ; collision_velocity_out_this
    SEC
    SBC zp_various_a3 ; collision_velocity_out_other
    STA zp_various_a3 ; collision_velocity_out_other
    RTS
.scroll_offset_deltas
    equb $FF,$01,$FF,$01
.scroll_offset_limits
.minimum_scroll_x_offset
    equb $FE
.maximum_scroll_x_offset
    equb $02
.minimum_scroll_y_offset
IF SRAM
    equb $fe
ELSE
    equb $FC
ENDIF
.maximum_scroll_y_offset
IF SRAM
    equb $02
ELSE
    equb $04
ENDIF
.scroll_viewpoint
    TXA
    SEC
    SBC #$0F
    TAX
    AND #$02
    TAY
    LDA scroll_offset_x,Y                          ; consider the current scroll offset
    CMP scroll_offset_limits,X                     ; is it already at its limit?
    BEQ L2C69 ; if so, leave
    CLC
    ADC scroll_offset_deltas,X                     ; change the offset accordingly
    STA scroll_offset_x,Y
    JSR play_sound
    equb $3D,$04,$11,$D4; sound data
    RTS
.store_teleport
    LDA this_object_energy
    CMP #$08 ; have we got enough energy to teleport?
    BCC L2C69 ; if not, leave
    LDY teleports_used
    CPY #$04
    BCS L2C4A
    INY ; increase the number of stored positions
.L2C4A
    STY teleports_used                              ; to a maximum of 4
    JSR get_object_centre
    LDY teleport_last                               ; A = this_object_x_centre
    STA teleports_x,Y
    LDA this_object_y_centre_OR_particle_y ; this_object_y_centre
    STA teleports_y,Y                              ; store teleport position
    JSR play_middle_beep
    INC teleport_last
.fix_teleport_last
    LDA teleport_last
    AND #$03
    STA teleport_last
.L2C69
    RTS
.move_right
    INC acceleration_x
    RTS
.move_left
    DEC acceleration_x
    RTS
.move_down
    INC acceleration_y
    RTS
.move_up
    DEC acceleration_y
    BIT player_can_move                             ; can the player move?
    BPL L2C98 ; if not, leave
.or_extra_with_0f
    LDA this_object_extra
    ORA #$0F
    STA this_object_extra
    RTS
.use_booster
    LDA player_can_move                             ; is the player able to move?
    AND booster_collected                           ; if so, have we got the booster?
    BPL L2C98 ; if not, leave
    LDA acceleration_y
    BMI double_acceleration
    LDA acceleration_x
    BEQ double_acceleration
    JSR or_extra_with_0f
.double_acceleration
    ASL acceleration_x                                ; double the player's acceleration
    ASL acceleration_y
.L2C98
    RTS
;;  (activate)
.play_whistle_2
    BIT whistle2_collected                          ; have we got the whistle?
    BPL L2C98 ; if not, leave
.whistle_sound
    JSR play_sound                                  ; sound a note
    equb $B0,$24,$B6,$E2; sound data
    LDA current_object
    STA whistle2_played                             ; mark the whistle as being played
    BPL play_whistle_sound
;;  (deactivate)
.play_whistle_1
    BIT whistle1_collected                              ; have we got the whistle?
    BPL L2C98 ; if not, leave
    SEC
    ROR whistle1_played                               ; mark the whistle as being played
.play_whistle_sound
    JSR play_sound                                  ; sound a note
    equb $B0,$24,$B6,$B3; sound data
    RTS
.get_water_level_for_x
    LDX #$04
.L2CBE
    DEX
    CMP x_ranges,X
    BCC L2CBE
.L2CC4
    LDA water_level_low_by_x_range,X               ; the water level depends on where we are
    STA water_level_low
    CLC
    SBC water_level_low_by_x_range+1
    LDA water_level_by_x_range,X
    STA water_level
    SBC water_level_by_x_range+1 ; water_level_by_x_range_range1               ; unless range 1 (the endgame water level)
    LDX #$01 ; is above, in which case we use that
    BCS L2CC4
    RTS
.bullet_types
    equb $00; (nothing)
    equb $18; pistol bullet
    equb $13; icer bullet
    equb $FB; suit discharge
    equb $19; plasma.
    equb $00; (nothing)
;; pistol bullet
;; icer bullet
;; suit discharge
;; plasma.
;; (nothing)
.change_to_weapon
    DEX
    BIT keys_pressed+shift_key_index ; is SHIFT pressed?
    BMI transfer_energy                         ; if so, transfer energy
    TXA
    BEQ L2CF4 ; no need to test if the jetpack is present
    CMP #$06
    BCS L2D25 ; leave if bad weapon (X >= 6)
    LDA booster_collected,X ; weapon_collected                          ; have we got the weapon?
    BPL L2D26 ; if not, then leave
.L2CF4
    STX current_weapon
    LDA weapon_energy_h,X                            ; get energy for weapon
    LSR A ; divide by 8
    LSR A
    LSR A
    STA bells_to_sound
    JMP play_high_beep                              ; sound bells to reflect energy levels
.transfer_energy
    TXA ; X = weapon to take from
    BEQ L2D0E ; we always have the jetpack
    CPX #$06
    BCS L2D26 ; if it's a bad weapon choice, leave
    LDA booster_collected,X ; weapon_collected
    BPL L2D26 ; if we've not got the weapon, leave
.L2D0E
    JSR reduce_weapon_energy_high
    BCC L2D26 ; if it doesn't have enough energy, leave
    LDX current_weapon
.L2D16
    LDA weapon_energy_h,X
    CLC
    ADC #$08 ; increase current weapon energy
    BCS L2D21
    STA weapon_energy_h,X
.L2D21
    LDA #$01
    STA bells_to_sound
.L2D25
    RTS
.L2D26
    RTS
.reduce_weapon_energy_high
    LDA weapon_energy_h,X
    SEC
    SBC #$08
    BCC L2D32 ; have we got energy in the weapon?
    STA weapon_energy_h,X
.L2D32
    RTS
.fire_weapon
    JSR setup_bullet_velocities
    LDA object_held
    STA object_being_fired
    BPL L2D91 ; are we carrying something? if so, leave
    LDA #$05
    STA autofire_timeout                            ; if we hold fire down, fire again after 5 cycles
    LDX current_weapon
    JSR make_firing_erratic_at_low_energy
    BCC L2D91 ; carry clear if weapon doesn't work; leave
    LDA bullet_types,X ; find the bullet type for this weapon
    BEQ L2D91 ; if there isn't one, leave
    STA player_bullet
    BMI reduce_weapon_energy                    ; the discharge device has no bullets
    JSR create_child_object                             ; create the bullet
    BCS L2D91 ; if we couldn't, leave
    LDX current_weapon
    DEX
    BEQ fire_pistol                                     ; is it the pistol?
    DEX
    BEQ fire_icer                                       ; is it the icer?
    JSR play_low_beep                           ; sound for plasma
    BCS reduce_weapon_energy
.fire_icer
    JSR play_sound                                      ; sound for icer
    equb $3D,$04,$3D,$D3; sound data [TOM 3d was 2d]
    BCS reduce_weapon_energy
.fire_pistol
    JSR play_sound                                      ; sound for pistol
    equb $3D,$04,$3D,$04; sound data
.reduce_weapon_energy
    LDX current_weapon                          ; reduce energy in weapon by energy_per_shot
.reduce_weapon_energy_for_x
    LDA weapon_energy,X
    SBC energy_per_shot,X
    STA weapon_energy,X
    LDA weapon_energy_h,X
    SBC #$00
    BCS L2D8E
    LDA #$00
    STA weapon_energy,X
.L2D8E
    STA weapon_energy_h,X
.L2D91
    RTS
.make_firing_erratic_at_low_energy
    LDA weapon_energy_h,X
    CMP #$04 ; does the weapon have &400 of energy?
    BCS L2DA2 ; if so, leave
    DEX
    CPX #$FF ; jetpack is much more likely to work
    INX
    ROR A
    ROR A
    ROR A
    CMP timer_2                                       ; random probability of it not working
.L2DA2
    RTS ; carry clear = weapon failed
.lookup_and_store_object_energy
    JSR convert_object_to_range_a
    LDA energy_by_range,X
    STA object_stack_energy,Y
    RTS
.convert_object_to_range
    LDA object_stack_type,Y
.convert_object_to_range_a
    LDX #$0A
.L2DB2
    DEX
    CMP object_type_ranges,X
    BCC L2DB2
    RTS
.sound_data_big_lookup_table
; 208 bytes
;        00  01  02  03  04  05  06  07  08  09  0a  0b  0c  0d  0e  0f 
    equb $88,$03,$10,$03,$F0,$80,$03,$C0,$01,$04,$05,$06,$82,$0C,$FE,$03 ; 0
    equb $03,$80,$01,$F9,$02,$01,$02,$FF,$08,$F0,$08,$F8,$01,$FB,$87,$03 ; 1
    equb $A1,$03,$81,$80,$83,$02,$A3,$02,$81,$80,$3E,$00,$01,$06,$0A,$0C ; 2
    equb $0A,$00,$78,$FE,$0F,$10,$0F,$F4,$F8,$04,$02,$05,$FE,$80,$08,$F0 ; 3
    equb $0A,$F8,$0C,$FC,$92,$03,$02,$03,$01,$03,$00,$03,$FF,$03,$FE,$80 ; 4
    equb $03,$03,$03,$01,$03,$00,$0C,$FF,$04,$20,$05,$10,$05,$08,$04,$E0 ; 5
    equb $05,$F0,$05,$F8,$E1,$01,$F8,$08,$01,$E1,$01,$1A,$0D,$FE,$80,$01 ; 6
    equb $18,$64,$00,$88,$02,$00,$01,$40,$02,$00,$01,$BC,$90,$03,$00,$01 ; 7
    equb $0C,$03,$00,$01,$F4,$80,$10,$00,$01,$2F,$10,$00,$01,$F9,$10,$00 ; 8
    equb $01,$F1,$83,$10,$F0,$87,$04,$20,$02,$FD,$02,$C0,$80,$0B,$14,$83 ; 9
    equb $03,$F0,$03,$10,$80,$03,$BC,$07,$06,$82,$02,$FE,$04,$02,$80,$11 ; a
    equb $FF,$0B,$14,$01,$02,$02,$83,$0A,$03,$04,$09,$88,$01,$0B,$01,$E0 ; b
    equb $01,$15,$AC,$01,$14,$01,$EC,$80,$10,$FF,$14,$F8,$28,$02,$01,$00 ; c
.can_we_scroll_screen
    equb $FF
;;  &2e88 = chatter_pitch
.consider_side_collisions
    LDA #$00
    STA zp_various_a2
    STA zp_various_a3
    LDA (support_delta_x_OR_wall_y_start_lookup_pointer),Y ; wall_y_start_lookup_pointer               ; Y = x_low / 32
    CLC
    ADC support_delta_y_OR_wall_y_start_base
    BCC L2E99
    LDA #$FF
.L2E99
    SEC
    SBC this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; this_object_y_low_bumped                      ; start of wall - y_low
    BCC L2EA6 ; b if object start inside wall
    CMP this_object_height
    BCC L2EA4 ; b if object end inside wall
    LDA this_object_height
.L2EA4
    STA zp_various_a2 ; &a2 = height untouched by wall
.L2EA6
    LDA this_object_height
    BIT object_spans_two_squares_y                  ; does the object cross a y square boundary?
    BPL no_second_square                            ; if so, consider the second square
    LDA (support_overlap_x_OR_wall_y_start_lookup_pointer_4),Y ; wall_y_start_lookup_pointer_4
    CLC
    ADC support_overlap_y_OR_wall_y_start_base_4
    BCC L2EB6
    LDA #$FF
.L2EB6
    CMP this_object_y_max_low_bumped
    BCC L2EBC
    LDA this_object_y_max_low_bumped
.L2EBC
    STA zp_various_a3
    BIT distance_OR_wall_sprite_4
    BMI L2EC9
    LDA this_object_y_max_low_bumped
    SEC
    SBC zp_various_a3
    STA zp_various_a3
.L2EC9
    LDA #$00
    SEC
    SBC this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; this_object_y_low_bumped
.no_second_square
    BIT support_overlap_x_low_OR_wall_sprite
    BMI L2ED7
    SEC
    SBC zp_various_a2
    STA zp_various_a2 ; invert things if needed
.L2ED7
    LDA zp_various_a2
    CLC
    ADC zp_various_a3 ; add results for both squares
    ADC #$06
    ROR A
    LSR A ; div 4, rounding up
    AND #$FE
    EOR #$FF ; invert sign
    CLC
    ADC #$01
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.do_object_wall_collisions
    LDA #$20
    STA background_processing_flag
    LSR object_onscreen
    LDA this_object_y_max_low                         ; Calculate how much of the object is underwater
    SEC
    SBC water_level_low
    TAX
    LDA this_object_y_max
    SBC water_level
    BEQ L2F01
    LDX #$00
    BCC L2F01
    DEX
.L2F01
    STX this_object_water_level                       ; and store in this_object_water_level
    LDA this_object_x
    STA square_x
    LDA this_object_y
    STA square_y
    LDX #$00
    STX intro_one
    JSR get_wall_start_7c_7f                        ; leaves with a = #&01
    STA support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4
    ASL intro_one
    BCC L2F19
    DEX
.L2F19
    BIT object_spans_two_squares_y                  ; does the object span a y square boundary?
    BPL L2F2D
    INC square_y
    JSR get_wall_start_80_83
    ASL intro_one
    BCC L2F39
    TXA
    ORA this_object_y_max_low
    TAX
    BCS L2F39
.L2F2D
    LDA support_delta_y_OR_wall_y_start_base
    STA support_overlap_y_OR_wall_y_start_base_4
    LDA support_delta_x_OR_wall_y_start_lookup_pointer
    STA support_overlap_x_OR_wall_y_start_lookup_pointer_4
    LDA support_overlap_x_low_OR_wall_sprite
    STA distance_OR_wall_sprite_4
.L2F39
    CPX this_object_water_level
    BCS L2F3F
    LDX this_object_water_level
.L2F3F
    STX screen_address
    LDY this_object_weight
    BNE L2F46
    INY
.L2F46
    LDA this_object_height
    LSR A
    LSR A
    STA zp_various_9a
    LDX #$04
    LDA screen_address
    BNE L2F53
    SEC
.L2F53
    ROR underwater
    BMI not_underwater
.L2F57
    SBC zp_various_9a
    BCC L2F69
    DEY
    BMI L2F62
    BNE L2F64
    DEC this_object_vel_y
.L2F62
    DEC this_object_vel_y
.L2F64
    DEX
    BNE L2F57
    BEQ L2F85
.L2F69
    LDA this_object_vel_y
    BMI L2F85
    LDA #$C0
    STA angle
    JSR get_object_centre
    LDA this_object_y_max_low
    SBC screen_address
    STA this_object_y_centre_low_OR_particle_y_low
    LDA this_object_y_max
    SBC #$00
    STA this_object_y_centre_OR_particle_y
    LDY #$63 ; &63 = water splash particles
    JSR add_particle                                ; water splash
.L2F85
    BIT loop_counter_every_04
    BPL not_underwater
    JSR L3222 ; dampen_this_object_vel_xy
.not_underwater
    LDA this_object_y_low
    AND #$F8
    ORA #$04
    STA this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; this_object_y_low_bumped                      ; calculate y_low_bumped
    LDA this_object_y_max_low
    AND #$F8
    ORA #$04
    STA this_object_y_max_low_bumped                  ; and y_max_low_bumped
    LDA this_object_x_low
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    TAY
    JSR consider_side_collisions                    ; get result for left hand side
    STA wall_collision_count_left
    LDA #$00
    STA wall_collision_count_top
    STA wall_collision_count_bottom
    LDA this_object_width                             ; next, consider the top and bottom edges
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA other_object_minus_10_OR_this_object_width_divided_32                  ; dividing the object up into chunks of width &20
.collision_width_loop_with_recalc
    LDA this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; this_object_y_low_bumped
    SEC
    SBC support_delta_y_OR_wall_y_start_base
    BCS L2FC1
    LDA #$00
.L2FC1
    STA zp_various_a0 ; y_low_minus_wall_base
    LDA this_object_y_max_low_bumped
    SEC
    SBC support_overlap_y_OR_wall_y_start_base_4
    BCS L2FCC
    LDA #$00
.L2FCC
    STA find_carry ; y_max_minus_wall_base
.collision_width_loop
    LDA (support_delta_x_OR_wall_y_start_lookup_pointer),Y ; wall_y_start_lookup_pointer               ; for each chunk, consider:
    CMP zp_various_a0 ; y_low_minus_wall_base
    ROR A
    EOR support_overlap_x_low_OR_wall_sprite
    BMI L2FD9 ; is there a wall on our top?
    DEC wall_collision_count_top                      ; if so, note in wall_collision_count_top
.L2FD9
    LDA (support_overlap_x_OR_wall_y_start_lookup_pointer_4),Y
    CMP find_carry ; y_max_minus_wall_base
    ROR A
    EOR distance_OR_wall_sprite_4
    BMI L2FE4 ; is there a wall on our bottom?
    DEC wall_collision_count_bottom                   ; if so, note in wall_collision_count_bottom
.L2FE4
    DEC other_object_minus_10_OR_this_object_width_divided_32
    BMI collision_width_loop_done                   ; leave when we've considered our entire width
    INY
    CPY #$08 ; does the object span a x square boundary?
    BCC collision_width_loop
    INC square_x                                      ; if so, recalculate the square
    JSR get_wall_start_80_83
    BIT object_spans_two_squares_y                  ; does the object span a y square boundary?
    BPL L2FFF
    DEC square_y
    JSR get_wall_start_7c_7f                        ; if so, calculate top most square
    JMP L300B
.L2FFF
    LDA support_overlap_y_OR_wall_y_start_base_4                           ; otherwise use same square results
    STA support_delta_y_OR_wall_y_start_base
    LDA support_overlap_x_OR_wall_y_start_lookup_pointer_4
    STA support_delta_x_OR_wall_y_start_lookup_pointer
    LDA distance_OR_wall_sprite_4
    STA support_overlap_x_low_OR_wall_sprite
.L300B
    LDY #$00
    BEQ collision_width_loop_with_recalc
.collision_width_loop_done
    LDA wall_collision_count_bottom
    ASL A
    ASL A
    ASL A
    STA wall_collision_count_bottom                   ; divide wall_collision_count_top by 8
    LDA wall_collision_count_top
    ASL A
    ASL A
    ASL A
    STA wall_collision_count_top                      ; divide wall_collision_count_bottom by 8
    SEC
    SBC wall_collision_count_bottom
    STA velocity_x                                    ; (actually the y velocity change for now)
    STA wall_collision_top_minus_bottom
    EOR #$FF
    CLC
    ADC #$01
    STA wall_collision_bottom_minus_top
    LDA wall_collision_count_bottom
    ORA wall_collision_count_top
    CMP #$01
    ROR wall_collision_top_or_bottom
    JSR consider_side_collisions                    ; get result for right hand side
    STA wall_collision_count_right
    SEC
    SBC wall_collision_count_left
    STA velocity_y                                    ; (actually the x velocity change for now)
    ORA velocity_x
    BNE do_wall_collision                           ; has there been a change in velocity?
    LDA wall_collision_count_left
    ORA wall_collision_count_top
    BEQ L306B ; if not, leave
.from_do_wall_collision
    JSR copy_object_values_from_old
    LDA this_object_vel_x
    CMP #$80
    ROR A
    STA this_object_vel_x                             ; change sign of this_object_vel_x
    LDA this_object_vel_y
    CMP #$80
    ROR A
    STA this_object_vel_y                             ; change sign of this_object_vel_y
    JSR calculate_object_maxes
    INX ; X = &ff
    STX wall_collision_bottom_minus_top
    STX wall_collision_top_minus_bottom ; wall_collision_count_bottom
    STX object_onscreen
    INX ; X = &00
    STX wall_collision_count_left
    STX wall_collision_count_right
    STX wall_collision_count_top
    STX wall_collision_count_bottom
.L306B
    RTS
.do_wall_collision
    JSR calculate_angle_from_velocities
    STA wall_collision_angle
    SEC
    SBC #$60
    AND #$C0
    ASL A
    ROL A ; Y & &02 if angle &80
    ROL A ; Y & &01 if angle &40
    TAY
    EOR #$02
    TAX ; X
    LDA wall_collision_count_left,Y ; Y = 0 - 3, &77 - &7a, wall_collision_count_[left|right|top|bottom]
    CMP wall_collision_count_left,X ; X = 0 - 3, &77 - &7a, wall_collision_count_[top|bottom|left|right]
    BCS L3086
    LDA wall_collision_count_left,X ; X = 0 - 3, &77 - &7a, wall_collision_count_[top|bottom|left|right]
.L3086
    CMP #$00
    BNE L308C
    LDA #$FE
.L308C
    ASL A
    ASL A
    PHA
    DEY
    TYA
    AND #$01
    ASL A
    TAX
    PLA
    CPX #$00
    BNE L30A0
    ADC #$0F
    BCC L30A0
    LDA #$FE
.L30A0
    CPY #$02
    BCC L30A5
    INY
.L30A5
    PHP
    JSR make_negative
    PLP
    JSR move_object_in_one_direction_with_given_velocity
    JSR calculate_object_maxes
    JSR calculate_angle_from_this_object_velocities
    STA wall_collision_post_angle
    LDY some_kind_of_velocity
    STY wall_collision_frict_y_vel
    SEC
    SBC wall_collision_angle
    STA angle
    BPL L30D2
    SBC #$C0
    JSR make_positive
    CMP #$2A
    BCS L30FB
    LDA some_kind_of_velocity
    CMP #$40
    BCC L30FB
    JMP from_do_wall_collision
.L30D2
    SEC
    SBC #$3F
    JSR shift_right_three_while_keeping_sign
    ADC angle
    EOR #$FF
    SEC
    ADC wall_collision_angle
    STA angle
    LDA some_kind_of_velocity
    CMP #$20
    BCC L30E9
    LDA #$20
.L30E9
    SBC #$02
    BCS L30EF
    LDA #$00
.L30EF
    JSR seven_eights
    JSR determine_velocities_from_angle         ; A = velocity_y
    STA this_object_vel_y
    LDA velocity_x
    STA this_object_vel_x
.L30FB
    RTS
.process_gun_aim
    LDA gun_aim_acceleration
    BEQ L3108 ; reset the gun aim speed if no acceleration
    CLC
    ADC gun_aim_velocity                              ; add the acceleration to the velocity
    LDY #$10
    JSR keep_within_range                           ; limit the velocity to +/- 10
.L3108
    STA gun_aim_velocity
    CLC
    ADC gun_aim_value                                 ; add the velocity to the gun aim value
    LDY #$3F
    JSR keep_within_range                           ; limit the value to +/- &3f
    STA gun_aim_value
    BIT this_object_angle                             ; which way is the player facing?
    BPL L311D
    EOR #$7F
    CLC
    ADC #$01
.L311D
    STA firing_angle                                  ; set the firing angle to match
    RTS
.reset_gun_aim
    LDA #$00
    STA gun_aim_value
    STA gun_aim_velocity
.raise_gun_aim
    DEC gun_aim_acceleration
    equb $2C; BIT &xxxx
.lower_gun_aim
    INC gun_aim_acceleration
.display_gun_particles
    JSR setup_bullet_velocities
    JSR invert_angle
    LDY #$42 ; &42 = gun aim particles
    JSR add_particle                            ; create gun aim particles
.invert_angle
    LDA this_object_angle
    EOR #$80
    STA this_object_angle
    RTS
IF SRAM
.M316C
ENDIF
    equb $00; (unused)
IF SRAM
.M316D
    lda gun_aim_value
    eor #$3f
    bne M31A4
    lda keys_pressed+shift_key_index
    and keys_pressed+boost_key_index
    bpl M31A4
    lda keys_pressed+f8_key_index
    and #$e0
    beq M31A4
    lda keys_pressed+f8_key_index
    and #$18
    bne M31A4
    lda keys_pressed+f8_key_index
    and #7
    beq M31A4
.M3190
    inc M316C
    lda M316C
    and #$f
    tax
    lda object_stack_y,x
    beq M3190
    stx M14E1
    jsr play_middle_beep
.M31A4:
    rts
ENDIF

;;  unused code
IF NOVELLA_LOOKUP = TRUE
.sub_c313e
ELSE
;;  unused code
ENDIF
    LDA switch_effects_table,Y
    JSR shift_right_two_while_keeping_sign
    AND #$15
    ADC switch_effects_table,Y
    RTS
    
;;        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
.teleport_destinations_x
    equb $62,$AD,$2A,$0B,$9D,$AF,$9E,$45,$89,$9D,$B5,$A2,$72,$A7,$9F,$B0
.teleport_destinations_y
    equb $C7,$62,$CD,$0B,$58,$62,$69,$57,$71,$3C,$66,$63,$54,$80,$49,$80
.retrieve_object_marker
    equb $FF
.npc_find_a
    equb $81,$81,$BA,$CD,$81,$A9,$37,$37,$8A,$0F
.npc_find_y
    equb $29,$29,$55,$37,$86,$86,$86,$86,$86,$0F
.npc_absorb_lookup
    equb $11,$2F,$10,$34,$30,$35,$34,$58,$58,$0F
.npc_find_ay
    equb $40,$40,$40,$40,$40,$88,$00,$00,$37,$3A
.npc_bit_flags_lookup
    equb $CC,$F6,$8C,$72,$F2,$76,$88,$A4,$1A,$0E
.npc_weapon_lookup
    equb $34,$17,$58,$33,$33
.imp_energy_lookup
    equb $0A,$50,$46,$14,$13
.imp_gift_lookup
    equb $4B,$12,$47,$47,$12
;; ##############################################################################
;; 
;;    NPCs
;;    ====
;;    no npc                           absorbs                 fires                   gives                      bit_flags
;;    0: &29     red/magenta imp       &11 wasp                &34 blue mushroom ball  &4b energy capsule x 4     &cc
;;    1: &2a     red/yellow imp        &2f white/yellow bird   &17 red bullet          &12 active grenade x 10    &f6
;;    2: &2b     blue/cyan imp         &10 pirahna             &58 coronium crystal    &47 mysterious weapon x 1  &8c
;;    3: &2c     cyan/yellow imp       &34 blue mushroom ball  &33 red mushroom ball   &47 mysterious weapon x 1  &72
;;    4: &2d     red/cyan imp          &30 red/magenta bird    &33 red mushroom ball   &12 active grenade x 10    &f2
;;    5: &1c-&1e robot                 &35 engine fire                                                            &76
;;    6: &03     fluffy                &34 blue mushroom ball                                                     &88
;;    7: &01,&38 chatter               &58 coronium crystal                                                       &a4
;;    8: &0a     green slime           &58 coronium crystal                                                       &1a
;;    9: &06     red frogman           &0f worm                                                                   &0e
;; 
;;    no npc                           find_a                  find_y                          find_ay
;;    0: &29     red/magenta imp       &81 active chatter + p  &29 red/magenta imp             &40 bush
;;    1: &2a     red/yellow imp        &81 active chatter + p  &29 red/magenta imp             &40 bush
;;    2: &2b     blue/cyan imp         &ba giant wall + p      &55 coronium boulder            &40 bush
;;    3: &2c     cyan/yellow imp       &cd full flask + p      &37 fireball                    &40 bush
;;    4: &2d     red/cyan imp          &81 active chatter + p  &86 range 6 (flying enemies)    &80 range 0 (allies) + p
;;    5: &1c-&1e robot                 &a9 red/magenta imp + p &86 range 6 (flying enemies)    &88 range 8 (scenery) + p
;;    6: &03     fluffy                &37 fireball            &86 range 6 (flying enemies)    &00 player
;;    7: &01,&38 chatter               &37 fireball            &86 range 6 (flying enemies)    &00 player
;;    8: &0a     green slime           &8a green slime + p     &86 range 6 (flying enemies)    &37 fireball
;;    9: &06     red frogman           &0f worm                &0f worm                        &3a giant wall
;; 
;; ##############################################################################
;;        0  1  2  3  4  5  6  7  8  9
;;       im im im im im dk fl ch sl fr
.toggle_door_locked_state
    ADC #$40
    LDA this_object_data
    BVS L31B6
    ADC #$60
    LSR A
    CLV
.L31B6
    LSR A
    LSR A
    LSR A
    LSR A
    TAX
    LDA keys_collected,X                              ; have we got the right key?
    BPL L31D7 ; if not, leave
    LDA this_object_data
    EOR #$01 ; toggle its state
    BVC L31CE
    LSR A
    AND #$FE
    BCS L31CD
    ORA #$01
.L31CD
    ROL A
.L31CE
    STA this_object_data
    JSR play_sound
    equb $94,$64,$BA,$C4; sound data [TOM c4 was c6]
.L31D7
    RTS
.move_towards_target
    LDX #$FF ; always
;;  A = magnitude
.move_towards_target_with_probability_x
    CPX timer_2                                 ; with probability X
    BCC L31F5 ; if not, leave
    STY zp_various_9c ; maximum_speed
    PHA
    JSR store_object_tx_ty_to_seventeenth_stack_slot
    PLA ; target is in slot seventeen for comparison
    JSR get_object_centre_and_determine_velocities_from_angle
    LDX #$02
.L31EA
    LDY #$00
    LDA velocity_x,X ; X = 2, &b6 velocity_y ; X = 0, &b4 velocity_x
    JSR speed_up
    DEX
    DEX
    BEQ L31EA
.L31F5
    RTS
.speed_up
    SEC
    SBC this_object_vel_x,X ; X = 2, &45 this_object_vel_y ; X = 0, &43 this_object_vel_x
    JSR speed_limit
    ADC this_object_vel_x,X ; X = 2, &45 this_object_vel_y ; X = 0, &43 this_object_vel_x
    STA this_object_vel_x,X ; X = 2, &45 this_object_vel_y ; X = 0, &43 this_object_vel_x
    RTS
.speed_limit
    JSR prevent_overflow
    PHP
    JSR make_positive
.L3208
    LSR A
    DEY
    BPL L3208
    ROL A
    CMP zp_various_9c ; maximum_speed                                   ; limit the speed to maximum_speed
    BCC L3213
    LDA zp_various_9c ; maximum_speed
.L3213
    PLP
    JSR make_positive
    CLC
    RTS
    JSR L3222 ; dampen_this_object_vel_xy                   ; this entrance unused
    JSR L3222 ; dampen_this_object_vel_xy
;;  dampen_this_object_vel_xy_twice                                             ; this_object_vel_[x|y] *= 49/64
.L321F
    JSR L3222 ; dampen_this_object_vel_xy
;;  dampen_this_object_vel_xy                                                   ; this_object_vel_[x|y] *= 7/8
.L3222
    JSR L322D ; dampen_this_object_vel_x
;;  dampen_this_object_vel_y                                                    ; this_object_vel_y *= 7/8
.L3225
    LDA this_object_vel_y
    JSR seven_eights
    STA this_object_vel_y
    RTS
;;  dampen_this_object_vel_x                                                    ; this_object_vel_x *= 7/8
.L322D
    LDA this_object_vel_x
    JSR seven_eights
    STA this_object_vel_x
    RTS
.seven_eights
    STA zp_various_9c ; velocity
    JSR make_positive_cmp_0
    ADC #$07
    LSR A
    LSR A
    LSR A ; velocity / 8, rounded up
    BIT zp_various_9c ; velocity                                        ; keep the sign
    JSR make_positive
    STA zp_various_9b ; velocity/8
    LDA zp_various_9c ; velocity
    SEC
    SBC zp_various_9b ; velocity/8
    RTS
.make_negative
    CLC
    BMI L3253
    EOR #$FF
    ADC #$01
.L3253
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.make_positive_cmp_0
    CMP #$00
.make_positive
{
    CLC
    BPL L325D
    EOR #$FF
    ADC #$01
.L325D
    RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  A = value
;;  Y = range
;;  returns A limited to +/- Y
.keep_within_range
    STY zp_various_9c
    STA zp_various_9d
    JSR make_positive_cmp_0
    CMP zp_various_9c
    BCC L326F
    TYA
    BIT zp_various_9d
    JMP make_positive
.L326F
    LDA zp_various_9d
    RTS
.shift_right_four_while_keeping_sign
    CMP #$80
    ROR A
.shift_right_three_while_keeping_sign
    CMP #$80
    ROR A
.shift_right_two_while_keeping_sign
    CMP #$80
    ROR A
.shift_right_one_while_keeping_sign
    CMP #$80
    ROR A
    RTS
.prevent_overflow
    BVC L3285
    LDA #$7F
    ADC #$00
.L3285
    RTS
;;  A = object type
.convert_object_to_another
    STA this_object_type                              ; store new object type
    TAY
    LDA object_sprite_lookup+101,Y ; object_palette_lookup
    AND #$7F
    STA this_object_palette                           ; store new palette
    LDA #$00
;;  takes A which we add to the base sprite for this object
.change_sprite
    CLC
.L3293
    LDY this_object_type
    ADC object_sprite_lookup,Y
.convert_object_keeping_palette
    CMP this_object_sprite                            ; is it the sprite we already have?
    BEQ L3285 ; if so, leave
    STA this_object_sprite
    TAY
    LDX #$02 ; X = 2, y direction
    LDA this_object_height
    SEC
    SBC sprite_height_lookup,Y
    JSR change_object_size                          ; move the object to reflect its new size
.change_object_width
    LDA this_object_width                             ; X = 0, x direction
    SEC
    SBC sprite_width_lookup,Y
.change_object_size
    ROR A
    EOR #$80
    JMP move_object_in_one_direction_with_given_velocity
.pick_up_object
    JSR can_we_pick_up_object
    BMI L32C7 ; leave if not touching anything
    LDY object_stack_type,X
    LDA object_sprite_lookup+101,Y ; object_palette_lookup                     ; can the object be picked up? (palette & &80)
    AND object_held                                   ; are our hands empty? (object_held >= &80)
    BPL L32C7 ; if so, pick up this object
    STX object_held
.L32C7
    RTS
.drop_object
    BIT object_held                                     ; are we holding an object?
    BMI L32C7 ; if not, leave
    SEC
    ROR object_held                                     ; if so, stop holding it
    JMP play_high_beep
.throw_velocities
    equb $20,$20,$20,$20,$20,$10,$08
.throw_object
    JSR setup_bullet_velocities
    LDY object_held                                     ; are we holding an object?
    BMI L32C7 ; if not, leave
    JSR get_object_gravity_flags ; get_object_weight
    TAY ; Y = object weight
    LDX object_held
    JSR drop_object
    JSR increment_timers
    AND #$07
    ADC throw_velocities,Y                          ; get a velocity based on the weight, plus a random extra
    JSR determine_velocities_from_angle
    BIT any_collision_top_bottom                      ; have we collided with something?
    BMI L3300
    LDA velocity_y                                      ; if not,
    CLC
    ADC this_object_vel_y                             ; add the y velocity to the firer's
    JSR prevent_overflow
.L3300
    STA object_stack_vel_y,X
    LDA velocity_x                                    ; add the x velocity to the firer's
    CLC
    ADC this_object_vel_x
    JSR prevent_overflow
    STA object_stack_vel_x,X
    RTS
.setup_bullet_velocities
    LDA firing_angle                                 ; set angle to firing angle
;;  setup_bullet_velocities_from_A                                                ; or use A as angle
.L3311
    STA angle
    JSR increment_timers
    AND #$03
    ADC #$40 ; magnitude is between &40 and &43
    JSR determine_velocities_from_angle             ; calculate velocities
.setup_bullet_velocities_with_velocities
    LDA this_object_vel_x
    ADC velocity_x                                    ; the new x velocity is relative
    JSR prevent_overflow
    PHP
    JSR make_positive
    CMP #$50 ; use this_object_vel_x + velocity_x
    BCC L333C ; unless > &50
    LDA this_object_vel_x
    JSR make_positive
    ADC #$20
    JSR prevent_overflow
    CMP #$50 ; else, use this_object_vel_x + &20
    BCS L333C ; unless > &50
    LDA #$50 ; in which case, use &50
.L333C
    PLP
    JSR make_positive
    STA velocity_x                                    ; (curiously, the y velocity isn't relative)
    RTS
.get_object_centre_and_determine_velocities_from_angle_quarter
    STA zp_various_a3
    LSR A
    LSR A
;;  a = magnitude
;;  a=&20 from unknown door func
.get_object_centre_and_determine_velocities_from_angle
    STA zp_various_a2 ; magnitude
    JSR get_angle_between_objects
    LDA some_kind_of_velocity
    STA this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; some_kind_of_velocity_copy
    LDA zp_various_a2 ; magnitude
    JMP determine_velocities_from_angle
.enemy_fire_velocity_calculation
    JSR get_object_centre_and_determine_velocities_from_angle_quarter
    LDA delta_magnitude
    CMP #$06
    BCS L33A4
    LSR zp_various_a2
    LSR zp_various_a2
    ASL this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; some_kind_of_velocity_copy
    LDA #$00
    LDY #$08
    ASL this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; some_kind_of_velocity_copy
.L336A
    ROL A
    CMP zp_various_a2
    BCC L3371
    SBC zp_various_a2
.L3371
    ROL this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; some_kind_of_velocity_copy
    DEY
    BNE L336A
    LDA delta_magnitude
    CLC
    ADC #$04
    TAY
    LDA #$00
.L337E
    ASL this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; some_kind_of_velocity_copy
    ROL A
    DEY
    BNE L337E
    EOR #$FF
    SEC
    ADC velocity_y
    SEC
    BVS L33A4
    STA velocity_y
    JSR make_positive
    TAY
    LDA object_stack_vel_x,X
    ADC velocity_x
    JSR prevent_overflow
    STA velocity_x
    JSR make_positive
    JSR get_biggest_of_a_and_y
    CMP zp_various_a3
.L33A4
    RTS
.generate_lightning
    LDX #$32 ; &32 = lightning
    LDA #$28 ; x velocity = &28
;;  X = object type to create
;;  A = x velocity
.add_weapon_discharge
    LDY #$00
;;  Y = y velocity
.add_weapon_discharge_y_velocity
    BIT this_object_angle                             ; alter x velocity to match orientation
    JSR make_positive
    STA velocity_x
    STY velocity_y
    JSR setup_bullet_velocities_with_velocities     ; make the velocities relative to the firer
    TXA
;;  A = type of object to create
;;  returns X = object number
.create_child_object
    JSR reserve_object                          ; find a free object slot
    BCS L33A4 ; if none found, leave
    SEC
    ROR child_created                                 ; note creation in child_created
    TYA ; Y = new object number
    TAX ; X = new object number
    LDA this_object_flags_lefted
    AND #$80
    LSR A
    ORA #$05
    STA object_stack_flags,Y                       ; set flags for new object
    JSR store_velocities_in_stack                   ; set velocities for new object
    LDY object_stack_sprite,X
    SEC
    LDA this_object_height
    SBC sprite_height_lookup,Y
    LSR A
    ADC this_object_y_low
    STA object_stack_y_low,X                       ; set y position for new object
    LDA this_object_y                                 ; at half way down the parent
    ADC #$00
    STA object_stack_y,X
    LDA this_object_vel_x
    SEC
    SBC velocity_x
    JSR prevent_overflow
    STA zp_various_9d ; tmp_vx
    EOR this_object_vel_x
    CLC
    PHP
    LDA zp_various_9d ; tmp_vx
    BPL L33FF
    LDA this_object_width
    ADC #$18
    LDY #$01
    BNE L3406
.L33FF
    LDA #$E9
    SBC sprite_width_lookup,Y
    LDY #$FF
.L3406
    BCS L3409
    DEY
.L3409
    CLC
    ADC this_object_x_low
    STA zp_various_9c
    TYA
    ADC this_object_x
    TAY
    LDA zp_various_9d
    PLP
    BMI L341B
    LDA #$01
    SBC velocity_x
.L341B
    CMP #$00
    BPL L3420
    DEY
.L3420
    CLC
    ADC zp_various_9c
    STA object_stack_x_low,X                       ; set x position for new object
    BCC L3429
    INY
.L3429
    TYA
    STA object_stack_x,X
    CLC
    RTS
.store_velocities_in_stack
    LDA velocity_x
    STA object_stack_vel_x,X
    LDA velocity_y
    STA object_stack_vel_y,X
    RTS
.suck_or_blow_all_objects
    LDA #$FF
;;  A = range of angles to suck
.suck_or_blow_all_objects_limited_angle
    STA find_carry ; sucking_angle_range
    LDA angle
    STA zp_various_a0 ; sucking_angle
    LDX #$0F ; consider each other object in turn
.suck_loop_over_objects
    CPX current_object                                ; ignoring ourselves
    BEQ suck_loop_next
    LDA sucking_distance                              ; consider objects closer than sucking_distance
    JSR is_object_close_enough                      ; have we got line of sight to it?
    BCS suck_loop_next                              ; if not, ignore it
    LDA angle
    EOR sucking_angle_modifier
    STA angle
    SBC zp_various_a0 ; sucking_angle
    CMP find_carry ; sucking_angle_range                           ; is the angle within range?
    BCC suck_object_ok
    EOR #$FF
    CMP find_carry ; sucking_angle_range
    BCS suck_loop_next
.suck_object_ok
    LDY object_stack_type,X                        ; if angle and line of sight are okay,
    LDA object_gravity_flags,Y
    AND #$07
    CMP #$07 ; does it fall under gravity?
    ROR object_static
    ASL A
    ADC #$08
    ADC distance_OR_wall_sprite_4 ; distance
    SBC sucking_distance                              ; heavier objects less likely to be sucked
    EOR #$FF
    BCS suck_loop_next                              ; is it too far away? if so, ignore it
    BIT sucking_damage
    BPL suck_no_damage                              ; only damage objects if sucking_damage set
    CMP #$04
    BCC suck_no_damage
    STX zp_various_9d
    LDY zp_various_9d
    PHA
    ASL A ; damage based on distance
    JSR take_damage                                 ; damage object
    PLA
.suck_no_damage
    BIT object_static
    BMI suck_loop_next                              ; don't suck it if it's fixed
    LSR A ; magnitude
    JSR determine_velocities_from_angle         ; A = velocity_y
    ADC object_stack_vel_y,X                       ; add velocities to object
    BVS L349A ; avoiding overflows
    STA object_stack_vel_y,X
.L349A
    LDA velocity_x
    ADC object_stack_vel_x,X
    BVS suck_loop_next
    STA object_stack_vel_x,X
.suck_loop_next
    DEX ; move on to next object
    BPL suck_loop_over_objects
    LSR sucking_damage                                ; clear sucking_damage
    LDA #$28
    STA sucking_distance                              ; reset sucking_distance
    INX
    STX sucking_angle_modifier                        ; reset sucking_angle_modifier
    RTS
.store_object
    LDA #$04
    equb $2C; BIT &xxxx
.store_object_five_pockets
    LDA #$05
    STA L34DA+1 ; change number of pockets
    LDY object_held
    CLC
    BMI L352D ; are we holding something? if not, leave
    LDX object_stack_sprite,Y
    LDA sprite_height_lookup,X
    CMP #$38
    BCS L352D ; if object too big, leave
    LDA object_stack_type,Y                        ; what kind of object is it?
    CMP #$4B ; &4b = energy capsule
    BNE pocket_object                           ; if not an energy capsule, pocket it
    LDX #$00
    JSR L2D16 ; otherwise increase energy in jetpack
    JMP L34F4 ; and remove object
.pocket_object
    LDX pockets_used
.L34DA
    CPX #$05 ; modified by &34b6, actually CPX #A           ; are we using all our pockets already?
    BCS L352D ; if so, leave
    LDX #$05
    PHA
.L34E1
    LDA clawed_robot_energy_when_last_used+3,X ; push the contents of the pockets one deeper
    STA pockets_used,X
    DEX
    BNE L34E1
    PLA
    STA pockets_used+1 ; store object in pocket
    INC pockets_used
    JSR drop_object                                 ; mark the object as no longer being held
.L34F4
    CLC
    JMP mark_stack_object_for_removal               ; and remove it
.retrieve_object
    JSR store_object_five_pockets
    ROR retrieve_object_marker                      ; mark us as due to retrieve an object
    RTS
.retrieve_object_if_marked
    BIT retrieve_object_marker                      ; are we due to retrieve an object?
    BMI L352D ; if not, leave
.actually_retrieve_object
    LDA this_object_angle                             ; get our angle, but reduce it to either
    AND #$80 ; &00 = straight left, &80 = straight right
    JSR L3311 ; setup_bullet_velocities_from_A
    LDX pockets_used                            ; are our pockets empty?
    BEQ L3529 ; if so, clear the mark and leave
    LDA pockets_used,X                          ; get the content of the pocket
    JSR create_child_object                             ; create it as an object; X = new object
    BCS L352D ; if not possible, keep the mark and leave
    STX object_held                                     ; mark the new object as being held
    JSR play_sound
    equb $17,$82,$13,$C2; sound data [TOM c2 was c3]
    LDY object_held
    JSR set_object_velocities                       ; set its velocities to match ours
    DEC pockets_used                                ; one fewer full pockets now
.L3529
    SEC
    ROR retrieve_object_marker                      ; clear the mark
.L352D
    RTS
;;  Y = minimum energy to give object
.give_minimum_energy
    LDA this_object_energy
    BEQ L3537 ; if the object has no energy, leave
    JSR get_biggest_of_a_and_y
    STA this_object_energy                            ; otherwise give it at least its minimum
.L3537
    RTS
.gain_energy_or_flash_if_damaged_minimum_1e
    LDY #$1E ; minimum energy = &1e
;;  gain_energy_or_flash_if_damaged                                               ; or Y
;;  Y = minimum energy to give object
.L353A
    BIT loop_counter_every_04                         ; every four cycles
    BPL give_minimum_energy_and_flash_if_damaged
    LDA this_object_energy
    CMP #$C0
    BCS give_minimum_energy_and_flash_if_damaged
    JSR gain_one_energy_point_if_not_immortal        ; gain energy if < &c0
.give_minimum_energy_and_flash_if_damaged
    JSR give_minimum_energy
    ASL A
    PHP
    BCS L3554 ; is energy < &80 ?
    LDA current_object_rotator
    AND #$07
    CMP #$02
.L3554
    JSR flash_palette                               ; if so, flash palette every 8 cycles
    PLP
    RTS
.get_object_distance_from_screen_centre
    LDY current_object
.L355B
    SEC
    LDA object_stack_x,Y
    SBC #$04
    SBC screen_start_square_x                         ; object_x - 4 - screen_x
    JSR make_positive
    STA zp_various_9d ; tmp
    LDA object_stack_y,Y
IF SRAM
    sbc #$03
ELSE
    SBC #$01
ENDIF
    SBC screen_start_square_y                         ; object_y - 1 - screen_y
    JSR make_positive
    ADC zp_various_9d ; tmp
    ROR A ; average the two
    RTS
.pause
    LSR game_paused
    JSR L3581 ; wait for COPY to be released
.L357C
    BIT keys_pressed+pause_key_index
    BPL L357C ; then pressed
.L3581
    BIT keys_pressed+pause_key_index
    BMI L3581 ; then released again
    ROR game_paused
    RTS
.player_can_move
    equb $FF
.allow_screen_redrawing
    equb $FF                    ; apparently constant
.scroll_square_offset_x_low
    equb $00,$E0
.scroll_square_offset_x
    equb $00,$07
.scroll_square_offset_y_low
    equb $00,$C0
.scroll_square_offset_y
    equb $00
IF SRAM
    equb $07
ELSE
    equb $03
ENDIF
.scroll_screen_address_offsets
IF SRAM
    equb $00,$3E,$3C,$3A
ELSE
    equb $00,$1E,$1C,$1A
ENDIF
.los_consider_water
    equb $00
.door_data_pointer_store
    equb $00
;; allow_screen_redrawing                                              ; apparently constant
.is_object_close_enough_80
    LDA #$80
;;  X = object
;;  A = range
;;  X = object
.is_object_close_enough
    STA L35CC+1 ; self modifying code
    LDA object_stack_y,X
    SEC
    BEQ L35CE ; is it an object? branch if not
    LDA object_stack_type,X
    SBC #$3C ; &3c - &3f various doors
    CMP #$04
    BCS not_door                                    ; if so, is it a door?
    LDA object_stack_data_pointer,X
    STA door_data_pointer_store                     ; if so, store data pointer for door
.not_door
    LDA #$20 ; magnitude
    JSR get_object_centre_and_determine_velocities_from_angle
    LDY delta_magnitude
    INY
    INY
    INY
    LDA #$00
.closeness_loop
    ASL this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left ; some_kind_of_velocity_copy                    ; push bits from some_kind_of_velocity_copy
    ROL A ; depending on delta_magnitude
    BCC L35C7
    LDA #$FD ; or set to &fd if overflowed
.L35C7
    DEY
    BNE closeness_loop
    ADC #$01
.L35CC
    CMP #$40 ; modifed by &359c (CMP #range)
.L35CE
    BCC line_of_sight_without_obstructions          ; if not an object, branch
    STA distance_OR_wall_sprite_4 ; distance
    JMP leave_with_carry_set
;;  distance to consider
.line_of_sight_without_obstructions
    STA this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left
    STX zp_various_9d ; tmp_x                                         ; preserve X
    LDX #$02 ; first y direction (X = 2), then x direction (X = 0)
.los_dir
    STA L3634 ; A = &b0 (BCS) or &90 (BCC)            ; self modifying code
    EOR #$76
    STA L3636 ; A = &c6 (DEC) or &e6 (INC)            ; self modifying code
    STX distance_OR_wall_sprite_4 ; distance
    LDA this_object_width,X ; X = 2, &3c this_object_height; X = 0, &3a this_object_width
    LSR A
    ADC this_object_x_low,X ; X = 2, &51 this_object_y_low; X = 0, &4f this_object_x_low
    STA support_overlap_x_OR_wall_y_start_lookup_pointer_4,X ; X = 2, &82 square_y_low; X = 0, &80 square_x_low
    LDA this_object_x,X ; X = 2, &55 this_object_y
    ADC #$00
    STA square_x,X ; X = 2, &97 square_y                   ; get centre of object into square, square_low
    LDA velocity_x,X ; X = 2, &b6 velocity_y
    LSR A
    AND #$20
    EOR #$90 ; A = &B0 (BCS) or &90 (BCC)            ; is the velocity positive or negative?
    DEX
    DEX
    BEQ los_dir      ; do it again for x direction
    STA L3642 ; A = &b0 (BCS) or &90 (BCC)            ; self modifying code
    EOR #$76
    STA L3644 ; A = &c6 (DEC) or &e6 (INC)            ; self modifying code
    LDA #$40
    STA background_processing_flag                    ; doors
    LDA square_x
    JSR get_water_level_for_x
    LDA support_overlap_y_OR_wall_y_start_base_4 ; square_y_low
    CMP water_level_low
    LDA square_y
    SBC water_level
    ROR A
    ROR A
    ROR A
    AND #$20 ; are we underwater or not?
    EOR #$B0
    STA L3670 ; A = &b0 (BCS) or &90 (BCC)            ; self modifying code
    LDX zp_various_9d ; tmp_x
    JSR get_wall_start_7c_7f
.los_loop
    LDA support_overlap_y_OR_wall_y_start_base_4 ; square_y_low                                  ; consider the next point on our route
    CLC
    ADC velocity_y                                    ; (by adding velocities to current point)
    STA support_overlap_y_OR_wall_y_start_base_4 ; square_y_low
    AND #$F8
    ORA #$04
    STA support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4 ; square_y_low_max
.L3634
    BCS L363B ; modified by &35db; either BCS &363b or BCC &363b, depending on sign of velocity_x
.L3636
    INC square_y              ; modified by &35e0; either DEC &97 or &INC &97, depending on sign of velocity_x
    JSR get_wall_start_7c_7f                        ; redundant?
.L363B
    LDA support_overlap_x_OR_wall_y_start_lookup_pointer_4 ; square_x_low
    CLC
    ADC velocity_x
    STA support_overlap_x_OR_wall_y_start_lookup_pointer_4 ; square_x_low
.L3642
    BCS L3649 ; modified by &35fd; either BCS &3649 or BCC &3649, depending on sign of velocity_y
.L3644
    INC square_x              ; modified by &3602; either DEC &95 or &INC &95, depending on sign of velocity_y
    JSR get_wall_start_7c_7f
.L3649
    LDA support_overlap_x_OR_wall_y_start_lookup_pointer_4 ; square_x_low                                  ; check whether there's a wall there
    AND #$E0
    ASL A
    ROL A
    ROL A
    ROL A
    TAY
    LDA (support_delta_x_OR_wall_y_start_lookup_pointer),Y ; wall_y_start_lookup_pointer
    ADC support_delta_y_OR_wall_y_start_base
    BCC L365A
    LDA #$FF
.L365A
    CMP support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4 ; square_y_low_max
    ROR A
    EOR support_overlap_x_low_OR_wall_sprite
    BPL leave_with_carry_set                        ; if so, there's an obstruction
    BIT los_consider_water
    BPL los_ignore_water ; is water considered a barrier?
    LDA support_overlap_y_OR_wall_y_start_base_4 ; square_y_low
    CMP water_level_low                             ; if so, have we passed through the water?
    LDA square_y
    SBC water_level                                 ; if so, there's an obstruction
.L3670
    BCC leave_with_carry_set ; modified by &371f; either BCS &367a or BCC &367a, depending on initial water level
.los_ignore_water
    INC distance_OR_wall_sprite_4 ; distance
    DEC this_object_y_low_bumped_OR_some_kind_of_velocity_copy_OR_distance_left
    BNE los_loop
    CLC ; no obstructions found; return carry clear
    equb $24; BIT &xx
.leave_with_carry_set
    SEC ; obstructions found; return carry set
    LDA #$FF
    STA door_data_pointer_store
    STA los_consider_water                          ; consider water unless otherwise ignored
.L3683
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.redraw_screen
    LDA allow_screen_redrawing ; should we redraw the screen? (constant)
    BPL L3683                  ; if not, leave
    LDA scroll_x_direction
    BEQ not_scrolling_x

; scrolling in X

    LDY scroll_square_x_velocity_high
    INY                         ; Y = &00 left, Y = &01 right
    LDA scroll_square_offset_x_low,Y
    CLC
    ADC screen_start_square_x_low
    LDA scroll_square_offset_x,Y
    ADC screen_start_square_x
    STA square_x           ; find the square on the edge of the screen
    LDA screen_start_square_y
    STA square_y
    LDA scroll_square_x_velocity_low
    BIT scroll_square_x_velocity_high
    JSR make_positive
    LSR A
    LSR A
    STA scroll_width            ; get the width of the scrolled area
IF SRAM
    ldx #$21
ELSE
    LDX #$11
ENDIF
    SEC
    LDA screen_offset
    BIT scroll_square_x_velocity_high
    BMI L36B7
    SBC scroll_width
.L36B7
    STA screen_address
    LDA screen_offset_h
    SBC #$00
    CLC
    ADC #screen_base_page ; calculate the screen address for the edge
    SEC
    DEC scroll_width
    BIT scroll_square_x_velocity_high
    BMI L36D4
    BPL L36D6
.L36C9
    LDA #$00
    LDY scroll_width
.clear_edge_loop
    STA (screen_address),Y ; clear the screen memory for the edge
    DEY
    BPL clear_edge_loop
    LDA screen_address+1
.L36D4
    SBC #$02
.L36D6
    ORA #screen_base_page
    STA screen_address+1
    DEX
    BNE L36C9 ; repeat until we've cleared the edge
IF SRAM
    ldy #$08
ELSE
    LDY #$04 ; strip length = 4 squares
ENDIF
    LDA #square_y ; when redrawing strip, increase &97 square_y
    LDX #$02 ; scroll in X
    BNE L375B ; done_scrolling
.not_scrolling_x
    LDX scroll_y_direction
    BEQ L375B

; scrolling in Y

    LDY scroll_square_y_velocity_high
    INY
    LDA scroll_square_offset_y_low,Y               ; Y = &00 up, Y = &01 down
    CLC
    ADC screen_start_square_y_low
    LDA scroll_square_offset_y,Y
    ADC screen_start_square_y
    STA square_y                                      ; find the square on the edge of the screen
    LDA screen_start_square_x
    STA square_x
    TYA
    BEQ L3702 ; are we scrolling down?
    LDY scroll_y_direction                            ; if so, Y = scroll_y_velocity
.L3702
    LDA screen_offset
    CLC
    STA screen_address_two
    LDA screen_offset_h
    ADC scroll_screen_address_offsets,Y
    AND #screen_size_pages-1    ; ok
    ORA #screen_base_page       ; ok
    STA screen_address_two_h
    LDA scroll_y_direction
    JSR make_positive
    STA scroll_height           ; get the height of the scrolled area
.L3719
    LDA screen_address_two_h
    STA screen_address+1
    LDX #$02
    LDY screen_address_two
    LDA #$00
    STA screen_address
.L3725
    STA (screen_address),Y ; clear the screen memory for left part of edge
    INY
    BNE L3725
    INC screen_address+1
    BPL L3734
    LDA #screen_base_page
    STA screen_address+1
    LDA #$00
.L3734
    DEX
    BNE L3725
    DEC screen_address+1
    DEC screen_address
    LDY screen_address_two
    BEQ L3746
    LDA #$00
.L3741
    STA (screen_address),Y ; clear the screen memory for right part of edge
    DEY
    BNE L3741
.L3746
    LDA screen_address_two_h
    CLC
    ADC #$02
    AND #screen_size_pages-1
    ORA #screen_base_page
    STA screen_address_two_h
    DEC scroll_height
    BNE L3719
    LDA #$95 ; when redrawing strip, increase &95 square_x
    LDY #$08 ; strip length = 8 squares
    LDX #$00
;;  done_scrolling                                                                ; X = 0 for y scrolling, X = 2 for x scrolling
.L375B
    STA L10EB+1 ; self modifying code                   ; use square_[x|y] variable depending on direction
    STA L378A+1 ; self modifying code                   ; use square_[x|y] variable depending on direction
    PHA
    LDA screen_start_square_x_low,X ; X = 2, &c9 screen_start_square_y_low; X = 0, &c7 screen_start_square_x_low
    BEQ L3767
    INY ; add one extra square to strip if needed
.L3767
    STY strip_length
    STY plotter_x ; strip_length_two
    PLA
    TAX
    LDA $00,X ; actually LDA &95|&97 square_[x|y]     ; preserve square_[x|y]
    PHA
    TXA
    PHA
    LDA call_object_handlers_when_redrawing_screen  ; should we call background object handlers?
    AND #$80
    STA background_processing_flag                    ; note this in background_processing_flag
.L3779
    DEC plotter_x ; strip_length_two
    BMI done_strip_plotting
    JSR determine_background                    ; this actually plots for movement and teleporting
    LDX plotter_x ; strip_length_two
    STA background_strip_cache_sprite,X            ; cache the background
    LDA square_orientation
    STA background_strip_cache_orientation,X
.L378A
    INC square_x ; actually &95|&97 square_[x|y], modified by &375e
    JMP L3779 ; loop over the entire strip
.done_strip_plotting
    PLA
    TAX
    PLA
    STA square_is_mapped_data,X ; actually LDA &95|&97 square_[x|y]     ; preserve square_[x|y]
    RTS
.do_player_stuff
    JSR double_acceleration
    BIT loop_counter_every_10                         ; every &10 cycles,
    BPL L37AC
    LDA this_object_energy                            ; heal the player by &04 energy
    ADC #$04
    BCS L37A4 ; avoiding overflow
    STA this_object_energy
.L37A4
    LDX #$00 ; 0 = jetpack
    JSR make_firing_erratic_at_low_energy
    ROR player_can_move                             ; make the jetpack erratic when energy low
.L37AC
    LDA #$10
    SBC this_object_energy
    BCC L37B4 ; if player's energy < &10, set daze
    STA player_immobility_daze                        ; ie, we can't move when severely hurt
.L37B4
    LDA player_immobility_daze
    CMP #$06
    BCC L37BD ; if the player is dazed, we can't move
    LSR player_can_move
.L37BD
    LDA player_nothrust_daze
    BEQ L37C6
    DEC player_nothrust_daze
    LSR player_can_move
.L37C6
    LSR player_crawling
    LDA player_angle
    SEC
    SBC #$CF
    CMP #$E1
    ROR A
    AND something_about_player_angle
    STA something_about_player_angle
    LDA acceleration_y
    BNE L37F8
    LDA acceleration_x
    BNE L37E6
    LDA object_onscreen
    ORA collided_in_last_cycle
    ORA keys_pressed+ctrl_key_index
    STA player_crawling
.L37E6
    JSR compare_extra_with_a_and_f
    BCC L3810
    BIT any_collision_top_bottom
    BPL L37F8
    JSR L3225 ; dampen_this_object_vel_y
    JSR L3225 ; dampen_this_object_vel_y
    JSR L3225 ; dampen_this_object_vel_y
.L37F8
    BIT player_can_move
    BPL L3810
    JSR create_jetpack_thrust
    BEQ L3810
    LDA loop_counter_every_08
    ORA keys_pressed+boost_key_index ; @_pressed
    AND loop_counter_every_02
    BPL L3810
    LDX #$00
    JSR reduce_weapon_energy_for_x
.L3810
    LDA player_immobility_daze
    BEQ L3859
    DEC player_immobility_daze
    LDA player_angle
    ASL A
    STA zp_various_9c
    LDA wall_collision_post_angle
    BIT wall_collision_top_or_bottom                  ; has it collided with a wall?
    BMI L3829
    LDA something_player_collision_value
    BIT this_object_supporting
    BMI L3840
    LDA #$40
.L3829
    ASL A
    SEC
    SBC zp_various_9c
    ROR A
    PHP
    LDA wall_collision_frict_y_vel
    LSR A
    LSR A
    ORA #$01
    PLP
    JSR make_positive
    ADC something_player_collision_value
    LDY #$20
    JSR keep_within_range
.L3840
    BIT loop_counter_every_04
    BPL L384F
    CMP #$04
    BCC L384F
    CMP #$FD
    BCS L384F
    JSR seven_eights
.L384F
    STA something_player_collision_value
    CLC
    ADC player_angle
    STA player_angle
    JMP L38B9
.L3859
    LDA #$00
    LDX #$02
.L385D
    LDY acceleration_x,X
    STY velocity_x,X
    CPY #$01
    ROL A
    DEX
    DEX
    BEQ L385D
    TAX
    BEQ L3874
    BIT player_can_move
    BPL L3874
    JSR calculate_angle_from_velocities
    equb $2C; BIT &xxxx
.L3874
    LDA #$C0 ; &c0 = straight up
    BIT player_crawling
    BPL L3882
    LDA #$FD
    BIT player_facing
    BPL L3882
    LDA #$83
.L3882
    SBC player_angle
    TAY
    CPX #$02
    BNE L3893
    SBC #$74
    CMP #$18
    BCS L3893
    LDY #$00
    BEQ L389B
.L3893
    LDA acceleration_x
    BEQ L389B
    BIT something_about_player_angle
    BMI L389D
.L389B
    LDX #$00
.L389D
    JSR compare_extra_with_a_and_f
    TYA
    BCS L38A9
    BIT player_crawling
    BMI L38A9
    LDA #$00
.L38A9
    JSR shift_right_two_while_keeping_sign
    ADC player_angle
    STA player_angle
    EOR acceleration_x
    EOR #$80
    DEX
    BMI L38B9
    STA player_facing
.L38B9
    JSR L3A8F
    LDA player_can_move
    BMI L38CC
    JSR compare_extra_with_a_and_f
    LDA #$00
    STA acceleration_y
    BCC L38CC
    STA acceleration_x
.L38CC
    LDY player_facing
    LDA player_angle
.change_palettes_for_player_like_objects
    BIT child_created                                 ; has a child object been created?
    BMI L38D9
    STY zp_various_9e
    JSR something_from_player
.L38D9
    LDA current_object_rotator
    AND #$1F
    ASL A
    CMP this_object_energy
    PHP
    LDY this_object_type
    LDA object_sprite_lookup+101,Y ; object_palette_lookup
    AND #$7F
    LDY this_object_type
    BNE L38FC
    LDX #$05 ; 5 = protection suit
    JSR make_firing_erratic_at_low_energy           ; flashes at low energy
    ROR A
    AND protection_suit_collected                   ; but not if we've not got it
    ROL A
    LDA #$33 ; palette with suit
    BCS L38FC
    LDA #$3E ; palette without suit
.L38FC
    PLP
    BCC L3903
    LDA this_object_palette
    EOR #$0B ; palette changes when damaged
.L3903
    STA this_object_palette
    RTS
.something_from_player
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    ADC #$00
    BIT zp_various_9e
    BMI L3915
    EOR #$07
    ADC #$01
.L3915
    PHA
    AND #$04
    CMP #$04
    ROR A
    STA this_object_angle
    EOR zp_various_9e
    STA this_object_flags_lefted
    PLA
    AND #$03
    CMP #$02
    BNE L394B
    LDA this_object_vel_x
    JSR make_positive
    LSR A
    BEQ L3948
    JSR compare_extra_with_a_and_f
    LDA #$02
    BCS L394B
    LDA #$08
    JSR get_sprite_from_velocity
    LSR A
    PHA
    LDA this_object_vel_x
    EOR this_object_angle
    ROL A
    PLA
    BCC L3948
    EOR #$03
.L3948
    CLC
    ADC #$04
.L394B
    JMP convert_object_keeping_palette
.null_function

IF NOVELLA_LOOKUP = TRUE
.c394e
    ldy #&44 ; 'D'                                                              ; 4a4e: a0 44       .D  :394e[1]
    ldx #2                                                                      ; 4a50: a2 02       ..  :3950[1]
    jsr sub_c313e                                                               ; 4a52: 20 3e 31     >1 :3952[1]
.loop_c3955
    eor l0b63,y                                                                 ; 4a55: 59 63 0b    Yc. :3955[1]
    iny                                                                         ; 4a58: c8          .   :3958[1]
    dex                                                                         ; 4a59: ca          .   :3959[1]
    bne loop_c3955                                                              ; 4a5a: d0 f9       ..  :395a[1]
    eor l07e7,y                                                                 ; 4a5c: 59 e7 07    Y.. :395c[1]
    bne c394e                                                                   ; 4a5f: d0 ed       ..  :395f[1]
    rts                                                                         ; 4a61: 60          `   :3961[1]
ELSE
    RTS
;;  (unused)
    equb $00
IF SRAM
    equb $00
ENDIF
    equs "(C) 1989BEEBSOFT"
    equb $00
IF SRAM=0
    equb $00
ENDIF
ENDIF

.unknown_lookup_3962
    equb $32,$80,$80,$20,$20,$20,$80
.unknown_lookup_3969
    equb $06,$08,$10,$03,$04,$05,$08
    equb $00,$01,$01,$01,$01,$01,$01; unknown_lookup_3970       ; these two are
    equb $EA,$C8,$C8,$10,$00,$00,$C8; unknown_lookup_3977       ; something to do with bouncing / tunneling
    equb $EA,$40,$08,$08,$00,$00,$10; unknown_lookup_397e       ; something to do with sprite changing
;;        0  1  2  3  4  5  6
;;             fl sl tu    mg
;; unknown_lookup_3970  ; these two are
;; unknown_lookup_3977  ; something to do with bouncing / tunneling
;; unknown_lookup_397e  ; something to do with sprite changing
.find_wall_underneath_y
    LDA this_object_width                               ; get centre of object
    LSR A
    ADC this_object_x_low
    STA this_object_x_centre_low_OR_particle_x_low ; this_object_centre_x_low                   ; into this_object_centre_x_low
    LDA this_object_x
    ADC #$00
    STA square_x                                        ; and square_x
    LDA this_object_y_max_low                           ; get bottom of object
    STA this_object_y_centre_low_OR_particle_y_low ; this_object_centre_y_low                   ; into this_object_centre_y_low
    LDA this_object_y_max
    STA square_y                                        ; and square_y
    BNE no_recalculate_centres                  ; assuming it's well defined
.recalc_called_from_bob_up_and_down
    JSR get_object_centre
    LDA this_object_x_centre_low_OR_particle_x_low ; this_object_centre_x_low                   ; otherwise...
    SBC #$7F
    STA this_object_x_centre_low_OR_particle_x_low ; this_object_centre_x_low
    LDA this_object_x_centre_OR_particle_x ; this_object_centre_x
    SBC #$00
    STA square_x
    JSR L3B77
    BMI L39B2
    INC square_x
.L39B2
    LDA this_sprite_width
    LSR A
    ADC this_object_y_max_low
    PHP
    SBC #$7F
    STA this_object_y_centre_low_OR_particle_y_low ; this_object_centre_y_low
    LDA this_object_y_max
    SBC #$00
    PLP
    ADC #$00
    STA square_y
.no_recalculate_centres
    STX plotter_x ; tmp_x                                         ; preserve x
    LDA this_object_x_centre_low_OR_particle_x_low ; this_object_centre_x_low
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    TAY ; Y = x_low / 32, for wall check
    LDA #$00
    STA distance_OR_wall_sprite_4 ; bob_y_low
    LDA #$40
    STA background_processing_flag
    LDA this_object_y_centre_low_OR_particle_y_low ; this_object_centre_y_low                      ; consider the bottom of the object
    AND #$F8
    ORA #$04
.L39DD
    STA support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4 ; square_y_low
    STY zp_various_9e ; square_x_low
    JSR get_wall_start_7c_7f
    LDY zp_various_9e ; square_x_low                                  ; previously calculated Y
    LDA (support_delta_x_OR_wall_y_start_lookup_pointer),Y ; wall_y_start_lookup_pointer               ; is there a wall there?
    CLC
    ADC support_delta_y_OR_wall_y_start_base
    BCC L39EF
    LDA #$FF
.L39EF
    TAX ; x = wall start
    CMP support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4 ; square_y_low
    ROR A
    EOR support_overlap_x_low_OR_wall_sprite
    BPL bob_wall_present                            ; if so, leave
    BIT support_overlap_x_low_OR_wall_sprite
    BPL L3A0B
.L39FB
    LDA support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4 ; square_y_low
    EOR #$FF
    ADC distance_OR_wall_sprite_4 ; bob_y_low
    BCS L3A15
    STA distance_OR_wall_sprite_4 ; bob_y_low
    INC square_y
    LDA #$04
    BNE L39DD
.L3A0B
    TXA
    INX
    BEQ L39FB
    SBC support_overlap_y_low_OR_wall_y_start_lookup_pointer_h_4
    ADC distance_OR_wall_sprite_4 ; bob_y_low
    BCC L3A17
.L3A15
    LDA #$FF
.L3A17
    STA distance_OR_wall_sprite_4 ; bob_y_low
.bob_wall_present
    LDX plotter_x ; tmp_x
    LDA distance_OR_wall_sprite_4 ; bob_y_low
    RTS
.bob_up_and_down
    BIT loop_counter_every_04
    BPL L3A53 ; once every four cycles
    LDA this_object_height
    EOR #$FF
    LSR A
    STA stack_object_y_centre_low ; half_minus_height
    JSR find_wall_underneath_y                      ; where is the wall underneath us?
    CMP #$FF
    BEQ no_wall_underneath
    CMP stack_object_y_centre_low ; half_minus_height
    BCS L3A53
    JSR increment_timers
    ORA #$C0
    ADC distance_OR_wall_sprite_4 ; bob_y_low
    BCS L3A3F
    DEC acceleration_y                                ; green slimes bob up and down
.L3A3F
    DEC acceleration_y
.no_wall_underneath
    DEC acceleration_y                                ; and float somewhat
    JMP L3225 ; dampen_this_object_vel_y
.L3A46
    BIT loop_counter_every_04
    CLC
    BPL L3A53 ; once every four cycles
    JSR recalc_called_from_bob_up_and_down
    SEC
    BEQ L3A53
    CMP #$FF
.L3A53
    RTS
.L3A54
    JSR compare_extra_with_1_and_f
    BCS L3A53
.L3A59
    LDA npc_speed                                     ; velocity magnitude
.L3A5B
    TAY ; maximum speed
    STX plotter_x
    JSR move_towards_target
    LDX plotter_x
    LDA acceleration_y
    SBC #$0A
    STA acceleration_y
    CLC
.L3A6A
    JMP or_extra_with_0f
.L3A6D
    BIT something_about_player_angle
    BPL L3A6A
    LDA wall_collision_top_or_bottom                  ; has it collided with a wall?
    ORA object_collision_with_other_object_top_bottom
    SEC
    BPL L3A7C
    JSR compare_wall_collision_angle_with_3962
.L3A7C
    LDA this_object_extra
    AND #$F0
    BCC L3A8C
    EOR this_object_extra
    CMP #$0F
    BCS L3A6A
    INC this_object_extra
    LDA this_object_extra
.L3A8C
    STA this_object_extra
    RTS
.L3A8F
    LDA #$1F
    STA npc_speed
    LDA current_object_rotator_low
    CMP #$02
    LDA this_object_weight
    SBC #$05
    TAY
    BCC L3ABD
    JSR compare_extra_with_a_and_f
    BCC L3ABD
    BIT any_collision_top_bottom
    BMI L3ABD
.L3AA7
    LDX #$02
.L3AA9
    LDA acceleration_x,X
    CMP #$80
    ROR A
    BPL L3AB2
    ADC #$00
.L3AB2
    STA acceleration_x,X
    DEX
    DEX
    BEQ L3AA9
    DEY
    BPL L3AA7
    BMI L3B0B
.L3ABD
    LDA #$0F
    INY
.L3AC0
    LSR A
    DEY
    BPL L3AC0
    ADC #$01
    LDY acceleration_x
    STY something_x_acc
    BNE L3AD0
    STY npc_speed
    LDA #$01
.L3AD0
    STA unknown_lookup_3969
    LDX #$00
    JSR compare_extra_with_a_and_f
    BCS L3ADC
    STX acceleration_x
.L3ADC
    JMP L3B0B
;;  commenting this out stops slime from moving
;;  turret x = &04 a = &18
;;  slime  x = &03 a = &0c
;;  fluffy x = &02 a = &28
;;  maggot x = &06 a = &08
;;  A = speed
;;  X = type
.something_motion_related
    STA npc_speed
.L3AE1
    JSR some_other_npc_stuff
    JSR L3A46
    BCC L3AFC
    JSR increment_timers
    CMP unknown_lookup_3969+14,X ; unknown_lookup_3977
    BCC L3B04
    LDA #$01
    BIT something_x_acc
    JSR make_negative
    ADC this_object_x
    STA this_object_tx
.L3AFC
    JSR increment_timers
    CMP unknown_lookup_3969+21,X ; unknown_lookup_397e
    BCS L3B07
.L3B04
    JMP L3A54
.L3B07
    RTS
.some_other_npc_stuff
    JSR L3B77
.L3B0B
    JSR L3A6D
    AND #$0F
    BNE L3B85
    LDY unknown_lookup_3969,X
    STY zp_various_9c
    LDY unknown_lookup_3969+7,X ; unknown_lookup_3970
    JSR compare_wall_collision_angle_with_3962
    SBC #$2C
    CMP #$28
    LDA npc_speed
    BCC L3B5B
    BIT something_x_acc
    JSR make_positive
    SEC
    SBC this_object_vel_x
    JSR speed_limit
    TAY
    AND #$80
    EOR wall_collision_angle
    ADC #$40
    ASL A
    LDA something_x_acc
    BNE L3B3E
    LDY #$00
.L3B3E
    LDA #$10
    BCC L3B44
    LDA #$6F
.L3B44
    ADC wall_collision_angle
    STA angle
    TYA
    JSR make_positive
    JSR determine_velocities_from_angle         ; A = velocity_y
    STA acceleration_y
    LDA velocity_x
    STA acceleration_x
    JSR L3225 ; dampen_this_object_vel_y
    JMP L3225 ; dampen_this_object_vel_y
.L3B5B
    BIT something_y_acc
    JSR make_positive
    LDX #$02
    JSR speed_up
    LDA #$08
    BIT wall_collision_angle
    JSR make_negative
    STA acceleration_x
    JSR L322D ; dampen_this_object_vel_x
    JSR L322D ; dampen_this_object_vel_x
    JMP L322D ; dampen_this_object_vel_x
.L3B77
    LDA this_object_ty
    CLC
    SBC this_object_y
    STA something_y_acc
    LDA this_object_tx
    SEC
    SBC this_object_x
    STA something_x_acc
.L3B85
    RTS
.compare_extra_with_1_and_f
    JSR compare_extra_with_a_and_f
    CMP #$01
    RTS
.compare_extra_with_a_and_f
    LDA this_object_extra
    AND #$0F
    CMP #$0A
    RTS
.p_pressed
    JSR compare_extra_with_a_and_f
    CMP #$05
    BCS L3BCC
    LDA #$F6
    BIT keys_pressed+boost_key_index ; @_pressed                                   ; is the booster pressed?
    BPL L3BA3
    LDA #$F0
.L3BA3
    ADC this_object_weight
    ASL A
    ADC this_object_vel_y
    STA this_object_vel_y
    LSR something_about_player_angle
    RTS
.compare_wall_collision_angle_with_3962
    LDA wall_collision_angle
    JSR make_positive
    CMP unknown_lookup_3962,X
    RTS
.get_biggest_velocity
    LDA this_object_vel_y
    JSR make_positive
    TAY
    LDA this_object_vel_x
    JSR make_positive
.get_biggest_of_a_and_y
    STY zp_various_9d
    CMP zp_various_9d
    BCS L3BCC
    TAY
    LDA zp_various_9d
    STY zp_various_9d
.L3BCC
    RTS
.return_sign_as_01_or_ff
    ASL A
    LDA #$FF
    BCS L3BCC
    LDA #$01
    RTS
.can_we_pick_up_object
    LDX this_object_supporting                  ; are we touching anything?
    BMI L3BE0 ; if not, leave
    JSR get_angle_between_objects                   ; get the angle between us and it
    ADC #$40 ; ninety degrees
    EOR this_object_angle                             ; are we facing it?
.L3BE0
    RTS
.absorb_object
    LDY this_object_supporting
    CMP object_stack_type,Y                        ; consider the object we're supporting
    BNE L3BF7 ; is it what we want? if not, leave
    JSR can_we_pick_up_object
    BMI L3BF7 ; if we're not supporting anything, leave
    LDY this_object_supporting
    JSR mark_stack_object_for_removal
    JSR play_low_beep
    LDA #$00 ; return nothing if collected
.L3BF7
    RTS
;;  A, Y => find
.find_target_occasionally
    LDX current_object_rotator_low
    CPX #$0F
    BMI L3C17 ; once every sixteen cycles
.find_target
    JSR find_nearest_object                         ; find nearest object as per A, Y
    BMI L3C17 ; if nothing found, leave
    STX this_object_target_object
    LDA #$40
    BNE L3C15
.avoid_fireballs
    LDA #$37 ; &37 = fireball
    TAY ; look only for fireballs
.avoid_a
    JSR find_target_occasionally
    BMI L3C17
.flag_target_as_avoid
    LDA this_object_target
    ORA #$20
.L3C15
    STA this_object_target
.L3C17
    RTS
;;  A = object type
;;  leaves with Y = count
.count_objects_of_type_a_in_stack
    LDY #$7F
    SEC
    JSR in_find_nearest_object
    LDY number_particles_OR_this_object_gravity_flags ; count
    RTS
.find_object_probabilities
    equb $80,$FF,$20,$80
.nearest_object
    equb $00
.find_first_7f
    equb $00
.find_second
    equb $00
.nearest_distance
    equb $00
.find_first
    equb $00
;;  A & &80 : note player too
;;  A & &7f = object type to look for
;;  Y & &80 : consider objects in range too
;;  Y & &7f = object range to look for
;;  else Y &7f = second object type to look for
;;  if carry set, simply count the number of matching objects in primary stack, return in &9f
;;  if carry clear, find the nearest matching object and return number in X
.find_nearest_object
    CLC
.L3C2B
    BIT this_object_weight
    ROR zp_various_9b ; weight_bit
    CLC
.in_find_nearest_object
    ROR find_carry                                    ; note whether we're finding or counting
    STA find_first
    AND #$7F
    STA find_first_7f
    STY find_second
    LDX #$FF
    STX nearest_object                              ; initially &ff
    STX nearest_distance                            ; initially &ff
    INX
    STX zp_various_a0 ; result                                        ; initially &00
    STX number_particles_OR_this_object_gravity_flags ; count                                         ; initially &00
    JSR increment_timers
    AND #$0F
    STA zp_various_a3 ; rnd_0f                                        ; get a random number &00 - &0f
    LDY #$0F
.find_object_object_loop
    STY zp_various_9e ; y_store                                       ; starting at that random place
    TYA
    EOR zp_various_a3 ; rnd_0f
    TAY
    LDA object_stack_y,Y                           ; consider the objects in turn
    BEQ find_object_next_object                     ; does it exist? if not, move to next
    CPY current_object
    BEQ find_object_next_object                     ; don't consider the npc
    LDA object_stack_type,Y
    BNE find_object_object_not_player               ; is the object the player?
    BIT find_first
    BMI L3C71 ; if find_first & &80, then note that in result
.find_object_object_not_player
    CMP find_first_7f                               ; is it the type we're interested in?
    BNE find_object_not_special
.L3C71
    LDA zp_various_a0 ; result
    ORA #$01 ; if so, note it in the result
    BNE find_object_found_one
.find_object_not_special
    BIT find_second
    BPL find_object_y_positive
    JSR convert_object_to_range_a                   ; returns object range in X
    TXA
    ORA #$80 ; A = range | &80
.find_object_y_positive
    CMP find_second                                 ; in other words, if in_Y & &80
    BNE find_object_next_object                     ; only count results not in our range
    LDA zp_various_a0 ; result                                        ; (the range set by find_second &7f)
    AND #$02 ; clear bottom bit of result
.find_object_found_one
    AND #$03
    STA zp_various_a0 ; result
    TAX
    INC number_particles_OR_this_object_gravity_flags ; count                                         ; count contains total number of matches
    BIT find_carry                                    ; was the carry set when function called?
    BMI find_object_next_object                     ; if so, move on to the next object
    JSR increment_timers
    CMP find_object_probabilities,X                ; X = result
    BCS find_object_next_object                     ; a random chance based on result to skip
    TYA
    TAX ; X = object being considered
    BIT zp_various_9b ; weight_bit
    BPL L3CB2 ; find_object_unset_weight_bit
    LDA #$00
    JSR is_object_close_enough                      ; get distance to object
    LDA distance_OR_wall_sprite_4 ; distance
    CMP nearest_distance                            ; is it nearer than earlier finds?
    BCC find_object_store_distance                  ; if nearer, store it
    BCS find_object_next_object                     ; if further away, ignore it
.L3CB2
    JSR increment_timers
    AND #$4F
    EOR nearest_distance
    JSR is_object_close_enough                      ; otherwise, pick one at random
    BCS find_object_next_object
    LDA distance_OR_wall_sprite_4 ; distance
.find_object_store_distance
    STA nearest_distance
    ASL zp_various_a0 ; result
    STX nearest_object
.find_object_next_object
    LDY zp_various_9e ; y_store                                       ; move on to considering the next object
    DEY
    BPL find_object_object_loop                     ; until we've done all sixteen
    LSR zp_various_a0 ; result
    LSR zp_various_a0 ; result                                        ; carry set to be result & &02
    LDX nearest_object
    RTS
.compare_this_object_x_y_tx_ty
    LDA this_object_ty
    CMP this_object_y
    BNE L3CE0
    LDA this_object_tx
    CMP this_object_x
.L3CE0
    RTS
.angle_randomness
    equb $00
.angle_minus_half_angle_randomness
    equb $00
.best_distance
    equb $00
.best_angle
    equb $00
.route_chooser_loop
    equb $00
;;  returns X = target
.do_we_have_a_target
    LDX this_object_target_object                     ; consider our target object
    LDA object_stack_y,X
    BNE L3CF3 ; does it exist?
    LDX current_object
    STX this_object_target_object                     ; if not, set target to be ourself
    STX this_object_target
.L3CF3
    CPX current_object                                ; do we have a target?
    RTS
;;  if our target is close, flag with &80 and &40; if avoiding, flee
;;  if too far and &80 set, unflag both &80 and &40
.set_targetting_flags
    LDA current_object_rotator_low
    BNE L3D25 ; once every sixteen cycles
    JSR do_we_have_a_target                         ; X = target
    BEQ no_target_3d36                                   ; if no target, leave
    JSR is_object_close_enough_80
    BCS target_too_far                              ; is our target close enough?
    LDA this_object_target
    ORA #$C0 ; if so, flag with &80 and &40
    STA this_object_target
    AND #$20
    BNE avoiding_target                             ; are we avoiding the target?
    JMP get_object_x_y_to_tx_ty                     ; if not, store its position in tx, ty
.avoiding_target
    JSR get_angle_between_objects                   ; get the angle between us and the target
    EOR #$80 ; use the opposite direction
    STA angle
    LDA #$7F ; angle randomness = &7f
    JMP choose_route_to_target_a
.target_too_far
    LDA this_object_target
    BPL L3D25 ; if &80 set, unflag both &80 and &40
    AND #$BF
    STA this_object_target
.L3D25
    RTS
.target_processing
    JSR set_targetting_flags                        ; set flags if close enough
    BIT this_object_target                            ; have we got a target?
    BMI L3D31 ; target &80
    BVC L3D68 ; target &c0 = &00
    BVS L3D40 ; V = bit 6 = &40
;;  target &c0 = &c0 or &80
.L3D31
    JSR possibly_get_speed_to_y_based_on_same_square
    BNE L3D3F ; generally leave with A = &07 or A = &3f
.no_target_3d36
    SEC
    LDA this_object_target
    SBC #$40 ; &c0 becomes &80, &80 becomes &40, &40 becomes &00
    BCC L3D3F
    STA this_object_target
.L3D3F
    RTS
;;  target &c0 = &40
.L3D40
    JSR increment_timers
    AND #$03
    BEQ L3D68 ; no_target                                   ; one in four chance to drop a notch
    LSR A
    ORA timer_2
    BEQ no_target_3d36
    JSR possibly_get_speed_to_y_based_on_same_square_with_bit_1b
    BNE L3DA4
    LDX this_object_target_object
    LDA #$20 ; magnitude
    JSR get_object_centre_and_determine_velocities_from_angle
    LDA this_object_target
    AND #$20
    BEQ L3D64
    LDA angle
    EOR #$80
    STA angle
.L3D64
    LDA #$3F ; angle randomness = &3f
    BNE choose_route_to_target_a
;;  target &c0 = &00
.L3D68
    JSR possibly_get_speed_to_y_based_on_same_square_with_bit_1b
    BNE L3DA4 ; rotator
    JSR increment_timers
    AND #$07
    SBC #$03
    ADC this_object_vel_x
    STA velocity_x                                    ; velocity_x = object_vel_x + rnd(4) - 7
    LDA timer_1
    AND #$07
    SBC #$03
    ADC this_object_vel_y                             ; velocity_y = object_vel_y + rnd(4) - 7
    JSR L22D2 ; essentially calculate_angle_from_velocities
    LDA #$FF
    LDX timer_2                                       ; randomly pick an angle randomness:
    CPX #$08
    BCC L3D91 ; &08 probability that A = &ff
    LSR A
    CPX #$40 ; &38 probability that A = &7f
    BCC L3D91
    LSR A ; &c0 probability that A = &3f
.L3D91
    JMP choose_route_to_target_a
.possibly_get_speed_to_y_based_on_same_square_with_bit_1b
    BIT wall_collision_top_or_bottom                  ; has it collided with a wall?
    BMI L3D9F
;;  target_&c0 = &80
.possibly_get_speed_to_y_based_on_same_square
    LDY #$3F
    JSR compare_this_object_x_y_tx_ty           ; are we at our target?
    BNE L3DA1
.L3D9F
    LDY #$07
.L3DA1
    TYA
    BIT current_object_rotator
.L3DA4
    RTS
.choose_route_to_target
    LDA #$FF
.choose_route_to_target_a
    STA angle_randomness                            ; angle_randomness = A
    LSR A
    STA zp_various_9d ; half_angle_randomness
    LDA angle
    SBC zp_various_9d ; half_angle_randomness
    STA angle_minus_half_angle_randomness
    LDA #$04
    STA route_chooser_loop
    STA best_distance
.choose_route_loop
    JSR increment_timers                            ; consider four random angles
    AND angle_randomness
    ADC angle_minus_half_angle_randomness
    STA angle                                         ; angle +/- rnd(angle_randomness / 2)
    PHA
    LDA #$20 ; magnitude
    JSR determine_velocities_from_angle
    JSR increment_timers
    AND #$1F ; consider a random distance &10 - &3f
    ADC #$10
    LSR los_consider_water                          ; ignore water
    JSR line_of_sight_without_obstructions          ; are there any obstacles over that distance?
    PLA
    BCC store_square_x_y_in_tx_ty                   ; if not, we've got a route - use it
    LDX distance_OR_wall_sprite_4 ; distance
    CPX best_distance
    BCC L3DEA ; is this route better than our best?
    STX best_distance                               ; if so, note it as the best so far
    STA best_angle
.L3DEA
    DEC route_chooser_loop
    BNE choose_route_loop                           ; if none offer a direct route
    LDA best_angle                                  ; pick the one with the maximum distance
    STA angle
    LDA #$20
    JSR determine_velocities_from_angle
    LDA best_distance
    CMP #$0A
    BCC L3E0D ; leave if it's a really short distance
    SBC #$08 ; otherwise move almost to the obstacle
    JSR line_of_sight_without_obstructions          ; note the destination square as our target
.store_square_x_y_in_tx_ty
    LDA square_x
    STA this_object_tx
    LDA square_y
    STA this_object_ty
.L3E0D
    RTS
IF SRAM=0
    RTS
ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF SRAM
.sram_ram_end
org $99ec
.sram_rom_begin
ENDIF

IF SRAM

; X = sound to play
.smp_play
    PHP 
    TYA 
    PHA 
    CPX smp_current_sound       ; compare to existing sound being
                                ; played, if any
    BCS M3EC7                   ; branch taken if new sound id is g/e
                                ; (so I guess sound ID encodes
                                ; priority too...)
    JSR get_object_distance_from_screen_centre
    CMP #$20
    BCS M3EC7                   ; cull by distance - branch taken if
                                ; object is too far away
    LSR A                       ; scale to 0-15 to get volume - 0
                                ; (near)=max, 15 (far)=silence
    ORA #$90                    ; mask in sound chip command: set tone
                                ; 3 volume
    STA smp_default_volume_cmd  ; save this
    STX smp_current_sound       ; save playing sound id
    TXA 
    ASL A                       ; sound id * 2
    TAX                         ; X = sound id * 2
    SEI

;; book channel 3 for the sample playback

    LDA #$02
    STA sound_max_channels
    LDA #$00
    STA sound_duration_low+3

;; get address of sample data and pop it in M3EE4. (TOC is 7 words at
;; $8100.)

    CLC 
    LDA $8100,X
    ADC #$00
    STA smp_prepare_byte+1
    LDA $8101,X
    ADC #$81
    STA smp_prepare_byte+2

;; set up user VIA

    LDA #%11000000              ; enable T1
    STA $FE6E                   ; enable user VIA T1

;; a frequency of 1 sets the chip constantly outputting +1 on that
;; channel - the volume is then be tweaked to get the desired
;; waveform. It's only 1 byte to change the volume.

    LDA #$81                    ; tone 3 frequency = xxxxxx001
    JSR push_sound_to_chip
    LDA #$00                    ; tone 3 frequency = 000000001
    JSR push_sound_to_chip

;; set T1 to $0001 to get an IRQ just after the PHP below.

    LDX #$01
    STX $FE64
    DEX 
    STX $FE65
    JSR smp_prepare_byte                        ; get first sample data byte
 .M3EC7
    PLA
    TAY
    PLP
    RTS

.smp_next_delay
    equb $00

;; Volume command to set on next T1 IRQ
.smp_next_volume_cmd
    equb $00

;; Last byte retrieved from the sample data
.smp_byte
    equb $00

;; If bit 7 is set, the high nybble of smp_byte has been processed (N
;; samples of silence) and the low nybble (N samples of noise) needs
;; doing. Otherwise, fetch a new byte.
.smp_do_low_nybble
    equb $00

;; Default volume command to use, based on object distance
.smp_default_volume_cmd
    equb $00

;; Seemingly unused
.M9A47
    equb $00

;; Current sound being played, or $ff for none
.smp_current_sound
    equb $ff


;; Sample data format is a series of bytes, arranged as two nybbles
;; each, encoding a ~7812Hz sample.
;;
;; If the byte is 0, that's the end of the data.
;;
;; If the low nybble is 15, the entire byte encodes 15-255 samples of
;; silence.
;;
;; Otherwise, the high nybble encodes the number of samples of
;; silence, and the low nybble encodes the number of samples of
;; non-silence.

.smp_next_byte
    BIT game_paused
    BPL smp_prepare_byte        ; taken if game paused
    BIT smp_do_low_nybble               ; do next nybble, or advance to next byte
    BMI smp_low_nybble                  ; branch taken if doing next nybble
    
;; fetch next byte of data with preincrement

    INC smp_prepare_byte+1
    BNE smp_prepare_byte
    INC smp_prepare_byte+2
.smp_prepare_byte LDA $8100     ; filled in with actual address of next byte

    BEQ smp_playback_done       ; if data byte was 0, sample is done
    STA smp_byte                ; save data byte
    AND #$0F                    ; get low nybble
    CMP #$0F
    LDA smp_byte                ; get data byte
    BCS smp_silence             ; taken if low nybble 15 - it's
                                ; silence, and entire data byte is the
                                ; delay

;; get high nybble

    LSR A                       ; >>1
    LSR A                       ; >>2
    LSR A                       ; >>3
    LSR A                       ; >>4
    BEQ smp_low_nybble          ; taken if high nybble is 0

;; (data&15)<15&&(data&0xf0)!=0

    SEC 
    ROR smp_do_low_nybble       ; do low nybble next time
    
.smp_silence
    LDY #$9F                    ; silence (tone 3 volume = %1111)
    JMP M3F0F                   ; tut... why not BNE?
    
.smp_low_nybble
    LDA smp_byte                ; get data byte
    AND #$0F                    ; get bottom 4 bits
    LSR smp_do_low_nybble       ; fetch a new byte next time
    LDY smp_default_volume_cmd  ; get volume command to use
.M3F0F
    STA smp_next_delay          ; 
    BIT volume                  ; sound on?
    BMI M3F19                   ; taken if so
    LDY #$9F                    ; volume command = silence
.M3F19
    STY smp_next_volume_cmd     ; save volume command
    RTS
    
.smp_playback_done
    LDA #$7F                    ; disable all user VIA interrupts
    STA $FE6E                   ; disable all user VIA interrupts

;; back to 3 channels again

    LDA #$00
    STA sound_duration+3
    STA sound_duration_low+3
    LDA #$03
    STA sound_max_channels
    LDA #$FF
    STA smp_current_sound
    RTS 

ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.push_palette_register_data
    LDY #$10
.L3E11
    LDA palette_register_updating,Y ; palette_register_data
    STA $FE21 ; video ULA palette register
    DEY
    BNE L3E11
    RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; routine addresses in object_handler_table are stored relative to
; this point.
.handlers_start

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_emerging
    BEQ L3E88 ; is object_data_pointer = 0? if so, leave
    LDX #$05
    LDA background_processing_flag
    AND #$90
    BEQ L3E48
    BPL L3E29
    LDX #$00
.L3E29
    LDA square_orientation
    ASL A
    LDA background_objects_data,Y
    BPL L3E4D ; is the object already present?
    PHP
    TXA
    PHA
    LDA #$40 ; &40 = bush
    JSR pull_objects_in_from_tertiary_stack
    LDA #$40
    STA object_stack_y_low,Y
    STA object_stack_x_low,Y
    LDY new_object_data_pointer
    PLA
    TAX
    PLP
    BMI L3E4D
.L3E48
    JSR increment_timers
    CMP #$F7
.L3E4D
    BCC L3E88
.into_tertiary_pull_in
    STX zp_various_a2
    LDA background_objects_data,Y
    STA zp_various_a3
    ASL A
    CMP #$08
    BCC L3E88
    AND #$06
    BNE L3E88
    LDX new_object_type_pointer
    LDA background_objects_type,X
    LDY zp_various_a2
    STA zp_various_a2
    JSR pull_objects_in_from_tertiary_stack_alt
    LDA zp_various_a3
    SBC #$03
    STA background_objects_data,X
    LDA #$05
    STA object_stack_flags,Y
    LDX zp_various_a2
    LDA object_sprite_lookup,X
    TAX
    LDA sprite_width_lookup,X
    EOR #$FF
    LSR A
    STA object_stack_x_low,Y
    CLC
.L3E87
    RTS
.L3E88
    SEC
    RTS
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_engine_thruster
    BEQ L3E87 ; is object_data_pointer = 0? if so, leave
    LDA #$3B ; &3b = engine thruster
    JMP pull_objects_in_from_tertiary_stack
.door_square_sprite_lookup
    equb $17,$19,$2A,$19
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_stone_door
    LDA #$3E ; &3e = horizontal stone door
    equb $2C; BIT &xxxx
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_door
    LDA #$3C ; &3c = horizontal door
    STA zp_various_9c ; door_type
    CPY door_data_pointer_store
    BEQ L3EE2 ; if so, leave
    LDA square_orientation
    ASL A
    ROL A
    ADC #$00
    AND #$01
    PHA
    LDA background_objects_data,Y
    BMI L3EB0
    LSR A
.L3EB0
    AND #$02
    LSR A
    SBC #$00
    STA zp_various_a3
    LDA background_processing_flag
    BMI L3EC4
    PLA
    PHA
    ROL A
    TAX
    LDA door_square_sprite_lookup,X
    STA square_sprite
.L3EC4
    PLA
    BIT background_processing_flag
    BVS L3EE2 ; if so, leave
    PHA
    CLC
    ADC zp_various_9c ; door_type
    JSR pull_objects_in_from_tertiary_stack
    PLA
    ASL A
    STA object_stack_ty,Y
    TAX
    LDA square_x,X
    SBC #$00
    STA object_stack_extra,Y
    LDA zp_various_a3
    STA object_stack_tx,Y
.L3EE2
    RTS
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_teleport_beam
    LDA #$41 ; &41 = teleport beam
    JSR pull_objects_in_from_tertiary_stack
    LDA #$40
    STA object_stack_x_low,Y
    ASL A
    STA object_stack_y_low,Y
.L3EF1
    RTS
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_invisible_switch
    LDX new_object_type_pointer
    LDA background_objects_type,X
    BMI L3EFD ; is it offscreen?
    CMP this_object_type                                ; if not, is it the current object?
    BNE L3EF1 ; if not, leave
.L3EFD
    LDY current_object
    JSR can_object_trigger_switch
    BCC L3EF1 ; if not, leave
    LDY new_object_data_pointer
    LDA background_objects_data,Y
    PHA
    LSR A
    ORA #$FC
    EOR #$03
    TAX
    PLA
    BCS L3F15
    AND #$F8
.L3F15
    JMP switch_effects
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_random_wind
    BIT this_object_water_level                       ; is the square underwater?
    BMI L3EF1 ; if so, leave
    BIT square_orientation
    BPL L3F24
    LDA #$70 ; fixed velocity if square inverted
    BPL L3F47
.L3F24
    LDA loop_counter
    ROL A
    ROL A
    STA angle
    LDA timer_2
    AND #$1F
    EOR square_y
    ASL A
    AND #$7F
    BIT square_x
    BPL L3F3B
    AND #$3F
    ADC #$28
.L3F3B
    JSR determine_velocities_from_angle
    JMP L3F4F ; becomes reserve_object_for_background
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_fixed_wind
    TYA ; Y = new_object_data_pointer
    BEQ L3F9D ; if no data, do something ?
    LDA background_objects_data,Y                  ; the data encodes the wind direction
.L3F47
    STA velocity_y
    ASL A
    ASL A
    ASL A
    ASL A
    STA velocity_x
.L3F4F
    JSR reserve_object_for_background
    BNE L3FB6 ; if so, leave
    LDX #$02
.L3F56
    LDY this_object_weight
    CPY #$04
    BCS L3F5D
    INY
.L3F5D
    BIT this_object_water_level
    BPL L3F62
    INY
.L3F62
    BIT underwater
    BPL L3F6C
    LDA loop_counter
    AND #$10
    BEQ L3FB6
.L3F6C
    JSR L3F94
    DEX
    DEX
    BEQ L3F56
.do_wind_motion
    JSR calculate_angle_from_velocities
    LDA timer_2
    LSR A
    CMP some_kind_of_velocity
    BCS L3FB6 ; if so, leave
    LDY #$6E ; &6e = wind particles
.add_wind_like_particles
    LDX #$02
.L3F81
    LDA this_object_x_low,X ; X = 2, &51 this_object_y_low ; X = 0, &4f this_object_x_low
    SBC #$40
    STA this_object_x_centre_low_OR_particle_x_low,X ; X = 2, &89 this_object_y_centre_low; X = 0, &87 this_object_x_centre_low
    LDA this_object_x,X ; X = 2, &55 this_object_y ; X = 0, &53 this_object_x
    SBC #$00
    STA this_object_x_centre_OR_particle_x,X ; X = 2, &8c this_object_y_centre; X = 0, &8b this_object_x_centre
    DEX
    DEX
    BEQ L3F81
    JMP add_particle                            ; wind particles
.L3F94
    LDA #$0C
    STA zp_various_9c
    LDA velocity_x,X ; velocity_[x|y]
    JMP speed_up
.L3F9D
    LDA loop_counter
    AND #$10
    BNE L3FB6
;;  A = &0d, water
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_water
    JSR reserve_object_for_background
    BNE L3FB6
    LDA square_orientation
    ASL A
    ROL A
    ROL A
    TAX
    LDA water_orientation_lookup,X
    BNE L3F47
    SEC
    ROR intro_one
.L3FB6
    RTS
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_from_type
    LDX new_object_type_pointer
    LDA background_objects_type,X
    JMP pull_objects_in_from_tertiary_stack
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_from_data
    LDA background_objects_data,Y
    AND #$7F
    JSR pull_objects_in_from_tertiary_stack
    LDA #$49 ; &49 = placeholder
    STA object_stack_type,Y
    RTS
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_switch
    LDA #$42 ; &42 = switch
    JMP pull_objects_in_from_tertiary_stack
;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_mushrooms
    LDX #$33 ; &33 = red mushroom ball
    BIT square_orientation
    BVC L3FD9
    INX ; or blue if &09 & &80.
.L3FD9
    JSR reserve_object_for_background_type_X
    BEQ L3FEA
    BCS L3FE9
    BIT square_orientation
    BVC L3FE6
    LDA #$00
.L3FE6
    STA object_stack_y_low,Y
.L3FE9
    RTS
.L3FEA
    LDA square_orientation
    ASL A
    ASL A
    LDY current_object
.consider_mushrooms_and_player
    TYA
    BNE L3FF9 ; is it the player?
    ADC #$00
    TAX
    JSR add_to_mushroom_daze
.L3FF9
    JSR play_sound
    equb $33,$F3,$1D,$03; sound data
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_lightning
    LDY #$4D
    JMP add_wind_like_particles
;;  X = mushroom flavour - 0 = red, 1 = blue
.add_to_mushroom_daze
    LDA #$3F
    ADC red_mushroom_daze,X                        ; increase the daze duration by &3f
    BCS L400F
    STA red_mushroom_daze,X                        ; but don't overflow - limit to &ff
.L400F
    BIT mushroom_pill_collected                     ; do we have immunity?
    BMI L4041 ; if so, leave
    CMP player_immobility_daze,X
    BCC L4041
    STA player_immobility_daze,X                     ; extend the player's daze to match
    RTS
.reserve_object_for_background
    LDX #$35 ; &35 = engine thruster
.reserve_object_for_background_type_X
    LDA #$10
    BIT background_processing_flag
    BEQ L4041 ; if so, leave
    TXA
    PHA
    JSR count_objects_of_type_a_in_stack            ; how many are there already?
    CPY #$04
    PLA
    BCS L403F ; if four or more, then leave
    JSR reserve_object_high_priority
    BCS L403F
    JSR set_object_x_y_tx_ty_to_square_x_y
    LDA timer_1
    STA object_stack_y_low,Y                      ; in a random part of the square
    LDA timer_2
    STA object_stack_x_low,Y
.L403F
    LDA #$FF
.L4041
    RTS
.pull_objects_in_from_tertiary_stack
    LDY #$00
    equb $2C; BIT &xxxx
    LDY #$08 ; ?
    STA zp_various_a2 ; new_object_type
    LDX new_object_data_pointer
    BEQ pull_objects_in_from_tertiary_stack_alt
    LDA background_objects_data,X                    ; is the object on screen already?
    BPL restore_stack_pointer                   ; if so, leave
    LDA zp_various_a2 ; new_object_type
.pull_objects_in_from_tertiary_stack_alt
    JSR reserve_objects                                 ; find a slot for it (Y = number to reserve)
    BCS restore_stack_pointer                   ; if no free slots, leave
    JSR set_object_x_y_tx_ty_to_square_x_y
    LDX zp_various_a2 ; new_object_type
    LDA object_sprite_lookup,X
    TAX
    LDA square_orientation
    ORA #$05
    STA object_stack_flags,Y
    LDA #$00
    BIT square_orientation
    BPL L4072
    SBC sprite_width_lookup,X
.L4072
    STA object_stack_x_low,Y
    LDA #$00
    BIT square_orientation
    BVS L407E
    SBC sprite_height_lookup,X
.L407E
    STA object_stack_y_low,Y
    LDA new_object_data_pointer
    STA object_stack_data_pointer,Y
    TAX
    LDA background_objects_data,X                    ; mark the object as being onscreen
    AND #$7F
    STA background_objects_data,X
    CLC
    RTS
.restore_stack_pointer
    LDX copy_of_stack_pointer
    TXS
    SEC
.L4095
    RTS
.handle_explosion_type_00
    LDX current_object                                ; is it the player?
    BNE L4095 ; if not, it's an indestructible object - leave
    INC this_object_energy
    JSR increment_timers                            ; a 50% chance to either:
    BPL L40AC
    JSR drop_object                                 ; drop held object and teleport
    LDX #$04
    JSR increment_game_time_X                       ; increment player deaths
    JMP teleport_player
;;  drop_object_from_pocket                                                       ; or:
.L40AC
    LDA timer_2
    CMP #$C0
    ROR A
    AND object_held                                   ; are we holding something?
    BPL L40B8 ; if not, with 75% probability
    JSR actually_retrieve_object                    ; retrieve an object from pocket
.L40B8
    JMP drop_object                                 ; drop whatever we're holding
.handle_explosion_type_80
    JMP turn_to_fireball_energy_7                   ; an inorganic object that burns
.handle_explosion_type_40
    JSR play_sound                                  ; something that squeals and explodes
    equb $57,$07,$43,$F6; sound data
.handle_explosion_type_c0
    JSR play_squeal
    LDA this_object_type
    JSR convert_object_to_range_a
    LDA energy_by_range,X
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    ADC #$03
    BPL explode_object
    LDA this_object_energy
;;  A = damage
.explode_object
    JSR play_sound2
    equb $17,$03,$11,$04; sound data
.explode_without_sound
    STA this_object_data_pointer ; this_object_supporting                       ; store damage in this_object_supporting
    LDA #$44 ; &44 = explosion
    STA this_object_type                              ; change to an explosion
.explode_without_sound_or_damage
    LDA #$CE
    STA explosion_timer
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_cannon
    LDA #$4F ; &4f = cannon control device
    JSR has_object_been_hit_by_other
    BCS L40FC ; cannon_not_fired                            ; has the cannon been fired? if so
    LDX #$15 ; &15 = cannonball
    LDA #$40 ; x velocity = &40
    JSR add_weapon_discharge                        ; create a cannonabll
;;  cannon_not fired
.L40FC
    LDA #$0F ; 1 in 15 chance to rotate cannon
    JMP flip_object_in_direction_of_travel_on_random_a
.unused_object_handler
    BMI L4111
    JSR does_it_collide_with_bullets_2
    BEQ L4114
    CMP #$01
    BEQ L4111
    LDA #$50
    JSR take_damage
.L4111
    TYA
    EOR #$FF
.L4114
    LDX this_object_extra
    ORA wall_collision_top_or_bottom                  ; has it collided with a wall?
    EOR #$FF
    ORA this_object_extra
    BMI L4127
    TXA
    JSR make_negative
    TAX
    BNE L4127
    LDX #$FE
.L4127
    DEC this_object_timer
    LDA this_object_timer
    CMP #$E7
    BEQ L4133
    INX
    BEQ L4155
    TXA
.L4133
    LDY #$04
    JSR keep_within_range
    STA this_object_extra
    JSR make_positive_cmp_0
    ADC #$6C
    JSR convert_object_keeping_palette
    LDA current_object_rotator
    LSR A
    ROR this_object_flags_lefted
    LSR A
    ROR this_object_angle
    DEC acceleration_y
.L414C
    LDA this_object_vel_x_old
    STA this_object_vel_x
    LDA this_object_vel_y_old
    STA this_object_vel_y
    RTS
.L4155
    JMP mark_this_object_for_removal
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_grenade_inactive
    JSR keep_object_floating_until_disturbed
    JSR has_object_been_fired
    BEQ L416B
    CMP object_held
    BNE L4167
    STA this_object_extra
.L4166
    RTS
.L4167
    LDA this_object_extra
    BEQ L4166
.L416B
    LDA #$12 ; &12 = live grenade
    JMP convert_object_to_another
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_gargoyle
    LDA gargoyle_frequency_lookup,X
    AND current_object_rotator
    BNE L4186
    LDY gargoyle_y_velocity_lookup,X              ; Y = y velocity
    LDA gargoyle_x_velocity_lookup,X
    PHA
    LDA gargoyle_y_velocity_lookup+5,X ; gargoyle_bullet_lookup
    TAX ; X = object type to create
    PLA ; A = x velocity
    JSR add_weapon_discharge_y_velocity
.L4186
    LDY #$5A ; gargoyle minimum energy = &5a
    JMP L353A ; gain_energy_or_flash_if_damaged
.gargoyle_frequency_lookup
    equb $0F,$07,$07,$07,$03
.gargoyle_x_velocity_lookup
    equb $11,$7F,$7F,$7F,$01
.gargoyle_y_velocity_lookup
    equb $C0,$0C,$04,$F9,$9A
    equb $32,$19,$19,$19,$32; gargoyle_bullet_lookup                                    ; &32 = plasma, &19 = lightning
;; gargoyle_bullet_lookup                                       ; &32 = plasma, &19 = lightning
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_maggot_machine
    LDA loop_counter
    AND #$3F
    TAX
    BNE L41BD
    LDA this_object_y
    CMP water_level                                     ; is the maggot machine above the water level?
    BCC L41B7
    LDA #$80
    STA earthquake_triggered                    ; trigger earthquake!
    STA endgame_value                               ; start endgame
    BMI L41E5 ; and explode!
.L41B7
    JSR play_squeal
    JSR invert_angle
.L41BD
    CPX #$08
    JMP flash_palette
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_coronium_crystal
    LDA #$0A ; coronium crystal explosion damage = &0a
    INC this_object_timer
    INC this_object_timer
    BMI L41E8 ; explode it if time runs out
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_coronium_boulder
    TYA
    BMI no_explosion ; is it touching anything?
    BEQ coronium_on_player                              ; is it the player?
    LDA object_stack_type,Y
    CMP #$55 ; is it a coronium boulder?
    BEQ L41DA
    CMP #$58 ; is it a coronium crystal?
    BNE no_explosion                                ; if either, it's explosion time
.L41DA
    JSR mark_stack_object_for_removal
    JSR get_object_gravity_flags ; get_object_weight
    ADC this_object_weight                            ; coronium explosion damage
    ASL A ; boulder weight = 5, crystal weight = 2
    ADC #$03 ; (combined weights * 2) + 3
.L41E5
    JSR flash_screen_background
.L41E8
    JMP explode_object
.no_explosion
    LDA timer_2
    AND #$C0 ; a one in four chance
    ORA object_held
    CMP current_object                                ; if its being held,
    BNE no_damage_from_coronium
.coronium_on_player
    LDA radiation_pill_collected                    ; and we don't have the radiation pill
    ORA this_object_water_level                       ; and we're not under water
    BMI no_damage_from_coronium
    LDA #$08 ; to damage the player
    LDY #$00
    JSR take_damage                                     ; coronium contact damage = &08
.no_damage_from_coronium
    JSR increment_timers
    LSR A
    STA this_object_palette                             ; change to a random colour
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_worm
    LDA #$86 ; &86 = red frogman + player
    LDY #$07 ; &07 green frogman
    LDX #$00 ; no damage from worms
    JSR from_handle_worm                            ; behave like a maggot, except
    JMP flag_target_as_avoid                        ; worms avoid targets
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_mysterious_weapon
    JSR gain_one_energy_point_if_not_immortal
    JSR has_object_been_fired                       ; has it been fired?
    BNE L4287 ; if not, leave
    LDX #$19 ; &19 = plasma ball
    LDA #$40 ; velocity = &40
    JSR add_weapon_discharge                        ; create a plasma ball
    BCS L4287 ; leave if we couldn't
    JMP play_low_beep
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_green_slime
    JSR flip_object_in_direction_of_travel_on_random_3
    LDX #$08
    JSR npc_targetting
    JSR target_processing
    JSR move_npc
    LSR npc_fed                                 ; has the green slime been fed a coronium crystal?
    BCC unfed_slime                                     ; if so, convert it into
    LDA #$0B ; &0b = yellow ball
.L423E
    JSR play_sound
    equb $B0,$24,$B6,$E2; sound data
    JMP convert_object_to_another
.unfed_slime
    LDX #$03 ; type
    LDA #$0C ; speed
    JSR something_motion_related
    JSR compare_extra_with_a_and_f
    BCC L4258
    LDA #$0F
    STA this_object_timer
.L4258
    LDA #$11 ; modulus
    JSR get_sprite_from_velocity                    ; use velocity
    SBC #$08 ; to calculate sprite for slime
    JSR make_positive
    LSR A ; (&00 - &03)
    JMP change_sprite                               ; set the sprite based on result
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_yellow_ball
    BNE L426A
    STY this_object_timer
.L426A
    LDA timer_2
    AND wall_collision_top_or_bottom                  ; has it collided with a wall?
    BPL L4278
    INC this_object_timer
    BNE L4278
    LDA #$0A ; &0a = green slime
    BNE L423E ; convert back to a green slime
.L4278
    LDX #$3C
    LDA timer_4
    LSR A
    ORA #$80
    CMP this_object_timer
    BCS L4285
    LDX #$39
.L4285
    STX this_object_palette
.L4287
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_fluffy
    LDY #$29 ; fluffy minimum energy = &29
    JSR give_minimum_energy
    LDX #$06
    JSR npc_targetting
    JSR target_processing
    JSR is_this_object_damaged
    BCS L42BE
    LDA this_object_extra
    AND #$C0
    CMP #$80
    BEQ L42BE
    LDA current_object
    BCS L42A8
    STA this_object_target_object
.L42A8
    LDA current_object_rotator
    AND #$0B
    BNE L42DB
    LDA #$2A
    LDY #$86
    JSR L3C2B+1
    BMI L42C9
    LDA nearest_distance
    CMP timer_2
    BCS L42C9
.L42BE
    JSR play_sound
    equb $B0,$24,$B6,$E2; sound data
    ROR this_object_timer
    BMI L42DB
.L42C9
    LDA this_object_extra
    JSR make_negative
    CMP timer_2
    ROR this_object_timer
    BPL L42DB
    JSR play_sound
    equb $C7,$81,$C1,$F3; sound data
.L42DB
    LDA timer_2
    AND #$02
    TAX
    LDA this_object_timer
    EOR this_object_angle,X
    STA this_object_angle,X
    AND this_object_timer
    BPL L4325
    LDA object_held
    EOR current_object                                ; is fluffy being held by the player?
    BEQ L4325 ; if so, leave
    LDX #$02 ; type
    LDA #$28 ; speed
    JMP something_motion_related
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_active_grenade
    JSR has_object_been_fired                   ; has the grenade just been fired?
    BNE grenade_still_active
    LDA #$00 ; if so, reset the timer
    STA this_object_timer
    LDA #$50 ; &50 = inactive grenade
    JMP convert_object_to_another                   ; and make it inactive
.grenade_still_active
    LDA #$0A
    LDX this_object_energy                              ; otherwise, has it run out of energy?
    BEQ L4313 ; if so, explode it, damage = &0a
    LDA this_object_timer
    CMP #$60 ; has it run out of time? (&60 ticks)
    BCC grenade_still_ticking
    LDA #$10 ; explode it, damage = &10
.L4313
    JMP explode_object
.grenade_still_ticking
    INC this_object_timer
    JSR rotate_colour                               ; cycle its colour
    TXA
    BNE L4325 ; once every four ticks
    JSR play_sound                                      ; sound the grenade claxon
    equb $57,$07,$CB,$82; sound data
.L4325
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_cannonball
    DEC acceleration_y                                ; cannonball defies gravity
    JSR is_it_supporting_anything_collidable
    BMI handle_death_ball_blue ; has the cannonball hit anything?
    LDA #$AA
    JSR take_damage                                     ; cannonball damage = &aa - lots!
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_death_ball_blue
    JSR is_it_supporting_anything_collidable        ; has it hit anything?
    LDA #$10
    CPY #$00
    BPL L4313 ; if so, explode it, damage = &10
    BIT wall_collision_top_or_bottom                  ; has it collided with a wall?
    BMI L4313 ; if so, explode it
    JSR reduce_object_energy_by_one                 ; has it run out of time?
    BEQ L4313 ; if so, explode it
    JSR calculate_angle_from_this_object_velocities ; calculate angle for particle trail
    JMP create_bullet_particle_trail                ; leave a particle trail in its wake
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_red_bullet
    LDA #$06 ; explosion damage = &06
    LDX #$1E ; red bullet damage = &1e
    JMP L461B ; behave like a finite tracer bullet
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_remote_control
    JSR has_object_been_fired                      ; has the rcd been activated?
    BNE L43A6
    JSR play_sound
    equb $57,$07,$C1,$D3; sound data
    JMP display_gun_particles                       ; if so, display gun sight particles
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_energy_capsule
    JSR reduce_object_energy_by_one                 ; reduce its energy
    LDA current_object_rotator_low
    CMP #$02 ; once every sixteen ticks
    JSR flash_palette                               ; flash green, otherwise red
    BCS L43A6
    JSR play_sound                                  ; make a noise when flashing
    equb $05,$F2,$FF,$C5; sound data [TOM 05 was 50]
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_destinator
    BIT ship_moving                                     ; is the ship already moving?
    BMI L43A6 ; if so, leave
    LDA background_objects_data+40 ; background_object_data                     ; for top engine thruster
    LSR A ; is the thruster active?
    BCS L4389
    JSR play_sound
    equb $91,$02,$85,$47; sound data
    ROR ship_moving                                 ; if so, set ship moving
.L4389
    LDA current_object_rotator
    AND #$1F
    CMP #$01
    JSR flash_palette                               ; flash the destinator every 32 cycles
    BCS L43A6
    JSR play_sound
    equb $33,$03,$85,$12; sound data
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_giant_wall
    LDA this_object_water_level
    CMP #$C0
    BCC L43A6 ; is the wall underwater?
    DEC acceleration_y                                ; if so, cause it to float upwards
    DEC acceleration_y
.L43A6
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_flask
    LDA #$4D ; &4d = full flask
    BIT underwater                                      ; are we underwater?
    BPL L43E4 ; if so, convert to a full flask
.L43AD
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_flask_full
    BMI L43B7 ; are we supporting something?
    JSR get_biggest_velocity                        ; if not, consider velocities
    CMP #$0A ; are we moving too fast?
    BCS L43BD ; if so, disturb flask
.L43B7
    LDA wall_collision_frict_y_vel ; some_kind_of_velocity
    CMP #$14 ; have we collided violently?
    BCC L43C1 ; if not, leave flask undisturbed
.L43BD
    LDA #$10 ; disturb flask
    STA this_object_timer
.L43C1
    LDA this_object_timer                             ; has the flask been disturbed?
    BEQ L43AD ; if not, leave
    LDY this_object_supporting
    BMI L43D3 ; are we supporting something?
    LDA object_stack_type,Y
    CMP #$37 ; &37 = fireball
    BNE L43D3 ; if so, is it a stationary fireball?
    JSR mark_stack_object_for_removal               ; if so, kill it
.L43D3
    LDA #$C0
    STA angle                                         ; set angle to point straight up
    LDY #$58 ; &58 = flask particles
    LDA #$08
    JSR add_particles                               ; create eight particles per tick
    DEC this_object_timer
    BNE L43AD ; when time runs out, convert to an empty flask
    LDA #$4C ; &4c = empty flask
.L43E4
    JMP convert_object_to_another
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_hover_ball
    JSR rotate_colour_6                             ; cycle the colour of the hover ball
    TYA
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_hover_ball_invisible
    BMI L4400 ; are we supporting something?
    LDA object_stack_type,Y
    EOR this_object_type                              ; if so, is it also a hover ball?
    BEQ L4400 ; hover balls don't damage each other
    LDA #$03
    JSR take_damage                                     ; hover balls damage = &03
    JSR play_sound
    equb $33,$03,$85,$02; sound data
.L4400
    LDA this_object_energy
    AND #$04 ; hover balls are very weak; energy = &04
    STA this_object_energy
    DEC this_object_timer                             ; has the timer run out?
    BNE L4415
    JSR force_object_offscreen                      ; if so, cause the hover ball to teleport home
.play_teleport_noise
    JSR play_sound
    equb $29,$C2,$37,$F3; sound data
    RTS
.L4415
    JSR thrust_and_home_in_on_player
    JMP thrust_towards_player                       ; annoy the player
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_pistol_bullet
    JSR is_it_supporting_anything_collidable
    BMI move_bullet                                 ; has the bullet hit anything?
    LDA #$0A ; if so, damage it
    JSR take_damage                                     ; pistol bullet damage = &0a
.L4425
    JSR play_sound2
    equb $17,$03,$1B,$02; sound data
    JSR turn_to_fireball_energy_2 ; TOM had to add this...
    LDA #$02 ; then explode
    JMP explode_without_sound                       ; explosion damage = &02
.move_bullet
    JSR reduce_object_energy_by_one                 ; has the bullet run out of time?
    BEQ L4425 ; if so, explode it
    BIT wall_collision_top_or_bottom                  ; has it collided with a wall?
    BPL L4447 ; if so, it can either ricochet or explode
    CMP #$3E
    BCS L4425 ; if energy > &3e, explode
    SBC #$14
    BCC L4425 ; if energy < &14, explode
    STA this_object_energy                            ; otherwise ricochet
.L4447
    JSR calculate_angle_from_this_object_velocities
    STA this_object_flags_lefted
    BIT this_object_flags_lefted
    BVC L4452
    EOR #$FF
.L4452
    STA this_object_angle                             ; change sprite based on bullet's direction
    AND #$7F
    LSR A
    LSR A
    LSR A
    CMP #$04
    BCC L4460
    LSR A
    EOR #$06
.L4460
    JMP change_sprite
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_frogman_red
    LDX #$09 ; type
    JSR npc_targetting
    LDA #$33 ; &33 = red mushroom ball
    TAY
    JSR avoid_a                                     ; red frogman avoids red mushroom balls
    JSR target_processing
    LDY #$64 ; red frogman minimum energy = &64
    BNE red_frogman
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_frogman_cyan
    LSR object_is_invisible                           ; cyan frogman is invisible
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_frogman_green
    LDX this_object_supporting
    BNE not_touching_player                         ; is the frogman touching the player?
    JSR add_to_mushroom_daze                        ; if so, daze the player
    LDA #$07
    STA this_object_timer
    ASL A ; frogman damage = &0e
    LDY #$00
    JSR take_damage                                 ; damage player
.not_touching_player
    LDY #$5A ; cyan / green frogman minimum energy = &5a
.red_frogman
    JSR give_minimum_energy
    LDY #$14
    STY npc_speed
    LDX #$01
    JSR some_other_npc_stuff
    JSR flip_object_in_direction_of_travel_on_random_3
    JSR compare_extra_with_1_and_f
    BCS L44AC
    JSR compare_wall_collision_angle_with_3962
    CMP #$28
    BCC L44B4
    JSR change_angle_if_wall_collision              ; turn it round if it's hit a wall
    LDX #$FF
    BNE L44B6
.L44AC
    BIT underwater
    BMI L44DC
    LDA current_object_rotator_low
    BNE L44DC
.L44B4
    LDX #$04
.L44B6
    LDA this_object_timer
    BNE L44DC
    LDA #$09
    BIT object_collision_with_other_object_top_bottom
    BMI L44D1
    LDA npc_speed
    LSR A
    LSR A
    LDY timer_3
    CPY #$20
    BCS L44D2
    CPY #$0A
    BCS L44D1
    ADC #$05
.L44D1
    TAX
.L44D2
    STA this_object_timer
    TXA
    BMI L44DC
    ASL A
    ASL A
    JSR L3A5B
.L44DC
    LDA this_object_timer
    CLC
    BEQ L44EC
    DEC this_object_timer
    LDA this_object_timer
    BEQ L44EC
    LSR A
    LSR A
    AND #$01
    SEC
.L44EC
    JMP L3293
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_imp
    LDA this_object_flags
    AND #$04
    BEQ L44F9
    LDA #$80
    STA this_object_extra
.L44F9
    LDY #$28
    LDA this_object_extra
    ASL A
    EOR this_object_extra
    BMI L4504
    LDY #$10
.L4504
    STY npc_speed
    LDA this_object_type
    SEC
    SBC #$29
    TAX
    LDA this_object_extra
    AND #$10
    PHP
    LDA square_sprite
    CMP #$0A ; is the square the imp's flowerpot?
    BNE not_in_flowerpot
    LSR npc_speed
    LSR npc_speed
    JSR get_object_centre
    LDA this_object_x_centre_low_OR_particle_x_low ; this_object_centre_x_low
    JSR make_positive
    CMP #$68
    BCC not_in_flowerpot                            ; is the imp near the centre of it?
    BIT wall_collision_bottom_minus_top
    BPL not_in_flowerpot
    PLP
    BEQ no_imp_gift                                 ; was the imp previously fed?
    DEC imp_gift_counts,X                          ; is there a gift to give?
    BMI no_imp_gift
    LDA imp_gift_lookup,X                          ; find out what it is
    TAX
    LDY #$C8
    JSR add_weapon_discharge_y_velocity             ; and generate it
    JSR play_squeal
.no_imp_gift
    JMP force_object_offscreen                      ; the imp disappears into the flowerpot
.not_in_flowerpot
    LDY imp_energy_lookup,X
    JSR give_minimum_energy
    JSR npc_targetting
    PLP
    BNE L4552
    LSR npc_fed                                 ; has the imp been fed?
    BCC unfed_imp
.L4552
    LDA this_object_extra
    AND #$3F ; mark extra as having been fed
    ORA #$90
    STA this_object_extra
.unfed_imp
    JSR target_processing
    LDX #$02
    JSR L3AE1
    LDY this_object_supporting
    CPY this_object_target_object
    BNE L457E
    BIT this_object_extra
    BMI L457E
    JSR can_we_pick_up_object
    BMI L457E
    LDY this_object_supporting
    LDA #$05
    JSR take_damage
    JSR get_object_velocities
    JMP L459F
.L457E
    JSR compare_extra_with_a_and_f
    BCS L45B3
    AND #$0F
    BNE L4596
    JSR compare_wall_collision_angle_with_3962
    CMP #$28
    LDA this_object_extra
    AND #$DF
    BCC L4594
    ORA #$20
.L4594
    STA this_object_extra
.L4596
    LDA this_object_extra
    AND #$20
    BEQ L45C1
    JSR change_angle_if_wall_collision              ; turn it round if it's hit a wall
.L459F
    LDA #$0C ; modulus
    LDX #$02 ; velocity / 4
    JSR L2557 ; get_sprite_from_velocity_X                  ; use velocity
    LSR A
    LSR A
    LSR A
    LDA #$67
    ADC #$00
    BNE L45ED
.L45AF
    LDA #$69
    BNE L45E8
.L45B3
    BIT underwater
    BMI L45AF
    JSR increment_timers
    AND #$1F
    BNE L45C1
    JSR L3A59
.L45C1
    LDY this_object_supporting
    CPY this_object_target_object
    BEQ L459F
    LDY #$00
    STY zp_various_9d
    LDX npc_type
    LDA npc_weapon_lookup,X
    TAX
    LDA #$08
    JSR L276D
    LDA #$64
    LDX this_object_vel_x
    BEQ L45ED
    LDA #$0C ; modulus
    LDX #$02 ; velocity /4
    JSR L2557 ; get_sprite_from_velocity_X                  ; use velocity
    LSR A
    LSR A
    CLC
    ADC #$64
.L45E8
    PHA
    JSR flip_object_in_direction_of_travel_on_random_3
    PLA
.L45ED
    JSR convert_object_keeping_palette
    JSR is_this_object_damaged
    LDA #$A5
    BCS L4609
    LDA current_object_rotator_low
    BNE L4613
    JSR increment_timers
    LSR A
    ROR A
    BPL L4613
    EOR this_object_extra
    AND #$E0
    LSR A
    ORA #$05
.L4609
    STA L4609+9
    JSR play_sound
    equb $9C,$05,$A6,$A5; sound data
.L4613
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_tracer_bullet
    JSR gain_one_energy_point                       ; tracer bullets are immortal
    LDA #$08 ; explosion damage = &08
    LDX #$0F ; bullet damage = &0f
.L461B
    JSR bullet_with_particle_trail                  ; leave a particle trail like an icer bullet
    JMP one_in_four_towards_player                  ; but home in on the player like a bird
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_bird_red
    LDA timer_2
    BNE no_sound_from_bird
    JSR whistle_sound                               ; does this also attract chatter?
    JMP no_sound_from_bird
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_bird_invisible
    LDA this_object_extra
    BNE handle_bird
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
    LSR object_is_invisible                           ; invisible bird is invisible
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_bird
    JSR increment_timers
    AND #$3F
    BNE no_sound_from_bird
    JSR play_sound
    equb $57,$07,$43,$F6; sound data
.no_sound_from_bird
    LDX this_object_type
    TYA
    BNE L464A
    LDA bird_damage_lookup-first_bird_type,X
    JSR take_damage
.L464A
    LDY bird_minimum_energy_lookup-first_bird_type,X
    JSR give_minimum_energy
    AND #$7F
    STA this_object_energy
    JSR is_this_object_damaged
    ROR this_object_extra
    BNE L4688
    LDA #$14 ; modulus
    JSR get_sprite_from_velocity                    ; use velocity
    LSR A
    LSR A
.L4662
    CMP #$04 ; to calculate sprite for bird
    BNE L4668 ; (&00 - &03)
.L4666
    LDA #$02
.L4668
    JSR change_sprite                               ; set the sprite based on result
    LDA #$11 ; &11 = wasp
    JSR absorb_object                               ; birds eat wasps
    LDA #$11 ; &11 = wasp
.L4672
    LDY #$00 ; &00 = player
    JSR find_target_occasionally
    JSR avoid_fireballs
.one_in_four_towards_player
    JSR target_processing
    LDY #$08 ; maximum speed = &08
    LDA #$40 ; velocity magnitude = &40
    LDX #$40 ; probability = &40
    JSR move_towards_target_with_probability_x
    DEC acceleration_y
.L4688
    BIT underwater
    BMI L468F
    JSR L321F ; dampen_this_object_vel_xy_twice             ; moves slower under water
.L468F
    RTS
.bird_damage_lookup
    equb $00,$03,$40,$14
.bird_minimum_energy_lookup
    equb $00,$00,$1E,$00
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_mushroom_ball
    BMI L46A6 ; are we supporting anything?
    LDA object_stack_type,Y
    CMP #$37 ; &37 = fireball
    BNE L46AB ; is it a fireball?
;;  if it isn't a fireball, but we're supporting something, lose no energy - possibly a bug?
    LDA #$58 ; &58 = coronium crystal
    JMP convert_object_to_another                   ; if so, convert to a coronium crystal
.L46A6
    JSR reduce_object_energy_by_one                 ; have we run out of energy?
    BNE L468F ; if not, leave
.L46AB
    LDA timer_3
    BMI L468F ; 1 in 2 chance to leave anyway
    LDA this_object_palette
    LSR A
    JSR consider_mushrooms_and_player               ; is the player affected by them?
    LDA #$20 ; create &20 particles
    LDY #$4D ; &4d = mushroom particles
    JSR add_particles                               ; turn the mushroom ball to particles
    JMP mark_this_object_for_removal                 ; and remove it
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_icer_bullet
    LDA #$02 ; explosion damage = &02
    LDX #$14 ; icer bullet damage = &14
.bullet_with_particle_trail
    PHA
    JSR is_it_supporting_anything_collidable
    PLA
    CPY #$00
    BMI L46D6 ; has the bullet hit anything?
    JSR explode_object                              ; if so, explode, doing damage from A
    TXA
    JSR take_damage                                 ; bullet damage is X
    JMP zero_velocities ; zero_velocites
.L46D6
    JSR move_bullet                                 ; if bullet hasn't hit anything, move it
.create_bullet_particle_trail
    LDA angle
    EOR #$80 ; 180 degrees
    STA angle                                         ; away from bullet's direction of travel
    LDX this_object_type
    LDA bullet_particle_colour_table-first_bullet_type,X
    STA particle_colour_table+particles_icer ; set the particle colour to match bullet
    LDY #particles_icer                      ; &2c = bullet particles
    JMP add_particle                         ; create particle
;;       13 14 15 16 - icer bullet, tracer bullet, cannonball, blue death ball
.bullet_particle_colour_table
    equb $02,$04,$08,$08
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_crew_member
    JSR scream_if_damaged
    JSR L3A6D
    JSR gain_one_energy_point_if_not_immortal
    LDA #$07
    JSR flip_object_in_direction_of_travel_on_random_a
    TAY
    LDA #$C0
    JMP change_palettes_for_player_like_objects
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_triax
    LDA #$4A ; &4a = destinator
    JSR absorb_object                           ; can triax collect the destinator?
    BNE no_destinator_for_triax
    LDA #$80
    STA background_objects_data+157 ; background_object_data                    ; return destinator to triax's lair
    BNE L475C ; teleport_away                           ; and teleport away!
.no_destinator_for_triax
    LDA this_object_target
    BMI L471A
    LDA current_object_rotator
    BEQ L475C
.L471A
    LDA this_object_energy
    CMP #$40
    BCS L4726
    LDA timer_1
    CMP #$04
    BCC L475C
.L4726
    LDA timer_3
    CMP #$08
    LDA #$13
    BCS L4730
    LDA #$12
.L4730
    JSR gain_energy_fire_and_thrust_towards_player  ; like a clawed robot
    LDA this_object_energy
    CMP #$05
    ROL A
    ORA timer_4
    ORA timer_2
    LSR A
    BCC L475C
    LDA player_east_of_76
    EOR #$80 ; if player is west of &76
    ORA endgame_value                               ; and we're in the end game
    BMI L474F
    LDA timer_4
    AND #$03 ; then, with a 1 in 4 chance
    BEQ L475C ; cause triax to teleport away # ?
.L474F
    JSR increment_timers
    BEQ L475C ; otherwise a 1 in 256 chance to teleport
    JSR handle_crew_member                          ; scream if damage, deal with sprite
    LDY #$00
    JMP teleport_object_near_player
.L475C
    LDA #$00
    JMP teleport_away
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_big_fish
    LDA #$10 ; &10 = pirahna
    JSR absorb_object                               ; big fish eats pirahnas
    LDY #$19
    JSR give_minimum_energy                         ; big fish minimum energy = &19
    LDA this_object_water_level
    CMP #$32 ; is the big fish underwater?
    BCC L47C2 ; if not, leave - it doesn't move
    LDA #$10 ; &10 = pirahna
    TAY
    JSR find_target_occasionally                    ; look for pirahnas to eat
    JSR target_processing
    LDA #$10
    BIT this_object_target
    BPL L4781 ; target &80 = &00 ?
    ASL A ; velocity magnitude
.L4781
    LDY #$02 ; maximum speed
    JSR move_towards_target
    JMP flip_object_in_direction_of_travel_on_random_3
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_sucker
    TYA ; is the sucker touching anything?
    ORA timer_4                                       ; if so, a one in two chance
    BMI L47C2
    JMP set_object_velocities                       ; to set its velocities to match
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_engine_fire
    JSR reduce_object_energy_by_one                 ; reduce its energy
    BNE L47C2 ; leave if it still has energy
    JMP mark_this_object_for_removal                 ; otherwise remove it
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_red_drop
    BMI red_drop_not_touching                   ; is it touching anything?
    LDA object_stack_type,Y                        ; if so,
    CMP #$09 ; &09 = red slime
    BEQ L47C2 ; ignore collisions with red slime
    CMP #$0B ; &0b = yellow ball
    BEQ convert_to_coronium_boulder                 ; convert yellow balls to coronium boulders
    CMP #$10 ; &10 = pirahna
    BEQ L47B6 ; explode on contact with pirahna, no damage
    JSR play_sound2
    equb $17,$03,$1B,$02; sound data
    LDA #$64 ; red drop damage = &64
    JSR take_damage                                 ; otherwise damage object
.L47B6
    JSR play_high_beep
    LDA #$00 ; and explode!
    JMP explode_without_sound
.red_drop_not_touching
    BIT wall_collision_top_or_bottom                  ; has it collided with a wall?
    BMI L47B6 ; if so, explode it
.L47C2
    RTS
.convert_to_coronium_boulder
    LDA #$55 ; &55 = coronium boulder
    STA object_stack_type,Y
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_red_slime
    LDA current_object_rotator_low
    BEQ L47D7 ; no_red_drop
    LSR A
    SEC
    SBC #$04
    BPL no_red_drop2
    EOR #$FF
    BPL no_red_drop2
.L47D7
    BIT timer_2                                       ; once in a while, create a red drop
    BPL no_red_drop
    LDA #$36 ; &36 = red drop
    JSR reserve_object_low_priority                     ; try to reserve slot for it
    BCS no_red_drop
    LDA #$90 ; x_low is either &90 or &30
    BIT this_object_angle                             ; depending on orientation
    BMI L47EA
    LDA #$30
.L47EA
    STA object_stack_x_low,Y                      ; set x_low for drop
    LDA #$40
    STA object_stack_y_low,Y                      ; set y_low for drop
    LDA #$04
    STA object_stack_vel_y,Y                      ; set y velocity for drop
.no_red_drop
    LDA #$03
.no_red_drop2
    CLC
    ADC #$1C
    TAY
    STA this_object_sprite
    LDX #$00 ; X = 0, x direction
    JMP change_object_width
    
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_hovering_robot
    JSR no_firing ; towards_gain_energy_or_flash_if_damaged     ; hovering robot energy = &14
    BCC L47C2 ; leave if insufficient energy
    LDA timer_4
    LSR A
    BNE L4815 ; once every &80 cycles
IF SRAM
    ldx #6                      ; ALIEN DIE
    jsr smp_play
ELSE
    JSR play_sound                                  ; make a noise
    equb $33,$F3,$63,$E3; sound data
ENDIF
.L4815
    LDA timer_1
    CMP #$40 ; three out of four times,
    BCS thrust_and_home_in_on_player                ; thrust towards player
    LDA #$18 ; &18 = pistol bullet
    BNE L4864 ; one out of four times shoot as well
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_clawed_robot
    JSR is_this_object_damaged
    ROR this_object_extra
    LSR this_object_extra
    LDX this_object_type
    LDY clawed_robot_minimum_energy_lookup-first_clawed_robot_type,X
    JSR give_minimum_energy
    BEQ L47C2 ; if out of energy, leave
    AND #$F8
    LSR A
    STA clawed_robot_energy_when_last_used-first_clawed_robot_type,X
    ASL A
    CMP #$8C
    BCC L4843
    LDA this_object_target
    AND #$C0
    ORA current_object_rotator
    BNE L484D
.L4843
    LDA this_object_extra
    BNE L484D
    STA clawed_robot_availability-first_clawed_robot_type,X ; actually clawed_robot_availability
    JMP teleport_away
.L484D
    LDY #$46
    JSR teleport_object_near_player
    JSR increment_timers
    LSR A
    BNE L485F
IF SRAM
    ldx #5                      ; DESTROY
    jsr smp_play
ELSE
    JSR play_sound
    equb $17,$03,$68,$A3; sound data
ENDIF
.L485F
    LDA #$13 ; &13 = icer bullet
.gain_energy_fire_and_thrust_towards_player
    JSR gain_one_energy_point
.L4864
    JSR gain_one_energy_point
    TAX
    TAY ; Y = ???
    LDA #$81 ; &81 = active chatter and player
    JSR find_a_target_and_fire_at_it                ; find a target and fire at it
.thrust_and_home_in_on_player
    LDA #$00
    STA this_object_target_object                     ; target the player
    JSR target_processing
    LDA #$07
    JSR flip_object_in_direction_of_travel_on_random_a
.thrust_towards_player
    LDA #$1C ; velocity magnitude
    LDY #$04 ; maximum speed
    LDX #$80 ; half of the time
.L4880
    JSR move_towards_target_with_probability_x
    DEC acceleration_y
    JSR bob_up_and_down
    JMP create_jetpack_thrust
.teleport_object_near_player
    BIT object_onscreen                              ; is the object already on screen?
    BPL L48C0 ; if so, leave
    LDA #$40
    STA this_object_target                            ; target the player | &40
    LDA #$03
    JSR get_random_square_near_player
    JSR store_square_x_y_in_tx_ty
    JSR get_biggest_of_a_and_y
.teleport_away
    STA this_object_ty
    JMP mark_this_object_as_teleporting
.clawed_robot_minimum_energy_lookup
    equb $46,$5A,$80,$82
.chatter_subroutine
    LDA whistle1_played
    AND #$80
    BPL L48B1 ; has whistle 1 been played?
    STA this_object_timer                             ; if so, note it in timer and extra
    STA this_object_extra
.L48B1
    LDX #$07
    JSR npc_targetting
    JSR target_processing
    LSR npc_fed                                 ; have we just fed chatter a crystal?
    BCC L48C0
.L48BD
    INC chatter_energy_level                    ; if so, increase his energy
.L48C0
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_chatter_inactive
    JSR chatter_subroutine                          ; absorb crystals and listen for whistle 1
    LDA this_object_timer                             ; has whistle 1 been played?
    BPL L48C0
    STA this_object_energy                            ; if so, give chatter energy
    DEC chatter_energy_level                        ; reduce reserve energy
    BMI L48BD ; if no reserve energy, keep inactive
    LDA #$01 ; &01 = active chatter
    equb $2C; BIT &xxxx                                               ; otherwise activate chatter
.deactivate_chatter
    LDA #$38 ; &38 = inactive chatter
    JMP convert_object_to_another
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_chatter_active
    JSR chatter_subroutine                          ; absorb crystals and listen for whistle 1
    LDY #$00
    JSR give_minimum_energy_and_flash_if_damaged    ; chatter minimum energy = &00
    LDA this_object_energy
    BEQ deactivate_chatter                          ; deactivate chatter if run out of energy
    LDA #$1F
    JSR flip_object_in_direction_of_travel_on_random_a
    BIT loop_counter_every_08
    BPL no_enemies_for_chatter ; once every eight cycles,
    LDA #$20 ; &20 = cyan/red turret
    LDY #$86 ; &86 = object range 6 (flying enemies)
    JSR find_nearest_object
    BMI no_enemies_for_chatter                      ; is there an enemy near chatter?
    LDA angle
    ADC #$40
    STA this_object_angle
    EOR this_object_flags
    BMI no_enemies_for_chatter                      ; is chatter facing the enemy?
    LDA angle
    AND #$7F
    SBC #$0A
    CMP #$6C
    BCC no_enemies_for_chatter                      ; and they're at a reasonable angle
    STA this_object_timer
    JSR generate_lightning                          ; attack them with lightning
.no_enemies_for_chatter
    LDA this_object_timer
    BEQ no_chatter_song
    DEC this_object_timer
    LDA timer_1
    CMP #$C0
    BCC no_chatter_song
    LDA timer_4                                       ; pick a random note for chatter
    LSR A
    LSR A
    EOR this_object_extra
    ADC #$40
    EOR #$C0
    LSR A
    STA sound_data_big_lookup_table+207 ; chatter_pitch
    JSR play_sound                                  ; sing chatter's song
    equb $33,$F3,$CD,$82; sound data
    LDA #$4B ; change colour
    STA this_object_palette
.no_chatter_song
    LDX whistle2_played                         ; has whistle 2 been played?
    BMI L494C ; no_whistle2
    JSR is_object_close_enough_80
    BCS L494C ; is chatter close enough to the player?
    LDY #$4B ; &4b = energy capsule
    LDA #$40
    JSR in_enemy_fire                               ; try to create an energy capsule
    BPL L494C
    BCS L494C ; and if successful,
    LDA #$00 ; reduce chatter's energy to zero
    STA this_object_energy
.L494C
    LDA this_object_supporting
.no_whistle2
    ORA this_object_target_object
    BNE L4954
    STA this_object_target
.L4954
    JMP thrust_towards_player
    RTS
.switch_effects_table
    equb $00,$B0,$BB,$84,$00,$0F,$29,$00,$C5,$00,$E7,$8F,$00,$8A,$00,$13
    equb $00,$8E,$32,$00,$C2,$00,$11,$AA,$BD,$00,$58,$CC,$55,$BC,$00,$55
    equb $00,$46,$A9,$00,$6A,$8B,$00,$E6,$85,$D8,$00,$C7,$88,$00,$68,$00
    equb $14,$00,$28,$4C,$00,$65,$00,$89,$00,$8D,$00,$64,$2A,$00,$6B,$00
    equb $A7,$B9,$10,$00
IF NOVELLA_LOOKUP = TRUE
.l499c
    equb $EA
ELSE
    equb $EA; (unused)
ENDIF

;; (unused)
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_switch
    CLC
    BMI L49A3 ; is it touching something?
    JSR can_object_trigger_switch                   ; is that something sufficiently heavy?
.L49A3
    ROR this_object_tx                                ; if so, mark the switch as touched
    BPL switch_not_pressed
    LDA this_object_tx
    ASL A ; has the switch been recently touched?
    BNE switch_not_pressed                          ; if so, don't trigger it again
    ROL A
    EOR this_object_data
    STA this_object_data                              ; toggle switch state
    LDX #$FF
    JSR switch_effects                              ; and do whatever the switch does!
    JSR play_sound
    equb $3D,$04,$11,$D4; sound data
.switch_not_pressed
    LDA this_object_data
    LSR A
    ROR this_object_angle                             ; change switch's appearance (in / out)
    JMP gain_energy_or_flash_if_damaged_minimum_1e  ; switch minimum energy = &1e
;;  returns carry set if object can trigger switches, carry clear if not
;;        0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
;;    00 ok ok ok no -- -- ok ok ok -- ok ok -- -- ok ok
;;    10 ok ok ok ok ok ok ok ok no ok ok ok ok ok ok --
;;    20 ok ok ok no no no no no -- ok ok ok ok ok ok ok
;;    30 ok ok ok no no no ok ok ok ok ok -- -- -- -- --
;;    40 ok -- -- ok  n ok ok ok -- ok ok no no ok no no
;;    50 ok ok ok ok ok ok ok ok no ok ok ok ok ok ok ok
;;    60 ok no no ok --
.can_object_trigger_switch
    JSR get_object_gravity_flags ; get_object_weight                            ; how heavy is what is touching the switch?
    CMP #$02 ; if it has weight less than 3
    BCC L49DA ; then it doesn't trigger the switch
    CPX #$35 ; X = object type
    BEQ L49D6 ; &35 = engine fire doesn't trigger switch
    CPX #$27 ; &27 = maggot
    BCS L49DA ; objects &28 - &63 do trigger switch
    CPX #$22 ; objects &00 - &22 do trigger switch
.L49D6
    ROL A
    EOR #$01
    ROR A
.L49DA
    RTS
;;  X = &ff if real switch, something else if invisible
;;  A = switch subtype = &80
;;  A = this_object_data
.switch_effects
    STX zp_various_9c
    LSR A
    PHA
    AND #$03
    STA zp_various_9d ; switch_type_and_03
    PLA
    LSR A
    LSR A
    TAX
    LDY #$FF
.L49E9
    INY
    LDA switch_effects_table,Y                     ; find a zero slot in switch_effects_table
    BNE L49E9
    DEX
    BPL L49E9 ; find the Xth zero slot in switch_effects_table
    TAX
.L49F3
    LDA background_objects_data,X
    STA zp_various_9a
    AND zp_various_9c
    EOR zp_various_9d
    STA background_objects_data,X
    INY
    LDX switch_effects_table,Y
    BNE L49F3
    CMP zp_various_9a
    BEQ L4A10
    JSR play_sound
    equb $C7,$C3,$C1,$03; sound data
.L4A10
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_player_object
    BMI not_supporting_fluffy ; is the player touching something?
    LDA object_stack_type,Y
    EOR #$03 ; &03 = fluffy
    BNE not_supporting_fluffy                       ; is it fluffy?
    STY object_held                                   ; if so, it jumps into the player's hands
.not_supporting_fluffy
    ROR object_being_fired                          ; clear object_being_fired
IF SRAM
.M4B41
    lda #$fe
    beq M4B4F
    inc M4B41+1
    bne M4B4F
    ldx #0                      ; welcome to the land of the exile
    jsr smp_play
.M4B4F
ENDIF
    LDA this_object_x
    CMP #$76 ; if player_x >= &76
    ROR player_east_of_76                           ; then set player_east_of_76
    JSR retrieve_object_if_marked
    LDA object_held
    PHA
    JSR process_keys
    LDA #$10
    BIT this_object_flags
    BNE L4A38
    JSR do_player_stuff
.L4A38
    JSR process_gun_aim
    PLA ; object_held
    TAY ; are we holding anything?
    BMI not_holding_anything
    LDA this_object_angle
    EOR this_object_flags
    BPL not_holding_anything
    LDX object_stack_sprite,Y
    LDA sprite_width_lookup,X
    BIT this_object_angle
    JSR make_negative
    LDX #$00
    BIT this_object_flags
    JSR move_object_in_one_direction_with_given_velocity
.not_holding_anything
    BIT loop_counter_every_04
    BPL L4A68
    LDA bells_to_sound
    BEQ L4A68
    DEC bells_to_sound
    JSR play_sound
    equb $17,$E3,$2F,$82; sound data
.L4A68
    DEC autofire_timeout
    BNE L4A70
    LSR keys_pressed+fire_key_index ; fire_pressed
.L4A70
    LDA player_bullet                                   ; has the player fired the discharge device?
    BPL L4A87 ; if not, leave
    INC player_bullet
    JSR explode_without_sound_or_damage         ; discharge device
    LDA #$0A
    STA this_object_data_pointer                        ; damage ?
    JSR play_sound2                                     ; play sound for discharge device
    equb $17,$03,$11,$04; sound data
    JSR handle_explosion                                ; create particles for discharge device
.L4A87
IF SRAM
    JSR M316D
ENDIF
    RTS


;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_plasma_ball
    BMI L4A92 ; is it touching something?
    LDA object_stack_type,Y
    JSR does_it_collide_with_bullets            ; and it's not a bush, fireball or explosion?
    BNE L4AB3 ; plasma_ball_collision
.L4A92
    LDA underwater                                    ; if it's underwater
    ORA timer_1
    ORA timer_4
    BPL plasma_ball_in_water                        ; then 25% of the time fizzle it out
    JSR reduce_object_energy_by_one
    BEQ L4ACB ; if it's run out of energy, remove it
    CMP #$03
    LDY #$A0
    LDA #$03
    BCS L4AAB ; cause it to fizzle if it's low on energy
.L4AA7
    LDY #$A1
    LDA #$1E
.L4AAB
    STY particle_flags_table+particles_plasma_ball
    LDY #$00
    JMP add_particles
;;  plasma_ball_collision                                                               ; the plasma ball has collided with something
.L4AB3
    LDA #$0D
    equb $2C; BIT &xxxx
.turn_to_fireball_energy_7
    LDA #$07 ; various entrances to this code
    equb $2C; BIT &xxxx
.turn_to_fireball_energy_2
    LDA #$02 ; this one appears to be unused?
    STA this_object_timer
    STA this_object_energy
    LDA #$00
    STA this_object_target_object                     ; target the player
    LDA #$37 ; convert the plasma ball to a fireball
    JMP convert_object_to_another
.plasma_ball_in_water
    JSR L4AA7 ; cause it to fizzle
.L4ACB
    JMP mark_this_object_for_removal                 ; then remove it
.fireball_palettes
    equb $10,$34,$34,$34,$10,$34,$10,$34
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_fireball
    LDA this_object_water_level                       ; is it underwater?
    AND timer_3
    AND timer_2
    BMI plasma_ball_in_water                        ; 25% chance that it fizzles and dies
    LDA this_object_target_object
    BNE L4B4A ; are we targetting the player?
    DEC this_object_timer
    BMI L4ACB
    LDX #$0A
;;  x = 4, &14 from moving fireball
.check_fireball_collision
    LDA current_object_rotator_low
    BNE L4AF4
    LDA this_object_timer
    CMP #$08
    BCC L4AF4
    LDX #$5A
.L4AF4
    TYA
    BMI no_fireball_collision                       ; is it touching anything?
    BNE L4AFF ; is it the player?
    BIT fire_immunity_collected                     ; if so, do they have immunity?
    BPL L4AFF
    TAX ; player without immunity damage = A
.L4AFF
    TXA ; other objects and immune player damage = X
    JSR take_damage
    JSR does_it_collide_with_bullets_2
    BEQ no_fireball_collision
    JSR get_object_velocities
.no_fireball_collision
    JSR increment_timers
    STA this_object_angle
    ASL A
    STA this_object_flags_lefted
    LDA this_object_timer
    AND #$07
    TAX
    LDA fireball_palettes,X                        ; change the colour of the fireball
    STA this_object_palette
    LDA #$C0 ; &c0 = straight up
    STA angle
    LDY #$21 ; &21 = fireball particle
    JMP add_particle                                ; create firey smoke particles going upward
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_moving_fireball
    LDX #$04
    JSR check_fireball_collision                    ; has it collided with anything?
    JSR copy_object_values_from_old
    LDA this_object_supporting
    BEQ L4B35
    JSR L414C
.L4B35
    JSR L4672
    BIT underwater
    BMI L4B44 ; is it underwater?
    LDA #$FC ; if so, accelerate it upwards
    STA acceleration_y
    BIT this_object_water_level                       ; is it still underwater?
    BMI plasma_ball_in_water ; if so, cause it to fizzle and die
.L4B44
    JSR accelerate_object
    JMP move_object
.L4B4A
    JSR L28AE
    BIT timer_2
    BPL handle_bush
    LDA timer_2
    AND #$0F
    ADC current_object_rotator_low
    ASL A
    ADC this_object_y_low
    ADC #$18
    STA this_object_y_low
    DEC this_object_timer
    LDX #$14
    BNE check_fireball_collision                    ; if it still has energy, check collisions
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_placeholder
    BMI L4B6B ; is it touching anything?
    JSR can_object_trigger_switch
    BCS L4B7F
.L4B6B
    LDY current_object_rotator_low
    BNE handle_bush                                 ; if not, make stationary
    LDA this_object_data
    JSR convert_object_to_range_a
    CPX #$09 ; is it range 9? (indestructible equipment)
    BEQ handle_bush                                 ; if so, remain stationary
    LDX #$00 ; X = 0, player object
    JSR is_object_close_enough_80                   ; is it close to the player?
    BCS handle_bush                                 ; if set, remain stationary
.L4B7F
    LDA this_object_data
    STA this_object_type
    LDA #$FF
    STA this_object_energy
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_collectable
    LDA object_held
    CMP current_object                          ; are we holding it?
    BNE keep_object_floating_until_disturbed ; if so:
    LDX this_object_type
    DEC background_objects_handler_lookup+199,X ; set the relevant collected byte
    JSR play_sound
    equb $72,$A5,$7B,$85; sound data
    JMP mark_this_object_for_removal                 ; and remove it
.keep_object_floating_until_disturbed
    LDY this_object_supporting                        ; otherwise, is it touching anything?
    BMI L4BA5
    ASL this_object_energy                            ; if so, mark it as disturbed
    LSR this_object_energy
.L4BA5
    BIT this_object_energy                            ; has it been disturbed?
    BPL L4C14 ; if not, keep it stationary
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_bush
    JSR zero_velocities
    JMP copy_object_values_from_old
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_nest
    LSR A ; data &7c = child type * 4
    LSR A
    STA this_object_extra                             ; this_object_extra = child type
    JSR absorb_object                               ; absorb children if they're near
    LDA #$46
    JSR give_minimum_energy                         ; nest minimum energy = &46
    BIT loop_counter_every_04
    BPL L4C14 ; every 4 cycles
    LDA this_object_data
    AND #$03 ; is the nest active?
    BNE L4C14 ; if not, leave
    LDA this_object_extra                               ; this_object_extra = child type
    JSR count_objects_of_type_a_in_stack            ; how many children already exist?
    JSR increment_timers
    AND timer_1
    AND timer_3
    AND #$07 ; create up to seven children
    CMP number_particles_OR_this_object_gravity_flags ; count                                         ; probability decreases the more there are
    BCC L4C14 ; if not, leave
    LDA #$0E ; &0e = big fish
    LDY #$86 ; &86 = object range 6 (flying enemies)
    JSR find_nearest_object                         ; are there nest enemies around?
    BPL L4C14 ; if so, leave
    JSR play_sound
    equb $33,$F3,$4F,$35; sound data
    LDA this_object_angle                             ; aim the nest's children towards the player
    AND #$80 ; &00 = straight left, &80 = straight right
    STA angle
    LDA #$20 ; velocity magnitude = &20
    JSR determine_velocities_from_angle
    LDA this_object_extra                             ; this_object_extra = child type
    JSR create_child_object                         ; create a child
    BCS L4C14 ; if we couldn't, leave
    LDA current_object
    STA object_stack_target,X                      ; child's target is the nest
    LDA #$20
    BIT this_object_angle
    BMI L4C06
    LDA #$A0
.L4C06
    STA object_stack_extra,X
    ASL A
    BCC L4C14
    LDA object_stack_palette,X                  ; change colour ?
    EOR #$3B
    STA object_stack_palette,X
.L4C14
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_engine_thruster
    AND #$03
    BNE turn_thruster_off                           ; is the thruster on?
    INC this_object_extra
    BPL L4C21
    INX
    INX
    STX this_object_data
.L4C21
    LDA timer_4
    CMP this_object_extra
    BCC L4C7A
    ASL A
    STA this_object_angle
    ASL A
    STA this_object_flags_lefted
    TYA
    BMI L4C34
    TAX
    INC object_stack_vel_x,X
.L4C34
    LDY #$FF
    STY this_object_x_centre_low_OR_particle_x_low
    LDA timer_3
    STA this_object_y_centre_low_OR_particle_y_low
    LDA this_object_x
    STA this_object_x_centre_OR_particle_x
    LDA this_object_y
    STA this_object_y_centre_OR_particle_y
    INY
    STY angle
    LDY #$37 ; &37 = thruster particles
    JSR add_particle
    LDA loop_counter
    CLC
    ADC this_object_y
    AND #$03
    BNE L4C68
    SEC
    ROR sucking_damage                                ; cause damage when blowing objects away
    LDA #$50
    STA sucking_distance
    LDA #$14 ; angle range
    JSR suck_or_blow_all_objects_limited_angle
    JSR play_sound2
    equb $70,$C2,$6E,$A3; sound data
.L4C68
    LDY #$34 ; firing_angle
    LDA loop_counter
    ROL A
    ROL A
    ROL A
    ROL A
    ADC loop_counter
    AND #$3F
    ADC #$90
    BNE L4C7E
.turn_thruster_off
    STA this_object_extra
.L4C7A
    LDY #$00 ; 0 colour = off
    LDA #$40
.L4C7E
    STY this_object_palette                             ; change colour
    STA this_object_x_low
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_door
    BMI L4C8D ; is it touching anything?
    JSR can_object_trigger_switch
    BCS L4C8D
    SEC
    ROR this_object_supporting
.L4C8D
    LSR this_object_flags_lefted
    LDX this_object_ty
    LDY this_object_extra
    STY this_object_x,X
    LDA #$FF
    STA this_object_x_low,X
    LDA this_object_data_pointer ; ; this_object_data_pointer
    STA door_data_pointer_store
    JSR has_object_been_hit_by_rcd_beam
    BCS L4CA8 ; has it been hit by the rcd beam?
    LDA #$40
    JSR toggle_door_locked_state                    ; if so, toggle its lock
.L4CA8
    ROR door_data_pointer_store
    LDA this_object_data
    ORA #$04
    PHA
    LSR A
    ROR A
    ROR A
    STA number_particles_OR_this_object_gravity_flags
    LSR A
    AND #$07
    STA zp_various_9e
    AND #$03
    TAX
    PHP
    LDA this_object_energy
    CMP unknown_doors_lookup,X
    LDA #$FF
    BCS L4CD5
    PLP
    PHP
    LDA #$00
    BCS L4CD5
    PLP
    PLA
    ORA #$08
    PHA
    PHP
    BCS L4CD7
.L4CD5
    STA this_object_energy
.L4CD7
    LDA unknown_doors_two,X
    PLP
    BCC L4CDF
    LDA #$01
.L4CDF
    BIT number_particles_OR_this_object_gravity_flags
    BMI L4CEC
    LSR A
    EOR #$FF
    BIT this_object_supporting
    BMI L4CEC
    LDA #$FF
.L4CEC
    STA zp_various_9c
    LDA this_object_tx
    EOR #$80
    SEC
    SBC zp_various_9c
    BVC L4D3B
    JSR prevent_overflow
    TAY
    BPL L4D09
    TXA
    BNE L4D0D
    LDA door_timer
    CMP #$14
    BCS L4D0D
    BCC L4D22
.L4D09
    PLA
    AND #$FB
    PHA
.L4D0D
    BIT this_object_supporting
    BMI L4D3A
    BIT number_particles_OR_this_object_gravity_flags
    BVS L4D3A
    TXA
    BNE L4D22
    LDA door_timer
    BNE L4D3A
    LDA #$3C
    STA door_timer
.L4D22
    PLA
    EOR #$02
    PHA
    AND #$02
    BEQ L4D33
    JSR play_sound
    equb $C7,$C3,$C1,$13; sound data
    BCS L4D3A
.L4D33
    JSR play_sound
    equb $C7,$C3,$C1,$03; sound data
.L4D3A
    TYA
.L4D3B
    EOR #$80
    LDX this_object_ty
    TAY
    SEC
    SBC this_object_tx
    CMP #$80
    ROR A
    STA this_object_vel_x,X
    TYA
    STA this_object_tx
    CLC
    ADC #$10
    STA this_object_x_low,X
    LDA this_object_extra
    ADC #$00
    STA this_object_x,X
    PLA
    LDY this_object_energy
    BNE L4D5D
    ORA #$04
.L4D5D
    STA this_object_data
    LDX this_object_data_pointer
    STA background_objects_data,X
    LDX zp_various_9e
    LDA door_palettes,X
    BIT number_particles_OR_this_object_gravity_flags
    BVS L4D6F
    AND #$0F
.L4D6F
    STA this_object_palette                             ; change colour
    RTS
.unknown_doors_two
    equb $20,$10,$08,$20
.unknown_doors_lookup
    equb $80,$74,$C0,$80
.door_palettes
    equb $2B,$2D,$15,$1C,$42,$12,$26,$4E
.teleport_beam_palettes
    equb $52,$63,$35,$21
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_teleport_beam
    LSR A ; data & &01 = teleporter inactive
    AND #$0F ; data & &1e = teleport number * 2
    TAX ; X = teleport number
    LDA #$B0 ; &b0 = beam sitting in teleporter base
    BCS stationary_beam
    TYA
    BMI deal_with_the_beam_itself                       ; is the beam touching something?
    LDA object_stack_flags,Y
    AND #$10 ; if so, is it already teleporting?
    BNE deal_with_the_beam_itself                   ; if so, ignore it; otherwise
    LDA teleport_destinations_x,X
    STA object_stack_tx,Y                            ; start teleporting the object
    LDA teleport_destinations_y,X
    STA object_stack_ty,Y
    JSR mark_stack_object_as_teleporting
    JSR set_object_velocities                   ; set the object velocities to those of the beam
    JSR play_teleport_noise
.deal_with_the_beam_itself
    LDA this_object_flags
    AND #$04 ; is the beam active?
    BNE no_beam_motion                              ; if not, don't move it
    LDA this_object_extra                             ; this_object_extra = beam position
    ADC #$20
    CMP #$B1 ; scan beam through teleporter
    BCC stationary_beam
    SBC #$B0 ; restarting when it gets to the bottom
.stationary_beam
    STA this_object_extra                               ; this_object_extra = beam position
    BIT this_object_flags_lefted
    JSR make_negative
    STA this_object_y_low
    DEC this_object_y_low
.no_beam_motion
    JSR has_object_been_hit_by_rcd_beam             ; has the beam been hit by the rcd beam?
    BCS rotate_colour_6
    LDA #$00
    JSR toggle_door_locked_state                    ; if so, toggle its state
.rotate_colour_6
    LDA current_object_rotator
.rotate_colour
    LSR A
    LSR A
    AND #$03
    TAX
    LDA teleport_beam_palettes,X
    STA this_object_palette                             ; change colour
.L4DDE
    RTS
.flash_palette
    LDY this_object_type
    LDA object_sprite_lookup+101,Y ; object_palette_lookup
    AND #$7F ; use the object's default palette
    BCS L4DEA
    EOR #$30 ; eor &30 if carry is set
.L4DEA
    STA this_object_palette
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ?
.handle_sucker_deadly
    LDA sucker_palettes,X                            ; X = this_object_data
    LSR A
    STA this_object_palette                           ; set colour of sucker
    LDA current_object_rotator_low
    BEQ L4E0B
    LDA sucker_attracted_lookup,X ; what does the sucker like to suck?
    BMI no_attraction                               ; if nothing, skip
    TAY
    CMP #$55 ; &55 = coronium boulder
    BNE L4E03 ; if so, then also suck
    LDY #$0B ; &0b = yellow ball
.L4E03
    JSR find_nearest_object
    TXA ; X = object number of nearest object
    EOR #$FF
.no_attraction
    STA this_object_extra                             ; this_object_extra = attracted object
.L4E0B
    LDA this_object_extra
    BPL no_attraction_2                             ; if no attracted object, skip
    LDX this_object_data
    LDA sucker_palettes,X
    LSR A
    ROR sucking_angle_modifier
    LDA sucker_sucking_distances,X
    STA sucking_distance
    JSR suck_or_blow_all_objects                    ; suck/blow objects towards/away from us
    LDA timer_3
    STA this_object_angle
    CMP #$50
    BEQ L4E29
.no_attraction_2
    LDA #$02
.L4E29
    LDY this_object_supporting                        ; are we supporting anything?
    BMI L4DDE ; if not, leave
    JSR play_sound
    equb $57,$07,$57,$97; sound data [TOM 97 was 95]
    JMP take_damage                                 ; if so, damage it! (damage = 2)
.sucker_attracted_lookup
equb $FF,$3E,$11,$55,$10,$FF,$55,$10,$0F ; &3e = door, &10 = pirahna, &55 = coronium, &11 = wasp, &0f = worm, &ff = nothing
.sucker_sucking_distances
    equb $50,$30,$7F,$40,$50,$7F,$7F,$50,$40
.sucker_palettes
    equb $5F,$AC,$BF,$3D,$F9,$58,$A2,$D8,$4B
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_maggot
    LDA this_object_energy
    AND #$7F
    STA this_object_energy
    LDA #$82 ; &82 = crew member + player
    LDY #$2F ; &2f = white/yellow bird
    LDX #$14 ; maggot damage = &14
.from_handle_worm
    STX L4E85+1 ; self modifying code
    JSR find_target_occasionally
    JSR target_processing
    JSR move_npc
    BMI maggot_moved
    JSR increment_timers
    BIT underwater
    BMI L4E75
    LDA #$FF
.L4E75
    ASL this_object_extra
    CMP #$F6
    ROR this_object_extra
    LDY this_object_supporting
    CPY this_object_target_object                     ; is it touching its target?
    BNE L4E8A
    LDA #$0A
    STA this_object_timer
.L4E85
    LDA #$14 ; modified by &4e5e; actually LDA #X    ; only maggots cause damage
    JSR take_damage
.L4E8A
    LDX this_object_water_level
    DEX
    BMI L4E94 ; is it underwater?
    LDX loop_counter_every_10
    STX object_collision_with_other_object_top_bottom
.L4E94
    LDA #$10
    BIT this_object_target
    BPL L4EB8 ; target &80 = &00 ?
    ASL A
    PHA
    JSR get_object_distance_from_screen_centre
    CMP #$0F ; is it close to the screen?
    BCS L4EB7
    EOR #$0F ; the nearer it is, the noisier it is
    CMP timer_3
    BCC L4EB7
    JSR play_sound                                  ; make a noise
    equb $33,$F3,$09,$B4; sound data
    JSR play_sound
    equb $33,$F3,$07,$B5; sound data
.L4EB7
    PLA
.L4EB8
    LDX #$06 ; type ; A = speed
    JSR something_motion_related
    BCS maggot_moved
    LDA #$06
    STA this_object_timer
.maggot_moved
    JSR flip_object_in_direction_of_travel_on_random_3
    LDA this_object_vel_y
    SBC #$04
    STA this_object_flags_lefted
    LDA current_object_rotator
    AND #$04
    LSR A
    ORA this_object_timer
    STA this_object_timer
    JMP L44DC
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_turret
    LSR A ; if lowest bit of this_object_data set,
    BCS no_firing                                   ; the turret is switched off; don't fire
    TAX ; this_object_data / 2 = bullet type
    BNE turret_firing                               ; which is presumably non-zero, so turret is stationary
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_robot
    BIT this_object_energy                            ; consider the object's energy
    BPL no_firing                                   ; don't move or fire if energy is low unless the robot is the blue one
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_robot_blue
    LDX #$05
    JSR npc_targetting
    JSR target_processing
    LDX #$04 ; type
    LDA #$18 ; speed
    JSR something_motion_related
    JSR flip_object_in_direction_of_travel_on_random_3
    LDY this_object_type
    LDX robot_bullet_lookup-first_robot_type,Y ; robot_bullet_lookup       ; actually &4f1e
.turret_firing
    BIT this_object_energy                            ; consider the object's energy
.L4EFB
    BPL no_firing ; don't fire if energy is low
    LDY #$84
    LDA this_object_y
.L4F01
    CMP #$B4 ; is y > &b4 ?
    BCS L4F0B
    BIT timer_3
    BVS L4F0B
    LDY #$86 ; &86 = range 6 (flying enemies)
.L4F0B
    LDA #$81 ; &81 = active chatter + player
    JSR find_a_target_and_fire_at_it                ; find a target and fire at it
.no_firing
    LDX this_object_type
    LDY robot_energy_lookup-first_robot_type,X ; robot_energy_lookup       ; actually &4f18 # minimum energy
    JMP L353A ; gain_energy_or_flash_if_damaged
.robot_energy_lookup
    equb $14,$46,$46,$14,$7F,$14
.robot_bullet_lookup
    equb $18,$13,$14; robot_bullet_lookup   ; &18 = pistol bullet, &13 = icer bullet, &14 = tracer bullet
;;       1c 1d 1e ; magenta robot, red robot, blue robot
;; robot_bullet_lookup   ; &18 = pistol bullet, &13 = icer bullet, &14 = tracer bullet
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_nest_dweller
    LDA #$05
    LDY this_object_type
    CPY #$11 ; &11 = wasp
    ROR this_object_flags_lefted                      ; note whether it's a wasp for later
    BMI L4F31
    LDA #$04
    STA acceleration_y                                ; acceleration for pirahna
    LDA #$04
.L4F31
    DEC acceleration_y                                ; wasp float somewhat
    BIT timer_3                                       ; sometimes find targets, sometimes not
    BVS L4F42
    LDX this_object_extra
    CPX timer_2                                       ; sometimes target the player, sometimes not
    BCS L4F3F
    LDA #$00 ; &00 = player
.L4F3F
    JSR find_target_occasionally                    ; Y = object_type, so other nest dwellers
.L4F42
    JSR target_processing
    JSR increment_timers
    BEQ L4F57
    CMP this_object_extra
    BCC L4F5E
    LDY this_object_supporting                        ; are we supporting something?
    BNE L4F5E ; if so, is it the player?
    LDA #$18
    JSR take_damage                                 ; wasp / pirahna damage = &18
.L4F57
    JSR play_sound
    equb $33,$F3,$4F,$35; sound data
.L4F5E
    LDA #$0C ; modulus
    JSR get_sprite_from_velocity                    ; use velocity
    LSR A ; to calculate sprite for wasp / pirahna
    LSR A ; (&00 - &02)
    JSR change_sprite                               ; set the sprite based on result
    JSR flip_object_in_direction_of_travel
    BIT wall_collision_top_or_bottom                  ; has it collided with a wall?
    BMI L4F75 ; if so, keep it moving regardless
    LDA this_object_flags_lefted
    EOR underwater                                    ; is the creature out of its element?
    BMI L4F9B ; if so, it doesn't move
.L4F75
    LDA #$30 ; velocity magnitude = &30
    LDY #$18 ; maximum speed = &18
    LDX #$28 ; probability = &28
    JSR move_towards_target_with_probability_x      ; move towards target
    BIT loop_counter_every_08
    BPL L4F9B ; every 8 cycles,
    JSR increment_timers
    AND #$02 ; pick a direction at random, x or y
    TAX
    LDA timer_3
    AND #$1F ; pick a acceleration at random
    SBC #$10 ; from -16 to +15
    ADC acceleration_x,X ; X = 2, &42 acceleration_y ; X = 0, &40 acceleration_x
    STA acceleration_x,X ; X = 2, &42 acceleration_y ; X = 0, &40 acceleration_x
    LDA this_object_energy
    CMP #$0A ; increase energy if < 10
    BCS L4F9B
    JMP gain_one_energy_point_if_not_immortal
.L4F9B
    RTS
;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_explosion
    LDA #$80 ; &80 = call background object handlers
    STA background_processing_flag
    LDX this_object_x                                 ; loop over
    DEX ; this_object_x - 1 to this_object_x + 1
    STX square_x
.explosion_loop_x
    LDX this_object_y                                 ; loop over
    DEX ; this_object_y - 1 to this_object_y + 1
    STX square_y
.explosion_loop_y
    JSR determine_background                        ; call for each square
    LDX this_object_y
    CPX square_y
    INC square_y
    BCS explosion_loop_y
    LDX this_object_x
    CPX square_x
    INC square_x
    BCS explosion_loop_x
    LDA timer_2
    AND #$13
    STA this_object_palette
    LDA #$0A ; &0a particles
    LDY #$16 ; &16 = explosion particles
    JSR add_particles
    LDA this_object_data_pointer                      ; data_pointer is used as a timer
    BEQ explosion_remove_object                     ; when it runs out, remove the explosion
    DEC this_object_data_pointer
    LDA timer_4
    AND #$07
    CMP this_object_data_pointer                      ; towards the end of the explosion,
    BCS L4F9B ; a random chance of not blowing objects away
    LDA this_object_data_pointer
    CMP #$08
    ROR sucking_damage                                ; cause damage for first 8 cycles
    ASL A
    ASL A
    STA sucking_distance
    JMP suck_or_blow_all_objects
.explosion_remove_object
    JMP mark_this_object_for_removal

IF SRAM
; I have no idea what this is.
incbin "exilemc_data.dat"
ELSE
    equb $F3,$97,$52,$4A; (unused?)
ENDIF
    
.map_data
    equb $95,$B6,$19,$EF,$6F,$6E,$70,$5E,$D4,$A9,$A9,$57,$6D,$06,$6E,$ED
    equb $2D,$6E,$6E,$06,$CA,$70,$AD,$07,$5E,$5E,$53,$62,$53,$9B,$35,$9E
    equb $15,$16,$E9,$22,$57,$97,$0C,$CC,$8C,$78,$3F,$BD,$05,$ED,$E2,$0A
    equb $F0,$05,$2D,$6E,$D3,$07,$E4,$24,$63,$A1,$A5,$64,$53,$07,$A4,$63
    equb $66,$7E,$3E,$DC,$8C,$72,$E8,$BC,$06,$19,$22,$6D,$DE,$D3,$19,$71
    equb $F1,$7E,$29,$F4,$39,$A9,$D3,$06,$53,$A1,$E4,$07,$D4,$A9,$D3,$1A
    equb $C1,$77,$D7,$41,$6F,$A1,$6D,$53,$F5,$D3,$21,$19,$A1,$53,$06,$E5
    equb $EE,$19,$97,$D3,$13,$EA,$75,$02,$D3,$9B,$53,$EA,$5F,$85,$72,$21
    equb $6E,$2C,$2D,$07,$AD,$ED,$B1,$25,$19,$2F,$53,$3B,$9E,$E2,$D3,$62
    equb $02,$F0,$2D,$06,$A4,$D3,$19,$21,$53,$21,$ED,$30,$D3,$6A,$59,$A4
    equb $6D,$70,$6F,$04,$A4,$64,$A2,$A2,$1E,$04,$D3,$01,$4A,$3B,$64,$63
    equb $F0,$2D,$17,$ED,$F4,$2F,$12,$30,$D3,$21,$FA,$A2,$A1,$E2,$8D,$2E
    equb $64,$6E,$02,$EE,$04,$05,$13,$EE,$4A,$6A,$2D,$05,$9B,$2D,$25,$65
    equb $ED,$FE,$31,$6F,$F0,$14,$EE,$BF,$DF,$8D,$D3,$6A,$DE,$53,$8B,$1E
    equb $EE,$AD,$70,$7A,$24,$A1,$22,$6D,$22,$D3,$21,$93,$DF,$01,$02,$DC
    equb $AE,$7C,$06,$AF,$DF,$B2,$07,$29,$03,$5E,$CD,$EA,$53,$CD,$07,$8F
    equb $FC,$94,$66,$69,$30,$07,$62,$35,$D6,$9D,$BF,$2F,$9D,$62,$62,$1F
    equb $53,$21,$D3,$43,$FE,$45,$93,$74,$9E,$F0,$91,$AE,$A1,$62,$02,$07
    equb $6A,$CC,$D9,$3D,$E2,$ED,$ED,$B0,$B4,$15,$E6,$19,$57,$17,$9D,$4C
    equb $ED,$A2,$93,$65,$03,$21,$9E,$05,$B4,$B0,$06,$EE,$5E,$A1,$5E,$25
    equb $49,$F9,$07,$7C,$DE,$DE,$EA,$07,$67,$04,$BD,$68,$53,$CC,$26,$A8
    equb $7A,$21,$DE,$E2,$9E,$06,$53,$A1,$1E,$E2,$04,$E8,$9E,$04,$64,$06
    equb $B9,$06,$DA,$13,$E3,$4A,$21,$F8,$05,$C2,$32,$97,$07,$62,$ED,$70
    equb $EF,$EA,$D3,$6A,$E4,$19,$C6,$F3,$03,$19,$A8,$1E,$28,$9E,$F5,$29
    equb $07,$04,$70,$21,$1E,$1E,$06,$FA,$EE,$2C,$2D,$F0,$13,$53,$BB,$F0
    equb $56,$21,$ED,$A1,$AA,$C0,$C4,$53,$62,$EF,$2F,$F0,$70,$5E,$A1,$19
    equb $6F,$DE,$1E,$A1,$24,$02,$5F,$62,$6D,$06,$71,$8D,$13,$71,$B0,$AF
    equb $56,$EA,$DE,$A5,$21,$E5,$4B,$8D,$03,$2F,$29,$2D,$57,$38,$6E,$07
    equb $D3,$19,$2A,$E3,$B5,$6E,$49,$E5,$70,$62,$B0,$12,$53,$D3,$22,$6D
    equb $DF,$8D,$53,$A1,$D4,$DF,$21,$1E,$2D,$F0,$22,$70,$6E,$35,$12,$E2
    equb $9A,$23,$A1,$61,$68,$05,$A5,$D3,$04,$2E,$06,$19,$07,$D3,$E1,$2E
    equb $24,$9B,$53,$CD,$07,$CD,$CA,$0F,$52,$ED,$E2,$2E,$05,$34,$78,$04
    equb $3A,$7B,$04,$AD,$53,$E1,$B1,$07,$DF,$21,$13,$FA,$7E,$19,$5E,$7B
    equb $05,$96,$3F,$BD,$54,$DD,$19,$B1,$32,$BC,$69,$2B,$21,$6F,$EE,$19
    equb $B8,$B2,$2D,$2D,$64,$20,$53,$03,$53,$A1,$3E,$FE,$D3,$07,$53,$FB
    equb $A8,$B7,$29,$2B,$E8,$BC,$68,$DD,$19,$39,$A2,$B1,$F0,$53,$1E,$AD
    equb $70,$3B,$03,$D6,$53,$1E,$7A,$A5,$07,$1B,$53,$DE,$1E,$9E,$D3,$21
    equb $D6,$19,$68,$FD,$02,$6A,$34,$66,$B0,$9E,$04,$EF,$04,$DE,$ED,$F1
    equb $ED,$18,$A4,$69,$17,$53,$53,$E2,$ED,$30,$DE,$EA,$9E,$19,$19,$47
    equb $EF,$06,$8C,$72,$EF,$19,$2F,$F0,$ED,$B9,$99,$B1,$DE,$23,$A3,$78
    equb $A2,$2F,$30,$EF,$04,$B5,$E4,$A1,$D3,$19,$7A,$A1,$CD,$DA,$1B,$D3
    equb $6D,$06,$ED,$71,$B1,$6E,$04,$6D,$EE,$AF,$4A,$D1,$5E,$1E,$53,$7C
    equb $EF,$18,$F0,$2D,$02,$B8,$7F,$62,$7C,$8D,$12,$DE,$C6,$E4,$8B,$AE
    equb $0D,$ED,$AD,$8D,$E2,$DF,$B1,$6E,$E4,$04,$64,$07,$25,$F0,$E4,$19
    equb $2E,$EF,$19,$B0,$4F,$32,$75,$07,$E4,$8D,$5F,$21,$D4,$CD,$CB,$53
    equb $8F,$AE,$AF,$ED,$4A,$21,$A1,$79,$23,$EA,$07,$13,$54,$F5,$62,$24
    equb $6F,$4A,$EE,$11,$13,$93,$1E,$A9,$25,$5F,$A1,$7A,$24,$A5,$5E,$0F
    equb $A4,$1E,$EE,$19,$A0,$53,$E1,$A1,$93,$93,$D3,$E1,$32,$97,$93,$53
    equb $D3,$19,$21,$1E,$F9,$19,$A5,$03,$6B,$21,$AE,$12,$7C,$6A,$FA,$2D
    equb $38,$72,$BF,$B0,$21,$EF,$11,$B5,$56,$36,$02,$3D,$68,$01,$8C,$30
    equb $D3,$21,$64,$7E,$64,$A1,$7C,$21,$54,$FE,$F2,$6E,$E4,$29,$5F,$04
    equb $19,$19,$2A,$AF,$2D,$E2,$6A,$6F,$A7,$69,$F7,$E9,$32,$A8,$FC,$28
    equb $FA,$07,$D3,$6A,$64,$32,$53,$05,$4A,$62,$04,$56,$D3,$6A,$54,$A4
    equb $6D,$53,$E2,$ED,$69,$14,$1E,$EF,$37,$00,$40,$28,$D3,$05,$2D,$74
    equb $ED,$05,$EF,$5E,$53,$E3,$19,$A5,$30,$05,$17,$A1,$A8,$5F,$21,$05
    equb $22,$ED,$E2,$B1,$62,$02,$64,$65,$6D,$2C,$12,$CC,$6D,$E2,$04,$D3
    equb $53,$A1,$19,$AB,$A2,$CD,$8B,$13,$01,$AF,$21,$ED,$51,$94,$F5,$29
    equb $39,$2E,$F0,$1A,$5E,$02,$1E,$7A,$AD,$ED,$39,$70,$B1,$EE,$03,$B4
    equb $D6,$8D,$53,$21,$C2,$DE,$8B,$2D,$ED,$19,$2F,$2F,$01,$AF,$FF,$3F
    equb $53,$00,$ED,$25,$06,$EF,$24,$E2,$2D,$ED,$ED,$DE,$5E,$7B,$31,$07
    equb $13,$CD,$D3,$1B,$D4,$CD,$07,$06,$A2,$6F,$A2,$31,$F0,$06,$F8,$62
    equb $A1,$53,$AA,$00,$64,$05,$00,$25,$0F,$6D,$53,$ED,$D3,$19,$13,$93
    equb $22,$D3,$22,$E1,$05,$64,$65,$2D,$70,$19,$62,$06,$22,$63,$63,$BB
    equb $64,$63,$53,$04,$22,$72,$63,$7E,$64,$63,$64,$05,$22,$65,$5B,$A1

;; ##############################################################################
;; 
;;    Sprites
;;    =======
;;    &00 spaceman, flying horizontally
;;    &01 spaceman, reclined forwards
;;    &02 spaceman, upright, jumping
;;    &03 spaceman, reclined backwards
;;    &04 spaceman, upright, stationary
;;    &05 spaceman, upright, walking
;;    &06 spaceman, upright, walking
;;    &07 spaceman, upright, walking
;;    &08 bullet
;;    &09 bullet
;;    &0a bullet
;;    &0b bullet
;;    &0c bullet
;;    &0d bullet
;;    &0e grass frond
;;    &0f red drop
;;    &10 frogman
;;    &11 frogman
;;    &12 frogman
;;    &13 robot
;;    &14 chatter
;;    &15 hovering robot
;;    &16 clawed robot
;;    &17 fireball
;;    &18 grass tuft
;;    &19 half bush
;;    &1a bush
;;    &1b full nest
;;    &1c half nest / slime
;;    &1d half nest / slime
;;    &1e small round nest / slime
;;    &1f small nest / slime
;;    &20 rock
;;    &21 plasma ball
;;    &22 coronium crystal
;;    &23 spaceship support
;;    &24 spaceship corner with pipes
;;    &25 spaceship tiny corner
;;    &26 spaceship wall left quarter
;;    &27 spaceship wall \ from top left to top 3/4 right
;;    &28 spaceship wall \ from top 3/4 left to middle right
;;    &29 spaceship wall \ from middle left to 1/4 right
;;    &2a spaceship wall \ from 1/4 right to bottom left
;;    &2b spaceship corner
;;    &2c spaceship wall bottom half
;;    &2d switch box
;;    &2e switch
;;    &2f pipe corner, bottom left
;;    &30 pipe left side, with top corner
;;    &31 pipe bottom side, with right corner
;;    &32 spaceship wall bottom half with pipework and pipe
;;    &33 spaceship corner with pipes
;;    &34 brick wall \ from top left to middle right
;;    &35 brick wall \ from middle left to bottom right
;;    &36 stone wall \ from top left to middle right
;;    &37 stone wall \ from middle left to bottom right
;;    &38 stone wall \, filled bottom left
;;    &39 brick wall, full
;;    &3a brick wall, bottom three quarters
;;    &3b brick wall, bottom half
;;    &3c brick wall, bottom quarter
;;    &3d stone wall, full
;;    &3e stone wall, bottom half with edging
;;    &3f very thin edge, bottom
;;    &40 stone wall, bottom half with edging
;;    &41 brick wall, left quarter
;;    &42 brick wall, left quarter, steep slope
;;    &43 brick wall, \, filled bottom left
;;    &44 brick wall, \, filled bottom left 3/4s
;;    &45 gargoyle
;;    &46 brick wall, bottom quarter
;;    &47 spaceship wall with pipework
;;    &48 spaceship wall, bottom half
;;    &49 spaceship wall, bottom quarter
;;    &4a horizontal door
;;    &4b vertical door
;;    &4c hydraulic leg
;;    &4d key
;;    &4e teleporter
;;    &4f wasp
;;    &50 wasp
;;    &51 wasp
;;    &52 maggot
;;    &53 maggot
;;    &54 maggot
;;    &55 pillar
;;    &56 cannon
;;    &57 mysterious weapon
;;    &58 rcd
;;    &59 bird
;;    &5a bird
;;    &5b bird
;;    &5c bird
;;    &5d chest
;;    &5e turret
;;    &5f flagpole
;;    &60 destinator
;;    &61 big fish
;;    &62 mushrooms
;;    &63 mushroom ball
;;    &64 imp
;;    &65 imp
;;    &66 imp
;;    &67 imp
;;    &68 imp
;;    &69 imp
;;    &6a large pipe top
;;    &6b jetpack booster
;;    &6c plasma gun
;;    &6d quarter lightning
;;    &6e half lightning
;;    &6f lightning
;;    &70 sucker
;;    &71 teleporter beam
;;    &72 pirahna
;;    &73 pirahna
;;    &74 pirahna
;;    &75 fluffy
;;    &76 flask
;;    &77 (nothing)
;;    &78 hoverball
;;    &79 pill
;;    &7a fire immunity device
;;    &7b energy capsule
;;    &7c whistle
;; 
;;    Sprite data is 128 x 128, 20 bytes per row.
;; 
;; ##############################################################################
;; 6000 - 7fff is used as screen memory

.sprite_data
    equb $C0,$00,$00,$00,$32,$11,$80,$10,$00,$00,$00,$20,$06,$08,$00,$00,$01,$8C,$00,$66,$80,$00,$00,$00,$01,$02,$08,$64,$90,$80,$00,$66
    equb $8C,$00,$00,$00,$56,$A3,$C0,$CA,$00,$00,$00,$07,$2D,$66,$00,$00,$00,$00,$00,$60,$C0,$00,$00,$00,$01,$0B,$88,$42,$F0,$3E,$64,$4C
    equb $3C,$00,$00,$00,$03,$01,$19,$68,$00,$00,$13,$21,$2D,$00,$00,$00,$0B,$8D,$00,$40,$68,$00,$00,$00,$02,$AB,$00,$CB,$F8,$18,$90,$4C
    equb $DF,$00,$00,$00,$46,$23,$00,$1C,$00,$00,$37,$07,$06,$00,$00,$00,$CA,$35,$04,$42,$FC,$80,$00,$00,$13,$19,$0A,$E8,$74,$99,$83,$1E
    equb $3C,$C0,$00,$00,$46,$23,$00,$0A,$00,$00,$1F,$21,$00,$00,$00,$00,$CB,$BD,$C5,$63,$4F,$C0,$00,$00,$15,$9F,$0B,$E2,$33,$00,$87,$78
    equb $FF,$0C,$00,$00,$07,$83,$59,$0E,$00,$01,$3F,$07,$00,$00,$03,$0F,$4B,$AD,$F5,$7B,$6F,$E0,$00,$00,$47,$FF,$26,$C0,$65,$01,$96,$C0
    equb $C7,$F4,$00,$00,$04,$02,$11,$08,$00,$03,$1F,$07,$00,$00,$0F,$0F,$4A,$25,$B5,$DB,$FF,$AC,$00,$00,$4F,$FF,$4E,$80,$61,$0B,$1E,$00
    equb $FF,$EF,$00,$00,$06,$13,$11,$5C,$00,$21,$3F,$21,$00,$01,$0F,$0F,$4B,$AD,$A5,$4B,$7A,$9E,$80,$00,$37,$FB,$CE,$80,$F8,$01,$96,$E0
    equb $79,$79,$C0,$00,$06,$13,$11,$1E,$00,$07,$1F,$21,$00,$03,$1F,$2F,$4B,$AD,$85,$43,$6F,$7C,$C0,$00,$13,$F9,$8C,$40,$E0,$00,$87,$3C
    equb $2F,$3D,$CC,$00,$26,$03,$00,$8C,$00,$21,$3F,$07,$00,$03,$0E,$0D,$4A,$25,$04,$42,$DF,$4F,$CA,$00,$13,$F0,$8C,$10,$80,$11,$87,$1E
    equb $FF,$FF,$3C,$00,$04,$03,$28,$24,$00,$07,$3F,$07,$00,$07,$0F,$0F,$0B,$8D,$00,$40,$BD,$EF,$9E,$00,$0D,$F0,$8F,$00,$0C,$10,$80,$84
    equb $96,$C7,$F7,$00,$04,$06,$68,$30,$00,$21,$1F,$21,$00,$06,$0B,$0D,$00,$00,$00,$40,$9F,$3E,$5E,$80,$15,$F1,$AE,$00,$CC,$32,$32,$00
    equb $FF,$FF,$DE,$80,$40,$40,$40,$10,$00,$07,$3F,$21,$00,$11,$44,$22,$03,$0E,$00,$42,$FF,$A7,$FC,$84,$37,$EB,$CC,$01,$0E,$00,$12,$08
    equb $B6,$1E,$8F,$68,$60,$60,$00,$03,$00,$21,$3F,$07,$01,$0F,$0F,$0F,$0E,$0B,$08,$41,$A7,$BF,$9F,$68,$6F,$EF,$0F,$11,$CA,$00,$25,$0C
    equb $FF,$FF,$FF,$8E,$00,$00,$00,$CA,$00,$07,$1F,$07,$01,$0F,$0F,$0F,$88,$88,$88,$62,$6F,$9F,$3F,$F8,$07,$BF,$0D,$03,$2D,$00,$48,$44
    equb $69,$C7,$78,$BE,$00,$11,$91,$06,$00,$21,$3F,$07,$00,$80,$00,$90,$00,$12,$C0,$71,$CF,$FF,$EF,$FE,$11,$9B,$88,$33,$ED,$00,$4B,$0E
    equb $6D,$6F,$3D,$8F,$00,$23,$C0,$0C,$00,$21,$3F,$21,$30,$E8,$30,$B9,$0C,$25,$E0,$50,$6F,$8F,$D6,$AF,$01,$8A,$08,$07,$0F,$08,$00,$00
    equb $FF,$FF,$FF,$FF,$00,$01,$19,$1A,$11,$07,$1F,$21,$73,$FC,$73,$BB,$CE,$25,$C0,$66,$ED,$AF,$CF,$CB,$00,$0B,$8C,$FF,$8F,$1D,$FF,$FF
    equb $3C,$9E,$C7,$3C,$00,$23,$11,$2A,$13,$07,$3F,$07,$74,$F2,$74,$B0,$CE,$00,$31,$06,$CF,$FF,$9F,$DF,$01,$09,$00,$07,$0F,$08,$DC,$E0
    equb $FF,$FF,$FF,$FF,$00,$03,$59,$08,$04,$21,$3F,$07,$64,$B2,$64,$90,$ED,$FF,$E2,$FF,$7F,$BF,$DF,$7F,$22,$00,$88,$33,$6F,$11,$DD,$FF
    equb $E3,$3D,$0F,$E3,$00,$01,$11,$4C,$17,$21,$1F,$07,$64,$32,$32,$07,$ED,$FF,$80,$06,$7B,$3E,$7F,$1F,$74,$11,$C0,$03,$07,$00,$DC,$E0
    equb $FF,$FF,$FF,$FF,$00,$02,$11,$7E,$0C,$07,$3F,$07,$64,$77,$B0,$27,$EB,$FF,$EE,$FF,$2F,$E7,$3F,$BF,$40,$10,$00,$11,$46,$11,$DD,$FF
    equb $3C,$8F,$79,$2D,$00,$07,$00,$3C,$97,$07,$3F,$21,$64,$72,$80,$05,$EB,$00,$33,$06,$7F,$3F,$7E,$EF,$60,$10,$80,$01,$0E,$00,$CC,$00
    equb $FF,$FF,$FF,$FF,$00,$27,$00,$0C,$0C,$21,$1F,$21,$FE,$00,$20,$07,$E7,$25,$C0,$66,$DF,$FF,$CF,$4F,$70,$10,$C0,$00,$CC,$00,$11,$CC
    equb $CB,$6B,$D6,$C7,$08,$0D,$00,$40,$97,$21,$1F,$07,$F4,$20,$20,$27,$6F,$25,$E0,$05,$9E,$CF,$C7,$6D,$DC,$33,$40,$11,$00,$00,$D1,$88
    equb $87,$E7,$1E,$DE,$18,$81,$00,$60,$0C,$07,$3F,$07,$00,$32,$64,$05,$69,$00,$00,$05,$8F,$4F,$5F,$EF,$8E,$23,$08,$C1,$60,$00,$00,$00
    equb $FF,$FF,$FF,$FF,$98,$10,$00,$00,$0C,$07,$3F,$07,$64,$32,$32,$06,$6F,$88,$40,$20,$DF,$FE,$FF,$B7,$0D,$03,$04,$61,$C0,$8E,$30,$80
    equb $A7,$1E,$C7,$4B,$90,$10,$80,$00,$97,$07,$1F,$07,$64,$77,$B0,$00,$6F,$08,$90,$22,$F7,$3F,$EF,$3F,$8C,$23,$04,$01,$11,$4A,$07,$0C
    equb $FF,$FF,$FF,$FF,$88,$22,$00,$00,$1F,$21,$1F,$21,$64,$72,$80,$20,$6F,$98,$B0,$64,$5F,$B7,$2F,$EF,$8F,$AB,$08,$11,$11,$ED,$F0,$F7
    equb $9E,$C7,$79,$1E,$08,$74,$00,$88,$0C,$21,$3F,$21,$E0,$00,$30,$E2,$6F,$78,$70,$BC,$5F,$AF,$7B,$8F,$8B,$AB,$2E,$9F,$01,$BD,$00,$00
    equb $FF,$FF,$FF,$FF,$88,$40,$11,$C0,$84,$07,$3F,$07,$E8,$20,$73,$EE,$6F,$7C,$A0,$06,$CF,$FF,$6F,$ED,$CC,$22,$3F,$99,$99,$2F,$73,$EE
    equb $7B,$5A,$8F,$C7,$80,$60,$10,$00,$1F,$07,$1F,$07,$C0,$3A,$30,$E0,$6F,$3C,$04,$9C,$8F,$7D,$CF,$F7,$37,$11,$11,$FF,$99,$0F,$30,$C4
    equb $E3,$0F,$1E,$E7,$08,$70,$10,$80,$00,$11,$EE,$0F,$01,$3A,$04,$20,$6F,$D8,$A0,$0E,$FF,$C7,$EF,$5F,$07,$09,$DD,$99,$88,$9F,$00,$00
    equb $FF,$FF,$FF,$FF,$88,$DC,$10,$C0,$00,$11,$EE,$0F,$1B,$3A,$06,$0E,$6F,$1C,$C0,$04,$D7,$6F,$7F,$4F,$07,$0D,$0C,$9F,$00,$EE,$73,$EE
    equb $3C,$9E,$E3,$1E,$0C,$8E,$33,$40,$00,$01,$0E,$44,$0A,$3A,$04,$0E,$6F,$BC,$80,$2A,$1F,$FF,$FD,$CF,$07,$0D,$08,$00,$00,$5C,$30,$CC
    equb $FF,$FF,$FF,$FF,$CC,$0D,$23,$08,$00,$11,$EE,$0B,$0B,$3A,$02,$4E,$6F,$E8,$80,$9F,$BF,$BD,$9F,$FF,$0E,$81,$08,$00,$00,$2C,$30,$C4
    equb $4F,$79,$0F,$E3,$C0,$8D,$03,$04,$00,$05,$0E,$0F,$1B,$3A,$06,$0A,$6F,$5F,$48,$03,$EF,$0F,$9F,$7B,$0C,$C5,$08,$00,$00,$6E,$30,$CC
    equb $FF,$FF,$FF,$FF,$8C,$8E,$23,$00,$00,$04,$00,$0F,$0A,$2A,$0E,$0E,$6F,$1F,$0C,$06,$7B,$2F,$FF,$2F,$80,$C1,$00,$00,$00,$2C,$00,$00
    equb $3D,$BC,$79,$0F,$88,$8F,$AB,$2E,$00,$1D,$EE,$78,$09,$09,$4E,$4E,$6F,$EF,$4E,$40,$1F,$FF,$EB,$2F,$C4,$10,$00,$00,$00,$5C,$33,$CC
    equb $3C,$8F,$7D,$3C,$C8,$8B,$AA,$2E,$00,$0D,$0E,$08,$0C,$03,$0A,$0A,$6F,$8F,$DF,$60,$FF,$BD,$3F,$6F,$C0,$10,$88,$00,$00,$00,$30,$CC
    equb $FF,$FF,$FF,$FF,$CC,$44,$33,$00,$01,$08,$00,$0F,$0E,$07,$0E,$0E,$F0,$F0,$F0,$C0,$BD,$1F,$1F,$FF,$00,$10,$80,$00,$00,$00,$30,$CC
    equb $E3,$1E,$8F,$E3,$48,$37,$01,$CC,$01,$5D,$EE,$78,$2F,$27,$4E,$4E,$6F,$FF,$EF,$EC,$9F,$7F,$DF,$3D,$00,$88,$00,$00,$00,$00,$30,$CC
    equb $FF,$FF,$FF,$FF,$88,$07,$01,$0E,$03,$01,$0E,$08,$0D,$05,$0A,$0A,$6F,$FF,$EF,$EC,$DF,$DE,$FF,$8F,$22,$91,$40,$40,$00,$00,$30,$C4
    equb $0F,$C7,$79,$2D,$C4,$03,$01,$0E,$03,$C4,$01,$0F,$0F,$07,$0E,$0E,$6F,$FF,$EF,$DE,$7F,$4F,$CB,$EF,$20,$54,$40,$41,$00,$00,$30,$CC
    equb $FF,$FF,$FF,$FF,$CE,$CB,$63,$0E,$06,$00,$03,$F0,$0A,$02,$0A,$0A,$6F,$FF,$EF,$DE,$6F,$6F,$8F,$BF,$45,$42,$61,$C3,$AC,$85,$30,$CC
    equb $6B,$79,$0F,$C7,$4A,$C3,$61,$20,$16,$D5,$8F,$00,$55,$55,$55,$55,$6F,$FF,$EF,$BE,$FF,$A7,$FF,$BD,$61,$00,$A9,$81,$7F,$CE,$30,$CC
    equb $7F,$FF,$FF,$FF,$CC,$90,$40,$31,$0E,$01,$0F,$0F,$0F,$0F,$0F,$0F,$6F,$FF,$EF,$BE,$3D,$BF,$DF,$9F,$20,$B8,$01,$03,$88,$07,$30,$CC
    equb $CF,$C7,$B5,$3C,$C6,$10,$88,$30,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$F0,$F0,$F0,$7E,$8F,$EF,$4F,$FF,$89,$A4,$99,$00,$CC,$CE,$30,$C4
    equb $F7,$FF,$FF,$CE,$00,$10,$80,$00,$0F,$0F,$0F,$0F,$0F,$07,$0E,$0F,$00,$30,$00,$02,$F0,$F2,$F3,$F4,$A0,$90,$80,$00,$77,$CD,$30,$CC
    equb $B5,$0F,$E3,$68,$00,$00,$00,$10,$0F,$0F,$0F,$0F,$0F,$07,$19,$1E,$00,$31,$00,$55,$60,$F0,$70,$E0,$51,$40,$11,$22,$0F,$0F,$30,$CC
    equb $79,$AD,$7B,$0C,$00,$00,$00,$10,$0C,$03,$00,$00,$0E,$02,$47,$69,$00,$20,$11,$20,$40,$A0,$20,$40,$12,$39,$32,$31,$F0,$6F,$30,$C4
    equb $FF,$FF,$8F,$C0,$00,$00,$00,$30,$3C,$C3,$F0,$F0,$19,$55,$1E,$83,$00,$02,$00,$E0,$00,$2B,$04,$00,$22,$C6,$31,$3E,$00,$F6,$30,$CC
    equb $2F,$6B,$DF,$88,$00,$00,$00,$21,$0F,$0F,$0F,$0F,$47,$0F,$69,$4F,$00,$06,$01,$51,$00,$22,$09,$44,$10,$50,$33,$3F,$06,$6F,$30,$CC
    equb $EF,$6B,$5A,$80,$00,$00,$00,$61,$00,$06,$00,$00,$0F,$1E,$87,$0F,$00,$0E,$C0,$C0,$11,$7F,$26,$44,$00,$28,$33,$33,$60,$0F,$30,$CC
    equb $7F,$FF,$CF,$00,$00,$00,$00,$43,$F0,$96,$F0,$F0,$0F,$69,$0F,$0E,$01,$0D,$EA,$82,$15,$55,$67,$4C,$10,$0C,$11,$22,$00,$44,$30,$C4
    equb $96,$C7,$78,$00,$00,$00,$00,$43,$0F,$0F,$0F,$0F,$1E,$83,$0F,$1B,$67,$0B,$50,$C0,$33,$DF,$EF,$EE,$00,$08,$00,$00,$0F,$CD,$30,$CC
    equb $FF,$FF,$CA,$00,$00,$00,$00,$A5,$00,$0C,$00,$03,$69,$4F,$0E,$4D,$46,$00,$10,$22,$AA,$9D,$AA,$AA,$00,$08,$55,$00,$09,$F0,$30,$CC
    equb $2D,$3C,$E8,$00,$00,$00,$10,$87,$F0,$3C,$F0,$C3,$87,$0F,$1B,$07,$4D,$2E,$10,$80,$EF,$17,$23,$BF,$65,$11,$60,$00,$69,$49,$30,$CC
    equb $EF,$1E,$0C,$00,$00,$00,$10,$D7,$0F,$0F,$0F,$0F,$0F,$0E,$4D,$0C,$8F,$2E,$30,$44,$46,$0E,$37,$99,$33,$8A,$B0,$88,$69,$6E,$00,$00
    equb $7B,$CF,$C0,$00,$00,$00,$30,$7F,$0F,$0F,$0F,$0F,$0F,$1B,$07,$00,$8F,$00,$20,$00,$0F,$07,$1B,$06,$55,$9D,$55,$02,$0F,$08,$70,$EE
    equb $EF,$6F,$88,$00,$00,$00,$30,$7B,$0A,$0D,$0A,$0D,$0E,$4D,$0C,$00,$CE,$00,$00,$44,$0B,$06,$1F,$0B,$66,$0A,$FA,$27,$09,$01,$00,$AC
    equb $2D,$5E,$80,$00,$00,$00,$21,$2F,$55,$22,$55,$22,$1B,$07,$00,$00,$20,$00,$00,$22,$30,$01,$08,$11,$33,$8C,$A0,$FD,$09,$21,$91,$3D
    equb $F3,$EF,$00,$00,$00,$00,$53,$A7,$0F,$0F,$0F,$0F,$4D,$0C,$00,$00,$E0,$00,$00,$22,$43,$0B,$0C,$32,$80,$19,$50,$27,$69,$25,$91,$0F
    equb $EF,$3C,$00,$00,$00,$00,$53,$AF,$0F,$0F,$0F,$0F,$07,$00,$00,$00,$C0,$00,$00,$01,$04,$82,$44,$20,$00,$04,$55,$02,$6F,$3D,$80,$0E
    equb $B4,$2E,$00,$00,$00,$00,$A7,$EF,$05,$0F,$0F,$0A,$0C,$00,$00,$00,$80,$00,$00,$88,$06,$03,$00,$30,$00,$24,$24,$24,$6F,$2C,$91,$8C
    equb $FF,$68,$00,$00,$00,$10,$A5,$7F,$84,$AA,$55,$12,$08,$10,$4C,$00,$E8,$00,$11,$C0,$07,$0B,$0C,$30,$80,$24,$FF,$24,$69,$37,$3A,$0C
    equb $6B,$4C,$00,$00,$00,$01,$0F,$FF,$84,$00,$00,$12,$08,$32,$2E,$00,$44,$00,$10,$00,$00,$00,$00,$66,$80,$00,$F6,$24,$09,$33,$47,$07
    equb $FF,$C0,$00,$00,$00,$10,$6F,$8F,$85,$0F,$0F,$1A,$2E,$03,$2E,$00,$00,$00,$10,$80,$71,$9A,$0C,$47,$00,$FB,$64,$99,$09,$22,$47,$09
    equb $A5,$08,$00,$00,$00,$30,$7F,$DF,$87,$0B,$0D,$1E,$17,$01,$0C,$00,$00,$00,$10,$C0,$A7,$12,$28,$06,$19,$FD,$80,$F6,$0F,$02,$47,$2E
    equb $5E,$80,$00,$00,$00,$30,$7B,$F5,$83,$49,$29,$1C,$21,$88,$6E,$C1,$00,$00,$33,$40,$AA,$52,$70,$46,$18,$FF,$88,$64,$0F,$22,$23,$A6
    equb $9F,$00,$00,$00,$00,$53,$3F,$7F,$C9,$6C,$63,$39,$47,$88,$6A,$AC,$08,$00,$27,$00,$FF,$12,$C0,$47,$00,$FA,$00,$00,$09,$22,$11,$0C
    equb $78,$00,$00,$00,$00,$C3,$2F,$4F,$64,$3F,$CF,$62,$DF,$03,$1F,$BA,$04,$00,$CF,$09,$AF,$9A,$D0,$47,$4C,$66,$00,$00,$69,$22,$00,$0A
    equb $CE,$00,$00,$00,$00,$D3,$6F,$E7,$33,$04,$02,$CC,$8E,$02,$1F,$9F,$82,$00,$8F,$09,$AA,$CE,$60,$45,$4C,$00,$00,$44,$69,$33,$00,$0E
    equb $68,$00,$00,$00,$00,$97,$7F,$3F,$F0,$0F,$0F,$0F,$8F,$04,$17,$99,$C8,$00,$4F,$19,$FF,$CF,$08,$22,$00,$00,$00,$E8,$0F,$08,$01,$0F
    equb $8C,$00,$00,$00,$10,$0F,$FF,$FF,$C3,$87,$0F,$0F,$8F,$1D,$2E,$8F,$EC,$01,$4E,$1D,$AF,$8D,$0C,$13,$88,$00,$DF,$80,$F0,$0F,$0F,$F0
    equb $48,$00,$00,$00,$10,$7A,$6D,$BF,$F0,$0F,$0F,$0F,$65,$23,$E6,$88,$EE,$CB,$2E,$2E,$AA,$EE,$00,$03,$08,$02,$FF,$C0,$00,$1C,$83,$00
    equb $88,$00,$00,$00,$30,$3F,$4F,$AF,$77,$FF,$FF,$EE,$23,$23,$08,$F0,$F0,$C3,$0C,$26,$77,$BB,$CC,$C5,$1D,$85,$4F,$E0,$06,$1D,$8B,$06
    equb $80,$00,$00,$00,$61,$FF,$DF,$EF,$70,$A5,$0F,$0E,$03,$19,$0C,$FF,$FF,$83,$00,$01,$00,$00,$00,$80,$0C,$03,$4F,$28,$60,$1D,$8B,$60
    equb $FF,$FF,$00,$04,$52,$CF,$FF,$3F,$70,$C3,$0F,$0E,$47,$0C,$04,$00,$00,$44,$08,$01,$70,$91,$08,$E3,$1D,$87,$4F,$0C,$00,$1C,$83,$00
    equb $FF,$FF,$2D,$2A,$D3,$EF,$CF,$F7,$70,$2D,$0F,$0E,$47,$C4,$0C,$31,$00,$61,$08,$00,$87,$59,$0C,$61,$18,$87,$46,$1F,$0F,$0F,$0F,$0F
    equb $00,$00,$22,$11,$97,$2F,$6F,$CF,$70,$87,$0F,$0E,$23,$80,$0C,$31,$00,$41,$00,$00,$0F,$1D,$CC,$40,$10,$06,$00,$17,$F0,$80,$10,$F0

.sprite_width_lookup

; %wwww000h
;
; 1+%wwww is the sprite width in pixels
;
; if h=1, the horizontal flip flag is inverted when plotting the
; sprite

;        0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $C0,$A0,$50,$90,$40,$50,$60,$40,$21,$20,$20,$21,$11,$11,$50,$30 ; 0
    equb $60,$51,$50,$50,$80,$50,$50,$B0,$B0,$80,$80,$50,$90,$70,$50,$30 ; 1
    equb $40,$20,$10,$F1,$F1,$71,$30,$F0,$F0,$F0,$F0,$F1,$F0,$30,$60,$30 ; 2
    equb $30,$F0,$F0,$F1,$F0,$F0,$F0,$F0,$F1,$F0,$F0,$F0,$F0,$F0,$F0,$F0 ; 3
    equb $F0,$30,$60,$F0,$F0,$70,$00,$F0,$F0,$F0,$F0,$30,$31,$41,$F0,$20 ; 4
    equb $40,$20,$50,$50,$30,$70,$C0,$40,$40,$20,$60,$60,$40,$F0,$70,$20 ; 5
    equb $70,$90,$C0,$30,$40,$50,$60,$40,$40,$30,$F0,$20,$30,$31,$70,$B1 ; 6
    equb $F0,$70,$51,$41,$50,$51,$30,$80,$30,$30,$50,$50,$40 ;             7

.sprite_height_lookup
; %hhhhh00v
;
; 1+%hhhhh is the sprite height in pixels
;
; if v=1, the vertical flip flag is inverted when plotting the sprite

;        0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $40,$80,$98,$91,$A8,$A0,$A0,$A0,$09,$08,$10,$19,$19,$18,$58,$18 ; 0
    equb $60,$78,$81,$98,$78,$70,$98,$90,$28,$48,$78,$69,$20,$28,$38,$48 ; 1
    equb $38,$20,$08,$F8,$F8,$68,$F9,$F9,$B9,$79,$39,$F8,$78,$38,$38,$38 ; 2
    equb $F8,$38,$78,$F8,$F8,$78,$F8,$78,$F8,$F8,$C9,$78,$38,$F8,$89,$09 ; 3
    equb $49,$F8,$F8,$F9,$F9,$68,$00,$F8,$78,$38,$39,$F9,$F9,$28,$48,$18 ; 4
    equb $11,$19,$20,$29,$41,$F8,$70,$30,$20,$20,$19,$18,$28,$60,$48,$80 ; 5
    equb $58,$58,$39,$19,$68,$68,$68,$58,$68,$58,$38,$38,$28,$48,$48,$48 ; 6
    equb $48,$08,$30,$20,$28,$39,$70,$38,$30,$20,$20,$20,$20 ;             7

.sprite_offset_a_lookup
;        0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $36,$44,$C5,$04,$66,$06,$91,$41,$60,$43,$D0,$D4,$E4,$E4,$A4,$03 ; 0
    equb $97,$63,$03,$05,$77,$97,$65,$06,$06,$06,$06,$E6,$C6,$D6,$E6,$F6 ; 1
    equb $37,$D6,$65,$02,$03,$12,$C2,$03,$03,$03,$03,$02,$02,$04,$96,$C4 ; 2
    equb $04,$04,$43,$43,$00,$00,$05,$05,$01,$00,$00,$00,$00,$05,$05,$05 ; 3
    equb $05,$00,$C0,$00,$00,$44,$C0,$03,$03,$03,$07,$07,$53,$17,$02,$D4 ; 4
    equb $80,$D4,$07,$F6,$C6,$87,$04,$84,$47,$67,$C6,$C6,$96,$02,$44,$D4 ; 5
    equb $C3,$67,$36,$86,$01,$51,$31,$B1,$B1,$C4,$02,$67,$47,$15,$55,$35 ; 6
    equb $05,$00,$16,$37,$E6,$76,$04,$B6,$C4,$47,$84,$B6,$A4 ;             7

.sprite_offset_b_lookup
;        0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f
    equb $42,$02,$E9,$81,$98,$98,$E0,$E0,$7A,$00,$72,$E1,$5A,$3A,$81,$00 ; 0
    equb $E1,$0A,$02,$E9,$60,$68,$E9,$00,$00,$49,$49,$50,$68,$68,$58,$50 ; 1
    equb $D0,$D9,$A0,$00,$28,$01,$01,$09,$49,$89,$C9,$01,$81,$41,$81,$41 ; 2
    equb $80,$41,$80,$20,$00,$00,$00,$00,$89,$80,$80,$80,$31,$80,$09,$89 ; 3
    equb $49,$80,$80,$71,$01,$D0,$00,$80,$01,$41,$4A,$89,$A8,$E9,$F9,$C0 ; 4
    equb $72,$C0,$00,$20,$00,$E0,$00,$18,$11,$E1,$C0,$C8,$51,$B1,$78,$00 ; 5
    equb $2A,$00,$02,$02,$00,$00,$70,$00,$60,$E0,$4A,$0A,$B1,$99,$99,$99 ; 6
    equb $99,$72,$C9,$61,$59,$C1,$D0,$11,$88,$89,$90,$E8,$90 ;             7

if SRAM=0
if P%>&6000:ERROR "encroaching on screen RAM":endif
else
.sram_rom_end

    copyblock sram_rom_begin, sram_rom_end, sram_ram_end
    clear sram_rom_begin, sram_rom_end

    org sram_ram_end + (sram_rom_end - sram_rom_begin)

endif

.program_top

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; screen starts here; anything past this point has to be init stuff
;; only
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

if SRAM
.sram_init2_begin
endif

; 12 bytes of junk???
equb $16,$16,$16,$16,$16,$16,$16,$16,$06,$06,$06,$06
.intro1
    LDA #$01
    LDX #$28
    STA $FE00                   ; r1=40
    STX $FE01 
    LDA #$0C
    LDX #$28
    STA $FE00                   ; r12=$28 ($7c00 Mode 7)
    STX $FE01 
    LDA #$0D
    LDX #$00
    STA $FE00                   ; R13=$28 ($7c00 Mode 7)
    STX $FE01 
    LDX #$83
    LDY #$FC
    LDA #$00
.L6030
    EOR background_strip_cache_sprite+2 ; actually EOR &xxyy
    INC L6030+1 ; self modifying code
    BNE L603B
    INC L6030+2 ; self modifying code
.L603B
    INX
    BNE L6030
    INY
    BNE L6030
    STA L6084+1 ; self modifying code
    SEC
    SED
    LDA #$82
    STA intro_two
    LDA #$FC
    STA intro_three
    LDY #$00
    LDA #$6E
    STA intro_one
    LDA #$92
.L6056
    ADC intro_one
    ADC #$15
    STA intro_one
.L605C
    EOR background_strip_cache_sprite+2,Y ; actually EOF &xxf8,Y
.L605F
    STA background_strip_cache_sprite+2,Y ; actually STA &xxf8,Y
    EOR intro_one
    INY
    BNE L606D
    INC L605C+2 ; self modifying code
    INC L605F+2 ; self modifying code
.L606D
    INC intro_two
    BNE L6056
    INC intro_three
    BNE L6056
    CLD
.teleport_fallback_wrong
    LDA teleport_fallback_x
    CMP #$99
    BNE teleport_fallback_wrong
    LDA teleport_fallback_y
    CMP #$3C
    BNE teleport_fallback_wrong                 ; loop until teleport_fallback_x,y are correct
.L6084
    LDA #$64 ; actually LDA #A from &6041
    EOR maybe_another_checksum
    EOR #$9F
    STA possible_checksum
    LDA #$43
    STA maybe_another_checksum
    LDY #$07
.restore_zero_page_loop
    LDA background_strip_cache_sprite+1,Y ; copy &7f8 - &7fe
    STA timer_1-1,Y ; to &d9 - &df 
    DEY
    BNE restore_zero_page_loop
    LDY #$0F
.L60A0
    LDA object_stack_flags,Y
    ORA #$01
    STA object_stack_flags,Y
    DEY
    BNE L60A0

IF NOVELLA_LOOKUP = TRUE
    lda l499c                                                                   ; 71ab: ad 9c 49    ..I :60ab[1]
    lsr a                                                                       ; 71ae: 4a          J   :60ae[1]
    lsr a                                                                       ; 71af: 4a          J   :60af[1]
    adc l499c                                                                   ; 71b0: 6d 9c 49    m.I :60b0[1]
    eor &da                                                                     ; 71b3: 45 da       E.  :60b3[1]
    eor &dc                                                                     ; 71b5: 45 dc       E.  :60b5[1]
    jsr novella_protection                                                      ; 71b7: 20 35 62     5b :60b7[1]
ENDIF

    LDA #$0F
    STA $FE42 ; system via

; Write to addressable latch to select screen base address.
    LDA #4 OR ((latch_b4!=0) AND (1<<3))
    STA $FE40 ; system via
    LDA #5 OR ((latch_b5!=0) AND (1<<3))
    STA $FE40 ; system via

    LDA #%0000
    STA $FE4B ; system via
    LDA #$00
    STA $FE6B ; user via Auxiliary Control Register
    LDA #$04
    STA $FE4C ; system via
    LDA #$0E
    STA $FE6C ; user via Peripheral Control Register
    LDA #$7F
    STA $FE4E ; system VIA interrupt enable register
    STA $FE6E ; user VIA interrupt enable register
    LDA #%11000010              ; T1 + CA1(vsync)
    STA $FE4E ; system VIA interrupt enable register
    LDX #$0A
    LDY #$09
.video_controller_write_loop
    LDA crtc_data,X
    STY $FE00 ; write to video controller
    STA $FE01 ; write to video controller
    DEX
    DEY
    BPL video_controller_write_loop
    LDA crtc_data,X ; push &14 to
    STA $FE20 ; video ULA control register (20 columns, 2Mhz)
    JMP intro2

IF NOVELLA_LOOKUP = TRUE
.write_char_to_screen_addr_and_inc_addr
l6105 = write_char_to_screen_addr_and_inc_addr+1
l6106 = write_char_to_screen_addr_and_inc_addr+2
    sta &ffff                                                                   ; 7204: 8d ff ff    ... :6104[1]
    inc l6105                                                                   ; 7207: ee 05 61    ..a :6107[1]
    bne c610f                                                                   ; 720a: d0 03       ..  :610a[1]
    inc l6106                                                                   ; 720c: ee 06 61    ..a :610c[1]
.c610f
    rts                                                                         ; 720f: 60          `   :610f[1]

.print_txt
    stx &0a                                                                     ; 7210: 86 0a       ..  :6110[1]
    sta &0b                                                                     ; 7212: 85 0b       ..  :6112[1]
    ldy #0                                                                      ; 7214: a0 00       ..  :6114[1]
.loop_c6116
    lda (&0a),y                                                                 ; 7216: b1 0a       ..  :6116[1]
    beq c6120                                                                   ; 7218: f0 06       ..  :6118[1]
    jsr write_char_to_screen_addr_and_inc_addr                                  ; 721a: 20 04 61     .a :611a[1]
    iny                                                                         ; 721d: c8          .   :611d[1]
    bne loop_c6116                                                              ; 721e: d0 f6       ..  :611e[1]
.c6120
    rts                                                                         ; 7220: 60          `   :6120[1]

.print_page_number
    ldx #0                                                                      ; 7221: a2 00       ..  :6121[1]
    stx &01                                                                     ; 7223: 86 01       ..  :6123[1]
    sec                                                                         ; 7225: 38          8   :6125[1]
.loop_c6126
    sbc #&0a                                                                    ; 7226: e9 0a       ..  :6126[1]
    inc &01                                                                     ; 7228: e6 01       ..  :6128[1]
    bcs loop_c6126                                                              ; 722a: b0 fa       ..  :612a[1]
    pha                                                                         ; 722c: 48          H   :612c[1]
    lda &01                                                                     ; 722d: a5 01       ..  :612d[1]
    adc #&2f ; '/'                                                              ; 722f: 69 2f       i/  :612f[1]
    cmp #&30 ; '0'                                                              ; 7231: c9 30       .0  :6131[1]
    beq c6138                                                                   ; 7233: f0 03       ..  :6133[1]
    jsr write_char_to_screen_addr_and_inc_addr                                  ; 7235: 20 04 61     .a :6135[1]
.c6138
    pla                                                                         ; 7238: 68          h   :6138[1]
    clc                                                                         ; 7239: 18          .   :6139[1]
    adc #&3a ; ':'                                                              ; 723a: 69 3a       i:  :613a[1]
    jmp write_char_to_screen_addr_and_inc_addr                                  ; 723c: 4c 04 61    L.a :613c[1]

.print_line_word_number
    pha                                                                         ; 723f: 48          H   :613f[1]
    jsr print_page_number                                                       ; 7240: 20 21 61     !a :6140[1]
    pla                                                                         ; 7243: 68          h   :6143[1]
    cmp #4                                                                      ; 7244: c9 04       ..  :6144[1]
    bcc c614a                                                                   ; 7246: 90 02       ..  :6146[1]
    lda #4                                                                      ; 7248: a9 04       ..  :6148[1]
.c614a
    tax                                                                         ; 724a: aa          .   :614a[1]
    dex                                                                         ; 724b: ca          .   :614b[1]
    lda ordinal_indicator_char_1,x                                              ; 724c: bd 58 61    .Xa :614c[1]
    jsr write_char_to_screen_addr_and_inc_addr                                  ; 724f: 20 04 61     .a :614f[1]
    lda ordinal_indicator_char_2,x                                              ; 7252: bd 5c 61    .\a :6152[1]
    jmp write_char_to_screen_addr_and_inc_addr                                  ; 7255: 4c 04 61    L.a :6155[1]

.ordinal_indicator_char_1
    equs "snrt"                                                                 ; 7258: 73 6e 72... snr :6158[1]
.ordinal_indicator_char_2
    equs "tddh"                                                                 ; 725c: 74 64 64... tdd :615c[1]
.please_type_txt
    equb &83                                                                    ; 7260: 83          .   :6160[1]
    equs "Please type this word from the novella:"                              ; 7261: 50 6c 65... Ple :6161[1]
    equb 0                                                                      ; 7288: 00          .   :6188[1]
.page_txt
    equb &86                                                                    ; 7289: 86          .   :6189[1]
    equs "Page "                                                                ; 728a: 50 61 67... Pag :618a[1]
    equb 0                                                                      ; 728f: 00          .   :618f[1]
.line_from_txt
    equb &82                                                                    ; 7290: 82          .   :6190[1]
    equs "line from "                                                           ; 7291: 6c 69 6e... lin :6191[1]
    equb 0                                                                      ; 729b: 00          .   :619b[1]
.word_from_txt
    equb &81                                                                    ; 729c: 81          .   :619c[1]
    equs "word from "                                                           ; 729d: 77 6f 72... wor :619d[1]
    equb 0                                                                      ; 72a7: 00          .   :61a7[1]
.top_txt
    equs "top"                                                                  ; 72a8: 74 6f 70    top :61a8[1]
    equb 0                                                                      ; 72ab: 00          .   :61ab[1]
.bottom_txt
    equs "bottom"                                                               ; 72ac: 62 6f 74... bot :61ac[1]
    equb 0                                                                      ; 72b2: 00          .   :61b2[1]
.left_txt
    equs "left"                                                                 ; 72b3: 6c 65 66... lef :61b3[1]
    equb 0                                                                      ; 72b7: 00          .   :61b7[1]
.right_txt
    equs "right"                                                                ; 72b8: 72 69 67... rig :61b8[1]
    equb 0                                                                      ; 72bd: 00          .   :61bd[1]
.wrong_txt
    equb &81                                                                    ; 72be: 81          .   :61be[1]
    equs "Wrong. Try again"                                                     ; 72bf: 57 72 6f... Wro :61bf[1]
    equb 0                                                                      ; 72cf: 00          .   :61cf[1]
.wrong_again_txt
    equb &82                                                                    ; 72d0: 82          .   :61d0[1]
    equs "Wrong again. Running demo version."                                   ; 72d1: 57 72 6f... Wro :61d1[1]
    equb 0                                                                      ; 72f3: 00          .   :61f3[1]
.will_hang_txt
    equb &81                                                                    ; 72f4: 81          .   :61f4[1]
    equs "This will hang up after a few minutes"                                ; 72f5: 54 68 69... Thi :61f5[1]
    equb 0                                                                      ; 731a: 00          .   :621a[1]
.correct_txt
    equb &86                                                                    ; 731b: 86          .   :621b[1]
    equs "Correct. Running game..."                                             ; 731c: 43 6f 72... Cor :621c[1]
    equb 0                                                                      ; 7334: 00          .   :6234[1]

.novella_protection
    jsr get_page_details                                                        ; 7335: 20 97 63     .c :6235[1]
    jsr text_entry_banner                                                       ; 7338: 20 42 64     Bd :6238[1]
    lda #<(mode7_screen_base_addr + 160)                                              ; 733b: a9 a0       ..  :623b[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 733d: 8d 05 61    ..a :623d[1]
    lda #>(mode7_screen_base_addr + 160)                                              ; 7340: a9 7c       .|  :6240[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 7342: 8d 06 61    ..a :6242[1]
    ldx #<please_type_txt                                                       ; 7345: a2 60       .`  :6245[1]
    lda #>please_type_txt                                                       ; 7347: a9 61       .a  :6247[1]
    jsr print_txt                                                               ; 7349: 20 10 61     .a :6249[1]
    lda #<(mode7_screen_base_addr + 293)                                              ; 734c: a9 25       .%  :624c[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 734e: 8d 05 61    ..a :624e[1]
    lda #>(mode7_screen_base_addr + 293)                                              ; 7351: a9 7d       .}  :6251[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 7353: 8d 06 61    ..a :6253[1]
    ldx #<page_txt                                                              ; 7356: a2 89       ..  :6256[1]
    lda #>page_txt                                                              ; 7358: a9 61       .a  :6258[1]
    jsr print_txt                                                               ; 735a: 20 10 61     .a :625a[1]
    lda &04                                                                     ; 735d: a5 04       ..  :625d[1]
    jsr print_page_number                                                       ; 735f: 20 21 61     !a :625f[1]
    lda #<(mode7_screen_base_addr + 368)                                              ; 7362: a9 70       .p  :6262[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 7364: 8d 05 61    ..a :6264[1]
    lda #>(mode7_screen_base_addr + 368)                                              ; 7367: a9 7d       .}  :6267[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 7369: 8d 06 61    ..a :6269[1]
    lda &05                                                                     ; 736c: a5 05       ..  :626c[1]
    bpl c6272                                                                   ; 736e: 10 02       ..  :626e[1]
    eor #&ff                                                                    ; 7370: 49 ff       I.  :6270[1]
.c6272
    clc                                                                         ; 7372: 18          .   :6272[1]
    adc #1                                                                      ; 7373: 69 01       i.  :6273[1]
    jsr print_line_word_number                                                  ; 7375: 20 3f 61     ?a :6275[1]
    ldx #<line_from_txt                                                         ; 7378: a2 90       ..  :6278[1]
    lda #>line_from_txt                                                         ; 737a: a9 61       .a  :627a[1]
    jsr print_txt                                                               ; 737c: 20 10 61     .a :627c[1]
    bit &05                                                                     ; 737f: 24 05       $.  :627f[1]
    bmi c628d                                                                   ; 7381: 30 0a       0.  :6281[1]
    ldx #<top_txt                                                               ; 7383: a2 a8       ..  :6283[1]
    lda #>top_txt                                                               ; 7385: a9 61       .a  :6285[1]
    jsr print_txt                                                               ; 7387: 20 10 61     .a :6287[1]
    jmp c6294                                                                   ; 738a: 4c 94 62    L.b :628a[1]

.c628d
    ldx #<bottom_txt                                                            ; 738d: a2 ac       ..  :628d[1]
    lda #>bottom_txt                                                            ; 738f: a9 61       .a  :628f[1]
    jsr print_txt                                                               ; 7391: 20 10 61     .a :6291[1]
.c6294
    lda #<(mode7_screen_base_addr + 448)                                              ; 7394: a9 c0       ..  :6294[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 7396: 8d 05 61    ..a :6296[1]
    lda #>(mode7_screen_base_addr + 448)                                              ; 7399: a9 7d       .}  :6299[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 739b: 8d 06 61    ..a :629b[1]
    lda &07                                                                     ; 739e: a5 07       ..  :629e[1]
    bit l499c                                                                   ; 73a0: 2c 9c 49    ,.I :62a0[1]
    bvc c62aa                                                                   ; 73a3: 50 05       P.  :62a3[1]
    clc                                                                         ; 73a5: 18          .   :62a5[1]
    lda &06                                                                     ; 73a6: a5 06       ..  :62a6[1]
    sbc &07                                                                     ; 73a8: e5 07       ..  :62a8[1]
.c62aa
    clc                                                                         ; 73aa: 18          .   :62aa[1]
    adc #1                                                                      ; 73ab: 69 01       i.  :62ab[1]
    jsr print_line_word_number                                                  ; 73ad: 20 3f 61     ?a :62ad[1]
    ldx #<word_from_txt                                                         ; 73b0: a2 9c       ..  :62b0[1]
    lda #>word_from_txt                                                         ; 73b2: a9 61       .a  :62b2[1]
    jsr print_txt                                                               ; 73b4: 20 10 61     .a :62b4[1]
    bit l499c                                                                   ; 73b7: 2c 9c 49    ,.I :62b7[1]
    bvs print_right_txt                                                         ; 73ba: 70 0a       p.  :62ba[1]
    ldx #<left_txt                                                              ; 73bc: a2 b3       ..  :62bc[1]
    lda #>left_txt                                                              ; 73be: a9 61       .a  :62be[1]
    jsr print_txt                                                               ; 73c0: 20 10 61     .a :62c0[1]
    jmp input_txt_and_verify                                                    ; 73c3: 4c cd 62    L.b :62c3[1]

.print_right_txt
    ldx #<right_txt                                                             ; 73c6: a2 b8       ..  :62c6[1]
    lda #>right_txt                                                             ; 73c8: a9 61       .a  :62c8[1]
    jsr print_txt                                                               ; 73ca: 20 10 61     .a :62ca[1]
.input_txt_and_verify
    jsr input_txt                                                               ; 73cd: 20 5b 64     [d :62cd[1]
; 
; **************************************************************
; Calculate hash from entered text and compare with value in
; zero page register &08
; **************************************************************
; 
    ldx #0                                                                      ; 73d0: a2 00       ..  :62d0[1]
    stx &01                                                                     ; 73d2: 86 01       ..  :62d2[1]
.loop_c62d4
    lda mode7_screen_base_addr + 650,x                                                ; 73d4: bd 8a 7e    ..~ :62d4[1]
    cmp #&0d                                                                    ; 73d7: c9 0d       ..  :62d7[1]
    beq c62e4                                                                   ; 73d9: f0 09       ..  :62d9[1]
    asl &01                                                                     ; 73db: 06 01       ..  :62db[1]
    adc &01                                                                     ; 73dd: 65 01       e.  :62dd[1]
    sta &01                                                                     ; 73df: 85 01       ..  :62df[1]
    inx                                                                         ; 73e1: e8          .   :62e1[1]
    bne loop_c62d4                                                              ; 73e2: d0 f0       ..  :62e2[1]
.c62e4
    lda &01                                                                     ; 73e4: a5 01       ..  :62e4[1]
    cmp &08                                                                     ; 73e6: c5 08       ..  :62e6[1]
    beq correct_entry                                                           ; 73e8: f0 44       .D  :62e8[1]
    dec entry_attempts_count                                                    ; 73ea: ce 93 63    ..c :62ea[1]
    beq failed_entry                                                            ; 73ed: f0 14       ..  :62ed[1]
    lda #<(mode7_screen_base_addr + 809)                                              ; 73ef: a9 29       .)  :62ef[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 73f1: 8d 05 61    ..a :62f1[1]
    lda #>(mode7_screen_base_addr + 809)                                              ; 73f4: a9 7f       ..  :62f4[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 73f6: 8d 06 61    ..a :62f6[1]
    ldx #<wrong_txt                                                             ; 73f9: a2 be       ..  :62f9[1]
    lda #>wrong_txt                                                             ; 73fb: a9 61       .a  :62fb[1]
    jsr print_txt                                                               ; 73fd: 20 10 61     .a :62fd[1]
    jmp input_txt_and_verify                                                    ; 7400: 4c cd 62    L.b :6300[1]

.failed_entry
    jsr sub_c6357                                                               ; 7403: 20 57 63     Wc :6303[1]
    lda #<(mode7_screen_base_addr + 403)                                              ; 7406: a9 93       ..  :6306[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 7408: 8d 05 61    ..a :6308[1]
    lda #>(mode7_screen_base_addr + 403)                                              ; 740b: a9 7d       .}  :630b[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 740d: 8d 06 61    ..a :630d[1]
    ldx #<wrong_again_txt                                                       ; 7410: a2 d0       ..  :6310[1]
    lda #>wrong_again_txt                                                       ; 7412: a9 61       .a  :6312[1]
    jsr print_txt                                                               ; 7414: 20 10 61     .a :6314[1]
    lda #<(mode7_screen_base_addr + 481)                                              ; 7417: a9 e1       ..  :6317[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 7419: 8d 05 61    ..a :6319[1]
    lda #>(mode7_screen_base_addr + 481)                                              ; 741c: a9 7d       .}  :631c[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 741e: 8d 06 61    ..a :631e[1]
    ldx #<will_hang_txt                                                         ; 7421: a2 f4       ..  :6321[1]
    lda #>will_hang_txt                                                         ; 7423: a9 61       .a  :6323[1]
    jsr print_txt                                                               ; 7425: 20 10 61     .a :6325[1]
    jsr delay_loop                                                              ; 7428: 20 42 63     Bc :6328[1]
    jmp delay_loop                                                              ; 742b: 4c 42 63    LBc :632b[1]

.correct_entry
    jsr sub_c6357                                                               ; 742e: 20 57 63     Wc :632e[1]
    lda #<(mode7_screen_base_addr + 405)                                              ; 7431: a9 95       ..  :6331[1]
    sta write_char_to_screen_addr_and_inc_addr + 1                              ; 7433: 8d 05 61    ..a :6333[1]
    lda #>(mode7_screen_base_addr + 405)                                              ; 7436: a9 7d       .}  :6336[1]
    sta write_char_to_screen_addr_and_inc_addr + 2                              ; 7438: 8d 06 61    ..a :6338[1]
    ldx #<correct_txt                                                           ; 743b: a2 1b       ..  :633b[1]
    lda #>correct_txt                                                           ; 743d: a9 62       .b  :633d[1]
    jsr print_txt                                                               ; 743f: 20 10 61     .a :633f[1]
.delay_loop
    lda #&0a                                                                    ; 7442: a9 0a       ..  :6342[1]
    sta delay_count                                                             ; 7444: 8d 94 63    ..c :6344[1]
    ldx #0                                                                      ; 7447: a2 00       ..  :6347[1]
    ldy #0                                                                      ; 7449: a0 00       ..  :6349[1]
.c634b
    dex                                                                         ; 744b: ca          .   :634b[1]
    bne c634b                                                                   ; 744c: d0 fd       ..  :634c[1]
    dey                                                                         ; 744e: 88          .   :634e[1]
    bne c634b                                                                   ; 744f: d0 fa       ..  :634f[1]
    dec delay_count                                                             ; 7451: ce 94 63    ..c :6351[1]
    bne c634b                                                                   ; 7454: d0 f5       ..  :6354[1]
    rts                                                                         ; 7456: 60          `   :6356[1]

.sub_c6357
    lda &09                                                                     ; 7457: a5 09       ..  :6357[1]
    sta l0ba7                                                                   ; 7459: 8d a7 0b    ... :6359[1]
    ldx #0                                                                      ; 745c: a2 00       ..  :635c[1]
    stx &01                                                                     ; 745e: 86 01       ..  :635e[1]
    txa                                                                         ; 7460: 8a          .   :6360[1]
    clc                                                                         ; 7461: 18          .   :6361[1]
.loop_c6362
    sbc &01                                                                     ; 7462: e5 01       ..  :6362[1]
    sta &01                                                                     ; 7464: 85 01       ..  :6364[1]
    lda mode7_screen_base_addr + 650,x                                                ; 7466: bd 8a 7e    ..~ :6366[1]
    inx                                                                         ; 7469: e8          .   :6369[1]
    eor #&0d                                                                    ; 746a: 49 0d       I.  :636a[1]
    bne loop_c6362                                                              ; 746c: d0 f4       ..  :636c[1]
    lda &01                                                                     ; 746e: a5 01       ..  :636e[1]
    sta l0ba8                                                                   ; 7470: 8d a8 0b    ... :6370[1]
    jmp clear_screen                                                            ; 7473: 4c 13 64    L.d :6373[1]

    equb &29, &44, &2a, &20, &51, &4b, &4e, &20, &4a, &73, &77, &6a             ; 7476: 29 44 2a... )D* :6376[1]
    equb &6f, &20, &27, &20, &4b, &44, &20, &54, &6e, &6a, &75, &69             ; 7482: 6f 20 27... o ' :6382[1]
    equb &20, &32, &3a, &39, &39                                                ; 748e: 20 32 3a...  2: :638e[1]
.entry_attempts_count
    equb 8                                                                      ; 7493: 08          .   :6393[1]
.delay_count
    equb &0a                                                                    ; 7494: 0a          .   :6394[1]
.l6395
    equb 0                                                                      ; 7495: 00          .   :6395[1]
    equb 0                                                                      ; 7496: 00          .   :6396[1]

.get_page_details
    sta l6395                                                                   ; 7497: 8d 95 63    ..c :6397[1]
    lda #0                                                                      ; 749a: a9 00       ..  :639a[1]
    sta l6395 + 1                                                               ; 749c: 8d 96 63    ..c :639c[1]
.loop_c639f
    lda l6395 + 1                                                               ; 749f: ad 96 63    ..c :639f[1]
    and #&80                                                                    ; 74a2: 29 80       ).  :63a2[1]
    sta l6395 + 1                                                               ; 74a4: 8d 96 63    ..c :63a4[1]
    lda #0                                                                      ; 74a7: a9 00       ..  :63a7[1]
    sta &04                                                                     ; 74a9: 85 04       ..  :63a9[1]
    lda #<table_01                                                              ; 74ab: a9 69       .i  :63ab[1]
    sta &02                                                                     ; 74ad: 85 02       ..  :63ad[1]
    lda #>table_01                                                              ; 74af: a9 65       .e  :63af[1]
    sta &03                                                                     ; 74b1: 85 03       ..  :63b1[1]
    ldy #0                                                                      ; 74b3: a0 00       ..  :63b3[1]
.c63b5
    lda (&02),y                                                                 ; 74b5: b1 02       ..  :63b5[1]
    beq loop_c639f                                                              ; 74b7: f0 e6       ..  :63b7[1]
    and #&f0                                                                    ; 74b9: 29 f0       ).  :63b9[1]
    bne c63cc                                                                   ; 74bb: d0 0f       ..  :63bb[1]
    lda (&02),y                                                                 ; 74bd: b1 02       ..  :63bd[1]
    clc                                                                         ; 74bf: 18          .   :63bf[1]
    adc &04                                                                     ; 74c0: 65 04       e.  :63c0[1]
    sta &04                                                                     ; 74c2: 85 04       ..  :63c2[1]
    inc &02                                                                     ; 74c4: e6 02       ..  :63c4[1]
    bne c63b5                                                                   ; 74c6: d0 ed       ..  :63c6[1]
    inc &03                                                                     ; 74c8: e6 03       ..  :63c8[1]
    bne c63b5                                                                   ; 74ca: d0 e9       ..  :63ca[1]
.c63cc
    lda l6395 + 1                                                               ; 74cc: ad 96 63    ..c :63cc[1]
    cmp l6395                                                                   ; 74cf: cd 95 63    ..c :63cf[1]
    beq c63e4                                                                   ; 74d2: f0 10       ..  :63d2[1]
    inc l6395 + 1                                                               ; 74d4: ee 96 63    ..c :63d4[1]
    clc                                                                         ; 74d7: 18          .   :63d7[1]
    lda &02                                                                     ; 74d8: a5 02       ..  :63d8[1]
    adc #3                                                                      ; 74da: 69 03       i.  :63da[1]
    sta &02                                                                     ; 74dc: 85 02       ..  :63dc[1]
    bcc c63b5                                                                   ; 74de: 90 d5       ..  :63de[1]
    inc &03                                                                     ; 74e0: e6 03       ..  :63e0[1]
    bne c63b5                                                                   ; 74e2: d0 d1       ..  :63e2[1]
.c63e4
    lda (&02),y                                                                 ; 74e4: b1 02       ..  :63e4[1]
    and #&0f                                                                    ; 74e6: 29 0f       ).  :63e6[1]
    sec                                                                         ; 74e8: 38          8   :63e8[1]
    sbc #8                                                                      ; 74e9: e9 08       ..  :63e9[1]
    sta &05                                                                     ; 74eb: 85 05       ..  :63eb[1]
    lda (&02),y                                                                 ; 74ed: b1 02       ..  :63ed[1]
    lsr a                                                                       ; 74ef: 4a          J   :63ef[1]
    lsr a                                                                       ; 74f0: 4a          J   :63f0[1]
    lsr a                                                                       ; 74f1: 4a          J   :63f1[1]
    lsr a                                                                       ; 74f2: 4a          J   :63f2[1]
    sta &06                                                                     ; 74f3: 85 06       ..  :63f3[1]
    iny                                                                         ; 74f5: c8          .   :63f5[1]
    lda (&02),y                                                                 ; 74f6: b1 02       ..  :63f6[1]
    sta &08                                                                     ; 74f8: 85 08       ..  :63f8[1]
    iny                                                                         ; 74fa: c8          .   :63fa[1]
    lda (&02),y                                                                 ; 74fb: b1 02       ..  :63fb[1]
    sta &09                                                                     ; 74fd: 85 09       ..  :63fd[1]
    lda &04                                                                     ; 74ff: a5 04       ..  :63ff[1]
    asl a                                                                       ; 7501: 0a          .   :6401[1]
    asl a                                                                       ; 7502: 0a          .   :6402[1]
    asl a                                                                       ; 7503: 0a          .   :6403[1]
    clc                                                                         ; 7504: 18          .   :6404[1]
    adc &05                                                                     ; 7505: 65 05       e.  :6405[1]
.loop_c6407
    cmp &06                                                                     ; 7507: c5 06       ..  :6407[1]
    bcc c6410                                                                   ; 7509: 90 05       ..  :6409[1]
    sbc &06                                                                     ; 750b: e5 06       ..  :640b[1]
    jmp loop_c6407                                                              ; 750d: 4c 07 64    L.d :640d[1]

.c6410
    sta &07                                                                     ; 7510: 85 07       ..  :6410[1]
    rts                                                                         ; 7512: 60          `   :6412[1]

.clear_screen
    lda #0                                                                      ; 7513: a9 00       ..  :6413[1]
    tay                                                                         ; 7515: a8          .   :6415[1]
    ldx #4                                                                      ; 7516: a2 04       ..  :6416[1]
.c6418
    sta mode7_screen_base_addr,y                                                      ; 7518: 99 00 7c    ..| :6418[1]
    dey                                                                         ; 751b: 88          .   :641b[1]
    bne c6418                                                                   ; 751c: d0 fa       ..  :641c[1]
    inc c6418 + 2                                                               ; 751e: ee 1a 64    ..d :641e[1]
    dex                                                                         ; 7521: ca          .   :6421[1]
    bne c6418                                                                   ; 7522: d0 f4       ..  :6422[1]
    dec c6418 + 2                                                               ; 7524: ce 1a 64    ..d :6424[1]
    dec c6418 + 2                                                               ; 7527: ce 1a 64    ..d :6427[1]
    dec c6418 + 2                                                               ; 752a: ce 1a 64    ..d :642a[1]
    dec c6418 + 2                                                               ; 752d: ce 1a 64    ..d :642d[1]
    lda #0                                                                      ; 7530: a9 00       ..  :6430[1]
    ldx #&0e                                                                    ; 7532: a2 0e       ..  :6432[1]
    stx &fe00                                                                   ; 7534: 8e 00 fe    ... :6434[1]
    sta &fe01                                                                   ; 7537: 8d 01 fe    ... :6437[1]
    inx                                                                         ; 753a: e8          .   :643a[1]
    stx &fe00                                                                   ; 753b: 8e 00 fe    ... :643b[1]
    sta &fe01                                                                   ; 753e: 8d 01 fe    ... :643e[1]
    rts                                                                         ; 7541: 60          `   :6441[1]

.text_entry_banner
    jsr clear_screen                                                            ; 7542: 20 13 64     .d :6442[1]
    lda #&84                                                                    ; 7545: a9 84       ..  :6445[1]
    sta mode7_screen_base_addr + 647                                                  ; 7547: 8d 87 7e    ..~ :6447[1]
    lda #&9d                                                                    ; 754a: a9 9d       ..  :644a[1]
    sta mode7_screen_base_addr + 648                                                  ; 754c: 8d 88 7e    ..~ :644c[1]
    lda #&83                                                                    ; 754f: a9 83       ..  :644f[1]
    sta mode7_screen_base_addr + 649                                                  ; 7551: 8d 89 7e    ..~ :6451[1]
    lda #&9c                                                                    ; 7554: a9 9c       ..  :6454[1]
    sta mode7_screen_base_addr + 668                                                  ; 7556: 8d 9c 7e    ..~ :6456[1]
    rts                                                                         ; 7559: 60          `   :6459[1]

.input_char_count
    equb 0                                                                      ; 755a: 00          .   :645a[1]

.input_txt
    jsr sub_c64f5                                                               ; 755b: 20 f5 64     .d :645b[1]
; 
; **************************************************************
; Clear text entry banner
; **************************************************************
; 
    ldx #&10                                                                    ; 755e: a2 10       ..  :645e[1]
    lda #&20 ; ' '                                                              ; 7560: a9 20       .   :6460[1]
.loop_c6462
    sta mode7_screen_base_addr + 650,x                                                ; 7562: 9d 8a 7e    ..~ :6462[1]
    dex                                                                         ; 7565: ca          .   :6465[1]
    bpl loop_c6462                                                              ; 7566: 10 fa       ..  :6466[1]
    ldx #0                                                                      ; 7568: a2 00       ..  :6468[1]
    stx input_char_count                                                        ; 756a: 8e 5a 64    .Zd :646a[1]
.get_char
    lda #<(mode7_screen_base_addr + 650)                                              ; 756d: a9 8a       ..  :646d[1]
    clc                                                                         ; 756f: 18          .   :646f[1]
    adc input_char_count                                                        ; 7570: 6d 5a 64    mZd :6470[1]
    tay                                                                         ; 7573: a8          .   :6473[1]
    lda #>(mode7_screen_base_addr + 650)                                              ; 7574: a9 7e       .~  :6474[1]
    adc #0                                                                      ; 7576: 69 00       i.  :6476[1]
    sec                                                                         ; 7578: 38          8   :6478[1]
    sbc #&54 ; 'T'                                                              ; 7579: e9 54       .T  :6479[1]
    ldx #&0f                                                                    ; 757b: a2 0f       ..  :647b[1]
    stx &fe00                                                                   ; 757d: 8e 00 fe    ... :647d[1]
    sty &fe01                                                                   ; 7580: 8c 01 fe    ... :6480[1]
    dex                                                                         ; 7583: ca          .   :6483[1]
    stx &fe00                                                                   ; 7584: 8e 00 fe    ... :6484[1]
    sta &fe01                                                                   ; 7587: 8d 01 fe    ... :6487[1]
    jsr read_char                                                               ; 758a: 20 29 65     )e :648a[1]
    cmp #&0d                                                                    ; 758d: c9 0d       ..  :648d[1]
    beq input_txt_complete                                                      ; 758f: f0 24       .$  :648f[1]
    cmp #&7f                                                                    ; 7591: c9 7f       ..  :6491[1]
    bne process_char                                                            ; 7593: d0 10       ..  :6493[1]
    ldx input_char_count                                                        ; 7595: ae 5a 64    .Zd :6495[1]
    beq get_char                                                                ; 7598: f0 d3       ..  :6498[1]
    lda #&20 ; ' '                                                              ; 759a: a9 20       .   :649a[1]
    sta mode7_screen_base_addr + 649,x                                                ; 759c: 9d 89 7e    ..~ :649c[1]
    dec input_char_count                                                        ; 759f: ce 5a 64    .Zd :649f[1]
    jmp get_char                                                                ; 75a2: 4c 6d 64    Lmd :64a2[1]

.process_char
    ldx input_char_count                                                        ; 75a5: ae 5a 64    .Zd :64a5[1]
    cpx #&10                                                                    ; 75a8: e0 10       ..  :64a8[1]
    beq get_char                                                                ; 75aa: f0 c1       ..  :64aa[1]
    sta mode7_screen_base_addr + 650,x                                                ; 75ac: 9d 8a 7e    ..~ :64ac[1]
    inc input_char_count                                                        ; 75af: ee 5a 64    .Zd :64af[1]
    jmp get_char                                                                ; 75b2: 4c 6d 64    Lmd :64b2[1]

.input_txt_complete
    ldx input_char_count                                                        ; 75b5: ae 5a 64    .Zd :64b5[1]
    sta mode7_screen_base_addr + 650,x                                                ; 75b8: 9d 8a 7e    ..~ :64b8[1]
    rts                                                                         ; 75bb: 60          `   :64bb[1]

.system_via_data
    equb &49, &59, &41, &64, &52, &32, &22, &43, &53, &54, &25, &45             ; 75bc: 49 59 41... IYA :64bc[1]
    equb &46, &56, &65, &55, &36, &37, &10, &33, &51, &23, &35, &63             ; 75c8: 46 56 65... FVe :64c8[1]
    equb &21, &42, &44, &61                                                     ; 75d4: 21 42 44... !BD :64d4[1]
.l64d8
    equb 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0                                     ; 75d8: 00 00 00... ... :64d8[1]
    equb 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0                                     ; 75e4: 00 00 00... ... :64e4[1]
    equb 0, 0, 0, 0                                                             ; 75f0: 00 00 00... ... :64f0[1]
.l64f4
    equb 0                                                                      ; 75f4: 00          .   :64f4[1]

.sub_c64f5
    sec                                                                         ; 75f5: 38          8   :64f5[1]
    bcs c64f9                                                                   ; 75f6: b0 01       ..  :64f6[1]
.sub_c64f8
    clc                                                                         ; 75f8: 18          .   :64f8[1]
.c64f9
    ror l64f4                                                                   ; 75f9: 6e f4 64    n.d :64f9[1]
    lda #&7f                                                                    ; 75fc: a9 7f       ..  :64fc[1]
    sta &fe43                                                                   ; 75fe: 8d 43 fe    .C. :64fe[1]
    lda #3                                                                      ; 7601: a9 03       ..  :6501[1]
    sta &fe40                                                                   ; 7603: 8d 40 fe    .@. :6503[1]
    ldx #&1b                                                                    ; 7606: a2 1b       ..  :6506[1]
.loop_c6508
    lda system_via_data,x                                                       ; 7608: bd bc 64    ..d :6508[1]
    sta &fe4f                                                                   ; 760b: 8d 4f fe    .O. :650b[1]
    lda &fe4f                                                                   ; 760e: ad 4f fe    .O. :650e[1]
    rol a                                                                       ; 7611: 2a          *   :6511[1]
    ror l64d8,x                                                                 ; 7612: 7e d8 64    ~.d :6512[1]
    bit l64f4                                                                   ; 7615: 2c f4 64    ,.d :6515[1]
    bmi c6522                                                                   ; 7618: 30 08       0.  :6518[1]
    lda l64d8,x                                                                 ; 761a: bd d8 64    ..d :651a[1]
    rol a                                                                       ; 761d: 2a          *   :651d[1]
    bcc c6522                                                                   ; 761e: 90 02       ..  :651e[1]
    bpl c6525                                                                   ; 7620: 10 03       ..  :6520[1]
.c6522
    dex                                                                         ; 7622: ca          .   :6522[1]
    bpl loop_c6508                                                              ; 7623: 10 e3       ..  :6523[1]
.c6525
    lda #&0b                                                                    ; 7625: a9 0b       ..  :6525[1]
    txa                                                                         ; 7627: 8a          .   :6527[1]
    rts                                                                         ; 7628: 60          `   :6528[1]

.read_char
    jsr sub_c64f8                                                               ; 7629: 20 f8 64     .d :6529[1]
    bmi read_char                                                               ; 762c: 30 fb       0.  :652c[1]
    bne c6533                                                                   ; 762e: d0 03       ..  :652e[1]
    lda #&0d                                                                    ; 7630: a9 0d       ..  :6530[1]
    rts                                                                         ; 7632: 60          `   :6532[1]

.c6533
    dex                                                                         ; 7633: ca          .   :6533[1]
    bne c6539                                                                   ; 7634: d0 03       ..  :6534[1]
    lda #&7f                                                                    ; 7636: a9 7f       ..  :6536[1]
    rts                                                                         ; 7638: 60          `   :6538[1]

.c6539
    clc                                                                         ; 7639: 18          .   :6539[1]
    adc #&3f ; '?'                                                              ; 763a: 69 3f       i?  :653a[1]
    rts                                                                         ; 763c: 60          `   :653c[1]

    equs "24/10/88 Disc (compact) RELEASE 2"                                    ; 763d: 32 34 2f... 24/ :653d[1]
;ENDIF
ELSE
IF SRAM
    equb $00
    equb $00
ENDIF
ENDIF

.crtc_data
equb $14                        ; ula
equb $7F                        ; r0
equb $00                        ; r1
;equb $5B                       ; r2
equb 98-(80-screen_width) DIV 2+1
equb $28                        ; r3
equb $26                        ; r4
equb $00                        ; r5
equb (screen_size_pages*256)/(screen_width*8) ; r6
IF SRAM
equb $23                        ; r7
ELSE
equb $1B                        ; r7
ENDIF
equb $00                        ; r8
equb $07                        ; r9

IF NOVELLA_LOOKUP = TRUE
.table_01
    equb   6, &f8, &6b, &62, &29, &5e, &4b, &ca, &ec, &67, &cb, &d1             ; 7669: 06 f8 6b... ..k :6569[1]
    equb &b3, &5f, &56, &3f, &f6, &67, &6b, &87, &a0, &8f,   1, &47             ; 7675: b3 5f 56... ._V :6575[1]
    equb &9c, &9d,   1, &58, &e8, &45, &dd, &e5, &3e, &c2, &e4, &8d             ; 7681: 9c 9d 01... ... :6581[1]
    equb &a3, &85, &9e, &c5,   2, &32, &c7, &24, &5b,   1, &c8, &57             ; 768d: a3 85 9e... ... :658d[1]
    equb   1, &d9, &47, &96, &fa, &58,   7, &c3, &e1, &73, &d6, &32             ; 7699: 01 d9 47... ..G :6599[1]
    equb &1b, &d7, &a5, &81,   1, &e9, &20, &3b, &3e, &6c, &40, &e2             ; 76a5: 1b d7 a5... ... :65a5[1]
    equb &e5, &21, &e3, &e7, &31, &95, &b0, &8a,   1, &e8, &10, &1b             ; 76b1: e5 21 e3... .!. :65b1[1]
    equb &b9, &64, &93, &5a, &a7, &7b, &eb, &26, &25, &6d, &d9, &86             ; 76bd: b9 64 93... .d. :65bd[1]
    equb &f1, &32, &17, &f5, &9b, &4c,   1, &dd, &1c, &1f, &b2, &c4             ; 76c9: f1 32 17... .2. :65c9[1]
    equb &35, &34, &81,   6, &47, &c4, &62,   1, &89, &b4, &71,   1             ; 76d5: 35 34 81... 54. :65d5[1]
    equb &64, &2b, &2f, &a7, &7e, &20,   1, &e9, &b7, &94, &dc, &0f             ; 76e1: 64 2b 2f... d+/ :65e1[1]
    equb &2c, &8e, &3f, &2e, &33, &ce, &0b, &37, &bd, &7c,   1, &7a             ; 76ed: 2c 8e 3f... ,.? :65ed[1]
    equb &43, &2c, &7c, &df, &99, &6e, &30, &6e, &b5, &5d, &75, &97             ; 76f9: 43 2c 7c... C,| :65f9[1]
    equb &cb, &15,   1, &c0,   7,   5, &e3, &37, &44, &e5, &10, &bc             ; 7705: cb 15 01... ... :6605[1]
    equb &37, &f1, &89,   1, &aa, &e8, &a4, &dc, &11, &3d, &c2, &a4             ; 7711: 37 f1 89... 7.. :6611[1]
    equb &5f, &37, &4d, &12,   1, &79, &8d,   1, &eb, &c0, &82, &3e             ; 771d: 5f 37 4d... _7M :661d[1]
    equb &58, &52, &b5, &5d, &a5,   1, &c9, &b5, &b3, &dd, &4e, &14             ; 7729: 58 52 b5... XR. :6629[1]
    equb &de, &78, &19, &57, &46, &56,   1, &c9, &be, &cb, &cc, &79             ; 7735: de 78 19... .x. :6635[1]
    equb &c0, &74, &3f, &52, &d5, &f7, &c9, &67, &e8, &cb,   1, &e9             ; 7741: c0 74 3f... .t? :6641[1]
    equb &b5, &c8, &3c, &86, &fd, &54, &64, &6e, &c5, &c4, &4b, &b7             ; 774d: b5 c8 3c... ..< :664d[1]
    equb &73, &75,   1, &b8, &92, &6b, &a9, &56, &3d, &ea, &d2, &61             ; 7759: 73 75 01... su. :6659[1]
    equb &2d, &d3, &24, &bf, &7c, &7b, &e0, &f1, &ed, &e3, &b2, &d1             ; 7765: 2d d3 24... -.$ :6665[1]
    equb &e5, &41, &7b, &a6, &ec, &36,   1, &a8, &26, &6d, &99, &ff             ; 7771: e5 41 7b... .A{ :6671[1]
    equb &c3, &40, &a3, &4c, &d4, &bc, &66, &d6, &60, &2f, &27, &33             ; 777d: c3 40 a3... .@. :667d[1]
    equb &1c,   1, &b8, &5e, &2b, &d9, &81,   8, &3a, &ce, &ec, &bb             ; 7789: 1c 01 b8... ... :6689[1]
    equb &26, &64, &53, &76, &7b,   1,   1, &b8, &d0, &cc, &dc, &93             ; 7795: 26 64 53... &dS :6695[1]
    equb   1, &6d, &e8, &49, &7f, &ef, &91, &f4,   9, &6e, &c5, &ed             ; 77a1: 01 6d e8... .m. :66a1[1]
    equb &58, &27, &3b, &75,   1, &59, &4b, &45, &ba, &2e, &40, &ec             ; 77ad: 58 27 3b... X'; :66ad[1]
    equb &18, &fd, &9d, &e2, &48,   1, &e6, &5a, &4a, &97, &30, &74             ; 77b9: 18 fd 9d... ... :66b9[1]
    equb   2, &32, &6b, &4d, &25, &10, &e2, &66,   6, &54, &57, &97             ; 77c5: 02 32 6b... .2k :66c5[1]
    equb &0a,   1, &48, &57, &7f, &ca, &49, &50, &5b, &a7, &12, &6e             ; 77d1: 0a 01 48... ..H :66d1[1]
    equb &86, &f8,   1, &b9, &d8, &e2, &ac, &d5, &12, &dd, &da, &fe             ; 77dd: 86 f8 01... ... :66dd[1]
    equb &25, &83, &68, &b7, &10, &7a,   1, &62, &68, &57, &a3, &da             ; 77e9: 25 83 68... %.h :66e9[1]
    equb &f2, &d6, &6e, &17,   1, &d8, &61, &1d, &ba, &64, &f4, &7b             ; 77f5: f2 d6 6e... ..n :66f5[1]
    equb &b5, &7d, &c0, &80,   0, &51, &e6, &71, &e2, &dd, &93, &43             ; 7801: b5 7d c0... .}. :6701[1]
    equb &99, &84, &d6, &73, &66, &47, &4e, &2c,   1, &39, &5c, &7c             ; 780d: 99 84 d6... ... :670d[1]
    equb &cb, &6b, &0a, &5d, &2f, &92, &50, &cc, &3a, &33, &3c, &3b             ; 7819: cb 6b 0a... .k. :6719[1]
    equb &37, &85, &9e,   1, &e8, &6b, &4f, &29,   2, &a4, &4f, &cc             ; 7825: 37 85 9e... 7.. :6725[1]
    equb &a4, &c2, &42, &7e, &75, &1d, &12, &67, &61, &88,   1, &5c             ; 7831: a4 c2 42... ..B :6731[1]
    equb &0f, &15, &30, &eb, &89, &22, &45, &3f, &c3, &20, &3b, &65             ; 783d: 0f 15 30... ..0 :673d[1]
    equb &dd, &71,   1, &d8, &65, &62, &69, &42, &2d, &ea, &fa, &20             ; 7849: dd 71 01... .q. :6749[1]
    equb &cd, &34, &79, &a5, &e7, &3c, &96, &d5, &7c,   1, &29, &81             ; 7855: cd 34 79... .4y :6755[1]
    equb &38, &5a, &d7, &80, &8b, &86,   3, &c2, &62, &87, &77, &1f             ; 7861: 38 5a d7... 8Z. :6761[1]
    equb &10,   2, &8b, &6b, &65, &ef, &de, &18, &b1, &57, &a1, &c2             ; 786d: 10 02 8b... ... :676d[1]
    equb &d3, &51, &24, &10, &aa, &47, &7a, &f7,   1, &4b, &33, &62             ; 7879: d3 51 24... .Q$ :6779[1]
    equb &dc, &35,   3, &83, &49,   8, &94, &b0, &b8, &57, &b7, &98             ; 7885: dc 35 03... .5. :6785[1]
    equb   1, &9a, &99, &aa, &7b, &26, &14, &60, &b8, &13,   3, &ec             ; 7891: 01 9a 99... ... :6791[1]
    equb &f7, &a2, &ce, &8d,   8, &71, &e4, &5c, &72, &79, &b0, &73             ; 789d: f7 a2 ce... ... :679d[1]
    equb &da, &bb, &97, &17, &4f,   1, &88, &21, &9c, &2b, &55,   1             ; 78a9: da bb 97... ... :67a9[1]
    equb &43, &0c, &56, &84,   6,   2,   2, &b9, &79, &bb, &2a, &86             ; 78b5: 43 0c 56... C.V :67b5[1]
    equb &b5, &a2, &df, &59, &a5, &e5, &0b,   1, &48, &f0, &1f, &ad             ; 78c1: b5 a2 df... ... :67c1[1]
    equb &f5, &1e, &e2, &d0, &ac, &c4, &4f, &30,   2, &c8, &81, &12             ; 78cd: f5 1e e2... ... :67cd[1]
    equb &6b, &f7, &cf, &67, &40, &c7,   1, &69, &f0, &2c, &eb, &68             ; 78d9: 6b f7 cf... k.. :67d9[1]
    equb &66, &26, &39, &0f, &a7, &81, &25,   0                                 ; 78e5: 66 26 39... f&9 :67e5[1]
;ENDIF
;.main_end
ELSE

IF SRAM
align 16
ENDIF
ENDIF

IF SRAM
.sram_init2_end
ENDIF

.main_end

if SRAM=0 AND NOVELLA_LOOKUP=FALSE AND P%>&6100:PRINT ~P%:ERROR "too much code!":ENDIF
PRINT &6000-program_top,"byte(s) free"

    copyblock base_address, main_end, load_address
    clear base_address, load_address

    org load_address + (main_end - base_address)

IF SRAM
.sram_init_begin
ENDIF

; **************************************************************
; Initial Entry Point
; **************************************************************

.intro

IF FILE_SYSTEM = NFS
; **************************************************************
; Relocated from ExileL to allow the main binaries to load
; over Econet.
; **************************************************************
    lda #&8f                                                                   ; 7302: a9 8f       ..
    ldx #&0c                                                                   ; 7304: a2 0c       ..
    ldy #&ff                                                                   ; 7306: a0 ff       ..
    jsr &fff4                                                                  ; 7308: 20 f4 ff     ..            ; Issue paged ROM service call, Reason X=12 - NMI claim
ENDIF
    SEI
    CLD
    LDA #$7F
    STA $FE4E ; system VIA interrupt enable register
    STA $FE6E ; user VIA interrupt enable register
    STA $FE4D ; set system VIA interrupt flag register
    STA $FE6D ; user VIA interrupt flag register
    LDA #$00
    LDX #$DF
.L7214
    STA 0,X
    DEX
    BNE L7214
    LDA #$28
    STA sucking_distance
    LDA #$C0
    STA player_angle
    DEC object_held
    LDX #$FF
    TXS

IF NOVELLA_LOOKUP = TRUE
    lda l0296                                                                   ; 7913: ad 96 02    ...
    and #&57 ; 'W'                                                              ; 7916: 29 57       )W
    sta &01                                                                     ; 7918: 85 01       ..
ENDIF

    LDA #$82
    STA intro_two
    LDA #$FC
    STA intro_three
    LDY #$FF
.L7230
lda $67e,Y                      ; presumably $67e is where EXILEL
                                ; leaves the save data
.L7233                                    
sta background_objects_type+5-base_address+load_address,Y ; $1b76
    DEY
    CPY #$FF
    BNE L7242
    CLC
    DEC L7230+2
    DEC L7233+2
.L7242
    INC intro_two
    BNE L7230
    INC intro_three
    BNE L7230

IF NOVELLA_LOOKUP = TRUE
.c793e
l793f = c793e+1
l7940 = c793e+2
    lda load_address                                                           ; 793e: ad 00 12    ...
.sub_c7941
l7942 = sub_c7941+1
l7943 = sub_c7941+2
    sta base_address                                                            ; 7941: 8d 00 01    ...
    inc l793f                                                                   ; 7944: ee 3f 79    .?y
    bne c794c                                                                   ; 7947: d0 03       ..
    inc l7940                                                                   ; 7949: ee 40 79    .@y
.c794c
    inc l7942                                                                   ; 794c: ee 42 79    .By
    bne c7954                                                                   ; 794f: d0 03       ..
    inc l7943                                                                   ; 7951: ee 43 79    .Cy
.c7954
    lda l793f                                                                   ; 7954: ad 3f 79    .?y
    cmp #<intro                                                                 ; 7957: c9 ed       ..
    bne c793e                                                                   ; 7959: d0 e3       ..
    lda l7940                                                                   ; 795b: ad 40 79    .@y
    cmp #>intro                                                                 ; 795e: c9 78       .x
    bne c793e                                                                   ; 7960: d0 dc       ..
    lda #&ff                                                                    ; 7962: a9 ff       ..
    sta &fe43                                                                   ; 7964: 8d 43 fe    .C.
    ldx #3                                                                      ; 7967: a2 03       ..
.loop_c7969
    lda l797a,x                                                                 ; 7969: bd 7a 79    .zy
    jsr push_sound_to_chip                                                               ; 796c: 20 e4 13     ..
    dex                                                                         ; 796f: ca          .
    bpl loop_c7969                                                              ; 7970: 10 f7       ..

IF SRAM = 0
    lda &01                                                                     ; 7972: a5 01       ..
    sta l499c                                                                   ; 7974: 8d 9c 49    ..I
ENDIF

ELSE
.L724A
lda load_address
.L724D
sta base_address
    INC L724A+1
    INC L724D+1
    BNE L724A
    INC L724A+2
    INC L724D+2
    LDA L724A+2
    CMP #HI(intro_end+255)
    BNE L724A
    LDA #$FF
    STA $FE43
    LDX #$03
.L726C
    LDA startup_sound,X
    JSR push_sound_to_chip
    DEX
    BPL L726C
ENDIF

IF SRAM

    ldx #$0f
.loop_01
    lda #$0f
IF SWRAM_FE6x = TRUE
    sta $fe62
    stx $fe60
ELIF SWRAM_FE6x = NOP
    nop:nop:nop
    nop:nop:nop
ENDIF
    stx $fe32
    stx $fe30
    ldy #<(swram_base_addr + &2000)
    sty intro_two
    lda #>(swram_base_addr + &2000)
    sta intro_three
.loop_02
    lda #%10101010
    sta (intro_two),Y
    cmp (intro_two),Y
    bne test_next_bank
    lda #%01010101
    sta (intro_two),Y
    cmp (intro_two),Y
    bne test_next_bank
    iny
    bne loop_02
    inc intro_two+1
    lda intro_two+1
    cmp #>(swram_base_addr + swram_bank_size)
    bcc loop_02

    tya
.loop_03
    sta swram_base_addr,Y
    dey
    bne loop_03
.loop_05
    lda sram_ram_end,Y          ; the files are concatenated...
.loop_04
    sta sram_rom_begin,Y
    iny
    bne loop_05
    inc loop_05+2
    inc loop_04+2
    lda loop_05+2
    cmp #HI(sram_rom_end - sram_rom_begin + sram_ram_end + 255)
    bcc loop_05
ENDIF

IF NOVELLA_LOOKUP = TRUE
IF SRAM = 1
    JMP intro1x
ELSE
    JMP intro1
ENDIF
ELSE
    JMP intro1
ENDIF

IF SRAM
.test_next_bank
    dex
    bpl loop_01
.infinite_loop
    jmp infinite_loop
ENDIF

IF NOVELLA_LOOKUP = TRUE
IF SRAM = 1
.intro1x
    lda &01                                                                     ; 7972: a5 01       ..
    sta l499c                                                                   ; 7974: 8d 9c 49    ..I
    jmp intro1
ENDIF
.l797a
    equb &ff, &df, &bf, &9f                                                     ; 797a: ff df bf... ...

    jmp &3000                                                                   ; 797e: 4c 00 30    L.0
ELSE
.startup_sound
    equb $FF,$DF,$BF,$9F,$00

if SRAM
    skip 10
endif

    equb $14,$01,$89
ENDIF

.intro_end

IF SRAM
.sram_init_end
ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF (change_to_weapon AND $8000)<>0:ERROR "bad top bit for change_to_weapon":ENDIF
IF (drop_object AND $8000)<>0:ERROR "bad top bit for drop_object":ENDIF
IF (f9_pressed AND $8000)<>0:ERROR "bad top bit for f9_pressed":ENDIF
IF (fire_weapon AND $8000)<>0:ERROR "bad top bit for fire_weapon":ENDIF
IF (just_rts AND $8000)<>0:ERROR "bad top bit for just_rts":ENDIF
IF (lower_gun_aim AND $8000)<>0:ERROR "bad top bit for lower_gun_aim":ENDIF
IF (move_down AND $8000)<>0:ERROR "bad top bit for move_down":ENDIF
IF (move_left AND $8000)<>0:ERROR "bad top bit for move_left":ENDIF
IF (move_right AND $8000)<>0:ERROR "bad top bit for move_right":ENDIF
IF (move_up AND $8000)<>0:ERROR "bad top bit for move_up":ENDIF
IF (or_extra_with_0f AND $8000)<>0:ERROR "bad top bit for or_extra_with_0f":ENDIF
IF (p_pressed AND $8000)<>0:ERROR "bad top bit for p_pressed":ENDIF
IF (pause AND $8000)<>0:ERROR "bad top bit for pause":ENDIF
IF (pick_up_object AND $8000)<>0:ERROR "bad top bit for pick_up_object":ENDIF
IF (play_whistle_1 AND $8000)<>0:ERROR "bad top bit for play_whistle_1":ENDIF
IF (play_whistle_2 AND $8000)<>0:ERROR "bad top bit for play_whistle_2":ENDIF
IF (raise_gun_aim AND $8000)<>0:ERROR "bad top bit for raise_gun_aim":ENDIF
IF (reset_gun_aim AND $8000)<>0:ERROR "bad top bit for reset_gun_aim":ENDIF
IF (retrieve_object AND $8000)<>0:ERROR "bad top bit for retrieve_object":ENDIF
IF (scroll_viewpoint AND $8000)<>0:ERROR "bad top bit for scroll_viewpoint":ENDIF
IF (store_object AND $8000)<>0:ERROR "bad top bit for store_object":ENDIF
IF (store_teleport AND $8000)<>0:ERROR "bad top bit for store_teleport":ENDIF
IF (swap_direction AND $8000)<>0:ERROR "bad top bit for swap_direction":ENDIF
IF (teleport_player AND $8000)<>0:ERROR "bad top bit for teleport_player":ENDIF
IF (throw_object AND $8000)<>0:ERROR "bad top bit for throw_object":ENDIF
IF (use_booster AND $8000)<>0:ERROR "bad top bit for use_booster":ENDIF
IF (volume_control AND $8000)<>0:ERROR "bad top bit for volume_control":ENDIF

;; the handlers table appears to be two tables in one - or is this the
;; disassembly being incorrect/unclear? Earlier entries have more
;; space for flags...

IF ((handle_background_door-handlers_start) AND $f000)<>0:ERROR "handle_background_door out of range":ENDIF
IF ((handle_background_engine_thruster-handlers_start) AND $f000)<>0:ERROR "handle_background_engine_thruster out of range":ENDIF
IF ((handle_background_invisible_switch-handlers_start) AND $f000)<>0:ERROR "handle_background_invisible_switch out of range":ENDIF
IF ((handle_background_mushrooms-handlers_start) AND $f000)<>0:ERROR "handle_background_mushrooms out of range":ENDIF
IF ((handle_background_object_fixed_wind-handlers_start) AND $f000)<>0:ERROR "handle_background_object_fixed_wind out of range":ENDIF
IF ((handle_background_object_from_data-handlers_start) AND $f000)<>0:ERROR "handle_background_object_from_data out of range":ENDIF
IF ((handle_background_object_from_type-handlers_start) AND $f000)<>0:ERROR "handle_background_object_from_type out of range":ENDIF
IF ((handle_background_object_random_wind-handlers_start) AND $f000)<>0:ERROR "handle_background_object_random_wind out of range":ENDIF
IF ((handle_background_object_water-handlers_start) AND $f000)<>0:ERROR "handle_background_object_water out of range":ENDIF
IF ((handle_background_stone_door-handlers_start) AND $f000)<>0:ERROR "handle_background_stone_door out of range":ENDIF
IF ((handle_background_switch-handlers_start) AND $f000)<>0:ERROR "handle_background_switch out of range":ENDIF
IF ((handle_background_teleport_beam-handlers_start) AND $f000)<>0:ERROR "handle_background_teleport_beam out of range":ENDIF
IF ((handlers_start-handlers_start) AND $f000)<>0:ERROR "handlers_start out of range":ENDIF

IF ((L43AD-handlers_start) AND $c000)<>0:ERROR "L43AD out of range":ENDIF
IF ((handle_active_grenade-handlers_start) AND $c000)<>0:ERROR "handle_active_grenade out of range":ENDIF
IF ((handle_big_fish-handlers_start) AND $c000)<>0:ERROR "handle_big_fish out of range":ENDIF
IF ((handle_bird-handlers_start) AND $c000)<>0:ERROR "handle_bird out of range":ENDIF
IF ((handle_bird_invisible-handlers_start) AND $c000)<>0:ERROR "handle_bird_invisible out of range":ENDIF
IF ((handle_bird_red-handlers_start) AND $c000)<>0:ERROR "handle_bird_red out of range":ENDIF
IF ((handle_bush-handlers_start) AND $c000)<>0:ERROR "handle_bush out of range":ENDIF
IF ((handle_cannon-handlers_start) AND $c000)<>0:ERROR "handle_cannon out of range":ENDIF
IF ((handle_cannonball-handlers_start) AND $c000)<>0:ERROR "handle_cannonball out of range":ENDIF
IF ((handle_chatter_active-handlers_start) AND $c000)<>0:ERROR "handle_chatter_active out of range":ENDIF
IF ((handle_chatter_inactive-handlers_start) AND $c000)<>0:ERROR "handle_chatter_inactive out of range":ENDIF
IF ((handle_clawed_robot-handlers_start) AND $c000)<>0:ERROR "handle_clawed_robot out of range":ENDIF
IF ((handle_collectable-handlers_start) AND $c000)<>0:ERROR "handle_collectable out of range":ENDIF
IF ((handle_coronium_boulder-handlers_start) AND $c000)<>0:ERROR "handle_coronium_boulder out of range":ENDIF
IF ((handle_coronium_crystal-handlers_start) AND $c000)<>0:ERROR "handle_coronium_crystal out of range":ENDIF
IF ((handle_crew_member-handlers_start) AND $c000)<>0:ERROR "handle_crew_member out of range":ENDIF
IF ((handle_death_ball_blue-handlers_start) AND $c000)<>0:ERROR "handle_death_ball_blue out of range":ENDIF
IF ((handle_destinator-handlers_start) AND $c000)<>0:ERROR "handle_destinator out of range":ENDIF
IF ((handle_door-handlers_start) AND $c000)<>0:ERROR "handle_door out of range":ENDIF
IF ((handle_energy_capsule-handlers_start) AND $c000)<>0:ERROR "handle_energy_capsule out of range":ENDIF
IF ((handle_engine_fire-handlers_start) AND $c000)<>0:ERROR "handle_engine_fire out of range":ENDIF
IF ((handle_engine_thruster-handlers_start) AND $c000)<>0:ERROR "handle_engine_thruster out of range":ENDIF
IF ((handle_explosion-handlers_start) AND $c000)<>0:ERROR "handle_explosion out of range":ENDIF
IF ((handle_explosion_type_00-handlers_start) AND $c000)<>0:ERROR "handle_explosion_type_00 out of range":ENDIF
IF ((handle_explosion_type_40-handlers_start) AND $c000)<>0:ERROR "handle_explosion_type_40 out of range":ENDIF
IF ((handle_explosion_type_80-handlers_start) AND $c000)<>0:ERROR "handle_explosion_type_80 out of range":ENDIF
IF ((handle_explosion_type_c0-handlers_start) AND $c000)<>0:ERROR "handle_explosion_type_c0 out of range":ENDIF
IF ((handle_fireball-handlers_start) AND $c000)<>0:ERROR "handle_fireball out of range":ENDIF
IF ((handle_flask-handlers_start) AND $c000)<>0:ERROR "handle_flask out of range":ENDIF
IF ((handle_flask_full-handlers_start) AND $c000)<>0:ERROR "handle_flask_full out of range":ENDIF
IF ((handle_fluffy-handlers_start) AND $c000)<>0:ERROR "handle_fluffy out of range":ENDIF
IF ((handle_frogman_cyan-handlers_start) AND $c000)<>0:ERROR "handle_frogman_cyan out of range":ENDIF
IF ((handle_frogman_green-handlers_start) AND $c000)<>0:ERROR "handle_frogman_green out of range":ENDIF
IF ((handle_frogman_red-handlers_start) AND $c000)<>0:ERROR "handle_frogman_red out of range":ENDIF
IF ((handle_gargoyle-handlers_start) AND $c000)<>0:ERROR "handle_gargoyle out of range":ENDIF
IF ((handle_giant_wall-handlers_start) AND $c000)<>0:ERROR "handle_giant_wall out of range":ENDIF
IF ((handle_green_slime-handlers_start) AND $c000)<>0:ERROR "handle_green_slime out of range":ENDIF
IF ((handle_grenade_inactive-handlers_start) AND $c000)<>0:ERROR "handle_grenade_inactive out of range":ENDIF
IF ((handle_hover_ball-handlers_start) AND $c000)<>0:ERROR "handle_hover_ball out of range":ENDIF
IF ((handle_hover_ball_invisible-handlers_start) AND $c000)<>0:ERROR "handle_hover_ball_invisible out of range":ENDIF
IF ((handle_hovering_robot-handlers_start) AND $c000)<>0:ERROR "handle_hovering_robot out of range":ENDIF
IF ((handle_icer_bullet-handlers_start) AND $c000)<>0:ERROR "handle_icer_bullet out of range":ENDIF
IF ((handle_imp-handlers_start) AND $c000)<>0:ERROR "handle_imp out of range":ENDIF
IF ((handle_maggot-handlers_start) AND $c000)<>0:ERROR "handle_maggot out of range":ENDIF
IF ((handle_maggot_machine-handlers_start) AND $c000)<>0:ERROR "handle_maggot_machine out of range":ENDIF
IF ((handle_moving_fireball-handlers_start) AND $c000)<>0:ERROR "handle_moving_fireball out of range":ENDIF
IF ((handle_mushroom_ball-handlers_start) AND $c000)<>0:ERROR "handle_mushroom_ball out of range":ENDIF
IF ((handle_mysterious_weapon-handlers_start) AND $c000)<>0:ERROR "handle_mysterious_weapon out of range":ENDIF
IF ((handle_nest-handlers_start) AND $c000)<>0:ERROR "handle_nest out of range":ENDIF
IF ((handle_nest_dweller-handlers_start) AND $c000)<>0:ERROR "handle_nest_dweller out of range":ENDIF
IF ((handle_pistol_bullet-handlers_start) AND $c000)<>0:ERROR "handle_pistol_bullet out of range":ENDIF
IF ((handle_placeholder-handlers_start) AND $c000)<>0:ERROR "handle_placeholder out of range":ENDIF
IF ((handle_plasma_ball-handlers_start) AND $c000)<>0:ERROR "handle_plasma_ball out of range":ENDIF
IF ((handle_player_object-handlers_start) AND $c000)<>0:ERROR "handle_player_object out of range":ENDIF
IF ((handle_red_bullet-handlers_start) AND $c000)<>0:ERROR "handle_red_bullet out of range":ENDIF
IF ((handle_red_drop-handlers_start) AND $c000)<>0:ERROR "handle_red_drop out of range":ENDIF
IF ((handle_red_slime-handlers_start) AND $c000)<>0:ERROR "handle_red_slime out of range":ENDIF
IF ((handle_remote_control-handlers_start) AND $c000)<>0:ERROR "handle_remote_control out of range":ENDIF
IF ((handle_robot-handlers_start) AND $c000)<>0:ERROR "handle_robot out of range":ENDIF
IF ((handle_robot_blue-handlers_start) AND $c000)<>0:ERROR "handle_robot_blue out of range":ENDIF
IF ((handle_sucker-handlers_start) AND $c000)<>0:ERROR "handle_sucker out of range":ENDIF
IF ((handle_sucker_deadly-handlers_start) AND $c000)<>0:ERROR "handle_sucker_deadly out of range":ENDIF
IF ((handle_switch-handlers_start) AND $c000)<>0:ERROR "handle_switch out of range":ENDIF
IF ((handle_teleport_beam-handlers_start) AND $c000)<>0:ERROR "handle_teleport_beam out of range":ENDIF
IF ((handle_tracer_bullet-handlers_start) AND $c000)<>0:ERROR "handle_tracer_bullet out of range":ENDIF
IF ((handle_triax-handlers_start) AND $c000)<>0:ERROR "handle_triax out of range":ENDIF
IF ((handle_turret-handlers_start) AND $c000)<>0:ERROR "handle_turret out of range":ENDIF
IF ((handle_worm-handlers_start) AND $c000)<>0:ERROR "handle_worm out of range":ENDIF
IF ((handle_yellow_ball-handlers_start) AND $c000)<>0:ERROR "handle_yellow_ball out of range":ENDIF
IF ((unused_object_handler-handlers_start) AND $c000)<>0:ERROR "unused_object_handler out of range":ENDIF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

IF SRAM
;  SAVE "S.RAM", (sram_ram_begin + load_address - main_begin), (sram_ram_end + load_address - main_begin), intro, load_address
;  SAVE "S.ROM", (sram_ram_end + load_address - main_begin), (sram_ram_end + (sram_rom_end - sram_rom_begin) + load_address - main_begin)
;  SAVE "S.INIT2", (sram_init2_begin + load_address - main_begin), (sram_init2_end + load_address - main_begin)
;  SAVE "S.INIT", sram_init_begin, sram_init_end

  SAVE "ExileMC", load_address, intro_end, intro
ELSE
;  SAVE "B.MAIN", load_address, (main_end + load_address - main_begin), intro, load_address
;  SAVE "B.INTRO", intro,intro_end

  SAVE "ExileB", load_address, intro_end, intro 
ENDIF

print "Start of Relocated code:", ~main_begin, "/", ~load_address
print "End of Relocated code:", ~(main_end - 1), "/", ~(main_end + load_address - main_begin - 1)
print "Start of Static code:", ~intro
print "End of Static code:", ~(intro_end - 1)
print "Load Address:", ~load_address
print "File Length:", ~(intro_end-load_address)
print "Execute Address:", ~intro
NEXT
}
