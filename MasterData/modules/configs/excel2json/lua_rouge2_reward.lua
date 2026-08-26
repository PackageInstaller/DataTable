-- chunkname: @modules/configs/excel2json/lua_rouge2_reward.lua

module("modules.configs.excel2json.lua_rouge2_reward", package.seeall)

local lua_rouge2_reward = {}
local fields = {
	group = 6,
	rewardPriority = 9,
	value = 3,
	num = 5,
	maxBuyCount = 4,
	rewardImage = 8,
	id = 1,
	stage = 2,
	rewardScore = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_reward.onLoad(json)
	lua_rouge2_reward.configList, lua_rouge2_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_reward
