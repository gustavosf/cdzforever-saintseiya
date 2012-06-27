on *:text:@Elevar*Aura Máxima:#: {
  if ($nick !ison #cdzforever) {
    .notice $nick 1,1 14,14 15,1 Você não está no 9#0CdzForever15 para ter acesso ao bot. 14,14 1,1 
  }
  if ($nick ison #cdzforever) {
    if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) {
      .notice $nick 1,1 14,14 15,1 Você não está0 Cadastrado14! 14,14 1,1 
    }
    if ($Readini users/ $+ $nick $+ .ini $Nick Nick != $null) {
      if ($readini users/ $+ $2 $+ .ini $2 Nick == $null) {
        .notice $nick 1,1 14,14 4,1 $2 15não está0 Cadastrado14! 14,14 1,1 
      }
      if ($Readini users/ $+ $2 $+ .ini $2 Nick != $null) {
        set %Cosmoki $readini users/ $+ $2 $+ .ini $2 Cosmo
        set %msg $chan
        set %aura Máxima
        if ( %Cosmoki >= 9000000 ) { 
          set %aff $calc(%Cosmoki * 700)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15é de:0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 7200000 ) { 
          msg %msg 1,1|14,14|0,1 $nick $+ 15,0 $2 15 não resistiria elevar seu Cosmo a Aura7 %aura 14,14|1,1|
        }
        if ( %Cosmoki < 9000000 ) && (%cosmoki > 7200000 ) { 
          if ( %Cosmoki < 9000000 ) && ( %Cosmoki >= 8900000 ) { 
            set %danos 10%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8900000 ) && ( %Cosmoki >= 8800000 ) {
            set %danos 15%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8800000 ) && ( %Cosmoki >= 8700000 ) {
            set %danos 20%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8700000 ) && ( %Cosmoki >= 8600000 ) {
            set %danos 25%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8600000 ) && ( %Cosmoki >= 8500000 ) {
            set %danos 30%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8500000 ) && ( %Cosmoki >= 8400000 ) {
            set %danos 35%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8400000 ) && ( %Cosmoki >= 8300000 ) {
            set %danos 40%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8300000 ) && ( %Cosmoki >= 8200000 ) {
            set %danos 45%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8200000 ) && ( %Cosmoki >= 8100000 ) {
            set %danos 50%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8100000 ) && ( %Cosmoki >= 8000000 ) {
            set %danos 55%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 8000000 ) && ( %Cosmoki >= 7900000 ) {
            set %danos 60%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7900000 ) && ( %Cosmoki >= 7800000 ) {
            set %danos 65%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7800000 ) && ( %Cosmoki >= 7700000 ) {
            set %danos 70%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7700000 ) && ( %Cosmoki >= 7600000 ) {
            set %danos 75%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7600000 ) && ( %Cosmoki >= 7500000 ) {
            set %danos 80%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7500000 ) && ( %Cosmoki >= 7400000 ) {
            set %danos 85%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7400000 ) && ( %Cosmoki >= 7300000 ) {
            set %danos 90%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          if ( %Cosmoki < 7300000 ) && ( %Cosmoki >= 7200000 ) {
            set %danos 95%
            set %aff $calc(%Cosmoki * 200)
          msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
          unset %cosmoki
          unset %aura
          unset %msg
          unset %aff
          unset %danos
        }
      }
    }
  }
}
}

