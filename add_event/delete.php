<?php
include '../connect.php';
$event_id=$_POST['event_id'];
$sql=mysqli_query($con,"DELETE from events where event_id='$event_id'");
if($sql)
{
    $myarray['result']='Success';   
}
else
{
    $myarray['result']='Failed';
}
echo json_encode($myarray);
?>