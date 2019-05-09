<?php

namespace app\time\controller;

use app\admin\model\ssr\Config;
use think\Controller;


/**
 * 每天
 */
class Sixhours extends Controller
{
    protected function _initialize()
    {
        set_time_limit(0);

    }

    public function index()
    {

        $this->getSSRShare();

        $this->detectAllSSR();
    }

    public function getSSRShare()
    {
        Config::getSSRShare();
    }

    public function detectAllSSR()
    {
        Config::detectAllSSR();
    }


    public function non_blocking_connect($host, $port, $timeout, &$errno, &$errstr)
    {
        define('EINPROGRESS', 115);
        $ip = gethostbyname($host);
        $s = socket_create(AF_INET, SOCK_STREAM, 0);
        if (socket_set_nonblock($s)) {
            $r = @socket_connect($s, $ip, $port);
            if ($r || socket_last_error() == EINPROGRESS) {
                $errno = EINPROGRESS;
                return $s;
            }
        }
        $errno = socket_last_error($s);
        $errstr = socket_strerror($errno);
        socket_close($s);
        return false;
    }
}
