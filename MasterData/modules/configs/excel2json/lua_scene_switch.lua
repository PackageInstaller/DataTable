-- chunkname: @modules/configs/excel2json/lua_scene_switch.lua

module("modules.configs.excel2json.lua_scene_switch", package.seeall)

local lua_scene_switch = {}
local fields = {
	eggSwitchTime = 8,
	initReportId = 9,
	itemId = 3,
	storyId = 12,
	reportSwitchTime = 10,
	previewIcon = 5,
	eggList = 7,
	resName = 6,
	previews = 11,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_scene_switch.onLoad(json)
	lua_scene_switch.configList, lua_scene_switch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_scene_switch
