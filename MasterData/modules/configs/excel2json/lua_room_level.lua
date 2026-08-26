-- chunkname: @modules/configs/excel2json/lua_room_level.lua

module("modules.configs.excel2json.lua_room_level", package.seeall)

local lua_room_level = {}
local fields = {
	cost = 2,
	needBlockCount = 3,
	characterLimit = 5,
	needCost = 6,
	maxBlockCount = 4,
	needEpisode = 7,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}

function lua_room_level.onLoad(json)
	lua_room_level.configList, lua_room_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_level
