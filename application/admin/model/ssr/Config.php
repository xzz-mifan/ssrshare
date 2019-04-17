<?php

namespace app\admin\model\ssr;

use think\Model;


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
}
