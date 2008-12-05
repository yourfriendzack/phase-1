<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 <xsl:output method="html" 
    media-type="text/html" 
    doctype-public="-//W3C//DTD html 4.01//EN"
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
    encoding="UTF-8"/>

 <xsl:include href="../p1_xsl/p1_screen_new.xsl"/>
  <xsl:include href="../p1_xsl/p1_add_subject.xsl"/>
  <xsl:include href="../p1_xsl/p1_logout.xsl"/>
  <xsl:include href="../p1_xsl/p1_register_study.xsl"/>
  <xsl:include href="../p1_xsl/p1_remove_study.xsl"/>
  <xsl:include href="../p1_xsl/p1_edit_profile.xsl"/>


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
     
     <xsl:choose>
       <xsl:when test="section/text() = 'screen_new'"><xsl:call-template name="p1_screen_new"/></xsl:when>
       <xsl:when test="section/text() = 'add_subject'"><xsl:call-template name="p1_add_subject"/></xsl:when>
       <xsl:when test="section/text() = 'register_study'"><xsl:call-template name="p1_register_study"/></xsl:when>
       <xsl:when test="section/text() = 'remove_study'"><xsl:call-template name="p1_remove_study"/></xsl:when>
       <xsl:when test="section/text() = 'edit_profile'"><xsl:call-template name="p1_edit_profile"/></xsl:when>
       <xsl:when test="section/text() = 'logout'"><xsl:call-template name="p1_logout"/></xsl:when>
       <xsl:otherwise>
         
         <ul id="menu">
           <li><a id="selected" class="menu_link" href="../p1_php/p1_home.php">Home</a></li>
           <li><a class="menu_link" href="../p1_php/p1_home.php?section=screen_new">Screen New Subject(s)</a></li>
           <li><a class="menu_link" href="../p1_php/p1_home.php?section=add_subject">Add Subject(s) to Database</a></li>
           <li><a class="menu_link" href="../p1_php/p1_home.php?section=register_study">Register a New Study</a></li>
           <li><a class="menu_link" href="../p1_php/p1_home.php?section=remove_study">Remove a Study</a></li>
           <li><a class="menu_link" href="../p1_php/p1_home.php?section=edit_profile">Edit Profile</a></li>
           <li style="margin:0 0 0 0;"><a class="menu_link" href="../p1_php/p1_home.php?section=logout">Logout</a></li>
         </ul>
         
         <div id="content">
           
           
           <xsl:value-of select="/root/section/text()"/>
           <div id="login_panel">
             <div id="login_panel_content">
               <form>
                 
                 <label class="left">Email Address</label><input type="text" class="left"/><br/>
                 <label class="left">Password</label><input type="password" class="left"/><br/>
                 <label class="left"></label><input class="left" type="button" style="margin-bottom:0px;" value="Login"/>
                 
               </form>
               <div class="clear"/>
             </div>
           </div>
         </div>
         
       </xsl:otherwise>
     </xsl:choose>
     
     
	      
	    
	    </div>
	 
      
   </div>
     
      
     
     




</body>

</html>
    </xsl:template> 
</xsl:stylesheet>
