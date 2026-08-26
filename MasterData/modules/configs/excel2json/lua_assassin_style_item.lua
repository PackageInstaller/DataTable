-- chunkname: @modules/configs/excel2json/lua_assassin_style_item.lua

module("modules.configs.excel2json.lua_assassin_style_item", package.seeall)

local lua_assassin_style_item = {}
local fields = {
	allLimit = 3,
	icon = 6,
	skillId = 1,
	roundLimit = 2,
	itemSpace = 5,
	desc = 4
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {
	desc = 1
}

function lua_assassin_style_item.onLoad(json)
	lua_assassin_style_item.configList, lua_assassin_style_item.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_style_item
