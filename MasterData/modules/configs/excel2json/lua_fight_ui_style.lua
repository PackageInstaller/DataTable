-- chunkname: @modules/configs/excel2json/lua_fight_ui_style.lua

module("modules.configs.excel2json.lua_fight_ui_style", package.seeall)

local lua_fight_ui_style = {}
local fields = {
	itemId = 4,
	sort = 5,
	image = 6,
	type = 2,
	showres = 9,
	banner = 8,
	previewImage = 7,
	id = 1,
	defaultUnlock = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_ui_style.onLoad(json)
	lua_fight_ui_style.configList, lua_fight_ui_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ui_style
