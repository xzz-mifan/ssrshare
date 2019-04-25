<?php

namespace app\time\controller;

use app\admin\model\ssr\Config;
use app\admin\model\ssr\Detect;
use app\admin\model\ssr\Share;
use think\Controller;
use app\common\components\reptiles\Reptile;
use think\Exception;
use think\Log;

/**
 * 每天
 */
class Sixhours extends Controller
{
    protected $site;

    protected function _initialize()
    {
        set_time_limit(0);
        $this->site = config('site');
    }

    public function index()
    {

        $this->getSSRShare();

        $this->detectAllSSR();
    }

    public function getSSRShare()
    {
        $shareList = Share::all(['status' => 1]);
        foreach ($shareList as $k => $v) {
            $reptile = new Reptile();
            if (preg_match('/^https/', $v['url'])) {
                $reptile->Set_Https(true);
            } else {
                $reptile->Set_Https(false);
            }
            $reptile->Set_Url([$v['url']]);
            $resl = $reptile->Reptile_send();
            if (empty($resl[0])) {
                continue;
            }
            $resl = base64_decode($resl[0]);
            $resl = explode("\n", $resl);
            foreach ($resl as $ssr) {
                $init_ssr = trim($ssr);
                if (empty($init_ssr)) {
                    continue;
                }
                $init_ssr = str_replace('_', '+', $init_ssr);
                $ssr_info = explode('://', $init_ssr);
                if (count($ssr_info) != 2) {
                    continue;
                }
                $ssr_info = base64_decode($ssr_info[1]);
                $ssr_info = explode('/?', $ssr_info);
                $val1 = explode(':', $ssr_info[0]);
                $val2 = explode('&', str_replace('>', "", $ssr_info[1]));
                halt($ssr_info);
                exit();
                if (!checkIp($val1[0]) && !checkHost($val1[0])) {
                    continue;
                }
                $val1[5] = str_replace('_', '+', $val1[5]);
                $date = [
                    'share_id' => $v['id'],
                    'address' => $val1[0],
                    'port' => $val1[1],
                    'password' => base64_decode($val1[5]),
                    'method' => $val1[3],
                    'protocol' => $val1[2],
                    'obfs' => $val1[4],
                    'ssrurl' => $ssr,
                    'updatetime' => time(),
                ];
                foreach ($val2 as $i) {
                    $ls = explode('=', $i);
                    switch ($ls[0]) {
                        case 'obfsparam':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['obfs_param'] = base64_decode($ls[1]);
                            break;
                        case 'protoparam':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['protocol_param'] = base64_decode($ls[1]);
                            break;
                        case 'remarks':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['remark'] = base64_decode($ls[1]);
                            break;
                        case 'group':
                            $ls[1] = str_replace('_', '+', $ls[1]);
                            $date['group'] = base64_decode($ls[1]);
                            break;
                    }
                }
                $shareInfo = Config::get(['share_id' => $v['id'], 'address' => $val1[0], 'port' => $val1[1]]);
                if ($shareInfo) {
                    Config::update($date, ['id' => $shareInfo['id']]);
                } else {
                    $date['status'] = 0;
                    Config::create($date);
                }

            }
        }
    }

    public function detectAllSSR()
    {
        $all_ssr = Config::all();
        foreach ($all_ssr as $k => $v) {
            $statr_time = msectime();
            $date = ['status' => -1];
            $timeout = $this->site['detect_ssr_time_out'];
            try {
                $connection = stream_socket_client("tcp://{$v['address']}:{$v['port']}", $erron, $errors, $timeout);
                if (!$connection) {
                    throw new Exception($errors($erron));
                }

                $end_time = msectime();
                $date['status'] = 1;
                $date['timeout'] = $end_time - $statr_time;
                Config::update($date, ['id' => $v['id']]);
                continue;

            } catch (Exception $ex) {
                $detectInfo = Detect::get(['ssr_id' => $v['id']]);
                if ($detectInfo) {
                    Detect::update(['count' => ($detectInfo['count'] + 1), 'updatetime' => time()], ['ssr_id' => $v['id']]);
                } else {
                    Detect::create(['ssr_id' => $v['id'], 'count' => 1, 'msg' => $ex->getMessage(), 'updatetime' => time(), 'createtime' => time()]);
                }
                if ($this->site['time_delete_error_count'] <= $detectInfo['count']) {
                    Config::get($v['id'])->delete();
                    $detectInfo->delete();
                }

                $end_time = msectime();
                $date['timeout'] = $end_time - $statr_time;
                Config::update($date, ['id' => $v['id']]);
                continue;
            }
        }
    }

