<?php require_once('Connections/logincheck.inc'); ?>
<?php require_once('Connections/mycxn.php'); ?>
<?php
$colname_rs_user = "-1";
if (isset($_SESSION['MM_Username'])) {
  $colname_rs_user = $_SESSION['MM_Username'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_user = sprintf("SELECT * FROM student_tbl WHERE matno_std = %s", GetSQLValueString($colname_rs_user, "text"));
$rs_user = mysql_query($query_rs_user, $mycxn) or die(mysql_error());
$row_rs_user = mysql_fetch_assoc($rs_user);
$totalRows_rs_user = mysql_num_rows($rs_user);

$maxRows_rs_lessons = 5;
$pageNum_rs_lessons = 0;
if (isset($_GET['pageNum_rs_lessons'])) {
  $pageNum_rs_lessons = $_GET['pageNum_rs_lessons'];
}
$startRow_rs_lessons = $pageNum_rs_lessons * $maxRows_rs_lessons;

$colname_rs_lessons = "-1";
if (isset($_SESSION['lvl'])) {
  $colname_rs_lessons = $_SESSION['lvl'];
}
mysql_select_db($database_mycxn, $mycxn);
// SELECT * FROM lesson_tbl WHERE course_id_lssn IN (SELECT id_crs FROM course_tbl WHERE app_level_crs = '100')

$query_rs_lessons = sprintf("SELECT * FROM lesson_tbl WHERE course_id_lssn IN (SELECT id_crs FROM course_tbl WHERE app_level_crs = %s) ORDER BY id_lssn DESC", GetSQLValueString($colname_rs_lessons, "text"));
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
<title>VirtualClass! - Dashboard</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('Connections/header_menu.inc'); ?>

<div id="content">
  <div id="colOne">
    <div id="latest-post">
      <h2 class="title"><a href="home.php">Welcome to VirtualClass!<br />
      </a></h2>
      <h3 class="posted"><?php echo date('F j,  Y H:i:s'); ?></h3>
      <div class="story"> <img src="images/img14.jpg" alt="" width="180" height="135" class="image" />
        <p>With <em><strong>VirtualClass! </strong></em>you will be able to read lecture notes added by lecturers for registered courses. You can also ask questions based on a lesson and interact with other students and lecturers using the forum section. Enjoy :)</p>
        <p>MY DETAILS</p>
        <table width="100%" border="0" align="center">
          <tr>
            <td align="right">Name:</td>
            <td colspan="3"><strong><?php echo $row_rs_user['name_std']; ?></strong></td>
          </tr>
          <tr>
            <td align="right">Matric No:</td>
            <td><strong><?php echo $row_rs_user['matno_std']; ?></strong></td>
            <td align="right">Level:</td>
            <td><strong><?php echo $row_rs_user['level_std']; ?></strong></td>
          </tr>
          <tr>
            <td align="right">Department:</td>
            <td><strong><?php echo $row_rs_user['dept_std']; ?></strong></td>
            <td align="right">Faculty:</td>
            <td><strong><?php echo $row_rs_user['faclty_std']; ?></strong></td>
          </tr>
        </table>
        <p><br />
        </p>
      </div>
    </div>
    <div id="recent-posts">
      <h3 class="title">Recent Lecture Notes</h3>
      <ul>
        <?php do {
			$q_lect= sprintf("SELECT name_lect FROM lecturer_tbl WHERE id_lect = %s", GetSQLValueString($row_rs_lessons['lecturer_id_lssn'], "text"));
			$r_lect = mysql_query($q_lect)or die(mysql_error());
			$r_lect = mysql_fetch_array($r_lect);
		?>
          <li><strong><a href="view_lesson.php?lssn=<?php echo $row_rs_lessons['id_lssn']; ?>">&raquo; <?php echo $row_rs_lessons['title_lssn']; ?></a></strong><br />
            <small>Subject: <a href="" class="category"><?php echo $r_subj['title_crs']; ?></a> | Course Code: <a href="" class="category"><?php echo $r_subj['code_crs']; ?></a><br/>
            Added on<a href="" class="category"> <?php echo $row_rs_lessons['date_added_lssn']; ?></a> by <a href="" class="category"><?php echo $r_lect['name_lect']; ?></a></small></li>
          <?php } while ($row_rs_lessons = mysql_fetch_assoc($rs_lessons)); ?>
      </ul>
    </div>
    <div style="clear: both; height: 1px;"></div>
  </div>
  <?php include('Connections/footer_menu.inc'); ?>
</body>
</html>
<?php
mysql_free_result($rs_user);

mysql_free_result($rs_lessons);
?>
