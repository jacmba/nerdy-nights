  .inesprg 1
  .ineschr 1
  .inesmap 0
  .inesmir 1

  .bank 0
  .org $8000
RESET:
  sei
  cld

FOREVER:
  jmp FOREVER

NMI:
  rti

  .bank 1
  .org $FFFA
  .dw NMI, RESET, 0
