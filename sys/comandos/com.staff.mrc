;; ----------------------------------------------------------------------------
;; Comando :: chat :: @AddAdm <nick>
;; Remove um usuário como administrador do canal
;; ----------------------------------------------------------------------------

alias com_help_@AddAdm return @AddAdm¼Canal ou PVT¼@AddAdm <nick>¼Adiciona um usuário a administração do canal
alias com_all_@AddAdm {
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @AddAdm <nick>
  if ($user.isadm($1)) msgehalt O usuário8 $1 15já é administrador.

  msgto #CdzForever 9 $+ $nick 15Adicionou0  $+ $1 $+  15como 7Administrador.
  memosend $1 SaintSeiya Você foi adicionado como 9Adminstrador15 do canal 15Cdz0For15ever. Você será 0automaticamente logado 15ao acessar o chat. Você também pode se identificar utilizando o comando 11/CTCP SaintSeiya IDENT <suasenha>
  w* $1 oper lvl 4
  w* $1 oper data $ctime
  w* $1 oper por $nick
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: @AddOper  <nick>
;; Remove um usuário como operador do canal
;; ----------------------------------------------------------------------------

alias com_help_@AddOper return @AddOper¼Canal ou PVT¼@AddOper <nick>¼Adiciona um usuário como operador do canal
alias com_all_@AddOper {
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @AddOper <nick>
  if ($user.isop($1)) msgehalt O usuário8 $1 15já é operador.

  msgto #CdzForever 9 $+ $nick 15Adicionou0  $+ $1 $+  15como 11Operador.
  memosend $1 SaintSeiya Você foi adicionado como 11Operador15 do canal 15Cdz0For15ever. Você será 0automaticamente logado 15ao acessar o chat. Você também pode se identificar utilizando o comando 11/CTCP SaintSeiya IDENT <suasenha>
  w* $1 oper lvl 3
  w* $1 oper data $ctime
  w* $1 oper por $nick
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: @AddAtu <nick>
;; Remove um usuário como atualizador do canal
;; ----------------------------------------------------------------------------

alias com_help_@AddAtu return @AddAtu¼Canal ou PVT¼@AddAtu <nick>¼Adiciona um usuário como atualizador do canal
alias com_all_@AddAtu {
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @AddAtu <nick>
  if ($user.isatu($1)) msgehalt O usuário8 $1 15já é atualizador.

  msgto #CdzForever 9 $+ $nick 15Adicionou0  $+ $1 $+  15como 9Atualizador.
  memosend $1 SaintSeiya Você foi adicionado como 9Atualizador15 do canal 15Cdz0For15ever. Você será 0automaticamente logado 15ao acessar o chat. Você também pode se identificar utilizando o comando 11/CTCP SaintSeiya IDENT <suasenha>
  w* $1 oper lvl 2
  w* $1 oper data $ctime
  w* $1 oper por $nick
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: @RemStaff <nick>
;; Remove um usuário da STAFF do canal
;; ----------------------------------------------------------------------------

alias com_help_@RemStaff return @RemStaff¼Canal ou PVT¼@RemStaff <nick>¼Remove um usuário da staff do canal
alias com_all_@RemStaff {
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @RemStaff <nick>
  if ($user.isatu($1)) msgehalt O usuário8 $1 4não 15está da staff.

  msgto #CdzForever 9 $+ $nick 15removeu0  $+ $1 $+  15da 7Staff 15do canal.
  memosend $1 SaintSeiya Você foi removido da STAFF do 15Cdz0For15ever por8 $nick $+ 15.
  .ruser $1
  w/ $1 oper
}

;; ----------------------------------------------------------------------------
;; Comandos desabilitados 
;; ----------------------------------------------------------------------------

alias com_all_@RemAdm {
  disabled Use @RemStaff <nick>
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @RemAdm <nick>
  if ($user.isadm($1)) msgehalt O usuário8 $1 4não 15é administrador.

  msgto #CdzForever 9 $+ $nick 15removeu0  $+ $1 $+  15como 7Administrador.
  memosend $1 SaintSeiya Você foi removido da STAFF do 15Cdz0For15ever por8 $nick $+ 15.
  .ruser $1
  w/ $1 oper
}


alias com_all_@RemOper {
  disabled Use @RemStaff <nick>
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @RemOper <nick>
  if ($user.isop($1)) msgehalt O usuário8 $1 4não 15é operador.

  msgto #CdzForever 9 $+ $nick 15removeu0  $+ $1 $+  15como 11Operador.
  memosend $1 SaintSeiya Você foi removido da STAFF do 15Cdz0For15ever por8 $nick $+ 15.
  .ruser $1
  w/ $1 oper
}

alias com_all_@RemAtu {
  disabled Use @RemStaff <nick>
  op.check !
  if (!$1) msgehalt Parâmetro Faltando! Uso: @RemAtu <nick>
  if ($user.isatu($1)) msgehalt O usuário8 $1 4não 15é atualizador.

  msgto #CdzForever 9 $+ $nick 15removeu0  $+ $1 $+  15como 9Atualizador.
  memosend $1 SaintSeiya Você foi removido da STAFF do 15Cdz0For15ever por8 $nick $+ 15.
  .ruser $1
  w/ $1 oper
}


;; ----------------------------------------------------------------------------
;; Comando :: chat :: @RemAtuTemp <nick>
;; Remove um usuário como atualizador temporário do canal
;; ----------------------------------------------------------------------------

alias com_help_@RemAtuTemp return @RemAtuTemp¼Canal ou PVT¼@RemAtuTemp <nick>¼Remove um usuário como atualizador temporário
alias com_all_@RemAtuTemp {
  op.check @
  if (!$1) msgehalt Parâmetro Faltando! Uso: @RemAtuTemp <nick>
  if (!$oplv($1)) msgehalt O usuário9 $1 15não é operador temporário!
  msgto #CdzForever 9 $+ $nick 15Removeu0  $+ $1 $+  15como Atualizador Temporário.
  msgto $1 Você foi removido da 9 Atualização Temporária15 do canal 15Cdz0For15ever.
  .ruser $1
  mode #cdzforever -v $1
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: @AddAtuTemp <nick>
;; Adiciona um usuário como operador temporário do canal
;; ----------------------------------------------------------------------------

alias com_help_@AddAtuTemp return @AddAtuTemp¼Canal ou PVT¼@AddAtuTemp <nick>¼Adiciona um usuário como atualizador temporário do canal
alias com_all_@AddAtuTemp {
  op.check @
  if (!$1) msgehalt Parâmetro Faltando! Uso: @AddAtuTemp <nick>
  if ($user.isatu($1)) msgehalt O8 $1 15já está na staff do canal!

  msgto #CdzForever 9 $+ $nick 15Adicionou0  $+ $1 $+  15como Atualizador Temporário.
  msgto $1 Você foi adicionado como 9Atualizador Temporário15 do canal 15Cdz0For15ever.
  .auser 2 $1 $1
  mode #cdzforever +v $1
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !atualizadores online
;; Lista os atualizadores conectados e logados no bot
;; ----------------------------------------------------------------------------

alias com_help_!Atualizadores_online return !Atualizadores Online¼Canal ou PVT¼!Atualizadores Online¼Lista os atualizadores que estão online no canal
alias com_chat_!atualizadores {
  if ($1 != online) return 
  id.check =
  msgtopo 
  msgt 0Atualizadores 7Online0 no Momento.
  msgdiv
  var %x = $ulist(*,0),%y = 0,%atuon,%atureal
  while %x {
    %atuon = $ulist(*,%x)
    %atureal = $ulist(*,%x).info
    if (%atuon ison #CdzForever) {
      msgl
      msgl     8 $+ %atuon $+  $iif(%atuon != %atureal,14( $+ %atureal $+ ))
      msgl     11Administrador14: 0 $+ $iif($user.isadm(%atureal),Sim,Não) $+           15_______________1
      msgl     11Operador14:      0 $+ $iif($user.isop(%atureal),Sim,Não) $+           1,15 9,1 Logado14: 0 $+ $iif($dados(%atureal,ident) == Sim,Sim,Não) 1,15 1,1
      msgl     11Atualizador14:   0 $+ $iif($user.isatu(%atureal),Sim,Não) $+           15¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1
      inc %y
    }
    dec %x
  }
  if (%y == 0) {
    msgl
    msgt 4Não consta atualizadores online no momento.
  }
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !staff
;; Lista os membros da staff, e os seus respectivos cargos
;; ----------------------------------------------------------------------------

alias com_help_!staff return !Staff¼Chat¼!Staff¼Lista os membros da Staff do canal, com seus respectivos cargos
alias com_chat_!staff {
  disabled
  id.check =
  msgtopo | msgt 0STAFF | msgdiv
  msgl 14Operador                Status                   Online?
  var %x = 1,%atunick
  while %x <= $ini($oper,0) {
    %atunick = $ini($oper,%x)
    if ($user.isatu(%atunick)) %pre = 09Atualizador15
    if ($user.isop(%atunick)) %pre = 11Operador15
    if ($user.isadm(%atunick)) %pre = 08Administrador15
    msgl %atunick $spc(%atunick,22) %pre $spc(%pre,29) $iif(%atunick ison #cdzforever,Sim,Não)
    inc %x
  }
  msgbase
}
