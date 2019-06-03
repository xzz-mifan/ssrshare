<?php

namespace app\api\controller;

use app\common\controller\Api;
use think\Cache;

class Count extends Api
{

    /**
     * 无需登录的方法,同时也就不需要鉴权了
     * @var array
     */
    protected $noNeedLogin = ['fastbeat'];

    /**
     * @ApiTitle    (fast心跳检测)
     * @ApiSector   (fast)
     * @ApiMethod   (POST)
     */
    public function fastbeat()
    {
        $ip = $this->request->ip();
        $robot_onlines_cache_key = 'fast_online';
        $robot_onlines = Cache::get($robot_onlines_cache_key);
        if (!$robot_onlines) {
            $robot_onlines = [$ip => time()];
            Cache::set($robot_onlines_cache_key, $robot_onlines, 0);
            $this->success('成功');
        }
        if (!isset($robot_onlines[$ip])) {
            $robot_onlines[$ip] = time();
            Cache::set($robot_onlines_cache_key, $robot_onlines, 0);
            $this->success('成功');
        }
        $robot_onlines[$ip] = time();
        Cache::set($robot_onlines_cache_key, $robot_onlines, 0);
        $this->success('成功');
    }
}