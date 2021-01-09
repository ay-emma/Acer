<?php require_once('../Connections/logincheck_lect.inc'); ?>
<?php require_once('../Connections/mycxn.php'); ?>
<?php
$maxRows_rs_mat = 10;
$pageNum_rs_mat = 0;
if (isset($_GET['pageNum_rs_mat'])) {
  $pageNum_rs_mat = $_GET['pageNum_rs_mat'];
}
$startRow_rs_mat = $pageNum_rs_mat * $maxRows_rs_mat;

if (isset($_GET['del'])){
	  $deleteSQL = sprintf("DELETE FROM resource_tbl WHERE id_rc=%s",
                       GetSQLValueString($_GET['del'], "int"));

  mysql_select_db($database_conxn, $mycxn);
  $Result1 = mysql_query($deleteSQL, $mycxn) or die(mysql_error());
	
	unlink("upload/".$_POST['file']); //for deleting file
  $deleteGoTo = "files.php?msg=1";
  header(sprintf("Location: %s", $deleteGoTo));
}

$colname_rs_mat = "-1";
if (isset($_SESSION['usr_lct'])) {
  $colname_rs_mat = $_SESSION['usr_lct'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_mat = sprintf("SELECT * FROM resource_tbl WHERE idcrs_rc IN (SELECT id_crs FROM course_tbl WHERE lect_inc_id = %s) ORDER BY id_rc DESC", GetSQLValueString($colname_rs_mat, "int"));
$rs_mat = mysql_query($query_rs_mat, $mycxn) or die(mysql_error());
$row_rs_mat = mysql_fetch_assoc($rs_mat);
$totalRows_rs_mat = mysql_num_rows($rs_mat);

$colname_rs_crss = "-1";
if (isset($_SESSION['usr_lct'])) {
  $colname_rs_crss = $_SESSION['usr_lct'];
}
mysql_select_db($database_mycxn, $mycxn);
$query_rs_crss = sprintf("SELECT id_crs, title_crs, code_crs FROM course_tbl WHERE lect_inc_id = %s ORDER BY title_crs ASC", GetSQLValueString($colname_rs_crss, "text"));
$rs_crss = mysql_query($query_rs_crss, $mycxn) or die(mysql_error());
$row_rs_crss = mysql_fetch_assoc($rs_crss);
$totalRows_rs_crss = mysql_num_rows($rs_crss);

?>
<?php 
	
	if (!empty($_FILES['file']) && isset($_POST['crs']))
	{ //for uploading file		
		$type = $_FILES["file"]["type"];
		
				  if ($_FILES["file"]["error"] > 0)
					{
					//echo $_FILES["file"]["error"];
					}
				  else
					{
					$safe_filename = preg_replace ("#[^a-z A-Z 0-9 .]#", "", $_FILES["file"]["name"]);
					$size = round($_FILES["file"]["size"] / 1024, 2);
					move_uploaded_file($_FILES["file"]["tmp_name"], "../upload/".$safe_filename);
					}
		$by = $_SESSION['usr_lct'];
		$date = date('Y-m-d H:i:s');
		$rcs = $_POST['crs'];
		$query = "INSERT into resource_tbl (idcrs_rc,idlect_rc,mimetype_rc,name_rc, size_rc, date_rc) VALUES ('$rcs','$by','$type','$safe_filename', '$size', '$date' )";
			 mysql_query($query) or die(mysql_error());
			 
			 $insertGoTo = "files.php?msg=2";
  			header(sprintf("Location: %s", $insertGoTo));
		}
	

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! -  Resources</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../images/default_lt.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('../Connections/header_menu_lect.inc'); ?>
<div id="content">
  <div id="colOne">
  <h2 class="title">Online Resources</h2><center>
    <p>Below are the multimedia files uploaded to aid offline learning. You may click on the file name to download the file or add another one by using the upload section below.</p></center>
    <div id="info"><?php if (@$_GET['msg']==1) { $msg= 'File successfully deleted';} else if (@$_GET['msg']==2){ $msg= 'File successflly uploaded';} echo @$msg; ?></div>
    <form action="files.php" method="post" enctype="multipart/form-data">
          <input type="hidden" name="MAX_FILE_SIZE" value="2000000" />
                        <table border="0" style="margin:auto">
                          <tr>
                            <td><strong>Course:</strong></td>
                            <td><label for="crs"></label>
                              <select name="crs" id="crs">
                              <option>Select Course</option>
                                <?php
				do {  
				?>
				<option value="<?php echo $row_rs_crss['id_crs']?>"<?php if (!(strcmp($row_rs_crss['id_crs'], $row_rs_crss['id_crs']))) {echo "selected=\"selected\"";} ?>><?php echo $row_rs_crss['title_crs']?> (<?php echo $row_rs_crss['code_crs']?>)</option>
												<?php
				} while ($row_rs_crss = mysql_fetch_assoc($rs_crss));
				  $rows = mysql_num_rows($rs_crss);
				  if($rows > 0) {
					  mysql_data_seek($rs_crss, 0);
					  $row_rs_crss = mysql_fetch_assoc($rs_crss);
				  }
				?>
                            </select></td>
                          </tr>
                          <tr>
                            <td><strong>File:</strong></td>
                            <td><input type="file" name="file" id="file" /></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td><button class="submit" type="submit" value="Submit">Upload</button></td>
                          </tr>
                        </table>
						</form>
  <br/>
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
          <td><a href="../Connections/view_file.php?<?php $hash = sha1('view'); echo "$hash=".$row_rs_mat['id_rc']; ?>" title="View File" target="new">View</a> &nbsp; <a href="../Connections/download_file.php?<?php $hash = sha1('key'); echo "$hash=".$row_rs_mat['id_rc']; ?>" title="Download File">Download</a>
          &nbsp; <a href="files.php?del=<?php echo $row_rs_mat['id_rc']; ?>" title="Delete file" onclick="if(!confirm('Are you sure you want to delete this file as this action can not be reversed? \n\n\n Click \'OK\' to Delete')){return false;}">Delete</a></td>
        </tr>
        <?php } while ($row_rs_mat = mysql_fetch_assoc($rs_mat)); ?>
    </table>
<div style="clear: both; height: 1px;"></div>
  </div>
  <?php include('../Connections/footer_menu_lect.inc'); ?>
</div></body>
</html>
<?php
mysql_free_result($rs_mat);

mysql_free_result($rs_crss);
?>
