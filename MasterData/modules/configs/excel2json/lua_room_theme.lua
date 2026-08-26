-- chunkname: @modules/configs/excel2json/lua_room_theme.lua

module("modules.configs.excel2json.lua_room_theme", package.seeall)

local lua_room_theme = {}
local fields = {
	collectionBonus = 8,
	name = 2,
	desc = 4,
	packages = 7,
	building = 6,
	sourcesType = 10,
	id = 1,
	extraShowBuilding = 9,
	rewardIcon = 5,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_room_theme.onLoad(json)
	lua_room_theme.configList, lua_room_theme.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_theme
