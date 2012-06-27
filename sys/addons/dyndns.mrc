;; damn dns
#ddns off
alias -l sw { sockwrite -nt $sockname $1- | ;; echo -a <<12 $1- }
on *:sockopen:ddns.*:{
  sw GET /nic/update?hostname=is.homedns.org&myip= $+ $ip $+ &wildcard=NOCHG&mx=NOCHG&backmx=NOCHG HTTP/1.1
  sw Host: members.dyndns.org
  sw Authorization: Basic c2VnYXdheTpmYWxrbGFuZA==
  sw User-Agent: Opera/9.80 (Windows NT 6.1; U; pt-BR) Presto/2.5.22 Version/10.50
  sw
}
on *:sockread:ddns.*:{
  sockread %a | tokenize 32 %a
  echo -a >> $1-
  if ($1 == good) { echo -st ddns -> atualizado $ip }
  if ($1 == nochg) { echo -st ddns -> atualização desnecessaria }
}
alias ddns {
  var %x = $+(ddns.,$rand(10000,99999))
  while ($sock(%x)) %x = $+(ddns.,$rand(10000,99999))
  sockopen %x members.dyndns.org 80
  return %x
}
on *:connect:{
  if ($ip == %ddns.ip) halt
  %ddns.ip = $ip
  ; .timerddns 1 30 ddns
}
alias com_chat_!getcad {
  op.check ! =
  if ($dados($1,nick)) {
    msgt enviando $dados($1)
    dcc send $nick $dados($1)
  }
}
#ddns end
