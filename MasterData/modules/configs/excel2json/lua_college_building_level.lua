-- chunkname: @modules/configs/excel2json/lua_college_building_level.lua

module("modules.configs.excel2json.lua_college_building_level", package.seeall)

local lua_college_building_level = {}
local fields = {
	param = 5,
	skillIds = 6,
	description = 7,
	buildingAsset = 8,
	id = 1,
	slots = 3,
	upgradeCost = 4,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	description = 1
}

function lua_college_building_level.onLoad(json)
	lua_college_building_level.configList, lua_college_building_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_building_level
