-- chunkname: @modules/configs/excel2json/lua_activity231_mission.lua

module("modules.configs.excel2json.lua_activity231_mission", package.seeall)

local lua_activity231_mission = {}
local fields = {
	listenerType = 5,
	prepose = 8,
	unlockCondition = 3,
	desc = 4,
	listenerParam = 6,
	id = 2,
	maxProgress = 7,
	activityId = 1,
	bonus = 9
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity231_mission.onLoad(json)
	lua_activity231_mission.configList, lua_activity231_mission.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity231_mission
