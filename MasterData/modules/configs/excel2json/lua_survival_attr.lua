-- chunkname: @modules/configs/excel2json/lua_survival_attr.lua

module("modules.configs.excel2json.lua_survival_attr", package.seeall)

local lua_survival_attr = {}
local fields = {
	id = 1,
	name = 2,
	flag = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_survival_attr.onLoad(json)
	lua_survival_attr.configList, lua_survival_attr.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_attr
