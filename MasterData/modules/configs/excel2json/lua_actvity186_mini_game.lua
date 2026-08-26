-- chunkname: @modules/configs/excel2json/lua_actvity186_mini_game.lua

module("modules.configs.excel2json.lua_actvity186_mini_game", package.seeall)

local lua_actvity186_mini_game = {}
local fields = {
	gameType2Prob = 6,
	expireSeconds = 7,
	triggerConditionParams = 4,
	triggerConditionType = 3,
	id = 2,
	activityId = 1,
	conditionStage = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_actvity186_mini_game.onLoad(json)
	lua_actvity186_mini_game.configList, lua_actvity186_mini_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity186_mini_game
