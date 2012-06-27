;; ----------------------------------------------------------------------------
;; Comando :: chat :: !top
;; Mostra o top, em diversas modalidades
;; ----------------------------------------------------------------------------
alias com_chat_!top {
  if $1 {
    if $1 = arquivo { 
      if !$2 {
        msgtopo
        msgt Arquivo de 0TOPs 15Semanais
        msgdiv
        var %x = $ini(semana.ini,0)
        var %s = $ini(semana.ini,%x),%s2 = $gettok($readini(semana.ini,%s,.),1,126)
        var %a = $date(%s2,yy),%m = $date(%s2,m),%ss = %s
        dec %x
        msgt 0Arquivo11 $date(%s2,yyyy) 
        msgt

        if %x = 1 { msgl  14>08 $mes(%m2) $+ $spc($mes(%m2),10) 09 $replace(%ss,$chr(32),  ) }
        while 2 < %x {
          var %s = $ini(semana.ini,%x)
          var %s3 = $gettok($readini(semana.ini,%s,.),1,126)
          var %a2 = $date(%s3,yy),%m2 = $date(%s3,m)
          if %m2 = %m { %ss = %ss %s }
          else {
            msgl 14>08 $mes(%m) $+ $spc($mes(%m),10) $+ 09 $replace(%ss,$chr(32),  )
            %ss = %s
            if %a != %a2 { msgdiv | msgt Arquivo08 $date(%s3,yyyy) | msgt }
          }
          %m = %m2
          %a = %a2
          dec %x
        }
        msgdiv
        msgt Para ver algum desses tops, digite 11!TOP 14<0id14>
        msgt 14Ex:11 !Top S2M4A06 | msgt 14(15segunda semana do mês de Maio de 200614)
        msgbase
      }
    }
    elseif (s* iswm $1 || 2010 == $1 || total == $1) {
      if (2010 == $1) rankanual
      elseif (total == $1) ranktotal
      elseif (*m* iswm $1) && (*a* iswm $1) { var %s = $1 }
      else { var %s = $iif($mid($1,2-),S $+ $int($mid($1,2-)),S $+ $readini(semana.ini,.,semana)) $+ M $+ $date($readini(semana.ini,.,inicio),m) $+ A $+ $date($readini(semana.ini,.,inicio),yy) }
      var %ns = $ini(semana.ini,%s,0),%x = %ns - 1,%n,%p
      if %ns {
        closewindows @top*
        window -hs @top 
        while %ns > 1 {
          %n = $ini(semana.ini,%s,%ns)
          %p = $readini(semana.ini,%s,%n)
          aline @top $str(0,$calc(10 - $len($gettok(%p,1,58)))) $+ %p $+ : $+ %n
          dec %ns
        }
      }
      if (%ns || $1 == 2010 || $1 == total) {
        msgtopo 
        if (%ns) {
          msgt TOP Semanal 
          msgt 14- 0Semana  $+ $mid(%s,2,1) $+  14- 
          msgt De08 $date²($gettok($readini(semana.ini,%s,.),1,126)) 15até08 $date²($gettok($readini(semana.ini,%s,.),2,126))
        }
        else {
          msgt Top Anual
          msgt 14-08201014-
        }
        msgdiv
        var %x = $line(@top,0),%max = %x
        if %x = 0 { msgt Sem registro de 8Combates14. }
        else { 
          msgl 14Pos Nick                   Pontos     Resultados
          var %ns = %x,%x = 1
          while %ns > 0 {
            var %c = $iif(%x = 1,11,$iif(%x isnum 2-4,09,$iif(%x isnum 5-7,08,$iif(%x = 8,04,15)))),%l = $line(@top,%ns)
            msgl 14 $+ $righter(%x,$len(%max)) $+ º %c $+ $gettok(%l,6,58) $spc($gettok(%l,6,58),22) $+ 00 $+ $div($gettok(%l,1,58)) $spc($div($gettok(%l,1,58)),9) 09 $+ $gettok(%l,2,58) $+ 15v08 $gettok(%l,4,58) $+ 15e04 $gettok(%l,5,58) $+ 15d00 $gettok(%l,3,58) $+ 15n
            inc %x | dec %ns
          }
        }
        msgdiv
        msgt Para ver os 0TOPs 15de outras semanas, digite
        msgt 7!9Top S14<0Semana14>
        msgbase
        window -c @top
      }
      else { 
        msgtopo | msgt Semana 9Inválida14.
        if !$readini(semana.ini,%s,.) { msgt Não existem 0registros relativos | msgt a semana de ID08 $mid($1,2-) $+ 14. | msgt | msgt Digite 11!Top Arquivo15 para ver a lista de TOPS 0antigos14. }
        else { msgt Escolha uma semana entre a 0primeira 14(08114) | msgt e a 0última 15de um mês 14(08414) | msgt 14Ex: 9!TOP S081 } 
        msgbase
      } 
    }

    else {
      if ($istok(vitorias vitoria vitória vitórias empates empate derrota derrotas narracoes narradas narrador narrada narração narracao narrações combates combate,$1,32)) {
        var %topfile = $+(sys/top/top,$left($1,1),.cdz)
        var %tipotop = $replace($left($1,1),v,Vitórias,e,Empates,d,Derrotas,C,Combates,N,Narrações)
      }
      else { var %topfile = sys/top/top.cdz,%tipotop = Cosmo }

      if ($2) {
        if ($istok(vitorias vitoria vitíria vitórias empates empate derrota derrotas narracoes narradas narrador narrada narração narracao narrações combates combate,$2,32)) {
          var %topfile = $+(sys/top/top,$left($2,1),.cdz)
          var %tipotop = $replace($left($2,1),v,Vitórias,e,Empates,d,Derrotas,C,Combates,N,Narrações)
        }
        else { var %topfile = sys/top/top.cdz,%tipotop = Cosmo }
      }
      if ($1 = eu) || ($1 = me) {
        var %me = $read(%topfile,r,: $+ $nick)
        var %act = $readn,%x = %act - 10,%x = $iif(%x < 1,1,%x)
        msgtopo | msgt 0TOP08 %x $+ - $+ $calc(%act + 10) 00 $+ %tipotop | msgdiv
        msgl  14Pos Nick                   %tipotop
        while %x < %act {
          var %n = $read(%topfile,%x)
          var %val = $div($gettok(%n,1,58))
          if ($len(%val) > 30) %val = $left(%val,26) $+ 8...
          msgl 14 $+ $spc(%x,3) $+ %x $+ º $+ 09 $gettok(%n,2,58) $spc($gettok(%n,2,58),21) 00 $+ %val
          inc %x
        }
        msgdiv
        var %val = $div($gettok(%me,1,58))
        if ($len(%val) > 30) %val = $left(%val,26) $+ 8...
        msgl 14 $+ $spc(%act,3) $+ %act $+ º $+ 08 $gettok(%me,2,58) $spc($gettok(%me,2,58),21) 00 $+ %val
        msgdiv
        inc %x
        inc %act 11
        while %x < %act {
          var %n = $read(%topfile,%x)
          var %val = $div($gettok(%n,1,58))
          if ($len(%val) > 30) %val = $left(%val,26) $+ 8...
          msgl 14 $+ $spc(%x,3) $+ %x $+ º $+ 11 $gettok(%n,2,58) $spc($gettok(%n,2,58),21) 00 $+ %val
          inc %x
        }
        msgdiv
        msgt 15Atualizado em08 $gettok($read(%topfile,$lines(%topfile)),1,58) 15ás08 $gettok($read(%topfile,$lines(%topfile)),2-,58) $+ 14.
        msgbase         
      }
      else {
        var %top = $iif($1 isnum,$1,10),%x = 1,%n,%c
        if %top isnum 1-50 {
          msgtopo | msgt 0TOP08 %top 00 $+ %tipotop | msgdiv
          msgl  14Pos Nick                   %tipotop
          while %x <= %top {
            var %n = $read(%topfile,%x),%c = $iif(%x isnum 1-3,09,$iif(%x isnum 4-6,08,$iif(%x isnum 7-10,11,15)))
            var %val = $div($gettok(%n,1,58))
            if ($len(%val) > 30) %val = $left(%val,28) $+ 8...
            msgl 14 $+ $spc(%x,3) $+ %x $+ º $+ %c $gettok(%n,2,58) $spc($gettok(%n,2,58),20) $+ 00 $+ %val
            inc %x
          }
          msgdiv
          msgt 15Atualizado em08 $gettok($read(%topfile,$lines(%topfile)),1,58) 15ás08 $gettok($read(%topfile,$lines(%topfile)),2-,58) $+ 14.
          msgbase 
        }
        if %top isnum 51-10000 { msgtopo | msgt Você só pode listar o 0Top 15até a posição 085014. | msgbase }
      }
    }
  }
  else {
    msgtopo
    msgt 9TOP
    msgt 0A Elite do #CdzForever
    msgdiv
    msgt Para ver a lista dos usuários mais fortes do canal, 
    msgt digite 11!TOP 14<0n14>15, onde o 14"0n14"15 é o número de
    msgt usuários listados. O número máximo de usuários é 0950
    msgt
    msgt E uma 0novidade15, o novo sistema de 9TOPs semanais15,
    msgt onde cada combate acumula pontos, rankeando os 
    msgt 8melhores lutadores 15de cada semana, do ano inteiro.
    msgt Os melhores de cada semana ganham 0prêmios15, em 
    msgt 11Méritos15, que eles podem trocar por 0itens14, 0cosmo 15ou 
    msgt 0armaduras15. 
    msgt 15No final de cada mês, os quatro 9TOPs 1 15se enfrentam
    msgt em um mata-mata, e o campeão leva o prêmio principal.
    msgt 
    msgdiv 
    msgt 0Comandos
    msgt ¯¯¯¯¯¯¯¯
    msgl    7!8Top 14<0n14> 14[0tipo14]15 -14>15 Ver o TOP geral (14max 5015)
    msgl    7!8Top eu 14[0tipo14]15 -14>15 Ver a sua posição no TOP
    msgl    7!8TOP S 15-14>15 Confira o TOP da semana
    msgl    7!8TOP S14<0n14>15 -14>15 Top de uma semana específica do mês
    msgl    7!8TOP Arquivo15 -14>15 Ver o arquivo de todos os TOPs
    msgdiv 
    msgt 0Exemplos
    msgt ¯¯¯¯¯¯¯¯
    msgt 7!8Top 35
    msgt 7!8Top eu vitórias
    msgt 7!8Top 35 narradas
    msgbase
  }
}

