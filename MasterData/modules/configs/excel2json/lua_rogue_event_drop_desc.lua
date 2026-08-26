-- chunkname: @modules/configs/excel2json/lua_rogue_event_drop_desc.lua

module("modules.configs.excel2json.lua_rogue_event_drop_desc", package.seeall)

local lua_rogue_event_drop_desc = {}
local fields = {
	icon = 5,
	iconbg = 6,
	type = 1,
	id = 2,
	title = 3,
	desc = 4
}
local primaryKey = {
	"type",
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rogue_event_drop_desc.onLoad(json)
	lua_rogue_event_drop_desc.configList, lua_rogue_event_drop_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rogue_event_drop_desc
