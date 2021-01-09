<?php
# FileName="Connection_php_mysql.htm"
# Type="MYSQL"
# HTTP="true"
$hostname_mycxn = "localhost";
$database_mycxn = "elearn_db";
$username_mycxn = "root";
$password_mycxn = "";
$mycxn = mysql_pconnect($hostname_mycxn, $username_mycxn, $password_mycxn) or trigger_error(mysql_error(),E_USER_ERROR); 
?>