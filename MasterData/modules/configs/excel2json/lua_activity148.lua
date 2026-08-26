-- chunkname: @modules/configs/excel2json/lua_activity148.lua

module("modules.configs.excel2json.lua_activity148", package.seeall)

local lua_activity148 = {}
local fields = {
	skillSmallIcon = 8,
	skillId = 6,
	cost = 5,
	type = 3,
	skillAttrDesc = 9,
	attrs = 7,
	id = 1,
	activityId = 2,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	skillAttrDesc = 1
}

function lua_activity148.onLoad(json)
	lua_activity148.configList, lua_activity148.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity148