    public function test()
    {
//        $resl = base64_decode('TUFYPTUNCnNzcjovL05EVXVNelV1TVRFNUxqRTBOVG8wTkRNNllYVjBhRjlqYUdGcGJsOWhPbTV2Ym1VNmRHeHpNUzR5WDNScFkydGxkRjloZFhSb09sWklNVGxpVkdSbVVqTkpMejl2WW1aemNHRnlZVzA5Sm5KbGJXRnlhM005TmxwdFVUWlpRMlkyVEZOdE5Wa3RNMGxJV25kamVVRjRKbWR5YjNWd1BWSnVTbXhhVms1VVZXa3hkMlJYU25OaFYwMA0Kc3NyOi8vTVRBMExqSXlOQzR4TmpJdU1qSTFPalU0T1RVeE9tRjFkR2hmWVdWek1USTRYMjFrTlRwaFpYTXRNVEk0TFdOMGNqcDBiSE14TGpKZmRHbGphMlYwWDJGMWRHZzZWVE0xV0ZKNVZucFRlazB2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMldtMVJObGxEWmpaTVUyMDFXUzB6U1VoYWQyTjVRWGttWjNKdmRYQTlVbTVLYkZwV1RsUlZhVEYzWkZkS2MyRlhUUQ0Kc3NyOi8vTVRBMExqSXdOeTR4TWprdU1qQTNPalEwTXpwaGRYUm9YMk5vWVdsdVgyRTZibTl1WlRwMGJITXhMakpmZEdsamEyVjBYMkYxZEdnNlZFZHNiRlZ1V2xOaVdITXZQMjlpWm5Od1lYSmhiVDBtY21WdFlYSnJjejAyV20xUk5sbERaalpNVTIwMVdTMHpTVWhhZDJONVFYb21aM0p2ZFhBOVVtNUtiRnBXVGxSVmFURjNaRmRLYzJGWFRRDQpzc3I6Ly9NVGs1TGpFNE1DNHhNek11TVRFNE9qRXdPREE2WVhWMGFGOWhaWE14TWpoZmJXUTFPbUZsY3kweE1qZ3RZM1J5T25Sc2N6RXVNbDkwYVdOclpYUmZZWFYwYURwVlJYUnZVMWRaTUZSRll5OF9iMkptYzNCaGNtRnRQU1p5WlcxaGNtdHpQVFphYlZFMldVTm1Oa3hUYlRWWkxUTkpTRnAzWTNsQk1DWm5jbTkxY0QxU2JrcHNXbFpPVkZWcE1YZGtWMHB6WVZkTg0Kc3NyOi8vTVRBM0xqRTRNaTR4TnpZdU9EazZPREE0TURwaGRYUm9YMk5vWVdsdVgyRTZibTl1WlRwMGJITXhMakpmZEdsamEyVjBYMkYxZEdnNlpVaDBSMk5XTlhwVk1FVXZQMjlpWm5Od1lYSmhiVDBtY21WdFlYSnJjejAyV20xUk5sbERaalpNVTIwMVdTMHpTVWhhZDJONVFURW1aM0p2ZFhBOVVtNUtiRnBXVGxSVmFURjNaRmRLYzJGWFRRDQpzc3I6Ly9NVGN5TGprekxqUTNMakV4TkRvM01EZ3dPbUYxZEdoZllXVnpNVEk0WDIxa05UcHlZelE2ZEd4ek1TNHlYM1JwWTJ0bGRGOWhkWFJvT2xOR1NsbGlhMVZ5VVcxbkx6OXZZbVp6Y0dGeVlXMDlKbkpsYldGeWEzTTlObHB0VVRaWlEyWTJURk50TlZrdE0wbElXbmRqZVVFeUptZHliM1Z3UFZKdVNteGFWazVVVldreGQyUlhTbk5oVjAwDQpzc3I6Ly9NVEEwTGpFMk1DNDBNQzQzTlRvMU1URXlOenBoZFhSb1gyRmxjekV5T0Y5dFpEVTZZV1Z6TFRFeU9DMWpkSEk2ZEd4ek1TNHlYM1JwWTJ0bGRGOWhkWFJvT21Vd01VNVhWVlpIVlRBNEx6OXZZbVp6Y0dGeVlXMDlKbkpsYldGeWEzTTlObHB0VVRaWlEyWTJURk50TlZrdE0wbElXbmRqZVVFekptZHliM1Z3UFZKdVNteGFWazVVVldreGQyUlhTbk5oVjAwDQpzc3I6Ly9NVGN5TGpFd05DNDVOaTR4TURrNk9EQTZZWFYwYUY5amFHRnBibDloT201dmJtVTZhSFIwY0Y5emFXMXdiR1U2UzFWc2RsQlZkRVZWVkVVdlAyOWlabk53WVhKaGJUMU5WR041VEdwRmQwNURORFZPYVRSNFRVUnJKbkpsYldGeWEzTTlObHB0VVRaWlEyWTJURk50TlZrdE0wbFBWelYxTFdGcGNHbENNbU5JVFdkUFFTWm5jbTkxY0QxU2JrcHNXbFpPVkZWcE1YZGtWMHB6WVZkTg0Kc3NyOi8vTVRBMExqRTJNQzR4T0RVdU1UQXhPamN3TURBNllYVjBhRjlqYUdGcGJsOWhPbTV2Ym1VNmRHeHpNUzR5WDNScFkydGxkRjloZFhSb09sUXdWa3BpTURWaFVqSlJMejl2WW1aemNHRnlZVzA5Sm5KbGJXRnlhM005TmxwdFVUWlpRMlkyVEZOdE5Wa3RNMGxJV25kamVVRTFKbWR5YjNWd1BWSnVTbXhhVms1VVZXa3hkMlJYU25OaFYwMA0Kc3NyOi8vTVRNNExqRTVOeTR5TURVdU5EUTZPREE2WVhWMGFGOWphR0ZwYmw5aE9tNXZibVU2YUhSMGNGOXphVzF3YkdVNlQxZFZNRkZHWXpKVGJHOHZQMjlpWm5Od1lYSmhiVDBtY21WdFlYSnJjejAyV20xUk5sbERaalpNVTIwMVdTMHpTVWhhZDJONVFYaE5RU1puY205MWNEMVNia3BzV2xaT1ZGVnBNWGRrVjBwellWZE4NCnNzcjovL2RHVnViVzB1WTI5dE9qUTBOVHBoZFhSb1gyTm9ZV2x1WDJFNmJtOXVaVHAwYkhNeExqSmZkR2xqYTJWMFgyRjFkR2c2WWtWd1pWUkdaRXhOVmxrdlAyOWlabk53WVhKaGJUMG1jbVZ0WVhKcmN6MDJXbTFSTmxsRFpqWk1VMjAxV1MwelNVaGFkMk41UVhoTlVTWm5jbTkxY0QxU2JrcHNXbFpPVkZWcE1YZGtWMHB6WVZkTg0Kc3NyOi8vT1RJdU1qSXpMalkzTGpnNk5qVTFNelU2WVhWMGFGOWhaWE14TWpoZmJXUTFPbUZsY3kweE1qZ3RZM1J5T25Sc2N6RXVNbDkwYVdOclpYUmZZWFYwYURwS1JsSkNZMFJHUkdWcmR5OF9iMkptYzNCaGNtRnRQU1p5WlcxaGNtdHpQVFphYlZFMldVTm1Oa3hUYlRWWkxUTkpTRnAzWTNsQmVFMW5KbWR5YjNWd1BWSnVTbXhhVms1VVZXa3hkMlJYU25OaFYwMA0Kc3NyOi8vT0RrdU5EWXVNVEkwTGpZeE9qRXdPREE2WVhWMGFGOWphR0ZwYmw5aE9tNXZibVU2Y0d4aGFXNDZZbXhPYm1JeVNsSmxWVFF2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMldtMVJObGxEWmpaTVUyMDFXUzB6U1VoYWQyTjVRWGhPUVNabmNtOTFjRDFTYmtwc1dsWk9WRlZwTVhka1YwcHpZVmRODQpzc3I6Ly9NVGt5TGpJeE1DNHhOekl1TWpRMk9qY3dNREE2WVhWMGFGOWphR0ZwYmw5aE9tNXZibVU2ZEd4ek1TNHlYM1JwWTJ0bGRGOWhkWFJvT2xWV2JGRm1iR053WlROakx6OXZZbVp6Y0dGeVlXMDlKbkpsYldGeWEzTTlObHB0VVRaWlEyWTJURk50TlZrdE0wbElXbmRqZVVGNFRsRW1aM0p2ZFhBOVVtNUtiRnBXVGxSVmFURjNaRmRLYzJGWFRRDQpzc3I6Ly9OVEl1TVRZekxqVTJMamc1T2pFNE5ETTBPbUYxZEdoZllXVnpNVEk0WDIxa05UcGhaWE10TVRJNExXTjBjanAwYkhNeExqSmZkR2xqYTJWMFgyRjFkR2c2U21sMGQyRXpOSEppTW1jdlAyOWlabk53WVhKaGJUMG1jbVZ0WVhKcmN6MDJXbTFSTmxsRFpqWk1VMjAxV1MwelNVaGFkMk41UVhoT1p5Wm5jbTkxY0QxU2JrcHNXbFpPVkZWcE1YZGtWMHB6WVZkTg0Kc3NyOi8vTVRNdU5qY3VNVEUyTGpRMU9qWTFOVE0xT21GMWRHaGZZV1Z6TVRJNFgyMWtOVHBoWlhNdE1USTRMV04wY2pwMGJITXhMakpmZEdsamEyVjBYMkYxZEdnNlVWWnNORlZIVlRsU2JtOHZQMjlpWm5Od1lYSmhiVDBtY21WdFlYSnJjejAxV1RKTE5scHRVVFpaUTJZMlRGTnROVmt0TTBsSVduZGplVUY0VG5jbVozSnZkWEE5VW01S2JGcFdUbFJWYVRGM1pGZEtjMkZYVFENCnNzcjovL01UTXVOamN1TVRFMkxqUTFPalV5TVRNMU9tRjFkR2hmWVdWek1USTRYMjFrTlRwaFpYTXRNVEk0TFdOMGNqcDBiSE14TGpKZmRHbGphMlYwWDJGMWRHZzZVRlF4Wm1NeVJrSkthbWN2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMVdUSkxObHB0VVRaWlEyWTJURk50TlZrdE0wbElXbmRqZVVGNFRua3dlU1puY205MWNEMVNia3BzV2xaT1ZGVnBNWGRrVjBwellWZE4NCnNzcjovL01qTXVNakkxTGpFNE1pNHhPVE02TkRVM09ETTZZWFYwYUY5aFpYTXhNamhmYldRMU9tRmxjeTB4TWpndFkzUnlPblJzY3pFdU1sOTBhV05yWlhSZllYVjBhRHBrUjNoc1RsVnNORXBxUVM4X2IySm1jM0JoY21GdFBTWnlaVzFoY210elBUVlpNa3MyV20xUk5sbERaalpNVTIwMVdTMHpTVWhhZDJONVFYaFBRU1puY205MWNEMVNia3BzV2xaT1ZGVnBNWGRrVjBwellWZE4NCnNzcjovL05EVXVOell1TWpFd0xqSXlPRG95T0RRek5qcGhkWFJvWDJGbGN6RXlPRjl0WkRVNllXVnpMVEV5T0MxamRISTZkR3h6TVM0eVgzUnBZMnRsZEY5aGRYUm9Pa3hWWkhSUldEVlBWMVJCTHo5dlltWnpjR0Z5WVcwOUpuSmxiV0Z5YTNNOU5scHRVVFpaUTJZMlRGTnROVmt0TTBsSVduZGplVUY0VDFFbVozSnZkWEE5VW01S2JGcFdUbFJWYVRGM1pGZEtjMkZYVFENCnNzcjovL01UTTVMalU1TGpJek9DNDNPakV4TVRZM09tRjFkR2hmWVdWek1USTRYMjFrTlRwaFpYTXRNVEk0TFdOMGNqcDBiSE14TGpKZmRHbGphMlYwWDJGMWRHZzZZMmxaT1U5V2NFTlRhV2N2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMldtMVJObGxEWmpaTVUyMDFXUzB6U1VoYWQyTjVRWGxOUVNabmNtOTFjRDFTYmtwc1dsWk9WRlZwTVhka1YwcHpZVmRODQpzc3I6Ly9kWE11YzJGdUxuTmlaWEl1ZUhsNk9qSXpNek16T21GMWRHaGZZMmhoYVc1ZllUcHViMjVsT25Cc1lXbHVPbUpGU2pObGFscDBMejl2WW1aemNHRnlZVzA5Sm5KbGJXRnlhM005TmxwdFVUWlpRMlkyVEZOdE5Wa3RNMGxJVm5wSlNFNXZXVmhLYkVsRVJTWm5jbTkxY0QxU2JrcHNXbFpPVkZWcE1YZGtWMHB6WVZkTg0Kc3NyOi8vTlRJdU1Ua3pMak13TGpFNE1qbzBORE02WVhWMGFGOWphR0ZwYmw5aE9tNXZibVU2Y0d4aGFXNDZXVzVLYkZsWGRETlpWRVY0VEcxS2MySXlaSHBqUnprd1RHMU9kbUpSTHo5dlltWnpjR0Z5WVcwOUpuSmxiV0Z5YTNNOU5scHRVVFpaUTJZMlRGTnROVmt0TTBsRlJsaFZlVUpMVlVOQ2VtRkhSbmxhVTBGNUptZHliM1Z3UFZKdVNteGFWazVVVldreGQyUlhTbk5oVjAwDQpzc3I6Ly9OVEl1TWpNeExqTTFMak02TkRRME5EUTZZWFYwYUY5amFHRnBibDloT25Kak5DMXRaRFU2ZEd4ek1TNHlYM1JwWTJ0bGRGOWhkWFJvT2sxRVZYaGpWMFkyVFZSVk1FNTNMejl2WW1aemNHRnlZVzA5Sm5KbGJXRnlhM005TmxwdFVUWlpRMlkyVEZOdE5Wa3RNMGxJVG05WldFcHNTVVJSSm1keWIzVndQVkp1U214YVZrNVVWV2t4ZDJSWFNuTmhWMDANCnNzcjovL05EY3VPRGd1TWpFMkxqWXpPalEwTXpwaGRYUm9YMk5vWVdsdVgyRTZibTl1WlRwMGJITXhMakpmZEdsamEyVjBYMkYxZEdnNlZXczFXbUp0VGxOWFJGcExaVlY0TTAwd1RqWlNNVkY1WVZOMFFsRlVNRGt2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMldtMVJObGxEWmpaTVUyMDFXUzB6U1VoT2IxbFlTbXhKUkZVbVozSnZkWEE5VW01S2JGcFdUbFJWYVRGM1pGZEtjMkZYVFENCnNzcjovL01UQTNMakUzTkM0M01TNHlPRG8wTkRNNllYVjBhRjlqYUdGcGJsOWhPbTV2Ym1VNmRHeHpNUzR5WDNScFkydGxkRjltWVhOMFlYVjBhRHBSTWxaMVpFZFdlVk5JVm1sTlJFRjRMejl2WW1aemNHRnlZVzA5Sm5CeWIzUnZjR0Z5WVcwOVRtcFpNazVxV1RKUGExcERaVVphVVZscWJFdGpWbXN6VDBodmVXSnFWU1p5WlcxaGNtdHpQVFphYlZFMldVTm1Oa3hUYlRWWkxUTkpTRTV2V1ZoS2JFbEVXU1puY205MWNEMVNia3BzV2xaT1ZGVnBNWGRrVjBwellWZE4NCnNzcjovL01qRXpMakU0TXk0ME9DNDNNVG94TURnd09tRjFkR2hmWTJoaGFXNWZZVHB1YjI1bE9uUnNjekV1TWw5MGFXTnJaWFJmWVhWMGFEcGpNMDU1THo5dlltWnpjR0Z5WVcwOUpuSmxiV0Z5YTNNOU5VeHBUalphYlZFMldVTm1Oa3hUYlRWWkxUTkpTRTV2V1ZoS2JFbEVZeVpuY205MWNEMVNia3BzV2xaT1ZGVnBNWGRrVjBwellWZE4NCnNzcjovL01qSXhMakV5TlM0eU1UY3VNVEl3T2pRMk5UcGhkWFJvWDJOb1lXbHVYMkU2Ym05dVpUcDBiSE14TGpKZmRHbGphMlYwWDJGMWRHZzZZbGRzYUdJelFtaGpNbXN2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMldtMVJObGxEWmpaTVUyMDFXUzB6U1VoT2IxbFlTbXhKUkdjbVozSnZkWEE5VW01S2JGcFdUbFJWYVRGM1pGZEtjMkZYVFENCnNzcjovL01UQTBMakU1TXk0eU1qWXVNVFl5T2pVd05Ua3lPbUYxZEdoZmMyaGhNVjkyTkRwaFpYTXRNVEk0TFdObVlqcDBiSE14TGpKZmRHbGphMlYwWDJGMWRHZzZUbXBSZUU0eVVUQk5ha0V2UDI5aVpuTndZWEpoYlQwbWNtVnRZWEpyY3owMldtMVJObGxEWmpaTVUyMDFXUzB6U1VoT2IxbFlTbXhKUkdzbVozSnZkWEE5VW01S2JGcFdUbFJWYVRGM1pGZEtjMkZYVFENCnNzcjovL05EY3VPRGd1TWpNd0xqSXdOVG8wTWpVMU1UcGhkWFJvWDJGbGN6RXlPRjl0WkRVNllXVnpMVEV5T0MxamRISTZkR3h6TVM0eVgzUnBZMnRsZEY5aGRYUm9PbUpzTUhkbFUxSjZWR3BOTHo5dlltWnpjR0Z5WVcwOUpuSmxiV0Z5YTNNOU5scHRVVFpaUTJZMlRGTnROVmt0TTBsSVRtOVpXRXBzU1VSRmR5Wm5jbTkxY0QxU2JrcHNXbFpPVkZWcE1YZGtWMHB6WVZkTg0Kc3NyOi8vTVRBekxqZzFMakU0Tnk0eE1UbzBORE02WVhWMGFGOWphR0ZwYmw5aE9tNXZibVU2ZEd4ek1TNHlYM1JwWTJ0bGRGOWhkWFJvT2xKdVNteGFWazVVVldjdlAyOWlabk53WVhKaGJUMVpNbmgyWkZkU2JXSkhSbmxhVXpWcVlqSXdKbkpsYldGeWEzTTlObHB0VVRaWlEyWTJURk50TlZrdE0wbElUbTlaV0Vwc1NVUkZlQ1puY205MWNEMVNia3BzV2xaT1ZGVnBNWGRrVjBwellWZE4NCg==');
//        $resl = explode("\n", $resl);
//
//        foreach ($resl as $ssr) {
//            $ssr='ssr://aGswNy5ub2RlLnRvdWhvdS53b3JsZDo4MDphdXRoX2FlczEyOF9tZDU6YWVzLTI1Ni1jZmI6aHR0cF9zaW1wbGU6YzNOdGRRLz9vYmZzcGFyYW09Wkc5M2JteHZZV1F1ZDJsdVpHOTNjM1Z3WkdGMFpTNWpiMjAmcHJvdG9wYXJhbT1Nall3T0RBNk9FdEJZMWsyJnJlbWFya3M9NmFhWjVyaXZJREEzSUVoTFZPV3V0dVd1dlNCSlVIW';
//            $init_ssr = trim($ssr);
//            if (empty($init_ssr)) {
//                continue;
//            }
//            $init_ssr = str_replace('_', '+', $init_ssr);
//            $ssr_info = explode('://', $init_ssr);
//            if (count($ssr_info) != 2) {
//                continue;
//            }
//            $ssr_info = base64_decode($ssr_info[1]);
//            $ssr_info = explode('/?', $ssr_info);
//            $val1 = explode(':', $ssr_info[0]);
//            $val2 = explode('&', str_replace('>', "", $ssr_info[1]));
//            if (!checkIp($val1[0]) && !checkHost($val1[0])) {
//                continue;
//            }
//            $val1[5] = str_replace('_', '+', $val1[5]);
//            $date = [
//                'address' => $val1[0],
//                'port' => $val1[1],
//                'password' => base64_decode($val1[5]),
//                'method' => $val1[3],
//                'protocol' => $val1[2],
//                'obfs' => $val1[4],
//                'ssrurl' => $ssr,
//                'updatetime' => time(),
//            ];
//            foreach ($val2 as $i) {
//                $ls = explode('=', $i);
//                switch ($ls[0]) {
//                    case 'obfsparam':
//                        $ls[1] = str_replace('_', '+', $ls[1]);
//                        $date['obfs_param'] = base64_decode($ls[1]);
//                        break;
//                    case 'protoparam':
//                        $ls[1] = str_replace('_', '+', $ls[1]);
//                        $date['protocol_param'] = base64_decode($ls[1]);
//                        break;
//                    case 'remarks':
//                        $ls[1] = str_replace('_', '+', $ls[1]);
//                        $date['remark'] = base64_decode($ls[1]);
//                        break;
//                    case 'group':
//                        $ls[1] = str_replace('_', '+', $ls[1]);
//                        $date['group'] = base64_decode($ls[1]);
//                        break;
//                }
//            }
//
//            $shareInfo = Config::get(['share_id' => $v['id'], 'address' => $val1[0], 'port' => $val1[1]]);
//            if ($shareInfo) {
//                Config::update($date, ['id' => $shareInfo['id']]);
//            } else {
//                $date['status'] = 0;
//                Config::create($date);
//            }
//
//        }
    }

    public function non_blocking_connect($host, $port, $timeout, &$errno, &$errstr)
    {
        define('EINPROGRESS', 115);
        $ip = gethostbyname($host);
        $s = socket_create(AF_INET, SOCK_STREAM, 0);
        if (socket_set_nonblock($s)) {
            $r = @socket_connect($s, $ip, $port);
            if ($r || socket_last_error() == EINPROGRESS) {
                $errno = EINPROGRESS;
                return $s;
            }
        }
        $errno = socket_last_error($s);
        $errstr = socket_strerror($errno);
        socket_close($s);
        return false;
    }
}
