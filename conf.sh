DIR=`pwd`
TARGET=$DIR/nginx
NGINX=$DIR/nginx-1.16.1
LUAJIT=$DIR/luajit
NGX_DEVEL_KIT=$DIR/ngx_devel_kit
LUA_NGINX_MODULE=$DIR/lua-nginx-module-0.10.15
LUA_RESTY_CORE=$DIR/lua-resty-core-0.1.17
LUA_RESTY_LRUCACHE=$DIR/lua-resty-lrucache

cd $LUAJIT
make uninstall PREFIX=$LUAJIT
make &&  make install PREFIX=$LUAJIT


cd $NGINX

export LUAJIT_LIB=$LUAJIT/lib 
export LUAJIT_INC=$LUAJIT/include/luajit-2.1

rm $TARGET -rf
./configure --prefix=$TARGET \
         --with-ld-opt="-Wl,-rpath,$LUAJIT/lib" \
	 --add-module=$NGX_DEVEL_KIT \
         --add-module=$LUA_NGINX_MODULE

make && make install

mkdir $TARGET/lib
cd $LUA_RESTY_CORE
make install PREFIX=$TARGET
cd $LUA_RESTY_LRUCACHE
make install PREFIX=$TARGET

