;; ----------------------------------------------------------------------------
;; Comando :: chat :: !Info <item/armadura/comando/etc>
;; Agragador de informações quanto a várias coisas do bot :)
;; Usa como [com_aux_!info.comando], [com_aux_!info.fc], [com_aux_!info.item], 
;; [com_aux_!info.armadura] e [com_aux_!info.golpe] como auxiliar
;; ----------------------------------------------------------------------------
alias com_chat_@info com_chat_!info $1-
alias com_chat_!info {
  if (!$1) msgehalt Este comando exige um 0segundo parâmetro15!¼Use 8!Info <item/armadura/comando/etc>

  if ($left($1,2) == FC) com_aux_!info.fc $1-
  elseif ($item($1-)) com_aux_!info.item $1-
  elseif ($arms.nome($1-)) com_aux_!info.armadura $1-
  elseif ($golpe($1-)) com_aux_!info.golpe $1-
  elseif ($isalias($+(com_help_,$replace($1-,$chr(32),_)))) com_aux_!info.comando $+(com_help_,$replace($1-,$chr(32),_))
}

;; ----------------------------------------------------------------------------
;; Auxiliar :: com_chat_!info
;; Mostra informações acerca de um comando do bot, que tenha o help em alias
;; ----------------------------------------------------------------------------

alias com_aux_!info.comando {
  var %help = [ $ [ $+ [ $1- ] ] ]
  msgtopo
  msgt 0SaintSeiya 14::0 Info
  msgt 08 $+ $gettok(%help,1,188)
  msgt
  msgtd
  msgtd 0Onde Usar?09 $gettok(%help,2,188)
  msgtd
  msgt
  var %msg = $gettok(%help,4,188)
  while (%msg) {
    xmsgt 00 $+ $gettok(%msg,1,189)
    %msg = $deltok(%msg,1,189)
  }
  msgbase
}

;; ----------------------------------------------------------------------------
;; Auxiliar :: com_chat_!info
;; Mostra informações acerca de uma ficha criminal
;; ----------------------------------------------------------------------------

alias com_aux_!info.fc { 
  var %fc = $mid($1,3)
  var %ficha = $read(sys/criminal.txt,w,$1 $+ ¼*)
  if (%ficha) {
    msgtopo
    msgt 0SaintSeiya 14::0 Delegacia
    msgt 4Passagem Criminal de $gettok(%ficha,3,188)
    msgdiv
    msgt         _______                .,-------_        
    msgt        /       \             ./          \       
    msgt       /         \           /             \      
    msgt      /___, : .___\         /       ,    _  )     
    msgt     _) >=-( )-=< (_       |       /( :  \=<(     
    msgt    ( (    / \    ) )      |      (< |;      \    
    msgt     \_\  ((_))  /_/        \    : `      ,(._)   
    msgt       |)/  :  \(|           `.           / _\    
    msgt       |(,-----.)|             \,        \  /     
    msgt       \   '"`   /               \   \______)     
    msgt       |`---"---'|               |       /        
    msgt       |   `-'   |               |       )        
    msgt
    msgt 04        FC- $+ %fc                  FC- $+ %fc         
    msgdiv
    msgt 0Crime
    xmsgt $gettok(%ficha,4,188)
    msgt
    msgt 0Punição
    xmsgt $gettok(%ficha,5,188)
    msgt
    msgt Referendado em08 $date($gettok(%ficha,2,188)) 15através da 0reunião galáctica
    msgbase
  }
}

;; ----------------------------------------------------------------------------
;; Auxiliar :: com_chat_!info
;; Mostra informações acerca de um ítem
;; ----------------------------------------------------------------------------

alias com_aux_!info.item {
  msgtopo
  msgt 0SaintSeiya 14::0 Informações 
  msgt $item($1-)
  msgdiv
  msgl                  Categoria 0,14  9,1 $item($1-).categoria
  msgl          Forma de Adquirir 0,14  8,1 $item($1-).forma
  msgl      Necessário para o uso 0,14  11,1 $item($1-).aura
  msgl                 Consumível 0,14  0,1 $iif($item($1-).consumivel,Sim,Não)
  msgt 14______________________
  msgt
  msgt 14-0 Descrição 14-
  xmsgt $item($1-).desc
  msgbase
}

;; ----------------------------------------------------------------------------
;; Auxiliar :: com_chat_!info
;; Mostra informações acerca de uma armadura
;; ----------------------------------------------------------------------------

alias com_aux_!info.armadura {
  msgtopo
  msgt 0SaintSeiya 14::0 Informações 
  msgt $arms.nome($1-)
  msgdiv
  var %c = $replace($arms.mundo($1-),sekai,7,meikai,4,makai,6,kaikai,12,tenkai,11,olimpo,8)
  msgl                  Categoria 0,14  9,1 $arms.categoria($1-)
  msgl                     Classe 0,14  8,1 $arms.classe($1-)
  msgl                      Mundo 0,14   $+ %c $+ ,1 $arms.mundo($1-)
  msgl                       Dono 0,14  0,1 $arms.dono($1-)
  msgdiv
  msgt 8Golpes
  msgt $iif($arms.golpes($1-),$v1,Desconhecidos)
  if ($arms.extra($1-)) {
    var %e = $v1
    msgt
    msgt 11Item Acoplado e/ou Característica
    msgt %e
  }
  msgbase
}

;; ----------------------------------------------------------------------------
;; Auxiliar :: com_chat_!info
;; Mostra informações acerca de um golpe
;; ----------------------------------------------------------------------------

alias com_aux_!info.golpe {
  msgtopo
  msgt 00SaintSeiya 14::00 Informações
  msgt $golpe($1-)
  msgdiv
  var %i = 1,%g
  while ($read($golpes.path,w,*@ $+ $1- $+ @*,%i)) {
    %g = $v1
    msgl                   Armadura 0,14  8,1 $gettok(%g,1,64)
    msgl   Aura necessária para uso 0,14  9,1 $gettok(%g,3,64)
    msgl                  Categoria 0,14  11,1 $arms.categoria($gettok(%g,1,64))
    msgl
    %i = $readn + 1
  }
  msgt 14_______________________
  msgt
  msgt 14-00 Descrição 14-
  msgt $gettok(%g,4,64)
  msgbase
}
