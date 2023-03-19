  processor 6502

  include "vcs.h"
	include "macro.h"

	seg code
  org $F000

Start:
  CLEAN_START
  lda #0           ; loads the accumulator %0000 0000
  sta COLUBK       ; changes the background color to black

  ldx #1           ;  00001
  stx CTRLPF       ;  Stores zero in the register which will turn on reflect


  ldy #$69
  sty COLUPF       ; Sets the color of the playfield

  lda #$B9          ;
  sta COLUP0        ; Sets the color of player 0 to green

  lda #$19
  sta COLUP1        ; sets the color of player 1 to yellow

StartFrame:
  lda #2            ; load accumulator with #0000 00010
  sta VSYNC         ; turns on VSYNC
  sta VBLANK        ; turns on VBLANK

;************************************************************************************************************
; The Vertical Sync
;************************************************************************************************************
  REPEAT 3
    sta WSYNC
  REPEND

  lda #0            ; loads accumulator with #0000 0000
  sta VSYNC         ; turns off VSYNC

;************************************************************************************************************
; The Vertical Blank
;************************************************************************************************************
  REPEAT 37
    sta WSYNC
  REPEND
  lda #0            ; load accumulator with #0000 0000
  sta VBLANK        ; turns off VBLANK

;************************************************************************************************************
; Visible Scanlines - will draw the playfield here
;************************************************************************************************************

;************************************************************************************************************
; Render 7 scanlines that are just blue backgrounds with the playfield values disabled
;************************************************************************************************************
  lda #0           ; loads the accumulator with zero
  sta PF0          ; turns off all the bits for PL0
  sta PF1          ; turns off all the bits for PL1
  sta PF2          ; turns off all bits for PL2
  REPEAT 7
    sta WSYNC
  REPEND

;************************************************************************************************************
; Render 7 scanlines that with a horizontal yellow line
;************************************************************************************************************
  ldx #%11100000        ; loads x with binary value 1110
  stx PF0               ; stores the values 1110 in the PL0 register on the TIA chip

  lda #%11111111        ; loads the accumulator with 1111 11111
  sta PF1
  sta PF2

  REPEAT 7
    sta WSYNC
  REPEND


;************************************************************************************************************
; Render 164 scanlines which will be vertical borders
;************************************************************************************************************
  ldx #%01100000      ; loads the accumulator with the value 0000 0010
  stx PF0             ; loads the value with PLO that will draw the verticle lines

  lda #0
  sta PF1

  ldx #%10000000
  stx PF2

  REPEAT 156
    sta WSYNC
  REPEND
;************************************************************************************************************
; Render 7 scanlines that with a horizontal yellow line
;************************************************************************************************************
  ldx #%11100000         ; loads x with binary value 1110
  stx PF0         ; stores the values 1110 in the PL0 register on the TIA chip

  ldy #%11111111      ; loads the accumulator with 1111 11111
  sty PF1
  sty PF2

  REPEAT 7
    sta WSYNC
  REPEND
;************************************************************************************************************
; Render 7 scanlines that are just blue backgrounds with the playfield values disabled
;************************************************************************************************************
  lda #0           ; loads the accumulator with zero
  sta PF0          ; turns off all the bits for PL0
  sta PF1          ; turns off all the bits for PL1
  sta PF2          ; turns off all bits for PL2
  REPEAT 7
    sta WSYNC
  REPEND
;************************************************************************************************************
; Overscan
;************************************************************************************************************
  lda #2
  sta VBLANK
  REPEAT 30
    sta WSYNC
  REPEND

  lda #0
  sta VBLANK ; Turns off VBLANK

  jmp StartFrame

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Defines an array of bytes to draw th scoreboard numbers
;;  We add the bytes in the laast ROM addresses
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  org $FFE8
PlayerBitmap:
  .byte #%01000010  ; #    #
  .byte #%11100111  ;###  ###
  .byte #%11111111  ;########
  .byte #%10111101  ;#  ##  #
  .byte #%11111111  ;########
  .byte #%10111101  ;# #### #
  .byte #%11000010  ;##    ##
  .byte #%11111111  ;########
  .byte #%01111110  ; ######
  .byte #%01111110  ; ######

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  org $FFFC       ; Defines orgin to $FFFC
  .word Start    ; Reset vector at $FFFC (where program starts)
  .word Start     ; Interupt vector at $FFFE (unused in the VCS)

