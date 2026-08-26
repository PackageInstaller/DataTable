-- chunkname: @modules/configs/excel2json/lua_fight_monster_unique_index.lua

module("modules.configs.excel2json.lua_fight_monster_unique_index", package.seeall)

local lua_fight_monster_unique_index = {}
local fields = {
	id = 1,
	index = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_monster_unique_index.onLoad(json)
	lua_fight_monster_unique_index.configList, lua_fight_monster_unique_index.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_monster_unique_index
