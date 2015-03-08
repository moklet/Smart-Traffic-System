<?php
	$sql = "select * from parkir";
	$data 	= $DB->getData($sql);
	echo json_encode($data);
?>