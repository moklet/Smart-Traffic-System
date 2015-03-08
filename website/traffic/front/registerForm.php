<?php 
	include('includes/header.php'); 
	$sql 		= "select * from jenis_kendaraan ";
	$vtype 		= $DB->getData($sql);
	$sql 		= "select * from merek";
	$merek 		= $DB->getData($sql);
	$sql 		= "select * from tipe_merek";
	$tipemerek 	= $DB->getData($sql);
?>
<section id="content">
<div class="dashboard col col-xs-12">
	<div class="container">
		<div class="header">Register User</div>
		<?php echo ($_SESSION['error'] == "") ? "":$_SESSION['error']; $_SESSION['error']="";?>
		<form action="/registerInsert" method="post" autocomplete="off">
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Id User</div>
				<div class="col col-xs-12 col-sm-8 col-md-10"><input type="text" name="id" required></div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Full Name</div>
				<div class="col col-xs-12 col-sm-8 col-md-10"><input type="text" name="name" required></div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Date Birth</div>
				<div class="col col-xs-12 col-sm-8 col-md-10"><input type="text" name="datebirth" required id="datebirth"></div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Sex</div>
				<div class="col col-xs-12 col-sm-8 col-md-10">
					<select name="sex" required>
						<option value="L">Male</option>
						<option value="P">Female</option>
					</select>
				</div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Vehicle Type</div>
				<div class="col col-xs-12 col-sm-8 col-md-10">
					<select name="vtype" required>
						<option value="">Choose One</option>
					<?php foreach($vtype as $data){ ?>
						<option value="<?php echo $data['id_jenis_kendaraan']; ?>"><?php echo $data['nama_jenis']; ?></option>
					<?php } ?>
					</select>
				</div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Merk</div>
				<div class="col col-xs-12 col-sm-8 col-md-10">
					<select name="merk" required id="merk">
					<option value="">Choose One</option>
					<?php foreach($merek as $data){ ?>
						<option value="<?php echo $data['id_merek']; ?>"><?php echo $data['nama_merek']; ?></option>
					<?php } ?>
					</select>
				</div>
				<div class="clear"></div>
			</div>
			<div class="col-register type-merk">
				<div class="col col-xs-12 col-sm-4 col-md-2">Merk Type</div>
				<div class="col col-xs-12 col-sm-8 col-md-10">
					<select name="merktype" required id="merktype">
						<option value="">Choose One</option>
					</select>
				</div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">Color</div>
				<div class="col col-xs-12 col-sm-8 col-md-10"><input type="text" name="color" required></div>
				<div class="clear"></div>
			</div>
			<div class="col-register">
				<div class="col col-xs-12 col-sm-4 col-md-2">License Number</div>
				<div class="col col-xs-12 col-sm-8 col-md-10"><input type="text" name="platnomor" required></div>
				<div class="clear"></div>
			</div>
			<div>
				<div class="col col-xs-12 col-sm-4 col-md-2"></div>
				<div class="col col-xs-12 col-sm-8 col-md-10"><input type="submit" value="Register"></div>
				<div class="clear"></div>
			</div>
		</form>
	</div>
</div>
</section>
<?php include('includes/footer.php');?>