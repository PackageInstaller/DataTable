-- chunkname: @modules/configs/excel2json/lua_sodache_building.lua

module("modules.configs.excel2json.lua_sodache_building", package.seeall)

local lua_sodache_building = {}
local fields = {
	defaultUnlock = 7,
	effect = 8,
	name = 3,
	type = 1,
	consumePram = 6,
	unlockPram = 5,
	buildingDesc = 12,
	requiredLevel = 11,
	unlockDesc = 13,
	location = 14,
	globalAttri = 10,
	prefab = 15,
	effectDesc = 9,
	icon = 4,
	level = 2
}
local primaryKey = {
	"type",
	"level"
}
local mlStringKey = {
	effectDesc = 2,
	name = 1,
	unlockDesc = 4,
	buildingDesc = 3
}

function lua_sodache_building.onLoad(json)
	lua_sodache_building.configList, lua_sodache_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sodache_building
