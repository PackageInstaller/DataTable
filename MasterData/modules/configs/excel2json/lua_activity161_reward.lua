-- chunkname: @modules/configs/excel2json/lua_activity161_reward.lua

module("modules.configs.excel2json.lua_activity161_reward", package.seeall)

local lua_activity161_reward = {}
local fields = {
	rewardId = 3,
	bonus = 4,
	activityId = 1,
	paintedNum = 2
}
local primaryKey = {
	"activityId",
	"paintedNum"
}
local mlStringKey = {}

function lua_activity161_reward.onLoad(json)
	lua_activity161_reward.configList, lua_activity161_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity161_reward
