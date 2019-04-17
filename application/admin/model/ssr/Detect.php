<?php

namespace app\admin\model\ssr;

use think\Model;


class Detect extends Model
{

    

    //数据库
    protected $connection = 'database';
    // 表名
    protected $name = 'ssr_detect';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

    







    public function ssrconfig()
    {
        return $this->belongsTo('app\admin\model\SsrConfig', 'ssr_id', 'id', [], 'LEFT')->setEagerlyType(0);
    }
}
