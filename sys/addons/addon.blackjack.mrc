alias bj {
  if ($isid) { return $hget($+(blackjack.,$1),$2)  }
  else { hadd -m $+(blackjack.,$1) $2 $3-  }
}

alias com_chat_!blackjack { 
  id.check =
  if (!$1) || ($1 == ajuda) { 
    msgtopo
    msgt  Blackjack :: Ajuda
    msgdiv
    msgl                                   .------.
    msgl                .------.           |A .   |
    msgl                |A_  _ |    .------; / \  |
    msgl                |( \/ )|-----. _   |(_,_) |
    msgl                | \  / | /\  |( )  |  I  A|
    msgl                |  \/ A|/  \ |_x_) |------'
    msgl                `-----+'\  / | Y  A|
    msgl                      |  \/ A|-----'
    msgl                      `------'
    msgdiv        
    msgt Informações
    msgdiv                    
    msgl - Cada aposta custa $500.
    msgl - Em caso de blackjack a banca paga $1.000.
    msgl - Só é blackjack caso some 21 somente com as duas
    msgl 1,1-15  primeiras cartas.
    msgl - A banca irá parar com 17 pontos, caso isso seja maior
    msgl 1,1-15 que a sua pontuação.
    msgl - Em caso de empate o dinheiro volta para você.
    msgdiv
    msgt Comandos:
    msgdiv
    msgl !blackjack 08iniciar15      - Inicia uma aposta.
    msgl !blackjack 08estatisticas15 - Mostra as estatisticas do jogo.
    msgbase
  }
  elseif ($1 == iniciar) { 
    if ($bj($nick,status) == 1) { msgehalt Você já está no meio de uma partida. }
    if ($user.dinheiro.get($nick) < 500) { msgehalt Você não tem dinheiro suficiente para apostar. }
    bj $nick status 1
    bj $nick baralho $shuffle
    bj $nick vez player
    bj.draw 1-2
    bj.draw 1 banca
    if ($contagem($bj($nick,cartas)) == 21) {
      bj.finaliza 5
    }   
    blackjack
  }
  elseif ($1 == estatisticas) { 
    msgtopo 
    msgt Blackjack :: Estatísticas
    msgdiv
    msgt Suas Estatísticas
    msgdiv 
    msgt Vitórias:09 $bj.dados($nick,vitorias) ( $+ $bj.dados($nick,vitorias.bj) $+ ) 15/ Empates:08 $bj.dados($nick,empates) 15/ Derrotas:04 $bj.dados($nick,derrotas) ( $+ $bj.dados($nick,derrotas.bj) $+ )
    msgt Ganhos: 09$ $+ $div($bj.dados($nick,ganho)) 15/ Gastos: 04$ $+ $div($bj.dados($nick,gasto)) 15/ Balanço: $+ $iif($calc($bj.dados($nick,ganho) - $bj.dados($nick,gasto)) < 0,04,09) $ $+ $div($calc($bj.dados($nick,ganho) - $bj.dados($nick,gasto)))
    msgdiv
    msgt Estatísticas da Banca
    msgdiv
    msgt Vitórias:09 $bj.ini(vitorias) ( $+ $bj.ini(vitorias.bj) $+ ) 15/ Empates:08 $bj.ini(empates) 15/ Derrotas:04 $bj.ini(derrotas) ( $+ $bj.ini(derrotas.bj) $+ )
    msgt Ganhos: 09$ $+ $div($bj.ini(arrecadado)) 15/ Pagos: 04$ $+ $div($bj.ini(pago)) 15/ Balanço: $iif($calc($bj.ini(arrecadado) - $bj.ini(pago)) < 0,04$,09$) $+ $div($calc($bj.ini(arrecadado) - $bj.ini(pago)))
    msgbase
  }
  else { 
    msgehalt Opção04 $1 15inválida.
  }
}

