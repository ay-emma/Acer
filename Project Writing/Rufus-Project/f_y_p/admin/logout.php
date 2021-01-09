<?php
// *** Logout the current user.
$logoutGoTo = "index.php?attempt=0";
if (!isset($_SESSION)) {
  session_start();
}
$_SESSION['usr_lct'] = NULL;
$_SESSION['MM_UserGroup_lct'] = NULL;
unset($_SESSION['usr_lct']);
unset($_SESSION['MM_UserGroup_lct']);
if ($logoutGoTo != "") {header("Location: $logoutGoTo");
exit;
}
?>
