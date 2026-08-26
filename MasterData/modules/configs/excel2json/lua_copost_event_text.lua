-- chunkname: @modules/configs/excel2json/lua_copost_event_text.lua

module("modules.configs.excel2json.lua_copost_event_text", package.seeall)

local lua_copost_event_text = {}
local fields = {
	text = 2,
	id = 1,
	chaId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1
}

function lua_copost_event_text.onLoad(json)
	lua_copost_event_text.configList, lua_copost_event_text.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_event_text
