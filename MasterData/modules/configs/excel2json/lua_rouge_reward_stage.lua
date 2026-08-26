-- chunkname: @modules/configs/excel2json/lua_rouge_reward_stage.lua

module("modules.configs.excel2json.lua_rouge_reward_stage", package.seeall)

local lua_rouge_reward_stage = {}
local fields = {
	jump = 8,
	name = 6,
	icon = 5,
	stage = 2,
	season = 1,
	openTime = 9,
	bigRewardId = 4,
	pointLimit = 10,
	preStage = 3,
	lockName = 7
}
local primaryKey = {
	"season",
	"stage"
}
local mlStringKey = {
	lockName = 2,
	name = 1
}

function lua_rouge_reward_stage.onLoad(json)
	lua_rouge_reward_stage.configList, lua_rouge_reward_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_reward_stage
