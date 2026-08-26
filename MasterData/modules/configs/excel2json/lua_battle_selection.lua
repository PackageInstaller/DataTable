-- chunkname: @modules/configs/excel2json/lua_battle_selection.lua

module("modules.configs.excel2json.lua_battle_selection", package.seeall)

local lua_battle_selection = {}
local fields = {
	title = 2,
	autoUse2 = 8,
	confirm = 5,
	autoUse1 = 7,
	id = 1,
	icon = 4,
	nextSelect = 6,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	confirm = 3,
	title = 1,
	desc = 2
}

function lua_battle_selection.onLoad(json)
	lua_battle_selection.configList, lua_battle_selection.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_battle_selection
