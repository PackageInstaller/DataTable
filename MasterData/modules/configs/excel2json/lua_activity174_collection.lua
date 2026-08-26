-- chunkname: @modules/configs/excel2json/lua_activity174_collection.lua

module("modules.configs.excel2json.lua_activity174_collection", package.seeall)

local lua_activity174_collection = {}
local fields = {
	season = 2,
	icon = 6,
	unique = 7,
	coinValue = 8,
	id = 1,
	title = 4,
	rare = 3,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_activity174_collection.onLoad(json)
	lua_activity174_collection.configList, lua_activity174_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_collection
