-- chunkname: @modules/configs/excel2json/lua_auto_chess_enemy_formation.lua

module("modules.configs.excel2json.lua_auto_chess_enemy_formation", package.seeall)

local lua_auto_chess_enemy_formation = {}
local fields = {
	index5 = 9,
	index3 = 7,
	zoneId = 4,
	index1Buff = 10,
	index3Buff = 12,
	index4 = 8,
	round = 3,
	index2Buff = 11,
	index4Buff = 13,
	index2 = 6,
	index5Buff = 14,
	enemyId = 2,
	id = 1,
	index1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_auto_chess_enemy_formation.onLoad(json)
	lua_auto_chess_enemy_formation.configList, lua_auto_chess_enemy_formation.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_enemy_formation
