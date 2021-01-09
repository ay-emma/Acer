<?php 
if (!isset($_SESSION)) {
  session_start();
} require_once('../Connections/mycxn.php'); ?>

<?php

// *** Validate request to login to this site.
$loginFormAction = $_SERVER['PHP_SELF'];
if (isset($_GET['accesscheck'])) {
  $_SESSION['PrevUrl'] = $_GET['accesscheck'];
}

if (isset($_POST['login_user'])) {
  $loginUsername=$_POST['login_user'];
  $password=$_POST['login_password'];
  $MM_fldUserAuthorization = "";
  $MM_redirectLoginSuccess = "home.php";
  $MM_redirectLoginFailed = "index.php?attempt=1";
  $MM_redirecttoReferrer = true;
  mysql_select_db($database_mycxn, $mycxn);
  
  $LoginRS__query=sprintf("SELECT id_lect, name_lect, course_taken_lect, passwrd_lect, email_lect FROM lecturer_tbl WHERE email_lect=%s AND passwrd_lect=%s",
    GetSQLValueString($loginUsername, "text"), GetSQLValueString($password, "text")); 
   
  $LoginRS = mysql_query($LoginRS__query, $mycxn) or die(mysql_error());
  $loginFoundUser = mysql_num_rows($LoginRS);
  $returned = mysql_fetch_array($LoginRS);
  if ($loginFoundUser) {
     $loginStrGroup = "";
    
	if (PHP_VERSION >= 5.1) {session_regenerate_id(true);} else {session_regenerate_id();}
    //declare two session variables and assign them
    $_SESSION['usr_lct'] = $returned['id_lect'];
	$_SESSION['crs'] = $returned['course_taken_lect'];
    $_SESSION['MM_UserGroup_lct'] = $loginStrGroup;	      

    if (isset($_SESSION['PrevUrl']) && true) {
      $MM_redirectLoginSuccess = $_SESSION['PrevUrl'];	
    }
    header("Location: " . $MM_redirectLoginSuccess );
  }
  else {
    header("Location: ". $MM_redirectLoginFailed );
  }
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>VirtualClass! - Admin Login</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../images/default_lt.css" rel="stylesheet" type="text/css" />
</head>
<body>
<?php include('../Connections/header_menu_lect.inc'); ?>
<div id="content">
  <div id="colOne">
  <?php $msg='Welcome to VirtualClass! Sign in below'; //default
  
  if (isset($_GET['attempt'])) {
	  switch ($_GET['attempt']) {
	case '1':
		$msg= 'Email address or password incorrect. Check and try and again';
		break;
	case '-1':
		$msg= 'You have to login first by filling and submitting the form below';
		break;
	case '0':
		$msg= 'You\'ve been successfully logged out.';
		break;
	}
	  } ?>
  <div id="info"><?php echo @$msg; ?></div>
    <table width="313" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td style="border-radius:2px; border:1px solid #333"><form ACTION="<?php echo $loginFormAction; ?>" method="POST" id="form1">
          <center>
            <table align="center" cellpadding="2" cellspacing="0">
              <tr>
                <td align="right"><label for="login_user">Email Address: </label></td>
                <td><input type="text" name="login_user" id="login_user" size="20" /></td>
              </tr>
              <tr>
                <td align="right"><label for="login_password">Password:</label></td>
                <td><input type="password" name="login_password" id="login_password" value="" size="20" /></td>
              </tr>
              <tr>
                <td colspan="2" align="center"><input type="submit" name="login" id="login" value="Login" /></td>
              </tr>
            </table>
          </center>
        </form></td>
      </tr>
    </table>
    <div style="clear: both; height: 1px;"></div>
  </div>
</div>
<div id="footer">
  <p>Student? <a href='../'>Log in here</a><br>Copyright &copy; 2014 VirtualClass! Powered by <a href="http://www.oluwarufus.com/"><strong>Oluwarufus</strong></a></p>
</div>
</body>
</html>

<?php
echo "<mm:dwdrfml documentRoot=" . __FILE__ .">";$included_files = get_included_files();foreach ($included_files as $filename) { echo "<mm:IncludeFile path=" . $filename . " />"; } echo "</mm:dwdrfml>";
?>