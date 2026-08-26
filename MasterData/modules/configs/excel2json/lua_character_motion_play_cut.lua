-- chunkname: @modules/configs/excel2json/lua_character_motion_play_cut.lua

module("modules.configs.excel2json.lua_character_motion_play_cut", package.seeall)

local lua_character_motion_play_cut = {}
local fields = {
	whenStopped = 4,
	heroId = 1,
	skinId = 2,
	whenNotStopped = 5,
	motion = 3
}
local primaryKey = {
	"heroId",
	"skinId"
}
local mlStringKey = {}

function lua_character_motion_play_cut.onLoad(json)
	lua_character_motion_play_cut.configList, lua_character_motion_play_cut.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_motion_play_cut
