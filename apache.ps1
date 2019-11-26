<#
# author: Escape
# add_time: 2018/08/29
# 安全配置策略基线检测脚本
# 代码中两个$path需要手动定义
#>

$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$path = "D:\phpStudy\PHPTutorial\Apache\conf\httpd.conf"
$data = @{"project"=@()}
$config = Get-Content -path $path  

#apache错误重定向界面

for ($i=0; $i -lt $config.Length; $i++)
 {
     
     $pattern = "^ErrorDocument"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="apache错误重定向界面为：$($config[$i])"};
         $data['project']+=$projectdata
		 $flag = 1
	 }    
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="不存在Apache错误页面重定向"};
		 $data['project']+=$projectdata
	 }
 
#是否禁止Apache列表显示文件
 
for ($i=0; $i -lt $config.Length; $i++)
 {
     
     $pattern = "-Indexes"
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="禁止Apache列表显示文件策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="禁止Apache列表显示文件策略不符合标准"};
		 $data['project']+=$projectdata
	 }
 
#是否隐藏Apache的版本号及其它敏感信息

for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^ServerTokens Prod"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="隐藏Apache的版本号及其它敏感信息策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="隐藏Apache的版本号及其它敏感信息策略不符合标准"};
		 $data['project']+=$projectdata
	 }
	 

#检查http请求的信息主体大小限制

for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^LimitRequestBody 102400"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="http请求的信息主体大小限制策略符合标准)"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="http请求的信息主体大小限制策略不符合标准"};
		 $data['project']+=$projectdata
	 }
 
<#  
检查http请求的信息主体大小限制是否启用（重复,冲突）
for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "LimitRequestBody 102400"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="http请求的信息主体大小限制是否启用策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="http请求的信息主体大小限制是否启用策略不符合标准"};
		 $data['project']+=$projectdata
	 } #>

#检查是否启用http持久链接
for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^KeepAlive On"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="是否启用http持久链接策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="是否启用http持久链接策略不符合标准"};
		 $data['project']+=$projectdata
}

#检查对http请求进行缓冲是否配置安全
for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^AcceptFilter http data"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="对http请求进行缓冲是否配置安全策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="对http请求进行缓冲是否配置安全不符合标准"};
		 $data['project']+=$projectdata
}	 

#检查对https请求进行缓冲是否配置安全
for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^AcceptFilter https data"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="对https请求进行缓冲是否配置安全策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="对https请求进行缓冲是否配置安全不符合标准"};
		 $data['project']+=$projectdata
}	

#检查是否禁用cgi
	

for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^LoadModule cgi_module modules/mod_cgi.so"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="禁用cgi策略不符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="禁用cgi策略符合标准"};
		 $data['project']+=$projectdata
}

#检查是否支持HTTPS
for ($i=0; $i -lt $config.Length; $i++)
 {
 
	 $pattern = "^LoadModule ssl_module modules/mod_ssl.so"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="是否支持HTTPS策略符合标准)"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="是否支持HTTPS策略不符合标准"};
		 $data['project']+=$projectdata
}	
 
 #检查是否禁用PUT、DELETE等危险的http方法
 
 for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^<LimitExcept GET POST> Deny from all </LimitExcept>"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="是否禁用PUT、DELETE等危险的http方法策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="是否禁用PUT、DELETE等危险的http方法策略不符合标准"};
		 $data['project']+=$projectdata
}

#检查是否开启Apache错误日志
 for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^ErrorLog logs/error_log"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="开启Apache错误日志策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
      
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="是否开启Apache错误日志策略不符合标准"};
		 $data['project']+=$projectdata
}

#检查是否开启Apache访问日志
 for ($i=0; $i -lt $config.Length; $i++)
 {
     $flag = 0	 
	 $pattern = "^CustomLog log/access_log combined"
     $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="开启Apache访问日志策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="开启Apache访问日志策略不符合标准"};
		 $data['project']+=$projectdata
}

#检查是否设置日志记录格式
 for ($i=0; $i -lt $config.Length; $i++)
 {
      
	 $pattern = "^LogFormat"
     $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="日志记录格式为$($config[$i]),请检查是否符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 
	 }
     
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="未设置日志记录格式"};
		 $data['project']+=$projectdata
}


#检查是否删除缺省安装的无用文件
#在此处修改$path参数为apache安装目录
$path = "D:\phpStudy\PHPTutorial\Apache\*"        
if(-not (Test-Path $path -include htdocs,cgi-bin,manual)){
    $projectdata = @{"msg"="是否删除缺省安装的无用文件策略符合标准"};
    $data['project']+=$projectdata
}
else{
    $projectdata = @{"msg"="是否删除缺省安装的无用文件策略不符合标准"};
    $data['project']+=$projectdata
}
#检查是否禁止Apache访问Web目录之外的任何文件
 for ($i=0; $i -lt $config.Length; $i++)
 {
	 $pattern = "^<Directory />Order Deny,Allow Deny from all</Directory>"
	 $config[$i] = $config[$i].Trim(' ')
     if ($config[$i] -match $pattern){
	     $projectdata = @{"msg"="是否禁用PUT、DELETE等危险的http方法策略符合标准"};
         $data['project']+=$projectdata
		 $flag = 1
		 break
	 }
     $flag = 0	 
}
if($flag -ne "1"){
	     $projectdata = @{"msg"="是否禁用PUT、DELETE等危险的http方法策略不符合标准"};
		 $data['project']+=$projectdata
}

#结果处理
$date = Get-Date
$date >>apacheResult.txt

foreach ($i in $data.project){
   # $result += "{'msg':$($(i-1).msg)},"
	echo "{'msg':[$($i.msg)]}"
	$i.msg >>apacheResult.txt
	
}
