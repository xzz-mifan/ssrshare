<?php


namespace app\api\controller;


use app\common\controller\Api;
use app\common\model\Baidu;
use app\common\model\BaiduPwd;
use app\common\model\BaiduUrl;
use fast\Http;
use think\Cache;
use think\Db;
use think\Exception;

/**
 * 网盘采集
 * Class Pan
 * @package app\api\controller
 */
class Pan extends Api
{

    /**
     * 无需登录的方法,同时也就不需要鉴权了
     * @var array
     */
    protected $noNeedLogin = '*';

    /**
     * @var BaiduUrl
     */
    private $model = null;

    /**
     * 代理信息
     * @var null|array
     */
    private $proxyInfo = null;

    protected function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub

        $this->model = new BaiduUrl();

        ini_set('memory_limit', '1024M');
    }

    /**
     * baiDuPanSou
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */

    public function baiDuPanSou()
    {
        for ($i = 300; $i < 999; $i++) {
            $this->baiDuSou((string)$i);
        }

    }

    /**
     * =
     * @param $keyword
     */
    private function baiDuSou($keyword)
    {
        $this->proxyInfo = $this->randomIP();
        $i               = 0;
        $result          = true;
        do {
            $i++;
            $options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
            $options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
            $data                       = Http::get('http://106.15.195.249:8011/search_new', ['q' => $keyword, 'p' => $i], $options);
            if (!$dataJson = json_decode($data, true)) {
                echo "{$data}:ip:{$this->proxyInfo['ip']}\r\n";
                sleep(5);
                $this->proxyInfo            = $this->randomIP();
                $options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
                $options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
                $data                       = Http::get('http://106.15.195.249:8011/search_new', ['q' => $keyword, 'p' => $i], $options);
                if (!$dataJson = json_decode($data, true)) {
                    echo "{$data}:ip:{$this->proxyInfo['ip']}\r\n";
                    sleep(5);
                    $this->proxyInfo            = $this->randomIP();
                    $options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
                    $options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
                    $data                       = Http::get('http://106.15.195.249:8011/search_new', ['q' => $keyword, 'p' => $i], $options);
                    if (!$dataJson = json_decode($data, true)) {
                        echo "{$data}:ip:{$this->proxyInfo['ip']}\r\n";
                        continue;
                    }
                }
            }

            if ($dataJson['list']['count'] == 0) {
                echo "关键字:{$keyword}页数:{$i}, 已无数据\r\n";
                $result = false;
            }

            if ($dataJson['list']['p'] == 1 && $i != 1) {
                echo "关键字:{$keyword}页数:{$i}, 已无数据\r\n";
                $result = false;
            }

            if ($result) {
                $insertData = [];
                foreach ($dataJson['list']['data'] as $datum) {
                    $count = stripos($datum['link'], "com/s/");
                    if ($count == 0) {
                        continue;
                    }

                    $count        += 6;
                    $url          = substr($datum['link'], $count);
                    $insertData[] = [
                        'url' => $url,
                    ];
                }

                $this->model->insertAll($insertData, true);
                echo "关键字:{$keyword}页数:{$i}, 插入完成\r\n";
            }


        } while ($result);

    }

    public function checkBaiDuData()
    {
        $this->proxyInfo = $this->randomIP();

        $list = $this->model->where(['status' => ['in', '1,2']])->field('id,url,status')->select();
        if (!$list) {
            echo "已无数据检测\r\n";
        }

        foreach ($list as $info) {
            if ($info['status'] == 1) {
                /* 检测链接有效性 */
                $data    = $this->checkBaiDuUrl($info['id'], $info['url']);
                $dataMsg = $data == true ? '有效' : '无效';
                echo "检测状态:{$dataMsg}\r\n";
                if ($data == false) {
                    continue;
                }
            }

            $this->checkBaiDuIsPWD($info['id'], $info['url']);
        }
        echo "已全部完成!\r\n";
    }

    /**
     * 验证链接是否有效
     * @param $url
     * @return bool
     */
    private function checkBaiDuUrl($id, $url)
    {
        $options = [];
        if ($this->proxyInfo != null) {
            $options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
            $options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
        }

        echo "-------开始验证链接 id:{$id} url:{$url} ip:" . ($this->proxyInfo == null ? '本地' : $this->proxyInfo['ip']) . "-------\r\n";
        try {
            $url    = explode('?', $url);
            $url    = $url[0];
            $status = true;
            switch (rand(1, 2)) {
                case 1:
                    $checkUrl = "https://pan.baidu.com/share/linkstatus";
                    $params   = [
                        'web'        => 5,
                        'app_id'     => 250528,
                        'channel'    => 'chunlei',
                        'clienttype' => 5,
                        'appid'      => 250528,
                        'shorturl'   => substr($url, 1),
                    ];
                    $data     = Http::get($checkUrl, $params, $options);

                    echo "百度云 返回参数1:{$data}\r\n";
                    if (!$dataJson = json_decode($data, true)) {
                        throw new Exception("百度云:{$data}:ip:{$this->proxyInfo['ip']}\r\n", -1);
                    }

                    if ($dataJson['status'] != 0) {
                        $this->model->update(['status' => 3], ['id' => $id]);
                        $status = false;
                    } else {
                        $this->model->update(['status' => 2], ['id' => $id]);
                        $status = true;
                    }
                    break;
                case 2:
                    $checkUrl = 'https://www.dalipan.com/api/checkUrlValidFromBaidu';

                    $baiduUrl = "https://pan.baidu.com/s/{$url}";
                    $data     = Http::post($checkUrl, ['data' => $baiduUrl], $options);

                    echo "大力盘:{$data} 返回参数:{$data}\r\n";
                    if (!$dataJson = json_decode($data, true)) {
                        throw new Exception("大力盘:{$data}:ip:{$this->proxyInfo['ip']}\r\n", '-1');
                    }

                    if ($dataJson[$baiduUrl] != 1) {
                        $this->model->update(['status' => 3], ['id' => $id]);
                        $status = false;
                    } else {
                        $this->model->update(['status' => 2], ['id' => $id]);
                        $status = true;
                    }
                    break;
            }
            echo "-------验证链接完成 id:{$id} url:{$baiduUrl}-------\r\n";
            return $status;

        } catch (\Exception $ex) {

            if ($ex->getCode() == -1) {
                $this->proxyInfo = $this->randomIP();
            }

            echo "验证链接是否有效异常:{$ex->getMessage()}:行:{$ex->getLine()}\r\n";
            return $this->checkBaiDuUrl($id, $url);
        }
    }

    /**
     * 当前链接总大小
     * @var int
     */
    private $total_size = 0;

    /**
     * 当前链接索引文本
     * @var string
     */
    private $total_content = '';

    /**
     * 获取网盘内信息
     * @param $id
     * @param $url
     * @return bool
     */
    private function checkBaiDuIsPWD($id, $url)
    {
        /* 初始化参数 */
        $this->total_size    = 0;
        $this->total_content = '';

        try {
            $options = [];
            if ($this->proxyInfo != null) {
                $options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
                $options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
            }

            echo "-------开始验证是否又有密码,没有则采集 id:{$id} url:{$url} ip:" . ($this->proxyInfo == null ? '本地' : $this->proxyInfo['ip']) . "-------\r\n";

            $checkUrl = 'https://pan.baidu.com/share/list';
            $params   = [
                'shorturl' => substr($url, 1),
                'root'     => 1
            ];

            $data = Http::get($checkUrl, $params, $options);
            echo "百度云 返回参数2:{$data}\r\n";
            if (!$dataJson = json_decode($data, true)) {
                throw new Exception("百度云:{$data}:ip:{$this->proxyInfo['ip']}\r\n", -1);
            }

            /* 判断是否有密码 */
            $savePwdData = null;
            if ($dataJson['errno'] != 0) {

                /* 获取密码 */
                $checkUrl = "https://nuexini.gq/bdp.php";
                $params   = [
                    'url' => "https://pan.baidu.com/s/{$url}",
                ];
                $getPWD   = Http::get($checkUrl, $params, $options);
                echo "获取密码 返回参数:{$getPWD}\r\n";
                if (empty($getPWD)) {
                    $this->model->update(['status' => 5], ['id' => $id]);
                    return false;
                }

                if (!$getPWDJson = json_decode($getPWD, true)) {
                    throw new Exception("获取密码:{$getPWD}:ip:{$this->proxyInfo['ip']}\r\n", -1);
                }

                /* 输入验证密码 */
                if (!isset($getPWDJson['access_code']) || empty($getPWDJson['access_code'])) {
                    $this->model->update(['status' => 5], ['id' => $id]);
                    return false;
                }

                $temp_options = [];
                if ($this->proxyInfo != null) {
                    $temp_options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
                    $temp_options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
                }

                $outPWDStatus = true;
                $isUntie      = false;
                while ($outPWDStatus) {
                    $options['Referer'] = "https://pan.baidu.com/share/init?surl=" . substr($url, 1);
                    $checkUrl           = 'https://pan.baidu.com/share/verify?surl=' . substr($url, 1) . '&channel=chunlei&web=1&app_id=250528&clienttype=0';
                    $params             = [
                        'pwd'       => $getPWD,
                        'vcode'     => '',
                        'vcode_str' => '',
                    ];
                    $result             = Http::post($checkUrl, $params, $temp_options);
                    if (!$resultJson = json_decode($result, true)) {
                        throw new Exception("输入密码:{$result}:ip:{$this->proxyInfo['ip']}\r\n", -1);
                    }

                    switch ($resultJson['errno']) {
                        case 0:
                            $isUntie      = true;
                            $outPWDStatus = false;
                            break;
                        case -62:
                            $proxyInfo = $this->randomIP();
                            if ($proxyInfo != null) {
                                $temp_options[CURLOPT_PROXYTYPE] = $proxyInfo['type'];//todo
                                $temp_options[CURLOPT_PROXY]     = $proxyInfo['ip'];
                            }
                            $isUntie = false;
                            break;
                        default:
                            $isUntie      = -1;
                            $outPWDStatus = false;
                    }
                }

                if ($isUntie != true) {
                    $this->model->update(['status' => 5], ['id' => $id]);
                    return false;
                }

                $savePwdData['url'] = $url;
                $savePwdData['pwd'] = $getPWD;

                echo "-------验证输入密码完成 开始获取信息 \r\n";

                $checkUrl = 'https://pan.baidu.com/share/list';
                $params   = [
                    'shorturl' => substr($url, 1),
                    'root'     => 1
                ];

                $data = Http::get($checkUrl, $params, $options);
                echo "百度云 返回参数3:{$data}\r\n";
                if (!$dataJson = json_decode($data, true)) {
                    throw new Exception("百度云:{$data}:ip:{$this->proxyInfo['ip']}\r\n", -1);
                }
            }

            /* 标题 */
            $titles            = explode('/', $dataJson['title']);
            $saveData['title'] = $titles[(count($titles) - 1)];

            /* 子标题 */
            if (count($titles) >= 2) {
                $saveData['path'] = $titles[(count($titles) - 2)] . $titles[(count($titles) - 1)];
            } else {
                $saveData['path'] = $titles[(count($titles) - 1)];
            }


            /* 分类 */
            $saveData['category'] = 99999;

            /* 文件大小 */
            $saveData['size'] = 0;

            /* 更新时间 */
            $saveData['server_mtime'] = 0;

            /* 内容 */
            $saveData['content'] = "";

            /* json内容 */
            $saveData['json_content'] = "";


            /* 内容数组 */
            $contents = [];

            foreach ($dataJson['list'] as $value) {

                /* 分类 */
                if ($value['server_filename'] == $saveData['title']) {
                    $saveData['category'] = $value['category'];
                }

                /* 更新时间 */
                if ($value['server_mtime'] > $saveData['server_mtime']) {
                    $saveData['server_mtime'] = $value['server_mtime'];
                }

                /* 统计大小及标题 */
                $this->total_size    += $value['size'];
                $this->total_content .= $value['server_filename'] . ",";


                /* 内容数组 */
                $contents[] = [
                    'isdir'           => $value['isdir'],
                    'server_filename' => $value['server_filename'],
                    'path'            => $value['path'],
                    'size'            => $value['size']
                ];

            }
            /* 采集N级目录 */
            foreach ($contents as $key => $value) {
                if ($value['isdir'] == 1) {

                    $contents[$key]['list'] = [];

                    $this->collection2($url, $value['path'], $contents[$key]['list']);
                }
            }

            /* 准备数据*/

            $saveData['size'] = $this->total_size;

            $saveData['content'] = $this->total_content;

            $saveData['json_content'] = json_encode($contents);

        } catch (Exception $ex) {
            if ($ex->getCode() == -1) {
                $this->proxyInfo = $this->randomIP();
            }

            echo "采集信息异常1:{$ex->getMessage()}:行:{$ex->getLine()}\r\n";
            return $this->checkBaiDuIsPWD($id, $url);
        }

        /* 写入数据库 */
        Db::startTrans();
        try {
            $baiduModel = new Baidu();
            $id         = $baiduModel->insertGetId($saveData);
            $md5        = md5($id . $saveData['title']);
            $baiduModel->update(['md5' => $md5], ['id' => $id]);

            if ($savePwdData === null) {
                $savePwdData['url'] = $url;
            }
            $savePwdData['md5'] = $md5;

            $baiduPwdModel = new BaiduPwd();
            $baiduPwdModel->insert($savePwdData);

            $this->model->update(['status' => 4], ['id' => $id]);

            echo "---插入完成 id:{$id} url:{$url} ip:" . ($this->proxyInfo == null ? '本地' : $this->proxyInfo['ip']) . "----\r\n";

            Db::commit();
            return true;
        } catch (Exception $ex) {
            echo "---插入异常 id:{$id} url:{$url} msg:{$ex->getMessage()} 行:{$ex->getLine()}----\r\n";
            Db::rollback();
            return false;
        }

    }


    private function collection2($url, $path, &$info)
    {
        try {

            $options = [];
            if ($this->proxyInfo != null) {
                $options[CURLOPT_PROXYTYPE] = $this->proxyInfo['type'];//todo
                $options[CURLOPT_PROXY]     = $this->proxyInfo['ip'];
            }

            $checkUrl = 'https://pan.baidu.com/share/list';
            $params   = [
                'web'        => 5,
                'app_id'     => 250528,
                'channel'    => 'chunlei',
                'clienttype' => 5,
                'desc'       => 1,
                'showempty'  => 0,
                'page'       => 1,
                'num'        => 20,
                'order'      => 'time',
                'shorturl'   => substr($url, 1),
                'dir'        => $path,
            ];

            $data = Http::get($checkUrl, $params, $options);
            echo "采集二级目录 返回参数:{$data}\r\n";

            if (!$dataJson = json_decode($data, true)) {
                throw new Exception("采集二级目录:{$data}:ip:{$this->proxyInfo['ip']}\r\n", -1);
            }

            foreach ($dataJson['list'] as $value) {
                $info[] = [
                    'isdir'           => $value['isdir'],
                    'server_filename' => $value['server_filename'],
                    'path'            => $value['path'],
                    'size'            => $value['size']
                ];

                /* 统计大小及标题 */
                $this->total_size    += $value['size'];
                $this->total_content .= $value['server_filename'] . ",";
            }

            foreach ($info as $key => $value) {
                if ($value['isdir'] == 1) {
                    $info[$key]['list'] = [];

                    $this->collection2($url, $value['path'], $info[$key]['list']);
                }
            }


        } catch (\Exception $ex) {
            if ($ex->getCode() == -1) {
                $this->proxyInfo = $this->randomIP();
            }

            echo "采集二级目录:{$ex->getMessage()}:行:{$ex->getLine()}\r\n";
            return $this->collection2($url, $path, $info);
        }

    }


    /**
     * 代理IP池
     * @return array
     */
    public function randomIP()
    {
        switch (rand(1, 4)) {
            case 1:
                $proxyArr = [
                    'ip'   => $this->readProxy('socks5'),
                    'type' => CURLPROXY_SOCKS5,
                ];
                break;
            case 2:
                $proxyArr = [
                    'ip'   => $this->readProxy('socks4'),
                    'type' => CURLPROXY_SOCKS4,
                ];
                break;
            case 3:
                $proxyArr = [
                    'ip'   => $this->readProxy('http'),
                    'type' => CURLPROXY_HTTP,
                ];
                break;
            case 4:
                $proxyArr = null;
                break;
        }

        if ($proxyArr != null) {
            try {
                for ($i = 0; $i < 6; $i++) {
                    $connection = stream_socket_client("tcp://{$proxyArr['ip']}", $erron, $errors, 5);
                    if (!$connection) {
                        throw new Exception('123');
                    }
                }
            } catch (\Exception $ex) {
                return $this->randomIP();
            }
        }

        return $proxyArr;
    }


    /**
     * 随机获取一个代理
     * @param string $type
     * @return bool|mixed
     */
    private function readProxy($type = 'socks5')
    {
        $filename = "{$type}.txt";
        if (!file_exists($filename)) {
            fopen($filename, "w");
        }

        $cacheKey = hash_file('md5', $filename);

        $data = Cache::get($cacheKey);

        if (!$data) {
            $data = $this->readFile($filename);

            Cache::set($cacheKey, $data, 259200);
        }

        return $data[(rand(0, count($data) - 1))];
    }

    /**
     * 读取文件
     * @param $filename
     * @return array
     */
    private function readFile($filename)
    {
        $data       = [];
        $fileHandle = fopen($filename, 'r');
        while (feof($fileHandle) === false) {

            $data[] = fgets($fileHandle);
        }

        fclose($fileHandle);

        return $data;
    }

}