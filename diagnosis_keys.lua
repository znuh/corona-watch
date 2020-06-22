#!/bin/lua

local https = require 'ssl.https'
local lfs = require "lfs"
local cjson = require "cjson"
require "utils"

-- see cwa-server/services/distribution/api_v1.json

-- paths: date/{date} date/{date}/hour date/{date}/hour/{hour}
-- protobuf def file: keyExportFormat
-- message: .de.rki.coronawarnapp.server.protocols.TemporaryExposureKeyExport

local base_path = "https://svc90.main.px.t-online.de/version/v1/diagnosis-keys/country/DE"

function fetch_data(rel_path)
	local rp = rel_path or ""
	local body, code, headers = https.request(base_path..rel_path)
	assert(code == 200)
	return body
end

function fetch_list(rel_path)
	-- get list
	local body = fetch_data(rel_path)
	print(rel_path..":",body)
	return cjson.decode(body)	
end

function load_keyfile(rel_path)
	-- TODO: check if keyfile already present
	
	lfs.mkdir("tmp")
	os.execute("rm -f tmp/*") -- *couch, cough*
	
	local body = fetch_data(rel_path)
	save_file("tmp/diagnosis_keys.zip",body,"wb")
	
	os.execute("cd tmp && unzip -q diagnosis_keys.zip")
	
	local bin_cfg = load_file("tmp/export.bin","rb")
	local keys = protobuf_decode(bin_cfg, "keyExportFormat", ".de.rki.coronawarnapp.server.protocols.TemporaryExposureKeyExport")
	
	-- TODO: compare & save keyfile
	
	os.execute("rm -f tmp/*") -- *couch, cough*
	
	return keys
end

function load_keys()
	local dates_path = "/date"
	-- fetch list of dates first
	local dates = fetch_list(dates_path)
	dump_table(dates)
	
	-- iterate through dates
	for _,day in pairs(dates) do
		local date_path = dates_path.."/"..day
		-- fetch keyfile for day
		local daykeys = load_keyfile(date_path)
		print(date_path..":")
		dump_table(daykeys)
		
		-- fetch hours list for day
		local hours_path = date_path.."/hour"
		local hours = fetch_list(hours_path)
		dump_table(hours)
		-- iterate through hours
		for _,hour in pairs(hours) do
			local hour_path = hours_path.."/"..hour
			-- fetch keyfile for hour
			local hour_keys = load_keyfile(hour_path)
			print(hour_path..":")
			dump_table(hour_keys)
		end
		
	end
end

load_keys()
