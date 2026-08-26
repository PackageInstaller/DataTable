-- chunkname: @modules/configs/excel2json/lua_activity197.lua

module("modules.configs.excel2json.lua_activity197", package.seeall)

local lua_activity197 = {}
local fields = {
	rummageConsume = 2,
	doubleTimes = 6,
	exploreNum = 5,
	activityConsume = 7,
	exploreConsume = 3,
	exploreItem = 4,
	activityId = 1,
	consumeBonus = 8
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity197.onLoad(json)
	lua_activity197.configList, lua_activity197.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity197
