-- chunkname: @modules/configs/excel2json/lua_rouge_reward.lua

module("modules.configs.excel2json.lua_rouge_reward", package.seeall)

local lua_rouge_reward = {}
local fields = {
	stage = 4,
	value = 6,
	preId = 3,
	type = 7,
	season = 1,
	offset = 11,
	pos = 5,
	rewardName = 9,
	rewardType = 10,
	id = 2,
	icon = 8
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	rewardName = 1
}

function lua_rouge_reward.onLoad(json)
	lua_rouge_reward.configList, lua_rouge_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_reward
