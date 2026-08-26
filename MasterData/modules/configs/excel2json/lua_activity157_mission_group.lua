-- chunkname: @modules/configs/excel2json/lua_activity157_mission_group.lua

module("modules.configs.excel2json.lua_activity157_mission_group", package.seeall)

local lua_activity157_mission_group = {}
local fields = {
	type = 3,
	mapName = 4,
	activityId = 1,
	missionGroupId = 2
}
local primaryKey = {
	"activityId",
	"missionGroupId"
}
local mlStringKey = {
	mapName = 1
}

function lua_activity157_mission_group.onLoad(json)
	lua_activity157_mission_group.configList, lua_activity157_mission_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity157_mission_group
