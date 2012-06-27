;; ----------------------------------------------------------------------------
;; Comando :: chat :: @enviar <nick>
;; Envia os dados para um narrador de um combate
;; ----------------------------------------------------------------------------

alias com_help_@enviar return !Enviar¼Canal¼!Enviar <nick>¼Envia os dados para o narrador em um canal de combate.
alias com_chan_@enviar {
  if ($chan !isin $sys._ARENAS) return

  id.check
  if (!$1) msgehalt Parâmetro 0faltando15! Uso: 9@enviar <nick>
  if ($1 !ison $chan) msgehalt Usuário9 $1 15não está no8 $chan $+ 15!
  if ($1 == $me) msgehalt Eu já sei os teus 8dados15, 14manolo15.

  var %m = Cosmo:08 $div($user.cosmo) 15(14 $+ $aura($nick).sentido $+ º sentido15) | Armadura:0 $user.armadura
  if ($user.armadura != Nenhuma) %m = %m 15(14 $+ $user.armadura.life $+ HP15) ( $+ $iif($user.armadura.on,9Invocada,4Não-Invocada) $+ 15) 15| Golpes:9 $user.armadura.golpes.permitidos

  .msg $1 0,1 1,14 $nick 15,1  %m 0,14 0,1 
  .msg $1 0,1 1,14 $nick 15,1 Ítens:0 $listItens($nick) 0,14 0,1 
  noticen Você enviou os seus dados para08 $1 $+ 15.

}


;; Comando antigo guardado para a posteridade ---------------------------------------------

