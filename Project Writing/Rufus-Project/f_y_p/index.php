<?php 
if (!isset($_SESSION)) {
  session_start();
} require_once('Connections/mycxn.php'); ?>

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
  
  $LoginRS__query=sprintf("SELECT matno_std,level_std, passwrd_std FROM student_tbl WHERE matno_std=%s AND passwrd_std=%s",
    GetSQLValueString($loginUsername, "text"), GetSQLValueString($password, "text")); 
   
  $LoginRS = mysql_query($LoginRS__query, $mycxn) or die(mysql_error());
  $loginFoundUser = mysql_num_rows($LoginRS);
  $returned = mysql_fetch_array($LoginRS);
  if ($loginFoundUser) {
     $loginStrGroup = "";
    
	if (PHP_VERSION >= 5.1) {session_regenerate_id(true);} else {session_regenerate_id();}
    //declare two session variables and assign them
    $_SESSION['MM_Username'] = $loginUsername;
	$_SESSION['lvl'] = $returned['level_std'];
    $_SESSION['MM_UserGroup'] = $loginStrGroup;	      

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
<title>VirtualClass! - Login</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="images/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><a href="index.php">VirtualClass!</a></h1>
  <h2><form method="get" action="search.php">
          <div>
            <input type="text" id="searchbox" name="searchbox" value="" size="18" />
            <input type="submit" id="submit" name="submit" value="Go" />
          </div>
  </form></h2>
</div>
<div id="pages">
  <h2>Pages</h2>
  <ul>
    <li class="active"><a id="page1" href="home.php">Home</a></li>
    <li><a id="page2" href="courses.php">Courses</a></li>
    <li><a id="page3" href="#">materials</a></li>
    <li><a id="page4" href="forum.php">forum</a></li>
    <li><a id="page5" href="#">log out</a></li>
  </ul>
</div>
<div id="content">
  <div id="colOne">
  <?php $msg='Welcome to VirtualClass! Sign in below'; //default
  
  if (isset($_GET['attempt'])) {
	  switch ($_GET['attempt']) {
	case '1':
		$msg= 'Matric No. or Password incorrect. Check and try and again';
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
                <td align="right"><label for="login_user">Matric No: </label></td>
                <td><input type="text" name="login_user" id="login_user" size="10" /></td>
              </tr>
              <tr>
                <td align="right"><label for="login_password">Password:</label></td>
                <td><input type="password" name="login_password" id="login_password" value="" size="10" /></td>
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
  <p>Lecturer? <a href='admin/'>Log in here</a><br>Copyright &copy; 2014 VirtualClass! Powered by <a href="http://www.oluwarufus.com/"><strong>Oluwarufus</strong></a></p>
</div>
</body>
</html>
