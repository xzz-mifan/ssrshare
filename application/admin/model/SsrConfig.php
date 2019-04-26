<?php

namespace app\admin\model;

use think\Model;

class SsrConfig extends Model
{
    // 表名
    protected $name = 'ssr_config';

    public static function analyze($analyze_id,$content)
    {
        switch ($analyze_id)
        {
            case 1:
                return self::analyzeCommon($content);
                break;
            case 2:
                self::analyzeASE($content);
                break;
        }
    }

    private function analyzeCommon($content)
    {
        $content = base64_decode($content);
        $content = explode("\n", $content);
        return $content;
    }

    private function analyzeASE($content)
    {

    }
    
}
