-- chunkname: @modules/configs/excel2json/lua_activity191_shop_group.lua

module("modules.configs.excel2json.lua_activity191_shop_group", package.seeall)

local lua_activity191_shop_group = {}
local fields = {
	type = 4,
	groupType = 5,
	coin = 2,
	id = 1,
	num = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity191_shop_group.onLoad(json)
	lua_activity191_shop_group.configList, lua_activity191_shop_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_shop_group
