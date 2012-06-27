;; ------------------------------------------------------------------------------------- Comandos

alias com_chat_!evento {
  reforma sega
  if ($1 == marcar) com_chat_!evento_marcar $2-

}

alias com_chat_!evento_marcar {

  if (!$4) msgehalt Parâmetro Faltando!¼ ¼Use 8!Evento Marcar <tipo> <dia> <hora> <título>¼ ¼Ex:9 !Evento Marcar RPG 24/12 23:00 RPG Natalino
  if (!$regex($1-3,/(rpg|campeonato|quiz) ([0-9]{2}\/[0-9]{2}) ([0-9]{2}:[0-9]{2})/i)) msgehalt Formato inválido!¼Use 8!Evento Marcar <tipo> <dd/mm> <hh:mm> <título>
  if ($ctime($2 $+ / $+ $date(yyyy) $3) == $null) msgehalt Data 0inválida15. Reveja a data marcada.
  if ($v1 > $calc($ctime + 60*60*24*14)) msgehalt Você 0não pode 15marcar eventos com mais de 11duas semanas 15de antecedência.

  evento add $v1 $nick $1 $4-
  var %code = $ini($evento.path,$ini($evento.path,0))

  msgtopo
  msgt Evento criado, código %code
  msgbase
}

;; ------------------------------------------------------------------------------------- Aliases

alias -l evento.path return sys/eventos.ini
alias -l evento {
  if ($isid) {
    return $readini($evento.path,$1,$2-)
  }
  else {
    if ($1 == add) {
      var %code = $randomstring(5)
      while ($ini($evento.path,%code)) %code = $randomstring(5)
      writeini $evento.path %code status 0
      writeini $evento.path %code data $1
      writeini $evento.path %code responsavel $2
      writeini $evento.path %code tipo $2
      writeini $evento.path %code titulo $4
    }
  }
}
