-- chunkname: @modules/configs/excel2json/lua_character_motion_effect.lua

module("modules.configs.excel2json.lua_character_motion_effect", package.seeall)

local lua_character_motion_effect = {}
local fields = {
	node = 4,
	everNode = 5,
	motion = 3,
	heroResName = 1,
	effectCompName = 2
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}

function lua_character_motion_effect.onLoad(json)
	lua_character_motion_effect.configList, lua_character_motion_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_motion_effect
