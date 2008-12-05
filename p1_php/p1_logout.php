<?php
/* @author - Yogesh Mali */

  setcookie("user_id","",time()-14400);
  setcookie("user_role","",time()-14400);
  header("Location: http://zisland.webhop.net/phase-1/p1_php/p1_login.php");

?>
