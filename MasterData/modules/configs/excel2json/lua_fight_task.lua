-- chunkname: @modules/configs/excel2json/lua_fight_task.lua

module("modules.configs.excel2json.lua_fight_task", package.seeall)

local lua_fight_task = {}
local fields = {
	taskParam1 = 3,
	taskParam2 = 5,
	sysParam4 = 10,
	taskParam3 = 7,
	condition = 2,
	taskParam4 = 9,
	sysParam2 = 6,
	sysParam1 = 4,
	id = 1,
	sysParam3 = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_task.onLoad(json)
	lua_fight_task.configList, lua_fight_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_task
