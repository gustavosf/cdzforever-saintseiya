on *:signal:user_logout:$+(.timer.treino.,$1,.*) off

on *:part:#cdzforever:{
  if ($user.treino.active) {
    $+(.timer.treino.,$nick,.*) off
  }
}
on *:QUIT: {
  if ($user.treino.active) {
    $+(.timer.treino.,$nick,.*) off
  }
}
on *:KICK:#cdzforever: {
  if ($user.treino.active($knick)) {
    $+(.timer.treino.,$knick,.*) off
  }
}
alias check.treinando {
  var %treino = $user.treino.active
  if (%treino) {
    msgtopo
    msgl 9Treino14:15 Você já está treinando!
    if (%treino = equipamentos) { msgl       8>15 Treino com Equipamentos 14(0!Treino com equipamento14) | msgl       8>15 Faltam08 $tempo($timer(.treino. $+ $nick $+ .tce).secs) 15para terminar. }
    if (%treino = normal)       { msgl       8>15 Treino Simples 14(0!Treinar14) | msgl       8>15 Faltam08 $tempo($timer(.treino. $+ $nick $+ .normal).secs) 15para terminar. }
    if (%treino = santuario)    { msgl       8>15 Treino com Mestre 14(0!Treinar Santuário14) | msgl       8>15 Faltam08 $tempo($timer(.treino. $+ $nick $+ .santuario).secs) 15para terminar. }
    if (%treino = asgard)       { msgl       8>15 Treino em Asgard 14(0!Treinar Asgard14) | msgl       8>15 Faltam08 $tempo($timer(.treino. $+ $nick $+ .asgard).secs) 15para terminar. }
    if (%treino = marinas)       { msgl       8>15 Treino com os Marinas 14(0!Treinar Marinas14) | msgl       8>15 Faltam08 $tempo($timer(.treino. $+ $nick $+ .marinas).secs) 15para terminar. }
    msgbase
    Halt 
  }
  if ($user.stamina < 10) { msge Você está muito exausto para treinar. | halt }
}

alias check.aventura { 
  if ($timer($+(.aventura.,$nick))) {
    msgehalt 0Você não pode treinar durante uma aventura¼ ¼Sua aventura termina em09 $tempo_certo($timer(.aventura. $+ $nick).secs)
  }
}

