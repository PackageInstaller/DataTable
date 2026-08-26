-- chunkname: @modules/configs/excel2json/lua_rouge2_attribute.lua

module("modules.configs.excel2json.lua_rouge2_attribute", package.seeall)

local lua_rouge2_attribute = {}
local fields = {
	name = 2,
	spriteIndex = 6,
	exAttrLimit = 3,
	type = 7,
	min = 9,
	showMax = 10,
	careerDesc = 4,
	id = 1,
	icon = 5,
	level = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	careerDesc = 2,
	name = 1
}

function lua_rouge2_attribute.onLoad(json)
	lua_rouge2_attribute.configList, lua_rouge2_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_attribute
