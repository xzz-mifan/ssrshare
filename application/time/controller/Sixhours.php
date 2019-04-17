<?php

namespace app\time\controller;

use app\admin\model\ssr\Config;
use app\admin\model\ssr\Detect;
use app\admin\model\ssr\Share;
use think\Controller;
use app\common\components\reptiles\Reptile;
use think\Exception;
use think\Log;

/**
 * 每天
 */
class Sixhours extends Controller
{
    protected $site ;

    protected function _initialize()
    {
        set_time_limit(0);
        $this->site= config('site');
    }
    public function index()
    {

        $this->getSSRShare();

        $this->detectAllSSR();
    }

    public function getSSRShare()
    {
        $shareList = Share::all(['status' => 1]);
        foreach ($shareList as $k => $v) {
            $reptile = new Reptile();
            if (preg_match('/^https/', $v['url'])) {
                $reptile->Set_Https(true);
            } else {
                $reptile->Set_Https(false);
            }
            $reptile->Set_Url([$v['url']]);
            $resl = $reptile->Reptile_send();
            if (empty($resl[0])) {
                continue;
            }
            $resl = base64_decode($resl[0]);
            $resl = explode("\n", $resl);
//            $resl=['ssr://dXMxLm11bWV2cG4uY29tOjk5MzpvcmlnaW46cmM0LW1kNTpwbGFpbjpNakF4T1M0d015NHdOdy8_cmVtYXJrcz1VMU5TVkU5UFRGX252bzdsbTcwdDVieVg1WkNKNWJDODVMcWE1YmVlT2pBdyZncm91cD1WMWRYTGxOVFVsUlBUMHd1UTA5Tg'];
            foreach ($resl as $ssr) {
                $init_ssr = trim($ssr);
                if (empty($init_ssr)) {
                    continue;
                }
                $init_ssr = str_replace('_', '+', $init_ssr);
                $ssr_info = explode('://', $init_ssr);
                if (count($ssr_info) != 2) {
                    continue;
                }
                $ssr_info = base64_decode($ssr_info[1]);
                $ssr_info = explode('/', $ssr_info);
                $val1 = explode(':', $ssr_info[0]);
                $val2 = explode('&', str_replace('>', "", $ssr_info[1]));
                if (!checkIp($val1[0]) && !checkHost($val1[0])) {
                    continue;
                }
                $val1[5] = str_replace('_', '+', $val1[5]);
                $date = [
                    'share_id' => $v['id'],
                    'address' => $val1[0],
                    'port' => $val1[1],
                    'password' => base64_decode($val1[5]),
                    'method' => $val1[3],
                    'protocol' => $val1[2],
                    'obfs' => $val1[4],
                    'ssrurl' => $ssr,
                    'updatetime' => time(),
                ];
                foreach ($val2 as $i) {
                    $ls = explode('=', $i);
                    switch ($ls[0]) {
                        case 'obfsparam':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['obfs_param'] = base64_decode($ls[1]);
                            break;
                        case 'protoparam':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['protocol_param'] = base64_decode($ls[1]);
                            break;
                        case 'remarks':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['remark'] = base64_decode($ls[1]);
                            break;
                        case 'group':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['group'] = base64_decode($ls[1]);
                            break;
                    }
                }
                $shareInfo = Config::get(['share_id' => $v['id'], 'address' => $val1[0], 'port' => $val1[1]]);
                if ($shareInfo) {
                    Config::update($date, ['id' => $shareInfo['id']]);
                } else {
                    $date['status'] = 0;
                    Config::create($date);
                }

            }
        }
    }

    public function detectAllSSR()
    {
        $all_ssr = Config::all();
        foreach ($all_ssr as $k => $v) {
            $statr_time = msectime();
            $date = ['status' => -1];
            $timeout = 15;
            try {
                $connection  = stream_socket_client("tcp://{$v['address']}:{$v['port']}",$erron,$errors,$timeout);
                if (!$connection) {
                    throw new Exception($errors($erron));
                }

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
}
