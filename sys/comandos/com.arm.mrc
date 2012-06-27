;; ----------------------------------------------------------------------------
;; Comando :: chat :: @arm
;; Solicita uma armadura
;; ----------------------------------------------------------------------------

alias com_help_@arm return @Arm¼Chat¼@Arm <armadura>¼Escolhe uma armadura no bot, levando em conta as condições de méritos, aura mínima e afins
alias com_chat_@arm {
  id.check =

  var %arm = $strip($1-), %arm.nome = $arms.nome(%arm),%v,%r = 1
  var %aura = $replace($arms.classe(%arm),S,113,A,54,B,37,C,15,D,2)

  ;; testes
  var %i = $hget(0)
  while (%i) {
    if ($hget($hget(%i),armadura) == %arm) msgehalt Já tem um usuário solicitando esta 8armadura15!
    dec %i
  }
  if (!$arms.nome(%arm)) msgehalt 0Essa armadura no ecziste!
  if ($arms.liberada(%arm) == Nao) msgehalt A armadura08 %arm.nome 4não 15está 0liberada15!
  ;; removida restrição de sexo para o traje
  ;; if ($arms.sexo(%arm) != $dados($nick,sexo)) msgehalt Você não pode usar a armadura de08 %arm.nome 15pois ela é de um sexo diferente do teu!¼Se a vontade for muito grande, você pode pensar em 13mudar de sexo 15no 8!9Hospital Graad
  if ($arms.dono(%arm) != Nenhum) msgehalt A armadura de08 %arm.nome 15já está sendo usada por09 $arms.dono(%arm) $+ 15!
  if ($dados($nick,armadura) != Nenhuma) msgehalt Você 0já possui 15uma armadura!
  if (%aura > $aura($nick)) msgehalt Você 4não 15possui a 0aura necessária 15para utilizar esta armadura!
  if ($read($logs(varrer.arm),w,$nick $+ @ $+ %arm.nome $+ @*,%r)) { %v = $v1 | %r = $readn + 1 }
  if (%v && $calc($gettok(%v,3,64) + 60*60*24*7) > $ctime) msgehalt Você 4não 15pode pegar esta armadura, pois ela foi 8varrida 15de você a 0menos de uma semana15.

  /* antigo, com confirmacao de operador
  hadd -mu60 $nick armadura %arm
  $+(.timer.sys.arm.,$nick 1 60) noticeto $nick O tempo para 8setar a armadura 15acabou, sem nenhum operador executar o comando. 0Tente novamente mais tarde15!
  msgto #cdzforever 08 $+ $nick 15está solicitando o cadastro para a armadura de9 %arm.nome $+ 15.
  */

  var %hp = $replace($arms.classe(%arm),S,5000,A,1000,B,800,C,400,D,100)

  w+ $nick Hp.Arm %hp
  w+ $nick Hp.Rec %hp
  w+ $nick Arm.on Nao
  w+ $nick Armadura $arms.nome(%arm)
  writeini armaduras.ini $arms.prepare(%arm) nick $nick

  msgto #cdzforever 0 $+ $nick 15acaba de receber a armadura de0 $arms.nome(%arm)
  msgto #cdzforever 7Status 0,14 15,1 Armadura:08  $+ $arms.nome(%arm) $+  14/15 Categoria: 09 $+ $arms.categoria(%arm) $+  14/15 Dono: 11 $+ $arms.dono(%arm) $+ 

  msgtopo
  msgt Você agora é o cavaleiro de11 $arms.nome(%arm) $+ 15.
  msgbase
}


;; ----------------------------------------------------------------------------
;; Comando :: chan :: @set <nick>
;; Seta uma aramdura a um determinado usuário no canal
;; ----------------------------------------------------------------------------

alias com_help_@set return @Set¼Canal¼@Set <nick>¼Seta uma armadura em um usuário (desabilitado)
alias com_chan_@set {
  op.check +

  ;; testes
  if (!$1) { noticen Você precisa 0indicar o usuário 15para o qual você deseja setar a armadura! Ex: 9@Set xys | return }
  if (!$hget($1,armadura)) { noticen O usuário8 $1 4não 15está 0solicitando uma armadura15! | return }

  var %arm = $hget($1,armadura)
  var %hp = $replace($arms.classe(%arm),S,5000,A,1000,B,800,C,400,D,100)

  w+ $1 Hp.Arm %hp
  w+ $1 Hp.Rec %hp
  w+ $1 Arm.on Nao
  w+ $1 Armadura $arms.nome(%arm)
  writeini armaduras.ini $arms.prepare(%arm) nick $1

  msgto #cdzforever 0 $+ $1 15acaba de receber a armadura de0 $arms.nome(%arm)
  msgto #cdzforever 7Status 0,14 15,1 Armadura:08  $+ $arms.nome(%arm) $+  14/15 Categoria: 09 $+ $arms.categoria(%arm) $+  14/15 Dono: 11 $+ $arms.dono(%arm) $+ 

  hdel $1 armadura
  $+(.timer.sys.arm.,$1 off)
}


