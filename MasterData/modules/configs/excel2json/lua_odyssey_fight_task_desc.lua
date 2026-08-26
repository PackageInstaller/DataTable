-- chunkname: @modules/configs/excel2json/lua_odyssey_fight_task_desc.lua

module("modules.configs.excel2json.lua_odyssey_fight_task_desc", package.seeall)

local lua_odyssey_fight_task_desc = {}
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

function lua_odyssey_fight_task_desc.onLoad(json)
	lua_odyssey_fight_task_desc.configList, lua_odyssey_fight_task_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_odyssey_fight_task_desc
