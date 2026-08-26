-- chunkname: @modules/configs/excel2json/lua_tower_compose_task_limit.lua

module("modules.configs.excel2json.lua_tower_compose_task_limit", package.seeall)

local lua_tower_compose_task_limit = {}
local fields = {
	startTime = 3,
	taskGroupId = 1,
	endTime = 4,
	queryVersion = 2
}
local primaryKey = {
	"taskGroupId",
	"queryVersion"
}
local mlStringKey = {}

function lua_tower_compose_task_limit.onLoad(json)
	lua_tower_compose_task_limit.configList, lua_tower_compose_task_limit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_compose_task_limit
