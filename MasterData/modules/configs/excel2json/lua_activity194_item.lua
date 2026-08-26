-- chunkname: @modules/configs/excel2json/lua_activity194_item.lua

module("modules.configs.excel2json.lua_activity194_item", package.seeall)

local lua_activity194_item = {}
local fields = {
	itemId = 1,
	name = 5,
	buffId = 3,
	isUse = 2,
	picture = 4
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {
	name = 1
}

function lua_activity194_item.onLoad(json)
	lua_activity194_item.configList, lua_activity194_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_item
