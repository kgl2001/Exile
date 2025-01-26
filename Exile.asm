;constants
STH = 0
V1 = 1
V2 = 2
V3 = 3
MC = 4
CUSTOM = 5
PAGE_15 = 0
PAGE_17 = 1
DFS = 0
NFS = 1
ADFS = 2
NOP = 1
IN_STATIC = 0
IN_RELOC = 1
DATA_STH_V1 = 1
DATA_V2_V3 = 2
DATA_MC = 3

; VERSION: Select from one of the following options:
; STH    Will build a version of the Loader that matches the Loader file from the STH archives
; V1     Will build a version of the Loader that matches the hfe image Exile_D1S1_80T_HG3_2066CA7D_1.hfe
; V2     Will build a version of the Loader that matches the hfe image Exile_D1S1_80T_HG3_EA8CECA2_1.hfe
; V3     Will build a version of the Loader that matches the hfe image Exile_D1S2_80T_HG3_162468BD_1.hfe
; MC     Will build a version of the Loader that matches the hfe image Exile_A6B2BE99.hfe
; CUSTOM Will build a custom version of the Loader - Adjust CUSTOM settings below (after line: IF VERSION = CUSTOM)
VERSION = V3

IF (VERSION < STH OR VERSION > CUSTOM):ERROR "Incorrect Source Version Option Selected":ENDIF

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

IF VERSION = STH
RELOC_ADDR = PAGE_15
FILE_SYSTEM = DFS
REMOVE_DEAD_CODE = FALSE
SWRAM_FE6x = TRUE
DYN_MAP_DATA_ADDR = FALSE
FILE_POINTER_SAVE = IN_RELOC
STATIC_TOGGLE_FS_TXT = FALSE
STATIC_TOGGLE_FS = FALSE
RELOC_TOGGLE_FS_TXT = TRUE
RELOC_TOGGLE_FS = NOP
UNREF_DATA = DATA_STH_V1
KEEP_FINAL_JMP = TRUE

ELIF VERSION = V1
RELOC_ADDR = PAGE_15
FILE_SYSTEM = DFS
REMOVE_DEAD_CODE = FALSE
SWRAM_FE6x = TRUE
DYN_MAP_DATA_ADDR = FALSE
FILE_POINTER_SAVE = IN_RELOC
STATIC_TOGGLE_FS_TXT = FALSE
STATIC_TOGGLE_FS = FALSE
RELOC_TOGGLE_FS_TXT = TRUE
RELOC_TOGGLE_FS = TRUE
UNREF_DATA = DATA_STH_V1
KEEP_FINAL_JMP = FALSE

ELIF VERSION = V2 OR VERSION = V3
RELOC_ADDR = PAGE_17
FILE_SYSTEM = DFS
REMOVE_DEAD_CODE = FALSE
SWRAM_FE6x = TRUE
DYN_MAP_DATA_ADDR = FALSE
FILE_POINTER_SAVE = IN_STATIC
STATIC_TOGGLE_FS_TXT = TRUE
STATIC_TOGGLE_FS = TRUE
RELOC_TOGGLE_FS_TXT = TRUE
RELOC_TOGGLE_FS = FALSE
UNREF_DATA = DATA_V2_V3
KEEP_FINAL_JMP = FALSE

ELIF VERSION = MC
RELOC_ADDR = PAGE_15
FILE_SYSTEM = ADFS
REMOVE_DEAD_CODE = FALSE
SWRAM_FE6x = TRUE
DYN_MAP_DATA_ADDR = FALSE
FILE_POINTER_SAVE = IN_RELOC
STATIC_TOGGLE_FS_TXT = FALSE
STATIC_TOGGLE_FS = FALSE
RELOC_TOGGLE_FS_TXT = TRUE
RELOC_TOGGLE_FS = TRUE
UNREF_DATA = DATA_MC
KEEP_FINAL_JMP = FALSE

ELIF VERSION = CUSTOM
RELOC_ADDR = PAGE_17
FILE_SYSTEM = NFS
REMOVE_DEAD_CODE = TRUE
SWRAM_FE6x = FALSE
DYN_MAP_DATA_ADDR = TRUE
FILE_POINTER_SAVE = IN_STATIC
STATIC_TOGGLE_FS_TXT = FALSE
STATIC_TOGGLE_FS = FALSE
RELOC_TOGGLE_FS_TXT = FALSE
RELOC_TOGGLE_FS = FALSE
UNREF_DATA = FALSE
KEEP_FINAL_JMP = FALSE
ENDIF

include "ExileL_main.asm"
clear 0, &ffff
include "ExileSR_main.asm"
