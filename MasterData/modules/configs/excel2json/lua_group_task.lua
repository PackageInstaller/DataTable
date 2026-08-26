-- chunkname: @modules/configs/excel2json/lua_group_task.lua

module("modules.configs.excel2json.lua_group_task", package.seeall)

local lua_group_task = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_group_task.onLoad(json)
	lua_group_task.configList, lua_group_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_group_task
