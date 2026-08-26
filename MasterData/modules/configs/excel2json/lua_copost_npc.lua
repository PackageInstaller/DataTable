-- chunkname: @modules/configs/excel2json/lua_copost_npc.lua

module("modules.configs.excel2json.lua_copost_npc", package.seeall)

local lua_copost_npc = {}
local fields = {
	weight = 4,
	time = 5,
	id = 1,
	condition = 3,
	textId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_copost_npc.onLoad(json)
	lua_copost_npc.configList, lua_copost_npc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_npc
