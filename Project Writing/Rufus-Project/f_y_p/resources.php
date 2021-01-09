<?php require_once('Connections/logincheck.inc'); ?>
<?php require_once('Connections/mycxn.php'); ?>
<?php

$maxRows_rs_mat = 10;
$pageNum_rs_mat = 0;
if (isset($_GET['pageNum_rs_mat'])) {
  $pageNum_rs_mat = $_GET['pageNum_rs_mat'];
}
$startRow_rs_mat = $pageNum_rs_mat * $maxRows_rs_mat;

$colname_rs_mat = "-1";
if (isset($_SESSION['lvl'])) {
  $colname_rs_mat = $_SESSION['lvl'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_mat = sprintf("SELECT * FROM resource_tbl WHERE idcrs_rc IN (SELECT id_crs FROM course_tbl WHERE app_level_crs = %s) ORDER BY id_rc DESC", GetSQLValueString($colname_rs_mat, "int"));
$query_limit_rs_mat = sprintf("%s LIMIT %d, %d", $query_rs_mat, $startRow_rs_mat, $maxRows_rs_mat);
$rs_mat = mysql_query($query_limit_rs_mat, $mycxn) or die(mysql_error());
$row_rs_mat = mysql_fetch_assoc($rs_mat);

if (isset($_GET['totalRows_rs_mat'])) {
  $totalRows_rs_mat = $_GET['totalRows_rs_mat'];
} else {
  $all_rs_mat = mysql_query($query_rs_mat);
  $totalRows_rs_mat = mysql_num_rows($all_rs_mat);
}
$totalPages_rs_mat = ceil($totalRows_rs_mat/$maxRows_rs_mat)-1;

?>
<?php 

/*
	$fileName = $_POST["logo_ini"]; //default logo incase of no change.
	
	if (!empty($_FILES['file']))
	{ //for uploading file
		$oldfile = $fileName;
		
		$type = $_FILES["file"]["type"];
		if ((($type == "image/gif") || ($type == "image/jpeg") || ($type == "image/pjpeg") || $type=="image/png"))
				{
				  if ($_FILES["file"]["error"] > 0)
					{
					//echo $_FILES["file"]["error"];
					}
				  else
					{
					$safe_filename = preg_replace ("#[^a-z A-Z 0-9 .]#", "", $_FILES["file"]["name"]);
					$size = round($_FILES["file"]["size"] / 1024, 2);
					$fileName= $_SESSION['Username_clt']."_".date('his')."_".$safe_filename;
					move_uploaded_file($_FILES["file"]["tmp_name"], "../assets/uploads/logo/".$fileName);
					unlink("../assets/uploads/logo/".$oldfile); //for deleting the old file
					}
				}	
		}

//for download
header('Content-Type: text/csv');
header("Content-Disposition: attachment;filename=" . date("Y-m-d") ."_".$filename.".csv;");		
*/
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! -  Resources</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('Connections/header_menu.inc'); ?>
<div id="content">
  <div id="colOne">
  <h2 class="title">Online Resources</h2><center>Below are the multimedia files uploaded by your lecturers to aid offline learning. You may click on the file name to download the file.<br/></center><br/>
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <th>Name</th>
        <th>File type</th>
        <th>Course Code</th>
        <th>Uploaded by</th>
        <th>Added on</th>
        <th>&nbsp;</th>
      </tr>
      <?php do { ?>
        <tr>
          <td><?php echo $row_rs_mat['name_rc']; ?> (<?php echo $row_rs_mat['size_rc']; ?> kb)</td>
          <td><?php echo $row_rs_mat['mimetype_rc']; ?></td>
          <td><?php
 			$q_crs= sprintf("SELECT code_crs FROM course_tbl WHERE id_crs = %s", GetSQLValueString($row_rs_mat['idcrs_rc'], "text"));
			$r_crs = mysql_query($q_crs)or die(mysql_error());
			$r_crs = mysql_fetch_array($r_crs); echo $r_crs['code_crs']; ?></td>
          <td><?php $q_lect= sprintf("SELECT name_lect FROM lecturer_tbl WHERE id_lect = %s", GetSQLValueString($row_rs_mat['idlect_rc'], "text"));
			$r_lect = mysql_query($q_lect)or die(mysql_error());
			$r_lect = mysql_fetch_array($r_lect); echo $r_lect['name_lect']; ?></td>
          <td><?php echo $row_rs_mat['date_rc']; ?></td>
          <td><a href="Connections/view_file.php?<?php $hash = sha1('view'); echo "$hash=".$row_rs_mat['id_rc']; ?>" title="View File" target="new">View</a> &nbsp; <a href="Connections/download_file.php?<?php $hash = sha1('key'); echo "$hash=".$row_rs_mat['id_rc']; ?>" title="Download File">Download</a></td>
        </tr>
        <?php } while ($row_rs_mat = mysql_fetch_assoc($rs_mat)); ?>
    </table>
<div style="clear: both; height: 1px;"></div>
  </div>
  <?php include('Connections/footer_menu.inc'); ?>
</div></body>
</html>
<?php
mysql_free_result($rs_mat);
?>
