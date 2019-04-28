<?php

namespace app\api\controller;

use app\admin\model\ssr\Config as ConfigModel;
use app\common\controller\Api;
use think\Cookie;
use think\Session;

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
        header('HTTP/1.1 301 Moved Permanently'); //发出301头部
        $token = $this->request->param('token');
//        $user_id = Cookie::get('user_id');
//        trace($user_id.'读取缓存','zhanzheng');
//        if (!$user_id){
//            Cookie::set('user_id',$token);
//            $user_id = Cookie::get('user_id');
//            trace($user_id.'设置缓存','zhanzheng');
//        }

        if ($token){
            header('HTTP/1.1 200 Moved Permanently'); //发出301头部
//            header('Location:http://ssr.1103c.cn/api/index/ssr'); //跳转到带www的网址
//            header('Content-Type: text/plain'); //纯文本格式
//            header('Content-Disposition: attachment; filename="123.txt"');
//            header('Content-Transfer-Encoding: binary');
            trace($token,'zhanzheng');
            $configModel = new ConfigModel();
            $ssrList = $configModel->where(['status'=>1])->order('timeout asc')->limit(50)->select();
            $ssr_str='';
            foreach ($ssrList as $k => $v)
            {
                $config_str = $v['address'].':'.$v['port'].':'.$v['protocol'].':'.$v['method'].':'.$v['obfs'].':'.base64_encode($v['password']).'/?obfsparam='.base64_encode($v['obfs_param']).'&protoparam='.base64_encode($v['protocol_param']).'&remarks='.base64_encode('低延迟').'&group='.base64_encode('专用SSR');
                $ssr_str.='ssr://'.base64_encode($config_str)."\n\r";
            }
            return base64_encode($ssr_str);
            exit();
        }
        echo '<script src="'. $this->request->root().'/assets/js/verification.js"></script>';
        header('Location:http://ssr.1103c.cn/api/index/ssr'); //跳转到带www的网址
    }
}
