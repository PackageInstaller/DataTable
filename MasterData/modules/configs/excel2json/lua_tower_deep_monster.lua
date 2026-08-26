-- chunkname: @modules/configs/excel2json/lua_tower_deep_monster.lua

module("modules.configs.excel2json.lua_tower_deep_monster", package.seeall)

local lua_tower_deep_monster = {}
local fields = {
	id = 1,
	bossId = 4,
	startHighDeep = 2,
	endHighDeep = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_tower_deep_monster.onLoad(json)
	lua_tower_deep_monster.configList, lua_tower_deep_monster.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_deep_monster
