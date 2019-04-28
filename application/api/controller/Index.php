<?php

namespace app\api\controller;

use app\admin\model\ssr\Config as ConfigModel;
use app\common\controller\Api;

/**
 * 首页接口
 */
class Index extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    /**
     * 首页
     *
     */
    public function index()
    {
        $this->success('请求成功');
    }
    public function ssr()
    {
        $token = $this->request->header('token');
        if ($token){
            trace(md5($token),'zhanzheng');
            $configModel = new ConfigModel();
            $ssrList = $configModel->where(['status'=>1])->order('timeout asc')->limit(50)->select();
            $ssr_str='';
            foreach ($ssrList as $k => $v)
            {
                $config_str = $v['address'].':'.$v['port'].':'.$v['protocol'].':'.$v['method'].':'.$v['obfs'].':'.base64_encode($v['password']).'/?obfsparam='.base64_encode($v['obfs_param']).'&protoparam='.base64_encode($v['protocol_param']).'&remarks='.base64_encode('低延迟').'&group='.base64_encode('专用SSR');
                $ssr_str.='ssr://'.base64_encode($config_str)."\n\r";
            }
            return base64_encode($ssr_str);
        }
        echo '<script src="'. $this->request->root().'/assets/js/verification.js"></script>';
    }
}
