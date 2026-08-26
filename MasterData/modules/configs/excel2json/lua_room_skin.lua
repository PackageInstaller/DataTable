-- chunkname: @modules/configs/excel2json/lua_room_skin.lua

module("modules.configs.excel2json.lua_room_skin", package.seeall)

local lua_room_skin = {}
local fields = {
	bannerIcon = 8,
	activity = 6,
	name = 5,
	type = 2,
	itemId = 4,
	priority = 11,
	rare = 10,
	desc = 9,
	equipEffPos = 14,
	sources = 15,
	model = 12,
	id = 1,
	icon = 7,
	equipEffSize = 13,
	buildId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_room_skin.onLoad(json)
	lua_room_skin.configList, lua_room_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_skin
