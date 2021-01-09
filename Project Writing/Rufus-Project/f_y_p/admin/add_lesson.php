<?php require_once('../Connections/logincheck_lect.inc'); ?>
<?php require_once('../Connections/mycxn.php'); ?>
<?php

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1")) {
  $insertSQL = sprintf("INSERT INTO lesson_tbl (title_lssn, content_lssn, course_id_lssn, lecturer_id_lssn, date_added_lssn) VALUES (%s, %s, %s, %s, %s)",
                       GetSQLValueString($_POST['title_lssn'], "text"),
                       GetSQLValueString($_POST['content_lssn'], "text"),
                       GetSQLValueString($_POST['course_id_lssn'], "int"),
                       GetSQLValueString($_POST['lecturer_id_lssn'], "int"),
					   GetSQLValueString(date('Y-m-d H:i:s'), "date"));

  mysql_select_db($database_mycxn, $mycxn);
  $Result1 = mysql_query($insertSQL, $mycxn) or die(mysql_error());

  $insertGoTo = "lessons.php?flag=1_";
  if (isset($_SERVER['QUERY_STRING'])) {
    $insertGoTo .= (strpos($insertGoTo, '?')) ? "&" : "?";
    $insertGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $insertGoTo));
}

$currentPage = $_SERVER["PHP_SELF"];

$colname_rs_lesson = "-1";
if (isset($_GET['lssn'])) {
  $colname_rs_lesson = $_GET['lssn'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_lesson = sprintf("SELECT * FROM lesson_tbl WHERE id_lssn = %s", GetSQLValueString($colname_rs_lesson, "int"));
$rs_lesson = mysql_query($query_rs_lesson, $mycxn) or die(mysql_error());
$row_rs_lesson = mysql_fetch_assoc($rs_lesson);
$totalRows_rs_lesson = mysql_num_rows($rs_lesson);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - Edit Lesson</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../images/default_lt.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('../Connections/header_menu_lect.inc'); ?>
<div id="content">
  <div id="colOne">
  Fill the form appropriately and click on add when done.
    <div style="clear: both; height: 5px;"></div>
  <form action="<?php echo $editFormAction; ?>" method="post" id="form1">
    <table align="center">
      <tr valign="baseline">
        <td align="right">Lesson Title:</td>
        <td><input type="text" name="title_lssn" value="" size="32" /></td>
      </tr>
      <tr valign="baseline">
        <td align="right" valign="top">Lesson Content:</td>
        <td><textarea name="content_lssn" cols="70" rows="5"></textarea></td>
      </tr>
      <tr valign="baseline">
        <td align="right">&nbsp;</td>
        <td><input type="submit" value="Add Lesson" /></td>
      </tr>
    </table>
    <input type="hidden" name="course_id_lssn" value="<?php echo $_GET['crs']; ?>" />
    <input type="hidden" name="lecturer_id_lssn" value="<?php echo $_SESSION['usr_lct']; ?>" />
    <input type="hidden" name="MM_insert" value="form1" />
  </form>
  <p>&nbsp;</p>
<p>&nbsp;</p>
      <div class="story"></div>
    <div style="clear: both; height: 1px;"></div>
  </div>
  <?php include('../Connections/footer_menu_lect.inc'); ?>
</body>
</html>
<?php
mysql_free_result($rs_lesson);
?>
