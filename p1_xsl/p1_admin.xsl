<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 <xsl:output method="html" 
    media-type="text/html" 
    doctype-public="-//W3C//DTD html 4.01//EN"
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
    encoding="UTF-8"/>

 <xsl:include href="../p1_xsl/p1_admin_all.xsl"/>


 <xsl:template match="/root">
   <html xmlns="http://www.w3.org/1999/xhtml"
      xml:lang="en">

<head>
  <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
  <title>Phase 1 Check</title>

  <link rel="stylesheet" type="text/css" href="../p1_css/p1_global.css"/>
  <link rel="stylesheet" type="text/css" href="../p1_css/p1_bgs.css"/>
  <link rel="stylesheet" type="text/css" href="../p1_css/p1_home.css"/>
  
  <!-- Sam Skin CSS -->
<link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/2.5.2/build/container/assets/skins/sam/container.css"/>

<!-- Dependencies -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.2/build/yahoo-dom-event/yahoo-dom-event.js"></script>

<!-- Source file -->
<script type="text/javascript" src="http://yui.yahooapis.com/2.5.2/build/container/container-min.js"></script>

  <script type="text/javascript" src="../p1_js/webtoolkit.aim.js"/>
  <script type="text/javascript" src="../p1_js/si.files.js"/>
  <script type="text/javascript" src="../p1_js/p1_global.js"/>
</head>

<body class="yui-skin-sam">
<script type="text/javascript" src="../js/wz_tooltip.js"/>

<div id="myOverlay" style="z-index:99999; overflow:visible;">
  <div id="context_menu_photo" class="context_menu_bg">
    <div class="tl">
      <span class="tr"><!-- --></span>
      <span class="ll"><!-- --></span>
      <div class="lr">
        <div class="content">
	
	<div class="bm_2"/>
	
          <div id="context_preview_side" class="left">
	    <img id="context_preview_side_img" src="http://www.smilehealth.info/PH01744J.JPG"/>
	  </div>
	
	  
	  
	  <div class="left">
	    <div class="x_round right bm_15" onclick="myOverlay.hide();"/>
	    <a class="context_menu_entry" href="#">Use for display photo</a>
	    <a class="context_menu_entry" href="#">See large size</a>
	    <a class="context_menu_entry" href="#">Delete</a>
	  </div>
	  
        </div>
      </div>
    </div>
  </div>
  
  <div id="context_arrow_rightside"/>
</div>
<script>var myOverlay = new YAHOO.widget.Overlay("myOverlay");
        myOverlay.render(); 
	myOverlay.hide();
	
	function show_context_menu(who) {
	  document.getElementById('context_preview_side_img').src = who.getAttribute('photo_src');
	  myOverlay.cfg.setProperty('context', [who, 'tr', 'tl']);
	  myOverlay.show();
	}
</script>


<div id="main">
    
    
    
 

      
   <div id="column_1">
      
     <div id="logo"/>
     <div style="color:white;">Wash-out Verification System for Clinical Trials</div>
     
     
     <div id="tab_b"><a href="../p1_php/p1_logout.php">Logout</a></div>
     <div id="tab_a"><a href="javascript:;">Client Accounts</a></div>
     <xsl:choose>
       <xsl:when test="section/text() = 'admin_all'"><xsl:call-template name="admin_all"/></xsl:when>
       <xsl:when test="section/text() = 'admin_active'"><xsl:call-template name="admin_active"/></xsl:when>
       <xsl:when test="section/text() = 'admin_closed'"><xsl:call-template name="admin_closed"/></xsl:when>
       <xsl:when test="section/text() = 'admin_master'"><xsl:call-template name="admin_master"/></xsl:when>
       <xsl:when test="section/text() = 'admin_stats'"><xsl:call-template name="admin_stats"/></xsl:when>
       <xsl:otherwise>
         <ul id="menu">
           <li><a id="selected" class="menu_link admin" href="../p1_php/p1_admin.php">Home</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
         </ul>
         
         
         <div id="content">
           
           
           Welcome to your home, Admin!
           
         </div>
         
       </xsl:otherwise>
     </xsl:choose>
     
     
	      
	    
	    </div>
	 
      
   </div>
     
      
     
     




</body>

</html>
    </xsl:template> 
</xsl:stylesheet>
