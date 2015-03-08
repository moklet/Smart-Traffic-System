<?php include('includes/header.php');
$sql = "select * from parkir";
$data 	= $DB->getData($sql);
?>
<div class="clear" id="body-wrap">
    <div id="icon-list">
        <h3 style="text-align: center; margin-bottom: 30px;">Choose your destination</h3>
        <div style="margin: 0px auto 0px">
            <ul>
                <?php
                foreach($data as $data){
                    $sqlcount = "select * from parkir LEFT JOIN detail_parkir using(id_parkir) where id_parkir = ".$data['id_parkir'];
                    $sqlcountused = "select * from parkir LEFT JOIN detail_parkir using(id_parkir) where id_parkir = ".$data['id_parkir']." and detail_parkir.status = 1";
                    $datac = mysql_query($sqlcount);
                    $datad = mysql_query($sqlcountused) or die(mysql_error());
                    $count = mysql_num_rows($datac);
                    $countused = mysql_num_rows($datad);
                    $countfree = $count - $countused;
                    $countusedprosen = $countused/$count*100;
                    $countfreeprosen = $countfree/$count*100;
                    //echo $count." ".$countused." ".$countfree;
                ?>
                <li>
                    <a href="/detailparking/<?=$data['id_parkir']?>" style="text-decoration: none">
                    <img src="/images/mall/mall-ambasador.png" />
                    <h4><?=$data['nama_parkir']?></h4>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success" role="progressbar" style="width:<?=$countfreeprosen;?>%">
                            <?=$countfree;?>
                        </div>
                        <div class="progress-bar progress-bar-danger" role="progressbar" style="width:<?=$countusedprosen;?>%">
                            <?=$countused   ;?>
                        </div>
                    </div>
                    </a>
                </li>
                <?php }?>
            </ul>
        </div>
    </div>
</div>
<?php include('includes/footer.php'); ?>