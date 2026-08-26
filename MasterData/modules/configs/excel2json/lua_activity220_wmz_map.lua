-- chunkname: @modules/configs/excel2json/lua_activity220_wmz_map.lua

module("modules.configs.excel2json.lua_activity220_wmz_map", package.seeall)

local lua_activity220_wmz_map = {}
local fields = {
	guildId = 5,
	zoneId4 = 9,
	mapSizeX = 2,
	zoneId2 = 7,
	maxEnergy = 4,
	zoneId3 = 8,
	id = 1,
	mapSizeY = 3,
	zoneId1 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity220_wmz_map.onLoad(json)
	lua_activity220_wmz_map.configList, lua_activity220_wmz_map.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_wmz_map
