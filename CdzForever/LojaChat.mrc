alias com_chat_@comprar {
  id.check =
  var %item = $capitalize($1-)
  var %preco = $loja(%item,compra)
  if (!%item) msge Item08 %item 15não existe!
  elseif (!%preco) msge Item08 %item 15não pode ser adquirido através de 0dinheiro15!
  elseif (%preco > $user.dinheiro.get) msge 0Você não tem dinheiro suficiente para comprar9 %item $+ 0!¼ ¼Para tal é necessário desembolsar um total de 8$ $+ $div(%preco)
  else {
    user.dinheiro.retrieve %preco
    user.item.add $nick %item
    msgtopo
    msgt 0Você adquiriu o ítem9 %item $+ 0!
    msgt
    msgt Você ficou com 08$ $+ $div($user.dinheiro.get) 15de dinheiro!
    msgbase
  }
}
alias com_chat_@vender {
  id.check =
  if ($istok(%narrador %lutador1 %lutador2 %lutador3,$nick,32)) { msge Você não pode vender itens durante uma Atualização de Luta! | halt }
  var %vendendo = $hget($nick,venda)
  var %item = $capitalize($iif(%vendendo,$v1,$1-))
  if ($user.item.has($nick,%item)) {
    if (%vendendo) {
      user.item.consume $nick %item
      user.dinheiro.add $loja(%item,venda)
      h- venda
      msgtopo
      msgl 9Venda:15 Você 0vendeu 15o ítem9 %item 15por 8$ $+ $div($loja(%item,venda)) $+ 15!
      msgl         Você está agora com 8$ $+ $div($user.dinheiro.get) $+ 15.
      msgbase
    }    
    elseif ($loja(%item,venda)) {
      h+ venda %item
      msgtopo
      msgl 9Venda:15 Para confirmar a venda, digite 11@Vender
      msgl  8Item:0 %item 14(15Valor: 8$ $+ $loja(%item,venda) $+ 14)
      msgbase
    }
    else msge Este ítem 4não pode ser vendido 15para o bot!
  }
  elseif (!$1) msge Você precisa indicar um 0ítem 15para 9vender15!¼ ¼Uso: 8@Vender <item>
  else msge Você não possui o ítem¼08 $+ %item
}
