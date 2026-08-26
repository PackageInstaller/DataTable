-- chunkname: @modules/configs/excel2json/lua_scene_settings.lua

module("modules.configs.excel2json.lua_scene_settings", package.seeall)

local lua_scene_settings = {}
local fields = {
	spineOffset = 2,
	lightColor2 = 4,
	prefabLightStartRotation = 7,
	lightColor3 = 5,
	id = 1,
	lightColor4 = 6,
	effectLightStartRotation = 8,
	lightColor1 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_settings.onLoad(json)
	lua_scene_settings.configList, lua_scene_settings.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_settings
