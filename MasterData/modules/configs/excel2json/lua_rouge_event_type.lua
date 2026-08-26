-- chunkname: @modules/configs/excel2json/lua_rouge_event_type.lua

module("modules.configs.excel2json.lua_rouge_event_type", package.seeall)

local lua_rouge_event_type = {}
local fields = {
	name = 3,
	version = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_event_type.onLoad(json)
	lua_rouge_event_type.configList, lua_rouge_event_type.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_event_type
