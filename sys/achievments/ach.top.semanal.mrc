alias ach.ts.update.all {
  if ($window(@ts.tmp)) clear @ts.tmp
  else window -sh @ts.tmp

  var %i = $ini(semana.ini,top,0)
  while (%i) { remini semana.ini top $ini(semana.ini,top,%i) | dec %i }

  var %s,%j,%n,%nick

  %i = $ini(semana.ini,0) - 1
  while (2 < %i) {
    %s = $ini(semana.ini,%i)
    %j = $ini(semana.ini,%s,0)

    clear @ts.tmp
    while (%j) {
      %nick = $ini(semana.ini,%s,%j)
      %n = $readini(semana.ini,%s,%nick)
      if (%nick != .) aline @ts.tmp $base($gettok(%n,1,58),10,10,3) $base($gettok(%n,2,58),10,10,3) $base($gettok(%n,3,58),10,10,3) $base($gettok(%n,1,58),10,10,3) $base($gettok(%n,4,58),10,10,3) $base($gettok(%n,5,58),10,10,3) %nick
      dec %j
    }
    %j = $gettok($line(@ts.tmp,$line(@ts.tmp,0)),-1,32)
    if (%j) writeini semana.ini top %j $calc($readini(semana.ini,top,%j) + 1)
    dec %i
  }
}
