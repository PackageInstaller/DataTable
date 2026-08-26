-- chunkname: @modules/configs/excel2json/lua_activity191_relation.lua

module("modules.configs.excel2json.lua_activity191_relation", package.seeall)

local lua_activity191_relation = {}
local fields = {
	id = 1,
	name = 4,
	activeNum = 7,
	levelDesc = 9,
	specDesc = 10,
	summon = 13,
	tagBg = 6,
	desc = 8,
	effects = 11,
	tag = 3,
	icon = 12,
	activityId = 2,
	level = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	specDesc = 4,
	name = 1,
	levelDesc = 3,
	desc = 2
}

function lua_activity191_relation.onLoad(json)
	lua_activity191_relation.configList, lua_activity191_relation.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity191_relation
