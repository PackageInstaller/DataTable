-- chunkname: @modules/configs/excel2json/lua_rouge_choice_event.lua

module("modules.configs.excel2json.lua_rouge_choice_event", package.seeall)

local lua_rouge_choice_event = {}
local fields = {
	version = 3,
	image = 6,
	type = 2,
	id = 1,
	title = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge_choice_event.onLoad(json)
	lua_rouge_choice_event.configList, lua_rouge_choice_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_choice_event
