  processor 6502
  include "vcs.h"
  include "macro.h"

  seg code
  org $F000       ; defines the orgin of the ROM at $F000

START:
  CLEAN_START      ;  Macro to safely clear the memory

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set background luminosity color to yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #$1E          ; load color into register A
  sta COLUBK           ; store A to BackgroundColor Address $09

  jmp START        ; Repeat

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  org $FFFC       ; Defines orgin to $FFFC
  .word START     ; Reset vector at $FFFC (where program starts)
  .word START     ; Interupt vector at $FFFE (unused in the VCS)
