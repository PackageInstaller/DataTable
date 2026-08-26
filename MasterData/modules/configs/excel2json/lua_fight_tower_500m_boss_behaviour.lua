-- chunkname: @modules/configs/excel2json/lua_fight_tower_500m_boss_behaviour.lua

module("modules.configs.excel2json.lua_fight_tower_500m_boss_behaviour", package.seeall)

local lua_fight_tower_500m_boss_behaviour = {}
local fields = {
	monsterid = 2,
	param2 = 4,
	hpColor = 13,
	param1 = 3,
	hpBgColor = 12,
	param3 = 5,
	param9 = 11,
	param7 = 9,
	param8 = 10,
	param6 = 8,
	param5 = 7,
	param4 = 6,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_fight_tower_500m_boss_behaviour.onLoad(json)
	lua_fight_tower_500m_boss_behaviour.configList, lua_fight_tower_500m_boss_behaviour.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_tower_500m_boss_behaviour
