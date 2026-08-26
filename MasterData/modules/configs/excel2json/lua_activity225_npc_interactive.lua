-- chunkname: @modules/configs/excel2json/lua_activity225_npc_interactive.lua

module("modules.configs.excel2json.lua_activity225_npc_interactive", package.seeall)

local lua_activity225_npc_interactive = {}
local fields = {
	interactiveTxt = 3,
	interactiveType = 2,
	interactiveId = 1,
	interactivePng = 4
}
local primaryKey = {
	"interactiveId"
}
local mlStringKey = {
	interactiveTxt = 1
}

function lua_activity225_npc_interactive.onLoad(json)
	lua_activity225_npc_interactive.configList, lua_activity225_npc_interactive.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_npc_interactive
