-- chunkname: @modules/configs/excel2json/lua_activity220_attribute.lua

module("modules.configs.excel2json.lua_activity220_attribute", package.seeall)

local lua_activity220_attribute = {}
local fields = {
	name = 2,
	min = 4,
	attrId = 1,
	special = 3,
	desc = 6,
	max = 5
}
local primaryKey = {
	"attrId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity220_attribute.onLoad(json)
	lua_activity220_attribute.configList, lua_activity220_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_attribute
