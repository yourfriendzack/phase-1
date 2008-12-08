<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 <xsl:output method="html" 
    media-type="text/html" 
    doctype-public="-//W3C//DTD html 4.01//EN"
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
    encoding="UTF-8"/>


 <xsl:template match="/root">
   <html xmlns="http://www.w3.org/1999/xhtml"
      xml:lang="en">

<head>
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
  <title>Phase 1 Check</title>

  <link rel="stylesheet" type="text/css" href="../p1_css/p1_global.css"/>
  <link rel="stylesheet" type="text/css" href="../p1_css/p1_bgs.css"/>
  <link rel="stylesheet" type="text/css" href="../p1_css/p1_login.css"/>
  
<!-- Sam Skin CSS -->
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.5.2/build/container/assets/skins/sam/container.css"/>

<!-- Dependencies -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.2/build/yahoo-dom-event/yahoo-dom-event.js"></script>

<!-- Source file -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.2/build/container/container-min.js"></script>

<!-- Source file --> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/animation/animation-min.js"></script> 

  <script type="text/javascript" src="../p1_js/p1_global.js"/>
  <script type="text/javascript" src="../p1_js/php_utf8_encode.min.js"/>
  <script type="text/javascript" src="../p1_js/php_md5.min.js"/>
</head>

<body class="yui-skin-sam">

<div id="main">
    
    
    
 

      
   <div id="column_1">
      
     <div id="logo"/>
     <div style="color:white;">Wash-out Verification System for Clinical Trials</div>
     
   
       
         
         
           <div id="subtitle">Welcome to Phase-1Check.com</div>
           
           <div id="login_panel">
         
             <form id="login_form" action="../p1_php/p1_admin.php" method="post">
                 
                 <label class="left">Login ID</label><input id="login_id" type="text" class="left"/><div/>
                 <label class="left">Password</label><input id="password" type="password" class="left"/><div/>
                 <label class="left"></label><input class="right" type="button" style="margin-bottom:0px;" value="Login" onclick="my_submit('login')"/>
                 
               </form>
               <div class="clear"/>
        
           </div>
     
       
	      
	    
	    
   
   
   </div>
	 
  <div id="footer">Copyright Phase-1Check.com.  All rights reserved.</div>
   </div>
     
      
     
     




</body>

</html>
    </xsl:template> 
</xsl:stylesheet>
