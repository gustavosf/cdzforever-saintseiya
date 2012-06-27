;; ----------------------------------------------------------------------------
;; Comando :: Canal, PVT ou Chat :: !setcos
;;            Canal, PVT ou Chat :: !delcos
;; Comandos para edição do cosmos de um usuário
;; ----------------------------------------------------------------------------

alias com_chat_!setcos com_aux_adddelcos $1-2 +
alias com_all_!setcos  com_aux_adddelcos $1-2 +
alias com_chat_!delcos com_aux_adddelcos $1-2 -
alias com_all_!delcos  com_aux_adddelcos $1-2 -
alias com_aux_adddelcos {
  op.check !
  var %n = $dados($1,nick),%c = $remove($2,$chr(44),$chr(46))
  if (%n) {
    if (%c isnum 0-) {
      w+ %n cosmo $calc($dados(%n,cosmo) $3 %c)
      write $logs(adddelcosmo) $nick $iif($3 == +,adicionou,removeu) $div(%c) de cosmo $iif($3 == +,para,de) %n
      msgto #cdzforever 9,1 $+ $nick 15 $+ $iif($3 == +,adicionou,removeu) $+ 0 $div(%c) 15de cosmo $iif($3 == +,para,de) $+ 8 %n $+ 15!
    }
    else noticen Favor use um valor 0inteiro 8positivo 9válido15!
  }
  else noticen 00 $+ $nick $+ 15, 08 $+ $1 15não está cadastrado no 0SaintSeiya15!
}

;; ----------------------------------------------------------------------------
;; Comando :: Canal, PVT ou Chat :: !setcos
;;            Canal, PVT ou Chat :: !delcos
;; Comandos para edição do dinheiro de um usuário
;; ----------------------------------------------------------------------------

alias com_chat_!setdin com_aux_adddeldin $1-2 +
alias com_all_!setdin  com_aux_adddeldin $1-2 +
alias com_chat_!deldin com_aux_adddeldin $1-2 -
alias com_all_!deldin  com_aux_adddeldin $1-2 -
alias com_aux_adddeldin {
  op.check !
  var %n = $dados($1,nick),%c = $remove($2,$chr(44),$chr(46))
  if (%n) {
    if (%c isnum 0-) {
      w+ %n dinheiro $calc($dados(%n,dinheiro) $3 %c)
      write $logs(adddeldin) $nick $iif($3 == +,adicionou,removeu) $chr(36) $+ $div(%c) de dinheiro $iif($3 == +,para,de) %n
      msgto #cdzforever 9,1 $+ $nick 15 $+ $iif($3 == +,adicionou,removeu) $+ 08 $chr(36) $+  div(%c) 15de dinheiro $iif($3 == +,para,de) $+ 8 %n $+ 15!
    }
    else noticen Favor use um valor 0inteiro 8positivo 9válido15!
  }
  else noticen 00 $+ $nick $+ 15, 08 $+ $1 15não está cadastrado no 0SaintSeiya15!
}
