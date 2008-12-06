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
	     
	     } else if (responseText == false) {
	       // The reaction for false goes here
	     }
	   }
      }
      
      
      else if (arg_a == "add_subject") 
     {
	   var url = cro_submit_url + "?location=" + arg_a;
       var url = url + "&user_id=" + arg_b;
	   var url = url + "&study_number=" + arg_c;
	   var url = url + "&subjects=";
	   
       var row_quantity = document.getElementById('table_data').getAttribute('row_quantity');
       var column_quantity = 5;
       var add_quantity = 0;
       
	   for (var i=1; i <= row_quantity; i++) {
	     var fields_completed = 0;
	     for (var j=1; j <= column_quantity; j++) {
	     
	        if (j == 2 || j == 3 || j == 4) {
	           if (document.getElementById('column_' + j + '_' + i).value.replace(/\s+/g,'').length !== 0) {
	              fields_completed = fields_completed + 1;
	            //  alert(document.getElementById('column_' + j + '_' + i));
	           }
	        }
	        
	    }
	 
	    if (fields_completed == 3) {
	      var url = url + document.getElementById('column_1_' + i).innerHTML + '*';
	      var url = url + document.getElementById('column_' + 2 + '_' + i).value + '*';
	      var url = url + document.getElementById('column_' + 3 + '_' + i).value + '*';
	      var url = url + document.getElementById('column_' + 4 + '_' + i).value + '*';
	      var url = url + '*';
	      
	      add_quantity = add_quantity + 1;
	    }
	    else if (fields_completed > 0 && fields_completed < 3) {
	      ajax_oktogo = false;
	      popup(document.getElementById('submit_subjects_button'));
	    }
	   }
	   
	   if (add_quantity == 0) {
	     ajax_oktogo = false;
	     popup(document.getElementById('submit_subjects_button'));
	   }
	   var url = url + "&add_quantity=" + add_quantity;
       
       
       
	   my_reaction = function my_reaction( responseText ) 
	   {
	     popup.hide();
	     var responseText = eval( responseText );
	     
	     if ((responseText[0] == true)) {
	     
	      alert('It worked');
	        
	     } else if((responseText[0] == false)){
	     
	      alert('It did not work.  False was returned.');
	        
	     }
	     if (responseText.length > 1) {
	       var rows = "";
	       for (var i=1; i < responseText.length; i++) {
	         var rows = rows + responseText[i] + ', ';
	       }
	       alert('It worked, but some of the subjects you attempted to add were already in the database. Row # ' + rows);
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
	     var url = url + "&subject_compensation=" + document.getElementById('subject_compensation').value;
	     var url = url + "&start_date=" + calendar_a.getSelectedDates()[0];
	     var url = url + "&end_date=" + calendar_b.getSelectedDates()[0];
	     
	     
	     my_reaction = function my_reaction( responseText ) {
	       popup.hide();
	       var responseText = eval( responseText );
	       
	       if ((responseText == true)) {
	         ctalk('Your study was added');
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

//*********************************************************
// Onload
//*********************************************************

function get_anchor() {
  var anchor_value = self.document.location.hash.substring(1);
  
  if (anchor_value == 'close_true') { 
    ctalk('Study succesfully removed.');
    self.document.location.hash = '#null';
  }
}

//*********************************************************
// CTalk
//********************************************************* 
  
var ctalk_array = new Array();

function ctalk(arg_a) {
  
  var newdiv = document.createElement('div');
  newdiv.setAttribute('class', 'ctalk_box popup_bg');
  newdiv.setAttribute('id', 'yyy');
  
  newdiv.style.position = 'fixed';
  
  newdiv.innerHTML = 
  "<div class='content'><div class='t'></div><div class='bm_2'></div>"+arg_a+"<div class='clear'></div></div><div class='b'><div></div></div>";

  document.body.appendChild(newdiv);
  ctalk_array.push(newdiv);
  
  var new_height = parseFloat(newdiv.offsetHeight);
  newdiv.style.bottom = -new_height - 10 + 'px';
  var myAnim = new YAHOO.util.Motion(newdiv, {points:  
    { by: [0, -new_height - 10] }  
    }, 0.5); 
    
    myAnim.animate();

    for (var i=0; i < ctalk_array.length; i++) {
      if (ctalk_array[i] !== newdiv && ctalk_array[i] !== null) {
         var myAnim = new YAHOO.util.Motion(ctalk_array[i], {points:  
         { by: [0, -new_height - 10] }  
          }, 0.5); 
    
        myAnim.animate();
        
        var myFade = new YAHOO.util.Anim(ctalk_array[i], {  
	      opacity: {to: 0}  
	      }, 0.5); 
	    
	    myFade.onComplete.subscribe(removeElement); 
	    myFade.animate();
	    
	    ctalk_array.splice(ctalk_array[i], 1, null);
      }
    }
   
}

var removeElement = function() { 
	   var el = this.getEl(); 
	   el.parentNode.removeChild(el); 
}

//*********************************************************
// Big Form
//*********************************************************
var form_array = [];

function new_row_array(who) {
  var row_array = [who];
  form_array.push(row_array);
}

function new_cell(who) {
//  form_array[Number(who.getAttribute('row')) - 1].push(who);
}
function new_row() {
  var row_quantity = Number(document.getElementById( 'table_data' ).getAttribute('row_quantity'));
  
  if (row_quantity % 2 !== 0 ) {
    var what_bg = 'cell_bg_a'
  }
  else {
    var what_bg = 'cell_bg_b'
  }
  
  var new_cell_1 = document.createElement('div');
  new_cell_1.setAttribute('class', 'cell_text' + ' ' + what_bg);
  new_cell_1.innerHTML = Number(document.getElementById( 'table_data' ).getAttribute('row_quantity')) + 1;
  document.getElementById( 'table_data' ).setAttribute('row_quantity', Number(document.getElementById( 'table_data' ).getAttribute('row_quantity')) + 1);
  
  var new_cell_2 = document.createElement('input');
  new_cell_2.setAttribute('class', 'cell_input' + ' ' + what_bg);
  new_cell_2.setAttribute('type', 'text');
  
  var new_cell_3 = document.createElement('input');
  new_cell_3.setAttribute('class', 'cell_input' + ' ' + what_bg);
  new_cell_3.setAttribute('type', 'text');
  
  var new_cell_4 = document.createElement('input');
  new_cell_4.setAttribute('class', 'cell_input' + ' ' + what_bg);
  new_cell_4.setAttribute('type', 'text');
  
  document.getElementById( 'table_column_1' ).appendChild( new_cell_1 );
  document.getElementById( 'table_column_2' ).appendChild( new_cell_2 );
  document.getElementById( 'table_column_3' ).appendChild( new_cell_3 );
  document.getElementById( 'table_column_4' ).appendChild( new_cell_4 );
  
  document.getElementById( 'table_box' ).style.height = document.getElementById( 'table_box' ).offsetHeight + 30 + 'px';
}

function test() {
  alert(form_array);
}