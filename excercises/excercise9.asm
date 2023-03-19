  processor 6502
  seg Code ; Define a new segment named "Code"
  org $F000 ; Define the origin of the ROM code at memory address $F000

Start:
 lda #1 ; Initialize the A register with the decimal value 1
Loop:
 ; TODO:
 cls
 adc #1     ; Increment A
 cmp #10    ; Compare the value in A with the decimal value 10
 bne Loop   ; Branch back to loop if the comparison was not equals (to zero)

 jump Start
  org $FFFC ; End the ROM by adding required values to memory position $FFFC
  .word Start ; Put 2 bytes with the reset address at memory position $FFFC
  .word Start ; Put 2 bytes with the break address at memory position $FFFE

