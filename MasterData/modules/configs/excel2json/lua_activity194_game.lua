-- chunkname: @modules/configs/excel2json/lua_activity194_game.lua

module("modules.configs.excel2json.lua_activity194_game", package.seeall)

local lua_activity194_game = {}
local fields = {
	maxRoundLimit = 5,
	winCondition = 7,
	extraConditionStr = 10,
	eventGroup = 4,
	winConditionStr = 8,
	startEnergy = 6,
	initialItem = 3,
	extraCondition = 9,
	initialTeam = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	extraConditionStr = 2,
	winConditionStr = 1
}

function lua_activity194_game.onLoad(json)
	lua_activity194_game.configList, lua_activity194_game.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_game
