-- chunkname: @modules/configs/excel2json/lua_power_item.lua

module("modules.configs.excel2json.lua_power_item", package.seeall)

local lua_power_item = {}
local fields = {
	expireTime = 7,
	name = 2,
	useDesc = 8,
	expireType = 6,
	effect = 10,
	sources = 11,
	rare = 4,
	desc = 9,
	itemSortIdx = 12,
	id = 1,
	icon = 3,
	highQuality = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_power_item.onLoad(json)
	lua_power_item.configList, lua_power_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_power_item
