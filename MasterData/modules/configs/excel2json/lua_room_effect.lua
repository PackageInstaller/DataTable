-- chunkname: @modules/configs/excel2json/lua_room_effect.lua

module("modules.configs.excel2json.lua_room_effect", package.seeall)

local lua_room_effect = {}
local fields = {
	id = 1,
	duration = 3,
	resPath = 2,
	audioId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_effect.onLoad(json)
	lua_room_effect.configList, lua_room_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_effect
