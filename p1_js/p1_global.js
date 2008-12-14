//*********************************************************
// Global
//*********************************************************

var submit_url = "../p1_php/p1_submit.php";
var cro_submit_url = "../p1_php/p1_cro_submit.php";

function randomXToY(minVal,maxVal,floatVal)
{
  var randVal = minVal+(Math.random()*(maxVal-minVal));
  return typeof floatVal=='undefined'?Math.round(randVal):randVal.toFixed(floatVal);
}

// Leave this function alone!  So that if u dont define a my_reaction further down, there won't be an error.
var my_reaction = function my_reaction( responseText ) 
{};



function create_ajax_object() 
{
	var xmlHttp;
	try
  	{
  	// Firefox, Opera 8.0+, Safari
  	  xmlHttp=new XMLHttpRequest();
    }catch (e)
    {
    // Internet Explorer
    try
    {
      xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
    }catch (e)
    {
      try
      {
        xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      }
      catch (e)
      {
        alert("Your browser does not support AJAX!");
        return false;
      }
    }
  }
  xmlHttp.onreadystatechange=function()
  {
    if(xmlHttp.readyState==4)
      {
      my_reaction( xmlHttp.responseText );
      // Clear out the reaction function
      my_reaction = function my_reaction( responseText ) 
      {};
      }
  }
  return xmlHttp;
}
  
 
 
 
 
 

