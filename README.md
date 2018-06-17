
## 环境变量说明
> NEW_REGISTER 强制进行重新注册（true or false）  
> REGISTER_CONF_FILE 设置 config.toml 模板文件的路径  

如果要启动 REGISTER_CONF_FILE，则要先把模板映射进来，如：  
> volumeMounts:  
>   \- mountPath: /tmp/config.toml  
>     name: config  
>     subPath: config.toml  

