-- chunkname: @modules/configs/excel2json/lua_enemy_behavior.lua

module("modules.configs.excel2json.lua_enemy_behavior", package.seeall)

local lua_enemy_behavior = {}
local fields = {
	effectRound = 3,
	chessId = 4,
	strategy = 6,
	behaviorGroup = 2,
	id = 1,
	effectCondition = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_enemy_behavior.onLoad(json)
	lua_enemy_behavior.configList, lua_enemy_behavior.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_enemy_behavior
