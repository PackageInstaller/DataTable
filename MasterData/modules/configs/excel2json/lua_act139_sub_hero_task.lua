-- chunkname: @modules/configs/excel2json/lua_act139_sub_hero_task.lua

module("modules.configs.excel2json.lua_act139_sub_hero_task", package.seeall)

local lua_act139_sub_hero_task = {}
local fields = {
	reward = 8,
	descSuffix = 7,
	desc = 6,
	storyId = 3,
	title = 4,
	image = 5,
	unlockParam = 11,
	taskId = 2,
	lockDesc = 12,
	unlockType = 10,
	id = 1,
	elementIds = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	descSuffix = 3,
	title = 1,
	lockDesc = 4,
	desc = 2
}

function lua_act139_sub_hero_task.onLoad(json)
	lua_act139_sub_hero_task.configList, lua_act139_sub_hero_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_act139_sub_hero_task
