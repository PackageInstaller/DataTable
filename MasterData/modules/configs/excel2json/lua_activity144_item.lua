-- chunkname: @modules/configs/excel2json/lua_activity144_item.lua

module("modules.configs.excel2json.lua_activity144_item", package.seeall)

local lua_activity144_item = {}
local fields = {
	isStackable = 9,
	name = 2,
	useDesc = 3,
	isShow = 10,
	effect = 11,
	sources = 12,
	rare = 7,
	desc = 4,
	subType = 5,
	id = 1,
	icon = 6,
	highQuality = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_activity144_item.onLoad(json)
	lua_activity144_item.configList, lua_activity144_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity144_item
