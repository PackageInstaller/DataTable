-- chunkname: @modules/configs/excel2json/lua_character_motion_cut.lua

module("modules.configs.excel2json.lua_character_motion_cut", package.seeall)

local lua_character_motion_cut = {}
local fields = {
	onlyStopCut = 4,
	heroId = 1,
	motion = 3,
	skinId = 2
}
local primaryKey = {
	"heroId",
	"skinId"
}
local mlStringKey = {}

function lua_character_motion_cut.onLoad(json)
	lua_character_motion_cut.configList, lua_character_motion_cut.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_motion_cut
