;; exporta os dados pra sqlite
;; não gera mais que um arquivo
;; usa só uma tabela pra tudo

;; mas primeiro vamos adicionar IDs a todos os cadastros...

alias find_invalids {
  var %sql.f = 1  
  while (%sql.f <= $findfile(users,*.ini,0)) { 
    dll WhileFix.dll WhileFix .
    if ($lines($findfile(users,*.ini,%sql.f)) == 6) {
      echo -st $findfile(users,*.ini,%sql.f)
    }
    inc %sql.f
  }
  echo -st ok!
}

alias set_id_start {
  set %sql.sid $findfile(users,*.ini,0) | timerset_id %sql.sid 1 set_id
  echo -st found %sql.sid
}

alias set_id {
  var %sql.nick $readini($findfile(users,*.ini,%sql.sid),$ini($findfile(users,*.ini,%sql.sid),1),nick)
  if ($dados(%sql.nick,nick) == $null) { echo -st 04CADASTRO QUEBRADO $findfile(users,*.ini,%sql.sid) | msg dvl- 04CADASTRO QUEBRADO $findfile(users,*.ini,%sql.sid) }
  else { w+ %sql.nick id $ctime | echo -st $findfile(users,*.ini,%sql.sid) - %sql.nick - $dados(%sql.nick,id) }
  dec %sql.sid
}

alias check_id {
  var %sql.f = 1  
  while (%sql.f <= $findfile(users,*.ini,0)) { 
    var %sql.nick = $readini($findfile(users,*.ini,%sql.f),$ini($findfile(users,*.ini,%sql.f),1),nick)
    if ($dados(%sql.nick,id) == $null) { ;;remove $findfile(users,*.ini,%sql.f) }
    inc %sql.f
  }
}

;; aliases

alias -l l { 
  if (!$window(@sql)) { window -e @sql }
  aline @sql -> $1- 
} 

alias -l conn { 
  set %sql.db $sqlite_open($scriptdircdzf.db)
  if (!%sql.db) { l 04fatal error: %sqlite_errstr | halt }
  else { l Conexão com a DB aberta... }
}

alias -l disc {
  sqlite_close %sql.db
  unset %sql*
  dll -u $scriptdirsqlite/msqlite.dll
  l Conexão encerrada...
}

alias -l geterr {
  l 04 $+ %sqlite_errno - %sqlite_errstr
}

;; trabalhando com os dados

alias create_db {
  if ($exists($scriptdircdzf.db)) { l a db já foi criada | halt }
  conn
  l Criando estrutura da tabela users...

  sqlite_exec %sql.db $&
    CREATE TABLE users ( $&
    id          integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, $&
    uid         integer NOT NULL, $&
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
    erros       integer DEFAULT 0, $&
    ano         integer NOT NULL, $&
    mes         integer NOT NULL, $&
    semana      varchar(3) NOT NULL, $&
    dia         integer NOT NULL, $&
    timestamp   integet NOT NULL, $&
    top         integer NOT NULL);

  l Estrutura criada..
  l Criando estrutura da tabela info...

  sqlite_exec %sql.db $&
    CREATE TABLE infos ( $&
    id          integer PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, $&
    ano         integer NOT NULL, $&
    mes         integer NOT NULL, $&
    semana      varchar(3) NOT NULL, $&
    dia         integer NOT NULL, $&
    timestamp   integet NOT NULL);

  l Estrutura criada

  disc
}

