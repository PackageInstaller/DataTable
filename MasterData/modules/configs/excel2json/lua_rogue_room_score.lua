-- chunkname: @modules/configs/excel2json/lua_rogue_room_score.lua

module("modules.configs.excel2json.lua_rogue_room_score", package.seeall)

local lua_rogue_room_score = {}
local fields = {
	id = 1,
	score = 3,
	type = 2
}
local primaryKey = {
	"id",
	"type"
}
local mlStringKey = {}

function lua_rogue_room_score.onLoad(json)
	lua_rogue_room_score.configList, lua_rogue_room_score.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_room_score
