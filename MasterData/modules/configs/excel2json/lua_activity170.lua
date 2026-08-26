-- chunkname: @modules/configs/excel2json/lua_activity170.lua

module("modules.configs.excel2json.lua_activity170", package.seeall)

local lua_activity170 = {}
local fields = {
	summonTimes = 4,
	itemId = 2,
	constId = 6,
	heroExtraDesc = 7,
	initWeight = 3,
	activityId = 1,
	poolId = 5
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity170.onLoad(json)
	lua_activity170.configList, lua_activity170.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity170
