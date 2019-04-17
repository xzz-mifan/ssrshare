<?php
namespace app\common\components\reptiles;
/**
* BY  :xuzhuangzhuang
* TIME:2018-05-12
* ADDRESS:henan-xuchang
*/
class Reptile {
	private $reptile;
	public function __construct(){
		$this->reptile=curl_multi_init();
	}
	private $header=[];
	/**
	 * 设置header
	 * 说明:设置为空数组则使用默认
	 * @param 数组类型 $value header
	 */
	public function Set_Header($value){
		$this->header=$value;
	}
	private $https=true;
	/**
	 * 设置请求类型
	 * @param 布尔类型 $value https
	 */
	public function Set_Https($value){
		$this->https=$value;
	}
	private $method='get';
	/**
	 * 设置发送类型
	 * @param 字符串类型 $value method
	 */
	public function Set_Method($value){
		$this->method=$value;
	}
	private $url=['https://www.baidu.com/s'];
	/**
	 * 设置链接
	 * @param 数组类型 $value url
	 */
	public function Set_Url($value){
		$this->url=$value;
	}
	private $param=['wd'=>'hello'];
	/**
	 * 设置发送数据
	 * 说明:类型为一维或多维
	 * @param 关联数组类型 $value data
	 */
	public function Set_Param($value){
		$this->param=$value;
	}
	private $time=60;
	/**
	 * 设置等待时间
	 * @param 整型 $value time
	 */
	public function Set_Wait_Time($value){
		$this->time=$value;
	}

	public function Reptile_send(){
		foreach ($this->url as $key => $url) {

			//创建连接
			$conn[$key]=curl_init($url);
			//检测提交方式
       		if ($this->method=='post' || $this->method='POST') {
       			curl_setopt($conn[$key],CURLOPT_POST,true);
       			if (count($this->param) == count($this->param,1)) {
       				curl_setopt($conn[$key],CURLOPT_POSTFIELDS,$this->param);
       			}else{
       				curl_setopt($conn[$key],CURLOPT_POSTFIELDS,$this->param[$key]);
       			}
       		}
			if ($this->method=='get' || $this->method='GET') {
       			$get_param='';
       			if (count($this->param) == count($this->param,1)) {
       				foreach ($this->param as $fidld => $va) {
       					$get_param.=$fidld.'='.$va.'&';
       				}
       				$url=$url.'?'.$get_param;
       			}else{
       				foreach ($this->param[$key] as $fidld => $va) {
       					$get_param.=$fidld.'='.$va.'&';
       				}
       				$url=$url.'?'.$get_param;
       			}
       			//重新创建连接
				$conn[$key]=curl_init($url);
       		}
			//设置以二进制形式返回数据
       		curl_setopt($conn[$key],CURLOPT_RETURNTRANSFER,true);
       		//等待请求时间
       		curl_setopt($conn[$key],CURLOPT_CONNECTTIMEOUT,$this->time);
       		//针对于302跳转
       		curl_setopt($conn[$key],CURLOPT_CUSTOMREQUEST,$this->method);
       		//判断是否是https
       		if ($this->https=true) {
       			curl_setopt($conn[$key],CURLOPT_SSL_VERIFYPEER,false);
          		curl_setopt($conn[$key],CURLOPT_SSL_VERIFYHOST,false);
       		}
       		//设置HTTP Hreader 信息
       		if (count($this->header)==0) {
       			curl_setopt($conn[$key],CURLOPT_HEADER,0);
       		}else{
       			curl_setopt($conn[$key],CURLOPT_HTTPHEADER,$this->header);
       		}
       		curl_multi_add_handle($this->reptile,$conn[$key]);
		}
		$collect=[]; //初始化返回值;
		// 初始化
		do {
			try {
				curl_multi_exec($this->reptile,$active);
			} catch (Exception $e) {
				return $e;
			}
		} while ($active);
		foreach ($this->url as $key => $url) {
			array_push($collect,curl_multi_getcontent($conn[$key]));
			curl_multi_remove_handle($this->reptile,$conn[$key]);
			curl_close($conn[$key]);
		}
		//关闭
		curl_multi_close($this->reptile);
		//返回数据
		return $collect;
	}
}
 ?>
