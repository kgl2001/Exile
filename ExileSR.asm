;constants
NOP = 1

; SWRAM_FE6x: Options are TRUE, FALSE or NOP
; TRUE will include SWRAM FE6x code. NOP will replace SWRAM FE6x code with NOP instructions
SWRAM_FE6x = TRUE

; KEEP_FINAL_JMP: Options are TRUE or FALSE
KEEP_FINAL_JMP = FALSE

include "ExileSR_main.asm"