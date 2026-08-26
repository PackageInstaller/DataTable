-- chunkname: @modules/configs/excel2json/lua_handbook_skin_high.lua

module("modules.configs.excel2json.lua_handbook_skin_high", package.seeall)

local lua_handbook_skin_high = {}
local fields = {
	scenePath = 7,
	name = 2,
	order = 5,
	des = 6,
	show = 4,
	iconRes = 9,
	id = 1,
	nameRes = 8,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	des = 2,
	name = 1
}

function lua_handbook_skin_high.onLoad(json)
	lua_handbook_skin_high.configList, lua_handbook_skin_high.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_handbook_skin_high
