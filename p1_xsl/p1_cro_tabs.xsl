<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml" version="1.0">
 <xsl:output method="html" 
    media-type="text/html" 
    doctype-public="-//W3C//DTD html 4.01//EN"
    doctype-system="http://www.w3.org/TR/html4/strict.dtd"
    cdata-section-elements="script style"
    indent="yes"
    encoding="UTF-8"/>

  <xsl:variable name="row_quantity"><xsl:number value="19"/></xsl:variable>
  
  <xsl:template match="/root" name="cro_add">


    <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_database">Database Actions</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
    </ul>
    
    
    <div id="content">
      
      <xsl:choose>
        <xsl:when test="section/@study_number and section/@study_number != '' and section/@study_number != ' '">
          <xsl:call-template name="study_number"/>
          
        </xsl:when>
        <xsl:otherwise>
          <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
          
          <xsl:choose>
            <xsl:when test="study">
              <div class="bm_10">Please select a study.</div>
              <div class="box_a">
                <xsl:for-each select="study">
                  <a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_add&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a>
                </xsl:for-each>
              </div>
            </xsl:when>
            <xsl:otherwise>
              There are no studies which match your account.
            </xsl:otherwise>
          </xsl:choose>
          
          
          
        </xsl:otherwise>
      </xsl:choose>
      
      
         
    </div>
     
 
 </xsl:template>
  
  <xsl:template match="/root" name="study_number">
    <div id="sub_column_1">
      <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
      <div class="bm_20"><span class="mini_title">Study # </span><span style="color:#ff55ff"><xsl:value-of select="study/@study_number"/></span></div>
      <div class="bm_20"><span class="mini_title">Study Leader </span><span class="color_555"><xsl:value-of select="study/@study_leader"/></span></div>
      <div class="bm_20"><span class="mini_title">Sponsor </span><span class="color_555"><xsl:value-of select="study/@sponsor"/></span></div>
      <div class="bm_20"><span class="mini_title">Drug </span><span class="color_555"><xsl:value-of select="study/@drug"/></span></div>
      <div class="bm_20"><span class="mini_title">Study Dates </span><div><span class="color_555"><xsl:value-of select="study/@start_date"/> - <xsl:value-of select="study/@end_date"/></span></div></div>
    </div>
    
    <div id="sub_column_2">
      <div id="table_data" class="nodisp" row_quantity="{$row_quantity}"/>
      
      <div id="tc_1_title" style="color:#fff; border:none;">
        aa
      </div>
      <div id="tc_2_title" style="border:none;">
          <div class="italic color_000" style="text-align:center;">Subject</div>
      </div>
      <div id="tc_3_title" style="border:none;">
          <div class="italic color_000" style="text-align:center;">Out-Patient Date</div>
      </div>
      <div id="tc_4_title" style="border:none;">
          <div class="italic color_000" style="text-align:center;">Washout</div>
      </div>
      
      <div class="clear"/>
      
      <div id="table_box">
        <div id="table_column_1">
          
          <xsl:call-template name="recurse_till_ten"/>
          
        </div>
        <div id="table_column_2">
          
          <xsl:call-template name="table_column_2"/>
          
        </div>
        <div id="table_column_3">
          
          <xsl:call-template name="table_column_3"/>
          
        </div>
        <div id="table_column_4">
          
          <xsl:call-template name="table_column_4"/>
          
        </div>
        <div id="table_column_5">
           
          <xsl:call-template name="table_column_5"/>
          
        </div>
        
      </div>
      
      <input id="submit_subjects_button" class="right" type="button" value="Submit" onclick="my_submit('add_subject', {/root/@user_id}, {/root/study/@study_number})"/>
      <input id="add_row_button" class="" type="button" value="+ add another row" onclick="new_row();"/>
    </div>
  <div class="clear"/>
  </xsl:template>
  
  <xsl:template name="recurse_till_ten">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="column_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:when>
        <xsl:otherwise><div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="recurse_till_ten">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="table_column_2">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = 20)">
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="column_2_{$num}" class="cell_input cell_bg_b" type="text" row="{$num}"/></xsl:when>
        <xsl:otherwise><input id="column_2_{$num}" class="cell_input" type="text" row="{$num}"/></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="table_column_2">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="table_column_3">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = 20)">
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="column_3_{$num}" class="cell_input cell_bg_b" type="text" row="{$num}"/></xsl:when>
        <xsl:otherwise><input id="column_3_{$num}" class="cell_input cell_bg_a" type="text" row="{$num}"/></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="table_column_3">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="table_column_4">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = 20)">
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="column_4_{$num}" class="cell_input cell_bg_b" type="text" row="{$num}"/></xsl:when>
        <xsl:otherwise><input id="column_4_{$num}" class="cell_input" type="text" row="{$num}"/></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="table_column_4">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="table_column_5">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      <div id="column_5_{$num}" class="" style="width:100%; height:30px; padding:0 0 0 5px;" row="{$num}">
        <a href="javascript:;">
          <img my_name="img" src="../p1_gfx/circle.png"/>
        </a>
        
        
      </div>
      
      <xsl:call-template name="table_column_5">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  
  
  <xsl:template match="/root" name="cro_register">
    
    
    <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_database">Database Actions</a></li>
      <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
    </ul>
    
    
    <div id="content" class="cro_register_content">
      
      <div id="sub_column_1">
        <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
        
      </div>
      <div id="sub_column_2">
        
        <h1 class="bm_30" style="margin-left:40px;">Register a Study</h1>
        <div class="bm_30" style="margin-left:40px;">Please enter study information.</div>
        
        <form id="register_study_form">
          <div class="form_row">
            <span class="label">Study Number</span>
            <span class="input"><input id="study_number" type="text" size="25" /></span>
          </div>
          <div class="form_row">
            <span class="label">Study Leader</span>
            <span class="input"><input id="study_leader" type="text" size="25" /></span>
          </div>
          <div class="form_row">
            <span class="label">Sponsor</span>
            <span class="input"><input id="sponsor" type="text" size="25" /></span>
          </div>
          <div class="form_row">
            <span class="label">Drug</span>
            <span class="input"><input id="drug" type="text" size="25" /></span>
          </div>
          <div class="form_row bm_30">
            <span class="label">Subject Compensation</span>
            <span class="input"><input id="subject_compensation" type="text" size="25" /></span>
            <div class="clear"/>
          </div>
          
          <div class="bm_30" style="margin-left:40px;">Please enter start and end dates.</div>
          
          <div id="callContainer_a" class="left clear"/>
          <div id="callContainer_b" class="left bm_20"/>
          
          <div class="clear"/>
        </form>
        <button class="right" onclick="my_submit('add_study', {@user_id})">Submit</button>
        
      </div>
      
    </div>
    
    
    
    
  </xsl:template>
  
  
  
  
  
  
  
  <xsl:template match="/root" name="cro_active">

    
    <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_database">Database Actions</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
      <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
    </ul>
    
    
    <div id="content" class="cro_active_content">
      <xsl:choose>
        <xsl:when test="section/@study_number and section/@study_number != '' and section/@study_number != ' '">
          
          <xsl:call-template name="view_active"/>
          
        </xsl:when>
        
        <xsl:otherwise>
          <div id="sub_column_1">
            <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
            
          </div>
          <div id="sub_column_2">
            
            <xsl:choose>
              <xsl:when test="study">
                <h2 class="bm_20">Active Studies</h2>
                <div class="bm_10">Please select a study to view or edit.</div>
                <div class="box_a">
                  <xsl:for-each select="study">
                    
                    <xsl:choose>
                      <xsl:when test="position() mod 2 = 1"><a class="box_a_item cell_bg_c" href="../p1_php/p1_cro.php?section=cro_active&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a></xsl:when>
                      <xsl:otherwise><a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_active&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a></xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    
                  </xsl:for-each>
                </div>
              </xsl:when>
              <xsl:otherwise>
                There are no studies which match your account.
              </xsl:otherwise>
            </xsl:choose>
            
            
          </div>
          
        </xsl:otherwise>
      </xsl:choose>
      
      
      
      
      
    </div>
    
    
    
    
  </xsl:template>
  
  
  <xsl:template match="/root" name="view_active">
    <div id="sub_column_1">
      
      <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
         <xsl:choose>
            <xsl:when test="study">
              <div class="bm_10">Review Active Study</div>
              <div class="box_a">
                <xsl:for-each select="study">
                  <a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_active&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a>
                </xsl:for-each>
              </div>
            </xsl:when>
            <xsl:otherwise>
              There are no studies which match your account.
            </xsl:otherwise>
         </xsl:choose>
      
    </div>
    
    <div id="sub_column_2">
      <h2 class="bm_20" style="margin-left:40px;">View Study Detail</h2>
      <h1 class="bm_10" style="margin-left:40px;"><xsl:value-of select="@my_name"/></h1>
        <div class="bm_10" style="margin-left:40px;">View or edit study details.</div>
        
        <form id="view_study_form">
          <div class="form_row">
            <span class="label">Study Number</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@study_number"/></span>
          </div>
          <div class="form_row">
            <span class="label">Study Leader</span>
            <span class="input"><input id="study_leader" type="text" size="25" value="{study[@study_number = ../section/@study_number]/@study_leader}" /></span>
          </div>
          <div class="form_row">
            <span class="label">Sponsor</span>
            <span class="input"><input id="sponsor" type="text" size="25" value="{study[@study_number = ../section/@study_number]/@sponsor}" /></span>
          </div>
          <div class="form_row">
            <span class="label">Drug</span>
            <span class="input"><input id="drug" type="text" size="25" value="{study[@study_number = ../section/@study_number]/@drug}" /></span>
          </div>
          <div class="form_row">
            <span class="label">Target Enrollment</span>
            <span class="input"><input id="target_enrollment" type="text" size="25" value="{study[@study_number = ../section/@study_number]/@target_enrollment}" /></span>
          </div>
          <div class="form_row bm_30">
            <span class="label">Subject Compensation</span>
            <span class="input"><input id="subject_compensation" type="text" size="25" value="{study[@study_number = ../section/@study_number]/@subject_compensation}" /></span>
          </div>
          
          <div class="clear bm_20"/>
          
          
          
          <div class="clear"/>
          
        </form>
        
      <button class="right" style="margin-right:100px;" onclick="my_submit('save_study', {@user_id}, {study[@study_number = ../section/@study_number]/@study_number})">Save Changes</button>
      
      
      
    </div>
    
    <div class="clear"/>
  
  </xsl:template>
  
  
  
  
  <xsl:template match="/root" name="cro_close">

    
    <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_database">Database Actions</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
      <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
    </ul>
    
    
    <div id="content">
      <xsl:choose>
        <xsl:when test="section/@study_number and section/@study_number != '' and section/@study_number != ' '">
          
          <xsl:call-template name="close_study"/>
          
        </xsl:when>
        
        <xsl:otherwise>
          <div id="sub_column_1">
            
            <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
          
          <xsl:choose>
            <xsl:when test="study">
              <div class="bm_10">Please select a study to close.</div>
              <div class="box_a">
                <xsl:for-each select="study">
                  <a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_close&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a>
                </xsl:for-each>
              </div>
            </xsl:when>
            <xsl:otherwise>
              There are no studies which match your account.
            </xsl:otherwise>
          </xsl:choose>
            
          </div>
          <div id="sub_column_2">
            
            
          </div>
          
        </xsl:otherwise>
      </xsl:choose>
      
    </div>
    
  </xsl:template>
  
  <xsl:template match="/root" name="close_study">
    <div id="sub_column_1">
      
      <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
         <xsl:choose>
            <xsl:when test="study">
              <div class="bm_10">Select a study to close</div>
              <div class="box_a">
                <xsl:for-each select="study">
                  <a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_close&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a>
                </xsl:for-each>
              </div>
            </xsl:when>
            <xsl:otherwise>
              There are no studies which match your account.
            </xsl:otherwise>
         </xsl:choose>
      
    </div>
    
    <div id="sub_column_2">
      <h2 class="bm_20" style="margin-left:40px;">Close this study?</h2>
      <h1 class="bm_10" style="margin-left:40px;"><xsl:value-of select="@my_name"/></h1>
        
        <form id="view_study_form">
          <div class="form_row">
            <span class="label">Study Number</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@study_number"/></span>
          </div>
          <div class="form_row">
            <span class="label">Study Leader</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@study_leader"/></span>
          </div>
          <div class="form_row">
            <span class="label">Sponsor</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@sponsor"/></span>
          </div>
          <div class="form_row">
            <span class="label">Drug</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@drug"/></span>
          </div>
          <div class="form_row">
            <span class="label">Target Enrollment</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@target_enrollment"/></span>
          </div>
          <div class="form_row bm_30">
            <span class="label">Subject Compensation</span>
            <span class="input cell_bg_c"><xsl:value-of select="study[@study_number = ../section/@study_number]/@subject_compensation"/></span>
          </div>
          
          <div class="clear bm_20"/>
          
          
          
          <div class="clear"/>
          
        </form>
        
      <button class="right" style="margin-right:100px; width:100px;" onclick="my_submit('close_study', {@user_id}, {study[@study_number = ../section/@study_number]/@study_number})" >Close</button>
      
    </div>
    
    <div class="clear"/>
  
  </xsl:template>
  
  
  
  <xsl:template match="/root" name="admin_master">
    
 
    <ul id="menu">
      <li><a class="menu_link" href="../p1_php/p1_admin.php">Home</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
      <li><a id="selected" class="menu_link" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
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
      <li><a class="menu_link" href="../p1_php/p1_admin.php">Home</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_closed">Closed Studies</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_active">Active Studies</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_all">View All Studies</a></li>
      <li><a class="menu_link" href="../p1_php/p1_admin.php?section=admin_master">Master Study Record</a></li>
      <li><a id="selected" class="menu_link" href="../p1_php/p1_admin.php?section=admin_stats" style="padding-right:26px;">Database Statistics</a></li>
    </ul>
    
    
    <div id="content">
      
      Hi there!  Welcome to the Database Statistics tab.
      
    </div>
    
    
    
    
  </xsl:template>
</xsl:stylesheet>










