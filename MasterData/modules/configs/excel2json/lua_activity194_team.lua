-- chunkname: @modules/configs/excel2json/lua_activity194_team.lua

module("modules.configs.excel2json.lua_activity194_team", package.seeall)

local lua_activity194_team = {}
local fields = {
	teamId = 1,
	name = 4,
	buffId = 2,
	roundActionTime = 5,
	iconOffset = 6,
	picture = 3
}
local primaryKey = {
	"teamId"
}
local mlStringKey = {
	name = 1
}

function lua_activity194_team.onLoad(json)
	lua_activity194_team.configList, lua_activity194_team.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity194_team
