-- chunkname: @modules/configs/excel2json/lua_college_building.lua

module("modules.configs.excel2json.lua_college_building", package.seeall)

local lua_college_building = {}
local fields = {
	param = 8,
	name = 2,
	assetPath = 3,
	tags = 9,
	chessPos = 10,
	pos = 4,
	buildingType = 7,
	posOffset = 5,
	id = 1,
	rotation = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_college_building.onLoad(json)
	lua_college_building.configList, lua_college_building.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_building
