;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Addon
;; Informações de como obter e instalar o addon do canal
;; ----------------------------------------------------------------------------

alias com_help_!addon return !Addon¼Chat¼!Addon¼Informações de como obter e instalar o addon do #Cdzforever!
alias com_chat_!addon {
  msgtopo
  msgt 0SaintSeiya 14::0 Addon
  msgdiv
  msgt O 0addon 15pode ser encontrado no link abaixo:
  msgt
  msgt 8www.cdzforever.net/addon
  msgdiv
  msgt 0Para carregar o addon, siga os seguintes passos:
  msgt
  msgl 091.15 Descompacte-o na pasta do mirc
  msgl 092.15 Digite 8//load -rs $chr(36) $+ sfile( $+ $chr(36) $+ mircdir) 15na tela do mirc
  msgl 093.15 Procure pelo arquivo 8CdzForever.Addon.mrc 15e clique 2x
  msgl
  msgt 0O seu addon está instalado, para acessá-lo:
  msgt
  msgl 094.15 Clique com o 0botão direito 15em uma janela qqr do mirc
  msgl 095.15 Vá em 08#Cdzforever 2011
  msgt
  msgt Os comandos a partir deste ponto são 0auto-explicativos14 :)
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Help <atu/op/admin>
;; Mostra a ajuda para comandos de operador do canal
;; ----------------------------------------------------------------------------

