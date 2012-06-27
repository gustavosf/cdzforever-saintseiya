alias weblogs.init {
  socklisten weblogs 23456
  hadd -m sys.weblogs status 1
}

alias -l sw { echo -a >>> $1- | sockwrite -nt $sockname $1- }
alias -l weblogs return $hget(sys.weblogs,$iif($1,$1,status))


;; --------------------------------------------------------------------------------

alias -l weblog {
  if ($isid) return $hget($sockname,$1)
  else hadd -m $sockname $1-
}

;; -------------------------------------------------------------------------------- WRAPS

alias weblog.wraps {
  if ($1 == html5) {
    if ($prop == len) return 104
    if ($prop == head) return <!DOCTYPE HTML><html lang="en-US"><head><meta charset="UTF-8"><title>@TITLE@</title></head><body>
    if ($prop == foot) return </body></html>
  }
}

;; -------------------------------------------------------------------------------- PROPRIEDADES

alias -l weblog.title { 
  if ($isid) { return $weblog(title) }
  weblog title $1- 
}
alias -l weblog.wrap { 
  if ($isid) { return $weblog(wrap) }
  weblog wrap $1
  weblog.resp $regsubex($weblog.wraps($1).head,/@(.*)@/gi,$iif($weblog(\1),$v1,$null))
}

;; --------------------------------------------------------------------------------

alias -l weblog.resp write $sockname $+ .tmp $1-

alias -l weblog.send {
  if ($weblog.wrap) weblog.resp $weblog.wraps($v1).foot

  sw HTTP/1.0 200 OK
  sw Date: $asctime(ddd $+ $chr(44) dd mmm yyyy hh:nn:ss) GMT
  sw Content-Type: text/html
  sw Content-Length: $file($sockname $+ .tmp).size
  sw
  .fopen $sockname $sockname $+ .tmp
  while (!$feof($sockname)) sw $fread($sockname)
  .fclose $sockname
  sw
}

alias -l weblog.clear {
  .remove $sockname $+ .tmp
  if ($hget($sockname)) hfree $sockname
}


;;on *:signal:start_ready:weblogs.init

on *:socklisten:weblogs:sockaccept weblogs. $+ $randomnum(8)

on *:sockread:weblogs.*:{
  sockread %a | tokenize 32 %a
  echo -a <<< $1-
  if ($1 == GET) sockmark $sockname $2
  if (!$1) {
    var %page = $sock($sockname).mark
    if  (%page == /) {
      weblog.title Log de Combates do #CdzForever
      weblog.wrap html5
      weblog.resp <h1>Log de Combates do #CdzForever</h1>
      weblog.resp <table>
      weblog.resp <tr><th>Data</th><th>Código</th><th>Tipo</th><th>Vencedor</th><th>Perdedor</th><th>Narrador</th><th>Atualizador</th><th>Canal</th></tr>
      var %f = $sockname $+ .lutas,%i = $lines($lutas.path),%limit = 50,%l
      .fopen %f $lutas.path
      while (%i && %limit) {
        .fseek -l %f %i
        %l = $fread(%f)
        tokenize 32 %l
        weblog.resp <tr><td> $17 ás $19 </td><td> $1 </td><td> $replacex($gettok($1,1,$asc(-)),WO,W.O.,E,Empate,F,Fácil,M,Média,D,Difícil) </td><td> $4 </td><td> $7 </td><td> $10 </td><td> $14 </td><td> $22 </td></tr>
        dec %i
        dec %limit
      }
      .fclose %f
      weblog.resp </table>
      weblog.send
      weblog.clear
    }
  }
}
