/*
** mIRC SQLite v1.3.0
**
** Author: Reko Tiira [ ramirez ]
** E-mail: reko@tiira.net
** Date: 18th August 2009
** IRC: ramirez @ irc.undernet.org [ #mircscripting ]
**      ramirez @ irc.swiftirc.net [ #msl ]
**
** Please see msqlite.chm for documentation.
** 
** Any questions, suggestions and such should be
** e-mailed at the above e-mail.
*/

/*
** SQLite Constants
*/

alias SQLITE_OK                   return 0
alias SQLITE_ERROR                return 1
alias SQLITE_INTERNAL             return 2
alias SQLITE_PERM                 return 3
alias SQLITE_ABORT                return 4
alias SQLITE_BUSY                 return 5
alias SQLITE_LOCKED               return 6
alias SQLITE_NOMEM                return 7
alias SQLITE_READONLY             return 8
alias SQLITE_INTERRUPT            return 9
alias SQLITE_IOERR                return 10
alias SQLITE_CORRUPT              return 11
alias SQLITE_NOTFOUND             return 12
alias SQLITE_FULL                 return 13
alias SQLITE_CANTOPEN             return 14
alias SQLITE_PROTOCOL             return 15
alias SQLITE_EMPTY                return 16
alias SQLITE_SCHEMA               return 17
alias SQLITE_TOOBIG               return 18
alias SQLITE_CONSTRAINT           return 19
alias SQLITE_MISMATCH             return 20
alias SQLITE_MISUSE               return 21
alias SQLITE_NOLFS                return 22
alias SQLITE_AUTH                 return 23
alias SQLITE_FORMAT               return 24
alias SQLITE_RANGE                return 25
alias SQLITE_NOTADB               return 26
alias SQLITE_INVALIDARG           return 200
alias SQLITE_NOMOREROWS           return 201
alias SQLITE_NOTMEMORYDB          return 202

alias SQLITE_BEG                  return 1
alias SQLITE_CUR                  return 2
alias SQLITE_END                  return 3

alias SQLITE_BOTH                 return 1
alias SQLITE_NUM                  return 2
alias SQLITE_ASSOC                return 3

alias SQLITE_ALL                  return 1
alias SQLITE_BOUND                return 2

alias SQLITE_INTEGER              return 1
alias SQLITE_FLOAT                return 2
alias SQLITE_TEXT                 return 3
alias SQLITE_BLOB                 return 4
alias SQLITE_NULL                 return 5

alias SQLITE_DENY                 return 1
alias SQLITE_IGNORE               return 2

alias SQLITE_CREATE_INDEX         return 1
alias SQLITE_CREATE_TABLE         return 2
alias SQLITE_CREATE_TEMP_INDEX    return 3
alias SQLITE_CREATE_TEMP_TABLE    return 4
alias SQLITE_CREATE_TEMP_TRIGGER  return 5
alias SQLITE_CREATE_TEMP_VIEW     return 6
alias SQLITE_CREATE_TRIGGER       return 7
alias SQLITE_CREATE_VIEW          return 8
alias SQLITE_DELETE               return 9
alias SQLITE_DROP_INDEX           return 10
alias SQLITE_DROP_TABLE           return 11
alias SQLITE_DROP_TEMP_INDEX      return 12
alias SQLITE_DROP_TEMP_TABLE      return 13
alias SQLITE_DROP_TEMP_TRIGGER    return 14
alias SQLITE_DROP_TEMP_VIEW       return 15
alias SQLITE_DROP_TRIGGER         return 16
alias SQLITE_DROP_VIEW            return 17
alias SQLITE_INSERT               return 18
alias SQLITE_PRAGMA               return 19
alias SQLITE_READ                 return 20
alias SQLITE_SELECT               return 21
alias SQLITE_TRANSACTION          return 22
alias SQLITE_UPDATE               return 23
alias SQLITE_ATTACH               return 24
alias SQLITE_DETACH               return 25
alias SQLITE_ALTER_TABLE          return 26
alias SQLITE_REINDEX              return 27
alias SQLITE_ANALYZE              return 28
alias SQLITE_CREATE_VTABLE        return 29
alias SQLITE_DROP_VTABLE          return 30
alias SQLITE_FUNCTION             return 31

/*
** On Load Event
*/

on *:LOAD:{
  if ($version < 6.2) {
    echo 4 -a Obsolete mIRC version $version
    echo 4 -a mSQLite requires at least mIRC 6.2
    echo 4 -a Script wasn't loaded.
    unload -rs $+(",$script,")
    halt
  }

  echo 3 -a mIRC SQLite loaded successfully.
}

/*
** SQLite DLL Path
*/

alias -l sqlite_dll return $qt($+($scriptdir,msqlite.dll))

/*
** SQLite API
*/

;;; <summary>Opens the help file.</summary>
;;; <syntax>/sqlite_help</syntax>
alias sqlite_help {
  run $+($scriptdir,msqlite.chm)
}

;;; <summary>Returns the version of the SQLite library.</summary>
;;; <syntax>$sqlite_libversion</syntax>
;;; <returns>The version of the library.</returns>
;;; <remarks>
;;; The returned version is delimited by periods and has 3 different numbers indicating the version: a <b>major</b>, a <b>minor</b> and a <b>revision</b> number.
;;; For example 1.2.3 means that major version is 1, minor 2 and the revision number is 3.
;;; </remarks>
;;; <example>
;;; ; Displays the SQLite version to an active window
;;; //echo -a SQLite Version: $sqlite_libversion
;;;
;;; ; Example output:
;;; ; SQLite Version: 3.3.6
;;; </example>
;;; <seealso>sqlite_dllversion</seealso>
alias sqlite_libversion {
  return $dll($sqlite_dll, msqlite_libversion, $null)
}

;;; <summary>Returns the version of the mIRC SQLite DLL.</summary>
;;; <syntax>$sqlite_dllversion</syntax>
;;; <returns>The version of the library.</returns>
;;; <remarks>
;;; The returned version is delimited by periods and has 3 different numbers indicating the version: a <i>major</i>, a <i>minor</i> and a <i>revision</i> number.
;;; For example 1.2.3 means that major version is 1, minor 2 and the revision number is 3.
;;; </remarks>
;;; <example>
;;; ; Displays the DLL version to an active window
;;; //echo -a DLL Version: $sqlite_dllversion
;;;
;;; ; Example output:
;;; ; DLL Version: 1.0.0
;;; </example>
;;; <seealso>sqlite_libversion</seealso>
alias sqlite_dllversion {
  return $dll($sqlite_dll, msqlite_dllversion, $null)
}

;;; <summary>Returns a textual representation of an error code.</summary>
;;; <syntax>$sqlite_error_string ( errcode )</syntax>
;;; <param name="errcode">The error code to format.</param>
;;; <returns>A formatted, textual representation of <i>errcode</i>.</returns>
;;; <example>
;;; ; Displays textual representation of the latest error code which is stored in %sqlite_errno
;;; var %err = %sqlite_errno
;;; echo -a Last Error: $sqlite_error_string(%err)
;;;
;;; ; Example output:
;;; ; Last Error: not an error
;;; </example>
;;; <seealso>sqlite_last_error</seealso>
alias sqlite_error_string {
  return $dll($sqlite_dll, msqlite_error_string, $1)
}

