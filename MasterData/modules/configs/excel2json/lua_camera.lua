-- chunkname: @modules/configs/excel2json/lua_camera.lua

module("modules.configs.excel2json.lua_camera", package.seeall)

local lua_camera = {}
local fields = {
	focusZ = 6,
	far = 9,
	distance = 4,
	foucsX = 8,
	yaw = 2,
	id = 1,
	pitch = 3,
	fov = 5,
	yOffset = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_camera.onLoad(json)
	lua_camera.configList, lua_camera.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_camera