alias com_chat_!hit { 
  id.check =
  if (!$bj($nick,status)) { msgehalt Você não está jogando. }
  bj.draw 1
  blackjack 
  if ($contagem($bj($nick,cartas)) == 21) {
    msgtopo
    msgt 08Você tem 21 pontos, passando a vez para a banca.
    msgbase
    bj.banca
  }
  elseif ($contagem($bj($nick,cartas)) > 21) { 
    bj.finaliza 1
  }
}

alias com_chat_!stand { 
  id.check =
  if (!$bj($nick,status)) { msgehalt Você não está jogando. }
  bj.banca
}

alias -l bj.banca {
  bj $nick vez banca 
  while ($contagem($bj($nick,banca)) < 17) {
    bj.draw 1 banca
  }
  if ($contagem($bj($nick,banca)) == 21) && ($numtok($bj($nick,banca),44) == 2) { 
    blackjack | bj.finaliza 6
  }
  elseif ($contagem($bj($nick,banca)) > 21) { 
    blackjack | bj.finaliza 2
  }
  elseif ($contagem($bj($nick,banca)) > $contagem($bj($nick,cartas))) { 
    blackjack | bj.finaliza 3
  }
  else {
    while ($contagem($bj($nick,cartas)) > $contagem($bj($nick,banca))) {
      bj.draw 1 banca
    }
    if ($contagem($bj($nick,banca)) > 21) { 
      blackjack | bj.finaliza 2
    }
    elseif ($contagem($bj($nick,banca)) > $contagem($bj($nick,cartas))) { 
      blackjack | bj.finaliza 3
    }
    elseif ($contagem($bj($nick,banca)) = $contagem($bj($nick,cartas))) { 
      blackjack | bj.finaliza 4
    }
  }
}

alias -l bj.draw {
  var %x = 1
  var %para = $iif($2 == banca,banca,cartas)
  if ($numtok($bj($nick,%para),44) == 0) { bj $nick %para $gettok($bj($nick,baralho),$1,44) }
  else { bj $nick %para $bj($nick,%para) $+ $chr(44) $+ $gettok($bj($nick,baralho),$1,44) }
  bj $nick baralho $deltok($bj($nick,baralho),$1,44)
}

alias -l blackjack { 
  msgtopo
  msgt Banca:
  msgdiv
  cartas $bj($nick,banca)
  msgt 1,1
  msgt $contagem($bj($nick,banca)) Pontos
  msgdiv
  msgt Você:
  msgdiv 
  cartas $bj($nick,cartas)
  msgt 1,1
  msgt $contagem($bj($nick,cartas)) Pontos
  if ($bj($nick,vez) == player) && ($contagem($bj($nick,cartas)) < 21) {
    msgdiv 
    msgt Opções:
    msgdiv
    msgt !Stand !Hit
  }
  msgbase
}

alias -l c { return $readini($mircdirsys/cartas.ini,$1,$2) }

alias -l cartas {
  var %n = $numtok($1,44), %l1, %l2, %l3, %l4, %l5, %l6, %c
  var %apr = $iif(%n > 4,-3,0)
  while %n { 
    %c = $gettok($1,%n,44)
    if (%apr) {
      %l1 = $mid(%l1,1,%apr) $+ $c($right(%c,1),1)
      %l2 = $mid(%l2,1,%apr) $+ $replace($c($right(%c,1),2),??,08 $+ $iif($len($left(%c,1)) == 2,$left(%c,1),$+($left(%c,1),$chr(160)) $+ 15))
      %l3 = $mid(%l3,1,%apr) $+ $c($right(%c,1),3)
      %l4 = $mid(%l4,1,%apr) $+ $c($right(%c,1),4)
      %l5 = $mid($strip(%l5),1,%apr) $+ $replace($c($right(%c,1),5),??,08 $+ $iif($len($left(%c,1)) == 2,$left(%c,1),$+($chr(160),$left(%c,1)) $+ 15))
      %l6 = $mid(%l6,1,%apr) $+ $c($right(%c,1),6)
    }
    else {
      %l1 = %l1 $c($right(%c,1),1)
      %l2 = %l2 $replace($c($right(%c,1),2),??,08 $+ $iif($len($left(%c,1)) == 2,$left(%c,1),$+($left(%c,1),$chr(160)) $+ 15))
      %l3 = %l3 $c($right(%c,1),3)
      %l4 = %l4 $c($right(%c,1),4)
      %l5 = %l5 $replace($c($right(%c,1),5),??,08 $+ $iif($len($left(%c,1)) == 2,$left(%c,1),$+($chr(160),$left(%c,1)) $+ 15))
      %l6 = %l6 $c($right(%c,1),6)
    }
    dec %n
  }
  msgt %l1 | msgt %l2 | msgt %l3 | msgt %l4 | msgt %l5 | msgt %l6
}

