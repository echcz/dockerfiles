# docker-builds

自定义的 Docker 镜像

## 特性

* 时区设置为中国上海(Asia/Shanghai)
* 使用 UTF-8 编码(C.UTF-8)
* docker 启动时，动态加载 `docker-entrypoint.d` 里的脚本文件(`.sh`将会执行，`.envsh`将会`source`)（加载顺序为文件名升序(`sort -V`)，推荐以 `%d%d-` 为前缀命名文件）
  * [05-fileenv.envsh](./docker-entrypoint.d/05-fileenv.envsh): 对于名称前缀为 `X_FILEENV_` 的环境变量，读取其值指向的文件的内容，设为 去掉前缀后的环境变量 的值。如 `X_FILEENV_HOSTS=/etc/hosts`，则 `HOSTS=$(cat /etc/hosts)`

## 使用

### for Linux

一键生成所有自定义 Docker 镜像：

``` shell
ls | grep '^Dockerfile' | awk -F . {'print "docker build -f " $0 " -t echcz/" $2 ":" $3 " ."'} | sh
```

一键推送所有自定义镜像到镜像仓库：

``` powershell
docker image ls --format "{{.Repository}}:{{.Tag}}" | grep '^echcz/' | sed s'|\(.*\)|docker push \1|' | sh
```

### for Windows

一键生成所有自定义 Docker 镜像：

``` powershell
Get-ChildItem -Name . | findstr -b Dockerfile | %{$f=$_;$a=$f.split('.');'echcz/'+$a[1]+':'+$a[2]} | %{docker build -f $f -t $_ .}
```

一键推送所有自定义镜像到镜像仓库：

``` powershell
docker image ls --format "{{.Repository}}:{{.Tag}}" | findstr -b 'echcz/' | %{docker push $_}
```
