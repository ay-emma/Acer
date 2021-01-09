<?php require_once('Connections/logincheck.inc'); ?>
<?php require_once('Connections/mycxn.php'); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - Courses</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('Connections/header_menu.inc'); ?>
<div id="content">
  <div id="colOne">
  <h2 class="title">Courses</h2>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><th>Courses</th><th>Course Unit</th><th>Lecturer-in-Charge</th><th>Lessons</th></tr>
   <?php
   $q_subjt= sprintf("SELECT id_crs,code_crs,title_crs,lect_inc_id,unit_crs,desc_crs FROM course_tbl WHERE app_level_crs = %s", GetSQLValueString($_SESSION['lvl'], "text"));
   $q_subjt = mysql_query($q_subjt) or die(mysql_error());
			$r_subjt = mysql_fetch_array($q_subjt);
		 do { ?>
          <tr>
            <td><a href="crs_lessons.php?crs=<?php echo $r_subjt['id_crs']; ?>"> <h3><?php echo $r_subjt['title_crs'].' ('.$r_subjt['code_crs'].')'; ?></h3></a>
            <h5><?php echo $r_subjt['desc_crs']; ?></h5></td>
            <td align="center"><?php echo $r_subjt['unit_crs']; ?></td>
            <td align="center"><?php $q_lect= sprintf("SELECT name_lect FROM lecturer_tbl WHERE id_lect = %s", GetSQLValueString($r_subjt['lect_inc_id'], "text"));
			$r_lect = mysql_query($q_lect)or die(mysql_error());
			$r_lect = mysql_fetch_array($r_lect); echo $r_lect['name_lect']; ?></td>
            <td align="center"><?php  $q_count= sprintf("SELECT * FROM lesson_tbl WHERE course_id_lssn = %s", GetSQLValueString($r_subjt['id_crs'], "text"));
			$q_count = mysql_query($q_count)or die(mysql_error());
			echo mysql_num_rows($q_count); ?>
            </td>
          </tr>
            
		 <?php } while ($r_subjt = mysql_fetch_assoc($q_subjt)); ?>
         </table>
    <div style="clear: both; height: 1px;"></div>
  </div>
  <?php include('Connections/footer_menu.inc'); ?>
</body>
</html>
