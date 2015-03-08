<?php date_default_timezone_set('Asia/Jakarta');

define ("DATABASE_LOCATION" , "localhost");
//define ("DATABASE_NAME" , "edoferi1_youth");
//define ("DATABASE_USERNAME" , "edoferi1_demo");
//define ("DATABASE_PASS" , "q1w2e3r4t5");

define ("DATABASE_USERNAME" , "root");
define ("DATABASE_NAME" , "sts");
define ("DATABASE_PASS" , "");

define ("SITE_CLEAN" , "http://".$_SERVER['HTTP_HOST']);
define ("SITE_IMG" , "http://".$_SERVER['HTTP_HOST']."/images");
define ("SITE_JS" , "http://".$_SERVER['HTTP_HOST']."/js");
define ("SITE_CSS" , "http://".$_SERVER['HTTP_HOST']."/css");
define ("SITE_PATH" , $_SERVER['DOCUMENT_ROOT'] . '/');
?>