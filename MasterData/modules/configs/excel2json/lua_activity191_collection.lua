-- chunkname: @modules/configs/excel2json/lua_activity191_collection.lua

module("modules.configs.excel2json.lua_activity191_collection", package.seeall)

local lua_activity191_collection = {}
local fields = {
	label = 8,
	tag2 = 7,
	replaceDesc = 10,
	desc = 9,
	tag = 6,
	title = 5,
	rare = 3,
	unique = 4,
	weight = 12,
	id = 1,
	icon = 11,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	label = 2,
	title = 1,
	replaceDesc = 4,
	desc = 3
}

function lua_activity191_collection.onLoad(json)
	lua_activity191_collection.configList, lua_activity191_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_collection
