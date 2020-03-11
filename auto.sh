DIR=`pwd`
TARGET=/root/nginx
NGINX=$DIR/nginx-1.16.1
LUAJIT=$DIR/luajit
NGX_DEVEL_KIT=$DIR/ngx_devel_kit
LUA_NGINX_MODULE=$DIR/lua-nginx-module-0.10.15
LUA_RESTY_CORE=$DIR/lua-resty-core-0.1.17
LUA_RESTY_LRUCACHE=$DIR/lua-resty-lrucache
ECHO_NGINX_MODULE=$DIR/echo-nginx-module-0.62rc1
rm -rf $TARGET
mkdir $TARGET

cd $LUAJIT
make &&  make install PREFIX=$TARGET

cd $NGINX

export LUAJIT_LIB=$TARGET/lib 
export LUAJIT_INC=$TARGET/include/luajit-2.1

./configure --prefix=$TARGET \
         --with-ld-opt="-Wl,-rpath,$TARGET/lib" \
	 --add-module=$NGX_DEVEL_KIT \
         --add-module=$LUA_NGINX_MODULE\
	 --add-module=$ECHO_NGINX_MODULE

make && make install

cd $LUA_RESTY_CORE
make install PREFIX=$TARGET
cd $LUA_RESTY_LRUCACHE
make install PREFIX=$TARGET

rm -rf $TARGET/include

mkdir $TARGET/conf/conf.d
cp $DIR/example $TARGET -rf
