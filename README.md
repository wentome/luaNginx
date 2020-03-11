# luaNginx
## Build nginx with  lua support

https://github.com/openresty/lua-nginx-module/#nginx-api-for-lua

```
DIR=`pwd`
TARGET=/root/nginx
NGINX=$DIR/nginx-1.16.1
LUAJIT=$DIR/luajit
NGX_DEVEL_KIT=$DIR/ngx_devel_kit
LUA_NGINX_MODULE=$DIR/lua-nginx-module-0.10.15
LUA_RESTY_CORE=$DIR/lua-resty-core-0.1.17
LUA_RESTY_LRUCACHE=$DIR/lua-resty-lrucache 
```


## add nginx.conf
```
http{
    lua_package_path "/your_lib_dir/lua/?.lua;;";
}

server {
location /lua {
            content_by_lua_block {
            ngx.say("hello lua")
          }
        }
}     
```

