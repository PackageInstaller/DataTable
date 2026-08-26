-- chunkname: @modules/configs/excel2json/lua_explore_item.lua

module("modules.configs.excel2json.lua_explore_item", package.seeall)

local lua_explore_item = {}
local fields = {
	icon = 6,
	name = 3,
	interactEffect = 11,
	type = 2,
	effect = 10,
	isClientStackable = 9,
	desc = 4,
	audioId = 7,
	desc2 = 5,
	id = 1,
	isStackable = 8,
	isReserve = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 3,
	name = 1,
	desc = 2
}

function lua_explore_item.onLoad(json)
	lua_explore_item.configList, lua_explore_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_explore_item
