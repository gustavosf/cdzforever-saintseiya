alias com_all_!freequiz {
  op.check !
  if ($1 && $dados($1,nick)) {
    remini $dados($1) quiz data
    msgn 08 $+ $1 15recebeu mais uma oportunidade para responder o 9Quiz 15hoje!
  }
}

alias com_chat_!quiz {
  id.check =
  msgtopo | msgt 0QUIZ CDZFOREVER
  msgt 4¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯
  xmsgt 0Perguntas diárias sobre os Cavaleiros do Zodíaco. 
  xmsgt 0As perguntas serão múltipla-escolha e cada usuário, poderá responder UMA por dia, sendo que terá 20 segundos para executar a resposta. Se por algum motivo, o usuário não responder a pergunta dentro dos15 200 segundos, perderá o direito de resposta no dia.
  xmsgt As perguntas serão aleatórias e não se repetirão no futuro mesmo se você errá-la, portanto seja rápido e atencioso!
  msgdiv
  msgt 0Para acionar a 'Pergunta do Dia', digite:7 !9Pergunta
  msgt Para respondê-la, digite 0!Resposta8 <letra>
  msgt
  msgl 9Exemplo: 0O que siginifica CdZ?
  msgl 8a11.15 Pizza
  msgl 8b11.15 Nada
  msgl 8c11.15 Começamos do Zero
  msgl 8d11.15 Cavaleiros do Zodíaco
  msgt
  msgl Para responder, digite:
  msgl 0!Resposta8 d
  msgt Fácil, né? 
  msgbase
}

alias loadperg {
  if (!$dados($1,nick)) return
  if ($window(@perguntas)) window -c @perguntas
  window -h @perguntas
  loadbuf @perguntas sys/perguntas.txt
  var %r = $user.quiz.perguntas,%l
  while (%r) {
    %l = $fline(@perguntas,$gettok(%r,1,44) $+ *)
    if (%l) dline @perguntas %l
    %r = $deltok(%r,1,44)  
  }
  return $line(@perguntas,$r(1,$line(@perguntas,0)))
}

alias com_chat_!pergunta {
  id.check =
  if ($user.quiz.data == $date) { msgtopo | msgt 4Você já respondeu o Quiz hoje! | msgbase | Halt }
  if ($timer(quizperg $+ $nick)) { msgtopo | msgt 4Você já está respondendo o Quiz de hoje! | msgbase | Halt }
  var %readperg = $loadperg($nick)
  var %resp = $user.quiz.perguntas
  var %pergunta = $gettok(%readperg,7,$asc(*))
  var %pergnume = $gettok(%readperg,1,$asc(*))

  if (!%pergunta) { msgtopo | msgt 4Você já finalizou o Quiz! | msgt 4Aguarde perguntas novas! | msgbase | Halt }

  hadd -mu20 $nick pergunta %pergunta
  hadd -u20 $nick pergnume %pergnume

  msgtopo 
  msgt 0PERGUNTA DO DIA
  msgt 4¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯
  msgt 15Prêmio:9 500 0méritos.
  msgt 14¯¯¯¯¯¯  ¯¯¯ ¯¯¯¯¯¯¯ 
  msgt 15Tempo de Resposta:9 200 segundos.
  msgt 14¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯¯¯  ¯¯ ¯¯¯¯¯¯¯¯ 
  xmsgt 07 $+ $gettok(%readperg,2,$asc(*))
  if ($gettok(%readperg,8,$asc(*)) != $null) { xmsgt 07 $+ $gettok(%readperg,8,$asc(*)) }
  msgt
  msgl 8a11.15 $gettok(%readperg,3,$asc(*))
  msgl 8b11.15 $gettok(%readperg,4,$asc(*))
  msgl 8c11.15 $gettok(%readperg,5,$asc(*))
  msgl 8d11.15 $gettok(%readperg,6,$asc(*))
  msgdiv
  msgt Para responder, digite 0!Resposta8 <letra>
  msgbase
  w* $nick quiz perguntas $addtok(%resp,%pergnume,44)
  .timerquizperg $+ $nick 1 20 .writeini users/ $+ $nick $+ .ini quiz data $date
  .timerquizperg2 $+ $nick 1 20 /msg =$nick 1,1 14,14 4,1 Tempo para responder o Quiz esgotado! Tente novamente amanhã! 14,14 1,1 
}
alias com_chat_!resposta {
  id.check =
  if ($1 != $null) {
    if ($1 != a) && ($1 != b) && ($1 != c) && ($1 != d) { msgtopo | msgt 4Escolha entre as opções 8a11,8 b11,8 c 11ou8 d4! | msgbase | Halt }
    else {
      if ($user.quiz.data == $date) { msgtopo | msgt 4Você já respondeu o Quiz hoje! | msgbase | Halt }
      if ($timer(quizperg $+ $nick)) {
        if ($1 == $hget($nick,pergunta)) {
          .timerquizperg $+ $nick off
          .timerquizperg2 $+ $nick off
          msgtopo | msgt 11RESPOSTA CORRETA!
          msgt 8¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯
          msgt 0Você ganhou 500 méritos! 
          msgbase
          .set %merquiz $readini(users/ $+ $nick $+ .ini,$nick,meritos)
          .set %quizmer $calc(%merquiz + 500)
          .set %acertoper $user.quiz.acertos
          .set %peracerto $calc(%acertoper + 1)
          .writeini users/ $+ $nick $+ .ini quiz acertos %peracerto
          .writeini users/ $+ $nick $+ .ini $nick meritos %quizmer
          .writeini users/ $+ $nick $+ .ini quiz data $date
          .unset %merquiz
          .unset %quizmer
          .unset %acertoper
          .unset %peracerto
          Halt
        }
        if ($1 != $hget($nick,pergunta)) {
          .timerquizperg $+ $nick off
          .timerquizperg2 $+ $nick off
          msgtopo 
          msgt 4RESPOSTA INCORRETA!
          msgt 0¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯
          msgt 15Não foi dessa vez que você acertou!
          msgt 15Estude mais até amanhã. Acredite no seu cosmo
          msgt 15que você superará os limites do conhecimento!
          msgbase
          .set %errosper $user.quiz.erros
          .set %pererros $calc(%errosper + 1)
          .writeini users/ $+ $nick $+ .ini quiz erros %pererros
          .writeini users/ $+ $nick $+ .ini quiz data $date
          hdel $nick pergunta
          hdel $nick pergnume
          .unset %errosper
          .unset %pererros
          Halt
        }
      }
    }
  }
}
