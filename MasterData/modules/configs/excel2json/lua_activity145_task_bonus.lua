-- chunkname: @modules/configs/excel2json/lua_activity145_task_bonus.lua

module("modules.configs.excel2json.lua_activity145_task_bonus", package.seeall)

local lua_activity145_task_bonus = {}
local fields = {
	bonus = 5,
	needProgress = 4,
	id = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity145_task_bonus.onLoad(json)
	lua_activity145_task_bonus.configList, lua_activity145_task_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity145_task_bonus
