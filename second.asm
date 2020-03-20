  .inesprg 1
  .ineschr 1
  .inesmir 1
  .inesmap 0

  .bank 0
  .org $8000

Reset:
  sei
  cld

  ldx #$00

VBlank:
  bit $2002
  bpl VBlank
  inx
  cpx #$02
  bne VBlank ; Wait for 2 V-Blank cycles

  lda #%10000000 ;enable NMI
  sta $2000

  lda #%00010000 ;enable sprite rendering
  sta $2001

  lda $2002
  lda #$3F
  sta $2006
  lda #$00
  sta $2006
  ldx #$00
LoadPalLoop:
  lda Palette, x
  sta $2007
  inx
  cpx #$20
  bne LoadPalLoop

  ldx #$00

LoadSpriteLoop:
  lda Sprite, x
  sta $0200, x
  inx
  cpx #$08
  bne LoadSpriteLoop

Forever:
  jmp Forever

Nmi:
  lda #$00
  sta $2003
  lda #$02
  sta $4014
  rti

Palette:
  .byte $0F,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
  .byte $0F,$05,$28,$08,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F

Sprite:
  .db $80, $36, $00, $80
  .db $80, $37, $00, $88

  .bank 1
  .org $FFFA
  .dw Nmi, Reset, 0

  .bank 2
  .incbin "mario.chr"
