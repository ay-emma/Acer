<?php require_once('../Connections/logincheck_lect.inc'); ?>
<?php require_once('../Connections/mycxn.php'); ?>
<?php

$colname_rs_admin = "-1";
if (isset($_SESSION['usr_lct'])) {
  $colname_rs_admin = $_SESSION['usr_lct'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_admin = sprintf("SELECT * FROM lecturer_tbl WHERE id_lect = %s", GetSQLValueString($colname_rs_admin, "int"));
$rs_admin = mysql_query($query_rs_admin, $mycxn) or die(mysql_error());
$row_rs_admin = mysql_fetch_assoc($rs_admin);
$totalRows_rs_admin = mysql_num_rows($rs_admin);

$maxRows_rs_lessons = 5;
$pageNum_rs_lessons = 0;
if (isset($_GET['pageNum_rs_lessons'])) {
  $pageNum_rs_lessons = $_GET['pageNum_rs_lessons'];
}
$startRow_rs_lessons = $pageNum_rs_lessons * $maxRows_rs_lessons;

$colname_rs_lessons = "-1";
if (isset($_SESSION['usr_lct'])) {
  $colname_rs_lessons = $_SESSION['usr_lct'];
}
mysql_select_db($database_mycxn, $mycxn);
// SELECT * FROM lesson_tbl WHERE course_id_lssn IN (SELECT id_crs FROM course_tbl WHERE app_level_crs = '100')

$query_rs_lessons = sprintf("SELECT * FROM lesson_tbl WHERE lecturer_id_lssn = %s ORDER BY id_lssn DESC", GetSQLValueString($colname_rs_lessons, "text"));
$query_limit_rs_lessons = sprintf("%s LIMIT %d, %d", $query_rs_lessons, $startRow_rs_lessons, $maxRows_rs_lessons);
$rs_lessons = mysql_query($query_limit_rs_lessons, $mycxn) or die(mysql_error());
$row_rs_lessons = mysql_fetch_assoc($rs_lessons);

if (isset($_GET['totalRows_rs_lessons'])) {
  $totalRows_rs_lessons = $_GET['totalRows_rs_lessons'];
} else {
  $all_rs_lessons = mysql_query($query_rs_lessons);
  $totalRows_rs_lessons = mysql_num_rows($all_rs_lessons);
}
$totalPages_rs_lessons = ceil($totalRows_rs_lessons/$maxRows_rs_lessons)-1;
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - Admin Dashboard</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../images/default_lt.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('../Connections/header_menu_lect.inc'); ?>

<div id="content">
  <div id="colOne">
    <div id="latest-post">
      <h2 class="title"><a href="../home.php">Welcome Admin!<br />
      </a></h2>
      <h3 class="posted"><?php echo date('F j,  Y H:i:s'); ?></h3>
      <div class="story"> <img src="../images/img14.jpg" alt="" width="180" height="135" class="image" />
        <p>With <em><strong>VirtualClass! </strong></em>you will be able to read lecture notes added by lecturers for registered courses. You can also ask questions based on a lesson and interact with other students and lecturers using the forum section. Enjoy :)</p>
        <p>MY DETAILS</p>
        <table width="100%" border="0" align="center">
          <tr>
            <td align="right">Name:</td>
            <td colspan="3"><strong><?php echo $row_rs_admin['name_lect']; ?></strong></td>
          </tr>
           <tr>
            <td align="right">Dept:</td>
            <td colspan="3"><strong><?php echo $row_rs_admin['dept_lect']; ?></strong></td>
          </tr>
          <tr>
            <td align="right">Course:</td>
            <td><strong><?php echo $row_rs_admin['course_taken_lect']; ?></strong></td>
            <td align="right">Faculty:</td>
            <td><strong><?php echo $row_rs_admin['faclty_lect']; ?></strong></td>
          </tr>
          <tr>
            <td align="right">Email:</td>
            <td colspan="3"><strong><?php echo $row_rs_admin['email_lect']; ?></strong></td>
          </tr>
        </table>
        <p><br />
        </p>
      </div>
    </div>
    <div id="recent-posts">
      <h3 class="title">Recent Lecture Notes</h3>
      <ul>
        <?php do { ?>
          <li><strong><a href="../view_lesson.php?lssn=<?php echo $row_rs_lessons['id_lssn']; ?>">&raquo; <?php echo $row_rs_lessons['title_lssn']; ?></a></strong><br />
            <small>Subject: <a href="" class="category"><?php echo $r_subj['title_crs']; ?></a> | Course Code: <a href="" class="category"><?php echo $r_subj['code_crs']; ?></a><br/>
            Added on<a href="" class="category"> <?php echo $row_rs_lessons['date_added_lssn']; ?></a></small></li>
          <?php } while ($row_rs_lessons = mysql_fetch_assoc($rs_lessons)); ?>
      </ul>
    </div>
    <div style="clear: both; height: 1px;"></div>
  </div>
  <?php include('../Connections/footer_menu_lect.inc'); ?>
</body>
</html>
<?php
mysql_free_result($rs_admin);

mysql_free_result($rs_lessons);
?>
