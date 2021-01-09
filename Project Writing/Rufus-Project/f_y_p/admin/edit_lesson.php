<?php require_once('../Connections/logincheck_lect.inc'); ?>
<?php require_once('../Connections/mycxn.php'); ?>
<?php
$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_update"])) && ($_POST["MM_update"] == "form1")) {
  $updateSQL = sprintf("UPDATE lesson_tbl SET title_lssn=%s, content_lssn=%s, date_added_lssn=%s WHERE id_lssn=%s",
                       GetSQLValueString($_POST['title_lssn'], "text"),
                       GetSQLValueString($_POST['content_lssn'], "text"),
					   GetSQLValueString(date('Y m d H:i:s'), "date"),
					   GetSQLValueString($_POST['id_lssn'], "int"));

  mysql_select_db($database_mycxn, $mycxn);
  $Result1 = mysql_query($updateSQL, $mycxn) or die(mysql_error());

  $updateGoTo = "lessons.php?flag=1";
  if (isset($_SERVER['QUERY_STRING'])) {
    $updateGoTo .= (strpos($updateGoTo, '?')) ? "&" : "?";
    $updateGoTo .= $_SERVER['QUERY_STRING'];
  }
  header(sprintf("Location: %s", $updateGoTo));
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
  Edit the lesson appropriately and click on update when done.
  <div style="clear: both; height: 5px;"></div>
    <form action="<?php echo $editFormAction; ?>" method="post" id="form1">
      <table align="center">
        <tr valign="baseline">
          <td align="right">Lesson Title:</td>
          <td><input type="text" name="title_lssn" value="<?php echo htmlentities($row_rs_lesson['title_lssn'], ENT_COMPAT, 'utf-8'); ?>" size="32" /></td>
        </tr>
        <tr valign="baseline">
          <td align="right" valign="top">Lesson Content:</td>
          <td><textarea name="content_lssn" cols="70" rows="5"><?php echo $row_rs_lesson['content_lssn']; ?></textarea></td>
        </tr>
        <tr valign="baseline">
          <td align="right">&nbsp;</td>
          <td><input type="submit" value="Update Lesson" /></td>
        </tr>
      </table>
      <input type="hidden" name="MM_update" value="form1" />
      <input type="hidden" name="id_lssn" value="<?php echo $row_rs_lesson['id_lssn']; ?>" />
    </form>
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
