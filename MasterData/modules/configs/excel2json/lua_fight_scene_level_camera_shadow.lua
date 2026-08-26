-- chunkname: @modules/configs/excel2json/lua_fight_scene_level_camera_shadow.lua

module("modules.configs.excel2json.lua_fight_scene_level_camera_shadow", package.seeall)

local lua_fight_scene_level_camera_shadow = {}
local fields = {
	shadowDistance = 2,
	rotation = 3,
	shadowDepthBias = 5,
	shadowNormalBias = 6,
	id = 1,
	lightShadowResolution = 7,
	invokeRotateImmediately = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_scene_level_camera_shadow.onLoad(json)
	lua_fight_scene_level_camera_shadow.configList, lua_fight_scene_level_camera_shadow.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_scene_level_camera_shadow
