;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Report <S/R/B> <texto>
;; Envia um report para o bot, com sugestão, reclamação ou bug
;; ----------------------------------------------------------------------------
alias com_help_!report return !Report¼Chat¼!Report <s/r/b/list> <mensagem>¼Comando para enviar 0sugestões15, 0reclamações 15ou avisos de 0bug 15para os administradores. Digite 8!Report 15para maiores informações
alias com_all_!report {
  if (!$istok(bug sugestao sugestão recalamcao reclamação,$1,32)) msgehalt Você precisa indicar um 8tipo de report15! 0,14 15,1 Os Tipos possíveis são 11Bug15,11 Sugestão 15e11 Reclamação15. 0,14 15,1 Ex: 9!Report Bug Tem um erro no report!
  if (!$2) msgehalt O que você quer reportar? 0,14 15,1 Uso: 8!Report <tipo> <mensagem> 0,14 15,1 Ex: 9!Report Bug Tem um erro no report!

  var %type = $replace($1,tao,tão,cao,ção,cão,ção,çao,ção)
  var %code = $randomstring(4)
  while ($read($report.path,w,@RPT-? %code *)) %code = $randomstring(4)
  write $report.path @RPT- $+ $upper($left($1,1)) %code 0 $ctime $nick $2-
  noticen Report 0,14 15,1 Sua0 %type 15foi enviada com 8sucesso15!
  memosend sega Report 08 $+ $nick 15<14 $+ $1 $+ 15>00 $2-
  ;mail.send sega report $+(nick=,$nick,&report=,$2-)
}
alias com_chat_!report {
  id.check =
  if ($1 == list) {
    msgtopo 
    msgt 0SaintSeiya 14:: 0Report 
    msgdiv
    if ($oplv($nick) >= 2) {
      if ($2 == opened) var %regex = /@RPT-([SRB]) ([a-zA-Z0-9]{4}) (0) ([0-9]+) ([^\s.]+) (.*)/g
      elseif ($2 == canceled) var %regex = /@RPT-([SRB]) ([a-zA-Z0-9]{4}) (1) ([0-9]+) ([^\s.]+) (.*)/g
      elseif ($2 == finalized) var %regex = /@RPT-([SRB]) ([a-zA-Z0-9]{4}) (2) ([0-9]+) ([^\s.]+) (.*)/g
      elseif ($2 == all) var %regex = /@RPT-([SRB]) ([a-zA-Z0-9]{4}) ([0-3]) ([0-9]+) ([^\s.]+) (.*)/g
      else var %regex = /@RPT-([SRB]) ([a-zA-Z0-9]{4}) ([0-3]) ([0-9]+) ( $+ $nick $+ ) (.*)/g
    }
    else var %regex = /@RPT-([SRB]) ([a-zA-Z0-9]{4}) ([0-3]) ([0-9]+) ( $+ $nick $+ ) (.*)/g

    if ($window(@reports)) clear @reports
    window -h @reports
    filter -gfw $report.path @reports %regex

    var %total = $line(@reports,0)
    var %p = $ceil($calc(%total / 5))
    if ($3) && ($3 <= %p) { var %pg = $int($abs($3)) }
    else var %pg = 1
    var %i = $calc(%total - ((%pg - 1) * 5))
    var %f = $max(0,$calc(%i - 5))
    if (%total) {
      while (%i > %f) {
        tokenize 32 $line(@reports,%i)
        msgl 08 $+ $2 00 $+ $replace($right($1,1),R,Reclamação,B,Bug,S,Sugestão) 15enviada em09 $asctime($4,dd/mm/yyyy) 15ás09 $asctime($4,hh:nn)
        msgl 14     $strip($left($6-,49)) $+ $iif($len($strip($6-)) > 49,...)
        msgl      $iif($nick != $5,Por:9 $5) 15Status:0 $replace($3,0,Em Aberto,1,4Cancelado,2,9Concluído)
        msgt
        dec %i
      }
      msgt Página08 %pg 15de11 %p
      msgdiv
      msgt Para visualizar um report em detalhe, digite 
      msgt 8!report view <código>
    }
    else msgt 0Nenhum report encontrado!
    msgbase
    window -c @reports
  }
  elseif ($1 == view) {
    if ($2) {
      var %regex = /@RPT-([SRBOX]) $2 ([0-3]) ([0-9]+) ([^\s.]*) (.*)/g
      var %r = $read($report.path,r,%regex)
      if (%r) {
        msgtopo | msgt 0SaintSeiya 14:: 0Report | msgdiv
        var %l
        while (%r) {
          msgl $iif($regml(1) == X,08 $+ $regml(4) 15respondeu,0Você 15escreveu) em09 $asctime($regml(3),dd/mm/yyyy) 15ás09 $asctime($regml(3),hh:nn) $+ 15:
          %l = $iif($regml(2) != 0 && $regml(1) == X,$regml(4) $replace($regml(2),1,4cancelou,2,8finalizou) 15este ticket)
          xmsgl < $+ $iif($regml(1) == X,08,00) $+ $regml(4) $+ 15> $regml(5)
          if (%l) msgr %l
          %l = %r
          %r = $read($report.path,r,%regex,$calc($readn + 1))
          if (%r) msgl
        }
        msgdiv
        msgt Última ação em09 $asctime($gettok(%l,4,32),dd/mm/yyyy) 15ás09 $asctime($gettok(%l,4,32),hh:nn:ss) 15por08 $gettok(%l,5,32)
        msgt Este ticket encontra-se $replace($gettok(%l,3,32),0,0em aberto,1,4cancelado,2,9finalizado)
        msgbase
      }
      else msge 15Report de id08 $2 15não foi encontrado!
    }  
    else msge Parâmetro 4Faltando¼14Use: 11!Report view <código>
  }
  elseif ($1 == reply) {
    if (!$2) msgehalt Parâmetro 4Faltando¼14Use: 11!Report reply <código> <mensagem>
    if (!$3) msgehalt Parâmetro 4Faltando¼14Use: 11!Report reply $2 <mensagem>      
    var %regex = /@RPT-([SRB]) $2 ([0-3]) ([0-9]+) $nick (.*)/g
    var %r = $read($report.path,r,%regex)
    if (!%r) msgehalt 15Report de id08 $2 15não foi encontrado!

    msgtopo 
    msgt 0SaintSeiya 14:: 0Report 
    msgdiv
    write $+(-l,$readn) $report.path $puttok(%r,0,3,32)
    write $report.path @RPT-O $2 0 $ctime $nick $3-
    msgt Você adicionou uma 9resposta 15ao report de código08 $2 $+ 15!
    msgt O seu post automaticamente foi posto como "0em aberto15"
    msgbase       
  }
  elseif ($1 == finalize || $1 == cancel || $1 == response) {
    op.check @ =
    if ($2) {
      if ($3) {
        var %regex = /@RPT-([SRB]) $2 ([0-3]) ([0-9]+) ([^\s.]*) (.*)/g
        var %r = $read($report.path,r,%regex)
        if (%r) {
          msgtopo | msgt 0SaintSeiya 14:: 0Report | msgdiv
          write $+(-l,$readn) $report.path $puttok(%r,$replace($1,finalize,2,cancel,1,response,0),3,32)
          write $report.path @RPT-X $2 $replace($1,finalize,2,cancel,1,response,0) $ctime $nick $3-
          msgt Você adicionou uma 9resposta 15ao report de código08 $2 $+ 15!
          msgt Este report foi configurado como "0 $+ $replace($1,finalize,8Finalizado,cancel,4Cancelado,response,0Em Aberto) $+ 15"
          msgbase       
          memosend $regml(4) SaintSeiya O seu 0report 15de código08 $2 15foi respondido por09 $nick $+ 15. Para visualizá-lo, digite09 !report view $2
        }
        else msge 15Report de id08 $2 15não foi encontrado!        
      }
      else msge Parâmetro 4Faltando¼14Use: 11!Report $1 $2 <mensagem>
    }  
    else msge Parâmetro 4Faltando¼14Use: 11!Report $1 <código> <mensagem>
  }
  elseif ($istok(sugestao sugestão reclamação reclamacao reclamacão reclamaçao bug,$1,32)) {
    if ($2) {
      var %type = $replace($1,tao,tão,cao,ção,cão,ção,çao,ção)
      var %code = $randomstring(4)
      while ($read($report.path,w,@RPT-? %code *)) %code = $randomstring(4)
      write $report.path @RPT- $+ $upper($left($1,1)) %code 0 $ctime $nick $2-
      msgtopo
      msgt SaintSeiya 14::0 Report
      msgdiv
      msgt Sua0 %type 15foi enviada com 8sucesso15!
      msgbase
      memosend sega Report 08 $+ $nick 15<14 $+ $1 $+ 15>00 $2-
      ;mail.send sega report $+(nick=,$nick,&report=,$2-)
    }
    else msge Parâmetro 4Faltando¼14Use: 11!Report $1 < $+ $1 $+ >
  }
  else {
    msgtopo 
    msgt 0SaintSeiya 14:: 0Report 
    msgt A sua voz no #CdzForever!
    msgdiv  
    xmsgt O 8#CdzForever 15sempre foi aberto a 0críticas 15e 0sugestões 15dos seus usuários, e isso sempre nos ajudou a manter a 7liderança 15como o canal de 11Cavaleiros do Zodíaco 15mais 4amado 15(14e humilde :x15) do IRC brasileiro!
    msgt
    xmsgt Para facilitar o contato entre os 0usuários 15e os 0administradores 15do canal, tanto para dar 11sugestão15, 11criticar 15algo ou informar um 11bug 15no bot, criamos o comando 9!Report15, e recentemente melhoramos ele.
    msgt
    xmsgt 0Para enviar um report à administração, use os seguintes comandos:
    msgdiv
    msgl 8!Report
    msgl   14- 0List                            15Lista os seus reports
    msgl   14- 0Sugestão 15<9mensagem15>             Envia uma sugestão
    msgl   14- 0Reclamação 15<9mensagem15>           Envia uma reclamação
    msgl   14- 0Bug 15<9mensagem15>                  Envia um aviso de bug
    msgl   14- 0Reply 15<9código15> <9mensagem15>       Reativa um report
    if ($oplv($nick) > 2) {
      msgl     4Sub-comandos exclusivos para Operadores:
      msgl   14- 0Finalize 15<9código15> <9mensagem15>    Responde + Finaliza
      msgl   14- 0Cancel 15<9código15> <9mensagem15>      Responde + Cancela
      msgl   14- 0Response 15<9código15> <9mensagem15>    Resposta simples
      msgl   14- 0List 9opened                     15Lista reps. abertos
      msgl   14- 0List 9closed                     15Lista reps. cancel.
      msgl   14- 0List 9finalized                  15Lista reps. final.
    }
    msgbase
  }
}
