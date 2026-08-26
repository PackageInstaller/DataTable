-- chunkname: @modules/configs/excel2json/lua_actvity205_mini_game_reward.lua

module("modules.configs.excel2json.lua_actvity205_mini_game_reward", package.seeall)

local lua_actvity205_mini_game_reward = {}
local fields = {
	isWin = 4,
	rewardId = 2,
	rewardDesc = 5,
	type = 1,
	bonus = 3
}
local primaryKey = {
	"type",
	"rewardId"
}
local mlStringKey = {
	rewardDesc = 1
}

function lua_actvity205_mini_game_reward.onLoad(json)
	lua_actvity205_mini_game_reward.configList, lua_actvity205_mini_game_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity205_mini_game_reward
