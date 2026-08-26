-- chunkname: @modules/configs/excel2json/lua_activity221.lua

module("modules.configs.excel2json.lua_activity221", package.seeall)

local lua_activity221 = {}
local fields = {
	summonTimes = 4,
	itemId = 2,
	constId = 6,
	heroExtraDesc = 7,
	initWeight = 3,
	doubleSixRate = 8,
	activityId = 1,
	poolId = 5
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity221.onLoad(json)
	lua_activity221.configList, lua_activity221.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity221
