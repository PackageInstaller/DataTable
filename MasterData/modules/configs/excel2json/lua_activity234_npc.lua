-- chunkname: @modules/configs/excel2json/lua_activity234_npc.lua

module("modules.configs.excel2json.lua_activity234_npc", package.seeall)

local lua_activity234_npc = {}
local fields = {
	id = 1,
	name = 2,
	icon = 4,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity234_npc.onLoad(json)
	lua_activity234_npc.configList, lua_activity234_npc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity234_npc
