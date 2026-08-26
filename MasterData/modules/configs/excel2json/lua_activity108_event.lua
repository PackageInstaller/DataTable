-- chunkname: @modules/configs/excel2json/lua_activity108_event.lua

module("modules.configs.excel2json.lua_activity108_event", package.seeall)

local lua_activity108_event = {}
local fields = {
	pos = 9,
	conditionParam = 4,
	type = 5,
	group = 6,
	title = 8,
	condition = 3,
	episodeId = 2,
	interactParam = 7,
	model = 10,
	id = 1,
	modelPos = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_activity108_event.onLoad(json)
	lua_activity108_event.configList, lua_activity108_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity108_event
