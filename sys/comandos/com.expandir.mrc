;; ----------------------------------------------------------------------------
;; Comando :: chan :: !Expandir Cosmo
;; Expande o cosmo (ou não) de um usuário
;; ----------------------------------------------------------------------------
alias com_chan_!expandir {
  if ($1 != cosmo) return
  if ($chan !isin $sys._ARENAS) return

  id.check

  if ($user.vigor >= 80) var %elecos = $rand(0,4)
  elseif ($user.vigor isnum 40-79) var %elecos = $rand(0,10)
  elseif ($user.vigor isnum 0-39) var %elecos = $rand(0,20)
  else var %elecos = 0

  var %elevcosmo = $user.cosmo
  if (%elecos == 1) { var %m = 10 }
  if (%elecos == 2) { var %m = 5 }
  if (%elecos isnum 1-2) {
    if (%elevcosmo isnum 0-80000) var %elevaff = $calc($calc(%elevcosmo * 1000) * %m)
    elseif (%elevcosmo isnum 80001-280000) var %elevaff = $calc($calc(%elevcosmo * 700) * %m)
    elseif (%elevcosmo isnum 280001-590000) var %elevaff = $calc($calc(%elevcosmo * 400) * %m)
    elseif (%elevcosmo isnum 590001-1090000) var %elevaff = $calc($calc(%elevcosmo * 100) * %m)
    elseif (%elevcosmo isnum 1090001-1890000) var %elevaff = $calc($calc(%elevcosmo * 90) * %m)
    elseif (%elevcosmo isnum 1890001-2890000) var %elevaff = $calc($calc(%elevcosmo * 80) * %m)
    elseif (%elevcosmo isnum 2890001-3990000) var %elevaff = $calc($calc(%elevcosmo * 70) * %m)
    elseif (%elevcosmo isnum 3990001-5210000) var %elevaff = $calc($calc(%elevcosmo * 60) * %m)
    elseif (%elevcosmo isnum 5210001-6710000) var %elevaff = $calc($calc(%elevcosmo * 50) * %m)
    elseif (%elevcosmo isnum 6710001-8710000) var %elevaff = $calc($calc(%elevcosmo * 40) * %m)
    elseif (%elevcosmo isnum 8710001-11000000) var %elevaff = $calc($calc(%elevcosmo * 30) * %m)
    elseif (%elevcosmo isnum 11000001-14000000) var %elevaff = $calc($calc(%elevcosmo * 20) * %m)
    elseif (%elevcosmo isnum 14000001-30000000) var %elevaff = $calc($calc(%elevcosmo * 10) * %m)
    elseif (%elevcosmo isnum 30000001-500000000) var %elevaff = $calc($calc(%elevcosmo * 10) * %m)
    elseif (%elevcosmo > 500000000) var %elevaff = $calc($calc(%elevcosmo * 5) * %m)

    if (%elevcosmo isnum 0-1090000) {
      msgn 0 $+ $nick $+ 15, você $+ $iif(%m = 5,$chr(44) com dificuldades $+ $chr(44)) expandiu seu cosmo, aumentando-o para0  $+ $replace($bytes(%elevaff,b),$chr(44),.) $+ 14!
      user.stamina.retrieve 20
    }
    elseif (%elevcosmo isnum 1090001-8710000) {
      msgn 0 $+ $nick $+ 15, você $+ $iif(%m = 5,$chr(44) com dificuldades $+ $chr(44)) alcançou a essência do cosmo, chegando ao9 7º Sentido15, aumentando seu cosmo para0  $+ $replace($bytes(%elevaff,b),$chr(44),.) $+ 14!
      user.stamina.retrieve 30
    }
    elseif (%elevcosmo isnum 8710001-500000000) {
      msgn 0 $+ $nick $+ 15, você $+ $iif(%m = 5,$chr(44) com dificuldades $+ $chr(44)) superou a essência do cosmo, chegando ao9 8º Sentido15, aumentando seu cosmo para0  $+ $replace($bytes(%elevaff,b),$chr(44),.) $+ 14!
      user.stamina.retrieve 40
    }
    else {
      msgn 0 $+ $nick $+ 15, você $+ $iif(%m = 5,$chr(44) com dificuldades $+ $chr(44)) superou todos os limites do Cosmo, chegando ao9 8º Sentido15, aumentando seu cosmo para0  $+ $replace($bytes(%elevaff,b),$chr(44),.) $+ 14!
      user.stamina.retrieve 50
    }
  }
  elseif (%elecos == 3) msgn 0 $+ $nick $+ 15, surge uma grande Aura em sua volta, mas logo se desfaz.
  elseif (%elecos == 4) msgn 0 $+ $nick $+ 15, apesar do seu grande esforço, nada acontece.
  elseif (%elecos == 5) msgn 0 $+ $nick $+ 15, Você tenta acender seu cosmo, porém não consegue.
  elseif (%elecos == 6) msgn 0 $+ $nick $+ 15, seu vigor foi grande, mas não o suficiente.
  elseif (%elecos == 7) msgn 0 $+ $nick $+ 15, você tentou atingir a essência do cosmo, mas foi muito pra você.
  elseif (%elecos == 8) msgn 0 $+ $nick $+ 15, você usou todo ódio de seu coração, seu cosmo se elevou mas voltou ao normal em seguida.
  elseif (%elecos == 9) msgn 0 $+ $nick $+ 15, sua tentativa de expandir o cosmo foi em vão.
  elseif (%elecos == 10) msgn 0 $+ $nick $+ 15, uma chama imensa de cosmo correu pelo seu corpo, mas logo se desfez.
  else msgn 0 $+ $nick $+ 15, você não se concentrou o suficiente e seu cosmo não mudou.
}
