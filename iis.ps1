<#
# author: Escape
# add_time: 2018/08/30
# 安全配置策略基线检测脚本
#>

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
secedit /export /cfg config.cfg /quiet
$data = @{"project"=@()}



#检查是否已禁用IP转发功能
$Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters'

$name = "IPEnableRouter"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -eq "0"){
            $projectdata = @{"msg"="是否已禁用IP转发功能策略符合标准";}
            $data['project']+=$projectdata
        }
 else {
            $projectdata = @{"msg"="是否已禁用IP转发功能策略不符合标准";}
            $data['project']+=$projectdata
        }
		

#检查是否已删除或禁用无关账号
$config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "EnableGuestAccount "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "1")
        {
            $data.code = "1"
            $projectdata = @{"msg"="guest账户停用策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="guest账户停用策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
		
#是否已删除风险实例文件: c:\inetpub\scripts

if(Test-Path c:\inetpub\scripts){
        $projectdata = @{"msg"="删除风险实例文件c:\inetpub\scripts策略不符合标准";}
        $data['project']+=$projectdata
}
else{
        $projectdata = @{"msg"="删除风险实例文件c:\inetpub\scripts策略符合标准";}
        $data['project']+=$projectdata
}

#是否已删除风险实例文件: %systemroot%\system32\inetsrv\adminsamples
if(Test-Path %systemroot%\system32\inetsrv\adminsamples){
        $projectdata = @{"msg"="删除风险实例文件%systemroot%\system32\inetsrv\adminsamples策略不符合标准";}
        $data['project']+=$projectdata
}
else{
        $projectdata = @{"msg"="删除风险实例文件%systemroot%\system32\inetsrv\adminsamples策略符合标准";}
        $data['project']+=$projectdata
}

#是否已删除风险实例文件: %systemroot%\system32\inetsrv\iisadmpwd
if(Test-Path %systemroot%\system32\inetsrv\iisadmpwd){
        $projectdata = @{"msg"="删除风险实例文件%systemroot%\system32\inetsrv\iisadmpwd策略不符合标准";}
        $data['project']+=$projectdata
}
else{
        $projectdata = @{"msg"="删除风险实例文件%systemroot%\system32\inetsrv\iisadmpwd策略符合标准";}
        $data['project']+=$projectdata
}

#是否已删除风险实例文件: %systemroot%\system32\inetsrv\iisadmin
if(Test-Path %systemroot%\system32\inetsrv\iisadmin){
        $projectdata = @{"msg"="删除风险实例文件%systemroot%\system32\inetsrv\iisadmin策略不符合标准";}
        $data['project']+=$projectdata
}
else{
        $projectdata = @{"msg"="删除风险实例文件%systemroot%\system32\inetsrv\iisadmin策略符合标准";}
        $data['project']+=$projectdata
}

#是否已删除风险实例文件: c:\program files\common files\system\msadc\samples
if(Test-Path "c:\program files\common files\system\msadc\samples"){
        $projectdata = @{"msg"="删除风险实例文件c:\program files\common files\system\msadc\samples策略不符合标准";}
        $data['project']+=$projectdata
}
else{
        $projectdata = @{"msg"="删除风险实例文件c:\program files\common files\system\msadc\samples策略符合标准";}
        $data['project']+=$projectdata
}

#是否已删除风险实例文件: c:\program files\common files\system\msadc
if(Test-Path "c:\program files\common files\system\msadc"){
        $projectdata = @{"msg"="删除风险实例文件c:\program files\common files\system\msadc策略不符合标准";}
        $data['project']+=$projectdata
}
else{
        $projectdata = @{"msg"="删除风险实例文件c:\program files\common files\system\msadc策略符合标准";}
        $data['project']+=$projectdata
}

#结果输出到文件
$date = Get-Date
$date >>iisResult.txt
foreach ($i in $data.project){
    $result += "{'msg':$($i.msg)},"
	echo "{'msg':[$($i.msg)]}"
	$i.msg >>iisResult.txt
	
}	
