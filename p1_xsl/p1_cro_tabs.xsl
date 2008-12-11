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
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
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
      
      <div id="add_table">
        <div class="table_head">
          <div class="title_1" style="color:#fff">
            a
          </div>
          <div class="title_2">
            <div class="italic color_000" style="text-align:center;">Subject ID</div>
          </div>
          <div class="title_3">
             <div class="italic color_000" style="text-align:center;">Out-Patient Date</div>
          </div>
          <div class="title_4">
            <div class="italic color_000" style="text-align:center;">Washout (in days)</div>
          </div>
          <div class="title_5">
            <div class="italic color_fff" style="text-align:center;">a</div>
          </div>
          
          <div class="clear"/>
          
          
        
        </div>
        
      
      <div id="example" class="bm_5" style="border: 2px solid #ddd; background-color:#ddd; width: 100%;">
            <div class="bold bm_2" style="font-size:10px; margin-left:2px; color:#444">EXAMPLE</div>
            
            <div id="example_1" style="background-color:#fff; height:30px; line-height:30px; text-align:center">1</div>
            <div id="example_2" style="background-color:#fff; height:30px; line-height:30px;">JTW-121783-4323</div>
            <div id="example_3" style="background-color:#fff; height:30px; line-height:30px;">10/19/08</div>
            <div id="example_4" style="background-color:#fff; height:30px; line-height:30px;">28</div>
            <div id="example_5" style="background-color:#fff; height:30px; line-height:30px;"></div>
            
            <div class="clear"/>
      </div>
        
      <div class="table_body">
        
        <div id="column_1">
          
          <xsl:call-template name="add_col_1"/>
          
        </div>
        <div id="column_2">
          
          <xsl:call-template name="add_col_2"/>
          
        </div>
        <div id="column_3">
          
          <xsl:call-template name="add_col_3"/>
          
        </div>
        <div id="column_4">
          
          <xsl:call-template name="add_col_4"/>
          
        </div>
        <div id="column_5">
          
          <xsl:call-template name="add_col_5"/>
          
        </div>
        
        
          <div class="clear"/>
        
        </div>
        
      </div>
      
      <input id="submit_subjects_button" class="right" type="button" value="Submit" onclick="my_submit('add_subject', {/root/@user_id}, {/root/study/@study_number})"/>
      <input id="add_row_button" class="" type="button" value="+ add another row" onclick="new_row();"/>
    </div>
    
  <div class="clear"/>
  </xsl:template>
  
  <xsl:template name="add_col_1">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="cell_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:when>
        <xsl:otherwise><div id="cell_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="add_col_1">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="add_col_2">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = 20)">
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="cell_2_{$num}" class="cell_input cell_bg_b" type="text" onkeyup="check_completion(this);"/></xsl:when>
        <xsl:otherwise><input id="cell_2_{$num}" class="cell_input" type="text" onkeyup="check_completion(this);"/></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="add_col_2">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="add_col_3">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = 20)">
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="cell_3_{$num}" class="cell_input cell_bg_b" type="text" onkeyup="check_completion(this);"/></xsl:when>
        <xsl:otherwise><input id="cell_3_{$num}" class="cell_input cell_bg_a" type="text" onkeyup="check_completion(this);"/></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="add_col_3">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="add_col_4">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = 20)">
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="cell_4_{$num}" class="cell_input cell_bg_b" type="text" onkeyup="check_completion(this);"/></xsl:when>
        <xsl:otherwise><input id="cell_4_{$num}" class="cell_input" type="text" onkeyup="check_completion(this);"/></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="add_col_4">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="add_col_5">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
    
        <a id="cell_5_{$num}" class="" href="javascript:;" onclick="switch_symbol(this);" style="cursor:default; text-align:center; height:28px; padding:2px 0 0 0; text-decoration:none; display: block;">
          <img my_name="img" src=""/>
        </a>
        
        
     
      
      <xsl:call-template name="add_col_5">
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
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
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
          <div class="form_row">
            <span class="label">Target Enrollment</span>
            <span class="input"><input id="target_enrollment" type="text" size="25" value="{study[@study_number = ../section/@study_number]/@target_enrollment}" /></span>
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
        <button class="right" onclick="my_submit('add_study', {@user_id}); poplog_object.hide();">Submit</button>
        
      </div>
      
    </div>
    
    
    
    
  </xsl:template>
  
  
  
  
  
  
  
  <xsl:template match="/root" name="cro_active">

    
    <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
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
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
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
  
  
  
  
  
 <xsl:template match="/root" name="cro_action">
   <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
   </ul>
   
   
     <xsl:choose>
        <xsl:when test="section/@study_number and section/@study_number != '' and section/@study_number != ' '">
          
          <xsl:call-template name="study_action"/>
          
        </xsl:when>
        
        <xsl:otherwise>
          <div id="content">
    <div id="sub_column_1">
      
      <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
         <xsl:choose>
            <xsl:when test="study">
              <div class="bm_10">Please select a study.</div>
              <div class="box_a">
                <xsl:for-each select="study">
                  <a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_action&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a>
                </xsl:for-each>
              </div>
            </xsl:when>
            <xsl:otherwise>
              There are no studies which match your account.
              
            </xsl:otherwise>
         </xsl:choose>
      
    </div>
    
    <div id="sub_column_2">
      <h2>Review Database Actions</h2>
      
    </div>
    
    
  
     <div class="clear"/>
     
   </div>
     </xsl:otherwise>
     </xsl:choose>
     
     
  </xsl:template>
  
  
  
  
 <xsl:template match="/root" name="study_action">
    <div id="content" class="study_action_content">
      
    <div id="sub_column_1">
      <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
      <div class="bm_20"><span class="mini_title">Study # </span><span style="color:#ff55ff"><xsl:value-of select="study/@study_number"/></span></div>
      <div class="bm_20"><span class="mini_title">Study Leader </span><span class="color_555"><xsl:value-of select="study/@study_leader"/></span></div>
      <div class="bm_20"><span class="mini_title">Sponsor </span><span class="color_555"><xsl:value-of select="study/@sponsor"/></span></div>
      <div class="bm_20"><span class="mini_title">Drug </span><span class="color_555"><xsl:value-of select="study/@drug"/></span></div>
      <div class="bm_20"><span class="mini_title">Study Dates </span><div><span class="color_555"><xsl:value-of select="study/@start_date"/> - <xsl:value-of select="study/@end_date"/></span></div></div>
    </div>
    
    <div id="sub_column_2">
      <h2 class="bm_20">Review Screens</h2>
      <div id="table_data" class="nodisp" row_quantity="{$row_quantity}"/>
      
      <div id="volunteer_table">
        <div class="table_head">
        <div class="title_1" style="color:#fff">
          a
        </div>
        <div class="title_2">
           <div class="italic color_000" style="text-align:center;">Volunteers Screened</div>
        </div>
        <div class="title_3">
           <div class="italic color_000" style="text-align:center;">Flagged</div>
        </div>
          
          <div class="clear"/>
          
        </div>
        
      
      
      <div class="table_body">
        
        <div id="column_1">
          
          <xsl:call-template name="volunteer_col_1"/>
          
        </div>
        <div id="column_2">
          
          <xsl:call-template name="volunteer_col_2"/>
          
        </div>
        <div id="column_3">
          
          <xsl:call-template name="volunteer_col_3"/>
          
        </div>
        
        
          <div class="clear"/>
        
        </div>
        
      </div>
      
      <!--<input id="submit_subjects_button" class="right" type="button" value="Submit" onclick="my_submit('add_subject', {/root/@user_id}, {/root/study/@study_number})"/>
      <input id="add_row_button" class="" type="button" value="+ add another row" onclick="new_row();"/>-->
    </div>
    
      <div id="sub_column_3">
        <h2 class="bm_20">Review Adds</h2>
        
        <div id="review_adds_table">
         <div class="table_head">
         <div class="title_1" style="color:#fff">
          a
        </div>
        <div class="title_2">
           <div class="italic color_000" style="text-align:center;">Subject Added</div>
        </div>
          
          <div class="clear"/>
          
        </div>
        
      
      
      <div class="table_body">
        
        <div id="column_1">
          
          <xsl:call-template name="review_adds_1"/>
          
        </div>
        <div id="column_2">
          
          <xsl:call-template name="review_adds_2"/>
          
        </div>
        <div id="column_3">
          
          <xsl:call-template name="review_adds_3"/>
          
        </div>
        
        
          <div class="clear"/>
        
        </div>
        
        </div>
        
      
      </div>
      
      
      <div class="clear"/>
      
      
    </div>
  </xsl:template>
  
  
  
  <xsl:template name="volunteer_col_1">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="column_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:when>
        <xsl:otherwise><div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="volunteer_col_1">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="volunteer_col_2">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="column_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"> <xsl:value-of select="subject[number($num)]/@subject_id"/> </div></xsl:when>
        <xsl:otherwise><div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"> <xsl:value-of select="subject[number($num)]/@subject_id"/> </div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="volunteer_col_2">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="volunteer_col_3">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}">   
        <xsl:if test="subject[number($num)]/@flagged = 'true'">FLAGGED</xsl:if>
      
      </div>
      
      <xsl:call-template name="volunteer_col_3">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  
  
  
  <xsl:template name="review_adds_1">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="column_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:when>
        <xsl:otherwise><div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="review_adds_1">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="review_adds_2">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="column_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"> <xsl:value-of select="subject[@study_number = ../section/@study_number][number($num)]/@subject_id"/> </div></xsl:when>
        <xsl:otherwise><div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"> <xsl:value-of select="subject[@study_number = ../section/@study_number][number($num)]/@subject_id"/> </div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="review_adds_2">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="review_adds_3">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <div id="column_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}">   
        <xsl:if test="subject[@study_number = ../section/@study_number][number($num)]/@subject_id">
          <a href="javascript:;" style="font-size:12px; margin-right:5px;">Edit</a> <a href="javascript:;" style="font-size:12px;">Remove</a>
        </xsl:if>
      
      </div>
      
      <xsl:call-template name="review_adds_3">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  
  
  
  <xsl:template match="/root" name="cro_screen">

    
    <ul id="menu">
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php">Home</a></li>
      <li><a id="selected" class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_screen">Screen New Subjects(s)</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_add">Add Subjects(s) to Database</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_action">Database Actions</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_register">Register a New Study</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_active">Active Studies</a></li>
      <li><a class="menu_link cro" href="../p1_php/p1_cro.php?section=cro_close">Close a Study</a></li>
    </ul>
    
    
    
      <xsl:choose>
        <xsl:when test="section/@study_number and section/@study_number != '' and section/@study_number != ' '">
          
          <xsl:call-template name="study_screen"/>
          
        </xsl:when>
        
        <xsl:otherwise>
          <div id="content">
            
            
          <div id="sub_column_1">
            <div class="bold bm_30" style="margin-top:30px">Welcome, <xsl:value-of select="@my_name"/>.</div>
            
          </div>
          <div id="sub_column_2">
            
            <xsl:choose>
              <xsl:when test="study">
                <h2 class="bm_20">Screen Subjects</h2>
                <div class="bm_10">Please select a study or <a href="../p1_php/p1_cro.php?section=cro_register">register a new study</a>.</div>
                <div class="box_a">
                  <xsl:for-each select="study">
                    
                    <xsl:choose>
                      <xsl:when test="position() mod 2 = 1"><a class="box_a_item cell_bg_c" href="../p1_php/p1_cro.php?section=cro_screen&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a></xsl:when>
                      <xsl:otherwise><a class="box_a_item" href="../p1_php/p1_cro.php?section=cro_screen&amp;study_number={@study_number}"><xsl:value-of select="@study_number"/></a></xsl:otherwise>
                    </xsl:choose>
                    
                    
                    
                    
                  </xsl:for-each>
                </div>
              </xsl:when>
              <xsl:otherwise>
                There are no studies which match your account.
              </xsl:otherwise>
            </xsl:choose>
            
            
          </div>
          
          
          </div>
        </xsl:otherwise>
      </xsl:choose>
      
      
      
      
      
    
    
    
    
    
  </xsl:template>
  
  
  
  
  
  <xsl:template match="/root" name="study_screen">
    <div id="content">
      
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
      
      <h2 class="bm_20">Screen Subjects</h2>
      
      <div id="screen_table">
        <div class="table_head">
          <div class="title_1" style="color:#fff">
            a
          </div>
          <div class="title_2">
            <div class="italic color_000" style="text-align:center;">Subject</div>
          </div>
          <div class="title_3">
             <div class="italic color_000" style="text-align:center; color:#fff">a</div>
          </div>
          <div class="title_4">
            <div class="italic color_000" style="text-align:center;">Eligible</div>
          </div>
          
          <div class="clear"/>
          
          
        
        </div>
        
      
      <div id="example" class="bm_5" style="border: 2px solid #ddd; background-color:#ddd; width: 100%;">
            <div class="bold bm_2" style="font-size:10px; margin-left:2px; color:#444">EXAMPLE</div>
            
            <div id="example_1" style="background-color:#fff; height:30px; line-height:30px; text-align:center">1</div>
            <div id="example_2" style="background-color:#fff; height:30px; line-height:30px;">JTW-121783-4323</div>
            <div id="example_3" style="background-color:#fff; height:30px;"></div>
            <div id="example_4" style="background-color:#fff; height:30px; line-height:30px;"></div>
            
            <div class="clear"/>
      </div>
        
      <div class="table_body">
        
        <div id="column_1">
          
          <xsl:call-template name="screen_col_1"/>
          
        </div>
        <div id="column_2">
          
          <xsl:call-template name="screen_col_2"/>
          
        </div>
        <div id="column_3">
          
          <xsl:call-template name="screen_col_3"/>
          
        </div>
        <div id="column_4">
          
          <xsl:call-template name="screen_col_4"/>
          
        </div>
        
        
          <div class="clear"/>
        
        </div>
        
      </div>
      
      <input id="submit_subjects_button" class="right" type="button" value="Submit" onclick="my_submit('screen', {/root/@user_id}, {/root/study/@study_number})"/>
      <input id="add_row_button" class="" type="button" value="+ add another row" onclick="new_row();"/>
    </div>
      
      
      
      <div class="clear"/>
      
      
    </div>
  </xsl:template>
  
  
  <xsl:template name="screen_col_1">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><div id="cell_1_{$num}" class="cell_text cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:when>
        <xsl:otherwise><div id="cell_1_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}"><xsl:value-of select="$num"/></div></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="screen_col_1">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template name="screen_col_2">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <xsl:choose>
        <xsl:when test="$num mod 2 != 0"><input id="cell_2_{$num}" class="cell_input cell_bg_b" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}" value="{subject[@study_number = ../section/@study_number][number($num)]/@subject_id}"></input></xsl:when>
        <xsl:otherwise><input id="cell_2_{$num}" class="cell_input" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}" value="{subject[@study_number = ../section/@study_number][number($num)]/@subject_id}"></input></xsl:otherwise>
      </xsl:choose>
      
      <xsl:call-template name="screen_col_2">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="screen_col_3">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <div id="cell_3_{$num}" class="cell_img">
        <xsl:choose>
          <xsl:when test="subject[@study_number = ../section/@study_number][number($num)]/@flagged = 'true'">
            <img my_name="img" src="../p1_gfx/flag.png"></img>
          </xsl:when>
          <xsl:when test="subject[@study_number = ../section/@study_number][number($num)]/@flagged = 'false'">
            <img my_name="img" src="../p1_gfx/green_flag.png"></img>
          </xsl:when>
          <xsl:otherwise>
            <img my_name="img" class="nodisp" src="../p1_gfx/flag.png"></img>
          </xsl:otherwise>
        </xsl:choose>
      
      </div>
      
      <xsl:call-template name="screen_col_3">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="screen_col_4">
    <xsl:param name="num">1</xsl:param> <!-- param has initial value of 1 -->
    <xsl:if test="not($num = $row_quantity + 1)">
      
      
      <div id="cell_4_{$num}" class="cell_text" oninit="new_row_array(this)" row_quantity="{number($row_quantity) - 1}">   
        <xsl:if test="subject[@study_number = ../section/@study_number][number($num)]/@flagged = 'true'"><xsl:value-of select="subject[@study_number = ../section/@study_number][number($num)]/@eligible"/></xsl:if>
      
      </div>
      
      <xsl:call-template name="screen_col_4">
        <xsl:with-param name="num">
          <xsl:value-of select="$num + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>