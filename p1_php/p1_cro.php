<?php 
/*
    @Author - Yogesh Mali
    @Date - 15th November, 2008 
*/

  include("p1_config.php");
  require_once("MDB.php");

  session_start();  
  $dsn = "mysql://$p1_db_user:$p1_password@$p1_host/$p1_database";

  $db = MDB::connect($dsn);

  $userid = $_SESSION['u_id'];
  $roleid = $_COOKIE['u_role'];
  $secname = $_GET['section'];  
  if(!isset($roleid))
  {


  }else if($roleid == 'cro')
  {
    $doc = new DomDocument('1.0');
    $root = $doc->createElement('root');
    $root = $doc->appendChild($root);
    
    switch($secname)
    {
      case "cro_add":
            $st_str = "SELECT t1.study_number, t2.id,t2.CRO_name FROM p1_study AS t1 INNER JOIN p1_cro AS t2 ON t1.cro_id = t2.id WHERE t2.crouser_id='$userid'";
            $rs_study = $db->query($st_str);
              
            $sty_num = $_GET['study_number'];
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
                   $sty_det = "SELECT id,study_leader,sponsor,drug,study_begin_date,study_end_date FROM p1_study WHERE study_number='$sty_num' ";
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
         break;
       case "cro_register":
             $cro_str = "SELECT id,CRO_name FROM p1_cro WHERE crouser_id='$userid'";
             $cro_res = $db->query($cro_str);
             $res = $db->fetchRow($cro_res,MDB_FETCHMODE_ASSOC);
             $croname = $res['CRO_name'];
             $crouid = $res['id'];
             $root->setAttribute('my_name',$croname);             
             $root->setAttribute('user_id',$crouid);
             $sec_n = $doc->createElement('section');
             $sec_n = $root->appendChild($sec_n);
             $sec_t = $doc->createTextNode("cro_register");
             $sec_t = $sec_n->appendChild($sec_t);
         break;  
       case "cro_active":
            $cro_det = "SELECT id FROM p1_cro WHERE crouser_id='$userid'";
            $cro_res = $db->query($cro_det);
            $res = $db->fetchRow($cro_res,MDB_FETCHMODE_ASSOC);
            $croid = $res['id'];
            $st_str = "SELECT id,study_number,study_leader,sponsor,drug,subject_comp,study_begin_date,study_end_date FROM p1_study WHERE cro_id='$croid' AND study_status='Active' ";
            $st_res = $db->query($st_str);
            $sty_num = $_GET['study_number'];
            while($row = $db->fetchInto($st_res,MDB_FETCHMODE_ASSOC))
            {
               if(empty($sty_num))
               {
                 $st_n = $doc->createElement('study');
                 $st_n = $root->appendChild($st_n);
                 
               }else if(is_numeric($sty_num))
               {

               }                             
            }            
       default:        



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
   
   }

 // close the connection
  $db->disconnect();

?>
    
