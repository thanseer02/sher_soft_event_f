<?php
include '../connect.php';
$sql=mysqli_query($con,"SELECT * from events INNER JOIN  register on register.log_id=events.log_id INNER JOIN login on events.log_id=login.log_id");
$list=array();
if ($sql->num_rows>0) {
   while($row=mysqli_fetch_assoc($sql))
   {
    $myarray['result']='success';
    $myarray['event_id']=$row['event_id'];
    $myarray['event_name']=$row['event_name'];
    $myarray['email']=$row['email'];
    $myarray['amount']=$row['amount'];
    $myarray['no_of_people']=$row['no_of_people'];
    $myarray['date']=$row['date'];
    $myarray['place']=$row['place'];
    $myarray['name']=$row['name'];
    $myarray['mobile_no']=$row['mobile_no'];
    $myarray['user_name']=$row['user_name'];

    array_push($list,$myarray);



   }
}
else{
    $myarray['result']='failed';
    array_push($list,$myarray);
}
echo json_encode($list);