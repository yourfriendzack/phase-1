<?php

/* Name - Yogesh Mali
   Date - 26th September 
   Modification Date - 5th November, using PEAR packages.   

*/

   include("p1_config.php");
   require_once("MDB.php");
   $var_submit = mysql_real_escape_string($_GET['location']);
   session_start();

   $dsn = "mysql://$p1_db_user:$p1_password@$p1_host/$p1_database";
   $db = MDB::connect($dsn);
   
   switch($var_submit)
   {
      case "login":
              $loginid = mysql_real_escape_string($_GET['login_id']);
   	      $passwd = mysql_real_escape_string($_GET['password']);
   	      if(MDB::isError($db))
   	      {
   		    $response = "[false]";
   	      }else
   	      {
   		    if(isset($passwd))
   		    { 
             	       $len = strlen($passwd);
     	               $passlen = $len-8;
                       $password = substr($passwd,0,$passlen);
   		       $str_user = "SELECT * FROM p1_users WHERE login_id='$loginid'"; 
   		       $res = $db->query($str_user);
                       $num = $db->numRows($res);
                       $results = $db->fetchRow($res, MDB_FETCHMODE_ASSOC);
   		       if($num==0)
   		       {
   		         $response="[false]";
   		       }else
   		       {
   		         $checkpass = $results['password'];
   		         $checkuser = $results['login_id'];
   		         $checkrole = $results['role'];
   		         if((!isset($checkrole))) 
   		         {
   		           $response = "[false]" ;
   		         }else
   		         {  
                            if($checkrole == 'admin')
                            {
                               if($password == $checkpass)
   		               {
                                  $response = "[true ,'$checkrole']";
                                  setcookie("user_id","$loginid",time()+3600);
                                  setcookie("user_role","$checkrole",time()+3600);
                               }else
   			       {
   			          $response = "[false]";
                               }
                            }else if($checkrole == 'cro')
                            {
                              if($password == $checkpass)
                              {
                              
                                $response = "[true,'$checkrole']";
                                setcookie("u_id","$loginid",time()+3600);
                                $_SESSION['u_id'] = $loginid;
                                setcookie("u_role","$checkrole",time()+3600);                                
                              }else
                              {
                                 $response = "[false]";
                              }
                            }else
                            {
                                $response="[false]";
                            }
   		          }
   		      }
   		   }else
   		   {
   		     $response = "[false]";
   		   }
   	     }
   	     $db->disconnect();
     	break;
      case "remove_study":
        $study_id = mysql_real_escape_string($_GET['study_id']);
        $study_num = mysql_real_escape_string($_GET['study_number']);
        if(MDB::isError($db))
        {
           $response = "false";
        }else
        { 
           $str_del_study = "DELETE FROM p1_study WHERE id = '$study_id' AND study_number='$study_num' ";
           $res = $db->query($str_del_study);
           if(MDB::isError($res))
           {
             $response = "false";
           }else
           {
             $response = "true";
           }
        }
        $db->disconnect();
        break;
      default:
        $response = "true";
   }
   
   echo $response;
?>
