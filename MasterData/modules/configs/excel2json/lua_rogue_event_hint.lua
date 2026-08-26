-- chunkname: @modules/configs/excel2json/lua_rogue_event_hint.lua

module("modules.configs.excel2json.lua_rogue_event_hint", package.seeall)

local lua_rogue_event_hint = {}
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

function lua_rogue_event_hint.onLoad(json)
	lua_rogue_event_hint.configList, lua_rogue_event_hint.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_hint