alias closewindows {
  if ($1) {
    var %x = 1
    while ($window(%x)) {
      if ($1 iswm $window(%x)) window -c $window(%x) 
      else inc %x
    }
  }
}

;; ----------------------------------------------------------------------------
;; Alias :: atutop
;; Atualiza todos os tops
;; ----------------------------------------------------------------------------
alias atutop {
  closewindows @top*
  window -hs @top | window -hs @topv | window -hs @tope | window -hs @topd | window -hs @topn | window -hs @topl
  write -c sys/top/top.cdz 
  write -c sys/top/topv.cdz 
  write -c sys/top/tope.cdz 
  write -c sys/top/topd.cdz 
  write -c sys/top/topn.cdz 
  write -c sys/top/topc.cdz
  var %x = $findfile(users,*.ini,0),%f,%c,%v,%e,%d,%n,%l

  while %x > 0 {
    dll.whilefix
    %f = $gettok($nopath($findfile(users,*.ini,%x)),1,46)
    %c = $gettok($dados(%f,cosmo),1,46)
    %v = $user.historico.vitorias(%f)
    %e = $user.historico.empates(%f)
    %d = $user.historico.derrotas(%f)
    %n = $user.historico.narradas(%f)
    %l = $user.historico.combates(%f)

    aline @top $str(0,$calc(30 - $len(%c))) $+ %c $+ : $+ %f
    aline @topv $str(0,$calc(10 - $len(%v))) $+ %v $+ : $+ %f
    aline @tope $str(0,$calc(10 - $len(%e))) $+ %e $+ : $+ %f
    aline @topd $str(0,$calc(10 - $len(%d))) $+ %d $+ : $+ %f
    aline @topn $str(0,$calc(10 - $len(%n))) $+ %n $+ : $+ %f
    aline @topl $str(0,$calc(10 - $len(%l))) $+ %l $+ : $+ %f

    dec %x
  }
  %x = $line(@top,0)
  while %x > 0 { 
    write sys/top/top.cdz $line(@top,%x) 
    write sys/top/topv.cdz $line(@topv,%x) 
    write sys/top/tope.cdz $line(@tope,%x) 
    write sys/top/topd.cdz $line(@topd,%x) 
    write sys/top/topn.cdz $line(@topn,%x) 
    write sys/top/topc.cdz $line(@topl,%x) 
    dec %x 
  }
  write sys/top/top.cdz $date $+ : $+ $time
  write sys/top/topv.cdz $date $+ : $+ $time
  write sys/top/tope.cdz $date $+ : $+ $time
  write sys/top/topd.cdz $date $+ : $+ $time
  write sys/top/topn.cdz $date $+ : $+ $time
  write sys/top/topc.cdz $date $+ : $+ $time
  if $me ison #cdzforever { msg #Cdzforever 0,1 0,14 15,1 Lista dos 8TOPs 15do 8#9CdzForever 0atualizada.14 [00 $+ $replace($date,/,15/00) 15ás0 $replace($time,:,15:00) $+ 14] 0,14 0,1  }
}

