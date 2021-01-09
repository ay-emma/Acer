<?php 

// Following code for message integration
$usr= 'oluwarufus';
$pass = 'smsp@55w0rd';
$phone='08062478642';

        
        $ch = curl_init();
           //modification
        $msgurl = urlencode("Morning, this is me testing the SMS API, do well to ignore this messsage.");
		
        $url = "http://smsportalgateway.com/components/com_spc/smsapi.php?username=&usr&password=$pass&sender=$usr&recipient=$phone&message=$msgurl";

        // set URL and other appropriate options
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // grab URL and pass it to the browser
        curl_exec($ch);

        // close cURL resource, and free up system resources
        curl_close($ch);
?>