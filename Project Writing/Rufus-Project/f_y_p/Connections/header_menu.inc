<div id="header">
  <h1><a href="index.php">VirtualClass!</a></h1>
  <h2><form method="get" action="search.php">
          <div>
            <input type="text" id="textfield1" name="textfield1" value="" size="18" />
            <input type="submit" id="submit1" name="submit1" value="Go" />
          </div>
  </form></h2>
</div>
<div id="pages">
  <h2>Pages</h2>
  <ul><?php $page = explode('/', $_SERVER['PHP_SELF']);  ?>
    <li <?php if ($page[2]=='home.php' || $page[2]=='index.php' ){ echo "class='active'";} else echo $page[2]; ?>><a id="page1" href="home.php">home</a></li>
    <li <?php if ($page[2]=='courses.php' || $page[2]=='crs_lessons.php' || $page[2]=='view_lesson.php'){ echo "class='active'";} else echo $page[2]; ?> ><a id="page2" href="courses.php">courses</a></li>
    <li <?php if ($page[2]=='resources.php'){ echo "class='active'";} else echo $page[2]; ?> ><a id="page3" href="resources.php">materials</a></li>
    <li <?php if ($page[2]=='forum.php' || $page[2]=='view_post.php'){ echo "class='active'";} else echo $page[2]; ?> ><a id="page4" href="forum.php">forum</a></li>
    <li <?php if ($page[2]=='logout.php'){ echo "class='active'";} else echo $page[2]; ?> ><a id="page5" href="logout.php">log out</a></li>
  </ul>
</div>