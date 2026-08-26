-- chunkname: @modules/configs/excel2json/lua_block_task.lua

module("modules.configs.excel2json.lua_block_task", package.seeall)

local lua_block_task = {}
local fields = {
	order = 4,
	isGuide = 5,
	id = 1,
	resourceId = 2,
	taskType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_block_task.onLoad(json)
	lua_block_task.configList, lua_block_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_block_task
