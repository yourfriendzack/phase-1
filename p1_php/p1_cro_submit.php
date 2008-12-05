<?php 
 
/*  @author - Yogesh Mali
    @date  - 20th November,2008
    @description - CRO pages' tabs.  */

  include("p1_config.php");
  require_once("MDB.php");
  $var = $_GET['location'];

  $dsn = "mysql://$p1_db_user:$p1_password@$p1_host/$p1_database";
  $db = MDB::connect($dsn);
  
  switch($var)
  {
    case "add_subject":
          $cro = $_GET['user_id'];
          $study_num = $_GET['study_number'];
          $subject = $_GET['subjects'];
          $num = $_GET['add_quantity'];
          $cro_sql = "SELECT * FROM p1_cro WHERE id = '$cro'";
          $cro_res = $db->query($cro_sql);
          if(MDB::isError($cro_res))
          {
             die($cro_res->getMessage());
          }
          $sty_sql = "SELECT id FROM p1_study WHERE study_number = '$study_num'";
          $sty_res = $db->query($sty_sql);
          if(MDB::isError($sty_res))
          {
              die($sty_res->getMessage());
          }else
          {
             $res = $db->fetchRow($sty_res,MDB_FETCHMODE_ASSOC);
             $sty_id = $res['id'];
          }
          $sub = urldecode($subject);
          $sub_str = str_replace("*","",$sub);
          $sub_spc = str_replace(" ","",$sub_str);
          $len = strlen($sub_spc);
          for($i=1;$i<= $num;$i++)
          {
            $sub_id = substr($sub_spc,1,15);
            $op_date = substr($sub_spc,16,11);
            
            $wash_out = substr($sub_spc,27,6);                      
            $init = substr($sub_id,0,3);
            $bdate = substr($sub_id,4,6);
            $l4ssn = substr($sub_id,11,4);
            $opdate = date("Y-m-d",strtotime($op_date));      
            $en_sub = sha1($sub_id);
  
            $check_str = "SELECT id,study_id,subject_id FROM p1_subject WHERE study_id='$sty_id' AND subject_id='$en_sub'";
            $check_res = $db->query($check_str);
            $number = $db->numRows($check_res);
            if($number == 0)
            { 
              $cro_str = "INSERT INTO p1_subject(study_id,subject_id,initials,date_of_birth,last_4_ssn,outpatient_date,wash_out_period) VALUES('$sty_id','$en_sub','$init','$bdate','$l4ssn','$opdate','$wash_out') ";
              $ins_res = $db->query($cro_str);              
              if(MDB::isError($ins_res))
              {
                 $response="[false]";
                 break;
              }else
              {
                 $response="[true]";
                 $sub_spc = substr($sub_spc,33,$len);
                 $len = strlen($sub_spc);
                 $flag1 = "true1"; 
              }           
            }else
            {
               $response .= " $i ,";
               $sub_spc = substr($sub_spc,33,$len);
               $len = strlen($sub_spc);
               $flag2 = "true2";
            } 
          }          
          if($flag1 == "true1" && $flag2 == "true2")
          {
             $response = "[ true ". $response . " ]";
          }else if($flag1 = "true1" && $flag2 != "true2")
          {
             $response = "[ true ]"; 
          }else
          {
             $response = "[ false ]";
          } 
          $db->disconnect();
          break;
    case "add_study":
         $cro_id = $_GET['user_id'];
         $sty_num = $_GET['study_number'];
         $sty_leader = $_GET['study_leader'];
         $sponsor = $_GET['sponsor'];
         $drug = $_GET['drug'];
         $sub_compensation = $_GET['subject_compensation'];
         $sty_beg_date = $_GET['start_date'];
         $sty_end_date = $_GET['end_date'];
         $beg_date = date("Y-m-d",strtotime($sty_beg_date));  
         $end_date = date("Y-m-d",strtotime($sty_end_date));

         if(is_numeric($sty_num) && isset($sty_leader) && isset($sponsor) && isset(drug))
         {   
            $check_q = "SELECT * FROM p1_study WHERE study_number='$sty_num' ";
            $check_r = $db->query($check_q);
            $num_of_rows = $db->numRows($check_r);
            if($num_of_rows == 0)
           { 
             $ins_str = "INSERT INTO p1_study(cro_id,study_number,study_leader,sponsor,drug,subject_comp,study_begin_date,study_end_date,study_status) VALUES('$cro_id','$sty_num','$sty_leader','$sponsor','$drug','$sub_compensation','$beg_date','$end_date','Active') ";
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
    default:
         $response = "true";  

  }
  echo $response;
?>
