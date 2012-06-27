;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Cadastrar
;; Inicia o processo de cadastro de um usuário no bot
;; ----------------------------------------------------------------------------

alias com_chat_!cadastrar {
  id.check = nocad
  if ($dados($nick,nick)) msge Você já está9 cadastrado15!
  else {
    h+ cad 1
    msgtopo
    msgt Verificando seu nick no servidor...
    msgt
    whois $nick
  }
}

;; ----------------------------------------------------------------------------
;; RAWs
;; ----------------------------------------------------------------------------

raw *:*:{
  if ($numeric == 307) && ($hget($2,cad) == 1) hadd $2 cad 2
  if ($numeric == 318) && ($hget($2,cad)) {
    if ($hget($2,cad) == 2) r-certo $2
    else r-errado $2
  }
}

alias r-certo { 
  msgt+ $1 0Nick Aceito! Iniciando cadastro...
  msgdiv+ $1
  msgt+ $1 Para se cadastrar, digite 9!0Escolher Sexo
  msgt+ $1 15Ex: 9!0Escolher Masculino
  msgbase+ $1
}
alias r-errado { 
  msgt+ $1 9Só cadastramos nicks Registrados!
  msgt+ $1 Registre seu nick e tente cadastrar novamente!
  msgbase+ $1
  close -c $1
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Escolher
;; Escolhe um sexo para anexar ao cadastro
;; ----------------------------------------------------------------------------

alias com_chat_!escolher {
  id.check = nocad
  if ($h?(cad) == 2) {
    var %s = MASCULINO FEMININO
    if (!$1) || (!$istok(masculino feminino,$1,32)) msge Escolha entre os Sexos 12Masculino 15ou 13Feminino15!
    else {
      writeini $dados($nick) $nick nick $nick
      w+ $nick sexo $replace($1,masculino,Masculino,feminino,Feminino)
      w+ $nick Armadura Nenhuma
      w+ $nick Cosmo 100
      w+ $nick Meritos 0
      w+ $nick Stamina 100
      w+ $nick Dinheiro 100
      w+ $nick Itens Adaga $+ $iif($1 == feminino,$chr(44) $+ Máscara)
      w* $nick historico Vitorias 0
      w* $nick historico Derrotas 0
      w* $nick historico Empates 0
      w* $nick historico Narradas 0
      w+ $nick Arm.On Nao
      w+ $nick Tce Nada
      w+ $nick Treino Nada
      w+ $nick id $ctime
      w+ $nick ua $ctime
      msgto #CdzForever 09 $+ $nick 15acaba de se cadastrar no 14,1(9#15Cdz0Fore15ver14)15. Agora estamos com9 $findfile(users,*.ini,0) 15usuários
      msgtopo
      msgt
      msgt 15Você foi0 Cadastrado!15 Para continuar o acesso
      msgt 15no BoT crie sua Senha e se Identifique.
      msgt
      msgt 0Se você ficar Sem Se Identificar no Bot pelo Período
      msgt 0de8 2 meses0, seu cadastro será apagado automaticamente.
      msgt
      msgt 15Agora para proteger seu 4Cadastro15 Digite:
      msgt 9!0Incluir Senha 7<SENHA> 15 Ex:9 !0Incluir Senha 7CdzForever
      msgt
      msgt 15Para ser 0Identificado, 15 Digite 9!0Ident <Sua Senha>
      msgbase
    }
  }
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Incluir Senha
;; Inclui uma senha ao cadastro
;; ----------------------------------------------------------------------------

alias com_chat_!incluir {
  if ($1 != senha) return
  id.check = noident
  if (!$dados($nick,senha)) {
    if (!$2) msgehalt 0Parâmetro Faltando!?Você precisa indicar ma senha!¼8!Incluir Senha <suasenha>
    w+ $nick senha $2
    w+ $nick ident Nao
    msgtopo
    msgt 0+8Sua senha foi registrada com sucesso!0+
    msgt
    msgt 15Sua Senha é:11 $2
    msgt
    msgt 15Guarde ela, pois será sua chave de acesso ao Bot.
    msgdiv
    msgt 0Se você se esquecer de sua senha,
    msgt 0digite: 7@9Minha Senha0,
    msgt 0que ela será encaminhada ao seu 4E-Mail0.
    msgdiv
    msgt 15Para mudar de Senha, digite:
    msgt 7!9Mudar Senha
    msgdiv
    msgt 0Você deve se identificar...
    msgt 0digite: 7!9Ident11 %nomecad
    msgbase
  }
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !SetarEmail <email>
;; Seta o e-mail do usuário no cadastro
;; ----------------------------------------------------------------------------

alias com_chat_!SetarEmail {
  id.check =

  if (!$1) msgehalt Você precisa indicar um e-mail válido!¼Ex: 8!SetarEmail novato@aol.com.br
  var %re = /^(.*?)@(.*?)$/
  if (!$regex($1,%re)) msgehalt E-Mail Inválido!

  var %cod = $left($md5($ctime),5)
  user.perfil.email.set $1
  user.perfil.email.code.set %cod
  mail.send $nick confirmacao $+(c=,%cod)
  msgtopo
  msgt Seu 8e-mail 15foi cadastrado com 0sucesso15!
  msgt 
  xmsgt 0Você receberá um e-mail com um código de ativação. Maiores informações poderão ser encontradas no próprio e-mail.
  msgdiv
  xmsgt Você pode alterar este e-mail a qualquer hora, digitando este mesmo comando
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !ConfirmarEmail <codigo>
;; Confirma o e-mail repassando o código recebido por e-mail
;; ----------------------------------------------------------------------------

alias com_chat_!ConfirmarEmail {
  id.check =

  if (!$user.perfil.email.code) msgehalt Você já confirmou o seu 0e-mail
  if (!$1) msgehalt Você precisa indicar o código de verificação¼8!ConformarMail 14<0código14>
  if ($1 !== $user.perfil.email.code) msgehalt Código de verificação 4inválido

  remini $dados($nick) user emailcode
  msgtopo 
  msgt Você confirmou o seu 0e-mail15 com 9sucesso15! 
  msgbase 
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !SetarTwitter <twitter>
;; Seta um twitter pro cadastro
;; ----------------------------------------------------------------------------

alias com_chat_!setartwitter {
  id.check = 

  if (!$1) msgehalt Você precisa indicar um username válido!¼Ex: 8!SetarTwitter novato
  var %re = /^[0-9a-zA-Z_]+$/
  if ($regex($1,%re)) msgehalt Twitter Inválido!¼Coloque apenas o seu username, com letras, números ou underline

  user.perfil.twitter.set $1
  msgtopo
  msgt Seu 8Twitter 15foi cadastrado com 0sucesso15!
  xmsgt Você pode alterar esta informação a qualquer hora, digitando este mesmo comando
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: chat :: !SetarNasc <data>
;; Seta a data de nascimento do usuário
;; ----------------------------------------------------------------------------

alias com_chat_!setarnasc {
  id.check =

  if ($user.perfil.nascimento) msgehalt Você já setou a sua 9data de nascimento15.¼0Para alterá-la, fale com um operador.
  if (!$1) msgehalt Parâmetro Faltando!¼Digite
  if (!$ctime($1)) msgehalt Data 4Inválida15!

  user.perfil.nascimento.set $date($ctime($1))
  msgtopo
  msgt Você setou a sua 8data de nascimento15!
  msgbase
}
