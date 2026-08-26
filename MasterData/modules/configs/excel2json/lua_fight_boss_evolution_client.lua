-- chunkname: @modules/configs/excel2json/lua_fight_boss_evolution_client.lua

module("modules.configs.excel2json.lua_fight_boss_evolution_client", package.seeall)

local lua_fight_boss_evolution_client = {}
local fields = {
	nextSkinId = 2,
	id = 1,
	timeline = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_boss_evolution_client.onLoad(json)
	lua_fight_boss_evolution_client.configList, lua_fight_boss_evolution_client.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_boss_evolution_client