;; ----------------------------------------------------------------------------
;; Comando :: chan :: @recusar <nick>
;; Recusa o registro de uma aramdura a um determinado usuário no canal
;; ----------------------------------------------------------------------------

alias com_help_@recusar return @Recusar¼Canal¼@Recusar <nick>¼Recusa uma armadura a um determinado usuário (desabilitado)
alias com_chan_@recusar {
  op.check @

  ;; testes
  if (!$1) { noticen Você precisa 0indicar o usuário 15para o qual você deseja setar a armadura! Ex: 9@Recusar xys | return }
  if (!$hget($1,armadura)) { noticen O usuário8 $1 4não 15está 0solicitando uma armadura15! | return }

  var %arm = $hget($1,armadura)
  hdel $1 armadura
  $+(.timer.sys.arm.,$1 off)

  msgto #cdzforever 09 $+ $1 $+ 15, seu pedido para receber a armadura de0  $+ $arms.nome(%arm) $+ 15, foi recusado!
}


;; ----------------------------------------------------------------------------
;; Comando :: chat :: @desfazer armadura
;; Se desfaz de uma armadura. Remove a armadura
;; ----------------------------------------------------------------------------

alias com_help_@desfazer return @Desfazer Armadura¼Chat¼@Desfazer Armadura¼Comando para se desfazer de uma armadura. Você precisará de 0870.000 méritos 15para se livrar de uma armadura 0Classe S15, 0850.000 15para 0Classe A15, 0830.000 15para 0Classe B15, 0815.000 15para 0Classe C 15e 085.000 15para 0Classe D15.
alias com_chat_@desfazer {
  if ($1 != armadura) return

  id.check

  var %arm = $arms.prepare($user.armadura)
  var %meritos = $replace($arms.classe(%arm),S,70000,A,50000,B,30000,C,15000,D,5000)

  ;; testes
  if ($dados($nick,armadura) == Nenhuma) msgehalt Você 4não15 possui 0nenhuma 15armadura!
  if ($dados($nick,arm.on) == Sim) msgehalt Você 4não15 pode se desfazer da sua armadura se ela estiver 0invocada15!¼Digite 8!Retirar Armadura 15no canal
  if ($dados($nick,hp.arm) == 0) msgehalt Você 4não15 pode se 0desfazer 15da sua armadura se ela estiver 8quebrada15!¼0Conserte-a antes de se desfazer dela
  if ($user.meritos.get < %meritos) msgehalt Você 4não15 possui a quantidade de 8méritos 15necessária para se 0desfazer 15desta armadura.¼Você precisa de9 $div(%meritos) méritos 15para se 0desfazer 15de uma armadura classe08 $arms.classe(%arm) $+ 15!

  hadd -m $nick desfazer %arm
  msgtopo
  msgt Desfazer a sua armadura irá lhe custar08 $div(%meritos) méritos15.
  msgt Para 0confirmar15, digite 9@Confirmar
  msgbase
}


;; ----------------------------------------------------------------------------
;; Comando :: chat :: @confirmar
;; Confirma a remoção da armadura.
;; Consome méritos (relativos a classe da armadura)
;; ----------------------------------------------------------------------------

alias com_chat_@confirmar {
  if (!$hget($nick,desfazer)) return
  id.check

  var %arm = $hget($nick,desfazer)
  var %permissao = $hget($nick,permissao)
  var %meritos = $replace($arms.classe(%arm),S,70000,A,50000,B,30000,C,15000,D,5000)

  ;; testes
  if ($dados($nick,armadura) == Nenhuma) msgehalt Você 4não15 possui 0nenhuma 15armadura!
  if ($dados($nick,arm.on) == Sim) msgehalt Você 4não15 pode se desfazer da sua armadura se ela estiver 0invocada15!¼Digite 8!Retirar Armadura 15no canal
  if ($dados($nick,hp.arm) == 0) msgehalt Você 4não15 pode se 0desfazer 15da sua armadura se ela estiver 8quebrada15!¼0Conserte-a antes de se desfazer dela
  if (!%permissao && $user.meritos.get < %meritos) msgehalt Você 4não15 possui a quantidade de 8méritos 15necessária para se 0desfazer 15desta armadura.¼Você precisa de9 $div(%meritos) méritos 15para se 0desfazer 15de uma armadura classe08 $arms.classe(%arm) $+ 15!

  if (!%permissao) user.meritos.retrieve %meritos
  else user.item.consume $nick Permissão Divina
  w+ $nick armadura Nenhuma
  w+ $nick arm.on Nao
  w- $nick hp.arm
  w- $nick hp.rec
  writeini armaduras.ini %arm nick Nenhum
  writeini armaduras.ini %arm liberada Sim

  msgtopo
  xmsgt Sua 8Caixa de Pandora 15começa a brilhar, e em um piscar de olhos ela se 0transforma em luz e sobe aos céus15!
  msgt
  msgt 0Sua ligação com a armadura foi desfeita
  msgbase

  msgto #cdzforever 08 $+ $nick 15acaba de se 0desfazer 15de sua armadura!
  msgto #cdzforever 7Status 0,14 15,1 Armadura:08  $+ $arms.nome(%arm) $+  14/15 Categoria: 09 $+ $arms.categoria(%arm) $+  14/15 Dono: 11 $+ $arms.dono(%arm) $+ 
  hdel $nick desfazer
  hdel $nick permissao
}

