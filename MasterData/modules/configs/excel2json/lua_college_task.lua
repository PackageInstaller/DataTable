-- chunkname: @modules/configs/excel2json/lua_college_task.lua

module("modules.configs.excel2json.lua_college_task", package.seeall)

local lua_college_task = {}
local fields = {
	description = 3,
	stageId = 2,
	reward = 5,
	jumpId = 6,
	id = 1,
	maxProgress = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 1
}

function lua_college_task.onLoad(json)
	lua_college_task.configList, lua_college_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_task
