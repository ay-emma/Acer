<?php require_once('Connections/logincheck.inc'); ?>
<?php require_once('Connections/mycxn.php'); ?>
<?php
$currentPage = $_SERVER["PHP_SELF"];

$editFormAction = $_SERVER['PHP_SELF'];
if (isset($_SERVER['QUERY_STRING'])) {
  $editFormAction .= "?" . htmlentities($_SERVER['QUERY_STRING']);
}

if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "comment_form")) {
  $insertSQL = sprintf("INSERT INTO blg_comment_tbl (idlsn_com, text_com, idusr_com, date_com) VALUES (%s, %s, %s, %s)",
                       GetSQLValueString($_POST['id_pst'], "int"),
                       GetSQLValueString($_POST['comment_box'], "text"),
                       GetSQLValueString($_POST['id_usr'], "text"),
					   GetSQLValueString(date('Y-m-d H:i:s'), "date"));

  mysql_select_db($database_mycxn, $mycxn);
  $Result1 = mysql_query($insertSQL, $mycxn) or die(mysql_error());
}

$colname_rs_lesson = "-1";
if (isset($_GET['lssn'])) {
  $colname_rs_lesson = $_GET['lssn'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_lesson = sprintf("SELECT * FROM lesson_tbl WHERE id_lssn = %s", GetSQLValueString($colname_rs_lesson, "int"));
$rs_lesson = mysql_query($query_rs_lesson, $mycxn) or die(mysql_error());
$row_rs_lesson = mysql_fetch_assoc($rs_lesson);
$totalRows_rs_lesson = mysql_num_rows($rs_lesson);

$maxRows_rs_reviews = 10;
$pageNum_rs_reviews = 0;
if (isset($_GET['pageNum_rs_reviews'])) {
  $pageNum_rs_reviews = $_GET['pageNum_rs_reviews'];
}
$startRow_rs_reviews = $pageNum_rs_reviews * $maxRows_rs_reviews;

$colname_rs_reviews = "-1";
if (isset($_GET['lssn'])) {
  $colname_rs_reviews = $_GET['lssn'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_reviews = sprintf("SELECT * FROM blg_comment_tbl WHERE idlsn_com = %s ORDER BY id_com DESC", GetSQLValueString($colname_rs_reviews, "int"));
$query_limit_rs_reviews = sprintf("%s LIMIT %d, %d", $query_rs_reviews, $startRow_rs_reviews, $maxRows_rs_reviews);
$rs_reviews = mysql_query($query_limit_rs_reviews, $mycxn) or die(mysql_error());
$rs_reviews_  = $rs_reviews;
$row_rs_reviews = mysql_fetch_assoc($rs_reviews);

if (isset($_GET['totalRows_rs_reviews'])) {
  $totalRows_rs_reviews = $_GET['totalRows_rs_reviews'];
} else {
  $all_rs_reviews = mysql_query($query_rs_reviews);
  $totalRows_rs_reviews = mysql_num_rows($all_rs_reviews);
}
$totalPages_rs_reviews = ceil($totalRows_rs_reviews/$maxRows_rs_reviews)-1;

$queryString_rs_reviews = "";
if (!empty($_SERVER['QUERY_STRING'])) {
  $params = explode("&", $_SERVER['QUERY_STRING']);
  $newParams = array();
  foreach ($params as $param) {
    if (stristr($param, "pageNum_rs_reviews") == false && 
        stristr($param, "totalRows_rs_reviews") == false) {
      array_push($newParams, $param);
    }
  }
  if (count($newParams) != 0) {
    $queryString_rs_reviews = "&" . htmlentities(implode("&", $newParams));
  }
}
$queryString_rs_reviews = sprintf("&totalRows_rs_reviews=%d%s", $totalRows_rs_reviews, $queryString_rs_reviews);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - <?php echo $row_rs_lesson['title_lssn']; ?></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('Connections/header_menu.inc'); ?>
<div id="content">
  <div id="colOne">
      <h2 class="title"><a href="view_lesson.php?lssn=<?php echo $row_rs_lesson['id_lssn']; ?>"><?php echo $row_rs_lesson['title_lssn']; ?></a></h2>
      <?php $q_lect= sprintf("SELECT name_lect FROM lecturer_tbl WHERE id_lect = %s", GetSQLValueString($row_rs_lesson['lecturer_id_lssn'], "text"));
			$r_lect = mysql_query($q_lect)or die(mysql_error());
			$r_lect = mysql_fetch_array($r_lect); ?>
      <h5 class="posted">Posted on <a href="#"><?php echo $row_rs_lesson['date_added_lssn']; ?></a> by <a href="#"><?php echo $r_lect['name_lect']; ?></a></h5>
      <div style="clear: both; height: 5px;"></div>
      <div class="story">
        <p><?php echo $row_rs_lesson['content_lssn']; ?></p>
    </div>
    <div style="clear: both; height: 1px;"></div>
  </div>
  <table width="80%" border="0" align="center">
    <tr><td colspan="2"><h4>Reviews</h4></td></tr>
    <tr>
      <td colspan="2"><form name="comment_form" action="<?php echo $editFormAction; ?>" method="POST" target="_top" id="comment_form">
      <label for="comment_box"></label>
      <textarea name="comment_box" id="comment_box" cols="72" rows="3"></textarea>
      <input type="hidden" name="id_pst" value="<?php echo $row_rs_lesson['id_lssn']; ?>" /> <input type="hidden" name="id_usr" value="<?php echo $_SESSION['MM_Username']; ?>" />
      <span style="float:right"><input type="submit" name="comments" id="comments" value="Add Review" /></span>
      <input type="hidden" name="MM_insert" value="comment_form" />
      </form></td></tr>
    <?php if ($totalRows_rs_reviews > 0) { // Show if recordset not empty ?>
  <?php do { ?>
    <tr <?php if (strlen($row_rs_reviews['idusr_com'])<4) {echo "bgcolor='#ddd'";} ?> >
      <td colspan="2"><b><?php
	  if (strlen($row_rs_reviews['idusr_com'])<4) {
		 $q_lect= sprintf("SELECT name_lect FROM lecturer_tbl WHERE id_lect = %s", GetSQLValueString($row_rs_reviews['idusr_com'], "text"));
			$r_lect = mysql_query($q_lect)or die(mysql_error());
		$writer= 'Lecturer: '.mysql_result($r_lect,0,'name_lect');
		  }
		  else {
			  $q_std= sprintf("SELECT name_std FROM student_tbl WHERE matno_std = %s", GetSQLValueString('0'.$row_rs_reviews['idusr_com'], "text"));
			$r_std = mysql_query($q_std)or die(mysql_error());
		$writer= mysql_result($r_std,0,'name_std');
			  }
	  
	   echo $writer; ?></b><br />
	   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $row_rs_reviews['text_com']; ?> <h6 align="right"><a href="#"> Submitted on <?php echo $row_rs_reviews['date_com']; ?></a></h6></td>
    </tr>
    <?php } while ($row_rs_reviews = mysql_fetch_assoc($rs_reviews_)); ?>
    <tr>
        <td>&nbsp;</td>
        <td><a href="<?php printf("%s?pageNum_rs_reviews=%d%s", $currentPage, max(0, $pageNum_rs_reviews - 1), $queryString_rs_reviews); ?>">Previous</a>  <a href="<?php printf("%s?pageNum_rs_reviews=%d%s", $currentPage, min($totalPages_rs_reviews, $pageNum_rs_reviews + 1), $queryString_rs_reviews); ?>">Next</a></td>
    </tr>
    <?php } else echo "<tr><td colspan='2'>No review for this lesson yet</td></tr>"; // Show if recordset not empty ?>
  </table>
  <?php include('Connections/footer_menu.inc'); ?>
</body>
</html>
<?php
mysql_free_result($rs_lesson);
?>
