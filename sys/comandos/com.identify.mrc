;; ----------------------------------------------------------------------------
;; Sinal :: user_logout
;; Captura quando um usuário deve ser deslogado, por algum motivo
;; ----------------------------------------------------------------------------

on *:signal:user_logout:{
  user.logout $1
  if ($hget($1)) hfree $1
  chat.close $1 Você foi deslogado
}

;; ----------------------------------------------------------------------------
;; Evento :: nick
;; Captura quando um operador troca de nick no canal, e reflete essa alteração
;; na lista de usuários
;; ----------------------------------------------------------------------------

on *:nick: {
  if ($nick == $newnick) return
  if ($oplv($nick)) {
    .auser $calc($v1 + 1) $newnick $ulist($nick).info
    .ruser $nick
  }
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Ident <senha>
;; Identificar o usuáro no bot
;; ----------------------------------------------------------------------------

alias com_help_!ident return !Ident¼Chat¼!Ident <senha>¼Comando para se identificar no bot
alias com_chat_!ident {
  id.check = nocad
  if (!$user.senha) msgehalt Você 14não 15tem 0senha 15cadastrada! Cadastre utilizando o comando 11!Incluir Senha <senha>
  if ($user.identifyed) return
  if ($user.senha !== $1-) msgehalt 15Esta0 senha15 é 4Incorreta0!¼15Se você esqueceu sua0 senha15,¼digite 7@9Minha Senha
  user.login
  apres.inicial 1
  .signal user_login $nick
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: @Minha Senha
;; Recupera a senha de um usuário no bot, enviando para o e-mail cadastrado
;; ----------------------------------------------------------------------------

alias com_help_@minha_senha return !Minha Senha¼Chat¼!Minha Senha¼Envia a senha cadastrada no bot para o e-mail cadastrado no bot
alias com_chat_@minha_senha {
  id.check noident
  if ($dados($nick,senha)) {
    if ($user.perfil.email && !$user.perfil.email.code) {
      var %pass = $randomstring(8)
      w+ $nick senha %pass
      mail.send $nick novasenha $+(novasenha=,%pass)
      msgtopo
      msgt SaintSeiya 14:: 15Troca de Senha
      msgdiv
      msgt Uma 0nova senha 15foi enviada para o e-mail
      msgt 09 $+ $user.perfil.email
      msgt
      xmsgt Caso você não tenha recebido, confira a 4caixa de spam15, senão fale com um 8operador
      msgbase
    }
    else msge Você não tem um 9e-mail setado 15no sistema!¼Desta maneira, 4não 15é possível efetuar a recuperação normal.¼ ¼0Entre em contato com um operador para resolver o seu problema manualmente.
  }
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Senha <novasenha>
;; Comando que altera a senha de um usuário no bot
;; ----------------------------------------------------------------------------

alias com_help_!senha return !Senha¼Chat¼!Senha <novasenha>¼Comando que altera a senha de um usuário no bot
alias com_chat_!senha {
  id.check =
  if (!$1) msgehalt Você precisa indicar uma senha!¼8!Senha <senha>
  msgtopo
  msgt 0Troca de Senha
  msgt ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  msgt Sua Senha foi mudada para:9 $1
  msgt Se você por acaso esquecê-la, digite: 11@9Minha Senha
  msgbase
  w+ $nick Senha $1
}

;; ----------------------------------------------------------------------------
;; CTCP :: Ident <senha> [user]
;; Loga um operador no bot
;; ----------------------------------------------------------------------------

ctcp *:ident *:*: {
  id.check nocad
  var %nick = $iif($3,$3,$nick)
  if (!$dados(%nick,nick)) msgehalt 09 $+ $nick $+ 15, $iif(%nick == $nick,você,o nick8 %nick) 15não está cadastrado no bot!
  if ($dados(%nick,senha) === $2) {
    user.login $iif(%nick != $nick,%nick,$nick)
    noticen Você foi identificado como8 $replace($oplv($nick),3,Administrador,2,Operador,1,Atualizador,0,usuário normal ahhahaha) $+ 15!
  }
  else noticen 4Senha incorreta...
}
