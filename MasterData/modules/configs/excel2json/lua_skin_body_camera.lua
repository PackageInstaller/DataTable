-- chunkname: @modules/configs/excel2json/lua_skin_body_camera.lua

module("modules.configs.excel2json.lua_skin_body_camera", package.seeall)

local lua_skin_body_camera = {}
local fields = {
	behavior = 2,
	res = 3,
	body = 4,
	camera_revert = 6,
	id = 1,
	camera = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_body_camera.onLoad(json)
	lua_skin_body_camera.configList, lua_skin_body_camera.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_body_camera
