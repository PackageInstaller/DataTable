-- chunkname: @modules/configs/excel2json/lua_skin_ui_effect.lua

module("modules.configs.excel2json.lua_skin_ui_effect", package.seeall)

local lua_skin_ui_effect = {}
local fields = {
	delayVisible = 5,
	effect = 2,
	id = 1,
	changeVisible = 4,
	realtime = 7,
	scale = 3,
	frameVisible = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_ui_effect.onLoad(json)
	lua_skin_ui_effect.configList, lua_skin_ui_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_ui_effect
