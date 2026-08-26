-- chunkname: @modules/configs/excel2json/lua_character_attribute.lua

module("modules.configs.excel2json.lua_character_attribute", package.seeall)

local lua_character_attribute = {}
local fields = {
	showType = 8,
	attrType = 2,
	name = 4,
	type = 3,
	showcolor = 9,
	sortId = 11,
	desc = 5,
	isShowTips = 6,
	id = 1,
	icon = 10,
	isShow = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_character_attribute.onLoad(json)
	lua_character_attribute.configList, lua_character_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_character_attribute
