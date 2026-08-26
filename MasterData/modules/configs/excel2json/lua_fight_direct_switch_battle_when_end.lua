-- chunkname: @modules/configs/excel2json/lua_fight_direct_switch_battle_when_end.lua

module("modules.configs.excel2json.lua_fight_direct_switch_battle_when_end", package.seeall)

local lua_fight_direct_switch_battle_when_end = {}
local fields = {
	id = 1,
	nextEpisodeId = 3,
	nextBattleId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_direct_switch_battle_when_end.onLoad(json)
	lua_fight_direct_switch_battle_when_end.configList, lua_fight_direct_switch_battle_when_end.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_direct_switch_battle_when_end
