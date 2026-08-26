-- chunkname: @modules/configs/excel2json/lua_activity123_package.lua

module("modules.configs.excel2json.lua_activity123_package", package.seeall)

local lua_activity123_package = {}
local fields = {
	id = 2,
	name = 3,
	changeWeight = 7,
	awardTime5 = 6,
	initWeight = 4,
	awardTime4 = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity123_package.onLoad(json)
	lua_activity123_package.configList, lua_activity123_package.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity123_package
