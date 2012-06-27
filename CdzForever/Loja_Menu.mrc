on *:chat:*: {
  if $strip($1-) = !Equip Comuns {
    id.check =
    msgtopo | msgt 0Equipamentos
    msgt 7¯¯¯¯¯¯¯¯¯¯¯¯
    msgl     0Itens0                    0Dinheiro0          0Méritos0
    msgl     9¯¯¯¯¯9                    11¯¯¯¯¯¯¯¯8          8¯¯¯¯¯¯¯0
    msgl 0Bomba de Fumaça      7* 15C:11  2.500 14|15 V:4    500 7* 8   -   
    msgl 0Nunchaku Cortante    7* 15C:11  3.500 14|15 V:4  1.000 7* 8   -   
    msgl 0Machado de Batalha   7* 15C:11 15.000 14|15 V:4  7.500 7* 8   -   
    msgl 0Asas de Prata        7* 15C:11 15.000 14|15 V:4  7.500 7* 8   -   
    msgl 0Anel de Nibelungo    7* 15C:11    -   14|15 V:4    -   7* 8   -   
    msgl 0Tridente de Ouro     7* 15C:11    -   14|15 V:4    -   7* 8 50.000
    msgl 0Nunchaku de Ouro     7* 15C:11    -   14|15 V:4    -   7* 8 50.000
    msgl 0Tonfá de Ouro        7* 15C:11    -   14|15 V:4    -   7* 8 50.000
    msgl 0Barra Tripla de Ouro 7* 15C:11    -   14|15 V:4    -   7* 8 50.000
    msgl 0Escudo de Ouro       7* 15C:11    -   14|15 V:4    -   7* 8 50.000
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comprar11 <Equip>14 -0 Para Comprar um Equipamento.
    msgl 7@9Vender 11 <Equip>14 -0 Para Vender um Equipamento.
    msgdiv
    msgl 8Méritos
    msgl 0¯¯¯¯¯¯¯
    msgl 7!9Trocar Item11 <Equip>14 -0 Trocar Mérito por Equipamento.
    msgdiv
    msgl 7!9Info11 <Equip>14 -0 Para Informações de um Equipamento.
    msgbase
  }
  if $strip($1-) = !Poções {
    id.check =
    msgtopo | msgt 0Poções
    msgt 7¯¯¯¯¯¯
    msgl     0Itens0                    0Dinheiro0          0Méritos0
    msgl     9¯¯¯¯¯9                    11¯¯¯¯¯¯¯¯8          8¯¯¯¯¯¯¯0
    msgl 0Poção Revitalizadora 7*15 C:11 10.000 14|15 V:4  5.000 7*8    -    
    msgl 0Poção de Cosmos      7*15 C:11 10.000 14|15 V:4  5.000 7*8    -   
    msgl 0Poção Demoníaca      7*15 C:11 20.000 14|15 V:4 10.000 7*8    -   
    msgl 0Poção Divina         7*15 C:11 40.000 14|15 V:4 20.000 7*8    -   
    msgl 0Poção Suprema        7*15 C:11 20.000 14|15 V:4 10.000 7*8    -   
    msgl 0Poção Mitológica     7*15 C:11   -    14|15 V:4    -   7*8  42.000
    msgl 0Sangue Dourado       7*15 C:11   -    14|15 V:4    -   7*8    -   
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comprar11 <Poção>14 -0 Para Comprar uma Poção.
    msgl 7@9Vender11  <Poção>14 -0 Para Vender uma Poção.
    msgdiv
    msgl 8Méritos
    msgl 0¯¯¯¯¯¯¯
    msgl 7!9Trocar Item11 <Poção>14 -0 Trocar Mérito por Poção.
    msgdiv
    msgl 7!9Info11 <Poção>14 -0 Para Informações de uma Poção.
    msgbase
  }
  if $strip($1-) = !Equip de Treino {
    id.check =
    msgtopo 
    msgt 0Equipamentos de Treino                  
    msgt 7¯¯¯¯¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯
    msgl     0Itens0                 0Dinheiro0           0Méritos0  
    msgl     9¯¯¯¯¯9                 11¯¯¯¯¯¯¯¯8           8¯¯¯¯¯¯¯0  
    msgl 0Peso 50 Kg    7*15   C:11  50.000 14|15 V:4  25.000 7*8     -     
    msgl 0Peso 100 Kg   7*15   C:11 100.000 14|15 V:4  50.000 7*8     -     
    msgl 0Peso 200 Kg   7*15   C:11 200.000 14|15 V:4 100.000 7*8     -     
    msgl 0Peso 500 Kg   7*15   C:11 500.000 14|15 V:4 250.000 7*8     -     
    msgl 0Peso 1 Ton    7*15   C:11     -   14|15 V:4     -   7*8  110.000  
    msgl 0Peso 2 Ton    7*15   C:11     -   14|15 V:4     -   7*8  220.000  
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comprar11 <Equip>14 -0 Para Comprar um Equipamento.
    msgl 7@9Vender 11 <Equip>14 -0 Para Vender um Equipamento.
    msgdiv
    msgl 8Méritos
    msgl 0¯¯¯¯¯¯¯
    msgl 7!9Trocar Item11 <Equip>14 -0 Trocar Mérito por Equipamento.
    msgdiv
    msgl 7!9Info11 <Equip>14 -0 Para Informações de um Equipamento.
    msgbase
  }
  if $strip($1-) = !Espadas Especiais {
    id.check =
    msgtopo | msgt 0Espadas Especiais
    msgt 7¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯
    msgl      0Itens0                    0Dinheiro0        0Méritos0 
    msgl      9¯¯¯¯¯9                    11¯¯¯¯¯¯¯¯8        8¯¯¯¯¯¯¯0 
    msgl 0Espada de Bronze  7*15 C:11 20.000 14|15 V:4 5.000 7*8      -    
    msgl 0Espada de Prata   7*15 C:11 30.000 14|15 V:4 5.000 7*8      -    
    msgl 0Espada das Trevas 7*15 C:11 30.000 14|15 V:4 5.000 7*8      -    
    msgl 0Espada Balmung    7*15 C:11    -   14|15 V:4   -   7*8      -    
    msgl 0Espada de Sapuris 7*15 C:11 50.000 14|15 V:4 5.000 7*8      -    
    msgl 0Espada de Ouro    7*15 C:11    -   14|15 V:4   -   7*8   50.000  
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comprar11 <Espada>14 -0 Para Comprar uma Espada.
    msgl 7@9Vender 11 <Espada>14 -0 Para Vender uma Espada.
    msgdiv
    msgl 8Méritos
    msgl 0¯¯¯¯¯¯¯
    msgl 7!9Trocar Item11 <Espada>14 -0 Trocar Mérito por Espada.
    msgdiv
    msgl 7!9Info11 <Espada>14 -0 Para Informações de uma Espada.
    msgbase
  }
  if $strip($1-) = !Espadas Elementais {
    id.check =
    msgtopo | msgt 0Espadas Elementais
    msgt 7¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯
    msgl       0Itens0                0Dinheiro0          0Méritos0  
    msgl       9¯¯¯¯¯9                11¯¯¯¯¯¯¯¯8          8¯¯¯¯¯¯¯0  
    msgl 0Espada da Terra  7*15 C:11 10.000 14|15 V:4 5.000 7*8      -
    msgl 0Espada da Água   7*15 C:11 10.000 14|15 V:4 5.000 7*8      -
    msgl 0Espada do Ar     7*15 C:11 10.000 14|15 V:4 5.000 7*8      -
    msgl 0Espada do Gelo   7*15 C:11 10.000 14|15 V:4 5.000 7*8      -
    msgl 0Espada do Trovão 7*15 C:11 10.000 14|15 V:4 5.000 7*8      -
    msgl 0Espada do Fogo   7*15 C:11 10.000 14|15 V:4 5.000 7*8      -
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comprar11 <Espada>14 -0 Para Comprar uma Espada.
    msgl 7@9Vender 11 <Espada>14 -0 Para Vender uma Espada.
    msgdiv
    msgl 8Méritos
    msgl 0¯¯¯¯¯¯¯
    msgl 7!9Trocar Item11 <Espada>14 -0 Trocar Mérito por Espada.
    msgdiv
    msgl 7!9Info11 <Espada>14 -0 Para Informações de uma Espada.
    msgbase
  }
  if $strip($1-) = !Espadas Comuns {
    id.check =
    msgtopo | msgt 0Espadas Comuns
    msgt 7¯¯¯¯¯¯¯ ¯¯¯¯¯¯
    msgl       0Itens0              0Dinheiro0           0Méritos0   
    msgl       9¯¯¯¯¯9              11¯¯¯¯¯¯¯¯8           8¯¯¯¯¯¯¯0   
    msgl 0Espada Pequena 7*15 C:11  4.000 14|15 V:4  2.000 7*8      -    
    msgl 0Espada Longa   7*15 C:11  6.000 14|15 V:4  3.000 7*8      -    
    msgl 0Espada de Aço  7*15 C:11 12.000 14|15 V:4  6.000 7*8      -    
    msgl 0Espada Dupla   7*15 C:11 20.000 14|15 V:4 10.000 7*8      -    
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comprar11 <Espada>14 -0 Para Comprar uma Espada.
    msgl 7@9Vender 11 <Espada>14 -0 Para Vender uma Espada.
    msgdiv
    msgl 8Méritos
    msgl 0¯¯¯¯¯¯¯
    msgl 7!9Trocar Item11 <Espada>14 -0 Trocar Mérito por Espada.
    msgdiv
    msgl 7!9Info11 <Espada>14 -0 Para Informações de uma Espada.
    msgbase
  }
  if $strip($1-) = !Espadas {
    id.check =
    msgtopo | msgt 0Espadas
    msgt 7¯¯¯¯¯¯¯
    msgl 8!11Espadas Comuns14 -0 Verifica as Espadas Comuns.
    msgl 8!11Espadas Elementais14 -0 Verifica as Espadas Elementais.
    msgl 8!11Espadas Especiais14 -0 Verifica as Espadas Especiais.
    msgbase
  }
  if $strip($1-) = !Equipamentos {
    id.check =
    msgtopo | msgt 0Equipamentos
    msgt 7¯¯¯¯¯¯¯¯¯¯¯¯
    msgl 8!11Equip Comuns14 -0 Mostra os Equipamentos Comuns.
    msgl 8!11Equip de Treino14 -0 Mostra os Equipamentos de Treino.
    msgbase
  }
  if $strip($1-) = !Lanchonete {
    id.check =
    msgtopo | msgt 0Lanches
    msgt 7¯¯¯¯¯¯¯
    msgl       0Itens0              0Dinheiro0           0Méritos0   
    msgl       9¯¯¯¯¯9              11¯¯¯¯¯¯¯¯8           8¯¯¯¯¯¯¯0   
    msgl 0Maçã           7*15 C:11    500 14|15 V:4    -   7*8      -    
    msgl 0Chocolate      7*15 C:11  1.000 14|15 V:4    -   7*8      -    
    msgl 0Sushi          7*15 C:11  2.000 14|15 V:4    -   7*8      -    
    msgdiv
    msgl 8Dinheiro
    msgl 0¯¯¯¯¯¯¯¯
    msgl 7@9Comer11 <Alimento>14 -0 Para Comprar e Comer.
    msgdiv
    msgl 7!9Info11 <Lanche>14 -0 Para Informações de uma Lanche.
    msgbase
  }
}




alias com_chat_!loja {
  id.check =
  msgtopo | msgt 0Loja
  msgt 7¯¯¯¯
  msgt 0Aqui você encontra itens para comprar, vender e 
  msgt 0trocar por méritos.
  msgl 
  msgt 15Se você não sabe o que são méritos, digite: 7!9Méritos
  msgdiv 
  msgl 0  0As seções da loja são:
  msgl 
  msgl 8     8!11Espadas14 -0 Verifica as nossas Espadas.
  msgl 8     8!11Poções14 -0 Verifica as nossas Poções.
  msgl 8     8!11Equipamentos14 -0 Verifica os Equipamentos.
  msgl
  msgl 8     8!11Lanchonete14 -0 Verifica os alimentos disponíveis.
  msgbase
}
