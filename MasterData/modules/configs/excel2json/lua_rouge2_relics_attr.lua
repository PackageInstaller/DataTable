-- chunkname: @modules/configs/excel2json/lua_rouge2_relics_attr.lua

module("modules.configs.excel2json.lua_rouge2_relics_attr", package.seeall)

local lua_rouge2_relics_attr = {}
local fields = {
	flag = 2,
	id = 1,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_relics_attr.onLoad(json)
	lua_rouge2_relics_attr.configList, lua_rouge2_relics_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_relics_attr