alias -l contagem {
  var %n = $numtok($1,44), %pontos = 0, %c
  while %n { 
    %c = $gettok($1,%n,44)
    %pontos = $calc(%pontos + $regsubex($left(%c,1),/([A-Z])/g,10))
    dec %n
  }
  return %pontos
}

alias -l bj.finaliza { 
  msgtopo
  if ($1 == 1) { 
    msgt 04Você estourou, você perdeu!
    user.dinheiro.retrieve $nick 500
    bj.inc vitorias
    bj.inc arrecadado 500

    bj.dados.inc derrotas
    bj.dados.inc gasto 500
  }
  elseif ($1 == 2) { 
    msgt 09A banca estourou, você ganhou!
    user.dinheiro.add $nick 500
    bj.inc derrotas
    bj.inc pago 500

    bj.dados.inc vitorias
    bj.dados.inc ganho 500
  }
  elseif ($1 == 3) { 
    msgt 04A banca fez mais pontos, você perdeu!
    user.dinheiro.retrieve $nick 500
    bj.inc vitorias
    bj.inc arrecadado 500

    bj.dados.inc derrotas
    bj.dados.inc gasto 500
  }
  elseif ($1 == 4) { 
    msgt 08Empate!
    bj.inc empates

    bj.dados.inc empates
  }
  elseif ($1 == 5) { 
    msgt 09BLACKJACK! VOCÊ VENCEU!!
    user.dinheiro.add $nick 1000
    bj.inc derrotas
    bj.inc derrotas.bj
    bj.inc pago 1000

    bj.dados.inc vitorias
    bj.dados.inc vitorias.bj
    bj.dados.inc ganho 1000
  }
  elseif ($1 == 6) { 
    msgt 04BLACKJACK! VOCÊ PERDEU!!
    user.dinheiro.retrieve $nick 500
    bj.inc vitorias
    bj.inc vitorias.bj
    bj.inc arrecadado 500

    bj.dados.inc derrotas 
    bj.dados.inc derrotas.bj
    bj.dados.inc gasto 500
  }
  msgbase 
  hfree $+(blackjack.,$nick)
}

alias bj.ini {
  if ($isid) { 
    if (!$1) { return $mircdirsys/blackjack.ini }
    else { return $iif($readini($mircdirsys/blackjack.ini,blackjack,$1),$v1,0) }
  }
  else { 
    writeini $mircdirsys/blackjack.ini blackjack $1-
  }
}

alias bj.inc { 
  bj.ini $1 $calc($bj.ini($1) + $iif($2,$2,1))
}

alias bj.dados.inc {
  writeini $dados($nick) blackjack $1 $calc($dados($nick,blackjack,$1) + $iif($2,$2,1))
}

alias bj.dados { 
  return $iif($dados($1,blackjack,$2),$v1,0)
}


