;; path para a dll do zip
alias path.dll.zip return sys/dll/szip.dll

;; ----------------------------------------------------------------------------
;; Comando :: sys :: Backup
;; Faz backup dos dados do bot
;; ----------------------------------------------------------------------------
alias sys.backup {
  var %bkpfile = bkp. $+ $date(yyyymmddhhnnss) $+ .zip
  ; var %to = $shortfn(D:/my dropbox/bkp/ss-bkp/data)
  var %to = $shortfn(D:\Users\dvl\Dropbox\ss-bkp)
  sys.backup.clear

  mkdir backup
  mkdir backup/users
  mkdir backup/users2
  mkdir backup/sys
  mkdir backup/sys/lists
  mkdir backup/sys/logs

  .copy users/* backup/users
  .copy users2/* backup/users2
  .copy sys/lists/* backup/sys/lists
  .copy sys/logs/* backup/sys/logs
  .copy sys/*.* backup/sys
  .copy *.ini backup
  .copy *.txt backup

  .noop $dll($path.dll.zip,SZipFolder,backup > %bkpfile)
  .timer.sys.backup.move 1 5 .rename %bkpfile %to $+ / $+ %bkpfile
  .timer.sys.backup.clear 1 6 sys.backup.clear
}


alias sys.backup.clear {
  if ($isdir(backup)) {
    var %i = $findfile(backup,*,0,5)
    while (%i) {
      .noop $findfile(backup,*,%i,5,.remove $1)
      dec %i
    }
    var %i = $finddir(backup,*,0,5)
    while (%i) {
      .noop $finddir(backup,*,%i,5,.rmdir $1)
      dec %i
    }
    .rmdir backup
  }
}
