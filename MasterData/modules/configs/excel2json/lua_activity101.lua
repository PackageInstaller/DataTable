-- chunkname: @modules/configs/excel2json/lua_activity101.lua

module("modules.configs.excel2json.lua_activity101", package.seeall)

local lua_activity101 = {}
local fields = {
	isnotPush = 4,
	sourceid = 5,
	v2Bonus = 6,
	clientDisplayTxt = 8,
	id = 2,
	clientDisplayType = 7,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_activity101.onLoad(json)
	lua_activity101.configList, lua_activity101.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity101