alias insert_data {
  conn
  l Inserindo dados
  l -

  var %sql.f = 1  
  while (%sql.f <= $findfile(users,*.ini,0)) { 
    dll WhileFix.dll WhileFix .

    var %sql.nick = $readini($findfile(users,*.ini,%sql.f),$ini($findfile(users,*.ini,%sql.f),1),nick)

    var %sql.query = INSERT INTO "users" ("id","uid","nick","cosmo","dinheiro","meritos","vitorias","empates","derrotas","narradas","armadura","itens","nascimento","acertos","erros","ano","mes","semana","dia","timestamp","top") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    var %sql.stmt = $sqlite_prepare(%sql.db,%sql.query)

    ;; binds

    noop $sqlite_bind_value(%sql.stmt,1,$null)
    noop $sqlite_bind_value(%sql.stmt,2,$dados(%sql.nick,id))
    noop $sqlite_bind_value(%sql.stmt,3,%sql.nick,$SQLITE_TEXT)
    noop $sqlite_bind_value(%sql.stmt,4,$int($dados(%sql.nick,Cosmo)))
    noop $sqlite_bind_value(%sql.stmt,5,$dados(%sql.nick,Dinheiro))
    noop $sqlite_bind_value(%sql.stmt,6,$iif($dados(%sql.nick,meritos) == $null,0,$dados(%sql.nick,meritos)))
    noop $sqlite_bind_value(%sql.stmt,7,$dados(%sql.nick,Vitorias))
    noop $sqlite_bind_value(%sql.stmt,8,$dados(%sql.nick,Empates))
    noop $sqlite_bind_value(%sql.stmt,9,$dados(%sql.nick,Derrotas))
    noop $sqlite_bind_value(%sql.stmt,10,$dados(%sql.nick,Narradas))
    noop $sqlite_bind_value(%sql.stmt,11,$dados(%sql.nick,Armadura),$SQLITE_TEXT)
    noop $sqlite_bind_value(%sql.stmt,12,$dados(%sql.nick,Itens),$SQLITE_TEXT)
    noop $sqlite_bind_value(%sql.stmt,13,$+($dados(%sql.nick,DiaNas),/,$dados(%sql.nick,MesNas),/,$dados(%sql.nick,AnoNas)),$SQLITE_TEXT)
    noop $sqlite_bind_value(%sql.stmt,14,$iif($dados(%sql.nick,acertoper) == $null,0,$dados(%sql.nick,acertoper)))
    noop $sqlite_bind_value(%sql.stmt,15,$iif($dados(%sql.nick,errosperg) == $null,0,$dados(%sql.nick,errosperg)))
    noop $sqlite_bind_value(%sql.stmt,16,$asctime(yyyy))
    noop $sqlite_bind_value(%sql.stmt,17,$asctime(mm))
    noop $sqlite_bind_value(%sql.stmt,18,$asctime(ddd),$SQLITE_TEXT)
    noop $sqlite_bind_value(%sql.stmt,19,$asctime(dd))
    noop $sqlite_bind_value(%sql.stmt,20,$ctime)
    noop $sqlite_bind_value(%sql.stmt,21,$top(%sql.nick))

    l %sql.f $+ . %sql.nick  15(uid:  $+ $dados(%sql.nick,id) $+ )01 source:  $+ $nopath($findfile(users,*.ini,%sql.f)) $+  01-> 03ok!

    ;; exec

    sqlite_exec %sql.stmt
    sqlite_free %sql.stmt

    inc %sql.f
  }  
  l -
  l Finalizado!
}

alias update_info {
  conn

  l Atualizando informações sobre update...

  var %sql.query = INSERT INTO "infos" ("id","ano","mes","semana","dia","timestamp") VALUES (?,?,?,?,?,?)
  var %sql.stmt = $sqlite_prepare(%sql.db,%sql.query)

  ;; binds

  noop $sqlite_bind_value(%sql.stmt,1,$null) 
  noop $sqlite_bind_value(%sql.stmt,2,$asctime(yyyy)) 
  noop $sqlite_bind_value(%sql.stmt,3,$asctime(mm)) 
  noop $sqlite_bind_value(%sql.stmt,4,$asctime(ddd),$SQLITE_TEXT)
  noop $sqlite_bind_value(%sql.stmt,5,$asctime(dd))
  noop $sqlite_bind_value(%sql.stmt,6,$ctime)

  ;; exec

  sqlite_exec %sql.stmt
  sqlite_free %sql.stmt

  l Atualização finalizada
}


;; para os testes

alias reset {
  if (%sql.db) { disc }
  clear @sql
  l Resetando...
  .remove $scriptdircdzf.db
  atutop
  create_db
  insert_data
  update_info
}
