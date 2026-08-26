-- chunkname: @modules/configs/excel2json/lua_rouge2_event_type.lua

module("modules.configs.excel2json.lua_rouge2_event_type", package.seeall)

local lua_rouge2_event_type = {}
local fields = {
	eventIcon = 3,
	name = 2,
	desc = 4,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	eventIcon = 2,
	name = 1,
	desc = 3
}

function lua_rouge2_event_type.onLoad(json)
	lua_rouge2_event_type.configList, lua_rouge2_event_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_event_type
