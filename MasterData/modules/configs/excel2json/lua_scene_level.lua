-- chunkname: @modules/configs/excel2json/lua_scene_level.lua

module("modules.configs.excel2json.lua_scene_level", package.seeall)

local lua_scene_level = {}
local fields = {
	ambientSound = 22,
	spineR = 9,
	cardCamera = 7,
	weatherEffect = 18,
	sceneId = 4,
	spineG = 10,
	useBloom = 8,
	bgm = 21,
	sceneType = 3,
	cameraId = 5,
	sceneEffects = 23,
	bloomEffect = 17,
	resName = 2,
	flyEffect = 19,
	bloomB = 14,
	bloomA = 15,
	bloomR = 12,
	cameraOffset = 6,
	flickerSceneFactor = 16,
	wadeEffect = 20,
	spineB = 11,
	id = 1,
	bloomG = 13
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_level.onLoad(json)
	lua_scene_level.configList, lua_scene_level.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_level
