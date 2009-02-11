<?php

/* Name - Yogesh Mali
   Date - 25th September,2008 */

   $var_section = mysql_real_escape_string($_GET['section']);

   $doc = new DomDocument('1.0');
   $root = $doc->createElement('root');
   $root = $doc->appendChild($root);
   if($var_section == "screen_new"){  
     $var_sect = $doc->createElement('section');
     $var_sect = $root->appendChild($var_sect);
     $var_secv = $doc->createTextNode($var_section);
     $var_secv = $var_sect->appendChild($var_secv);
   } else if($var_section == "add_subject"){
        $var_sect = $doc->createElement('section');
        $var_sect = $root->appendChild($var_sect);
        $var_secv = $doc->createTextNode($var_section);
        $var_secv = $var_sect->appendChild($var_secv);
   } else if($var_section == "register_study"){
        $var_sect = $doc->createElement('section');
        $var_sect = $root->appendChild($var_sect);
        $var_secv = $doc->createTextNode($var_section);
        $var_secv = $var_sect->appendChild($var_secv);
   } else if($var_section == "remove_study"){
        $var_sect = $doc->createElement('section');
        $var_sect = $root->appendChild($var_sect);
        $var_secv = $doc->createTextNode($var_section);
        $var_secv = $var_sect->appendChild($var_secv);
   } else if($var_section == "edit_profile"){
        $var_sect = $doc->createElement('section');
        $var_sect = $root->appendChild($var_sect);
        $var_secv = $doc->createTextNode($var_section);
        $var_secv = $var_sect->appendChild($var_secv);
   } else if($var_section == "logout"){
        $var_sect = $doc->createElement('section');
        $var_sect = $root->appendChild($var_sect);
        $var_secv = $doc->createTextNode($var_section);
        $var_secv = $var_sect->appendChild($var_secv);
   }
   
   $xml_out = $doc->saveXML();
    
   $xml = new DomDocument;
   $xml-> loadXML($xml_out);

   $xsl = new DomDocument;
   $xsl -> load('../p1_xsl/p1_home.xsl');

   $xslt = new Xsltprocessor;
   $xslt -> importStylesheet($xsl);

   $transformation = $xslt->transformToXml($xml);
   echo $transformation;
?>
