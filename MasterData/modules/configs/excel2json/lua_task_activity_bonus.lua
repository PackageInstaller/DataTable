-- chunkname: @modules/configs/excel2json/lua_task_activity_bonus.lua

module("modules.configs.excel2json.lua_task_activity_bonus", package.seeall)

local lua_task_activity_bonus = {}
local fields = {
	hideInVerifing = 6,
	bonus = 5,
	desc = 3,
	type = 1,
	id = 2,
	needActivity = 4
}
local primaryKey = {
	"type",
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_task_activity_bonus.onLoad(json)
	lua_task_activity_bonus.configList, lua_task_activity_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_task_activity_bonus