;;; <summary>Opens a SQLite database.</summary>
;;; <syntax>$sqlite_open ( [ db [, from ] ] )</syntax>
;;; <param name="db">The filename of the database to open. Optional, see remarks for details.</param>
;;; <param name="from">The filename of the database to create memory database from. Optional, see remarks for details.</param>
;;; <returns>A positive, numeric connection identifier if successful, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; The <i>db</i> argument is optional, if it isn't specified, a transient database is opened in a temporary file. If specified, and the file <i>db</i> doesn't exist, an empty database will be created on that file.
;;;
;;; If <i>db</i> is equal to the special keyword <b>:memory:</b> a memory database is opened instead of a file database. If <i>from</i> is specified the memory database will contain a copy of the specified database, otherwise an empty memory database is created. If file <i>from</i> doesn't exist, an empty database will be created on that file.
;;; <i>from</i> is only valid when <b>:memory:</b> is used, otherwise an error is raised.
;;;
;;; If <b>$null</b> is returned you can determine the exact reason for the error by checking the value of <b>%sqlite_errstr</b>.
;;; For more information about error handling, see <a href="errors.html">Handling Errors</a>
;;; </remarks>
;;; <example>
;;; ; Opens a database and displays the status after. Closes the db if it was opened successfully.
;;; var %db = $sqlite_open(test.db)
;;; if (%db) {
;;;   echo -a Database opened successfully.
;;;   sqlite_close %db
;;; }
;;; else {
;;;   echo -a Error opening database: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_close</seealso>
;;; <seealso>sqlite_open_memory</seealso>
;;; <seealso>sqlite_write_to_file</seealso>
alias sqlite_open {
  return $dll($sqlite_dll, msqlite_open, $qt($1) $iif($2, $qt($2)))
}

;;; <summary>Opens a SQLite memory database.</summary>
;;; <syntax>$sqlite_open_memory ( [ from ] )</syntax>
;;; <param name="from">The filename of the database to create memory database from. Optional, see remarks for details.</param>
;;; <returns>A positive, numeric connection identifier if successful, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; This function is identical to using <a href="sqlite_open.html">$sqlite_open</a> with the first argument <i>db</i> set to special keyword <b>:memory:</b>. See its reference for details.
;;; </remarks>
;;; <example>
;;; ; Opens a database and displays the status after. Closes the db if it was opened successfully.
;;; var %db = $sqlite_open_memory()
;;; if (%db) {
;;;   echo -a Memory database created and opened successfully.
;;;   sqlite_close %db
;;; }
;;; else {
;;;   echo -a Error opening a memory database: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_open</seealso>
;;; <seealso>sqlite_close</seealso>
;;; <seealso>sqlite_write_to_file</seealso>
alias sqlite_open_memory {
  return $sqlite_open(:memory:, $1)
}

;;; <summary>Closes an open SQLite database connection.</summary>
;;; <syntax>$sqlite_close ( conn )</syntax>
;;; <syntax>/sqlite_close conn</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns><b>1</b> if connection was closed successfully, or <b>$null</b> if there was an error.</returns>
;;; <remarks>It is usually ok to ignore the return value of $sqlite_close because the only case an error is returned is when an invalid <i>conn</i> is specified.</remarks>
;;; <example>
;;; ; Opens a database and displays the status after. Closes the db if it was opened successfully.
;;; var %db = $sqlite_open(test.db)
;;; if (%db) {
;;;   echo -a Database opened successfully.
;;;   sqlite_close %db
;;; }
;;; else {
;;;   echo -a Error opening database: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_open</seealso>
alias sqlite_close {
  return $dll($sqlite_dll, msqlite_close, $1)
}

;;; <summary>Executes a result-less SQL query.</summary>
;;; <syntax>$sqlite_exec ( conn, query [, bind_value [, ... ] ] ) [ .file ]</syntax>
;;; <syntax>/sqlite_exec conn query</syntax>
;;; <syntax>$sqlite_exec ( statement [, bind_value [, ... ] ] )</syntax>
;;; <syntax>/sqlite_exec statement [ bind_value [ ... ] ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="query">The query to execute.</param>
;;; <param name="statement">A prepared statement to execute.</param>
;;; <param name="bind_value">Optional. One or more values to bind to the query.</param>
;;; <prop name="file">Optional. If specified the query parameter is treated as a filename instead, and that file will be executed as SQL.</prop>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; To execute a prepared statement, first prepare it with <a href="sqlite_prepare.html">$sqlite_prepare</a>.
;;; To learn about prepared statements and binding values, see <a href="prepared.html">Prepared Statements</a>.
;;;
;;; If <b>$null</b> is returned you can determine the exact reason for the error by checking the value of <b>%sqlite_errstr</b>.
;;; For more information about error handling, see <a href="errors.html">Handling Errors</a>
;;;
;;; Note that if you want to bind a text value with more than one word, you must use the identifier form of syntax. If you don't care about the return value, you can use the built-in mIRC command <b>/noop</b>
;;;
;;; Starting from mSQLite version 1.2.0 you can bind values even for non-prepared statements, but this only works when calling $sqlite_exec as an identifier.
;;;
;;; $sqlite_exec can execute multiple queries seperated by semicolons.
;;; To see guidelines for writing SQL queries with mIRC SQLite, see <a href="queries.html">Writing Queries</a>.
;;; </remarks>
;;; <example>
;;; ; Inserts data to a table, assumes that a db connection is already established
;;; var %sql = INSERT INTO table (key, value) VALUES ('version', '1.0.0')
;;; if ($sqlite_exec(%db, %sql)) {
;;;   echo -a Query executed succesfully.
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso href="queries.html">Writing Queries</seealso>
;;; <seealso href="binary.html">Handling Binary Data</seealso>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_unbuffered_query</seealso>
alias sqlite_exec {
  var %id = $gettok($1, 1, 32), %file = 0
  if ($sqlite_is_valid_statement(%id)) {
    var %bind, %i = 2
    while (%i <= $0) {
      var %value = $ [ $+ [ %i ] ]
      %bind = %bind $+(",$replace(%value,\,\\,",\"),")
      inc %i
    }
    return $dll($sqlite_dll, msqlite_exec, %id %bind)
  }
  else if ($isid) {
    var %params = $calc($0 - 2)
    if ($prop == file) {
      %file = 1
    }
    if (%params > 0) {
      var %bind, %i = 3
      while (%i <= $0) {
        var %value = $ [ $+ [ %i ] ]
        %bind = %bind $+(",$replace(%value,\,\\,",\"),")
        inc %i
      }
      return $dll($sqlite_dll, msqlite_exec, %id %file %params %bind $2)
    }
  }
  return $dll($sqlite_dll, msqlite_exec, %id %file 0 $2-)
}

;;; <summary>Executes a result-less SQL query from a file.</summary>
;;; <syntax>$sqlite_exec_file ( conn, file [, bind_value [, ... ] ] )</syntax>
;;; <syntax>/sqlite_exec_file conn file</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="file">The file to execute.</param>
;;; <param name="bind_value">Optional. One or more values to bind to the query.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; This is an alias for <a href="sqlite_exec.html">$sqlite_exec(...).file</a>
;;;
;;; This command is useful for executing a long query or multiple queries.
;;; One common use is executing an initialization query file after loading a script.
;;; </remarks>
;;; <example>
;;; ; A possible LOAD event for a script
;;; on *:LOAD:{
;;;   var %db = $sqlite_open(script.db)
;;;   sqlite_exec_file %db init.sql
;;;   sqlite_close %db
;;; }
;;; </example>
;;; <seealso href="queries.html">Writing Queries</seealso>
;;; <seealso href="binary.html">Handling Binary Data</seealso>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_exec</seealso>
alias sqlite_exec_file {
  if (!$isid || $0 < 3) {
    return $sqlite_exec($1, $2).file
  }
  else {
    var %params, %i = 1
    while (%i <= $0) {
      %params = $+(%params,$iif(%params,$chr(44)),$ $+ %i)
      inc %i
    }
    var %cmd = $!sqlite_exec( $+ %params $+ ).file
    return [ [ %cmd ] ]
  }
}

;;; <summary>Executes a SQL query and returns data returned by it.</summary>
;;; <syntax>$sqlite_query ( conn, query [, bind_value [, ... ] ] ) [ .file ]</syntax>
;;; <syntax>/sqlite_query conn query</syntax>
;;; <syntax>$sqlite_query ( statement [, bind_value [, ... ] ] )</syntax>
;;; <syntax>/sqlite_query statement [ bind_value [ ... ] ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="query">The query to execute.</param>
;;; <param name="statement">A prepared statement to execute.</param>
;;; <param name="bind_value">Optional. One or more values to bind to the query.</param>
;;; <prop name="file">Optional. If specified the query parameter is treated as a filename instead, and that file will be executed as SQL.</prop>
;;; <returns>A positive, numeric result identifier or <b>0</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; To execute a prepared statement first prepare it with <a href="sqlite_prepare.html">$sqlite_prepare</a>.
;;; To learn about prepared statements and binding values, see <a href="prepared.html">Prepared Statements</a>.
;;;
;;; In case of <b>0</b> is returned, it means that $sqlite_query was used to execute a query that doesn't return any data, such as INSERT or UPDATE.
;;; A SELECT query always returns a result identifier on success, even if the query selected no rows. You can use <b>$sqlite_num_rows</b> to determine how many rows were returned.
;;;
;;; If <b>$null</b> is returned you can determine the exact reason for the error by checking the value of <b>%sqlite_errstr</b>.
;;; For more information about error handling, see <a href="errors.html">Handling Errors</a>
;;;
;;; Note that if you want to bind a text value with more than one word, you must use the identifier form of syntax. If you don't care about the return value, you can use the built-in mIRC command <b>/noop</b>
;;;
;;; Starting from mSQLite version 1.2.0 you can bind values even for non-prepared statements, but this only works when calling $sqlite_query as an identifier.
;;;
;;; $sqlite_query can execute multiple queries seperated by semicolons. The returned result is the data returned by the last SQL query.
;;; To see guidelines for writing SQL queries with mIRC SQLite, see <a href="queries.html">Writing Queries</a>.
;;; </remarks>
;;; <example>
;;; ; Selects data from a table and fetches it, assumes that a db connection is already established
;;; var %sql = SELECT col, another FROM table
;;; var %request = $sqlite_query(%db, %sql)
;;; if (%request) {
;;;   echo -a Query executed successfully.
;;;   sqlite_free %request
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso href="queries.html">Writing Queries</seealso>
;;; <seealso href="binary.html">Handling Binary Data</seealso>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_unbuffered_query</seealso>
;;; <seealso>sqlite_exec</seealso>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_bound</seealso>
;;; <seealso>sqlite_fetch_single</seealso>
;;; <seealso>sqlite_num_rows</seealso>
;;; <seealso>sqlite_free</seealso>
alias sqlite_query {
  var %id = $gettok($1, 1, 32), %file = 0
  if ($sqlite_is_valid_statement(%id)) {
    var %bind, %i = 2
    while (%i <= $0) {
      var %value = $ [ $+ [ %i ] ]
      %bind = %bind $+(",$replace(%value,\,\\,",\"),")
      inc %i
    }
    return $dll($sqlite_dll, msqlite_query, %id %bind)
  }
  elseif ($isid) {
    var %params = $calc($0 - 2)
    if ($prop == file) {
      %file = 1
    }
    if (%params > 0) {
      var %bind, %i = 3
      while (%i <= $0) {
        var %value = $ [ $+ [ %i ] ]
        %bind = %bind $+(",$replace(%value,\,\\,",\"),")
        inc %i
      }
      return $dll($sqlite_dll, msqlite_query, %id %file %params %bind $2)
    }
  }
  return $dll($sqlite_dll, msqlite_query, %id %file 0 $2-)
}

;;; <summary>Executes a SQL query and returns data returned by it.</summary>
;;; <syntax>$sqlite_unbuffered_query ( conn, query [, bind_value [, ... ] ] ) [ .file ]</syntax>
;;; <syntax>/sqlite_unbuffered_query conn query</syntax>
;;; <syntax>$sqlite_unbuffered_query ( statement [, bind_value [, ... ] ] )</syntax>
;;; <syntax>/sqlite_unbuffered_query statement [ bind_value [ ... ] ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="query">The query to execute.</param>
;;; <param name="statement">A prepared statement to execute.</param>
;;; <param name="bind_value">Optional. One or more values to bind to the query.</param>
;;; <prop name="file">Optional. If specified the query parameter is treated as a filename instead, and that file will be executed as SQL.</prop>
;;; <returns>A positive, numeric result identifier or <b>0</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; To execute a prepared statement, first prepare it with <a href="sqlite_prepare.html">$sqlite_prepare</a>.
;;; To learn about prepared statements and binding values, see <a href="prepared.html">Prepared Statements</a>.
;;;
;;; Unbuffered queries work like regular queries, except that they produce a result set that isn't buffered in memory. Since the rows aren't buffered in memory, unbuffered queries are the optimal way to handle large set of sequental data because they're more efficient and the memory footprint is much smaller.
;;; The trade off is that you can't random-access the unbuffered result set, like you can with buffered result sets. The following functions aren't supported on unbuffered results: <a href="sqlite_num_rows.html">sqlite_num_rows</a>, <a href="sqlite_current.html">sqlite_current</a>, <a href="sqlite_current_bound.html">sqlite_current_bound</a>, <a href="sqlite_result.html">sqlite_result</a>, <a href="sqlite_next.html">sqlite_next</a>, <a href="sqlite_prev.html">sqlite_prev</a>, <a href="sqlite_has_more.html">sqlite_has_more</a>, <a href="sqlite_has_prev.html">sqlite_has_prev</a>, <a href="sqlite_seek.html">sqlite_seek</a>, <a href="sqlite_rewind.html">sqlite_rewind</a> and <a href="sqlite_key.html">sqlite_key</a>.
;;;
;;; Remember to free the result with <a href="sqlite_free.html">sqlite_free</a> when done with the result set. If there's unfetched rows in the result set, and it isn't freed it might block other queries from executing.
;;;
;;; In case of <b>0</b> is returned, it means that $sqlite_unbuffered_query was used to execute a query that doesn't return any data, such as INSERT or UPDATE.
;;; A SELECT query always returns a result identifier on success, even if the query selected no rows. You can use <b>$sqlite_num_rows</b> to determine how many rows were returned.
;;;
;;; If <b>$null</b> is returned you can determine the exact reason for the error by checking the value of <b>%sqlite_errstr</b>.
;;; For more information about error handling, see <a href="errors.html">Handling Errors</a>
;;;
;;; Note that if you want to bind a text value with more than one word, you must use the identifier form of syntax. If you don't care about the return value, you can use the built-in mIRC command <b>/noop</b>
;;;
;;; Starting from mSQLite version 1.2.0 you can bind values even for non-prepared statements, but this only works when calling $sqlite_unbuffered_query as an identifier.
;;;
;;; $sqlite_unbuffered_query can execute multiple queries seperated by semicolons. The returned result is the data returned by the last SQL query.
;;; To see guidelines for writing SQL queries with mIRC SQLite, see <a href="queries.html">Writing Queries</a>.
;;;
;;; For an example, see <a href="sqlite_query.html">$sqlite_query</a>.
;;; </remarks>
;;; <seealso href="queries.html">Writing Queries</seealso>
;;; <seealso href="binary.html">Handling Binary Data</seealso>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_exec</seealso>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_bound</seealso>
;;; <seealso>sqlite_fetch_single</seealso>
;;; <seealso>sqlite_num_rows</seealso>
;;; <seealso>sqlite_free</seealso>
alias sqlite_unbuffered_query {
  var %id = $gettok($1, 1, 32), %file = 0
  if ($sqlite_is_valid_statement(%id)) {
    var %bind, %i = 2
    while (%i <= $0) {
      var %value = $ [ $+ [ %i ] ]
      %bind = %bind $+(",$replace(%value,\,\\,",\"),")
      inc %i
    }
    return $dll($sqlite_dll, msqlite_unbuffered_query, %id %bind)
  }
  elseif ($isid) {
    var %params = $calc($0 - 2)
    if ($prop == file) {
      %file = 1
    }
    if (%params > 0) {
      var %bind, %i = 3
      while (%i <= $0) {
        var %value = $ [ $+ [ %i ] ]
        %bind = %bind $+(",$replace(%value,\,\\,",\"),")
        inc %i
      }
      return $dll($sqlite_dll, msqlite_unbuffered_query, %id %file %params %bind $2)
    }
  }
  return $dll($sqlite_dll, msqlite_unbuffered_query, %id %file 0 $2-)
}

;;; <summary>Frees a query result or prepared statement.</summary>
;;; <syntax>$sqlite_free ( result )</syntax>
;;; <syntax>/sqlite_free result</syntax>
;;; <syntax>$sqlite_free ( statement )</syntax>
;;; <syntax>/sqlite_free statement</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="statement">The statement identifier.</param>
;;; <returns><b>1</b> if the result was freed successfully, or <b>$null</b> if there was an error.</returns>
;;; <remarks>It is usually ok to ignore the return value of $sqlite_free because the only case an error is returned is when an invalid <i>result</i> is specified.</remarks>
;;; <example>
;;; ; Selects data from a table and then frees it (unpractical, only shows usage)
;;; var %sql = SELECT * FROM table
;;; var %request = $sqlite_query(%db, %sql)
;;; if (%request) {
;;;   echo -a Query executed succesfully. Freeing data.
;;;   sqlite_free %request
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_finalize</seealso>
alias sqlite_free {
  return $dll($sqlite_dll, msqlite_free, $1)
}

;;; <summary>Frees a query result or prepared statement.</summary>
;;; <syntax>$sqlite_finalize ( result )</syntax>
;;; <syntax>/sqlite_finalize result</syntax>
;;; <syntax>$sqlite_finalize ( statement )</syntax>
;;; <syntax>/sqlite_finalize statement</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="statement">The statement identifier.</param>
;;; <returns><b>1</b> if the result was freed successfully, or <b>$null</b> if there was an error.</returns>
;;; <remarks>This is an alias for <a href="sqlite_free.html">$sqlite_free</a> provided for convience for those, who prefer to use finalize when freeing prepared statements.</remarks>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_free</seealso>
alias sqlite_finalize {
  return $sqlite_free($1)
}

;;; <summary>Escapes a string for use as a query parameter.</summary>
;;; <syntax>$sqlite_escape_string ( string )</syntax>
;;; <param name="string">The string to escape.</param>
;;; <returns>Escaped string.</returns>
;;; <remarks>
;;; $sqlite_escape_string escapes the specific <i>string</i> so that it can be used safely in queries.
;;; You should always call $sqlite_escape_string on user input to avoid SQL injection.
;;; </remarks>
;;; <example>
;;; var %str = $?="Input a string:"
;;; var %sql = INSERT INTO table (value) VALUES (' $+ $sqlite_escape_string(%str) $+ ')
;;; ; %sql can now be safely executed
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_exec</seealso>
;;; <seealso>sqlite_qt</seealso>
alias sqlite_escape_string {
  return $replace($1-, ', '')
}

;;; <summary>Returns a number of rows in a result.</summary>
;;; <syntax>$sqlite_num_rows ( result )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns>The number of rows in the result on success, or <b>$null</b> if there was an error.</returns>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT * FROM table
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   echo -a Number of rows returned: $sqlite_num_rows(%res)
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_num_fields</seealso>
alias sqlite_num_rows {
  return $dll($sqlite_dll, msqlite_num_rows, $1)
}

;;; <summary>Returns a number of fields in a result.</summary>
;;; <syntax>$sqlite_num_fields ( result )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns>The number of fields in the result on success, or <b>$null</b> if there was an error.</returns>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT * FROM table
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   echo -a Number of fields returned: $sqlite_num_fields(%res)
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_num_rows</seealso>
alias sqlite_num_fields {
  return $dll($sqlite_dll, msqlite_num_fields, $1)
}

;;; <summary>Returns a number of affected rows of the last INSERT, UPDATE or DELETE query.</summary>
;;; <syntax>$sqlite_changes ( conn )</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns>The number of affected rows on success, or <b>$null</b> if there was an error.</returns>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = UPDATE publishers SET publisher = 'Square Enix' WHERE publisher = 'Squaresoft'
;;; if ($sqlite_exec(%db, %sql)) {
;;;   echo -a Number of rows affected: $sqlite_changes(%db)
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_exec</seealso>
;;; <seealso>sqlite_query</seealso>
alias sqlite_changes {
  return $dll($sqlite_dll, msqlite_changes, $1)
}

;;; <summary>Returns the row id of the most recently inserted row.</summary>
;;; <syntax>$sqlite_last_insert_rowid ( conn )</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns>The row id on success, or <b>$null</b> if there was an error.</returns>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = INSERT INTO publishers (publisher) VALUES ('Square Enix')
;;; if ($sqlite_exec(%db, %sql)) {
;;;   echo -a Insrted row id: $sqlite_last_insert_rowid(%db)
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_exec</seealso>
;;; <seealso>sqlite_query</seealso>
alias sqlite_last_insert_rowid {
  return $dll($sqlite_dll, msqlite_last_insert_rowid, $1)
}

;;; <summary>Returns the name of the specified field.</summary>
;;; <syntax>$sqlite_field_name ( result, field_index )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="field_index">The ordinal index of the field. The first field has an index of 1.</param>
;;; <returns>The name of the field on success, or <b>$null</b> if there was an error.</returns>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT * FROM table
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   echo -a Name of the first field: $sqlite_field_name(%res, 1)
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
alias sqlite_field_name {
  return $dll($sqlite_dll, msqlite_field_name, $gettok($1, 1, 32) $2)
}

;;; <summary>Returns the type of the specified field.</summary>
;;; <syntax>$sqlite_field_type ( result, field_index [, row_index ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="field_index">The ordinal index of the field. The first field has an index of 1.</param>
;;; <param name="row_index">The row index to get the type for. Optional; If result is unbuffered or if omitted current row is assumed.</param>
;;; <returns>The type of the field on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; The returned type can be one of the following values: <b>$SQLITE_INTEGER</b>, <b>$SQLITE_FLOAT</b>, <b>$SQLITE_TEXT</b>, <b>$SQLITE_BLOB</b> and <b>$SQLITE_NULL</b>.
;;;
;;; SQLite uses so called manifest typing, which means that field types aren't static.
;;; This means that every row can store any type for any field. $sqlite_field_type can be used to determine the type of the field for a specified row.
;;; There are exceptions to this, for details see <a href="http://www.sqlite.org/datatype3.html" target="_blank">Datatypes In SQLite Version 3</a>.
;;; </remarks>
;;; <seealso>sqlite_query</seealso>
alias sqlite_field_type {
  return $dll($sqlite_dll, msqlite_field_type, $gettok($1, 1, 32) $2)
}

;;; <summary>Fetches the current row from a result and then advances to the next row.</summary>
;;; <syntax>$sqlite_fetch_row ( result, hash_table [, result_type ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="hash_table">The name of the hash table to where to store the row data.</param>
;;; <param name="result_type">The type of the result. Optional, see remarks for more info.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if there are no more rows available, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_fetch_row fetches the next row from the <i>result</i> and stores the data in <i>hash_table</i>.
;;; If the hash table doesn't exist, it will be created; Otherwise it will be cleared before new data is stored.
;;;
;;; <i>result_type</i> specifies how the hash table is created, it can be one of the following: <b>$SQLITE_NUM</b>, <b>$SQLITE_ASSOC</b> or <b>$SQLITE_BOTH</b>. $SQLITE_BOTH is default.
;;; If $SQLITE_NUM is used, the hash table items will be field indexes, starting from index 1. If $SQLITE_ASSOC is used, the items will be field names. If $SQLITE_BOTH is used, both column indexes and names are used.
;;; In case of $SQLITE_BOTH, if some of the column names are identical to another columns' index, the index has priority and will be used as an item.
;;; </remarks>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT first_name, last_name FROM contacts
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   echo -a Fetching results...
;;;   echo -a -
;;;   while ($sqlite_fetch_row(%res, row, $SQLITE_ASSOC)) {
;;;     ; If you used $SQLITE_FETCH_NUM or $SQLITE_FETCH_BOTH you could use 1 instead of first_name and 2 instead of last_name
;;;     echo -a First name: $hget(row, first_name)
;;;     echo -a Last name: $hget(row, last_name)
;;;     echo -a -
;;;   }
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_fetch_single</seealso>
alias sqlite_fetch_row {
  return $dll($sqlite_dll, msqlite_fetch_row, $gettok($1, 1, 32) $gettok($2, 1, 32) $3)
}

;;; <summary>Fetches the current row from a result and then advances to the next row.</summary>
;;; <syntax>$sqlite_fetch_num ( result, hash_table )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="hash_table">The name of the hash table to where to store the row data.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if there are no more rows available, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; <b>$sqlite_fetch_num</b> is provided for convenience. All it does is call <a href="sqlite_fetch_row.html">$sqlite_fetch_row</a> with <i>result_type</i> set to <b>$SQLITE_NUM</b>
;;; </remarks>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_assoc</seealso>
alias sqlite_fetch_num {
  return $sqlite_fetch_row($1, $2, $SQLITE_NUM)
}

;;; <summary>Fetches the current row from a result and then advances to the next row.</summary>
;;; <syntax>$sqlite_fetch_assoc ( result, hash_table )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="hash_table">The name of the hash table to where to store the row data.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if there are no more rows available, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; <b>$sqlite_fetch_assoc</b> is provided for convenience. All it does is call <a href="sqlite_fetch_row.html">$sqlite_fetch_row</a> with <i>result_type</i> set to <b>$SQLITE_ASSOC</b>
;;; </remarks>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_num</seealso>
alias sqlite_fetch_assoc {
  return $sqlite_fetch_row($1, $2, $SQLITE_ASSOC)
}

;;; <summary>Fetches the current row from a result and assigns the column values in variables and then advances to the next row.</summary>
;;; <syntax>$sqlite_fetch_bound ( result [, bind_type ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="bind_type">The type of the bind. Optional, see remarks for more info.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if there are no more rows available, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_fetch_bound fetches the next row from the <i>result</i> and assigns the column data in variables specified by <a href="sqlite_fetch_field.html">$sqlite_fetch_field</a>.
;;;
;;; <i>bind_type</i> specifies how the values are bound, it can be one of the following: <b>$SQLITE_ALL</b> or <b>$SQLITE_BOUND</b>. $SQLITE_BOUND is default.
;;; If $SQLITE_BOUND is specified, only columns that have been bound with <a href="sqlite_fetch_field.html">$sqlite_fetch_field</a> are fetched in variables. If $SQLITE_ALL is specified all rows are fetched, even ones that haven't been bound explicitly with <a href="sqlite_fetch_field.html">$sqlite_fetch_field</a>. In this case the column names are used as variable names. Depending on whether the column type is binary or not, a regular variable or a binary variable will be used.
;;;
;;; The bound variables are set as global variables when fetched, because mSQLite has no access to local variables. You should be very careful that you don't override any existing global variables, especially when $SQLITE_ALL is used!
;;; </remarks>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT first_name, last_name, address FROM contacts
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   ; The first column will be bound to %name
;;;   sqlite_bind_field %result 1 name
;;;   ; The third column will be bound to %postal_address
;;;   sqlite_bind_field %result address first_name
;;;   ; The second column will be bound automatically to %last_name with $SQLITE_ALL
;;;   echo -a Fetching results...
;;;   echo -a -
;;;   while ($sqlite_fetch_bound(%res, $SQLITE_ALL)) {
;;;     ; If you used $SQLITE_BOUND, %last_name would not exist because it wasn't bound explicitly with sqlite_bind_field
;;;     echo -a First name: %name
;;;     echo -a Last name: %last_name
;;;     echo -a Address: %postal_address
;;;     echo -a -
;;;   }
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_bind_field</seealso>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_single</seealso>
alias sqlite_fetch_bound {
  tokenize 32 $dll($sqlite_dll, msqlite_fetch_bound, $gettok($1, 1, 32) $2)
  if ($0 == 1) {
    return $1
  }
  if ($0 == 3) {
    var %file = $1, %i = 1, %total = $numtok($2, 124), %offset = 0
    while (%i <= %total) {
      var %size = $gettok($2, %i, 124), %bvar = $gettok($3, %i, 124)
      bread %file %offset %size %bvar
      inc %offset %size
      inc %i
    }
    return 1
  }
  return $null
}

;;; <summary>Fetches and returns the first column of the current row from a result and then advances to the next row.</summary>
;;; <syntax>$sqlite_fetch_single ( result [, &binvar ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="binvar">The name of the binary variable to assign binary data to. Optional.</param>
;;; <returns>The value of the first column of the fetched row if <i>&binvar</i> isn't specified, otherwise the size of the binary variable on success, <b>$null</b> if there are no more rows, or if there was an error.</returns>
;;; <remarks>
;;; If <i>&binvar</i> is specified the behaviour of $sqlite_fetch_single changes slightly. Instead of returning the first column's value, it will assign it to a binvar and return the binvar's size on success.
;;; In case the first column is not blob type, its text representation will be stored in the <i>&binvar</i> as sequential ascii values. If <i>&binvar</i> isn't set, but the first column is a blob, it will be converted to text.
;;; For more information about handling binary data in mSQLite, see <a href="binary.html">Handling Binary Data</a>
;;; 
;;; In case of <b>$null</b> is returned it can mean three different things:
;;; <b>1.</b> The returned value from SQLite database is NULL.
;;; <b>2.</b> There are no more rows available.
;;; <b>3.</b> There was an error.
;;;
;;; To determine the cause of $null, examine the <b>%sqlite_errno</b> variable after calling $sqlite_fetch_single. The returned value can be one of the following:
;;; <b>1.</b> <b>$SQLITE_OK</b> if there was no error.
;;; <b>2.</b> <b>$SQLITE_NOMOREROWS</b> if there are no more rows available.
;;; <b>3.</b> Some other of the <a href="errors.html">Error Codes</a> if there was an error.
;;; </remarks>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT COUNT(*) FROM contacts
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   echo -a Number of rows in contacts: $sqlite_fetch_single(%res)
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_field</seealso>
alias sqlite_fetch_single {
  if ($0 < 2) {
    return $dll($sqlite_dll, msqlite_fetch_single, $1)
  }
  else {
    tokenize 32 $dll($sqlite_dll, msqlite_fetch_single, $gettok($1, 1, 32) $2)
    if ($0 == 3) {
      bread $1 0 $2 $3
      return $bvar($3, 0)
    }
    return $null
  }
}

;;; <summary>Fetches and returns the specified column of the current row from a result and then advances to the next row.</summary>
;;; <syntax>$sqlite_fetch_field ( result, field [, &binvar ] ) [ .name ]</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="field">The field index or name. See remarks for details.</param>
;;; <param name="binvar">The name of the binary variable to assign binary data to. Optional.</param>
;;; <prop name="name">Forces field to be treated as name.</prop>
;;; <returns>The value of the specified column of the fetched row if <i>&binvar</i> isn't specified, otherwise the size of the binary variable on success, <b>$null</b> if there are no more rows, or if there was an error.</returns>
;;; <remarks>
;;; $sqlite_fetch_field is identical to $sqlite_fetch_single with the only difference being that $sqlite_fetch_field returns a value of specified column, instead of the first column.
;;;
;;; If <i>field</i> is numeric it is treated as an ordinal index for the column, first column being 1, otherwise it is treated as the column's name. You can use the <b>.name</b> property to force the field to be treated as column name even if it's a number.
;;;
;;; See <a href="sqlite_fetch_single.html">$sqlite_fetch_single</a> for more details.
;;; </remarks>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT 1, 'test' AS '1'
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   ; This treats 1 as field ordinal, thus first column is returned
;;;   echo -a Fetch 1st field: $sqlite_fetch_field(%res, 1)
;;;   ; Go back to previous row because $sqlite_fetch_field increments row counter
;;;   sqlite_rewind %res
;;;   ; This treats 1 as field nane because of the .name property, second column is returned
;;;   echo -a Fetch 2nd field: $sqlite_fetch_field(%res, 1).name
;;;   ; Free result
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;;
;;; ; Output:
;;; ; Fetch 1st field: 1
;;; ; Fetch 2nd field: a
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_single</seealso>
;;; <seealso>sqlite_result</seealso>
alias sqlite_fetch_field {
  if ($0 < 3) {
    return $dll($sqlite_dll, msqlite_fetch_field, $1 $iif($2 !isnum || $prop == name, 1, 0) $2 1)
  }
  else {
    tokenize 32 $dll($sqlite_dll, msqlite_fetch_field, $1 $iif($2 !isnum || $prop == name, 1, 0) $2 1 $3)
    if ($0 == 3) {
      bread $1 0 $2 $3
      return $bvar($3, 0)
    }
    return $null
  }
}

;;; <summary>Fetches everything into a file.</summary>
;;; <syntax>$sqlite_fetch_all ( result, file [, delim = 9 ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="file">The output filename.</param>
;;; <param name="delim">Optional. Delimiter in ASCII used to separate fields.</param>
;;; <returns><b>1</b> on success or <b>$null</b> on error.</returns>
;;; <remarks>
;;; <b>$sqlite_fetch_all</b> is useful for fetching everything into a single file if you wish to process it using a command such as <i>/filter</i> or <i>/play</i> through custom alias.
;;;
;;; Each line in the resulting fill will consist of a single row. All fields in the line are separated by <b>delim</b>, which is TAB by default. You can specify your own delimiter.
;;;
;;; Because it's possible that the data for a field in a row can consist of unsafe characters that would mess up the rows/fields, mIRC SQLite encodes the special characters in the resulting file.
;;; The characters that are encoded are: \ (backslash), \n (newline), \r (carriage return), \0 (null-byte, in binary data) and whatever delimiter is used. The characters are encoded as an escape sequence \xNN where NN is a two-digit hexadecimal number.
;;; You can decode the data with <a href="sqlite_safe_decode.html">$sqlite_safe_decode</a> if you need to.
;;; </remarks>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_fetch_row</seealso>
;;; <seealso>sqlite_fetch_single</seealso>
;;; <seealso>sqlite_fetch_field</seealso>
;;; <seealso>sqlite_safe_encode</seealso>
;;; <seealso>sqlite_safe_decode</seealso>
alias sqlite_fetch_all {
  var %delim = $iif($0 >= 3, $gettok($3, 1, 32), 9)
  return $dll($sqlite_dll, msqlite_fetch_all, $gettok($1, 1, 32) %delim $2)
}

;;; <summary>Returns whether or not more rows are available.</summary>
;;; <syntax>$sqlite_has_more ( result )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns><b>1</b> if there are more rows available; Otherwise <b>0</b> if there are no more rows available, or <b>$null</b> if there was an error.</returns>
;;; <example>
;;; ; This code assumes a connection is already established and stored in %db
;;; var %sql = SELECT * FROM table
;;; var %res = $sqlite_query(%db, %sql)
;;; if (%res) {
;;;   ; Counts number of rows, unpractical as you could just use $sqlite_num_rows, this is only to show usage
;;;   var %rows = 0
;;;   while ($sqlite_has_more(%res)) {
;;;     sqlite_next %res
;;;     inc %rows
;;;   }
;;;   echo -a Number of rows returned: %rows
;;;   sqlite_free %res
;;; }
;;; else {
;;;   echo -a Error executing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_num_rows</seealso>
;;; <seealso>sqlite_next</seealso>
;;; <seealso>sqlite_prev</seealso>
;;; <seealso>sqlite_has_prev</seealso>
alias sqlite_has_more {
  return $dll($sqlite_dll, msqlite_has_more, $1)
}

;;; <summary>Returns whether or not a previous row is available.</summary>
;;; <syntax>$sqlite_has_prev ( result )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns><b>1</b> if there is a previous available; Otherwise <b>0</b> if there is no previous row available, or <b>$null</b> if there was an error.</returns>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_num_rows</seealso>
;;; <seealso>sqlite_prev</seealso>
;;; <seealso>sqlite_next</seealso>
;;; <seealso>sqlite_has_more</seealso>
alias sqlite_has_prev {
  return $dll($sqlite_dll, msqlite_has_prev, $1)
}

;;; <summary>Seek to the next row number.</summary>
;;; <syntax>$sqlite_next ( result )</syntax>
;;; <syntax>/sqlite_next result</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if there are no more rows available, or <b>$null</b> if there was an error.</returns>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_num_rows</seealso>
;;; <seealso>sqlite_prev</seealso>
;;; <seealso>sqlite_has_more</seealso>
;;; <seealso>sqlite_has_prev</seealso>
alias sqlite_next {
  return $dll($sqlite_dll, msqlite_next, $1)
}

;;; <summary>Seek to the previous row number.</summary>
;;; <syntax>$sqlite_prev ( result )</syntax>
;;; <syntax>/sqlite_prev result</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if there is no previous row available, or <b>$null</b> if there was an error.</returns>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_num_rows</seealso>
;;; <seealso>sqlite_next</seealso>
;;; <seealso>sqlite_has_more</seealso>
;;; <seealso>sqlite_has_prev</seealso>
alias sqlite_prev {
  return $dll($sqlite_dll, msqlite_prev, $1)
}

;;; <summary>Seek to a particular row.</summary>
;;; <syntax>$sqlite_seek ( result, row_index [, seek_type ] )</syntax>
;;; <syntax>/sqlite_seek result row_index [ seek_type ]</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="row_index">The row to seek to.</param>
;;; <param name="seek_type">The seek type. Optional, see remarks for more info.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if the row isn't seekable, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; The optional <i>seek_type</i> parameter specifies the direction and offset of seek and can be one of the following: <b>$SQLITE_BEG</b>, <b>$SQLITE_CUR</b> or <b>$SQLITE_END</b>. $SQLITE_BEG is default.
;;; $SQLITE_BEG seeks forward from the start of the result. $SQLITE_CUR seeks forward from the current position of the result. $SQLITE_END seeks backwards from the end of the result.
;;; </remarks>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_key</seealso>
alias sqlite_seek {
  return $dll($sqlite_dll, msqlite_seek, $gettok($1, 1, 32) $2)
}

;;; <summary>Seeks to the first row.</summary>
;;; <syntax>$sqlite_rewind ( result )</syntax>
;;; <syntax>/sqlite_rewind result</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if the result isn't rewindable, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_rewind is equivalent to calling <b>$sqlite_seek</b> with row value of 1 and seek_type of <b>$SQLITE_BEG</b>.
;;; </remarks>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_key</seealso>
;;; <seealso>sqlite_rewind</seealso>
alias sqlite_rewind {
  return $sqlite_seek($1, 1, $SQLITE_BEG)
}

;;; <summary>Returns the current row number of a result.</summary>
;;; <syntax>$sqlite_key ( result )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns>The current row number on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_rewind is equivalent to calling <b>$sqlite_seek</b> with row value of 1 and seek_type of <b>$SQLITE_BEG</b>.
;;; </remarks>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_key</seealso>
;;; <seealso>sqlite_rewind</seealso>
alias sqlite_key {
  return $dll($sqlite_dll, msqlite_key, $1)
}

;;; <summary>Fetches the current row from a result.</summary>
;;; <syntax>$sqlite_current ( result, hash_table [, result_type ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="hash_table">The name of the hash table to where to store the row data.</param>
;;; <param name="result_type">The type of the result. Optional, see remarks for more info.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if the current row position is beyond final row, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_current is identical to <a href="sqlite_fetch_row.html">$sqlite_fetch_row</a> except it doesn't advance to the next row.
;;; </remarks>
;;; <seealso>sqlite_fetch_row</seealso>
alias sqlite_current {
  return $dll($sqlite_dll, msqlite_current, $gettok($1, 1, 32) $gettok($2, 1, 32) $3)
}

;;; <summary>Fetches the current row from a result and assigns the column values in variables.</summary>
;;; <syntax>$sqlite_current_bound ( result [, bind_type ] )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="bind_type">The type of the bind. Optional, see remarks for more info.</param>
;;; <returns><b>1</b> on success; Otherwise <b>0</b> if the current row position is beyond final row, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_current_bound is identical to <a href="sqlite_fetch_bound.html">$sqlite_fetch_bound</a> except it doesn't advance to the next row.
;;; </remarks>
;;; <seealso>sqlite_fetch_bound</seealso>
alias sqlite_current_bound {
  return $dll($sqlite_dll, msqlite_current_bound, $gettok($1, 1, 32) $gettok($2, 1, 32) $3)
}

;;; <summary>Fetches and returns the specified column of the current row from a result.</summary>
;;; <syntax>$sqlite_result ( result, field [, &binvar ] ) [ .name ]</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="field">The field index or name. See remarks for details.</param>
;;; <param name="binvar">The name of the binary variable to assign binary data to. Optional.</param>
;;; <prop name="name">Forces field to be treated as name.</prop>
;;; <returns>The value of the specified column of the fetched row if <i>&binvar</i> isn't specified, otherwise the size of the binary variable on success, <b>$null</b> if there are no more rows, or if there was an error.</returns>
;;; <remarks>
;;; $sqlite_result is identical to <a href="sqlite_fetch_field.html">$sqlite_fetch_field</a> except it doesn't advance to the next row.
;;; </remarks>
;;; <seealso>sqlite_fetch_field</seealso>
alias sqlite_result {
  if ($0 < 3) {
    return $dll($sqlite_dll, msqlite_fetch_field, $1 $iif($2 !isnum || $prop == name, 1, 0) $2 0)
  }
  else {
    tokenize 32 $dll($sqlite_dll, msqlite_fetch_field, $1 $iif($2 !isnum || $prop == name, 1, 0) $2 0 $3)
    if ($0 == 3) {
      bread $1 0 $2 $3
      return $bvar($3, 0)
    }
    return $null
  }
}

;;; <summary>Sets the busy timeout duration or disables busy handlers.</summary>
;;; <syntax>$sqlite_busy_timeout ( conn, milliseconds )</syntax>
;;; <syntax>/sqlite_busy_timeout conn  milliseconds</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="milliseconds">The number of milliseconds.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; Set the maximum time, in milliseconds, that SQLite will wait for a <i>conn</i> to become ready for use.
;;; Use <b>0</b> for <i>milliseconds</i> to disable busy handlers.
;;;
;;; You can set the default busy timeout in the mSQLite configuration file, see <a href="conf.html">Configuring mIRC SQLite</a> for details.
;;; It is usually ok to ignore the return value of $sqlite_busy_timeout because the only case an error is returned is when an invalid <i>conn</i> is specified.
;;; </remarks>
alias sqlite_busy_timeout {
  return $dll($sqlite_dll, msqlite_busy_timeout, $gettok($1, 1, 32) $2)
}

;;; <summary>Register an user defined function.</summary>
;;; <syntax>$sqlite_create_function ( conn, func_name, func_alias [, num_args [, prop ] ] )</syntax>
;;; <syntax>/sqlite_create_function conn func_name func_alias [ num_args [ prop ] ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="func_name">The SQL function name to register.</param>
;;; <param name="func_alias">The mIRC alias to register as function.</param>
;;; <param name="num_args">The number of arguments the function accepts. Optional.</param>
;;; <param name="prop">A custom property you want to use with alias name. Optional.</param>
;;; <returns><b>1</b> if the function was registered successfully, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_create_function allows users to register their own functions in SQL.
;;; You can also use $sqlite_create_function to override default functionality of SQLite's core functions.
;;;
;;; The optional argument <i>num_args</i> can be used to hint SQLite if there's a predetermined amount of arguments.
;;; If an user defined function is used with different parameter count as what was instructed with <i>num_args</i>, the query will raise an SQL error.
;;; The default, <b>-1</b>, means that an arbitrary number of parameters can be passed to the function.
;;;
;;; It is usually ok to ignore the return value of $sqlite_create_function if you know that the parameters are valid.
;;; For more information about user defined functions, see <a href="functions.html">User Defined Functions</a>.
;;; </remarks>
;;; <example>
;;; ; Returns a specified amount of characters from left side of a md5 generated string
;;; alias md5_left {
;;;   var %str = $1, %len = $2
;;;   return $left($md5(%str), %len)
;;; }
;;;
;;; ; Registers the user defined function in an existing connection %db
;;; sqlite_create_function %db md5_left md5_left 2
;;;
;;; ; Registers mIRC's $base as convert_base (3 first parameters, no zeropadding or precision)
;;; sqlite_create_function %db convert_base base 3
;;;
;;; ; Example queries
;;; ; SELECT md5_left(value, 8) FROM strings
;;; ; SELECT convert_base(15, 10, 16)
;;; </example>
;;; <seealso href="functions.html">User Defined Functions</seealso>
;;; <seealso href="limits.html">Function Limitations</seealso>
;;; <seealso>sqlite_create_aggregate</seealso>
alias sqlite_create_function {
  return $dll($sqlite_dll, msqlite_create_function, $gettok($1, 1, 32) $gettok($2, 1, 32) $gettok($3, 1, 32) $gettok($4, 1, 32) $5)
}

;;; <summary>Register an user defined aggregate.</summary>
;;; <syntax>$sqlite_create_aggregate ( conn, func_name, step_alias, finalize_alias [, num_args [, step_prop [, finalize_prop ] ] ] )</syntax>
;;; <syntax>/sqlite_create_aggregate conn func_name step_alias finalize_alias [ num_args [ step_prop [ finalize_prop ] ] ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="func_name">The SQL function name to register.</param>
;;; <param name="step_alias">The mIRC alias to register as step function.</param>
;;; <param name="finalize_alias">The mIRC alias to register as finalize function.</param>
;;; <param name="num_args">The number of arguments the function accepts. Optional.</param>
;;; <param name="step_prop">A custom property you want to use for step alias. Optional.</param>
;;; <param name="finalize_prop">A custom property you want to use for finalize alias. Optional.</param>
;;; <returns><b>1</b> if the function was registered successfully, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_create_aggregate allows users to register their own aggregates in SQL.
;;; You can also use $sqlite_create_aggregate to override default functionality of SQLite's core aggregates.
;;;
;;; Creating aggregate functions is similiar to creating ordinary functions.
;;; The key difference is that $sqlite_create_aggregate requires two mIRC aliases to be registered:
;;; <i>step_alias</i> is called for each row in a group, it is used to accumulate data.
;;; <i>finalize_alias</i> is called after all the rows are processed, it is used to return the result to the query.
;;;
;;; <i>step_alias</i> and <i>finalize_alias</i> always receive an aggregate context as first parameter.
;;; The <i>step_alias</i> can use the aggregate context to accumulate data. It should return the aggregate context at end.
;;; When <i>finalize_alias</i> is called it can use the aggregate context to determine the accumuluted result.
;;; Parameters passed to the function in the SQL query are passed after the aggregate context.
;;;
;;; The optional argument <i>num_args</i> can be used to hint SQLite if there's a predetermined amount of arguments.
;;; If an user defined function is used with different parameter count as what was instructed with <i>num_args</i>, the query will raise an SQL error.
;;; The default, <b>-1</b>, means that an arbitrary number of parameters can be passed to the function.
;;;
;;; It is usually ok to ignore the return value of $sqlite_create_function if you know that the parameters are valid.
;;; For more information about user defined aggregates, see <a href="functions.html">User Defined Functions</a> and <a href="aggregates.html">User Defined Aggregates</a>.
;;; </remarks>
;;; <example>
;;; ; Creates an aggregate to return the max length of a string
;;; alias max_len_step {
;;;   var %context = $1, %len = $len($2)
;;;   if (%context !isnum || %len > %context) {
;;;     %context = %len
;;;   }
;;;   return %context
;;; }
;;;
;;; alias max_len_finalize {
;;;   var %context = $1
;;;   if (%context !isnum) {
;;;     %context = 0
;;;   }
;;;   return %context
;;; }
;;;
;;; ; Registers the user defined function in an existing connection %db
;;; sqlite_create_aggregate %db max_len max_len_step max_len_finalize
;;;
;;; ; Example queries
;;; ; SELECT max_len(value) FROM strings
;;; ; SELECT max_len(first_name) FROM contacts GROUP BY last_name
;;; </example>
;;; <seealso href="functions.html">User Defined Functions</seealso>
;;; <seealso href="aggregates.html">User Defined Aggregates</seealso>
;;; <seealso href="limits.html">Function Limitations</seealso>
;;; <seealso>sqlite_create_function</seealso>
alias sqlite_create_aggregate {
  return $dll($sqlite_dll, msqlite_create_aggregate, $gettok($1, 1, 32) $gettok($2, 1, 32) $gettok($3, 1, 32) $gettok($4, 1, 32) $gettok($5, 1, 32) $gettok($6, 1, 32) $7)
}

;;; <summary>Allows user defined functions to signal an error.</summary>
;;; <syntax>$sqlite_signal_error ( error )</syntax>
;;; <syntax>/sqlite_signal_error error</syntax>
;;; <param name="error">The error to be signaled.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; It is usually ok to ignore the return value of $sqlite_signal_error because the only case an error is returned it's called from an alias that isn't an user defined function.
;;; </remarks>
;;; <example>
;;; ; User defined function
;;; alias udf_error {
;;;   sqlite_signal_error this function will always signal an error
;;; }
;;;
;;; ; Example, always outputs error
;;; sqlite_create_function udf_error udf_error -1
;;; sqlite_exec SELECT udf_error()
;;; if (%sqlite_errno != $SQLITE_OK) {
;;;   echo 4 -a %sqlite_errstr
;;; }
;;; </example>
;;; <example>
;;; ; Another way to signal an error
;;; alias udf_another_error {
;;;   return $sqlite_signal_error(this function will always signal an error)
;;;   echo -a This part is never reached!
;;; }
;;; </example>
;;; <seealso href="functions.html">User Defined Functions</seealso>
;;; <seealso href="aggregates.html">User Defined Aggregates</seealso>
;;; <seealso href="limits.html">Function Limitations</seealso>
alias sqlite_signal_error {
  return $dll($sqlite_dll, msqlite_signal_error, $1-)
}

;;; <summary>Add single quotes around text.</summary>
;;; <syntax>$sqlite_qt ( text )</syntax>
;;; <param name="text">The text to be single quoted.</param>
;;; <returns>The single quoted text.</returns>
;;; <remarks>
;;; This is an auxiliary identifier that can be used to quote data prior to using them in queries.
;;; You should this instead of the mIRC's <i>$qt</i> identifier, the reason is explained in <a href="faq.html">FAQ</a>, under the question "Should I use single or double quotes for string literals?"
;;; </remarks>
;;; <example>
;;; ; Escape data, and then add quotes around it
;;; %data = $sqlite_qt($sqlite_escape_string(%data))
;;; ; Execute a query
;;; sqlite_exec %db INSERT INTO table (data) VALUES ( %data )
;;; </example>
;;; <seealso>sqlite_escape_string</seealso>
alias sqlite_qt {
  return $+(',$1-,')
}

;;; <summary>Retrieves meta information about a specific column.</summary>
;;; <syntax>$sqlite_field_metadata ( conn [, database ], table, column, htable )</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="database">The database name where table exists. Optional, see remarks for details.</param>
;;; <param name="table">The table name where column exists.</param>
;;; <param name="column">The column to get meta information about.</param>
;;; <param name="htable">The hash table to assign results to.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; This identifier fetches meta information about a specific column, and assigns the results to <i>htable</i>.
;;; The hash table will have the following items set:
;;; [pre]
;;; <b>dattype</b>   The declared data type, eg. <i>INTEGER</i>
;;; <b>collseq</b>   The collation sequence name, eg. <i>BINARY</i>
;;; <b>notnull</b>   1 if <i>NOT NULL</i> constraint exists, otherwise 0
;;; <b>primkey</b>   1 if column is part of <i>PRIMARY KEY</i>, otherwise 0
;;; <b>autoinc</b>   1 if column is <i>AUTOINCREMENT</i>, otherwise 0
;;; [/pre]
;;; The <i>database</i> argument is optional. If omitted all attached databases in <i>conn</i> will be searched for the specified table.
;;; </remarks>
alias sqlite_field_metadata {
  return $dll($sqlite_dll, msqlite_field_metadata, $1-)
}

;;; <summary>Loads a dynamic extension.</summary>
;;; <syntax>$sqlite_load_extension ( conn, filename [, entrypoint ] )</syntax>
;;; <syntax>/sqlite_load_extension conn filename [ entrypoint ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="filename">The filename of the extension.</param>
;;; <param name="entrypoint">The entrypoint of the extension Optional, see remarks for details.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; This function loads a dynamic extension <i>filename</i>. Dynamic extensions are useful for creating efficient custom functions and <a href="http://www.sqlite.org/cvstrac/wiki?p=VirtualTables" target="_blank">virtual table modules</a>.
;;; The optional parameter <i>entrypoint</i> specifies the initialization function within the extension. If omitted, the entrypoint will default to <b>sqlite3_extension_init</b>, which is recommended. See SQLite Wiki's <a href="http://www.sqlite.org/cvstrac/wiki?p=LoadableExtensions" target="_blank">Loadable Extensions</a> article for details and more information.
;;;
;;; <b>NOTE.</b> The loadable extension API, as well as the virtual table API, is still beta in SQLite, hence if there are any changes in the API in the future, the changes might also reflect in mSQLite.
;;; </remarks>
alias sqlite_load_extension {
  return $dll($sqlite_dll, msqlite_load_extension, $gettok($1, 1, 32) $gettok($2, 1, 32) $3)
}

;;; <summary>Checks if a database connection is valid.</summary>
;;; <syntax>$sqlite_is_valid_conn ( conn )</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns><b>1</b> if <i>conn</i> is a valid connection, <b>0</b> if it's invalid, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; It is usually ok to ignore if $sqlite_is_valid_conn returns $null because the only case an error is returned is when <i>conn</i> isn't specified.
;;; </remarks>
;;; <seealso>sqlite_open</seealso>
;;; <seealso>sqlite_is_valid_result</seealso>
;;; <seealso>sqlite_is_valid_statement</seealso>
;;; <seealso>sqlite_is_memory</seealso>
alias sqlite_is_valid_conn {
  return $dll($sqlite_dll, msqlite_is_valid_conn, $1)
}

;;; <summary>Checks if a result is valid.</summary>
;;; <syntax>$sqlite_is_valid_result ( result )</syntax>
;;; <param name="result">The result identifier.</param>
;;; <returns><b>1</b> if <i>result</i> is a valid result, <b>0</b> if it's invalid, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; It is usually ok to ignore if $sqlite_is_valid_result returns $null because the only case an error is returned is when <i>result</i> isn't specified.
;;; </remarks>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_is_valid_conn</seealso>
;;; <seealso>sqlite_is_valid_statement</seealso>
;;; <seealso>sqlite_is_memory</seealso>
alias sqlite_is_valid_result {
  return $dll($sqlite_dll, msqlite_is_valid_result, $1)
}

;;; <summary>Checks if a prepared statement is valid.</summary>
;;; <syntax>$sqlite_is_valid_statement ( statement )</syntax>
;;; <param name="result">The statement identifier.</param>
;;; <returns><b>1</b> if <i>statement</i> is a valid prepared statement, <b>0</b> if it's invalid, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; It is usually ok to ignore if $sqlite_is_valid_statement returns $null because the only case an error is returned is when <i>statement</i> isn't specified.
;;; </remarks>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_is_valid_conn</seealso>
;;; <seealso>sqlite_is_valid_result</seealso>
;;; <seealso>sqlite_is_memory</seealso>
alias sqlite_is_valid_statement {
  return $dll($sqlite_dll, msqlite_is_valid_statement, $1)
}

;;; <summary>Checks whether database is memory database or not.</summary>
;;; <syntax>$sqlite_is_memory ( conn )</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns><b>1</b> if <i>conn</i> is a memory database, <b>0</b> if it's file database, or <b>$null</b> if there was an error.</returns>
;;; <seealso>sqlite_is_valid_conn</seealso>
;;; <seealso>sqlite_is_valid_result</seealso>
alias sqlite_is_memory {
  return $dll($sqlite_dll, msqlite_is_memory, $1)
}

;;; <summary>Writes a memory database to a file.</summary>
;;; <syntax>$sqlite_write_to_file ( conn, file )</syntax>
;;; <syntax>/sqlite_write_to_file conn file </syntax>
;;; <param name="conn">The connection identifier of a memory database.</param>
;;; <param name="file">The filename to save the memory database to.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; This function allows you to write a memory database to a file. It's useful if you want to work with a database on memory for vastly improved speed, but also keep a permanent copy on disk. Another common use is to debug errors by dumping a memory database to file so you can examine the contents with your favorite visual editor.
;;; </remarks>
alias sqlite_write_to_file {
  return $dll($sqlite_dll, msqlite_write_to_file, $gettok($1, 1, 32) $qt($2-))
}

;;; <summary>Reloads the configuration file.</summary>
;;; <syntax>/sqlite_reload</syntax>
;;; <remarks>
;;; This command allows you to reload the configuration file in case you have made changes but don't want to reload the whole DLL.
;;; </remarks>
alias sqlite_reload {
  noop $dll($sqlite_dll, msqlite_reload, $null)
}

;;; <summary>Registers an authorizer for a connection.</summary>
;;; <syntax>$sqlite_set_authorizer ( conn, authorizer_alias [, prop ] )</syntax>
;;; <syntax>/sqlite_set_authorizer conn authorizer_alias [ prop ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="authorizer_alias">The mIRC alias to register as an authorizer.</param>
;;; <param name="prop">A custom property you want to use with alias name. Optional.</param>
;;; <returns><b>1</b> if the authorizer was registered successfully, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; An authorizer lets you to examine what kind of query SQLite is trying to run, and change the behavior of the result by either denying the operation, or ignoring it. The foremost purpose of an authorizer is to allow scripts to safely execute user-entered SQL queries, without compromising security of the database.
;;;
;;; Only one authorizer can be registered at a time for a connection. Setting a new authorizer for a connection will override the old authorizer, if one is registered. You can unregister the authorizer by passing <b>$null</b> for <i>authorizer_alias</i>.
;;;
;;; The authorizer should return <b>$SQLITE_OK</b> if the current action should be allowed, <b>$SQLITE_DENY</b> if it should be denied (generates an error) or <b>$SQLITE_IGNORE</b> if it should be ignored (treated as a no-op). You can use an authorizer to make certain columns or functions return NULL by returning $SQLITE_IGNORE for the corresponding action (see below). Returning any other value than the ones previously mentioned will auto-assume $SQLITE_OK.
;;;
;;; The authorizer alias will receive a few arguments. The first argument is the type of action SQLite is performing. The second and third argument provide additional information depending on what type of an action is in question. The fourth argument is the name of the database (eg. "main" or "temp") where applicable. The fifth argument is the name of the inner-most trigger or view that triggered the authorizer, or <b>$null</b> if the authorizer was triggered directly from code.
;;;
;;; You can see all the possible types of action that authorizer can be triggered for below, and the associated arguments for it (the 2nd and 3rd arguments of the authorizer alias).
;;; <pre style="font-weight: bold;">Type                          Value     2nd Arg         3rd Arg</pre><pre>$SQLITE_CREATE_INDEX              1     Index Name      Table Name
;;; $SQLITE_CREATE_TABLE              2     Table Name      <i>$null</i>
;;; $SQLITE_CREATE_TEMP_INDEX         3     Index Name      Table Name
;;; $SQLITE_CREATE_TEMP_TABLE         4     Table Name      <i>$null</i>
;;; $SQLITE_CREATE_TEMP_TRIGGER       5     Trigger Name    Table name
;;; $SQLITE_CREATE_TEMP_VIEW          6     View Name       <i>$null</i>
;;; $SQLITE_CREATE_TRIGGER            7     Trigger name    Table Name
;;; $SQLITE_CREATE_VIEW               8     View Name       <i>$null</i>
;;; $SQLITE_DELETE                    9     Table Name      <i>$null</i>
;;; $SQLITE_DROP_INDEX               10     Index Name      Table Name
;;; $SQLITE_DROP_TABLE               11     Table Name      <i>$null</i>
;;; $SQLITE_DROP_TEMP_INDEX          12     Index Name      Table Name
;;; $SQLITE_DROP_TEMP_TABLE          13     Table Name      <i>$null</i>
;;; $SQLITE_DROP_TEMP_TRIGGER        14     Trigger Name    Table Name
;;; $SQLITE_DROP_TEMP_VIEW           15     View Name       <i>$null</i>
;;; $SQLITE_DROP_TRIGGER             16     Trigger Name    Table Name
;;; $SQLITE_DROP_VIEW                17     View Name       <i>$null</i>
;;; $SQLITE_INSERT                   18     Table Name      <i>$null</i>
;;; $SQLITE_PRAGMA                   19     Pragma Name     1st Arg or <i>$null</i>
;;; $SQLITE_READ                     20     Table Name      Column Name
;;; $SQLITE_SELECT                   21     <i>$null</i>           <i>$null</i>
;;; $SQLITE_TRANSACTION              22     <i>$null</i>           <i>$null</i>
;;; $SQLITE_UPDATE                   23     Table Name      Column Name
;;; $SQLITE_ATTACH                   24     Filename        <i>$null</i>
;;; $SQLITE_DETACH                   25     Database Name   <i>$null</i>
;;; $SQLITE_ALTER_TABLE              26     Database Name   Table Name
;;; $SQLITE_REINDEX                  27     Index Name      <i>$null</i>
;;; $SQLITE_ANALYZE                  28     Table Name      <i>$null</i>
;;; $SQLITE_CREATE_VTABLE            29     Table Name      Module Name
;;; $SQLITE_DROP_VTABLE              30     Table Name      Module Name
;;; $SQLITE_FUNCTION                 31     Function Name   <i>$null</i></pre>
;;; </remarks>
;;; <example>
;;; ; The following example demonstrates how to create an authorizer that:
;;; ; 1) Disallows queries of other type than SELECT.
;;; ; 2) Disallows access to certain columns by making SQLite return NULL for them.
;;; alias my_authorizer {
;;;   ; To make the function look cleaner, let's assign the tokens to variables.
;;;   var %type = $1
;;;   ; First deny queries other than SELECT
;;;   if (%type != $SQLITE_SELECT && %type != $SQLITE_READ && %type != $SQLITE_FUNCTION) {
;;;     ; Not authorized!
;;;     return $SQLITE_DENY
;;;   }
;;;   ; Next make sure that we aren't trying to access a "secret" column, eg. a password in an users table.
;;;   if (%type == $SQLITE_READ) {
;;;     var %table = $2, %column = $3
;;;     if (%table == users && %column == password) {
;;;       ; By returning $SQLITE_IGNORE SQLite will return NULL for this column. It's a good idea to do this instead
;;;       ; of denying the whole query, because in that case query such as "SELECT * FROM users" would fail as well.
;;;       return $SQLITE_IGNORE
;;;     }
;;;   }
;;;   ; Nothing special in this action, allow it.
;;;   return $SQLITE_OK
;;; }
;;;
;;; ; To register the authorizer do (assumes that %db exists):
;;; sqlite_set_authorizer %db my_authorizer
;;; </example>
alias sqlite_set_authorizer {
  if ($2 != $null) {
    return $dll($sqlite_dll, msqlite_set_authorizer, $gettok($1, 1, 32) $gettok($2, 1, 32) $3)
  }
  else {
    return $dll($sqlite_dll, msqlite_set_authorizer, $1)
  }
}

;;; <summary>Prepares a SQL query to be executed later.</summary>
;;; <syntax>$sqlite_prepare ( conn, query ) [ .file ]</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="query">The query to execute.</param>
;;; <prop name="file">Optional. If specified the query parameter is treated as a filename instead, and that file will be executed as SQL.</prop>
;;; <returns>A positive, numeric statement identifier on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; Prepared queries are efficient when you need to execute the same query many times with different parameters. This is because prepared query is only compiled once, and can then be executed without having to re-compile the query.
;;; You can bind parameters in prepared queries, for more information about prepared statements and parameter binding, see <a href="prepared.html">Prepared Statements</a>.
;;; Just like ordinary queries, prepared queries are executed with $sqlite_exec or $sqlite_query, see example below.
;;;
;;; If <b>$null</b> is returned you can determine the exact reason for the error by checking the value of <b>%sqlite_errstr</b>.
;;; For more information about error handling, see <a href="errors.html">Handling Errors</a>.
;;;
;;; <b>$sqlite_prepare</b> can only prepare a single query. Extra queries seperated by a semi-colon are ignored, only the first one is prepared.
;;; To see guidelines for writing SQL queries with mIRC SQLite, see <a href="queries.html">Writing Queries</a>.
;;; </remarks>
;;; <example>
;;; ; Inserts data into a table two times with different parameters
;;; var %sql = INSERT INTO table VALUES (?, :test)
;;; var %stmt = $sqlite_prepare(%db, %sql)
;;; if (%stmt) {
;;;   echo -a Query prepared successfully.
;;;
;;;   ; Binds Hello as first parameter, and World as second parameter and inserts the row
;;;   sqlite_bind_value %stmt 1 Hello
;;;   sqlite_bind_value %stmt :test World
;;;   sqlite_exec %stmt
;;;
;;;   ; Binds NULL as first parameter, and 100 as second parameter and inserts the row
;;;   sqlite_bind_null %stmt 1
;;;   sqlite_bind_value %stmt :test 100
;;;   sqlite_exec %stmt
;;;
;;;   ; Binds 'This is a test' as first parameter, and uses the previously bound parameter for second parameter
;;;   noop $sqlite_exec(%stmt, This is a test)
;;;
;;;   sqlite_free %stmt
;;; }
;;; else {
;;;   echo -a Error preparing query: %sqlite_errstr
;;; }
;;; </example>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_bind_column</seealso>
;;; <seealso>sqlite_bind_param</seealso>
;;; <seealso>sqlite_bind_value</seealso>
;;; <seealso>sqlite_exec</seealso>
;;; <seealso>sqlite_query</seealso>
;;; <seealso>sqlite_free</seealso>
alias sqlite_prepare {
  var %id = $gettok($1, 1, 32), %file = 0
  if ($isid && $prop == file) {
    %file = 1
  }
  return $dll($sqlite_dll, msqlite_prepare, %id %file $2-)
}


;;; <summary>Binds a column to a variable.</summary>
;;; <syntax>$sqlite_bind_field ( result, column, var ) [ .name ]</syntax>
;;; <syntax>/sqlite_bind_field result column var</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="column">The column number of name to bind for. Must exist in the result set.</param>
;;; <param name="var">The variable or binary variable to bind the column for.</param>
;;; <prop name="name">Forces column to be treated as name.</prop>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; The columns bound to variables with $sqlite_bind_field are used when fetching rows with <b>$sqlite_fetch_bound</b> or <b>$sqlite_current_bound</b>.
;;;
;;; If <i>column</i> is numeric it is treated as an ordinal index for the column, first column being 1, otherwise it is treated as the column's name. You can use the <b>.name</b> property to force the field to be treated as column name even if it's a number.
;;;
;;; The <i>var</i> parameter is considered as a binary variable if it starts with a <b>&</b>. Otherwise it's considered as a regular variable. You should <b>not</b> prefix the var with a <b>%</b>; otherwise mIRC will evaluate the variable right away.
;;;
;;; The bound variables are set as global variables when fetched, because mSQLite has no access to local variables. You should be very careful that you don't override any existing global variables.
;;;
;;; For more information about parameter binding, see <a href="prepared.html">Prepared Statements</a>.
;;;
;;; If you want to use the <b>.name</b> property to force the <i>column</i> to act as a column name, you must use the first form of the syntax. If you don't care about the return value, you can use the mIRC's built-in command <b>/noop</b>
;;; </remarks>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_bind_column</seealso>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_fetch_bound</seealso>
;;; <seealso>sqlite_current_bound</seealso>
alias sqlite_bind_field {
  return $dll($sqlite_dll, msqlite_bind_field, $gettok($1, 1, 32) $iif($2 !isnum || $prop == name, 1, 0) $gettok($2, 1, 32) $gettok($3, 1, 32))
}

;;; <summary>Binds a column to a variable.</summary>
;;; <syntax>$sqlite_bind_column ( result, column, var ) [ .name ]</syntax>
;;; <syntax>/sqlite_bind_column result column var</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="column">The column number of name to bind for. Must exist in the result set.</param>
;;; <param name="var">The variable or binary variable to bind the column for.</param>
;;; <prop name="name">Forces column to be treated as name.</prop>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>This is an alias for <a href="sqlite_bind_field.html">$sqlite_bind_field</a> provided for convience.</remarks>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_bind_field</seealso>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_fetch_bound</seealso>
alias sqlite_bind_column {
  return $sqlite_bind_field($1, $2, $3)
}

;;; <summary>Binds a variable as a parameter for prepared statement.</summary>
;;; <syntax>$sqlite_bind_param ( statement, param, var [, datatype ] )</syntax>
;;; <syntax>/sqlite_bind_param statement param var [ datatype ]</syntax>
;;; <param name="statement">The prepared statement identifier.</param>
;;; <param name="param">The parameter to bind to. Must exist in the prepared query.</param>
;;; <param name="var">The variable or binary variable to bind to.</param>
;;; <param name="datatype">Optional. Tells what datatype var is. See remarks.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_bind_param can be used to bind a variable to a parameter. The variable is bound as a reference and is evaluated at the time of execution. This means that by changing the variable in mIRC, you're effectively changing the bound value as well.
;;;
;;; The <i>param</i> parameter can either be a numerical index, specified with a <b>?</b> in the query, or a named parameter specified with a <b>:name</b> in the query. If binding a named parameter, you should also include the colon in the name.
;;;
;;; The <i>var</i> parameter is considered as a binary variable if it starts with a <b>&</b>. Otherwise it's considered as a regular variable. You should <b>not</b> prefix the var with a <b>%</b>; otherwise mIRC will evaluate the variable right away. If not a binary variable, the specified variable must be a global variable because local variables only exist in scope of the alias they're declared in; mSQLite has no access to them. See example below.
;;;
;;; If <i>datatype</i> is specified, it must be one of the <b>$SQLITE_INTEGER</b>, <b>$SQLITE_FLOAT</b>, <b>$SQLITE_TEXT</b>, <b>$SQLITE_BLOB</b> and <b>$SQLITE_NULL</b>. The datatype tells what datatype var is. If omitted, mSQLite will attempt to deduce the datatype of the variable at execution time. You should specify datatype when you want a numerical variable to act as a text for example.
;;;
;;; For more information about parameter binding, see <a href="prepared.html">Prepared Statements</a>.
;;; </remarks>
;;; <example>
;;; ; Open a temporary db
;;; var %db = $sqlite_open()
;;;
;;; ; Binds one numerical and one named parameter two times
;;; var %sql = SELECT ?, :test
;;; var %stmt = $sqlite_prepare(%db, %sql)
;;; if (%stmt) {
;;;   ; Binds %first as first parameter, and &second as second parameter.
;;;   ; Do not prefix the variable with a % or mIRC will evaluate the variable beforehand.
;;;   sqlite_bind_param %stmt 1 first
;;;   ; If datatype isn't specified the binary variable would be considered a blob by mSQLite.
;;;   sqlite_bind_param %stmt :test &second $SQLITE_TEXT
;;;
;;;   ; We can declare the variables after they're bound because they aren't evaluated before the query is executed.
;;;   set %first Hello
;;;   bset -t &second 1 World
;;;
;;;   ; Execute the query and show the results
;;;   var %result = $sqlite_query(%stmt)
;;;   if ($sqlite_fetch_row(%result, row, $SQLITE_NUM)) {
;;;     echo -a First execution:
;;;     echo -a 1st: $hget(row, 1)
;;;     echo -a 2nd: $hget(row, 2)
;;;   }
;;;   sqlite_free %result
;;;
;;;   ; Change the first parameter to something else, you don't need to call sqlite_bind_param again!
;;;   set %first Another
;;;
;;;   ; Execute the query again and show the new results
;;;   var %result = $sqlite_query(%stmt)
;;;   if ($sqlite_fetch_row(%result, row, $SQLITE_NUM)) {
;;;     echo -a Second execution:
;;;     echo -a 1st: $hget(row, 1)
;;;     echo -a 2nd: $hget(row, 2)
;;;   }
;;;   sqlite_free %result
;;;   sqlite_free %stmt
;;; }
;;; else {
;;;   echo -a Error preparing query: %sqlite_errstr
;;; }
;;;
;;; sqlite_close %db
;;;
;;; ; Output:
;;; ; First execution:
;;; ; 1st: Hello
;;; ; 2nd: World
;;; ; Second execution:
;;; ; 1st: Another
;;; ; 2nd: World
;;; </example>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_bind_field</seealso>
;;; <seealso>sqlite_bind_value</seealso>
alias sqlite_bind_param {
  return $dll($sqlite_dll, msqlite_bind_param, $gettok($1, 1, 32) $gettok($2, 1, 32) $gettok($3, 1, 32) $4)
}

;;; <summary>Binds a value as a parameter for prepared statement.</summary>
;;; <syntax>$sqlite_bind_value ( statement, param, value [, datatype ] )</syntax>
;;; <syntax>/sqlite_bind_value statement param value [ datatype ]</syntax>
;;; <param name="statement">The prepared statement identifier.</param>
;;; <param name="param">The parameter to bind to. Must exist in the prepared query.</param>
;;; <param name="value">The value to bind to.</param>
;;; <param name="datatype">Optional. Tells what datatype value is. See remarks.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_bind_value can be used to bind a value to a parameter.
;;;
;;; The <i>param</i> parameter can either be a numerical index, specified with a <b>?</b> in the query, or a named parameter specified with a <b>:name</b> in the query. If binding a named parameter, you should also include the colon in the name.
;;;
;;; If <i>datatype</i> is specified, it must be one of the <b>$SQLITE_INTEGER</b>, <b>$SQLITE_FLOAT</b>, <b>$SQLITE_TEXT</b>, <b>$SQLITE_BLOB</b> and <b>$SQLITE_NULL</b>. The datatype tells what datatype value is. If omitted, mSQLite will attempt to deduce the datatype of the value. You should specify datatype when you want a numerical value to act as a text for example.
;;;
;;; Note that if you want to bind a text value with more than one word, you must use the first form of syntax. If you don't care about the return value, you can use the built-in mIRC command <b>/noop</b>
;;;
;;; For more information about parameter binding, see <a href="prepared.html">Prepared Statements</a>.
;;; </remarks>
;;; <example>
;;; ; Open a temporary db
;;; var %db = $sqlite_open()
;;;
;;; ; Binds one numerical and one named parameter
;;; var %sql = SELECT ?, :test
;;; var %stmt = $sqlite_prepare(%db, %sql)
;;; if (%stmt) {
;;;   ; Binds 'Hello world' as first parameter and 100 as second parameter as float.
;;;   ; We must use the $sqlite_bind_param syntax here, because the value contains more than one word.
;;;   noop $sqlite_bind_value(%stmt, 1, Hello world)
;;;   ; If datatype isn't specified 100 would be considered an integer by mSQLite.
;;;   sqlite_bind_value %stmt :test 100 $SQLITE_FLOAT
;;;
;;;   ; Execute the query and show the results
;;;   var %result = $sqlite_query(%stmt)
;;;   if ($sqlite_fetch_row(%result, row, $SQLITE_NUM)) {
;;;     echo -a 1st: $hget(row, 1)
;;;     echo -a 2nd: $hget(row, 2)
;;;   }
;;;
;;;   sqlite_free %result
;;;   sqlite_free %stmt
;;; }
;;; else {
;;;   echo -a Error preparing query: %sqlite_errstr
;;; }
;;;
;;; sqlite_close %db
;;;
;;; ; Output:
;;; ; 1st: Hello world
;;; ; 2nd: 100.0
;;; </example>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_bind_field</seealso>
;;; <seealso>sqlite_bind_param</seealso>
alias sqlite_bind_value {
  if ($0 < 3) {
    return $dll($sqlite_dll, msqlite_bind_value, $gettok($1, 1, 32) $2)
  }
  else {
    return $dll($sqlite_dll, msqlite_bind_value, $gettok($1, 1, 32) $gettok($2, 1, 32) $iif($0 < 4, -1, $gettok($4, 1, 32)) $3)
  }
}

;;; <summary>Binds null as a parameter for prepared statement.</summary>
;;; <syntax>$sqlite_bind_null ( statement, param )</syntax>
;;; <syntax>/sqlite_bind_null statement param</syntax>
;;; <param name="statement">The prepared statement identifier.</param>
;;; <param name="param">The parameter to bind to. Must exist in the prepared query.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; The <i>param</i> parameter can either be a numerical index, specified with a <b>?</b> in the query, or a named parameter specified with a <b>:name</b> in the query. If binding a named parameter, you should also include the colon in the name.
;;;
;;; For more information about parameter binding, see <a href="prepared.html">Prepared Statements</a>.
;;; </remarks>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_bind_field</seealso>
;;; <seealso>sqlite_bind_param</seealso>
;;; <seealso>sqlite_bind_value</seealso>
alias sqlite_bind_null {
  return $sqlite_bind_value($1, $2, $null, $SQLITE_NULL)
}

;;; <summary>Clears all bindings from a result or a statement.</summary>
;;; <syntax>$sqlite_clear_bindings ( result )</syntax>
;;; <syntax>/sqlite_clear_bindings result</syntax>
;;; <syntax>$sqlite_clear_bindings ( statement )</syntax>
;;; <syntax>/sqlite_clear_bindings statement</syntax>
;;; <param name="result">The result identifier.</param>
;;; <param name="statement">The prepared statement identifier.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_clear_bindings clear all parameter bindings from a specified result or prepared statement. That is, unless they're re-bound, they will default to NULL.
;;;
;;; If used to clear bindings in a result set, clears all bindings specified with $sqlite_bind_field. If used to clear bindings in a prepared statement, clears all bindings specified with $sqlite_bind_param or $sqlite_bind_value.
;;;
;;; It is usually ok to ignore the return value of $sqlite_clear_bindings because the only case an error is returned is when an invalid <i>statement</i> is specified.
;;; </remarks>
;;; <seealso href="prepared.html">Prepared Statements</seealso>
;;; <seealso>sqlite_prepare</seealso>
;;; <seealso>sqlite_bind_param</seealso>
;;; <seealso>sqlite_bind_value</seealso>
alias sqlite_clear_bindings {
  return $dll($sqlite_dll, msqlite_clear_bindings, $1)
}

;;; <summary>Begins a transaction.</summary>
;;; <syntax>$sqlite_begin ( conn )</syntax>
;;; <syntax>/sqlite_begin conn</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_begin is a shorthand function provided for convience for executing <i>BEGIN TRANSACTION</i> on <i>conn</i>.
;;;
;;; Transactions should be used whenever a batch of queries that modify a database are executed. Transactions are much more efficient in such cases, because otherwise every individual query would create a transaction of their own, which is an expensive operation.
;;;
;;; It is usually ok to ignore the return value of $sqlite_begin because the only case an error is returned is when an invalid <i>conn</i> is specified or it's used out of sequence.
;;; </remarks>
;;; <seealso>sqlite_commit</seealso>
;;; <seealso>sqlite_rollback</seealso>
;;; <seealso>sqlite_autocommit</seealso>
alias sqlite_begin {
  return $sqlite_exec($1, BEGIN TRANSACTION)
}

;;; <summary>Commits a transaction.</summary>
;;; <syntax>$sqlite_commit ( conn )</syntax>
;;; <syntax>/sqlite_commit conn</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_commit is a shorthand function provided for convience for executing <i>COMMIT TRANSACTION</i> on <i>conn</i>.
;;;
;;; Committing a transaction will save all the changes that were done during the transaction to the database.
;;;
;;; It is usually ok to ignore the return value of $sqlite_commit because the only case an error is returned is when an invalid <i>conn</i> is specified or it's used out of sequence.
;;; </remarks>
;;; <seealso>sqlite_begin</seealso>
;;; <seealso>sqlite_rollback</seealso>
;;; <seealso>sqlite_autocommit</seealso>
alias sqlite_commit {
  return $sqlite_exec($1, COMMIT TRANSACTION)
}

;;; <summary>Rolls back a transaction.</summary>
;;; <syntax>$sqlite_rollback ( conn )</syntax>
;;; <syntax>/sqlite_rollback conn</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <returns><b>1</b> on success, or <b>$null</b> if there was an error.</returns>
;;; <remarks>
;;; $sqlite_rollback is a shorthand function provided for convience for executing <i>ROLLBACK TRANSACTION</i> on <i>conn</i>.
;;;
;;; Rolling back a transaction will discard all the changes that were done during the transaction.
;;;
;;; It is usually ok to ignore the return value of $sqlite_rollback because the only case an error is returned is when an invalid <i>conn</i> is specified or it's used out of sequence.
;;; </remarks>
;;; <seealso>sqlite_begin</seealso>
;;; <seealso>sqlite_commit</seealso>
;;; <seealso>sqlite_autocommit</seealso>
alias sqlite_rollback {
  return $sqlite_exec($1, ROLLBACK TRANSACTION)
}

;;; <summary>Turns on or off autocommit mode, or returns its current state.</summary>
;;; <syntax>$sqlite_autocommit ( conn [, mode ] )</syntax>
;;; <syntax>/sqlite_autocommit conn mode</syntax>
;;; <param name="conn">The connection identifier.</param>
;;; <param name="mode"><b>1</b>1 to enable autocommit mode, <b>0</b> to disable.</param>
;;; <returns>If setting the autocommit mode, <b>1</b> on success, or <b>$null</b> if there was an error. If getting the autocommit mode, <b>1</b> if autocommit mode is enabled, otherwise <b>0</b>.</returns>
;;; <remarks>
;;; When auto-commit mode is enabled every SQL statement is automatically committed after they're executed, unless <i>$sqlite_begin</i> or <i>BEGIN TRANSACTION</i> is explicitly used to start a transaction. When disabled, changes to the database are deferred and only committed when <i>$sqlite_commit</i> or <i>COMMIT TRANSACTION</i> is used.
;;;
;;; Using transactions when doing a batch of updates on database can greatly improve the performance. Disabling auto-commit mode means that you don't have to worry about remembering to start the transaction all the time, all you need to worry about is where you want all the pending changes to be committed.
;;;
;;; Auto-commit is enabled by default for new database connections. SQLite doesn't remember the state of auto-commit mode when database is closed, thus you must call this function everytime for a newly opened connection, if you want to disable auto-commit mode by default for that connection.
;;;
;;; Enabling auto-commit for a connection will commit all pending changes.
;;;
;;; It is usually ok to ignore the return value of $sqlite_autocommit when used to set autocommit mode, because the only case an error is returned is when an invalid <i>conn</i> is specified.
;;; </remarks>
;;; <example>
;;; ; Open a temporary database and disable auto-commit on it
;;; var %db = $sqlite_open()
;;; sqlite_autocommit %db 0
;;;
;;; ; Create a table and insert a row in it
;;; sqlite_exec %db CREATE TABLE test (text)
;;; sqlite_exec %db INSERT INTO test VALUES ('First row')
;;; sqlite_commit %db
;;;
;;; ; Insert another row, but this time roll it back
;;; sqlite_exec %db INSERT INTO test VALUES ('Second row')
;;; sqlite_rollback %db
;;;
;;; ; Print all the rows in the table
;;; var %res = $sqlite_query(%db, SELECT * FROM test), %i = 1
;;; while ($sqlite_fetch_single(%res)) {
;;;   echo -a %i - $v1
;;;   inc %i
;;; }
;;;
;;; ; Clean up
;;; sqlite_free %res
;;; sqlite_close %db
;;;
;;; ; Output:
;;; ; 1 - First row
;;; ; 2 - Second row
;;; </example>
;;; <seealso>sqlite_begin</seealso>
;;; <seealso>sqlite_commit</seealso>
;;; <seealso>sqlite_rollback</seealso>
alias sqlite_autocommit {
  return $dll($sqlite_dll, msqlite_autocommit, $gettok($1, 1, 32) $2)
}

;;; <summary>Encodes data for safe use in files.</summary>
;;; <syntax>$sqlite_safe_encode ( data [, delim ] )</syntax>
;;; <param name="data">The data to be encoded.</param>
;;; <param name="delim">Optional. Delimiter in ASCII used to separate fields.</param>
;;; <returns>Encoded data on success or <b>$null</b> on error.</returns>
;;; <remarks>
;;; <b>$sqlite_safe_encode</b> is used by <a href="sqlite_fetch_all.html">$sqlite_fetch_all</a> internally to encode data so it can be safely written into a file.
;;;
;;; The characters that are encoded are: \ (backslash), \n (newline), \r (carriage return), \0 (null-byte, in binary data) and whatever delimiter is used, if any. The characters are encoded as an escape sequence \xNN where NN is a two-digit hexadecimal number.
;;;
;;; In case <b>$null</b> is returned it can mean an error, but it can also happen if you tried to encode an empty string. It should be ok to ignore this, but in case you want to determine whether $null meant an error or not, you can check the <b>%sqlite_errno</b> variable; if it's <b>$SQLITE_OK</b> there was no error.
;;; </remarks>
;;; <seealso>sqlite_fetch_all</seealso>
;;; <seealso>sqlite_safe_decode</seealso>
alias sqlite_safe_encode {
  var %delim = $iif($0 >= 2, $gettok($2, 1, 32), -1)
  return $dll($sqlite_dll, msqlite_safe_encode, %delim $1)
}

;;; <summary>Decodes safe-encoded data.</summary>
;;; <syntax>$sqlite_safe_decode ( data )</syntax>
;;; <param name="data">The data to be decoded.</param>
;;; <returns>Decoded data on success or <b>$null</b> on error.</returns>
;;; <remarks>
;;; <b>$sqlite_safe_decode</b> is used to decode data encoded by  <a href="sqlite_fetch_all.html">$sqlite_fetch_all</a> or <a href="sqlite_safe_encode.html">$sqlite_safe_encode</a>.
;;;
;;; In case <b>$null</b> is returned it can mean an error, but it can also happen if you tried to encode an empty string. It should be ok to ignore this, but in case you want to determine whether $null meant an error or not, you can check the <b>%sqlite_errno</b> variable; if it's <b>$SQLITE_ERROR_OK</b> there was no error.
;;; </remarks>
;;; <seealso>sqlite_fetch_all</seealso>
;;; <seealso>sqlite_safe_decode</seealso>
alias sqlite_safe_decode {
  return $dll($sqlite_dll, msqlite_safe_decode, $1)
}
