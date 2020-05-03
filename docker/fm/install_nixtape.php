#!/usr/bin/php
<?php

require_once('/var/www/nixtape/vendor/autoload.php');

$_POST['install'] = true;
$_POST['dbms'] = 'mysqli';
$_POST['hostname'] = 'db';
$_POST['dbname'] = $_ENV['GNUFM_DBNAME'];
$_POST['username'] = $_ENV['GNUFM_USERNAME'];
$_POST['password'] = $_ENV['GNUFM_PASSWORD'];
$_POST['site_name'] = $_ENV['GNUFM_SITENAME'];
$_POST['default_theme'] = $_ENV['GNUFM_THEME'];
$_POST['submissions_server'] = $_ENV['GNUFM_SUBMISSIONS'];

require_once('/var/www/nixtape/install.php');
