on *:chat:*: {
  if $strip($1) = !livres {
    id.check =
    if $istok(S A B C D,$strip($2),32) {
      var %x = 1,%arm,%mundo,%a,%l,%t = 0
      if $hget(arms) { hfree arms }
      while %x <= $ini(armaduras.ini,0) {
        %arm = $ini(armaduras.ini,%x)
        if ($readini(armaduras.ini,%arm,nick) == nenhum) && ($readini(armaduras.ini,%arm,classe) == $strip($2)) { 
          %mundo = $readini(armaduras.ini,%arm,mundo)
          hadd -m arms %mundo $addtok($hget(arms,%mundo),%arm,44)
        }
        inc %x
      }

      msgtopo | msgt 0Lista das Armaduras Livres | msgt 14-08 Classe $upper($strip($2)) 14-
      var %x = 1
      while %x <= 6 { 
        %a = $hget(arms,$replace(%x,1,Sekai,2,Kaikai,3,Meikai,4,Makai,5,Tenkai,6,Olimpo))
        if %a {
          inc %t
          msgdiv | msgt 9 $+ $replace(%x,1,S  E  K  A  I,2,K  A  I  K  A  I,3,M  E  I  K  A  I,4,M A K A I,5,T  E  N  K  A  I,6,O  L  I  M  P  O) | msgt 14¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
          while %a { %l = $spc($readini(armaduras.ini,$gettok(%a,1,44),arm),22) $+ $iif($readini(armaduras.ini,$gettok(%a,1,44),liberada) == sim,00,11) $+ $readini(armaduras.ini,$gettok(%a,1,44),arm)       $iif($readini(armaduras.ini,$gettok(%a,2,44),liberada) == sim,00,11) $+ $readini(armaduras.ini,$gettok(%a,2,44),arm) | msgl 0  %l | %a = $deltok(%a,1-2,44) }
        }
        inc %x
      }
      if !%t { msgdiv | msgt 9Nenhuma 15Armadura está livre para a 0Classe 15selecionada }
      else {
        msgdiv | msgt 0,11 11,1 Bloqueada     0Liberada 0,0 0,1  | msgdiv
        msgt Para ver 0informações 15sobre alguma dessas armaduras
        msgt Digite 9!Info 14<0Armadura14>
        msgt Ex: 11!Info Pégaso
      }
      msgbase
    }
    else { 
      msgtopo | msgt 4Erro | msgt As 0Classes 15disponíveis são: 9S15, 9A15, 9B15, 9C 15e 9D 
      msgt Sintaxe: 11!Livres 14<0Classe14> /15 Exemplo: 11!Livres 0S | msgbase
    }
  }
}
