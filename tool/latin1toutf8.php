#!/usr/bin/php
<?php

define('EOL', PHP_EOL);

$usage = 'Usage: DBUSER DBPASS DBNAME [DBHOST]' . EOL;

$host = $argv[4] ?? 'localhost';
$user = $argv[1] ?? '';
$pass = $argv[2] ?? '';
$dbname = $argv[3] ?? '';

if (empty($user) || empty($pass) || empty($dbname)) {
    die($usage);
}

$converter = new Converter($host, $user, $pass, $dbname);

$converter->alterDb();
$converter->alterTables();
$converter->alterColumns();

$converter->latin1ToUtf8();

$converter->renameTables();
$converter->changeEngine();

$converter->closeDb();


class Converter
{
    protected $db = null;
    public $dbname = null;

    public function __construct($host, $user, $pass, $dbname)
    {
        $db = new mysqli($host, $user, $pass, $dbname);
        
        if ($db->connect_error) {
            die('Error : ('. $db->connect_errno .') '. $db->connect_error . EOL);
        }
        $this->dbname = $dbname;
        $this->db = $db;
    }

    public function alterDb()
    {
        $this->db->query('ALTER DATABASE '. $this->dbname .' CHARACTER SET utf8 COLLATE utf8_general_ci');
        return true;
    }

    public function alterTables()
    {
        $tables = $this->getTables();

        foreach($tables as $table) {            
            $this->db->query('ALTER TABLE '.$table.' CHARSET=utf8, COLLATE=utf8_general_ci');
        }
        return true;
    }

    public function alterColumns()
    {
        $tables = $this->getTables();

        foreach($tables as $table) {            
            $cols = $this->getColumns($table);
            foreach($cols as $col){
                $col['Null'] = ($col['Null'] == 'NO') ? 'NOT NULL' : 'NULL';
                $col['Default'] = is_null($col['Default']) ? '' : ' DEFAULT "'. $col['Default'] .'"';
                $this->db->query('ALTER TABLE '.$table.' CHANGE '.$col['Field'].' '.$col['Field'].' '.$col['Type'].' CHARSET utf8 COLLATE utf8_general_ci'.$col['Default'].' '. $col['Null']);
            } 
        }
        return true;
    }

    public function latin1ToUtf8()
    {
        $tables = $this->getTables();

        foreach($tables as $table) {            
            $cols = $this->getColumns($table);
            $ary = [];
            foreach($cols as $col){
                $ary[] = $col['Field'] .' = CONVERT(CAST(CONVERT('.$col['Field'].' USING latin1) AS BINARY) USING utf8)';
            } 

            $this->db->query('UPDATE '.$table.' SET ' . implode(', ', $ary));
        }
        return true;
    }

    public function getColumns($table)
    {
        $rows = [];
        $result = $this->db->query('SHOW COLUMNS FROM '. $table .' WHERE `Type` LIKE "%char%" OR `Type` LIKE "%text"');
        while($row = $result->fetch_assoc()) {
            $rows[] = $row;
        }
        $result->free();
        return $rows;
    }

    public function getTables()
    {
        $rows = [];
        $result = $this->db->query('SHOW TABLES');
        while($row = $result->fetch_assoc()) {
            $rows[] = $row['Tables_in_' . $this->dbname];
        }
        $result->free();
        return $rows;
    }

    public function renameTables()
    {
        $tables = $this->getTables();
        foreach($tables as $table) {            
            $this->db->query('RENAME TABLE '. $table .' TO '. str_replace('pega_', '', $table));
        }
        return true;
    }

    public function changeEngine()
    {
        $tables = $this->getTables();

        foreach($tables as $table) {            
            $this->db->query('ALTER TABLE '. $table .' ENGINE=INNODB');
        }
        return true;
    }

    public function closeDb()
    {
        $this->db->close();
    }
}



