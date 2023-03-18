# JWT 测试

在网站 [https://mkjwk.org/](https://mkjwk.org/) 生成秘钥 和 jwks

[查看示例图片](https://img.alicdn.com/imgextra/i2/O1CN01whe2lQ1du9t7NShNp_!!6000000003795-0-tps-1448-1488.jpg)


### 下载压缩包

复制自己的秘钥到

`Resources/JWTSigners/rsaPrivateKey.txt`

复制自己的 jwks 到

`Resources/JWTSigners/jwks.json`

创建 `JWT Token`

```
curl http://127.0.0.1:8080/api/jwt/sign
```

验证 `JWT Token`

```
curl 'http://127.0.0.1:8080/api/jwt/verify' \
--header 'Authorization: Bearer eyxxxx'
```

## 阿里云函数部署

- 下载压缩包，上传

- 配置启动命令

```
./scf_bootstrap
```
