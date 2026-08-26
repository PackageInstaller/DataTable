-- chunkname: @modules/configs/excel2json/lua_rouge2_attr_drop.lua

module("modules.configs.excel2json.lua_rouge2_attr_drop", package.seeall)

local lua_rouge2_attr_drop = {}
local fields = {
	needNum = 5,
	level = 4,
	id = 1,
	career = 2,
	attr = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_attr_drop.onLoad(json)
	lua_rouge2_attr_drop.configList, lua_rouge2_attr_drop.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_attr_drop
