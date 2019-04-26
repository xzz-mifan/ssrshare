<?php

namespace app\admin\model\ssr;

use think\Model;
use app\common\components\reptiles\Reptile;

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

    public static function detectAllSSR()
    {
        $site = config('site');
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
            $resl = self::analyze($v['analyze_tyep'],$resl[0],$v['key']);

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
                $shareInfo = self::get(['share_id' => $v['id'], 'address' => $val1[0], 'port' => $val1[1]]);
                if ($shareInfo) {
                    self::update($date, ['id' => $shareInfo['id']]);
                } else {
                    $date['status'] = 0;
                    self::create($date);
                }

            }
        }
    }

    public static function analyze($analyze_tyep,$content,$key='')
    {
        switch ($analyze_tyep)
        {
            case 1:
                return self::analyzeCommon($content);
                break;
            case 2:
                self::analyzeASE($content,$key);
                break;
        }
    }

    private static function analyzeCommon($content)
    {
        $content = base64_decode($content);
        $content = explode("\n", $content);
        return $content;
    }

    private static function analyzeASE($content,$key)
    {
        $ssrs = openssl_decrypt($content, 'AES-128-ECB', $key);
        $ssrs = json_decode($ssrs,true);
        $content=[];
        foreach ($ssrs as $value) {
            if (isset())
        }

    }
}
