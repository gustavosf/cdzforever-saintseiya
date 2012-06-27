;; ----------------------------------------------------------------------------
;; Comando :: chat :: @desfazer armadura
;; Se desfaz de uma armadura. Remove a armadura
;; ----------------------------------------------------------------------------

alias com_help_!descadastrar return !Descadastrar¼Chat¼!Descadastrar <senha>¼Comando para remover o seu cadastro do bot.½4Uma vez usado este comando, o seu chat é fechado e o seu cadastro é excluído do sistema.
alias com_chat_!descadastrar {
  id.check =
  if (!$1) msgehalt Para se descadastrar, você deve digitar 11!Descadastrar <senha>15, onde 0<senha>15 é a sua 0senha de acesso 15ao bot.¼ ¼4AO DIGITAR ESTE COMANDO VOCÊ ESTARÁ REMOVENDO O SEU CADASTRO DO BOT
  if ($user.senha !== $1) msgehalt Senha 4incorreta15!
  if ($user.armadura != Nenhuma) {
    msgto #CdzForever A Armadura de9 $v1 15está vaga a partir de agora!
    user.armadura.remove
  }
  .copy -o $+(users/,$nick,.ini) $+(users2/,$nick,.ini)
  .remove users/ $+ $nick $+ .ini 
  .unset %arm
  msgtopo
  msgt Seus dados foram 4 deletados15 dos arquivos do #CdzForever
  msgbase
  close -c $nick
}
