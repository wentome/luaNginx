# luaNginx
Build nginx with  lua support

add nginx.conf
```
http{
    lua_package_path "/your_lib_dir/lua/?.lua;;";
}
```

