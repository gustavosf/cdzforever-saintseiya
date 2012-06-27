;; ----------------------------------------------------------------------------
;; Comando :: Chan :: !LutaX <nick[,nick,...]> <nick[,nick,...]> <nick>
;; Atualiza uma luta, sendo os possíveis valores para X:
;;  - F  = Luta fácil
;;  - M  = Luta Média
;;  - D  = Luta Difícil
;;  - WO = Luta WO
;; ----------------------------------------------------------------------------
alias com_chan_!lutaf com_aux_!luta F $1-
alias com_chan_!lutam com_aux_!luta M $1-
alias com_chan_!lutaD com_aux_!luta D $1-
alias com_chan_!lutae com_aux_!luta E $1-
alias com_chan_!lutaWO com_aux_!luta WO $1-
alias com_aux_!luta {
  op.check +
  var %tipo = $1

  ;; verificação de consistência
  if ($hget(atualiza,status)) msgehalt Já está havendo uma atualização!!
  if (!$4) msgehalt Parâmetro 0Faltando15. Sintaxe:9 $1 $iif(%tipo = E,<Lutador1> <Lutador2>,<Vencedor> <Perdedor>) <narrador>
  var %x = 1,%l = $replace($2-3,$chr(44),$chr(32)) $4,%nc
  while (%x <= $numtok(%l,32)) { if !$dados($gettok(%l,%x,32),nick) { %nc = $addtok(%nc," $+ $gettok(%l,%x,32) $+ ",44) } | inc %x }
  if %nc {
    if ($numtok(%nc,44) = 1) msgehalt O seguinte usuário não está 0cadastrado 15no bot:08 %nc
    else msgehalt Os seguintes usuários não estão 0cadastrados 15no bot:8 $replace(%nc,",14"08,$chr(44),15 $+ $chr(44) 08)
  }

  ;; Calculo do bônus
  var %dif = $calc($numtok($3,44) - $numtok($2,44))
  if %dif > 0 {
    var %bonus = $calc(%dif * 100),%bonusd = $calc(%dif * 200)
    if %tipo = E { var %bns = $int($calc(200 / %dif)),%bnsd = $int($calc(300 / %dif)) }
    else { var %bns = $int($calc(100 / (%dif * 2))),%bnsd = $int($calc(200 / (%dif * 2))) }
  }
  if %dif = 0 {
    %dif = $calc((($numtok($3,44) + $numtok($2,44)) - 2) / 2)
    var %bonus = $calc(%dif * 100),%bonusd = $calc(%dif * 200)
    if %tipo = E { var %bns = $calc(%dif * 100),%bnsd= $calc(%dif * 200) }
    else { var %bns = $calc(%dif * 50),%bnsd = $calc(%dif * 100) }
  }
  if %dif < 0 {
    %dif = $abs(%dif)
    var %bonus = $abs($calc(%dif * 50)),%bonusd = $abs($calc(%dif * 100))
    if %tipo = E { var %bns = $abs($calc(%dif * 100)),%bnsd = $abs($calc(%dif * 200)) }
    else { var %bns = $abs($calc(%dif * 25)),%bnsd = $abs($calc(%dif * 50)) }
  }

  hadd -m atualiza status 1
  hadd atualiza tipo $upper(%tipo)
  var %x = 1,%n | while %x <= $numtok($2,44) { 
    %n = $gettok($2,%x,44)
    hadd atualiza p1 $hget(atualiza,p1) $+ , $+ $dados(%n,nick)
    hadd atualiza p1.arm $hget(atualiza,p1.arm) $+ , $+ $replace($dados(%n,arm.on),sim,1,nao,0)
    hadd atualiza p1.cosmo $hget(atualiza,p1.cosmo) $+ , $+ $calc($dados(%n,cosmo) + $replace($hget(atualiza,tipo),D,1500,M,1400,F,1200,E,1500,WO,500) + %bonus)
    hadd atualiza p1.dinheiro $hget(atualiza,p1.dinheiro) $+ , $+ $calc($dados(%n,dinheiro) + $replace($hget(atualiza,tipo),D,1000,M,800,F,600,E,800,WO,300) + %bonusd)
    hadd atualiza p1.stamina $hget(atualiza,p1.stamina) $+ , $+ $calc($dados(%n,stamina) - $replace($hget(atualiza,tipo),D,4,M,3,F,2,E,2,WO,0))
    inc %x
  }
  var %x = 1 | while %x <= $numtok($3,44) { 
    %n = $gettok($3,%x,44)
    hadd atualiza p2 $hget(atualiza,p2) $+ , $+ $dados(%n,nick)
    hadd atualiza p2.arm $hget(atualiza,p2.arm) $+ , $+ $replace($dados(%n,arm.on),sim,1,nao,0)
    hadd atualiza p2.cosmo $hget(atualiza,p2.cosmo) $+ , $+ $calc($dados(%n,cosmo) + $replace($hget(atualiza,tipo),D,1125,M,975,F,900,E,1500,WO,0) + %bns)
    hadd atualiza p2.dinheiro $hget(atualiza,p2.dinheiro) $+ , $+ $calc($dados(%n,dinheiro) + $replace($hget(atualiza,tipo),D,800,M,600,F,400,E,800,WO,0) + %bnsd)
    hadd atualiza p2.stamina $hget(atualiza,p2.stamina) $+ , $+ $calc($dados(%n,stamina) - $replace($hget(atualiza,tipo),D,5,M,4,F,3,E,2,WO,0))
    inc %x
  }
  hadd atualiza n $dados($4,nick)
  hadd atualiza n.dinheiro $calc($dados($4,dinheiro) + $replace($hget(atualiza,tipo),D,1800,M,1400,F,1000,E,1600,WO,300) + (100 * ($numtok($2,44) + $numtok($3,44) - 2)))
  hadd atualiza atu $nick

  if %tipo = E { var %tipo2 = Empate } | if %tipo = F { var %tipo2 = Fácil }
  if %tipo = D { var %tipo2 = Difícil } | if %tipo = M { var %tipo2 = Médio }

  msgto #cdzforever 9Atualização 15de luta0 $numtok($2,44) $+ 15x00 $+ $numtok($3,44) 15 $+ $iif(%tipo == WO,0WO,nível00 %tipo2) $iif($chan ison #meikai #tenkai #sekai #kaikai,15no mundo11 $remove($chan,$chr(35))) 15entre:
  var %x = 1 | while %x <= $numtok($2,44) { msgto #cdzforever 9 $+ $gettok($hget(atualiza,p1),%x,44) 15 $+ $iif(%tipo = E,empatou,venceu) $+ , e ficou com0 $div($gettok($hget(atualiza,p1.cosmo),%x,44)) 15de cosmo $iif(%bonus,14+08 $+ %bonus) e0 $+($,$div($gettok($hget(atualiza,p1.dinheiro),%x,44))) 15de Dinheiro $iif(%bonusd,14+08 $+ %bonusd) | inc %x }
  var %x = 1 | while %x <= $numtok($3,44) { msgto #cdzforever 9 $+ $gettok($hget(atualiza,p2),%x,44) 15 $+ $iif(%tipo = E,empatou,perdeu) $+ , e ficou com0 $div($gettok($hget(atualiza,p2.cosmo),%x,44)) 15de cosmo $iif(%bns,14+08 $+ %bns) e0 $+($,$div($gettok($hget(atualiza,p2.dinheiro),%x,44))) 15de Dinheiro $iif(%bnsd,14+08 $+ %bnsd) | inc %x }
  msgto #cdzforever 9 $+ $hget(atualiza,n) 15narrou, e ficou com0 $+($,$div($hget(atualiza,n.dinheiro))) 15de Dinheiro.
  msgto #cdzforever 9 $+ $nick $+ 15, para completar a atualização digite 0!Confirmar
}

;; ----------------------------------------------------------------------------
;; Comando :: Chan :: !Confirmar
;; Confirma a atualização de uma luta no canal
;; ----------------------------------------------------------------------------
alias com_chan_!confirmar {
  op.check +

  ;; verificação de consistência
  if (!$hget(atualiza,status)) msgehalt Não está havendo lutas!!
  if ($hget(atualiza,atu) != $nick) msgehalt 9 $+ $nick 15Não é você que está atualizando a luta!!

  ;; gera um código único para o combaate em %code
  var %code = $+($hget(atualiza,tipo),-,$r(11111,99999))
  while ($read($lutas.path,s,%code)) %code = $+($hget(atualiza,tipo),-,$r(11111,99999))

  ;; Registrando nos dados...
  var %p1 = $hget(atualiza,p1),%p2 = $hget(atualiza,p2),%n = $hget(atualiza,n),%x = 1,%px
  var %s = S $+ $readini(semana.ini,.,semana) $+ M $+ $date($readini(semana.ini,.,inicio),m) $+ A $+ $date($readini(semana.ini,.,inicio),yy),%s1

  ;; Premiação dos vencedores
  while %x <= $numtok(%p1,44) {
    %px = $gettok(%p1,%x,44)
    writeini $dados(%px) %px cosmo $gettok($hget(atualiza,p1.cosmo),%x,44) 
    writeini $dados(%px) %px dinheiro $gettok($hget(atualiza,p1.dinheiro),%x,44)
    writeini $dados(%px) historico $iif($hget(atualiza,tipo) = E,empates,vitorias) $calc($dados(%px,historico,$iif($hget(atualiza,tipo) = E,empates,vitorias)) + 1)
    writeini $dados(%px) %px Stamina $iif($gettok($hget(atualiza,p1.stamina),%x,44) < 0,0,$v1)
    %s1 = $iif($readini(semana.ini,%s,%px),$readini(semana.ini,%s,%px),0:0:0:0:0)
    %s1 = $puttok(%s1,$calc($gettok(%s1,1,58) + $iif($hget(atualiza,tipo) = E,2,3)),1,58)
    %s1 = $puttok(%s1,$calc($gettok(%s1,$iif($hget(atualiza,tipo) = E,4,2),58) + 1),$iif($hget(atualiza,tipo) = E,4,2),58)
    writeini -n semana.ini %s %px %s1
    if $dados(%px,armadura) != Nenhuma {
      var %hp.arm = $calc($dados(%px,hp.arm) - $gettok($hget(atualiza,p1.arm),%x,44) * $replace($hget(atualiza,tipo),D,40,M,10,F,0,E,50,WO,0))
      if (%hp.arm <= 0) {
        if (%px ison #cdzforever) { .msg %px 1,1|14,14|15,1 Sua Armadura Foi 0Destruída.15 Digite 7!9Consertar Armadura 15no chat do Bot. 14,14|1,1| } 
        writeini $dados(%px) %px arm.on Nao 
      }
      writeini $dados(%px) %px hp.arm $iif(%hp.arm < 0,0,%hp.arm)
    }
    user.lutas.add %px %code
    inc %x
  }

  ;; Premiação dos derrotados
  %x = 1
  while %x <= $numtok(%p2,44) {
    %px = $gettok(%p2,%x,44)
    writeini $dados(%px) %px cosmo $gettok($hget(atualiza,p2.cosmo),%x,44) 
    writeini $dados(%px) %px dinheiro $gettok($hget(atualiza,p2.dinheiro),%x,44)
    writeini $dados(%px) historico $iif($hget(atualiza,tipo) = E,empates,derrotas) $calc($dados(%px,historico,$iif($hget(atualiza,tipo) = E,empates,derrotas)) + 1)
    writeini $dados(%px) %px Stamina $iif($gettok($hget(atualiza,p2.stamina),%x,44) < 0,0,$v1)
    %s1 = $iif($readini(semana.ini,%s,%px),$readini(semana.ini,%s,%px),0:0:0:0:0)
    %s1 = $puttok(%s1,$calc($gettok(%s1,1,58) + $iif($hget(atualiza,tipo) = E,2,1)),1,58)
    %s1 = $puttok(%s1,$calc($gettok(%s1,$iif($hget(atualiza,tipo) = E,4,5),58) + 1),$iif($hget(atualiza,tipo) = E,4,5),58)
    writeini -n semana.ini %s %px %s1
    if $dados(%px,armadura) != Nenhuma {
      var %hp.arm = $calc($dados(%px,hp.arm) - $gettok($hget(atualiza,p2.arm),%x,44) * $replace($hget(atualiza,tipo),D,50,M,30,F,30,E,50,WO,0))
      if (%hp.arm <= 0) {
        if (%px ison #cdzforever) { .msg %px 1,1|14,14|15,1 Sua Armadura Foi 0Destruída.15 Digite 7!9Consertar Armadura 15no chat do Bot. 14,14|1,1| } 
        writeini $dados(%px) %px arm.on Nao 
      }
      writeini $dados(%px) %px hp.arm $iif(%hp.arm < 0,0,%hp.arm)
    }
    user.lutas.add %px %code
    inc %x
  }

  ;; Premiação do Narrador
  writeini $dados(%n) %n dinheiro $hget(atualiza,n.dinheiro) 
  writeini $dados(%n) historico narradas $calc($dados(%n,historico,narradas) + 1)
  user.lutas.add %n %code

  ;; Registra no TOP S
  %s1 = $iif($readini(semana.ini,%s,%n),$readini(semana.ini,%s,%n),0:0:0:0:0)
  %s1 = $puttok(%s1,$calc($gettok(%s1,3,58) + 1),3,58)
  %s1 = $puttok(%s1,$calc($gettok(%s1,1,58) + 2),1,58)
  writeini -n semana.ini %s %n %s1

  ;; Loga o combate para ele poder ser cancelado posteriormente
  write $lutas.path %code $str($chr(160),$calc(15 - $len(%code))) $iif($hget(atualiza,tipo) = E,Lutador1:,Vencedor:) $gettok(%p1,1-,44) // $iif($hget(atualiza,tipo) = E,Lutador2:,Perdedor:) $gettok(%p2,1-,44) // Narrador: %n // Atualizada por $hget(atualiza,atu) no dia $date ás $time // Canal: $chan

  %p1 = $gettok(%p1,1-,44)
  %p2 = $gettok(%p2,1-,44)
  msgto #CdzForever Luta entre0 $replace(%p1,$chr(44),15 $+ $chr(44) 00) 15Vs0 $replace(%p2,$chr(44),15 $+ $chr(44) 00) 15Narrada por0 %n 9Atualizada! 15(14 $+ %code $+ 15)
  hfree atualiza
}

;; ----------------------------------------------------------------------------
;; Comando :: Chan :: !Cancelar
;; Cancela a atualização de uma luta no canal
;; ----------------------------------------------------------------------------
alias com_chan_!cancelar {
  op.check +
  if (!$hget(atualiza,status)) msgehalt Não está havendo lutas!
  hfree atualiza
  msgto #CdzForever 9Atualização15 da Luta foi0 Cancelada!
}
