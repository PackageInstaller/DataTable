-- chunkname: @modules/configs/excel2json/lua_activity178_talent.lua

module("modules.configs.excel2json.lua_activity178_talent", package.seeall)

local lua_activity178_talent = {}
local fields = {
	isBig = 7,
	name = 3,
	effect = 11,
	cost = 12,
	condition = 9,
	desc = 8,
	needLv = 10,
	point = 5,
	id = 2,
	icon = 6,
	activityId = 1,
	root = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity178_talent.onLoad(json)
	lua_activity178_talent.configList, lua_activity178_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_talent
