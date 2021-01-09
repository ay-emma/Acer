<?php
# FileName="Connection_php_mysql.htm"
# Type="MYSQL"
# HTTP="true"
$hostname_mycxn = "127.0.0.1";
$database_mycxn = "elearn_db";
$username_mycxn = "root";
$password_mycxn = "";
$mycxn = mysql_pconnect($hostname_mycxn, $username_mycxn, $password_mycxn) or trigger_error(mysql_error(),E_USER_ERROR); 
mysql_select_db($database_mycxn);


if (!function_exists("GetSQLValueString")) {
function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
{
  if (PHP_VERSION < 6) {
    $theValue = get_magic_quotes_gpc() ? stripslashes($theValue) : $theValue;
  }

  $theValue = function_exists("mysql_real_escape_string") ? mysql_real_escape_string($theValue) : mysql_escape_string($theValue);

  switch ($theType) {
    case "text":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;    
    case "long":
    case "int":
      $theValue = ($theValue != "") ? intval($theValue) : "NULL";
      break;
    case "double":
      $theValue = ($theValue != "") ? doubleval($theValue) : "NULL";
      break;
    case "date":
      $theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
      break;
    case "defined":
      $theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
      break;
  }
  return $theValue;
}
}

if (isset($_SESSION['lvl']) || isset($_SESSION['usr_lct'])) {
$q_subj= @sprintf("SELECT id_crs,code_crs,title_crs FROM course_tbl WHERE app_level_crs = %s OR lect_inc_id = %s", GetSQLValueString($_SESSION['lvl'], "text"), GetSQLValueString($_SESSION['usr_lct'], "text"));
			$q_subj = mysql_query($q_subj)or die(mysql_error());
			$r_subj = mysql_fetch_array($q_subj);
		
		$query_forum = "SELECT * FROM blg_topic_tbl ORDER BY date_top DESC";
		$rs_forum = mysql_query($query_forum, $mycxn) or die(mysql_error());
}
?>