<?php 
session_start(); 
include "config/global.php";
include "config/con_open.php";
function sanitize_output($buffer) {
    $search = array(
        '/\>[^\S ]+/s',
        '/[^\S ]+\</s',
        '/(\s)+/s'
    );
    $replace = array(
        '>',
        '<',
        '\\1'
    );
    $buffer = preg_replace($search, $replace, $buffer);
    return $buffer;
}
//ob_start("sanitize_output");
	$subdoctype = 'home';
	error_reporting(0);
	$uri = $_SERVER['REQUEST_URI'];
	$alias = $uri;
	$varelement = explode('/',$alias);
	include "front/route.php";
ob_end_flush();
include "config/con_close.php";
?>
