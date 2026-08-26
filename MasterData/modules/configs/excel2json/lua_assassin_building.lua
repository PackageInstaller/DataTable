-- chunkname: @modules/configs/excel2json/lua_assassin_building.lua

module("modules.configs.excel2json.lua_assassin_building", package.seeall)

local lua_assassin_building = {}
local fields = {
	cost = 7,
	buildingBgIcon = 10,
	unlockDesc = 5,
	type = 3,
	effectDesc = 6,
	title = 2,
	lockBuildingIcon = 9,
	desc = 13,
	levelupPic = 12,
	itemIcon = 11,
	id = 1,
	buildingIcon = 8,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 3,
	title = 1,
	unlockDesc = 2,
	desc = 4
}

function lua_assassin_building.onLoad(json)
	lua_assassin_building.configList, lua_assassin_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_building
