-- chunkname: @modules/configs/excel2json/lua_room_character_building_interact_camera.lua

module("modules.configs.excel2json.lua_room_character_building_interact_camera", package.seeall)

local lua_room_character_building_interact_camera = {}
local fields = {
	nodesXYZ = 6,
	focusXYZ = 5,
	distance = 3,
	rotate = 4,
	id = 1,
	nextCameraParams = 7,
	angle = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_character_building_interact_camera.onLoad(json)
	lua_room_character_building_interact_camera.configList, lua_room_character_building_interact_camera.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_character_building_interact_camera
