-- chunkname: @modules/configs/excel2json/lua_character_motion_effect_animator.lua

module("modules.configs.excel2json.lua_character_motion_effect_animator", package.seeall)

local lua_character_motion_effect_animator = {}
local fields = {
	defaultState = 3,
	effectNode = 2,
	delay = 5,
	stateList = 4,
	heroResName = 1
}
local primaryKey = {
	"heroResName",
	"effectNode"
}
local mlStringKey = {}

function lua_character_motion_effect_animator.onLoad(json)
	lua_character_motion_effect_animator.configList, lua_character_motion_effect_animator.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_motion_effect_animator
