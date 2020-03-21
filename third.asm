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
  cpx #$10
  bne LoadSpriteLoop

Forever:
  jmp Forever

MoveLeft:
  ldx #$00
MoveLeftLoop: ;Loop to move group of 4 sprites
  lda $0203,x
  sec
  sbc #$01
  sta $0203,x
  txa
  clc
  adc #$04
  tax
  cpx #$10
  bmi MoveLeftLoop
  rts

MoveRight:
  ldx #$00
MoveRightLoop:
  lda $0203,x
  clc
  adc #$01
  sta $0203,x
  txa
  clc
  adc #$04
  tax
  cpx #$10
  bmi MoveRightLoop
  rts

MoveUp:
  ldx #$00
MoveUpLoop:
  lda $0200,x
  sec
  sbc #$01
  sta $0200,x
  txa
  clc
  adc #$04
  tax
  cpx #$10
  bmi MoveUpLoop
  rts

MoveDown:
  ldx #$00
MoveDownLoop:
  lda $0200,x
  clc
  adc #$01
  sta $200,x
  txa
  clc
  adc #$04
  tax
  cpx #$10
  bmi MoveDownLoop
  rts

Nmi:
  lda #$00
  sta $2003
  lda #$02
  sta $4014

  lda #$01
  sta $4016
  lda #$00
  sta $4016 ;latch controller buttons

ReadA:
  lda $4016
  and #%00000001
  beq ReadADone
ReadADone:

ReadB:
  lda $4016
  and #%00000001
  beq ReadBDone
ReadBDone:

ReadSelect:
  lda $4016
  and #%00000001
  beq ReadSelectDone
ReadSelectDone:

ReadStart:
  lda $4016
  and #%00000001
  beq ReadStartDone
ReadStartDone:

ReadUp:
  lda $4016
  and #%00000001
  beq ReadUpDone
  jsr MoveUp
ReadUpDone:

ReadDown:
  lda $4016
  and #%00000001
  beq ReadDownDone
  jsr MoveDown
ReadDownDone:

ReadLeft:
  lda $4016
  and #%00000001
  beq ReadLeftDone
  jsr MoveLeft
ReadLeftDone:

ReadRight:
  lda $4016
  and #%00000001
  beq ReadRightDone
  jsr MoveRight
ReadRightDone:

  rti

  .bank 1
  .org $E000
Palette:
  .byte $0F,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
  .byte $0F,$05,$28,$08,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F

Sprite:
  .db $80, $36, $00, $80
  .db $80, $37, $00, $88
  .db $88, $38, $00, $80
  .db $88, $39, $00, $88
  
  .org $FFFA
  .dw Nmi, Reset, 0

  .bank 2
  .org $0000
  .incbin "mario.chr"
