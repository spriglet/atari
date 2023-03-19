  processor 6502

  seg code
  org $F000   ;Define the code origin at $F000 in ROM

Start:        ; This is a label which is just a alias to a memeory address
  sei         ; Disable interupts
  cld         ; Disabele the BCD decimal math mode
  ldx #$FF    ; Load the X register with #$FF
  txs         ; Transfers the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 to FF)
; Meaning the entire RAM and also the entire TIA registers
; Includes TIA address memory mappings plus the entire ram of our machine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  lda #0       ; A = 0
  ldx #$FF     ; X = #$FF
  sta $FF     ; set the value at $FF's memory block to 0
MemLoop:
  dex          ; X--
  sta $0,X     ; Store the value of A inside memory address 0 + X
  bne MemLoop  ; Loop until X is equal 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill teh ROM Size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  org $FFFC
  .word Start   ; Reset vector at $FFFC  (where the program starts)
  .word Start   ; Reset vector at $FFFE  (unused in the VCS)
