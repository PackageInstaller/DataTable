-- chunkname: @modules/configs/excel2json/lua_room_camera_params.lua

module("modules.configs.excel2json.lua_room_camera_params", package.seeall)

local lua_room_camera_params = {}
local fields = {
	fogRangeXYZW = 15,
	gameMode = 3,
	blur = 9,
	state = 2,
	lightMin = 6,
	bendingAmount = 8,
	distance = 5,
	fogParticles = 13,
	zoom = 4,
	oceanFog = 18,
	angle = 7,
	shadowOffsetXYZW = 12,
	fogNearColorRGBA = 16,
	fogViewType = 14,
	touchMoveSpeed = 11,
	offsetHorizon = 10,
	fogFarColorRGBA = 17,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_room_camera_params.onLoad(json)
	lua_room_camera_params.configList, lua_room_camera_params.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_room_camera_params
