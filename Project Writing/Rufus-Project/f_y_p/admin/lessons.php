<?php require_once('../Connections/logincheck_lect.inc'); ?>
<?php require_once('../Connections/mycxn.php'); 

$currentPage = $_SERVER["PHP_SELF"];
$maxRows_rs_lessons = 10;
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
$query_rs_lessons = sprintf("SELECT * FROM lesson_tbl WHERE lecturer_id_lssn= %s ORDER BY id_lssn DESC", GetSQLValueString($colname_rs_lessons, "int"));
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
<?php
if ((isset($_GET['del'])) && ($_GET['del'] != "")) {
  $deleteSQL = sprintf("DELETE FROM lesson_tbl WHERE id_lssn=%s",
                       GetSQLValueString($_GET['del'], "int"));

  mysql_select_db($database_mycxn, $mycxn);
  $Result1 = mysql_query($deleteSQL, $mycxn) or die(mysql_error());

  $deleteGoTo = "lessons.php?flag=0_";
  header(sprintf("Location: %s", $deleteGoTo));
}

$queryString_rs_lessons = "";
if (!empty($_SERVER['QUERY_STRING'])) {
  $params = explode("&", $_SERVER['QUERY_STRING']);
  $newParams = array();
  foreach ($params as $param) {
    if (stristr($param, "pageNum_rs_lessons") == false && 
        stristr($param, "totalRows_rs_lessons") == false) {
      array_push($newParams, $param);
    }
  }
  if (count($newParams) != 0) {
    $queryString_rs_lessons = "&" . htmlentities(implode("&", $newParams));
  }
}
$queryString_rs_lessons = sprintf("&totalRows_rs_lessons=%d%s", $totalRows_rs_lessons, $queryString_rs_lessons);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - Lessons : Admin</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../images/default_lt.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('../Connections/header_menu_lect.inc'); ?>
<div id="content">
  <div id="colOne">
   <?php 
  if (isset($_GET['flag'])) {
	  switch ($_GET['flag']) {
	case '1':
		$msg= 'Lesson successfully updated';
		break;
	case '1_':
		$msg= 'Lesson successfully added';
		break;
	case '0':
		$msg= 'Unable to update lesson now, pls try again later';
		break;
	case '0_':
		$msg= 'Record successfully deleted';
		break;
	}
	  } ?>
  <div id="info"><?php echo @$msg; ?></div>
  <?php $q_crs= sprintf("SELECT id_crs, code_crs, desc_crs, unit_crs, title_crs FROM course_tbl WHERE lect_inc_id = %s", GetSQLValueString($_SESSION['usr_lct'], "text")); //for selecting the course details
			$r_crs = mysql_query($q_crs)or die(mysql_error()); $r_crs = mysql_fetch_array($r_crs); ?>
  <h2 class="title"><a href="#"><?php echo $r_crs['title_crs']; ?></a></h2>   
    <h5 class="posted">Course Code: <a href="#"><?php echo $r_crs['code_crs']; ?></a>  |  Course Unit: <a href="#"><?php echo $r_crs['unit_crs']; ?></a></h5>
    <div style="clear: both; height: 3px;"></div>
    <p>Course Description: <?php echo $r_crs['desc_crs']; ?>  <a href="add_lesson.php?crs=<?php echo $r_crs['id_crs']; ?>"> ...[add new lesson]</a> </p>
    <p>
      <?php if ($totalRows_rs_lessons > 0) { // Show if recordset not empty ?>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <th>S/N</th>
    <th align="left">Lesson Topic</th>
  </tr>
  <?php $i=1; do { ?>
    <tr>
      <td align="center"><?php echo $i++; ?></td>
      <td><a href="view_lesson.php?lssn=<?php echo $row_rs_lessons['id_lssn']; ?>"><strong><?php echo $row_rs_lessons['title_lssn']; ?></strong></a>
        <h6>Added on <a href="#"><?php echo $row_rs_lessons['date_added_lssn']; ?></a></h6>
		<?php echo substr($row_rs_lessons['content_lssn'], 0, 300); ?> &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="edit_lesson.php?lssn=<?php echo $row_rs_lessons['id_lssn']; ?>">...[edit lesson]</a>&nbsp; &nbsp; <a href="lessons.php?del=<?php echo $row_rs_lessons['id_lssn']; ?>" onclick="if(!confirm('Are you sure you want to delete this lesson as this action can not be reversed? \n\n\n Click \'OK\' to Delete')){return false;}">...[delete lesson]</a></td>
    </tr>
    <?php } while ($row_rs_lessons = mysql_fetch_assoc($rs_lessons)); ?>
  <tr>
    <td align="right"></td>
    <td align="center"><a href="<?php printf("%s?pageNum_rs_lessons=%d%s", $currentPage, 0, $queryString_rs_lessons); ?>">First</a>   <a href="<?php printf("%s?pageNum_rs_lessons=%d%s", $currentPage, max(0, $pageNum_rs_lessons - 1), $queryString_rs_lessons); ?>">Previous</a>  <a href="<?php printf("%s?pageNum_rs_lessons=%d%s", $currentPage, min($totalPages_rs_lessons, $pageNum_rs_lessons + 1), $queryString_rs_lessons); ?>">Next</a>    <a href="<?php printf("%s?pageNum_rs_lessons=%d%s", $currentPage, $totalPages_rs_lessons, $queryString_rs_lessons); ?>">Last</a></td>
  </tr>
</table>
<?php } else echo "<strong>OOPS!!! </strong>No lecture has been added to this course yet. Kindly check back later. Thanks"; // Show if recordset not empty ?>
</p>
  </div>
  <?php include('../Connections/footer_menu_lect.inc'); ?>

</body>
</html>
<?php
mysql_free_result($rs_lessons);
?>
