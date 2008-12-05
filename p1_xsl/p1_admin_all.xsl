<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 <xsl:output method="html" 
    media-type="text/html" 
    doctype-public="-//W3C//DTD html 4.01//EN"
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
    encoding="UTF-8"/>


 <xsl:template match="/root" name="admin_all">


         <ul id="menu">
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php">Home</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
           <li><a id="selected"  class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
           <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
         </ul>
         
         
         <div id="content">
           
           <div class="left bold" style="width:25%; margin-bottom:10px;">CRO</div> 
           <div class="left bold" style="width:30%;">Study #</div> 
           <div class="left bold" style="width:30%;">Status</div> 
           <div class="right bold">Study Start Date</div>
           
           <div class="clear"/>
           <xsl:for-each select="cro">
             <xsl:variable name="cro"><xsl:value-of select="text()"/></xsl:variable>
             <div class="row">
                 <div class="left" style="width:23%; height:100%; padding-top:10px;"><xsl:value-of select="text()"/></div>
               <xsl:for-each select="../study[@cro = $cro]">
                 
                 <div class="right" style="padding:10px 10px 10px 10px; width:73.7%;" study_id="{@study_id}" study_number="{@study_number}">
                   <div class="right" style="padding:0 14px 0 0"><xsl:value-of select="@start_date"/></div>
                   <div class="left" style="width:40.5%;"><xsl:value-of select="@study_number"/></div>
                   <div class="left" style="width:30%;"><xsl:value-of select="@status"/>
                     <xsl:if test="@status = 'Closed'"> - <xsl:value-of select="@closed_date"/></xsl:if></div>
                 </div>
               </xsl:for-each>
               <div class="clear"/>
             </div>
           </xsl:for-each>
           
         </div>
         

     
 
 </xsl:template>
  
  
  
  
  
  <xsl:template match="/root" name="admin_active">
    
    
    <ul id="menu">
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php">Home</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
      <li><a id="selected" class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
    </ul>
    
    
    <div id="content">
      
      <div class="left bold" style="width:23%; margin-bottom:10px;">CRO</div> 
      <div class="left bold" style="width:13%; padding-left:10px;">Study #</div> 
      <div class="left bold" style="width:9%; padding-left:10px;">Status</div>
      <div class="left bold" style="width:19%; padding-left:10px;">Subjects Screened</div>
      <div class="left bold" style="width:13%; padding-left:10px;">Subjects Added</div>
      <div class="right bold">Study Start Date</div>
      
      <div class="clear"/>
      <xsl:for-each select="cro">
        <xsl:variable name="cro"><xsl:value-of select="text()"/></xsl:variable>
        <xsl:if test="count(../study[@cro = $cro][@status = 'Active'])">
          
        <div class="row">
          <div class="left" style="width:23%; height:100%; padding-top:10px;"><xsl:value-of select="text()"/></div>
          <xsl:for-each select="../study[@cro = $cro][@status = 'Active']">
            
            <div class="right" style="padding:10px 10px 10px 10px; width:74.3%;" study_id="{@study_id}" study_number="{@study_number}">
              <div class="right" style="padding:0 14px 0 0"><xsl:value-of select="@start_date"/></div>
              <div class="left" style="width:19%;"><xsl:value-of select="@study_number"/></div>
              <div class="left" style="width:22%;"><xsl:value-of select="@status"/></div>
              <div class="left" style="width:27%;"><xsl:value-of select="@subjects_screened"/></div>
              <div class="left" style="width:15%;"><xsl:value-of select="@subjects_added"/></div>
            </div>
          </xsl:for-each>
          <div class="clear"/>
        </div>
        </xsl:if>
      </xsl:for-each>
      
    </div>
    
    
    
    
  </xsl:template>
  
  
  
  
  
  
  
  <xsl:template match="/root" name="admin_closed">
    
    
    <ul id="menu">
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php">Home</a></li>
      <li><a id="selected" class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
    </ul>
    
    
    <div id="content">
      
      <div class="left bold" style="width:25%; margin-bottom:10px;">CRO</div> 
      <div class="left bold" style="width:17%;">Study #</div> 
      <div class="left bold" style="width:22%;">Status</div>
      <div class="left bold">Invoice Status</div>
      
      <div class="clear"/>
      <xsl:for-each select="cro">
        <xsl:variable name="cro"><xsl:value-of select="text()"/></xsl:variable>
        <xsl:if test="count(../study[@cro = $cro][@status = 'Closed'])">
        <div class="row">
          <div class="left" style="width:23%; height:100%; padding-top:10px;"><xsl:value-of select="text()"/></div>
          <xsl:for-each select="../study[@cro = $cro][@status = 'Closed']">
            
            <div class="right" style="padding:10px 10px 10px 10px; width:73.7%;" study_id="{@study_id}" study_number="{@study_number}">
              <div class="right"><a href="javascript:;" onclick="my_submit('remove_study', this.parentNode.parentNode);">Remove study</a></div>
              <div name="study_number" class="left" style="width:23%;"><xsl:value-of select="@study_number"/></div>
              <div class="left" style="width:29.9%; color:"><xsl:value-of select="@status"/> - <xsl:value-of select="@closed_date"/></div>
              <div class="left" style="width:30%; color:#00791a">
                <xsl:choose>
                  <xsl:when test="@invoice_status = 'Invoice Sent'"><xsl:value-of select="@invoice_status"/></xsl:when>
                  <xsl:otherwise><span style="color:#790000;">Invoice Not Sent</span></xsl:otherwise>
                </xsl:choose>
              </div>
            </div>
          </xsl:for-each>
          <div class="clear"/>
        </div>
        </xsl:if>
      </xsl:for-each>
      
    </div>
    
    
    
    
  </xsl:template> 
  
  
  
  
  <xsl:template match="/root" name="admin_master">
    
 
    <ul id="menu">
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php">Home</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
      <li><a id="selected" class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
    </ul>
    
    
    <div id="content">
      
      <div class="left bold" style="width:25%; margin-bottom:10px;">CRO</div> 
      <div class="left bold" style="width:30%;">Study #</div> 
      <div class="left bold" style="width:30%;">Status</div> 
      <div class="right bold">Invoice #</div>
      
      <div class="clear"/>
      <xsl:for-each select="cro">
        <xsl:variable name="cro"><xsl:value-of select="text()"/></xsl:variable>
        <div class="row">
          <div class="left" style="width:23%; height:100%; padding-top:10px;"><xsl:value-of select="text()"/></div>
          <xsl:for-each select="../study[@cro = $cro]">
            
            <div class="right" style="padding:10px 10px 10px 10px; width:73.7%;" study_id="{@study_id}" study_number="{@study_number}">
              
              <div class="left" style="width:40.5%;"><xsl:value-of select="@study_number"/></div>
              <div class="left" style="width:51.5%;"><xsl:value-of select="@status"/>
                <xsl:if test="@status = 'Closed'"> - <xsl:value-of select="@closed_date"/></xsl:if>
              </div>
              <div class="left" style="width:5%;"><xsl:value-of select="@invoice_number"/></div>
            </div>
          </xsl:for-each>
          <div class="clear"/>
        </div>
      </xsl:for-each>
      
    </div>
    
    
    
    
  </xsl:template>
  
  
  
  
  <xsl:template match="/root" name="admin_stats">
    

    <ul id="menu">
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php">Home</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
      <li><a class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
      <li><a id="selected" class="menu_link admin" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
    </ul>
    
    
    <div id="content">
      
      Hi there!  Welcome to the Database Statistics tab.
      
    </div>
    
    
    
    
  </xsl:template>
</xsl:stylesheet>










