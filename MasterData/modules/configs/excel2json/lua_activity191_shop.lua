-- chunkname: @modules/configs/excel2json/lua_activity191_shop.lua

module("modules.configs.excel2json.lua_activity191_shop", package.seeall)

local lua_activity191_shop = {}
local fields = {
	position = 6,
	name = 7,
	desc = 8,
	type = 3,
	id = 2,
	stage = 5,
	activityId = 1,
	level = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity191_shop.onLoad(json)
	lua_activity191_shop.configList, lua_activity191_shop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_shop
