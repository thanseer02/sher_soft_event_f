<?php
include '../connect.php';
$event_id=$_POST['event_id'];
$event_name=$_POST['event_name'];
$no_of_people=$_POST['no_of_people'];
$amount=$_POST['amount'];
$date=$_POST['date'];
$place=$_POST['place'];
$sql=mysqli_query($con,"UPDATE events set event_name='$event_name',no_of_people='$no_of_people',amount='$amount',date='$date',place='$place' where event_id='$event_id'");
if($sql)
{
    $myArray['result']='success';
}
else
{
    $myArray['result']='faild';
}
echo json_encode($myArray);
?>