alias com_chat_!Treino_com_equipamento {
  id.check =
  check.treinando
  check.aventura

  if ($readini users/ $+ $nick $+ .ini $nick Arm.on == Sim) { .msg =$nick 1,1 14,14 0,1 Você 4não0 pode treinar com Armadura invocada14.0 Digite no 9#15cdzfo0rever 7!9Retirar Armadura 14,14 1,1  | Halt }
  .set %treino $readini(users/ $+ $nick $+ .ini,$nick,TCE)
  if ( %treino == $date ) { .msg =$nick 1,1 14,14 15,1 Você não pode mais realizar esse tipo de 9treino15 hoje! 14,14 1,1  | Halt }

  var %itens = $dados($nick,itens),%carga = 0
  var %p50,%p100,%p200,%p500,%p1000,%p2000

  %p50 = $count(%itens,Peso 50 kg)
  if (%p50 > 2) %p50 = 2
  %p100 = $count(%itens,Peso 100 kg)
  if (%p100 > 2) %p100 = 2
  %p200 = $count(%itens,Peso 200 kg)
  if (%p200 > 2) %p200 = 2
  %p500 = $count(%itens,Peso 500 kg)
  if (%p500 > 2) %p500 = 2
  %p1000 = $count(%itens,Peso 1 ton)
  if (%p1000 > 2) %p1000 = 2
  %p2000 = $count(%itens,Peso 2 ton)
  if (%p2000 > 2) %p2000 = 2

  %pt = $calc(%p50 * 50 + %p100 * 100 + %p200 * 200 + %p500 * 500 + %p1000 * 1000 + %p2000 * 2000)

  if (!%pt) { .msg =$nick 1,1 14,14 15,1 Você não possui nenhum peso para realizar o 00Treinamento15! 14,14 1,1  | Halt }

  msgtopo
  msgt 0SaintSeiya 14::0 Treinos
  msgt Treino com Equipamento
  msgdiv
  msgt 09Você está usando os seguintes pesos:

  var %x = 1
  var %p1 = 14,1._____.
  var %p2 = 14,1'15 \o/ 14'
  var %p3 = 15,1   |   
  var %p4 = 15,1  / \  
  var %p5 = 9,1 ¯¯¯¯¯ 

  msgl
  if (%p50) { msgl           Peso 0050 15Kg 1,14 08,1 %p50 $iif(%p50 = 1,peso,pesos) $spc($iif(%p50 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p100) { msgl          Peso 00100 15Kg 1,14 08,1 %p100 $iif(%p100 = 1,peso,pesos) $spc($iif(%p100 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p200) { msgl          Peso 00200 15Kg 1,14 08,1 %p200 $iif(%p200 = 1,peso,pesos) $spc($iif(%p200 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p500) { msgl          Peso 00500 15Kg 1,14 08,1 %p500 $iif(%p500 = 1,peso,pesos) $spc($iif(%p500 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p1000) { msgl           Peso 001 15Ton 1,14 08,1 %p1000 $iif(%p1000 = 1,peso,pesos) $spc($iif(%p1000 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p2000) { msgl           Peso 002 15Ton 1,14 08,1 %p2000 $iif(%p2000 = 1,peso,pesos) $spc($iif(%p2000 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  while %x <= 5 { msgr [ %p [ $+ [ %x ] ] ] $spc( ,9) | inc %x }

  %carga = $calc(%pt * 0.00004)

  msgt Carga de peso 0total14:08 $div(%pt) quilos
  msgt 0Porcentagem 15de aumento14:09 $calc(%carga *100) $+ $chr(37)
  msgl
  msgt Cosmo 0Inicial14:08 $div($dados($nick,cosmo))
  msgt Cosmo 0Ganho14:11 $div($calc($dados($nick,cosmo) * %carga))
  msgt Cosmo 0Final14:09 $div($calc($dados($nick,cosmo) * (%carga + 1)))
  msgl
  msgt Tempo estimado de 0820 minutos 15para terminar o treinamento
  msgbase
  .timer.treino. $+ $nick $+ .tce 1 1200 fim.treino tce $nick %carga $date
}
alias fim.treino {
  if ($1 = tce) {
    var %tf = $iif($dados($2,specialstatus,treinofail) == $4,$true,$false)
    var %tc = $iif($dados($2,specialstatus,treinocerto) == $4,$true,$false)
    if (($r(1,8) = 1 || %tf) && !%tc) {
      var %lugar = $r(1,4)
      msgstopo $2
      msgs $2 Seu 0treino com equipamentos 15terminou.¼Durante o treino, você sofreu um 0acidente15, e os pesos cairam sobre $replace(%lugar,4,os seu 0pés,3,os seus 0ombros,2,a sua 0cabeça,1,o seu 0genital) $+ 15.¼Você perdeu09 $div($calc($dados($2,cosmo) * ($3 / %lugar))) 15de 0cosmo15, ficando com08 $div($calc($dados($2,cosmo) - ($dados($2,cosmo) * ($3 / %lugar)))) 15de 0cosmo15.
      msgsbase $2
      user.cosmo.retrieve $2 $calc(($dados($2,cosmo) * ($3 / %lugar)))
      user.stamina.retrieve $2 10
      w+ $2 tce $4
    }
    else {
      msgstopo $2
      msgs $2 Seu 0treino com equipamentos 15terminou.¼Você ganhou09 $div($calc($dados($2,cosmo) * $3)) 15de 0cosmo15, ficando com08 $div($calc($dados($2,cosmo) * (1 + $3))) 15de 0cosmo15.
      msgsbase $2
      user.cosmo.add $2 $calc($dados($2,cosmo) * $3)
      user.stamina.retrieve $2 5
      w+ $2 tce $4
    }
  }
}


alias com_chat_!tce {
  reforma sega
  id.check =
  check.treinando
  check.aventura

  if ($readini users/ $+ $nick $+ .ini $nick Arm.on == Sim) { msge Você 4não15 pode treinar com Armadura invocada.¼0Digite no 9#15cdzfo0rever 7!9Retirar Armadura | halt }
  ;if ($dados($nick,tce) == $date) { msge Você não pode mais realizar esse tipo de 9treino15 hoje! | Halt }

  if ($2 isnum) var %carga = $ceil($2)

  var %itens = $dados($nick,itens),%carga = 0
  var %p50,%p100,%p200,%p500,%p1000,%p2000

  %p50 = $count(%itens,Peso 50 kg)
  if (%p50 > 2) %p50 = 2
  %p100 = $count(%itens,Peso 100 kg)
  if (%p100 > 2) %p100 = 2
  %p200 = $count(%itens,Peso 200 kg)
  if (%p200 > 2) %p200 = 2
  %p500 = $count(%itens,Peso 500 kg)
  if (%p500 > 2) %p500 = 2
  %p1000 = $count(%itens,Peso 1 ton)
  if (%p1000 > 2) %p1000 = 2
  %p2000 = $count(%itens,Peso 2 ton)
  if (%p2000 > 2) %p2000 = 2

  %pt = $calc(%p50 * 50 + %p100 * 100 + %p200 * 200 + %p500 * 500 + %p1000 * 1000 + %p2000 * 2000)

  if (!%pt) { .msg =$nick 1,1 14,14 15,1 Você não possui nenhum peso para realizar o 00Treinamento15! 14,14 1,1  | Halt }

  msgtopo
  msgt 0SaintSeiya 14::0 Treinos
  msgt Treino com Equipamento
  msgdiv
  msgt 09Você está usando os seguintes pesos:

  var %x = 1
  var %p1 = 14,1._____.
  var %p2 = 14,1'15 \o/ 14'
  var %p3 = 15,1   |   
  var %p4 = 15,1  / \  
  var %p5 = 9,1 ¯¯¯¯¯ 

  msgl
  if (%p50) { msgl           Peso 0050 15Kg 1,14 08,1 %p50 $iif(%p50 = 1,peso,pesos) $spc($iif(%p50 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p100) { msgl          Peso 00100 15Kg 1,14 08,1 %p100 $iif(%p100 = 1,peso,pesos) $spc($iif(%p100 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p200) { msgl          Peso 00200 15Kg 1,14 08,1 %p200 $iif(%p200 = 1,peso,pesos) $spc($iif(%p200 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p500) { msgl          Peso 00500 15Kg 1,14 08,1 %p500 $iif(%p500 = 1,peso,pesos) $spc($iif(%p500 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p1000) { msgl           Peso 001 15Ton 1,14 08,1 %p1000 $iif(%p1000 = 1,peso,pesos) $spc($iif(%p1000 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  if (%p2000) { msgl           Peso 002 15Ton 1,14 08,1 %p1000 $iif(%p2000 = 1,peso,pesos) $spc($iif(%p2000 = 1,peso,pesos),15) $+ [ %p [ $+ [ %x ] ] ] | inc %x }
  while %x <= 5 { msgr [ %p [ $+ [ %x ] ] ] $spc( ,9) | inc %x }

  %carga = $calc(%pt * 0.00004)

  msgt Carga de peso 0total14:08 $div(%pt) quilos
  msgt 0Porcentagem 15de aumento14:09 $calc(%carga *100) $+ $chr(37)
  msgl
  msgt Cosmo 0Inicial14:08 $div($dados($nick,cosmo))
  msgt Cosmo 0Ganho14:11 $div($calc($dados($nick,cosmo) * %carga))
  msgt Cosmo 0Final14:09 $div($calc($dados($nick,cosmo) * (%carga + 1)))
  msgl
  msgt Tempo estimado de 0820 minutos 15para terminar o treinamento
  msgbase
  .timer.treino. $+ $nick $+ .tce 1 1200 fim.treino tce $nick %carga
}
