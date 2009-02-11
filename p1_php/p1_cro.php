<?php

/* @Author - Yogesh Mali
   @date - 10th December, 2008
   @description - modularizing the code */
   
  include("p1_config.php");
  require_once("MDB.php");
  
  session_start();
  $dsn = "mysql://$p1_db_user:$p1_password@$p1_host/$p1_database";

  $db = MDB::connect($dsn);

  $userid = $_SESSION['u_id'];
  $roleid = $_COOKIE['u_role'];
  $secname = mysql_real_escape_string($_GET['section']);
    
  function cro_tabs_to_xmldoc($var_dbuser,$var_pass,$var_host,$var_db,$var_uid,$var_section,$var_study)
  {
    $dsn = "mysql://$var_dbuser:$var_pass@$var_host/$var_db";
    $db = MDB::connect($dsn);
    $doc = new DomDocument('1.0');
    $root = $doc->createElement('root');
    $root = $doc->appendChild($root);
    $cro_str = "SELECT id,CRO_name FROM p1_cro WHERE crouser_id = '$var_uid' ";
    $cro_res = $db->query($cro_str);
    $res = $db->fetchRow($cro_res,MDB_FETCHMODE_ASSOC);
    $croname = $res['CRO_name'];
    $crouid = $res['id'];
    $root->setAttribute('my_name',$croname);             
    $root->setAttribute('user_id',$crouid);
    $sec_n = $doc->createElement('section');
    $sec_n = $root->appendChild($sec_n);
    $sec_n->setAttribute('study_number',$var_study);
    $sec_t = $doc->createTextNode($var_section);
    $sec_t = $sec_n->appendChild($sec_t);
    
    $st_str = "SELECT id,study_number FROM p1_study WHERE cro_id='$crouid' AND study_status='Active' ";
    $st_res = $db->query($st_str);
    while($row = $db->fetchInto($st_res,MDB_FETCHMODE_ASSOC))
    {
       if(empty($var_study))
       {
          $st_n = $doc->createElement('study');
          $st_n = $root->appendChild($st_n);
          $st_n->setAttribute('study_number',$row['study_number']);
       }else if(is_numeric($var_study))
       {
          $study_node = $doc->createElement('study');
          $study_node = $root->appendChild($study_node);
          $study_node->setAttribute('study_number',$var_study);
          $sty_det = "SELECT id,study_leader,sponsor,drug,target_enrollment,subject_comp,study_begin_date,study_end_date FROM p1_study WHERE study_number='$var_study' ";
          $sty_res = $db->query($sty_det);
          $rowres = $db->fetchRow($sty_res,MDB_FETCHMODE_ASSOC);
          $study_node->setAttribute('study_leader',$rowres['study_leader']);
          $study_node->setAttribute('sponsor',$rowres['sponsor']);
          $study_node->setAttribute('drug',$rowres['drug']);
          $study_node->setAttribute('target_enrollment',$rowres['target_enrollment']);
          $study_node->setAttribute('subject_compensation',$rowres['subject_comp']);
          $study_node->setAttribute('start_date',$rowres['study_begin_date']);
          $study_node->setAttribute('end_date',$rowres['study_end_date']);
          $sty_id = $rowres['id']; 
       }
    }
    $xml_out = $doc->saveXML();
    $xml = new DomDocument;
    $xml-> loadXML($xml_out);

    $xsl = new DomDocument;
    $xsl -> load('../p1_xsl/p1_cro.xsl');

    $xslt = new Xsltprocessor;
    $xslt -> importStylesheet($xsl);
    $transformation = $xslt->transformToXml($xml);
    echo $transformation;
    
    $db->disconnect(); 
  }
  
  if(!isset($roleid))
  {

  }else if($roleid == 'cro')
  {
	  switch($secname)
	  {
	     case "cro_add":
/*	         $doc = new DomDocument('1.0');
                 $root = $doc->createElement('root');
                 $root = $doc->appendChild($root);
	         $st_str = "SELECT t1.study_number, t2.id,t2.CRO_name FROM p1_study AS t1 INNER JOIN p1_cro AS t2 ON t1.cro_id = t2.id WHERE t2.crouser_id='$userid' AND t1.study_status='Active'";
                 $rs_study = $db->query($st_str);              
                 $sty_num = mysql_real_escape_string($_GET['study_number']);
             
                 while($res = $db->fetchInto($rs_study,MDB_FETCHMODE_ASSOC))
                 {
                   if(empty($sty_num))
                   {
                      $root->setAttribute('my_name',$res['CRO_name']);
                      $root->setAttribute('user_id',$res['id']);
                      $study_node = $doc->createElement('study');
                      $study_node = $root->appendChild($study_node);
                      $study_node->setAttribute('study_number',$res['study_number']);
                   }else if(is_numeric($sty_num))
                   {
                      $root->setAttribute('my_name',$res['CRO_name']);
                      $root->setAttribute('user_id',$res['id']);
                      $study_node = $doc->createElement('study');
                      $study_node = $root->appendChild($study_node);
                      $study_node->setAttribute('study_number',$sty_num);
                      $sty_det = "SELECT id,study_leader,sponsor,drug,target_enrollment,study_begin_date,study_end_date FROM p1_study WHERE study_number='$sty_num' ";
                      $sty_res = $db->query($sty_det);
                      $rowres = $db->fetchRow($sty_res,MDB_FETCHMODE_ASSOC);
                      $study_node->setAttribute('study_leader',$rowres['study_leader']);
                      $study_node->setAttribute('sponsor',$rowres['sponsor']);
                      $study_node->setAttribute('drug',$rowres['drug']);
                      $study_node->setAttribute('start_date',$rowres['study_begin_date']);
                      $study_node->setAttribute('end_date',$rowres['study_end_date']);             
                      $sty_id = $rowres['id'];
                   
                   } 
                 }
                 $sec_node = $doc->createElement('section');
                 $sec_node = $root->appendChild($sec_node);
                 $sec_node->setAttribute('study_number',$sty_num);
                 $sec_text = $doc->createTextNode("cro_add");
                 $sec_text = $sec_node->appendChild($sec_text);
                 $xml_out = $doc->saveXML();
                 $xml = new DomDocument;
                 $xml-> loadXML($xml_out);
   
                 $xsl = new DomDocument;
                 $xsl -> load('../p1_xsl/p1_cro.xsl');

                 $xslt = new Xsltprocessor;
                 $xslt -> importStylesheet($xsl);

                 $transformation = $xslt->transformToXml($xml);
                 echo $transformation; */
                 $casename = "cro_add";
                 $user_id = $userid;
                 $sty_num  = mysql_real_escape_string($_GET['study_number']);
                 cro_tabs_to_xmldoc($p1_db_user,$p1_password,$p1_host,$p1_database,$user_id,$casename,$sty_num);
	         break;
	     case "cro_register":
	         $casename = "cro_register";
                 $user_id = $userid;
	         $sty_num = mysql_real_escape_string($_GET['study_number']);
	         cro_tabs_to_xmldoc($p1_db_user,$p1_password,$p1_host,$p1_database,$user_id,$casename,$sty_num);
	         break;
	     case "cro_active":
	         $casename = "cro_active";
                 $user_id = $userid;
	         $sty_num = mysql_real_escape_string($_GET['study_number']);
	         cro_tabs_to_xmldoc($p1_db_user,$p1_password,$p1_host,$p1_database,$user_id,$casename,$sty_num);       
	         break;
	     case "cro_close":	  
	         $casename = "cro_close";
                 $user_id = $userid;
                 $sty_num = mysql_real_escape_string($_GET['study_number']);
	         cro_tabs_to_xmldoc($p1_db_user,$p1_password,$p1_host,$p1_database,$user_id,$casename,$sty_num);               
	         break;
	     case "cro_action":
	         $casename = "cro_action";
	         $doc = new DomDocument('1.0');
                 $root = $doc->createElement('root');
                 $root = $doc->appendChild($root);
	         $cro_det = "SELECT id,CRO_name FROM p1_cro WHERE crouser_id='$userid'";
                 $cro_res = $db->query($cro_det);
                 $res = $db->fetchRow($cro_res,MDB_FETCHMODE_ASSOC);
                 $croid = $res['id'];
                 $st_str = "SELECT id,study_number FROM p1_study WHERE cro_id='$croid' AND study_status='Active' ";
                 $st_res = $db->query($st_str);
                 $sty_num = mysql_real_escape_string($_GET['study_number']);
                 $root->setAttribute('my_name',$res['CRO_name']);
                 $root->setAttribute('user_id',$res['id']);
                 while($row = $db->fetchInto($st_res,MDB_FETCHMODE_ASSOC))
                 {
                   if(empty($sty_num))
                   {
                     $st_n = $doc->createElement('study');
                     $st_n = $root->appendChild($st_n);
                     $st_n->setAttribute('study_number',$row['study_number']);
                   }else if(is_numeric($sty_num))
                   {
                     $study_node = $doc->createElement('study');
                     $study_node = $root->appendChild($study_node);
                     $study_node->setAttribute('study_number',$sty_num);
                     $sty_det = "SELECT id,study_leader,sponsor,drug,target_enrollment,subject_comp,study_begin_date,study_end_date FROM p1_study WHERE study_number='$sty_num' ";
                     $sty_res = $db->query($sty_det);
                     $rowres = $db->fetchRow($sty_res,MDB_FETCHMODE_ASSOC);
                     $study_node->setAttribute('study_leader',$rowres['study_leader']);
                     $study_node->setAttribute('sponsor',$rowres['sponsor']);
                     $study_node->setAttribute('drug',$rowres['drug']);
                     $study_node->setAttribute('target_enrollment',$rowres['target_enrollment']);
                     $study_node->setAttribute('subject_compensation',$rowres['subject_comp']);	
                     $study_node->setAttribute('start_date',$rowres['study_begin_date']);
                     $study_node->setAttribute('end_date',$rowres['study_end_date']);
                     $sty_id = $rowres['id']; 
                     $str_q = "SELECT id,initials,date_of_birth,last_4_ssn FROM p1_subject_screen WHERE study_id='$sty_id'";
                     $str_r = $db->query($str_q);
                     while($subres = $db->fetchInto($str_r,MDB_FETCHMODE_ASSOC))
                     {
                       $init = $subres['initials'];
                       $bdate = $subres['date_of_birth'];
                       $ssn = $subres['last_4_ssn'];
                       $sub_id = $init."-".$bdate."-".$ssn;               
                       $en_sub = sha1($sub_id);
                       $cross_str = "SELECT id FROM p1_subject WHERE subject_id='$en_sub'";
                       $cross_res = $db->query($cross_str);
                       $num_res = $db->numRows($cross_res);
                       if($num_res > 0)
                       {
                         $sub_n = $doc->createElement('subject');
                         $sub_n = $root->appendChild($sub_n);
                         $sub_n->setAttribute('subject_id',$sub_id);
                         $sub_n->setAttribute('flagged',"true");
                         $sub_n->setAttribute('study_number',$sty_num);
                       }else
                       {
                         $sub_n = $doc->createElement('subject');
                         $sub_n = $root->appendChild($sub_n);
                         $sub_n->setAttribute('subject_id',$sub_id);
                         $sub_n->setAttribute('flagged',"false");
                         $sub_n->setAttribute('study_number',$sty_num);
                       }
                     }             
                   }
                 }
                 $sec_n = $doc->createElement('section');
                 $sec_n = $root->appendChild($sec_n);
                 $sec_n->setAttribute('study_number',$sty_num);
                 $sec_t = $doc->createTextNode("cro_action");
                 $sec_t = $sec_n->appendChild($sec_t);
                 $xml_out = $doc->saveXML();
                 $xml = new DomDocument;
                 $xml-> loadXML($xml_out);

                 $xsl = new DomDocument;
                 $xsl -> load('../p1_xsl/p1_cro.xsl');
  
                 $xslt = new Xsltprocessor;
                 $xslt -> importStylesheet($xsl);
 
                 $transformation = $xslt->transformToXml($xml);
                 echo $transformation;
                 break;
           case "cro_screen":
	         $casename = "cro_screen";
	         $doc = new DomDocument('1.0');
                 $root = $doc->createElement('root');
                 $root = $doc->appendChild($root);
	         $cro_det = "SELECT id,CRO_name FROM p1_cro WHERE crouser_id='$userid'";
                 $cro_res = $db->query($cro_det);
                 $res = $db->fetchRow($cro_res,MDB_FETCHMODE_ASSOC);
                 $croid = $res['id'];
                 $st_str = "SELECT id,study_number FROM p1_study WHERE cro_id='$croid' AND study_status='Active' ";
                 $st_res = $db->query($st_str);
                 $sty_num = mysql_real_escape_string($_GET['study_number']);
                 $root->setAttribute('my_name',$res['CRO_name']);
                 $root->setAttribute('user_id',$res['id']);

                 while($row = $db->fetchInto($st_res,MDB_FETCHMODE_ASSOC))
                 {
                   if(empty($sty_num))
                   {
                     $st_n = $doc->createElement('study');
                     $st_n = $root->appendChild($st_n);
                     $st_n->setAttribute('study_number',$row['study_number']);
                   }else if($row['study_number'] == $sty_num) /*if(is_numeric($sty_num))*/
                   {
                     $study_node = $doc->createElement('study');
                     $study_node = $root->appendChild($study_node);
                     $study_node->setAttribute('study_number',$sty_num);
                     $sty_det = "SELECT id,study_leader,sponsor,drug,target_enrollment,subject_comp,study_begin_date,study_end_date FROM p1_study WHERE study_number = '$sty_num' ";
                     $sty_res = $db->query($sty_det);
                     $rowres = $db->fetchRow($sty_res,MDB_FETCHMODE_ASSOC);
                     $study_node->setAttribute('study_leader',$rowres['study_leader']);
                     $study_node->setAttribute('sponsor',$rowres['sponsor']);
                     $study_node->setAttribute('drug',$rowres['drug']);
                     $study_node->setAttribute('target_enrollment',$rowres['target_enrollment']);
                     $study_node->setAttribute('subject_compensation',$rowres['subject_comp']);
                     $study_node->setAttribute('start_date',$rowres['study_begin_date']);
                     $study_node->setAttribute('end_date',$rowres['study_end_date']);
                     $sty_id = $rowres['id'];
                     $str_q = "SELECT id,subject_id,initials,date_of_birth,last_4_ssn FROM p1_subject_screen WHERE study_id='$sty_id'";
                     $str_r = $db->query($str_q);
                     $resnum = $db->numRows($str_r);
                     if($resnum > 0)
                     {
                       while($subres = $db->fetchInto($str_r,MDB_FETCHMODE_ASSOC))
                       {
                         $init = $subres['initials'];
                         $bdate = $subres['date_of_birth'];
                         $ssn = $subres['last_4_ssn'];
                         $sub_id = $init."-".$bdate."-".$ssn;
                         $en_sub = sha1($sub_id);
                         $cross_str = "SELECT id FROM p1_subject WHERE subject_id='$en_sub'";
                         $cross_res = $db->query($cross_str);
                         $num_res = $db->numRows($cross_res);
                         if($num_res == 1)
                         { 
                           $sub_n = $doc->createElement('subject');
                           $sub_n = $root->appendChild($sub_n);
                           $sub_n->setAttribute('subject_id',$sub_id);
                           $sub_n->setAttribute('flagged',"true");
                           $last_day = $rowres['study_end_date'];
                           $eligible = date("M. d Y", strtotime("$last_day+1 day"));
                           $sub_n->setAttribute('eligible',$eligible);
                           $sub_n->setAttribute('study_number',$sty_num);
                        }else
                        {
                           $sub_n = $doc->createElement('subject');
                           $sub_n = $root->appendChild($sub_n);
                           $sub_n->setAttribute('subject_id',$sub_id);
                           $sub_n->setAttribute('flagged',"false");
                           $sub_n->setAttribute('study_number',$sty_num);
                        }
                      }
                    }
                  }
                }
                $sec_n = $doc->createElement('section');
                $sec_n = $root->appendChild($sec_n);
                $sec_n->setAttribute('study_number',$sty_num);
                $sec_t = $doc->createTextNode("cro_screen");
                $sec_t = $sec_n->appendChild($sec_t);
             
                $xml_out = $doc->saveXML();
                $xml = new DomDocument;
                $xml-> loadXML($xml_out);

                $xsl = new DomDocument;
                $xsl -> load('../p1_xsl/p1_cro.xsl');

                $xslt = new Xsltprocessor;
                $xslt -> importStylesheet($xsl);

                $transformation = $xslt->transformToXml($xml);
                 echo $transformation;
	         break;    
           default:  
             $doc = new DomDocument('1.0');
             $root = $doc->createElement('root');
             $root = $doc->appendChild($root);
	  
             $xml_out = $doc->saveXML();
             $xml = new DomDocument;
             $xml-> loadXML($xml_out);

             $xsl = new DomDocument;
             $xsl -> load('../p1_xsl/p1_cro.xsl');

             $xslt = new Xsltprocessor;
             $xslt -> importStylesheet($xsl);

             $transformation = $xslt->transformToXml($xml);
             echo $transformation;

      }
      
/*    $xml_out = $doc->saveXML();
      $xml = new DomDocument;
      $xml-> loadXML($xml_out);

      $xsl = new DomDocument;
      $xsl -> load('../p1_xsl/p1_cro.xsl');

      $xslt = new Xsltprocessor;
      $xslt -> importStylesheet($xsl);

      $transformation = $xslt->transformToXml($xml);
      echo $transformation; */
  }	  
  
  // close the connection
  $db->disconnect(); 
?>