on *:text:@Elevar*Aura Extrema:#: {
if ($nick !ison #cdzforever) {
  .msg $nick 1,1|14,14|15,1 Você não está no 9#0CdzForever15 para ter acesso ao bot. 14,14|1,1| 
  /closemsg $nick
}
if ($nick ison #cdzforever) {
  if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) {
    .msg $nick 1,1|14,14|15,1 Você não está0 Cadastrado14! 14,14|1,1|
    /closemsg $nick
  }
  if ($Readini users/ $+ $nick $+ .ini $Nick Nick != $null) {
    if ($readini users/ $+ $2 $+ .ini $2 Nick == $null) {
      .msg $nick 1,1|14,14|4,1 $2 15não está0 Cadastrado14! 14,14|1,1|
      /closemsg $nick
    }
    if ($Readini users/ $+ $2 $+ .ini $2 Nick != $null) {
      set %Cosmoki $readini users/ $+ $2 $+ .ini $2 Cosmo
      set %msg $chan
      set %aura Extrema
      if ( %Cosmoki >= 12000000 ) { 
        set %aff $calc(%Cosmoki * 500)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15é de:0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 9000000 ) { 
        msg %msg 1,1|14,14|0,1 $nick $+ 15,0 $2 15 não resistiria elevar seu Cosmo a Aura7 %aura 14,14|1,1|
      }
      if ( %Cosmoki < 12000000 ) && (%cosmoki > 9000000 ) { 
        if ( %Cosmoki < 12000000 ) && ( %Cosmoki >= 11700000 ) { 
          set %danos 10%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 11700000 ) && ( %Cosmoki >= 11400000 ) {
          set %danos 15%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 11400000 ) && ( %Cosmoki >= 11100000 ) {
          set %danos 20%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 11100000 ) && ( %Cosmoki >= 10800000 ) {
          set %danos 25%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 10800000 ) && ( %Cosmoki >= 10500000 ) {
          set %danos 30%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 10500000 ) && ( %Cosmoki >= 10400000 ) {
          set %danos 35%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 10400000 ) && ( %Cosmoki >= 10300000 ) {
          set %danos 40%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 10300000 ) && ( %Cosmoki >= 10200000 ) {
          set %danos 45%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 10200000 ) && ( %Cosmoki >= 10100000 ) {
          set %danos 50%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 10100000 ) && ( %Cosmoki >= 9900000 ) {
          set %danos 55%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9900000 ) && ( %Cosmoki >= 9800000 ) {
          set %danos 60%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9800000 ) && ( %Cosmoki >= 9700000 ) {
          set %danos 65%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9700000 ) && ( %Cosmoki >= 9600000 ) {
          set %danos 70%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9600000 ) && ( %Cosmoki >= 9500000 ) {
          set %danos 75%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9500000 ) && ( %Cosmoki >= 9400000 ) {
          set %danos 80%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9400000 ) && ( %Cosmoki >= 9300000 ) {
          set %danos 85%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9300000 ) && ( %Cosmoki >= 9200000 ) {
          set %danos 90%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        if ( %Cosmoki < 9200000 ) && ( %Cosmoki >= 9000000 ) {
          set %danos 95%
          set %aff $calc(%Cosmoki * 500)
        msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
        unset %cosmoki
        unset %aura
        unset %msg
        unset %aff
        unset %danos
      }
    }
  }
}
}
}

on *:text:@Elevar*Aura Suprema:#: {
if ($nick !ison #cdzforever) {
.msg $nick 1,1|14,14|15,1 Você não está no 9#0CdzForever15 para ter acesso ao bot. 14,14|1,1| 
/closemsg $nick
}
if ($nick ison #cdzforever) {
if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) {
  .msg $nick 1,1|14,14|15,1 Você não está0 Cadastrado14! 14,14|1,1|
  /closemsg $nick
}
if ($Readini users/ $+ $nick $+ .ini $Nick Nick != $null) {
  if ($readini users/ $+ $2 $+ .ini $2 Nick == $null) {
    .msg $nick 1,1|14,14|4,1 $2 15não está0 Cadastrado14! 14,14|1,1|
    /closemsg $nick
  }
  if ($Readini users/ $+ $2 $+ .ini $2 Nick != $null) {
    set %Cosmoki $readini users/ $+ $2 $+ .ini $2 Cosmo
    set %msg $chan
    set %aura Suprema
    if ( %Cosmoki >= 15000000 ) { 
      set %aff $calc(%Cosmoki * 1000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15é de:0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 12000000 ) { 
      msg %msg 1,1|14,14|0,1 $nick $+ 15,0 $2 15 não resistiria elevar seu Cosmo a Aura7 %aura 14,14|1,1|
    }
    if ( %Cosmoki < 15000000 ) && (%cosmoki >= 12000000 ) { 
      if ( %Cosmoki < 15000000 ) && ( %Cosmoki >= 14800000 ) { 
        set %danos 10%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 14800000 ) && ( %Cosmoki >= 14600000 ) {
        set %danos 15%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 14600000 ) && ( %Cosmoki >= 14400000 ) {
        set %danos 20%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 14400000 ) && ( %Cosmoki >= 14200000 ) {
        set %danos 25%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 14200000 ) && ( %Cosmoki >= 14000000 ) {
        set %danos 30%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 14000000 ) && ( %Cosmoki >= 13800000 ) {
        set %danos 35%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 13800000 ) && ( %Cosmoki >= 13600000 ) {
        set %danos 40%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 13600000 ) && ( %Cosmoki >= 13400000 ) {
        set %danos 45%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 13400000 ) && ( %Cosmoki >= 13200000 ) {
        set %danos 50%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 13200000 ) && ( %Cosmoki >= 13000000 ) {
        set %danos 55%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 13000000 ) && ( %Cosmoki >= 12800000 ) {
        set %danos 60%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12800000 ) && ( %Cosmoki >= 12600000 ) {
        set %danos 65%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12600000 ) && ( %Cosmoki >= 12500000 ) {
        set %danos 70%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12500000 ) && ( %Cosmoki >= 12400000 ) {
        set %danos 75%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12400000 ) && ( %Cosmoki >= 12300000 ) {
        set %danos 80%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12300000 ) && ( %Cosmoki >= 12200000 ) {
        set %danos 85%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12200000 ) && ( %Cosmoki >= 12100000 ) {
        set %danos 90%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      if ( %Cosmoki < 12100000 ) && ( %Cosmoki >= 12000000 ) {
        set %danos 95%
        set %aff $calc(%Cosmoki * 800)
      msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
      unset %cosmoki
      unset %aura
      unset %msg
      unset %aff
      unset %danos
    }
  }
}
}
}
}

