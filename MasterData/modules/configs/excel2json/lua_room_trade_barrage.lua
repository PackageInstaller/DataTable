-- chunkname: @modules/configs/excel2json/lua_room_trade_barrage.lua

module("modules.configs.excel2json.lua_room_trade_barrage", package.seeall)

local lua_room_trade_barrage = {}
local fields = {
	heroId = 4,
	type = 2,
	id = 1,
	icon = 3,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_room_trade_barrage.onLoad(json)
	lua_room_trade_barrage.configList, lua_room_trade_barrage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_trade_barrage
