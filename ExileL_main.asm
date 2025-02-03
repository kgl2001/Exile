; VERSION: Select from one of the following options:
; STH    Will build a version of the Loader that matches the Loader file from the STH archives
; V1     Will build a version of the Loader that matches the hfe image Exile_D1S1_80T_HG3_2066CA7D_1.hfe
; V2     Will build a version of the Loader that matches the hfe image Exile_D1S1_80T_HG3_EA8CECA2_1.hfe
; V3     Will build a version of the Loader that matches the hfe image Exile_D1S2_80T_HG3_162468BD_1.hfe
; MC     Will build a version of the Loader that matches the hfe image Exile_A6B2BE99.hfe
; CUSTOM Will build a custom version of the Loader - Adjust CUSTOM settings below (after line: IF VERSION = CUSTOM)

; RELOC_ADDR: Select either PAGE_15 or PAGE_17

; FILE_SYSTEM: Select either DFS, NFS or ADFS

; REMOVE_DEAD_CODE: Select either TRUE or FALSE

; SWRAM_FE6x: Select either TRUE, FALSE or NOP
; TRUE will include SWRAM FE6x code. NOP will replace SWRAM FE6x code with NOP instructions

; DYN_MAP_DATA_ADDR: Select either TRUE or FALSE
; FALSE will fix map_addr at &41e0. TRUE will allow map_addr to follow on from previous code

; FILE_POINTER_SAVE: Select either IN_STATIC or IN_RELOC
; IN_STATIC will locate code in static area of memory. IN_RELOC to locate code in relocated area of memory

; RELOC_TOGGLE_FS_TXT: Select either TRUE or FALSE.
; TRUE will issue *TAPE followed by *yyyy in relocated code area, where yyyy is either DFS, ADFS or NFS (as defined by FILE_SYSTEM)

; RELOC_TOGGLE_FS: TRUE, FALSE or NOP
; TRUE will include FS toggle code. NOP will replace toggle code with NOP instructions
; If TRUE or NOP, text at .reloc_tape_txt will be generated, regardless of RELOC_TOGGLE_FS_TXT setting.

; STATIC_TOGGLE_FS_TXT: Select either TRUE or FALSE.
; TRUE will issue *TAPE followed by *yyyy in static code area, where yyyy is either DFS, ADFS or NFS (as defined by FILE_SYSTEM)

; STATIC_TOGGLE_FS: TRUE or FALSE
; TRUE will include FS toggle code
; If TRUE, text at .reloc_tape_txt will be generated, regardless of RELOC_TOGGLE_FS_TXT setting.

; UNREF_DATA: Select either FALSE, DATA_STH_V1, DATA_V2_V3 or DATA_MC
; Will add selected unreferenced data block.

