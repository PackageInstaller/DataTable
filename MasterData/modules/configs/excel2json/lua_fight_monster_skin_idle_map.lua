-- chunkname: @modules/configs/excel2json/lua_fight_monster_skin_idle_map.lua

module("modules.configs.excel2json.lua_fight_monster_skin_idle_map", package.seeall)

local lua_fight_monster_skin_idle_map = {}
local fields = {
	freezeAnimName = 4,
	idleAnimName = 2,
	giddyAnimName = 6,
	skinId = 1,
	sleepAnimName = 5,
	hitAnimName = 3
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_monster_skin_idle_map.onLoad(json)
	lua_fight_monster_skin_idle_map.configList, lua_fight_monster_skin_idle_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_monster_skin_idle_map