function my_submit(arg_a, arg_b, arg_c, arg_d, arg_e, arg_f, arg_g) 
{
     var ajax_oktogo = true;
     var ajax_object = create_ajax_object();
  
     if (arg_a == "login") 
     {
	   var url = submit_url + "?location=" + arg_a;
       var url = url + "&login_id=" + document.getElementById('login_id').value;
	   var url = url + "&password=" + md5( document.getElementById('password').value ) + String( randomXToY(10000000, 99999999) );
	  
	   my_reaction = function my_reaction( responseText ) 
	   {
	     var responseText = eval( responseText );
	     
	     if ((responseText[0] == true) && (responseText[1]=='admin')) {
	     
	        document.getElementById('login_form').submit();
	        
	     } else if((responseText[0] == true) && (responseText[1] == 'cro')){
	     
	        document.getElementById('login_form').setAttribute('action', '../p1_php/p1_cro.php');
	        document.getElementById('login_form').submit();
	        
	     } else if((responseText[0] == true) && (responseText[1] == 'user')){
	     
	     } else if (responseText[0] == false) {
	       ctalk('Your login failed. Please check your email and password and try again.');
	     }
	   }
      }
      
      
      
      else if (arg_a == "screen") {
	     var url = cro_submit_url + "?location=" + arg_a;
	     var url = url + "&user_id=" + arg_b;
	     var url = url + "&study_number=" + arg_c;
	     
	     var row_quantity = document.getElementById('table_data').getAttribute('row_quantity');
	     var column_quantity = 4;
	     var icells_in_row = 1;
	     var uncompleted_rows = [];
	     
	     for (var i=1; i <= column_quantity; i++) {
	       eval( 'var column_' + i + '= [];' );
	     }
	     for (var i=1; i <= row_quantity; i++) {
	     
	       var icells_completed_in_row = 0;
	       
	       for (var j=1; j <= column_quantity; j++) {
	         // Validate each cell of the row here
	         if (j == 2) {
	           if (document.getElementById('cell_' + j + '_' + i).value.replace(/\s+/g,'').length !== 0) {
	              icells_completed_in_row = icells_completed_in_row + 1;
	           }
	         }  
	       }
	  
	  
	      if (icells_completed_in_row == icells_in_row) {
	        column_2.push( document.getElementById('cell_' + 2 + '_' + i).value );
	      }
	      else if (icells_completed_in_row > 0 && icells_completed_in_row < icells_in_row) {
	        uncompleted_rows.push( i );
	      }
	      
	    }
	    
	    
	    var url = url + "&subject_id=" + js_array_to_php_array( column_2 );
	    if (uncompleted_rows.length > 0) {
	      ajax_oktogo = false;
	      poplog(document.getElementById('submit_subjects_button'),'top','ok', 'Some fields are not filled out correctly');
	    }
	  
	  
	    my_reaction = function my_reaction( responseText ) 
	    {
	      var responseText = eval( responseText );
	      if (responseText[0] == true) {
    	     ctalk('Screen succesful.');
             
             for (var i=1; i <= row_quantity; i++) {      
    	         if (document.getElementById('cell_' + 2 + '_' + i).value.replace(/\s+/g,'').length > 0) {
	               getNamedChildren('cell_3_' + i, 'img')[0].style.display = 'inline';
	               getNamedChildren('cell_3_' + i, 'img')[0].src = '../p1_gfx/green_flag.png';
	             }
	         }
    	     if (responseText.length > 1) {
    	       var subject_array = responseText[1].split( ',' );
               var eligibile_array = responseText[2].split( ',' );
    	       for (var i=1; i <= row_quantity; i++) {
   
    	         for (var j=0; j < subject_array.length; j++) {
    	           if (subject_array[j] == document.getElementById('cell_2_' + i).value) {
    	             getNamedChildren('cell_3_' + i, 'img')[0].style.display = 'inline';
    	             getNamedChildren('cell_3_' + i, 'img')[0].src = '../p1_gfx/flag.png';
    	             document.getElementById('cell_4_' + i).innerHTML = eligibile_array[j];
    	           }
    	         }
    	       }
    	     }
    	     
	      }
	      else if (responseText[0] == false) {
	          ctalk('There was an error.');
	      }
	    }    
      }
      
      
      
      else if (arg_a == "add_subject") 
     {
	   var url = cro_submit_url + "?location=" + arg_a;
	   var url = url + "&user_id=" + arg_b;
	   var url = url + "&study_number=" + arg_c;
	     
	   var row_quantity = document.getElementById('table_data').getAttribute('row_quantity');
	   var column_quantity = 5;
	   var icells_in_row = 4;
	   var uncompleted_rows = [];
	     
	     for (var i=1; i <= column_quantity; i++) {
	       eval( 'var column_' + i + '= [];' );
	     }
	     for (var i=1; i <= row_quantity; i++) {
	     
	       var icells_completed_in_row = 0;
	       
	       // Validate each icell of row here
	       for (var j=1; j <= column_quantity; j++) {	         
	         if (j == 2 || j == 3 || j == 4) {
	           if (document.getElementById('cell_' + j + '_' + i).value.replace(/\s+/g,'').length !== 0) {
	              icells_completed_in_row = icells_completed_in_row + 1;
	           }
	         }  
	       }
	       if ( get_symbol( 'cell_5_' + i )  == 'check' ) {
	              icells_completed_in_row = icells_completed_in_row + 1;
	       }
	  
	  
	      if (icells_completed_in_row == icells_in_row) {
	        for (var k=0; k < column_2.length; k++) {
	          if ( document.getElementById('cell_2_' + i).value == column_2[0] ) {
	            ajax_oktogo = false;
	            poplog(document.getElementById('submit_subjects_button'),'top','ok', '2 or more subjects you are trying to add have the same subject ID. Check for duplicates and try again.');
	          }
	        }
	        column_2.push( document.getElementById('cell_' + 2 + '_' + i).value );
	        column_3.push( document.getElementById('cell_' + 3 + '_' + i).value );
	        column_4.push( document.getElementById('cell_' + 4 + '_' + i).value );
	      }
	      else if (icells_completed_in_row > 0 && icells_completed_in_row < icells_in_row) {
	        uncompleted_rows.push( i );
	      }
	      
	    }
	    
	    
	    var url = url + "&subject_id=" + js_array_to_php_array( column_2 );
	    var url = url + "&outpatient_date=" + js_array_to_php_array( column_3 );
	    var url = url + "&washout=" + js_array_to_php_array( column_4 );
	    if (uncompleted_rows.length > 0) {
	      ajax_oktogo = false;
	      poplog(document.getElementById('submit_subjects_button'),'top','ok', 'Some fields are not filled out correctly. Make sure orange circles have been turned into green checks.');
	    }
	  
	  
	    my_reaction = function my_reaction( responseText ) 
	    {
	      var responseText = eval( responseText );
	      if (responseText == true) {
    	     ctalk('Subject(s) added succesfully.');
	      }
	      else if (responseText == false) {
	          ctalk('There was an error.');
	      }
	    }
      }
      
      else if (arg_a == "add_study") {
	     var url = cro_submit_url + "?location=" + arg_a;
	     var url = url + "&user_id=" + arg_b;
	     var url = url + "&study_number=" + document.getElementById('study_number').value;
	     var url = url + "&study_leader=" + document.getElementById('study_leader').value;
	     var url = url + "&sponsor=" + document.getElementById('sponsor').value;
	     var url = url + "&drug=" + document.getElementById('drug').value;
	     var url = url + "&target_enrollment=" + document.getElementById('target_enrollment').value;
	     var url = url + "&subject_compensation=" + document.getElementById('subject_compensation').value;
	     var url = url + "&start_date=" + calendar_a.getSelectedDates()[0];
	     var url = url + "&end_date=" + calendar_b.getSelectedDates()[0];
	     
	     
	     my_reaction = function my_reaction( responseText ) {
	       
	       var responseText = eval( responseText );
	       
	       if ((responseText == true)) {
	         ctalk('Your study was added');
	         document.getElementById('register_study_form').reset();
	       }
	       else {
	         ctalk('Failure. There was an error.');
	       }
	     }
	     
	  }
	  
	  else if (arg_a == "remove_study") {
	     var url = submit_url + "?location=" + arg_a;
	     var url = url + "&user_id=" + arg_b;
	     var url = url + "&study_number=" + document.getElementById('study_number').value;
	      
	     my_reaction = function my_reaction( responseText ) {
	       popup.hide();
	       var responseText = eval( responseText );
	       
	       if ((responseText == true)) {
	         ctalk('Your study was added');
	       }
	       else {
	         ctalk('Your study was not added. Something has gone horribly wrong.');
	       }
	     }
	     
	  }
	  
	  else if (arg_a == "save_study") {
	     var url = cro_submit_url + "?location=" + arg_a;
	     var url = url + "&user_id=" + arg_b;
	     var url = url + "&study_number=" + arg_c;
	     var url = url + "&study_leader=" + document.getElementById('study_leader').value;
	     var url = url + "&sponsor=" + document.getElementById('sponsor').value;
	     var url = url + "&drug=" + document.getElementById('drug').value;
	     var url = url + "&target_enrollment=" + document.getElementById('target_enrollment').value;
	     var url = url + "&subject_compensation=" + document.getElementById('subject_compensation').value;
	  
	    my_reaction = function my_reaction( responseText ) 
	    {
	      var responseText = eval( responseText );
	      if (responseText == true) {
    	      
    	      ctalk('Changes saved');
    	      
	      }
	      else if (responseText == false) {
	          ctalk('There was an error');
	      }
	    }
      }
      
      else if (arg_a == "close_study") {
	     var url = cro_submit_url + "?location=" + arg_a;
	     var url = url + "&user_id=" + arg_b;
	     var url = url + "&study_number=" + arg_c;
	  
	    my_reaction = function my_reaction( responseText ) 
	    {
	      var responseText = eval( responseText );
	      if (responseText == true) {
    	      //window.location.reload();
    	      window.location = "../p1_php/p1_cro.php?section=cro_close#close_true"
    	      
	      }
	      else if (responseText == false) {
	          ctalk('There was an error');
	      }
	    }
      }
	
	
	
	
	
	
	
	
	 if (ajax_oktogo == true) {
       ajax_object.open("GET", url, true);
       ajax_object.send(null);
     }
}
