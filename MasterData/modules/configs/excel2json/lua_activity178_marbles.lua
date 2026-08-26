-- chunkname: @modules/configs/excel2json/lua_activity178_marbles.lua

module("modules.configs.excel2json.lua_activity178_marbles", package.seeall)

local lua_activity178_marbles = {}
local fields = {
	detectTime = 9,
	name = 3,
	radius = 6,
	elasticity = 7,
	effectTime2 = 11,
	limit = 12,
	effectTime = 10,
	desc = 4,
	id = 2,
	icon = 5,
	activityId = 1,
	velocity = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity178_marbles.onLoad(json)
	lua_activity178_marbles.configList, lua_activity178_marbles.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity178_marbles
