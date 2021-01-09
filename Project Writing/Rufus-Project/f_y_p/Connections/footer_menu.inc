<div id="colTwo">
    <ul>
      <li>
        <h2>Forum</h2>
        <ul>
        <?php while ($array_forum = mysql_fetch_assoc($rs_forum)) { ?>
          <li><a href="view_post.php?id=<?php echo $array_forum['id_top']; ?>"><?php echo substr($array_forum['title_top'], 0, 25);
			$q_cnt= sprintf("SELECT * FROM blg_comment_tbl WHERE idart_com = %s", GetSQLValueString($array_forum['id_top'], "text"));	mysql_select_db($database_mycxn, $mycxn); $q_cnt = mysql_query($q_cnt, $mycxn)or die(mysql_error());
			echo " (".mysql_num_rows($q_cnt).")";  ?></a></li>	<?php } ;  ?>
        </ul>
      </li>
      <li>
        <h2>Courses</h2>
        <ul>
        <?php
		 do { ?>
          <li><a href="crs_lessons.php?crs=<?php echo $r_subj['id_crs']; ?>"><?php echo $r_subj['code_crs']; ?> 
          <?php  $q_count= sprintf("SELECT * FROM lesson_tbl WHERE course_id_lssn = %s", GetSQLValueString($r_subj['id_crs'], "text")); mysql_select_db($database_mycxn, $mycxn);
			$q_count = mysql_query($q_count, $mycxn)or die(mysql_error());
			echo "(".mysql_num_rows($q_count).")"; ?></a>
          </li>
		 <?php } while ($r_subj = mysql_fetch_assoc($q_subj));  ?>
        </ul>
      </li>
      <li>
        <h2>Links</h2>
  	<ul>
    	<li><a href="courses.php">Courses</a></li>
    	<li><a href="forum.php">Forum</a></li>
  	</ul>
      </li>
      <li>
        <h2>Search</h2>
        <form method="get" action="#">
          <div>
            <input type="text" id="textfield1" name="textfield1" value="" size="18" />
            <input type="submit" id="submit1" name="submit1" value="Go" />
          </div>
        </form>
      </li>
    </ul>
    <div style="clear: both;">&nbsp;</div>
  </div>
  </div>
<div id="footer">
  <p>Copyright &copy; 2014 VirtualClass! Powered by <a href="http://www.oluwarufus.com/"><strong>Oluwarufus</strong></a></p>
</div>