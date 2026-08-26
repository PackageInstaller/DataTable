-- chunkname: @modules/configs/excel2json/lua_room_color_const.lua

module("modules.configs.excel2json.lua_room_color_const", package.seeall)

local lua_room_color_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_room_color_const.onLoad(json)
	lua_room_color_const.configList, lua_room_color_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_color_const
