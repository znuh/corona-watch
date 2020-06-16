#!/bin/lua

local https = require 'ssl.https'
local lfs = require "lfs"
local cjson = require "cjson"
require "utils"

function load_last_appconfig()
	local ts = load_file("app_config/last_update")
	if not ts then return end
	return load_file("app_config/"..ts..".bin"), ts
end

function save_appconfig(now, config)
	-- save binary config
	lfs.mkdir("app_config")
	os.execute("mv tmp/export.bin app_config/"..now..".bin")

	-- update last timestamp
	save_file("app_config/last_update", now)

	-- save text config
	save_file("app_config/"..now..".txt", table_tostring(config))
	
	-- save json config
	save_file("app_config/"..now..".json", cjson.encode(config))
end

function update_appconfig()
	local last_config, last_ts = load_last_appconfig()
	
	lfs.mkdir("tmp")
	os.execute("rm -f tmp/*") -- *couch, cough*
	
	local body, code, headers = https.request("https://svc90.main.px.t-online.de/version/v1/configuration/country/DE/app_config")
	local now = os.time()
	assert(code == 200)
	save_file("tmp/app_config.zip",body,"wb")
	
	os.execute("cd tmp && unzip -q app_config.zip")
	
	local bin_cfg = load_file("tmp/export.bin","rb")
	local config = protobuf_decode(bin_cfg, "applicationConfiguration", ".de.rki.coronawarnapp.server.protocols.ApplicationConfiguration")
	
	if last_config == bin_cfg then
		print("config unchanged")
	else
		save_appconfig(now, config)
		
		if last_ts then
			-- show diff if previous config available
			os.execute("diff app_config/"..last_ts..".txt app_config/"..now..".txt")
		end
	end
	
	os.execute("rm -f tmp/*") -- *couch, cough*
	
	return config
end

update_appconfig()
