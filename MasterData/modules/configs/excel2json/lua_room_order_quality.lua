-- chunkname: @modules/configs/excel2json/lua_room_order_quality.lua

module("modules.configs.excel2json.lua_room_order_quality", package.seeall)

local lua_room_order_quality = {}
local fields = {
	goodsWeight = 3,
	quality = 1,
	price = 2,
	typeCount = 4
}
local primaryKey = {
	"quality"
}
local mlStringKey = {}

function lua_room_order_quality.onLoad(json)
	lua_room_order_quality.configList, lua_room_order_quality.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_order_quality
