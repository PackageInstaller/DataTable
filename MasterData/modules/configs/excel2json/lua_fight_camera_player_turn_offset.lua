-- chunkname: @modules/configs/excel2json/lua_fight_camera_player_turn_offset.lua

module("modules.configs.excel2json.lua_fight_camera_player_turn_offset", package.seeall)

local lua_fight_camera_player_turn_offset = {}
local fields = {
	id = 1,
	offset = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_camera_player_turn_offset.onLoad(json)
	lua_fight_camera_player_turn_offset.configList, lua_fight_camera_player_turn_offset.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_camera_player_turn_offset
