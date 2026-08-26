-- chunkname: @modules/configs/excel2json/lua_copost_version_task.lua

module("modules.configs.excel2json.lua_copost_version_task", package.seeall)

local lua_copost_version_task = {}
local fields = {
	jumpId = 10,
	activityid = 9,
	taskType = 3,
	desc = 6,
	versionId = 7,
	listenerType = 2,
	listenerParam = 4,
	id = 1,
	maxProgress = 5,
	bonus = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_copost_version_task.onLoad(json)
	lua_copost_version_task.configList, lua_copost_version_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_version_task
