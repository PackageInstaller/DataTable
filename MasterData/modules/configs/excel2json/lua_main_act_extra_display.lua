-- chunkname: @modules/configs/excel2json/lua_main_act_extra_display.lua

module("modules.configs.excel2json.lua_main_act_extra_display", package.seeall)

local lua_main_act_extra_display = {}
local fields = {
	sortId = 4,
	name = 2,
	id = 1,
	icon = 3,
	show = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_main_act_extra_display.onLoad(json)
	lua_main_act_extra_display.configList, lua_main_act_extra_display.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_main_act_extra_display
