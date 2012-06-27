;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Consertar Aramdura
;; Recupera o life da armadura
;; ----------------------------------------------------------------------------

alias com_help_!consertar_armadura return !Consertar Aramdura¼Chat¼!Consertar Armadura¼Recupera o life da sua armadura. Você deve pagar uma taxa que depende da classe da armadura.
alias com_chat_!consertar {
  id.check =
  if ($1 != armadura) return

  if ($user.armadura == Nenhuma) msgehalt Você não tem 0nenhuma 8armadura15!
  if ($user.armadura.life == $user.armadura.life.total) msgehalt Sua armadura não precisa de conserto!
  if ($user.lutando) msgehalt Você está em uma 0luta15. Aguarde a 9confirmação 15do combate!

  var %preco = $replace($user.armadura.classe,D,5000,C,15000,B,25000,A,30000,S,50000)
  hadd -u30 $nick hprec %preco

  msgtopo
  msgt Você está prestes a recuperar a aramdura de
  msgt
  msgt 09 $+ $user.armadura
  msgt
  msgt Para isso, você precisará gastar 8$ $+ $div(%preco) 15para o 0mercenário recuperador de armaduras15.
  msgt Para confirmar, digite 11@Conserto
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: @Conserto
;; Efetua a recuperação do life da armadura
;; ----------------------------------------------------------------------------

alias com_help_@conserto return @Conserto¼Chat¼@Conserto¼Efetua a recuperação do life da sua armadura. Você deve pagar uma taxa que depende da classe da armadura. Deve ser usado apenas depois de digitar !Consertar Armadura
alias com_chat_@conserto {
  id.check =
  if ($h?(hprec)) var %preco = $v1
  if  (!%preco) msgehalt Você 4não 15está solicitando 0recuperação de armadura15. Para isso, digite 8!Consertar Armadura
  if ($user.dinheiro < %preco) msgehalt Você não tem 8$ $+ $div(%preco) 15para consertar a sua armadura!
  if ($user.armadura == Nenhuma) msgehalt Você não tem 0nenhuma 8armadura15!
  if ($user.lutando) msgehalt Você está em uma 0luta15. Aguarde a 9confirmação 15do combate!

  h- hprec
  user.armadura.life.restore
  user.dinheiro.retrieve %preco

  msgtopo
  msgt Você 8recuperou 15a sua aramdura!
  msgbase
}
