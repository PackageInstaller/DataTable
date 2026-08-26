-- chunkname: @modules/configs/excel2json/lua_main_ui_skin.lua

module("modules.configs.excel2json.lua_main_ui_skin", package.seeall)

local lua_main_ui_skin = {}
local fields = {
	iconAnchor = 4,
	name = 7,
	showChild = 8,
	skinId = 2,
	id = 1,
	icon = 3,
	iconRotate = 5,
	isLangBg = 6
}
local primaryKey = {
	"id",
	"skinId"
}
local mlStringKey = {}

function lua_main_ui_skin.onLoad(json)
	lua_main_ui_skin.configList, lua_main_ui_skin.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_main_ui_skin
