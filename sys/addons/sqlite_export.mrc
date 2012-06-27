;; exporta os dados pra sqlite
;; dvl - 03:05@10/03/2010 

alias export {
  if (!$window(@sql)) { window -e @sql }
  else { clear @sql }

  %sql.dbname = dbs/ $+ $replace($date,/,-) $+ .db

  if ($exists($scriptdir $+ %sql.dbname)) { .remove $scriptdir $+ %sql.dbname }

  set %sql.db $sqlite_open($scriptdir $+ %sql.dbname)

  if (!%sql.db) { 
    aline @sql 04fatal erro: %sqlite_errstr
    halt
  }

  aline @sql db aberta  $+ %sql.dbname $+ , criando estrutura...

  sqlite_exec %sql.db $&
    CREATE TABLE users ( $&
    id          integer PRIMARY KEY AUTOINCREMENT NOT NULL, $&
    nick        varchar(50) NOT NULL, $&
    cosmo       BIGINT DEFAULT 0, $&
    dinheiro    BIGINT DEFAULT 0, $&
    meritos     integer DEFAULT 0, $&
    vitorias    integer DEFAULT 0, $&
    empates     integer DEFAULT 0, $&
    derrotas    integer DEFAULT 0, $&
    narradas    integer DEFAULT 0, $&
    armadura    varchar(50) DEFAULT "Nenhuma", $&
    itens       text DEFAULT "Nenhum", $&
    nascimento  varchar(10), $&
    acertos     integer DEFAULT 0, $&
    erros       integer DEFAULT 0);

  aline @sql estrutura criada, lendo e inserindo dados...
  aline @sql -

  var %sql.f = 1  
  while (%sql.f <= $findfile(users,*.ini,0)) { 
    var %sql.nick = $readini($findfile(users,*.ini,%sql.f),$ini($findfile(users,*.ini,%sql.f),1),nick)

    var %sql.query = INSERT INTO "users" ("id","nick","cosmo","dinheiro","meritos","vitorias","empates","derrotas","narradas","armadura","itens","nascimento","acertos","erros") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    var %sql.stmt = $sqlite_prepare(%sql.db,%sql.query)

    ;; binds

    sqlite_bind_value %sql.stmt 1 %sql.f
    sqlite_bind_value %sql.stmt 2 %sql.nick
    sqlite_bind_value %sql.stmt 3 $dados(%sql.nick,Cosmo)
    sqlite_bind_value %sql.stmt 4 $dados(%sql.nick,Dinheiro)
    sqlite_bind_value %sql.stmt 5 $dados(%sql.nick,meritos)
    sqlite_bind_value %sql.stmt 6 $dados(%sql.nick,Vitorias)
    sqlite_bind_value %sql.stmt 7 $dados(%sql.nick,Empates)
    sqlite_bind_value %sql.stmt 8 $dados(%sql.nick,Derrotas)
    sqlite_bind_value %sql.stmt 9 $dados(%sql.nick,Narradas)
    sqlite_bind_value %sql.stmt 10 $dados(%sql.nick,Armadura)
    sqlite_bind_value %sql.stmt 11 $replace($dados(%sql.nick,Itens),$chr(44),*,$chr(32),-)
    sqlite_bind_value %sql.stmt 12 $dados(%sql.nick,DiaNas) $+ / $+ $dados(%sql.nick,MesNas) $+ / $+ $dados(%sql.nick,AnoNas)
    sqlite_bind_value %sql.stmt 13 $dados(%sql.nick,acertoper)
    sqlite_bind_value %sql.stmt 14 $dados(%sql.nick,errosperg) 

    aline @sql # $+ %sql.f $+ . %sql.nick $+ ... ok!

    ;; exec

    sqlite_exec %sql.stmt
    sqlite_free %sql.stmt

    inc %sql.f
  }  

  aline @sql -
  aline @sql dados inseridos, fechando conexão...

  sqlite_close %sql.db

  unset %sql*

  dll -u $scriptdirsqlite/msqlite.dll

  aline @sql script executado com sucesso.

}
