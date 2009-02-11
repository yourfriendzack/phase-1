<?php 
 
/*  @author - Yogesh Mali
    @date  - 20th November,2008
    @description - CRO pages' tabs.  */

  include("p1_config.php");
  require_once("MDB.php");
  $var = mysql_real_escape_string($_GET['location']);

  $dsn = "mysql://$p1_db_user:$p1_password@$p1_host/$p1_database";
  $db = MDB::connect($dsn);
  
  switch($var)
  {
    case "screen":
          $serial_str = $_GET['subject_id'];
          $sty_num = mysql_real_escape_string($_GET['study_number']);
          $str = "SELECT id,study_end_date FROM p1_study WHERE study_number = '$sty_num' ";
          $res = $db->query($str);
          $row = $db->fetchRow($res,MDB_FETCHMODE_ASSOC);
          $sty_id = $row['id'];
          $end_date = $row['study_end_date'];
          $eligible = date("M. d Y ", strtotime("$end_date + 1 day"));
          $arr = unserialize(urldecode(stripslashes($serial_str)));         

          $i = 0;
          $flag1 = "false";
          if(!empty($serial_str))
          {
            foreach( $arr as $val)
            {
              $sub_id = $val;
              if(strlen($sub_id) == 15)
              {
                $en_sub = sha1($sub_id);
                $add_str = "SELECT id FROM p1_subject WHERE subject_id = '$en_sub'";
                $add_res = $db->query($add_str);
                $num_add = $db->numRows($add_res);
                if($num_add == 0)
                {
                  $check_str = "SELECT id FROM p1_subject_screen WHERE subject_id='$en_sub'";
                  $check_res = $db->query($check_str);
                  $num_res = $db->numRows($check_res);
                  if($num_res == 0)
                  {
                    $init = substr($sub_id,0,3);
                    $bday = substr($sub_id,4,6);
                    $l4ssn = substr($sub_id,11,4);
                    $store_str = "INSERT INTO p1_subject_screen(study_id,subject_id,initials,date_of_birth,last_4_ssn) VALUES('$sty_id','$en_sub','$init','$bday','$l4ssn') ";
                    $store_res = $db->query($store_str);
                    if(MDB::isError($store_res))
                    {
                      $flag1 = "true";
                    } else
                    {
                      $flag2 = "true";                           
                    }
                  }else
                  {
                    $flag3 = "true";               
                  }
                }else
                {
                  $flagged_sub[$i] = $sub_id;
                  $flagged_date[$i] = $eligible;
                  $i = $i + 1;
                  $flag2 = "true";
                }
              }else
              {
                $flag4 = "true";
              }
            }
            if($flag1 != "true" && $flag2 == "true" && flag4 != "true")
            {
              if(count(array_filter($flagged_sub)) == 0)
              {
                $response = "[true ]";
              }
              else
              {
                $value = implode(",",$flagged_sub);                
                $dval = implode(",",$flagged_date);
                $response = "[true , '$value'  , '$dval' ]";
              }
            }else if($flag1 == "true" || $flag4 == "true")
            { 
              $response = "[false]";
            }else if($flag3 == "true" && $flag1 != "true")
            {
              $response = "[true]";
            }          
          }else
          {
             $response = "[false]";
          }
          break;
    case "add_subject":
          $ser_out_str = $_GET['outpatient_date'];
          $ser_wash_out = $_GET['washout'];
          $ser_sub_str = $_GET['subject_id'];
          $sty_num = mysql_real_escape_string($_GET['study_number']);
          $arr_sub = unserialize(urldecode(stripslashes($ser_sub_str))); 
          $arr_date = unserialize(urldecode(stripslashes($ser_out_str)));        
          $arr_wash = unserialize(urldecode(stripslashes($ser_wash_out)));
          $str = "SELECT id FROM p1_study WHERE study_number = '$sty_num' ";
          $res = $db->query($str);
          $row = $db->fetchRow($res,MDB_FETCHMODE_ASSOC);
          $sty_id = $row['id'];
          
          $i = 0;$j = 0;$num_of_elements = count($arr_sub);
          if(!empty($ser_sub_str) && !empty($ser_out_str) && !empty($ser_wash_out))
          {
	          foreach($arr_sub as $val)
	          {
		         $sub_id = $val;
		         if(strlen($sub_id) == 15)
		         {
		           $en_sub = sha1($sub_id);
		           $check_str = "SELECT id FROM p1_subject WHERE subject_id = '$en_sub' ";
		           $check_res = $db->query($check_str);
		           $num_res = $db->numRows($check_res);
		           if($num_res == 0)
		           {
			      $init = substr($sub_id,0,3);
                              $bday = substr($sub_id,4,6);
	                      $l4ssn = substr($sub_id,11,4);
                              $var_washout = $ser_wash_out[$i];
                              $outdate = $ser_out_str[$i];
                              $var_outdate = date("Y-m-d",strtotime($outdate));
                              $store_str = "INSERT INTO p1_subject(study_id,subject_id,initials,date_of_birth,last_4_ssn,outpatient_date,wash_out_period) VALUES('$sty_id','$en_sub','$init','$bday','$l4ssn','$var_outdate','$var_washout') ";
                              $store_res = $db->query($store_str);
                              if(MDB::isError($store_res))
                              {
	                        $f_ins_failed = "true";    
                              }else
                              {
                                $f_ins_success = "true";
	                        $i = $i + 1;           	                    
		              } 
		           }else        
		           {
		              $j = $j + 1;		          
                           }	          
                        }else  
                        {
	                  $f_sub_wrong = "true";
                        }    
                  }
              if($f_ins_failed != "true" && $f_ins_success == "true" && $f_sub_wrong != "true")
              {
	          $response = "true";
              }else if($j == $num_of_elements)
              {
	          $response = "false";
              }else if($f_ins_failed == "true" || $f_sub_wrong == "true")
              {
	          $response = "false";              
	      }    
          }else
          {
	      $response = "false";
          }
          break;
    case "add_study":
         $cro_id = mysql_real_escape_string($_GET['user_id']);
         $sty_num = mysql_real_escape_string($_GET['study_number']);
         $sty_leader = mysql_real_escape_string($_GET['study_leader']);
         $sponsor = mysql_real_escape_string($_GET['sponsor']);
         $drug = mysql_real_escape_string($_GET['drug']);
         $target = mysql_real_escape_string($_GET['target_enrollment']);
         $sub_compensation = mysql_real_escape_string($_GET['subject_compensation']);
         $sty_beg_date = mysql_real_escape_string($_GET['start_date']);
         $sty_end_date = mysql_real_escape_string($_GET['end_date']);
         $beg_date = date("Y-m-d",strtotime($sty_beg_date));  
         $end_date = date("Y-m-d",strtotime($sty_end_date));

         if(is_numeric($sty_num) && isset($sty_leader) && isset($sponsor) && isset($drug))
         {   
            $check_q = "SELECT * FROM p1_study WHERE study_number='$sty_num' ";
            $check_r = $db->query($check_q);
            $num_of_rows = $db->numRows($check_r);
            if($num_of_rows == 0)
           { 
             $ins_str = "INSERT INTO p1_study(cro_id,study_number,study_leader,sponsor,drug,target_enrollment,subject_comp,study_begin_date,study_end_date,study_status) VALUES('$cro_id','$sty_num','$sty_leader','$sponsor','$drug','$target','$sub_compensation','$beg_date','$end_date','Active') ";
             $ins_res = $db->query($ins_str);
             if(MDB::isError($ins_res))
             {
               $response = "false";
             }else
             {
               $response = "true";
             }
           }else
           {
             $response = "false";
           }
         }else
         {
             $response = "false";
         }
         break;
    case "close_study":
         $cro_id = mysql_real_escape_string($_GET['user_id']);
         $sty_num = mysql_real_escape_string($_GET['study_number']);
         if(is_numeric($sty_num) && isset($cro_id))
         {
           $close_str = "UPDATE p1_study SET study_status='Closed' WHERE study_number = '$sty_num' ";
           $close_res = $db->query($close_str);
           if(MDB::isError($close_res))
           {
             $response = "false";
           }else
           {
             $response = "true";
           }
         }else
         {
            $response = "false";
         }    
        break;
    case "save_study":
        $sty_num = mysql_real_escape_string($_GET['study_number']);
        $sty_leader = mysql_real_escape_string($_GET['study_leader']);
        $sponsor = mysql_real_escape_string($_GET['sponsor']);
        $drug = mysql_real_escape_string($_GET['drug']);
        $target = mysql_real_escape_string($_GET['target_enrollment']);
        $sub_comp = mysql_real_escape_string($_GET['subject_compensation']);
        if(is_numeric($sty_num) && isset($sty_leader) && isset($sponsor))
        {
          $save_str = "UPDATE p1_study SET study_leader='$sty_leader',sponsor='$sponsor',drug='$drug',target_enrollment='$target',subject_comp='$sub_comp' WHERE study_number = '$sty_num' ";
          $save_res = $db->query($save_str);
          if(MDB::isError($save_res))
          {
            $response = "false";
          }else
          {
            $response = "true";
          }      
        }else
        {
          $response = "false";
        }
        break;
    default:
         $response = "true";  

  }
  echo $response;
  $db->disconnect();
?>
