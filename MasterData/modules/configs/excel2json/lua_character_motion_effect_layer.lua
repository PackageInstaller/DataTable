-- chunkname: @modules/configs/excel2json/lua_character_motion_effect_layer.lua

module("modules.configs.excel2json.lua_character_motion_effect_layer", package.seeall)

local lua_character_motion_effect_layer = {}
local fields = {
	node1Layer = 3,
	node1 = 2,
	heroResName = 1
}
local primaryKey = {
	"heroResName"
}
local mlStringKey = {}

function lua_character_motion_effect_layer.onLoad(json)
	lua_character_motion_effect_layer.configList, lua_character_motion_effect_layer.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_motion_effect_layer
