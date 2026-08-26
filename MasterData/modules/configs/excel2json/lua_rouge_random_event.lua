-- chunkname: @modules/configs/excel2json/lua_rouge_random_event.lua

module("modules.configs.excel2json.lua_rouge_random_event", package.seeall)

local lua_rouge_random_event = {}
local fields = {
	id = 1,
	eventId = 2,
	relateId = 3
}
local primaryKey = {
	"id",
	"eventId"
}
local mlStringKey = {}

function lua_rouge_random_event.onLoad(json)
	lua_rouge_random_event.configList, lua_rouge_random_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_random_event
