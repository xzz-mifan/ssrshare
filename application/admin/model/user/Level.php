<?php

namespace app\admin\model\user;

use think\Model;


class Level extends Model
{

    

    //数据库
    protected $connection = 'database';
    // 表名
    protected $name = 'user_level';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [

    ];
    

    







}
