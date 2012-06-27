;; --------------------------------------------------------------------------------------------- ABOUT
;;
;; Comando feito por sega, em Fevereiro/2010
;; Proibida a reprodução por rippers dos canais rivais (ouviu first?)
;;
;; --------------------------------------------------------------------------------------------- FIX ALIASES

;alias -l fixurl return $regsubex($1-,/([^a-z0-9 ])/ig,% $+ $base($asc(\t),10,16,2))
alias -l fixurl return $regsubex($1-,/([ÂÃÄÀÁÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõöøùúûüışÿ])/ig,% $+ $base($asc(\t),10,16,2) $+ 00)
;alias -l fixurl return $regsubex($1-,/([^a-z0-9])/ig,$+($chr(37),26,$chr(35),$asc(\t),$chr(59)))

alias -l fixxml { var %a | noop $regsub($1-,/<[^<>]+>/g,,%a) | return %a }
alias -l fixtxt return $regsubex($1-,/&#([0-9]+);/g,$chr(\1))

alias -l sw { sockwrite -nt $sockname $1- | ;;echo -a <<12 $1- }
alias -l twitSet sockmark $twitOpen $1-

alias -l twitOpen {
  var %x = $+(twit.,$rand(10000,99999))
  while ($sock(%x)) %x = $+(twit.,$rand(10000,99999))
  sockopen %x twitter.com 80
  return %x
}

;; --------------------------------------------------------------------------------------------- SOCKETS

on *:sockopen:twit.*:{
  tokenize 32 $sock($sockname).mark
  sw $iif($2,POST,GET) $1 HTTP/1.1
  sw Authorization: Basic Y2R6NGV2ZXI6Y2R6NHR3aXQ=
  sw Host: twitter.com
  sw Accept: */*
  sw Content-Length: $len($2-)
  sw Content-Type: application/x-www-form-urlencoded
  sw 
  if ($2) { sw $2- | sw }
}
on *:sockread:twit.*:{
  sockread %a | tokenize 32 %a
  ;;echo -a >>04 $1-¨
  var %type = $sock($sockname).mark

  if (followers isin %type) {
    if (<users* iswm $1-) {
      hadd -m twit users 0
      hadd twit user
    }
    if (<screen_name>* iswm $1-) {
      hinc twit users
      hadd twit user $addtok($hget(twit,user),$fixxml($1-),44)
    }
  }
  if (mention isin %type) {
    if (<text>* iswm $1-) hadd -m twit text $fixxml($1-)
    if (<screen_name>* iswm $1-) hadd -m twit user $fixxml($1-)
    if (</status>* iswm $1-) echo -a @ $+ $hget(twit,user) $+ : $fixtxt($hget(twit,text))
  }
}

;; --------------------------------------------------------------------------------------------- SUBCOMANDOS

alias twit { twit.post $1- }
alias twit.post twitSet /statuses/update.xml $+(status=,$fixurl($1-))
alias twit.get twitSet /direct_messages.xml
alias twit.followers twitSet /statuses/followers.xml
alias twit.follow twitSet /friendships/create/ $+ $1 $+ .xml
alias twit.mentions twitSet /statuses/mentions.xml

;; --------------------------------------------------------------------------------------------- COMANDOS

alias com_@twit {
  if ($1 == post) {
    var %msg = $2- ( $+ $nick $+ )
    if ($len(%msg) <= 140) twit.post %msg
  }
}

;; --------------------------------------------------------------------------------------------- HANDLERS

on *:input:*:{
  tokenize 32 $1-
  if ($isalias($+(com_,$1))) $+(com_,$1) $2-
}
off *:text:*:*:{
  tokenize 32 $1-
  if ($isalias($+(com_,$1))) $+(com_,$1) $2-
}

alias com_all_!twitt {
  id.check
  op.check !
  twit $1- ( $+ $iif($dados($nick,twitter),@ $+ $dados($nick,twitter),$nick) $+ )
  msg #cdzforever 0,1 0,14 0,1 twitter atualizado 09@00cdz4ever 0,14 0,1 
}
