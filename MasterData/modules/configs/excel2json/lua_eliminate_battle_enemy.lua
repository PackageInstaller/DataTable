-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_enemy.lua

module("modules.configs.excel2json.lua_eliminate_battle_enemy", package.seeall)

local lua_eliminate_battle_enemy = {}
local fields = {
	id = 1,
	icon = 2,
	hp = 3,
	loop = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_eliminate_battle_enemy.onLoad(json)
	lua_eliminate_battle_enemy.configList, lua_eliminate_battle_enemy.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_eliminate_battle_enemy
