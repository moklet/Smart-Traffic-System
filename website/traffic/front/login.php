<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Smart Traffic System</title>
	<link href="<?php echo SITE_CSS; ?>/bootstrap.min.css" rel="stylesheet">
	<link href="<?php echo SITE_CSS; ?>/styles.css" rel="stylesheet">
</head>
<body id="login">
<section id="content">
<div class="container">
	<div class="container-login">
		<span>hello. sign in.</span>
		<form method="post" action="/check-login" autocomplete="off">
			<input type="text" name="username" required placeholder="username">
			<input type="password" name="password" required placeholder="password">
			<input type="submit" value="login" name="login"/>
		</form>
	</div>
</div>
</section>
<section id="footer">
<div class="container col-xs-12">
	copyright &copy <?php echo date('Y'); ?>
	<div class="clear"></div>
</div>
</section>
	<script src="<?php echo SITE_JS; ?>/jquery.min.js"></script>
	<script src="<?php echo SITE_JS; ?>/bootstrap.min.js"></script>
	<script src="<?php echo SITE_JS; ?>/general.js"></script>
</body>
</html>