;; ----------------------------------------------------------------------------
;; Alias :: fecha.semana
;; Fecho o top semanal, distribui a premiação e inicia uma nova semana
;; ----------------------------------------------------------------------------
alias fecha.semana {
  var %s.atual = $ini(semana.ini,$ini(semana.ini,0))

  var %d = $date(dd),%s
  if %d isnum 1-7 { %s = 1 } | if %d isnum 8-14 { %s = 2 } 
  if %d isnum 15-21 { %s = 3 } | if %d isnum 22- { %s = 4 }
  var %s.prox = $+(S,%s,M,$date(m),A,$date(yy))

  if %s.prox != %s.atual {
    var %d = $ini(semana.ini,%s.atual,0),%n,%p
    if ($window(@fecha.semana)) window -c @fecha.semana
    window -hs @fecha.semana
    while %d > 1 {
      %n = $ini(semana.ini,%s.atual,%d)
      %p = $readini(semana.ini,%s.atual,%n)
      aline @fecha.semana $str(0,$calc(10 - $len($gettok(%p,1,58)))) $+ %p $+ : $+ %n
      dec %d
    }
    var %d = 0,%p
    while (%d < 8) && (%d < $line(@fecha.semana,0)) {
      %n = $gettok($line(@fecha.semana,$calc($line(@fecha.semana,0) - %d)),6,58)
      user.meritos.add %n $replacex(%d,0,5000,1,4500,2,4000,3,3500,4,3000,5,2500,6,2000,7,1500,8,1000)
      if (%d == 0) {
        w+ %n tops $calc($dados(%n,tops,1) + 1)
        user.item.add %n Ordem Divina
        user.item.add %n Treino Certo
        user.item.add %n Vale Treino
        memosend %n SaintSeiya Você recebeu08 5.000 méritos 15por ter alcançado a 09primeira colocação 15no top desta semana! Como bônus, você também levou os itens 11Ordem Divina15,11 Treino Certo 15e11 Vale Treino15.
      }
      elseif (%d == 1) {
        user.item.add %n Ordem Divina
        user.item.add %n Treino Certo
        user.item.add %n Treino Fail
        memosend %n SaintSeiya Você recebeu08 4.500 méritos 15por ter alcançado a 9segunda colocação 15no top desta semana. Como bônus, você também levou os itens 11Ordem Divina15, 11Treino Fail 15e11 Treino Certo15.
      }
      elseif (%d == 2) {
        user.item.add %n Ordem Divina
        user.item.add %n Treino Certo
        user.item.add %n Chimarrão
        memosend %n SaintSeiya Você recebeu08 4.000 méritos 15por ter alcançado a09 terceira colocação 15no top desta semana. Como bônus você também levou os ítens 11Ordem Divina15, 11Treino Certo 15e 11Chimarrão.
      }
      elseif (%d == 3) {
        user.item.add %n Ordem Divina
        user.item.add %n Maçã
        memosend %n SaintSeiya Você recebeu08 3.500 méritos 15por ter alcançado a09 quarta colocação 15no top desta semana. Como bônus você também levou os ítens 11Ordem Divina 15e 11Maçã.
      }
      elseif (%d == 4) {
        user.item.add %n Ordem Divina
        memosend %n SaintSeiya Você recebeu08 3.000 méritos 15por ter alcançado a09 quarta colocação 15no top desta semana. Como bônus você também levou o ítem 11Ordem Divina15.
      }
      else memosend %n SaintSeiya Você recebeu08 $div($replacex(%d,0,5000,1,4500,2,4000,3,3500,4,3000,5,2500,6,2000,7,1500,8,1000)) méritos 15por ter alcançado a09 $calc(%d + 1) $+ ª colocação 15no top desta semana.
      %p = $addtok(%p,%n,44)
      inc %d
    }
    window -c @fecha.semana
    if $me ison #cdzforever {
      msg #cdzforever 0,1 0,14 0,1 $replace($mid(%s.atual,2,1),1,Primeira,2,Segunda,3,Terceira,4,Última) Semana 15do mês de9 $mes($gettok($gettok(%s.atual,1,65),2,77)) 15foi 0finalizada15. Os cavaleiros melhores classificados no 9TOP Semanal 15foram automaticamente premiados com 0méritos15. São eles: 0,14 0,1 
      msg #cdzforever 0,1 0,14 8,1 $replace(%p,$chr(44),14 $+ $chr(44) 08) $+ 14. 0Parabéns a todos14! 0,14 0,1 
    }
    if $date(d) isnum 1-7 { %d = 1 } | if $date(d) isnum 8-14 { %d = 2 }
    if $date(d) isnum 15-21 { %d = 3 } | if $date(d) isnum 21- { %d = 4 }

    var %ini = $calc($ctime.mes + (%d - 1) * 604800)
    if %d = 4 { var %fim = $ctime.prox.mes }
    else { var %fim = $calc($ctime.mes + %d * 604800) }
    writeini -n semana.ini . inicio %ini
    writeini -n semana.ini . fim %fim
    writeini -n semana.ini . semana %d
    writeini -n semana.ini %s.prox . %ini $+ ~ $+ %fim
  }
  .timer.sys.fecha.semana -o 1 $calc($readini(semana.ini,.,fim) - $ctime) fecha.semana
}

