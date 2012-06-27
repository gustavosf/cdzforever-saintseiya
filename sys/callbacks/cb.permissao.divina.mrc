;; ----------------------------------------------------------------------------
;; Callback :: Permissão Divina
;; Se desfaz de uma armadura. Remove a armadura
;; ----------------------------------------------------------------------------

alias cb.permissao_divina {
  var %arm = $arms.prepare($user.armadura)
  ;; testes
  if ($dados($nick,armadura) == Nenhuma) msgehalt Você 4não15 possui 0nenhuma 15armadura!
  if ($dados($nick,arm.on) == Sim) msgehalt Você 4não15 pode se desfazer da sua armadura se ela estiver 0invocada15!¼Digite 8!Retirar Armadura 15no canal
  if ($dados($nick,hp.arm) == 0) msgehalt Você 4não15 pode se 0desfazer 15da sua armadura se ela estiver 8quebrada15!¼0Conserte-a antes de se desfazer dela

  hadd -m $nick desfazer %arm
  hadd -m $nick permissao 1
  msgtopo
  msgt Desfazer a sua armadura irá lhe custar uma 08 Permissão Divina15.
  msgt Para 0confirmar15, digite 9@Confirmar
  msgbase
  halt
}