;; ----------------------------------------------------------------------------
;; Comando :: chan :: !delarm <nick>
;; Remove a armadura de um determinado usuário
;; ----------------------------------------------------------------------------

alias com_help_@delarm return @DelArm¼Chan¼@DelArm¼Retira a armadura de um usuário a força
alias com_chan_!delarm {
  disabled
  op.check !

  ;; testes
  if (!$dados($1,nick)) { noticen O usuário8 $1 4não 15está cadastrado! | return }
  if ($dados($1,armadura) == Nenhuma) { noticen O usuário8 $1 4não 15possui armadura. | return }

  hadd -mu60 $nick delarm $1
  noticen Para confirmar a remoção da Armadura de0 $1 15de0 $dados($1,armadura) $+ 15, digite7 !9ConfirmarDel 14/15 Para cancelar, digite7 !9CancelarDel
}

;; ----------------------------------------------------------------------------
;; Comando :: chan :: !confirmardel
;; Confirma a remoção da armadura de um determinado usuário
;; ----------------------------------------------------------------------------

alias com_chan_!confirmardel {
  disabled
  op.check !
  var %n = $hget($nick,delarm)

  ;; testes
  if (!%n) { noticen Você 4não 15solicitou a 0remoção da armadura 15de ninguém! | return }
  if (!$dados(%n,nick)) { noticen O usuário8 $1 4não 15está cadastrado! | return }
  if ($dados(%n,armadura) == Nenhuma) { noticen O usuário8 %n 4não 15possui armadura. | return }

  var %arm = $capitalize($remove($dados(%n,armadura),$chr(44)))

  if ($dados(%n,arm.on) == Sim) w+ %n cosmo $calc($dados(%n,cosmo) - $dados(%n,cosarm))
  w+ %n Arm.On Nao
  w+ %n Armadura Nenhuma
  writeini armaduras.ini %arm nick Nenhum

  msgto #cdzforever 08 $+ %n 15acaba de ter a sua armadura 4removida15!
  msgto #cdzforever 7Status 0,14 15,1 Armadura:08  $+ $arms.nome(%arm) $+  14/15 Categoria: 09 $+ $arms.categoria(%arm) $+  14/15 Dono: 11 $+ $arms.dono(%arm) $+ 

  hdel $nick delarm
}

;; ----------------------------------------------------------------------------
;; Comando :: chan :: !cancelardel
;; Cancela a remoção da armadura de um usuário
;; ----------------------------------------------------------------------------

alias com_chan_!cancelardel {
  disabled
  op.check !
  var %n = $hget($nick,delarm)
  if (!%n) { noticen Você 4não 15solicitou a 0remoção da armadura 15de ninguém! | return }
  msgto #cdzforever 00 $+ $nick $+ 15, a remoção da armadura de9  $+ %n $+  15 foi cancelada!
  hdel $nick delarm  
}


;; ----------------------------------------------------------------------------
;; Comando :: chan :: @Liberar <armadura>
;; Libera uma determinada armadura
;; ----------------------------------------------------------------------------

alias com_help_@liberar return @Liberar¼Chat¼@Liberar <Armadura>¼Libera uma determinada armadura (desativado)
alias com_chan_@liberar {
  disabled
  if ($1 != armaduras) return
  reforma sega 
  msgto #cdzforever Liberando 8todas 0armaduras15...
  var %i = $ini(armaduras.ini,0),%arm
  while (%i) {
    %arm = $ini(armaduras.ini,%i)
    writeini armaduras.ini %arm liberada Sim
    dec %i
  }
  msgto #cdzforever 9Todas 15as armaduras foram 0liberadas15.
}
