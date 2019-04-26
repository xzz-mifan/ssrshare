<?php

namespace app\admin\model\ssr;

use think\Model;


class Share extends Model
{

    

    //数据库
    protected $connection = 'database';
    // 表名
    protected $name = 'share';
    
    // 自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    // 定义时间戳字段名
    protected $createTime = 'createtime';
    protected $updateTime = 'updatetime';
    protected $deleteTime = false;

    // 追加属性
    protected $append = [
        'analyze_tyep_text',
        'status_text'
    ];
    

    
    public function getAnalyzeTyepList()
    {
        return ['1' => __('Analyze_tyep 1'), '2' => __('Analyze_tyep 2')];
    }

    public function getStatusList()
    {
        return ['0' => __('Status 0'), '1' => __('Status 1')];
    }


    public function getAnalyzeTyepTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['analyze_tyep']) ? $data['analyze_tyep'] : '');
        $list = $this->getAnalyzeTyepList();
        return isset($list[$value]) ? $list[$value] : '';
    }


    public function getStatusTextAttr($value, $data)
    {
        $value = $value ? $value : (isset($data['status']) ? $data['status'] : '');
        $list = $this->getStatusList();
        return isset($list[$value]) ? $list[$value] : '';
    }




}