alias com_help_!help return !Help¼Chat¼!Help <atu/op/admin>¼Mostra a ajuda para comandos de operador do canal
alias com_chat_!help {
  if ($1 == Atu) {
    op.check + =
    msgtopo 
    msgt 0Ajuda para 8Atualizador
    msgt 8¯¯¯¯¯ ¯¯¯¯ 0¯¯¯¯¯¯¯¯¯¯¯
    msgt 15Lutas 1x1
    msgt 14¯¯¯¯¯ ¯¯¯
    msgl 7!9luta8<Nível> 11<Vencedor> <Perdedor> <Narrador>
    msgl 7!9luta8WO 11<Vencedor> <Perdedor> <Narrador>
    msgl 4.15Atualiza uma luta como 8W15.8O
    msgt 
    msgt 15Lutas 2x1
    msgt 14¯¯¯¯¯ ¯¯¯
    msgl 7!9luta8<Nível> 11<Venc.>0,11<Venc.> <Perd.> <Narrador>
    msgl 4.15Atualiza vitória da Dupla sobre o Individual.
    msgl 7!9luta8<Nível> 11<Venc.> <Perd.>0,11<Perd.> <Narrador>
    msgl 4.15Atualiza vitória do Individual sobre a Dupla.
    msgdiv
    msgl 8Níveis de Lutas:
    msgl 8F14 - 0Para vitória 8Fácil0.
    msgl 8M14 - 0Para vitória 8Média0.
    msgl 8D14 - 0Para vitória 8Difícil0.
    msgl 8E14 - 0Para 8Empate0.
    msgdiv
    msgl 7!9Confirmar
    msgl 14¯¯¯¯¯¯¯¯¯14,1415,1 Confirma as atualizações.
    msgl 7@9Cancelar
    msgl 14¯¯¯¯¯¯¯¯¯14,1415,1 Cancela as atualizações. | msgbase | Halt
  }
  if ($1 == Op) {
    op.check @ =
    msgtopo 
    msgt 0Ajuda para 4Operador
    msgt 4¯¯¯¯¯ ¯¯¯¯ 0¯¯¯¯¯¯¯¯
    msgt 15Canal
    msgt 14¯¯¯¯¯
    msgl 7!9op 14-0 Você receberá OP.
    msgl 7!9voice14 -0 Você receberá Voice.
    msgl 7!9op 11<nick>14 -0 Você dará OP para outro.
    msgl 7!9voice 11<nick>14 -0 Você dará Voice para outro.
    msgl 7!9kick 11<nick> 8<motivo>14 -0 kicka o user e justifica.
    msgl 7!9kb 11<nick> 8<motivo>14 -0 kicka e Bane em seguida o user.
    msgt 
    msgt 15SaintSeiya Access
    msgt 14¯¯¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯
    msgl 7@9AddAtuTemp 11<nick> 14-0 Adiciona atualizador temporário.
    msgl 7@9RemAtuTemp 11<nick> 14-0 Remove atualizador temporário.
    msgt
    msgt 15Armaduras
    msgt 14¯¯¯¯¯¯¯¯¯
    msgl 7@9Set 11<nick> 14-0 Adiciona armadura após solicitação.
    msgl 7!9Delarm 11<nick> 14-0 Remove a armadura do dono.
    msgl 7!9Confirmardel 14-0 Confirma a remoção.
    msgl 7!9Cancelar 14-0 Cancela uma solicitação.
    msgl 7!9Status 11<armadura> 14-0 Verifica o status da armadura.
    msgl 7@9Retirar Armadura 11<nick> 14-0 Retira Armadura Invocada.
    msgl 7!9SetEve 11<Título> 14-0 Setar Evento.
    msgl 7!9DelEve 14-0 Deletar Evento.
    msgbase
  }
  if ($1 == Admin) {
    op.check ! =
    .msg =$Nick 0,0 0,0 0,0 1,11,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|14,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯14,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,10Help Adm114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9SetDin 11<Nick>8 <Valor>14 -15 Você dará dinheiro a alguém.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9Deldin 11<Nick>8 <Valor>14 -15 Você tira dinheiro de alguém.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9Additem 11<Nick>8 <Item>14 -15 Adiciona um item.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9Delitem 11<Nick>8 <Item>14 -15 Remove um item.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9Confir 11<Nick>8 <Item>14 -15 Confirma a remoção.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|14,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯14,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9Akick 11<Nick/Host>8 <Motivo>14 -15 Adiciona alguém na 114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,115SaintSeiya Akick.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9RemAkick 11<Nick/Host>14 -15 Remove alguém da 114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,115 SaintSeiya Akick. 114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17!9Listar Akick14 -15 Mostra a SaintSeiya Akick List. 114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|14,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯14,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17@9AddOper 11<Nick>14 -15 Adiciona como Operador.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17@9AddAdm 11<Nick>14 -15 Adiciona como administrador.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17@9AddAtu 11<Nick>14 -15 Adiciona como atualizador.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,14|1,17@9RemStaff 11<Nick>14 -15 Remove nick da staff.114,14|1,1
    .msg =$Nick 0,0 0,0 0,0 1,114,141,114,141,1
    .msg =$Nick 0,0 0,0 0,0 1,114,114,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
  }
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Ajuda
;; Mostra as seções da ajuda no bot
;; ----------------------------------------------------------------------------

alias com_help_!ajuda return !Ajuda¼Chat¼!Ajuda¼Mostra as seções de ajuda do bot
alias com_chat_!ajuda {
  id.check =
  msgtopo 
  msgt 0Menu de Ajuda
  msgt 7¯¯¯¯ ¯¯ ¯¯¯¯¯
  msgl 9Índice0:
  msgl
  msgl 0(1110) Comandos Básicos.
  msgl 0(1120) Comandos Principais.
  msgl 0(1130) Comandos Extras.
  msgl 0(1140) Comandos relacionados às Armaduras.
  msgl 0(1150) Comandos relacionados às Lutas.
  msgl 0(1160) Comandos relacionados ao Canal.
  msgdiv
  msgt Para selecionar um item do índice,
  msgt digite: 9!14S15el0ect (11nº0)14
  msgt 7Ex: 9!14S15el0ect11 1 
  msgbase 
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Select
;; Seleciona uma seção do help do bot, mostrando os comandos respectivos
;; ----------------------------------------------------------------------------

alias com_help_!select return !Select¼Chat¼!Select <num>¼Seleciona uma seção do help do bot, mostrando os comandos respectivos
alias com_chat_!select {
  tokenize 32 !select $1-
  id.check =
  if ($2 == 1) {
    msgtopo | msgt 0Comandos Básicos
    msgt 7¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯
    msgt 9!14H15o0ra                       12*
    msgt 9!14D15a0ta                       12*
    msgt 9!14N15e0ws                       4*
    msgt 9!14R15e0port                     4*    
    msgt 9!14C15d0zStatus                  8*
    msgdiv
    msgl    4* 14-0 Comando para ser acionado no chat.
    msgl    8* 14-0 Comando para ser acionado no canal.
    msgl    12* 14-0 Comando para ser acionado no chat ou canal.
    msgdiv
    msgt Para saber mais informações de cada comando
    msgt acima, digite14:9 @14I15n0fo <comando>
    msgt 7Ex:14:9 @14I15n0fo !Hora 
    msgbase 
  }
  elseif ($2 == 2) {
    msgtopo | msgt 0Comandos Principais
    msgt 7¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯
    msgt 9!14C15ad0astrar                     4*
    msgt 9!14D15esca0dastrar                  4*
    msgt 9!14I15de0nt <senha>                 4*
    msgt 9!14M15ud0ar Nick                    4*
    msgt 9!14M15ud0ar Senha                   4*
    msgt 9@14M15in0ha Senha                   4*
    msgdiv
    msgl    4* 14-0 Comando para ser acionado no chat.
    msgl    8* 14-0 Comando para ser acionado no canal.
    msgl    12* 14-0 Comando para ser acionado no chat ou canal.
    msgdiv
    msgt Para saber mais informações de cada comando
    msgt acima, digite14:9 @14I15n0fo <comando>
    msgt 7Ex:14:9 @14I15n0fo !Cadastrar 
    msgbase 
  }
  elseif ($2 == 3) {
    msgtopo 
    msgt 0Comandos Extras
    msgt 7¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯
    msgt 9!14T15o0p                     4*
    msgt 9!14T15r0einos                 4*
    msgt 9!14L15o0ja                    4*
    msgt 9!14M15é0ritos                 4*
    msgt 9!14F15a0q                     12*
    msgt 9!14A15d0don                   12*
    msgt 9!14B15an0co                   4*
    msgt 9!14A15pro0veitamento          4*
    msgdiv
    msgl    4* 14-0 Comando para ser acionado no chat.
    msgl    8* 14-0 Comando para ser acionado no canal.
    msgl    12* 14-0 Comando para ser acionado no chat ou canal.
    msgdiv
    msgt Para saber mais informações de cada comando
    msgt acima, digite14:9 @14I15n0fo <comando>
    msgt 7Ex:14:9 @14I15n0fo !Top 
    msgbase 
  }
  elseif ($2 == 4) {
    msgtopo 
    msgt 0Comandos relacionados às Armaduras
    msgt 7¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯¯¯¯
    msgt 9!14A15rm0aduras                     4*
    msgt 9!14I15nv0ocar armadura              8*
    msgt 9!14R15et0irar armadura              8*
    msgt 9!14C15on0sertar armadura            4*
    msgt 9!14I15nf0o <armadura>               4*
    msgt 9!14L15i0vres <classe>               4*
    msgt 9!14L15i0fe armadura                 8*
    msgt 9@14L15if0e armadura <nick>          8*
    msgt 9@14D15es0fazer armadura             4*
    msgt 9@14C15la0sses armaduras             4*
    msgdiv
    msgl    4* 14-0 Comando para ser acionado no chat.
    msgl    8* 14-0 Comando para ser acionado no canal.
    msgl    12* 14-0 Comando para ser acionado no chat ou canal.
    msgdiv
    msgt Para saber mais informações de cada comando
    msgt acima, digite14:9 @14I15n0fo <comando>
    msgt 7Ex:14:9 @14I15n0fo !Armaduras 
    msgbase 

  }
  elseif ($2 == 5) {
    msgtopo 
    msgt 0Comandos relacionados às Lutas
    msgt 7¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯
    msgt 9!14A15ur0a                              8*
    msgt 9!14D15ad0os                             4*
    msgt 9!14E15le0var aura <nível>               8*
    msgt 9!14E15xp0andir Cosmo                    11*
    msgt 9!14S15en0tidos                          4*
    msgt 9@14D15ad0os <nick>                      4*
    msgt 9@14A15ur0a <nick>                       8*
    msgt 9@14E15nv0iar <nick>                     12*
    msgt 9@14E15le0var <nick> aura <nível>        8*
    msgt 9+14A15ur0a                              8*
    msgt 9+14A15ur0a <nick>                       8*
    msgt 9!14A15tu0alizadores Online              8*
    msgdiv
    msgl    4* 14-0 Comando para ser acionado no chat.
    msgl    11* 14-0 Comando para ser acionado nos canais de luta.
    msgl    8* 14-0 Comando para ser acionado no canal.
    msgl    12* 14-0 Comando para ser acionado no chat ou canal.
    msgdiv
    msgt Para saber mais informações de cada comando
    msgt acima, digite14:9 @14I15n0fo <comando>
    msgt 7Ex:14:9 @14I15n0fo !Aura 
    msgbase 

  }
  elseif ($2 == 6) {
    msgtopo 
    msgt 0Comandos relacionados ao Canal
    msgt 7¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯
    msgt 9!14S15t0aff                     4*
    msgt 9!14R15eg0ras                    4*
    msgt 9!14A15vis0os                    4*
    msgt 9!14P15arcer0ias                 4*
    msgdiv
    msgl    4* 14-0 Comando para ser acionado no chat.
    msgl    8* 14-0 Comando para ser acionado no canal.
    msgl    12* 14-0 Comando para ser acionado no chat ou canal.
    msgdiv
    msgt Para saber mais informações de cada comando
    msgt acima, digite14:9 @14I15n0fo <comando>
    msgt 7Ex:14:9 @14I15n0fo !Dados
    msgbase 
  }
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Treinos
;; Lista com as regras básicas para o bom andamento do canal
;; ----------------------------------------------------------------------------

alias com_help_!treinos return !Treinos¼Chat¼!Treinos¼Comando para listar os treinos disponíveis no bot
alias com_chat_!treinos {
  id.check = nocad
  msgtopo
  msgt 0BEM VINDOS A SEÇÃO DE TREINOS!
  msgt 15¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1
  msgl 0Existem4 50 tipos diferentes de treinos:
  msgt
  msgl 9!0Treinar 12(0Treino Simples para iniciantes 14*Aura <11 10x14*12)
  msgl 9!0Santuário 12(0Treino rigoroso com os mestres de ouro12)
  msgl 9!0Treinar Asgard 12(0Treino rigoroso com Guerreiros Deuses12)
  msgl 9!0Treinar Marinas 12(0Treino com os Generais Marinass12)
  msgl 9!0Treino com Equipamento 12(0Treino solo com ajuda de equips12)
  msgt
  msgt 4OBS0: Os Treinos são diários, ou seja, realizados somente uma vez por dia, e com tempo determinado no treino.
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Regras
;; Lista com as regras básicas para o bom andamento do canal
;; ----------------------------------------------------------------------------

alias com_help_!regras return !Regras¼Chat¼!Regras¼Lista com as regras básicas para o bom andamento do canal
alias com_chat_!regras {
  id.check = nocad
  msgtopo
  msgt SaintSeiya 14::0 Regras 
  msgdiv
  msgt As regras foram feitas propriamente para auxiliar no controle do canal, evitando contra-tempos que possam atrapalhar no nosso bom desempenho.
  msgt
  msgl 00Agora veja as Regras
  msgl 14¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  msgl 14»0 Não faça spam (Propaganda)
  msgl 14»0 Não faça Flood's.
  msgl 14»0 Não peça @.
  msgl 14»0 Não ofenda ninguem.
  msgl 14»0 Não use clones.
  msgl 14»0 Não se aproveite de possíveis bug do bot.
  msgl 14»0 Não use addon de outros canais.
  msgl 14»0 É proibido o uso de remotes que beneficiem injustamente 
  msgl 14 0 o usuário, como por exemplo remotes para responder 
  msgl 14 0 automaticamente a comandos do bot com intuito de
  msgl 14 0 ganhar recompensa.
  msgl 14»0 A conta é pessoal e intransferível, o que significa que
  msgl 14 0 não pode ser passada para outro usuário "logar",
  msgl 14 0 "treinar" ou "lutar" com ela enquanto o dono real não 
  msgl 14 0 acessa o canal.
  msgl 14»0 Não deve-se colar perguntas do quiz no canal. O 
  msgl 14 0 objetivo do quiz é premiar o conhecimento do usuário, 
  msgl 14 0 colar a pergunta no canal elimina o fator surpresa :).
  msgt
  msgt 8Como punição para o desrespeito das regras acima, os operadores estão autorizados a penalizar com perda de cosmo, méritos, prisão da conta e banimento do canal.
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Avisos
;; Avisos básicos do bot
;; ----------------------------------------------------------------------------

alias com_help_!Avisos return !Avisos¼Chat¼!Avisos¼Mostra alguns avisos básicos para usuários iniciantes no canal
alias com_chat_!Avisos {
  id.check = nocad
  msgtopo 
  msgt 14,1A15v0isos
  msgt 7,1¯¯¯¯¯¯
  msgdiv
  msgt 0Aqui vai alguns avisos muito importantes para deixá-lo ciente de fatos e acontecimentos em geral ocorrem com frequência no canal.
  msgt
  msgl    00Agora veja os avisos:
  msgl    14¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
  msgl 14»0 Todos os comandos começam sempre com "!", "@" ou "+".
  msgl 14»0 Esse bot não é de auto-lutas.
  msgl 14»0 Não troque de nick quando estiver dentro do chat.
  msgl 14»0 Não saia do canal se você tiver em treinamento.
  msgl 14»0 Não lute e treine ao mesmo tempo.
  msgl 14»0 O cadastrado adquire armadura a partir da Aura 2X.
  msgl 14»0 Rpg's e torneios só em finais de semana.
  msgl 14»0 As batalhas acontecem nos canais auxiliares.
  msgt
  msgt 8Obs:.0 Seguindo esses passos dificilmente você terá problemas de adaptação no nosso sistema.
  msgbase
}

;; ----------------------------------------------------------------------------
;; Comando :: Chat :: !Sentidos
;; Mostra todos os sentidos disponíveis no bot
;; ----------------------------------------------------------------------------

alias com_help_!sentidos return !Sentidos¼Chat¼!Sentidos¼Lista os sentidos e o cosmo necesário para alcançá-lo
alias com_chat_!sentidos {
  id.check = nocad
  msgtopo 
  msgt 14,1S15ent0idos
  msgt 7,1¯¯¯¯¯¯¯¯
  msgt 14"15O Mérito do Cavaleiro não está na sua Armadura e
  msgt 15sim na sua cosmo-energia.14"
  msgr 11Mú de Áries     
  msgr 10¯¯ ¯¯ ¯¯¯¯¯     
  msgt 0Para ver a info de um determinado sentido, digite:
  msgt
  msgt 14»0 6º Sentido10«_____________»19!006º Sentido
  msgt 14»0 7º Sentido10«_____________»19!007º Sentido
  msgt 14»0 8º Sentido10«_____________»19!008º Sentido
  msgt 14»0 9º Sentido10«_____________»19!009º Sentido
  msgbase
}
