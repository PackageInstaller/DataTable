-- chunkname: @modules/configs/excel2json/lua_activity128_expand_bond.lua

module("modules.configs.excel2json.lua_activity128_expand_bond", package.seeall)

local lua_activity128_expand_bond = {}
local fields = {
	tagType = 6,
	name = 7,
	activeNum = 9,
	backingIcon = 12,
	groupId = 5,
	tag2 = 4,
	numberIcon = 14,
	desc = 10,
	effects = 11,
	tag1 = 3,
	id = 1,
	icon = 13,
	activityId = 2,
	level = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity128_expand_bond.onLoad(json)
	lua_activity128_expand_bond.configList, lua_activity128_expand_bond.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_expand_bond
