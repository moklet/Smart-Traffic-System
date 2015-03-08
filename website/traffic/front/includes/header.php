<?php if(empty($_SESSION['sts'])) echo "<script>window.location.href='/';</script>"; ?>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Smart Traffic System</title>
	<link href="<?php echo SITE_CSS; ?>/bootstrap.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/styles.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/jquery.dataTables.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/datatables.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/datatables-adv.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/jquery-ui.css" rel="stylesheet">
</head>
<body id="home">
<section id="header">
<div class="container"></div>
<div id="menu" class="glyphicon glyphicon-align-justify cursor menu"></div>
<div class="menu-container">
	<div><?php echo $_SESSION['sts']['username']; ?></div>
	<ul>
		<li><a href="/dashboard">Dashboard</a></li>
		<li><a href="/registerForm">Insert User</a></li>
		<li><a href="/logout">Logout</a></li>
	</ul>
</div>
</section>