-- chunkname: @modules/configs/excel2json/lua_college_location.lua

module("modules.configs.excel2json.lua_college_location", package.seeall)

local lua_college_location = {}
local fields = {
	param = 8,
	progressPerStep = 5,
	requiredProgress = 6,
	tags = 11,
	skillIds = 9,
	name = 2,
	pos = 3,
	description = 12,
	turnsPerStep = 4,
	locationType = 7,
	id = 1,
	slots = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 2,
	name = 1
}

function lua_college_location.onLoad(json)
	lua_college_location.configList, lua_college_location.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_location
