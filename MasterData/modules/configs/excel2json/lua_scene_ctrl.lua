-- chunkname: @modules/configs/excel2json/lua_scene_ctrl.lua

module("modules.configs.excel2json.lua_scene_ctrl", package.seeall)

local lua_scene_ctrl = {}
local fields = {
	resName = 1,
	param2 = 4,
	param1 = 3,
	param4 = 6,
	ctrlName = 2,
	param3 = 5
}
local primaryKey = {
	"resName",
	"ctrlName"
}
local mlStringKey = {}

function lua_scene_ctrl.onLoad(json)
	lua_scene_ctrl.configList, lua_scene_ctrl.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_ctrl
