<?php

namespace app\admin\model\ssr;

use think\Model;
use app\common\components\reptiles\Reptile;
use think\Exception;
use app\common\components\net\IpLocation;

class Config extends Model
{

    //数据库
    protected $connection = 'database';
    // 表名
    protected $name = 'ssr_config';

    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'status_text'
    ];

    protected function _initialize()
    {

    }


    public function getStatusList()
    {
        return ['0' => __('Status 0'), '-1' => __('Status -1'), '1' => __('Status 1')];
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function share()
    {
        return $this->belongsTo('app\admin\model\ssr\Share', 'share_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }

    public static function getSSRShare()
    {
        $shareList = Share::all(['status' => 1]);
        foreach ($shareList as $k => $v) {
            $reptile = new Reptile();
            if (preg_match('/^https/', $v['url'])) {
                $reptile->Set_Https(true);
            } else {
                $reptile->Set_Https(false);
            }
            $reptile->Set_Method('exit');
            $reptile->Set_Url([$v['url']]);
            $resl = $reptile->Reptile_send();
            if (empty($resl[0])) {
                continue;
            }
            $resl = self::analyze($v['analyze_tyep'], $resl[0], $v['key']);

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
                $ssr_info_str = $ssr_info;
                $ssr_info = explode('/?', $ssr_info_str);
                if (count($ssr_info) == 1) {
                    $ssr_info = explode('/>', $ssr_info_str);
                }
                $val1 = explode(':', $ssr_info[0]);
                $val2 = explode('&', $ssr_info[1]);
                if (!checkIp($val1[0]) && !checkHost($val1[0])) {
                    continue;
                }
                if (empty($val1[2])) {
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
                $where = [
                    'address' => $date['address'],
                    'port' => $date['port'],
                    'password' => $date['password'],
                    'method' => $date['method'],
                    'protocol' => $date['protocol'],
                    'obfs' => $date['obfs'],
                ];
                foreach ($val2 as $i) {
                    $ls = explode('=', $i);
                    switch ($ls[0]) {
                        case 'obfsparam':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['obfs_param'] = base64_decode($ls[1]);
                            $where['obfs_param'] =$date['obfs_param'];
                            break;
                        case 'protoparam':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['protocol_param'] = base64_decode($ls[1]);
                            $where['protocol_param'] =$date['protocol_param'];
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
                /* 去重 */
                $ssrCount = self::where($where)->count();
                if ($ssrCount > 1) {
                    self::where($where)->delete();
                }
                try {
                    $shareInfo = self::get(['address' => $val1[0], 'port' => $val1[1]]);
                    if ($shareInfo) {
                        self::update($date, ['address' => $val1[0], 'port' => $val1[1]]);
                    } else {
                        $date['status'] = 0;
                        self::create($date);
                    }
                } catch (Exception $ex) {
                    throw new Exception($ex->getMessage());
                }
            }
        }
    }

    public static function analyze($analyze_tyep, $content, $key = '')
    {
        switch ($analyze_tyep) {
            case 1:
                return self::analyzeCommon($content);
                break;
            case 2:
                return self::analyzeASE($content, $key);
                break;
        }
    }

    private static function analyzeCommon($content)
    {
        $content = base64_decode($content);
        $content = explode("\n", $content);
        return $content;
    }

    private static function analyzeASE($content, $key)
    {
        $content = json_decode($content, true);
        $content = $content['ssrs'];
        $ssrs = openssl_decrypt($content, 'AES-128-ECB', $key);
        $ssrs = json_decode($ssrs, true);
        $content = [];
        foreach ($ssrs as $value) {
            if (isset($value['ssrUrl'])) {
                array_push($content, $value['ssrUrl']);
            }
        }
        return $content;
    }

    public static function detectAllSSR()
    {
        $site = config('site');
        $all_ssr = Config::all();
        foreach ($all_ssr as $k => $v) {
            $statr_time = msectime();
            $date = ['status' => -1];
            $timeout = $site['detect_ssr_time_out'];
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
                if ($site['time_delete_error_count'] <= $detectInfo['count']) {
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
