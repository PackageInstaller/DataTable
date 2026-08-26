-- chunkname: @modules/configs/excel2json/lua_activity174_shop.lua

module("modules.configs.excel2json.lua_activity174_shop", package.seeall)

local lua_activity174_shop = {}
local fields = {
	id = 1,
	name = 5,
	season = 3,
	activityId = 2,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity174_shop.onLoad(json)
	lua_activity174_shop.configList, lua_activity174_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_shop
