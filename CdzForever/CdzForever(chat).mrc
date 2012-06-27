on *:open:=: {
  ; Grava o IP do cara :D
  if !$window(@IPs) { window -j800 @IPs | loadbuf 800 @IPs $ips.path }

  var %ip = $chat($nick).ip
  aline @IPs IP - $date $+ @ $+ $time - $nick %ip
  write $ips.path IP - $date $+ @ $+ $time - $nick %ip

  var %x = 1
  while %x <= $chat(0) {
    if ($chat(%x).ip = $chat($nick).ip) && ($chat(%x).wid != $chat($nick).wid) {
      if ($chat(%x).status = active) {
        msg =$nick 0,1 0,14 15,1 Você 4não 15pode conectar neste bot com 7clone 14¬¬15. Verifique se já não tens uma 8outra janela 0conectada15. 0,14 0,1 
        if $chat($chat(%x),2) { close -c2 $nick | halt }
        else { close -c $nick | halt }
      }
      else { close -c $chat(%x) | halt }
    }
    inc %x
  }

  if ($user.exists) {
    var %i = $fline(@IPs,* %ip,0),%r,%ctime
    while (%i) {
      %r = $fline(@IPs,* %ip,%i).text
      %ctime = $ctime($replace($gettok(%r,3,32),@,$chr(32)))
      if ($gettok(%r,-2,32) != $nick && $user.exists($gettok(%r,-2,32)) && %ctime > $calc($ctime - 172800)) {
        memosend sega SaintSeiya Usuário8 $nick 15acessando com 0clone no IP9 %ip $+ 15. 15(14 $+ $date(dd/mm hh:nn:ss) $+ 15)8 $+ $nick $+ 15==8 $+ $gettok(%r,-2,32) $+ 15(14 $+ $date(%ctime,dd/mm hh:nn:ss) $+ 15)
        %i = 1
      }
      dec %i
    }
  }

  if (!$dados($nick,nick)) {
    msgtopo | msgt 0Você ainda não está 4Cadastrado0!
    msgt
    msgt 0Para se cadastrar, digite: 9!0Cadastrar
    msgdiv
    msgt 0Se você já possui um cadastro com 4outro nick
    msgt 0mas quer passar o cadastro para este,
    msgt 0digite: 9!0Mudar Nick
    msgdiv
    msgt 0,1Para mais informações, Digite: 9!0Ajuda
    msgdiv
    msgt 4Obs:0 O Bot não lê letras coloridas,
    msgt 0portanto não utilize cor nos comandos! | msgbase
  }
  else {
    .writeini users/ $+ $nick $+ .ini $nick IpNovo $chat($nick).ip
    if (!$dados($nick,senha)) {
      msgtopo 
      msgt 0+4Atenção0+
      msgt 5¯¯¯¯¯¯¯
      msgt 0Você ainda não possui uma senha setada para
      msgt 0proteger seu cadastro.
      msgt 0Para adicioná-la, digite:
      msgt 9!0Incluir Senha 7<0senha7>
      msgt 4Ex: 9!0Incluir Senha 123 
      msgbase
    }
    else {
      if ($dados($nick,ipident) == $dados($nick,ipnovo)) && ($dados($nick,ident) == sim) {
        hadd -m $nick chat on
        hadd $nick nick $nick
        apres.inicial
      }
      elseif (!user.identifyed) {
        .writeini users/ $+ $nick $+ .ini $nick Ident Nao 
        msgtopo 
        msgt 0+4STOP!0+
        msgt 5¯¯¯¯¯¯¯
        msgt 0você não está identificado ainda.
        msgt 0Para se identificar, digite:
        msgt 7!0ident 9<0senha9> | msgbase
      }
    }
  }
}

