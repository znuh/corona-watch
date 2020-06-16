#!/bin/lua

local https = require 'ssl.https'
local lfs = require "lfs"
local cjson = require "cjson"
require "utils"

-- see cwa-server/services/distribution/api_v1.json

function load_keys()
	local body, code, headers = https.request("https://svc90.main.px.t-online.de/version/v1/diagnosis-keys/country/DE/date")
	assert(code == 200)
	print("dates:",body)
	local dates = cjson.decode(body)
	dump_table(dates)
	-- TBD
	-- paths: date/{date} date/{date}/hour date/{date}/hour/{hour}
	-- protobuf def file: keyExportFormat
	-- message: .de.rki.coronawarnapp.server.protocols.TemporaryExposureKeyExport
end

load_keys()
