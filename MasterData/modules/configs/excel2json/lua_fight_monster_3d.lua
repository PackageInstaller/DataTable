-- chunkname: @modules/configs/excel2json/lua_fight_monster_3d.lua

module("modules.configs.excel2json.lua_fight_monster_3d", package.seeall)

local lua_fight_monster_3d = {}
local fields = {
	sizeForScale = 5,
	buffId2hang = 4,
	id = 1,
	size = 3,
	hangMap = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_monster_3d.onLoad(json)
	lua_fight_monster_3d.configList, lua_fight_monster_3d.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_monster_3d
