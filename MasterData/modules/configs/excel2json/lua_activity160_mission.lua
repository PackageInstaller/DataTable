-- chunkname: @modules/configs/excel2json/lua_activity160_mission.lua

module("modules.configs.excel2json.lua_activity160_mission", package.seeall)

local lua_activity160_mission = {}
local fields = {
	bonus = 5,
	desc = 6,
	preId = 4,
	sort = 7,
	id = 2,
	episodeId = 8,
	activityId = 1,
	mailId = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity160_mission.onLoad(json)
	lua_activity160_mission.configList, lua_activity160_mission.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity160_mission
