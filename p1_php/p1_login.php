<?php

/* @author - Yogesh Mali
   @date - 18th October 2008 */

  include("p1_config.php");

  $doc = new DomDocument('1.0');
  $root = $doc->createElement('root');
  $root = $doc->appendChild($root);
  $xml_out = $doc->saveXML();

  $xml = new DomDocument;
  $xml-> loadXML($xml_out);

  $xsl = new DomDocument;
  $xsl -> load('../p1_xsl/p1_login.xsl');

  $xslt = new Xsltprocessor;
  $xslt -> importStylesheet($xsl);

  $transformation = $xslt->transformToXml($xml);
  echo $transformation;

?>
  
  
