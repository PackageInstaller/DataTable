-- chunkname: @modules/configs/excel2json/lua_tower_monster_score.lua

module("modules.configs.excel2json.lua_tower_monster_score", package.seeall)

local lua_tower_monster_score = {}
local fields = {
	killScore = 3,
	monsterId = 1,
	hpPerScore = 2
}
local primaryKey = {
	"monsterId"
}
local mlStringKey = {}

function lua_tower_monster_score.onLoad(json)
	lua_tower_monster_score.configList, lua_tower_monster_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_monster_score
