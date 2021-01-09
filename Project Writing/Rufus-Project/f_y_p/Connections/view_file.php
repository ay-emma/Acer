<?php require_once('mycxn.php');
$hash = sha1('view');
$key = $_GET[$hash];
mysql_select_db($database_mycxn, $mycxn);
$query_rs_uploads = "SELECT * FROM resource_tbl WHERE id_rc = $key";
$rs_uploads = mysql_query($query_rs_uploads, $mycxn) or die(mysql_error());
$row_rs_uploads = mysql_fetch_assoc($rs_uploads);

$filename = $row_rs_uploads['name_rc'];
$type = $row_rs_uploads['mimetype_rc'];

$datafile = "../upload/".$filename;

header( "Content-type: $type" );
//header( "Content-Length: ".@filesize( $datafile ) );
//header( 'Content-Disposition: attachment; filename="'.$filename.'"' );

readfile( $datafile);
?>