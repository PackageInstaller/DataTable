-- chunkname: @modules/configs/excel2json/lua_activity216_only_one_tasks.lua

module("modules.configs.excel2json.lua_activity216_only_one_tasks", package.seeall)

local lua_activity216_only_one_tasks = {}
local fields = {
	tips = 5,
	taskIds = 3,
	id = 1,
	activityId = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_activity216_only_one_tasks.onLoad(json)
	lua_activity216_only_one_tasks.configList, lua_activity216_only_one_tasks.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity216_only_one_tasks
