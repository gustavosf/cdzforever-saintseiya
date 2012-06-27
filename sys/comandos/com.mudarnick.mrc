;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Mudar Nick
;; Ajuda o usuário a trocar de nick. O comando executa o WHOIS e caso o usuário
;; esteja identificado no servidor, prossegue
;; ----------------------------------------------------------------------------
alias com_chat_!mudar {
  if ($1 != nick) return
  if ($user.exists) msgehalt 15Este seu nick já está 0cadastrado15!

  msgtopo
  msgl 9Mudar Nick14:15 Estamos verificando o seu 8status 15na 0BrasNet
  msgl             15Aguarde alguns instantes...
  msgbase
  hadd -m $nick mudar.nick 1
  whois $nick
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Nick
;; Solicita a troca de um nick. É exigido que o usuário esteja identificado
;; no servidor
;; ----------------------------------------------------------------------------
alias com_chat_!nick {
  if ($h?(mudar.nick) != 3) msgehalt Digite 8!Mudar Nick 15primeiro para podermos confirmar o 0status 15do seu nick 14;P
  if ($dados($1,senha) !== $2) msgehalt 0Senha 15e14/15ou 0Nick 15não são compatíveis.

  h+ mudar.nick.de $1
  msgto #cdzforever O usuário8 $nick 15está solicitando a 0troca do nick 15de cadastro de09 $1 14(0 $+ $1 $+ 15-14>15 $+ $nick $+ 14). 15Algum operador 0confirme 15digitando 08@SetNick $nick
  msgtopo 
  msgt Aguarde a 0confirmação 15de um 08operador 15no canal 
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: chan :: @SetNick <nick>
;; Troca o nick de um usuário que está solicitando isto
;; ----------------------------------------------------------------------------
alias com_chan_@setnick {
  op.check @

  var %nick = $hget($1,mudar.nick.de)
  var %arm = $capitalize($remove($dados(%nick,armadura),$chr(32)))

  ;; testes
  if (!%nick) { noticen O usuário $1 não está solicitando a troca de nick! | return }

  if (%armadura != Nenhuma) writeini armaduras.ini %arm nick $1
  w+ %nick nick $1
  write -l1 $dados(%nick) $chr(91) $+ $1 $+ $chr(93)
  if ($isfile($dados($1))) .remove $dados($1)
  .rename $dados(%nick) $dados($1)
  write sys/logs/mudarnick.txt $date -- %nick -> $1 ( $+ $nick $+ )

  msgto $1 Seu Nick foi mudado de9 %nick 15para9 $1
  msgto #cdzforever O usuário9 %nick 15teve seu nick trocado para9 $1

  .signal nick_change %nick $1
}

;; ----------------------------------------------------------------------------
;; Raw :: 307, 318
;; Pega se o usuário está logado no servidor, e manda a mensagem avisando
;; ----------------------------------------------------------------------------
raw 307:*:if ($hget($2,mudar.nick) = 1) hadd $2 mudar.nick 2
raw 318:*:{
  if ($hget($2,mudar.nick) = 2) {
    hadd $2 mudar.nick 3
    msgtopo+ $2
    msgl+ $2 9Mudar Nick14:15 Nick 0aceito15! Iniciando mudança...
    msgl+ $2             Você tem 8certeza 15que deseja mudar seu nick?
    msgl+ $2             Se está certo disso, digite:
    msgl+ $2               9!Nick <0nick_antigo9> <0senha_do_nick9>
    msgbase+ $2
  }
  elseif ($hget($2,mudar.nick) = 1) {
    msgtopo+ $2
    msgl+ $2 9Mudar Nick14:15 Seu nick não está 0identificado15.
    msgl+ $2             Por 8questões de segurança15, você 4não 15poderá
    msgl+ $2             mudar de nick.
    msgbase+ $2
    hdel $2 mudar.nick
  }
}
