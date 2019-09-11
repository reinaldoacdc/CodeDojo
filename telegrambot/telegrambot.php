<?php

$token    = '255430597:AAFX9koaaRQ5UxJ7Eu705FQM_mY0uylExW4';
$website  = 'https://api.telegram.org/bot'.$token;

$update = file_get_contents("php://input");
//$update = file_get_contents($website."/getupdates");

$updateArray = json_decode($update, TRUE);

//$text= $updateArray["result"][0]["message"]["text"];
//$chatID= $updateArray["result"][0]["message"]["chat"]["id"];

$text= $updateArray["message"]["text"];
$chatID= $updateArray["message"]["chat"]["id"];


//$text = 'teste';
//$chatID = '240317345';

if (isset($chatID)) {
  file_get_contents($website."/sendmessage?chat_id=".$chatID."&text=".$text);
}

?>