on *:text:@Elevar*Aura Divina:#: {
if ($nick !ison #cdzforever) {
.msg $nick 1,1|14,14|15,1 Você não está no 9#0CdzForever15 para ter acesso ao bot. 14,14|1,1| 
/closemsg $nick
}
if ($nick ison #cdzforever) {
if ($readini users/ $+ $nick $+ .ini $Nick Nick == $null) {
.msg $nick 1,1|14,14|15,1 Você não está0 Cadastrado14! 14,14|1,1|
/closemsg $nick
}
if ($Readini users/ $+ $nick $+ .ini $Nick Nick != $null) {
if ($readini users/ $+ $2 $+ .ini $2 Nick == $null) {
  .msg $nick 1,1|14,14|4,1 $2 15não está0 Cadastrado14! 14,14|1,1|
  /closemsg $nick
}
if ($Readini users/ $+ $2 $+ .ini $2 Nick != $null) {
  set %Cosmoki $readini users/ $+ $2 $+ .ini $2 Cosmo
  set %msg $chan
  set %aura Divina
  if ( %Cosmoki >= 50000000 ) { 
    set %aff $calc(%Cosmoki * 1000000)
  msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado a Aura7 %aura 15é de:0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
  if ( %Cosmoki < 15000000 ) { 
    msg %msg 1,1|14,14|0,1 $nick $+ 15,0 $2 15 não resistiria elevar seu Cosmo a Aura7 %aura 14,14|1,1|
  }
  if ( %Cosmoki < 50000000 ) && (%cosmoki >= 15000000 ) { 
    if ( %Cosmoki < 50000000 ) && ( %Cosmoki >= 45000000 ) { 
      set %danos 10%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 45000000 ) && ( %Cosmoki >= 42000000 ) {
      set %danos 15%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 42000000 ) && ( %Cosmoki >= 38000000 ) {
      set %danos 20%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 38000000 ) && ( %Cosmoki >= 33000000 ) {
      set %danos 25%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 33000000 ) && ( %Cosmoki >= 29000000 ) {
      set %danos 30%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 29000000 ) && ( %Cosmoki >= 27000000 ) {
      set %danos 35%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 27000000 ) && ( %Cosmoki >= 26000000 ) {
      set %danos 40%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 26000000 ) && ( %Cosmoki >= 25000000 ) {
      set %danos 45%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 25000000 ) && ( %Cosmoki >= 24000000 ) {
      set %danos 50%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 24000000 ) && ( %Cosmoki >= 23000000 ) {
      set %danos 55%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 23000000 ) && ( %Cosmoki >= 22000000 ) {
      set %danos 60%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 22000000 ) && ( %Cosmoki >= 21000000 ) {
      set %danos 65%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 21000000 ) && ( %Cosmoki >= 20000000 ) {
      set %danos 70%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 20000000 ) && ( %Cosmoki >= 19000000 ) {
      set %danos 75%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 19000000 ) && ( %Cosmoki >= 18000000 ) {
      set %danos 80%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 18000000 ) && ( %Cosmoki >= 17000000 ) {
      set %danos 85%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 17000000 ) && ( %Cosmoki >= 16000000 ) {
      set %danos 90%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    if ( %Cosmoki < 16000000 ) && ( %Cosmoki >= 15000000 ) {
      set %danos 95%
      set %aff $calc(%Cosmoki * 10000)
    msg %msg 1,1|14,14|0,1 $nick $+ 15,15 o Cosmo de0 $2 15elevado à Aura7 %aura 15Com danos de 09 $+ %danos $+ 15 é de: 0  $+ $replace($bytes(%aff,b),$chr(44),.) $+  14,14|1,1| }
    unset %cosmoki
    unset %aura
    unset %msg
    unset %aff
    unset %danos
  }
}
}
}
}
}
