-- chunkname: @modules/configs/excel2json/lua_assassin_monster_group.lua

module("modules.configs.excel2json.lua_assassin_monster_group", package.seeall)

local lua_assassin_monster_group = {}
local fields = {
	group = 2,
	id = 1,
	monster = 3,
	weight = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_assassin_monster_group.onLoad(json)
	lua_assassin_monster_group.configList, lua_assassin_monster_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_monster_group
