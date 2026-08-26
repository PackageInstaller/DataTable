-- chunkname: @modules/configs/excel2json/lua_siege_battle_hero.lua

module("modules.configs.excel2json.lua_siege_battle_hero", package.seeall)

local lua_siege_battle_hero = {}
local fields = {
	param = 5,
	name = 2,
	type = 4,
	id = 1,
	icon = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_siege_battle_hero.onLoad(json)
	lua_siege_battle_hero.configList, lua_siege_battle_hero.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_siege_battle_hero
