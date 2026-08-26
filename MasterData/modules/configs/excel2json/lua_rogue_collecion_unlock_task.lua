-- chunkname: @modules/configs/excel2json/lua_rogue_collecion_unlock_task.lua

module("modules.configs.excel2json.lua_rogue_collecion_unlock_task", package.seeall)

local lua_rogue_collecion_unlock_task = {}
local fields = {
	param = 2,
	id = 1,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rogue_collecion_unlock_task.onLoad(json)
	lua_rogue_collecion_unlock_task.configList, lua_rogue_collecion_unlock_task.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_collecion_unlock_task
