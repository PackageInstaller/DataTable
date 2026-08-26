-- chunkname: @modules/configs/excel2json/lua_fight_task_group.lua

module("modules.configs.excel2json.lua_fight_task_group", package.seeall)

local lua_fight_task_group = {}
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

function lua_fight_task_group.onLoad(json)
	lua_fight_task_group.configList, lua_fight_task_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_task_group
