;; ----------------------------------------------------------------------------
;; Alias :: Varrer <tipo>
;; Limpa o banco de dados de usuários, deixando apenas os ativos
;; Adicionalmente remove as armaduras de usuários inativos
;; ----------------------------------------------------------------------------
;; Uso: /Varrer <1/2/3>
;;      1 = Armaduras
;;      2 = Cadastros
;;      3 = Ambos (padrão)
;; ----------------------------------------------------------------------------

alias varrer {
  var %oper = $iif($1,$1,3)
  var %ison = $iif($me ison #cdzforever,1,0)

  if (%ison) msgto #cdzforever Iniciando a 14varredura 15por cadastros 8Inativos 15no bot14...

  var %x = $findfile(users,*.ini,0),%z = 0,%z2 = 0

  var %limit.arm = $calc($ctime - 1209600)
  var %limit.cad = $calc($ctime - 5184000)

  var %aposentados,%arms.lib,%n,%arm
  var %delay = 1

  while (%x) {
    dll.whilefix
    ;; evita do bot travar com loops muito grandes - dvl
    %n = $remove($nopath($findfile(users,*.ini,%x)),.ini)
    %arm = $dados(%n,armadura)
    if ($dados(%n,imune) != Sim) {
      ;; verifica se eh pra varrer as armaduras
      if ($isbit(%oper,1)) {
        if (%limit.arm > $iif($dados(%n,ua),$v1,$dados(%n,dc))) && (%arm != Nenhuma) {
          writeini $dados(%n) %n armadura Nenhuma
          remini $dados(%n) %n hp.arm 
          remini $dados(%n) %n hp.rec
          writeini $dados(%n) %n arm.on Nao
          writeini $arms.path $arms.prepare(%arm) Nick Nenhum
          writeini $arms.path $arms.prepare(%arm) liberada Sim
          write $logs(varrer.arm) $+(%n,@,%arm,@,$ctime)
          %arms.lib = $addtok(%arms.lib,%arm,44)
          inc %z
        }
      }
      if ($isbit(%oper,2)) {
        if (%limit.cad > $dados(%n,ua)) {
          .copy -o $dados(%n) $+(users2\,%n,.ini) | .remove $dados(%n)
          if (%ison) {
            %aposentados = $addtok(%aposentados,%n,44)
            if ($len(%aposentados) > 330) {
              .timer 1 %delay msgto #CdzForever 0Os Cavaleiros08 %aposentados 0foram 15aposentados 0por não acessar o bot por mais de 092 Meses
              inc %delay 5
              var %aposentados
            }
            inc %z2
          }
        }
      }
    }
    dec %x
  }
  if (%ison) {
    if ($isbit(%oper,1)) {
      if (!%z) msgto #cdzforever 8Nenhum 0Cavaleiro teve a sua armadura 15retirada0.
      if (%z = 1) msgto #cdzforever 08 $+ %z 0Cavaleiro teve a sua armadura 15retirada0.
      if (%z > 1) msgto #cdzforever 08 $+ %z 0Cavaleiros tiveram as suas armaduras 15retiradas0.
      if (%arms.lib) msgto #cdzforever Armaduras08 $replace(%arms.lib,$chr(44),15 $+ $chr(44) $+ 08 ) 15foram 0liberadas 15por falta de uso.
    }
    if ($isbit(%oper,2)) {
      if (!%z2) msgto #cdzforever 8Nenhum 0Cavaleiro foi 15aposentado14 ;P
      else {
        if (%aposentados) .timer 1 %delay msgto #CdzForever 0Os Cavaleiros08 %aposentados 0foram 15aposentados 0por não acessar o bot por mais de 092 Meses
        if (%z2 = 1) .timer 1 %delay .msgto #cdzforever 08 $+ %z2 0Cavaleiro foi  15aposentado0.
        if (%z2 > 1) .timer 1 %delay .msgto #cdzforever 08 $+ %z2 0Cavaleiros foram 15aposentados0.
      }
    }
  }
}
