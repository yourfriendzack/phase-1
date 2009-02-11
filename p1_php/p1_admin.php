<?php
/*
 * @author - Yogesh Mali
 * @date - 23rd October, 2008
 * modification date - 5th November, 2008 with PEAR packages use
 */
 
  include("p1_config.php"); 
  require_once("MDB.php");
  
  $dsn = "mysql://$p1_db_user:$p1_password@$p1_host/$p1_database";
  
  $db = MDB::connect($dsn);
  
  
  $userid = mysql_real_escape_string($_COOKIE['user_id']);
  $roleid = mysql_real_escape_string($_COOKIE['user_role']);
  $secname = mysql_real_escape_string($_GET['section']);
  if(!isset($roleid))
  {
  	$xml = new DomDocument;
  	$xml->load('p1_invalid.xml');
  	$xsl = new DomDocument;
  	$xsl->load('../p1_xsl/p1_invalid.xsl');
  	$xslt = new Xsltprocessor;
  	$xslt->importStyleSheet($xsl);
  	
  	$transformation=$xslt->transformToXml($xml);
  	echo $transformation;  	
  }else if($roleid=='admin')
  {
  	if(MDB::isError($db))
  	{
  		echo "Not connected";
  	}else
  	{
        $str_qcro = "SELECT id,CRO_name FROM p1_cro";
        $rs_cro = $db->query($str_qcro);
        if(MDB::isError($rs_cro))
        {
          die($rs_cro->getMessage());
        }    
  		$doc=new DomDocument('1.0');
  		$root = $doc->createElement('root');
  		$root = $doc->appendChild($root);    
        switch($secname)
        {
	        case "admin_all":
	           while($row=$db->fetchInto($rs_cro,MDB_FETCHMODE_ASSOC))
                   {
                     $cro_id = $row['id'];
                     $str_studies = "SELECT DISTINCT study_number FROM p1_study WHERE cro_id='$cro_id' ";
                     $rs_studies = $db->query($str_studies);
                     $cro_node = $doc->createElement('cro');
                     $cro_node  = $root->appendChild($cro_node);
                     $cro_text = $doc->createTextNode($row['CRO_name']);
                     $cro_text = $cro_node->appendChild($cro_text);
                     while($rowres = $db->fetchInto($rs_studies,MDB_FETCHMODE_ASSOC))
                     {
                       $study_num = $rowres['study_number'];
                       $str_details = "SELECT id,study_status,study_begin_date,study_end_date FROM p1_study WHERE study_number = '$study_num' ";
                       $rs_details = $db->query($str_details);
                       while($res = $db->fetchInto($rs_details,MDB_FETCHMODE_ASSOC))
                       {
                         $start_dt = $res['study_begin_date'];
                         $timestamp = mktime(0,0,0,substr($start_dt,5,2),substr($start_dt,8,2),substr($start_dt,0,4));
                         $begin_dt = date("M. d Y",$timestamp);
                         $end_dt = $res['study_end_date'];
                         $timestmp = mktime(0,0,0,substr($end_dt,5,2),substr($end_dt,8,2),substr($end_dt,0,4));
                         $closed_dt = date("M. d Y",$timestmp);
                         $study_node = $doc->createElement('study');
                         $study_node = $root->appendChild($study_node);
                         $study_node->setAttribute('status',$res['study_status']);
                         $study_node->setAttribute('study_id',$res['id']);
                         $study_node->setAttribute('cro',$row['CRO_name']);
                         $study_node->setAttribute('study_number',$rowres['study_number']);
                         $study_node->setAttribute('start_date',$begin_dt);
                         $study_node->setAttribute('closed_date',$closed_dt);
                         $sec_node = $doc->createElement('section');
                         $sec_node = $root->appendChild($sec_node);
                         $sec_text = $doc->createTextNode("admin_all");
                         $sec_text = $sec_node->appendChild($sec_text);     
                       }
                     }
                   }
	           break;
	        case "admin_active":
	           while($row=$db->fetchInto($rs_cro,MDB_FETCHMODE_ASSOC))
                   {
                     $cro_id = $row['id'];
                     $str_studies = "SELECT DISTINCT study_number FROM p1_study WHERE cro_id='$cro_id' ";
                     $rs_studies = $db->query($str_studies);
                     $cro_node = $doc->createElement('cro');
                     $cro_node  = $root->appendChild($cro_node);
                     $cro_text = $doc->createTextNode($row['CRO_name']);
                     $cro_text = $cro_node->appendChild($cro_text);
                     while($rowres = $db->fetchInto($rs_studies,MDB_FETCHMODE_ASSOC))
                     {
                       $study_num = $rowres['study_number'];
                       $str_details = "SELECT id,study_status,study_begin_date,study_end_date FROM p1_study WHERE study_number = '$study_num' ";
                       $rs_details = $db->query($str_details);
                       while($res = $db->fetchInto($rs_details,MDB_FETCHMODE_ASSOC))
                       {
                         $start_dt = $res['study_begin_date'];
                         $timestamp = mktime(0,0,0,substr($start_dt,5,2),substr($start_dt,8,2),substr($start_dt,0,4));
                         $begin_dt = date("M. d Y",$timestamp);
                         $end_dt = $res['study_end_date'];
                         $timestmp = mktime(0,0,0,substr($end_dt,5,2),substr($end_dt,8,2),substr($end_dt,0,4));
                         $closed_dt = date("M. d Y",$timestmp);
                         $study_node = $doc->createElement('study');
                         $study_node = $root->appendChild($study_node);
                         $study_node->setAttribute('status',$res['study_status']);
                         $study_node->setAttribute('study_id',$res['id']);
                         $study_node->setAttribute('cro',$row['CRO_name']);
                         $study_node->setAttribute('study_number',$rowres['study_number']);
                         $study_node->setAttribute('start_date',$begin_dt);
                         $study_node->setAttribute('closed_date',$closed_dt);
                         $study_node->setAttribute('subjects_screened',230);
                         $study_node->setAttribute('subjects_added',20);
                         $sec_node = $doc->createElement('section');
                         $sec_node = $root->appendChild($sec_node);
                         $sec_text = $doc->createTextNode("admin_active");
                         $sec_text = $sec_node->appendChild($sec_text);     
                       }
                     }
                   }       
	           break;
	        case "admin_closed":
	           while($row=$db->fetchInto($rs_cro,MDB_FETCHMODE_ASSOC))
                   {
                     $cro_id = $row['id'];
                     $str_studies = "SELECT DISTINCT study_number FROM p1_study WHERE cro_id='$cro_id' ";
                     $rs_studies = $db->query($str_studies);
                     $cro_node = $doc->createElement('cro');
                     $cro_node  = $root->appendChild($cro_node);
                     $cro_text = $doc->createTextNode($row['CRO_name']);
                     $cro_text = $cro_node->appendChild($cro_text);
                     while($rowres = $db->fetchInto($rs_studies,MDB_FETCHMODE_ASSOC))
                     {
                       $study_num = $rowres['study_number'];
                       $str_details = "SELECT id,study_status,study_begin_date,study_end_date FROM p1_study WHERE study_number = '$study_num' ";
                       $rs_details = $db->query($str_details);
                       while($res = $db->fetchInto($rs_details,MDB_FETCHMODE_ASSOC))
                       {
                         $start_dt = $res['study_begin_date'];
                         $timestamp = mktime(0,0,0,substr($start_dt,5,2),substr($start_dt,8,2),substr($start_dt,0,4));
                         $begin_dt = date("M. d Y",$timestamp);
                         $end_dt = $res['study_end_date'];
                         $timestmp = mktime(0,0,0,substr($end_dt,5,2),substr($end_dt,8,2),substr($end_dt,0,4));
                         $closed_dt = date("M. d Y",$timestmp);
                         $study_node = $doc->createElement('study');
                         $study_node = $root->appendChild($study_node);
                         $study_node->setAttribute('status',$res['study_status']);
                         $study_node->setAttribute('study_id',$res['id']);
                         $study_node->setAttribute('cro',$row['CRO_name']);
                         $study_node->setAttribute('study_number',$rowres['study_number']);
                         $study_node->setAttribute('start_date',$begin_dt);
                         $study_node->setAttribute('closed_date',$closed_dt);
                         $study_node->setAttribute('Invoice_status',"Invoice Sent");
                         $sec_node = $doc->createElement('section');
                         $sec_node = $root->appendChild($sec_node);
                         $sec_text = $doc->createTextNode("admin_closed");
                         $sec_text = $sec_node->appendChild($sec_text);     
                       }
                     }
                   }	               
	           break;
	        case "admin_master":
                  while($row=$db->fetchInto($rs_cro,MDB_FETCHMODE_ASSOC))
                   {
                     $cro_id = $row['id'];
                     $str_studies = "SELECT DISTINCT study_number FROM p1_study WHERE cro_id='$cro_id' and study_status='Closed' ";
                     $rs_studies = $db->query($str_studies);
                     while($rowres = $db->fetchInto($rs_studies,MDB_FETCHMODE_ASSOC))
                     {
                       $study_num = $rowres['study_number'];
                       $str_details = "SELECT id,study_status,study_begin_date,study_end_date FROM p1_study WHERE study_number = '$study_num' ";
                       $rs_details = $db->query($str_details);
                       while($res = $db->fetchInto($rs_details,MDB_FETCHMODE_ASSOC))
                       {
	                     $sty_id = $res['id'];	                     
	                     $inv_q = "SELECT id FROM p1_invoices WHERE study_id='$sty_id' ";
	                     $inv_res = $db->query($inv_q);
	                     $num = $db->numRows($inv_res);	                     
	                     if($num==0)
	                     {
		                     
	                     }else    
	                     {
	                       $cro_node = $doc->createElement('cro');
                           $cro_node  = $root->appendChild($cro_node);
                           $cro_text = $doc->createTextNode($row['CRO_name']);
                           $cro_text = $cro_node->appendChild($cro_text);		                     
	                       $rowinv = $db->fetchRow($inv_res,MDB_FETCHMODE_ORDERED);
                           $start_dt = $res['study_begin_date'];
                           $timestamp = mktime(0,0,0,substr($start_dt,5,2),substr($start_dt,8,2),substr($start_dt,0,4));
                           $begin_dt = date("M. d Y",$timestamp);
                           $end_dt = $res['study_end_date'];
                           $timestmp = mktime(0,0,0,substr($end_dt,5,2),substr($end_dt,8,2),substr($end_dt,0,4));
                           $closed_dt = date("M. d Y",$timestmp);
                           $study_node = $doc->createElement('study');
                           $study_node = $root->appendChild($study_node);
                           $study_node->setAttribute('status',$res['study_status']);
                           $study_node->setAttribute('study_id',$res['id']);
                           $study_node->setAttribute('cro',$row['CRO_name']);
                           $study_node->setAttribute('study_number',$rowres['study_number']);
                           $study_node->setAttribute('start_date',$begin_dt);
                           $study_node->setAttribute('closed_date',$closed_dt);
                           $study_node->setAttribute('invoice_number',$rowinv[0]);
                           $sec_node = $doc->createElement('section');
                           $sec_node = $root->appendChild($sec_node);
                           $sec_text = $doc->createTextNode("admin_master");
                           $sec_text = $sec_node->appendChild($sec_text);                           
                         }  
                       }
                     }
                   }                           
	            break;
	        case "admin_database":
	        
	            break;
	        default:
	        
        }        
                $xml_out = $doc->saveXML();  		
  		$xml = new DomDocument;
  		$xml->loadXML($xml_out);
  		$xsl = new DomDocument;
  		$xsl->load('../p1_xsl/p1_admin.xsl');
  		$xslt = new Xsltprocessor;
  		$xslt->importStylesheet($xsl);
  		$transformation=$xslt->transformToXml($xml);
  		echo $transformation;  		
    }
  }

  //close the connection  
  $db->disconnect();
?>