off *:text:@Enviar*:*: {
  .set %chansacess #Meikai #Sekai #Tenkai #cdzmakai #cdzMeikai #cdzSekai #cdzTenkai #cdzKaikai #cdzforever #cdzbattle #cdzbattle1 #cdzbattle2 #cdzbattle3 #cdzbattle4 #cdzbattle5 #cdzbattle6 #cdzbattle7 #cdzbattle8 #cdzsantuario
  if ($chan !isin %chansacess) {
  }
  if ($chan isin %chansacess) {
    if ($nick !ison #CdzForever ) {
      .notice $nick 1,1 14,14 9,1 $nick $+ 14,15 Você não está no 9#15Cdz0Fore15ver15 para ter acesso ao bot. 14,14 1,1 
      close -c $nick
    }
    if ($nick ison #CdzForever ) {
      if ($2 !ison #CdzForever ) {
        .notice $nick 1,1 14,14 9,1 $nick $+ 14,0 $2 15não está no 9#15Cdz0Fore15ver15 para receber seus dados. 14,14 1,1  
        close -c $nick
      }
      if ($2 ison #CdzForever ) {
        if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) {
          .notice $nick 1,1 14,14 9,1 $nick $+ 14,15 Você não está0 Cadastrado! 14,14 1,1 
        }
        if ($readini users/ $+ $nick $+ .ini $Nick Nick != $null) {
          if ($readini users/ $+ $2 $+ .ini $2 Nick == $null) {
            .notice $nick 1,1 14,14 9,1 $2 $+ 15 não está0 cadastrado! 14,14 1,1  
          }
          if ($readini users/ $+ $2 $+ .ini $2 Nick != $null) {
            if ($readini users/ $+ $nick $+ .ini $Nick Ident == Nao ) {
              .notice $nick 1,1 14,14 9,1 $nick $+ 14,15 Você não está0 Identificado! 14,14 1,1  
            }
            if ($readini users/ $+ $nick $+ .ini $Nick Ident == Sim ) { 
              if ($2 == SaintSeiya ) {
                .notice $nick 1,1 14,14 9,1 $nick $+ 14,15 pra que enviar os seus dados pro Bot?! 14,14 1,1 
              }
              if ($2 != SaintSeiya ) { 
                /set %nick2 $nick
                if ($readini users/ $+ $nick $+ .ini $Nick Cosmo < 2290001 ) {
                  .set %ensent 6° Sentido
                }
                if ($readini users/ $+ $nick $+ .ini $Nick Cosmo >= 2290001 ) && ($readini users/ $+ $nick $+ .ini $Nick Cosmo < 8710001 )  {
                  .set %ensent 7° Sentido
                }
                if ($readini users/ $+ $nick $+ .ini $Nick Cosmo >= 8710001 ) && ($readini users/ $+ $nick $+ .ini $Nick Cosmo < 500000001) {
                  .set %ensent 8° Sentido
                }
                if ($readini users/ $+ $nick $+ .ini $Nick Cosmo >= 500000001) {
                  .set %ensent 8° Sentido
                }
                if ($readini users/ $+ $nick $+ .ini $Nick Armadura == Nenhuma ) {
                  .set %ensex $readini users/ $+ $nick $+ .ini $nick Sexo
                  .set %encosmo $readini users/ $+ $nick $+ .ini $nick Cosmo
                  .set %enarmadura $readini users/ $+ $nick $+ .ini $nick Armadura
                  .set %endin $readini users/ $+ $nick $+ .ini $nick Dinheiro
                  .set %enitens $readini users/ $+ $nick $+ .ini $nick Itens
                  .set %envit $user.historico.vitorias
                  .set %ender $user.historico.derrotas
                  .set %enemp $user.historico.empates
                  .set %ennar $user.historico.narradas
                  .set %encom $user.historico.combates
                  .set %en1 $calc(%envit + %ender + %enemp)
                  .msg $2 1,1 14,14 9,1 $2 $+ 15,0 %nick2 15enviou os dados para você. 14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Armadura:9  $+ %enarmadura $+  14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Cosmo:9  $+ $replace($bytes(%encosmo,b),$chr(44),.) $+  14/15 Dinheiro:9 $ $+ $replace($bytes(%endin,b),$chr(44),.) $+  14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Sentido Máximo:9 %ensent 14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Itens:9 %enitens 14,14 1,1 
                  .notice $nick 1,1 14,14 9,1 $nick $+ 15, seus dados foram enviados a0 $2 $+ 15! 14,14 1,1 
                  .unset %arquivo
                  .unset %ensex
                  .unset %encosmo
                  .unset %enarmadura
                  .unset %endin
                  .unset %enitens 
                  .unset %envit
                  .unset %ender
                  .unset %enemp
                  .unset %ennar
                  .unset %encom
                  .unset %en1
                }
                if ($readini users/ $+ $nick $+ .ini $Nick Armadura != Nenhuma ) {
                  .set %ensex $readini users/ $+ $nick $+ .ini $nick Sexo
                  .set %encosmo $readini users/ $+ $nick $+ .ini $nick Cosmo
                  .set %enarmadura $readini users/ $+ $nick $+ .ini $nick Armadura
                  .set %endin $readini users/ $+ $nick $+ .ini $nick Dinheiro
                  .set %enitens $readini users/ $+ $nick $+ .ini $nick Itens
                  .set %envit $user.historico.vitorias
                  .set %ender $user.historico.derrotas
                  .set %enemp $user.historico.empates
                  .set %ennar $user.historico.narradas
                  .set %encom $user.historico.combates
                  .set %enarmon $readini users/ $+ $nick $+ .ini $nick Arm.On
                  .set %en1 $calc(%envit + %ender + %enemp)
                  .msg $2 1,1 14,14 9,1 $2 $+ 15,0 %nick2 15enviou os dados para você. 14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Armadura:9  $+ %enarmadura $+  14/15 Invocada:9  $+ %enArmon $+  14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Cosmo:9  $+ $replace($bytes(%encosmo,b),$chr(44),.) $+  14/15 Dinheiro:9 $ $+ $replace($bytes(%endin,b),$chr(44),.) $+  14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Sentido Máximo:9 %ensent 14,14 1,1 
                  .msg $2 1,1 14,14 15,1 Itens:9 %enitens 14,14 1,1 
                  .notice $nick 1,1 14,14 9,1 $nick $+ 15, seus dados foram enviados a0 $2 $+ 15! 14,14 1,1 
                  .unset %arquivo
                  .unset %ensex
                  .unset %encosmo
                  .unset %enarmadura
                  .unset %endin
                  .unset %enitens 
                  .unset %envit
                  .unset %ender
                  .unset %enemp
                  .unset %ennar
                  .unset %encom
                  .unset %en1
                }
              }
            }
          }
        }
      }
    }
  }
}
