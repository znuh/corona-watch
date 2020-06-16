
function load_file(fn,mode)
	local fh = io.open(fn,mode)
	if not fh then return end
	local res = fh:read("*all")
	fh:close()
	return res
end

function save_file(fn,data,mode)
	local fh = io.open(fn,mode or "w")
	fh:write(data)
	fh:close()
end

function table_tostring(tbl,pre)
	local buf = ""
	local function tbl_helper(t, prefix)
		local k,v
		if prefix == nil then prefix = " " end
		-- sort keys first
		local keys = {}
		for k,_ in pairs(t) do
			table.insert(keys, k)
		end
		table.sort(keys)
		for i=1,#keys do
			local k = keys[i]
			local v = t[k]
			if type(v) == "table" then tbl_helper(v," "..prefix..k..".")
			else buf = buf .. prefix..k.."= "..v.."\n" end
		end
	end
	tbl_helper(tbl, pre)
	return buf
end

function dump_table(t,prefix)
	print(table_tostring(t,prefix))
end

function protobuf_decode(data, schema, name)
	-- required: https://github.com/starwing/lua-protobuf
	local pb = require "pb"
	local protoc = require "protoc"
	assert(protoc:load(load_file("cwa-app-android/Server-Protocol-Buffer/src/main/proto/"..schema..".proto")))
	local decoded = assert(pb.decode(name, data))
	return decoded
end
