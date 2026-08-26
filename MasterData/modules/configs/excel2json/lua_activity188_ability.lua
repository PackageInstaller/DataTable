-- chunkname: @modules/configs/excel2json/lua_activity188_ability.lua

module("modules.configs.excel2json.lua_activity188_ability", package.seeall)

local lua_activity188_ability = {}
local fields = {
	effectTime = 3,
	skillId = 4,
	abilityId = 2,
	activityId = 1,
	desc = 5
}
local primaryKey = {
	"activityId",
	"abilityId"
}
local mlStringKey = {
	desc = 1
}

function lua_activity188_ability.onLoad(json)
	lua_activity188_ability.configList, lua_activity188_ability.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity188_ability
