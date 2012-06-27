alias com_chan_@retirar {
  if ($2 != armadura) return
  disabled
  id.check
  op.check @
  if (!$user.exists($2)) msgehalt $nick $2 0não está Cadastrado!
  if ($user.armadura($1) == Nenhuma) msgehalt $nick $2 $+ 15 não tem Armadura!

  .set %golpe1i $readini users/ $+ $2 $+ .ini $2 Armadura
  .set %golpe1if $remove(%golpe1i,$chr(32))
  .set %armadura1ret2 $readini users/ $+ $2 $+ .ini $2 Arm.On 
  if (%armadura1ret != Nenhuma) {
    if (%armadura1ret2 == Nao) {
      .notice $nick 1,1 14,14 9,1 $nick $+ 15,11 $2 15 não está usando Armadura! 14,14 1,1 
    }
    if (%armadura1ret2 == Sim) {
      if ( %#cdzbattleLut1 == $2 ) || ( %#cdzbattleLut2 == $2 ) || ( %#cdzbattle2Lut1 == $2 ) || ( %#cdzbattle2Lut2 == $2 ) && ( %#cdzbattle3Lut1 == $2 ) || ( %#cdzbattle3Lut2 == $2 ) || ( %#cdzbattle4Lut1 == $2 ) || ( %#cdzbattle4Lut2 == $2 ) && ( %#cdzbattle1Lut1 == $2 ) || ( %#cdzbattle1Lut2 == $2 ) || ( %#cdzbattle5Lut1 == $2 ) || ( %#cdzbattle5Lut2 == $2 ) {
        .notice $nick 1,1 14,14 15,1 Espere confirmarem a atualização, pra você retirar a armadura. 14,14 1,1 
      }
      if ( %#cdzbattleLut1 != $2 ) && ( %#cdzbattleLut2 != $2 ) && ( %#cdzbattle2Lut1 != $2 ) && ( %#cdzbattle2Lut2 != $2 ) && ( %#cdzbattle3Lut1 != $2 ) && ( %#cdzbattle3Lut2 != $2 ) && ( %#cdzbattle4Lut1 != $2 ) && ( %#cdzbattle4Lut2 != $2 ) && ( %#cdzbattle1Lut1 != $2 ) && ( %#cdzbattle1Lut2 != $2 ) && ( %#cdzbattle5Lut1 != $2 ) && ( %#cdzbattle5Lut2 != $2 ) {
        if ( %narrador == $2 ) || ( %lutador1 == $2 ) || ( %lutador3 == $2 ) || ( %lutador2 == $2 ) {
          .notice $nick 1,1 14,14 15,1 Espere confirmarem a atualização, pra você retirar a armadura. 14,14 1,1 
        }
        if ( %narrador != $2 ) && ( %lutador1 != $2 ) && ( %lutador3 != $2 ) && ( %lutador2 != $2 ) {
          .set %arm1ret $readini users/ $+ $2 $+ .ini $2 Armadura
          .set %arm1ret2 $readini armaduras.ini %golpe1if Classe
          .set %cos1 $readini users/ $+ $2 $+ .ini $2 Cosmo
          .set %cos1arm $readini users/ $+ $2 $+ .ini $2 Cosarm
          .set %pizza1inv2 $calc( %cos1 - %cos1arm )
          .msg $chan 1,1 14,14 9,1 $Nick $+ 15 forçou11 $2 15a retirar sua armadura de0 %arm1ret $+ 14! 14,14 1,1 
          .writeini users/ $+ $2 $+ .ini $2 Arm.On Nao 
          .writeini users/ $+ $2 $+ .ini $2 Cosmo %pizza1inv2
          .set %invarm $remtok(%invarm,$2,32)
        }
      }
    }
  }
}
