<?php
/*
 * This code has been taken from book
 * Object-oriented PHP by Peter Lavin
 * 
 * @author - Peter Lavin
 */
  require 'p1_mysqlresultset.php';
  
  class MySQLConnect{
  	//data members
  	private $connection;
  	static $instances = 0;
  	//constructor
  	function _construct($hostname,$username,$password){
  	  if(MySQLConnect::$instances == 0){
        $this->connection = mysql_connect($hostname,$username,$password) or
          die ( mysql_error(). " Error no:".mysql_errno());
          MySQLConnect::$instances = 1;
      }else{
        $msg = "Close the existing instance of the ".
        "MySQLConnect class.";
       die($msg);
      }
  	}
  	//destructor
  	function _destruct(){
  		$this->close();
  	}
  	
  	function createResultSet($strSQL,$databasename){
  		$rs = new MySQLResultSet($strSQL,$databasename,$this->connection);
  		return $rs;
  	}
  	function getConnection(){
  		return $this->connection;
  	}
    function getVersionNumber(){
    //mysql_get_server_info
      return mysql_get_server_info();
    }
    function close(){
      MySQLConnect::$instances = 0;
      if(isset($this->connection)){
        mysql_close($this->connection);
        unset($this->connection);
      }
    }
  }
?>