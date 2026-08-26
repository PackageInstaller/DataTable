-- chunkname: @modules/configs/excel2json/lua_activity191_item.lua

module("modules.configs.excel2json.lua_activity191_item", package.seeall)

local lua_activity191_item = {}
local fields = {
	rare = 6,
	name = 3,
	id = 1,
	icon = 5,
	activityId = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity191_item.onLoad(json)
	lua_activity191_item.configList, lua_activity191_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_item
