alias com_chat_!aventura {
  id.check =
  if ($dados($nick,aventura,data) == $asctime(ddmmyyyy)) msgehalt Você já concluiu sua aventura hoje.
  elseif ($timer($+(.aventura.,$nick))) msgehalt 0Você já está em uma aventura¼ ¼Sua aventura termina em09 $tempo_certo($timer(.aventura. $+ $nick).secs)
  elseif ($user.treino.active($nick)) msgehalt Você está treinando atualmente, não pode ir em uma aventura.
  ;elseif ($user.vigor($nick) < 40) msgehalt Você precisa de ao menos 0840% 15de vigor para poder sair em uma aventura.
  elseif ($user.vigor($nick) <= 0) msgehalt Você está exausto, você não pode ir em uma aventura sem vigor.

  ;;;;;; verificar o número de vezes que o cara tentou o usar o comando, pra evitar espertinhos :)
  if ($gettok($dados($nick,aventura,duracao),1,32) != $date) w* $nick aventura duracao $date $rand(10,120)
  var %adv.duracao = $gettok($dados($nick,aventura,duracao),2,32)
  ;;;;;; fim da verificacao

  msgtopo
  msgt Você está a caminho de:
  var %adv.local = $read($list.path(locais))
  msgt 08 $+ $gettok(%adv.local,2,59) 15no mundo08 $capitalize($remove($gettok(%adv.local,1,59),#cdz))
  msgt 1,1
  msgt Sua aventura irá terminar em:04 %adv.duracao 15minutos
  msgbase
  .timer.aventura. $+ $nick 1 $calc(%adv.duracao * 60) aventura.fim $nick %adv.duracao
}

alias aventura.fim { 
  if !$2 { return }
  var %adv.cosmo = $int($calc($2 ^ 1.8)), %adv.msg = Sua aventura terminou, durante ela você ganhou09 $div(%adv.cosmo) 15de cosmo
  var %adv.premio = $rand(1,15)
  if (%adv.premio isnum 8-11) { 
    var %adv.comida = $rand(1,6) 
    if (%adv.comida isnum 1-3) { 
      %adv.msg = %adv.msg $+ $chr(44) achou 04uma maçã15
      var %adv.item = Maçã
    }
    if (%adv.comida isnum 4-5) { 
      %adv.msg = %adv.msg $+ $chr(44) achou 05uma barra chocolate15
      var %adv.item = Chocolate
    }
    if (%adv.comida == 6) { 
      %adv.msg = %adv.msg $+ $chr(44) pegou 14um peixe15
      var %adv.item = Sushi
    }
  }
  elseif (%adv.premio isnum 12-14) { 
    var %adv.dinheiro = $int($calc($2 ^ 1.5))
    %adv.msg = %adv.msg $+ $chr(44) 08C$ $div(%adv.dinheiro) $+ 15
  }
  elseif (%adv.premio == 15) { 
    var %adv.item = $readini($loja.path,$ini($loja.path,$rand(1,$ini($loja.path,0))),nome)
    %adv.msg = %adv.msg $+ $chr(44) achou um(a)11 %adv.item $+ 15 
  }
  else { 
    %adv.msg = %adv.msg $+ $chr(44) você não achou nenhum item
  }
  var %adv.vigor = $int($calc($2 / 4))
  %adv.msg = %adv.msg e gastou07 %adv.vigor 15de vigor.
  if ($calc($user.vigor($1) - %adv.vigor) <= 0) && (%adv.premio >= 8) { 
    %adv.msg = %adv.msg Entretanto como você perdeu todo seu vigor você não foi capaz de trazer nenhum item/dinheiro consigo.
  }
  else { 
    if (%adv.dinheiro) { user.dinheiro.add $1 %adv.dinheiro }
    if (%adv.item) { user.item.add $1 %adv.item }
  }
  user.vigor.retrieve $1 %adv.vigor
  user.cosmo.add $1 %adv.cosmo
  ;; patch (marca a aventura como tendo ocorrido no dia em que ela começou)
  var %ainit = $calc($ctime - $2 * 60)
  w* $1 aventura data $asctime(%ainit, ddmmyyyy)
  msgto $1 %adv.msg
}


on *:part:#cdzforever:{
  if ($timer($+(.aventura.,$nick))) { .timer.aventura. $+ $nick off | msgto $nick Você saiu do canal, sua aventura foi cancelada. }
}

on *:QUIT: {
  if ($timer($+(.aventura.,$nick))) { .timer.aventura. $+ $nick off  }
}

on *:KICK:#cdzforever: {
  if ($timer($+(.aventura.,$knick))) { .timer.aventura. $+ $knick off | msgto $knick Você foi kickado do canal, sua aventura foi cancelada. }
}

on *:NICK: {
  if ($nick == $newnick) return
  if ($timer($+(.aventura.,$nick))) && ($newnick ison #cdzforever) { .timer.aventura. $+ $nick off | msgto $newnick Você 8trocou de nick15, sua aventura foi cancelada. }
}
