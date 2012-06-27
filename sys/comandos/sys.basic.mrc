;; ----------------------------------------------------------------------------
;; Configurações básicas do sistema
;; ----------------------------------------------------------------------------

alias sys._PASSWORD return np03az**
alias sys._SERVER   return irc.irchighway.net
alias sys._ARENAS   return #cdzmeikai #cdzkaikai #cdzmakai #cdztenkai #cdzsekai #coliseu #cdzforever #starhill
alias sys._AJOIN    return #cdzforever,#cdzsekai,#cdztenkai,#cdzmeikai,#cdzmakai,#cdzkaikai,#starhill,#coliseu,#saintseiya,#cdz
alias sys._CHANSOP  return #cdzforever,#cdzsekai,#cdztenkai,#cdzmeikai,#cdzmakai,#cdzkaikai,#starhill,#coliseu,#saintseiya,#cdz

;; ----------------------------------------------------------------------------
;; Classe do sistema
;; ----------------------------------------------------------------------------

alias sys.ajoin {
  var %x = $sys._AJOIN,%j
  while (%x) {
    if ($me !ison $gettok(%x,1,44)) %j = $addtok(%j,$v2,44)
    %x = $deltok(%x,1,44)
  }
  if (%j) join %j
}

alias sys.checkup { 
  if (!$server) return
  sys.ajoin
  if ($me != SaintSeiya) { 
    nickserv ghost SaintSeiya $sys._PASSWORD 
    .timer 1 5 nick SaintSeiya 
  }
  elseif (r isin $usermode) {
    if ($me !isop #cdzforever) { chanserv op #cdzforever $me }
    if ($me !isop #cdzsekai) { chanserv op #cdzsekai $me }
    if ($me !isop #cdztenkai) { chanserv op #cdztenkai $me }
    if ($me !isop #cdzkaikai) { chanserv op #cdzkaikai $me }
    if ($me !isop #cdzmeikai) { chanserv op #cdzmeikai $me }
    if ($me !isop #cdzmakai) { chanserv op #cdzmakai $me }
  }
  if ($uptime(system,3) > %uptime.system) %uptime.system = $uptime(system,3)
  if ($uptime(server,3) > %uptime.server) %uptime.server = $uptime(server,3)
}


;; ----------------------------------------------------------------------------
;; RAWs
;; ----------------------------------------------------------------------------

raw 465:* { .timer.sys.reconect 1 300 svr $sys._SERVER }
raw 474:* { if ($istok($sys._AJOIN,$2,44)) chanserv unban $2 $me }

;; ----------------------------------------------------------------------------
;; START
;; ----------------------------------------------------------------------------

on *:start:{
  .echo -a 1,1 14,14 11,1 CdzForever Bot Script 15de Uso exclusivo de Pessoas de confiança da 8Staff 9#15Cdz0Fore15ver15 14,14 1,1 
  .echo -a 1,1 14,14 1,1 1 1 1 1 1 1 1 15BoT do 9#15Cdz0Fore15ver15 by0 _KDETT_15 &0 DeathshadoW15 &0 MeLorD15 &0 HyOgA_Di_CiSnE 1 1 1 1 1 1 1 14,14 1,1 

  var %f = $calc($readini(semana.ini,.,fim) - $ctime)
  if %f > 0 { .timer.sys.fecha.semana -o 1 %f fecha.semana }
  else { fecha.semana }
  .timer.sys.atutop -o 23:58 0 86400 atutop
  .timer.sys.backup -o 01:00 0 86400 sys.backup
  .timer.sys.varrer -o 23:59 0 86400 varrer 3
  .timer.sys.initrandomfight -o 1 $rand(10800,64800) com_aux_randomfight
  .timer.sys.marketing -o 0 $calc(60*63*2) marketing
  .timer.sys.checkup -o 0 60 sys.checkup

  .signal system_ready
}

;; ----------------------------------------------------------------------------
;; Eventos Secundários
;; ----------------------------------------------------------------------------

on *:disconnect:{
  server $sys._SERVER
  .timer.treino.* off
  .close -c *
}

on *:text:*:? {
  if (!$window(@pvt)) window @pvt
  echo @pvt $time :: ( $+ $iif($left($1,1) isin @ !,7,1) $+ $nick $+ ) $1-
  close -m $nick
}

on *:join:#CdzForever: {
  if ($nick == $me) { 
    .rlevel -r 2,3,4 
    if (!$ip) localinfo -u
  }
}

on *:connect:sys.checkup

on *:notice:*:*: {
  if ($nick == nickserv) && (*msg nickserv identify* iswm $strip($1-)) {
    nickserv identify $sys._PASSWORD
  }
}

on *:USERMODE:{
  if (*+*r* iswm $1-) away 14,1(8#0CDZforever8/15Narrado14) 0Digite 15!8CDZforever 
}

on *:kick:*:.signal user_kicked $knick $chan
on *:quit:.signal user_exited $nick
on *:part:#cdzforever:.signal user_exited $nick $chan

on *:deop:*:{
  ;; Proteção anti-deop
  if ($opnick == $me) && ($istok($chan,$sys._CHANSOP,44)) chanserv op $chan $me
}

on *:ban:*: { 
  ;; Proteção anti-ban
  if ($istok($chan,$sys._CHANSOP,44)) { 
    var %x = 1 
    while %x <= $ial($banmask,0) { 
      if $ial($banmask,%x) == $address($me,5) { 
        if ($me !isop #) set %unb $banmask
        else mode # -b $banmask
        halt
      } 
      inc %x 
    }
  }
}

on *:op:*: { 
  if ($istok($chan,$sys._CHANSOP,44)) {
    ;; Proteção anti-ban
    if ($opnick == $me) && (%unb) { mode # -b %unb | unset %unb }
  }
}

on *:nick: {
  if ($nick == $newnick) return
  if ($nick == $me) && ($newnick != SaintSeiya) { nickserv regain SaintSeiya $sys._PASSWORD }
  if ($newnick isop #cdzforever) || ($newnick ishop #cdzforever) {
    if (away isin $newnick) || (off isin $newnick) || (out isin $newnick) || (adeus isin $newnick) || (fui isin $newnick) || ( volto isin $newnick ) || ( auei isin $newnick ) || ( 0ut isin $newnick ) || ( off isin $newnick ) || ( afk isin $newnick ) {
      mode #cdzforever -aoh $newnick $newnick $newnick
    } 
  }  
}

on *:chat:*:{
  if ($oplv($nick) < 1) $+(.timer.chat.,$nick,.close) 1 600 chat.close $nick Inatividade de 10 minutos
  else $+(.timer.chat.,$nick,.close) off
}

on *:close:=:.signal close_chat $nick

;; ----------------------------------------------------------------------------
;; Signals
;; ----------------------------------------------------------------------------

on *:signal:user_kicked:if ($2 == #cdzforever) .signal user_logout $1
on *:signal:user_exited:if ((!$2) || ($2 == #cdzforever)) .signal user_logout $1

;; ----------------------------------------------------------------------------
;; CTCPs
;; ----------------------------------------------------------------------------

ctcp ^*:dcc { if ($nick !ison #cdzforever) halt }

;; ----------------------------------------------------------------------------
;; Comando :: pvt ou canal :: !Cdzforever
;; Abre uma conexão com o usuário (e fecha uma ativa, caso exista)
;; ----------------------------------------------------------------------------

alias com_all_!cdzforever {
  close -c $nick 
  dcc chat $nick 
}

;; ----------------------------------------------------------------------------
;; Comando :: pvt ou canal :: !bots
;; Lista os bots ativos no canal
;; ----------------------------------------------------------------------------

alias com_all_!bots {
  var %ss = $iif(SaintSeiya ison #cdzforever,9On,4Off)
  var %zd = $iif(Pandora ison #cdzforever,9On,4Off)
  msgn 15,1(0!BOTS15) 11×0SaintSeiya11: %ss 15(0Comandos11: 0!CdzForever 15ou 0!dcc15) 7/ 11×0Zodiaco11: %zd 15(0Comandos11:0 .Autolutas 15ou 0/Dcc Chat Pandora15)
}

;; ----------------------------------------------------------------------------
;; Comandos Auxiliares ou de Marketing
;; ----------------------------------------------------------------------------

alias com_all_!ajuda     com_all_!cadastrar
alias com_all_!cadastrar noticen 09 $+ $nick $+ 15, o comando para acessar o bot é:0 !CdzForever
alias com_all_!dcc       noticen 09 $+ $nick $+ 15,00 Para conectar digite 09/dcc chat bot.cdzforever.net: $+ $dccport $+ 
alias com_all_!quotes    msgn Acesse as 8pérolas 15do 9#CdzForever 15em0 www.cdzforever.net/qdb 15!
alias com_all_!addon     noticen O 0Addon 15do 8#CdzForever 15pode ser encontrado no seguinte link: 11www.CdzForever.net/addon 0,14 15,1 Para maiores informações, digite 9!Addon 15dentro do 0chat 15do bot

alias com_chat_!faq      msge O Faq está sendo 8refeito15. 0Aguarde15!¼Qualquer dúvida entre em contato com um 8operador15!

alias com_all_!cdzstatus     { msgn Status do0 14,1(9#15Cdz0Fore15ver14) $+ 14:09  $+ $nick(#CdzForever,0,o) $+  15@0OP14'9s 14|09 09 $+ $nick(#CdzForever,0,h) $+  15%0Half-OP14'9s 14|09  $+ $nick(#CdzForever,0,v) $+   15+0Voice14'9s 14|09 $nick(#CdzForever,0,r) 0Normais 14|09 $nick(#CdzForever,0,a) 0ao Todo. 14|0 Pico de 09 $+ $gettok(%cdzfor.pico,1,32) $+ 0 users 14(09 $+ $gettok(%cdzfor.pico,3,32) $+ 00@14/09 $+ $gettok(%cdzfor.pico,4,32) $+ 00%14/09 $+ $gettok(%cdzfor.pico,5,32) $+ 00+14/09 $+ $gettok(%cdzfor.pico,6,32) $+ 00n14)0 no dia15 $date($gettok(%cdzfor.pico,7,32)) 0às15 $time($gettok(%cdzfor.pico,7,32)) $+ 0. }
alias com_all_!cdzstatus.old { msgn Status do0 14,1(9#15Cdz0Fore15ver14) $+ 14:09  $+ $nick(#CdzForever,0,o) $+  15@0OP14'9s 14|09  $+ $nick(#CdzForever,0,v) $+  15+0Voice14'9s 14|09 $nick(#CdzForever,0,r) 0Normais 14|09 $nick(#CdzForever,0,a) 0ao Todo. 14|0 Pico de 09 $+ $gettok(%cdzfor.pico.old,1,32) $+ 0 users 14(09 $+ $gettok(%cdzfor.pico.old,2,32) $+ 00@14/09 $+ $gettok(%cdzfor.pico.old,3,32) $+ 00+14/09 $+ $gettok(%cdzfor.pico.old,4,32) $+ 00n14)0 no dia15 $date($gettok(%cdzfor.pico.old,5,32)) 0às15 $time($gettok(%cdzfor.pico.old,5,32)) $+ 0. }
alias com_all_!Users         { msgn No canal tem9 $findfile(users,*.ini,0) 15users cadastrados. }

alias marketing {
  if ($me !ison #cdzforever) return
  var %x = $r(1,2)
  if (%x == 1) msgto #cdzforever Tem0 Twitter15? Siga o #9CdzForever15! 8http://twitter.cdzforever.net
  if (%x == 2) msgto #cdzforever Tem11 Facebook15? Curta a página do #9CdzForever15! 8http://www.facebook.com/CDZForever
}

alias chat.close {
  if ($chat($1).status == active) {
    if ($2) msg = $+ $1 0,4 0,0 0,4 Seu chat será fechado. Motivo:8 $2- 0,0 0,4 
    close -c $1
  }
}
