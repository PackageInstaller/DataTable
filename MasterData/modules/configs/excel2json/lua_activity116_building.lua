-- chunkname: @modules/configs/excel2json/lua_activity116_building.lua

module("modules.configs.excel2json.lua_activity116_building", package.seeall)

local lua_activity116_building = {}
local fields = {
	cost = 7,
	name = 2,
	configType = 6,
	desc = 8,
	filterEpisode = 11,
	buildingType = 4,
	elementId = 3,
	lightBgUrl = 10,
	id = 1,
	icon = 9,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity116_building.onLoad(json)
	lua_activity116_building.configList, lua_activity116_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity116_building
