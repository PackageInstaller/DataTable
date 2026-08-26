-- chunkname: @modules/logic/gm/gaosiniao/reverse_define.lua

local rawset = _G.rawset
local assert = _G.assert
local sf = string.format

local function _split(s, delimiter)
	return string.split(s, delimiter) or {}
end

local function _make_tables(name, value, root)
	local list = _split(name, ".")
	local res = root or _G

	for i, key in ipairs(list) do
		if i == #list and value ~= nil then
			rawset(res, key, value)
		else
			rawset(res, key, res[key] or {})
		end

		res = res[key]
	end

	return res
end

local function _rname(user_define_name)
	assert(type(user_define_name) == "string")

	return sf("_r.%s", user_define_name)
end

local function _transfer(src_define_tbl, declare_name)
	local list = _split(declare_name, ".")
	local n = #list
	local res = src_define_tbl

	for _, key in ipairs(list) do
		res = res[key]

		if not res then
			break
		end

		n = n - 1
	end

	local ok = n == 0 and res

	return ok, res
end

return function(src_define_tbl, member_name)
	local rname = _rname(member_name)
	local ok, dst_tbl = _transfer(src_define_tbl, rname)

	if ok then
		return dst_tbl
	end

	local ok2, src_tbl = _transfer(src_define_tbl, member_name)

	assert(ok2, sf("can not found define.%s", member_name))

	dst_tbl = _make_tables(rname, nil, src_define_tbl)

	local check_same_value = {}

	for k, v in pairs(src_tbl) do
		dst_tbl[v] = k

		assert(not check_same_value[v], sf("%s: can not set same value when use RD, conflict between %s and %s", rname, v, k))

		check_same_value[v] = k
	end

	return dst_tbl
end
