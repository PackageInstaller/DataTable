-- chunkname: @modules/configs/excel2json/lua_fight_die_act_enemyus.lua

module("modules.configs.excel2json.lua_fight_die_act_enemyus", package.seeall)

local lua_fight_die_act_enemyus = {}
local fields = {
	id = 1,
	act = 3,
	playEffect = 4,
	enemyus = 2
}
local primaryKey = {
	"id",
	"enemyus"
}
local mlStringKey = {}

function lua_fight_die_act_enemyus.onLoad(json)
	lua_fight_die_act_enemyus.configList, lua_fight_die_act_enemyus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_die_act_enemyus
