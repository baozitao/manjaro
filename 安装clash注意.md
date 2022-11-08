
1.用订阅连接放在浏览器里，下载config.yaml文件，要注意config.yaml文件的
2.修改config.yaml的allow lan为true
3.下载docker
```
yay -S docker
su 

## 运行clash
docker run -d --name=clash -v $PWD/config.yaml:~/.config/clash/config.yaml -p 7890:7890 -p 7891:7891 -p 9090:9090 --restart=unless-stopped dreamacro/clash

## 运行面板
docker run -p 1234:80 -d --name yacd --restart=unless-stopped haishanh/yacd

```
4.登陆http://127.0.0.1:1234/，设置网络节点。
5.设置/etc/profile代理即可
```
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
```