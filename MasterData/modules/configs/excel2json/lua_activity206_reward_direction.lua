-- chunkname: @modules/configs/excel2json/lua_activity206_reward_direction.lua

module("modules.configs.excel2json.lua_activity206_reward_direction", package.seeall)

local lua_activity206_reward_direction = {}
local fields = {
	activityId = 1,
	name = 9,
	guaranteeCount = 6,
	pic = 10,
	nextDayDecRate = 4,
	haveGuarantee = 5,
	rewardGroupId = 7,
	baseRate = 3,
	directionId = 2,
	des = 8
}
local primaryKey = {
	"activityId",
	"directionId"
}
local mlStringKey = {
	name = 2,
	des = 1
}

function lua_activity206_reward_direction.onLoad(json)
	lua_activity206_reward_direction.configList, lua_activity206_reward_direction.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity206_reward_direction
