# corona-watch
monitoring the german corona-warn-app server data

1) git submodule init
2) git submodule update
3) install the following lua packages (e.g. via luarocks): cjson, lua-protobuf
 
* app_config.lua fetches the most recent app config from server and compares against previously fetched config
* diagnosis_keys.lua is still WIP - no keys on the server yet
