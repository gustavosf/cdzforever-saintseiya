alias sys.reload {
  var %a = $alias(0)
  while (%a) {
    .reload -a $alias(%a)
    dec %a
  }

  var %r = $script(0)
  while (%r) {
    if ($script(%r) != $script) .reload -rs $shortfn($script(%r))
    dec %r
  }
}

alias com_all_!reload {
  op.check !
  sys.reload
  noticen Sistema 8recarregado15!14 :)
}

alias com_all_!svnupdate {
  op.check !
  run TortoiseProc.exe /command:update /path: $+ $shortfn($mircdir)
  noticen Atualizando svn...
}

alias com_all_!databackup {
  op.check !
  sys.backup
  noticen Backup ok! :)
}


on *:connect: { write connection.log $date - $time - Connected }
on *:disconnect: { write connection.log $date - $time - Disconnected }
