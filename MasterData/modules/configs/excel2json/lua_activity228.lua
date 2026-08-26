-- chunkname: @modules/configs/excel2json/lua_activity228.lua

module("modules.configs.excel2json.lua_activity228", package.seeall)

local lua_activity228 = {}
local fields = {
	intensifyGuaranteeCount = 7,
	cost = 5,
	row = 2,
	reward = 4,
	finalReward = 9,
	column = 3,
	effectWeights = 8,
	intensifyRate = 6,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}

function lua_activity228.onLoad(json)
	lua_activity228.configList, lua_activity228.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity228