alias apres.inicial {
  msgtopo
  msgt 8,1                  ________   _       /¯\                
  msgt 8,1            _____/ ______ \_/ \_____// \\_____          
  msgt 8,1          _/_____/        \_/4+8\_____/   \___ /_         
  msgt 8,1         /_/        0_____  ____  _____ 0' ' + 8\__\       
  msgt 8,1        //         0/  __/ |    \ \_   /       * 8\\      
  msgt 8,1       //         0<  <__  | _>  | / _/           8\\     
  msgt 8,1      /_\          0\____\ |____/ /____\          8/_\    
  msgt 8,1     //0_______ ____ _____   _____       __________ 8\\   
  msgt 8,1    // 0\   __//    \\ _  \ | ___//\  /\| ___/\ _  \ 8\\  
  msgt 8,1   //  0/  >  / _)  /|  ´ < |  >_ \ \/ /|  >_ |  ´ <  8\\ 
  msgt 8,1  //  0/__/   \____/ |_|\__\|____\ \__/ |____\|_|\__\  8\\
  msgt 8,1 //_______________             _______________________8//
  msgt 8,1/________________/_____________| _____________________/ 
  msgt 0,1´´´´´´´´´´´´´´´´8/_______________|0´´´´´´´´´´´´´´´´´´´´´  
  msgt 0,1                ´´´´´´´´´´´´´´´´  11THE BEST OF BRASNET   
  msgr 11NOW ON IRCHIGHWAY  
  if ($1) {
    msgdiv
    msgt 0Oi,9 $nick $+ 0. Seja bem vindo ao canal.
    msgt
    msgt 0Se você possui alguma dúvida sobre algum comando do bot,
    msgt 0antes de perguntar a um OP ou a outra pessoa,
    msgt 0digite: 7!9Ajuda
    msgt
    msgt 0Fique atento sobre as novidades do canal, digitando 
    msgt 0sempre o comando 7!9News
    msgdiv 
    msgt 7"0Seja um Cavaleiro. Lute por seu Deus.
    msgt 0Seja um #CdzForever!7"
    msgt 
    msgr 11»0 By Equipe CdzForever9®11 «
    msgr 0Cavaleiros do Zodíaco SaintSeiya® » B0T v08
  }
  msgbase

  if ($oplv($nick)) {
    msgtd 15Você foi identificado automaticamente como01 $replace($oplv($nick),3,Administrador,2,Operador,1,Atualizador) $+ 15.
    msgblack
    $+(.timer.chat.,$nick,.close) off
  }

  w+ $nick ua $ctime

  if (!$user.perfil.email) {
    redmsgtopo
    redmsgt 1Você ainda não setou o seu e-mail!
    redmsgt 
    redmsgt Este passo é muito importante para os projetos futuros 
    redmsgt do #CdzForever, portanto pedimos que você adicione um 
    redmsgt e-mail válido ao seu cadastro, através do comando abaixo:
    redmsgt
    redmsgt 1!SetarEmail <0e-mail1>
    redmsgt 
    redmsgt O #CdzForever se compromete em manter em sigilo o e-mail 
    redmsgt registrado.
    redmsgbase
  }
  elseif ($user.perfil.email.code) {
    redmsgtopo
    redmsgt 1Você ainda não confirmou o seu e-mail!
    redmsgt 
    redmsgt Para confirmar, verifique sua caixa de entrada. Caso você
    redmsgt tenha passado o e-mail corretamente, uma mensagem
    redmsgt automática do bot lhe dirá como proceder para efetuar a
    redmsgt confirmação.
    redmsgt 
    redmsgt 1Caso você não tenha recebido o e-mail, utilize novamente
    redmsgt 1o comando !setaremail.
    redmsgbase
  }
  if (!$user.perfil.nascimento) {
    redmsgtopo
    redmsgt Você ainda não setou a sua data de nascimento!
    redmsgt
    redmsgt Para setá-la, digite 8!SetarNasc dd/mm/aaaa0, onde:
    redmsgl        - 8dd15 é o dia do seu nascimento
    redmsgl        - 8mm15 é o mês do seu nascimento
    redmsgl        - 8aaaa15 é o ano do seu nascimento
    redmsgbase
  }

  if ($user.cosmo < 500 && $user.tutorial == $null) {
    msgtopo
    msgt 8,1           .           
    msgt 8,1      .´'´' '`'`.      
    msgt 8,1    .´_.'''''''._`.    
    msgt 8,1    \6/\/ 0__ __6 \/\8/    
    msgt 0,1     6\/\  12o o  6/\/     
    msgt 0,1        ||_6v0_||        
    msgt 0,1        \ 6---0 /        
    msgt 10,1       / 0|___|10 \       
    msgt 10,1      / \     / \      
    msgt 10,1     /   \   /   \     
    msgt 10,1    /    /6\_/10\    \    
    msgt 10,1    \___\6__86__10/___/    
    msgt 10,1     \____6b.d10____/     
    msgt 
    msgt 0Olá,7 $nick $+ 0!
    msgt 0Seja bem vindo ao 11Mundo CdzForever0!
    msgt 
    msgt Boa sorte na sua jornada para ser um Cavaleiro
    msgt e lutar por seu deus.
    msgt 
    msgt 0Como você é iniciante, ajudarei com algumas dicas!
    msgt 
    msgt Sempre que acabar de seguir cada dica com sucesso,
    msgt digite 7!0Mestre Ancião15 para uma nova dica.
    msgt 
    msgt 081ª Dica:0 Todos os comandos do jogo, estão listados
    msgt 0no 7!0Ajuda
    msgt 0Sempre que esquecer um comando, vá lá.
    msgt 
    msgt Digite:7 !0Ajuda
    user.tutorial.set 1
  }
}
