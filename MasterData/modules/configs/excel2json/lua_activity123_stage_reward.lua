-- chunkname: @modules/configs/excel2json/lua_activity123_stage_reward.lua

module("modules.configs.excel2json.lua_activity123_stage_reward", package.seeall)

local lua_activity123_stage_reward = {}
local fields = {
	stageId = 3,
	star = 4,
	keyReward = 7,
	bonusId = 2,
	bonusIcon = 5,
	activityId = 1,
	bonus = 6
}
local primaryKey = {
	"activityId",
	"bonusId"
}
local mlStringKey = {}

function lua_activity123_stage_reward.onLoad(json)
	lua_activity123_stage_reward.configList, lua_activity123_stage_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_stage_reward
