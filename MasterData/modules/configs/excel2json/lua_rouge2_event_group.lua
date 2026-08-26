-- chunkname: @modules/configs/excel2json/lua_rouge2_event_group.lua

module("modules.configs.excel2json.lua_rouge2_event_group", package.seeall)

local lua_rouge2_event_group = {}
local fields = {
	id = 1,
	events = 2,
	eventType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_event_group.onLoad(json)
	lua_rouge2_event_group.configList, lua_rouge2_event_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_event_group