alias com_chan_!iniciar {
  reforma sega
  op.check @
  if ($1 != apostas) return
  if (!$2) return
  writeini sys/apostas.ini aposta title $2-
}
alias com_chan_!apostar {
  reforma sega
  id.check 
  var %opcoes = $readini(sys/apostas.ini,aposta,opcoes)
  if (!$2) noticen Você precisa indicar a sua 0aposta15! 8Uso: !Apostar <valor> <opção>
  elseif (%opcoes && !$istok(%opcoes,$2-,44)) noticen Opção 4inválida15! As opções disponíveis são8 $replace(%opcoes,$chr(44),$chr(44) $+ $chr(32)) $+ 15.
  elseif ($remove($1,.) !isnum 1-) noticen Valor 4inválido15. O valor deve ser um número de 111 15a 8infinito15.
  elseif ($user.dinheiro < $remove($1,.)) noticen Você 4não15 tem 8$ $+ $div($remove($1,.)) 15para apostar!
  else {
    var %d = $remove($1,.)
    writeini sys/apostas.ini aposta $nick %d $+ ¼ $+ $2
    writeini sys/apostas.ini pot $calc($readini(sys/apostas.ini,aposta,pot) + %d)
    noticen Você apostou 8$ $+ $div(%d) $+ 15. O valor total das apostas é de 8$ $+ $div($readini(apostas.ini,aposta,pot)) $+ 15.
  }
}


alias ranktotal {
  var %i = $ini(semana.ini,0),%f = 0,%s,%j,%n,%v
  if ($hget(rank)) hdel -w rank *
  while (2 < %i) {
    %s = $ini(semana.ini,%i)
    %j = 2
    while (%j <= $ini(semana.ini,%s,0)) {
      %n = $ini(semana.ini,%s,%j)
      %v = $readini(semana.ini,%s,%n)
      if ($hget(rank,%n)) %v = $+($calc($gettok($v1,1,58) + $gettok(%v,1,58)),:,$calc($gettok($v1,2,58) + $gettok(%v,2,58)),:,$calc($gettok($v1,3,58) + $gettok(%v,3,58)),:,$calc($gettok($v1,4,58) + $gettok(%v,4,58)),:,$calc($gettok($v1,5,58) + $gettok(%v,5,58)))
      hadd -m rank %n %v
      inc %j
    }
    dec %i
  }
  var %i = $hfind(rank,*,0,w)
  if ($window(@top)) window -c @top
  window -hs @top
  while (%i) {
    %s = $hfind(rank,*,%i,w)
    %v = $hget(rank,%s)
    aline @top $str(0,$calc(10 - $len($gettok(%v,1,58)))) $+ %v $+ : $+ %s
    dec %i  
  }
}


alias rankanual {
  var %i = $ini(semana.ini,0),%f = 0,%s,%j,%n,%v
  if ($hget(rank)) hdel -w rank *
  while (%i || %f) {
    %s = $ini(semana.ini,%i)
    if ($right(%s,2) == 10) {
      %j = 2
      while (%j <= $ini(semana.ini,%s,0)) {
        %n = $ini(semana.ini,%s,%j)
        %v = $readini(semana.ini,%s,%n)
        if ($hget(rank,%n)) %v = $+($calc($gettok($v1,1,58) + $gettok(%v,1,58)),:,$calc($gettok($v1,2,58) + $gettok(%v,2,58)),:,$calc($gettok($v1,3,58) + $gettok(%v,3,58)),:,$calc($gettok($v1,4,58) + $gettok(%v,4,58)),:,$calc($gettok($v1,5,58) + $gettok(%v,5,58)))
        hadd -m rank %n %v
        inc %j
      }
    }
    dec %i
    else %f = 1
  }
  var %i = $hfind(rank,*,0,w)
  if ($window(@top)) window -c @top
  window -hs @top
  while (%i) {
    %s = $hfind(rank,*,%i,w)
    %v = $hget(rank,%s)
    aline @top $str(0,$calc(10 - $len($gettok(%v,1,58)))) $+ %v $+ : $+ %s
    dec %i  
  }
}
