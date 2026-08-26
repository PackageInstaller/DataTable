-- chunkname: @modules/configs/excel2json/lua_act173_global_task.lua

module("modules.configs.excel2json.lua_act173_global_task", package.seeall)

local lua_act173_global_task = {}
local fields = {
	id = 2,
	endValue = 3,
	activityId = 1,
	isVisible = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}

function lua_act173_global_task.onLoad(json)
	lua_act173_global_task.configList, lua_act173_global_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_act173_global_task
