;-------------------------------------------------------------------
; Program 4 - Backgrounds tutorial
;-------------------------------------------------------------------

  .inesprg 1
  .ineschr 1
  .inesmir 1
  .inesmap 0

  .bank 0
  .org $8000
Reset:
  sei
  clc

VBWait1:
  bit $2002
  bpl VBWait1

  lda #%10010000 ;Enable NMI
  sta $2000

  lda #%00011110 ;Enable sprites and background
  sta $2001

VBWait2:
  bit $2002
  bpl VBWait2

  lda #$3F
  sta $2006
  lda #$00
  sta $2006
  ldx #$00
LoadPalete:
  lda palette,x
  sta $2007
  inx
  cpx #$10
  bne LoadPalete

  lda $2002
  lda #$20
  sta $2006
  lda #$00
  sta $2006
  ldx #$00
LoadBackground:
  lda nametable,x
  sta $2007
  inx
  cpx #$80
  bne LoadBackground

  lda $2002
  lda #$23
  sta $2006
  lda #$C0
  sta $2006
  ldx #$00
LoadAttribute:
  lda attribute,x
  sta $2007
  inx
  cpx #$08
  bne LoadAttribute

Loop:
  jmp Loop

Nmi:
  lda #$00
  sta $2005
  sta $2005
  rti

;-----------------------------------------------------------------------

  .bank 1
  .org $E000
  
nametable:
  .incbin "background.map"

attribute:
  .db %00000000, %00010000, %0010000, %00010000, %00000000, %00000000, %00000000, %00110000

palette:
  .db $22,$29,$1A,$0F,  $22,$36,$17,$0F,  $22,$30,$21,$0F,  $22,$27,$17,$0F

  .org $FFFA
  .word Nmi, Reset, $00

;-----------------------------------------------------------------------

  .bank 2
  .org $0000
  .incbin "mario.chr"