;; ----------------------------------------------------------------------------
;; Comando :: chan :: !Top [nick]
;; Mostra a posição no top do usuário, ou de [nick]
;; ----------------------------------------------------------------------------
alias com_chan_!top {
  id.check noident
  var %n = $iif($1,$strip($1),$nick)
  if ($dados(%n,cosmo)) {
    var %t = $top(%n)
    if (%t) msgn 00 $+ $nick $+ 15, $iif(%n != $nick,08 $+ %n,você) 15é o09 $top(%n)  $+ º 15usuário mais forte 15do 8SaintSeiya15!
    else noticen 00 $+ $nick $+ 15, $iif(%n != $nick,08 $+ %n,você) 15ainda não aparece no 9TOP15. 0Espere pela atualização.
  }
  else noticen $iif(%n == $nick,Você,00 $+ $nick $+ $chr(44) 09 %n) 15não é cadastrado no bot!
}

;; ----------------------------------------------------------------------------
;; Signal :: nick_change
;; Atualiza o top semanal no caso de troca de nick (troca o nick no arquivo)
;; ----------------------------------------------------------------------------
on *:signal:nick_change:{ 
  ;; $1 = nick, $2 = novo nick
  ;; corrige o problema do top semanal na troca de nick
  var %i = $ini(semana.ini,0),%s,%d
  while (%i) {
    %s = $ini(semana.ini,%i)
    %d = $readini(semana.ini,%s,$1)
    if (%d) {
      writeini semana.ini %s $2 %d
      remini semana.ini %s $1
    }
    dec %i
  }
}

