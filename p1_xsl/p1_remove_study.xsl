<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="p1_remove_study" match="/root">
        <ul id="menu">
            <li><a class="menu_link" href="../p1_php/p1_home.php">Home</a></li>
            <li><a class="menu_link" href="../p1_php/p1_home.php?section=screen_new">Screen New Subject(s)</a></li>
            <li><a class="menu_link" href="../p1_php/p1_home.php?section=add_subject">Add Subject(s) to Database</a></li>
            <li><a class="menu_link" href="../p1_php/p1_home.php?section=register_study">Register a New Study</a></li>
            <li><a id="selected" class="menu_link" href="../p1_php/p1_home.php?section=remove_study">Remove a Study</a></li>
            <li><a class="menu_link" href="../p1_php/p1_home.php?section=edit_profile">Edit Profile</a></li>
            <li style="margin:0 0 0 0;"><a class="menu_link" href="../p1_php/p1_home.php?section=logout">Logout</a></li>
        </ul>
        
        <div id="content">
            
            
            So, you'd like to remove a study?
            
        </div>
    </xsl:template>

</xsl:stylesheet>
