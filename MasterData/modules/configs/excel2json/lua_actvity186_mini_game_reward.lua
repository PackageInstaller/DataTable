-- chunkname: @modules/configs/excel2json/lua_actvity186_mini_game_reward.lua

module("modules.configs.excel2json.lua_actvity186_mini_game_reward", package.seeall)

local lua_actvity186_mini_game_reward = {}
local fields = {
	rewardId = 2,
	blessingdes = 6,
	type = 1,
	blessingtitle = 5,
	prob = 3,
	bonus = 4
}
local primaryKey = {
	"type",
	"rewardId"
}
local mlStringKey = {
	blessingtitle = 1,
	blessingdes = 2
}

function lua_actvity186_mini_game_reward.onLoad(json)
	lua_actvity186_mini_game_reward.configList, lua_actvity186_mini_game_reward.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity186_mini_game_reward
