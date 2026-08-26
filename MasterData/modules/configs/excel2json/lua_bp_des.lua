-- chunkname: @modules/configs/excel2json/lua_bp_des.lua

module("modules.configs.excel2json.lua_bp_des", package.seeall)

local lua_bp_des = {}
local fields = {
	tagType = 6,
	iconType = 4,
	iconDesc = 10,
	type = 3,
	des = 9,
	items = 5,
	bpId = 2,
	id = 1,
	icon = 8,
	tagTxt = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	iconDesc = 2,
	des = 1
}

function lua_bp_des.onLoad(json)
	lua_bp_des.configList, lua_bp_des.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp_des
