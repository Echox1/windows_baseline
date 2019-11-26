<#
# author: Escape
# add_time: 2018/08/27
# 安全配置策略基线检测脚本
#>
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$data = @{"project"=@()}
secedit /export /cfg config.cfg /quiet

#账户检查
$config = Get-WmiObject -Class Win32_UserAccount
$projectdata = @{"msg"="当前账户为：$($config)";}
$data['project']+=$projectdata

			

#guest停用策略

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
  
  #guest重命名策略

$config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "NewGuestName "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "Guest")
        {
            $data.code = "1"
            $projectdata = @{"msg"="guest账户重命名策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="guest账户重命名策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
 
 #密码复杂性策略
 $config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "PasswordComplexity "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "1")
        {
            $data.code = "1"
            $projectdata = @{"msg"="密码复杂性策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="密码复杂性策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
 
 #密码长度最小值策略
 $config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "MinimumPasswordLength "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -ge "8")
        {
            $data.code = "1"
            $projectdata = @{"msg"="密码最小值策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="密码最小值策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  #密码最长使用期限策略
  
   $config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "MaximumPasswordAge "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -le "90")
        {
            $data.code = "1"
            $projectdata = @{"msg"="密码最长使用期限策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="密码最长使用期限策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  #账户锁定阀值策略
  
   $config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "LockoutBadCount "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -le "5")
        {
            $data.code = "1"
            $projectdata = @{"msg"="账户锁定阀值策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="账户锁定阀值策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  
 #账户锁定时间策略
  
   $config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "ResetLockoutCount "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -ge "10")
        {
            $data.code = "1"
            $projectdata = @{"msg"="账户锁定时间策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="账户锁定时间策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }

 #关闭系统仅Administrator策略
  $config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "ResetLockoutCount "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -ge "10")
        {
            $data.code = "1"
            $projectdata = @{"msg"="账户锁定时间策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="账户锁定时间策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
 
#操作系统远程关机策略安全


$config = Get-Content -path config.cfg

 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "SeRemoteShutdownPrivilege "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "*S-1-5-32-544")
        {
            $data.code = "1"
            $projectdata = @{"msg"="操作系统远程关机策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="操作系统远程关机策略不符合标准";
                             }
            $data['project']+=$projectdata
        }
    }
  }

  #操作系统本地关机策略安全

  $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "SeShutdownPrivilege "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "*S-1-5-32-544")
        {
            $data.code = "1"
            $projectdata = @{"msg"="操作系统本地关机策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="操作系统本地关机策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
    #取得文件或其他对象的所有权限策略
  $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "SeProfileSingleProcessPrivilege "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "*S-1-5-32-544")
        {
            $data.code = "1"
            $projectdata = @{"msg"="取得文件或其他对象的所有权限策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="取得文件或其他对象的所有权限策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  #从网络访问此计算机策略
  $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "SeNetworkLogonRight "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "*S-1-5-32-544,*S-1-5-32-545,*S-1-5-32-551")
        {
            $data.code = "1"
            $projectdata = @{"msg"="从网络访问此计算机策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="从网络访问此计算机策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
 #审核策略更改

 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditSystemEvents "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "3")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核策略更改策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核策略更改策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  
  #审核登录事件

 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditLogonEvents "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "3")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核登录事件策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核登录事件不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
    #审核对象访问

 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditObjectAccess "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "3")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核对象访问策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核对象访问不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  
  #审核进程跟踪

 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditProcessTracking "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "2")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核进程跟踪策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核进程跟踪策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
    #审核目录服务访问

 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditDSAccess "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "3")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核目录服务访问策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核目录服务访问策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  
  #审核特权使用
 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditPrivilegeUse "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "3")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核特权使用策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核特权使用策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
  }
  
    #审核系统事件
 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditSystemEvents "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "3")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核系统事件策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核系统事件策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
}
	
	 #审核账户登录事件
 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditAccountLogon "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "2")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核账户登录事件策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核账户登录事件策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
}
  
  
  	 #审核账户管理
 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "AuditAccountManage "))
    {
        $config_line[1] = $config_line[1].Trim(' ')
        if($config_line[1] -eq "2")
        {
            $data.code = "1"
            $projectdata = @{"msg"="审核账户管理策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="审核账户管理策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
}
#暂停会话前所需的空闲时间
 $config = Get-Content -path config.cfg
 for ($i=0; $i -lt $config.Length; $i++)
 {
    $config_line = $config[$i] -split "="
    if(($config_line[0] -eq "MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters\AutoDisconnect"))
    {
	    $config_line = $config_line[1]
	    $config_line = $config[$i] -split ","
        
        if($config_line[1] -le "30")
        {
            $data.code = "1"
            $projectdata = @{"msg"="暂停会话前所需的空闲时间策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="暂停会话前所需的空闲时间策略不符合标准";}
            $data['project']+=$projectdata
        }
    }
}
#检测防护软件
#无防护软件标准,最好使用人工查询

#是否启用NTP服务同步时钟
$Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer'
$Name = 'Enabled'
 $config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$Name
   if($config -eq "1")
        {
            $data.code = "1"
            $projectdata = @{"msg"="启用NTP服务同步时钟策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="启用NTP服务同步时钟策略不符合标准";}
            $data['project']+=$projectdata
        }

#检测开机启动项
$Key = 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run'
$result = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop)
$projectdata = @{"msg"="开机启动项为：$($result)";}
 $data['project']+=$projectdata

 #检查关闭默认共享盘

 $Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa'
 $Name = 'restrictanonymous'
 $config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$Name
   if($config -eq "1")
        {
            $data.code = "1"
            $projectdata = @{"msg"="关闭默认共享盘策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="关闭默认共享盘策略不符合标准";}
            $data['project']+=$projectdata
        }
		
#禁止全部驱动器自动播放
 $Key = 'HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
 $name = "NoDriveTypeAutoRun"
 $config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
   if($config -eq "255")
        {
            $data.code = "1"
            $projectdata = @{"msg"="禁止全部驱动器自动播放符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="禁止全部驱动器自动播放不符合标准";}
            $data['project']+=$projectdata
        }
		
#应用日志查看器大小设置
$Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Application'

$name = "MaxSize"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -ge "8192")
        {
            $data.code = "1"
            $projectdata = @{"msg"="应用日志查看器大小设置策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="应用日志查看器大小设置策略不符合标准";}
            $data['project']+=$projectdata
        }
		
#系统日志查看器大小设置
$Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\System'

$name = "MaxSize"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -ge "8192")
        {
            $data.code = "1"
            $projectdata = @{"msg"="系统日志查看器大小设置策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="系统日志查看器大小设置策略不符合标准";}
            $data['project']+=$projectdata
        }
#安全日志查看器大小设置
$Key = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Security'
$name = "MaxSize"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -ge "8192")
        {
            $data.code = "1"
            $projectdata = @{"msg"="安全日志查看器大小设置策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="安全日志查看器大小设置策略不符合标准";}
            $data['project']+=$projectdata
        }

#屏幕自动保护程序
$Key = 'HKEY_CURRENT_USER\Control Panel\Desktop'
$name = "ScreenSaveActive"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -eq "1")
        {
            $data.code = "1"
            $projectdata = @{"msg"="屏幕自动保护程序策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="屏幕自动保护程序策略不符合标准";}
            $data['project']+=$projectdata
        }

#屏幕保护程序启动时间
$Key = 'HKEY_CURRENT_USER\Control Panel\Desktop'
$name = "ScreenSaveTimeOut"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -le "600")
        {
            $data.code = "1"
            $projectdata = @{"msg"="屏幕保护程序启动时间策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="屏幕保护程序启动时间策略不符合标准";}
            $data['project']+=$projectdata
        }

#屏幕恢复时使用密码保护
$Key = 'HKEY_CURRENT_USER\Control Panel\Desktop'
$name = "ScreenSaveTimeOut"
$config = (Get-ItemProperty -Path "Registry::$Key" -ErrorAction Stop).$name
if($config -ge "1")
        {
            $data.code = "1"
            $projectdata = @{"msg"="屏幕恢复时使用密码保护策略符合标准";}
            $data['project']+=$projectdata
        }
        else
        {
            $data.code = "0"
            $projectdata = @{"msg"="屏幕恢复时使用密码保护策略不符合标准";}
            $data['project']+=$projectdata
        }
#结果处理
$date = Get-Date
$date >>windowsResult.txt

#$result = ""
foreach ($i in $data.project){
    #$result += "{'msg':$($i.msg)},"
	echo "{'msg':[$($i.msg)]}"
	$i.msg >>windowsResult.txt
	
}



