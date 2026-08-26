-- chunkname: @modules/configs/excel2json/lua_rouge_event.lua

module("modules.configs.excel2json.lua_rouge_event", package.seeall)

local lua_rouge_event = {}
local fields = {
	desc = 7,
	name = 5,
	type = 2,
	id = 1,
	version = 3,
	specialUI = 4,
	nameEn = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge_event.onLoad(json)
	lua_rouge_event.configList, lua_rouge_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_event
