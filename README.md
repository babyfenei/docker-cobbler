# Cobbler 批量装机

> 这是一个运行在docker里的cobbler平台。

### 文件说明

构建cobbler镜像的Dockerfile文件：

```yaml
- Dockerfile
- start.sh
```
运行cobbler容器的compose文件：
```YAML
- docker-compose.yml
- cobbler.env
```
修改cobbler.env中相关IP地址变量及默认root密码
### 下载并解压镜像到/mnt（此步骤可省略）
```
wget https://mirrors.aliyun.com/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso && mount CentOS-7-x86_64-Minimal-2003.iso  /mnt && ls /mnt
```

### 运行docker
```bash
docker-compose up -d --build
```
使用logs查看docker输出日志
```bash
docker logs -f docker-cobbler_cobbler_1
```
> 如果在 cobbler get-loader报错,多重启几次容器直至容器成功运行
```bash
docker restart docker-cobbler_cobbler_1
```
docker logs
```bash?linenums
2020-08-27 05:34:18,525 INFO success: httpd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2020-08-27 05:34:18,525 INFO success: cobblerd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2020-08-27 05:34:18,526 INFO success: tftpd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2020-08-27 05:34:18,526 INFO success: dhcpd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```

### 挂载镜像
挂载镜像后需要重启容器才可以在容器内挂载
```bash?linenums
wget https://mirrors.aliyun.com/centos/7.8.2003/isos/x86_64/CentOS-7-x86_64-Minimal-2003.iso && mount CentOS-7-x86_64-Minimal-2003.iso  /mnt && ls /mnt
docker restart docker-cobbler_cobbler_1
docker exec -it docker-cobbler_cobbler_1 cobbler import --name=CentOS-7-x86_64-Minimal-2003 --path=/mnt
docker exec -it docker-cobbler_cobbler_1 cobbler sync
```
### Cobbler_web访问
https://url/cobbler_web
用户名：cobbler
密码：    cobbler
