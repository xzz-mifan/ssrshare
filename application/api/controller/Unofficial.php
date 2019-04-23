<?php
namespace app\api\controller;

use app\common\components\reptiles\Reptile;
use app\common\controller\Api;
use think\Cache;

class Unofficial extends Api
{
    /**
     * 无需登录的方法,同时也就不需要鉴权了
     * @var array
     */
    protected $noNeedLogin = ['bingImage'];
    public function bingImage()
    {
        $idx = $this->request->param('idx');
        $idx = !$idx?0:$idx;
        $image = Cache::get('bingimage');
        if (!$image)
        {
            $reptile = new Reptile();
            $reptile->Set_Https(true);
            $reptile->Set_Url(['https://www.bing.com/HPImageArchive.aspx']);
            $reptile->Set_Param(['format'=>'js','idx'=>'2','n'=>'1']);
            $data = $reptile->Reptile_send();
            $data = json_decode($data[0],true);
            $image = "https://www.bing.com/{$data['images'][0]['url']}";
            Cache::set('bingimage',$image,43200);
        }
        $this->success('获取成功',$image);
    }

}