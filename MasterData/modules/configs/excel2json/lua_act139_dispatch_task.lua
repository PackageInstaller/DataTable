-- chunkname: @modules/configs/excel2json/lua_act139_dispatch_task.lua

module("modules.configs.excel2json.lua_act139_dispatch_task", package.seeall)

local lua_act139_dispatch_task = {}
local fields = {
	id = 1,
	desc = 9,
	time = 5,
	image = 10,
	title = 8,
	extraParam = 7,
	elementId = 11,
	shortType = 6,
	minCount = 3,
	maxCount = 4,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_act139_dispatch_task.onLoad(json)
	lua_act139_dispatch_task.configList, lua_act139_dispatch_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_act139_dispatch_task
