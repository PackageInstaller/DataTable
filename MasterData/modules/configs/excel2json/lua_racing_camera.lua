-- chunkname: @modules/configs/excel2json/lua_racing_camera.lua

module("modules.configs.excel2json.lua_racing_camera", package.seeall)

local lua_racing_camera = {}
local fields = {
	shakeFrequency = 9,
	height = 3,
	shakeStrength = 8,
	distance = 2,
	lookHeight = 5,
	fOV = 7,
	id = 1,
	rotationSharpness = 6,
	lookAhead = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_racing_camera.onLoad(json)
	lua_racing_camera.configList, lua_racing_camera.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_racing_camera
