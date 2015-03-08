<?php
ini_set('display_errors', 1);
ini_set('log_errors', 1);
ini_set('error_log', dirname(__FILE__) . '/error_log.txt');
error_reporting(E_ALL);
//var_dump(file_exists('./config/db.php'));
include('./config/db.php');
	$hostname = DATABASE_LOCATION;
	$username = DATABASE_USERNAME;
	$password = DATABASE_PASS;
	$dbname = DATABASE_NAME;
	$DB = new DB($hostname, $username, $dbname, $password);
	$con = $DB->connectDB();
?>