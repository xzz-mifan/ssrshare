<?php


namespace app\api\controller;


use app\admin\model\WeiboUser;
use app\common\controller\Api;
use fast\Random;

/**
 * 微博
 * Class WeiBo
 * @package app\api\controller
 */
class WeiBo extends Api
{
    /**
     * 无需登录的方法,同时也就不需要鉴权了
     * @var array
     */
    protected $noNeedLogin = ['login','check'];

    /**
     * 登录
     *
     * @ApiTitle    (登录)
     * @ApiMethod   (POST)
     * @ApiParams   (name="username", type="string", required=true, description="用户名")
     * @ApiParams   (name="password", type="string", required=true, description="密码")
     */
    public function login()
    {
        $username = $this->request->post('username');
        $password = $this->request->post('password');
        if (!$username || !$password)
        {
            $this->error('用户名密码不能为空');
        }
        $userInfo = WeiboUser::get(['username'=>$username]);
        if (!$userInfo){
            $this->error('用户名不正确');
        }
        if ($userInfo['password'] != md5(md5($password).$userInfo['salt'])){
            $this->error('用户名密码不正确');
        }
        if ($userInfo['statrtime']>time() || $userInfo['endtime']<time()){
            $this->error('账号已到期或未到激活时间,请重新登录');
        }
        $uuid = Random::uuid();
        $resl = WeiboUser::update(['token'=>$uuid],['username'=>$username]);
        if (!$resl){
            $this->error('登陆失败');
        }
        $this->success('获取成功',['token'=>$uuid]);
    }

    /**
     * 验证
     * @ApiTitle    (验证)
     * @ApiMethod   (POST)
     * @ApiParams   (name="token", type="string", required=true, description="TOKEN")
     */
    public function check()
    {
        $token = $this->request->post('token');
        if (!$token)
        {
            $this->error('验证失败');
        }
        $userInfo = WeiboUser::get(['token'=>$token]);
        if (!$userInfo){
            $this->error('验证失败,请重新登录');
        }
        if ($userInfo['statrtime']>time() || $userInfo['endtime']<time()){
            $this->error('账号已到期,请重新登录');
        }
        $this->success('验证成功');
    }
}