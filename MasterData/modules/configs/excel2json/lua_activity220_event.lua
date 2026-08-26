-- chunkname: @modules/configs/excel2json/lua_activity220_event.lua

module("modules.configs.excel2json.lua_activity220_event", package.seeall)

local lua_activity220_event = {}
local fields = {
	frontText = 6,
	result3reward = 10,
	npc = 5,
	type = 4,
	typeParam = 7,
	eventId = 2,
	chooseDesc = 11,
	result1reward = 8,
	result2reward = 9,
	weight = 3,
	gameId = 1
}
local primaryKey = {
	"gameId",
	"eventId"
}
local mlStringKey = {
	typeParam = 2,
	chooseDesc = 3,
	frontText = 1
}

function lua_activity220_event.onLoad(json)
	lua_activity220_event.configList, lua_activity220_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_event