; KEEP_FINAL_JMP: TRUE or FALSE


    org &3000
{
; 
; *****************************************************************************
; For standalone assembling remove comments from this section.
; Modify the VERSION = line as required, and adjust the CUSTOM table setting to
; match your requirements.
; Otherwise these variables should be commented out, as they are defined in the
; calling file.
; *****************************************************************************
;
; STH = 0
; V1 = 1
; V2 = 2
; V3 = 3
; MC = 4
; CUSTOM = 5

; VERSION = V3

; IF (VERSION < STH OR VERSION > CUSTOM):ERROR "Incorrect Source Version Option Selected":ENDIF

; PAGE_15 = 0
; PAGE_17 = 1
; DFS = 0
; NFS = 1
; ADFS = 2
; NOP = 1
; IN_STATIC = 0
; IN_RELOC = 1
; DATA_STH_V1 = 1
; DATA_V2_V3 = 2
; DATA_MC = 3

; IF VERSION = STH
; RELOC_ADDR = PAGE_15
; FILE_SYSTEM = DFS
; REMOVE_DEAD_CODE = FALSE
; SWRAM_FE6x = TRUE
; DYN_MAP_DATA_ADDR = FALSE
; FILE_POINTER_SAVE = IN_RELOC
; STATIC_TOGGLE_FS_TXT = FALSE
; STATIC_TOGGLE_FS = FALSE
; RELOC_TOGGLE_FS_TXT = TRUE
; RELOC_TOGGLE_FS = NOP
; UNREF_DATA = DATA_STH_V1
; KEEP_FINAL_JMP = TRUE

; ELIF VERSION = V1
; RELOC_ADDR = PAGE_15
; FILE_SYSTEM = DFS
; REMOVE_DEAD_CODE = FALSE
; SWRAM_FE6x = TRUE
; DYN_MAP_DATA_ADDR = FALSE
; FILE_POINTER_SAVE = IN_RELOC
; STATIC_TOGGLE_FS_TXT = FALSE
; STATIC_TOGGLE_FS = FALSE
; RELOC_TOGGLE_FS_TXT = TRUE
; RELOC_TOGGLE_FS = TRUE
; UNREF_DATA = DATA_STH_V1
; KEEP_FINAL_JMP = FALSE

; ELIF VERSION = V2 OR VERSION = V3
; RELOC_ADDR = PAGE_17
; FILE_SYSTEM = DFS
; REMOVE_DEAD_CODE = FALSE
; SWRAM_FE6x = TRUE
; DYN_MAP_DATA_ADDR = FALSE
; FILE_POINTER_SAVE = IN_STATIC
; STATIC_TOGGLE_FS_TXT = TRUE
; STATIC_TOGGLE_FS = TRUE
; RELOC_TOGGLE_FS_TXT = TRUE
; RELOC_TOGGLE_FS = FALSE
; UNREF_DATA = DATA_V2_V3
; KEEP_FINAL_JMP = FALSE

; ELIF VERSION = MC
; RELOC_ADDR = PAGE_15
; FILE_SYSTEM = ADFS
; REMOVE_DEAD_CODE = FALSE
; SWRAM_FE6x = TRUE
; DYN_MAP_DATA_ADDR = FALSE
; FILE_POINTER_SAVE = IN_RELOC
; STATIC_TOGGLE_FS_TXT = FALSE
; STATIC_TOGGLE_FS = FALSE
; RELOC_TOGGLE_FS_TXT = TRUE
; RELOC_TOGGLE_FS = TRUE
; UNREF_DATA = DATA_MC
; KEEP_FINAL_JMP = FALSE

; ELIF VERSION = CUSTOM
; RELOC_ADDR = PAGE_17
; FILE_SYSTEM = NFS
; REMOVE_DEAD_CODE = TRUE
; SWRAM_FE6x = FALSE
; DYN_MAP_DATA_ADDR = TRUE
; FILE_POINTER_SAVE = IN_STATIC
; STATIC_TOGGLE_FS_TXT = FALSE
; STATIC_TOGGLE_FS = FALSE
; RELOC_TOGGLE_FS_TXT = FALSE
; RELOC_TOGGLE_FS = FALSE
; UNREF_DATA = FALSE
; KEEP_FINAL_JMP = FALSE
; ENDIF
; 
; *****************************************************************************
; End of standalone assembly section
; *****************************************************************************
;

IF NOT(RELOC_ADDR = PAGE_15 OR RELOC_ADDR = PAGE_17):ERROR "Incorrect RELOC_ADDR Option Selected":ENDIF
IF (FILE_SYSTEM < DFS OR FILE_SYSTEM > ADFS):ERROR "Incorrect FILE_SYSTEM Option Selected":ENDIF
IF NOT(REMOVE_DEAD_CODE = TRUE OR REMOVE_DEAD_CODE = FALSE):ERROR "Incorrect REMOVE_DEAD_CODE Option Selected":ENDIF
IF NOT(SWRAM_FE6x = TRUE OR SWRAM_FE6x = FALSE OR SWRAM_FE6x = NOP):ERROR "Incorrect SWRAM_FE6x Option Selected":ENDIF
IF NOT(DYN_MAP_DATA_ADDR = TRUE OR DYN_MAP_DATA_ADDR = FALSE):ERROR "Incorrect DYN_MAP_DATA_ADDR Option Selected":ENDIF
IF NOT(FILE_POINTER_SAVE = IN_STATIC OR FILE_POINTER_SAVE = IN_RELOC):ERROR "Incorrect FILE_POINTER_SAVE Option Selected":ENDIF
IF NOT(STATIC_TOGGLE_FS_TXT = TRUE OR STATIC_TOGGLE_FS_TXT = FALSE):ERROR "Incorrect STATIC_TOGGLE_FS_TXT Option Selected":ENDIF
IF NOT(STATIC_TOGGLE_FS = TRUE OR STATIC_TOGGLE_FS = FALSE):ERROR "Incorrect STATIC_TOGGLE_FS Option Selected":ENDIF
IF NOT(RELOC_TOGGLE_FS_TXT = TRUE OR RELOC_TOGGLE_FS_TXT = FALSE):ERROR "Incorrect RELOC_TOGGLE_FS_TXT Option Selected":ENDIF
IF NOT(RELOC_TOGGLE_FS = TRUE OR RELOC_TOGGLE_FS = FALSE OR RELOC_TOGGLE_FS = NOP):ERROR "Incorrect RELOC_TOGGLE_FS Option Selected":ENDIF
IF (UNREF_DATA < FALSE OR UNREF_DATA > DATA_MC):ERROR "Incorrect UNREF_DATA Option Selected":ENDIF
IF NOT(KEEP_FINAL_JMP = TRUE OR KEEP_FINAL_JMP = FALSE):ERROR "Incorrect KEEP_FINAL_JMP Option Selected":ENDIF

; Constants
cr                                                 = 13
crtc_horz_displayed                                = 1
crtc_scan_lines_per_char                           = 9
crtc_screen_start_high                             = 12
crtc_screen_start_low                              = 13
lf                                                 = 10
maxBank                                            = 15
max_char_value                                     = 127
max_number_of_chars                                = 14
min_char_value                                     = 32
osbyte_clear_escape                                = 124
osbyte_explode_chars                               = 20
osbyte_flush_buffer_class                          = 15
osbyte_inkey                                       = 129
osbyte_issue_service_request                       = 143
osbyte_read_tube_presence                          = 234
osbyte_read_write_ctrl_function_key_status         = 227
osbyte_read_write_ctrl_shift_function_key_status   = 228
osbyte_read_write_escape_break_effect              = 200
osbyte_read_write_function_key_status              = 225
osbyte_read_write_shift_function_key_status        = 226
osbyte_set_cursor_editing                          = 4
osbyte_set_escape                                  = 125
osbyte_vsync                                       = 19
osbyte_write_video_ula_control                     = 154
osfile_load                                        = 255
osfile_read_catalogue_info                         = 5
osfile_save                                        = 0
osfind_close                                       = 0
osword_read_line                                   = 0
screen_size_pages                                  = 40
screen_width                                       = 64
spc                                                = 32
swram_bank_size                                    = 16384

screen_base_page = &80 - screen_size_pages

; Memory locations
zp_0                            = &0000
l0001                           = &0001
l0002                           = &0002
this_object_data                = &0003
new_object_data_pointer         = &0004
new_object_type_pointer         = &0005
velocity_signs_OR_pixel_colour  = &0007
l0009                           = &0009
sprite_row_byte_offset          = &000a
zp_various_b                    = &000b
square_sprite                   = &000e
square_orientation              = &000f
l0010                           = &0010
l0011                           = &0011
l0018                           = &0018
l001a                           = &001a
zp_various_1b                   = &001b
zp_various_1c                   = &001c
l001d                           = &001d
l001e                           = &001e
this_object_type                = &001f
l0020                           = &0020
l0022                           = &0022
square_x                        = &0023
square_y                        = &0025
this_object_angle               = &0027
this_object_extra               = &0028
this_object_flags_lefted        = &0029
this_object_width               = &002a
this_object_data_pointer        = &002b
this_object_height              = &002c
this_object_tx                  = &002f
this_object_ty                  = &0031
this_sprite_width               = &0032
this_sprite_width_old           = &0033
this_sprite_height              = &0034
this_sprite_height_old          = &0035
this_object_x_low               = &0036
this_object_x_low_old           = &0037
this_object_y_low               = &0038
this_object_y_low_old           = &0039
this_object_x                   = &003a
this_object_x_old               = &003b
this_object_y                   = &003c
this_object_y_old               = &003d
this_object_screen_x_low        = &003e
this_object_screen_x_low_old    = &003f
this_object_screen_y_low        = &0040
this_object_screen_y_low_old    = &0041
this_object_screen_x            = &0042
this_object_screen_x_old        = &0043
this_object_screen_y            = &0044
this_object_screen_y_old        = &0045
this_sprite_a                   = &0046
this_sprite_a_old               = &0047
this_sprite_b                   = &0048
this_sprite_b_old               = &0049
this_sprite_flipping_flags      = &004a
this_sprite_flipping_flags_old  = &004b
this_sprite_partflip            = &004c
this_sprite_partflip_old        = &004d
bytes_per_line_in_sprite        = &0050
copy_of_stack_pointer_51        = &0051
bytes_per_line_on_screen        = &0052
lines_in_sprite                 = &0053
skip_sprite_calculation_flags   = &0055
this_object_flags               = &0056
this_object_flags_old           = &0057
this_object_flipping_flags      = &0058
this_object_flipping_flags_old  = &0059
this_object_palette             = &005a
this_object_palette_old         = &005b
this_object_sprite              = &005c
this_object_sprite_old          = &005d
zp_5e                           = &005e
l005f                           = &005f
l0060                           = &0060
l0061                           = &0061
l0062                           = &0062
l0063                           = &0063
l0064                           = &0064
l0065                           = &0065
l0066                           = &0066
zp_67                           = &0067
l0068                           = &0068
l0069                           = &0069
l006a                           = &006a
l006b                           = &006b
l006c                           = &006c
l006d                           = &006d
zp_various_6e                   = &006e
zp_various_6f                   = &006f
l0070                           = &0070
l0071                           = &0071
map_address                     = &0072
current_object                  = &0078
plotter_x                       = &007c
screen_offset_x_low             = &007e
screen_offset_x_low_old         = &007f
screen_offset_y_low             = &0080
screen_offset_y_low_old         = &0081
screen_offset_x                 = &0082
screen_offset_x_old             = &0083
screen_offset_y                 = &0084
screen_offset_y_old             = &0085
l0086                           = &0086
l00fd                           = &00fd
l00ff                           = &00ff
base_address                    = &0100
l01a0                           = &01a0
userv                           = &0200
brkv                            = &0202
wrchv                           = &020e
filev                           = &0212
fscv                            = &021e
l0400                           = &0400
l04a0                           = &04a0
l08a0                           = &08a0
save_data_table                 = &2c00
l59e0                           = &59e0
swram_base_addr                 = &8000
crtc_address_register           = &fe00
crtc_address_write              = &fe01
video_ula_palette               = &fe21
romsel                          = &fe30
lfe32                           = &fe32

IF SWRAM_FE6x = TRUE
user_via_orb_irb                = &fe60
user_via_ddrb                   = &fe62
ENDIF

vector_table_pointer            = &ffb7
nvwrch                          = &ffcb
osfind                          = &ffce
osfile                          = &ffdd
osrdch                          = &ffe0
oswrch                          = &ffee
osword                          = &fff1
osbyte                          = &fff4
oscli                           = &fff7

.code_start

IF RELOC_ADDR = PAGE_15
    org &1500
ELSE
    org &1700
ENDIF

;; ##############################################################################
;; 
;;    Object handlers
;;    ===============
;;    background objects:
;;    no   l   h    addr  name                                  object created          80 40 20 10
;;    &00  &84 &20  &3caf handle_background_invisible_switch                             -  -  +  -
;;    &01  &79 &b0  &3ca4 handle_background_teleport_beam        teleport beam           +  -  +  +
;;    &02  &8e &90  &3cb9 handle_background_object_from_data     (use object_data & &7f) +  -  -  +
;;    &03  &31 &f0  &3c5c handle_background_door                 door                    +  +  +  +
;;    &04  &2e &f0  &3c59 handle_background_stone_door           stone door              +  +  +  +
;;    &05  &86 &b0  &3cb1 handle_background_object_from_type     (use object_type)       +  -  +  +
;;    &06  &86 &b0  &3cb1 handle_background_object_from_type     (use object_type)       +  -  +  +
;;    &07  &86 &b0  &3cb1 handle_background_object_from_type     (use object_type)       +  -  +  +
;;    &08  &9c &b0  &3cc7 handle_background_switch               switch                  +  -  +  +
;;    &09  &00 &b0  &3c2b handle_background_object_emerging      (use object_type)       +  -  +  +
;;    &0a  &00 &b0  &3c2b handle_background_object_emerging      (use object_type)       +  -  +  +
;;    &0b  &85 &30  &3cb0 handle_background_object_fixed_wind                            -  -  +  +
;;    &0c  &29 &90  &3c54 handle_background_engine_thruster      engine thruster         +  -  -  +
;;    &0d  &85 &30  &3cb0 handle_background_object_water                                 -  -  +  +
;;    &0e  &85 &30  &3cb0 handle_background_object_random_wind                           -  -  +  +
;;    &0f  &a1 &30  &3ccc handle_background_mushrooms            mushroom ball           -  -  +  +
;;    &10  &f4 &00  &3d1f handle_explosion_type_00
;;    &11  &f4 &00  &3d1f handle_explosion_type_40
;;    &12  &f4 &00  &3d1f handle_explosion_type_80
;;    &13  &f4 &00  &3d1f handle_explosion_type_c0
;; 
;;    stack objects:
;;  r no   l   h    addr  name                        object
;;  0:&00  &01 &05  &412c handle_player_object          player
;;    &01  &f5 &00  &3d20 handle_chatter_active         active chatter
;;    &02  &f5 &80  &3d20 handle_crew_member            pericles crew member
;;    &03  &f4 &80  &3d1f handle_fluffy                 fluffy
;;  1:&04  &02 &c5  &412d handle_nest                   small nest
;;    &05  &02 &c5  &412d handle_nest                   big nest
;;  2:&06  &f5 &80  &3d20 handle_frogman_red            red frogman
;;    &07  &f5 &80  &3d20 handle_frogman_green          green frogman
;;    &08  &f5 &80  &3d20 handle_frogman_cyan           cyan frogman
;;    &09  &f5 &00  &3d20 handle_red_slime              red slime
;;    &0a  &f4 &00  &3d1f handle_green_slime            green slime
;;    &0b  &f4 &00  &3d1f handle_yellow_ball            yellow ball
;;    &0c  &f5 &00  &3d20 handle_sucker                 sucker
;;    &0d  &5a &05  &4185 handle_sucker_deadly          deadly sucker
;;    &0e  &f5 &80  &3d20 handle_big_fish               big fish
;;  3:&0f  &f4 &80  &3d1f handle_worm                   worm
;;    &10  &5a &c5  &4185 handle_nest_dweller           pirahna
;;    &11  &5a &85  &4185 handle_nest_dweller           wasp
;;  4:&12  &f4 &c0  &3d1f handle_grenade_active         active grenade
;;    &13  &f5 &c0  &3d20 handle_icer_bullet            icer bullet
;;    &14  &f5 &c0  &3d20 handle_tracer_bullet          tracer bullet
;;    &15  &f4 &c0  &3d1f handle_cannonball           cannonball
;;    &16  &f4 &c0  &3d1f handle_death_ball_blue        blue death ball
;;    &17  &f4 &c0  &3d1f handle_red_bullet             red bullet
;;    &18  &f5 &c0  &3d20 handle_pistol_bullet          pistol bullet
;;    &19  &01 &85  &412c handle_plasma_ball            plasma ball
;;    &1a  &02 &45  &412d handle_hover_ball             hover ball
;;    &1b  &02 &45  &412d handle_hover_ball_invisible   invisible hover ball
;;  5:&1c  &5a &45  &4185 handle_robot                  magenta robot
;;    &1d  &5a &45  &4185 handle_robot                  red robot
;;    &1e  &5a &45  &4185 handle_robot_blue             blue robot
;;    &1f  &5a &45  &4185 handle_turret                 green/white turret
;;    &20  &5a &45  &4185 handle_turret                 cyan/red turret
;;    &21  &f5 &40  &3d20 handle_hovering_robot         hovering robot
;;  6:&22  &f5 &40  &3d20 handle_clawed_robot           magenta clawed robot
;;    &23  &f5 &40  &3d20 handle_clawed_robot           cyan clawed robot
;;    &24  &f5 &40  &3d20 handle_clawed_robot           green clawed robot
;;    &25  &f5 &40  &3d20 handle_clawed_robot           red clawed robot
;;    &26  &f5 &00  &3d20 handle_triax                  triax
;;    &27  &5a &85  &4185 handle_maggot                 maggot
;;    &28  &f4 &c0  &3d1f handle_gargoyle               gargoyle
;;    &29  &f5 &80  &3d20 handle_imp                    red/magenta imp
;;    &2a  &f5 &80  &3d20 handle_imp                    red/yellow imp
;;    &2b  &f5 &80  &3d20 handle_imp                    blue/cyan imp
;;    &2c  &f5 &80  &3d20 handle_imp                    cyan/yellow imp
;;    &2d  &f5 &80  &3d20 handle_imp                    red/cyan imp
;;    &2e  &f5 &80  &3d20 handle_bird                   green/yellow bird
;;    &2f  &f5 &80  &3d20 handle_bird                   white/yellow bird
;;    &30  &f5 &80  &3d20 handle_bird_red               red/magenta bird
;;    &31  &01 &85  &412c handle_bird_invisible         invisible bird
;;  7:&32  &f4 &00  &3d1f handle_lightning              lightning
;;    &33  &f5 &00  &3d20 handle_mushroom_ball          red mushroom ball
;;    &34  &f5 &00  &3d20 handle_mushroom_ball          blue mushroom ball
;;    &35  &f5 &00  &3d20 handle_engine_fire            engine fire
;;    &36  &f5 &c0  &3d20 handle_red_drop               red drop
;;    &37  &02 &05  &412d handle_fireball               fireball
;;  8:&38  &f5 &00  &3d20 handle_chatter_inactive       inactive chatter
;;    &39  &f4 &00  &3d1f handle_moving_fireball        moving fireball
;;    &3a  &f4 &00  &3d1f handle_giant_wall             giant wall
;;    &3b  &02 &05  &412d handle_engine_thruster        engine thruster
;;    &3c  &03 &c5  &412e handle_door                   horizontal door
;;    &3d  &03 &c5  &412e handle_door                   vertical door
;;    &3e  &03 &c5  &412e handle_door                   horizontal stone door
;;    &3f  &03 &c5  &412e handle_door                   vertical stone door
;;    &40  &02 &05  &412d handle_bush                   bush
;;    &41  &3c &05  &4167 handle_teleport_beam          teleport beam
;;    &42  &f5 &c0  &3d20 handle_switch                 switch
;;    &43  &01 &05  &412c (null function)               chest
;;    &44  &5b &05  &4186 handle_explosion              explosion
;;    &45  &01 &05  &412c (null function)               rock
;;    &46  &f5 &00  &3d20 handle_cannon                 cannon
;;    &47  &f4 &40  &3d1f handle_mysterious_weapon      mysterious weapon
;;    &48  &f4 &00  &3d1f handle_maggot_machine         maggot machine
;;    &49  &02 &05  &412d handle_placeholder            placeholder
;;  9:&4a  &f4 &00  &3d1f handle_destinator             destinator
;;    &4b  &f4 &80  &3d1f handle_energy_capsule         energy capsule
;;    &4c  &01 &05  &412c handle_flask                  empty flask
;;    &4d  &02 &05  &412d handle_flask_full             full flask
;;    &4e  &f4 &00  &3d1f handle_remote_control         remote control device
;;    &4f  &f4 &00  &3d1f handle_remote_control         cannon control device
;;    &50  &f4 &c0  &3d1f handle_grenade_inactive       inactive grenade
;;    &51  &f4 &00  &3d1f handle_collectable            cyan/yellow/green key
;;    &52  &f4 &00  &3d1f handle_collectable            red/yellow/green key
;;    &53  &f4 &00  &3d1f handle_collectable            green/yellow/red key
;;    &54  &f4 &00  &3d1f handle_collectable            yellow/white/red key
;;    &55  &f4 &00  &3d1f handle_coronium_boulder       coronium boulder
;;    &56  &f4 &00  &3d1f handle_collectable            red/magenta/red key
;;    &57  &f4 &00  &3d1f handle_collectable            blue/cyan/green key
;;    &58  &f4 &00  &3d1f handle_coronium_crystal       coronium crystal
;;    &59  &f4 &00  &3d1f handle_collectable            jetpack booster
;;    &5a  &f4 &00  &3d1f handle_collectable            pistol
;;    &5b  &f4 &00  &3d1f handle_collectable            icer
;;    &5c  &f4 &00  &3d1f handle_collectable            discharge device
;;    &5d  &f4 &00  &3d1f handle_collectable            plasma gun
;;    &5e  &f4 &00  &3d1f handle_collectable            protection suit
;;    &5f  &f4 &00  &3d1f handle_collectable            fire immunity device
;;    &60  &f4 &00  &3d1f handle_collectable            mushroom immunity pull
;;    &61  &f4 &00  &3d1f handle_collectable            whistle 1
;;    &62  &f4 &00  &3d1f handle_collectable            whistle 2
;;    &63  &f4 &00  &3d1f handle_collectable            radiation immunity pull
;;    &64  &01 &05  &412c (null function)               ?
;; 
;; ##############################################################################
.main_begin
.object_sprite_lookup
    ;;     0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb   4, &14,   4, &75, &1e, &1b, &10, &10, &10, &1c, &1c, &20, &70, &70, &61, &52; 00
    equb &72, &4f, &21,   8,   8, &21, &21,   8,   8, &21, &78, &78, &13, &13, &13, &5e; 10
    equb &5e, &15, &16, &16, &16, &16,   4, &52, &45, &64, &64, &64, &64, &64, &59, &59; 20
    equb &59, &59, &6d, &63, &63, &0b, &0f, &17, &14, &17, &39, &17, &4a, &4b, &3c, &41; 30 
    equb &1a, &71, &2e, &5d, &17, &20, &56, &57, &47, &22, &60, &7b, &76, &76, &58, &58; 40
    equb &21, &4d, &4d, &4d, &4d, &20, &4d, &4d, &22, &6b, &6c, &6c, &79, &6c,   4, &7a; 50
    equb &63, &7c, &7c, &79, &77; 60

.object_palette_lookup
    ;;  & &80 = can be picked up
    ;;  & &7f = palette
    ;;     0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &3e, &1b, &2e, &f2, &32, &32, &53,   5, &0f, &14, &29, &bc, &65, &65, &f7, &97; 00
    equb &d3, &c7, &ef, &7e, &5f, &3c, &5a, &11, &2d, &34, &e1, &80, &55, &1b, &4c, &59; 10
    equb &23, &72, &2e, &7b, &77, &33, &39, &8b, &44, &51, &0d, &46, &2b, &53, &35, &3c; 20
    equb   2,   1, &70, &9c, &cf,   0, &14, &10, &4b, &10, &0c, &34, &6b, &6b, &42, &42; 30
    equb &31, &6f, &15, &2e, &12, &cb, &33, &b1, &62,   0, &db, &9f, &8f, &cf, &e5, &8e; 40
    equb &ef, &ab, &ad, &95, &9c, &91, &92, &a6, &91, &b1, &8e, &e0, &a2, &b5, &b3, &e3; 50
    equb &d5, &e3, &d7, &f0, &71; 60

.table_01a
    equb &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e
    equb &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e
    equb &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e, &2e
.table_01b
    equb &f0, &c8, &3c, &28, &28, &3c, &3c,   3,   8,   8,   8, &0c, &18, &28, &3c, &28
    equb &50, &28,   8, &78,   8, &20, &10, &14, &1c, &0c, &20, &50, &30, &64, &28, &3c
    equb &50, &78, &a0, &28, &28, &3c, &50, &50, &3c, &3c, &3c, &3c, &3c, &50
.table_01c
    equb   2,   3,   4,   5,   7,   8, &0a, &0f, &10, &11, &1a, &1b, &1c, &1d, &1e, &1f
    equb &20, &21, &27, &28, &29, &2a, &2b, &2c, &2d, &2e, &2f, &30, &31, &51, &52, &53
    equb &54, &56, &57, &59, &5a, &5b, &5c, &5d, &5e, &5f, &60, &61, &62, &63

.object_handler_table
    ;; for background objects / explosions
    equb   <(handle_background_invisible_switch - handlers_start)
    equb      <(handle_background_teleport_beam - handlers_start)
    equb   <(handle_background_object_from_data - handlers_start)
    equb               <(handle_background_door - handlers_start)
    equb         <(handle_background_stone_door - handlers_start)
    equb   <(handle_background_object_from_type - handlers_start)
    equb   <(handle_background_object_from_type - handlers_start)
    equb   <(handle_background_object_from_type - handlers_start)
    equb             <(handle_background_switch - handlers_start)
    equb                       <(handlers_start - handlers_start)
    equb                       <(handlers_start - handlers_start)
    equb  <(handle_background_object_fixed_wind - handlers_start)
    equb    <(handle_background_engine_thruster - handlers_start)
    equb       <(handle_background_object_water - handlers_start)
    equb <(handle_background_object_random_wind - handlers_start)
    equb          <(handle_background_mushrooms - handlers_start)
    equb             <(handle_explosion_type_00 - handlers_start)
    equb             <(handle_explosion_type_40 - handlers_start)
    equb             <(handle_explosion_type_80 - handlers_start)
    equb             <(handle_explosion_type_c0 - handlers_start)
    equb                 <(handle_player_object - handlers_start)
    equb                <(handle_chatter_active - handlers_start)
    equb                   <(handle_crew_member - handlers_start)
    equb                        <(handle_fluffy - handlers_start)
    equb                          <(handle_nest - handlers_start)
    equb                          <(handle_nest - handlers_start)
    equb                   <(handle_frogman_red - handlers_start)
    equb                 <(handle_frogman_green - handlers_start)
    equb                  <(handle_frogman_cyan - handlers_start)
    equb                     <(handle_red_slime - handlers_start)
    equb                   <(handle_green_slime - handlers_start)
    equb                   <(handle_yellow_ball - handlers_start)
    equb                        <(handle_sucker - handlers_start)
    equb                 <(handle_sucker_deadly - handlers_start)
    equb                      <(handle_big_fish - handlers_start)
    equb                          <(handle_worm - handlers_start)
    equb                  <(handle_nest_dweller - handlers_start)
    equb                  <(handle_nest_dweller - handlers_start)
    equb                <(handle_active_grenade - handlers_start)
    equb                   <(handle_icer_bullet - handlers_start)
    equb                 <(handle_tracer_bullet - handlers_start)
    equb                    <(handle_cannonball - handlers_start)
    equb               <(handle_death_ball_blue - handlers_start)
    equb                    <(handle_red_bullet - handlers_start)
    equb                 <(handle_pistol_bullet - handlers_start)
    equb                   <(handle_plasma_ball - handlers_start)
    equb                    <(handle_hover_ball - handlers_start)
    equb          <(handle_hover_ball_invisible - handlers_start)
    equb                         <(handle_robot - handlers_start)
    equb                         <(handle_robot - handlers_start)
    equb                    <(handle_robot_blue - handlers_start)
    equb                        <(handle_turret - handlers_start)
    equb                        <(handle_turret - handlers_start)
    equb                <(handle_hovering_robot - handlers_start)
    equb                  <(handle_clawed_robot - handlers_start)
    equb                  <(handle_clawed_robot - handlers_start)
    equb                  <(handle_clawed_robot - handlers_start)
    equb                  <(handle_clawed_robot - handlers_start)
    equb                         <(handle_triax - handlers_start)
    equb                        <(handle_maggot - handlers_start)
    equb                      <(handle_gargoyle - handlers_start)
    equb                           <(handle_imp - handlers_start)
    equb                           <(handle_imp - handlers_start)
    equb                           <(handle_imp - handlers_start)
    equb                           <(handle_imp - handlers_start)
    equb                           <(handle_imp - handlers_start)
    equb                          <(handle_bird - handlers_start)
    equb                          <(handle_bird - handlers_start)
    equb                      <(handle_bird_red - handlers_start)
    equb                <(handle_bird_invisible - handlers_start)
    equb                <(unused_object_handler - handlers_start)
    equb                 <(handle_mushroom_ball - handlers_start)
    equb                 <(handle_mushroom_ball - handlers_start)
    equb                   <(handle_engine_fire - handlers_start)
    equb                      <(handle_red_drop - handlers_start)
    equb                      <(handle_fireball - handlers_start)
    equb              <(handle_chatter_inactive - handlers_start)
    equb               <(handle_moving_fireball - handlers_start)
    equb                    <(handle_giant_wall - handlers_start)
    equb               <(handle_engine_thruster - handlers_start)
    equb                          <(handle_door - handlers_start)
    equb                          <(handle_door - handlers_start)
    equb                          <(handle_door - handlers_start)
    equb                          <(handle_door - handlers_start)
    equb                          <(handle_bush - handlers_start)
    equb                 <(handle_teleport_beam - handlers_start)
    equb                        <(handle_switch - handlers_start)
    equb                                <(L3F52 - handlers_start)
    equb                     <(handle_explosion - handlers_start)
    equb                                <(L3F52 - handlers_start)
    equb                        <(handle_cannon - handlers_start)
    equb             <(handle_mysterious_weapon - handlers_start)
    equb                <(handle_maggot_machine - handlers_start)
    equb                   <(handle_placeholder - handlers_start)
    equb                    <(handle_destinator - handlers_start)
    equb                <(handle_energy_capsule - handlers_start)
    equb                         <(handle_flask - handlers_start)
    equb                    <(handle_flask_full - handlers_start)
    equb                <(handle_remote_control - handlers_start)
    equb                <(handle_remote_control - handlers_start)
    equb              <(handle_grenade_inactive - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb              <(handle_coronium_boulder - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb              <(handle_coronium_crystal - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                   <(handle_collectable - handlers_start)
    equb                                <(L3F52 - handlers_start)

.object_handler_table_h
    ;;  & &c0 = how the object explodes
    ;; for background objects / explosions
    equb                         >(handle_background_invisible_switch - handlers_start) OR (1<<5)
    equb        >(handle_background_teleport_beam - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb               >(handle_background_object_from_data - handlers_start) OR (1<<7) OR (1<<4)
    equb       >(handle_background_door - handlers_start) OR (1<<7) OR (1<<6) OR (1<<5) OR (1<<4)
    equb >(handle_background_stone_door - handlers_start) OR (1<<7) OR (1<<6) OR (1<<5) OR (1<<4)
    equb     >(handle_background_object_from_type - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb     >(handle_background_object_from_type - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb     >(handle_background_object_from_type - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb               >(handle_background_switch - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb                         >(handlers_start - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb                         >(handlers_start - handlers_start) OR (1<<7) OR (1<<5) OR (1<<4)
    equb              >(handle_background_object_fixed_wind - handlers_start) OR (1<<5) OR (1<<4)
    equb                >(handle_background_engine_thruster - handlers_start) OR (1<<7) OR (1<<4)
    equb                   >(handle_background_object_water - handlers_start) OR (1<<5) OR (1<<4)
    equb             >(handle_background_object_random_wind - handlers_start) OR (1<<5) OR (1<<4)
    equb                      >(handle_background_mushrooms - handlers_start) OR (1<<5) OR (1<<4)
    equb                                             >(handle_explosion_type_00 - handlers_start)
    equb                                             >(handle_explosion_type_40 - handlers_start)
    equb                                             >(handle_explosion_type_80 - handlers_start)
    equb                                             >(handle_explosion_type_c0 - handlers_start)
    equb                                                 >(handle_player_object - handlers_start)
    equb                                                >(handle_chatter_active - handlers_start)
    equb                                         >(handle_crew_member - handlers_start) OR (1<<7)
    equb                                              >(handle_fluffy - handlers_start) OR (1<<7)
    equb                                      >(handle_nest - handlers_start) OR (1<<7) OR (1<<6)
    equb                                      >(handle_nest - handlers_start) OR (1<<7) OR (1<<6)
    equb                                         >(handle_frogman_red - handlers_start) OR (1<<7)
    equb                                       >(handle_frogman_green - handlers_start) OR (1<<7)
    equb                                        >(handle_frogman_cyan - handlers_start) OR (1<<7)
    equb                                                     >(handle_red_slime - handlers_start)
    equb                                                   >(handle_green_slime - handlers_start)
    equb                                                   >(handle_yellow_ball - handlers_start)
    equb                                                        >(handle_sucker - handlers_start)
    equb                                                 >(handle_sucker_deadly - handlers_start)
    equb                                            >(handle_big_fish - handlers_start) OR (1<<7)
    equb                                                >(handle_worm - handlers_start) OR (1<<7)
    equb                              >(handle_nest_dweller - handlers_start) OR (1<<7) OR (1<<6)
    equb                                        >(handle_nest_dweller - handlers_start) OR (1<<7)
    equb                            >(handle_active_grenade - handlers_start) OR (1<<7) OR (1<<6)
    equb                               >(handle_icer_bullet - handlers_start) OR (1<<7) OR (1<<6)
    equb                             >(handle_tracer_bullet - handlers_start) OR (1<<7) OR (1<<6)
    equb                                >(handle_cannonball - handlers_start) OR (1<<7) OR (1<<6)
    equb                           >(handle_death_ball_blue - handlers_start) OR (1<<7) OR (1<<6)
    equb                                >(handle_red_bullet - handlers_start) OR (1<<7) OR (1<<6)
    equb                             >(handle_pistol_bullet - handlers_start) OR (1<<7) OR (1<<6)
    equb                                         >(handle_plasma_ball - handlers_start) OR (1<<7)
    equb                                          >(handle_hover_ball - handlers_start) OR (1<<6)
    equb                                >(handle_hover_ball_invisible - handlers_start) OR (1<<6)
    equb                                               >(handle_robot - handlers_start) OR (1<<6)
    equb                                               >(handle_robot - handlers_start) OR (1<<6)
    equb                                          >(handle_robot_blue - handlers_start) OR (1<<6)
    equb                                              >(handle_turret - handlers_start) OR (1<<6)
    equb                                              >(handle_turret - handlers_start) OR (1<<6)
    equb                                      >(handle_hovering_robot - handlers_start) OR (1<<6)
    equb                                        >(handle_clawed_robot - handlers_start) OR (1<<6)
    equb                                        >(handle_clawed_robot - handlers_start) OR (1<<6)
    equb                                        >(handle_clawed_robot - handlers_start) OR (1<<6)
    equb                                        >(handle_clawed_robot - handlers_start) OR (1<<6)
    equb                                                         >(handle_triax - handlers_start)
    equb                                              >(handle_maggot - handlers_start) OR (1<<7)
    equb                                  >(handle_gargoyle - handlers_start) OR (1<<7) OR (1<<6)
    equb                                                 >(handle_imp - handlers_start) OR (1<<7)
    equb                                                 >(handle_imp - handlers_start) OR (1<<7)
    equb                                                 >(handle_imp - handlers_start) OR (1<<7)
    equb                                                 >(handle_imp - handlers_start) OR (1<<7)
    equb                                                 >(handle_imp - handlers_start) OR (1<<7)
    equb                                                >(handle_bird - handlers_start) OR (1<<7)
    equb                                                >(handle_bird - handlers_start) OR (1<<7)
    equb                                            >(handle_bird_red - handlers_start) OR (1<<7)
    equb                                      >(handle_bird_invisible - handlers_start) OR (1<<7)
    equb                                                >(unused_object_handler - handlers_start)
    equb                                                 >(handle_mushroom_ball - handlers_start)
    equb                                                 >(handle_mushroom_ball - handlers_start)
    equb                                                   >(handle_engine_fire - handlers_start)
    equb                                  >(handle_red_drop - handlers_start) OR (1<<7) OR (1<<6)
    equb                                                      >(handle_fireball - handlers_start)
    equb                                              >(handle_chatter_inactive - handlers_start)
    equb                                               >(handle_moving_fireball - handlers_start)
    equb                                                    >(handle_giant_wall - handlers_start)
    equb                                               >(handle_engine_thruster - handlers_start)
    equb                                      >(handle_door - handlers_start) OR (1<<7) OR (1<<6)
    equb                                      >(handle_door - handlers_start) OR (1<<7) OR (1<<6)
    equb                                      >(handle_door - handlers_start) OR (1<<7) OR (1<<6)
    equb                                      >(handle_door - handlers_start) OR (1<<7) OR (1<<6)
    equb                                                          >(handle_bush - handlers_start)
    equb                                                 >(handle_teleport_beam - handlers_start)
    equb                                    >(handle_switch - handlers_start) OR (1<<7) OR (1<<6)
    equb                                                                >(L3F52 - handlers_start)
    equb                                                     >(handle_explosion - handlers_start)
    equb                                                                >(L3F52 - handlers_start)
    equb                                                        >(handle_cannon - handlers_start)
    equb                                   >(handle_mysterious_weapon - handlers_start) OR (1<<6)
    equb                                                >(handle_maggot_machine - handlers_start)
    equb                                                   >(handle_placeholder - handlers_start)
    equb                                                    >(handle_destinator - handlers_start)
    equb                                      >(handle_energy_capsule - handlers_start) OR (1<<7)
    equb                                                         >(handle_flask - handlers_start)
    equb                                                    >(handle_flask_full - handlers_start)
    equb                                                >(handle_remote_control - handlers_start)
    equb                                                >(handle_remote_control - handlers_start)
    equb                          >(handle_grenade_inactive - handlers_start) OR (1<<7) OR (1<<6)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                              >(handle_coronium_boulder - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                              >(handle_coronium_crystal - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                   >(handle_collectable - handlers_start)
    equb                                                                >(L3F52 - handlers_start)

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
    ;;     0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &c6, &ce, &c6, &c6, &c6, &bb, &c6, &18, &2d, &70, &6a, &c6, &23, &39, &c6, &62; 0
    equb &c0, &8e, &39, &44, &47, &26, &48, &49, &df, &c6, &99, &9a, &25, &2b, &39, &3b; 1
    equb &3c, &55, &8e, &43, &34, &35, &27, &28, &29, &2a, &42, &bf, &40, &3d, &38, &36; 2
    equb &37, &3e, &33, &31, &2f, &30, &2c, &24, &32, &41, &45, &3a, &6a, &23, &60, &cc; 3

.background_y_offset_lookup
    ;;     0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb   0,   0,   0,   0,   0,   0,   0, &d0, &c0, &b0, &c0,   0,   0,   0,   0, &c0; 0
    equb &b0, &a0,   0,   0,   0,   0, &80, &c0, &70,   0, &b0, &80, &90,   0,   0, &80; 1
    equb &c0,   0, &a0,   0,   0, &80,   0, &40, &80, &c0,   0, &f0, &b0,   0,   0,   0; 2
    equb &80, &70,   0, &c0, &c0,   0, &80,   0, &80,   0, &90, &30, &c0,   0, &a0,   0; 3

.background_palette_lookup
    ;;     0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &80,   2, &91, &91, &91,   0, &91, &a8, &dc, &b8, &8c, &80, &c9, &4a, &80,   6; 0
    equb &88,   5,   4,   0,   2,   2,   2,   2,   2, &91,   3,   3,   2,   2,   0,   0; 1
    equb   0, &bc, &b1,   0,   0,   0,   1,   1,   1,   1,   0,   4,   4,   4,   4,   4; 2
    equb   4,   4,   2,   1,   1,   1,   2,   2,   2,   0,   0,   0, &82,   2, &64, &ee; 3

.background_objects_range_minus_one
    equb 0

.background_objects_range
    equb &1d, &39, &57, &7a, &9e, &bc, &d8, &f6, &fe

.background_objects_data_offset
    ;;    +1   -2   -5   -6   -8  -11  -11  -13  -13
    equb   1, &fe, &fb, &fa, &f8, &f5, &f5, &f3, &f3

.background_objects_type_offset
    equb   0, &f5, &e9, &de, &ce, &be, &b1, &a1, &98

.background_objects_x_lookup
    ;;     0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f   10   11   12   13   14   15   16   17   18   19   1a   1b   1c
    equb &ff, &ff, &b0, &ec, &77, &64, &9a, &af, &da, &c6, &36, &9f, &2e, &a9, &9c, &83, &88, &5f, &57, &bf, &9d, &4d, &45, &81, &b3, &3f, &cb, &40, &4c 
    ;;    1d   1e   1f   20   21   22   23   24   25   26   27   28   29   2a   2b   2c   2d   2e   2f   30   31   32   33   34   35   36   37   38
    equb &ca, &2f, &a7, &56, &34, &e3, &3b, &e4, &80, &e0, &64, &37, &47, &9f, &9c, &aa, &9b, &9a, &5e, &c7, &8a, &60, &9d, &a2, &b2, &98, &a9, &db
    ;;    39   3a   3b   3c   3d   3e   3f   40   41   42   43   44   45   46   47   48   49   4a   4b   4c   4d   4e   4f   50   51   52   53   54   55   56
    equb &28, &29, &3c, &98, &63, &cb, &61, &a3, &ce, &e9, &80, &2e, &4f, &79, &87, &b6, &97, &2d, &d6, &5c, &a0, &74, &6a, &a1, &9f, &89, &85, &6b, &ae, &65
    ;;    57   58   59   5a   5b   5c   5d   5e   5f   60   61   62   63   64   65   66   67   68   69   6a   6b   6c   6d   6e   6f   70   71   72   73   74   75   76   77   78   79
    equb &e2, &ed, &80, &cd, &a8, &2b, &ab, &9d, &62, &e5, &70, &ec, &83, &c1, &c6, &67, &eb, &2d, &98, &aa, &cc, &a5, &9e, &a2, &d7, &e6, &e7, &94, &7c, &e3, &45, &9b, &9f, &c2, &71
    ;;    7a   7b   7c   7d   7e   7f   80   81   82   83   84   85   86   87   88   89   8a   8b   8c   8d   8e   8f   90   91   92   93   94   95   96   97   98   99   9a   9b   9c   9d
    equb &67, &4f, &cf, &d2, &e2, &7a, &62, &da, &76, &b2, &66, &d7, &83, &84, &80, &87, &9b, &50, &ae, &64, &a3, &63, &b8, &7f, &82, &e0, &9c, &61, &9d, &29, &46, &9f, &9a, &74, &75, &77
    ;;    9e   9f   a0   a1   a2   a3   a4   a5   a6   a7   a8   a9   aa   ab   ac   ad   ae   af   b0   b1   b2   b3   b4   b5   b6   b7   b8   b9   ba   bb
    equb &b2, &e4, &62, &63, &82, &61, &d4, &d3, &77, &2e, &64, &86, &a5, &a0, &d1, &b4, &7f, &a3, &9f, &99, &80, &67, &da, &89, &95, &8b, &ab, &c4, &9d, &aa
    ;;    bc   bd   be   bf   c0   c1   c2   c3   c4   c5   c6   c7   c8   c9   ca   cb   cc   cd   ce   cf   d0   d1   d2   d3   d4   d5   d6   d7
    equb &bb, &47, &8a, &a7, &61, &9e, &2e, &d6, &7e, &da, &aa, &ab, &45, &67, &d4, &29, &b8, &6b, &69, &9d, &94, &63, &b4, &a1, &9f, &a0, &57, &e1
    ;;    d8   d9   da   db   dc   dd   de   df   e0   e1   e2   e3   e4   e5   e6   e7   e8   e9   ea   eb   ec   ed   ee   ef   f0   f1   f2   f3   f4   f5
    equb &7f, &a6, &b4, &53, &61, &d4, &82, &e3, &75, &c3, &84, &9e, &c6, &64, &a2, &28, &29, &9d, &83, &a8, &80, &aa, &d5, &a0, &9f, &d6, &62, &69, &2c, &a5
    ;;    f6   f7   f8   f9   fa   fb   fc   fd 
    equb &b8, &b9, &d9, &59, &79, &39, &48, &e8
    ;;    fe
    equb &a0

.background_objects_handler_lookup
    equb &89, &89, &89, &89, &89, &8a, &46, &c6,   6,   6, &46,   5,   5,   0, &c3,   4
    equb &83, &84, &84, &83, &88, &48,   2,   2, &42,   2, &7b, &22, &1e,   6,   6, &c6
    equb   6, &46, &46, &85, &85, &87, &89, &89, &c7, &0a, &8c,   3, &84, &83, &43, &84
    equb &84,   2,   1, &41,   1,   1, &2e, &1e, &3b, &46, &46,   6, &c6,   6,   6,   6
    equb &46,   6,   9, &c9, &89, &ca, &8a, &8a, &0a, &4a, &8a,   4, &44, &41,   1, &c8
    equb &48, &cc, &82,   2,   2,   2, &1e, &89,   9, &0a, &4a, &ca, &4a, &86, &46, &46
    equb &46, &86, &45, &47,   0,   0,   0,   0, &84, &c3, &44, &43, &43, &43, &44, &84
    equb &44,   4,   1,   8,   8,   2,   2, &82, &1e, &2d, &46, &46, &45, &46, &c6, &89
    equb &c9, &49, &89, &ca, &ca, &8a, &8a, &8a, &0a,   0,   0, &c4, &43,   4, &43, &84
    equb &44,   4, &44, &84, &41,   1,   1,   1, &c8, &42, &82, &3b, &11, &3b, &89, &c9
    equb &ca, &8a, &c6,   6, &c6, &c6,   6,   6, &85, &47, &4a, &ca, &8a,   0,   0, &44
    equb &43, &c3, &44, &44,   4, &41, &c8, &88, &c8, &c8,   2, &8c, &49, &89, &0a, &0a
    equb &8a, &c6,   6,   6, &47, &87, &cc, &41,   1,   8,   8,   8,   8, &c4, &84, &43
    equb &43, &84,   4, &83, &82, &82, &0d, &0d, &46,   6,   6,   6,   6, &45, &45, &45
    equb   6,   7, &89,   9, &8a, &4a, &4a, &ca, &ca, &4a,   0,   0,   0, &48,   8, &82
    equb &82, &82,   2, &c4, &c4, &0b, &0b, &0b, &d1, &91, &d1, &d1, &91, &91,   0

.table_02
    ;; background_strip_cache_orientation???
    ;; background_strip_cache_sprite???
    equb &2e, &2e, &2e, &2e, &2e, &2e, &2e

.game_time
    equb 0, 0, 0, 0

.player_deaths
    equb 0, 0, 0

.keys_collected
    equb 0; cyan/yellow/green key
    equb 0; red/yellow/green key
    equb 0; green/yellow/red key
    equb 0; yellow/white/red key
    equb 0; (unused)
    equb 0; red/magenta/red key
    equb 0; blue/cyan/green key
    equb 0; (unused)

.booster_collected
    equb 0

.pistol
    equb 0

.icer
    equb 0
    equb 0; discharge_device
    equb 0; plasma_gun

.protection_suit_collected
    equb 0

.fire_immunity_collected
    equb 0

.mushroom_pill_collected
    equb 0

.whistle1_collected
    equb 0

.whistle2_collected
    equb 0

.radiation_pill_collected
    equb 0

.door_timer
    equb 0

.red_mushroom_daze
    equb 0

.blue_mushroom_daze
    equb 0

.chatter_energy_level
    equb 0

.explosion_timer
    equb 0

.endgame_value
    equb 0

.earthquake_triggered
    equb 0
    equb &ff                           ; (unused)

.teleport_last
    equb 0

.teleports_used
    equb 0

.teleports_x
    equb &32, &8e, &d2, &63

.teleport_fallback_x
    equb &99

.teleports_y
    equb &98, &c0, &c0, &c7

.teleport_fallback_y
    equb &3c

.timers_and_eor
    equb 0

.water_level_low_by_x_range
    equb 0, 0, 0, 0

.water_level_by_x_range
    equb &ce, &df, &c1, &c1

.desired_water_level_by_x_range
    equb &ce, &df, &c1, &c1

.imp_gift_counts
    equb   4, &0a,   1,   1, &0a

.clawed_robot_availability
    equb &80, &80, &80, &80

.clawed_robot_energy_when_last_used
    equb 0, 0, 0, 0

.pockets_used
    equb 0
    equb &50, &50, &50, &50, &50; contents_of_pockets

.current_weapon
    equb 0

.weapon_energy
   ;; 0 = jetpack, 1 = pistol, 2 = icer, 3 = discharge, 4 = plasma, 5 = suit
   ;;   0  1  2  3  4  5 
   equb 0, 0, 0, 0, 0, 0

.weapon_energy_h
    equb &30, &10, &10,   1,   8, &10

.energy_per_shot
    equb   1,   6, &10, &ff, &32,   0

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
    equb   0, &26, &60, &cc,   0,   0,   0,   0,   0,   0,   0, &d0, &c0, &b0, &c0,   0

.object_stack_sprite
    equb   4,   4,   0, &c0, &b0, &a0,   0,   0,   0,   0, &80, &c0, &70,   0, &b0, &80

.object_stack_x_low
    equb &c0, &64,   0, &80, &c0,   0, &a0,   0,   0, &80,   0, &40, &80, &c0,   0, &f0
    equb &b0; seventeenth slot = target

.object_stack_x
    equb &9b, &99,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
    equb   0, &65; eighteenth slot = waterfall (&65, &dc), for sound

.object_stack_y_low
    equb &80, &20,   2, &91, &91, &91,   0, &91, &a8, &dc, &b8, &8c, &80, &c9, &4a, &80
    equb 6; seventeenth slot = target

.object_stack_y
    equb &3b, &3b,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
    equb   0, &dc; eighteenth slot = waterfall (&65, &dc), for sound

.object_stack_flags
    ;;  80 set = horizontal invert (facing left)
    ;;  40 set = vertical invert (upside down)
    ;;  20 set = remove from display
    ;;  10 set = teleporting
    ;;  08 set = damaged
    ;;  02 set = collision detected
    ;;  01 set at load positon?
    equb &81, &11,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1,   1

.object_stack_palette
    ;;  10 set = damaged
    equb   2, &39,   1,   1,   2,   2,   2,   0,   0,   0, &82,   2, &64, &ee, &ca, &34

.object_stack_vel_x
    equb   0,   0, &b0, &de, &a1, &d9, &3c, &b1, &9c, &f0, &d4, &75,   1, &99, &8e, &c0

.object_stack_vel_y
    equb   0, &10, &22, &59, &34, &83, &82, &80, &76, &68, &52, &20, &55, &26, &67, &0d

.object_stack_target
    equb &35,   0, &6f, &d0, &0c, &3d, &64, &69, &f6, &31, &48, &18, &49, &f7, &50, &97

.object_stack_tx
    equb &47, &99,   0, &16, &47,   9, &34, &83, &82, &80, &76, &68, &52, &20, &31, &42

.object_stack_energy
    equb &ff, &c8, &6b, &70, &43, &34, &43, &3c, &75, &72, &15, &3a, &c4, &64, &5e, &ae

.object_stack_ty
    equb &68, &3b, &32, &79, &74, &64, &44,   3, &22, &59, &34, &83, &82, &80, &0a, &f1

.object_stack_supporting
    equb &9a, &f4, &2c, &f8, &3a, &c1, &36, &d0, &9b, &75, &85, &88, &79, &85, &38, &c9

.object_stack_timer
    equb &87, &0e, &67, &50, &16, &47,   9, &34, &83, &82, &80, &76, &68, &52, &20, &55

.object_stack_data_pointer
    equb   0, &cf, &e8, &83, &7d, &4b, &81, &a6, &8e, &9c, &5b, &8a, &9e, &54, &86, &40

.object_stack_extra
    equb &f8, &ef, &b9, &fc, &78, &80, &76, &68, &52, &20, &55, &26, &67, &d0, &16, &28

;; ##############################################################################
;; 
;;    Background objects
;;    ==================
;;    no    x            handler      data         type            x, y    handler: object
;;  0:&00 : &1a22 = &ff  &1b21 = &89  &1daf = &7c  &1e9a = &0f  (&ff, &??) &09: worm (x 31) (unused?)
;;    &01 : &1a23 = &ff  &1b22 = &89  &1db0 = &60  &1e9b = &27  (&ff, &??) &09: maggot (x 24) (unused?)
;;    &02 : &1a24 = &b0  &1b23 = &89  &1db1 = &04  &1e9c = &2e  (&b0, &??) &09: green/yellow bird
;;    &03 : &1a25 = &ec  &1b24 = &89  &1db2 = &88  &1e9d = &07  (&ec, &??) &09: green frogman (x 2)
;;    &04 : &1a26 = &77  &1b25 = &89  &1db3 = &88  &1e9e = &2f  (&77, &??) &09: white/yellow bird (x 2)
;;    &05 : &1a27 = &64  &1b26 = &8a  &1db4 = &a0  &1e9f = &2d  (&64, &??) &0a: red/cyan imp (x 8)
;;    &06 : &1a28 = &9a  &1b27 = &46  &1db5 = &a6  &1ea0 = &1f  (&9a, &??) &06: green/white turret
;;    &07 : &1a29 = &af  &1b28 = &c6  &1db6 = &ae  &1ea1 = &1f  (&af, &??) &06: green/white turret
;;    &08 : &1a2a = &da  &1b29 = &06  &1db7 = &83  &1ea2 = &0d  (&da, &??) &06: deadly sucker
;;    &09 : &1a2b = &c6  &1b2a = &06  &1db8 = &86  &1ea3 = &0d  (&c6, &??) &06: deadly sucker
;;    &0a : &1a2c = &36  &1b2b = &46  &1db9 = &82  &1ea4 = &0d  (&36, &??) &06: deadly sucker
;;    &0b : &1a2d = &9f  &1b2c = &05  &1dba = &80  &1ea5 = &0c  (&9f, &??) &05: sucker
;;    &0c : &1a2e = &2e  &1b2d = &05  &1dbb = &80  &1ea6 = &60  (&2e, &??) &05: mushroom immunity pull
;;    &0d : &1a2f = &a9  &1b2e = &00  &1dbc = &ad  &1ea7 = &2c  (&a9, &??) &00: invisible switch
;;    &0e : &1a30 = &9c  &1b2f = &c3  &1dbd = &81  &1ea8 = &00  (&9c, &??) &03: door
;;    &0f : &1a31 = &83  &1b30 = &04  &1dbe = &f7  &1ea9 = &0d  (&83, &??) &04: stone door
;;    &10 : &1a32 = &88  &1b31 = &83  &1dbf = &a1  &1eaa = &0d  (&88, &??) &03: door
;;    &11 : &1a33 = &5f  &1b32 = &84  &1dc0 = &f1  &1eab = &1f  (&5f, &??) &04: stone door
;;    &12 : &1a34 = &57  &1b33 = &84  &1dc1 = &f7  &1eac = &0d  (&57, &??) &04: stone door
;;    &13 : &1a35 = &bf  &1b34 = &83  &1dc2 = &81  &1ead = &5c  (&bf, &??) &03: door
;;    &14 : &1a36 = &9d  &1b35 = &88  &1dc3 = &8a  &1eae = &0d  (&9d, &??) &08: switch
;;    &15 : &1a37 = &4d  &1b36 = &48  &1dc4 = &ac  &1eaf = &20  (&4d, &??) &08: switch
;;    &16 : &1a38 = &45  &1b37 = &02  &1dc5 = &d2  &1eb0 = &05  (&45, &??) &02: red/yellow/green key
;;    &17 : &1a39 = &81  &1b38 = &02  &1dc6 = &df  &1eb1 = &04  (&81, &??) &02: fire immunity device
;;    &18 : &1a3a = &b3  &1b39 = &42  &1dc7 = &d4  &1eb2 = &06  (&b3, &??) &02: yellow/white/red key
;;  1:&19 : &1a3b = &3f  &1b3a = &02  &1dc8 = &a3  &1eb3 = &31  (&3f, &??) &02: red/yellow/green key (unused)
;;    &1a : &1a3c = &cb  &1b3b = &7b  &1dc9 = &84  &1eb4 = &05  (&cb, &??) &3b: brick wall, 3/4 filled bottom (unused)
;;    &1b : &1a3d = &40  &1b3c = &22  &1dca = &85  &1eb5 = &2a  (&40, &??) &22: leaf (unused)
;;    &1c : &1a3e = &4c  &1b3d = &1e  &1dcb = &ae  &1eb6 = &09  (&4c, &??) &1e: brick wall
;;    &1d : &1a3f = &ca  &1b3e = &06  &1dcc = &80  &1eb7 = &0d  (&ca, &??) &06: deadly sucker
;;    &1e : &1a40 = &2f  &1b3f = &06  &1dcd = &80  &1eb8 = &0d  (&2f, &??) &06: deadly sucker
;;    &1f : &1a41 = &a7  &1b40 = &c6  &1dce = &88  &1eb9 = &1f  (&a7, &??) &06: green/white turret
;;    &20 : &1a42 = &56  &1b41 = &06  &1dcf = &ac  &1eba = &20  (&56, &??) &06: deadly sucker
;;    &21 : &1a43 = &34  &1b42 = &46  &1dd0 = &c4  &1ebb = &55  (&34, &??) &06: discharge device
;;    &22 : &1a44 = &e3  &1b43 = &46  &1dd1 = &c0  &1ebc = &55  (&e3, &??) &06: deadly sucker
;;    &23 : &1a45 = &3b  &1b44 = &85  &1dd2 = &04  &1ebd = &0d  (&3b, &??) &05: cyan/red turret
;;    &24 : &1a46 = &e4  &1b45 = &85  &1dd3 = &a8  &1ebe = &63  (&e4, &??) &05: big nest
;;    &25 : &1a47 = &80  &1b46 = &87  &1dd4 = &c4  &1ebf = &0f  (&80, &??) &07: small nest
;;    &26 : &1a48 = &e0  &1b47 = &89  &1dd5 = &bc  &1ec0 = &2e  (&e0, &??) &09: red frogman
;;    &27 : &1a49 = &64  &1b48 = &89  &1dd6 = &fd  &1ec1 = &0a  (&64, &??) &09: invisible bird (x 10)
;;    &28 : &1a4a = &37  &1b49 = &c7  &1dd7 = &81  &1ec2 = &1b  (&37, &??) &07: big nest
;;    &29 : &1a4b = &47  &1b4a = &0a  &1dd8 = &c1  &1ec3 = &37  (&47, &??) &0a: red/yellow imp (x 15)
;;    &2a : &1a4c = &9f  &1b4b = &8c  &1dd9 = &d1  &1ec4 = &29  (&9f, &??) &0c: engine thruster
;;    &2b : &1a4d = &9c  &1b4c = &03  &1dda = &91  &1ec5 = &1a  (&9c, &??) &03: door
;;    &2c : &1a4e = &aa  &1b4d = &84  &1ddb = &f1  &1ec6 = &1a  (&aa, &??) &04: stone door
;;    &2d : &1a4f = &9b  &1b4e = &83  &1ddc = &f1  &1ec7 = &37  (&9b, &??) &03: door
;;    &2e : &1a50 = &9a  &1b4f = &43  &1ddd = &da  &1ec8 = &37  (&9a, &??) &03: door
;;    &2f : &1a51 = &5e  &1b50 = &84  &1dde = &f7  &1ec9 = &0a  (&5e, &??) &04: stone door
;;    &30 : &1a52 = &c7  &1b51 = &84  &1ddf = &f3  &1eca = &37  (&c7, &??) &04: stone door
;;    &31 : &1a53 = &8a  &1b52 = &02  &1de0 = &d8  &1ecb = &4b  (&8a, &??) &02: pistol
;;    &32 : &1a54 = &60  &1b53 = &01  &1de1 = &88  &1ecc = &4b  (&60, &??) &01: teleport beam
;;    &33 : &1a55 = &9d  &1b54 = &41  &1de2 = &80  &1ecd = &2d  (&9d, &??) &01: teleport beam
;;    &34 : &1a56 = &a2  &1b55 = &01  &1de3 = &83  &1ece = &1f  (&a2, &??) &01: teleport beam
;;    &35 : &1a57 = &b2  &1b56 = &01  &1de4 = &83  &1ecf = &20  (&b2, &??) &01: teleport beam
;;    &36 : &1a58 = &98  &1b57 = &2e  &1de5 = &b0  &1ed0 = &0d  (&98, &??) &2e: stone wall \
;;    &37 : &1a59 = &a9  &1b58 = &1e  &1de6 = &aa  &1ed1 = &0d  (&a9, &??) &1e: brick wall
;;    &38 : &1a5a = &db  &1b59 = &3b  &1de7 = &80  &1ed2 = &28  (&db, &??) &3b: brick wall, top quarter empty
;;  2:&39 : &1a5b = &28  &1b5a = &46  &1de8 = &80  &1ed3 = &55  (&28, &??) &06: red slime
;;    &3a : &1a5c = &29  &1b5b = &46  &1de9 = &87  &1ed4 = &05  (&29, &??) &06: deadly sucker
;;    &3b : &1a5d = &3c  &1b5c = &06  &1dea = &80  &1ed5 = &80  (&3c, &??) &06: deadly sucker
;;    &3c : &1a5e = &98  &1b5d = &c6  &1deb = &30  &1ed6 = &00  (&98, &??) &06: green/white turret
;;    &3d : &1a5f = &63  &1b5e = &06  &1dec = &08  &1ed7 = &80  (&63, &??) &06: cyan/red turret
;;    &3e : &1a60 = &cb  &1b5f = &06  &1ded = &10  &1ed8 = &80  (&cb, &??) &06: coronium boulder
;;    &3f : &1a61 = &61  &1b60 = &06  &1dee = &7c  &1ed9 = &20  (&61, &??) &06: coronium boulder
;;    &40 : &1a62 = &a3  &1b61 = &46  &1def = &04  &1eda = &28  (&a3, &??) &06: deadly sucker
;;    &41 : &1a63 = &ce  &1b62 = &06  &1df0 = &10  &1edb = &0d  (&ce, &??) &06: radiation immunity pull
;;    &42 : &1a64 = &e9  &1b63 = &09  &1df1 = &a8  &1edc = &0d  (&e9, &??) &09: worm (x 12)
;;    &43 : &1a65 = &80  &1b64 = &c9  &1df2 = &90  &1edd = &28  (&80, &??) &09: green/yellow bird (x 2)
;;    &44 : &1a66 = &2e  &1b65 = &89  &1df3 = &04  &1ede = &27  (&2e, &??) &09: green slime (x 4)
;;    &45 : &1a67 = &4f  &1b66 = &ca  &1df4 = &c1  &1edf = &31  (&4f, &??) &0a: invisible hover ball (x 31)
;;    &46 : &1a68 = &79  &1b67 = &8a  &1df5 = &f1  &1ee0 = &0e  (&79, &??) &0a: fireball
;;    &47 : &1a69 = &87  &1b68 = &8a  &1df6 = &e1  &1ee1 = &08  (&87, &??) &0a: red/magenta imp (x 4)
;;    &48 : &1a6a = &b6  &1b69 = &0a  &1df7 = &95  &1ee2 = &11  (&b6, &??) &0a: hover ball (x 10)
;;    &49 : &1a6b = &97  &1b6a = &4a  &1df8 = &bc  &1ee3 = &39  (&97, &??) &0a: hover ball (x 4)
;;    &4a : &1a6c = &2d  &1b6b = &8a  &1df9 = &b4  &1ee4 = &37  (&2d, &??) &0a: fireball
;;    &4b : &1a6d = &d6  &1b6c = &04  &1dfa = &fd  &1ee5 = &37  (&d6, &??) &04: stone door
;;    &4c : &1a6e = &5c  &1b6d = &44  &1dfb = &a1  &1ee6 = &37  (&5c, &??) &04: stone door
;;    &4d : &1a6f = &a0  &1b6e = &41  &1dfc = &d6  &1ee7 = &2a  (&a0, &??) &01: teleport beam
;;    &4e : &1a70 = &74  &1b6f = &01  &1dfd = &dd  &1ee8 = &80  (&74, &??) &01: teleport beam
;;    &4f : &1a71 = &6a  &1b70 = &c8  &1dfe = &e2  &1ee9 = &4a  (&6a, &??) &08: switch
;;    &50 : &1a72 = &a1  &1b71 = &48  &1dff = &04  &1eea = &10  (&a1, &??) &08: switch
;;    &51 : &1a73 = &9f  &1b72 = &cc  &1e00 = &0c  &1eeb = &2f  (&9f, &??) &0c: engine thruster
;;    &52 : &1a74 = &89  &1b73 = &82  &1e01 = &04  &1eec = &30  (&89, &??) &02: hovering robot
;;    &53 : &1a75 = &85  &1b74 = &02  &1e02 = &20  &1eed = &30  (&85, &??) &02: red/magenta/red key
;;    &54 : &1a76 = &6b  &1b75 = &02  &1e03 = &21  &1eee = &09  (&6b, &??) &02: plasma gun
;;    &55 : &1a77 = &ae  &1b76 = &02  &1e04 = &a0  &1eef = &0d  (&ae, &??) &02: whistle 2
;;    &56 : &1a78 = &65  &1b77 = &1e  &1e05 = &b0  &1ef0 = &09  (&65, &??) &1e: brick wall
;;  3:&57 : &1a79 = &e2  &1b78 = &89  &1e06 = &ac  &1ef1 = &09  (&e2, &??) &09: fireball
;;    &58 : &1a7a = &ed  &1b79 = &09  &1e07 = &83  &1ef2 = &4f  (&ed, &??) &09: green slime (x 3)
;;    &59 : &1a7b = &80  &1b7a = &0a  &1e08 = &81  &1ef3 = &24  (&80, &??) &0a: fireball
;;    &5a : &1a7c = &cd  &1b7b = &4a  &1e09 = &84  &1ef4 = &4a  (&cd, &??) &0a: energy capsule (x 8)
;;    &5b : &1a7d = &a8  &1b7c = &ca  &1e0a = &80  &1ef5 = &04  (&a8, &??) &0a: energy capsule (x 8)
;;    &5c : &1a7e = &2b  &1b7d = &4a  &1e0b = &c4  &1ef6 = &1a  (&2b, &??) &0a: red/cyan imp (x 8)
;;    &5d : &1a7f = &ab  &1b7e = &86  &1e0c = &85  &1ef7 = &39  (&ab, &??) &06: green/white turret
;;    &5e : &1a80 = &9d  &1b7f = &46  &1e0d = &95  &1ef8 = &10  (&9d, &??) &06: cyan/red turret
;;    &5f : &1a81 = &62  &1b80 = &46  &1e0e = &a3  &1ef9 = &00  (&62, &??) &06: deadly sucker
;;    &60 : &1a82 = &e5  &1b81 = &46  &1e0f = &b5  &1efa = &4c  (&e5, &??) &06: deadly sucker
;;    &61 : &1a83 = &70  &1b82 = &86  &1e10 = &f1  &1efb = &0a  (&70, &??) &06: gargoyle
;;    &62 : &1a84 = &ec  &1b83 = &45  &1e11 = &ad  &1efc = &2f  (&ec, &??) &05: coronium boulder
;;    &63 : &1a85 = &83  &1b84 = &47  &1e12 = &c1  &1efd = &29  (&83, &??) &07: big nest
;;    &64 : &1a86 = &c1  &1b85 = &00  &1e13 = &81  &1efe = &2c  (&c1, &??) &00: invisible switch
;;    &65 : &1a87 = &c6  &1b86 = &00  &1e14 = &89  &1eff = &37  (&c6, &??) &00: invisible switch
;;    &66 : &1a88 = &67  &1b87 = &00  &1e15 = &a0  &1f00 = &20  (&67, &??) &00: invisible switch
;;    &67 : &1a89 = &eb  &1b88 = &00  &1e16 = &c1  &1f01 = &3a  (&eb, &??) &00: invisible switch
;;    &68 : &1a8a = &2d  &1b89 = &84  &1e17 = &f1  &1f02 = &0d  (&2d, &??) &04: stone door
;;    &69 : &1a8b = &98  &1b8a = &c3  &1e18 = &f1  &1f03 = &05  (&98, &??) &03: door
;;    &6a : &1a8c = &aa  &1b8b = &44  &1e19 = &c1  &1f04 = &05  (&aa, &??) &04: stone door
;;    &6b : &1a8d = &cc  &1b8c = &43  &1e1a = &8c  &1f05 = &0d  (&cc, &??) &03: door
;;    &6c : &1a8e = &a5  &1b8d = &43  &1e1b = &a4  &1f06 = &20  (&a5, &??) &03: door
;;    &6d : &1a8f = &9e  &1b8e = &43  &1e1c = &e4  &1f07 = &0d  (&9e, &??) &03: door
;;    &6e : &1a90 = &a2  &1b8f = &44  &1e1d = &d7  &1f08 = &0d  (&a2, &??) &04: stone door
;;    &6f : &1a91 = &d7  &1b90 = &84  &1e1e = &9d  &1f09 = &48  (&d7, &??) &04: stone door
;;    &70 : &1a92 = &e6  &1b91 = &44  &1e1f = &e1  &1f0a = &51  (&e6, &??) &04: stone door
;;    &71 : &1a93 = &e7  &1b92 = &04  &1e20 = &a6  &1f0b = &0c  (&e7, &??) &04: stone door
;;    &72 : &1a94 = &94  &1b93 = &01  &1e21 = &81  &1f0c = &55  (&94, &??) &01: teleport beam
;;    &73 : &1a95 = &7c  &1b94 = &08  &1e22 = &85  &1f0d = &22  (&7c, &??) &08: switch
;;    &74 : &1a96 = &e3  &1b95 = &08  &1e23 = &83  &1f0e = &04  (&e3, &??) &08: switch
;;    &75 : &1a97 = &45  &1b96 = &02  &1e24 = &83  &1f0f = &2e  (&45, &??) &02: blue/cyan/green key
;;    &76 : &1a98 = &9b  &1b97 = &02  &1e25 = &d0  &1f10 = &2f  (&9b, &??) &02: red robot
;;    &77 : &1a99 = &9f  &1b98 = &82  &1e26 = &a8  &1f11 = &2b  (&9f, &??) &02: whistle 1
;;    &78 : &1a9a = &c2  &1b99 = &1e  &1e27 = &04  &1f12 = &2a  (&c2, &??) &1e: brick wall
;;    &79 : &1a9b = &71  &1b9a = &2d  &1e28 = &04  &1f13 = &21  (&71, &??) &2d: stone wall
;;  4:&7a : &1a9c = &67  &1b9b = &46  &1e29 = &d0  &1f14 = &02  (&67, &??) &06: cyan/red turret
;;    &7b : &1a9d = &4f  &1b9c = &46  &1e2a = &88  &1f15 = &02  (&4f, &??) &06: gargoyle
;;    &7c : &1a9e = &cf  &1b9d = &45  &1e2b = &04  &1f16 = &1a  (&cf, &??) &05: deadly sucker
;;    &7d : &1a9f = &d2  &1b9e = &46  &1e2c = &04  &1f17 = &80  (&d2, &??) &06: deadly sucker
;;    &7e : &1aa0 = &e2  &1b9f = &c6  &1e2d = &04  &1f18 = &4b  (&e2, &??) &06: gargoyle
;;    &7f : &1aa1 = &7a  &1ba0 = &89  &1e2e = &08  &1f19 = &80  (&7a, &??) &09: maggot (x 20)
;;    &80 : &1aa2 = &62  &1ba1 = &c9  &1e2f = &bd  &1f1a = &00  (&62, &??) &09: invisible bird (x 10)
;;    &81 : &1aa3 = &da  &1ba2 = &49  &1e30 = &8a  &1f1b = &00  (&da, &??) &09: big fish
;;    &82 : &1aa4 = &76  &1ba3 = &89  &1e31 = &f1  &1f1c = &00  (&76, &??) &09: cyan frogman
;;    &83 : &1aa5 = &b2  &1ba4 = &ca  &1e32 = &d1  &1f1d = &00  (&b2, &??) &0a: wasp (x 20)
;;    &84 : &1aa6 = &66  &1ba5 = &ca  &1e33 = &f1  &1f1e = &00  (&66, &??) &0a: moving fireball (x 2)
;;    &85 : &1aa7 = &d7  &1ba6 = &8a  &1e34 = &b1  &1f1f = &00  (&d7, &??) &0a: fireball
;;    &86 : &1aa8 = &83  &1ba7 = &8a  &1e35 = &f1  &1f20 = &00  (&83, &??) &0a: fireball
;;    &87 : &1aa9 = &84  &1ba8 = &8a  &1e36 = &c1  &1f21 = &00  (&84, &??) &0a: fireball
;;    &88 : &1aaa = &80  &1ba9 = &0a  &1e37 = &c1  &1f22 = &00  (&80, &??) &0a: red/yellow imp (x 2)
;;    &89 : &1aab = &87  &1baa = &00  &1e38 = &c1  &1f23 = &00  (&87, &??) &00: invisible switch
;;    &8a : &1aac = &9b  &1bab = &00  &1e39 = &c1  &1f24 = &00  (&9b, &??) &00: invisible switch
;;    &8b : &1aad = &50  &1bac = &c4  &1e3a = &e2  &1f25 = &00  (&50, &??) &04: stone door
;;    &8c : &1aae = &ae  &1bad = &43  &1e3b = &e4  &1f26 = &00  (&ae, &??) &03: door
;;    &8d : &1aaf = &64  &1bae = &04  &1e3c = &dc  &1f27 = &00  (&64, &??) &04: stone door
;;    &8e : &1ab0 = &a3  &1baf = &43  &1e3d = &a0  &1f28 = &00  (&a3, &??) &03: door
;;    &8f : &1ab1 = &63  &1bb0 = &84  &1e3e = &c2  &1f29 = &00  (&63, &??) &04: stone door
;;    &90 : &1ab2 = &b8  &1bb1 = &44  &1e3f = &cb  &1f2a = &00  (&b8, &??) &04: stone door
;;    &91 : &1ab3 = &7f  &1bb2 = &04  &1e40 = &b8  &1f2b = &00  (&7f, &??) &04: stone door
;;    &92 : &1ab4 = &82  &1bb3 = &44  &1e41 = &a8  &1f2c = &00  (&82, &??) &04: stone door
;;    &93 : &1ab5 = &e0  &1bb4 = &84  &1e42 = &10  &1f2d = &00  (&e0, &??) &04: stone door
;;    &94 : &1ab6 = &9c  &1bb5 = &41  &1e43 = &98  &1f2e = &00  (&9c, &??) &01: teleport beam
;;    &95 : &1ab7 = &61  &1bb6 = &01  &1e44 = &a0  &1f2f = &00  (&61, &??) &01: teleport beam
;;    &96 : &1ab8 = &9d  &1bb7 = &01  &1e45 = &80  &1f30 = &00  (&9d, &??) &01: teleport beam
;;    &97 : &1ab9 = &29  &1bb8 = &01  &1e46 = &83  &1f31 = &00  (&29, &??) &01: teleport beam
;;    &98 : &1aba = &46  &1bb9 = &c8  &1e47 = &80  &1f32 = &00  (&46, &??) &08: switch
;;    &99 : &1abb = &9f  &1bba = &42  &1e48 = &80  &1f33 = &00  (&9f, &??) &02: energy capsule
;;    &9a : &1abc = &9a  &1bbb = &82  &1e49 = &80  &1f34 = &00  (&9a, &??) &02: inactive chatter
;;    &9b : &1abd = &74  &1bbc = &3b  &1e4a = &80  &1f35 = &00  (&74, &??) &3b: brick wall, top quarter empty
;;    &9c : &1abe = &75  &1bbd = &11  &1e4b = &00  &1f36 = &00  (&75, &??) &11: leaf
;;    &9d : &1abf = &77  &1bbe = &3b  &1e4c = &c4  &1f37 = &00  (&77, &??) &3b: brick wall, top quarter empty
;;  5:&9e : &1ac0 = &b2  &1bbf = &89  &1e4d = &40  &1f38 = &00  (&b2, &??) &09: pirahna (x 10)
;;    &9f : &1ac1 = &e4  &1bc0 = &c9  &1e4e = &84  &1f39 = &00  (&e4, &??) &09: white/yellow bird (x 4)
;;    &a0 : &1ac2 = &62  &1bc1 = &ca  &1e4f = &28  &1f3a = &00  (&62, &??) &0a: red/magenta bird (x 6)
;;    &a1 : &1ac3 = &63  &1bc2 = &8a  &1e50 = &75  &1f3b = &00  (&63, &??) &0a: red/magenta bird (x 8)
;;    &a2 : &1ac4 = &82  &1bc3 = &c6  &1e51 = &bc  &1f3c = &00  (&82, &??) &06: red slime
;;    &a3 : &1ac5 = &61  &1bc4 = &06  &1e52 = &f1  &1f3d = &00  (&61, &??) &06: deadly sucker
;;    &a4 : &1ac6 = &d4  &1bc5 = &c6  &1e53 = &d1  &1f3e = &00  (&d4, &??) &06: red slime
;;    &a5 : &1ac7 = &d3  &1bc6 = &c6  &1e54 = &a9  &1f3f = &00  (&d3, &??) &06: red slime
;;    &a6 : &1ac8 = &77  &1bc7 = &06  &1e55 = &f1  &1f40 = &00  (&77, &??) &06: cannon control device
;;    &a7 : &1ac9 = &2e  &1bc8 = &06  &1e56 = &c0  &1f41 = &00  (&2e, &??) &06: green clawed robot
;;    &a8 : &1aca = &64  &1bc9 = &85  &1e57 = &c1  &1f42 = &00  (&64, &??) &05: destinator
;;    &a9 : &1acb = &86  &1bca = &47  &1e58 = &8f  &1f43 = &00  (&86, &??) &07: small nest
;;    &aa : &1acc = &a5  &1bcb = &4a  &1e59 = &94  &1f44 = &00  (&a5, &??) &0a: hover ball (x 16)
;;    &ab : &1acd = &a0  &1bcc = &ca  &1e5a = &c2  &1f45 = &00  (&a0, &??) &0a: moving fireball
;;    &ac : &1ace = &d1  &1bcd = &8a  &1e5b = &ca  &1f46 = &00  (&d1, &??) &0a: pirahna (x 10)
;;    &ad : &1acf = &b4  &1bce = &00  &1e5c = &fa  &1f47 = &00  (&b4, &??) &00: invisible switch
;;    &ae : &1ad0 = &7f  &1bcf = &00  &1e5d = &9c  &1f48 = &00  (&7f, &??) &00: invisible switch
;;    &af : &1ad1 = &a3  &1bd0 = &44  &1e5e = &fe  &1f49 = &00  (&a3, &??) &04: stone door
;;    &b0 : &1ad2 = &9f  &1bd1 = &43  &1e5f = &10  &1f4a = &00  (&9f, &??) &03: door
;;    &b1 : &1ad3 = &99  &1bd2 = &c3  &1e60 = &14  &1f4b = &00  (&99, &??) &03: door
;;    &b2 : &1ad4 = &80  &1bd3 = &44  &1e61 = &90  &1f4c = &00  (&80, &??) &04: stone door
;;    &b3 : &1ad5 = &67  &1bd4 = &44  &1e62 = &98  &1f4d = &00  (&67, &??) &04: stone door
;;    &b4 : &1ad6 = &da  &1bd5 = &04  &1e63 = &04  &1f4e = &00  (&da, &??) &04: stone door
;;    &b5 : &1ad7 = &89  &1bd6 = &41  &1e64 = &a4  &1f4f = &00  (&89, &??) &01: teleport beam
;;    &b6 : &1ad8 = &95  &1bd7 = &c8  &1e65 = &80  &1f50 = &00  (&95, &??) &08: switch
;;    &b7 : &1ad9 = &8b  &1bd8 = &88  &1e66 = &83  &1f51 = &00  (&8b, &??) &08: switch
;;    &b8 : &1ada = &ab  &1bd9 = &c8  &1e67 = &c6  &1f52 = &00  (&ab, &??) &08: switch
;;    &b9 : &1adb = &c4  &1bda = &c8  &1e68 = &c4  &1f53 = &00  (&c4, &??) &08: switch
;;    &ba : &1adc = &9d  &1bdb = &02  &1e69 = &fe  &1f54 = &00  (&9d, &??) &02: magenta robot
;;    &bb : &1add = &aa  &1bdc = &8c  &1e6a = &aa  &1f55 = &00  (&aa, &??) &0c: engine thruster
;;  6:&bc : &1ade = &bb  &1bdd = &49  &1e6b = &90  &1f56 = &00  (&bb, &??) &09: green slime (x 4)
;;    &bd : &1adf = &47  &1bde = &89  &1e6c = &ec  &1f57 = &00  (&47, &??) &09: white/yellow bird (x 5)
;;    &be : &1ae0 = &8a  &1bdf = &0a  &1e6d = &dc  &1f58 = &00  (&8a, &??) &0a: red/magenta imp (x 4)
;;    &bf : &1ae1 = &a7  &1be0 = &0a  &1e6e = &9e  &1f59 = &00  (&a7, &??) &0a: cyan/yellow imp (x 6)
;;    &c0 : &1ae2 = &61  &1be1 = &8a  &1e6f = &f4  &1f5a = &00  (&61, &??) &0a: fireball
;;    &c1 : &1ae3 = &9e  &1be2 = &c6  &1e70 = &f7  &1f5b = &00  (&9e, &??) &06: cyan/red turret
;;    &c2 : &1ae4 = &2e  &1be3 = &06  &1e71 = &f1  &1f5c = &00  (&2e, &??) &06: giant wall
;;    &c3 : &1ae5 = &d6  &1be4 = &06  &1e72 = &f1  &1f5d = &00  (&d6, &??) &06: deadly sucker
;;    &c4 : &1ae6 = &7e  &1be5 = &47  &1e73 = &81  &1f5e = &00  (&7e, &??) &07: big nest
;;    &c5 : &1ae7 = &da  &1be6 = &87  &1e74 = &f1  &1f5f = &00  (&da, &??) &07: big nest
;;    &c6 : &1ae8 = &aa  &1be7 = &cc  &1e75 = &f1  &1f60 = &00  (&aa, &??) &0c: engine thruster
;;    &c7 : &1ae9 = &ab  &1be8 = &41  &1e76 = &b1  &1f61 = &00  (&ab, &??) &01: teleport beam
;;    &c8 : &1aea = &45  &1be9 = &01  &1e77 = &db  &1f62 = &00  (&45, &??) &01: teleport beam
;;    &c9 : &1aeb = &67  &1bea = &08  &1e78 = &9e  &1f63 = &00  (&67, &??) &08: switch
;;    &ca : &1aec = &d4  &1beb = &08  &1e79 = &84  &1f64 = &00  (&d4, &??) &08: switch
;;    &cb : &1aed = &29  &1bec = &08  &1e7a = &ac  &1f65 = &00  (&29, &??) &08: switch
;;    &cc : &1aee = &b8  &1bed = &08  &1e7b = &80  &1f66 = &00  (&b8, &??) &08: switch
;;    &cd : &1aef = &6b  &1bee = &c4  &1e7c = &80  &1f67 = &00  (&6b, &??) &04: stone door
;;    &ce : &1af0 = &69  &1bef = &84  &1e7d = &80  &1f68 = &00  (&69, &??) &04: stone door
;;    &cf : &1af1 = &9d  &1bf0 = &43  &1e7e = &80  &1f69 = &00  (&9d, &??) &03: door
;;    &d0 : &1af2 = &94  &1bf1 = &43  &1e7f = &80  &1f6a = &00  (&94, &??) &03: door
;;    &d1 : &1af3 = &63  &1bf2 = &84  &1e80 = &80  &1f6b = &00  (&63, &??) &04: stone door
;;    &d2 : &1af4 = &b4  &1bf3 = &04  &1e81 = &80  &1f6c = &00  (&b4, &??) &04: stone door
;;    &d3 : &1af5 = &a1  &1bf4 = &83  &1e82 = &c0  &1f6d = &00  (&a1, &??) &03: door
;;    &d4 : &1af6 = &9f  &1bf5 = &82  &1e83 = &04  &1f6e = &00  (&9f, &??) &02: icer
;;    &d5 : &1af7 = &a0  &1bf6 = &82  &1e84 = &08  &1f6f = &00  (&a0, &??) &02: blue robot
;;    &d6 : &1af8 = &57  &1bf7 = &0d  &1e85 = &90  &1f70 = &00  (&57, &??) &0d: water
;;    &d7 : &1af9 = &e1  &1bf8 = &0d  &1e86 = &a2  &1f71 = &00  (&e1, &??) &0d: water
;;  7:&d8 : &1afa = &7f  &1bf9 = &46  &1e87 = &04  &1f72 = &00  (&7f, &??) &06: deadly sucker
;;    &d9 : &1afb = &a6  &1bfa = &06  &1e88 = &04  &1f73 = &00  (&a6, &??) &06: cyan/red turret
;;    &da : &1afc = &b4  &1bfb = &06  &1e89 = &04  &1f74 = &00  (&b4, &??) &06: deadly sucker
;;    &db : &1afd = &53  &1bfc = &06  &1e8a = &20  &1f75 = &00  (&53, &??) &06: deadly sucker
;;    &dc : &1afe = &61  &1bfd = &06  &1e8b = &bc  &1f76 = &00  (&61, &??) &06: maggot machine
;;    &dd : &1aff = &d4  &1bfe = &45  &1e8c = &53  &1f77 = &00  (&d4, &??) &05: cyan/yellow/green key
;;    &de : &1b00 = &82  &1bff = &45  &1e8d = &9d  &1f78 = &00  (&82, &??) &05: sucker
;;    &df : &1b01 = &e3  &1c00 = &45  &1e8e = &84  &1f79 = &00  (&e3, &??) &05: coronium boulder
;;    &e0 : &1b02 = &75  &1c01 = &06  &1e8f = &da  &1f7a = &00  (&75, &??) &06: magenta clawed robot
;;    &e1 : &1b03 = &c3  &1c02 = &07  &1e90 = &cb  &1f7b = &00  (&c3, &??) &07: small nest
;;    &e2 : &1b04 = &84  &1c03 = &89  &1e91 = &de  &1f7c = &00  (&84, &??) &09: green/yellow bird
;;    &e3 : &1b05 = &9e  &1c04 = &09  &1e92 = &c5  &1f7d = &00  (&9e, &??) &09: white/yellow bird (x 2)
;;    &e4 : &1b06 = &c6  &1c05 = &8a  &1e93 = &a5  &1f7e = &00  (&c6, &??) &0a: blue/cyan imp (x 4)
;;    &e5 : &1b07 = &64  &1c06 = &4a  &1e94 = &c1  &1f7f = &00  (&64, &??) &0a: red/yellow imp (x 8)
;;    &e6 : &1b08 = &a2  &1c07 = &4a  &1e95 = &f1  &1f80 = &00  (&a2, &??) &0a: hovering robot
;;    &e7 : &1b09 = &28  &1c08 = &ca  &1e96 = &70  &1f81 = &00  (&28, &??) &0a: pericles crew member
;;    &e8 : &1b0a = &29  &1c09 = &ca  &1e97 = &d0  &1f82 = &00  (&29, &??) &0a: pericles crew member
;;    &e9 : &1b0b = &9d  &1c0a = &4a  &1e98 = &80  &1f83 = &00  (&9d, &??) &0a: hover ball (x 8)
;;    &ea : &1b0c = &83  &1c0b = &00  &1e99 = &00  &1f84 = &00  (&83, &??) &00: invisible switch
;;    &eb : &1b0d = &a8  &1c0c = &00  &1e9a = &00  &1f85 = &00  (&a8, &??) &00: invisible switch
;;    &ec : &1b0e = &80  &1c0d = &00  &1e9b = &00  &1f86 = &00  (&80, &??) &00: invisible switch
;;    &ed : &1b0f = &aa  &1c0e = &48  &1e9c = &00  &1f87 = &00  (&aa, &??) &08: switch
;;    &ee : &1b10 = &d5  &1c0f = &08  &1e9d = &00  &1f88 = &00  (&d5, &??) &08: switch
;;    &ef : &1b11 = &a0  &1c10 = &82  &1e9e = &00  &1f89 = &00  (&a0, &??) &02: energy capsule
;;    &f0 : &1b12 = &9f  &1c11 = &82  &1e9f = &00  &1f8a = &00  (&9f, &??) &02: protection suit
;;    &f1 : &1b13 = &d6  &1c12 = &82  &1ea0 = &00  &1f8b = &00  (&d6, &??) &02: rock
;;    &f2 : &1b14 = &62  &1c13 = &02  &1ea1 = &00  &1f8c = &00  (&62, &??) &02: red clawed robot
;;    &f3 : &1b15 = &69  &1c14 = &c4  &1ea2 = &00  &1f8d = &00  (&69, &??) &04: stone door
;;    &f4 : &1b16 = &2c  &1c15 = &c4  &1ea3 = &00  &1f8e = &00  (&2c, &??) &04: stone door
;;    &f5 : &1b17 = &a5  &1c16 = &0b  &1ea4 = &00  &1f8f = &00  (&a5, &??) &0b: downdraught
;;  8:&f6 : &1b18 = &b8  &1c17 = &0b  &1ea5 = &00  &1f90 = &00  (&b8, &??) &0b: updraught
;;    &f7 : &1b19 = &b9  &1c18 = &0b  &1ea6 = &00  &1f91 = &00  (&b9, &??) &0b: updraught
;;    &f8 : &1b1a = &d9  &1c19 = &d1  &1ea7 = &00  &1f92 = &00  (&d9, &??) &11: leaf
;;    &f9 : &1b1b = &59  &1c1a = &91  &1ea8 = &00  &1f93 = &00  (&59, &??) &11: leaf
;;    &fa : &1b1c = &79  &1c1b = &d1  &1ea9 = &00  &1f94 = &00  (&79, &??) &11: leaf
;;    &fb : &1b1d = &39  &1c1c = &d1  &1eaa = &00  &1f95 = &00  (&39, &??) &11: leaf
;;    &fc : &1b1e = &48  &1c1d = &91  &1eab = &00  &1f96 = &00  (&48, &??) &11: leaf
;;    &fd : &1b1f = &e8  &1c1e = &91  &1eac = &00  &1f97 = &00  (&e8, &??) &11: leaf
;; 
;; ##############################################################################; 

; ; *****************************************************************************
; background_objects_data
; &80 set = not in current stack
; ; *****************************************************************************
; 
.background_objects_data
    ;;  &80 set = not in current stack
    equb   0, &7c, &60,   4, &88, &88, &a0, &a6, &ae, &83, &86, &82, &80, &80, &ad, &81
    equb &f7, &a1, &f1, &f7, &81, &8a, &ac, &d2, &df, &d4, &a3, &84, &85, &ae, &80, &80
    equb &88
.background_objects_data_2
    equb &ac, &c4, &c0,   4, &a8, &c4, &bc, &fd, &81, &c1, &d1, &91, &f1, &f1, &da, &f7
    equb &f3, &d8, &88, &80, &83, &83, &b0, &aa, &80, &80, &87, &80
    equb &30
.background_objects_data_3
    equb   8, &10, &7c,   4, &10, &a8, &90,   4, &c1, &f1, &e1, &95, &bc, &b4, &fd, &a1
    equb &d6, &dd, &e2,   4, &0c,   4, &20, &21, &a0, &b0, &ac, &83, &81, &84, &80, &c4
    equb &85, &95, &a3, &b5, &f1, &ad, &c1, &81, &89, &a0, &c1, &f1, &f1, &c1, &8c, &a4
    equb &e4, &d7, &9d, &e1, &a6, &81, &85, &83, &83, &d0, &a8,   4,   4, &d0, &88,   4
    equb   4,   4,   8, &bd, &8a, &f1, &d1, &f1, &b1, &f1, &c1, &c1, &c1, &c1, &e2, &e4
    equb &dc, &a0, &c2, &cb, &b8, &a8, &10, &98
    equb &a0
.background_objects_data_4
    equb &80, &83, &80, &80, &80, &80,   0, &c4, &40, &84, &28, &75, &bc, &f1, &d1, &a9
    equb &f1, &c0, &c1, &8f, &94, &c2, &ca, &fa, &9c, &fe, &10, &14, &90, &98,   4, &a4
    equb &80, &83, &c6, &c4, &fe, &aa, &90, &ec, &dc, &9e, &f4, &f7, &f1, &f1, &81, &f1
    equb &f1, &b1, &db, &9e, &84, &ac, &80, &80, &80, &80, &80, &80, &80, &c0,   4,   8
    equb &90, &a2,   4,   4,   4, &20, &bc, &53, &9d, &84, &da, &cb, &de, &c5, &a5, &c1
    equb &f1, &70, &d0, &80

.background_objects_type
    equb   0, &0f, &27, &2e,   7, &2f, &2d, &1f, &1f, &0d, &0d, &0d, &0c, &60, &2c,   0
    equb &0d, &0d, &1f, &0d, &5c, &0d, &20,   5,   4,   6, &31,   5, &2a,   9, &0d, &0d
    equb &1f, &20, &55, &55, &0d, &63, &0f, &2e, &0a, &1b, &37, &29, &1a, &1a, &37, &37
    equb &0a, &37, &4b, &4b, &2d, &1f, &20, &0d, &0d, &28, &55,   5, &80,   0, &80, &80
    equb &20, &28, &0d, &0d, &28, &27, &31, &0e,   8, &11, &39, &37, &37, &37, &2a, &80
    equb &4a, &10, &2f, &30, &30,   9, &0d,   9,   9, &4f, &24, &4a,   4, &1a, &39, &10
    equb   0, &4c, &0a, &2f, &29, &2c, &37, &20, &3a, &0d,   5,   5, &0d, &20, &0d, &0d
    equb &48, &51, &0c, &55, &22,   4, &2e, &2f, &2b, &2a, &21,   2,   2, &1a, &80, &4b
    equb &80

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
;; ##############################################################################; 

.secondary_object_stack_x
    equb &9b, &a3, &98, &98, &a4, &9f, &a0, &c0, &48, &83, &c5, &87, &97, &e1, &84, &98
    equb &99, &e7, &7c,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0

.secondary_object_stack_y
    equb &39, &5d, &4d, &4d, &67, &49, &49, &4e, &56, &78, &60, &59, &5e, &61, &5b, &80
    equb &3c, &80, &77,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0

.secondary_object_stack_type
    equb &64, &43, &50, &50, &59, &50, &46, &50, &50, &4e, &45, &53, &1d,   3, &50, &50
    equb &4a, &3a, &4c,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0

.possible_checksum
    equb &dc

.secondary_object_stack_energy_and_low
    equb &f0, &f3, &71, &79, &fb, &42, &f5, &47, &f3, &f2, &f3, &f2, &f0, &fb, &f2, &40
    equb &fb, &f0, &f1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0

;; variables used for secondary stack
; secondary_stack_object_number
    equb   0
; secondary_stack_random_1f
    equb   0
; maybe_another_checksum
    equb &43
; consider_secondary_stack_objects
; secondary_stack_player_odometer
    equb   0

.sprite_and
    equb &ff

.palette_value_to_pixel_lookup
    equb &ca; yellow bg, black bg
    equb &c9; green bg, red bg
    equb &e3; magenta bg, red bg
    equb &e9; cyan bg, red bg
    equb &eb; white bg, red bg
    equb &ce; yellow bg, green bg
    equb &f8; cyan bg, blue bg
    equb &e6; magenta bg, green bg
    equb &cc; green bg, green bg
    equb &ee; white bg, green bg
    equb &30; blue fg, blue fg
    equb &de; yellow bg, cyan bg
    equb &ef; white bg, yellow bg
    equb &cb; yellow bg, red bg
    equb &fb; white bg, magenta bg
    equb &fe; white bg, cyan bg

.plot_sprite_screen_address_offsets_low
    equb   0, &ea,   0, &ea

.plot_sprite_screen_address_offsets
    equb   8, &ea,   5, &ea

.used_in_redraw_1fb8
    equb &f0, &f0, &f8, &f8

.plot_sprite_when_to_flags_and
    equb   5, &0a

.sub_c1fbe
    jmp push_near_objects_from_secondary_to_primary_stack

.move_secondary_object_into_primary_stack
{
    lda secondary_object_stack_y,x     ; look at random object on secondary stack
    beq done                           ; does it exist? if not, leave
    lda secondary_object_stack_type,x  ; get type
    jsr reserve_objects                ; find a slot to put it in, create object
    bcs done                           ; if no free slot, leave
    lda secondary_object_stack_x,x
    sta object_stack_x,y               ; get x
    lda secondary_object_stack_y,x
    sta object_stack_y,y               ; get y
    lda secondary_object_stack_energy_and_low,x
    pha
    ora #&0f
    sta object_stack_energy,y          ; get top four bits of energy + &f
    pla
    asl a
    asl a
    asl a
    asl a
    pha
    and #&c0
    sta object_stack_x_low,y           ; get top two bits of x_low
    pla
    asl a
    asl a
    sta object_stack_y_low,y           ; get top two bits of y_low
    lda #0
    sta secondary_object_stack_y,x     ; remove from secondary stack
.done
    rts
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.push_near_objects_from_secondary_to_primary_stack
{    ldx #&1f                          ; start with last slot of secondary stack
.loop
    lda secondary_object_stack_y,x
    sta this_object_y
    sec
    sbc screen_offset_y_low_old
    clc
    adc #1
    cmp #7
    bcs done
    lda secondary_object_stack_x,x
    sta this_object_x
    sec
    sbc screen_offset_x_low_old
    clc
    adc #1
    cmp #&0a
    bcs done
    ldy #1                             ; if this object is near the screen
    jsr move_secondary_object_into_primary_stack ; push it into the primary stack
.done
    dex
    bpl loop                           ; continue for the rest of the secondary stack
    rts
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.plot_object
{    lda #&3f                          ; objects are plotted and &3f
    sta sprite_and
    jsr plot_sprite
    ldx current_object
    lsr object_stack_flags,x
    lda skip_sprite_calculation_flags
    and #5
    cmp #1
    rol object_stack_flags,x
    lda #&ff                           ; background is plotted and &ff
    sta sprite_and
    rts
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.plot_sprite
    ldx #3                             ; first X = 3, previous                       ; then X = 2, current
    asl skip_sprite_calculation_flags
;; Calculate various variables for the sprite, both for its previous
;; and current location. We determine the screen address at which to
;; plot, and whether the sprite crosses the edge of the screen - if
;; so, we alter its size accordingly.
.plot_sprite_calculation_loop
    bcs plot_sprite_skip_calculations
    cpx #2
    bcc plot_sprite_continued          ; taken if X<2 (and therefore done)
    ldy this_object_sprite - 2,x       ; X = 3, &5d this_object_sprite_old, X = 2, &5c this_object_sprite
    lda sprite_height_lookup,y         ; C=?? A=h7 h6 h5 h4 h3 h2 h1 h0
    lsr a                              ; C=h0 A=00 h7 h6 h5 h4 h3 h2 h1
    lda sprite_width_lookup,y          ; C=h0 A=w7 w6 w5 w4 w3 w2 w1 w0
    ror a                              ; C=w0 A=h0 w7 w6 w5 w4 w3 w2 w1
    and #&80                           ; C=w0 A=h0 00 00 00 00 00 00 00
    ror a                              ; C=00 A=w0 h0 00 00 00 00 00 00
    eor this_object_flipping_flags - 2,x ; X = 3, &59 this_object_flipping_flags_old ; X = 2, &58, this_object_flipping_flags
                                         ; swap based on object flip flags? (So sprite can be flipped as part of its definition??)
    sta this_sprite_flipping_flags - 2,x ; X = 3, &59 this_sprite_flipping_flags_old ; X = 2, &58 this_sprite_flipping_flags
                                         ; save for the sprite
    asl a                              ; C = X flip flag?
    sta this_sprite_partflip - 2,x     ; X = 3, &4d this_sprite_vertflip_old         ; X = 2, &4c this_sprite_partflip
    lda sprite_width_lookup,y
    and #&f0                           ; mask off actual width?
    sta this_sprite_width - 2,x        ; X = 3, &33 this_sprite_width_old            ; X = 2, &32 this_sprite_width
    lda sprite_height_lookup,y
    and #&f8                           ; mask off actual height?
    sta this_sprite_height - 2,x       ; X = 3, &35 this_sprite_height_old           ; X =2, &34 this_sprite_height
    lda sprite_offset_a_lookup,y
    sta this_sprite_a - 2,x            ; X = 3, &47 this_sprite_a_old                ; X = 2, &46 this_sprite_a
    lda sprite_offset_b_lookup,y
    sta this_sprite_b - 2,x            ; X = 3, &49 this_sprite_b_old                ; X = 2, &48 this_sprite_b

.plot_sprite_continued
    lda this_object_y_low - 2,x        ; X = 3, &39 this_object_y_low_old            ; X = 2, &38 this_object_y_low
    and used_in_redraw_1fb8,x          ; X = 3, &1fbb (&f8)                          ; X = 2 &1fba (&f8) ; always mask with &f8? - extract character row index
    sec
    sbc screen_offset_y_low - 2,x      ; X = 3, &81 screen_offset_y_low_old          ; X = 2, &80 screen_offset_y_low
    sta this_object_screen_y_low - 2,x ; X = 3, &41 this_object_screen_y_low_old     ; X = 2, &40 this_object_screen_y_low
    lda this_object_y - 2,x            ; X = 3, &3d this_object_y_old                ; X = 2, &53c this_object_y
    sbc screen_offset_y_low_old - 2,x  ; X = 3, &85 screen_offset_y_old              ; X = 2, &84 screen_offset_y
    sta this_object_screen_y - 2,x     ; X = 3, &45 this_object_screen_y_old         ; X = 2, &44 this_object_screen_y
    lda this_object_screen_y_low - 2,x ; X = 3, &41 this_object_screen_y_low_old     ; X = 2 &40 this_object_screen_y_low
    clc
    adc this_sprite_height - 2,x       ; X = 3, &35 this_sprite_height_old           ; X = 2, &34 this_sprite_height
    sta zp_various_1b
    lda this_object_screen_y - 2,x     ; X = 3, &45 this_object_screen_y_old         ; X = 2, &44 this_object_screen_y
    adc #0
    sta zp_various_1c
    bmi c20e9
    bcs c20d3
    lda zp_various_1b
    sec
    sbc plot_sprite_screen_address_offsets_low,x
    sta zp_various_1b
    lda zp_various_1c
    sbc plot_sprite_screen_address_offsets,x
    sta zp_various_1c
    beq c20b6
    bpl plot_sprite_skip_calculations
.c20a9
    lda this_object_screen_y_low - 2,x ; X = 3, &41 this_object_screen_y_low_old     ; X = 2 &40 this_object_screen_y_low
.c20ab
    sta this_object_screen_y_low - 2,x ; X = 3, &41 this_object_screen_y_low_old     ; X = 2 &40 this_object_screen_y_low
    clc
.plot_sprite_skip_calculations
    rol skip_sprite_calculation_flags
    dex                                ; do it again for X =2
    bmi plot_sprite_after_calculations
    jmp plot_sprite_calculation_loop

.c20b6
    lda zp_various_1b
    sbc this_sprite_height - 2,x       ; X = 3, &35 this_sprite_height_old           ; X = 2, &34 this_sprite_height
    bcs plot_sprite_skip_calculations
    eor used_in_redraw_1fb8,x          ; X = 3, &1fbb (&f8)                          ; X = 2, &1fba (&f8)
    sta this_sprite_height - 2,x       ; X = 3, &35 this_sprite_height_old           ; X = 2, &34 this_sprite_height
    lda this_sprite_partflip - 2,x     ; X = 3, &4d this_sprite_vertflip_old         ; X = 2, &4c this_sprite_partflip
    bpl c20a9
    lda zp_various_1b
    sec
    sbc used_in_redraw_1fb8,x          ; X = 3, &1fbb (&f8)                          ; X = 2, &1fba (&f8)
    adc this_sprite_b - 2,x            ; X = 3, &49 this_sprite_b_old                ; X = 2, &48 this_sprite_b
    adc #0
    sta this_sprite_b - 2,x            ; X = 3, &49 this_sprite_b_old                ; X = 2, &48 this_sprite_b
    bcc c20a9
.c20d3
    lda zp_various_1b
    sta this_sprite_height - 2,x       ; X = 3, &35 this_sprite_height_old           ; X = 2, &34 this_sprite_height
    lda this_sprite_partflip - 2,x     ; X = 3, &4d this_sprite_vertflip_old         ; X = 2, &4c this_sprite_partflip
    bmi c20e3
    lda this_sprite_b - 2,x            ; X = 3, &49 this_sprite_b_old                ; X = 2, &48 this_sprite_b
    sbc this_object_screen_y_low - 2,x ; X = 3, &41 this_object_screen_y_low_old     ; X = 2, &40 this_object_screen_y_low
    adc #0
    sta this_sprite_b - 2,x            ; X = 3, &49 this_sprite_b_old                ; X = 2, &48 this_sprite_b
.c20e3
    lda #0
    sta this_object_screen_y - 2,x     ; X = 3, &45 this_object_screen_y_old         ; X = 2, &44 this_object_screen_y
    beq c20ab
.c20e9
    sec
    bcs plot_sprite_skip_calculations
.plot_sprite_after_calculations
    lda skip_sprite_calculation_flags
    jmp object_needs_redrawing_in

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    and #5
    beq object_needs_redrawing_in
    rts
ENDIF

.object_needs_redrawing_in
    lda #2
    sta plotter_x
    lda #0
    sta zp_0
    pha
    tsx
    stx copy_of_stack_pointer_51
.object_redrawing_loop
    dec plotter_x
    bpl do_the_plotting
    pla
    rts

;;  Plot an object or the background
.do_the_plotting
    ldx plotter_x                      ; first X = 1, previous ; then X = 0, current
    lda skip_sprite_calculation_flags
    and plot_sprite_when_to_flags_and,x; should we actually plot it?
    bne object_redrawing_loop          ; if not, continue
    lda this_sprite_a,x                ; this_sprite_a(_old)


; A = abcdefgh
;
; Byte offset = fghab (32 bytes per line)
; Pixel offset = cd (4 pixels/byte)
    asl a                              ; a bcdefgh0
    adc #0                             ; 0 bcdefgha
    asl a                              ; b cdefgha0
    adc #0                             ; 0 cdefghab
    and #&1f                           ; 0 000fghab
    sta sprite_row_byte_offset         ; byte offset into row

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

    lda this_object_palette,x          ; this_object_palette(_old)
    lsr a
    lsr a
    lsr a
    lsr a
    tay                                ; Y = primary colour

    lda pixel_table,y                  ; map primary colour (0-15) to Mode 2 pixel value with that colour in both pixels
    and #&55
    sta l0011                          ; &11 - primary colour right pixel
    asl a
    sta l0022                          ; &22 - primary colour left pixel

    lda this_object_palette,x          ; this_object_palette(_old)
    and #&0f                           ; Y = (palette>>0)&15 - pair index
    tay
    lda palette_value_to_pixel_lookup,y; get pair
    and sprite_and                     ; 00111111 or 11111111
    tay
    and #&55                           ; get right pixel
    sta l0001                          ; right 1
    asl a
    sta l0002                          ; left 1
    tya
    and #&aa                           ; get left pixel
    sta l0020                          ; left 2
    lsr a
    sta l0010                          ; right 2
    lda this_sprite_flipping_flags,x   ; this_sprite_flipping_flags(_old)
    sta this_sprite_partflip           ; plot_flipping_flags - bit 7=X flip, bit 6=Y flip
    lsr a                              ; 0XY.....
    lsr a                              ; 00XY....
    lsr a                              ; 000XY...

; Initially, pixels need swapping if the object is X-flipped.

; If it's X-flipped, swap only if the width is odd - the effective
; start coordinate will then be the opposite parity from the screen X
; coordinate.

    and this_sprite_width,x            ; this_sprite_width(_old)

; If screen X coordinate is odd, invert the flag.

    eor this_object_screen_x_low,x     ; this_object_screen_x_low(_old)

; I'm prepared to believe that this is correct ;)

    eor this_sprite_a,x                ; this_sprite_a(_old)
    and #&10                           ; combination of all of the above
    beq dont_swap                      ; branch taken if pixel values are OK

; Swap. $00 is shared; there's only 3 pairs.

    lda l0002:ldy l0001:sta l0001:sty l0002
    lda l0020:ldy l0010:sta l0010:sty l0020
    lda l0022:ldy l0011:sta l0011:sty l0022

.dont_swap

;;  Calculate the offset between rows in the sprite

    lda #&20:ldy #0                    ; $0020 - +32
    bit this_sprite_partflip           ; test .Y......
    bvs c217d                          ; taken if Y set
    lda #&e0:dey                       ; $ffe0 - -32

.c217d
    sta l229e + 1                      ; fix up ADC# for LSB
    sty l22a6 + 1                      ; fix up ADC# for MSB

;;  Calculate the sprite address

; Put starting Y coord in A - either the sprite height, or 0,
; depending on whether it's flipped.

    lda this_sprite_height,x           ; this_sprite_height(_old)
    bvc c2189                          ; taken if Y was clear above
    lda #0
.c2189
    clc
    adc this_sprite_b,x                ; add sprite data Y coordinate
    adc #0                             ; add carry - note that there will only be carry when starting from
                                       ; this_sprite_height(rather than $00), in which case the bottom 3 bits
                                       ; will be clear (see plot_sprite_calculation_loop)
    asl a                              ; |
    adc #0                             ; | yyYYY0xx -> yYYY0xxy
    asl a                              ; |
    adc #0                             ; | yYYY0xxy -> YYY0xxyy
    sta zp_various_b

    and #&e0                           ; | YYY0000 (LSB of y*32)
    ora sprite_row_byte_offset
    adc #<sprite_data                  ; get LSB of sprite address
    sta line_loop + 1                  ; sprite_address
    lda zp_various_b                   ; YYY0xxyy
    and #&0f                           ; 0000xxyy (MSB of y*32)
    adc #>sprite_data
    sta line_loop + 2                  ; self modifying code
    
;;  Calculate the number of bytes in a line of the sprite

    lda this_object_screen_x_low,x     ; this_object_screen_x_low(_old)
    and #&10                           ; LSb
    adc this_sprite_width,x            ; this_sprite_width(_old)
    sta velocity_signs_OR_pixel_colour
    ror a
    and #&f0
    lsr a                              ; width*8?
    sta zp_various_6e
    lda this_sprite_a,x                ; this_sprite_a(_old)
    and #&30                           ; sprite data pixel X coordinate bits 0/1
    adc this_sprite_width,x            ; this_sprite_width(_old) - get inclusive width including an extra pixel if
                                       ; starting on an odd X coordinate
    ror a                              ; wwwww000
    lsr a                              ; 0wwwww00
    lsr a                              ; 00wwwww0
    lsr a                              ; 000wwwww
    tay
    lsr a                              ; /2
    lsr a                              ; /4 (since 4 pixel/byte)
    sta bytes_per_line_in_sprite
    
;;  Calculate the number of bytes in a line on the screen. The sprite data is
;;  unpacked into the stack - we also calculate where to put it.

    lda this_sprite_width,x            ; this_sprite_width(_old)
    lsr a
    lsr a
    lsr a
    lsr a                              ; remove the fractional bits
    sta zp_various_b                   ; sprite width in pixels
    tya
    and #3                             ; remainder due to 4 pixels/byte
    clc
    adc copy_of_stack_pointer_51
    sbc #1
    sta l2273 + 1                      ; self modifying code
    tax
    inx
    sbc zp_various_b
    sbc #2
    sta l2276 + 1                      ; self modifying code
    ldy #&ca                           ; &ca = DEX (right facing)
    bit this_sprite_partflip           ; plot_flipping_flags
    bpl c21eb
    tax
    dex
    ldy #&e8                           ; &e8 = INX (left facing)
.c21eb
    lda velocity_signs_OR_pixel_colour
    and #&10
    beq c21f5
    sty c21f4                          ; self modifying code
.c21f4
    inx                                ; either INX or DEX from &21f1
.c21f5
    stx bytes_per_line_on_screen
    sty plot_screen_loop               ; self modifying code
    sty c2282                          ; self modifying code

;;  Calculate the number of lines in the sprite

    ldx plotter_x
    lda this_sprite_height,x           ; this_sprite_height(_old)
    lsr a
    lsr a
    lsr a                              ; remove the fractional bits
    sta lines_in_sprite
    
;; Calculate the screen address of the sprite.
;;
;; 3 fractional bits for Y.

    lda this_object_screen_y_low,x     ; this_object_screen_y_low(_old)
    clc                                ; LSB of Y*8
    adc this_sprite_height,x           ; this_sprite_height(_old)
    sta zp_various_1b                  ; LSB address
    lda this_object_screen_y,x         ; this_object_screen_y(_old)
    adc #0                             ; MSB of Y*8
    sta zp_various_1c                  ; MSB address

; Currently have (Y+sprite_height)*8 in screen_address

    lda zp_various_1b
    lsr zp_various_1c:ror a            ; (Y+sprite_height)*4
    lsr zp_various_1c:ror a            ; (Y+sprite_height)*2
    lsr zp_various_1c:ror a            ; Y+sprite_height
    tay                                ; save LSB (for row)
    and #7                             ; get scanline, 0-7, in character row
    ora zp_various_6e                  ; width*8
    sta zp_various_6f                  ; use that as the offset
    ora #7                             ; get equivalent for scanline 7 in the row
    sta zp_various_6e                  ; that's the initial value for dest offset after moving to previous row
    lda this_object_screen_x_low,x     ; this_object_screen_x_low(_old)
    and #&e0                           ; %11100000
    adc #0
    sta zp_various_1b
    tya                                ; get LSB (for row) back again
    and #&f8                           ; get just the character row part
    eor this_object_screen_x,x         ; this_object_screen_x(_old) - ??guess this must just be 1-3 bits??
    adc #0                             ; ??add scrolling offset MSB, pre-scaled??

;; Ignoring the X coordinate's contribution, the accumulator value is
;; a row-aligned scanline coordinate: 0, 8, 16, 24, etc. Each
;; character rows is 512 ($200) bytes, so divide this value by 4 to
;; get the MSB of the base address for that character row.
;;
;; ??figure out the X values... they must be scaled already to make
;; this work??

    ror a:ror zp_various_1b           ; /2
    lsr a:ror zp_various_1b           ; /4
    adc #screen_base_page             ; make a screen address
    sta zp_various_1c                 ; save it

.plot_sprite_line
;;  For each byte in the sprite data, unpack it onto the stack.
    ldy bytes_per_line_in_sprite
.line_loop
    lda [(zp_0 - 1) AND &ffff],y       ; ABCDabcd
    tax                                ; ABCDabcd ABCDabcd
    and #&11                           ; 000D000d ABCDabcd
    sta l224d + 1
.l224d
    lda l00ff                          ; 0D0D0D0D [mode 2]
    pha                                ; push on to stack
    txa                                ; ABCDabcd
    and #&22                           ; 00C000c0
    sta l2256 + 1
.l2256
    lda l00ff                          ; C0C0C0C0 [mode 2]
    pha                                ; push on to stack
    txa                                ; ABCDabcd
    lsr a                              ; 0ABCDabc
    lsr a                              ; 00ABCDab
    tax
    and #&11                           ; 000B000b
    sta l2262 + 1
.l2262
    lda l00ff                          ; 0B0B0B0B [mode 2]
    pha                                ; push on to stack
    txa                                ; 00ABCDab
    and #&22                           ; 00A000a0
    sta l226b + 1
.l226b
    lda l00ff                          ; A0A0A0A0 [mode 2]
    pha                                ; push on to stack
    dey
    bpl line_loop                      ; loop for all input bytes 
    pha                                ; erm...?
    iny
.l2273                                 ; Y=0
    sty base_address + 255             ; actually &01XX from &21d5
.l2276
    sty base_address + 255             ; actually &01XX from &21de
    sec
    ldy zp_various_6f
    ldx bytes_per_line_on_screen

;;  Now take that data from the stack and plot it to the screen - if
;;  the plotting mode is set to overwrite, just plot it, otherwise
;;  consider what is there already - if it's background data (&80 is
;;  set), don't.

.plot_screen_loop
    dex                                ; actually either DEX or INX from &21f7
    lda base_address,x                 ; get left/right pixel from stack
.c2282
    dex                                ; actually either DEX or INX from &21fa
    ora base_address,x                 ; mask in other pixel from stack

;; This snippet is either EOR/BMI or BMI/EOR. `change_display_mode'
;; toggles between them.
;;
;; When EOR/BMI, the write will be skipped if this would replace
;; background on screen with sprite begin drawn.
;;
;; When BMI/EOR, this is background, and write will replace whatever's
;; on screen (though this isn't quite a perfect check as the N flag
;; only covers the left pixel - and you can sometimes tell).

.c2286
    eor (zp_various_1b),y              ; read the current screen data
.c2288
    bmi c228c                          ; actually either "EOR, BMI &106a" or "BMI &1068, EOR" from &22bf
    sta (zp_various_1b),y              ; plot the sprite to screen depending on plotting mode
.c228c
    tya                                ; offset in character row
    sbc #8                             ; next column
    tay
    bcs plot_screen_loop               ; taken if offset>=0
    ldx copy_of_stack_pointer_51
    txs                                ; reset stack pointer
    dec lines_in_sprite
    bmi plotting_done                  ; any more lines to do? if not, leave
    dec zp_various_6f                  ; next screen line next time
    
;; adjust sprite data address in initial LDA in sprite loop

    lda line_loop + 1
.l229e
    adc #&20                           ; actually ADC #sprite_byte_offset_between_rows from &217d
    sta line_loop + 1
    lda line_loop + 2
.l22a6
    adc #0                             ; actually ADC #sprite_byte_offset_between_rows_h from &2180
    sta line_loop + 2
    
;; if in line 7 of character row, when the bcs plot_screen_loop above falls
;; through, Y=&ff; line 6, &fe ... line 0, &f8. So if Y<&f9, Y=&f8,
;; meaning that was line 0 of the character row, so it's time to
;; advance to the previous character row.

    cpy #&f9
    bcs plot_sprite_line
    lda zp_various_6e
    sta zp_various_6f
; there are &200 bytes per line...
    lda zp_various_1c
    sbc #1                             ; actually SBC #2 - the BCS fell through, so carry is clear
    sta zp_various_1c
    jmp plot_sprite_line               ; do it all again for the next line

.plotting_done
    jmp object_redrawing_loop

.change_display_mode
    ldx #1                             ; swap &2286-2287 and &2288-&2289
.loop_c22c1
    lda c2286,x                        ; this changes the display mode between overwriting
    ldy c2288,x                        ; this changes the display mode between overwriting
    sta c2288,x
    tya
    sta c2286,x
    dex
    bpl loop_c22c1
.loop_c22d1
    rts

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    jsr setup_background_sprite_values
    cpy #&19                           ; is the square an empty space?
    beq loop_c22d1                     ; if so, leave
    lda #0
ENDIF

.sub_c22db
    sta skip_sprite_calculation_flags
    lda #0
    sta this_object_flags
    sta this_object_flags_old
    jmp plot_sprite                    ; this plots the background space

.background_lookup
    equb &19, &2d, &ed, &6d, &ad, &2d, &ed
    equb &5e, &9e,   0, &c0, &80, &40
    equb &2e, &2f, &2e, &23
    equb   6,   4,   6,   4,   7,   5,   5,   6, &19, &2c, &19, &2b,   0,   1
    equb   2,   3, &1a, &21,   9, &9b, &12, &10, &60, &2b, &0f, &4f,   4, &0a

.lookup_for_unmatched_hash
    equb &1b, &5a, &19, &19, &1e, &13, &24, &2c, &19

.wall_palette_zero_lookup
    ;;  lookup table for Y -> palette for background
    equb &8d, &82, &8b, &8f, &84, &89, &8d

.wall_palette_four_lookup
    equb &81, &82, &81, &85
    equb &b2, &cd, &90, &95, &81

.wall_palette_three_lookup
    equb &b1, &97, &fd, &f3

.palette_register_data_1
    ;;     0:black 1:red 2:green 3:yellow 4:blue 5:magenta 6:cyan 7:white
    ;;     8:black 9:red a:green b:yellow c:blue d:magenta e:cyan f:white
    equb   7, &16, &25, &34, &43, &52, &61, &70, &87, &96, &a5, &b4, &c3, &d2, &e1, &f0
.palette_register_data_2
    equb &37, &27, &17,   7, &77, &67, &57, &47, &b0, &a0, &90, &80, &f0, &e0, &d0, &c0
    equb 1, 0

.sub_c2352
    lda #0
    sta screen_offset_x_low
    sta screen_offset_y_low
    lda l001a
    sec
    sbc #2
    sta screen_offset_y_low_old
    lda l0018
    sbc #4
    sta screen_offset_x_low_old
    lda #&80
    sta background_processing_flag
    lda screen_offset_y_low_old
    sta square_y
    ldx #5
.loop_c2370
    txa
    pha
    lda screen_offset_x_low_old
    sta square_x
    ldx #8
.loop_c2378
    txa
    pha
    jsr sub_c2fe3
    inc square_x
    pla
    tax
    dex
    bne loop_c2378
    inc square_y
    pla
    tax
    dex
    bne loop_c2370
    rts

.f3_xy
    equb 0
.f2_xy
    equb 0

; returns A = ?square_sprite = background sprite for square (i.e., 0-63)
;
; Stores orientation flags (%xx000000) in square_orientation.
.determine_background
    ldx #0
    stx new_object_data_pointer
    jsr calculate_background
    sta square_sprite
    and #&c0
    sta square_orientation
    eor square_sprite                  ; = calculate_background &3f
    cmp #9
    bcs no_background_object

; is there a hash table point in this square?

    sta zp_various_b                   ; background_object_number
    tay                                ; a = 0 - 8
    ldx background_objects_range,y     ; use background_objects_range to determine where to look
    lda background_objects_x_lookup,x  ; in background_objects_x_lookup

; Try to find square_x in the table. The range to search is from
; (background_objects_range-1)[X] (inclusive) to
; background_objects_range[X] (exclusive). To simplify the loop
; condition, use a sentinel: set background_objects_range[X] to
; square_x. Check after the loop whether it was an actual entry that
; was found, or the sentinel.

    pha                                ; backup value of background_objects_x_lookup
    lda square_x
    sta background_objects_x_lookup,x  ; push square_x at the end of this range
    ldx background_objects_range_minus_one,y; get start index
    dex                                ; loop fudge
.loop_c23b4
    inx                                ; next item
    cmp background_objects_x_lookup,x  ; found square_x?
    bne loop_c23b4                     ; branch taken if square_x not found
    txa                                ; A = index of entry
    cmp background_objects_range,y     ; is it the sentinel value?
    bcs no_background_object_in_hash   ; taken if so - i.e., no entry

; data_pointer = square_x + background_objects_data_offset

    adc background_objects_data_offset,y
    sta new_object_data_pointer

; type_pointer = X + background_objects_data_offset + background_objects_type_offset

    clc
    adc background_objects_type_offset,y
    sta new_object_type_pointer
    lda background_objects_handler_lookup,x
    jmp c23d8                          ; use_background_object_from_hash

.no_background_object_in_hash
    ldx zp_various_b                   ; background_object_number
    lda lookup_for_unmatched_hash,x
    eor square_orientation

;;  use_background_object_from_hash
.c23d8
    sta square_sprite                  ; A = handler_lookup if in hash, square_sprite if not

; Undo sentinel.

    ldx background_objects_range,y
    pla
    sta background_objects_x_lookup,x

; Separate out orientation and sprite.

    lda square_sprite
    and #&c0
    sta square_orientation
    eor square_sprite

.no_background_object
    sta square_sprite
    cmp #&10
    bcs no_objects_to_create           ; do we need to create a background object?
    tsx
    stx copy_of_stack_pointer          ; store the stack pointer
    tax
    lda object_handler_table_h,x
    bit background_processing_flag     ; does background_processing_flag match the background object?
    beq c2403                          ; if set, call background object handlers
    and #&0f
    ldy new_object_data_pointer
    jsr handle_background_object
.c2403
    lda square_sprite
.no_objects_to_create
    rts

;;  First, determine whether we should use mapped data or not
.calculate_background
    lda square_y
    tax
    lsr a
    eor square_x
    and #&f8
    lsr a
    adc square_x
    lsr a
    adc square_y
    sta zp_various_b                   ; f_xy is a function of square_x and square_y
    txa                                ; A = square_y
    cmp #&79
    bcc c2421                          ; taken if square_y<0x79
    cmp #&bf
    bcc not_mapped2                    ; taken if square_y<0xbf

; before: square_y = 0xc0 ... 0xff
; after:  square_y = 0x7a ... 0xb9

    sbc #&46                           ; y >= &c0 ; y -= &46;

.c2421
; A = square_y
    cmp #&48
    bcs c242b                          ; taken if square_y>=0x48
    cmp #&3e
    bcs not_mapped2                    ; taken if square_y>=0x3e

; before: square_y = 0x00 ... 0x3d
; after:  square_y = 0x0a ... 0x47

    adc #&0a

.c242b
    sta f2_xy                          ; at this point, a function of square_y
    and #&a8
    eor #&6f
    lsr a
    adc square_x
    eor #&60
    adc #&28
    sta f3_xy                          ; f3_xy is another function of square_x and square_y
    and #&38
    eor #&a4
    adc f2_xy
    sta f2_xy                          ; f2_xy a function of square_x and square_y
    tay                                ; A is f2_xy
    eor #&2c
    adc f3_xy                          ; A is a function of f2_xy and f3_xy
    cpy #&20
    bcs not_mapped2                    ; taken if f2_xy>=0x20
    cmp #&20
    bcs not_mapped                     ; if A >= &20, don't use mapped data
    tay                                ; Y = A = f(f2_xy,f3_xy)
    asl a
    asl a
    asl a
    eor f2_xy
    sta map_address                    ; &72 = (A * 8) ^ &10;
    tya                                ; A = Y = f(f2_xy,f3_xy)
    and #3
    adc #>map_data
    sta map_address + 1                ; &73 = (A & 3) + &45;
    ldy #<map_data                     ; &e0 ; &41e0 - &45e0
    lda (map_address),y                ; use mapped data
    rts

.loop_c2469
    jmp c25b3

.via_return_background_empty
    jmp return_background_empty

;  If not mapped data, are we on or above the surface?
;
.not_mapped
    cmp #&3d
    bcc via_return_background_empty
.not_mapped2
    cpx #&4e                           ; if square_y < &4e, return empty space
    bcc via_return_background_empty
    beq loop_c2469                     ; if square_y = &4e, return bushes
    cpx #&4f
    bne below_surface
    lda square_x                       ; if square_y = &4f, do surface
    cmp #&40
    beq return_background_grass_frond  ; force (&40, &4f) to be a grass frond
    ldy #1
    jmp via_background_is_114f_lookup_with_y ; otherwise, return wall

.return_background_grass_frond
    lda #&62                           ; &62 = grass frond
    rts

;;  Things get rather hairy below the surface...
.below_surface
    ldy zp_various_b                   ; f_xy
    lda #0
    sta zp_various_b
    lda square_x
    bit square_y
    bmi c249e
    adc #&1d
    cmp #&5e ; '^'
    jmp c24a2

.c249e
    adc #7
    cmp #&2b ; '+'
.c24a2
    bcc c24f9
    tya
    and #&e8
    cmp square_y
    bcc c24f9
    sty zp_various_b
    txa
    asl a
    adc square_y
    lsr a
    adc square_y
    and #&e0
    adc square_x
    and #&e8
    bne no_mushrooms
    lda square_y
    bpl via_return_background_empty    ; no mushrooms if square_y < &80
    lda square_x
    lsr a
    lsr a
    lsr a
    tax
.return_background_mushrooms
    lda #&0e                           ; &0e = mushrooms (on floor)
    cpx #&0a
    bne c24ce
    lda #&8e                           ; &8e = mushrooms (on ceiling)
.c24ce
    rts

.no_mushrooms
    tya                                ; Y = f_xy
    lsr a
    lsr a
    and #&30
    lsr a
    adc square_x
    lsr a
    eor square_x
    lsr a
    eor square_x
    adc square_x
    and #&fd
    eor square_x
    and #7
    bne c24f5
    lda square_x
    bmi c24f2
    lsr a
    adc square_y
    and #&30
    beq c24f5
.c24f2
    lda #8                             ; return hash point 8
    rts

.c24f5
    cpx #&52
    bcs c24fc
.c24f9
    jmp background_is_114f_lookup_with_top_of_9d

.c24fc
    tya
    and #&68 ; 'h'
    adc square_y
    lsr a
    adc square_y
    lsr a
    adc square_y
    and #&fc
    eor square_y
    and #&17
    bne c255b
    tya
    adc square_x
    and #&50 ; 'P'
    beq return_background_empty
    and square_x
    lsr a
    lsr a
    adc square_y
    lsr a
    lsr a
    and #&0f
    cmp #8
    bcc c252c
    bit zp_various_b
    bvc c253e
    ora #4
    bne c253e
.c252c
    sta sprite_row_byte_offset
    eor #5
    cmp #6
    lda sprite_row_byte_offset
    bcs c253e
    tya
    lsr a
    adc square_y
    eor square_x
    and #7
.c253e
    clc
    adc #&1d
    pha
    jsr some_background_calc_thing
    pla
    bcc return_background_empty
    tay
    lda background_lookup,y
    ldy square_y
    cpy #&e0
    bne return_background_empty
    eor #&40 ; '@'
.return_background_empty
    ldy #0
.background_is_114f_lookup_with_y
    sec
    lda background_lookup,y
    rts

.c255b
    jsr some_background_calc_thing
    bcs background_is_114f_lookup_with_top_of_9d
    cpy #0
    beq background_is_114f_lookup_with_y ; empty space
    lda zp_various_b
    pha
    sty sprite_row_byte_offset
    rol a
    rol a
    rol a
    and #1
    rol a
    tay
    pla
    adc square_x
    rol a
    eor square_y
    and #&1a
    bne c258f
    tya
    ldy sprite_row_byte_offset
    eor background_lookup + 7,y
    and #&7f
    cmp #&40
    rol a
    and #7
    tax
    lda background_lookup + 17,x
    eor background_lookup + 7,y
    rts

.c258f
    lda background_lookup + 13,y
    ldy sprite_row_byte_offset
    eor background_lookup + 7,y
    rts

.background_is_114f_lookup_with_top_of_9d
    lda zp_various_b
    lsr a
    lsr a
    lsr a
    and #&0e
    lsr a
    adc #1
    tay
.via_background_is_114f_lookup_with_y
    jmp background_is_114f_lookup_with_y

.loop_c25a6
    adc square_x
    rol a
    rol a
    rol a
    and #2
    adc #&19
    tay
    jmp background_is_114f_lookup_with_y

.c25b3
    ldy #&19
    lda square_x
    lsr a
    adc square_x
    and #&17
    bne loop_c25a6
    ror zp_various_b
    ror a
    rts

.some_background_calc_thing
    txa
    lsr a
    eor square_y
    and #6
    bne c25ed
    tya
    ldy #2
    and #&20
    asl a
    asl a
    eor #&e5
    sta c25dd                          ; self modifying code
    bmi c25da
    ldy #4
.c25da
    txa
    adc #&16
.c25dd
    adc square_x
    and #&5f
    tax
    dex
    cpx #&0c
    bcc c261f
    beq c2621
    iny
    inx
    beq c2621
.c25ed
    lda square_x
    lsr a
    lsr a
    lsr a
    lsr a
    bcs c261e
    lda #1
    adc square_x
    adc square_y
    and #&8f
    cmp #1
    beq c261f
    tax
    sec
    lda square_y
    sbc square_x
    and #&2f
    cmp #1
    beq c261f
    ldy #2
    cmp #2
    beq c2621
    iny
    bcc c2621
    iny
    cpx #2
    beq c2621
    iny
    bcc c2621
.c261e
    rts

.c261f
    ldy #0
.c2621
    clc
    rts

.handle_background_object
    tsx
    stx copy_of_stack_pointer
    ldx square_sprite
    bpl c262f                          ; we've already got A and calculated h of our handler
.handle_current_object
    tax
    lda object_handler_table_h,x       ; Calculate address of object handler
.c262f
    pha
    lda object_handler_table,x
    clc
    adc #<(handlers_start - 1)         ; -1 to account for RTS logic
    tax
    pla
    and #&3f
    adc #>(handlers_start - 1)         ; -1 to account for RTS logic
    pha                                ; high = ((&18cd, type + &14)) & 3f) + &3e
    txa
    pha                                ; low = (&1854, type + &14) + &1a
    ldx this_object_data
    txa
    cpy #0
    rts                                ; Call the object handler we've put on stack

.process_objects
    ldx #0                             ; start with object 0
.c2647
    stx current_object
    lda object_stack_y,x               ; is there an object here?
    bne process_object                 ; if so, process it
    jmp next_object

.process_object
    lda object_stack_y,x               ; pull object's details from object stack into registers
    sta this_object_y                  ; keeping a copy of them before they're changed
    sta this_object_y_old
    lda object_stack_flags,x
    sta this_object_flags
    sta this_object_flags_old
    sta this_object_angle
    asl a
    sta this_object_flags_lefted
    lda object_stack_x,x
    sta this_object_x
    sta this_object_x_old
    lda object_stack_x_low,x
    sta this_object_x_low
    sta this_object_x_low_old
    lda object_stack_y_low,x
    sta this_object_y_low
    sta this_object_y_low_old
    lda object_stack_sprite,x
    sta this_object_sprite
    sta this_object_sprite_old
    lda object_stack_palette,x
    sta this_object_palette
    sta this_object_palette_old
    lda object_stack_type,x
    sta this_object_type
    lda object_stack_data_pointer,x
    sta this_object_data_pointer
    lda object_stack_tx,x
    sta this_object_tx
    lda object_stack_ty,x
    sta this_object_ty
    lda object_stack_extra,x
    sta this_object_extra
    ldx this_object_sprite
    lda sprite_width_lookup,x
    and #&f0
    sta this_object_width
    lda sprite_height_lookup,x
    and #&f8
    sta this_object_height
    ldx this_object_data_pointer
    lda background_objects_data,x
    sta this_object_data
    lda this_object_type
    clc
    adc #&14
    ldy #&ff
    jsr handle_current_object
    clc
    lda this_object_flags_old
    ror a
    ror a
    and #&c0
    sta sprite_row_byte_offset
    lsr a
    lsr a
    ora sprite_row_byte_offset
    sta skip_sprite_calculation_flags
    lda this_object_angle
    asl a
    lda this_object_flags_lefted
    ror a
    and #&c0
    sta this_object_flipping_flags
    lda this_object_flags
    and #&c0
    sta this_object_flipping_flags_old
    eor this_object_flags
    eor this_object_flipping_flags
    and #&f7
    sta this_object_flags
;;  Push the object's details back into the object stack
    ldx current_object
    lda this_object_y
    sta object_stack_y,x
    lda this_object_x
    sta object_stack_x,x
    lda this_object_x_low
    sta object_stack_x_low,x
    lda this_object_flags
    sta object_stack_flags,x
    lda this_object_y_low
    sta object_stack_y_low,x
    lda this_object_sprite
    sta object_stack_sprite,x
    lda this_object_palette
    sta object_stack_palette,x
    lda this_object_type
    sta object_stack_type,x
    lda this_object_data_pointer
    sta object_stack_data_pointer,x
    lda this_object_tx
    sta object_stack_tx,x
    lda this_object_ty
    sta object_stack_ty,x
    lda this_object_extra
    sta object_stack_extra,x
    jsr plot_object
    ldx current_object
.next_object
    inx
    cpx #&10                           ; sixteen objects
    bcs c2733
    jmp c2647                          ; loop for next one
.c2733
    rts

.background_processing_flag
    equb 0

.pixel_table
    ;                                    ABCDEFGH
    equb 0                             ; 00000000 0  0  
    equb 3                             ; 00000011 1  1  
    equb &c                            ; 00001100 2  2  
    equb &f                            ; 00001111 3  3  
    equb &30                           ; 00110000 4  4  
    equb &33                           ; 00110011 5  5  
    equb &3c                           ; 00111100 6  6  
    equb &3f                           ; 00111111 7  7  
    equb &c0                           ; 11000000 8  8  
    equb &c3                           ; 11000011 9  9  
    equb &cc                           ; 11001100 10 10
    equb &cf                           ; 11001111 11 11
    equb &f0                           ; 11110000 12 12
    equb &f3                           ; 11110011 13 13
    equb &fc                           ; 11111100 14 14
    equb &ff                           ; 11111111 15 15

    equb 0, 0

.reserve_object_high_priority
    ldy #0
    equb &2c                           ; overlapping BIT &xxxx

.reserve_object
    ldy #1
    equb &2c                           ; overlapping BIT &xxxx

.reserve_object_low_priority
    ldy #4
;;  A = type of object to create
;;  Y = number of slots that must be free for success
;;  &53 = x
;;  &55 = y

.reserve_objects
    sta sprite_row_byte_offset         ; store desired object type
    stx l0009                          ; ensure we leave with X unchanged
    ldy #&ff
.loop_c2755
    iny
    cpy #&10                           ; sixteen objects
    bcs c2796                          ; if no free slots, leave with C set
    lda object_stack_y,y               ; is this slot free?
    bne loop_c2755                     ; if not, keep searching
    ldx sprite_row_byte_offset         ; actually LDX #object_type, from &1ec5
    lda object_palette_lookup,x        ; object_palette_lookup
    and #&7f
    sta object_stack_palette,y         ; store palette & &7f
    lda object_sprite_lookup,x
    sta object_stack_sprite,y          ; store sprite
    lda #1
    sta object_stack_flags,y           ; store flags = 1
    lda #&ff
    sta object_stack_supporting,y      ; supporting nothing
    tya
    sta object_stack_target,y          ; store target = object's own number
    lda #0
    sta object_stack_data_pointer,y
    sta object_stack_extra,y
    sta object_stack_timer,y           ; store timer = 0
    sta object_stack_vel_x,y           ; store x velocity = 0
    sta object_stack_vel_y,y           ; store y velocity = 0
    txa
    sta object_stack_type,y            ; store object_type
    jsr store_object_x_y_in_stack      ; store &53 in x, &55 in y
    clc
.c2796
    ldx l0009                          ; ensure we leave with X unchanged
    rts

.copy_of_stack_pointer
    equb 0

.setup_background_sprite_values
    jsr determine_background

; (08 refers to square_sprite and 09 to square_orientation.)
.setup_background_sprite_values_from_08_09
    tay                                ; Y = square_sprite
    lda background_palette_lookup,y    ; what's the palette for this sprite?
    bne palette_not_zero               ; palette_defined

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

    lda square_y
    sec
    sbc #&54                           ; square_y-$54
    lsr a                              ; /2
    lsr a                              ; /4
    lsr a                              ; /8
    lsr a                              ; /16
    tax
    lda wall_palette_zero_lookup,x     ; array lookup

.palette_not_zero
    cmp #3
    bcs palette_not_two                ; taken if >=3

; palette is 1 or 2 - function of square_y<0x80
;
; square_y<0x80?0xb1+palette:(0xb1+palette)<<1+0x91

    adc #&b1                           ; palette is $B2 (1) or $B3 (2)
    bit square_y
    bpl palette_not_six                ; taken if square_y<0x80

; square_y>=0x80

    asl a                              ; palette is $64 (1) or $66 (2), and C set
    adc #&90                           ; palette is $f5 (1) or $f7 (2)

.palette_not_two
    cmp #3
    bne palette_not_three

; palette is 3 - function of x, y and orientation

    lda square_orientation             ; C=1 %ab000000
    rol a                              ; C=a %b0000001
    rol a                              ; C=b %0000001a
    rol a                              ; C=0 %000001ab
    sbc square_y                       ; um
    ror a                              ; ...
    clc                                ; ???
    adc square_x                       ; ...
    and #3                             ; it's only 2 bits though
    tax
    lda wall_palette_three_lookup,x

.palette_not_three
    cmp #4
    bne palette_not_four

; palette is 4 - it's wall_palette_four_lookup[square_y>>4&7]

    lda square_y
    rol a
    rol a
    rol a
    rol a
.c27dc
    and #7
    tax
    lda wall_palette_four_lookup,x

.palette_not_four
    cmp #5
    bne palette_not_five

; palette is 5 - a function of y and orientation

    lda square_y
    ror a
    ror a
    eor square_y
    ror a
    bcc c27f1
    ldy #&19
.c27f1
    ror a
    sbc square_y
    and #&40
    eor square_orientation
    bit square_orientation
    sta square_orientation
    lda #&b1
    bvc palette_not_six
    adc #&0a

.palette_not_five
    cmp #6
    bne palette_not_six

; palette is 6 - a function of orientation

    lda #&9c
    bit square_orientation
    bvc palette_not_six
    lda #&cf

.palette_not_six
    sta this_object_palette            ; set the palette for this square
    sta this_object_palette_old
    lda square_orientation
    sta this_object_flipping_flags     ; set the orientation for this square
    sta this_object_flipping_flags_old

; Translate background sprite to object sprite.

    lda background_sprite_lookup,y
    and #&7f                           ; mask off the extra flag
    tax
    sta this_object_sprite
    sta this_object_sprite_old

; Adjust Y coordinate.

    lda background_y_offset_lookup,y   ; Y = background sprite
    and #&f0                           ; %11110000
    bit square_orientation
    bvc c2832                          ; taken if not flipped vertically
    adc sprite_height_lookup,x         ; adjust Y to account for flip
    ora #7                             ; (the lower bits of sprite_height_lookup are used for something)
    eor #&ff                           ; negate???
.c2832
    sta this_object_y_low              ; y position of start of square sprite
    sta this_object_y_low_old
    lda #0
    bit square_orientation
    bpl c2841                          ; taken if not flipped horizontally
    lda #&f2                           ; %11110010
    sbc sprite_width_lookup,x
.c2841
    sta this_object_x_low
    sta this_object_x_low_old          ; x position of start of square sprite
    lda square_x
    sta this_object_x
    sta this_object_x_old
    lda square_y
    sta this_object_y
    sta this_object_y_old
    rts

.set_object_x_y_tx_ty_to_square_x_y
    lda square_x
    sta object_stack_x,y
    lda square_y
    sta object_stack_y,y
    rts

.store_object_x_y_in_stack
    lda this_object_x
    sta object_stack_x,y
    lda this_object_y
    sta object_stack_y,y
    rts

    equb   0, &ea,   0, &0f, &ea,   7, &f0, &ea, &f8, &20, &ea, &80, &ea, &10
    equb &ea, &40, &ff

.make_negative
    clc
    bmi c2880
    eor #&ff
    adc #1
.c2880
    rts

.sei_test_for_swram
    sei
    jsr test_for_swram
    cli
    rts

.test_for_swram
{
    ldx #maxBank
.loop_01
    lda #&0f

IF SWRAM_FE6x = TRUE
    sta user_via_ddrb
    stx user_via_orb_irb
ELIF SWRAM_FE6x = NOP
    nop:nop:nop
    nop:nop:nop
ENDIF

    stx lfe32
    stx romsel
    ldy #<swram_base_addr
    sty zp_various_1b
    lda #>swram_base_addr
    sta zp_various_1c
.loop_02
    lda (zp_various_1b),y
    sta zp_various_b
    lda #%10101010
    sta (zp_various_1b),y
    cmp (zp_various_1b),y
    bne test_next_bank
    lda #%01010101
    sta (zp_various_1b),y
    cmp (zp_various_1b),y
    bne test_next_bank
    lda zp_various_b
    sta (zp_various_1b),y
    iny
    bne loop_02
    inc zp_various_1c
    lda zp_various_1c
    cmp #>(swram_base_addr + swram_bank_size)
    bcc loop_02
    rts

.test_next_bank
    dex
    bpl loop_01
    clc
    rts
}

.table_03a
    equb 0, 0, 0, 0
.table_03b
    equb 0, 0, 0, 0
.table_03c
    equb 0, 0, 0, 0
.table_03d
    equb 0, 0, 0, 0
.table_03e
    equb 0, 0, 0, 0
.table_03f
    equb 0, 0, 0, 0

.sub_c28e0
    asl table_03e
    rol table_03e + 1
    rol table_03e + 2
    rol table_03e + 3
    rts

.sub_c28ed
    jsr c3180
    ldx #&18
    lda #0
.loop_c28f4
    sta table_03a - 1,x
    dex
    bne loop_c28f4
    ldy #3
.loop_c28fc
    lda player_deaths - 1,y
    sta table_03e - 1,y
    dey
    bne loop_c28fc
    sty table_03f - 1
    ldx #2
.c290a
    ldy #3
.loop_c290c
    lda table_03e,y
    pha
    dey
    bpl loop_c290c
    jsr sub_c28e0
    jsr sub_c28e0
    clc
    ldy #&fc
.loop_c291c
    pla
    adc table_03e - &fc,y
    sta table_03e - &fc,y
    iny
    bne loop_c291c
    jsr sub_c28e0
    dex
    bne c290a
    jsr sub_c2e08
    ldy #4
.loop_c2931
    lda this_object_sprite_old,y
    sta table_03d - 1,y
    dey
    bne loop_c2931
    ldx #4
    ldy #0
.c293e
    dex
    bmi c295f
    lda clawed_robot_availability,x
    beq c293e
    bmi c293e
    tya
    pha
    txa
    pha
    clc
    adc #&22
    jsr sub_c2b89
    sty zp_various_b
    pla
    tax
    pla
    tay
    lda zp_various_b
    bne c293e
    iny
    bne c293e
.c295f
    tya
    tax
    beq c296d
.loop_c2963
    lda #&88
    ldy #&13
    jsr sub_c2a6e
    dex
    bne loop_c2963
.c296d
    lda background_objects_data_3 + 69
    and #8
    beq c297b
    lda #&28
    ldy #&23
    jsr sub_c2a7a
.c297b
    lda #2
    jsr sub_c2ac8
    ldx l2ac7
    beq c298f
.loop_c2985
    lda #&20
    ldy #&4e
    jsr sub_c2a7a
    dex
    bne loop_c2985
.c298f
    lda background_objects_data_2 + 7
    ror a
    bcs c299c
    lda #&20
    ldy #&4e
    jsr sub_c2a7a
.c299c
    lda desired_water_level_by_x_range + 1
    bmi c29a8
    lda #&20
    ldy #&4e
    jsr sub_c2a7a
.c29a8
    ldx #0
.c29aa
    txa
    pha
    lda table_01c,x
    jsr sub_c2ac8
    pla
    tax
    lda table_01a,x
    sec
    sbc l2ac6
    bcc c29fa
    sta zp_various_b
    lda table_01b,x
    jsr sub_c2a4a
    ldy #2
.loop_c29c7
    lda l001e
    pha
    lda l001d
    asl l001d
    rol l001e
    asl l001d
    rol l001e
    adc l001d
    sta l001d
    pla
    adc l001e
    sta l001e
    dey
    bne loop_c29c7
    lda table_01c,x
    stx zp_various_b
    ldx #0
    cmp #4
    bcs c29ed
    ldx #4
.c29ed
    cmp #&4a
    bcc c29f3
    ldx #8
.c29f3
    lda l001d
    ldy l001e
    jsr c2a8c
.c29fa
    inx
    cpx #table_01b - table_01a
    bne c29aa
    ldx #0
    jsr sub_c2a28
    ldx #4
    jsr sub_c2a39
    ldx #8
    jsr sub_c2a28
    ldx #&0c
    jsr sub_c2a39
    ldx #&10
    jsr sub_c2a39
    lda table_03f + 3
    bpl c2a27
    ldx #4
    lda #0
.loop_c2a21
    sta table_03f - 1,x
    dex
    bne loop_c2a21
.c2a27
    rts

.sub_c2a28
    clc
    ldy #&fc
.loop_c2a2b
    lda table_03f - &fc,y
    adc table_03a,x
    sta table_03f - &fc,y
    inx
    iny
    bne loop_c2a2b
    rts

.sub_c2a39
    sec
    ldy #&fc
.loop_c2a3c
    lda table_03f - &fc,y
    sbc table_03a,x
    sta table_03f - &fc,y
    inx
    iny
    bne loop_c2a3c
    rts

.sub_c2a4a
    sta zp_various_1b
    lda #0
    sta zp_various_1c
    sta l001d
    sta l001e
.loop_c2a54
    lsr zp_various_b
    bcc c2a65
    clc
    lda zp_various_1b
    adc l001d
    sta l001d
    lda zp_various_1c
    adc l001e
    sta l001e
.c2a65
    asl zp_various_1b
    rol zp_various_1c
    lda zp_various_b
    bne loop_c2a54
    rts

.sub_c2a6e
    stx zp_various_b
    ldx #0
    bpl c2a8c
    stx zp_various_b
    ldx #4
    bpl c2a8c
.sub_c2a7a
    stx zp_various_b
    ldx #8
    bpl c2a8c
    stx zp_various_b
    ldx #&0c
    bpl c2a8c
    stx zp_various_b
    ldx #&10
    bpl c2a8c
.c2a8c
    clc
    adc table_03a,x
    sta table_03a,x
    tya
    adc table_03a + 1,x
    sta table_03a + 1,x
    lda #0
    adc table_03a + 2,x
    sta table_03a + 2,x
    lda #0
    adc table_03a + 3,x
    sta table_03a + 3,x
    ldx zp_various_b
    rts

.update_table_01a
    ldx #0
.loop_c2aaf
    txa
    pha
    lda table_01c,x
    jsr sub_c2ac8
    pla
    tax
    lda l2ac6
    sta table_01a,x
    inx
    cpx #table_01b - table_01a
    bne loop_c2aaf
    rts

.l2ac5
    equb 0
.l2ac6
    equb 0
.l2ac7
    equb 0

.sub_c2ac8
    sta l2ac5
    ldy #0
    sty l2ac7
    jsr sub_c2b89
    sty l2ac6
    lda l2ac5
    jsr sub_c2b6e
    lda l2ac5
    jsr sub_c2ae3
    rts

.sub_c2ae3
    ldy #0
    ldx background_objects_range_minus_one,y
.c2ae8
    tya
    pha
    txa
    pha
    clc
    adc background_objects_data_offset,y
    sta new_object_data_pointer
    clc
    adc background_objects_type_offset,y
    sta new_object_type_pointer
    lda background_objects_handler_lookup,x
    and #&3f
    cmp #9
    beq c2b26
    cmp #&0a
    beq c2b26
    cmp #6
    beq c2b43
    cmp #5
    beq c2b43
    cmp #7
    beq c2b43
    cmp #2
    beq c2b5a
.c2b15
    pla
    tax
    pla
    tay
    inx
    txa
    cmp background_objects_range,y
    bne c2ae8
    iny
    cpy #9
    bne c2ae8
    rts

.c2b26
    ldx new_object_type_pointer
    lda background_objects_type,x
    cmp l2ac5
    bne c2b15
    ldx new_object_data_pointer
    lda background_objects_data,x
    lsr a
    lsr a
    and #&1f
    clc
    adc l2ac6
    sta l2ac6
    jmp c2b15

.c2b43
    ldx new_object_type_pointer
    lda background_objects_type,x
    cmp l2ac5
    bne c2b15
    ldx new_object_data_pointer
    lda background_objects_data,x
    bpl c2b15
    inc l2ac6
    jmp c2b15

.c2b5a
    ldx new_object_data_pointer
    lda background_objects_data,x
    bpl c2b15
    and #&7f
    cmp l2ac5
    bne c2b15
    inc l2ac6
    jmp c2b15

.sub_c2b6e
    ldx #&20
.loop_c2b70
    ldy secondary_object_stack_x + 31,x
    beq c2b85
    cmp secondary_object_stack_y + 31,x
    bne c2b85
    inc l2ac6
    pha
    lda secondary_object_stack_x + 31,x
    jsr sub_c2bb4
    pla
.c2b85
    dex
    bne loop_c2b70
    rts

.sub_c2b89
    ldx #&0f
    ldy #0
    sta zp_various_b
.c2b8f
    lda object_stack_y,x
    beq c2bb0
    lda object_stack_type,x
    cmp #&49
    bne c2ba5
    sty sprite_row_byte_offset
    ldy object_stack_data_pointer,x
    lda background_objects_data,y
    ldy sprite_row_byte_offset
.c2ba5
    cmp zp_various_b
    bne c2bb0
    iny
    lda object_stack_y,x
    jsr sub_c2bb4
.c2bb0
    dex
    bpl c2b8f
    rts

.sub_c2bb4
    sec
    sbc #&3a
    cmp #4
    bcs c2bbe
    inc l2ac7
.c2bbe
    rts

IF REMOVE_DEAD_CODE = FALSE
; Unreferenced data 
 equb &ff,   0, &e0,   0,   7,   0, &c0,   0,   4,   0
    equs "&$", '"'
ENDIF

IF FILE_SYSTEM = ADFS
.print_insert_own_disc_and_wait
    ldx #<insert_own_disc_txt
    ldy #>insert_own_disc_txt
    jsr print_txt
.loop_c29d3
    jsr get_keypress
    cmp #cr
    bne loop_c29d3
    rts

.print_insert_exile_disc_and_wait
    ldx #<insert_exile_disc_txt
    ldy #>insert_exile_disc_txt
    jsr print_txt
.loop_c29e2
    jsr get_keypress
    cmp #cr
    bne loop_c29e2
    jsr setup_crtc
    rts
ELSE

IF REMOVE_DEAD_CODE = FALSE
.empty_routine
    rts

; Uncalled code
    rts
ENDIF
ENDIF

IF FILE_SYSTEM = ADFS
.get_drive_number
    jsr setup_pointers
    ldx #<directory_txt
    ldy #>directory_txt
    jsr print_txt
    jsr get_filename
    lda osfile_filename
    cmp #cr
    beq c2a14
    ldy #&ff
.loop_c2a03
    iny
    lda osfile_filename,y
    sta osfile_path + 3,y
    sta directory_name_txt,y
    cmp #cr
    bne loop_c2a03
    sty osfile_path_pointer
.c2a14
    ldx #<drive_txt
    ldy #>drive_txt
    jsr print_txt
    lda #&ff
    sta l3451
    jsr sub_c3170
.loop_c2a23
    jsr get_keypress
    cmp #cr
    beq c2a41
    sec
    sbc #&30                           ; '0'
    cmp #8
    bcs loop_c2a23
    adc #&30                           ; '0'
    sta osfile_path + 1
    sta catalogue_txt + 4
    jsr oswrch                         ; Write character
    lda #cr
    jsr oswrch                         ; Write character 13
.c2a41
    jsr oswrch                         ; Write character
    rts

ELIF FILE_SYSTEM = DFS
.get_drive_number
    jsr setup_pointers
    ldx #<drive_txt
    ldy #>drive_txt
    jsr print_txt
    lda #&ff
    sta l3451
    jsr sub_c3170
.loop_c2be0
    jsr get_keypress
    cmp #cr
    beq c2bfe
    sec
    sbc #&30                           ; '0'
    cmp #4
    bcs loop_c2be0
    adc #&30                           ; '0'
    sta osfile_path_and_filename + 1
    sta catalogue_txt + 4
    jsr oswrch                         ; Write character
    lda #cr
    jsr oswrch                         ; Write character 13
.c2bfe
    jsr oswrch                         ; Write character
    rts

ELIF REMOVE_DEAD_CODE = FALSE
.get_drive_number
    jsr setup_pointers
    ldx #<drive_txt
    ldy #>drive_txt
    jsr print_txt
    lda #&ff
    sta l3451
    jsr sub_c3170
.loop_c2be0
    jsr get_keypress
    cmp #cr
    beq c2bfe
    sec
    sbc #&30                           ; '0'
    cmp #4
    bcs loop_c2be0
    adc #&30                           ; '0'
    sta osfile_path_and_filename + 1
    sta catalogue_txt + 4
    jsr oswrch                         ; Write character
    lda #cr
    jsr oswrch                         ; Write character 13
.c2bfe
    jsr oswrch                         ; Write character
    rts
ENDIF
    
.show_catalogue_code
    jsr setup_crtc
IF FILE_SYSTEM = ADFS
    jsr print_insert_own_disc_and_wait
    jsr get_drive_number
ELIF REMOVE_DEAD_CODE = FALSE
    jsr empty_routine
ENDIF

IF FILE_SYSTEM = DFS
    jsr get_drive_number
ENDIF
    jsr sub_c2ffb
    ldx #<(catalogue_txt)
    ldy #>(catalogue_txt)
    jsr oscli
    jmp wait_cr_spc_display_menu

IF FILE_SYSTEM = ADFS
.directory_txt
    equb &11, &21, cr, lf
    equs "Directory?", cr
    equb lf, lf, &3f, &11, &77,   0
.drive_txt
    equb &11, &21, cr, lf
    equs "Drive?"
    equb &11, &77,   0
ELSE

IF FILE_SYSTEM = DFS
.drive_txt
    equb &11, &21, cr, lf
    equs "Drive?"
    equb &11, &77,   0
ELIF REMOVE_DEAD_CODE = FALSE
.drive_txt
    equb &11, &21, cr, lf
    equs "Drive?"
    equb &11, &77,   0
ENDIF
ENDIF

.sub_c2c25
    dec l2c63
    bpl c2c31
    inc l2c63
    ldy #4
    bne c2c3d
.c2c31
    dec l2c63 + 1
    lda l2c63 + 1
    and #3
    sta l2c63 + 1
    tay
.c2c3d
    lda teleports_x,y
    sta object_stack_x
    lda teleports_y,y
    sta object_stack_y
    ldx object_stack_sprite
    lda sprite_width_lookup,x
    lsr a
    eor #&ff
    adc #&80
    sta object_stack_x_low
    lda sprite_height_lookup,x
    lsr a
    eor #&ff
    adc #&80
    sta object_stack_y_low
    rts

.l2c63
    equb 0, 0

.save_position_code
IF FILE_SYSTEM = ADFS
    jsr initialise_screen
    jsr print_insert_own_disc_and_wait
    ldx #<save_filename_txt
    ldy #>save_filename_txt
    jsr print_txt
    jsr get_filename
    ldy #0
.loop_c2acf
    lda osfile_filename,y
    sta filename_table_2_txt,y
    iny
    cmp #cr
    bne loop_c2acf
    jsr copy_save_table_to_osfile_control_block
    jsr get_drive_number
    ldy osfile_path_pointer
    lda #&2e
    sta osfile_path + 3,y
    ldx #&ff
.loop_c2aea
    iny
    inx
    lda filename_table_2_txt,x
    sta osfile_path + 3,y
    cmp #cr
    bne loop_c2aea
ELSE
    jsr initialise_screen
IF REMOVE_DEAD_CODE = FALSE
    jsr empty_routine
ENDIF
    ldx #<save_filename_txt
    ldy #>save_filename_txt
    jsr print_txt
    jsr get_filename
    jsr copy_save_table_to_osfile_control_block
IF FILE_SYSTEM = DFS
    jsr get_drive_number
ENDIF
ENDIF
    lda #osfile_save
    ldx #<(osfile_control_block)
    ldy #>(osfile_control_block)
    jsr osfile                         ; Save a block of memory (returning file length and attributes) (A=0)
    lda #3
    sta l351f
    jsr format_filename_table_txt
    jmp display_menu

.load_position_code
IF FILE_SYSTEM = ADFS
    jsr initialise_screen
    jsr print_insert_own_disc_and_wait
    ldx #<load_filename_txt
    ldy #>load_filename_txt
    jsr print_txt
    jsr get_filename
    ldy #0
.loop_c2b1c
    lda osfile_filename,y
    sta filename_table_2_txt,y
    iny
    cmp #cr
    bne loop_c2b1c
    jsr copy_load_table_to_osfile_control_block
    jsr get_drive_number
    ldy osfile_path_pointer
    lda #&2e
    sta osfile_path + 3,y
    ldx #&ff
.loop_c2b37
    iny
    inx
    lda filename_table_2_txt,x
    sta osfile_path + 3,y
    cmp #cr
    bne loop_c2b37
ELSE
    jsr initialise_screen
IF REMOVE_DEAD_CODE = FALSE
    jsr empty_routine
ENDIF
    ldx #<load_filename_txt
    ldy #>load_filename_txt
    jsr print_txt
    jsr get_filename
    jsr copy_load_table_to_osfile_control_block
IF FILE_SYSTEM = DFS
    jsr get_drive_number
ENDIF
ENDIF
    lda #osfile_read_catalogue_info
    ldx #<(osfile_control_block)
    ldy #>(osfile_control_block)
    jsr osfile                         ; Read catalogue information (A=5)
    cmp #1
    bne not_found_error
    sec
    lda osfile_control_block + 11
    eor #4
    ora osfile_control_block + 10
    ora osfile_control_block + 12
    ora osfile_control_block + 13
    beq load_file
    brk

    equb 0
    equs "Bad file", 0

.not_found_error
    brk

    equb 0
    equs "Not found", 0

.load_file
    jsr copy_load_table_to_osfile_control_block
IF FILE_SYSTEM = ADFS
    clc
    lda osfile_control_block
    adc #3
    sta osfile_control_block
    lda osfile_control_block + 1
    adc #0
    sta osfile_control_block + 1
ENDIF
    lda #osfile_load
    ldx #<(osfile_control_block)
    ldy #>(osfile_control_block)
    jsr osfile                         ; Load named file (if XY+6 contains 0, use specified address) (A=255)
    lda #4
    sta zp_various_1c
    lda #0
    sta zp_various_1b
    lda #2
    sta l351f
    jsr format_filename_table_txt
.close_file_return_to_menu
    jsr sub_c28ed
    lda #osfind_close
    tay
    jsr osfind                         ; Close all files (Y=0)
    jmp display_menu

.copy_load_table_to_osfile_control_block
    ldx #&12
.loop_c2d04
    lda osfile_load_table - 1,x
    sta osfile_control_block - 1,x
    dex
    bne loop_c2d04
    rts

.copy_save_table_to_osfile_control_block
    ldx #&12
.loop_c2d10
    lda osfile_save_table - 1,x
    sta osfile_control_block - 1,x
    dex
    bne loop_c2d10
    rts

.load_filename_txt
    equb &11, &21
    equb lf
    equs "Load Filename? ", cr
    equb lf, lf
    equs "?", 0
.save_filename_txt
    equb &11, &21
    equb lf
    equs "Save Filename? ", cr
    equb lf, lf
    equs "?", 0
 
IF FILE_SYSTEM = ADFS 
.insert_own_disc_txt
    equb &11, &33
.l2bf9
    equs "Insert your own disc", cr
    equb lf
    equs "and press RETURN"
    equb lf, cr
    equb 0
.insert_exile_disc_txt
    equb &11, &23
    equs "Insert "
    equb &11, &33
    equs "EXILE "
    equb &11, &23
    equs "disc", cr
    equb lf
    equs "and press RETURN"
    equb lf, lf, cr
    equb 0
ENDIF

IF FILE_SYSTEM = ADFS
.osfile_control_block
    equw osfile_path
    equb   0,   4, &ff, &ff,   0,   0,   0,   0,   0,   0,   0,   0
    equb   0,   0,   0,   0
.osfile_load_table
    equw osfile_path
    equb   0,   4, &ff, &ff,   0,   0,   0,   0,   0,   0,   0,   0
    equb   0,   0,   0,   0
.osfile_save_table
    equw osfile_path
    equb   0, &2c, &ff, &ff,   0,   0,   0,   0,   0,   4, &ff, &ff
    equb   0,   8, &ff, &ff
.filename_table_2_txt
    equb cr                                                       
    equs "              "                                          

ELSE
.osfile_control_block
    equw osfile_path_and_filename
    equb   0,   4, &ff, &ff,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
    equb   0,   0
.osfile_load_table
    equw osfile_path_and_filename
    equb   0,   4, &ff, &ff,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
    equb   0,   0
.osfile_save_table
    equw osfile_path_and_filename
    equb   0, &2c, &ff, &ff,   0,   0,   0,   0,   0,   4, &ff, &ff,   0,   8
    equb &ff, &ff
ENDIF

.format_filename_table_txt
    ldx #&ff
    ldy #0
.get_next_char
    inx
IF FILE_SYSTEM = ADFS
    lda filename_table_2_txt,x
ELSE
    lda osfile_filename,x
ENDIF
    cmp #spc
    beq get_next_char
    cmp #cr
    beq terminate_filename_table_txt
    sta filename_table_txt,y
    iny
    cpy #max_number_of_chars
    bne get_next_char
.terminate_filename_table_txt
    lda #&22 ; '"'
    sta filename_table_txt,y
    lda #0
    sta filename_table_txt + 1,y
    rts

.display_duration
    jsr sub_c2e08
    lda #&3c
    jsr c2ec5
    pha
    lda #&3c
    jsr c2ec5
    pha
    lda #&18
    jsr c2ec5
    pha
    lda #&64
    jsr c2ec5
    pha
    lda #&1b
    jsr sub_c2e1c
    lda #&83
    jsr oswrch                         ; Write character 131
    jsr sub_c2e2c
    lda zp_5e
    clc
    adc #&30                           ; '0'
    jsr oswrch                         ; Write character
    pla
    jsr sub_c2f34
    lda #&30                           ; '0'
    jsr sub_c2e1c
    lda #&82
    jsr oswrch                         ; Write character 130
    jsr sub_c2e2c
    pla
    jsr sub_c2f34
    lda #&3f
    jsr sub_c2e1c
    lda #&81
    jsr oswrch                         ; Write character 129
    jsr sub_c2e2c
    pla
    jsr sub_c2f34
    lda #&4e
    jsr sub_c2e1c
    lda #&80
    jsr oswrch                         ; Write character 128
    jsr sub_c2e2c
    pla
    jmp c2f1b

.sub_c2e08
    lda #0
    sta l0062
    ldy #4
.loop_c2e0e
    lda table_02 + 6,y
    sta this_object_sprite_old,y
    dey
    bne loop_c2e0e
    lda #&32
    jmp c2ec5

.sub_c2e1c
    sta l2e3c
    jsr adjust_x_pos
    lda #&19
    jsr adjust_y_pos
    lda #&11
    sta l0086
    rts

.sub_c2e2c
    lda #&20
    jsr adjust_y_pos
    lda l2e3c
    jsr adjust_x_pos
    lda #&7e
    sta l0086
    rts

.l2e3c
    equb 0

.display_score
    lda #&2c
    jsr adjust_y_pos
    ldx #<score_txt
    ldy #>score_txt
    jsr sub_c350b
    lda #0
    sta l0062
    ldy #4
.loop_c2e4f
    lda table_03f - 1,y
    sta this_object_sprite_old,y
    dey
    bne loop_c2e4f
    jsr sub_c2e79
    lsr screen_offset_x_old
    ror screen_offset_x
    lda #&b0
    sbc screen_offset_x
    sta screen_offset_x
    lda #&83
    sbc screen_offset_x_old
    sta screen_offset_x_old
    ldx #<score_txt
    ldy #>score_txt
    jsr print_txt
    ldx #<text_table_txt
    ldy #>text_table_txt
    jmp print_txt

.sub_c2e79
    ldy #0
.loop_c2e7b
    tya
    pha
    lda #&0a
    jsr c2ec5
    sta zp_various_b
    pla
    tay
    lda zp_various_b
    clc
    adc #&30                           ; '0'
    pha
    iny
    lda #0
    ldx #4
.loop_c2e91
    ora this_object_sprite_old,x
    bne loop_c2e7b
    dex
    bne loop_c2e91
.loop_c2e98
    pla
    sta text_table_txt,x
    inx
    dey
    bne loop_c2e98
    tya
    sta text_table_txt,x
    ldx #<text_table_txt
    ldy #>text_table_txt
    jmp c3511

.score_txt
    equb &11, &31
    equs "Score :  "
    equb &11, &2c,   0
.text_table_txt
    equs "            "

.c2ec5
    sta l006b
    lda #0
    sta zp_67
    sta l0068
    sta l0069
    sta l006a
    sta l0062
    ldx #&20
.c2ed5
    lsr l006b
    ror l006a
    ror l0069
    ror l0068
    ror zp_67
    sec
    ldy #&fb
.loop_c2ee2
    lda [(zp_5e - &fb) AND &ffff],y
    sbc [(zp_67 - &fb) AND &ffff],y
    iny
    bne loop_c2ee2
    bcc c2efb
    ldy #&fb
.loop_c2eef
    lda [(zp_5e - &fb) AND &ffff],y
    sbc [(zp_67 - &fb) AND &ffff],y
    sta [(zp_5e - &fb) AND &ffff],y
    iny
    bne loop_c2eef
.c2efb
    rol l0063
    rol l0064
    rol l0065
    rol l0066
    dex
    bne c2ed5
    lda zp_5e
    pha
    lda l0063
    sta zp_5e
    lda l0064
    sta l005f
    lda l0065
    sta l0060
    lda l0066
    sta l0061
    pla
    rts

.c2f1b
    ldx #&ff
    sec
.loop_c2f1e
    sbc #&0a
    inx
    bcs loop_c2f1e
    adc #&0a
    pha
    txa
    clc
    adc #&30                           ; '0'
    jsr oswrch                         ; Write character
    pla
    clc
    adc #&30                           ; '0'
    jmp oswrch                         ; Write character

.sub_c2f34
    jsr c2f1b
    lda #&2e                           ; '.'
    jmp oswrch                         ; Write character 46

.display_comp
    jsr c3180
    lda #2
    jsr sub_c2ac8
    jsr sub_c2e08
    clc
    lda #&37
    jsr sub_c2fc5
    jsr sub_c2fc5
    adc l0061
    adc table_03f
    sta l0061
    adc keys_collected + 3
    clc
    adc l0060
    adc table_03f + 1
    sta l0060
    adc l005f
    adc table_03f + 2
    sta l005f
    adc zp_5e
    adc table_03f + 3
    sta zp_5e
    adc keys_collected + 4
    jsr sub_c2fc5
    lda background_objects_data_3 + 69
    and #&7f
    jsr sub_c2fc5
    lda desired_water_level_by_x_range + 1
    and #&80
    jsr sub_c2fc5
    adc l2ac7
    jsr sub_c2fc5
    lda background_objects_data_2 + 7
    and #&7f
    jsr sub_c2fc5
    lda #&10
    jsr adjust_x_pos
    lda #&38
    jsr adjust_y_pos
    ldx #<comp_txt
    ldy #>comp_txt
    jsr print_txt
    ldx #4
.loop_c2fa7
    txa
    pha
    lda #&61
    jsr c2ec5
    jsr c2f1b
    pla
    tax
    dex
    bne loop_c2fa7
    rts

.comp_txt
    equb &11, &31
    equs "Comp. :  "
    equb &11, &1c,   0

.sub_c2fc5
    adc l0061
    adc l005f
    sta l005f
    adc l0060
    sta l0060
    adc l0061
    sta l0061
    adc zp_5e
    sta zp_5e
    rts

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    ldx #&0f
    lda #0
.loop_c2fdc
    sta object_stack_y,x
    dex
    bpl loop_c2fdc
    rts
ENDIF

.sub_c2fe3
    jsr setup_background_sprite_values
    jsr change_display_mode
    lda #&a0
    jsr sub_c22db
    jmp change_display_mode

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    lda c2288
    eor #&14
    sta c2288
    rts
ENDIF

.l2ffa
    equb 0

.sub_c2ffb
{    jsr sub_c30e5
    lda #cr
    jsr nvwrch                         ; Write character 13
    jsr sub_c3026
    lsr l2ffa
    ldx #&15
    jsr sub_c3094
    jsr sub_c30c3
    lda #crtc_screen_start_high
    ldy #&0c
    sta crtc_address_register
    sty crtc_address_write
    lda #crtc_screen_start_low
    ldy #0
    sta crtc_address_register
    sty crtc_address_write
    rts
}

.sub_c3026
{
    ldx #1
IF REMOVE_DEAD_CODE = FALSE
    jmp c302d

; Uncalled code
    ldx #0

.c302d
ENDIF
    lda #&17
    jsr nvwrch                         ; Write character 23
    lda #1
    jsr nvwrch                         ; Write character 1
    txa
    jsr nvwrch                         ; Write character
    lda #0
    jsr nvwrch                         ; Write character 0
    jsr nvwrch                         ; Write character
    jsr nvwrch                         ; Write character
    jsr nvwrch                         ; Write character
    jsr nvwrch                         ; Write character
    jsr nvwrch                         ; Write character
    jmp nvwrch                         ; Write character
}

.setup_crtc
{
    lda #0
    sta screen_offset_x_low
    sta screen_offset_y_low
    sta screen_offset_x
    sta screen_offset_y
    sta screen_offset_x_old
    lda #&80
    sta screen_offset_x_low_old
    sta screen_offset_x_old
    lda #&80
    sta screen_offset_y_low_old
    sta screen_offset_y_old
    lda #&ff
    sta l2ffa
    jsr sub_c30ea
    lda #osbyte_vsync
    jsr osbyte                         ; Wait for vertical sync
    jsr push_palette_register_data
    lda #&31
    sta l0086
    lda #crtc_screen_start_high
    ldy #&0b
    sta crtc_address_register
    sty crtc_address_write
    lda #crtc_screen_start_low
    ldy #0
    sta crtc_address_register
    sty crtc_address_write
    ldx #&0a
.^sub_c3094
    txa
    pha
    lda #osbyte_vsync
    jsr osbyte                         ; Wait for vertical sync
    pla
    tax
    ldy #crtc_scan_lines_per_char
.video_controller_write_loop
    lda crtc_data,x
    sty crtc_address_register          ; write to video controller
    sta crtc_address_write             ; write to video controller
    dex
    dey
    bpl video_controller_write_loop
    lda crtc_data,x
    tax
    ldy #0
    lda #osbyte_write_video_ula_control
    jsr osbyte                         ; Write X to video ULA control register and OS copy (BBC and Master only), and reset flash cycle
.^push_palette_register_data
    ldy #&10
.loop1
    lda wall_palette_three_lookup + 3,y
    sta video_ula_palette
    dey
    bne loop1
    rts
}

.sub_c30c3
{    ldy #&10
.loop1
    lda palette_register_data_1 + 15,y
    sta video_ula_palette
    dey
    bne loop1
    rts
}

.crtc_data
    equb                                      &14
    equb                                      &7f
    equb                                      &40
    equb             98-(80-screen_width) DIV 2+1
    equb                                      &28
    equb                                      &26
    equb                                        0
    equb (screen_size_pages*256)/(screen_width*8)
    equb                                      &1d
    equb                                        0
    equb                                        7
    equb &88, &3f, &28, &31, &24, &26,   0, &19, &20,   0,   7

.sub_c30e5
    lda #&0c
    jmp nvwrch                         ; Write character 12

.sub_c30ea
{
    ldx #&0f
.loop_c30ec
    lda object_stack_flags,x
    ora #1
    sta object_stack_flags,x
    dex
    bpl loop_c30ec
    lda #screen_base_page
    sta zp_various_1c
    lda #0
    sta zp_various_1b
    tay
.loop2
    sta (zp_various_1b),y
    iny
    bne loop2
    inc zp_various_1c
    bpl loop2
    jmp push_palette_register_data
}

.wrchv_code
{
    sta zp_various_b
    pha
    txa
    pha
    tya
    pha
    lda zp_various_b
    bit l3451
    bmi c3120
    jsr sub_c3148
    jmp restore_yxa_rts
.c3120
    cmp #cr
    beq nv_cr_lf
    cmp #7
    beq c3134
    cmp #&15
    beq c3134
    cmp #&20
    bcc restore_yxa_rts
    cmp #0
    bmi restore_yxa_rts
.c3134
    jsr sub_c3148
    jmp restore_yxa_rts
.nv_cr_lf
    jsr sub_c3148
    lda #lf
    jsr sub_c3148
.restore_yxa_rts
    pla
    tay
    pla
    tax
    pla
    rts
}

.sub_c3148
{
    bit l2ffa
    bmi c3150
    jmp nvwrch                         ; Write character
.c3150
    bit l3451
    bpl c316d
    pha
    lda #&7f
    jsr c3201
    pla
    jsr c3201
    cmp #&0d
    bne c3167
    lsr l3451
    rts
.c3167
    pha
    jsr sub_c3170
    pla
    rts
.c316d
    jmp c3201
}

.sub_c3170
{
    lda l0086
    pha
    lda #&6a
    sta l0086
    lda #&5f
    jsr c3201
    pla
    sta l0086
    rts
}

.c3180
{
    lda #&82
    sta zp_various_1b
    lda #&fc
    sta zp_various_1c
    lda #4
    sta l31a2 + 2                      ; self modifying code
    lda #>table_02
    sta l31a5 + 2                      ; self modifying code
    sec
    sed
    ldy #0
    lda #&6e
    sta zp_various_b
    lda #&92
.c319c
    adc zp_various_b
    adc #&15
    sta zp_various_b
.l31a2
    eor l0400,y
.l31a5
    sta table_02,y
    eor zp_various_b
    iny
    bne c31b3
    inc l31a2 + 2                      ; self modifying code
    inc l31a5 + 2                      ; self modifying code
.c31b3
    inc zp_various_1b
    bne c319c
    inc zp_various_1c
    bne c319c
    cld
    lda teleport_fallback_x
    cmp #&99
    bne c31f0
    lda teleport_fallback_y
    cmp #&3c
    bne c31f0
    ldx #&a6
    ldy #&fc
    lda #<table_02
    sta l31da + 1                      ; self modifying code
    lda #>table_02
    sta l31da + 2                      ; self modifying code
    lda #&dc
.l31da
    eor table_02
    inc l31da + 1                      ; self modifying code
    bne c31e5
    inc l31da + 2                      ; self modifying code
.c31e5
    inx
    bne l31da
    iny
    bne l31da
    cmp possible_checksum
    beq c31f6
.c31f0
    jsr relocate_code_to_0x400
    jmp c3180
.c31f6
    lda l351f
    bne c31fe
    sta object_stack_y + 1
.c31fe
    rts
}

.l31ff
    equb 0, 0

.c3201
{
    pha
    sta l31ff + 1
    tya
    pha
    txa
    pha
    lda l31ff
    cmp #&11
    bne c321d
    lda l31ff + 1
    sta l0086
    lda #0
    sta l31ff
    jmp restore_xya_rts
.c321d
    lda l31ff + 1
    cmp #spc
    bcs c3266
    cmp #cr
    bne c3233
    lda #0
    sta screen_offset_x
    lda #&80
    sta screen_offset_x_old
    jmp restore_xya_rts
.c3233
    cmp #&0a
    bne c325c
    clc
    lda screen_offset_y
    adc #&50
    sta screen_offset_y
    lda screen_offset_y_old
    adc #0
    sta screen_offset_y_old
    cmp #&85
    bcc c3259
.loop_c3248
    ldx #&ff
    jsr sub_c339f
    bpl c3256
    ldx #&fe
    jsr sub_c339f
    bmi loop_c3248
.c3256
    jsr setup_crtc
.c3259
    jmp restore_xya_rts
.c325c
    cmp #&11
    bne c3263
    sta l31ff
.c3263
    jmp restore_xya_rts
.c3266
    cmp #&7f
    beq c328b
    clc
    adc #&5d
    pha
    ldy l335e
    sta l335f,y
    lda l0086
    sta l337f,y
    iny
    tya
    and #&1f
    sta l335e
    lda l0086
    sta this_object_palette
    pla
    jsr sub_c32de
    jmp restore_xya_rts
.c328b
    ldy l335e
    dey
    tya
    and #&1f
    tay
    sta l335e
    ldx l335f,y
    clc
    lda sprite_width_lookup,x
    and #&f0
    adc #&20
    sta zp_various_b
    sec
    lda screen_offset_x
    sbc zp_various_b
    sta screen_offset_x
    pha
    lda screen_offset_x_old
    sbc #0
    sta screen_offset_x_old
    pha
    lda l337f,y
    sta this_object_palette
    lda l335f,y
    jsr sub_c32de
    pla
    sta screen_offset_x_old
    pla
    sta screen_offset_x
    jmp restore_xya_rts
.restore_xya_rts
    pla
    tax
    pla
    tay
    pla
    rts
}

.sub_c32cc
{
    lda screen_offset_x
    sta this_object_x_low
    lda screen_offset_x_old
    sta this_object_x
    lda screen_offset_y
    sta this_object_y_low
    lda screen_offset_y_old
    sta this_object_y
    rts
}

.l32dd
    equb &ff

.sub_c32de
{
    sta this_object_sprite
    bit l32dd
    bpl c3341
    jsr sub_c32cc
    ldx #0
    lda this_object_sprite
    sec
    sbc #&be
    cmp #&1a
    bcs c32f5
    ldx #8
.c32f5
    stx zp_various_b
    lda #&80
    sta screen_offset_x_low_old
    lda #&80
    sta screen_offset_y_low_old
    lda #0
    sta screen_offset_x_low
    sta screen_offset_y_low
    ldx #&0f
    lda #0
.loop_c3309
    sta object_stack_y,x
    dex
    bpl loop_c3309
    lda this_object_x
    sta object_stack_x
    lda this_object_x_low
    sta object_stack_x_low
    clc
    lda this_object_y_low
    adc zp_various_b
    sta object_stack_y_low
    lda this_object_y
    adc #0
    sta object_stack_y
    lda this_object_palette
    sta object_stack_palette
    lda #1
    sta object_stack_flags
    lda #&49 ; 'I'
    sta object_stack_type
    lda this_object_sprite
    sta object_stack_sprite
    pha
    jsr process_objects
    pla
.c3341
    tax
    sec
    sbc #&7d
    cmp #&5f
    lda #&10
    bcs c334d
    lda #&20
.c334d
    clc
    adc sprite_width_lookup,x
    and #&f0
    adc screen_offset_x
    sta screen_offset_x
    lda screen_offset_x_old
    adc #0
    sta screen_offset_x_old
    rts
}

.l335e
    equb 0
.l335f
    equs "................................"
.l337f
    equs "................................"

.sub_c339f
{
    ldy #&ff
    lda #osbyte_inkey
    jsr osbyte                         ; Read a specific key (or read machine type)
    cpx #0
    rts
}

.adjust_x_pos
{
    sta screen_offset_x
    lda #0
    sta screen_offset_x_old
    asl screen_offset_x
    rol screen_offset_x_old
    asl screen_offset_x
    rol screen_offset_x_old
    asl screen_offset_x
    rol screen_offset_x_old
    asl screen_offset_x
    rol screen_offset_x_old
    lda #&80
    clc
    adc screen_offset_x_old
    sta screen_offset_x_old
    rts
}

.adjust_y_pos
{
    sta screen_offset_y
    lda #0
    sta screen_offset_y_old
    asl screen_offset_y
    rol screen_offset_y_old
    asl screen_offset_y
    rol screen_offset_y_old
    asl screen_offset_y
    rol screen_offset_y_old
    lda #&80
    clc
    adc screen_offset_y_old
    sta screen_offset_y_old
    rts
}

.restore_defaults_code
{
    jsr setup_crtc
    jsr relocate_code_to_0x400
    jsr sub_c28ed
    jmp display_menu
}

.relocate_code_to_0x400
{
    lda #<defaults_table
    sta zp_various_1b
    lda #>defaults_table
    sta zp_various_1c
    lda #4
    sta l3400 + 2                      ; self modifying code
    ldx #4
.loop2
    ldy #0
.loop1
    lda (zp_various_1b),y
.l3400
    sta l0400,y
    dey
    bne loop1
    inc zp_various_1c
    inc l3400 + 2                      ; self modifying code
    dex
    bne loop2
    lda #0
    sta l351f
    rts
}

.get_filename
{
    lda #osbyte_set_cursor_editing
    ldx #0
    ldy #0
    jsr osbyte                         ; Enable cursor editing (X=0)
    bit l2ffa
    bpl c342e
    jsr sub_c3170
    lda #osbyte_set_cursor_editing
    ldx #1
    ldy #0
    jsr osbyte                         ; Disable cursor editing (edit keys give ASCII 135-139) (X=1)
.c342e
    lda #&ff
    sta l3451
    lda l0086
    pha
    lda #&77
    sta l0086
    ldx #<(osword_table)
    ldy #>(osword_table)
    lda #osword_read_line
    jsr osword                         ; Read line from input stream (exits with C=1 if ESCAPE pressed)
    pla
    sta l0086
    lda #0
    sta l3451
    bcc c3450
    jmp c34d0
.c3450
    rts
}

.l3451
    equb 0
.osword_table
    equw osfile_filename               ; Buffer address for input (2 bytes)
    equb max_number_of_chars           ; Maximum line length
    equb      min_char_value           ; Min. acceptable character value
    equb      max_char_value           ; Max. acceptable character value

IF FILE_SYSTEM = ADFS
.osfile_filename
    equb cr, cr, cr, cr, cr, cr, cr, cr, cr, cr, cr, cr
    equb cr, cr, cr
.osfile_path
    equs ":0.$", cr
    equs "                              "
.osfile_path_pointer
    equb 1

ELSE
.osfile_path_and_filename
IF FILE_SYSTEM = DFS
    equs ":0."
ELSE
    equs "SAVES."
ENDIF
.osfile_filename
    equb cr, cr, cr, cr, cr, cr, cr, cr, cr, cr, cr, cr, cr, cr
    equb cr
ENDIF

.get_keypress
{
    jsr osrdch                         ; Read a character from the current input stream
    bcc c3475
    cmp #&1b                           ; A=character read
    bne c3475
    jmp c34d0
.c3475
    clc
    rts
}

.sub_c3477
{
    stx l34cc
    sty l34cc + 1
    rts
}

.c347e
{
    stx l34ce
    sty l34ce + 1
    rts
}

.initialise_screen
{
    jsr setup_crtc
.^setup_pointers
    ldx #<wait_cr_spc_display_menu
    ldy #>wait_cr_spc_display_menu
    jsr sub_c3477
    ldx #<display_menu
    ldy #>display_menu
    jmp c347e
}

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    ldx #<close_file_return_to_menu
    ldy #>close_file_return_to_menu
    jsr sub_c3477
    jmp c347e
ENDIF

.brk_code
{
    jsr update_wrchv
    lda #&71
    sta l0086
    lsr l3451
    lda #osbyte_flush_buffer_class
    ldx #0
    ldy #0
    jsr osbyte                         ; Flush all buffers (X=0)
    lda l00ff
    pha
    bpl c34c0
    lda #osbyte_clear_escape
    jsr osbyte                         ; Clear escape condition
    jmp c34c3
.c34c0
    jsr sub_c34de
.c34c3
    pla
    bmi c34c9
    jmp (l34cc)
.c34c9
    jmp (l34ce)
}

.l34cc
    equw display_menu
.l34ce
    equw display_menu

.c34d0
{
    lda #osbyte_set_escape
    jsr osbyte                         ; Set escape condition
    brk

    equb 0
    equs "Escape", 0
}

.sub_c34de
{
    jsr c34f0
    ldy #1
.loop_c34e3
    lda (l00fd),y
    beq c34ed
    jsr oswrch                         ; Write character
    iny
    bne loop_c34e3
.c34ed
    jmp c34f0                          ; Unnecessary jmp
.c34f0
    lda #lf
    jsr oswrch                         ; Write character 10
    lda #cr
    jmp oswrch                         ; Write character 13
}

; 
; ; *****************************************************************************
; Write text to screen. On entry X & Y contains pointer to text.
; Text is terminated with 0.
; ; *****************************************************************************
; 
.print_txt
{
    stx l001d
    sty l001e
    ldy #0
.loop1
    lda (l001d),y
    beq c350a
    jsr oswrch                         ; Write character
    iny
    bne loop1
.c350a
    rts
}

.sub_c350b
{
    lda #0
    sta screen_offset_x
    sta screen_offset_x_old
.^c3511
    lda #0
    sta l32dd
    jsr print_txt
    lda #&ff
    sta l32dd
    rts
}

.l351f
    equb 0

.update_wrchv
{
    lda #<wrchv_code
    sta wrchv
    lda #>wrchv_code
    sta wrchv+1
    rts
}

.tmp_filev_ptr_save
    equw 0
.tmp_fscv_ptr_save
    equw 0

.relocation_run
{
    lda #<brk_code
    sta brkv
    lda #>brk_code
    sta brkv+1
    lda #osbyte_read_write_escape_break_effect
    ldx #2
    ldy #0
    jsr osbyte                         ; Write Set normal ESCAPE action, clear memory on BREAK, value X=2

IF FILE_POINTER_SAVE = IN_RELOC
    lda filev
    sta tmp_filev_ptr_save
    lda filev+1
    sta tmp_filev_ptr_save + 1
    lda fscv
    sta tmp_fscv_ptr_save
    lda fscv+1
    sta tmp_fscv_ptr_save + 1
ENDIF
 
    jsr update_wrchv

IF RELOC_TOGGLE_FS = TRUE
    ldx #<(reloc_tape_txt)
    ldy #>(reloc_tape_txt)
    jsr oscli
IF FILE_SYSTEM = ADFS
    ldx #<(reloc_adfs_txt)
    ldy #>(reloc_adfs_txt)
    jsr oscli
ELIF FILE_SYSTEM = NFS
    ldx #<(reloc_net_txt)
    ldy #>(reloc_net_txt)
    jsr oscli
ELSE
    ldx #<(reloc_disc_txt)
    ldy #>(reloc_disc_txt)
    jsr oscli
ENDIF
ELIF RELOC_TOGGLE_FS = NOP
    nop:nop
    nop:nop
    nop:nop:nop
    nop:nop
    nop:nop
    nop:nop:nop
ENDIF
    jsr update_table_01a
; 
; ; *****************************************************************************
; Switch to Mode 6
; ; *****************************************************************************
; 
    lda #&16
    jsr nvwrch                         ; Write character 22
    lda #6
    jsr nvwrch                         ; Write character 6
    jsr setup_crtc
    jsr sub_c28ed
    jmp display_menu
}

.show_position_code
{
    jsr setup_crtc
    jsr c3180
    lda object_stack_x
    sta l3b56
    lda object_stack_y
    sta l3b56 + 1
    lda teleports_used
    sta l2c63
    lda teleport_last
    sta l2c63 + 1
    ldx #&ff
    txs
    ldx #<display_menu
    ldy #>display_menu
    jsr sub_c3477
    jsr c347e
    jsr c3180
    jsr sub_c30ea
.c358c
    lda l3b56
    sta l0018
    lda l3b56 + 1
    sta l001a
    jsr sub_c2352
    jsr sub_c1fbe
    jsr process_objects
.c359f
    jsr get_keypress
    bcs c359f
    cmp #spc
    bne c35ab
    jmp display_menu
.c35ab
    ora #&20
    cmp #&74
    bne c359f
    jsr c3180
    jsr sub_c30ea
    jsr sub_c2c25
    lda object_stack_x
    sta l3b56
    lda object_stack_y
    sta l3b56 + 1
    jmp c358c
}

.score_breakdown_code
{
    ldx #<wait_cr_spc_display_menu
    ldy #>wait_cr_spc_display_menu
    jsr sub_c3477
    ldx #<display_menu
    ldy #>display_menu
    jsr c347e
    jsr setup_crtc
    jsr display_exile_banner
    lda #&1c
    jsr adjust_y_pos
    lda #&0f
    jsr adjust_x_pos
    ldx #<score_breakdown_2_txt
    ldy #>score_breakdown_2_txt
    jsr print_txt
    lda #&32
    sta l38bf
    lda #0
    sta l38c0
.c35f8
    lda l38bf
    jsr adjust_y_pos
    lda l38c0
    asl a
    tay
    lda score_breakdown_pointer_table,y
    pha
    tax
    lda score_breakdown_pointer_table + 1,y
    pha
    tay
    jsr sub_c350b
    lda #&ce
    sbc screen_offset_x
    sta screen_offset_x
    lda #&83
    sbc screen_offset_x_old
    sta screen_offset_x_old
    pla
    tay
    pla
    tax
    jsr print_txt
    lda #0
    sta screen_offset_x
    sta screen_offset_x_old
    lda l38c0
    asl a
    asl a
    tax
    ldy #&fc
.loop_c3631
    lda table_03a,x
    sta [(zp_5e - &fc) AND &ffff],y
    inx
    iny
    bne loop_c3631
    jsr sub_c2e79
    lda #&c8
    sbc screen_offset_x
    sta screen_offset_x
    lda #&86
    sbc screen_offset_x_old
    sta screen_offset_x_old
    ldx #<text_table_txt
    ldy #>text_table_txt
    jsr print_txt
    lda l38bf
    clc
    adc #&0c
    sta l38bf
    inc l38c0
    lda l38c0
    cmp #6
    bne c35f8
    jmp wait_cr_spc_display_menu
}

.score_breakdown_2_txt
    equb &11, &61
    equs "Score Breakdown:", 0

.score_breakdown_pointer_table
    equw   kills_plus_txt
    equw  kills_minus_txt
    equw bonuses_plus_txt
    equw   time_minus_txt
    equw deaths_minus_txt
    equw        total_txt

.kills_plus_txt
    equb &11, &31
    equs "Kills  +", 0

.kills_minus_txt
    equb &11, &1c
    equs "Kills  -", 0

.bonuses_plus_txt
    equb &11, &31
    equs "Bonuses  +", 0

.time_minus_txt
    equb &11, &1c
    equs "Time  -", 0

.deaths_minus_txt
    equs "Deaths  -", 0

.total_txt
    equb &0a, &11, &77
    equs "Total      ", 0

.show_status_code
{
    ldx #<display_menu
    ldy #>display_menu
    jsr sub_c3477
    jsr c347e
    jsr c3180
    jsr setup_crtc
    jsr display_exile_banner
    jsr display_duration
    jsr display_score
    jsr display_comp
    lda #4
    jsr adjust_x_pos
    lda #&48
    jsr adjust_y_pos
    ldx #<fuel_txt
    ldy #>fuel_txt
    jsr print_txt
    lda #&1a
    jsr adjust_x_pos
    lda #&45
    sta l38bf
    jsr adjust_y_pos
    lda #&21
    sta l38c1
    lda weapon_energy_h
    jsr fuel_banner_txt
    lda #0
    sta l38c0
.c3716
    lda l38bf
    clc
    adc #&0f
    sta l38bf
    inc l38c0
    ldx l38c0
    cpx #6
    beq c3793
    lda booster_collected,x
    php
    lda #0
    plp
    bpl c3780
    txa
    clc
    adc #&59
    tax
    lda object_palette_lookup,x
    and #&7f
    sta this_object_palette
    lda object_sprite_lookup,x
    pha
    tay
    lda sprite_height_lookup,y
    lsr a
    lsr a
    lsr a
    lsr a
    eor #&ff
    adc #4
    adc l38bf
    jsr adjust_y_pos
    lda #&11
    jsr adjust_x_pos
    lda l38c0
    cmp #5
    bne c3765
    lda #9
    jsr adjust_x_pos
.c3765
    pla
    jsr sub_c32de
    lda #&1a
    jsr adjust_x_pos
    lda l38bf
    jsr adjust_y_pos
    ldx l38c0
    lda l38b9,x
    sta l38c1
    lda weapon_energy_h,x
.c3780
    pha
    lda #&1a
    jsr adjust_x_pos
    lda l38bf
    jsr adjust_y_pos
    pla
    jsr fuel_banner_txt
    jmp c3716
.c3793
    lda #&4e
    jsr adjust_x_pos
    lda #&49
    jsr adjust_y_pos
    ldx #<pockets_txt
    ldy #>pockets_txt
    jsr print_txt
    lda #&49
    jsr adjust_x_pos
    lda #&54
    jsr adjust_y_pos
    ldx #<pockets_banner_txt
    ldy #>pockets_banner_txt
    jsr print_txt
    lda #&51
    sta l38b8
.c37ba
    ldx pockets_used
    beq c3811
    lda pockets_used,x
    tax
    lda object_palette_lookup,x
    and #&7f
    sta this_object_palette
    lda object_sprite_lookup,x
    pha
    tay
    lda l38b8
    jsr adjust_x_pos
    lda sprite_width_lookup,y
    lsr a
    adc #8
    sta zp_various_b
    lda screen_offset_x
    sbc zp_various_b
    sta screen_offset_x
    bcs c37e7
    dec screen_offset_x_old
.c37e7
    lda #&5b
    jsr adjust_y_pos
    lda sprite_height_lookup,y
    lsr a
    adc #4
    sta zp_various_b
    lda screen_offset_y
    sbc zp_various_b
    sta screen_offset_y
    bcs c37fe
    dec screen_offset_y_old
.c37fe
    pla
    jsr sub_c32de
    clc
    lda l38b8
    adc #&0b
    sta l38b8
    dec pockets_used
    jmp c37ba
.c3811
    lda #&55
    jsr adjust_x_pos
    lda #&76
    jsr adjust_y_pos
    ldx #<keys_txt
    ldy #>keys_txt
    jsr print_txt
    lda #&49
    jsr adjust_x_pos
    lda #&81
    jsr adjust_y_pos
    ldx #<keys_banner_txt
    ldy #>keys_banner_txt
    jsr print_txt
    lda #&4d
    jsr adjust_x_pos
    lda #&84
    jsr adjust_y_pos
    lda #&ff
    sta l3870
.c3842
    inc l3870
    ldx l3870
    cpx #8
    beq c386d
    lda keys_collected,x
    bpl c3842
    lda object_palette_lookup + 81,x
    and #&7f
    sta this_object_palette
    lda #&4d ; 'M'
    jsr sub_c32de
    clc
    lda screen_offset_x
    adc #&10
    sta screen_offset_x
    lda screen_offset_x_old
    adc #0
    sta screen_offset_x_old
    jmp c3842
.c386d
    jmp wait_cr_spc_display_menu
}

.l3870
    equb 0

.fuel_txt
    equb &11, &6a
    equs "Fuel", 0

.pockets_txt
    equb &11, &5a
    equs "Pockets", 0

.keys_txt
    equb &11, &5a
    equs "Keys", 0

.keys_banner_txt
    equb &11, &31, &84, &11,   1, &89, &89, &89, &89, &89, &87, &11, &31, &85
    equb   0

.pockets_banner_txt
    equb &11, &31, &84, &11,   1, &89, &86, &11, &11, &87, &11,   1, &89, &86
    equb &11, &11, &87, &11,   1, &89, &86, &11, &11, &87, &11,   1, &89, &86
    equb &11, &31, &85,   0

.l38b8
    equb 0

.l38b9
    equb &21, &51, &61, &31, &11, &71

.l38bf
    equb 0

.l38c0
    equb 0

.l38c1
    equb 0

.l38c2
    equb 0

.l38c3
    equb 0

.l38c4
    equb 0

.fuel_banner_txt
{
    cmp #0
    bpl c38cb
    lda #&7f
.c38cb
    lsr a
    lsr a
    sta l38c2
    eor #&1f
    sta l38c3
    lda #&31
    sta l0086
    lda #&84
    jsr oswrch                         ; Write character 132
    lda #1
    sta l0086
    lda #&86
    jsr oswrch                         ; Write character 134
    lda l38c1
    sta l0086
    lda l38c2
    jsr sub_c3905
    lda #1
    sta l0086
    lda l38c3
    jsr sub_c3905
    lda #&31
    sta l0086
    lda #&85
    jmp oswrch                         ; Write character 133
}

.sub_c3905
{
    sta l38c4
.c3908
    lda l38c4
    beq c3952
    cmp #8
    bcc c3921
    lda l38c4
    sbc #8
    sta l38c4
    lda #&89
    jsr oswrch                         ; Write character 137
    jmp c3908
.c3921
    cmp #4
    bcc c3935
    lda l38c4
    sbc #4
    sta l38c4
    lda #&88
    jsr oswrch                         ; Write character 136
    jmp c3908
.c3935
    cmp #2
    bcc c3947
    dec l38c4
    dec l38c4
    lda #&87
    jsr oswrch                         ; Write character 135
    jmp c3908
.c3947
    dec l38c4
    lda #&86
    jsr oswrch                         ; Write character 134
    jmp c3908
.c3952
    rts
}

.l3953
    equb 0

.wait_cr_spc_display_menu
{    jsr get_keypress
    cmp #cr
    beq display_menu
    cmp #spc
    bne wait_cr_spc_display_menu
}

.display_menu
{
    ldx #&ff
    txs
    ldx #<display_menu
    ldy #>display_menu
    jsr sub_c3477
    jsr c347e
    lda #osbyte_set_cursor_editing
    ldx #1
    ldy #0
    jsr osbyte                         ; Disable cursor editing (edit keys give ASCII 135-139) (X=1)
    lda #osbyte_read_write_function_key_status
    ldx #&30
    ldy #0
    jsr osbyte                         ; Write function key status, value X=48
    lda #osbyte_read_write_shift_function_key_status
    ldx #0
    ldy #0
    jsr osbyte                         ; Write SHIFT+function keys status, value X=0
    lda #osbyte_read_write_ctrl_function_key_status
    ldx #0
    ldy #0
    jsr osbyte                         ; Write CTRL+function keys status, value X=0
    lda #osbyte_read_write_ctrl_shift_function_key_status
    ldx #0
    ldy #0
    jsr osbyte                         ; Write CTRL+SHIFT+function keys status, value X=0
    jsr setup_crtc
    jsr display_exile_banner
    lda #&1e
    jsr adjust_y_pos
    lda #0
    sta l3953
.loop1
    ldx #<leading_f_txt
    ldy #>leading_f_txt
    jsr print_txt
    lda l3953
    clc
    adc #&30                           ; '0'
    jsr oswrch                         ; Write character
    lda #&26
    jsr adjust_x_pos
    lda l3953
    asl a
    asl a
    tax
    lda menu_pointer_table + 3,x
    tay
    lda menu_pointer_table + 2,x
    tax
    jsr print_txt
    lda #cr
    jsr oswrch                         ; Write character 13
    lda #lf
    jsr oswrch                         ; Write character 10
    inc l3953
    lda l3953
    asl a
    asl a
    tax
    lda menu_pointer_table + 1,x
    bpl loop1                          ; Loop for all menu items
    ldx #<newline_txt
    ldy #>newline_txt
    jsr print_txt
    lda l351f
    bne dont_print_default
    ldx #<default1_txt
    ldy #>default1_txt
    jsr print_txt
    jmp keypress_loop
.dont_print_default
    cmp #1
    bne dont_print_unsaved
    ldx #<unsaved_txt
    ldy #>unsaved_txt
    jsr print_txt
    jmp keypress_loop
.dont_print_unsaved
    cmp #2
    bne print_file2
    ldx #<file1_txt
    ldy #>file1_txt
    jsr print_txt
    jmp print_filename
.print_file2
    ldx #<file2_txt
    ldy #>file2_txt
    jsr print_txt
.print_filename
    ldx #<filename_table_txt
    ldy #>filename_table_txt
    jsr print_txt
.keypress_loop
    jsr get_keypress
    sec
    sbc #&30                           ; '0'
    cmp l3953
    bcs keypress_loop
    asl a
    asl a
    tax
    lda menu_pointer_table,x
    sta zp_various_1b
    lda menu_pointer_table + 1,x
    sta zp_various_1c
    jmp (zp_various_1b)
}

.display_exile_banner
{
    lda #6
    jsr adjust_x_pos
    lda #7
    jsr adjust_y_pos
    ldx #<banner_left_txt
    ldy #>banner_left_txt
    jsr print_txt
    lda #0
    jsr adjust_y_pos
    ldx #<banner_centre_txt
    ldy #>banner_centre_txt
    jsr print_txt
    lda #7
    jsr adjust_y_pos
    ldx #<banner_right_txt
    ldy #>banner_right_txt
    jmp print_txt
}

.banner_left_txt
    equb &11, &53, &8b, &11, &1e, &8a, &8a, &8a, &8a, &8c,   0
.banner_centre_txt
    equb &11, &33, &8f, &90,   0
.banner_right_txt
    equb &11, &1e, &8d, &8a, &8a, &8a, &8a, &11, &53, &8e, &0d,   0
.leading_f_txt
    equb &11, &31, &20, &20, &20, &20, &20, &20, &20, &20, &20, &20, &46,   0

.menu_pointer_table
    equw run_game_code,  run_game_txt
    equw show_status_code,  show_status_txt
    equw show_position_code,  show_position_txt
    equw show_catalogue_code,  show_catalogue_txt
    equw load_position_code,  load_position_txt
    equw save_position_code,  save_position_txt
    equw score_breakdown_code,  score_breakdown_txt
    equw restore_defaults_code,  restore_defaults_txt
    equb &ff, &ff

.run_game_txt
    equs "Run Game", 0

.show_status_txt
    equs "Status", 0

.score_breakdown_txt
    equs "Score Breakdown", 0

.load_position_txt
    equs "Load position", 0

.save_position_txt
    equs "Save position", 0

.restore_defaults_txt
    equs "Default position", 0

.show_position_txt
    equs "See position", 0

.show_catalogue_txt
    equs "Catalogue", 0

.newline_txt
    equb cr, lf,   0

.default1_txt
    equb &11, &17
    equs "Default", 0

.unsaved_txt
    equb &11, &6a
    equs "Unsaved", 0

.file1_txt
    equb &11, &21
    equs "File: ", '"', 0

.file2_txt
    equb &11, &21
    equs "File: ", '"', 0

.filename_table_txt
    equs "................"
.l3b56
IF RELOC_ADDR = PAGE_17
    equw run_game_no_swram + 1
ELSE
    equw &3b9c
ENDIF

.run_game_code
{
    lda #osbyte_read_write_escape_break_effect
    ldx #3
    ldy #0
    jsr osbyte                         ; Write Disable ESCAPE action, clear memory on BREAK, value X=3
    jsr setup_crtc
IF FILE_SYSTEM = ADFS
    jsr print_insert_exile_disc_and_wait                              ; 55c1: 20 db 29     .) :3ac1[1]
ENDIF
    lda tmp_filev_ptr_save
    sta filev
    lda tmp_filev_ptr_save + 1
    sta filev+1
    lda tmp_fscv_ptr_save
    sta fscv
    lda tmp_fscv_ptr_save + 1
    sta fscv+1
    jsr sei_test_for_swram
    bcc run_game_no_swram
    stx l3c2a
    ldx #<swr_req_txt
    ldy #>swr_req_txt
    jsr print_txt
.loop_c3b8b
    jsr get_keypress
    ora #&20                           ; convert to lower case
    cmp #&79                           ; 'y'
    beq c3ba2
    cmp #&6e                           ; 'n'
    bne loop_c3b8b
    jsr oswrch                         ; Write character
.^run_game_no_swram
    ldx #<run_ExileB
    ldy #>run_ExileB
    jmp c3ba9
.c3ba2
    jsr oswrch                         ; Write character
    ldx #<run_ExileSR
    ldy #>run_ExileSR
.c3ba9
    txa
    pha
    tya
    pha
    lda #&16
    jsr nvwrch                         ; Write character 22
    lda #7
    jsr nvwrch                         ; Write character 7
    lda #&cb
    sta wrchv
    lda #&ff
    sta wrchv+1
    lda #crtc_horz_displayed
    sta crtc_address_register
    lda #0
    sta crtc_address_write
    pla
    tay
    pla
    tax
    jmp oscli
}

IF FILE_SYSTEM = ADFS
.run_ExileSR
    equs "/:0.ExileSR", cr
.run_ExileB
    equs "/:0.ExileB", cr
.catalogue_txt
    equs "CAT:0."
.directory_name_txt
    equs "$", cr
    equs "              "
IF RELOC_TOGGLE_FS_TXT = TRUE OR RELOC_TOGGLE_FS = TRUE OR RELOC_TOGGLE_FS = NOP
.reloc_adfs_txt
    equs "ADFS", cr
.reloc_tape_txt
    equs "TAPE", cr
    equb   0
    equw osfile_control_block
    equb 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ENDIF

ELIF FILE_SYSTEM = NFS
.run_ExileSR
    equs "/ExileSR", cr
.run_ExileB
    equs "/ExileB", cr
.catalogue_txt
    equs "CAT SAVES", cr
IF RELOC_TOGGLE_FS_TXT = TRUE OR RELOC_TOGGLE_FS = TRUE OR RELOC_TOGGLE_FS = NOP
.reloc_net_txt
    equs "NET", cr
.reloc_tape_txt
    equs "TAPE", cr
    equb   0
    equw osfile_control_block
    equb 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ENDIF

ELSE
.run_ExileSR
    equs "/ExileSR", cr
.run_ExileB
    equs "/ExileB", cr
.catalogue_txt
    equs "CAT 0", cr
IF RELOC_TOGGLE_FS_TXT = TRUE OR RELOC_TOGGLE_FS = TRUE OR RELOC_TOGGLE_FS = NOP
.reloc_disc_txt
    equs "DISC", cr
.reloc_tape_txt
    equs "TAPE", cr
    equb   0
    equw osfile_control_block
    equb 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
ENDIF
ENDIF

.swr_req_txt
    equb &11, &31
    equs "May I use your Sideways", cr
    equb lf, lf
    equs "Ram ? (y/n)"
    equb &11, &75,   0
.l3c2a
    equb 0

; routine addresses in object_handler_table are stored relative to
; this point.
.handlers_start

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_emerging
{
    beq done                           ; is object_data_pointer = 0? if so, leave
    lda background_processing_flag
    and #&90
    beq done
    lda square_orientation
    asl a
    lda background_objects_data,y
    bpl done                           ; is the object already present?
    lda #&40                           ; &40 = bush
    jsr pull_objects_in_from_tertiary_stack
    lda #&40
    sta object_stack_y_low,y
    rts
.done
    sec
    rts
}

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    lda #5
    bit square_orientation
    bvs c3c51
    lda #4
.c3c51
    jmp pull_objects_in_from_tertiary_stack
ENDIF

.handle_background_engine_thruster
    rts

.door_square_sprite_lookup
    equb &17, &19, &2a, &19

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_stone_door
{
    lda #&3e                           ; &3e = horizontal stone door
    equb &2c                           ; overlapping BIT &xxxx

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.^handle_background_door
    lda #&3c                           ; &3c = horizontal door
    sta sprite_row_byte_offset         ; door_type
    lda square_orientation
    asl a
    rol a
    adc #0
    and #1
    pha
    lda background_objects_data,y
    bmi c3c6f
    lsr a
.c3c6f
    and #2
    lsr a
    sbc #0
    sta l0071
    lda background_processing_flag
    bmi c3c84
    pla
    pha
    rol a
    tax
    lda door_square_sprite_lookup,x
    sta square_sprite
.c3c84
    pla
    bit background_processing_flag
    bvs done                           ; if so, leave
    pha
    clc
    adc sprite_row_byte_offset         ; door_type
    jsr pull_objects_in_from_tertiary_stack
    pla
    asl a
    sta object_stack_ty,y
    tax
    lda square_x,x
    sbc #0
    sta object_stack_extra,y
    lda l0071
    sta object_stack_tx,y
.done
    rts
}

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_teleport_beam
{
    lda #&41                           ; &41 = teleport beam
    jsr pull_objects_in_from_tertiary_stack
    lda #&40
    sta object_stack_x_low,y
    rts
}

.handle_background_invisible_switch
    rts

.handle_background_object_fixed_wind
.handle_background_object_water
.handle_background_object_random_wind
    rts

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_from_type
{
    ldx new_object_type_pointer
    lda background_objects_type,x
    jmp pull_objects_in_from_tertiary_stack
}

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_object_from_data
{
    lda background_objects_data,y
    and #&7f
    jsr pull_objects_in_from_tertiary_stack
    lda #&49                           ; &49 = placeholder
    sta object_stack_type,y
    rts
}

;;  called with:
;;  A, X = &bc this_object_data
;;  Y = &bd new_object_data_pointer; CPY #&00
.handle_background_switch
{
    lda #&42                           ; &42 = switch
    jmp pull_objects_in_from_tertiary_stack
}

.handle_background_mushrooms
    rts

.pull_objects_in_from_tertiary_stack
{
    ldy #0
IF REMOVE_DEAD_CODE = FALSE
    equb &2c                           ; overlapping BIT &xxxx

    ldy #8                             ; but nothing calling this command
ENDIF
    sta l0070                          ; new_object_type
    ldx new_object_data_pointer
    beq pull_objects_in_from_tertiary_stack_alt
    lda background_objects_data,x      ; is the object on screen already?
    bpl restore_stack_pointer          ; if so, leave
    lda l0070                          ; new_object_type
.pull_objects_in_from_tertiary_stack_alt
    jsr reserve_objects                ; find a slot for it (Y = number to reserve)
    bcs restore_stack_pointer          ; if no free slots, leave
    jsr set_object_x_y_tx_ty_to_square_x_y
    ldx l0070                          ; new_object_type
    lda object_sprite_lookup,x
    tax
    lda square_orientation
    ora #1
    sta object_stack_flags,y
    lda #0
    bit square_orientation
    bpl c3cfd
    sbc sprite_width_lookup,x
.c3cfd
    sta object_stack_x_low,y
    lda #0
    bit square_orientation
    bvs c3d09
    sbc sprite_height_lookup,x
.c3d09
    sta object_stack_y_low,y
    lda new_object_data_pointer
    sta object_stack_data_pointer,y
    tax
    lda background_objects_data,x      ; mark the object as being onscreen
    and #&7f
    clc
    rts
}

.restore_stack_pointer
{
    ldx copy_of_stack_pointer
    txs
    sec
    rts
}

.handle_explosion_type_00
.handle_explosion_type_40
.handle_explosion_type_80
.handle_explosion_type_c0
.handle_fluffy
.handle_green_slime
.handle_yellow_ball
.handle_worm
.handle_active_grenade
.handle_cannonball
.handle_death_ball_blue
.handle_red_bullet
.handle_gargoyle
.unused_object_handler
.handle_moving_fireball
.handle_giant_wall
.handle_mysterious_weapon
.handle_maggot_machine
.handle_destinator
.handle_energy_capsule
.handle_remote_control
.handle_grenade_inactive
.handle_collectable
.handle_coronium_boulder
.handle_coronium_crystal
    rts

.handle_chatter_active
.handle_crew_member
.handle_frogman_red
.handle_frogman_green
.handle_frogman_cyan
.handle_red_slime
.handle_sucker
.handle_big_fish
.handle_icer_bullet
.handle_tracer_bullet
.handle_pistol_bullet
.handle_hovering_robot
.handle_clawed_robot
.handle_triax
.handle_imp
.handle_bird
.handle_bird_red
.handle_mushroom_ball
.handle_engine_fire
.handle_red_drop
.handle_chatter_inactive
.handle_switch
.handle_cannon
{
    lda this_object_data
    lsr a
    ror this_object_angle
    rts
}

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    rol a
    eor #1
    ror a
    rts

    rts
ENDIF

.defaults_table
    equb &f9, &1c, &b3, &58, &66, &41, &38, &86, &93,   2, &20, &55, &26, &67, &50, &16
    equb &47,   9, &34, &83, &82, &80, &76, &68, &52, &20, &55, &26, &67, &50, &16, &47
    equb   9, &34, &83, &82, &80, &76, &68, &52, &df, &81, &78, &40, &a6, &82, &2b, &0d
    equb &bb, &a0, &b6, &cf, &66, &1e, &83, &82, &7a, &76, &a8, &4f, &a0, &b6, &c7, &b1
    equb &41, &f6, &0d, &32, &84, &84, &8f, &16, &a8, &d2, &80, &96,   8, &32, &79, &74
    equb &34, &43, &22, &59, &d4, &34, &84, &84, &84, &84, &84, &84, &b4,   4, &24, &72
    equb &69, &56, &19, &54, &32, &96, &b3, &10, &36, &a1, &4e, &10, &ce, &1e, &de, &9f
    equb &bc, &5e, &ac, &2c, &5e,   7, &5b, &78, &3c, &91, &62, &f7, &77, &65, &0a, &77
    equb &65,   4, &65, &30, &65, &7d, &18, &cf, &f6, &6d, &18, &32, &5a, &73, &61,   3
    equb &1b, &57, &6d, &77, &70, &89, &2e, &7f, &0b, &0c, &bc, &fa, &a2, &58, &32, &79
    equb &74, &64, &44,   3, &bd, &fe, &dc, &9c, &85, &98, &51, &50, &56, &98, &52, &7c
    equb &42, &db, &3d, &da, &29, &4d, &0e, &90, &51, &a5, &84, &20, &1b, &6d, &79, &79
    equb &35, &85, &86, &88, &92,   0, &16, &7d, &7d, &7e, &78,   5, &5b, &ea,   1,   9
    equb &41, &99, &15, &44,   5, &24, &65, &44,   5, &a5, &86, &48, &11, &b8, &4c, &79
    equb &6e, &54, &15, &22, &17, &e1, &24, &e4, &ca, &98, &12, &55, &3b, &4c, &35, &85
    equb &86, &88, &cb, &7c, &b4, &fb, &73,   3, &6e, &43,   1, &18, &51, &18, &50,   7
    equb &38, &93, &7b, &e2, &2c, &7e, &7e, &7e, &7e,   5, &24, &65, &44,   5, &95, &36
    equb &85, &8b, &24, &84, &84, &84, &85, &86,   9, &69, &4b, &1e, &5d, &3d, &92,   1
    equb &16, &4d, &1e, &dc, &96, &e8, &44, &cf, &1c, &a7, &fe, &0f, &8d, &7e, &7e, &49
    equb &b9, &7e, &10, &c2, &8d, &93, &a6, &40, &84, &be, &7e, &7e, &7e, &7e, &d1, &13
    equb   7, &29, &6d, &58, &cc, &7e, &7f, &3e,   5, &2c, &58, &0c, &64, &44, &85, &8c
    equb &ed, &7d,   9,   7, &20, &6b, &59, &ec, &9f, &eb, &7d, &7e, &7e, &7e, &4f, &5f
    equb &33, &81, &77, &ba,   2, &34, &71, &63,   3, &58, &32, &79, &74, &64, &44,   6
    equb &25, &65, &4b, &1f, &5e, &3e, &91, &94,   4,   1,   9, &7c, &4e, &38, &90, &9b
    equb &13, &42, &94,   4, &24, &6d, &91, &aa, &56, &63, &40, &96, &93, &83, &17, &35
    equb &f9, &70, &e9, &ae, &f7, &96, &ed, &91, &a6, &c0, &f8, &d2, &ac, &31, &81, &d2
    equb &d0, &9f,   8, &18, &ea, &c0, &96, &b5, &31, &bd, &fd, &f9, &b3, &e3, &aa, &e5
    equb &d4, &a1, &7c, &de, &f2, &b9, &3c, &99, &d2, &b3,   0, &f7, &71, &bd, &f1, &87
    equb &af, &80, &84, &87, &84, &b7, &eb, &88, &92, &a6, &c3, &b2, &18, &54, &6f,   0
    equb &30, &cd, &84, &10, &81, &c6, &98,   6, &a8, &8d, &35, &39, &85, &89, &bb, &92
    equb   8, &2c, &55, &67, &89, &84, &98, &cb, &14, &a1, &c2, &44, &c5, &14, &b3, &f5
    equb &e0, &c5, &c8, &d5, &8c, &b3, &82, &b0, &96, &b8, &9f, &91, &a6, &b3, &0e, &c2
    equb &c7, &85, &80, &82, &1a, &e5, &3e, &52, &20, &89, &ec, &36, &80, &84, &88, &39
    equb &b3, &99, &52, &a0, &d6, &e8, &45, &84, &84, &84, &a7, &8c, &aa, &a2, &e3, &4b
    equb &ff, &80, &35, &ed, &e4, &85, &85, &87, &90, &97, &b0, &56, &ec, &d6, &cc, &bf
    equb &4d, &bb, &b4, &a4, &3c, &a2, &b1, &59, &fc, &c5, &51, &aa, &7c, &18, &e6, &90
    equb &92,   4, &8b, &25, &c5, &82, &83, &5f, &be, &e4, &2b, &b8, &8e, &ae, &9c, &d5
    equb &85, &82, &80, &e6, &d8, &75, &c4, &ce, &f8, &c4, &2d, &b0, &d6, &88, &92, &a1
    equb &b8, &f2, &80, &33, &8d,   4, &b1, &45,   5, &26, &43, &9e, &11, &f5, &bd, &a3
    equb &53, &b9, &c7, &e3, &c4, &b7,   9, &d3, &d3,   2, &2f, &57, &6d, &35, &ad, &3c
    equb &76, &7e, &6c, &44,   5, &25,   9, &bf, &34, &89, &84, &96, &0c, &75, &2d, &48
    equb &37, &80, &86, &b3, &14, &6b, &21, &69, &44, &17, &61, &4d, &d3, &38, &ea, &5a
    equb &1c, &63, &53, &20, &7b, &53,   2,   2, &65, &39, &b0, &58, &cc, &18, &76, &41
    equb &15, &45, &20, &11, &75, &e1, &18, &d2, &80, &b6,   0, &49,   5,   1, &62, &12
    equb &5e, &38, &92, &a8, &22, &64,   4, &78, &c6, &c2, &36, &57, &61, &18, &68, &48
    equb   1, &2c, &3d, &15, &2b,   3, &3c, &ba,   9, &44, &4f, &7e, &5b, &78, &69,   7
    equb &72, &7a, &3b, &97,   0, &2c, &48, &3f, &9f, &5b, &c1, &2b, &21, &32, &5c, &18
    equb &46, &1a, &4c, &15, &66, &44, &1f, &c6, &c3, &a7, &ca, &34, &df, &90, &b0, &de
    equb &a1, &d9, &3c, &b1, &9c, &f0, &d4, &75,   1, &99, &8e, &c0, &1f,   3, &22, &59
    equb &34, &83, &82, &80, &76, &68, &52, &20, &55, &26, &67, &0d, &35, &64, &6f, &d0
    equb &0c, &3d, &64, &69, &f6, &31, &48, &18, &49, &f7, &50, &97, &47, &92,   0, &16
    equb &47,   9, &34, &83, &82, &80, &76, &68, &52, &20, &31, &42,   9, &d3, &6b, &70
    equb &43, &34, &43, &3c, &75, &72, &15, &3a, &c4, &64, &5e, &ae, &68,   8, &32, &79
    equb &74, &64, &44,   3, &22, &59, &34, &83, &82, &80, &0a, &f1, &9a, &f4, &2c, &f8
    equb &3a, &c1, &36, &d0, &9b, &75, &85, &88, &79, &85, &38, &c9, &87, &71, &67, &50
    equb &16, &47,   9, &34, &83, &82, &80, &76, &68, &52, &20, &55, &26, &cf, &e8, &83
    equb &7d, &4b, &81, &a6, &8e, &9c, &5b, &8a, &9e, &54, &86, &40, &f8, &ef, &b9, &fc
    equb &78, &80, &76, &68, &52, &20, &55, &26, &67, &d0, &16, &28, &71, &cf, &9e, &12
    equb &6f, &48, &11, &38, &91, &90, &0c, &3a, &8f, &68, &72, &88, &8c, &87, &8f, &96
    equb   8, &97,   6, &ff, &a1, &6d, &f1, &64, &98, &e0, &7a,   8, &28, &d3, &8c, &17
    equb &66, &bf, &be, &80,   1, &45,   1, &d2, &8f, &fa, &cc, &48, &46, &2e, &79, &0a
    equb &f9, &ed, &28, &76, &22, &28, &79, &1b, &80, &53, &bd, &4c,   2, &33, &b0, &a3
    equb &3d, &b1, &b5, &73, &dc, &a3, &ff, &18, &12, &e6, &12, &2c, &15, &ee, &8f, &68
    equb &be, &44, &99, &37,   1, &56, &75,   4, &12, &cf, &5b, &64, &98, &8a, &64, &98

.handle_player_object
.handle_plasma_ball
.handle_bird_invisible
.L3F52
.handle_flask
    rts

.handle_nest
.handle_hover_ball
.handle_hover_ball_invisible
.handle_fireball
.handle_engine_thruster
.handle_bush
.handle_placeholder
.handle_flask_full
    rts

;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_door
{
    lsr this_object_flags_lefted
    lda this_object_data
    ora #4
    lsr a
    ror a
    ror a
    sta l006d
    lsr a
    and #7
    sta l006c
    lda this_object_tx
    ldx this_object_ty
    clc
    adc #&10
    sta this_object_x_low,x
    lda this_object_extra
    adc #0
    sta this_object_x,x
    ldx l006c
    lda door_palettes,x
    bit l006d
    bvs c4158
    and #&0f
.c4158
    sta this_object_palette            ; change colour
    rts
}

.door_palettes
    equb &2b, &2d, &15, &1c, &42, &12, &26, &4e

.teleport_beam_palettes
    equb &52, &63, &35, &21

;;  called with:
;;  X = this_object_data
;;  A = this_object_data
;;  Y = this_object_supporting ; CPY #&00
.handle_teleport_beam
{
    lsr a                              ; data & &01 = teleporter inactive
    lda #&b0                           ; &b0 = beam sitting in teleporter base
    bcs stationary_beam
    lda #&80
.stationary_beam
    bit this_object_flags_lefted
    jsr make_negative
    sta this_object_y_low
    dec this_object_y_low
    lda this_object_x
    adc this_object_y
    and #3
    tax
    lda teleport_beam_palettes,x
    sta this_object_palette            ; change colour
    rts
}

IF REMOVE_DEAD_CODE = FALSE
; Uncalled code
    rts
ENDIF

.handle_sucker_deadly
.handle_nest_dweller
.handle_robot
.handle_robot_blue
.handle_turret
.handle_maggot
    rts

.handle_explosion
    rts

IF UNREF_DATA = DATA_V2_V3
; unreferenced data
    equb &2c, &d7, &3a, &65, &2c, &e5, &3a, &c9, &35, &c7, &3a, &e1, &33, &f3, &3a, &ff
    equb &ff
    equs "Run Game", 0
    equs "Status", 0
    equs "Score Breakdown", 0
    equs "Load position", 0
    equs "Save position", 0
    equs "Default posi"
ELIF UNREF_DATA = DATA_MC
; unreferenced data
    equb &3a, &20, &31, &34, &4c, &84, &39, &c9,   1, &d0, &0a, &a2, &85, &a0, &3a, &20
    equb &31, &34, &4c, &84, &39, &c9,   2, &d0, &0a, &a2, &8f, &a0, &3a, &20, &31, &34
    equb &4c, &7d, &39, &a2, &99, &a0, &3a, &20, &31, &34, &a2, &a3, &a0, &3a, &20, &31
    equb &34, &20, &a0, &33, &38, &e9, &30, &cd, &b0, &38, &b0, &f5, &0a, &0a, &aa, &bd
    equb &f2, &39, &85, &1b, &bd, &f3, &39, &85, &1c, &6c, &1b,   0, &a9,   6, &20, &bf
    equb &32, &a9,   7, &20, &dd, &32, &a2, &c8, &a0, &39, &20, &31, &34, &a9,   0, &20
    equb &dd, &32, &a2, &d3, &a0, &39, &20, &31, &34, &a9,   7, &20, &dd, &32, &a2, &d8
    equb &a0, &39, &4c, &31, &34, &11, &53, &8b, &11, &1e, &8a, &8a, &8a, &8a, &8c,   0
    equb &11, &33, &8f, &90,   0, &11, &1e, &8d, &8a, &8a, &8a, &8a, &11, &53, &8e, &0d
    equb   0, &11, &31, &20, &20, &20, &20, &20, &20, &20, &20, &20, &20, &46,   0, &b5
    equb &3a, &14, &3a, &29, &36, &1d, &3a, &b8, &34, &61, &3a, &45, &2a, &6e, &3a, &0a
    equb &2b, &34, &3a, &bd, &2a, &42, &3a, &26, &35, &24, &3a, &f7, &32, &50, &3a, &ff
    equb &ff
    equs "Run Game", 0
    equs "Status", 0
    equs "Score Breakdown", 0
    equs "Lo"
ELIF UNREF_DATA = DATA_STH_V1
; unreferenced data
    equb &48, &11, &38, &91, &90, &0c, &3a, &8f, &68, &72, &88, &8c, &87, &8f, &96,   8
    equb &97,   6, &ff, &a1, &6d, &f1, &64, &98, &e0, &7a,   8, &28, &d3, &8c, &17, &66
    equb &bf, &be, &80,   1, &45,   1, &d2, &8f, &fa, &cc, &48, &46, &2e, &79, &0a, &f9
    equb &ed, &28, &76, &22, &28, &79, &1b, &80, &53, &bd, &4c,   2, &33, &b0, &a3, &3d
    equb &b1, &b5, &73, &dc, &a3, &ff, &18, &12, &e6, &12, &2c, &15, &ee, &8f, &68, &be
    equb &44, &99, &37,   1, &56, &75,   4, &12, &cf, &5b, &64, &98, &8a, &64, &98, &8d
    equb &ea, &36, &ad, &ea, &36, &f0, &45, &c9,   8, &90, &10, &ad, &ea, &36, &e9,   8
    equb &8d, &ea, &36, &a9, &89, &20, &ee, &ff, &4c, &2e, &37, &c9,   4, &90, &10, &ad
    equb &ea, &36, &e9,   4, &8d, &ea, &36, &a9, &88, &20, &ee, &ff, &4c, &2e, &37, &c9
    equb   2, &90, &0e, &ce, &ea, &36, &ce, &ea, &36, &a9, &87, &20, &ee, &ff, &4c, &2e
    equb &37, &ce, &ea, &36, &a9, &86, &20, &ee, &ff, &4c, &2e, &37, &60,   0, &20, &69
    equb &32, &c9, &0d, &f0,   4, &c9, &20, &d0, &f5, &a2, &ff, &9a, &a2, &85, &a0, &37
    equb &20, &77, &32, &20, &7e, &32, &a9,   4, &a2,   1, &a0,   0, &20, &f4, &ff, &a9
    equb &e1, &a2, &30, &a0,   0, &20, &f4, &ff, &a9, &e2, &a2,   0, &a0,   0, &20, &f4
    equb &ff, &a9, &e3, &a2,   0, &a0,   0, &20, &f4, &ff, &a9, &e4, &a2,   0, &a0,   0
    equb &20, &f4, &ff, &20, &52, &2e, &20, &68, &38, &a9, &1e, &20, &c7, &31, &a9,   0
    equb &8d, &79, &37, &a2, &ad, &a0, &38, &20, &fa, &32, &ad, &79, &37, &18, &69, &30
    equb &20, &ee, &ff, &a9, &26, &20, &a9, &31, &ad, &79, &37, &0a, &0a, &aa, &bd, &be
    equb &38, &a8, &bd, &bd, &38, &aa, &20, &fa, &32, &a9, &0d, &20, &ee, &ff, &a9, &0a
    equb &20, &ee, &ff, &ee, &79, &37, &ad, &79, &37, &0a, &0a, &aa, &bd, &bc, &38, &10
    equb &c2, &a2, &41, &a0, &39, &20, &fa, &32, &ad, &1f, &33, &d0, &0a, &a2, &44, &a0
    equb &39, &20, &fa, &32, &4c, &4d, &38, &c9,   1, &d0, &0a, &a2, &4e, &a0, &39, &20
    equb &fa, &32, &4c, &4d, &38, &c9,   2, &d0, &0a, &a2, &58, &a0, &39, &20, &fa, &32
    equb &4c, &46, &38, &a2, &62, &a0, &39, &20, &fa, &32, &a2, &6c, &a0, &39, &20, &fa
    equb &32, &20, &69, &32, &38, &e9, &30, &cd, &79, &37, &b0, &f5, &0a, &0a, &aa, &bd
    equb &bb, &38, &85, &1b, &bd, &bc, &38, &85, &1c, &6c, &1b,   0, &a9,   6, &20, &a9
    equb &31, &a9,   7, &20, &c7, &31, &a2, &91, &a0, &38, &20, &fa, &32, &a9,   0, &20
    equb &c7, &31, &a2, &9c, &a0, &38, &20, &fa, &32, &a9,   7, &20, &c7, &31, &a2, &a1
    equb &a0, &38, &4c, &fa, &32, &11, &53, &8b, &11, &1e, &8a, &8a, &8a, &8a, &8c,   0
    equb &11, &33, &8f, &90,   0, &11, &1e, &8d, &8a, &8a, &8a, &8a, &11, &53, &8e, &0d
    equb   0, &11, &31, &20, &20, &20, &20, &20, &20, &20, &20, &20, &20, &46,   0, &7e
    equb &39, &dd, &38, &f2, &34, &e6, &38, &81, &33, &2a, &39,   2, &2a, &37, &39, &8f
    equb &2a, &fd, &38, &65, &2a, &0b, &39, &ef, &33, &ed, &38, &e1, &31, &19, &39, &ff
    equb &ff
    equs "Run Game", 0
    equs "Status", 0
    equs "Score Breakdown", 0
    equs "Lo"
ENDIF

IF DYN_MAP_DATA_ADDR = FALSE
org &41e0
ENDIF

.map_data
    equb &95, &b6, &19, &ef, &6f, &6e, &70, &5e, &d4, &a9, &a9, &57, &6d,   6, &6e, &ed
    equb &2d, &6e, &6e,   6, &ca, &70, &ad,   7, &5e, &5e, &53, &62, &53, &9b, &35, &9e
    equb &15, &16, &e9, &22, &57, &97, &0c, &cc, &8c, &78, &3f, &bd,   5, &ed, &e2, &0a
    equb &f0,   5, &2d, &6e, &d3,   7, &e4, &24, &63, &a1, &a5, &64, &53,   7, &a4, &63
    equb &66, &7e, &3e, &dc, &8c, &72, &e8, &bc,   6, &19, &22, &6d, &de, &d3, &19, &71
    equb &f1, &7e, &29, &f4, &39, &a9, &d3,   6, &53, &a1, &e4,   7, &d4, &a9, &d3, &1a
    equb &c1, &77, &d7, &41, &6f, &a1, &6d, &53, &f5, &d3, &21, &19, &a1, &53,   6, &e5
    equb &ee, &19, &97, &d3, &13, &ea, &75,   2, &d3, &9b, &53, &ea, &5f, &85, &72, &21
    equb &6e, &2c, &2d,   7, &ad, &ed, &b1, &25, &19, &2f, &53, &3b, &9e, &e2, &d3, &62
    equb   2, &f0, &2d,   6, &a4, &d3, &19, &21, &53, &21, &ed, &30, &d3, &6a, &59, &a4
    equb &6d, &70, &6f,   4, &a4, &64, &a2, &a2, &1e,   4, &d3,   1, &4a, &3b, &64, &63
    equb &f0, &2d, &17, &ed, &f4, &2f, &12, &30, &d3, &21, &fa, &a2, &a1, &e2, &8d, &2e
    equb &64, &6e,   2, &ee,   4,   5, &13, &ee, &4a, &6a, &2d,   5, &9b, &2d, &25, &65
    equb &ed, &fe, &31, &6f, &f0, &14, &ee, &bf, &df, &8d, &d3, &6a, &de, &53, &8b, &1e
    equb &ee, &ad, &70, &7a, &24, &a1, &22, &6d, &22, &d3, &21, &93, &df,   1,   2, &dc
    equb &ae, &7c,   6, &af, &df, &b2,   7, &29,   3, &5e, &cd, &ea, &53, &cd,   7, &8f
    equb &fc, &94, &66, &69, &30,   7, &62, &35, &d6, &9d, &bf, &2f, &9d, &62, &62, &1f
    equb &53, &21, &d3, &43, &fe, &45, &93, &74, &9e, &f0, &91, &ae, &a1, &62,   2,   7
    equb &6a, &cc, &d9, &3d, &e2, &ed, &ed, &b0, &b4, &15, &e6, &19, &57, &17, &9d, &4c
    equb &ed, &a2, &93, &65,   3, &21, &9e,   5, &b4, &b0,   6, &ee, &5e, &a1, &5e, &25
    equb &49, &f9,   7, &7c, &de, &de, &ea,   7, &67,   4, &bd, &68, &53, &cc, &26, &a8
    equb &7a, &21, &de, &e2, &9e,   6, &53, &a1, &1e, &e2,   4, &e8, &9e,   4, &64,   6
    equb &b9,   6, &da, &13, &e3, &4a, &21, &f8,   5, &c2, &32, &97,   7, &62, &ed, &70
    equb &ef, &ea, &d3, &6a, &e4, &19, &c6, &f3,   3, &19, &a8, &1e, &28, &9e, &f5, &29
    equb   7,   4, &70, &21, &1e, &1e,   6, &fa, &ee, &2c, &2d, &f0, &13, &53, &bb, &f0
    equb &56, &21, &ed, &a1, &aa, &c0, &c4, &53, &62, &ef, &2f, &f0, &70, &5e, &a1, &19
    equb &6f, &de, &1e, &a1, &24,   2, &5f, &62, &6d,   6, &71, &19, &13, &71, &b0, &af
    equb &56, &ea, &de, &a5, &21, &e5, &4b, &8d,   3, &2f, &29, &2d, &57, &38, &6e,   7
    equb &d3, &19, &2a, &e3, &b5, &6e, &49, &e5, &70, &62, &b0, &12, &53, &d3, &22, &6d
    equb &df, &8d, &53, &a1, &d4, &df, &21, &1e, &2d, &f0, &22, &70, &6e, &35, &12, &e2
    equb &9a, &23, &a1, &61, &68,   5, &a5, &d3,   4, &2e,   6, &19,   7, &d3, &e1, &2e
    equb &24, &9b, &53, &cd,   7, &cd, &ca, &0f, &52, &ed, &e2, &2e,   5, &34, &78,   4
    equb &3a, &7b,   4, &ad, &53, &e1, &b1,   7, &df, &21, &13, &fa, &7e, &19, &5e, &7b
    equb   5, &96, &3f, &bd, &54, &dd, &19, &b1, &32, &bc, &69, &2b, &21, &6f, &ee, &19
    equb &b8, &b2, &2d, &2d, &64, &20, &53,   3, &53, &a1, &3e, &fe, &d3,   7, &53, &fb
    equb &a8, &b7, &29, &2b, &e8, &bc, &68, &dd, &19, &39, &a2, &b1, &f0, &53, &1e, &ad
    equb &70, &3b,   3, &d6, &53, &1e, &7a, &a5,   7, &1b, &53, &de, &1e, &9e, &d3, &21
    equb &d6, &19, &68, &fd,   2, &6a, &34, &66, &b0, &9e,   4, &ef,   4, &de, &ed, &f1
    equb &ed, &18, &a4, &69, &17, &53, &53, &e2, &ed, &30, &de, &ea, &9e, &19, &19, &47
    equb &ef,   6, &8c, &72, &ef, &19, &2f, &f0, &ed, &b9, &99, &b1, &de, &23, &a3, &78
    equb &a2, &2f, &30, &ef,   4, &b5, &e4, &a1, &d3, &19, &7a, &a1, &cd, &da, &1b, &d3
    equb &6d,   6, &ed, &71, &b1, &6e,   4, &6d, &ee, &af, &4a, &d1, &5e, &1e, &53, &7c
    equb &ef, &18, &f0, &2d,   2, &b8, &7f, &62, &7c, &8d, &12, &de, &c6, &e4, &8b, &ae
    equb &0d, &ed, &ad, &0f, &e2, &df, &b1, &6e, &e4,   4, &64,   7, &25, &f0, &e4, &19
    equb &2e, &ef, &19, &b0, &4f, &32, &75,   7, &e4, &8d, &5f, &21, &d4, &cd, &cb, &53
    equb &8f, &ae, &af, &ed, &4a, &21, &a1, &79, &23, &ea,   7, &13, &54, &f5, &62, &24
    equb &6f, &4a, &ee, &11, &13, &93, &1e, &a9, &25, &5f, &a1, &7a, &24, &a5, &5e, &0f
    equb &a4, &1e, &ee, &19, &a0, &53, &e1, &a1, &93, &93, &d3, &e1, &32, &97, &93, &53
    equb &d3, &19, &21, &1e, &f9, &19, &a5,   3, &6b, &21, &ae, &12, &7c, &6a, &fa, &2d
    equb &38, &72, &bf, &b0, &21, &ef, &11, &b5, &56, &36,   2, &3d, &68,   1, &8c, &30
    equb &d3, &21, &64, &7e, &64, &a1, &7c, &21, &54, &fe, &f2, &6e, &e4, &29, &5f,   4
    equb &19, &19, &2a, &af, &2d, &e2, &6a, &6f, &a7, &69, &f7, &e9, &32, &a8, &fc, &28
    equb &fa,   7, &d3, &6a, &64, &32, &53,   5, &4a, &62,   4, &56, &d3, &6a, &54, &a4
    equb &6d, &53, &e2, &ed, &69, &14, &1e, &ef, &37,   0, &40, &28, &d3,   5, &2d, &74
    equb &ed,   5, &ef, &5e, &53, &e3, &19, &a5, &30,   5, &17, &a1, &a8, &5f, &21,   5
    equb &22, &ed, &e2, &b1, &62,   2, &64, &65, &6d, &2c, &12, &cc, &6d, &e2,   4, &d3
    equb &53, &a1, &19, &ab, &a2, &cd, &8b, &13,   1, &af, &21, &ed, &51, &94, &f5, &29
    equb &39, &2e, &f0, &1a, &5e,   2, &1e, &7a, &ad, &ed, &39, &70, &b1, &ee,   3, &b4
    equb &d6, &8d, &53, &21, &c2, &de, &8b, &2d, &ed, &19, &2f, &2f,   1, &af, &ff, &3f
    equb &53,   0, &ed, &25,   6, &ef, &24, &e2, &2d, &ed, &ed, &de, &5e, &7b, &31,   7
    equb &13, &cd, &d3, &1b, &d4, &cd,   7,   6, &a2, &6f, &a2, &31, &f0,   6, &f8, &62
    equb &a1, &53, &aa,   0, &64,   5,   0, &25, &0f, &6d, &53, &ed, &d3, &19, &13, &93
    equb &22, &d3, &22, &e1,   5, &64, &65, &2d, &70, &19, &62,   6, &22, &63, &63, &bb
    equb &64, &63, &53,   4, &22, &72, &63, &7e, &64, &63, &64,   5, &22, &65, &5b, &a1

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
.sprite_data
    equb &c0,   0,   0,   0, &32, &11, &80, &10,   0,   0,   0, &20,   6,   8,   0,   0,   1, &8c,   0, &66, &80,   0,   0,   0,   1,   2,   8, &64, &90, &80,   0, &66
    equb &8c,   0,   0,   0, &56, &a3, &c0, &ca,   0,   0,   0,   7, &2d, &66,   0,   0,   0,   0,   0, &60, &c0,   0,   0,   0,   1, &0b, &88, &42, &f0, &3e, &64, &4c
    equb &3c,   0,   0,   0,   3,   1, &19, &68,   0,   0, &13, &21, &2d,   0,   0,   0, &0b, &8d,   0, &40, &68,   0,   0,   0,   2, &ab,   0, &cb, &f8, &18, &90, &4c
    equb &df,   0,   0,   0, &46, &23,   0, &1c,   0,   0, &37,   7,   6,   0,   0,   0, &ca, &35,   4, &42, &fc, &80,   0,   0, &13, &19, &0a, &e8, &74, &99, &83, &1e
    equb &3c, &c0,   0,   0, &46, &23,   0, &0a,   0,   0, &1f, &21,   0,   0,   0,   0, &cb, &bd, &c5, &63, &4f, &c0,   0,   0, &15, &9f, &0b, &e2, &33,   0, &87, &78
    equb &ff, &0c,   0,   0,   7, &83, &59, &0e,   0,   1, &3f,   7,   0,   0,   3, &0f, &4b, &ad, &f5, &7b, &6f, &e0,   0,   0, &47, &ff, &26, &c0, &65,   1, &96, &c0
    equb &c7, &f4,   0,   0,   4,   2, &11,   8,   0,   3, &1f,   7,   0,   0, &0f, &0f, &4a, &25, &b5, &db, &ff, &ac,   0,   0, &4f, &ff, &4e, &80, &61, &0b, &1e,   0
    equb &ff, &ef,   0,   0,   6, &13, &11, &5c,   0, &21, &3f, &21,   0,   1, &0f, &0f, &4b, &ad, &a5, &4b, &7a, &9e, &80,   0, &37, &fb, &ce, &80, &f8,   1, &96, &e0
    equb &79, &79, &c0,   0,   6, &13, &11, &1e,   0,   7, &1f, &21,   0,   3, &1f, &2f, &4b, &ad, &85, &43, &6f, &7c, &c0,   0, &13, &f9, &8c, &40, &e0,   0, &87, &3c
    equb &2f, &3d, &cc,   0, &26,   3,   0, &8c,   0, &21, &3f,   7,   0,   3, &0e, &0d, &4a, &25,   4, &42, &df, &4f, &ca,   0, &13, &f0, &8c, &10, &80, &11, &87, &1e
    equb &ff, &ff, &3c,   0,   4,   3, &28, &24,   0,   7, &3f,   7,   0,   7, &0f, &0f, &0b, &8d,   0, &40, &bd, &ef, &9e,   0, &0d, &f0, &8f,   0, &0c, &10, &80, &84
    equb &96, &c7, &f7,   0,   4,   6, &68, &30,   0, &21, &1f, &21,   0,   6, &0b, &0d,   0,   0,   0, &40, &9f, &3e, &5e, &80, &15, &f1, &ae,   0, &cc, &32, &32,   0
    equb &ff, &ff, &de, &80, &40, &40, &40, &10,   0,   7, &3f, &21,   0, &11, &44, &22,   3, &0e,   0, &42, &ff, &a7, &fc, &84, &37, &eb, &cc,   1, &0e,   0, &12,   8
    equb &b6, &1e, &8f, &68, &60, &60,   0,   3,   0, &21, &3f,   7,   1, &0f, &0f, &0f, &0e, &0b,   8, &41, &a7, &bf, &9f, &68, &6f, &ef, &0f, &11, &ca,   0, &25, &0c
    equb &ff, &ff, &ff, &8e,   0,   0,   0, &ca,   0,   7, &1f,   7,   1, &0f, &0f, &0f, &88, &88, &88, &62, &6f, &9f, &3f, &f8,   7, &bf, &0d,   3, &2d,   0, &48, &44
    equb &69, &c7, &78, &be,   0, &11, &91,   6,   0, &21, &3f,   7,   0, &80,   0, &90,   0, &12, &c0, &71, &cf, &ff, &ef, &fe, &11, &9b, &88, &33, &ed,   0, &4b, &0e
    equb &6d, &6f, &3d, &8f,   0, &23, &c0, &0c,   0, &21, &3f, &21, &30, &e8, &30, &b9, &0c, &25, &e0, &50, &6f, &8f, &d6, &af,   1, &8a,   8,   7, &0f,   8,   0,   0
    equb &ff, &ff, &ff, &ff,   0,   1, &19, &1a, &11,   7, &1f, &21, &73, &fc, &73, &bb, &ce, &25, &c0, &66, &ed, &af, &cf, &cb,   0, &0b, &8c, &ff, &8f, &1d, &ff, &ff
    equb &3c, &9e, &c7, &3c,   0, &23, &11, &2a, &13,   7, &3f,   7, &74, &f2, &74, &b0, &ce,   0, &31,   6, &cf, &ff, &9f, &df,   1,   9,   0,   7, &0f,   8, &dc, &e0
    equb &ff, &ff, &ff, &ff,   0,   3, &59,   8,   4, &21, &3f,   7, &64, &b2, &64, &90, &ed, &ff, &e2, &ff, &7f, &bf, &df, &7f, &22,   0, &88, &33, &6f, &11, &dd, &ff
    equb &e3, &3d, &0f, &e3,   0,   1, &11, &4c, &17, &21, &1f,   7, &64, &32, &32,   7, &ed, &ff, &80,   6, &7b, &3e, &7f, &1f, &74, &11, &c0,   3,   7,   0, &dc, &e0
    equb &ff, &ff, &ff, &ff,   0,   2, &11, &7e, &0c,   7, &3f,   7, &64, &77, &b0, &27, &eb, &ff, &ee, &ff, &2f, &e7, &3f, &bf, &40, &10,   0, &11, &46, &11, &dd, &ff
    equb &3c, &8f, &79, &2d,   0,   7,   0, &3c, &97,   7, &3f, &21, &64, &72, &80,   5, &eb,   0, &33,   6, &7f, &3f, &7e, &ef, &60, &10, &80,   1, &0e,   0, &cc,   0
    equb &ff, &ff, &ff, &ff,   0, &27,   0, &0c, &0c, &21, &1f, &21, &fe,   0, &20,   7, &e7, &25, &c0, &66, &df, &ff, &cf, &4f, &70, &10, &c0,   0, &cc,   0, &11, &cc
    equb &cb, &6b, &d6, &c7,   8, &0d,   0, &40, &97, &21, &1f,   7, &f4, &20, &20, &27, &6f, &25, &e0,   5, &9e, &cf, &c7, &6d, &dc, &33, &40, &11,   0,   0, &d1, &88
    equb &87, &e7, &1e, &de, &18, &81,   0, &60, &0c,   7, &3f,   7,   0, &32, &64,   5, &69,   0,   0,   5, &8f, &4f, &5f, &ef, &8e, &23,   8, &c1, &60,   0,   0,   0
    equb &ff, &ff, &ff, &ff, &98, &10,   0,   0, &0c,   7, &3f,   7, &64, &32, &32,   6, &6f, &88, &40, &20, &df, &fe, &ff, &b7, &0d,   3,   4, &61, &c0, &8e, &30, &80
    equb &a7, &1e, &c7, &4b, &90, &10, &80,   0, &97,   7, &1f,   7, &64, &77, &b0,   0, &6f,   8, &90, &22, &f7, &3f, &ef, &3f, &8c, &23,   4,   1, &11, &4a,   7, &0c
    equb &ff, &ff, &ff, &ff, &88, &22,   0,   0, &1f, &21, &1f, &21, &64, &72, &80, &20, &6f, &98, &b0, &64, &5f, &b7, &2f, &ef, &8f, &ab,   8, &11, &11, &ed, &f0, &f7
    equb &9e, &c7, &79, &1e,   8, &74,   0, &88, &0c, &21, &3f, &21, &e0,   0, &30, &e2, &6f, &78, &70, &bc, &5f, &af, &7b, &8f, &8b, &ab, &2e, &9f,   1, &bd,   0,   0
    equb &ff, &ff, &ff, &ff, &88, &40, &11, &c0, &84,   7, &3f,   7, &e8, &20, &73, &ee, &6f, &7c, &a0,   6, &cf, &ff, &6f, &ed, &cc, &22, &3f, &99, &99, &2f, &73, &ee
    equb &7b, &5a, &8f, &c7, &80, &60, &10,   0, &1f,   7, &1f,   7, &c0, &3a, &30, &e0, &6f, &3c,   4, &9c, &8f, &7d, &cf, &f7, &37, &11, &11, &ff, &99, &0f, &30, &c4
    equb &e3, &0f, &1e, &e7,   8, &70, &10, &80,   0, &11, &ee, &0f,   1, &3a,   4, &20, &6f, &d8, &a0, &0e, &ff, &c7, &ef, &5f,   7,   9, &dd, &99, &88, &9f,   0,   0
    equb &ff, &ff, &ff, &ff, &88, &dc, &10, &c0,   0, &11, &ee, &0f, &1b, &3a,   6, &0e, &6f, &1c, &c0,   4, &d7, &6f, &7f, &4f,   7, &0d, &0c, &9f,   0, &ee, &73, &ee
    equb &3c, &9e, &e3, &1e, &0c, &8e, &33, &40,   0,   1, &0e, &44, &0a, &3a,   4, &0e, &6f, &bc, &80, &2a, &1f, &ff, &fd, &cf,   7, &0d,   8,   0,   0, &5c, &30, &cc
    equb &ff, &ff, &ff, &ff, &cc, &0d, &23,   8,   0, &11, &ee, &0b, &0b, &3a,   2, &4e, &6f, &e8, &80, &9f, &bf, &bd, &9f, &ff, &0e, &81,   8,   0,   0, &2c, &30, &c4
    equb &4f, &79, &0f, &e3, &c0, &8d,   3,   4,   0,   5, &0e, &0f, &1b, &3a,   6, &0a, &6f, &5f, &48,   3, &ef, &0f, &9f, &7b, &0c, &c5,   8,   0,   0, &6e, &30, &cc
    equb &ff, &ff, &ff, &ff, &8c, &8e, &23,   0,   0,   4,   0, &0f, &0a, &2a, &0e, &0e, &6f, &1f, &0c,   6, &7b, &2f, &ff, &2f, &80, &c1,   0,   0,   0, &2c,   0,   0
    equb &3d, &bc, &79, &0f, &88, &8f, &ab, &2e,   0, &1d, &ee, &78,   9,   9, &4e, &4e, &6f, &ef, &4e, &40, &1f, &ff, &eb, &2f, &c4, &10,   0,   0,   0, &5c, &33, &cc
    equb &3c, &8f, &7d, &3c, &c8, &8b, &aa, &2e,   0, &0d, &0e,   8, &0c,   3, &0a, &0a, &6f, &8f, &df, &60, &ff, &bd, &3f, &6f, &c0, &10, &88,   0,   0,   0, &30, &cc
    equb &ff, &ff, &ff, &ff, &cc, &44, &33,   0,   1,   8,   0, &0f, &0e,   7, &0e, &0e, &f0, &f0, &f0, &c0, &bd, &1f, &1f, &ff,   0, &10, &80,   0,   0,   0, &30, &cc
    equb &e3, &1e, &8f, &e3, &48, &37,   1, &cc,   1, &5d, &ee, &78, &2f, &27, &4e, &4e, &6f, &ff, &ef, &ec, &9f, &7f, &df, &3d,   0, &88,   0,   0,   0,   0, &30, &cc
    equb &ff, &ff, &ff, &ff, &88,   7,   1, &0e,   3,   1, &0e,   8, &0d,   5, &0a, &0a, &6f, &ff, &ef, &ec, &df, &de, &ff, &8f, &22, &91, &40, &40,   0,   0, &30, &c4
    equb &0f, &c7, &79, &2d, &c4,   3,   1, &0e,   3, &c4,   1, &0f, &0f,   7, &0e, &0e, &6f, &ff, &ef, &de, &7f, &4f, &cb, &ef, &20, &54, &40, &41,   0,   0, &30, &cc
    equb &ff, &ff, &ff, &ff, &ce, &cb, &63, &0e,   6,   0,   3, &f0, &0a,   2, &0a, &0a, &6f, &ff, &ef, &de, &6f, &6f, &8f, &bf, &45, &42, &61, &c3, &ac, &85, &30, &cc
    equb &6b, &79, &0f, &c7, &4a, &c3, &61, &20, &16, &d5, &8f,   0, &55, &55, &55, &55, &6f, &ff, &ef, &be, &ff, &a7, &ff, &bd, &61,   0, &a9, &81, &7f, &ce, &30, &cc
    equb &7f, &ff, &ff, &ff, &cc, &90, &40, &31, &0e,   1, &0f, &0f, &0f, &0f, &0f, &0f, &6f, &ff, &ef, &be, &3d, &bf, &df, &9f, &20, &b8,   1,   3, &88,   7, &30, &cc
    equb &cf, &c7, &b5, &3c, &c6, &10, &88, &30, &0f, &0f, &0f, &0f, &0f, &0f, &0f, &0f, &f0, &f0, &f0, &7e, &8f, &ef, &4f, &ff, &89, &a4, &99,   0, &cc, &ce, &30, &c4
    equb &f7, &ff, &ff, &ce,   0, &10, &80,   0, &0f, &0f, &0f, &0f, &0f,   7, &0e, &0f,   0, &30,   0,   2, &f0, &f2, &f3, &f4, &a0, &90, &80,   0, &77, &cd, &30, &cc
    equb &b5, &0f, &e3, &68,   0,   0,   0, &10, &0f, &0f, &0f, &0f, &0f,   7, &19, &1e,   0, &31,   0, &55, &60, &f0, &70, &e0, &51, &40, &11, &22, &0f, &0f, &30, &cc
    equb &79, &ad, &7b, &0c,   0,   0,   0, &10, &0c,   3,   0,   0, &0e,   2, &47, &69,   0, &20, &11, &20, &40, &a0, &20, &40, &12, &39, &32, &31, &f0, &6f, &30, &c4
    equb &ff, &ff, &8f, &c0,   0,   0,   0, &30, &3c, &c3, &f0, &f0, &19, &55, &1e, &83,   0,   2,   0, &e0,   0, &2b,   4,   0, &22, &c6, &31, &3e,   0, &f6, &30, &cc
    equb &2f, &6b, &df, &88,   0,   0,   0, &21, &0f, &0f, &0f, &0f, &47, &0f, &69, &4f,   0,   6,   1, &51,   0, &22,   9, &44, &10, &50, &33, &3f,   6, &6f, &30, &cc
    equb &ef, &6b, &5a, &80,   0,   0,   0, &61,   0,   6,   0,   0, &0f, &1e, &87, &0f,   0, &0e, &c0, &c0, &11, &7f, &26, &44,   0, &28, &33, &33, &60, &0f, &30, &cc
    equb &7f, &ff, &cf,   0,   0,   0,   0, &43, &f0, &96, &f0, &f0, &0f, &69, &0f, &0e,   1, &0d, &ea, &82, &15, &55, &67, &4c, &10, &0c, &11, &22,   0, &44, &30, &c4
    equb &96, &c7, &78,   0,   0,   0,   0, &43, &0f, &0f, &0f, &0f, &1e, &83, &0f, &1b, &67, &0b, &50, &c0, &33, &df, &ef, &ee,   0,   8,   0,   0, &0f, &cd, &30, &cc
    equb &ff, &ff, &ca,   0,   0,   0,   0, &a5,   0, &0c,   0,   3, &69, &4f, &0e, &4d, &46,   0, &10, &22, &aa, &9d, &aa, &aa,   0,   8, &55,   0,   9, &f0, &30, &cc
    equb &2d, &3c, &e8,   0,   0,   0, &10, &87, &f0, &3c, &f0, &c3, &87, &0f, &1b,   7, &4d, &2e, &10, &80, &ef, &17, &23, &bf, &65, &11, &60,   0, &69, &49, &30, &cc
    equb &ef, &1e, &0c,   0,   0,   0, &10, &d7, &0f, &0f, &0f, &0f, &0f, &0e, &4d, &0c, &8f, &2e, &30, &44, &46, &0e, &37, &99, &33, &8a, &b0, &88, &69, &6e,   0,   0
    equb &7b, &cf, &c0,   0,   0,   0, &30, &7f, &0f, &0f, &0f, &0f, &0f, &1b,   7,   0, &8f,   0, &20,   0, &0f,   7, &1b,   6, &55, &9d, &55,   2, &0f,   8, &70, &ee
    equb &ef, &6f, &88,   0,   0,   0, &30, &7b, &0a, &0d, &0a, &0d, &0e, &4d, &0c,   0, &ce,   0,   0, &44, &0b,   6, &1f, &0b, &66, &0a, &fa, &27,   9,   1,   0, &ac
    equb &2d, &5e, &80,   0,   0,   0, &21, &2f, &55, &22, &55, &22, &1b,   7,   0,   0, &20,   0,   0, &22, &30,   1,   8, &11, &33, &8c, &a0, &fd,   9, &21, &91, &3d
    equb &f3, &ef,   0,   0,   0,   0, &53, &a7, &0f, &0f, &0f, &0f, &4d, &0c,   0,   0, &e0,   0,   0, &22, &43, &0b, &0c, &32, &80, &19, &50, &27, &69, &25, &91, &0f
    equb &ef, &3c,   0,   0,   0,   0, &53, &af, &0f, &0f, &0f, &0f,   7,   0,   0,   0, &c0,   0,   0,   1,   4, &82, &44, &20,   0,   4, &55,   2, &6f, &3d, &80, &0e
    equb &b4, &2e,   0,   0,   0,   0, &a7, &ef,   5, &0f, &0f, &0a, &0c,   0,   0,   0, &80,   0,   0, &88,   6,   3,   0, &30,   0, &24, &24, &24, &6f, &2c, &91, &8c
    equb &ff, &68,   0,   0,   0, &10, &a5, &7f, &84, &aa, &55, &12,   8, &10, &4c,   0, &e8,   0, &11, &c0,   7, &0b, &0c, &30, &80, &24, &ff, &24, &69, &37, &3a, &0c
    equb &6b, &4c,   0,   0,   0,   1, &0f, &ff, &84,   0,   0, &12,   8, &32, &2e,   0, &44,   0, &10,   0,   0,   0,   0, &66, &80,   0, &f6, &24,   9, &33, &47,   7
    equb &ff, &c0,   0,   0,   0, &10, &6f, &8f, &85, &0f, &0f, &1a, &2e,   3, &2e,   0,   0,   0, &10, &80, &71, &9a, &0c, &47,   0, &fb, &64, &99,   9, &22, &47,   9
    equb &a5,   8,   0,   0,   0, &30, &7f, &df, &87, &0b, &0d, &1e, &17,   1, &0c,   0,   0,   0, &10, &c0, &a7, &12, &28,   6, &19, &fd, &80, &f6, &0f,   2, &47, &2e
    equb &5e, &80,   0,   0,   0, &30, &7b, &f5, &83, &49, &29, &1c, &21, &88, &6e, &c1,   0,   0, &33, &40, &aa, &52, &70, &46, &18, &ff, &88, &64, &0f, &22, &23, &a6
    equb &9f,   0,   0,   0,   0, &53, &3f, &7f, &c9, &6c, &63, &39, &47, &88, &6a, &ac,   8,   0, &27,   0, &ff, &12, &c0, &47,   0, &fa,   0,   0,   9, &22, &11, &0c
    equb &78,   0,   0,   0,   0, &c3, &2f, &4f, &64, &3f, &cf, &62, &df,   3, &1f, &ba,   4,   0, &cf,   9, &af, &9a, &d0, &47, &4c, &66,   0,   0, &69, &22,   0, &0a
    equb &ce,   0,   0,   0,   0, &d3, &6f, &e7, &33,   4,   2, &cc, &8e,   2, &1f, &9f, &82,   0, &8f,   9, &aa, &ce, &60, &45, &4c,   0,   0, &44, &69, &33,   0, &0e
    equb &68,   0,   0,   0,   0, &97, &7f, &3f, &f0, &0f, &0f, &0f, &8f,   4, &17, &99, &c8,   0, &4f, &19, &ff, &cf,   8, &22,   0,   0,   0, &e8, &0f,   8,   1, &0f
    equb &8c,   0,   0,   0, &10, &0f, &ff, &ff, &c3, &87, &0f, &0f, &8f, &1d, &2e, &8f, &ec,   1, &4e, &1d, &af, &8d, &0c, &13, &88,   0, &df, &80, &f0, &0f, &0f, &f0
    equb &48,   0,   0,   0, &10, &7a, &6d, &bf, &f0, &0f, &0f, &0f, &65, &23, &e6, &88, &ee, &cb, &2e, &2e, &aa, &ee,   0,   3,   8,   2, &ff, &c0,   0, &1c, &83,   0
    equb &88,   0,   0,   0, &30, &3f, &4f, &af, &77, &ff, &ff, &ee, &23, &23,   8, &f0, &f0, &c3, &0c, &26, &77, &bb, &cc, &c5, &1d, &85, &4f, &e0,   6, &1d, &8b,   6
    equb &80,   0,   0,   0, &61, &ff, &df, &ef, &70, &a5, &0f, &0e,   3, &19, &0c, &ff, &ff, &83,   0,   1,   0,   0,   0, &80, &0c,   3, &4f, &28, &60, &1d, &8b, &60
    equb &ff, &ff,   0,   4, &52, &cf, &ff, &3f, &70, &c3, &0f, &0e, &47, &0c,   4,   0,   0, &44,   8,   1, &70, &91,   8, &e3, &1d, &87, &4f, &0c,   0, &1c, &83,   0
    equb &ff, &ff, &2d, &2a, &d3, &ef, &cf, &f7, &70, &2d, &0f, &0e, &47, &c4, &0c, &31,   0, &61,   8,   0, &87, &59, &0c, &61, &18, &87, &46, &1f, &0f, &0f, &0f, &0f
    equb   0,   0, &22, &11, &97, &2f, &6f, &cf, &70, &87, &0f, &0e, &23, &80, &0c, &31,   0, &41,   0,   0, &0f, &1d, &cc, &40, &10,   6,   0, &17, &f0, &80, &10, &f0

;; ##############################################################################
;; 
;; Extended sprite_data table - used by loader only.
;; 
;; ##############################################################################

    equb   0,   0,   0,   0, &66,   0, &11, &cc,   0,   0,   0,   0, &55,   0,   0, &ff, &88, &77, &77, &22,   0, &33, &99, &bb, &33,   0, &ee,   0,   0, &77, &88, &44
    equb &77, &77, &77, &dd, &ee, &ee, &cd, &3f, &66, &77, &dd, &ff, &dd, &33, &dd, &8f, &cc, &df, &bf, &22,   0, &67, &ff, &ff, &33, &11, &bf,   0,   0, &57, &88, &ff
    equb &df, &df, &df, &dd, &ff, &bf, &9d, &ff, &bf, &cf, &dd, &9f, &dd, &33, &7f, &bb, &cc, &1d, &bb, &77,   0, &66, &3f, &6f, &33, &11, &bb,   0,   0, &77, &99, &8f
    equb &1d, &ff, &dd, &ff, &7f, &1b, &19, &ff, &0b, &6e, &5d, &3b, &0d, &33, &77, &ab, &cc, &77, &3b, &77,   0, &ff,   3,   6, &ff, &ef, &ef, &33, &cc, &17, &89, &ee
    equb &dd, &cf, &7f, &cf, &77, &bb, &99, &ff,   0, &37, &77, &67,   0, &33, &77, &bb, &8c, &67, &33, &df, &88, &6f,   0,   0, &3f, &1f, &ae,   3, &0c, &11, &ee, &3f
    equb &7f, &7f, &17, &dd, &ef, &ef, &dd, &ff,   0, &ef, &27, &77, &88, &ff, &df, &8b,   8,   6, &33, &dd, &88, &66,   0,   0, &33, &11, &bb, &77, &ff, &99, &bf, &ef
    equb   7,   7, &77, &7f, &0e, &0e, &3f, &0f,   0, &0e,   2,   7,   8, &ff, &0d, &ff, &cc, &66, &77, &0d, &7f, &ff, &cc,   0, &33,   1, &df, &88,   0, &11, &ef, &4e
    equb   0,   0,   7,   7,   0,   0,   3,   0,   0,   0,   0,   0,   0, &0f,   0, &0f, &0c,   6,   7,   0,   7, &0f, &0c,   0,   3,   0, &0d, &2f, &af, &89, &0e,   4
    equb   0,   3,   0, &ff, &bb, &bb,   0, &11, &88,   0,   0,   0, &22,   0,   0,   0, &11, &cc, &77, &bb, &66, &22, &33,   0, &ff,   0,   0,   0,   0,   0,   0,   0
    equb &0d, &3f,   0, &cf, &6f, &ff, &77, &77, &ee, &ff, &bb, &88, &ee, &33, &bb, &66, &11, &cc, &77, &ff, &ff, &aa, &df, &99, &88,   0,   0, &57, &5f,   8,   0,   0
    equb &dd, &ff,   0, &ff,   6, &ff, &df, &df, &bf, &bf, &bb, &88, &ff, &8b, &ff, &ff, &ef, &0c, &ff, &bf, &6f, &ff, &9d, &bb, &6e,   0,   0,   0,   0,   0,   0,   0
    equb &df, &bb,   0, &1f, &99, &cf, &dd, &dd, &bb, &bb, &bb, &aa, &ef, &3b, &ef, &bf, &0e,   0, &df, &bb, &66, &7f,   9, &ef,   0,   0,   0,   7, &0f,   8,   0,   0
    equb &ff, &bb,   0, &11, &89, &ff, &dd, &dd, &bb, &bb, &bb, &ff, &ee, &ef, &ee, &3b, &ff, &ff, &dd, &bb, &66, &ff, &99, &bf, &44,   0,   0, &77, &8a, &ff,   0,   0
    equb &dd, &88,   0, &dd, &88, &ff, &7f, &7f, &bb, &bb, &ef, &df, &bf, &bf, &ee, &33, &1f, &ff, &8d, &7f, &ff, &af, &dd, &9b, &88,   0,   0, &f8,   7, &70, &88,   0
    equb &dd, &88,   0, &7f,   8, &ff,   7,   7, &0b, &0b, &0e, &0d, &0b, &0b, &0e,   3,   1, &5f, &99, &bf, &6f, &2a, &3f,   9, &88,   0, &11, &80, &0d,   8, &c4,   0
    equb &df, &88,   0,   7,   0, &0f,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   5,   9, &0b,   6,   2,   3,   0,   8,   0, &10,   7, &0a, &0f, &40,   0
    equb &77, &77, &77, &33, &33, &11, &bb, &77, &ee, &cc, &ff, &ee, &ee, &ee, &ee, &ff, &88,   0,   0,   0,   0, &88,   0,   0, &cc,   0, &fe,   0,   7,   0, &73, &88
    equb &df, &df, &df, &ff, &33, &11, &bb, &df, &bf, &cc, &df, &bf, &bf, &bf, &bf, &cf, &88,   0,   0,   0, &33, &bb, &aa, &bb, &cc,   0, &f0,   6, &0d, &0b, &70, &80
    equb &cd, &1d, &dd, &bf, &33, &11, &ef, &dd, &bb, &7f, &9d, &8b, &3b, &bb, &8b, &1d, &88,   0,   0,   0, &22, &88, &aa, &aa, &cc, &11, &80,   0,   0,   0,   0, &c4
    equb &ff, &77, &7f, &bb, &33, &55, &ce, &dd, &bb, &37, &3b, &cc, &33, &bb, &88, &33,   8,   0,   0,   0, &22, &bb, &bb, &99, &cc, &10, &b3, &cc, &55, &55, &ee, &c0
    equb &df, &cf, &17, &bb, &33, &ff, &ee, &7f, &ef, &33, &13, &8c, &33, &bb, &bb, &67,   0,   3, &0f, &0e, &33, &bb, &88, &bb, &cc, &32, &23, &6e, &dd, &45, &8e, &62
    equb &dd, &dd, &dd, &bb, &33, &bf, &bf, &17, &bf, &33, &11, &99, &bb, &bb, &9b, &66,   0,   6,   0,   0,   0,   0, &11, &88, &dd, &b8, &77, &37, &9d, &44, &ee, &60
    equb &7f, &7f, &7f, &7f, &bb, &1b, &bb, &11, &bb, &33, &11, &ef, &ef, &ef, &ef, &66,   0, &1f, &ff, &ee,   0,   0, &88,   0, &ff, &ec, &47, &13, &19, &44, &4e, &31
    equb   7,   7,   7,   7, &0b,   1, &0b,   1, &0b,   3,   1, &0e, &0e, &0e, &0e,   6,   0, &5f, &ff, &ee, &11, &44, &33,   0, &0f, &68, &ff, &33, &99, &77, &77, &b8
    equb &11, &dd, &bb, &cc, &66, &66, &ff, &77, &33, &bb, &bb, &ff, &66, &ee, &cc, &77, &ff, &1b, &ff, &ee, &22, &aa, &aa, &88,   0, &40, &0f, &67, &cd,   7,   7, &18
    equb &11, &dd, &ef, &ee, &ee, &66, &df, &df, &ef, &ef, &df, &bf, &77, &bf, &cc, &77, &3f, &1f, &ff, &ee, &22, &aa, &aa, &88,   0, &51, &ff, &ce, &7f, &ff, &ff, &dc
    equb &11, &dd, &ee, &ff, &ff, &66, &dd, &dd, &ee, &ee, &1d, &bb, &67, &3b, &6e, &cf, &77, &1f, &ff, &ee, &22, &aa, &aa, &88,   0, &41, &0f, &0c,   7, &0f, &0f, &1c
    equb &11, &dd, &bf, &df, &7f, &ff, &dd, &dd, &bf, &bf, &11, &bb, &66, &ef, &37, &8c, &ef, &5f, &ff, &ee, &22,   0,   0,   0,   0, &40,   0,   0,   0,   0,   0, &10
    equb &11, &dd, &ef, &cd, &67, &ef, &dd, &dd, &ef, &ef, &11, &9b, &57, &8e, &67, &dd, &ce, &1b, &ff, &ee, &33, &bb, &bb, &66, &dd, &f8, &e0,   8,   0,   0, &38, &f0
    equb &dd, &dd, &ee, &cc, &66, &6e, &dd, &dd, &6e, &ee, &dd, &99, &dd, &88, &ce, &7f, &8c, &1f, &ff, &ee, &22, &aa, &22, &66, &99, &70, &e0, &0f, &0a, &0f, &38, &f0
    equb &7f, &7f, &3f, &cc, &66, &66, &ff, &6f, &bf, &bf, &9d, &89, &9d, &ff, &cc, &77, &ff,   6,   0,   0, &22, &aa, &11, &44, &88, &88, &70,   7, &0a, &0f, &70,   0
    equb   7,   7,   3, &0c,   6,   6, &0f,   6, &0b, &0b,   9,   8,   9, &0f, &0c,   7, &0f,   3, &0f, &0e, &22, &aa, &33, &66, &dd, &88, &30, &83,   7,   6, &e0,   0

.sprite_width_lookup
; %wwww000h
;
; 1+%wwww is the sprite width in pixels
;
; if h=1, the horizontal flip flag is inverted when plotting the
; sprite

;        0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &c0, &a0, &50, &90, &40, &50, &60, &40, &21, &20, &20, &21, &11, &11, &50, &30 ; 0
    equb &60, &51, &50, &50, &80, &50, &50, &b0, &b0, &80, &80, &50, &90, &70, &50, &30 ; 1
    equb &40, &20, &10, &f1, &f1, &71, &30, &f0, &f0, &f0, &f0, &f1, &f0, &30, &60, &30 ; 2
    equb &30, &f0, &f0, &f1, &f0, &f0, &f0, &f0, &f1, &f0, &f0, &f0, &f0, &f0, &f0, &f0 ; 3
    equb &f0, &30, &60, &f0, &f0, &70,   0, &f0, &f0, &f0, &f0, &30, &31, &41, &f0, &20 ; 4
    equb &40, &20, &50, &50, &30, &70, &c0, &40, &40, &20, &60, &60, &40, &f0, &70, &20 ; 5
    equb &70, &90, &c0, &30, &40, &50, &60, &40, &40, &30, &f0, &20, &30, &31, &70, &b1 ; 6
    equb &f0, &70, &51, &41, &50, &51, &30, &80, &30, &30, &50, &50, &40                ; 7

;; ##############################################################################
;; 
;; Extended sprite_width_lookup table - used by loader only.
;; 
;; ##############################################################################

    equb   0, &10, &20, &60, &40, &50, &50,   0, &20, &21, &60, &50, &10, &50, &10, &30
    equb &40, &30, &40, &41, &40, &40, &40, &40, &40, &40, &10, &10, &30, &20, &31, &40
    equb &60, &40, &41, &41, &40, &30, &31, &40, &40, &10, &40, &40, &40, &60, &50, &40
    equb &41, &40, &40, &41, &30, &40, &40, &60, &60, &50, &50, &21, &31, &20, &40, &20
    equb &50, &40, &41, &41, &40, &40, &41, &40, &40, &10, &20, &40, &10, &60, &41, &40
    equb &40, &41, &50, &30, &40, &41, &40, &60, &40, &41, &30, &31, &10, &30, &50, &30
    equb &a0, &a0, &90, &d0, &20, &21,   0, &10, &30, &70, &70, &21, &20, &21, &20, &b0
    equb &e0

.sprite_height_lookup
; %hhhhh00v
;
; 1+%hhhhh is the sprite height in pixels
;
; if v=1, the vertical flip flag is inverted when plotting the sprite

;        0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &40, &80, &98, &91, &a8, &a0, &a0, &a0,   9,   8, &10, &19, &19, &18, &58, &18 ; 0
    equb &60, &78, &81, &98, &78, &70, &98, &90, &28, &48, &78, &69, &20, &28, &38, &48 ; 1
    equb &38, &20,   8, &f8, &f8, &68, &f9, &f9, &b9, &79, &39, &f8, &78, &38, &38, &38 ; 2
    equb &f8, &38, &78, &f8, &f8, &78, &f8, &78, &f8, &f8, &c9, &78, &38, &f8, &89,   9 ; 3
    equb &49, &f8, &f8, &f9, &f9, &68,   0, &f8, &78, &38, &39, &f9, &f9, &28, &48, &18 ; 4
    equb &11, &19, &20, &29, &41, &f8, &70, &30, &20, &20, &19, &18, &28, &60, &48, &80 ; 5
    equb &58, &58, &39, &19, &68, &68, &68, &58, &68, &58, &38, &38, &28, &48, &48, &48 ; 6
    equb &48,   8, &30, &20, &28, &39, &70, &38, &30, &20, &20, &20, &20                ; 7

;; ##############################################################################
;; 
;; Extended sprite_height_lookup table - used by loader only.
;; 
;; ##############################################################################

    equb &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &20, &38, &38
    equb &38, &38, &38, &38, &39, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38
    equb &38, &39, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38
    equb &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38
    equb &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38
    equb &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38, &38
    equb &20, &20, &20, &28, &58, &58, &58, &58, &58, &58, &30, &31, &30, &30, &31, &98
    equb &98

.sprite_offset_a_lookup
;        0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &36, &44, &c5,   4, &66,   6, &91, &41, &60, &43, &d0, &d4, &e4, &e4, &a4,   3 ; 0
    equb &97, &63,   3,   5, &77, &97, &65,   6,   6,   6,   6, &e6, &c6, &d6, &e6, &f6 ; 1
    equb &37, &d6, &65,   2,   3, &12, &c2,   3,   3,   3,   3,   2,   2,   4, &96, &c4 ; 2
    equb   4,   4, &43, &43,   0,   0,   5,   5,   1,   0,   0,   0,   0,   5,   5,   5 ; 3
    equb   5,   0, &c0,   0,   0, &44, &c0,   3,   3,   3,   7,   7, &53, &17,   2, &d4 ; 4
    equb &80, &d4,   7, &f6, &c6, &87,   4, &84, &47, &67, &c6, &c6, &96,   2, &44, &d4 ; 5
    equb &c3, &67, &36, &86,   1, &51, &31, &b1, &b1, &c4,   2, &67, &47, &15, &55, &35 ; 6
    equb   5,   0, &16, &37, &e6, &76,   4, &b6, &c4, &47, &84, &b6, &a4                ; 7

;; ##############################################################################
;; 
;; Extended sprite_offset_a_lookup table - used by loader only.
;; 
;; ##############################################################################

    equb &d5, &b4, &13, &d4, &b7, &57, &76, &33, &b3, &b3, &35,   6, &64, &d6, &43, &74
    equb &33, &d0, &33, &52, &30, &c0,   0, &c3, &12, &80, &34, &44, &d5,   4, &d5, &44
    equb &b3,   0, &90, &f2, &81, &b2, &92, &73, &51, &51,   0, &71,   6, &c0, &11, &33
    equb &c1, &c1, &f1, &40, &a2, &40, &e2, &21, &83, &42, &e3, &94, &74, &94, &c4, &15
    equb &45, &53, &c1,   0, &c1, &40, &11, &80, &f1, &c1, &a1, &11, &11, &93, &32, &81
    equb &63, &63, &e1, &42, &13, &72, &82, &b2, &51, &c0, &d2, &a5, &61, &a5, &a5, &a4
    equb &a5, &25, &25, &25, &44, &44, &74, &74, &74, &74, &d6, &16, &16, &16, &16, &56
    equb &17

.sprite_offset_b_lookup
;        0    1    2    3    4    5    6    7    8    9    a    b    c    d    e    f
    equb &42,   2, &e9, &81, &98, &98, &e0, &e0, &7a,   0, &72, &e1, &5a, &3a, &81,   0 ; 0
    equb &e1, &0a,   2, &e9, &60, &68, &e9,   0,   0, &49, &49, &50, &68, &68, &58, &50 ; 1
    equb &d0, &d9, &a0,   0, &28,   1,   1,   9, &49, &89, &c9,   1, &81, &41, &81, &41 ; 2
    equb &80, &41, &80, &20,   0,   0,   0,   0, &89, &80, &80, &80, &31, &80,   9, &89 ; 3
    equb &49, &80, &80, &71,   1, &d0,   0, &80,   1, &41, &4a, &89, &a8, &e9, &f9, &c0 ; 4
    equb &72, &c0,   0, &20,   0, &e0,   0, &18, &11, &e1, &c0, &c8, &51, &b1, &78,   0 ; 5
    equb &2a,   0,   2,   2,   0,   0, &70,   0, &60, &e0, &4a, &0a, &b1, &99, &99, &99 ; 6
    equb &99, &72, &c9, &61, &59, &c1, &d0, &11, &88, &89, &90, &e8, &90                ; 7

;; ##############################################################################
;; 
;; Extended sprite_offset_b_lookup table - used by loader only.
;; 
;; ##############################################################################

    equb &2b, &ca, &8a, &ca, &8a, &8a, &8a, &8a, &8a, &8a, &ca, &8a, &ca, &8a, &8a, &ca
    equb &0b, &0b, &4b, &4b, &ca, &ca, &0b, &0b, &4b, &0b, &c2, &ca, &ca, &ca, &ca, &8a
    equb &8a, &d2, &4b, &0b, &4b, &0b, &0b, &0b, &4b, &4b, &4b, &0b, &0b, &4b, &4b, &0b
    equb &0b, &4b, &0b, &0b, &4b, &4b, &4b, &0b, &4b, &0b, &4b, &8a, &ca, &8a, &8a, &8a
    equb &8a, &ca, &ca, &8a, &ca, &8a, &ca, &8a, &ca, &8a, &8a, &8a, &8a, &ca, &ca, &ca
    equb &8a, &8a, &8a, &8a, &ca, &ca, &8a, &ca, &8a, &8a, &8a, &ca, &ca, &ca, &8a, &3b
    equb &63, &3b, &63, &0b, &2b, &2b, &2b, &2b, &2b, &2b, &b2, &ca, &ca, &ca, &ca, &ea
    equb &ea

.end_of_valid_reloc_code

;; ##############################################################################
;; 
;; Unknown data.
;; 
;; ##############################################################################

IF REMOVE_DEAD_CODE = FALSE
; Unreferenced data
    equb &16, &16, &16, &16, &16, &16, &16, &16,   6,   6,   6,   6,   6,   6,   6, &17
    equb &16, &16, &16, &19, &1e, &23, &16, &17,   9,   6,   6, &13, &17, &17, &17, &17
    equb   6, &13,   6, &2d, &16, &16,   6,   6,   6,   6,   6, &16, &16, &1f,   6,   6
    equb   6,   6, &16, &16,   7,   7,   6,   6,   6,   7,   7,   7, &13,   6,   6, &0c
    equb   6,   6,   6,   7, &13,   7,   3,   6,   6,   6, &1e, &1e, &37, &2d, &16, &1f
    equb &1f, &1e,   6,   6,   6, &3f, &16,   6, &0d, &1f, &1f, &1f, &1f, &37, &19, &29
    equb &16,   6, &1f, &1f,   6,   6,   6,   6,   6,   6, &1f, &0e,   6,   6,   6,   6
    equb   6, &3c, &16, &16, &16,   6, &3d,   6,   6,   6,   6,   6,   6

; Unreferenced data
    equb 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 3, 3, 3, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6
    equb 6

; Unreferenced data
    equb   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   5,   1
    equb &11, &11, &11,   5,   1, &15,   5,   5,   1,   0,   0,   5,   1,   1,   1,   1
    equb   5, &11,   5, &10,   5,   5,   5,   5,   5,   5,   5,   5,   5, &11,   5,   5
    equb   5,   5,   5,   5, &15, &15,   5,   5, &11,   0,   0,   0,   0,   5,   5,   4
    equb   5,   5,   5,   0,   0,   0,   1,   5,   5,   5, &14, &14, &14,   1,   5, &14
    equb &14, &15,   5,   5,   5,   5,   5,   5, &14,   4,   4,   4,   4,   4,   5,   5
    equb   5,   5,   1,   1, &11, &11, &11, &11,   5,   5,   0,   1,   5,   5,   5,   5
    equb   5, &14, &11, &11, &11,   5, &10,   5,   5,   5,   5,   5,   5

; Unreferenced data
    equb 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 1, 1, 1, 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5
    equb 5

; Unreferenced data
    equs "manLI", cr
    equs "manLF", cr
    equs "manKN", cr
    equs "manLB", cr
    equs "manST", cr
    equs "manRU1", cr
    equs "manRU2", cr
    equs "manRU3", cr
    equs "line1", cr
    equs "line2", cr
    equs "line3", cr
    equs "line4", cr
    equs "l"
ENDIF

.end_of_reloc_code

if end_of_valid_reloc_code > (screen_base_page * &100):ERROR "encroaching on screen RAM":endif
PRINT "Loader reloc code has", (screen_base_page * &100) - end_of_valid_reloc_code,"byte(s) free"

    copyblock main_begin, end_of_reloc_code, code_start
    clear main_begin, code_start
    org code_start + (end_of_reloc_code - main_begin)

.start_addr
{
; 
; ; *****************************************************************************
; Loader starting point...
;
; Reset vectors.
; Read from default vector table and write to table at &0200
; 
; Pointer to default vector table stored at &FFB7
; https://tobylobster.github.io/mos/mos/S-s10.html#SP1
; ; *****************************************************************************
; 
    cld
    sei
    lda vector_table_pointer
    sta zp_various_1b
    lda vector_table_pointer + 1
    sta zp_various_1c
    ldy #0
.loop_c72ee
    lda (zp_various_1b),y
    sta userv,y
    iny
    cpy #&12
    bne loop_c72ee
    cli
; 
; ; *****************************************************************************
; Initialisation
; Note: Claiming NMI at this point prevents the loader from
;       being able to load the main game files from Econet, so
;       if running the game from Econet this claim should be
;       disabled, and instead should be implemented at the very
;       start of the main game files EliteB or EliteMC
; ; *****************************************************************************
; 
    lda #osbyte_read_write_escape_break_effect
    ldx #3
    ldy #0
    jsr osbyte                                                                  ; Write Disable ESCAPE action, clear memory on BREAK, value X=3
IF FILE_SYSTEM <> NFS
    lda #osbyte_issue_service_request
    ldx #&0c
    ldy #&ff
    jsr osbyte                                                                  ; Issue paged ROM service call, Reason X=12 - NMI claim
ENDIF
    lda #osbyte_read_tube_presence
    ldx #0
    ldy #0
    jsr osbyte                                                                  ; Write Tube present flag, value X=0
    lda #osbyte_explode_chars
    ldx #0
    jsr osbyte                                                                  ; Implode character definition RAM, can redefine characters 128-159 (X=0)

IF FILE_POINTER_SAVE = IN_STATIC
; 
; ; *****************************************************************************
; Save copy of file system vectors and reselect file system
; ; *****************************************************************************
; 
    lda filev
    sta tmp_filev_ptr_save - main_begin + code_start
    lda filev+1
    sta tmp_filev_ptr_save + 1 - main_begin + code_start
    lda fscv
    sta tmp_fscv_ptr_save - main_begin + code_start
    lda fscv+1
    sta tmp_fscv_ptr_save + 1 - main_begin + code_start
ENDIF

IF STATIC_TOGGLE_FS = TRUE
    ldx #<(static_tape_txt)
    ldy #>(static_tape_txt)
    jsr oscli
    ldx #<(static_fs_txt)
    ldy #>(static_fs_txt)
    jsr oscli
ENDIF
; 
; ; *****************************************************************************
; Relocate &400 bytes of save data from previous game.
; Game data is left between &2C00..&3000.
; Note that the code at &2C00 is NOT part of this loader.
; ; *****************************************************************************
; 
    lda #<save_data_table
    sta zp_various_1b
    lda #>save_data_table
    sta zp_various_1c
    jsr relocate_data_to_page_4
; 
; ; *****************************************************************************
; Doing some checksum test for valid save data at &2C00 and
; saves the result to zp_0. If valid data is not found, then
; loader will report 'default' instead of 'unsaved'
; ; *****************************************************************************
; 
    lda #1
    sta l351f - main_begin + code_start
    lda #&82
    sta zp_various_1b
    lda #&fc
    sta zp_various_1c
    ldy #0
    lda #&6e
    sta zp_0
    lda #&92
    sec
    sed
.c7363
    adc zp_0
    adc #&15
    sta zp_0
.l7369
    eor save_data_table,y
.l736c
    sta save_data_table,y
    eor zp_0
    iny
    bne c737a
    inc l7369 + 2                      ; self modifying code
    inc l736c + 2                      ; self modifying code
.c737a
    inc zp_various_1b
    bne c7363
    inc zp_various_1c
    bne c7363
    cld
;ENDIF
; 
; ; *****************************************************************************
; Relocate code from &3000..&72df to &1700..&59df or
; Relocate code from &3000..&74df to &1500..&59df
; ; *****************************************************************************
; 
.main_game_relocation
    lda code_start
.main_game_relocation_loop
    sta main_begin
    inc main_game_relocation + 1       ; self modifying code
    bne dont_inc_hi_1
    inc main_game_relocation + 2       ; self modifying code
.dont_inc_hi_1
    inc main_game_relocation_loop + 1  ; self modifying code
    bne dont_inc_hi_2
    inc main_game_relocation_loop + 2  ; self modifying code
.dont_inc_hi_2
    lda main_game_relocation + 1
    cmp #<start_addr
    bne main_game_relocation
    lda main_game_relocation + 2
    cmp #>start_addr
    bne main_game_relocation
; 
; ; *****************************************************************************
; Clear zero pages addresses &00..&8f
; ; *****************************************************************************
; 
    lda #0
    ldx #&8f
.loop_c73ab
    sta zp_0,x
    dex
    bne loop_c73ab
; 
; ; *****************************************************************************
; And jump to relocated code
; ; *****************************************************************************
; 
    jmp relocation_run
}

IF STATIC_TOGGLE_FS_TXT = TRUE OR STATIC_TOGGLE_FS = TRUE
.static_tape_txt
    equs "TAPE", cr
.static_fs_txt
IF FILE_SYSTEM = DFS
    equs "DISC", cr
ELIF FILE_SYSTEM = NFS
    equs "NET", cr
ELSE
    equs "ADFS", cr
ENDIF
ENDIF

; 
; ; *****************************************************************************
; Subroutine to relocate 4 pages of data from (&1B) to &400
; ; *****************************************************************************
; 
.relocate_data_to_page_4
{
    lda #4
    sta loop + 2                       ; self modifying code
    ldy #0
    ldx #4
.loop1
    lda (zp_various_1b),y
.loop
    sta l0400,y
    iny
    bne loop1
    inc zp_various_1c
    inc loop + 2                       ; self modifying code
    dex
    bne loop1
    rts
}

; 
; ; *****************************************************************************
; Unused jump left over from decryption code
; ; *****************************************************************************
; 
IF KEEP_FINAL_JMP = TRUE
    jmp code_start
ENDIF

.code_end

print "Start of Relocated code:", ~main_begin, "/", ~code_start
print "End of Relocated code:", ~(end_of_reloc_code-1), "/", ~(end_of_reloc_code-main_begin+code_start-1)
print "Start of Static code:", ~start_addr
print "End of Static code:", ~(code_end-1)
print "End of Relocated code:", ~(end_of_reloc_code-1)
print "Load Address:", ~code_start
print "File Length:", ~(code_end-code_start)
print "Execute Address:", ~start_addr

save "ExileL", code_start, code_end, start_addr
}