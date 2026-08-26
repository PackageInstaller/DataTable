-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_attribute.lua

module("modules.configs.excel2json.lua_activity220_hedone_attribute", package.seeall)

local lua_activity220_hedone_attribute = {}
local fields = {
	defaultValue = 6,
	min = 4,
	attrId = 1,
	ownerType = 3,
	name = 2,
	max = 5
}
local primaryKey = {
	"attrId"
}
local mlStringKey = {
	name = 1
}

function lua_activity220_hedone_attribute.onLoad(json)
	lua_activity220_hedone_attribute.configList, lua_activity220_hedone_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_hedone_attribute
