-- chunkname: @modules/configs/excel2json/lua_activity114_attribute.lua

module("modules.configs.excel2json.lua_activity114_attribute", package.seeall)

local lua_activity114_attribute = {}
local fields = {
	attrName = 4,
	educationAttentionConsts = 6,
	attributeNum = 5,
	id = 2,
	activityId = 1,
	attribute = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	attrName = 1
}

function lua_activity114_attribute.onLoad(json)
	lua_activity114_attribute.configList, lua_activity114_attribute.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_attribute
