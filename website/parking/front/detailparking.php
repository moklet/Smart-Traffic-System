<?php include('includes/header.php'); ?>
<?php

$sql = "select * from parkir LEFT JOIN detail_parkir using(id_parkir) where id_parkir = ".$varelement[2]." GROUP BY nama_lantai";
$sqlcount = "select * from parkir LEFT JOIN detail_parkir using(id_parkir) where id_parkir = ".$varelement[2];
$sqlcountused = "select * from parkir LEFT JOIN detail_parkir using(id_parkir) where id_parkir = ".$varelement[2]." and detail_parkir.status = 1";
$data 	= $DB->getData($sql);
$datac = mysql_query($sqlcount);
$datad = mysql_query($sqlcountused) or die(mysql_error());
$count = mysql_num_rows($datac);
$countused = mysql_num_rows($datad);
$countfree = $count - $countused;
$countusedprosen = $countused/$count*100;
$countfreeprosen = $countfree/$count*100;
//echo $count." ".$countused." ".$countfree;
//$sql2 = "select nama_koordinat_lantai from detail_parkir where nama_lantai =";
//$dat2 	= $DB->getData($sql);
?>
    <div class="clear" id="body-wrap">
        <h3 style="text-align: center; margin-bottom: 30px;">Detail Parking Place</h3>
        <div id="detailpark">
            <img src="/images/mall/mall-ambasador.png" />
            <h4><?php echo $data[0]['nama_parkir'];?></h4>
            <div class="progress">
                <div class="progress-bar progress-bar-success" role="progressbar" style="width:<?=$countfreeprosen;?>%">
                    <?=$countfree;?>
                </div>
                <div class="progress-bar progress-bar-danger" role="progressbar" style="width:<?=$countusedprosen;?>%">
                    <?=$countused   ;?>
                </div>
            </div>
        </div>
        <h3 style="text-align: center; margin-bottom: 30px; margin-top: 30px;" class="clear">Parking Area Map</h3>
        <div style="margin: 0 auto 0; width: 1000px; text-align: center;">

            <table id="tablepark" style="margin: 0 auto 0;">
                <?php
                    foreach($data as $data_lantai){
                        $sql2 = "select nama_koordinat_lantai,status from detail_parkir where nama_lantai ='".$data_lantai['nama_lantai']."'";
                        $data2 	= $DB->getData($sql2);
                        //echo $sql2;
                ?>
                <thead>
                <th colspan="100">Lantai <?php echo $data_lantai['nama_lantai'];?></th>
                </thead>
                <tbody>
                <?php foreach($data2 as $koordinat){
                    if($koordinat['status']==0){
                ?>
                <td><?php echo $koordinat['nama_koordinat_lantai'];?></td>
                <?php }else{?>
                <td style="background: darkred;"><?php echo $koordinat['nama_koordinat_lantai'];?><br>Occupied</td>
                <?php }
                }?>
                </tbody>
                <?php }?>
            </table>
        </div>
    </div>

<?php include('includes/footer.php'); ?>