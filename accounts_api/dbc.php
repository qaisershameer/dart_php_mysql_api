<?php

function dbcN()
{
    $con = mysqli_connect("localhost","root","","accounts");
    return $con;
}

?>