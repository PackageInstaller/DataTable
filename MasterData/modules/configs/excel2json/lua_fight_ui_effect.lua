-- chunkname: @modules/configs/excel2json/lua_fight_ui_effect.lua

module("modules.configs.excel2json.lua_fight_ui_effect", package.seeall)

local lua_fight_ui_effect = {}
local fields = {
	id = 1,
	name = 2,
	res = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_fight_ui_effect.onLoad(json)
	lua_fight_ui_effect.configList, lua_fight_ui_effect.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_ui_effect
