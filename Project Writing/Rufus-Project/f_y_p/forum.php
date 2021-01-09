<?php require_once('Connections/logincheck.inc'); ?>
<?php require_once('Connections/mycxn.php'); ?>
<?php

$currentPage = $_SERVER["PHP_SELF"];

$maxRows_rs_forum_posts = 5;
$pageNum_rs_forum_posts = 0;
if (isset($_GET['pageNum_rs_forum_posts'])) {
  $pageNum_rs_forum_posts = $_GET['pageNum_rs_forum_posts'];
}
$startRow_rs_forum_posts = $pageNum_rs_forum_posts * $maxRows_rs_forum_posts;

mysql_select_db($database_mycxn, $mycxn);
$query_rs_forum_posts = "SELECT * FROM blg_topic_tbl ORDER BY date_top DESC";
$query_limit_rs_forum_posts = sprintf("%s LIMIT %d, %d", $query_rs_forum_posts, $startRow_rs_forum_posts, $maxRows_rs_forum_posts);
$rs_forum_posts = mysql_query($query_limit_rs_forum_posts, $mycxn) or die(mysql_error());
$row_rs_forum_posts = mysql_fetch_assoc($rs_forum_posts);

if (isset($_GET['totalRows_rs_forum_posts'])) {
  $totalRows_rs_forum_posts = $_GET['totalRows_rs_forum_posts'];
} else {
  $all_rs_forum_posts = mysql_query($query_rs_forum_posts);
  $totalRows_rs_forum_posts = mysql_num_rows($all_rs_forum_posts);
}
$totalPages_rs_forum_posts = ceil($totalRows_rs_forum_posts/$maxRows_rs_forum_posts)-1;

$queryString_rs_forum_posts = "";
if (!empty($_SERVER['QUERY_STRING'])) {
  $params = explode("&", $_SERVER['QUERY_STRING']);
  $newParams = array();
  foreach ($params as $param) {
    if (stristr($param, "pageNum_rs_forum_posts") == false && 
        stristr($param, "totalRows_rs_forum_posts") == false) {
      array_push($newParams, $param);
    }
  }
  if (count($newParams) != 0) {
    $queryString_rs_forum_posts = "&" . htmlentities(implode("&", $newParams));
  }
}
$queryString_rs_forum_posts = sprintf("&totalRows_rs_forum_posts=%d%s", $totalRows_rs_forum_posts, $queryString_rs_forum_posts);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - Forum</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('Connections/header_menu.inc'); ?>
<div id="content">
  <div id="colOne">
    <h2 class="title">Ongoing Discussions</h2>
    <p>
      <?php if ($totalRows_rs_forum_posts > 0) { // Show if recordset not empty ?>
    </p>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <th>S/N</th>
        <th align="left">Topic</th>
      </tr>
      <?php $i=1; do { ?>
      <tr>
        <td align="center"><?php echo $i++; ?></td>
        <td><a href="view_post.php?id=<?php echo $row_rs_forum_posts['id_top']; ?>"><strong><?php echo $row_rs_forum_posts['title_top']; ?></strong></a>
          <h6>Added on <a href="#"><?php echo $row_rs_forum_posts['date_top']; ?></a></h6>
          <?php echo substr($row_rs_forum_posts['desc_top'], 0, 150); ?> <a href="view_post.php?id=<?php echo $row_rs_forum_posts['id_top']; ?>">...read more</a></td>
      </tr>
      <?php } while ($row_rs_forum_posts = mysql_fetch_assoc($rs_forum_posts)); ?>
      <tr>
        <td align="right"></td>
        <td align="center"><a href="<?php printf("%s?pageNum_rs_forum_posts=%d%s", $currentPage, 0, $queryString_rs_forum_posts); ?>">First</a> <a href="<?php printf("%s?pageNum_rs_forum_posts=%d%s", $currentPage, max(0, $pageNum_rs_forum_posts - 1), $queryString_rs_forum_posts); ?>">Previous</a> <a href="<?php printf("%s?pageNum_rs_forum_posts=%d%s", $currentPage, min($totalPages_rs_forum_posts, $pageNum_rs_forum_posts + 1), $queryString_rs_forum_posts); ?>">Next</a> <a href="<?php printf("%s?pageNum_rs_forum_posts=%d%s", $currentPage, $totalPages_rs_forum_posts, $queryString_rs_forum_posts); ?>">Last</a></td>
      </tr>
    </table>
    <?php } else echo "<strong>OOPS!!! </strong>No ongoing discussion. Kindly start a topic or check back later. Thanks"; // Show if recordset not empty ?>
    </p>
  </div>
  <?php include('Connections/footer_menu.inc'); ?>
</div></body>
</html>
<?php
mysql_free_result($rs_forum_posts);
?>
