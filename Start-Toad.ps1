$oracle = 'C:\Utilities\OracleInstantClient\ForToad'
$env:Path += "$oracle\bin;"
$env:LD_LIBRARY_PATH = "$oracle\bin"
$env:ORACLE_HOME = $oracle
$env:ORACLE_HOME_NAME = $oracle
$env:SQL_PATH = $oracle
$env:TNS_ADMIN = "$oracle\network\admin"
& 'C:\Program Files (x86)\Quest Software\Toad for Oracle FREEWARE\TOAD.exe'