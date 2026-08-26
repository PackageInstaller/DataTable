-- chunkname: @modules/configs/excel2json/lua_act139_explore_task.lua

module("modules.configs.excel2json.lua_act139_explore_task", package.seeall)

local lua_act139_explore_task = {}
local fields = {
	storyId = 4,
	unlockParam = 12,
	unlockDesc = 13,
	type = 3,
	unlockToastDesc = 14,
	title = 5,
	pos = 9,
	desc = 7,
	unlockLineNumbers = 15,
	unlockType = 11,
	areaPos = 8,
	titleEn = 6,
	id = 1,
	activityId = 2,
	elementIds = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockDesc = 3,
	title = 1,
	unlockToastDesc = 4,
	desc = 2
}

function lua_act139_explore_task.onLoad(json)
	lua_act139_explore_task.configList, lua_act139_explore_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_act139_explore_task
