-- chunkname: @modules/configs/excel2json/lua_activity101_springsign.lua

module("modules.configs.excel2json.lua_activity101_springsign", package.seeall)

local lua_activity101_springsign = {}
local fields = {
	goodDesc = 6,
	name = 3,
	simpleDesc = 4,
	detailDesc = 5,
	badDesc = 7,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {
	goodDesc = 4,
	name = 1,
	simpleDesc = 2,
	detailDesc = 3,
	badDesc = 5
}

function lua_activity101_springsign.onLoad(json)
	lua_activity101_springsign.configList, lua_activity101_springsign.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity101_springsign
