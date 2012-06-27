on *:text:!Invocar Armadura:#: {
  if ($chan isin %chanscdz) {
    if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) { .notice $nick 1,1 14,14 4,1 Você não está0 cadastrado! 14,14 1,1  | Halt }
    .set %arminvoc $readini users/ $+ $nick $+ .ini $Nick Armadura 
    .set %armadinv $readini users/ $+ $nick $+ .ini $Nick Arm.On 
    if (%arminvoc == Nenhuma) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, você não tem Armadura! 14,14 1,1  | .unset %arminvoc | Halt }
    if (%armadinv == Sim) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, Você já está usando Armadura! 14,14 1,1  | .unset %armadinv | Halt }
    .set %armlife $readini users/ $+ $nick $+ .ini $Nick Hp.Arm 
    if (%armlife <= 0) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, sua armadura está 4DESTRUÍDA15! 14,14 1,1  | .unset %armlife | Halt }
    if ($user.treino.active) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, você 4não15 pode Invocar armadura enquanto está treinando! 14,14 1,1  | Halt }
    if ( %#cdzbattleLut1 == $nick ) || ( %#cdzbattleLut2 == $nick ) || ( %#cdzbattle2Lut1 == $nick ) || ( %#cdzbattle2Lut2 == $nick ) || ( %#cdzbattle3Lut1 == $nick ) || ( %#cdzbattle3Lut2 == $nick ) || ( %#cdzbattle4Lut1 == $nick ) || ( %#cdzbattle4Lut2 == $nick ) || ( %#cdzbattle1Lut1 == $nick ) || ( %#cdzbattle1Lut2 == $nick ) || ( %#cdzbattle5Lut1 == $nick ) || ( %#cdzbattle5Lut2 == $nick ) {
    .notice $nick 1,1|14,14|15,1 Você acha que é malandro de onde?0 Espere confirmarem a atualização, pra você invocar a armadura. 14,14 1,1  | Halt }
    if ( %narrador == $nick ) || ( %lutador1 == $nick ) || ( %lutador3 == $nick ) || ( %lutador2 == $nick ) {
    .notice $nick 1,1|14,14|15,1 Você acha que é malandro de onde?0 Espere confirmarem a atualização, pra você invocar a armadura. 14,14 1,1  | Halt }
    .set %arinv $readini users/ $+ $nick $+ .ini $Nick Armadura
    .set %armain $remove(%arinv,$chr(32))
    .set %armclas $readini armaduras.ini %armain Classe
    $+(.timer.armadura.,$nick,.invocada) 1 $calc(2 * 60) noop
    if (%armclas == d) { .set %cporcinv 0.01 }
    if (%armclas == c) { .set %cporcinv 0.05 }
    if (%armclas == b) { .set %cporcinv 0.1 }
    if (%armclas == a) { .set %cporcinv 0.2 }
    if (%armclas == s) { .set %cporcinv 0.5 }
    .set %cosinvarm $readini users/ $+ $nick $+ .ini $nick Cosmo
    .set %csinfarma $calc((%cosinvarm * %cporcinv))
    .set %cosinvfin $round(%csinfarma,0)
    .writeini users/ $+ $nick $+ .ini $nick Cosarm %cosinvfin
    .set %cosarminv $readini users/ $+ $nick $+ .ini $nick Cosarm
    .set %pizzainvf $calc(%cosinvarm + %cosarminv)
    .msg $chan 1,1 14,14 9,1 $nick $+ ,15 vestiu a Armadura de0 %arinv 14/15 Seu Cosmo com a armadura invocada é de7  $+ $replace($bytes(%pizzainvf,b),$chr(44),.) $+  14,14 1,1 
    .writeini users/ $+ $nick $+ .ini $Nick Arm.On Sim 
    .writeini users/ $+ $nick $+ .ini $Nick Cosmo2 %cosinvarm
    .writeini users/ $+ $nick $+ .ini $Nick Cosmo %pizzainvf
    .unset %csinfarma
    .unset %arminvoc
    .unset %armadinv
    .unset %armlife
    .unset %arinv
    .unset %armain
    .unset %armclas
    .unset %cosinvarm
    .unset %cosinvfin
    .unset %cosarminv
    .unset %pizzainvf
  }
}

