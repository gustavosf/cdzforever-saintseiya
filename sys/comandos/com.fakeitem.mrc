alias com_all_!fakeitem { 
  id.check | op.check @
  if (!$3) || ($1 != add) && ($1 != del) { noticen Sintaxe !Fakeitem <add/del> <nick> <item> | halt }  
  if ($dados($2,nick) == $null) { noticen 09 $+ $2 15não está cadastrado | halt } 
  if ($loja($3-,pizza)) { noticen 09 $+ $3- 15é um item valido, não pode ser adicionado/deletado por esse comando | halt }
  if ($1 == add) { 
    w+ $2 itens $dados($2,itens) $+ , $3-
    noticen O item 09 $+ $3- 15foi adicionado para09 $2 
    noticen 09 $+ $2 15possui agora os seguintes itens08 $dados($2,itens)
  }
  if ($1 == del) { 
    if (!$istok($dados($2,itens),$chr(32) $+ $3-,44)) { noticen 09 $+ $2 15não possui o item09 $3- | halt }
    w+ $2 itens $remtok($dados($2,itens),$+($chr(32),$3-),1,44)
    noticen O item 09 $+ $3- 15foi removido de09 $2 
    noticen 09 $+ $2 15possui agora os seguintes itens08 $dados($2,itens)
  } 
  write $mircdirsys/logs/fakeitem.log $date $time -- $1 -- $2 -- $3- -- $nick
}
