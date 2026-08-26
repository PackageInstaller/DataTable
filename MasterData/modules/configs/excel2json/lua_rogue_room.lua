-- chunkname: @modules/configs/excel2json/lua_rogue_room.lua

module("modules.configs.excel2json.lua_rogue_room", package.seeall)

local lua_rogue_room = {}
local fields = {
	nextRoom = 6,
	name = 2,
	layer = 5,
	type = 7,
	id = 1,
	difficulty = 4,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rogue_room.onLoad(json)
	lua_rogue_room.configList, lua_rogue_room.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_room
