<?php

namespace app\index\controller;

use app\common\controller\Frontend;
use app\common\library\Token;

class Index extends Frontend
{

    protected $noNeedLogin = '*';
    protected $noNeedRight = '*';
    protected $layout = '';

    public function index()
    {
        $socket = socket_create(AF_INET,SOCK_DGRAM,SOL_UDP);
        $result = socket_connect($socket,'46.29.162.104',21560);
        if ($result < 0) {
            echo "socket_connect() failed.\nReason: ($result) " . socket_strerror($result) . "\n";
        }else{
            echo "连接OK\n";
        }

        return $this->view->fetch();
    }

    public function news()
    {

    }

}