on *:text:!Retirar Armadura:#: {
  if ($chan isin %chanscdz) {
    if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) { .notice $nick 1,1 14,14 4,1 Você não está0 Cadastrado! 14,14 1,1  | Halt }
    .set %armretir $readini users/ $+ $nick $+ .ini $Nick Armadura 
    if (%armretir == Nenhuma) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, você não tem Armadura! 14,14 1,1  | .unset %armretir | Halt }
    if ($readini users/ $+ $nick $+ .ini $Nick Arm.On == Nao) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, você não está usando Armadura! 14,14 1,1  | Halt }
    if ( %#cdzbattleLut1 == $nick ) || ( %#cdzbattleLut2 == $nick ) || ( %#cdzbattle2Lut1 == $nick ) || ( %#cdzbattle2Lut2 == $nick ) && ( %#cdzbattle3Lut1 == $nick ) || ( %#cdzbattle3Lut2 == $nick ) || ( %#cdzbattle4Lut1 == $nick ) || ( %#cdzbattle4Lut2 == $nick ) && ( %#cdzbattle1Lut1 == $nick ) || ( %#cdzbattle1Lut2 == $nick ) || ( %#cdzbattle5Lut1 == $nick ) || ( %#cdzbattle5Lut2 == $nick ) {
    .notice $nick 1,1 14,14 15,1 Você acha que é malandro de onde?0 Espere confirmarem a atualização, pra você retirar a armadura. 14,14 1,1  | Halt }
    if ( %narrador == $nick ) || ( %lutador1 == $nick ) || ( %lutador3 == $nick ) || ( %lutador2 == $nick ) {
    .notice $nick 1,1 14,14 15,1 Você acha que é malandro de onde?0 Espere confirmarem a atualização, pra você retirar a armadura. 14,14 1,1  | Halt }
    if ($timer($+(.armadura.,$nick,.invocada))) {
      .noticen Você só pode retirar armadura após passar 082 minutos15 da invocação.
      halt
    }
    else {
      .set %armret $readini users/ $+ $nick $+ .ini $nick Armadura
      .set %armart $remove(%armret,$chr(32))
      .set %retcls $readini armaduras.ini %golpeif Classe
      .set %retcos $readini users/ $+ $nick $+ .ini $nick Cosmo
      .set %rcosarm $readini users/ $+ $nick $+ .ini $nick Cosarm
      .set %pizzaretf $calc(%retcos - %rcosarm)
      .msg $chan 1,1 14,14 9,1 $nick $+ ,15 retirou a Armadura de0 %armret 14/15 Seu Cosmo com a armadura retirada é de7  $+ $replace($bytes(%pizzaretf,b),$chr(44),.) $+  14,14 1,1 
      .writeini users/ $+ $nick $+ .ini $Nick Arm.On Nao 
      .writeini users/ $+ $nick $+ .ini $Nick Cosmo %pizzaretf
    }
    .unset %armret
    .unset %armart
    .unset %retcls
    .unset %retcos
    .unset %rcosarm
    .unset %pizzaretf
    .unset %armretir 
  }
}

on *:text:!Life Armadura:#: {
  if ($chan isin %chanscdz) {
    if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) { .notice $nick 1,1 14,14 4,1 Você não está0 Cadastrado! 14,14 1,1  | Halt }
    .set %arlifem $readini users/ $+ $nick $+ .ini $Nick Armadura 
    if (%arlifem == Nenhuma) { .notice $nick 1,1 14,14 9,1 $nick $+ 15, você não tem Armadura! 14,14 1,1  | .unset %arlifem | Halt }
    .set %hparm $readini users/ $+ $nick $+ .ini $Nick Hp.Arm 
    .set %hprec $readini users/ $+ $nick $+ .ini $Nick Hp.Rec 
    if (%hparm < 0) { .set %hparm2 0 }
    if (%hparm >= 0) { .set %hparm2 %hparm }
    .msg $chan 1,1 14,14 0,1 $nick $+ , 15o life da sua Armadura é de9 %hparm2 15/7 %hprec 14,14 1,1 
    .unset %hparm2
    .unset %hparm 
    .unset %hprec
    .unset %arlifem
  }
}

on *:text:@Life Armadura*:#: {
  if ($chan isin %chanscdz) {
    if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) { .notice $nick 1,1 14,14 4,1 Você não está0 cadastrado! 14,14 1,1  | Halt }
    if ($readini users/ $+ $3 $+ .ini $3 Nick == $null) { .notice $nick 1,1 14,14 4,1 $3 0não está cadastrado! 14,14 1,1  | Halt } 
    .set %armlifeout $readini users/ $+ $3 $+ .ini $3 Armadura 
    if (%armlifeout == Nenhuma) { .notice $nick 1,1 14,14 9,1 $3 $+ 15 não tem Armadura! 14,14 1,1  | .unset %armlifeout | Halt }
    .set %hparm3 $readini users/ $+ $3 $+ .ini $3 Hp.Arm 
    .set %hprec3 $readini users/ $+ $3 $+ .ini $3 Hp.Rec 
    if (%hparm3 < 0) { .set %hparm4 0 }
    if (%hparm3 >= 0) { .set %hparm4 %hparm3 }
    .msg $chan 1,1 14,14 0,1 $nick $+ , 15o life da Armadura do14(15a14) 11 $+ $3 $+ 15 é de9 %hparm4 15/7 %hprec3 14,14 1,1 
    .unset %armlifeout
    .unset %hparm3
    .unset %hprec3
    .unset %hparm4
  }
}
