-- chunkname: @modules/configs/excel2json/lua_activity174_test_collection.lua

module("modules.configs.excel2json.lua_activity174_test_collection", package.seeall)

local lua_activity174_test_collection = {}
local fields = {
	icon = 5,
	unique = 6,
	costCoin = 7,
	id = 1,
	title = 3,
	rare = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_activity174_test_collection.onLoad(json)
	lua_activity174_test_collection.configList, lua_activity174_test_collection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_test_collection
