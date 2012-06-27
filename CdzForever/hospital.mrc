on *:chat:!Hospital Graad: {
  id.check =
  msgtopo | msgt 15Seja Bem-Vindo14(9a14,1)15 ao Hospital Graad.
  msgdiv
  msgt 15,1Aqui você poderá fazer Operação de Mudança de Sexo.
  msgl 
  msgl 9          Operação                     8Valor
  msgl 11   Masculino15 ->13 Feminino              0415.000
  msgl 13   Feminino 15 ->11 Masculino             0410.000
  msgl
  msgt 15Ou se curar quando estiver com Vigor Físico
  msgt 15em estado crítico.
  msgl 
  msgt 8Cura 15-> 0410.000
  msgt
  msgt 0Lembrando que o Estado Crítico é quando o Vigor FÍsico
  msgt 0está abaixo de 0%.
  msgt 0Com a cura, você fará seu VF ficar 0% 
  msgt 0e poderá, então, usar a lanchonete.
  msgdiv
  msgl 8Comandos:
  msgl 9!0Iniciar Operação14 -15 Inicia a Mudança de Sexo.
  msgl 9!0Curar Vigor     14 -15 Inicia a Cura do Vigor Físico.
  msgbase
}

alias com_chat_!iniciar {
  if ($1 != operação) return
  id.check =
  msgtopo 
  msgt 15Você está prestes a virar $iif($user.perfil.sexo == Masculino,13Mulher,11Homem) $+ 15.
  msgdiv
  msgt 0,1Tem certeza que é isso que você quer?
  msgl 
  msgt Isso irá lhe custar8 $iif($user.perfil.sexo == Masculino,15.000,10.000) $+ 15 de dinheiro
  msgdiv
  msgl 0Para confirmar a operação, digite: 7!9Finalizar Operação
  msgbase
  .timer.opsex. $+ $nick 0 60 noop
}

alias com_chat_!finalizar {
  if ($1 != operação) return
  id.check =
  var %sex = $user.perfil.sexo
  if (!$timer(.opsex. $+ $nick)) msgehalt Você 4não 15iniciou o procedimento de operação para 9troca de sexo15, ou 0demorou demais para responder ao médico15. 0Recomece 15o processo através do comando 11!Iniciar Operação
  if ($user.dinheiro.get < $iif(%sex == Masculino,15000,10000)) msgehalt 0Você 4não 15possui o 0dinheiro necessário 15para fazer esta operação¼ ¼14Você terá que se contentar com a sua genitália por enquanto.
  user.perfil.sexo.set $iif(%sex == Masculino,Feminino,Masculino)
  user.dinheiro.retrieve $iif(%sex == Masculino,15000,10000)
  msgtopo 
  msgt 15Você agora é uma $iif(%sex == Masculino,uma 13Mulher,um 11Homem) $+ 15.
  msgdiv
  msgt 0,1Agora você pode usufruir das vantagens de ser $iif(%sex == Masculino,uma 13menina,um 11menino) $+ 15.
  if (%sex == Masculino) {
    msgt 14Isto inclui TPM, menstruação, sexto sentido, urinar sentada, salários mais baixos, e ter que usar uma máscara 24 horas por dia!
    if (!$user.item.has(Máscara)) {
      user.item.add $nick Máscara
      msgt Adicionalmente, você ganhou uma 13Máscara de amazona.
    }
  }
  if (%sex == Feminino) msgt 14Isto inclui urinar de pé, posições de comando elevados, não precisar usar máscara, permissão para ser o personagem principal de qualquer desenho, maior salário, entre outras.
  msgbase
  .timer.opsex. $+ $nick off
}
alias com_chat_!curar {
  if ($1 != vigor) return
  id.check =
  if ($readini users/ $+ $nick $+ .ini $nick Stamina > 0) {
    msgtopo 
    msgt 0,1Você não precisa de Cura Médica e sim de Lanche.
    msgbase
    .unset %curnickvig
    .timercurvig $+ $nick off
    halt
  }
  if ($readini users/ $+ $nick $+ .ini $nick Dinheiro < 10000) {
    msgtopo 
    msgt 0,1Você não possui8 10.000 0de dinheiro.
    msgbase
    .unset %curnickvig
    .timercurvig $+ $nick off
    halt 
  }
  msgtopo
  msgl 4    _    
  msgl 4  _| |_   0  Você está prestes a gastar8 10.000
  msgl 4 |_   _|  0para se curar. Se quiser mesmo, digite
  msgl 4   |_|    0         7!9Confirmar Cura
  msgl
  msgbase
  .timercurvig $+ $nick 1 30 noop
}

alias com_chat_!confirmar {
  if ($1 != cura) return
  id.check =
  if (!$timer(curvig $+ $nick)) msge 0,1Digite 7!9Curar Vigor0 antes.
  elseif ($user.stamina > 0) msge 0,1Você não precisa de Cura Médica e sim de Lanche.
  else {
    if ($user.dinheiro.get < 10000) {
      msgtopo 
      msgt 0,1Você não possui8 10.000 0de dinheiro.
      msgbase
    }
    else {
      user.stamina.set 50
      user.dinheiro.retrieve 10000
      msgtopo 
      msgt 15Você está 11Curado15.
      msgdiv
      msgt 0,1Você está com 50% de VF.
      msgt 0,1Vá até a Lanchonete se alimentar.
      msgbase
    }
  }
  .timercurvig $+ $nick off
}
