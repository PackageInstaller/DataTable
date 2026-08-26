-- chunkname: @modules/configs/excel2json/lua_fight_camera_rorate_when_idle.lua

module("modules.configs.excel2json.lua_fight_camera_rorate_when_idle", package.seeall)

local lua_fight_camera_rorate_when_idle = {}
local fields = {
	id = 1,
	invokeRotateImmediately = 3,
	offset = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_camera_rorate_when_idle.onLoad(json)
	lua_fight_camera_rorate_when_idle.configList, lua_fight_camera_rorate_when_idle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_camera_rorate_when_idle
