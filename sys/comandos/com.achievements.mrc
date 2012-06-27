;; achievements
;; para descrição consultar o achievements.ini

alias ra { 
  if $2 { return $readini($mircdirsys/lists/achievement.ini,$1,$2) }
  else { return $ini($mircdirsys/lists/achievement.ini,$1) }
}

alias com_chat_!conquistas  {
  id.check =
  if !$1 { 
    msgtopo
    msgt 0Conquistas
    msgt 15¯¯¯¯¯¯¯¯¯¯
    msgt 15 Sintaxe: !Conquistas <ação> [Nick]
    msgt 1
    msgt 00Descrição do pra que essa porra serve.
    msgdiv
    msgt 0Ações disponiveis
    msgt 15¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯
    msgl 15!Conquistas 09Lista 1.....14-> 00Conquistas existentes
    msgl 15!Conquistas 09Alcançadas 14-> 00Conquistas alcançadas
    msgl 15!Conquistas 09Pendentes 1.14-> 00Conquistas não alcançadas
    msgl 15!Conquistas 09Ver 1.......14-> 00Vê a descrição da conquista
    msgl 09
    msgbase
  }
  elseif ($1 == Lista || $1 == List) { 
    if !$2 { var %nick = $nick } 
    else { var %nick = $2 }
    if !$dados(%nick,nick) { msgl 09 $+ %nick 15não está cadastrado | halt }
    var %f = 1
    msgtopo
    xmsgt Vendo conquistas de09 %nick
    msgdiv
    while %f <= $ra(0) {
      xmsgt 09 $+ $ra(%f,nome) 
      xmsgl 1
      xmsgl 0Descrição: 15 $+ $ra(%f,desc)
      if $dados(%nick,conquistas,%f) >= $ra(%f,prog) { xmsgl 0Progresso: 07Concluido }
      else { xmsgl 0Progresso: $iif($ra(%f,prog) != 1,$dados(%nick,conquistas,%f)  $+ / $+ $ra(%f,prog,Não concluido)) }
      if %f < $ra(0) { msgdiv }
      inc %f
    }
    msgbase
  }
  else { xmsgl Ação invalida }
}
