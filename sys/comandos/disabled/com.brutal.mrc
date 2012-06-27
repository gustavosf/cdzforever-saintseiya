on *:text:*:*:{
  if @brutal = $strip($1) {
    op.check ! | id.check 
    tokenize 32 $strip($1-)
    if $2 = openpl {
    if $dados($3,nick) { writeini $dados($3) $3 chat 1 | msg #cdzforever 0,1 0,14 4,1 Brutal 14"7OPENPL14"15 usado por08 $nick $+ 14. 15A PartyLine de09 $3 15agora foi aberta. 0,1 0,14 0,1  }    }
    if $2 = closepl {
      if $dados($3,nick) { remini $dados($3) $3 chat | msg #cdzforever 0,1 0,14 4,1 Brutal 14"7CLOSEPL14"15 usado por08 $nick $+ 14. 15A PartyLine de09 $3 15agora foi fechada. 0,1 0,14 0,1  }
    }
    if $2 = changenick {
      if $isfile($dados($3)) {
        if $isfile($dados($4)) { 
          write -l1 $dados($3) $+([,$4,])
          write -l2 $dados($3) $+(nick=,$4)
          write -l1 $dados($4) $+([,$3,])
          write -l2 $dados($4) $+(nick=,$3)
          .rename $dados($3) $+($dados($3),.bak)
          .rename $dados($4) $dados($3) 
          .rename $+($dados($3),.bak) $dados($4)
          .rename quiz\ $+ $3 $+ .ini quiz\ $+ $4 $+ ini 
          if ($readini users/ $+ $4 $+ .ini $4 Armadura != Nenhuma) {
            set %armbrutnick $readini users/ $+ $4 $+ .ini $4 Armadura
            set %armnickbrut $remove(%armbrutnick,$chr(32))
            .writeini armaduras.ini %armnickbrut Nick $4
          }
          if ($readini ops.ini $3 Op != $null) {
            .set %admmnic $readini ops.ini $3 Adim
            .set %admmnic1 $readini ops.ini $3 Atua
            .set %admmnic2 $readini ops.ini $3 Op
            .writeini ops.ini $4 Adim %admmnic
            .writeini ops.ini $4 Atua %admmnic1
            .writeini ops.ini $4 Op %admmnic2
            .remini ops.ini $3
            .remini ops.ini $3 Op
            .remini ops.ini $3 Atua 
            .remini ops.ini $3 Adim
          }
          unset %armbrutnick
          unset %armnickbrut
          unset %admmnic
          unset %admmnic1
          unset %admmnic2
          msg #cdzforever 0,1 0,14 4,1 Brutal 14"7CHANGENICK14"15 usado por08 $nick $+ 14. 15Cadastros de09 $3 15e09 $4 15foram trocados.
        }
        elseif $4 { 
          write -l1 $dados($3) $+([,$4,])
          write -l2 $dados($3) $+(nick=,$4)
          .rename $dados($3) $dados($4)
          .rename quiz\ $+ $3 $+ .ini quiz\ $+ $4 $+ ini 
          if ($readini users/ $+ $4 $+ .ini $4 Armadura != Nenhuma) {
            set %armbrutnick $readini users/ $+ $4 $+ .ini $4 Armadura
            set %armnickbrut $remove(%armbrutnick,$chr(32))
            .writeini armaduras.ini %armnickbrut Nick $4
          }
          if ($readini ops.ini $3 Op != $null) {
            .set %admmnic $readini ops.ini $3 Adim
            .set %admmnic1 $readini ops.ini $3 Atua
            .set %admmnic2 $readini ops.ini $3 Op
            .writeini ops.ini $4 Adim %admmnic
            .writeini ops.ini $4 Atua %admmnic1
            .writeini ops.ini $4 Op %admmnic2
            .remini ops.ini $3
            .remini ops.ini $3 Op
            .remini ops.ini $3 Atua 
            .remini ops.ini $3 Adim
          }
          unset %armbrutnick
          unset %armnickbrut
          unset %admmnic
          unset %admmnic1
          unset %admmnic2
          msg #cdzforever 0,1 0,14 4,1 Brutal 14"7CHANGENICK14"15 usado por08 $nick $+ 14. 15Cadastro de09 $3 15foi alterado para09 $4 $+ 15. 0,14 0,1 
        }
        elseif !$4 { .notice $nick 0,1 0,14 15,1 Parâmetro 7faltando15! Uso: 09@Brutal Changenick <nick> <newnick/nick> 0,14 0,1  }
      }
      else { .notice $nick 0,1 0,14 15,1 Nick09 $3 0não 15encontrado no banco de dados 0,14 0,1  }
    }
    if $2 = kickban {
      if $3 {
        var %x = 1,%b
        while %x <= 6 { var %b = %b $address($3,%x) | inc %x }
        var %b
        mode # +bbbbbb %b
        while %x <= 12 { var %b = %b $address($3,%x) | inc %x }
        mode # +bbbbbb %b
        kick # $3 0,1 0,14 15,1 Você foi 7 banido 4BRUTALMENTE08 $nick 0,14 0,1 
        msg #cdzforever 0,1 0,14 4,1 Brutal 14"7KICKBAN14"15 usado por08 $nick $+ 14. 15Ele foi jogado pra fora que nem o 7Jazz 15do 0Maluco no Pedaço 0,14 0,1 
      }
    }
    if $2 = changepass {
      if $4 {
        if $dados($3,nick) {
          var %pass = $makepass($len($4))
          writeini $dados($3) $3 senha %pass
          memoserv send $3 0,1 0,14 15,1 Sua senha do bot foi 0trocada 15para08 %pass 15pelo operador09 $nick $+ 15. 0,14 0,1 
          .notice $nick 0,1 0,14 15,1 Senha 0alterada15 para08 %pass 0,14 0,1 
          .msg #cdzforever 0,1 0,14 15,1 A senha de08 $3 15foi alterada pelo operador09 $nick 0,14 0,1 
        }
        else { .notice $nick 0,1 0,14 15,1 O usuário08 $3 15não está cadastrado! 0,14 0,1  }
      }
      elseif !$4 { .notice $nick 0,1 0,14 15,1 Parâmetro 7faltando15! Uso: 09@Brutal Changepas <nick> <num_digitos> 0,14 0,1  }
    }
  }
}
alias makepass {
  var %x = 1,%p,%y = $iif($1 isnum,$1,$len($1))
  while %x <= %y { var %p = %p $+ $chr($r(48,122)) | inc %x }
  return %p
}
