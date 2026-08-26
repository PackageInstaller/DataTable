-- chunkname: @modules/configs/excel2json/lua_scene_effect_settings.lua

module("modules.configs.excel2json.lua_scene_effect_settings", package.seeall)

local lua_scene_effect_settings = {}
local fields = {
	tag = 4,
	lightColor3 = 8,
	path = 3,
	sceneId = 1,
	lightColor2 = 7,
	colorKey = 5,
	id = 2,
	lightColor4 = 9,
	lightColor1 = 6
}
local primaryKey = {
	"sceneId",
	"id"
}
local mlStringKey = {}

function lua_scene_effect_settings.onLoad(json)
	lua_scene_effect_settings.configList, lua_scene_effect_settings.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_effect_settings
