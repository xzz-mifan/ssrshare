<?php

namespace app\time\controller;

use app\admin\model\ssr\Config;
use app\admin\model\ssr\Detect;
use app\admin\model\ssr\Share;
use think\Controller;
use app\common\components\reptiles\Reptile;
use think\Exception;
use think\Log;
use app\common\components\net\IpLocation;

/**
 * 每天
 */
class Sixhours extends Controller
{
    protected $site;

    protected function _initialize()
    {
        set_time_limit(0);
        $this->site = config('site');
    }

    public function index()
    {

        $this->getSSRShare();

        $this->detectAllSSR();
    }

    public function getSSRShare()
    {
        Config::detectAllSSR();
    }

    public function detectAllSSR()
    {
        $all_ssr = Config::all();
        foreach ($all_ssr as $k => $v) {
            $statr_time = msectime();
            $date = ['status' => -1];
            $timeout = $this->site['detect_ssr_time_out'];
            try {
                $connection = stream_socket_client("tcp://{$v['address']}:{$v['port']}", $erron, $errors, $timeout);
                if (!$connection) {
                    throw new Exception($errors($erron));
                }

                $ip = filter_var($v['address'], FILTER_VALIDATE_IP) ? trim($v['address']) : trim(gethostbyname($v['address']));

                if (file_exists(ROOT_PATH . "application/common/components/net/qqwry.dat")) {
                    $ipLocation = new IpLocation('qqwry.dat');
                    $areaResult = $ipLocation->getlocation($ip);
                    $date['country'] = mb_convert_encoding($areaResult['country'], 'utf8', 'gbk');
                } else {
                    $date['country'] = '未知';
                }
                $date['ip'] = $ip;
                $date['country'] = empty($date['country']) ? '未知' : $date['country'];
                $end_time = msectime();
                $date['status'] = 1;
                $date['timeout'] = $end_time - $statr_time;
                Config::update($date, ['id' => $v['id']]);
                continue;

            } catch (Exception $ex) {
                $detectInfo = Detect::get(['ssr_id' => $v['id']]);
                if ($detectInfo) {
                    Detect::update(['count' => ($detectInfo['count'] + 1), 'updatetime' => time()], ['ssr_id' => $v['id']]);
                } else {
                    Detect::create(['ssr_id' => $v['id'], 'count' => 1, 'msg' => $ex->getMessage(), 'updatetime' => time(), 'createtime' => time()]);
                }
                if ($this->site['time_delete_error_count'] <= $detectInfo['count']) {
                    Config::get($v['id'])->delete();
                    $detectInfo->delete();
                }

                $end_time = msectime();
                $date['timeout'] = $end_time - $statr_time;
                Config::update($date, ['id' => $v['id']]);
                continue;
            }
        }
    }

    public function test()
    {
        if (file_exists(ROOT_PATH . "application/common/components/net/qqwry.dat")) {
            $ipLocation = new IpLocation('qqwry.dat');
            $areaResult = $ipLocation->getlocation("128.199.249.166");
            halt(mb_convert_encoding($areaResult['country'], 'utf8', 'gbk'));
            exit();
            $param['country'] = mb_convert_encoding($areaResult['country'], 'utf8', 'gbk');
        } else {
            $param['country'] = '';
        }
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
