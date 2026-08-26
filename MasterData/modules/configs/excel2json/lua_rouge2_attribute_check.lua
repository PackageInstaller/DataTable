-- chunkname: @modules/configs/excel2json/lua_rouge2_attribute_check.lua

module("modules.configs.excel2json.lua_rouge2_attribute_check", package.seeall)

local lua_rouge2_attribute_check = {}
local fields = {
	interactive = 5,
	desc = 6,
	check_point = 4,
	type = 3,
	id = 1,
	event = 7,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {}

function lua_rouge2_attribute_check.onLoad(json)
	lua_rouge2_attribute_check.configList, lua_rouge2_attribute_check.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_attribute_check
