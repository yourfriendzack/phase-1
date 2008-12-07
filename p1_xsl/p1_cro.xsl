<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 <xsl:output method="html" 
    media-type="text/html" 
    doctype-public="-//W3C//DTD html 4.01//EN"
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
    encoding="UTF-8"/>

 <xsl:include href="../p1_xsl/p1_cro_tabs.xsl"/>


 <xsl:template match="/root">
   <html xmlns="http://www.w3.org/1999/xhtml"
      xml:lang="en">

<head>
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
  <title>Phase 1 Check</title>

  <link rel="stylesheet" type="text/css" href="../p1_css/p1_global.css"/>
  <link rel="stylesheet" type="text/css" href="../p1_css/p1_bgs.css"/>
  <link rel="stylesheet" type="text/css" href="../p1_css/p1_cro.css"/>
  
<!-- Sam Skin CSS -->
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.5.2/build/container/assets/skins/sam/container.css"/>

<!-- Dependencies -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.2/build/yahoo-dom-event/yahoo-dom-event.js"></script>

<!-- Source file -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.2/build/container/container-min.js"></script>

<!-- Source file --> 
<script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/animation/animation-min.js"></script> 
  
  <!-- CALENDAR -->
  
  <!--CSS file (default YUI Sam Skin) --> 
  <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.6.0/build/calendar/assets/skins/sam/calendar.css"/>
  	  
  <!-- Source file --> 
  <script type="text/javascript" src="http://yui.yahooapis.com/2.6.0/build/calendar/calendar-min.js"></script> 

<script type="text/javascript" src="../p1_js/p1_global.js"/>
</head>

<body class="yui-skin-sam" onload="get_anchor();">

  <div id="popup" style="z-index:99999; overflow:visible;">
    
    <div id="popup_bg" class="popup_bg dialog">
      <div class="content">
        <div class="t"></div>
        <!-- Content START -->
        
        <div id="popup_text" class="popup_text bold">You have some fields that are not filled out yet.</div>
        
        
        <a class="ok_button right" href="javascript:;" onclick="popup_object.hide();">OK</a>
        <a class="yes_button right nodisp" href="javascript:;" onclick="popup_object.hide();">Yes</a>
        <a class="no_button right nodisp" href="javascript:;" onclick="popup_object.hide();">No</a>
        <!-- Content END -->
        <div class="clear"/>
      </div>
      <div class="b"><div></div></div>
    </div>
    
    
    
  </div>
  
  <script>var popup_object = new YAHOO.widget.Overlay("popup");
    popup_object.render(); 
    popup_object.hide();
	
	function popup(who) {
	  document.getElementById( 'popup_bg' ).style.left = -( ((document.getElementById( 'popup_bg' ).offsetWidth + 6) - who.offsetWidth) / 2 ) + 'px';
	  document.getElementById( 'popup_bg' ).style.top = '-10px';
	  popup_object.cfg.setProperty('context', [who, 'bl', 'tl']);
	  popup_object.show();
	}
</script>


<div id="main">
    
    
    
 

      
   <div id="column_1">
      
     <div id="logo"/>
     <div style="color:white;">Wash-out Verification System for Clinical Trials</div>
     
     
     <div id="tab_b"><a href="../p1_php/p1_logout.php">Logout</a></div> 
     <div id="tab_a"><a href="javascript:;">Profile</a></div>
     <xsl:choose>
       <xsl:when test="section/text() = 'cro_add'"><xsl:call-template name="cro_add"/></xsl:when>
       <xsl:when test="section/text() = 'cro_register'"><xsl:call-template name="cro_register"/>
         <script>var calendar_a = new YAHOO.widget.Calendar('calendar_a', "callContainer_a"); 
           var calendar_b = new YAHOO.widget.Calendar('calendar_b', "callContainer_b"); 
           
           calendar_a.cfg.setProperty("title","Start Date");
           calendar_b.cfg.setProperty("title","End Date");
           
           calendar_a.render(); 
           calendar_b.render();
         </script>
       </xsl:when>
       <xsl:when test="section/text() = 'cro_action'"><xsl:call-template name="cro_action"/></xsl:when>
       <xsl:when test="section/text() = 'cro_active'"><xsl:call-template name="cro_active"/></xsl:when>
       <xsl:when test="section/text() = 'cro_close'"><xsl:call-template name="cro_close"/></xsl:when>
       <xsl:otherwise>
         <ul id="menu">
           <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
           <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
           <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
           <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
           <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
           <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
           <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
         </ul>
         
         
         <div id="content">
           
           
           Welcome to your home, CRO!
           
         </div>
         
       </xsl:otherwise>
     </xsl:choose>
     
     
	      
	      <div style="color:#000">Copyright Phase-1 Check.com. All rights reserved.</div>
   </div>
	 
      
   </div>
     
      
     
     




</body>

</html>
    </xsl:template> 
</xsl:stylesheet>
