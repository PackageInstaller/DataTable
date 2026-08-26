-- chunkname: @modules/configs/excel2json/lua_activity157_mission.lua

module("modules.configs.excel2json.lua_activity157_mission", package.seeall)

local lua_activity157_mission = {}
local fields = {
	groupId = 3,
	area = 9,
	storyId = 7,
	linePrefab = 8,
	pos = 6,
	elementId = 5,
	missionId = 2,
	activityId = 1,
	order = 4
}
local primaryKey = {
	"activityId",
	"missionId"
}
local mlStringKey = {}

function lua_activity157_mission.onLoad(json)
	lua_activity157_mission.configList, lua_activity157_mission.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity157_mission
