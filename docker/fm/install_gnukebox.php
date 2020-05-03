#!/usr/bin/php
<?php

require_once('/var/www/gnukebox/vendor/autoload.php');

$_POST['install'] = true;
$_POST['dbms'] = 'mysqli';
$_POST['hostname'] = 'db';
$_POST['dbname'] = $_ENV['GNUFM_DBNAME'];
$_POST['username'] = $_ENV['GNUFM_USERNAME'];
$_POST['password'] = $_ENV['GNUFM_PASSWORD'];

require_once('/var/www/gnukebox/install.php');