;; ---------------------------------------------------------------------------- COMANDOS DUMMY

alias com_all_!fortaum {
  var %x = $nick(#,0),%t = a,%n
  while (%x) {
    if ($top($nick(#,%x)) && $top($nick(#,%x)) < %t) { 
      %t = $top($nick(#,%x))
      %n = $nick(#,%x)
    }
    dec %x
  }
  msgn O usuário mais00 fortão 15do #cdzforever neste momento é o08 %n 15(14top09 %t $+ 15)
}
alias com_all_!serelepe msgn O usuário mais 8serelepe15 deste canal é o 9xdvl15 $+ .
alias com_all_!fracaum {
  var %x = $nick(#,0),%t = 0,%n
  while (%x) {
    if ($top($nick(#,%x)) && $top($nick(#,%x)) > %t) { 
      %t = $top($nick(#,%x))
      %n = $nick(#,%x)
    }
    dec %x
  }
  msgn O usuário mais00 fracaum 15do #cdzforever neste momento é o08 %n 15(14top09 %t $+ 15)
}
alias com_all_!perdedorzaum {
  var %x = $nick(#,0),%t = a,%t2,%n
  while (%x) {
    var %top = $read(sys/top/topd.cdz,w,*: $+ $nick(#,%x))
    var %topn = $readn
    if (%top && %topn < %t) { 
      %t2 = $gettok(%top,1,$asc(:))
      %t = %topn
      %n = $gettok(%top,2,$asc(:))
    }
    dec %x
  }
  msgn O usuário mais00 perdedorzaum 15do #cdzforever neste momento é o08 %n 15(14com09 $div(%t2) $+ 14 derrotas15)
}
alias com_all_!fodaum {
  var %x = $nick(#,0),%t = a,%t2,%n
  while (%x) {
    var %top = $read(sys/top/topv.cdz,w,*: $+ $nick(#,%x)),%topn = $readn
    if (%top && %topn < %t) { 
      %t2 = $gettok(%top,1,$asc(:))
      %t = %topn
      %n = $gettok(%top,2,$asc(:))
    }
    dec %x
  }
  msgn O usuário mais00 fodaum 15do #cdzforever neste momento é o08 %n 15(14com09 $div(%t2) $+ 14 vitórias15)
}
