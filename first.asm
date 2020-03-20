  .inesprg 1
  .ineschr 1
  .inesmap 0
  .inesmir 1

  .bank 0
  .org $8000
RESET:
  sei
  cld

  lda #%10000000
  sta $2001

FOREVER:
  jmp FOREVER

  .bank 1
  .org $FFFA
  .dw 0, RESET, 0
