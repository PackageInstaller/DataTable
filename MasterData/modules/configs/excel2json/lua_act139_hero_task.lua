-- chunkname: @modules/configs/excel2json/lua_act139_hero_task.lua

module("modules.configs.excel2json.lua_act139_hero_task", package.seeall)

local lua_act139_hero_task = {}
local fields = {
	reward = 8,
	heroId = 3,
	preEpisodeId = 9,
	title = 4,
	toastId = 10,
	desc = 7,
	heroIcon = 6,
	heroTabIcon = 5,
	id = 1,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_act139_hero_task.onLoad(json)
	lua_act139_hero_task.configList, lua_act139_hero_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_act139_hero_task
